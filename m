Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6EFED78321
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 13:45:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI6Xv-0007yG-5Q; Mon, 02 Dec 2024 08:33:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tI6Gz-0002xO-6V
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 08:15:33 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tI6GY-0003O8-Kx
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 08:15:32 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-385de59c1a0so2908487f8f.2
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 05:14:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733145279; x=1733750079; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bcSQWPJxoEZ5kc/cEyAZreOowNhccL15M84TKXenqM8=;
 b=ufE9gu07u4hBlYTwM6ro/Qm9bYhR3BuzYPoAnfhh99VkBl42BZapp5Xb/L2947EmWB
 qiSPVHaTyy6uDmRJukQwkfQgObm6Ec1jIp6umBCCVxJ4AR0EOSGse/VU3kt0PZnHQVae
 paZqs6Uq9Z2PNAZm5usC/EDucOIu2UU/pK1t08npRA543/oikTQ6N5EH7ZFPISJHbl6M
 pdpMh0kH4yDLaIza4n/OwL3OFgkf3GuKYZ3sQ+fI+vQJuPEZtN3Csz4CFqdOO6hA/CoV
 qsCbDUxssjBBX+SI3KNlVaINKomfPSxeZ15+qsPFLJkRrBSLEdMWXQd134OuX1C4+9eB
 xYKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733145279; x=1733750079;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bcSQWPJxoEZ5kc/cEyAZreOowNhccL15M84TKXenqM8=;
 b=FzJz3aOfTPAlut1zhSI8LBg1CQADHOFnhg3/TmIA5I5lwuRCBunS+q/bqP+6oisU9N
 YtbjEbhYPvoyg5Qmb2yXMAruadAzOzayQ8Z4ikmxiUNNSEHT1VvVA5+MNzUhhXocDZUJ
 CLxlFiW3mFueBDTOVcgGOximNq8WBPEWKO0uccCDmHOjI3HoOcRWwaXsB0gDXOSE6tWu
 OBTd4CQMPdF4H/nSDWITZo+NavWSDdn9HZSDJIqQP9McUdLn6QoM+8QKNbRtYbBrQQAs
 LIfYmr4VxwYYYbw7FzcZuqKJKz5mDEZsMpgkCxUPimHR3BEo8LcE+rxuMuF7+kTbBesl
 VbSA==
X-Gm-Message-State: AOJu0Yy20NTX1/XoZK2NW7qrJCw/cxIrxlIKn/gAXaqI3934Qd54yZa2
 Ok1XWgdTkxhdWqPcwmqFethMTt/LPzaJhKtvqIQzrt3U61D5BZzrdx+tEXsSHcOJsq2etUWlI7U
 A
X-Gm-Gg: ASbGncuAlmQ5hTeU4wgq4CFHUMc55ZZ7zb8Jl7WlNUjTVtYL4qrDEnS9WtmOIt8PsOQ
 s35sco4CcqKVjB8ac90E6CpKyRG5y3xY6kapfiamFVlHG1KBtwm0dYf89qAqZi06CmFrPMqX5A8
 yJfKHL8LQUwKYEQ4jJ0FamXqV+cYhYbHo/oqh0FiT/J9+z4PGL2UyU7hZYukyTOonVv2lktA/l4
 L+X1JFT7JUO4htwbidAQHa4a/pLbIzT5pO7brrFybbGngTgfV3DFDY=
X-Google-Smtp-Source: AGHT+IHr1vI+MOZbtPkNYb3mNUy7gWjvLx38mjS4L3RplG6H9NCgwOtAH784x77t7dH5oedV37mDOA==
X-Received: by 2002:a5d:6d8e:0:b0:382:4b2a:4683 with SMTP id
 ffacd0b85a97d-385c6eb84c3mr21557497f8f.2.1733145278737; 
 Mon, 02 Dec 2024 05:14:38 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385dea1e4ebsm10160157f8f.1.2024.12.02.05.14.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Dec 2024 05:14:38 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v2 for-10.0 32/54] target/sparc: Initialize local scratch
 float_status from env->fp_status
Date: Mon,  2 Dec 2024 13:13:25 +0000
Message-Id: <20241202131347.498124-33-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241202131347.498124-1-peter.maydell@linaro.org>
References: <20241202131347.498124-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x429.google.com
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

