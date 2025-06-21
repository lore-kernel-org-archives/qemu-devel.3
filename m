Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EC37C7115C
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Jun 2025 23:57:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uT82k-0003hO-DF; Sat, 21 Jun 2025 19:54:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT82W-0002eh-7b
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:54:28 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT82U-0005CS-A6
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:54:27 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-747fba9f962so2273502b3a.0
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 16:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750550065; x=1751154865; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=KSMYEPMmFHBsuW15JHYPo//vS6oU9zg++I26gTjYMvo=;
 b=mwG3yHkkz1YdiIlsStAHEbC77n51nd2bOCkX/O6mcZ0RjEuXHXdKWID7SUHXHG2xkP
 5x/1o5EVESL+or+Sus/9S7lVz5aBJLE7H5yft+GCbXpZ2X2adTOdwsKJaWMdV5cQlCCV
 n4g+uduXOEGLe8DlLPj/leIEU1NFgSEdTlCO2hWd0J8SZf0yI3Nfpr8S4+jfnT50dP8o
 0lsVzQfdFB3XdejMpUJq7yBhsZ2fb9LW1NWbqjmgxAi9CAfvniIOdsFFfd+6R12XiH19
 /hCurLjAdZsxA7zxjYXC266Tqr+c7i4XijGu8SI7ax4OTrHGgirgA5A1dvES2BPZ+uDg
 l99Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750550065; x=1751154865;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KSMYEPMmFHBsuW15JHYPo//vS6oU9zg++I26gTjYMvo=;
 b=pX4FtM0ksHCG2L9Zn6mvt5Hb4hom84q/d65mF0hKLlerMGyamjDYaKXpevZRHLEvxK
 DT0OshtZmCc2XqmErfOccK6UdcIZbofeaypi+1A3s20Df0FqCLFkSUNgYX2RyGeh61WC
 yN0+SpQ6JfLNeR19Advz8uKY0wo2YhZmjxIndZY+o/Wexam+aPj0Mu7WA2OQyJAGwX0I
 QD2s4eYyp+Ne4j8Y0OCMyy5UPX65WwuOO1hyLKVN8NkFuHAkZh1w58AK2/dBQ1g2lMyP
 1USwqUBqRLwukmkRcn976Pwktca8KWdCh3ppdPE2GrZz+m2Blbti0ATSm+KLawR0f2ix
 JuWA==
X-Gm-Message-State: AOJu0Yzb/f8y8zMrlV4250zx8+gDWq+EpigrtGHvWRDLRIyU9e6AhpHG
 ZXDG+3xF8Zs+Hi6+V2PdlJZuWPtKDWoHsE7yThpaCaRgLMckjA+CUYt+dGgWyqEORPiRFpvAPS5
 gHMnDOg4=
X-Gm-Gg: ASbGnct2LFbtptoEcOrGZsrMX66iLhcGAQIpjz9A5p82K3DJ4Qc1co01FyI0z7wKBTK
 n9fRWdjbBf/z+Dc4/NzLgS54nVvpeuwctQVZoliJ9g3SmQdmE/rp0kDal0vU765mKXS0UWFBW2t
 BrLcCh8lXUwkOmDzYii99uJHWtXfXNzYtl3vmGif6Y6oaexSSdZyEv+ny/sk+AED7bKEdUn/B24
 XH08mJc3byP3Mmk1mhXWUi6rsDJJHcPWoHsgBbWesU9i8ddc1BlqEEZioAgIGJlbiz2omddSitE
 YeDqjT9o3UtMSlAUZlcVhNlvaXFnnkRxCxuFmrrBuuZM5rB2JhoETGNoGz72/D9Qaz5xPNcaSrA
 D09RLNgc3u9J8cKoFQ7AT
X-Google-Smtp-Source: AGHT+IHZAH944svGZB54r2KSz5IPaVzcVangGJv5zaZz9eZ2RsDQYFmj6I2QzUndj82Cg8zXzHbpfw==
X-Received: by 2002:a05:6a20:7350:b0:21f:56d0:65dc with SMTP id
 adf61e73a8af0-220292bc007mr10204933637.13.1750550064874; 
 Sat, 21 Jun 2025 16:54:24 -0700 (PDT)
Received: from stoup.. (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7490a46b590sm4970051b3a.27.2025.06.21.16.54.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Jun 2025 16:54:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 072/101] target/arm: Split out do_whilel from
 helper_sve_whilel
Date: Sat, 21 Jun 2025 16:50:08 -0700
Message-ID: <20250621235037.74091-73-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250621235037.74091-1-richard.henderson@linaro.org>
References: <20250621235037.74091-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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
index 789c9ce3a5..0d16c318cf 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -4128,26 +4128,30 @@ static uint32_t pred_count_test(uint32_t elements, uint32_t count, bool invert)
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


