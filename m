Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48EA8C4829B
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Feb 2024 08:52:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZS2Y-00043t-Rq; Mon, 12 Feb 2024 03:51:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rZS2X-00043T-GD
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 03:51:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rZS2W-0007H5-2r
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 03:51:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707727907;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Pb4stnFSgLtxvls6g5nBA9keK5Lrn0q3wrG5+BdOhOU=;
 b=X+CdVIj/P40F+vGpk0fYMk61D/d6GCZ7Zjhv+qjSvhi5mvh17mVPuUuKcon7upUp2GLpKu
 k2SSAEdbTkQwD9ovM7h/ZQ44wqEKpEFov6VRvSf16zqFvgRs2TFo9kPvAtZoUw8dShRJdj
 lsQThJrf4HubvaNugiFuQczLG5VZxI0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-282-xabRcOcwM8G2HrvfMSIWaQ-1; Mon,
 12 Feb 2024 03:51:44 -0500
X-MC-Unique: xabRcOcwM8G2HrvfMSIWaQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2588E3C28643;
 Mon, 12 Feb 2024 08:51:44 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0313F208D057;
 Mon, 12 Feb 2024 08:51:44 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D299A21E66D5; Mon, 12 Feb 2024 09:51:42 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PULL 0/4] Character device backend patches for 2024-02-12
Date: Mon, 12 Feb 2024 09:51:38 +0100
Message-ID: <20240212085142.523317-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.677,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

I offered Marc-André to do this pull request, and he accepted.

The following changes since commit 5d1fc614413b10dd94858b07a1b2e26b1aa0296c:

  Merge tag 'migration-staging-pull-request' of https://gitlab.com/peterx/qemu into staging (2024-02-09 11:22:20 +0000)

are available in the Git repository at:

  https://repo.or.cz/qemu/armbru.git tags/pull-char-2024-02-12

for you to fetch changes up to 684d03acff6096b8ae79da0fcd6194238827c67e:

  qapi/char: Deprecate backend type "memory" (2024-02-12 09:39:38 +0100)

----------------------------------------------------------------
Character device backend patches for 2024-02-12

----------------------------------------------------------------
Markus Armbruster (4):
      chardev/parallel: Don't close stdin on inappropriate device
      tests/unit/test-char: Fix qemu_socket(), make_udp_socket() check
      qapi/char: Make backend types properly conditional
      qapi/char: Deprecate backend type "memory"

 docs/about/deprecated.rst |  8 ++++++++
 qapi/char.json            | 28 +++++++++++++++++-----------
 include/qemu/osdep.h      |  9 ++++++++-
 chardev/char-parallel.c   |  7 +++++--
 tests/unit/test-char.c    | 25 +++++++++++++++++++++++--
 chardev/meson.build       |  4 +---
 6 files changed, 62 insertions(+), 19 deletions(-)

-- 
2.43.0


