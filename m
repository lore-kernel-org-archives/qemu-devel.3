Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15967C5DF9C
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 10:29:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyRuc-00033n-JJ; Mon, 24 Aug 2026 06:28:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wyRuZ-00032u-DX
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 06:28:16 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wyRuW-0001pe-EK
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 06:28:15 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-49554ebb87dso30201655e9.3
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 03:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787567289; x=1788172089; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=I0r2nXlXjUB7wD1f3dT3ydAdxG7m+kDY629ovNa4ajA=;
 b=WRgd69QaX7rsMqzfqEED+1UnZmzk3bppswvhZ1aJMxhdaOX4R0mbHioCnfkwS4ef7P
 myNIN5/La0akMlB7Ncijkupo6nBp8I50Ykb0D/xtxeIQcozB23WXDMwlZJqNgFQVOSDE
 UEptD3NUuQu1Hnk0j5nOQD8Sw6NFkGnYft2oHEWwNKPCZN25Ir0Qw/IfE6LK5CZju92V
 AfQdW+TAbD3VSwd42j005b4Z5HGjwHmPdNOcwuolw0t+CYcv+Fom6Es++8ZXAmFwkzsg
 NYQhLp/bKcqAvE/S8EG0sMlHvxhDvLp7ZGXYBsSGZlr/FgFU7J8nVkDKtWbI8hFq9ugR
 rYVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787567289; x=1788172089;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=I0r2nXlXjUB7wD1f3dT3ydAdxG7m+kDY629ovNa4ajA=;
 b=opGPqftFIHLzmxR5CZ2xXUQf5mobFPVhDply6pcmObNAq9RtuovWSYJvhMHi32rc08
 qc5ZIh0xa/qxCAxHw6SERI4om4dzfcrZfqQbJjWIr+YOf9pMv/n/QLJzcMKhtYLWU0e8
 YDnrcWDrS4QEtXYDW0kseD1d25lOC24+6kDf8rAMs83LMe5YuI+cVSutGCW5onUQ6ytF
 CY5OE38S/JRjQ9tspPoaa3or1RMgVFq1CezZYr6zvRdh4Wf+AiuIHdHKkr1djUQwT0Ie
 NmSjjZUb6LBpxrhZ13Uh5kDl24NWAqSkQGXdJqKyO/MMUGqfLuMHaHS3Gl5tQKalmJpj
 rVMw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqFqWiI3rcQLZNG2a6L3TLaQmO0v/MTxFawk8SQhX04fYJO5+MF5nWUwGnqH/ycBrJXSpgQcemMgPLh@nongnu.org
X-Gm-Message-State: AFuF++mKV00L0vBj2tR9hLb9LQZ4/4y2lOXzFi0vBi+mKH8+3xosuXjj
 bbUCkr9HM2hYdn8dnkOpQgHwWxmb2bJDzGGHKt3FeSjVKcBCgE1V75EcZ22OA9Sy0hJy4ks7jMB
 DZ6MkJ88=
X-Gm-Gg: AR+sD12JJtOm5Zslgm24fbv+c51/JrrJmeHsfV66lunaYdcUtGbEl3ePIJCXcW/FBPD
 S0ZhRO0rJvAgwoJ9sLFJBA/OjnXnMMCJ3WuoQGA6uyn/SBzxT6I8wQVYitVoMpSG6e2qHI6Gb4m
 tcPSNpTAmWsVZ+ZzMrbzxsJzZfsannFiEiQkSb1y+/vvW0oSRrgsunuwCWn02sMrbXbKM2qtRC0
 BFPWLTpwVuow5hDqlh0Fr7+E7R246WdfAjhali33WwJMTj9f5O9UmtFy26wnxbirZxGQpfCWua/
 4+WBON0JYiLtnQLOfCAzSUN6vpIM+vcJimiBdG/9iqR+5jzjO0c4zeok9EBNXrqF5k3NRMMdUXk
 kaDsZz+hZiUis5hnuuvW/wNXS+zKIiLvO1GE+JdnOxUtCPLEFcCtyXuojTPSVYwPnet8y41Vu4Y
 UtRvys6XI8weAhuOkWb+PzsAk+gWtDzP6lP8hyV5TVmDhVL8fr8cfUuQGjbw6H1hIZ8Cq5mESiV
 Ok6y1/oH+t+GctwLDHr586y7iiZpdm26DZmKtEvwfleN3M/IGaiZRU8P/kmIZF50jEPdW2dhTaY
 +Adq
X-Received: by 2002:a05:600c:a087:b0:499:86ce:465e with SMTP id
 5b1f17b1804b1-499b8324b09mr321172385e9.4.1787567289130; 
 Mon, 24 Aug 2026 03:28:09 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499c355e6d1sm77730095e9.6.2026.08.24.03.28.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 03:28:08 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 1/6] hw/intc/arm_gicv5: Ignore low bits in IRS_IST_BASER.ADDR
Date: Mon, 24 Aug 2026 11:28:00 +0100
Message-ID: <20260824102805.639072-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260824102805.639072-1-peter.maydell@linaro.org>
References: <20260824102805.639072-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
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
index 08878193dfc..cdc6c9d3466 100644
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
+        cfg->base &= MAKE_64BIT_MASK(0, tableszbits);
+
         if (!cfg->lpi_cache) {
             /*
              * Keys are GINT_TO_POINTER(intid), so we want the g_direct_hash
-- 
2.43.0


