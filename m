Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90417C28B28
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Mar 2025 15:30:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsO1n-0002oZ-Uv; Wed, 12 Mar 2025 11:29:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1tsO1l-0002mZ-5z
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 11:29:49 -0400
Received: from us-smtp-delivery-44.mimecast.com ([207.211.30.44])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1tsO1j-0001bp-Eu
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 11:29:48 -0400
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-533-YpO43PuuNnS-y_CrzaTW7g-1; Wed,
 12 Mar 2025 11:29:39 -0400
X-MC-Unique: YpO43PuuNnS-y_CrzaTW7g-1
X-Mimecast-MFC-AGG-ID: YpO43PuuNnS-y_CrzaTW7g_1741793379
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6AE6A1809CA5; Wed, 12 Mar 2025 15:29:38 +0000 (UTC)
Received: from bahia.redhat.com (unknown [10.44.32.39])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AC1A018001E9; Wed, 12 Mar 2025 15:29:34 +0000 (UTC)
From: Greg Kurz <groug@kaod.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, Greg Kurz <groug@kaod.org>,
 Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH v3 0/6] 9pfs: Fix ftruncate-after-unlink
Date: Wed, 12 Mar 2025 16:29:26 +0100
Message-ID: <20250312152933.383967-1-groug@kaod.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: softfail client-ip=207.211.30.44; envelope-from=groug@kaod.org;
 helo=us-smtp-delivery-44.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_SOFTFAIL=0.665 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

QEMU 9.2 already fixed the long standing limitation of failing fstat() on
unlinked files. This series does something similar for ftruncate().

The following program can be straced inside the guest with a shared fs in
passthrough mode over 9p2000.L.

int main(void)
{
	struct stat st;
	int fd = creat("./foo", 0000);

	ftruncate(fd, 100);
	unlink("./foo");
	ftruncate(fd, 1000);
}

Before :

creat("./foo", 000)                     = 3
ftruncate(3, 100)                       = -1 EACCES (Permission denied)
unlink("./foo")                         = 0
ftruncate(3, 1000)                      = -1 ENOENT (No such file or directory)

After :

creat("./foo", 000)                     = 3
ftruncate(3, 100)                       = 0
unlink("./foo")                         = 0
ftruncate(3, 1000)                      = 0

Cheers,

--
Greg

Christian Schoenebeck (1):
  tests/9p: add 'Tsetattr' request to test client

Greg Kurz (5):
  9pfs: local : Introduce local_fid_fd() helper
  9pfs: Don't use file descriptors in core code
  9pfs: Introduce ftruncate file op
  9pfs: Introduce futimens file op
  tests/9p: Test `Tsetattr` can truncate unlinked file

 fsdev/file-op-9p.h                    |  5 +++
 hw/9pfs/9p-local.c                    | 49 ++++++++++++++++++++-------
 hw/9pfs/9p-synth.c                    | 22 ++++++++++++
 hw/9pfs/9p-util.h                     |  1 +
 hw/9pfs/9p.c                          | 21 +++++++++---
 hw/9pfs/cofs.c                        | 37 ++++++++++++++++++++
 hw/9pfs/coth.h                        |  4 +++
 tests/qtest/libqos/virtio-9p-client.c | 49 +++++++++++++++++++++++++++
 tests/qtest/libqos/virtio-9p-client.h | 34 +++++++++++++++++++
 tests/qtest/virtio-9p-test.c          | 15 ++++++++
 10 files changed, 219 insertions(+), 18 deletions(-)

-- 
2.48.1


