Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FBC7C7115B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Jun 2025 13:18:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSF5H-0003Y3-83; Thu, 19 Jun 2025 09:13:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSF5F-0003X6-5Z
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 09:13:37 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSF5D-0003ra-J2
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 09:13:36 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-45348bff79fso9528465e9.2
 for <qemu-devel@nongnu.org>; Thu, 19 Jun 2025 06:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750338814; x=1750943614; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=njVumrb22osQKhmYAguxSrlkLoqT+wPkHlSnrsTIoAI=;
 b=MGKrNRTwee0OFOgXSDX30+ZpBuA9OD8xA3Y0+tfhEwXseR5Q55DB2NG8ZFcxfhxct4
 qLCLbaWP2Ob4ptLuVkRK9pFGOdAiYYyMTlK4x2FZ7qq4CHW1rsZpGZbjhf7iah/io5zO
 fjay8FnnKyNio2AkcI58WI7kfoq815qxPb8jydDVAz7+5oCVwdtwdw37m75sgoRIbfA2
 GKBfvPWtAZhMvxY+2dd4IrHtL2EZVqBpuod13wcCr1A+ggxZV2LGQFrXFS67suQUWCYf
 ejx03puWvFTmgEEFSjilB5kzif4DCWqub98PgTx2h/qfwhpUAVSxPrpa7MJNKT5BGUqG
 BZsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750338814; x=1750943614;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=njVumrb22osQKhmYAguxSrlkLoqT+wPkHlSnrsTIoAI=;
 b=dGWoqC8f6op8VgExximu2hylZHWuSlO0w7piOu1jT3v79X+7boM2QIzecLZTlkaxji
 EHweLgfpaf8OLkFunaMFbfAczHluQ4/hccFywIbrXgoqxH9bDfCEUjteGyiLVOEkLnGm
 snka3Tqdp0qpVa6nRoxTBe8Bab7VYAJpda69pqMgXuP+qPjteyzvQc5KpvMaCXu1+mmU
 d2W3w7cxjGgF6sKNVGhxUlKhk8jHUxlrJYdTUUZbV5wx6V8B/pcf80FXuvmSmnuVqYEz
 ghUKM0mdtspRv17GT0F/DAwB7SdRYWWWAQOkaYCPw0deVOBUoYnFoLTDb4F2Axf1/DJD
 /D3A==
X-Gm-Message-State: AOJu0YyTrHs2vjBOUrPB0oG8HagJS5c59WwkZ8EFDBnAkqZHVta5fZcB
 yi5PMN4Jvuu4nOe00NCEvpQx7eOkBdQOO0TKqJHtCJNQXfPBTruqkbpThsyJ34E3C7WOL7NeQPv
 XVsl/hyk=
X-Gm-Gg: ASbGncvYa9VxA/ypzYmJjLZnribseHW3saw5+mpUliXVAmTxIxQmvgzENtC4wmRaYGn
 gi/D/QjzP3Wuytp5KCN/DfyfQWk1wpHIMWeeadm/3Mkq1icCp3nHA7KKAdhQ9XoAVoYGrdKz1Xy
 DXqc5iFL7prLZOYpPNbw1AK7z7GWmxLB1tq+CilwGYnCAGTKYcVbhGgCuxNRO7X/5Joi7Qt26xy
 ro8vgI7AdTMaInVdi29OkhO63VxGVikPDAZIjCj4ITftrr5LJ+vVyNjLygKsUzyRXHMG4Nv/8Bo
 LlMAJCM3NTCXU4g4Q8c7ny97zpM53epYiPlT5yNyaNqoWSPeraZanACtXC8Twvl34RG/YYCilQ4
 WoAfr4CNSUy4/mX3/ONuznL5AipAc3MCRg7Gk
X-Google-Smtp-Source: AGHT+IGHJFjSXSFKOe1Y20YU1PJNu67FjETa65TJxweZU1CKSra6h9mGTRAvKIyXP6ctcKvZdSxHTA==
X-Received: by 2002:a05:6000:3112:b0:3a4:e480:b5df with SMTP id
 ffacd0b85a97d-3a572e79749mr18776507f8f.44.1750338813836; 
 Thu, 19 Jun 2025 06:13:33 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4536366326fsm2312615e9.38.2025.06.19.06.13.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Jun 2025 06:13:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Cameron Esfahani <dirty@apple.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Leif Lindholm <leif.lindholm@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Roman Bolshakov <rbolshakov@ddn.com>, Alexander Graf <agraf@csgraf.de>
Subject: [PATCH 02/20] target/arm: Reduce arm_cpu_post_init() declaration scope
Date: Thu, 19 Jun 2025 15:13:01 +0200
Message-ID: <20250619131319.47301-3-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250619131319.47301-1-philmd@linaro.org>
References: <20250619131319.47301-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

arm_cpu_post_init() is only used within the same file unit.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/cpu.h | 2 --
 target/arm/cpu.c | 2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 302c24e2324..c31f69912b8 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1150,8 +1150,6 @@ void arm_gt_sel2vtimer_cb(void *opaque);
 unsigned int gt_cntfrq_period_ns(ARMCPU *cpu);
 void gt_rme_post_el_change(ARMCPU *cpu, void *opaque);
 
-void arm_cpu_post_init(Object *obj);
-
 #define ARM_AFF0_SHIFT 0
 #define ARM_AFF0_MASK  (0xFFULL << ARM_AFF0_SHIFT)
 #define ARM_AFF1_SHIFT 8
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index e025e241eda..eb0639de719 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1713,7 +1713,7 @@ static void arm_cpu_propagate_feature_implications(ARMCPU *cpu)
     }
 }
 
-void arm_cpu_post_init(Object *obj)
+static void arm_cpu_post_init(Object *obj)
 {
     ARMCPU *cpu = ARM_CPU(obj);
 
-- 
2.49.0


