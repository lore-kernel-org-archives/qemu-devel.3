Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4B5DC369CB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 01:15:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7l0g-0004F9-D9; Wed, 23 Apr 2025 21:04:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kwz-0005X6-LO
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 21:00:25 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kwx-0005YF-G3
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 21:00:25 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-7390d21bb1cso356572b3a.2
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 18:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745456422; x=1746061222; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JLzC9VkDx4HsryHBPy+FJ9fpV0dAAKB9NnelMQm4FiI=;
 b=Ti5An7wUPB3a2pM0Tktf9y++Ojv6bj9Ox1SjmIww+1CRFt2qPMJIzrchWS8jd5gQTu
 dmbS4ItHjB55EzLfVH1e+HD09kGPqZI7B9SXZpKPVi061d75tkvAWIxYfsraF6D9FrNg
 whIZtUMqHa3yuLpHEf019YY8c0FOoSmttaxp18Qllj2DqifIgs4GKbD0YrbN05jf6jLY
 ZSPYLGcM7hz867MluL6sNeijLl5l+1eYPpQshPLj6DqChVpRksuLrzZt+f0O0pH7izav
 NwtDLSSkL/NInx27DF1mCJjEfIH/nPnklnAgO8Wf2TnB2B9aeJAQ3XO2wopr1n8wKOO2
 ce9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745456422; x=1746061222;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JLzC9VkDx4HsryHBPy+FJ9fpV0dAAKB9NnelMQm4FiI=;
 b=wSamPIiJvjEZKavXtf8uBsgadIFveo1ZsevuGROSamk1aS9Dx5IZRkT63hb6pYXic/
 cVwOJMnzjuDCOgS0Ms6COel7pnOkWQ7J1k6r/ri7B80y9gwWqy5axVTuk228WVnD0FUJ
 KL2YENQdTZoXEl7Ih2j+H4xTU/p7P3sXHanilGLvGFZqQOCooyEXX/Yuvq8ooDenB3Tv
 6Grq5zc4NJLq+C+zxGFmn7glqdo5QCydo7qRDrNyrxHP4nTr8sRYpREhFuZ+ihcUj0B6
 TL4yJSzYowE83rMCWm4WPUkPXQ/REF0GOm8V3VTXB2IGpR1PwgNAsdxGC0MPgWgnG+VE
 SD4A==
X-Gm-Message-State: AOJu0Yz/WiBUOjyaihX/gGF1VD6macdTG0IIJZBcPkG9ZTwJU3Ljy80n
 AGS1DbUxU05SabHaxx9YgxIAAdAKW7HlTmrGqHd5T3EI8MZBs9P2GvoAWK8o/NDhSo5Fv+IwdjV
 R
X-Gm-Gg: ASbGnctRvtIOnWJzaUh2sRvyvu3E+7XwaI4XqXINiH+jj4UcSCc7KHBpvF9RCojp1F1
 3lDLTJFAMPvykpobGsVTlYYhjhnA0TbJF5yPvPgED1REyGegl2n720sgJ/kQTv0uc9UH0SFR5lQ
 c6H2H/d45JTI+rKKxiBGSgWl2+UVw7CWkX0aBhhEXSiVxv0wV2/OwVR6Un5uL0viRuUK6YthLNb
 fxdANy+TltCrgGmno+Qd30bilpESJeZGplupd6k8/q+kZ/bSUcsaKgYu40HbDN8mZ7UrYO5v6KI
 jGC64J43ibvrn5yHp0M2ZPnS6VneJBKPeDqymL9Sf2jjL8MDYrhGKs9zOX/MwUdbVFxmeSH5MVg
 =
X-Google-Smtp-Source: AGHT+IHZAjVklVC6B1MM1jCB2+SILlBFCPltnz3tTeOq1eYwvJFgsevNwGSZY/PsCd0JcyQv94jQxw==
X-Received: by 2002:a05:6a21:118e:b0:1ee:e2ac:5159 with SMTP id
 adf61e73a8af0-20444ebde5bmr873604637.19.1745456422011; 
 Wed, 23 Apr 2025 18:00:22 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b15f76f45c7sm129259a12.16.2025.04.23.18.00.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 18:00:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 145/148] accel/tcg: Move mttcg warning to tcg_init_machine
Date: Wed, 23 Apr 2025 17:49:30 -0700
Message-ID: <20250424004934.598783-146-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424004934.598783-1-richard.henderson@linaro.org>
References: <20250424004934.598783-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

Delay the warning to tcg_init_machine, because we will
have resolved the CPUClass at that point.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/tcg-all.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
index fa77a4c5a2..ecdd48847c 100644
--- a/accel/tcg/tcg-all.c
+++ b/accel/tcg/tcg-all.c
@@ -93,7 +93,8 @@ static int tcg_init_machine(MachineState *ms)
 # else
     bool mttcg_supported = false;
 # endif
-    if (s->mttcg_enabled == ON_OFF_AUTO_AUTO) {
+    switch (s->mttcg_enabled) {
+    case ON_OFF_AUTO_AUTO:
         /*
          * We default to false if we know other options have been enabled
          * which are currently incompatible with MTTCG. Otherwise when each
@@ -108,12 +109,22 @@ static int tcg_init_machine(MachineState *ms)
          */
         if (mttcg_supported && !icount_enabled()) {
             s->mttcg_enabled = ON_OFF_AUTO_ON;
+            max_threads = ms->smp.max_cpus;
         } else {
             s->mttcg_enabled = ON_OFF_AUTO_OFF;
         }
-    }
-    if (s->mttcg_enabled == ON_OFF_AUTO_ON) {
+        break;
+    case ON_OFF_AUTO_ON:
+        if (!mttcg_supported) {
+            warn_report("Guest not yet converted to MTTCG - "
+                        "you may get unexpected results");
+        }
         max_threads = ms->smp.max_cpus;
+        break;
+    case ON_OFF_AUTO_OFF:
+        break;
+    default:
+        g_assert_not_reached();
     }
 #endif
 
@@ -153,10 +164,6 @@ static void tcg_set_thread(Object *obj, const char *value, Error **errp)
         if (icount_enabled()) {
             error_setg(errp, "No MTTCG when icount is enabled");
         } else {
-#ifndef TARGET_SUPPORTS_MTTCG
-            warn_report("Guest not yet converted to MTTCG - "
-                        "you may get unexpected results");
-#endif
             s->mttcg_enabled = ON_OFF_AUTO_ON;
         }
     } else if (strcmp(value, "single") == 0) {
-- 
2.43.0


