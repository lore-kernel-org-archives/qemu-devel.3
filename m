Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBD5DC7115C
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 13:12:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSbUC-0003xE-Fj; Fri, 20 Jun 2025 09:08:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSbU7-0003ge-1N
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 09:08:49 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSbU5-0004lj-5B
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 09:08:46 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4531e146a24so11631125e9.0
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 06:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750424923; x=1751029723; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2kLq7ybqs3cS0L36YzYXj0nQxUzd1xncr8lPWgttp7A=;
 b=sioQ8Wo+hXQ8uqQkSVlIg+A/PtxXvSR/AiQvwM8rDdr1tIUTfOFQCLUFbxxbiD9Jd7
 QTm4nXkeMZGaWlh5ehzUofAP6lyvHbAJiEP6frN8DcQ5if6fL7gKDvPBH3sa9euTooKT
 ZH1ygoOntt94sWq3NA75Bv/UZaelaJkXN1GYJg1DYS7q95Gz0/HxpLMdNoBUQfRuJ6iB
 +shSMyOpJIe9f8dOG2YF6fmxDFuGdwFyGQ6kJz9eY+ugUKcC9HlGNpCDTelUZT0yl7n6
 bMv3xZQltF0QVmbYSwj+qcUfOcw+BproBxjUFFcWYTEwXtvJDKEQEbluyuOPCOo9VWF5
 QmkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750424923; x=1751029723;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2kLq7ybqs3cS0L36YzYXj0nQxUzd1xncr8lPWgttp7A=;
 b=rSuZ8PxZG8++TgILIVnbn34FB9d5pqI0lH6Zl9PUipo5+Qhw08BuASkr8LLUsyeBKy
 RmOGZempo0MyQV6+lSkhsw6gvncX6Wzrlsgc/0SVVRZHWeCaHxIB5gq8KJ+oI57OdOgn
 bc3oOqxv+ezZIBHT0/mpKtDAMQGx7tO9Go1D6eyYtKaCXu0aqw/HGNJy07le900PuczK
 eKeu5Zywk9RSEtWMIILQ1ww1P27RiaDgJvLM7Fc/stQr4kaAOfWfmPtjW3Kd4/R9nnte
 KpTPN6nU8v0KYKRmxh0MMCdSAtdm7pJzwzRAtqYPU29Quj5Jdd6SGMHiA6/VltIB7K0S
 UZzA==
X-Gm-Message-State: AOJu0Yz6KY6hCIkLYhz7INJvfj3A+vNPTJcODmDg2M3aiJuDcmSgpD8l
 +Slk2N+QIlPL1hYqUtjCTrN07Zzg89H4NSyJXTpwEJFhSFFGMTNDHk9AbJSK8dgOB8wFaBVmMeD
 4vp24RdI=
X-Gm-Gg: ASbGncsDP6DtU9vw5MmMy5ZpJKV2mpb0zlXe75jbIPES4+/ZWHfFiy87CrYgIR9eJDX
 +FU2DHTfFagdkT6nzrA+OsAMKawltmJ29+EUWUZy6N6epqLWJG0QraKFA+pT7hUTk9S/uIG9xKu
 aQGt3nw9PBWVaww8DAT1sETOnOyVCAFEVcLXyd9FXFduC8tcqBn2o0xyzmt+d+HWLqO9FhrwQxW
 PMXMt02SR0qCZtmwP3/aY86AwgGIdSLpLc8Fz+nuEdvscuM5jrHh1K3DpRu/vWJMZrA+OrF3EAh
 Oy7gO/ENNM2JPhSLX8joAJQmrSQMwWKVjVHBvN2W940+tSoUkc59kBnmxPWnjpKk62H7u+TuSh2
 bYHguLVO3i6uAt9vw8f808ZDcp1ZvXNMm2tzw
X-Google-Smtp-Source: AGHT+IHx17Q3o0n4ExJMDEX9nhiRFuD9m/DDwUW/YxBilyeTC3sNUKgmjYDttzl1RvFGqYhxbO7bhQ==
X-Received: by 2002:a05:600c:c4ac:b0:442:dc75:5625 with SMTP id
 5b1f17b1804b1-453659be428mr24945485e9.5.1750424922099; 
 Fri, 20 Jun 2025 06:08:42 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-453646fd74asm24979395e9.22.2025.06.20.06.08.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Jun 2025 06:08:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Leif Lindholm <leif.lindholm@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>, Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>, Cleber Rosa <crosa@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, kvm@vger.kernel.org,
 qemu-arm@nongnu.org, Eric Auger <eric.auger@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH v2 16/26] accel/hvf: Add hvf_arch_cpu_realize() stubs
Date: Fri, 20 Jun 2025 15:06:59 +0200
Message-ID: <20250620130709.31073-17-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620130709.31073-1-philmd@linaro.org>
References: <20250620130709.31073-1-philmd@linaro.org>
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
index b932134a833..fd493f45af1 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1082,6 +1082,11 @@ int hvf_arch_init_vcpu(CPUState *cpu)
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


