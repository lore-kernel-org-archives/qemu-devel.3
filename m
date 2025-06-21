Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15E95C7115D
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Jun 2025 23:57:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uT838-00050G-UF; Sat, 21 Jun 2025 19:55:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT82W-0002gn-SE
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:54:29 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT82U-0005Cp-QZ
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:54:28 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-74924255af4so606106b3a.1
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 16:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750550065; x=1751154865; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=s8p0SktSL4fF18XZNBUS8dNzNdzT2jjZNDd3cNk6e+s=;
 b=HwN6JKuxA+1WbN6htLNzXx1qJeGqpxS57uQZLKslApWNnt2g6Dlgfc0fsnbr0CNS8w
 N5qFScY2ytvW6wPiaFTi26RXYBab4MTqYFI0xzZ0rALH0UEXAYfL+eIbwjEnpJr8grgK
 f2jN5men20ZSwGXKJTYr2/psp9zsrD56jnI7mR9JwhwlGJDdmhPqcJkKknlx5TAw/M0r
 mSjdfULJA7mIDXZ+A79iKor7+3fipFCf1MRqm8kKpOrv/aEHCUNVP7lTT9rvnfC2VtTr
 soGpLRjDvex54Hj75pKTOUQEq1Ie2i9op1C1IoPAVZkRv7cdCVMTAbGAAMdN+yDne44B
 qwVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750550065; x=1751154865;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s8p0SktSL4fF18XZNBUS8dNzNdzT2jjZNDd3cNk6e+s=;
 b=AZYTuucQXXfi7xnm9h+dDW+6+8R0awU19U/YG2ZbGu75yozK3tthf+llfrZbwXtWKD
 ctJQUwGY6Zi+ZF6UCV/8rnjbYgKpCXw446llRTcZfRWuLTluWVYmrA+sDpKdNxEpe3Jx
 ALh6Z6cgPhub7WfvqXY4m+mqK8tEGdyxGZySuYL9oe8gLs6UGbHQb3Q/csfoQivlwDps
 K8xBetxJJOqDT9vsbH1gfElPLTROdpXucEBDO4eb8r/0HYCn3mvNmCcffEJEEMoc4ypY
 oRCp1nmK+6DL71M5K0h6q+FqIZEkOxhuuFsUgseG3aEwIZFeAWRZ0x1KxtO9NsgHICXo
 f8DQ==
X-Gm-Message-State: AOJu0YzpUFAT/0kYt/I+DIFZxwDnfRftm/b56CCkpOSh2ZxmfGJbApIe
 6X7UUYK33WDNh/KMuu/3lyKhY0qva8aNbTA1/AF4E9+4Np6iT720wRRaivPh3RwzrKoHbUQTxMb
 VN4bhOu8=
X-Gm-Gg: ASbGncuqg6nmzb6AJ3924AAL99ygRv5VQNGByw66gBhDewdhXEtc41i/AtndsVJ2ADK
 F2EA3y+cLK5GLrbHuLwrzijxUfsxDXxxrAf8LT8poCfF8F9WJwea/O+tqOV/ZMFQfzkuIbeQ8EK
 NyCeWnKHxHuZq79Plu7KMWlZxZWhcICW7lOI5h83NQgEoxmrD00TS1zsP/34B79am7SPTYpEpQi
 QzU1KpHZDz3xvgkhyVugX4T+p4oqj5Xaz7uZ8lmZWwprs2Hnxbu14EdgKprasatsnv9iiWnviZI
 Depdx4kvr55EaTUieVbIx8A6py/EYp+P+v9LGPsaqWdmA2eLG/oRgG4ZdngUJpBuvuG3zDLFNn/
 faRpeIkmhyhF9lt5C2SUw
X-Google-Smtp-Source: AGHT+IFmNi3J5hegpqit9Tm5+UMrAP0kYWe9mdioJdlHGAywk9d1IMbBwu6XoFkdecJAGW7BOYzXLw==
X-Received: by 2002:aa7:88c3:0:b0:748:de24:1ad5 with SMTP id
 d2e1a72fcca58-7490d630822mr10271559b3a.11.1750550065508; 
 Sat, 21 Jun 2025 16:54:25 -0700 (PDT)
Received: from stoup.. (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7490a46b590sm4970051b3a.27.2025.06.21.16.54.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Jun 2025 16:54:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 073/101] target/arm: Split out do_whileg from
 helper_sve_whileg
Date: Sat, 21 Jun 2025 16:50:09 -0700
Message-ID: <20250621235037.74091-74-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250621235037.74091-1-richard.henderson@linaro.org>
References: <20250621235037.74091-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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
 target/arm/tcg/sve_helper.c | 36 +++++++++++++++++++-----------------
 1 file changed, 19 insertions(+), 17 deletions(-)

diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index 0d16c318cf..c32354142a 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -4156,32 +4156,34 @@ uint32_t HELPER(sve_whilel)(void *vd, uint32_t count, uint32_t pred_desc)
     return pred_count_test(oprbits, count, false);
 }
 
-uint32_t HELPER(sve_whileg)(void *vd, uint32_t count, uint32_t pred_desc)
+static void do_whileg(uint64_t *d, uint64_t esz_mask,
+                      uint32_t count, uint32_t oprbits)
 {
-    intptr_t oprsz = FIELD_EX32(pred_desc, PREDDESC, OPRSZ);
-    intptr_t esz = FIELD_EX32(pred_desc, PREDDESC, ESZ);
-    uint64_t esz_mask = pred_esz_masks[esz];
-    ARMPredicateReg *d = vd;
-    intptr_t i, invcount, oprbits = oprsz * 8;
-    uint64_t bits;
+    uint32_t invcount = oprbits - count;
+    uint64_t bits = esz_mask;
+    uint32_t i;
 
     tcg_debug_assert(count <= oprbits);
 
-    /* Begin with a zero predicate register.  */
-    do_zero(d, oprsz);
-
-    /* Set all of the requested bits.  */
-    bits = esz_mask;
     if (oprbits & 63) {
         bits &= MAKE_64BIT_MASK(0, oprbits & 63);
     }
-
-    invcount = oprbits - count;
-    for (i = (oprsz - 1) / 8; i > invcount / 64; --i) {
-        d->p[i] = bits;
+    for (i = (oprbits - 1) / 64; i > invcount / 64; --i) {
+        d[i] = bits;
         bits = esz_mask;
     }
-    d->p[i] = bits & MAKE_64BIT_MASK(invcount & 63, 64);
+    d[i] = bits & MAKE_64BIT_MASK(invcount & 63, 64);
+}
+
+uint32_t HELPER(sve_whileg)(void *vd, uint32_t count, uint32_t pred_desc)
+{
+    uint32_t oprsz = FIELD_EX32(pred_desc, PREDDESC, OPRSZ);
+    uint32_t esz = FIELD_EX32(pred_desc, PREDDESC, ESZ);
+    uint32_t oprbits = oprsz * 8;
+    uint64_t esz_mask = pred_esz_masks[esz];
+
+    do_zero(vd, oprsz);
+    do_whileg(vd, esz_mask, count, oprbits);
 
     return pred_count_test(oprbits, count, true);
 }
-- 
2.43.0


