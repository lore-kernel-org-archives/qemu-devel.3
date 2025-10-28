Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BAB6CCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 06:00:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDcl8-0000wY-JC; Tue, 28 Oct 2025 02:00:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDcl0-0000vC-3Z
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 02:00:35 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDckx-0005XD-Vs
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 02:00:33 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-475dd559a83so16435985e9.1
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 23:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761631229; x=1762236029; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SMVGGhuv+EE/XWA6EIDr/RcPSQYEZruS7kFfhc7sgP8=;
 b=GkuXCjV4evDmmaSOem4BukTpP9ws2b1qUarmR9jtnQeIu24JZMHog4bBlk5uLjNsGC
 ZwLgiwc5T+/q1kBmW5SsPohFRfC5on6eoquoEqZGImUqZ518A8axrae/ZedpMaAX3a2U
 mA+NoL3xYeydgKSkQJyXOQaSKNpFJ4YjHr51a0tzA6Qf3nynDdE9PGv7XlFR5PTCphHz
 4ooKk9/8HGWIJpGUGfgoFhcirX0m7d3WgEQv2yUHzhQSpKqzT3Od015heFSdDlrKDBiX
 ukhHV9VSU2tcBv1rmlKGODrMhaKJflUZwRri9Td4G4VBHpVsHkz5oCp3ebob2RGEGLnc
 tMUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761631229; x=1762236029;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SMVGGhuv+EE/XWA6EIDr/RcPSQYEZruS7kFfhc7sgP8=;
 b=WCDAXIy9DpDTJjCXQP+BFbgG3LaPSuUrafgOR7LwIllT33sX8C5nyb6tSGhH+1BY4P
 PSELecQcrI0ZqL49r/ZOOa1Rk7drU9+PFuLOBFREtjmrbXn9yz3JsN8CRu6mAK8R2HBr
 iwuvUr1g8zSBc2kpm7osyE8WN3riFqL6Utvp5fz4XWkdxQ1RJoIa3/i1ndFi6iJ/suk+
 o4B/rRbHq7vwPiJn2PjGyBCH6Vi3y54j0DmKnRL7y5X8EQrKKzcsppJ493m4tTYk4/K9
 b2Bt1Vss6uPt/FhdQB0lkOKZnNyghO3xpykCiHr6gr1WDiTM2UsLzKZKbymOSJIV2QQF
 5x0g==
X-Gm-Message-State: AOJu0YxeA2vT1GKITodcM3bKJUdfL5Z68ZuG/WxCMXu2XdvdphgTmMVZ
 iEJR5f+bG5fL9N8i2rysjK8F93/5lphW8PpeeG1fv8uPcGnHLzurJ9xpQhct3FhBSlA1fmEQl/c
 yE/NK29c=
X-Gm-Gg: ASbGnctv+Bj0O3u74gSffur0/gTz2hIezpuq7J5GaPwiRZUp4jumMexobJfRP3dtAn7
 u8vbEFNs8r48XdPDFPn/TznT2D16a3r4tZYwerEUljTJZpUxBfjd9ZwBjVwDogLEo50gXCplO1l
 533TU/TGGrYLJQFImHowfdl9QAXmiedTbVneop4WnqHpZbG/6dB07sQkaw56maK9ZEvpWwQfleF
 jemFJ1V6vLpksjpa9Ucob0jY3hfGlBEyQMPJ+4Gau6IIT7TwplmHUC4KMh5b1ZwzVco91VEnL5a
 ZdDf5HNHAuyGo22XTh5x8hPTIeqaTj902Xo7keubxp++JSmYXpPy8PLLAv2Btnsx5fGWkdL833M
 TgvXxs8nMRPHZkAR6siyzX4d37+RG3Wzf4OqsrRnpCoHuWVcgdS9u82qaBMhOroejVoHhUs5WFI
 MX+RFmO+Eb4DH+bfJB1nNTF4UX9EYJHMjSI0jArMXdF0L0oqunVi9LIJg=
X-Google-Smtp-Source: AGHT+IF3kDF5RwB3sViv6DTHlMR6a23Mx+XIxQHrKZgDkNqNKVT/dI1mRiDZKI+ljqDV/tXA6UGkiw==
X-Received: by 2002:a05:600c:848d:b0:471:16e5:6d7a with SMTP id
 5b1f17b1804b1-47717dff972mr14201915e9.13.1761631229212; 
 Mon, 27 Oct 2025 23:00:29 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475dd48a07dsm175051845e9.17.2025.10.27.23.00.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 27 Oct 2025 23:00:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mads Ynddal <mads@ynddal.dk>, Cameron Esfahani <dirty@apple.com>,
 qemu-arm@nongnu.org, Roman Bolshakov <rbolshakov@ddn.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Collingbourne <pcc@google.com>,
 Peter Maydell <peter.maydell@linaro.org>, Alexander Graf <agraf@csgraf.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 25/59] target/arm: Rename init_cpreg_list() ->
 arm_init_cpreg_list()
Date: Tue, 28 Oct 2025 06:42:01 +0100
Message-ID: <20251028054238.14949-26-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251028054238.14949-1-philmd@linaro.org>
References: <20251028054238.14949-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

Prefix init_cpreg_list() with 'arm_'.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/internals.h | 2 +-
 target/arm/cpu.c       | 2 +-
 target/arm/helper.c    | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index f86f421a3db..773c08d4f7c 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -376,7 +376,7 @@ static inline int r14_bank_number(int mode)
 void arm_cpu_register(const ARMCPUInfo *info);
 
 void register_cp_regs_for_features(ARMCPU *cpu);
-void init_cpreg_list(ARMCPU *cpu);
+void arm_init_cpreg_list(ARMCPU *cpu);
 
 void arm_cpu_register_gdb_regs_for_features(ARMCPU *cpu);
 void arm_translate_init(void);
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index d2fc17eab63..39292fb9bc1 100644
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
index 2ef9c178147..31bb3ce5172 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -252,7 +252,7 @@ static void count_cpreg(gpointer key, gpointer value, gpointer opaque)
     }
 }
 
-void init_cpreg_list(ARMCPU *cpu)
+void arm_init_cpreg_list(ARMCPU *cpu)
 {
     /*
      * Initialise the cpreg_tuples[] array based on the cp_regs hash.
-- 
2.51.0


