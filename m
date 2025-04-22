Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABE87C369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 20:06:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7JQ9-0008QF-Lh; Tue, 22 Apr 2025 15:36:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JOu-00056a-4m
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:35:29 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JOq-00071a-BY
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:35:22 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-224191d92e4so55774285ad.3
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 12:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745350517; x=1745955317; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wTTbJUYSutthRAHWERBfaY61+pWxicGlAYRiaD9+MBo=;
 b=JGp1UPR5fuVG0BgFgXe8uCm5cwUZgggBydyYsfxu/W4y03k7ZAAMwUkwpDnl1dknIN
 X2vDn0tt3oi7fchVWrSNi8/tE2v4sauzz/kna1yFU4x962UFmhvXVokd+Khil5SJ6VGf
 evwX5iQ6r2ae3rDZq2BuLz8cqBpIasDsC1ZQFDRzr/OPoDAYbi39WaTNl3l2oEtHidYP
 tHR6cr10kxZQwhNVCKiyoOmpTTaR8Izm4T0rkRMZBH6flMFNPdii2ZubO9JdfaLrfWJ7
 XQGteDn29gZSvzO5mU1y8mzCH9FCC9cp5BOkSJRzGFSGnoucKlrf4/6k/XFuuEX8vWVe
 V49A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745350517; x=1745955317;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wTTbJUYSutthRAHWERBfaY61+pWxicGlAYRiaD9+MBo=;
 b=bmMlsPFgb8feTJy28XBfPcaXnZ1mR6yEc4RKU29D4XNBCb7iHzR/ytfVt0eHhZ13VH
 wPe2zBX9fJYf7mDp8BZYEaMFfexVrhoxp3jf1ux9y1BNSsugZT5Cn/VKkldRFS7Vc1Pz
 2pYMfJTXGF/ECerfHn+Wmux3ebQGnloUbjWVuEyvu8RuB4vHsNvgY3Rh2ryrWZW2yLA5
 YMWsq6R0E7CxOX3dyu7aRB8ZD7bvvpqKYgDoP19BFXPLD0PsFHWrO4mHJeUfD5sNQuDg
 OYPCy+9nfvvO++Ao27bQHr4JtDPWqZeXzx18uz48ouCLpHKEpj3q1B/sWBUdb30fDrxT
 9niw==
X-Gm-Message-State: AOJu0Yx3JfwpaOeEjNvtiwkgJeerf10kDChgsNVVgPW5Amo7vfYq9MU3
 GMiPFBLQAzeW1UucJoS/GOdkC+d89IwyaXaUyEVvTqRYtnvurC35nR4qoUb9yUwxz4Lb/O9pYN7
 l
X-Gm-Gg: ASbGncuS2zpRtMHtvf+Uk2+XBJHQSVlmJ0FU+neOtcMpG0rEM2tM1KTYj1WRazs/DJi
 m5Fo341CVZj94dWRxROgMtcmqYZ190VbBcB4H9xRohfu6F3Y5HYdM6gMBYPq9L0WZaaDj3urDfG
 jwCGEU0NjX1dgqsuJj/TmMbXAIes0TNt7n0Wckg/C6fDawE7fF9/8JaMaCVYQFpc3DN3ZQajJ1S
 r3pe9T5e0/S67tlVhKWNnqPPamGoPXldw6YsqsfivAQ/0ECSx8urxo4EOTol4zTkdWp924DloC+
 SWIglZB471gf0PRYhJnabcRgX/5DbNGcIpjFwfDsEq6YnqPxeE6usFPLCPzr+dsqOrw49BHwEc4
 =
X-Google-Smtp-Source: AGHT+IEN79ZnpXd2WZW7/CzCrQkflbbXtTzueXTzCs/wdF0KezWejwERUMQ0tNOjK7obHYuugMgF4A==
X-Received: by 2002:a17:902:ce01:b0:223:569d:9a8b with SMTP id
 d9443c01a7336-22c53580d1dmr207953245ad.18.1745350517215; 
 Tue, 22 Apr 2025 12:35:17 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50fdf1f1sm88996795ad.237.2025.04.22.12.35.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 12:35:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 086/147] target/ppc: Restrict SoftMMU mmu_index() to TCG
Date: Tue, 22 Apr 2025 12:27:15 -0700
Message-ID: <20250422192819.302784-87-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250422192819.302784-1-richard.henderson@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Convert CPUClass::mmu_index() to TCGCPUOps::mmu_index(),
restricting ppc_cpu_mmu_index() to TCG #ifdef.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250401080938.32278-16-philmd@linaro.org>
---
 target/ppc/cpu_init.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 17f0f3d3ff..fd8c42069e 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -7216,6 +7216,11 @@ static void ppc_restore_state_to_opc(CPUState *cs,
 
     cpu->env.nip = data[0];
 }
+
+static int ppc_cpu_mmu_index(CPUState *cs, bool ifetch)
+{
+    return ppc_env_mmu_index(cpu_env(cs), ifetch);
+}
 #endif /* CONFIG_TCG */
 
 #ifndef CONFIG_USER_ONLY
@@ -7225,11 +7230,6 @@ static bool ppc_cpu_has_work(CPUState *cs)
 }
 #endif /* !CONFIG_USER_ONLY */
 
-static int ppc_cpu_mmu_index(CPUState *cs, bool ifetch)
-{
-    return ppc_env_mmu_index(cpu_env(cs), ifetch);
-}
-
 static void ppc_cpu_reset_hold(Object *obj, ResetType type)
 {
     CPUState *cs = CPU(obj);
@@ -7482,6 +7482,7 @@ static const TCGCPUOps ppc_tcg_ops = {
   .initialize = ppc_translate_init,
   .translate_code = ppc_translate_code,
   .restore_state_to_opc = ppc_restore_state_to_opc,
+  .mmu_index = ppc_cpu_mmu_index,
 
 #ifdef CONFIG_USER_ONLY
   .record_sigsegv = ppc_cpu_record_sigsegv,
@@ -7518,7 +7519,6 @@ static void ppc_cpu_class_init(ObjectClass *oc, void *data)
                                        &pcc->parent_phases);
 
     cc->class_by_name = ppc_cpu_class_by_name;
-    cc->mmu_index = ppc_cpu_mmu_index;
     cc->dump_state = ppc_cpu_dump_state;
     cc->set_pc = ppc_cpu_set_pc;
     cc->get_pc = ppc_cpu_get_pc;
-- 
2.43.0


