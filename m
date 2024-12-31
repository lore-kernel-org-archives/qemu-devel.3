Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E47E0E77188
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2024 19:08:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tShZz-0004SE-06; Tue, 31 Dec 2024 14:06:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tShZv-0004Rd-QF
 for qemu-devel@nongnu.org; Tue, 31 Dec 2024 14:06:56 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tShZu-00085d-5s
 for qemu-devel@nongnu.org; Tue, 31 Dec 2024 14:06:55 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-38633b5dbcfso9925655f8f.2
 for <qemu-devel@nongnu.org>; Tue, 31 Dec 2024 11:06:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735672012; x=1736276812; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LT79yJT21rJPtnu6Fd4xIWi2kLyEAZ71iOLyoGT2BAA=;
 b=NfZFKMBMwjNhE2wnhoaulW14pvrSfT83w4EpMADxILOqrfyqlb+3ykg8x8KQ3WnsR3
 Ml5VOK2IfTuTeaW2APyHY0dKeVlEfVCEJr7heXX9eKRKmsEarvbO2KE9zgqMOP1wCcKV
 Wn8NFungBAl9EebW94osIY0ctGlmruAsXK089Uh8syPO8A6fVPxRHyx+UvcTvn1mXnET
 bTJsOsJw0qMbuLhDAx5evuhtwGLEFKS8Hu/3pQ2LkEQcBBlqJvDYE5Sk/ZKQhfPI8lQY
 PpGlBSithlbzcOKn9EtXMEeSSTwhMdwgvv4Qy4ZeiH/IbMLSLI5RVwhPS4WGAxqQrN92
 xBpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735672012; x=1736276812;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LT79yJT21rJPtnu6Fd4xIWi2kLyEAZ71iOLyoGT2BAA=;
 b=hcxVW9lMPLud1xUuVIjKjjHG85tjDxG5if7PqUWkn8OVgLsWjEOsXSjCfg2VrlVSJQ
 1BUjjJcOA7RrZ4xM3MCrEKZE7BW/YrQl2g5qA7ohNaNQCh72a3FaPhdTlJTPyovhwMoC
 CaCE5SO6DsQJBLgTPOfHOvVWp73YFGZPP4r79PnQlASIdWLqA9WqGb0HM2e+qD/YjmCR
 aBFZDhueO6m+HB2XQwYglaCf/Ow027lu8Ns3YbqmCstNyuNgNx4plTosexodz4jGty09
 DiqlMEEKdN0EO9Nrjrbnq9UrtqEXZYRaWGF7u6carBaU4D7SkAZ4IqaTtEP8zAAPBIMj
 gWjw==
X-Gm-Message-State: AOJu0YzTDVPlALaXhAZxbGDN/T24ODzloSccqugGAZ+U9nwBOI38qbOx
 q+RQSdLr9UKDxFWTn6pXZiq/rNMacD8+0xOLYqBYdp4goBwnCl8gC4K78GtqxorThAcu9prkV1P
 C3KQ=
X-Gm-Gg: ASbGnct5Ahm0Xr1JS/7RMiTrMrvwDGhLMN6laDDo1hjHLoVPMUBx1ScjcycgdeWUB3R
 dvAuvsGrcXjbakbivjJZ0R+A97KkI+Psn9GOJwBrVgqEsqrn0xAHFTlKdASeQslD5J7oGCXtRwK
 Wp30KzV9uXlxkZtpk0ZVgxeaRN+oQhrDedF48XFAfJTt56l7vvenyNaI2msBfSYVfzLtOhwmrYY
 t4BLKcQ6Q3P6WiBpBnrS/Xtx3X6tv7QkehozUj3sH6vsMlSPLc5sLPTiGHSyo5+8cwTC6OjSxaq
 0aD3xI1qG4tefLtZFet0uUolPXDFgvo=
X-Google-Smtp-Source: AGHT+IGbpL9qeyaZHSfNVDwVLyf/zoHk3KF2UlBxaYI7QSI0lEdTAqFaBjZXC2VBZuhUGEstw6C0Gg==
X-Received: by 2002:adf:979c:0:b0:38a:418e:1179 with SMTP id
 ffacd0b85a97d-38a418e13dbmr14365648f8f.2.1735672012505; 
 Tue, 31 Dec 2024 11:06:52 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c84722dsm33476906f8f.53.2024.12.31.11.06.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 31 Dec 2024 11:06:51 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 6/6] target/hppa: Speed up hppa_is_pa20()
Date: Tue, 31 Dec 2024 20:06:20 +0100
Message-ID: <20241231190620.24442-7-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241231190620.24442-1-philmd@linaro.org>
References: <20241231190620.24442-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

From: Helge Deller <deller@gmx.de>

Although the hppa_is_pa20() helper is costly due to string comparisons
in object_dynamic_cast(), it is called quite often during memory lookups
and at each start of a block of instruction translations.
Speed hppa_is_pa20() up by calling object_dynamic_cast() only once at
CPU creation and store the result in the is_pa20 of struct CPUArchState.

Signed-off-by: Helge Deller <deller@gmx.de>
Co-developed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/hppa/cpu.h | 6 ++++--
 target/hppa/cpu.c | 8 ++++++++
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index c1d69c1a835..083d4f5a56a 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -266,6 +266,8 @@ typedef struct CPUArchState {
 
     /* Fields up to this point are cleared by a CPU reset */
     struct {} end_reset_fields;
+
+    bool is_pa20;
 } CPUHPPAState;
 
 /**
@@ -297,9 +299,9 @@ struct HPPACPUClass {
 
 #include "exec/cpu-all.h"
 
-static inline bool hppa_is_pa20(CPUHPPAState *env)
+static inline bool hppa_is_pa20(const CPUHPPAState *env)
 {
-    return object_dynamic_cast(OBJECT(env_cpu(env)), TYPE_HPPA64_CPU) != NULL;
+    return env->is_pa20;
 }
 
 static inline int HPPA_BTLB_ENTRIES(CPUHPPAState *env)
diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index 7278b7ca6b5..b0bc9d35e4c 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -193,6 +193,13 @@ static void hppa_cpu_realizefn(DeviceState *dev, Error **errp)
     tcg_cflags_set(cs, CF_PCREL);
 }
 
+static void hppa_cpu_initfn(Object *obj)
+{
+    CPUHPPAState *env = cpu_env(CPU(obj));
+
+    env->is_pa20 = !!object_dynamic_cast(obj, TYPE_HPPA64_CPU);
+}
+
 static void hppa_cpu_reset_hold(Object *obj, ResetType type)
 {
     HPPACPUClass *scc = HPPA_CPU_GET_CLASS(obj);
@@ -282,6 +289,7 @@ static const TypeInfo hppa_cpu_type_infos[] = {
         .parent = TYPE_CPU,
         .instance_size = sizeof(HPPACPU),
         .instance_align = __alignof(HPPACPU),
+        .instance_init = hppa_cpu_initfn,
         .abstract = false,
         .class_size = sizeof(HPPACPUClass),
         .class_init = hppa_cpu_class_init,
-- 
2.47.1


