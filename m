Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCDD0C77B7C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 11:00:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXHct-0004Fd-6d; Thu, 03 Jul 2025 06:57:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXHcF-00046k-As
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 06:56:38 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXHc7-0000uz-6i
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 06:56:26 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3a5257748e1so3727182f8f.2
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 03:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751540179; x=1752144979; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bOy/hh8CdzW8JKLOeQuyvYboWC5TjWykREm1ryjsqd8=;
 b=eCwF7YdRNBzX0hJmh0bZnR/XhGnwiwD6swBaYxloTG7cLDthAfo3yD82yEVk+gg+4y
 a2yis617FSnHtZ+rWpdyeTndUP5AAT3WgCtpQHdE+FYE94jYXXe1earDocY+SZ7UcbMq
 6qktkYV/G8fyZRCbWfdpgWPOguw4ASS/glr2Send49ClUz1EbSIINS4HA9qQQoptt5P6
 1XPr1RGpCG624XyAptAlJsKofykLqrpzvEvjncoVfYvc/1EUq597GakTwP8Bk579leVx
 UgPd5hqlMKwhDiE99qcOA9y37bDHFOGnYzR0uoO/CaednlgmZZdeUef+UjR2bzUQkK2N
 oxKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751540179; x=1752144979;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bOy/hh8CdzW8JKLOeQuyvYboWC5TjWykREm1ryjsqd8=;
 b=Ru1qY8+X5BLb/MjNg9WUQDKmrpgH1tHxVtKXiwKUTn8jzIrtKcWjkr2Jkby7UST1wB
 lvhqthmFRiFEbA4OwPJR9ZqL8cJCqEzN9YhF1aRL/k1mqUirLYjpi+qqcZzQXQ5Xu69K
 tHQrOXWtYxztuvub7HV0njyC7cDv5UoiPHERvTXHlzUxaAAMkYF4599eKSFjqGIzsv45
 IT/Od1JZX+FRfwE4zgICqCa4rcxasVxzJqVN1TpKiaRgS6OwuSGQjPnFib37ugVsfM/y
 bT7NCskDB49sQ1GnNR6ZMg8P41AtysY12BNrUk8okg38ShJu2HzFC6pjpiJ8YEn7zoHB
 7Ugg==
X-Gm-Message-State: AOJu0YxISYnqpwN7qMlMp3VcMKV3AFOXYGHM2ed+Y9ZWDTJEtEGe7SNZ
 THpyjcWWzmUGOXD9XDZNwfxOoRCJwjjkIHhhQwTxFx4DJ82aJuPie+s+hPQDrB9PaH/zHXKT8Ev
 /dpVfwjM=
X-Gm-Gg: ASbGncvEji67JlmJ3K5PjJVjkoN5abwhBBELDyKuYIWjz1kovMYpKPrbf1I/B+vvkzV
 eNwZ9NgFrQcshEU+LCFmH0kB1JG0L9EhvKBx8QybSqeveE5v//1sMCBfRwu06Fpbm3AzVVqY0FO
 lVnGYnlP4qe/mh/+vLR/kqY5T1rukD3FXKzi+/Wy5nca3slAma5bDn4koi7CKULbSx0X9p3oIt+
 MGze0bnuWPhcZ+LgQSLjBaMJgEC5tc1888x3ItR03x0C1SuWhQfWCV9xM+YEbvvn/5n/bKI6HuW
 bAegHxkGWSYZyNK6iIpZF/m+nO/JY2MKt7sEqVZ/rztAftTJcdZv9PzOx5cdQeAr6Gy0ulnw+cq
 gSwczIw0EKwY=
X-Google-Smtp-Source: AGHT+IG7ipjun04dtTdCOm6oy7eUWWjsKtRV5HObOuItyYoks+uXkUq2AKmszEHPvw4ntsxZJLkEbg==
X-Received: by 2002:a05:6000:2c0b:b0:3a3:7387:3078 with SMTP id
 ffacd0b85a97d-3b1fe5bf382mr5188202f8f.4.1751540179252; 
 Thu, 03 Jul 2025 03:56:19 -0700 (PDT)
Received: from localhost.localdomain ([83.247.137.20])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a892e595d1sm18529515f8f.71.2025.07.03.03.56.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Jul 2025 03:56:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, kvm@vger.kernel.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Mads Ynddal <mads@ynddal.dk>,
 Alexander Graf <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org
Subject: [PATCH v5 07/69] accel/hvf: Add hvf_arch_cpu_realize() stubs
Date: Thu,  3 Jul 2025 12:54:33 +0200
Message-ID: <20250703105540.67664-8-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250703105540.67664-1-philmd@linaro.org>
References: <20250703105540.67664-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

Implement HVF AccelOpsClass::cpu_target_realize() hook as
empty stubs. Target implementations will come separately.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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
index 7b6d291e79c..4c4d21e38cd 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1081,6 +1081,11 @@ int hvf_arch_init_vcpu(CPUState *cpu)
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


