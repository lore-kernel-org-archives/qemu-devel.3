Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 261DEC282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 17:11:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trgf7-0003Ug-Te; Mon, 10 Mar 2025 13:11:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1trgep-0003L2-Ds
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 13:11:16 -0400
Received: from us-smtp-delivery-44.mimecast.com ([205.139.111.44])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1trgen-00016L-3t
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 13:11:14 -0400
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-602-Qds5QOSpN6KRK_Q3E0bsVQ-1; Mon,
 10 Mar 2025 13:11:05 -0400
X-MC-Unique: Qds5QOSpN6KRK_Q3E0bsVQ-1
X-Mimecast-MFC-AGG-ID: Qds5QOSpN6KRK_Q3E0bsVQ_1741626664
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8D8EA1800361; Mon, 10 Mar 2025 17:11:04 +0000 (UTC)
Received: from bahia.redhat.com (unknown [10.22.64.233])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0BF41180094A; Mon, 10 Mar 2025 17:11:02 +0000 (UTC)
From: Greg Kurz <groug@kaod.org>
To: qemu-devel@nongnu.org
Cc: Christian Schoenebeck <qemu_oss@crudebyte.com>, Greg Kurz <groug@kaod.org>
Subject: [PATCH 0/4] 9pfs: Fix ftruncate-after-unlink
Date: Mon, 10 Mar 2025 18:10:57 +0100
Message-ID: <20250310171101.138380-1-groug@kaod.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: softfail client-ip=205.139.111.44; envelope-from=groug@kaod.org;
 helo=us-smtp-delivery-44.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Christian,

I'm not familiar enough with the latest changes to write a proper test
for this case and I don't have enough cycles to learn. I'm sorry for that
but I guess it will be a lot easier for you and I'll review.

Cheers,

--
Greg

Greg Kurz (4):
  9pfs: local : Introduce local_fid_fd() helper
  9pfs: Don't use file descriptors in core code
  9pfs: Introduce ftruncate file op
  9pfs: Introduce futimens file op

 fsdev/file-op-9p.h |  5 +++++
 hw/9pfs/9p-local.c | 49 ++++++++++++++++++++++++++++++++++------------
 hw/9pfs/9p-synth.c | 22 +++++++++++++++++++++
 hw/9pfs/9p-util.h  |  1 +
 hw/9pfs/9p.c       | 21 +++++++++++++++-----
 hw/9pfs/cofs.c     | 37 ++++++++++++++++++++++++++++++++++
 hw/9pfs/coth.h     |  4 ++++
 7 files changed, 122 insertions(+), 17 deletions(-)

-- 
2.48.1


