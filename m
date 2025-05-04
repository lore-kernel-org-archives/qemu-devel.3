Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EB21C3ABB0
	for <qemu-devel@archiver.kernel.org>; Sun,  4 May 2025 20:58:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBgOz-0008Qk-Nx; Sun, 04 May 2025 16:57:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uBgOq-0008Mw-K4
 for qemu-devel@nongnu.org; Sun, 04 May 2025 16:57:25 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uBgOo-0006wW-M6
 for qemu-devel@nongnu.org; Sun, 04 May 2025 16:57:24 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-af908bb32fdso3246522a12.1
 for <qemu-devel@nongnu.org>; Sun, 04 May 2025 13:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746392240; x=1746997040; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aPY0PoTn2GLTyVD137nu2Bjal+slOFwG2h9vUM4KmIE=;
 b=F4R5JOxtbpfF7ypBcQrHJtAKLbtLwN0W7V3t9iVv0ToAyOR8Nyyb/gnDWFpD24Z4hA
 9fP6irSGeqCK+07eM5Waig2RC0+MEk8so5Dd5CeiJawaRnCpZ62g8PY/zcMAmRroa2lW
 v9Pts5wVMU6gFYFO0amMlgOL6JJnG8zIbAcO45gmUZSjaYMNFUxa/e32IWR8pNu4vJcb
 msWnj291FcMxlVVMY7egKBlZSQwStuWsc0mBfwOmhEvSpUQ1pVIcrd01UG0Lgs8j2mr2
 MugRIn8v/l1x39ZvjcVRhA8U1o8Pk4PasJZshy+JrktOdiNJ/+WWD+zH9wRq+oleilPn
 5q6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746392240; x=1746997040;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aPY0PoTn2GLTyVD137nu2Bjal+slOFwG2h9vUM4KmIE=;
 b=j3YbRu7qJQhXvZCFYF4ohKBVONlyfSc+hpClBDasXcM4qfs0sfYzol1yr4HrbXaFUW
 G3zN6j5jyYaOFxtq+me6iug6/PvZuFkB9nhhv5Nhe33PpPLIDZPifL6vt67+Vkqboluh
 CrWR4xb9t/FEgwgSgbjppgyzxLjn6Ruz5soYUB8BejEVcm+31N9Hfuv/RMDJJgjuPhlY
 wKBDADuJRoYpLVszrSpqsufDgNc53KFWCU6n7gc8FfVnJSCUMfFsJxEAGyttkV9275Cd
 h5kUF6KpgmVCG6aEgjnhPVWUHrcZF7/6UnhtRJyehguwPFA7reih29M/qPzgXVoiQaIM
 Y3kA==
X-Gm-Message-State: AOJu0YxcOnOGSfNSyXWlVEBkZcMl8KxnxOVd+jS4SacsyBoQy7N5B/0y
 PMA/pSERNKk9SrGV7lgjM6V5uwS2OAW9eHD9DGgG30fRnSC8kd3u58Y0mv6j8TFhgLbCqpd+tFs
 w
X-Gm-Gg: ASbGncsV7an4bGkZ3/AxJr3MtNZX4y9AawgPKN8HB/9YMqd6pTEJVs+M/uaolaode9C
 lWiiohr7AjZbNynT5e5MHGgPF4dfAbEs9j2y/hKEesTA4N/cMuMNdro+7VVLyOMdUu4QZzsRklC
 tSXFdEsm7VyAOekV6q/XnKiBYA9ZxYA78ITv2A5h4wommkF9HNHcsC0NkU0SDRfBseEoUbppXBl
 3PjwYAoJieHEOIiNcJd47UadVXky4vYSqA/hcmVCgT6xsmR++8u2rE7NbySgCctO1ndv1Lnq1xa
 OiycHgeAgKKCe2Wn/bpvBO8eiTuOhOxp3oBaGPRp/qPa4WCb6Z7oLnyg4v1runNJ1NBs9n5rIqM
 =
X-Google-Smtp-Source: AGHT+IHtEV4aEFP/ycyCWsqtyMtfmjyx0ab1ESgtGmpHjBebBxC1B/dVJz2sc81K4j3b3VEH2xmveA==
X-Received: by 2002:a17:903:40d0:b0:216:4676:dfb5 with SMTP id
 d9443c01a7336-22e100b7209mr173665005ad.21.1746392240567; 
 Sun, 04 May 2025 13:57:20 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e150eadfcsm41346425ad.32.2025.05.04.13.57.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 May 2025 13:57:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: foss@percivaleng.com, Song Gao <gaosong@loongson.cn>,
 Bibo Mao <maobibo@loongson.cn>
Subject: [PATCH 06/12] target/loongarch: Fill in TCGCPUOps.pointer_wrap
Date: Sun,  4 May 2025 13:57:07 -0700
Message-ID: <20250504205714.3432096-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250504205714.3432096-1-richard.henderson@linaro.org>
References: <20250504205714.3432096-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x530.google.com
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

Check va32 state.

Cc: Song Gao <gaosong@loongson.cn>
Cc: Bibo Mao <maobibo@loongson.cn>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/loongarch/cpu.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index f7535d1be7..abad84c054 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -334,6 +334,12 @@ static bool loongarch_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
     }
     return false;
 }
+
+static vaddr loongarch_pointer_wrap(CPUState *cs, int mmu_idx,
+                                    vaddr result, vaddr base)
+{
+    return is_va32(cpu_env(cs)) ? (uint32_t)result : result;
+}
 #endif
 
 static TCGTBCPUState loongarch_get_tb_cpu_state(CPUState *cs)
@@ -889,6 +895,7 @@ static const TCGCPUOps loongarch_tcg_ops = {
 
 #ifndef CONFIG_USER_ONLY
     .tlb_fill = loongarch_cpu_tlb_fill,
+    .pointer_wrap = loongarch_pointer_wrap,
     .cpu_exec_interrupt = loongarch_cpu_exec_interrupt,
     .cpu_exec_halt = loongarch_cpu_has_work,
     .cpu_exec_reset = cpu_reset,
-- 
2.43.0


