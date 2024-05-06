Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCACAC10F16
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 11:49:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3wox-0005R3-TK; Mon, 06 May 2024 07:47:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1s3wnD-0002bM-JY
 for qemu-devel@nongnu.org; Mon, 06 May 2024 07:46:04 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1s3wn0-00026a-0c
 for qemu-devel@nongnu.org; Mon, 06 May 2024 07:45:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=DIhcn+chzbw/OhcdHLU14KIEmrpThVyUGELVh9DW21U=; b=xgVmHfctoPamA2KpnDbvPlGJbq
 iL0Bt4C0B2utOXCb6qXvZUq98Ka+POgvMVMNCqvAMBmSP4ajij56wMPG7+4Lhf0PvDimi27vvptJ1
 IjSbwXK+kBAW+N4wTBwPOfcM+iFSM9sqVE+dyJpqCkuQpPEOTp5afMk9nq48WUZe/evI01bvggO58
 4UgkfIT5uPahFqkYxtr2l47vRiE2cR1rD+e9/qFRUAnC8HXgooEDe1xUbYZlntwv5UPAQUKNjYWI9
 bV7jsQHJ+ZaOcG+whUst+ff2c6FBo+Bw724HiCz7K++bZY/QgWwHILNG08O8K5weY7hPIAADaXlGI
 GXm/cvNytSFZgfb9vI8r6GYYT+gyI87SZSFMrthmECWyYZouijWOFOcYhvlQaor0SkLbw9LUUio/R
 uNIAov6wzBVvzvYanATweFfltpjVfH0IfEZI9eJjjoBhcmFgaLgtQ75zJOWLjTKBG7CE6xWnYxYvm
 CIGnBC/4c5nQniCHZRpz8uOqcqLBaU4PJj0dtqqfxo8ktBmSFu9T+6qWsUZMinTwK2ihIMLwhnz2q
 EE/OjPim0qQgtptFmRkRbmyHtlat2/m6qDbibkCLjKjUdOUVR5vZYUlB976JWmqVl+qGBC76HolkS
 eF4eqISfdpHlSEZ5r4msGu7EpGrxmK4qz/8hfwzhM=;
Received: from [2a00:23c4:8bb4:4000:b60d:a162:d698:c802]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1s3wlr-0005pA-Nr; Mon, 06 May 2024 12:44:43 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: qemu-devel@nongnu.org,
	richard.henderson@linaro.org
Date: Mon,  6 May 2024 12:44:51 +0100
Message-Id: <20240506114451.331311-13-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240506114451.331311-1-mark.cave-ayland@ilande.co.uk>
References: <20240506114451.331311-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb4:4000:b60d:a162:d698:c802
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PULL 12/12] target/sparc: Split out do_ms16b
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Richard Henderson <richard.henderson@linaro.org>

The unit operation for fmul8x16 and friends is described in the
manual as "MS16b".  Split that out for clarity.  Improve rounding
with an unconditional addition of 0.5 as a fixed-point integer.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20240502165528.244004-8-richard.henderson@linaro.org>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 target/sparc/vis_helper.c | 78 ++++++++++++---------------------------
 1 file changed, 24 insertions(+), 54 deletions(-)

diff --git a/target/sparc/vis_helper.c b/target/sparc/vis_helper.c
index 14c665cad6..e15c6bb34e 100644
--- a/target/sparc/vis_helper.c
+++ b/target/sparc/vis_helper.c
@@ -44,6 +44,7 @@ target_ulong helper_array8(target_ulong pixel_addr, target_ulong cubesize)
 
 #if HOST_BIG_ENDIAN
 #define VIS_B64(n) b[7 - (n)]
+#define VIS_SB64(n) sb[7 - (n)]
 #define VIS_W64(n) w[3 - (n)]
 #define VIS_SW64(n) sw[3 - (n)]
 #define VIS_L64(n) l[1 - (n)]
@@ -51,6 +52,7 @@ target_ulong helper_array8(target_ulong pixel_addr, target_ulong cubesize)
 #define VIS_W32(n) w[1 - (n)]
 #else
 #define VIS_B64(n) b[n]
+#define VIS_SB64(n) sb[n]
 #define VIS_W64(n) w[n]
 #define VIS_SW64(n) sw[n]
 #define VIS_L64(n) l[n]
@@ -60,6 +62,7 @@ target_ulong helper_array8(target_ulong pixel_addr, target_ulong cubesize)
 
 typedef union {
     uint8_t b[8];
+    int8_t sb[8];
     uint16_t w[4];
     int16_t sw[4];
     uint32_t l[2];
@@ -95,27 +98,23 @@ uint64_t helper_fpmerge(uint32_t src1, uint32_t src2)
     return d.ll;
 }
 
