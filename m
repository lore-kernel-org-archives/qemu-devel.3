Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 528C7C25B79
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 15:09:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7GFN-0003qY-6w; Wed, 15 May 2024 11:08:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7GFI-0003pT-Dl
 for qemu-devel@nongnu.org; Wed, 15 May 2024 11:08:45 -0400
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7GFG-0002ng-L4
 for qemu-devel@nongnu.org; Wed, 15 May 2024 11:08:44 -0400
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2e0933d3b5fso103891461fa.2
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 08:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715785721; x=1716390521; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=65Gkdr7ftr6lyKPmfr51rDrQ5Maa9PeaHdOx7rkPnQ4=;
 b=CC+G5yAZSQuIyP5KOiDdRhafBLp4dEwJ1yDQpr9C240Yw1Hj8DPqvD3s/CN5KLqZGA
 9bIM0NHR2SvdJ2VEOK9zlad55lZsu3jITlVXZxrKgU2JOLjKK68zzRyuJYPk8yARt1zI
 r4DKGPNHvj61oUvfWr+D4HTV4DV2oaDJzBMhBbfjEJ9cvzAX3xKMpsR9C/BrVTAZipRc
 Yw6AssB3Bws3Cv/wckK+YWryjX8BwNfyH3Y+S0EQflXP96bStl3PkQRbBe4ZBalebNM/
 stYL4bDZExuHuxOqqXzmQECRdyCiyhOUiQF+NLra+uzGm+S7jyhgqHy/XuPIcuk2ec7L
 sA9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715785721; x=1716390521;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=65Gkdr7ftr6lyKPmfr51rDrQ5Maa9PeaHdOx7rkPnQ4=;
 b=dTNLqwXRtxOrtsiHlprqENQrFihEMtkJC8m+jZud/XXQLbdTIOL4hEFxejvta8Ft/I
 5HOZ5PN8lNJyNNwi79WvRV64SWtxwBWUmwmxb3gAjR5ix7sl84H7A4yqRQC8/8cmflZn
 +wj1+vpE+HbgHQ7nG+h4hSQf3kF3AyTiIe17PNbMhjGT8qZ4S2JqrREhISZRdAwKgHo1
 /EF07KcS5lnVfkxvN+mnHAHg7TW6InEfgTLuuTYG7uNrM1i9K+cf0QB4P5WVoFe1I5UC
 sGJPCnv0f/wppYJ5as5HT5+8/vaPS70LEX97iyPdBMlsshUL01Fr/KLnUJv3HiQAA0ym
 t3TQ==
X-Gm-Message-State: AOJu0YwGb33JFWCvHrezK/NKYTLffPOrj/4c3TzY516r+vq9ourJDNTj
 EOI6nCiWSLuoTFLLDNW0WFdfw4HZ/RroKj6ANfekw3V30ciEv+3vUay4oDRivENiGMaC7V6b6T5
 caLc=
X-Google-Smtp-Source: AGHT+IHhNhGX9XxKmbl7KAz71ZdyGVByi4iZmyqdy5iLu5oenu8w+bacTtTcB/EdRW3ZuvQpVKD8OA==
X-Received: by 2002:a2e:2a83:0:b0:2e2:2791:9842 with SMTP id
 38308e7fff4ca-2e5204ac519mr97256021fa.44.1715785720940; 
 Wed, 15 May 2024 08:08:40 -0700 (PDT)
