Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A81B9C8303F
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 12:56:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWwoH-00025y-OK; Wed, 02 Jul 2025 08:43:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwjg-0004Ud-08
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:38:48 -0400
Received: from mail-oa1-x30.google.com ([2001:4860:4864:20::30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwjV-0002AU-FL
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:38:47 -0400
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-2ef493de975so2767037fac.1
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 05:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751459913; x=1752064713; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RcJXzqbdP4MBhhNnvlFmfWg+QcNiD4D3ij3AZXZY+T4=;
 b=ugO/POX3PsjdoCdynszvPURnL0XwU6pkcX5swlfeCp0Fib+1Ja7asoZT4+ACOKUddu
 28AheYMhzhbh5UIa1y8FODOtWEmses+Q355P1Tk+NbX3kQLApJTkj+hhgPLNKNG/36B3
 MFv7XDi0oInK7WEZbkWla+8k4Kh/iVgHoc2O/NBq9imQ6dYb2DXMozhOi4L+M/15gxod
 MQhdC03G+zf79hH7Ut/nu4GuOBfZ1THwguFHqhOzujDRxWcPgmPGLnFeCuMiZXeLdC7k
 QJwBuj/f0yREe9tueY/eKyeTDPrwe694DO3v6low7CHFgH78RS62qYIN+y6w2bfchiJY
 HpuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751459913; x=1752064713;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RcJXzqbdP4MBhhNnvlFmfWg+QcNiD4D3ij3AZXZY+T4=;
 b=VnBdGOR1SqohY3WUOxgaUsuXULzGWfK0Mm6Kz9cj6oxUyY0m6y3/+ROD/mcPlz7Wqf
 SYp6+q6OkRTn8ROZP2rJhsOrwPsRfvHNecBSej+H6FBzNV6x/cZ8l2hHqx0fl4DdWPef
 tjqvwaU+bhyMn6HwK9lAHwATh8MAXWDY51PzB1wmxXkxYRfBZtmkzOz2PsnL0oFxNQBj
 UpmtXezwj7Ry45mnJvSpPpXMiEIEmBZ5+vCZX5rstqBPQ59rBRo7q9R6AhUUOSJBQdX9
 0ZeQ3LDs1SgbdrlJYWd9ZybIUh4Ts50mDPL3FC9q8cPQEC6e/ZbXOZSnXa1IVq9QcqoG
 /3bg==
X-Gm-Message-State: AOJu0YxUpjWbLVa+tm64EYHObakxSIr20y+CTxTtqUjcsgUZ9EtUVWda
 Hd0KXoZOj6g2FbnbDAYuGEuVNxRW5wiEHBzMoVItpwTn4Z96H+vwgwNXRzlG6+BnzyvbJ9x9awO
 D+ei7zTk=
X-Gm-Gg: ASbGncsqxr1bIWrpx3uXFDTsjrzxbLxQUlp8iRJrw45meWijUhBoKXVX4sFF8NY05jV
 vcmUHA5yOhn/IUoC/BGd3Lgy7vhIqG17iZmUlM/50HcVmsOsEeVDxd6IFik/SF2beXR1SJWqv1T
 HJS1uLeA9WF+VK2zgi2e5shoy2x/VjW25Q3hCHnKIJNsK+mtzl/HalnUOKUd4Yu0Sh1nOlUYasz
 E8Rjjao7txcemFqhRqu+jKqwxW2Ow/e1vnR7Iono8KB6JRRImFKNTxzc2j8UCNOrBsH7gzc0BE9
 w4KcfxEsrg2HQo53jFKUO9myOHfkuQT+J9vh+Sf7T/helIEM+1VBAb1c6A1rlqbTopbDtQ==
X-Google-Smtp-Source: AGHT+IFgFRMKvHhAbZIU/2MmgeGdyXF1n3XL0QwPT5wo0RofcU8EvbXJEQmFcYtY13AMFs9W65a1dA==
X-Received: by 2002:a05:6870:7092:b0:2d4:d9d6:c8cf with SMTP id
 586e51a60fabf-2f5a8d299bbmr2117463fac.5.1751459912753; 
 Wed, 02 Jul 2025 05:38:32 -0700 (PDT)
Received: from stoup.. ([187.210.107.185]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2efd4ea5d9fsm3843451fac.10.2025.07.02.05.38.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 05:38:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v3 62/97] target/arm: Split out do_whilel from
 helper_sve_whilel
Date: Wed,  2 Jul 2025 06:33:35 -0600
Message-ID: <20250702123410.761208-63-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250702123410.761208-1-richard.henderson@linaro.org>
References: <20250702123410.761208-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::30;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x30.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/sve_helper.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index 5014fd135d..4497e9107b 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -4113,26 +4113,30 @@ static uint32_t pred_count_test(uint32_t elements, uint32_t count, bool invert)
     return flags;
 }
 
-uint32_t HELPER(sve_whilel)(void *vd, uint32_t count, uint32_t pred_desc)
+static void do_whilel(uint64_t *d, uint64_t esz_mask,
+                      uint32_t count, uint32_t oprbits)
 {
-    intptr_t oprsz = FIELD_EX32(pred_desc, PREDDESC, OPRSZ);
-    intptr_t esz = FIELD_EX32(pred_desc, PREDDESC, ESZ);
-    uint64_t esz_mask = pred_esz_masks[esz];
-    ARMPredicateReg *d = vd;
-    intptr_t i, oprbits = oprsz * 8;
+    uint32_t i;
 
     tcg_debug_assert(count <= oprbits);
 
-    /* Begin with a zero predicate register.  */
-    do_zero(d, oprsz);
-
-    /* Set all of the requested bits.  */
     for (i = 0; i < count / 64; ++i) {
-        d->p[i] = esz_mask;
+        d[i] = esz_mask;
     }
     if (count & 63) {
-        d->p[i] = MAKE_64BIT_MASK(0, count & 63) & esz_mask;
+        d[i] = MAKE_64BIT_MASK(0, count & 63) & esz_mask;
     }
+}
+
+uint32_t HELPER(sve_whilel)(void *vd, uint32_t count, uint32_t pred_desc)
+{
+    uint32_t oprsz = FIELD_EX32(pred_desc, PREDDESC, OPRSZ);
+    uint32_t esz = FIELD_EX32(pred_desc, PREDDESC, ESZ);
+    uint32_t oprbits = oprsz * 8;
+    uint64_t esz_mask = pred_esz_masks[esz];
+
+    do_zero(vd, oprsz);
+    do_whilel(vd, esz_mask, count, oprbits);
 
     return pred_count_test(oprbits, count, false);
 }
-- 
2.43.0


