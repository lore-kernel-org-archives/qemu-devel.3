Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F6EA10ED65C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 11:20:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w65C6-0006rC-4a; Fri, 27 Mar 2026 07:17:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w65C3-0006o4-L2
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 07:17:35 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w65C1-00083m-W9
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 07:17:35 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-43b3d9d0695so1384403f8f.0
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 04:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774610252; x=1775215052; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BIEYPH/8UZWbZO+zeq/wWjHQtbsxlRNvPAOsbq37PZQ=;
 b=adxYthpynXYu9Cn6Kn7uSzgSOlaVS9mbxyBaoBBLFL8MY7BEpIJIobR71lEe9vDfL/
 LJGDf0pJDy5HBO9mEQn1fn14dH9Nsk0vvEevHCbCPb3jEDoUNqpOTJWjm59yT/JDVq/J
 A6dhT97/g6x0vCeGQRfqogbxby/FbP2esru+ULlu37gOu6eMEKyCaen9Nq02RVJY1zYA
 YStijQIIb5BvX+6Evpu2alKK7juTgnOkf2x9r9R4iIa3aex8MbZUmhEa0KBsH/sBCUQ8
 7BDfcfnWHfSIRE3eAeQ0GJIHT14tdR2hXsmty+o8ikun/bE/o2kdeKux6TnSl1JdCVyT
 /bUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774610252; x=1775215052;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BIEYPH/8UZWbZO+zeq/wWjHQtbsxlRNvPAOsbq37PZQ=;
 b=siEEzE9qrBSM21Q+34xrfz7hkVeLmJp+gA2Ya3J14QpdkGc6P6LcaLb0RTwMqKPPPM
 AoK5fkzYz4eG8Z2Pz76tXBcRrgNqR/AN0yuJh/3DKoOdZejljoG3itCiKJ5TuCbl27Ra
 Moq0ClLWR1peDS2pimuCxhwFFSWSg21OI+VuRm6Rq2rcQvueNBNy7WsYq8so9MkSLeFp
 R44Hia3191ZyJFZZc9z5TliTY67QftRv0DgHHMdsiR0ABhCDP0okKVUCH8KRbZ8hKyu7
 oU7uODdbDstlO6kAvnOuUC360Fthg8LtInaqRKZVmev+rxd3bxLcjZjZ36pj+2IEesnm
 eOCQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUrPX35rmdEq9IH+VTNm2t1spZbUziP7mZ5SoPQ9Blx8WMyUV3MND9z8HpMhqp+BtQnGRiJ44Ene4qn@nongnu.org
X-Gm-Message-State: AOJu0YzyYT+sFdEkUwfwIl8qePNXh9ngmzPvLxqVIS7Z/LfJy6GhPd0t
 jAArD5yZLYAAIDkQpFt+u2ESk1ft+XtnKkC1Ss25ihtXu1sm5Z+8znLt3Eq8wgsjTok=
X-Gm-Gg: ATEYQzwZcZwoRbL9rIQSkE1IpA773lz63RFGfEmTmaePFUlbGWhLeO2jlWXP2+ecd6c
 sNUDOO85ktVjbhxhKP9uxXWjzQB9TK39kkenGXyOb7/mmZXOr1WGHa0bWjnpuZacMwm3+g7v7TU
 /lmtYT/CyaDOkMBJh2SeUBEs2u1bjdYJl4SDD2wC3qQ8RMXBEgP3KVapCebyqTLc3whpOELAxyw
 z6JpFmEjcQCZO6IkEekRvfpZs0ZdExEM49GPRg/gR8ByIbQsQp2SkIDjQqCsuWGqCmaKS/3vrVu
 PmRooL5/4AqMj8vM9/t7O53eHfz3tFkraIev2H8TdIW4B880HHQa2VPHYZyv1EtfsYgvoeoWdyK
 EQGzWza2fnJoZNmUiBGGN288+hgYUWp7fKqC8wmYkCVeiV2hMjSltKn/t5shDWEeyWP/PlwVoov
 s1/J61IzjUqeNzRZC8l0jwaVWv3TnDelg3LDA+9MnkwZ5mff91kHj6uf/8ePZYI7AJOgV17RoRS
 mh0aEdL5rLYGYqQOAtNX4+U9vBJGRQ=
X-Received: by 2002:adf:eac9:0:b0:43b:9f7e:c912 with SMTP id
 ffacd0b85a97d-43b9f7ec96bmr2076070f8f.1.1774610252416; 
 Fri, 27 Mar 2026 04:17:32 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b919cf2b2sm15484227f8f.18.2026.03.27.04.17.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 04:17:31 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: [PATCH v2 32/65] hw/intc/arm_gicv5: Implement CoreSight ID registers
Date: Fri, 27 Mar 2026 11:16:27 +0000
Message-ID: <20260327111700.795099-33-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260327111700.795099-1-peter.maydell@linaro.org>
References: <20260327111700.795099-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x432.google.com
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
index a95a9dc16b..866c1333c3 100644
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
+     * hardware GICv5 implementation. Arm suggests that the
+     * Implementer, Product, etc in IRS_IIDR should also be reported
+     * here, so we do that.
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
@@ -1124,6 +1152,13 @@ static bool config_readl(GICv5 *s, GICv5Domain domain, hwaddr offset,
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


