Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF290CA1010
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 10:11:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utkSC-0006vo-CE; Wed, 03 Sep 2025 06:11:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utkRa-0006Pl-AQ
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 06:10:37 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utkRX-0000Tm-IF
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 06:10:21 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-45cb659e858so2762975e9.2
 for <qemu-devel@nongnu.org>; Wed, 03 Sep 2025 03:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756894216; x=1757499016; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0fUgWLFNyRj4U87Ya1zFrmdpfoNfLiPoZL+nODXkG4k=;
 b=LS1qcCS/JSJ29D20UqRp+GY6a9L+r8G1Tdhi3B4gvwXUiDM2+1DMVY6Joal0We4e0z
 1tZh39yZNHKcCJ815zeP4JESJWPVVWNU5bD1ITsHuk5o3bjQK27nofLfZViM/8egOmC/
 kpDrN5bc3Q7yCALEs/prKJ5jY9gyor86fQyEAP5r4skYQ+/tQenELl82LBZ4lXyDKUJJ
 fS+FC+rkXVGxTU6rhVjxksvsuPEz+ECyf/iKmHiZuSSYjZDTSebwUAWtoViuVIYDDcBO
 mL5XwFZ8+/x1jYav5wc8R5sCmL0FgDEBanQpJmzORVc6Csb37r2T9Db+Tvj8PrNqIjMi
 +PYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756894216; x=1757499016;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0fUgWLFNyRj4U87Ya1zFrmdpfoNfLiPoZL+nODXkG4k=;
 b=ZpvSCc6htLF2SiEHU53o69yfOBlztNcI2ctZkovar7/WAzZU8yG4WlXPaJCpiXWmF7
 ITOEr+ItWZuUweEeVJb2RU+X3VRBa/TbaH+0decplSgAPeCD3AEBSWF4fzraJJ8oezXV
 l+xXfQvoQ9T5VqTcmC0KoBotaIHM043AmcFao7cnp9i/y0ozxg0ww94kEICQL+sYaOl8
 lbFdTZaDSWM3JZzrRd8lw+GZSwHa+NkdHzroeqQpVucB1lO7Io5NkIT3rsAHwUBSWwyh
 TEeQqacjEb9BqoG7cc4cLa26F7MCgGj84TZSUvRFnq5FQp5k5w9y1vPmzgg4Ci2UV9ME
 cMTg==
X-Gm-Message-State: AOJu0Yxrmgw1/+iMsxd7we14DFrSWN8KWLLV0VymF7IsfPdLYrWx838c
 yEN3Un5PJ9RgjZOBlDyr0q/XX10bhxX+wo1EznryaN5Swmlqqcb5JOIZwPXI3QxLKWfpIoLo871
 qaKKAzo1iDQ==
X-Gm-Gg: ASbGncsd+QmKPhX6TwA/s835cwyby3wJXkzfyZ7JJCejjPnLW37f4sh6N1Um6wCrD80
 iglweMny3y+nyzbxmCPGA5NQNuDxupMevp+KEh4gygmkdlg8njMb9rMKu841xrfQZlUPiJ0maqv
 mkxMtAXzkX7vJ8dO4QoQ6hlXHx10pVMNK36AqTPhvDufuXmSwAQrX1RwJ0sTXg7lCxktTRsex43
 NT9J1SUaMfKyAtJOfeDShmRPRKYi5p+eB7bdvHQRG6DuuM6/29By1ct7YC39yy1j02cVj3lFzYm
 byd0AX+9f2TN4VrtcuM1tjXBFn89dLvoexcVzTVj1b9k39VNu58jp0TafBE3IZUbcyws/AA4STE
 IOD/kaTbQ3bZ8ON940Za/lyd8aGR5oExor3XrtUSMvPgLrJdkE+XcTvy5AL4Ap5/bAtggwNGEel
 xxcqWsmw==
X-Google-Smtp-Source: AGHT+IGOhuq0u3nwM5iPLA36iAloZif9a/HS2UIgkB042U+7dAVQ7RbjlGPc6pyL/tEF6RfdU7N2Aw==
X-Received: by 2002:a05:600c:4ecc:b0:459:da89:b06 with SMTP id
 5b1f17b1804b1-45b8555b390mr145082195e9.16.1756894216308; 
 Wed, 03 Sep 2025 03:10:16 -0700 (PDT)
Received: from localhost.localdomain (98.red-88-29-180.dynamicip.rima-tde.net.
 [88.29.180.98]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3cf33fba9fbsm23082809f8f.50.2025.09.03.03.10.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 03 Sep 2025 03:10:15 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexander Graf <agraf@csgraf.de>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>, Mads Ynddal <mads@ynddal.dk>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cameron Esfahani <dirty@apple.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 23/24] target/arm: Rename init_cpreg_list() ->
 arm_init_cpreg_list()
Date: Wed,  3 Sep 2025 12:06:59 +0200
Message-ID: <20250903100702.16726-24-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250903100702.16726-1-philmd@linaro.org>
References: <20250903100702.16726-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

Prefix init_cpreg_list() with 'arm_'.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/internals.h | 2 +-
 target/arm/cpu.c       | 2 +-
 target/arm/helper.c    | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index f0aa26c5117..400b4d670f6 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -374,7 +374,7 @@ static inline int r14_bank_number(int mode)
 void arm_cpu_register(const ARMCPUInfo *info);
 
 void register_cp_regs_for_features(ARMCPU *cpu);
-void init_cpreg_list(ARMCPU *cpu);
+void arm_init_cpreg_list(ARMCPU *cpu);
 
 void arm_cpu_register_gdb_regs_for_features(ARMCPU *cpu);
 void arm_translate_init(void);
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 633ec55a57c..1789890dea3 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2141,7 +2141,7 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
     arm_cpu_register_gdb_regs_for_features(cpu);
     arm_cpu_register_gdb_commands(cpu);
 
-    init_cpreg_list(cpu);
+    arm_init_cpreg_list(cpu);
 
 #ifndef CONFIG_USER_ONLY
     MachineState *ms = MACHINE(qdev_get_machine());
diff --git a/target/arm/helper.c b/target/arm/helper.c
index fb62742d983..0db3e05571f 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -237,7 +237,7 @@ static gint cpreg_key_compare(gconstpointer a, gconstpointer b, gpointer d)
     return 0;
 }
 
-void init_cpreg_list(ARMCPU *cpu)
+void arm_init_cpreg_list(ARMCPU *cpu)
 {
     /*
      * Initialise the cpreg_tuples[] array based on the cp_regs hash.
-- 
2.51.0