+static inline int do_ms16b(int x, int y)
+{
+    return ((x * y) + 0x80) >> 8;
+}
+
 uint64_t helper_fmul8x16(uint32_t src1, uint64_t src2)
 {
     VIS64 d;
     VIS32 s;
-    uint32_t tmp;
 
     s.l = src1;
     d.ll = src2;
 
-#define PMUL(r)                                                 \
-    tmp = (int32_t)d.VIS_SW64(r) * (int32_t)s.VIS_B32(r);       \
-    if ((tmp & 0xff) > 0x7f) {                                  \
-        tmp += 0x100;                                           \
-    }                                                           \
-    d.VIS_W64(r) = tmp >> 8;
-
-    PMUL(0);
-    PMUL(1);
-    PMUL(2);
-    PMUL(3);
-#undef PMUL
+    d.VIS_W64(0) = do_ms16b(s.VIS_B32(0), d.VIS_SW64(0));
+    d.VIS_W64(1) = do_ms16b(s.VIS_B32(1), d.VIS_SW64(1));
+    d.VIS_W64(2) = do_ms16b(s.VIS_B32(2), d.VIS_SW64(2));
+    d.VIS_W64(3) = do_ms16b(s.VIS_B32(3), d.VIS_SW64(3));
 
     return d.ll;
 }
@@ -124,25 +123,14 @@ uint64_t helper_fmul8x16a(uint32_t src1, int32_t src2)
 {
     VIS32 s;
     VIS64 d;
-    uint32_t tmp;
 
     s.l = src1;
     d.ll = 0;
 
-#define PMUL(r)                                \
-    do {                                       \
-        tmp = src2 * (int32_t)s.VIS_B32(r);    \
-        if ((tmp & 0xff) > 0x7f) {             \
-            tmp += 0x100;                      \
-        }                                      \
-        d.VIS_W64(r) = tmp >> 8;               \
-    } while (0)
-
-    PMUL(0);
-    PMUL(1);
-    PMUL(2);
-    PMUL(3);
-#undef PMUL
+    d.VIS_W64(0) = do_ms16b(s.VIS_B32(0), src2);
+    d.VIS_W64(1) = do_ms16b(s.VIS_B32(1), src2);
+    d.VIS_W64(2) = do_ms16b(s.VIS_B32(2), src2);
+    d.VIS_W64(3) = do_ms16b(s.VIS_B32(3), src2);
 
     return d.ll;
 }
@@ -150,23 +138,14 @@ uint64_t helper_fmul8x16a(uint32_t src1, int32_t src2)
 uint64_t helper_fmul8sux16(uint64_t src1, uint64_t src2)
 {
     VIS64 s, d;
-    uint32_t tmp;
 
     s.ll = src1;
     d.ll = src2;
 
-#define PMUL(r)                                                         \
-    tmp = (int32_t)d.VIS_SW64(r) * ((int32_t)s.VIS_SW64(r) >> 8);       \
-    if ((tmp & 0xff) > 0x7f) {                                          \
-        tmp += 0x100;                                                   \
-    }                                                                   \
-    d.VIS_W64(r) = tmp >> 8;
-
-    PMUL(0);
-    PMUL(1);
-    PMUL(2);
-    PMUL(3);
-#undef PMUL
+    d.VIS_W64(0) = do_ms16b(s.VIS_SB64(1), d.VIS_SW64(0));
+    d.VIS_W64(1) = do_ms16b(s.VIS_SB64(3), d.VIS_SW64(1));
+    d.VIS_W64(2) = do_ms16b(s.VIS_SB64(5), d.VIS_SW64(2));
+    d.VIS_W64(3) = do_ms16b(s.VIS_SB64(7), d.VIS_SW64(3));
 
     return d.ll;
 }
@@ -174,23 +153,14 @@ uint64_t helper_fmul8sux16(uint64_t src1, uint64_t src2)
 uint64_t helper_fmul8ulx16(uint64_t src1, uint64_t src2)
 {
     VIS64 s, d;
-    uint32_t tmp;
 
     s.ll = src1;
     d.ll = src2;
 
-#define PMUL(r)                                                         \
-    tmp = (int32_t)d.VIS_SW64(r) * ((uint32_t)s.VIS_B64(r * 2));        \
-    if ((tmp & 0xff) > 0x7f) {                                          \
-        tmp += 0x100;                                                   \
-    }                                                                   \
-    d.VIS_W64(r) = tmp >> 8;
-
-    PMUL(0);
-    PMUL(1);
-    PMUL(2);
-    PMUL(3);
-#undef PMUL
+    d.VIS_W64(0) = do_ms16b(s.VIS_B64(0), d.VIS_SW64(0));
+    d.VIS_W64(1) = do_ms16b(s.VIS_B64(2), d.VIS_SW64(1));
+    d.VIS_W64(2) = do_ms16b(s.VIS_B64(4), d.VIS_SW64(2));
+    d.VIS_W64(3) = do_ms16b(s.VIS_B64(6), d.VIS_SW64(3));
 
     return d.ll;
 }
-- 
2.39.2


