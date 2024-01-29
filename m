Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92DADC47DB3
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 23:37:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUb68-0005gw-8J; Mon, 29 Jan 2024 18:31:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rUb5m-0005SD-6Z
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 18:31:09 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rUb5j-00051U-2P
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 18:31:04 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1d8d747a3bcso11454305ad.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 15:31:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706571062; x=1707175862; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P5Fsq2RX8/y2x9aiQTk6UToPX5ZjmTnnnnUS2+II2G4=;
 b=SeNa/NMfzeruYW+HVQUkavTTiKAuX4/52RZT3dQC3bqQ3kwe9gjkeZW8+STgZ/VnAU
 yfT4fYHu4IrS4qVO4t0lQW3qsZdvwlStsBhnnJ61omX2sweiBfJnQLoEaVGrDY2whEnH
 /jfmPWEYOt550d9VPg6tZHBxi14XCer+B3tDu0ZP4E52S2leIrDOSdM/3ZSi2lNAXk5j
 38RSFNN6AtK+W2ywL9KqoZZqURtEx3giLfsMHUuf4pcnQsOA4JMDYjYp8v9RQiB0Mbul
 /6AohlMuoTyEGSFwb2nRp76P3Vgw2JK6fNEysHxkfad5T0+6c1p16gB441attqCwGHHm
 wfQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706571062; x=1707175862;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P5Fsq2RX8/y2x9aiQTk6UToPX5ZjmTnnnnUS2+II2G4=;
 b=jeYZZSrXZ6uKdNgtVZiEB9IaCYfaGf/5D3OcuaJ6AuiDpoRUv3S2Lf8BKctjd49KmL
 wy85U1QMIZCAFC0xY4fnxtEqekVStMwk1/pUUY41o9FeG42Bkk2cGDByI2H28iYb0lEF
 Fk/k4IPt21QHLRzCAAx8U6g0dpLTWM4lr2wvs67OfnQ1bUivW/pirgzCSCMm70Vqxnf4
 mEISmQpFg9whQ+jPfQsiuz2bTuPV3QJZp7VwPTb/dPWh776rhedj2DlCaNuNbacyX4NN
 2BE/Jg4Mt8le0A/l6n1dBBKWgxcdk6vmhPx0wYreVKZgnc2MrWpoOyc89QdUp1c2d32G
 w1aQ==
X-Gm-Message-State: AOJu0Yw1ID0vBaJYX4X9QvpYjmwRW+QzSnq0qYiYaoUWtIx+Le7d/0ty
 RZ7CwxBpTCPW52IOeSOwQwd2QFsB0bCO+jXJDQz/cAl07eC+45MTW6VBIMOC/neKNPl47p3HUJX
 e9VY=
X-Google-Smtp-Source: AGHT+IFKvBwYZeNrXgyA6nQwPCuY+mjtHM79d8nnDUa7Zys/jNQGXgjayCwAev94250A6amC8zblLA==
X-Received: by 2002:a17:902:f691:b0:1d7:5c60:f4f5 with SMTP id
 l17-20020a170902f69100b001d75c60f4f5mr72001plg.16.1706571061697; 
 Mon, 29 Jan 2024 15:31:01 -0800 (PST)
Received: from stoup.. ([103.210.27.218]) by smtp.gmail.com with ESMTPSA id
 l6-20020a170902eb0600b001d8dbb867b1sm2710591plb.179.2024.01.29.15.30.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jan 2024 15:31:01 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	anjo@rev.ng
Subject: [PATCH 06/33] target/avr: Populate CPUClass.mmu_index
Date: Tue, 30 Jan 2024 09:30:16 +1000
Message-Id: <20240129233043.34558-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129233043.34558-1-richard.henderson@linaro.org>
References: <20240129233043.34558-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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
 target/avr/cpu.h | 4 +---
 target/avr/cpu.c | 6 ++++++
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/target/avr/cpu.h b/target/avr/cpu.h
index 7d5dd42575..4595c6bb18 100644
--- a/target/avr/cpu.h
+++ b/target/avr/cpu.h
@@ -184,9 +184,7 @@ static inline void set_avr_feature(CPUAVRState *env, int feature)
     env->features |= (1U << feature);
 }
 
-#define cpu_mmu_index avr_cpu_mmu_index
-
-static inline int avr_cpu_mmu_index(CPUAVRState *env, bool ifetch)
+static inline int cpu_mmu_index(CPUAVRState *env, bool ifetch)
 {
     return ifetch ? MMU_CODE_IDX : MMU_DATA_IDX;
 }
diff --git a/target/avr/cpu.c b/target/avr/cpu.c
index 1c68748b24..a40f445af2 100644
--- a/target/avr/cpu.c
+++ b/target/avr/cpu.c
@@ -50,6 +50,11 @@ static bool avr_cpu_has_work(CPUState *cs)
             && cpu_interrupts_enabled(env);
 }
 
+static int avr_cpu_mmu_index(CPUState *cs, bool ifetch)
+{
+    return ifetch ? MMU_CODE_IDX : MMU_DATA_IDX;
+}
+
 static void avr_cpu_synchronize_from_tb(CPUState *cs,
                                         const TranslationBlock *tb)
 {
@@ -236,6 +241,7 @@ static void avr_cpu_class_init(ObjectClass *oc, void *data)
     cc->class_by_name = avr_cpu_class_by_name;
 
     cc->has_work = avr_cpu_has_work;
+    cc->mmu_index = avr_cpu_mmu_index;
     cc->dump_state = avr_cpu_dump_state;
     cc->set_pc = avr_cpu_set_pc;
     cc->get_pc = avr_cpu_get_pc;
-- 
2.34.1