Received: from stoup.. ([149.14.240.163]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42013c5fa61sm132080825e9.40.2024.05.15.08.08.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 08:08:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com,
	laurent@vivier.eu
Subject: [PATCH v3 03/28] target/i386: Convert helper_{fbld,
 fbst}_ST0 to X86Access
Date: Wed, 15 May 2024 17:08:12 +0200
Message-Id: <20240515150837.259747-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240515150837.259747-1-richard.henderson@linaro.org>
References: <20240515150837.259747-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::232;
 envelope-from=richard.henderson@linaro.org; helo=mail-lj1-x232.google.com
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

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/tcg/fpu_helper.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/target/i386/tcg/fpu_helper.c b/target/i386/tcg/fpu_helper.c
index 1662643a8f..6237cd8383 100644
--- a/target/i386/tcg/fpu_helper.c
+++ b/target/i386/tcg/fpu_helper.c
@@ -773,18 +773,21 @@ void helper_fninit(CPUX86State *env)
 
 void helper_fbld_ST0(CPUX86State *env, target_ulong ptr)
 {
+    X86Access ac;
     floatx80 tmp;
     uint64_t val;
     unsigned int v;
     int i;
 
+    access_prepare(&ac, env, ptr, 10, MMU_DATA_LOAD, GETPC());
+
     val = 0;
     for (i = 8; i >= 0; i--) {
-        v = cpu_ldub_data_ra(env, ptr + i, GETPC());
+        v = access_ldb(&ac, ptr + i);
         val = (val * 100) + ((v >> 4) * 10) + (v & 0xf);
     }
     tmp = int64_to_floatx80(val, &env->fp_status);
-    if (cpu_ldub_data_ra(env, ptr + 9, GETPC()) & 0x80) {
+    if (access_ldb(&ac, ptr + 9) & 0x80) {
         tmp = floatx80_chs(tmp);
     }
     fpush(env);
@@ -798,7 +801,9 @@ void helper_fbst_ST0(CPUX86State *env, target_ulong ptr)
     target_ulong mem_ref, mem_end;
     int64_t val;
     CPU_LDoubleU temp;
+    X86Access ac;
 
+    access_prepare(&ac, env, ptr, 10, MMU_DATA_STORE, GETPC());
     temp.d = ST0;
 
     val = floatx80_to_int64(ST0, &env->fp_status);
@@ -806,20 +811,20 @@ void helper_fbst_ST0(CPUX86State *env, target_ulong ptr)
     if (val >= 1000000000000000000LL || val <= -1000000000000000000LL) {
         set_float_exception_flags(float_flag_invalid, &env->fp_status);
         while (mem_ref < ptr + 7) {
-            cpu_stb_data_ra(env, mem_ref++, 0, GETPC());
+            access_stb(&ac, mem_ref++, 0);
         }
-        cpu_stb_data_ra(env, mem_ref++, 0xc0, GETPC());
-        cpu_stb_data_ra(env, mem_ref++, 0xff, GETPC());
-        cpu_stb_data_ra(env, mem_ref++, 0xff, GETPC());
+        access_stb(&ac, mem_ref++, 0xc0);
+        access_stb(&ac, mem_ref++, 0xff);
+        access_stb(&ac, mem_ref++, 0xff);
         merge_exception_flags(env, old_flags);
         return;
     }
     mem_end = mem_ref + 9;
     if (SIGND(temp)) {
-        cpu_stb_data_ra(env, mem_end, 0x80, GETPC());
+        access_stb(&ac, mem_end, 0x80);
         val = -val;
     } else {
-        cpu_stb_data_ra(env, mem_end, 0x00, GETPC());
+        access_stb(&ac, mem_end, 0x00);
     }
     while (mem_ref < mem_end) {
         if (val == 0) {
@@ -828,10 +833,10 @@ void helper_fbst_ST0(CPUX86State *env, target_ulong ptr)
         v = val % 100;
         val = val / 100;
         v = ((v / 10) << 4) | (v % 10);
-        cpu_stb_data_ra(env, mem_ref++, v, GETPC());
+        access_stb(&ac, mem_ref++, v);
     }
     while (mem_ref < mem_end) {
-        cpu_stb_data_ra(env, mem_ref++, 0, GETPC());
+        access_stb(&ac, mem_ref++, 0);
     }
     merge_exception_flags(env, old_flags);
 }
-- 
2.34.1


