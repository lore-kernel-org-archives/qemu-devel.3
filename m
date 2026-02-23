Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64BE9EC1112
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 17:09:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuZKg-0002Nt-3r; Mon, 23 Feb 2026 12:02:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuZKe-0002Lr-Tn
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 12:02:52 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuZKd-0000Fm-4F
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 12:02:52 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4806cc07ce7so43130135e9.1
 for <qemu-devel@nongnu.org>; Mon, 23 Feb 2026 09:02:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771866170; x=1772470970; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=cG9UQZiWYcMzTWYtwzGm/gBDPA6lWtqbwXkGQvPrL5w=;
 b=LNX6S9fJIW5aHHvxjIZ1xI+BjerUOIegJFJl3KtuX/cvf3nvuQ8h9dBma1YIqmFaLc
 jO4sOKolW+kqw082dW/RvaBWvzu6xlGsLVQGBe+E+GSm6ZTFSck9A23m21TSDZe9zbWf
 1dNbuLWGQ6beJUuEN8Us4U92Hd0J4kXa4iRvTYJXgEJZRYrYBaTajSsOj+B2chhxqsCw
 MCkbHd2+rqvTzdyi2X5ZUobB/mpCGNiQwSIZJ8SDrYAyES51IevmhmjIM8CHT6SjCDYt
 XR5ihv1/HYWpSXCj3UMKXEt30IxaDiW54Q/YD4STPMS3H9qC3pSDNRo80yorvdwmhs41
 Rq3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771866170; x=1772470970;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=cG9UQZiWYcMzTWYtwzGm/gBDPA6lWtqbwXkGQvPrL5w=;
 b=NrIXM6ms2cDkqxWegZZFIJuU7J3RPtg+YQX5S2mVi5quD3o6ZJbZw4F7jCu2AejWpE
 ZTFxvtmDSR1UTGa2jb0UI0bmuJjLT8Hom7C6eVygQ3oiRrekofO9yi1/E7ZCa/3422cz
 t86sWXi7O67s6p82dOCvfBG2HafN3feBk0uVnL0Xae43/yU4DmASbU2L+0tomqQbdfB7
 uYwlfblu1NHf5Mli1pJtPp1kt+5J0KmzO9NHnxCqb3lT9MRyU0eFy11x45sW5yGvJ90e
 Xh3UGVsIo9FU6Y4XDLUtpUEWT0PsRnBWUKNHUgVkvfkRzXnNY02ogwY8aQrBYKTiPIrQ
 Tgcw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUG0ygu4l0Mng8UXwimh/aOMOF/nk3ZH+Yrvo0v15961/J43JiHoEa+JhUoXP1VB/d4tEZIDbvV6V7a@nongnu.org
X-Gm-Message-State: AOJu0YwFqUkq1GFHc5S3d/OrCyXY79TvCNgJfFQ9bs7ruTGuUQVTfc20
 pIhHWMzWuFzFdnjP5CfyibcJFTAHFBGCmvRg76fOy3MjngCKIwlABjwxaGpVR9FRx/I=
X-Gm-Gg: AZuq6aL5qveKNavEsyM88X2VeM8Vg96RftI2ze+x0MHrWkq2Kae5fNBe4ScYjNA5C2/
 mKCmB6iSG4X8rSHfLVyxVyBLHRFMTqSKjbthDyqTBCyDRLgbUFvktWWXQumGFd7lQsC+MR0gymu
 QCD54loM4IrYLUHBgdlloYRYTxgMKsa45JP3DVqR637Q/U/TtmYq93Is2wknRVTvD6JQccrryE8
 gKg+qC4vnIARUMfmgwuipd2qA1uDUcA1+lt8lX6rFNHvRinT96req1TQgU3viGfKgjnYn6JDavT
 Hs2fCmS9EUZ9vyamN/VOZfYd5h+DrQ/AR9O0+oSzmRK6zrmlg9Gl9d9xnGk088eU9RILfOrdveh
 +Dmaxt4WpQWcQZbI23O3NXCzJgZH3lrsrbygbOZRWiCX7XVlH8OyBhnB+f42PkodSSSi0BQCYDc
 Jg85ktwwwpClXDxohNAYtvgTKmHEqaDlG0rf+fWQHYW+4G2GZ7VoJ94vjO0SRpRKL4CbYJiskpt
 g5Srh9f7QAslRITe6WnfIRaQLcOes0=
