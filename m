Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A0E3C8303C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 18:55:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uX2bR-0001Jr-BN; Wed, 02 Jul 2025 14:54:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uX2bC-00017I-3M
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 14:54:28 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uX2bA-0001eh-2U
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 14:54:25 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-453643020bdso63096655e9.1
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 11:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751482459; x=1752087259; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bOy/hh8CdzW8JKLOeQuyvYboWC5TjWykREm1ryjsqd8=;
 b=TKIDvWmzgH2Wu1WJNjUoUTrxHx6YR8rvBxDS9FCvy4F+5cnEcX3pUlDl2nXqItlNsR
 SvvpV4ra9bqqCtKDqUmnUd6QK+dih+pduG3bR1qJYt+KGIFk/66MNwU5dfJMx40cNtnN
 ya0VLFY+IaArFyHJft6xCCrxZ7REHvzqXKneBJZX896hz9ozJ2mbZ3u1ctbs6KyvdWHI
 fkzxaTHYXre+pZsVjvnSd/oCiPJ+3L66oV5tC4MyzJ8fh46rw1biYqzUW78QnvYpa0mT
 Oq7gyOV6gTUQsJNB0m+0S2OBgZBq2fJD97MnYXwFH55hf4T36xgYAkBNrrOyCCavhum6
 Z43w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751482459; x=1752087259;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bOy/hh8CdzW8JKLOeQuyvYboWC5TjWykREm1ryjsqd8=;
 b=gYI5hBQ91ZLyeSNbWgjDCUbRRHdLy3vFwndKDqZs2F5CwirFQzraTY1s1F/aOe6IWZ
 cg3+1F10Ugr1lva6g8n0wsGxQ0ReEjDQCR3ZyaZkTzzfIig5zBZhfDyzP9K/Ud+UeLiH
 cCD7Td4wGIJeKHGIabmhM4ANYyYi/9zK+Tiim/8Da0TaxVW+4ixTUwVgZT54kjxzLtrT
 6Zo9/hqQVGpyQ+I+JgCvMenPFODxr4JEoFmy9meUJoWi1Vvz8Qly+jnYfjCNkoDFUP3u
 6F6Ky/BTblE7kgHe79Ld+oitdVo1Rts7oCaPZjFKWWKyFl9w0hlZMnmGNIAqP4gcNkEK
 2FVQ==
X-Gm-Message-State: AOJu0Yx01hcUbgd8u1lsF0OhVZ4CHsPDbrcI9oxJYa52siIa3VtS6lEn
 mzhBG8HwOErsVjlmRqdl4iBt5K+e9S4KC6T0MkpmfB35KtvVclo0jztQn7hxW5matSDx5cQCTzK
 v2hnz
X-Gm-Gg: ASbGncs18H/3+Qjd/hO7m2JyUpNPnrZDpWQwJFfoGKr/POb/EArBysST9c0Uh8TGoKU
 fBoSGqKzOhxwXWdKZWonb/cbqrDFqd7kGU3zyET5KJ+CBXebErGFsR3oltjB+E6nomxo+W5N/5Q
 qzvp8bAG8+U2TK26To/ffS2qcV8j7a5igaGYWLp0mewrQXDkiw+k+3ndxcY5cXMJvRYlGeCSIcz
 gBnR8QDA9f2j9beG0hnHs2xzrGUSX3Yfs6wrupYCOQ/C2+MW3+I2WAhR4CQpQ68cqH963LQBK6t
 4fp1U3OMzCGEt4iEpYkRkpUHhO3RAWeFhdQNQAAe1aRyorE4L3Ki0zBDDUXGICFobWnISiLX2vy
 18b/W4EbISQOc0csM+hiHVXa77IkSfHzlKP6y
X-Google-Smtp-Source: AGHT+IEgLL7L+r+iZgsRNi8i+FxvbIr5PVnGC8TUcln6/EmVy2Fl0Q34xbpV9etgWh6AfecbWbg6LQ==
X-Received: by 2002:a05:600c:348e:b0:450:d386:1afb with SMTP id
 5b1f17b1804b1-454a36e35f0mr48504795e9.9.1751482459480; 
 Wed, 02 Jul 2025 11:54:19 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-453b35309casm35763075e9.1.2025.07.02.11.54.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 02 Jul 2025 11:54:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Mads Ynddal <mads@ynddal.dk>,
 Alexander Graf <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org
Subject: [PATCH v4 06/65] accel/hvf: Add hvf_arch_cpu_realize() stubs
Date: Wed,  2 Jul 2025 20:52:28 +0200
Message-ID: <20250702185332.43650-7-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250702185332.43650-1-philmd@linaro.org>
References: <20250702185332.43650-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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


