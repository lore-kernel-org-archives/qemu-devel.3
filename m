Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC369CCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 05:59:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDcjf-0008Ds-JE; Tue, 28 Oct 2025 01:59:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDcjd-000882-0O
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 01:59:09 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDcja-0005C9-Fs
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 01:59:08 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-475ca9237c2so30839135e9.3
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 22:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761631144; x=1762235944; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B7QBs13fwIjO7kuSvhwOAAtMaY6vnhC/TwMzIPPo1l8=;
 b=rmk57Zty/evzamT60+o/nQOGx5q+LSBnLNHqBz6mOskvLUESw+h+EVtWwXzCD99vPu
 ISgj9l0tF4jyU8S9epReiyaXS+cLNp9s3AjTGeK1f5TaI2y68iFY3Wqy1vcL3663zEOk
 gRf5iBkddhAUC2rWwkiFb+Na4EzFJRDFfk1SuDFBvys7C2rUf06C/G4nzZrXNEkrP36S
 A8TXgUAp0pUnqX30c/hl7npx/7i1dADaXduRBVhJ/m/duXG2OYYZAzcbZYS5m/FruvGx
 xQn28bIfLKGQbJXwFhCKTU92AFhMq5Fx6F0KIR1AtdvA6p5ZKRkoBMgZwokThj7KS4Hh
 QF2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761631144; x=1762235944;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B7QBs13fwIjO7kuSvhwOAAtMaY6vnhC/TwMzIPPo1l8=;
 b=ubsUg+rR8ThZK00cj80MgC1vhml/Nn0/OxyU2kmEFbYhC/r6wiZuMSxpbAazmpAV6f
 ZcbvC/czY9ubAWgtSTYqdqG3yY3p0HyFJ00GFUsOZgvZzK10XdmrzoCHK1u+S8uo66S1
 Uhwia/RGK3Qd2BJYHUVIZgekOyo7NGA9qr5rQGxDCOzfjO9jA9BauSJtcts9RldquvGJ
 Mj/a20NVtDU7z5Swe163vG12s173LlfVOfkMKgIeFS31RvAUUiRxun4W/e87ULDr8GWJ
 xvc2HVW4zuWSjUVRPXGEq2rqGooCxV0AfFPK5MDNkReuHPqviEZ9Ybp7sYepPgqJgEmG
 S+8w==
X-Gm-Message-State: AOJu0YyXYsZEe/ytUrf0ALMAKnPdAWog16W+j7Lh7Dv3tPZb4r596BHZ
 U2uyS6MpNOlJ76cZ8IKgEVtBnL02H8epBBiCbwvk+CmB6RCa4g9uGricnuqPnsQVuT9c3zpw/VO
 Fg3hc+YM=
X-Gm-Gg: ASbGncs6w8IuTq9Tk3U0fEO8pADrLQJPAJc9KPbwbDr1Ss7yQ+3t5nML5CQ1ccrILYf
 p+yGzE82SsnzQauWXRWVP6hMdIIrSWvnkaqaZvGxX+ojT7Ddhngv+dsb571jm0e2eqYShDKHekK
 AYA8usq28qbZW+a1ZQesgipDyqtwS8Z1kEcAFc8xKmtoIdhwBckzKgf9ISDzjAXjZs/LvjkmTtK
 8c8YCNPJ3TmCPun1QI03lkwYq+58OdV0N9lYTJ409e62a4dpcZ6Ept0qsVX5Uigqbg5rS5v9rGF
 WKLZeEV1Hs2crOUd1o1B3CBvr8zzBZE/eedmahqf9IgAzzYEdLVzHYjkseXk/iJF4/y1DizUqR5
 tIMTyLatcfaZ37GGTAKjs9ktZZPyxhKon7RaZZxArSFZdB5U7t/YD12I+AXApnpSqU8YXfqlgrA
 PcQ8l8O3+U+LuGemjFT2M9TUnbFwNkhqoJmkcEkn59kuVisi0HmWwQFk8sXcIn18DUJA==
X-Google-Smtp-Source: AGHT+IGbknHLhEBnabsdxE3ebxXJ5OObCI/Mgp9Tr9GEX1f4T7tga0oYi+Tdc1fEonM88BoyMHReNQ==
X-Received: by 2002:a05:600c:4450:b0:475:ddf7:9969 with SMTP id
 5b1f17b1804b1-47717dff741mr18493875e9.9.1761631144360; 
 Mon, 27 Oct 2025 22:59:04 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475dd4cc596sm179116375e9.15.2025.10.27.22.59.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 27 Oct 2025 22:59:03 -0700 (PDT)
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
Subject: [PATCH v3 23/59] target/arm: Call aarch64_add_pauth_properties() once
 in host_initfn()
Date: Tue, 28 Oct 2025 06:41:59 +0100
Message-ID: <20251028054238.14949-24-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251028054238.14949-1-philmd@linaro.org>
References: <20251028054238.14949-1-philmd@linaro.org>
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu64.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 26cf7e6dfa2..f81cfd0113c 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -762,20 +762,20 @@ static void aarch64_a53_initfn(Object *obj)
 
 static void aarch64_host_initfn(Object *obj)
 {
-#if defined(CONFIG_KVM)
     ARMCPU *cpu = ARM_CPU(obj);
+#if defined(CONFIG_KVM)
     kvm_arm_set_cpu_features_from_host(cpu);
     if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
         aarch64_add_sve_properties(obj);
-        aarch64_add_pauth_properties(obj);
     }
 #elif defined(CONFIG_HVF)
-    ARMCPU *cpu = ARM_CPU(obj);
     hvf_arm_set_cpu_features_from_host(cpu);
-    aarch64_add_pauth_properties(obj);
 #else
     g_assert_not_reached();
 #endif
+    if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
+        aarch64_add_pauth_properties(obj);
+    }
 }
 
 static void aarch64_max_initfn(Object *obj)
-- 
2.51.0


