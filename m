Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26FC2CA5FA0
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 09:09:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAkrp-0003ye-LP; Sun, 27 Sep 2026 05:08:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xAkpq-0000wY-2N; Sun, 27 Sep 2026 05:06:18 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xAkpo-00087x-8I; Sun, 27 Sep 2026 05:06:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1790499957; bh=cqjV+MLVWF4LhvhI2EFcgVDUYV7PRpp6TrxjjNb40Ik=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Q+cIuIv/fhrcAnbzo/6rzodM5Lo4RJl77QwIwcu2v3Jwd/CPySTHZafUCgvvf84Aw
 uhTuEvXtEoz/05Oz21yt/sP5DBdtKftYSyCB9X7oDCaMUvrbTLoljynwfUwE58VncW
 EGsibUYgZj9kFy7GICtplr+NDm6/jhlIdY3RrY+/kzeLh5NvCzNV8tT0/CWmcuM6oM
 KLgrZRnscSxApOQCHaVuLAJU2NOT8vbes9J+WgM4/qsTEcrjQa2tI5r6yP4VDAELZs
 5pAjyfTupjupRph/uD4xXtPo/rrqkHMls1gjOrkwVNEN45uNX7xyTtWLhXsN8EKKkV
 w74SZ+4hbv9Qw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 677E91D8B13;
 Sun, 27 Sep 2026 12:05:57 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 4BEDD4320CC;
 Sun, 27 Sep 2026 12:05:57 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id E66315E657; Sun, 27 Sep 2026 12:05:56 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Jared Rossi <jrossi@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 "Jason J. Herne" <jjherne@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.5 v2 66/86] hw/s390x/ipl: Fix incorrect PCI IPL block
 lengths
Date: Sun, 27 Sep 2026 12:05:13 +0300
Message-ID: <20260927090540.102811-9-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.5-20260927120511@cover.tls.msk.ru>
References: <qemu-stable-11.0.5-20260927120511@cover.tls.msk.ru>
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
index 1babcd2b7dd..a844b5daecf 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -525,6 +525,8 @@ static bool s390_build_iplb(DeviceState *dev_st, IplParameterBlock *iplb)
         switch (devtype) {
         case PCI_DEVTYPE_VIRTIO:
             iplb->len = cpu_to_be32(S390_IPLB_MIN_PCI_LEN);
+            iplb->blk0_len =
+                cpu_to_be32(S390_IPLB_MIN_PCI_LEN - S390_IPLB_HEADER_LEN);
             iplb->pbt = S390_IPL_TYPE_PCI;
             iplb->pci.fid = cpu_to_be32(pbdev->fid);
             break;
diff --git a/hw/s390x/ipl.h b/hw/s390x/ipl.h
index 33729d4be5a..ad79b000367 100644
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


