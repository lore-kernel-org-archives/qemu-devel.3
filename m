Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A1CEC47DA9
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 23:37:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUb67-0005fi-B9; Mon, 29 Jan 2024 18:31:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rUb5r-0005So-M0
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 18:31:22 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rUb5p-000529-UY
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 18:31:11 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1d8f3acc758so7337685ad.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 15:31:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706571068; x=1707175868; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZpWWy5vO/pXMstRanLNjNwO63iDqbDF9cuw2FeN4mjg=;
 b=LbLWACt3f7PeEdqa69AC7wFVT/2MrOjH3h5RlEtsZur7Eyi1n3Gzr1CnlCKwDw+QjP
 xX3Y0qElRTKViQPHTV1PulLSmPFD+crH/Gom1zhfs3DBVg2kXOoISecz9tq8ZpKaFZFU
 2Yb0dW+likUOarWFLJer5GwZzKShVAtuzuWyH7LJv6wDGgRaQvlJglb8Wr1oO5LkyEb/
 NSEuXkvnmEcHjornW+yL8wb6ew2joH4mwGT6Bt9SkuzOzdUiESReSY1UyVNFL9qfWbzn
 aUj8623yOfIT7pAr6sI0ncj0i7NgWAYzBYAQTLrN31wT0+7fVJaZdYnk6evIo4kP98QE
 VybQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706571068; x=1707175868;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZpWWy5vO/pXMstRanLNjNwO63iDqbDF9cuw2FeN4mjg=;
 b=pWgWnnFO3bezoEEgTBGA6E0e1Zwv8dj+WzFYIMcmBfclCBCitw/7PRJ7PUV3uFLdN+
 46inqlUq7JHkNOgFRIkmeyXqgwTY1R2lY58h19KgNsLLsjoeY9SdCVs6DvpVAD2VwcTU
 FW1OaGdQEXM79dl87jbOsJKQaC6tsjWGNnIaVTb6bRcLf19mpGjixOolHd4qOIvctOgM
 OC/7Dc5h0Wpn4osshcm3rztKmBDUmPBk8BE8/NLeKXiRRCEgdyL4EHdnamIBmPoWex3B
 HPccnWpwZjAnmSc14e3z1dMauGD0X+ZwDsoaTF2qPGYZac1yJSMFvb+Q8XBdpmC4+hjJ
 zxXQ==
X-Gm-Message-State: AOJu0Yx39nRS+UfW06KZWdez5wrMU4HS6pY1pqLjoR+YDLyxiy2W5iav
 54KCbiq7OJy7C/fOVApLdnVYlHeJTu+ElDj9MI7qnMDryWmdABm95NI7JJ9Y5/aHVL3f//F+HnM
 LeBE=
X-Google-Smtp-Source: AGHT+IGQ4Pbqe896uKMR+Qwx6VCHa3hiugDB9DqJDidghEGTVRHbvarISi1sPusAgbBAbb3xZaxgWQ==
X-Received: by 2002:a17:902:650f:b0:1d8:c767:d82d with SMTP id
 b15-20020a170902650f00b001d8c767d82dmr62066plk.17.1706571068579; 
 Mon, 29 Jan 2024 15:31:08 -0800 (PST)
Received: from stoup.. ([103.210.27.218]) by smtp.gmail.com with ESMTPSA id
 l6-20020a170902eb0600b001d8dbb867b1sm2710591plb.179.2024.01.29.15.31.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jan 2024 15:31:08 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	anjo@rev.ng
Subject: [PATCH 09/33] target/hppa: Populate CPUClass.mmu_index
Date: Tue, 30 Jan 2024 09:30:19 +1000
Message-Id: <20240129233043.34558-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129233043.34558-1-richard.henderson@linaro.org>
References: <20240129233043.34558-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
 target/hppa/cpu.h |  7 ++-----
 target/hppa/cpu.c | 12 ++++++++++++
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index 6a153405d2..04439f247d 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -281,16 +281,13 @@ static inline int HPPA_BTLB_ENTRIES(CPUHPPAState *env)
     return hppa_is_pa20(env) ? 0 : PA10_BTLB_FIXED + PA10_BTLB_VARIABLE;
 }
 
+int hppa_cpu_mmu_index(CPUState *cs, bool ifetch);
 static inline int cpu_mmu_index(CPUHPPAState *env, bool ifetch)
 {
 #ifdef CONFIG_USER_ONLY
     return MMU_USER_IDX;
 #else
-    if (env->psw & (ifetch ? PSW_C : PSW_D)) {
-        return PRIV_P_TO_MMU_IDX(env->iaoq_f & 3, env->psw & PSW_P);
-    }
-    /* mmu disabled */
-    return env->psw & PSW_W ? MMU_ABS_W_IDX : MMU_ABS_IDX;
+    return hppa_cpu_mmu_index(env_cpu(env), ifetch);
 #endif
 }
 
diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index 3c019855b4..fbb37e541e 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -94,6 +94,17 @@ static bool hppa_cpu_has_work(CPUState *cs)
     return cs->interrupt_request & (CPU_INTERRUPT_HARD | CPU_INTERRUPT_NMI);
 }
 
+int hppa_cpu_mmu_index(CPUState *cs, bool ifetch)
+{
+    CPUHPPAState *env = cpu_env(cs);
+
+    if (env->psw & (ifetch ? PSW_C : PSW_D)) {
+        return PRIV_P_TO_MMU_IDX(env->iaoq_f & 3, env->psw & PSW_P);
+    }
+    /* mmu disabled */
+    return env->psw & PSW_W ? MMU_ABS_W_IDX : MMU_ABS_IDX;
+}
+
 static void hppa_cpu_disas_set_info(CPUState *cs, disassemble_info *info)
 {
     info->mach = bfd_mach_hppa20;
@@ -194,6 +205,7 @@ static void hppa_cpu_class_init(ObjectClass *oc, void *data)
 
     cc->class_by_name = hppa_cpu_class_by_name;
     cc->has_work = hppa_cpu_has_work;
+    cc->mmu_index = hppa_cpu_mmu_index;
     cc->dump_state = hppa_cpu_dump_state;
     cc->set_pc = hppa_cpu_set_pc;
     cc->get_pc = hppa_cpu_get_pc;
-- 
2.34.1


