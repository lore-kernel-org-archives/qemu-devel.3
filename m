Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064E1606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 05:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=f0G/QK2P
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWoyQ-0003MT-DX; Fri, 27 Nov 2026 00:58:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWoyK-0003HR-NL; Fri, 27 Nov 2026 00:58:12 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWoyI-0007n1-Rf; Fri, 27 Nov 2026 00:58:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1795758877; bh=meSyJgVdHQnjwQLD2fgNx2c0GnXdUVL1UbBXmAgKwT0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=f0G/QK2PMX4LUwmrdnYToCAzDThtKNFLhUAZu8Gqig+nq4qv0c/fJCPmJGOqVrudw
 3bmTunK0f/P0B9FoFts3Z9WuWbSXMkljushaJcPQcsvqp5RolWFOCjBNqv+5OZ7jJH
 58ehFK5MetNlnjJ/l3qwOw7GSmhQl1aLVVfT3lMy1gEXEy+axaGvsQ9CpDq60x8aXj
 OyVmWOwzMweo8P1ObgHaF1xsJq/3Pf5m5bw5WXFh+vV8GjtHRBMy4OZ81Q4hdENgRv
 ot5e11+P23CbRDcnO3iRBykAU4zmmIQufmFWdvs9gPa0Ell9qWM63/R/rQPQMyU4oR
 Q1VRBz0/srabg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id B239C1EA2ED;
 Fri, 27 Nov 2026 08:54:37 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id B00A1469928;
 Fri, 27 Nov 2026 08:54:37 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 993A0CF25C; Fri, 27 Nov 2026 08:54:37 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Daniel Wade <danjwade95@gmail.com>, Kevin Wolf <kwolf@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.16 v2 099/140] block/vhdx: Add alignment checks for
 region tables
Date: Fri, 27 Nov 2026 08:53:25 +0300
Message-ID: <20261127055421.39015-40-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.16-20261127085304@cover.tls.msk.ru>
References: <qemu-stable-10.0.16-20261127085304@cover.tls.msk.ru>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Thomas Huth <thuth@redhat.com>

According to the VHDX specification:

 "The FileOffset and Length fields specify the 64-bit byte offset and 32-bit
  byte length of the object within the file. The values must be a multiple of
  1 MB, and FileOffset must be at least 1 MB."

Thus let's add a sanity check to avoid that bad things could happen later.

Cc: qemu-stable@nongnu.org
Buglink: https://gitlab.com/qemu-project/qemu/-/work_items/3762
Reported-by: Daniel Wade <danjwade95@gmail.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20261113072336.46309-1-thuth@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit 2a4384b4ef01ee3e2c9aeb96d7748307ff0f248b)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/block/vhdx.c b/block/vhdx.c
index 1d60cb2e38a..ceb0b1c7769 100644
--- a/block/vhdx.c
+++ b/block/vhdx.c
@@ -566,6 +566,16 @@ vhdx_open_region_tables(BlockDriverState *bs, BDRVVHDXState *s)
 
         vhdx_region_entry_le_import(&rt_entry);
 
+        /*
+         * According to the VHDX spec, offset and length must be multiple
+         * of 1 MiB and offset must be at least 1 MiB.
+         */
+        if (!QEMU_IS_ALIGNED(rt_entry.file_offset, MiB) ||
+            !QEMU_IS_ALIGNED(rt_entry.length, MiB) || !rt_entry.file_offset) {
+            ret = -EINVAL;
+            goto fail;
+        }
+
         /* check for region overlap between these entries, and any
          * other memory regions in the file */
         ret = vhdx_region_check(s, rt_entry.file_offset, rt_entry.length);
-- 
2.47.3


