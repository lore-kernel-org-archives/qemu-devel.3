Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B690C98324
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 10:50:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAmSG-0007Ju-9c; Sun, 27 Sep 2026 06:50:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xAmRc-000640-Og; Sun, 27 Sep 2026 06:49:21 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xAmRb-00013A-6W; Sun, 27 Sep 2026 06:49:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1790506130; bh=oP827NXVehDBLxkNpXERII/bI5xIvEsJzeGXxZTyvI8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=cg8yFcEF5Kfd2pKnL2yvHSPnRlCfhrhlQ9B/yBeSzOJV8lyagxiy+G/7YMKrBPY/u
 gLpqKC3u9s+vkfXRz+8UpqvOGm9a/GLsiZh0ll/QipLWEAkLn/to8qxAZIzG4TzH3H
 75Xypv4fG0TtZlnNMsge78DScRHApZZi7BlPsUzd27BxyC4UmL5elEDEhSABhOiusC
 OiYZM0ijwJYdCUrugEx8wHiLOWQDGwXW09eQJh3iyF/b35zcPJTG/jIdIQM0IhhJpR
 TkbbvRbtx0T8JnRucW+9rqFGgRKlgeeibkxRBjXlryhLPjQ+9x8qN8HO1LdZCyhsob
 rskUVbXofoSLw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id A1E9E1D8B63;
 Sun, 27 Sep 2026 13:48:50 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 94F44432169;
 Sun, 27 Sep 2026 13:48:50 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 623935E77C; Sun, 27 Sep 2026 13:48:50 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Jared Rossi <jrossi@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 "Jason J. Herne" <jjherne@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.2 v2 67/92] hw/s390x/ipl: Fix incorrect PCI IPL block
 lengths
Date: Sun, 27 Sep 2026 13:47:43 +0300
Message-ID: <20260927104821.196183-11-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.2-20260927121932@cover.tls.msk.ru>
References: <qemu-stable-11.1.2-20260927121932@cover.tls.msk.ru>
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Jared Rossi <jrossi@linux.ibm.com>

The length of the PCI IPLB is calculated by size of the IplBlockPci struct
plus the number of bytes used for common IPLB fields.

Fix the S390_IPLB_MIN_PCI_LEN to reflect this, and assign a valid blk0_len
while we are at it.

Cc: qemu-stable@nongnu.org
Fixes: 395116781df5 ("s390x: Build IPLB for virtio-pci devices")
Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Reviewed-by: Jason J. Herne <jjherne@linux.ibm.com>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260831194919.3830270-3-jrossi@linux.ibm.com
Signed-off-by: Eric Farman <farman@linux.ibm.com>
(cherry picked from commit 8435aadbb9add09c4c2e16f803b37441b4c6a32f)
(Mjt: S390_IPLB_MIN_PCI_LEN is in hw/s390x/ipl.h across v11.1.0-600-g854de451f21c
 "hw/s390x/ipl: Add IPIB flags to IPL Parameter Block")
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index d5fdc3ea0ff..fd6e9100f96 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -526,6 +526,8 @@ static bool s390_build_iplb(DeviceState *dev_st, IplParameterBlock *iplb)
         switch (devtype) {
         case PCI_DEVTYPE_VIRTIO:
             iplb->len = cpu_to_be32(S390_IPLB_MIN_PCI_LEN);
+            iplb->blk0_len =
+                cpu_to_be32(S390_IPLB_MIN_PCI_LEN - S390_IPLB_HEADER_LEN);
             iplb->pbt = S390_IPL_TYPE_PCI;
             iplb->pci.fid = cpu_to_be32(pbdev->fid);
             break;
diff --git a/hw/s390x/ipl.h b/hw/s390x/ipl.h
index ef9c063d904..a60c9520c0c 100644
--- a/hw/s390x/ipl.h
+++ b/hw/s390x/ipl.h
@@ -107,7 +107,7 @@ QEMU_BUILD_BUG_MSG(offsetof(S390IPLState, iplb) & 3, "alignment of iplb wrong");
 #define S390_IPLB_MIN_PV_LEN 148
 #define S390_IPLB_MIN_CCW_LEN 200
 #define S390_IPLB_MIN_FCP_LEN 384
-#define S390_IPLB_MIN_PCI_LEN 376
+#define S390_IPLB_MIN_PCI_LEN (offsetof(IplParameterBlock, pci) + sizeof(IplBlockPci))
 #define S390_IPLB_MIN_QEMU_SCSI_LEN 200
 
 static inline bool iplb_valid_len(IplParameterBlock *iplb)
-- 
2.47.3


