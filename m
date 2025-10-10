Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D8D0CCD185
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 13:55:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7DQL-0002xb-DC; Fri, 10 Oct 2025 09:44:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v7DQA-0002pc-24
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:44:35 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v7DPG-0008Es-Q3
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:44:32 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3ee12332f3dso704199f8f.2
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 06:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760103809; x=1760708609; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=liEThv/wKJajj3nFHkBzaXuLPFXtT8t9IBEbSacuDCs=;
 b=QCIU+pIYZ9VtRxF2rpLrqEzAusYML0G/xx8WnZr0YK1g5khL4ThOOEBa5GKU/nSZAh
 oIgR0EatgdGjFB0WoA1sJlnD8efeucXdR7veT9qxwkQR/Wb2G6BIlmhRvHmt09wwoE/O
 0LJC4ZRm4SLyeKkHAJjzXA2lgzcegn9NWu9AbWCeXT1KbuZE4/fjejWV8CIEiQjAHCni
 UPqNP3iudEzZF2rQTTWs/B8HSzm2mnPzes/YEGwgftWHCtsY4B9oyiYpf684e0MvECHZ
 Ygt14gmzhJNWa/SpTX2wbu8UAE7D8iQksW9aSuVnTICbTNJOwUgBN9+MdW3LTTKPLpTp
 Sjtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760103809; x=1760708609;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=liEThv/wKJajj3nFHkBzaXuLPFXtT8t9IBEbSacuDCs=;
 b=ni7RKP+Sjyy9qvsw2vTUmAR4jMIzh4hS7T+nNqFfLeYhrJhE7YlnNGeX4o4wSY4KkQ
 Q5XoohKvF+cwuxbvLh5ZwsMfG2Mue5tJV2NQbW5IQqNcBTFc+zJdVgvA1DJFSqFQ2Ta3
 PP2bW+aIF1jqGSE/x/0LQZTprksXf+zK4JZrM483/HAqFaTeXMElwC3WNIhdiz46bsnw
 7TmiLpu9qXShdo1Kh0JEJDSWxoY5ylqsaP3hnN+Ey1ldEu9WVFrldfOMtP4L5dd/QNly
 6T3ZpeH3xDEyPCRAf7Gy/1ogrizergtnbRu6QGIZQsLuPmk9DQUtU2F4fjCrTs3ILjvH
 ZOCA==
X-Gm-Message-State: AOJu0Ywbt9SbZiypu3zSXBDhT9YzdlHeYrd09L9eP4W8ngPxkYU2cA4o
 I5LLJk3pT7KsSIIjjBiJSulX2FmQa4vlrRYsypGqjZsATzLkUjk5VF7r2/VEs0eh4/LJ3eb4vQ9
 GiNgpxAYFpA==
X-Gm-Gg: ASbGncsrAnga38UF6grybUnYTDfLH85yQ1s+CAItj250RUnWitBShJuWX7rfIRUs0i8
 0it370P7ADet5QN/1GusJuZ40HkohNO//aoaAqfBteOqO6ECvgfnptg501zB6B5a3kzITfnvsNh
 9ZOrtJMeXa0uuGji/IigN1cRTia7AWSxHZA7cTw+zK/hpY7xnvEhyg/Nz5ttf4juXK4SkgQUkVS
 Q9Ljt/ZA+oXIQDHEkib7Ad1wB4nXhae30nZ9ovZhNlr/87PWBKx0dmwzaINu5LLRUpUoBhCupr/
 0M675QQxYr9FPQImnjo/mqOn+5F2FsQygmNHcoMJ2nTl9PsnIYDPaFdnxKa2gaR+yTjJNYgG4Vb
 HrKESW4ZeW+d6HKajb+XSo1TH2XzbIc4DnSjmWx/Pj84FPziBMa85Vy6DbPEYhV9Yy7SBvCqmvQ
 MWmgh93ubHEL9st2LkAZc=
X-Google-Smtp-Source: AGHT+IGW6g3IRBwrgQ64LIPxMU+Cxf303nlsOYFSMp0KSf39t5vruwxMoX+O6e9XrwP6KHumAdOWVQ==
X-Received: by 2002:a5d:64e8:0:b0:425:855c:5879 with SMTP id
 ffacd0b85a97d-4266e7d63f2mr7779098f8f.15.1760103808517; 
 Fri, 10 Oct 2025 06:43:28 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce57cce5sm4474174f8f.1.2025.10.10.06.43.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 10 Oct 2025 06:43:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>
Subject: [PATCH 11/16] target/mips: Replace HOST_BIG_ENDIAN #ifdef with
 runtime if() check
Date: Fri, 10 Oct 2025 15:42:20 +0200
Message-ID: <20251010134226.72221-12-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010134226.72221-1-philmd@linaro.org>
References: <20251010134226.72221-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

Replace compile-time #ifdef with a runtime check to ensure all code
paths are built and tested. This reduces build-time configuration
complexity and improves maintainability.

No functional change intended.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/tcg/msa_helper.c | 889 +++++++++++++++++------------------
 1 file changed, 444 insertions(+), 445 deletions(-)

