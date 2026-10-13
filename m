Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6E41CC6B10
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 08:46:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGY31-0006nZ-2L; Tue, 13 Oct 2026 04:39:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGY2y-0006m8-S3
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 04:39:44 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGY2x-0007Yi-5d
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 04:39:44 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4a018792ab3so22413755e9.0
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 01:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791880782; x=1792485582; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=iOOUVgrNaS2uLQpuE+4HLt5jLUXlLvr0Bv+5ciAHV1g=;
 b=YxMuGkqyBnkJBZFsltu5ar0lQ3MzgoQn0/YNBWeW5E5fLbh+WaxsTfGilqOxXjannm
 1e34Q0YgYQXSGN3bBWKv+aDLMzGvuP1+eNPSSo6QPMIbXnVziESc7QlId7u3f2fOcBKv
 BnRRn0ki21JHQH3JqV+NTakh8vGPXcCjTvD9WjRg8McNTtXKf8/5fvVQN18YJAvDCZ2b
 LroMbqZ96KEJ46tVQQOQPJvVsAzqywXfKhw1b/ek/D0HpW3xmTwmWOEP16YYAQW90x8X
 wupodgnnN8Dnnat/9sbNMrSEYmmSHch7W1uREr0e4V76OApIW5gRxyY4nSBD05ObaZsS
 oTKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791880782; x=1792485582;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=iOOUVgrNaS2uLQpuE+4HLt5jLUXlLvr0Bv+5ciAHV1g=;
 b=O9fGejUxwPWkmDzi4k4IhWMbwQa1AqBp7aB1jALFG2Ow9XizXGTi18nMgDkti4L9yz
 io3YGl/YI2JSqgwcUUQNGoyXgJ07Jw6RTTX+q3dFvbGGw/5ghElncgFy2sqiMflagz21
 Zm5I0M1OMRr81qN3ATivfTo1AlKY7ACI+zj56mczyWG/sSUhGVfmvJroNWWw1YSHwsfS
 TOxTw81M2qjuO/y0XeX+TZZyXWdOdNwIlxQ9XLFXgdAgzqGIPfKUSweBQoiAfHVaGZbg
 8ZmJ6z1uQSzsjlKnzwQoZGXTCLajlYpxyqgRnY3umcQzIliiVidLTbnHqrtzIUnMOvAU
 FrAQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxI44Xj65sh6MLa46U/DIXNbro5A4eeAmUUIGWRz/KJFCS0d9Bh1/k2KjQ0adoANP/9yLTd79eSo4PG@nongnu.org
X-Gm-Message-State: AFq9FYI3RxVCeRK1B0cZo2r2n6Uzk4il644V6Qk3hTD+LknmAQJW7B8l
 JBQ2aeePDxFTKYnKzRd8gDG7s7fd5u3bd7XBnbdc9eLNdeeWblJfpc+hhb3OTZSb9DIJS2/77EZ
 xfoUeo1E=
X-Gm-Gg: AYBFou3psiS1nfcs9/cgzF2BAuVAWoPDDbzpCgrQkelqMZ0nTASn4xtEDvRTvYMGsMp
 MOecvUuHWnp20x8yvMz8xCeRD6Vvdaxqc05+tWqQmeREk68YXa0/AcQPRqIu5acAaaEp/JEeaH9
 mTJKAkPgtyhH0n5nwcjNjvytkR6FzV7dbyIyZ/ArEeytV4Mn2oN3iXpKYf7eZ4W19P97WdNXjoL
 ODMXHfAyNvi1U503KN/5iaHoxnb/+xBj14V6sLiJ5IM+xqZMoNP/FMwNLbMKAVIs0JL0ij2ALvQ
 Xmg0YhXyYJkIkRwbgOOCb98/nOqM8b2UhN2x50pxeg6m87c6MQGVv5oQis2QozyGKniCpPFrvrm
 ZCVjdsz2GrqEEDUtQ5AxxFShmeDXolanzB/2wtRxNVpalt8C9OnK1cnbW1I7dR4tE4+pjqYYav1
 ZeQdMGnKxJfLZOPMjYPTYf0aLewgHkJDl2OkJ5MCrc7VyxAzbOf4st4GmilPRLKanLm8WTdax/P
 SXrp996ZHfXbDTVaSGQjKDFgiRPuyEE/Fa4pgF6gA/COTMJyz+l8WIDFf3oBdNYcZTa6zzifD02
 zFwtx7mc0bncUA==
X-Received: by 2002:a05:600c:8218:b0:49f:ffdc:939d with SMTP id
 5b1f17b1804b1-4a18e49d9f5mr224228765e9.9.1791880780214; 
 Tue, 13 Oct 2026 01:39:40 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18be96549sm495086735e9.6.2026.10.13.01.39.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 01:39:38 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 02/86] hw/intc/arm_gicv5: Ignore low bits in IRS_IST_BASER.ADDR
Date: Tue, 13 Oct 2026 09:38:09 +0100
Message-ID: <20261013083933.1024405-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013083933.1024405-1-peter.maydell@linaro.org>
References: <20261013083933.1024405-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
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
index ebfb0878af3..3c50238634e 100644
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


