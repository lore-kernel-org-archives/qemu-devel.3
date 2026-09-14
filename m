Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E6DDC88E6E
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 16:02:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x697P-0003nA-Fg; Mon, 14 Sep 2026 12:01:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x696a-00031I-Hj
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 12:00:28 -0400
Received: from mail-wr2-x10.google.com ([2a00:1450:4864:30::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x696X-0004cL-6j
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 12:00:27 -0400
Received: by mail-wr2-x10.google.com with SMTP id
 ffacd0b85a97d-482f633cd78so1103627f8f.1
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 09:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789401623; x=1790006423; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=TifGTPPkGOKDLGobPWLql5F+xJCFO44YItkMr2umQYs=;
 b=GS3Sm2Rzas8SOHoRoShwOKyC+9qWvXyMbobA1YI7qKVQyG05Ga+dNYu7oRhO6vFU3I
 +J+t+pRwejy4kTOSyCO51A5IGwL3uc+j9gJllSkJ2/85rVAhwAPZEeruVkLRKHNhXV3q
 FmpaZYlGBWTfAvtLzXzii5FIoOKNsafTMKu/RMr8HmPLpVO+RHqlGdIjnr58lBq6a1Cd
 KDCh4YLPsBGuesJP06WddPnnIO2icF4+tZnD/AZV604bONw6Sc0U5EYk9cfCLukIs7GS
 2+4antHgDX77xgYJEPTGmce/pUhOBwzqnUUm/pSM3V2/AeITlUyn1EjqzrrOt80gk7GN
 6ANQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789401623; x=1790006423;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=TifGTPPkGOKDLGobPWLql5F+xJCFO44YItkMr2umQYs=;
 b=pHuIhpYlh2iI3q42lzorL7DwE0RsimFzHYi2xoeyEsbBSPN9CkIPQ0rILdrvCD05oc
 hWcTfU+/BqCwHO6O1Mj2L8GOhbo1L3WT4lGL5WBFmjebnmOGb9vM2w5Df8+i/GGaW4kQ
 dZg+HWll2+QcZeKcR/tirlXuj9iCQTOFb1jqmGAgF00aAL+EOz0c7FI+U6X1bUVnLcWb
 f5ls7y480Uva19d3e/Qu0SSwZuB1wD67RnQNLbz3pc+IkHzbLePw3MTNvMTMPzb6gvKw
 ZSEs+TXp2hXsuzp3zzqfQd5Y1wFrE9Yrra9N1ZEAJA5liJH71kYRuaEX8/IiBS1aAdE4
 R1DA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwoI3AC8uwC/sPWQIEVAJ91lJmMCBqWDyZSRwARAtp7CMmtNqtWHkuwRHRaKzofygHor0TyYrryCxHM@nongnu.org
X-Gm-Message-State: AFuF++k7xqguuk9wz6VIF7D1QHQOjLOW96CQpVYyMErJYvKt24U2IXkW
 6ILS1uaNKGf8OkvAncvciO9EDIltH4zonhlv/aS/yiKpcNiJzKQlt0RYzvz6cI1JHNM=
X-Gm-Gg: AYBFou10cxtFN6/Fk4wE2U1QArhWfpQ6HeE4accnjAdX89dj0sIBt4l/YVr8BCV1oTc
 e+MxzfsImib5xkx2x0B8shh/HRTkypE0/y1HWpB9FR+D0RWFRDmQ6glRQQNhtVChg8uIFjtOS85
 e53tuhZE857hBINEq+1yl8Gb4FgogrK/7ARh0UZwtUYmKkgQ2VvZPB0/koDOsEIzTMr6rxhndqm
 1GogkupJcFKC6Ai/UGCT9Vvi+f7fFCPxKA96LeYZRCq7rjFXNp+ypPSDDFEla7Q1y0ZfBdkp3mi
 Bzs7RBgH6sbliWReSv7kVT3nNUF9MMHHczBiyDssJNzHAWHmV1tM6LH+Ohns0R7nwmQs3S2Bs4n
 +PWAmY82V2+7x48eIwBY+TVEkUv3WlDDU2FOqNgfm78j/e+F+Q+Vq8xyRRF+gE0gYgMhBnUHkb/
 0CMrChaLKF7oNjyUFX70EGaU8ooqSAeE8yHI34UXOIK5RubOJEo1iUd/sUf6ZbeTsALytB9LYsi
 QKnkfHqJI2qSRPdNZvAZQT3RtnaVXJ2nQFvs2MVYu5rkni+GU2cI7DNo59FJ0H2M4qzWdEpVeYi
 Lqpt
X-Received: by 2002:a05:6000:1785:b0:485:8a46:b3c4 with SMTP id
 ffacd0b85a97d-48702b5e64bmr3846156f8f.44.1789401623451; 
 Mon, 14 Sep 2026 09:00:23 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb350686sm30797695f8f.27.2026.09.14.09.00.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 09:00:22 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 1/9] hw/intc/arm_gicv5: Ignore low bits in
 IRS_IST_BASER.ADDR
Date: Mon, 14 Sep 2026 17:00:12 +0100
Message-ID: <20260914160020.327787-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260914160020.327787-1-peter.maydell@linaro.org>
References: <20260914160020.327787-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:30::10;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr2-x10.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

The IRS_IST_BASER.ADDR documentation says:

For IRS_IST_CFGR.STRUCTURE = 0:
 Bits[N:0] of the resulting address are 0 where N depends on the ISTSZ
 and LPI_ID_BITS fields in IRS_IST_CFGR as follows:
    N = Max(5, (ISTSZ + 1) + LPI_ID_BITS)
For IRS_IST_CFGR.STRUCTURE = 1:

 Bits[N:0] of the resulting address are 0 where N depends on L2SZ,
 ISTSZ, and LPI_ID_BITS in IRS_IST_CFGR as follows:
    N = Max(5, LPI_ID_BITS - ((10 - ISTSZ) + (2 * L2SZ)) + 2)

This enforces that the IST is aligned to the size of the IST table,
or to a 64-byte boundary if the table is smaller than 64 bytes, even
if the guest programs the low bits in the ADDR field to specify an
insufficiently aligned address.

We were missing this check, and instead trusted the guest-provided
address to be sufficiently aligned already; add the alignment
enforcement.

The GICv5 spec defines the masking to be used with the expressions
quoted above, which work with the raw field values from the
IRS_IST_CFGR register; these simplify down to some straightforward
expressions based on the sanitized values we've already extracted
form those fields.  You can get to the expressions we use here either
by working through the simplification of the GIC spec expressions, or
from first principles (the number of bits needed for the size of the
table in bytes is the number of bits that index it plus the number of
bits specifying the size of an individual table entry).

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/arm_gicv5.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/hw/intc/arm_gicv5.c b/hw/intc/arm_gicv5.c
index 08878193dfc..34c3ee90d43 100644
--- a/hw/intc/arm_gicv5.c
+++ b/hw/intc/arm_gicv5.c
@@ -1313,6 +1313,7 @@ static void irs_ist_baser_write(GICv5 *s, GICv5Domain domain, uint64_t value)
          */
         GICv5ISTConfig *cfg = &s->phys_lpi_config[domain];
         uint8_t istbits, l2bits, l2_idx_bits;
+        int tableszbits;
         uint8_t id_bits = FIELD_EX64(cs->irs_ist_cfgr[domain],
                                      IRS_IST_CFGR, LPI_ID_BITS);
         id_bits = MIN(MAX(id_bits, QEMU_GICV5_MIN_LPI_ID_BITS), QEMU_GICV5_ID_BITS);
@@ -1359,6 +1360,33 @@ static void irs_ist_baser_write(GICv5 *s, GICv5Domain domain, uint64_t value)
         cfg->l2_idx_bits = l2_idx_bits;
         cfg->structure = FIELD_EX64(cs->irs_ist_cfgr[domain],
                                     IRS_IST_CFGR, STRUCTURE);
+
+        /*
+         * Bits [N:0] of the base addr are ignored, to enforce that in a
+         * 1-level IST it is aligned to the size of the ISTE array,
+         * and in a 2-level IST it is aligned to the size of the L1 table.
+         * The spec defines N in terms of the raw L2SZ, ISTSZ and LPI_ID_BITS
+         * fields, but we have already sanitized these to
+         *  istbits = ISTSZ + 2
+         *  l2bits = (L2SZ * 2) + 12
+         *  id_bits = LPI_ID_BITS
+         * We have also already enforced the "bottom 6 bits are 0" via
+         * R_IRS_IST_BASER_ADDR_MASK, so can skip the Max() operation.
+         * We want tableszbits == the number of bits to zero, which is N + 1.
+         */
+        if (cfg->structure) {
+            /*
+             * L1 table is indexed by the (id_bits - l2_idx_bits) bits in
+             * the ID, so has 2^(id_bits - l2_idx_bits) entries, and each
+             * entry is 8 bytes == 2^3.
+             */
+            tableszbits = id_bits - l2_idx_bits + 3;
+        } else {
+            /* table has 2^id_bits entries of 2^istbits size each */
+            tableszbits = id_bits + istbits;
+        }
+        cfg->base &= ~MAKE_64BIT_MASK(0, tableszbits);
+
         if (!cfg->lpi_cache) {
             /*
              * Keys are GINT_TO_POINTER(intid), so we want the g_direct_hash
-- 
2.43.0


