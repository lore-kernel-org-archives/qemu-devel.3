Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E91F3C7EE2A
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 17:21:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSfMm-0005HS-Jj; Fri, 20 Jun 2025 13:17:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfMJ-000484-Ke
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:17:00 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfMI-0004iz-08
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:16:59 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-453066fad06so13789695e9.2
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 10:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750439816; x=1751044616; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oUi7yglI42JXKxGDm/lTESiR8XgQvpHhdliY4w41XPA=;
 b=sSkXrNfnLc7j6X8EcK7WikUV1WYEbo51KfwQwHE7v8SbjosCYcQOQz/6DoxTGFCBj5
 bTdPGvNxq8XVEEDacGQn0gr8J3OsH8+uAOV1J4RUKXA8WJXnZW3uY7hkTZ7HQbTBQxPW
 ZFzt7WP7J5tO/BC931FndjdAWWwF6vhWar5jz7/vBl/kHTfPTHXFR0W+XDiMnKW4IrVF
 rygKuX+NvgFeC13QiHvWNFFw4k15ZnO74XM04g0nAw875mtQy4PFe7PgWTMyaek4+kq4
 T4Yen/XTmU862qxX1f7cJ5yylqjFcC3m+ADVxCAmmvZUjmJrE9i1R1peAC3ev+lOrYvy
 V15g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750439816; x=1751044616;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oUi7yglI42JXKxGDm/lTESiR8XgQvpHhdliY4w41XPA=;
 b=mtxG6K7zF8kcyq3FswmbHKOgQnGAqJuUsu2MF4cyr9K/4Pvqnaxj9baZp2Sh98c20O
 bqo72FwKttUFqlKhJUQ/lzgH1bVEJxv5wlTpgbMwNxmLB4kehDL2IIdDXb5gtd2IortJ
 JH3qz7By1Eme6s07g10GtB+H2/Ut2UQxkBh0YBRGKHG0mVD2ojm9XdRX+JiAxZPbDJ/P
 z1roV6NZsDPwBFp9NRKJ0USj5SCohih/ywpcjAsGXTuUPpr8CzFxlnw2SJPiwZ2LUZKA
 t91IHj5PqqeGv5AGJrP1e8U89ArlgUPjPEL3pMiroaL7Ucn5o3JPYLx61QWv0Zre2y3t
 FW5w==
X-Gm-Message-State: AOJu0YyT6EgS+8MFZk6diSxEDZJyZrj7BcMJdZJ+6joVCBlqXRH5VfRJ
 HtOe2Two5kKbTFNc4kkCMvpk50Uke+JoXAcSDJXxbWYOQM7Yq5dR6OcmuJYSE3wBYtw9O1kgCfl
 WcSfqiWU=
X-Gm-Gg: ASbGncugSR9XiaJUXb66ktqIiArXzcIw0cZ0+RFhJ2Oy2ckYwecEe6tpByrBqsPJWSt
 jZkpBmmZ07LjzRgRIizdokRQf7F1pHl4AUmvAt8smukYRFmH00vBNqcZoDoUi56CtH5WXDsm8xp
 W8xh2CSvrjzTD8qU0QbNk0Pdgj4IOYYVSwUTPuMtnOlbRQ7bXYS6oncNX0gcsYYd+cL6jnKKW28
 IegHv8nwXsKVwfo8RD2aBO+Og+zKOXFnRQx0TH7vhM29ClXJ7GY4B2fkr/IWCcYZbWq8wWKU6KL
 aTlddOMifTx54u99RKodPqMOUDEMcZ9G2YAFIJRCG3Zk4tJ6CWRUWW+aAg738h4C1gGZYASFSut
 1WMCClqW11s1MeQFAFJf01YzttqySqsVWz9T3
X-Google-Smtp-Source: AGHT+IE/UDID759kAq2VRKoKQIAXLzF6RbN66AnuW0HPUm66IM0LFmz9X1007kTBKWjcSyk76A/TnQ==
X-Received: by 2002:a05:6000:1a85:b0:3a4:dc80:b932 with SMTP id
 ffacd0b85a97d-3a6d1193dfbmr2825828f8f.8.1750439815764; 
 Fri, 20 Jun 2025 10:16:55 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6d0f1011fsm2588239f8f.7.2025.06.20.10.16.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Jun 2025 10:16:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexander Graf <agraf@csgraf.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Cameron Esfahani <dirty@apple.com>,
 Julian Armistead <julian.armistead@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH v2 39/48] accel/system: Introduce hwaccel_enabled() helper
Date: Fri, 20 Jun 2025 19:13:32 +0200
Message-ID: <20250620171342.92678-40-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620171342.92678-1-philmd@linaro.org>
References: <20250620171342.92678-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

hwaccel_enabled() return whether any hardware accelerator
is available.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/system/hw_accel.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/include/system/hw_accel.h b/include/system/hw_accel.h
index 574c9738408..49556b026e0 100644
--- a/include/system/hw_accel.h
+++ b/include/system/hw_accel.h
@@ -28,7 +28,28 @@
 void cpu_synchronize_state(CPUState *cpu);
 void cpu_synchronize_pre_loadvm(CPUState *cpu);
 
+/**
+ * cpu_synchronize_post_reset:
+ * cpu_synchronize_post_init:
+ * @cpu: The vCPU to synchronize.
+ *
+ * Request to synchronize QEMU vCPU registers to the hardware accelerator
+ * (QEMU is the reference).
+ */
 void cpu_synchronize_post_reset(CPUState *cpu);
 void cpu_synchronize_post_init(CPUState *cpu);
 
+/**
+ * hwaccel_enabled:
+ *
+ * Returns: %true if a hardware accelerator is enabled, %false otherwise.
+ */
+static inline bool hwaccel_enabled(void)
+{
+    return hvf_enabled()
+        || kvm_enabled()
+        || nvmm_enabled()
+        || whpx_enabled();
+}
+
 #endif /* QEMU_HW_ACCEL_H */
-- 
2.49.0


