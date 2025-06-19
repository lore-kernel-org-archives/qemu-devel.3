Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95A97C7115B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Jun 2025 13:18:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSF6Z-0004m0-Ui; Thu, 19 Jun 2025 09:15:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSF6H-0004S6-Ef
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 09:14:42 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSF6F-00043p-Dn
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 09:14:41 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3a53359dea5so494907f8f.0
 for <qemu-devel@nongnu.org>; Thu, 19 Jun 2025 06:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750338877; x=1750943677; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vBwegXGmW2xI9QNEHAmJjIKzsQveZBksCJkfDcZvi14=;
 b=UUThBdmUIe22DkfqJibiyCvQvqYfB4ylLJ4pLuUVr9kNRAZcjLOs+1BQqoSEXaVTin
 VIBg+wUAxVwx895dqg6qEQcEH31N5zRRS6XmgYJr+JXezvASO5UnT7Lqz7jFSebcOSbj
 Qbv3SWuwfP2tNyV7pcj9WLTMA3EazBi3IkvERLgy3UTvHVvKiTHbmwX+lHiQbFGzsnEa
 R4eASb0gZap12XimLzhgvc3eizOrkotsMGje2BguUZ6WRX4wnpeeh6XzVIW+7VjpWNtH
 NDaokPz8YsmbOTIibasXrBq20357IvtJjQYTwKTPZ2wgaqpljURL9ceg1ygJGYVm/w4E
 Rhbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750338877; x=1750943677;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vBwegXGmW2xI9QNEHAmJjIKzsQveZBksCJkfDcZvi14=;
 b=KjSPB0Snf/GWH+A9qv6hTrEwb1cwHmPIdN2aqvk5zQbccOJCjDaywyC2hVNOD4SqT1
 5OvaORRetTx17LjP0ZW+5CR9sSWAGrpFFhBHuFvyzswDWuIjkZJHBaX8E5trvRb6ISF3
 WcW7iyqVPGytkXDMy0gdV2x1SojqVNgliSMy8l96ro613+xKKk5QiKTA6dvOZR+M2YE4
 CT6gKS1ojSpA7Pz/a5J33S+SEENwE99wcbzpCFBecakP2OIBU9ZZt1qVL419aXv5jgJP
 y9TXIp6lojteg7lo0Wtumhrqd9G5m5tfMEcWxzCAtDdNnOr8tUib+vmr2ipGKvhQEXI7
 jBvA==
X-Gm-Message-State: AOJu0Yznus3XaFMhS0UGugy012DHAnvvGD5XNWSQKZLQsepn14ocIX3S
 WUBXOueTavNsgD9ICea4P3FJid1mbzR/HWwkAWdLSVl0d1+a7RRDdXjihL0sBdNz5UfTbvdBRXT
 +VdzpGJc=
X-Gm-Gg: ASbGncuw7jU1MjBcarkxbJICw8y4IcN5tVd7XEwtgttN40xirjuF0MQjKxbunpfHQ50
 ZzvpgxzCvgpuF4dFZbD7EQVPmHXl+SSb+2Be2dRoo3vloKKa2mOAPZmuMtMYlybSI9oD8ypp55F
 AYXuAgTQxnMocIZk/O0hGoWX2S0I0pBUv5owd6CYYOd+DOTderoSSpdsUmjFxoXwFMVJwTUZDDF
 1G7sMLsVtfal0penQuYp+zVFaDIqz4u8qfMtcijpN/X2O3LnqjfLFw4aqhue2oTkqjOANf8OL+R
 mbizoGlsSWp4PyLcL9itXqHcxL8+oQBNUXD3M1krTO1+R9bCdJ5x8Z0K6+ByWAz4vInAmuF0dBA
 K8h7mshUssP0Erlx1PnYqzzgpYWr6Hc+cpSJi
X-Google-Smtp-Source: AGHT+IGphVnwIkNy8mgxx1bMSCUP1PYKYP3HE8EUL+SUsHxrYE2Vhs26H5k6O4fJy9ktfqkBuAu1MA==
X-Received: by 2002:a5d:64ee:0:b0:3a4:f744:e00c with SMTP id
 ffacd0b85a97d-3a5723a2dafmr16025163f8f.29.1750338876992; 
 Thu, 19 Jun 2025 06:14:36 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a568b7741bsm19777232f8f.98.2025.06.19.06.14.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Jun 2025 06:14:36 -0700 (PDT)
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
Subject: [PATCH 14/20] accel/hvf: Add hvf_arch_cpu_realize() stubs
Date: Thu, 19 Jun 2025 15:13:13 +0200
Message-ID: <20250619131319.47301-15-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250619131319.47301-1-philmd@linaro.org>
References: <20250619131319.47301-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

Implement HVF AccelOpsClass::cpu_target_realize() hook as
empty stubs. Target implementations will come separately.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/system/hvf.h      | 3 +++
 accel/hvf/hvf-accel-ops.c | 2 ++
 target/arm/hvf/hvf.c      | 5 +++++
 target/i386/hvf/hvf.c     | 5 +++++
 4 files changed, 15 insertions(+)

diff --git a/include/system/hvf.h b/include/system/hvf.h
index a9a502f0c8f..8c4409a13f1 100644
--- a/include/system/hvf.h
+++ b/include/system/hvf.h
@@ -72,6 +72,9 @@ void hvf_arch_update_guest_debug(CPUState *cpu);
  * Return whether the guest supports debugging.
  */
 bool hvf_arch_supports_guest_debug(void);
+
+bool hvf_arch_cpu_realize(CPUState *cpu, Error **errp);
+
 #endif /* COMPILING_PER_TARGET */
 
 #endif
diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c
index b38977207d2..b9511103a75 100644
--- a/accel/hvf/hvf-accel-ops.c
+++ b/accel/hvf/hvf-accel-ops.c
@@ -588,6 +588,8 @@ static void hvf_accel_ops_class_init(ObjectClass *oc, const void *data)
 {
     AccelOpsClass *ops = ACCEL_OPS_CLASS(oc);
 
+    ops->cpu_target_realize = hvf_arch_cpu_realize;
+
     ops->create_vcpu_thread = hvf_start_vcpu_thread;
     ops->kick_vcpu_thread = hvf_kick_vcpu_thread;
 
diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 1fbfdaed59f..632751d1eab 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1078,6 +1078,11 @@ int hvf_arch_init_vcpu(CPUState *cpu)
     return 0;
 }
 
+bool hvf_arch_cpu_realize(CPUState *cs, Error **errp)
+{
+    return true;
+}
+
 void hvf_kick_vcpu_thread(CPUState *cpu)
 {
     cpus_kick_thread(cpu);
diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index 99e37a33e50..28484496710 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -367,6 +367,11 @@ int hvf_arch_init_vcpu(CPUState *cpu)
     return 0;
 }
 
+bool hvf_arch_cpu_realize(CPUState *cs, Error **errp)
+{
+    return true;
+}
+
 static void hvf_store_events(CPUState *cpu, uint32_t ins_len, uint64_t idtvec_info)
 {
     X86CPU *x86_cpu = X86_CPU(cpu);
-- 
2.49.0