X-Received: by 2002:a05:600c:1d0e:b0:477:98f7:2aec with SMTP id
 5b1f17b1804b1-483a95b58c3mr129810345e9.3.1771866169490; 
 Mon, 23 Feb 2026 09:02:49 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a9b21ceasm200155625e9.0.2026.02.23.09.02.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Feb 2026 09:02:48 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 31/65] hw/intc/arm_gicv5: Implement CoreSight ID registers
Date: Mon, 23 Feb 2026 17:01:38 +0000
Message-ID: <20260223170212.441276-32-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260223170212.441276-1-peter.maydell@linaro.org>
References: <20260223170212.441276-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The GICv5 register blocks all implement the usual Arm CoreSight ID
registers; implement these for the IRS.  Although we only have one
callsite at the moment, the ITS config frame uses the same ID
register values, so we abstract this out into a function we can reuse
later.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/arm_gicv5.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/hw/intc/arm_gicv5.c b/hw/intc/arm_gicv5.c
index 0f32bdf357..fa7692ca0e 100644
--- a/hw/intc/arm_gicv5.c
+++ b/hw/intc/arm_gicv5.c
@@ -285,6 +285,9 @@ REG64(IRS_SWERR_SYNDROMER0, 0x3c8)
 REG64(IRS_SWERR_SYNDROMER1, 0x3d0)
     FIELD(IRS_SWERR_SYNDROMER2, ADDR, 3, 53)
 
+REG32(IRS_IDREGS, 0xffd0)
+REG32(IRS_DEVARCH, 0xffbc)
+
 FIELD(L1_ISTE, VALID, 0, 1)
 FIELD(L1_ISTE, L2_ADDR, 12, 44)
 
@@ -310,6 +313,31 @@ FIELD(ICSR, HM, 5, 1)
 FIELD(ICSR, PRIORITY, 11, 5)
 FIELD(ICSR, IAFFID, 32, 16)
 
+#define IRS_DEVARCH_VALUE ((0x23b << 31) | (0x1 << 20) | 0x5a19)
+
+static uint32_t gicv5_idreg(int regoffset)
+{
+    /*
+     * As with the main IRS_IIDR, we don't identify as a specific
+     * hardware GICv5 implementation. Arm suggests that the Implementer,
+     * Product, etc in IRS_IIDR should also be reported here, so we
+     * do that.
+     */
+    static const uint8_t gic_ids[] = {
+        QEMU_GICV5_IMPLEMENTER >> 8, 0x00, 0x00, 0x00, /* PIDR4..PIDR7 */
+        QEMU_GICV5_PRODUCTID & 0xff, /* PIDR0 */
+        ((QEMU_GICV5_PRODUCTID >> 8) |
+         ((QEMU_GICV5_IMPLEMENTER & 0xf) << 4)), /* PIDR1 */
+        ((QEMU_GICV5_REVISION << 4) | (1 << 3) |
+         ((QEMU_GICV5_IMPLEMENTER & 0x70) >> 4)), /* PIDR2 */
+        QEMU_GICV5_VARIANT << 4, /* PIDR3 */
+        0x0D, 0xF0, 0x05, 0xB1, /* CIDR0..CIDR3 */
+    };
+
+    regoffset /= 4;
+    return gic_ids[regoffset];
+}
+
 static GICv5SPIState *spi_for_selr(GICv5Common *cs, GICv5Domain domain)
 {
     /*
@@ -1084,6 +1112,13 @@ static bool config_readl(GICv5 *s, GICv5Domain domain, hwaddr offset,
         }
         *data = v;
         return true;
+    case A_IRS_DEVARCH:
+        *data = IRS_DEVARCH_VALUE;
+        return true;
+    case A_IRS_IDREGS ... A_IRS_IDREGS + 0x2f:
+        /* CoreSight ID registers */
+        *data = gicv5_idreg(offset - A_IRS_IDREGS);
+        return true;
     }
 
     return false;
-- 
2.43.0