In the helper functions flcmps and flcmpd we use a scratch float_status
so that we don't change the CPU state if the comparison raises any
floating point exception flags. Instead of zero-initializing this
scratch float_status, initialize it as a copy of env->fp_status. This
avoids the need to explicitly initialize settings like the NaN
propagation rule or others we might add to softfloat in future.

To do this we need to pass the CPU env pointer in to the helper.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/sparc/helper.h     | 4 ++--
 target/sparc/fop_helper.c | 8 ++++----
 target/sparc/translate.c  | 4 ++--
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/target/sparc/helper.h b/target/sparc/helper.h
index 134e519a377..1ae3f0c467d 100644
--- a/target/sparc/helper.h
+++ b/target/sparc/helper.h
@@ -51,8 +51,8 @@ DEF_HELPER_FLAGS_3(fcmpd, TCG_CALL_NO_WG, i32, env, f64, f64)
 DEF_HELPER_FLAGS_3(fcmped, TCG_CALL_NO_WG, i32, env, f64, f64)
 DEF_HELPER_FLAGS_3(fcmpq, TCG_CALL_NO_WG, i32, env, i128, i128)
 DEF_HELPER_FLAGS_3(fcmpeq, TCG_CALL_NO_WG, i32, env, i128, i128)
-DEF_HELPER_FLAGS_2(flcmps, TCG_CALL_NO_RWG_SE, i32, f32, f32)
-DEF_HELPER_FLAGS_2(flcmpd, TCG_CALL_NO_RWG_SE, i32, f64, f64)
+DEF_HELPER_FLAGS_3(flcmps, TCG_CALL_NO_RWG_SE, i32, env, f32, f32)
+DEF_HELPER_FLAGS_3(flcmpd, TCG_CALL_NO_RWG_SE, i32, env, f64, f64)
 DEF_HELPER_2(raise_exception, noreturn, env, int)
 
 DEF_HELPER_FLAGS_3(faddd, TCG_CALL_NO_WG, f64, env, f64, f64)
diff --git a/target/sparc/fop_helper.c b/target/sparc/fop_helper.c
index 6f9ccc008a0..236d27b19c1 100644
--- a/target/sparc/fop_helper.c
+++ b/target/sparc/fop_helper.c
@@ -490,13 +490,13 @@ uint32_t helper_fcmpeq(CPUSPARCState *env, Int128 src1, Int128 src2)
     return finish_fcmp(env, r, GETPC());
 }
 
-uint32_t helper_flcmps(float32 src1, float32 src2)
+uint32_t helper_flcmps(CPUSPARCState *env, float32 src1, float32 src2)
 {
     /*
      * FLCMP never raises an exception nor modifies any FSR fields.
      * Perform the comparison with a dummy fp environment.
      */
-    float_status discard = { };
+    float_status discard = env->fp_status;
     FloatRelation r;
 
     set_float_2nan_prop_rule(float_2nan_prop_s_ba, &discard);
@@ -518,9 +518,9 @@ uint32_t helper_flcmps(float32 src1, float32 src2)
     g_assert_not_reached();
 }
 
-uint32_t helper_flcmpd(float64 src1, float64 src2)
+uint32_t helper_flcmpd(CPUSPARCState *env, float64 src1, float64 src2)
 {
-    float_status discard = { };
+    float_status discard = env->fp_status;
     FloatRelation r;
 
     set_float_2nan_prop_rule(float_2nan_prop_s_ba, &discard);
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index cdd0a95c03d..322319a1288 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -5584,7 +5584,7 @@ static bool trans_FLCMPs(DisasContext *dc, arg_FLCMPs *a)
 
     src1 = gen_load_fpr_F(dc, a->rs1);
     src2 = gen_load_fpr_F(dc, a->rs2);
-    gen_helper_flcmps(cpu_fcc[a->cc], src1, src2);
+    gen_helper_flcmps(cpu_fcc[a->cc], tcg_env, src1, src2);
     return advance_pc(dc);
 }
 
@@ -5601,7 +5601,7 @@ static bool trans_FLCMPd(DisasContext *dc, arg_FLCMPd *a)
 
     src1 = gen_load_fpr_D(dc, a->rs1);
     src2 = gen_load_fpr_D(dc, a->rs2);
-    gen_helper_flcmpd(cpu_fcc[a->cc], src1, src2);
+    gen_helper_flcmpd(cpu_fcc[a->cc], tcg_env, src1, src2);
     return advance_pc(dc);
 }
 
-- 
2.34.1