diff --git a/target/mips/tcg/msa_helper.c b/target/mips/tcg/msa_helper.c
index f554b3d10ee..9f2d2bd6adc 100644
--- a/target/mips/tcg/msa_helper.c
+++ b/target/mips/tcg/msa_helper.c
@@ -4148,41 +4148,41 @@ void helper_msa_ilvev_b(CPUMIPSState *env,
     wr_t *pws = &(env->active_fpu.fpr[ws].wr);
     wr_t *pwt = &(env->active_fpu.fpr[wt].wr);
 
-#if HOST_BIG_ENDIAN
-    pwd->b[8]  = pws->b[9];
-    pwd->b[9]  = pwt->b[9];
-    pwd->b[10] = pws->b[11];
-    pwd->b[11] = pwt->b[11];
-    pwd->b[12] = pws->b[13];
-    pwd->b[13] = pwt->b[13];
-    pwd->b[14] = pws->b[15];
-    pwd->b[15] = pwt->b[15];
-    pwd->b[0]  = pws->b[1];
-    pwd->b[1]  = pwt->b[1];
-    pwd->b[2]  = pws->b[3];
-    pwd->b[3]  = pwt->b[3];
-    pwd->b[4]  = pws->b[5];
-    pwd->b[5]  = pwt->b[5];
-    pwd->b[6]  = pws->b[7];
-    pwd->b[7]  = pwt->b[7];
-#else
-    pwd->b[15] = pws->b[14];
-    pwd->b[14] = pwt->b[14];
-    pwd->b[13] = pws->b[12];
-    pwd->b[12] = pwt->b[12];
-    pwd->b[11] = pws->b[10];
-    pwd->b[10] = pwt->b[10];
-    pwd->b[9]  = pws->b[8];
-    pwd->b[8]  = pwt->b[8];
-    pwd->b[7]  = pws->b[6];
-    pwd->b[6]  = pwt->b[6];
-    pwd->b[5]  = pws->b[4];
-    pwd->b[4]  = pwt->b[4];
-    pwd->b[3]  = pws->b[2];
-    pwd->b[2]  = pwt->b[2];
-    pwd->b[1]  = pws->b[0];
-    pwd->b[0]  = pwt->b[0];
-#endif
+if (HOST_BIG_ENDIAN) {
+        pwd->b[8]  = pws->b[9];
+        pwd->b[9]  = pwt->b[9];
+        pwd->b[10] = pws->b[11];
+        pwd->b[11] = pwt->b[11];
+        pwd->b[12] = pws->b[13];
+        pwd->b[13] = pwt->b[13];
+        pwd->b[14] = pws->b[15];
+        pwd->b[15] = pwt->b[15];
+        pwd->b[0]  = pws->b[1];
+        pwd->b[1]  = pwt->b[1];
+        pwd->b[2]  = pws->b[3];
+        pwd->b[3]  = pwt->b[3];
+        pwd->b[4]  = pws->b[5];
+        pwd->b[5]  = pwt->b[5];
+        pwd->b[6]  = pws->b[7];
+        pwd->b[7]  = pwt->b[7];
+    } else {
+        pwd->b[15] = pws->b[14];
+        pwd->b[14] = pwt->b[14];
+        pwd->b[13] = pws->b[12];
+        pwd->b[12] = pwt->b[12];
+        pwd->b[11] = pws->b[10];
+        pwd->b[10] = pwt->b[10];
+        pwd->b[9]  = pws->b[8];
+        pwd->b[8]  = pwt->b[8];
+        pwd->b[7]  = pws->b[6];
+        pwd->b[6]  = pwt->b[6];
+        pwd->b[5]  = pws->b[4];
+        pwd->b[4]  = pwt->b[4];
+        pwd->b[3]  = pws->b[2];
+        pwd->b[2]  = pwt->b[2];
+        pwd->b[1]  = pws->b[0];
+        pwd->b[0]  = pwt->b[0];
+    }
 }
 
 void helper_msa_ilvev_h(CPUMIPSState *env,
@@ -4192,25 +4192,25 @@ void helper_msa_ilvev_h(CPUMIPSState *env,
     wr_t *pws = &(env->active_fpu.fpr[ws].wr);
     wr_t *pwt = &(env->active_fpu.fpr[wt].wr);
 
-#if HOST_BIG_ENDIAN
-    pwd->h[4] = pws->h[5];
-    pwd->h[5] = pwt->h[5];
-    pwd->h[6] = pws->h[7];
-    pwd->h[7] = pwt->h[7];
-    pwd->h[0] = pws->h[1];
-    pwd->h[1] = pwt->h[1];
-    pwd->h[2] = pws->h[3];
-    pwd->h[3] = pwt->h[3];
-#else
-    pwd->h[7] = pws->h[6];
-    pwd->h[6] = pwt->h[6];
-    pwd->h[5] = pws->h[4];
-    pwd->h[4] = pwt->h[4];
-    pwd->h[3] = pws->h[2];
-    pwd->h[2] = pwt->h[2];
-    pwd->h[1] = pws->h[0];
-    pwd->h[0] = pwt->h[0];
-#endif
+    if (HOST_BIG_ENDIAN) {
+        pwd->h[4] = pws->h[5];
+        pwd->h[5] = pwt->h[5];
+        pwd->h[6] = pws->h[7];
+        pwd->h[7] = pwt->h[7];
+        pwd->h[0] = pws->h[1];
+        pwd->h[1] = pwt->h[1];
+        pwd->h[2] = pws->h[3];
+        pwd->h[3] = pwt->h[3];
+    } else {
+        pwd->h[7] = pws->h[6];
+        pwd->h[6] = pwt->h[6];
+        pwd->h[5] = pws->h[4];
+        pwd->h[4] = pwt->h[4];
+        pwd->h[3] = pws->h[2];
+        pwd->h[2] = pwt->h[2];
+        pwd->h[1] = pws->h[0];
+        pwd->h[0] = pwt->h[0];
+    }
 }
 
 void helper_msa_ilvev_w(CPUMIPSState *env,
@@ -4220,17 +4220,17 @@ void helper_msa_ilvev_w(CPUMIPSState *env,
     wr_t *pws = &(env->active_fpu.fpr[ws].wr);
     wr_t *pwt = &(env->active_fpu.fpr[wt].wr);
 
-#if HOST_BIG_ENDIAN
-    pwd->w[2] = pws->w[3];
-    pwd->w[3] = pwt->w[3];
-    pwd->w[0] = pws->w[1];
-    pwd->w[1] = pwt->w[1];
-#else
-    pwd->w[3] = pws->w[2];
-    pwd->w[2] = pwt->w[2];
-    pwd->w[1] = pws->w[0];
-    pwd->w[0] = pwt->w[0];
-#endif
+    if (HOST_BIG_ENDIAN) {
+        pwd->w[2] = pws->w[3];
+        pwd->w[3] = pwt->w[3];
+        pwd->w[0] = pws->w[1];
+        pwd->w[1] = pwt->w[1];
+    } else {
+        pwd->w[3] = pws->w[2];
+        pwd->w[2] = pwt->w[2];
+        pwd->w[1] = pws->w[0];
+        pwd->w[0] = pwt->w[0];
+    }
 }
 
 void helper_msa_ilvev_d(CPUMIPSState *env,
@@ -4252,41 +4252,41 @@ void helper_msa_ilvod_b(CPUMIPSState *env,
     wr_t *pws = &(env->active_fpu.fpr[ws].wr);
     wr_t *pwt = &(env->active_fpu.fpr[wt].wr);
 
-#if HOST_BIG_ENDIAN
-    pwd->b[7]  = pwt->b[6];
-    pwd->b[6]  = pws->b[6];
-    pwd->b[5]  = pwt->b[4];
-    pwd->b[4]  = pws->b[4];
-    pwd->b[3]  = pwt->b[2];
-    pwd->b[2]  = pws->b[2];
-    pwd->b[1]  = pwt->b[0];
-    pwd->b[0]  = pws->b[0];
-    pwd->b[15] = pwt->b[14];
-    pwd->b[14] = pws->b[14];
-    pwd->b[13] = pwt->b[12];
-    pwd->b[12] = pws->b[12];
-    pwd->b[11] = pwt->b[10];
-    pwd->b[10] = pws->b[10];
-    pwd->b[9]  = pwt->b[8];
-    pwd->b[8]  = pws->b[8];
-#else
-    pwd->b[0]  = pwt->b[1];
-    pwd->b[1]  = pws->b[1];
-    pwd->b[2]  = pwt->b[3];
-    pwd->b[3]  = pws->b[3];
-    pwd->b[4]  = pwt->b[5];
-    pwd->b[5]  = pws->b[5];
-    pwd->b[6]  = pwt->b[7];
-    pwd->b[7]  = pws->b[7];
-    pwd->b[8]  = pwt->b[9];
-    pwd->b[9]  = pws->b[9];
-    pwd->b[10] = pwt->b[11];
-    pwd->b[11] = pws->b[11];
-    pwd->b[12] = pwt->b[13];
-    pwd->b[13] = pws->b[13];
-    pwd->b[14] = pwt->b[15];
-    pwd->b[15] = pws->b[15];
-#endif
+    if (HOST_BIG_ENDIAN) {
+        pwd->b[7]  = pwt->b[6];
+        pwd->b[6]  = pws->b[6];
+        pwd->b[5]  = pwt->b[4];
+        pwd->b[4]  = pws->b[4];
+        pwd->b[3]  = pwt->b[2];
+        pwd->b[2]  = pws->b[2];
+        pwd->b[1]  = pwt->b[0];
+        pwd->b[0]  = pws->b[0];
+        pwd->b[15] = pwt->b[14];
+        pwd->b[14] = pws->b[14];
+        pwd->b[13] = pwt->b[12];
+        pwd->b[12] = pws->b[12];
+        pwd->b[11] = pwt->b[10];
+        pwd->b[10] = pws->b[10];
+        pwd->b[9]  = pwt->b[8];
+        pwd->b[8]  = pws->b[8];
+    } else {
+        pwd->b[0]  = pwt->b[1];
+        pwd->b[1]  = pws->b[1];
+        pwd->b[2]  = pwt->b[3];
+        pwd->b[3]  = pws->b[3];
+        pwd->b[4]  = pwt->b[5];
+        pwd->b[5]  = pws->b[5];
+        pwd->b[6]  = pwt->b[7];
+        pwd->b[7]  = pws->b[7];
+        pwd->b[8]  = pwt->b[9];
+        pwd->b[9]  = pws->b[9];
+        pwd->b[10] = pwt->b[11];
+        pwd->b[11] = pws->b[11];
+        pwd->b[12] = pwt->b[13];
+        pwd->b[13] = pws->b[13];
+        pwd->b[14] = pwt->b[15];
+        pwd->b[15] = pws->b[15];
+    }
 }
 
 void helper_msa_ilvod_h(CPUMIPSState *env,
@@ -4296,25 +4296,25 @@ void helper_msa_ilvod_h(CPUMIPSState *env,
     wr_t *pws = &(env->active_fpu.fpr[ws].wr);
     wr_t *pwt = &(env->active_fpu.fpr[wt].wr);
 
-#if HOST_BIG_ENDIAN
-    pwd->h[3] = pwt->h[2];
-    pwd->h[2] = pws->h[2];
-    pwd->h[1] = pwt->h[0];
-    pwd->h[0] = pws->h[0];
-    pwd->h[7] = pwt->h[6];
-    pwd->h[6] = pws->h[6];
-    pwd->h[5] = pwt->h[4];
-    pwd->h[4] = pws->h[4];
-#else
-    pwd->h[0] = pwt->h[1];
-    pwd->h[1] = pws->h[1];
-    pwd->h[2] = pwt->h[3];
-    pwd->h[3] = pws->h[3];
-    pwd->h[4] = pwt->h[5];
-    pwd->h[5] = pws->h[5];
-    pwd->h[6] = pwt->h[7];
-    pwd->h[7] = pws->h[7];
-#endif
+    if (HOST_BIG_ENDIAN) {
+        pwd->h[3] = pwt->h[2];
+        pwd->h[2] = pws->h[2];
+        pwd->h[1] = pwt->h[0];
+        pwd->h[0] = pws->h[0];
+        pwd->h[7] = pwt->h[6];
+        pwd->h[6] = pws->h[6];
+        pwd->h[5] = pwt->h[4];
+        pwd->h[4] = pws->h[4];
+    } else {
+        pwd->h[0] = pwt->h[1];
+        pwd->h[1] = pws->h[1];
+        pwd->h[2] = pwt->h[3];
+        pwd->h[3] = pws->h[3];
+        pwd->h[4] = pwt->h[5];
+        pwd->h[5] = pws->h[5];
+        pwd->h[6] = pwt->h[7];
+        pwd->h[7] = pws->h[7];
+    }
 }
 
 void helper_msa_ilvod_w(CPUMIPSState *env,
@@ -4324,17 +4324,17 @@ void helper_msa_ilvod_w(CPUMIPSState *env,
     wr_t *pws = &(env->active_fpu.fpr[ws].wr);
     wr_t *pwt = &(env->active_fpu.fpr[wt].wr);
 
-#if HOST_BIG_ENDIAN
-    pwd->w[1] = pwt->w[0];
-    pwd->w[0] = pws->w[0];
-    pwd->w[3] = pwt->w[2];
-    pwd->w[2] = pws->w[2];
-#else
-    pwd->w[0] = pwt->w[1];
-    pwd->w[1] = pws->w[1];
-    pwd->w[2] = pwt->w[3];
-    pwd->w[3] = pws->w[3];
-#endif
+    if (HOST_BIG_ENDIAN) {
+        pwd->w[1] = pwt->w[0];
+        pwd->w[0] = pws->w[0];
+        pwd->w[3] = pwt->w[2];
+        pwd->w[2] = pws->w[2];
+    } else {
+        pwd->w[0] = pwt->w[1];
+        pwd->w[1] = pws->w[1];
+        pwd->w[2] = pwt->w[3];
+        pwd->w[3] = pws->w[3];
+    }
 }
 
 void helper_msa_ilvod_d(CPUMIPSState *env,
@@ -4356,41 +4356,41 @@ void helper_msa_ilvl_b(CPUMIPSState *env,
     wr_t *pws = &(env->active_fpu.fpr[ws].wr);
     wr_t *pwt = &(env->active_fpu.fpr[wt].wr);
 
-#if HOST_BIG_ENDIAN
-    pwd->b[7]  = pwt->b[15];
-    pwd->b[6]  = pws->b[15];
-    pwd->b[5]  = pwt->b[14];
-    pwd->b[4]  = pws->b[14];
-    pwd->b[3]  = pwt->b[13];
-    pwd->b[2]  = pws->b[13];
-    pwd->b[1]  = pwt->b[12];
-    pwd->b[0]  = pws->b[12];
-    pwd->b[15] = pwt->b[11];
-    pwd->b[14] = pws->b[11];
-    pwd->b[13] = pwt->b[10];
-    pwd->b[12] = pws->b[10];
-    pwd->b[11] = pwt->b[9];
-    pwd->b[10] = pws->b[9];
-    pwd->b[9]  = pwt->b[8];
-    pwd->b[8]  = pws->b[8];
-#else
-    pwd->b[0]  = pwt->b[8];
-    pwd->b[1]  = pws->b[8];
-    pwd->b[2]  = pwt->b[9];
-    pwd->b[3]  = pws->b[9];
-    pwd->b[4]  = pwt->b[10];
-    pwd->b[5]  = pws->b[10];
-    pwd->b[6]  = pwt->b[11];
-    pwd->b[7]  = pws->b[11];
-    pwd->b[8]  = pwt->b[12];
-    pwd->b[9]  = pws->b[12];
-    pwd->b[10] = pwt->b[13];
-    pwd->b[11] = pws->b[13];
-    pwd->b[12] = pwt->b[14];
-    pwd->b[13] = pws->b[14];
-    pwd->b[14] = pwt->b[15];
-    pwd->b[15] = pws->b[15];
-#endif
+    if (HOST_BIG_ENDIAN) {
+        pwd->b[7]  = pwt->b[15];
+        pwd->b[6]  = pws->b[15];
+        pwd->b[5]  = pwt->b[14];
+        pwd->b[4]  = pws->b[14];
+        pwd->b[3]  = pwt->b[13];
+        pwd->b[2]  = pws->b[13];
+        pwd->b[1]  = pwt->b[12];
+        pwd->b[0]  = pws->b[12];
+        pwd->b[15] = pwt->b[11];
+        pwd->b[14] = pws->b[11];
+        pwd->b[13] = pwt->b[10];
+        pwd->b[12] = pws->b[10];
+        pwd->b[11] = pwt->b[9];
+        pwd->b[10] = pws->b[9];
+        pwd->b[9]  = pwt->b[8];
+        pwd->b[8]  = pws->b[8];
+    } else {
+        pwd->b[0]  = pwt->b[8];
+        pwd->b[1]  = pws->b[8];
+        pwd->b[2]  = pwt->b[9];
+        pwd->b[3]  = pws->b[9];
+        pwd->b[4]  = pwt->b[10];
+        pwd->b[5]  = pws->b[10];
+        pwd->b[6]  = pwt->b[11];
+        pwd->b[7]  = pws->b[11];
+        pwd->b[8]  = pwt->b[12];
+        pwd->b[9]  = pws->b[12];
+        pwd->b[10] = pwt->b[13];
+        pwd->b[11] = pws->b[13];
+        pwd->b[12] = pwt->b[14];
+        pwd->b[13] = pws->b[14];
+        pwd->b[14] = pwt->b[15];
+        pwd->b[15] = pws->b[15];
+    }
 }
 
 void helper_msa_ilvl_h(CPUMIPSState *env,
@@ -4400,25 +4400,25 @@ void helper_msa_ilvl_h(CPUMIPSState *env,
     wr_t *pws = &(env->active_fpu.fpr[ws].wr);
     wr_t *pwt = &(env->active_fpu.fpr[wt].wr);
 
-#if HOST_BIG_ENDIAN
-    pwd->h[3] = pwt->h[7];
-    pwd->h[2] = pws->h[7];
-    pwd->h[1] = pwt->h[6];
-    pwd->h[0] = pws->h[6];
-    pwd->h[7] = pwt->h[5];
-    pwd->h[6] = pws->h[5];
-    pwd->h[5] = pwt->h[4];
-    pwd->h[4] = pws->h[4];
-#else
-    pwd->h[0] = pwt->h[4];
-    pwd->h[1] = pws->h[4];
-    pwd->h[2] = pwt->h[5];
-    pwd->h[3] = pws->h[5];
-    pwd->h[4] = pwt->h[6];
-    pwd->h[5] = pws->h[6];
-    pwd->h[6] = pwt->h[7];
-    pwd->h[7] = pws->h[7];
-#endif
+    if (HOST_BIG_ENDIAN) {
+        pwd->h[3] = pwt->h[7];
+        pwd->h[2] = pws->h[7];
+        pwd->h[1] = pwt->h[6];
+        pwd->h[0] = pws->h[6];
+        pwd->h[7] = pwt->h[5];
+        pwd->h[6] = pws->h[5];
+        pwd->h[5] = pwt->h[4];
+        pwd->h[4] = pws->h[4];
+    } else {
+        pwd->h[0] = pwt->h[4];
+        pwd->h[1] = pws->h[4];
+        pwd->h[2] = pwt->h[5];
+        pwd->h[3] = pws->h[5];
+        pwd->h[4] = pwt->h[6];
+        pwd->h[5] = pws->h[6];
+        pwd->h[6] = pwt->h[7];
+        pwd->h[7] = pws->h[7];
+    }
 }
 
 void helper_msa_ilvl_w(CPUMIPSState *env,
@@ -4428,17 +4428,17 @@ void helper_msa_ilvl_w(CPUMIPSState *env,
     wr_t *pws = &(env->active_fpu.fpr[ws].wr);
     wr_t *pwt = &(env->active_fpu.fpr[wt].wr);
 
-#if HOST_BIG_ENDIAN
-    pwd->w[1] = pwt->w[3];
-    pwd->w[0] = pws->w[3];
-    pwd->w[3] = pwt->w[2];
-    pwd->w[2] = pws->w[2];
-#else
-    pwd->w[0] = pwt->w[2];
-    pwd->w[1] = pws->w[2];
-    pwd->w[2] = pwt->w[3];
-    pwd->w[3] = pws->w[3];
-#endif
+    if (HOST_BIG_ENDIAN) {
+        pwd->w[1] = pwt->w[3];
+        pwd->w[0] = pws->w[3];
+        pwd->w[3] = pwt->w[2];
+        pwd->w[2] = pws->w[2];
+    } else {
+        pwd->w[0] = pwt->w[2];
+        pwd->w[1] = pws->w[2];
+        pwd->w[2] = pwt->w[3];
+        pwd->w[3] = pws->w[3];
+    }
 }
 
 void helper_msa_ilvl_d(CPUMIPSState *env,
@@ -4460,41 +4460,41 @@ void helper_msa_ilvr_b(CPUMIPSState *env,
     wr_t *pws = &(env->active_fpu.fpr[ws].wr);
     wr_t *pwt = &(env->active_fpu.fpr[wt].wr);
 
-#if HOST_BIG_ENDIAN
-    pwd->b[8]  = pws->b[0];
-    pwd->b[9]  = pwt->b[0];
-    pwd->b[10] = pws->b[1];
-    pwd->b[11] = pwt->b[1];
-    pwd->b[12] = pws->b[2];
-    pwd->b[13] = pwt->b[2];
-    pwd->b[14] = pws->b[3];
-    pwd->b[15] = pwt->b[3];
-    pwd->b[0]  = pws->b[4];
-    pwd->b[1]  = pwt->b[4];
-    pwd->b[2]  = pws->b[5];
-    pwd->b[3]  = pwt->b[5];
-    pwd->b[4]  = pws->b[6];
-    pwd->b[5]  = pwt->b[6];
-    pwd->b[6]  = pws->b[7];
-    pwd->b[7]  = pwt->b[7];
-#else
-    pwd->b[15] = pws->b[7];
-    pwd->b[14] = pwt->b[7];
-    pwd->b[13] = pws->b[6];
-    pwd->b[12] = pwt->b[6];
-    pwd->b[11] = pws->b[5];
-    pwd->b[10] = pwt->b[5];
-    pwd->b[9]  = pws->b[4];
-    pwd->b[8]  = pwt->b[4];
-    pwd->b[7]  = pws->b[3];
-    pwd->b[6]  = pwt->b[3];
-    pwd->b[5]  = pws->b[2];
-    pwd->b[4]  = pwt->b[2];
-    pwd->b[3]  = pws->b[1];
-    pwd->b[2]  = pwt->b[1];
-    pwd->b[1]  = pws->b[0];
-    pwd->b[0]  = pwt->b[0];
-#endif
+    if (HOST_BIG_ENDIAN) {
+        pwd->b[8]  = pws->b[0];
+        pwd->b[9]  = pwt->b[0];
+        pwd->b[10] = pws->b[1];
+        pwd->b[11] = pwt->b[1];
+        pwd->b[12] = pws->b[2];
+        pwd->b[13] = pwt->b[2];
+        pwd->b[14] = pws->b[3];
+        pwd->b[15] = pwt->b[3];
+        pwd->b[0]  = pws->b[4];
+        pwd->b[1]  = pwt->b[4];
+        pwd->b[2]  = pws->b[5];
+        pwd->b[3]  = pwt->b[5];
+        pwd->b[4]  = pws->b[6];
+        pwd->b[5]  = pwt->b[6];
+        pwd->b[6]  = pws->b[7];
+        pwd->b[7]  = pwt->b[7];
+    } else {
+        pwd->b[15] = pws->b[7];
+        pwd->b[14] = pwt->b[7];
+        pwd->b[13] = pws->b[6];
+        pwd->b[12] = pwt->b[6];
+        pwd->b[11] = pws->b[5];
+        pwd->b[10] = pwt->b[5];
+        pwd->b[9]  = pws->b[4];
+        pwd->b[8]  = pwt->b[4];
+        pwd->b[7]  = pws->b[3];
+        pwd->b[6]  = pwt->b[3];
+        pwd->b[5]  = pws->b[2];
+        pwd->b[4]  = pwt->b[2];
+        pwd->b[3]  = pws->b[1];
+        pwd->b[2]  = pwt->b[1];
+        pwd->b[1]  = pws->b[0];
+        pwd->b[0]  = pwt->b[0];
+    }
 }
 
 void helper_msa_ilvr_h(CPUMIPSState *env,
@@ -4504,25 +4504,25 @@ void helper_msa_ilvr_h(CPUMIPSState *env,
     wr_t *pws = &(env->active_fpu.fpr[ws].wr);
     wr_t *pwt = &(env->active_fpu.fpr[wt].wr);
 
-#if HOST_BIG_ENDIAN
-    pwd->h[4] = pws->h[0];
-    pwd->h[5] = pwt->h[0];
-    pwd->h[6] = pws->h[1];
-    pwd->h[7] = pwt->h[1];
-    pwd->h[0] = pws->h[2];
-    pwd->h[1] = pwt->h[2];
-    pwd->h[2] = pws->h[3];
-    pwd->h[3] = pwt->h[3];
-#else
-    pwd->h[7] = pws->h[3];
-    pwd->h[6] = pwt->h[3];
-    pwd->h[5] = pws->h[2];
-    pwd->h[4] = pwt->h[2];
-    pwd->h[3] = pws->h[1];
-    pwd->h[2] = pwt->h[1];
-    pwd->h[1] = pws->h[0];
-    pwd->h[0] = pwt->h[0];
-#endif
+    if (HOST_BIG_ENDIAN) {
+        pwd->h[4] = pws->h[0];
+        pwd->h[5] = pwt->h[0];
+        pwd->h[6] = pws->h[1];
+        pwd->h[7] = pwt->h[1];
+        pwd->h[0] = pws->h[2];
+        pwd->h[1] = pwt->h[2];
+        pwd->h[2] = pws->h[3];
+        pwd->h[3] = pwt->h[3];
+    } else {
+        pwd->h[7] = pws->h[3];
+        pwd->h[6] = pwt->h[3];
+        pwd->h[5] = pws->h[2];
+        pwd->h[4] = pwt->h[2];
+        pwd->h[3] = pws->h[1];
+        pwd->h[2] = pwt->h[1];
+        pwd->h[1] = pws->h[0];
+        pwd->h[0] = pwt->h[0];
+    }
 }
 
 void helper_msa_ilvr_w(CPUMIPSState *env,
@@ -4532,17 +4532,17 @@ void helper_msa_ilvr_w(CPUMIPSState *env,
     wr_t *pws = &(env->active_fpu.fpr[ws].wr);
     wr_t *pwt = &(env->active_fpu.fpr[wt].wr);
 
-#if HOST_BIG_ENDIAN
-    pwd->w[2] = pws->w[0];
-    pwd->w[3] = pwt->w[0];
-    pwd->w[0] = pws->w[1];
-    pwd->w[1] = pwt->w[1];
-#else
-    pwd->w[3] = pws->w[1];
-    pwd->w[2] = pwt->w[1];
-    pwd->w[1] = pws->w[0];
-    pwd->w[0] = pwt->w[0];
-#endif
+    if (HOST_BIG_ENDIAN) {
+        pwd->w[2] = pws->w[0];
+        pwd->w[3] = pwt->w[0];
+        pwd->w[0] = pws->w[1];
+        pwd->w[1] = pwt->w[1];
+    } else {
+        pwd->w[3] = pws->w[1];
+        pwd->w[2] = pwt->w[1];
+        pwd->w[1] = pws->w[0];
+        pwd->w[0] = pwt->w[0];
+    }
 }
 
 void helper_msa_ilvr_d(CPUMIPSState *env,
@@ -4663,41 +4663,41 @@ void helper_msa_pckev_b(CPUMIPSState *env,
     wr_t *pws = &(env->active_fpu.fpr[ws].wr);
     wr_t *pwt = &(env->active_fpu.fpr[wt].wr);
 
-#if HOST_BIG_ENDIAN
-    pwd->b[8]  = pws->b[9];
-    pwd->b[10] = pws->b[13];
-    pwd->b[12] = pws->b[1];
-    pwd->b[14] = pws->b[5];
-    pwd->b[0]  = pwt->b[9];
-    pwd->b[2]  = pwt->b[13];
-    pwd->b[4]  = pwt->b[1];
-    pwd->b[6]  = pwt->b[5];
-    pwd->b[9]  = pws->b[11];
-    pwd->b[13] = pws->b[3];
-    pwd->b[1]  = pwt->b[11];
-    pwd->b[5]  = pwt->b[3];
-    pwd->b[11] = pws->b[15];
-    pwd->b[3]  = pwt->b[15];
-    pwd->b[15] = pws->b[7];
-    pwd->b[7]  = pwt->b[7];
-#else
-    pwd->b[15] = pws->b[14];
-    pwd->b[13] = pws->b[10];
-    pwd->b[11] = pws->b[6];
-    pwd->b[9]  = pws->b[2];
-    pwd->b[7]  = pwt->b[14];
-    pwd->b[5]  = pwt->b[10];
-    pwd->b[3]  = pwt->b[6];
-    pwd->b[1]  = pwt->b[2];
-    pwd->b[14] = pws->b[12];
-    pwd->b[10] = pws->b[4];
-    pwd->b[6]  = pwt->b[12];
-    pwd->b[2]  = pwt->b[4];
-    pwd->b[12] = pws->b[8];
-    pwd->b[4]  = pwt->b[8];
-    pwd->b[8]  = pws->b[0];
-    pwd->b[0]  = pwt->b[0];
-#endif
+    if (HOST_BIG_ENDIAN) {
+        pwd->b[8]  = pws->b[9];
+        pwd->b[10] = pws->b[13];
+        pwd->b[12] = pws->b[1];
+        pwd->b[14] = pws->b[5];
+        pwd->b[0]  = pwt->b[9];
+        pwd->b[2]  = pwt->b[13];
+        pwd->b[4]  = pwt->b[1];
+        pwd->b[6]  = pwt->b[5];
+        pwd->b[9]  = pws->b[11];
+        pwd->b[13] = pws->b[3];
+        pwd->b[1]  = pwt->b[11];
+        pwd->b[5]  = pwt->b[3];
+        pwd->b[11] = pws->b[15];
+        pwd->b[3]  = pwt->b[15];
+        pwd->b[15] = pws->b[7];
+        pwd->b[7]  = pwt->b[7];
+    } else {
+        pwd->b[15] = pws->b[14];
+        pwd->b[13] = pws->b[10];
+        pwd->b[11] = pws->b[6];
+        pwd->b[9]  = pws->b[2];
+        pwd->b[7]  = pwt->b[14];
+        pwd->b[5]  = pwt->b[10];
+        pwd->b[3]  = pwt->b[6];
+        pwd->b[1]  = pwt->b[2];
+        pwd->b[14] = pws->b[12];
+        pwd->b[10] = pws->b[4];
+        pwd->b[6]  = pwt->b[12];
+        pwd->b[2]  = pwt->b[4];
+        pwd->b[12] = pws->b[8];
+        pwd->b[4]  = pwt->b[8];
+        pwd->b[8]  = pws->b[0];
+        pwd->b[0]  = pwt->b[0];
+    }
 }
 
 void helper_msa_pckev_h(CPUMIPSState *env,
@@ -4707,25 +4707,25 @@ void helper_msa_pckev_h(CPUMIPSState *env,
     wr_t *pws = &(env->active_fpu.fpr[ws].wr);
     wr_t *pwt = &(env->active_fpu.fpr[wt].wr);
 
-#if HOST_BIG_ENDIAN
-    pwd->h[4] = pws->h[5];
-    pwd->h[6] = pws->h[1];
-    pwd->h[0] = pwt->h[5];
-    pwd->h[2] = pwt->h[1];
-    pwd->h[5] = pws->h[7];
-    pwd->h[1] = pwt->h[7];
-    pwd->h[7] = pws->h[3];
-    pwd->h[3] = pwt->h[3];
-#else
-    pwd->h[7] = pws->h[6];
-    pwd->h[5] = pws->h[2];
-    pwd->h[3] = pwt->h[6];
-    pwd->h[1] = pwt->h[2];
-    pwd->h[6] = pws->h[4];
-    pwd->h[2] = pwt->h[4];
-    pwd->h[4] = pws->h[0];
-    pwd->h[0] = pwt->h[0];
-#endif
+    if (HOST_BIG_ENDIAN) {
+        pwd->h[4] = pws->h[5];
+        pwd->h[6] = pws->h[1];
+        pwd->h[0] = pwt->h[5];
+        pwd->h[2] = pwt->h[1];
+        pwd->h[5] = pws->h[7];
+        pwd->h[1] = pwt->h[7];
+        pwd->h[7] = pws->h[3];
+        pwd->h[3] = pwt->h[3];
+    } else {
+        pwd->h[7] = pws->h[6];
+        pwd->h[5] = pws->h[2];
+        pwd->h[3] = pwt->h[6];
+        pwd->h[1] = pwt->h[2];
+        pwd->h[6] = pws->h[4];
+        pwd->h[2] = pwt->h[4];
+        pwd->h[4] = pws->h[0];
+        pwd->h[0] = pwt->h[0];
+    }
 }
 
 void helper_msa_pckev_w(CPUMIPSState *env,
@@ -4735,17 +4735,17 @@ void helper_msa_pckev_w(CPUMIPSState *env,
     wr_t *pws = &(env->active_fpu.fpr[ws].wr);
     wr_t *pwt = &(env->active_fpu.fpr[wt].wr);
 
-#if HOST_BIG_ENDIAN
-    pwd->w[2] = pws->w[3];
-    pwd->w[0] = pwt->w[3];
-    pwd->w[3] = pws->w[1];
-    pwd->w[1] = pwt->w[1];
-#else
-    pwd->w[3] = pws->w[2];
-    pwd->w[1] = pwt->w[2];
-    pwd->w[2] = pws->w[0];
-    pwd->w[0] = pwt->w[0];
-#endif
+    if (HOST_BIG_ENDIAN) {
+        pwd->w[2] = pws->w[3];
+        pwd->w[0] = pwt->w[3];
+        pwd->w[3] = pws->w[1];
+        pwd->w[1] = pwt->w[1];
+    } else {
+        pwd->w[3] = pws->w[2];
+        pwd->w[1] = pwt->w[2];
+        pwd->w[2] = pws->w[0];
+        pwd->w[0] = pwt->w[0];
+    }
 }
 
 void helper_msa_pckev_d(CPUMIPSState *env,
@@ -4767,42 +4767,41 @@ void helper_msa_pckod_b(CPUMIPSState *env,
     wr_t *pws = &(env->active_fpu.fpr[ws].wr);
     wr_t *pwt = &(env->active_fpu.fpr[wt].wr);
 
-#if HOST_BIG_ENDIAN
-    pwd->b[7]  = pwt->b[6];
-    pwd->b[5]  = pwt->b[2];
-    pwd->b[3]  = pwt->b[14];
-    pwd->b[1]  = pwt->b[10];
-    pwd->b[15] = pws->b[6];
-    pwd->b[13] = pws->b[2];
-    pwd->b[11] = pws->b[14];
-    pwd->b[9]  = pws->b[10];
-    pwd->b[6]  = pwt->b[4];
-    pwd->b[2]  = pwt->b[12];
-    pwd->b[14] = pws->b[4];
-    pwd->b[10] = pws->b[12];
-    pwd->b[4]  = pwt->b[0];
-    pwd->b[12] = pws->b[0];
-    pwd->b[0]  = pwt->b[8];
-    pwd->b[8]  = pws->b[8];
-#else
-    pwd->b[0]  = pwt->b[1];
-    pwd->b[2]  = pwt->b[5];
-    pwd->b[4]  = pwt->b[9];
-    pwd->b[6]  = pwt->b[13];
-    pwd->b[8]  = pws->b[1];
-    pwd->b[10] = pws->b[5];
-    pwd->b[12] = pws->b[9];
-    pwd->b[14] = pws->b[13];
-    pwd->b[1]  = pwt->b[3];
-    pwd->b[5]  = pwt->b[11];
-    pwd->b[9]  = pws->b[3];
-    pwd->b[13] = pws->b[11];
-    pwd->b[3]  = pwt->b[7];
-    pwd->b[11] = pws->b[7];
-    pwd->b[7]  = pwt->b[15];
-    pwd->b[15] = pws->b[15];
-#endif
-
+    if (HOST_BIG_ENDIAN) {
+        pwd->b[7]  = pwt->b[6];
+        pwd->b[5]  = pwt->b[2];
+        pwd->b[3]  = pwt->b[14];
+        pwd->b[1]  = pwt->b[10];
+        pwd->b[15] = pws->b[6];
+        pwd->b[13] = pws->b[2];
+        pwd->b[11] = pws->b[14];
+        pwd->b[9]  = pws->b[10];
+        pwd->b[6]  = pwt->b[4];
+        pwd->b[2]  = pwt->b[12];
+        pwd->b[14] = pws->b[4];
+        pwd->b[10] = pws->b[12];
+        pwd->b[4]  = pwt->b[0];
+        pwd->b[12] = pws->b[0];
+        pwd->b[0]  = pwt->b[8];
+        pwd->b[8]  = pws->b[8];
+    } else {
+        pwd->b[0]  = pwt->b[1];
+        pwd->b[2]  = pwt->b[5];
+        pwd->b[4]  = pwt->b[9];
+        pwd->b[6]  = pwt->b[13];
+        pwd->b[8]  = pws->b[1];
+        pwd->b[10] = pws->b[5];
+        pwd->b[12] = pws->b[9];
+        pwd->b[14] = pws->b[13];
+        pwd->b[1]  = pwt->b[3];
+        pwd->b[5]  = pwt->b[11];
+        pwd->b[9]  = pws->b[3];
+        pwd->b[13] = pws->b[11];
+        pwd->b[3]  = pwt->b[7];
+        pwd->b[11] = pws->b[7];
+        pwd->b[7]  = pwt->b[15];
+        pwd->b[15] = pws->b[15];
+    }
 }
 
 void helper_msa_pckod_h(CPUMIPSState *env,
@@ -4812,25 +4811,25 @@ void helper_msa_pckod_h(CPUMIPSState *env,
     wr_t *pws = &(env->active_fpu.fpr[ws].wr);
     wr_t *pwt = &(env->active_fpu.fpr[wt].wr);
 
-#if HOST_BIG_ENDIAN
-    pwd->h[3] = pwt->h[2];
-    pwd->h[1] = pwt->h[6];
-    pwd->h[7] = pws->h[2];
-    pwd->h[5] = pws->h[6];
-    pwd->h[2] = pwt->h[0];
-    pwd->h[6] = pws->h[0];
-    pwd->h[0] = pwt->h[4];
-    pwd->h[4] = pws->h[4];
-#else
-    pwd->h[0] = pwt->h[1];
-    pwd->h[2] = pwt->h[5];
-    pwd->h[4] = pws->h[1];
-    pwd->h[6] = pws->h[5];
-    pwd->h[1] = pwt->h[3];
-    pwd->h[5] = pws->h[3];
-    pwd->h[3] = pwt->h[7];
-    pwd->h[7] = pws->h[7];
-#endif
+    if (HOST_BIG_ENDIAN) {
+        pwd->h[3] = pwt->h[2];
+        pwd->h[1] = pwt->h[6];
+        pwd->h[7] = pws->h[2];
+        pwd->h[5] = pws->h[6];
+        pwd->h[2] = pwt->h[0];
+        pwd->h[6] = pws->h[0];
+        pwd->h[0] = pwt->h[4];
+        pwd->h[4] = pws->h[4];
+    } else {
+        pwd->h[0] = pwt->h[1];
+        pwd->h[2] = pwt->h[5];
+        pwd->h[4] = pws->h[1];
+        pwd->h[6] = pws->h[5];
+        pwd->h[1] = pwt->h[3];
+        pwd->h[5] = pws->h[3];
+        pwd->h[3] = pwt->h[7];
+        pwd->h[7] = pws->h[7];
+    }
 }
 
 void helper_msa_pckod_w(CPUMIPSState *env,
@@ -4840,17 +4839,17 @@ void helper_msa_pckod_w(CPUMIPSState *env,
     wr_t *pws = &(env->active_fpu.fpr[ws].wr);
     wr_t *pwt = &(env->active_fpu.fpr[wt].wr);
 
-#if HOST_BIG_ENDIAN
-    pwd->w[1] = pwt->w[0];
-    pwd->w[3] = pws->w[0];
-    pwd->w[0] = pwt->w[2];
-    pwd->w[2] = pws->w[2];
-#else
-    pwd->w[0] = pwt->w[1];
-    pwd->w[2] = pws->w[1];
-    pwd->w[1] = pwt->w[3];
-    pwd->w[3] = pws->w[3];
-#endif
+    if (HOST_BIG_ENDIAN) {
+        pwd->w[1] = pwt->w[0];
+        pwd->w[3] = pws->w[0];
+        pwd->w[0] = pwt->w[2];
+        pwd->w[2] = pws->w[2];
+    } else {
+        pwd->w[0] = pwt->w[1];
+        pwd->w[2] = pws->w[1];
+        pwd->w[1] = pwt->w[3];
+        pwd->w[3] = pws->w[3];
+    }
 }
 
 void helper_msa_pckod_d(CPUMIPSState *env,
@@ -5928,13 +5927,13 @@ void helper_msa_copy_s_b(CPUMIPSState *env, uint32_t rd,
                          uint32_t ws, uint32_t n)
 {
     n %= 16;
-#if HOST_BIG_ENDIAN
-    if (n < 8) {
-        n = 8 - n - 1;
-    } else {
-        n = 24 - n - 1;
+    if (HOST_BIG_ENDIAN) {
+        if (n < 8) {
+            n = 8 - n - 1;
+        } else {
+            n = 24 - n - 1;
+        }
     }
-#endif
     env->active_tc.gpr[rd] = (int8_t)env->active_fpu.fpr[ws].wr.b[n];
 }
 
@@ -5942,13 +5941,13 @@ void helper_msa_copy_s_h(CPUMIPSState *env, uint32_t rd,
                          uint32_t ws, uint32_t n)
 {
     n %= 8;
-#if HOST_BIG_ENDIAN
-    if (n < 4) {
-        n = 4 - n - 1;
-    } else {
-        n = 12 - n - 1;
+    if (HOST_BIG_ENDIAN) {
+        if (n < 4) {
+            n = 4 - n - 1;
+        } else {
+            n = 12 - n - 1;
+        }
     }
-#endif
     env->active_tc.gpr[rd] = (int16_t)env->active_fpu.fpr[ws].wr.h[n];
 }
 
@@ -5956,13 +5955,13 @@ void helper_msa_copy_s_w(CPUMIPSState *env, uint32_t rd,
                          uint32_t ws, uint32_t n)
 {
     n %= 4;
-#if HOST_BIG_ENDIAN
-    if (n < 2) {
-        n = 2 - n - 1;
-    } else {
-        n = 6 - n - 1;
+    if (HOST_BIG_ENDIAN) {
+        if (n < 2) {
+            n = 2 - n - 1;
+        } else {
+            n = 6 - n - 1;
+        }
     }
-#endif
     env->active_tc.gpr[rd] = (int32_t)env->active_fpu.fpr[ws].wr.w[n];
 }
 
@@ -5977,13 +5976,13 @@ void helper_msa_copy_u_b(CPUMIPSState *env, uint32_t rd,
                          uint32_t ws, uint32_t n)
 {
     n %= 16;
-#if HOST_BIG_ENDIAN
-    if (n < 8) {
-        n = 8 - n - 1;
-    } else {
-        n = 24 - n - 1;
+    if (HOST_BIG_ENDIAN) {
+        if (n < 8) {
+            n = 8 - n - 1;
+        } else {
+            n = 24 - n - 1;
+        }
     }
-#endif
     env->active_tc.gpr[rd] = (uint8_t)env->active_fpu.fpr[ws].wr.b[n];
 }
 
@@ -5991,13 +5990,13 @@ void helper_msa_copy_u_h(CPUMIPSState *env, uint32_t rd,
                          uint32_t ws, uint32_t n)
 {
     n %= 8;
-#if HOST_BIG_ENDIAN
-    if (n < 4) {
-        n = 4 - n - 1;
-    } else {
-        n = 12 - n - 1;
+    if (HOST_BIG_ENDIAN) {
+        if (n < 4) {
+            n = 4 - n - 1;
+        } else {
+            n = 12 - n - 1;
+        }
     }
-#endif
     env->active_tc.gpr[rd] = (uint16_t)env->active_fpu.fpr[ws].wr.h[n];
 }
 
@@ -6005,13 +6004,13 @@ void helper_msa_copy_u_w(CPUMIPSState *env, uint32_t rd,
                          uint32_t ws, uint32_t n)
 {
     n %= 4;
-#if HOST_BIG_ENDIAN
-    if (n < 2) {
-        n = 2 - n - 1;
-    } else {
-        n = 6 - n - 1;
+    if (HOST_BIG_ENDIAN) {
+        if (n < 2) {
+            n = 2 - n - 1;
+        } else {
+            n = 6 - n - 1;
+        }
     }
-#endif
     env->active_tc.gpr[rd] = (uint32_t)env->active_fpu.fpr[ws].wr.w[n];
 }
 
@@ -6021,13 +6020,13 @@ void helper_msa_insert_b(CPUMIPSState *env, uint32_t wd,
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
     target_ulong rs = env->active_tc.gpr[rs_num];
     n %= 16;
-#if HOST_BIG_ENDIAN
-    if (n < 8) {
-        n = 8 - n - 1;
-    } else {
-        n = 24 - n - 1;
+    if (HOST_BIG_ENDIAN) {
+        if (n < 8) {
+            n = 8 - n - 1;
+        } else {
+            n = 24 - n - 1;
+        }
     }
-#endif
     pwd->b[n] = (int8_t)rs;
 }
 
@@ -6037,13 +6036,13 @@ void helper_msa_insert_h(CPUMIPSState *env, uint32_t wd,
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
     target_ulong rs = env->active_tc.gpr[rs_num];
     n %= 8;
-#if HOST_BIG_ENDIAN
-    if (n < 4) {
-        n = 4 - n - 1;
-    } else {
-        n = 12 - n - 1;
+    if (HOST_BIG_ENDIAN) {
+        if (n < 4) {
+            n = 4 - n - 1;
+        } else {
+            n = 12 - n - 1;
+        }
     }
-#endif
     pwd->h[n] = (int16_t)rs;
 }
 
@@ -6053,13 +6052,13 @@ void helper_msa_insert_w(CPUMIPSState *env, uint32_t wd,
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
     target_ulong rs = env->active_tc.gpr[rs_num];
     n %= 4;
-#if HOST_BIG_ENDIAN
-    if (n < 2) {
-        n = 2 - n - 1;
-    } else {
-        n = 6 - n - 1;
+    if (HOST_BIG_ENDIAN) {
+        if (n < 2) {
+            n = 2 - n - 1;
+        } else {
+            n = 6 - n - 1;
+        }
     }
-#endif
     pwd->w[n] = (int32_t)rs;
 }
 
-- 
2.51.0


