Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D93ADC7EE30
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 14:42:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWcAU-0005VB-2W; Tue, 01 Jul 2025 10:41:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWcAK-0005Rw-Lk
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:40:57 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWcAI-0006qR-QD
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:40:56 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-45363645a8eso40114025e9.1
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 07:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751380852; x=1751985652; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U2Yk9uzbm0hxEuuKUPRhHe024yTVt+FZ6Bo92Z60qs4=;
 b=LvOj/bcdiXwpBYM1fZwVq0LOLwyR+UvyKto+7AMIjrChdRGNkIKnFDwTHUT4EzL8B6
 B6H4i5823utcZv1sxUP3919R8FFBy2SXAhwShay0DH9KhC7AApjlk5jlvN83/Lnq6Jz1
 BKDlbNnIKAF3/kVCCgpPxf1NLF8mwzYbfprhnJ1Ceb/6nPqCy3GZbhgr/qLN/6FhMTM2
 fRbR4bWg2HVsuAWfGJ682G96/R6sgFvXtHkNzp73Vb1oghoVUUE3MZlGNTcZHvrLxfGS
 o6OgksLpomm8g1xprPPBkSjnjQQzxyvF9D4gc2OVKt0eZD7Y2CO60ksDQ5adAUCFWux5
 V9AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751380852; x=1751985652;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U2Yk9uzbm0hxEuuKUPRhHe024yTVt+FZ6Bo92Z60qs4=;
 b=Cp9CTVm3W9AlDQb3c4ZYXanl+jom1v68w3w11yX/dYpS/4Z0obLNwevvgNTv80KFX2
 StLPntuFkmpFiBP8VbrpLjlG2h061Fw0acLE9bhAMmrnI5oqbl6qCAOqU19jft8fdMDA
 JG5k8WeXy1ieecFR/IWvTfUtMTCTlHfw5V0EmgyhuaxRUoYP8UMDi50DijSGSuMXpS9O
 ctRMyu7DUAwHMUQ5IupdWK1+kku3OwN5+lce51n2BtUUXzQCM/1ZdNQ/0x3fWW/qCOUC
 PuZMrkcIJAjju1omiWmA5i2mdX+LGE2rPn2U6gNaCCLGOEYW3lRGhFXJxYDj/GCnGbp/
 ykkg==
X-Gm-Message-State: AOJu0YxmFXKWwFBVKbAJOQiwXdQT9bAvO0loZZUm5nqUMcDa25WZ/iIp
 9dxQclPshT+RyuzCbI2mKhPIqCgtETBjbkar9KwGH/Rm3n172FfRNF2QqMLiPBT4TpBy/9o/cer
 29DDI
X-Gm-Gg: ASbGncuyN+oalqPcg0eWTzIm0kLeF8pdPGLNrJlmIlIokkxmqVGXJlrNmZT2YclefJz
 T6eXjziBzRv3dv6jHN9qJeCzhPgVNmBpV6LhxwmqXmRXKmO5FRzL2GM2Gy7hk08hqlKADagBETd
 ucfPBWVvUKxxQjm022ySLYqRfAU3jNoechcVR78D86grS2oz7KOLN00LltcaCVgs4fx22eEvGbu
 4Fn6UdoKdijfkob6W0b6uj4vEPTaIC+Bew9QrWFUPWr4mqwAo9HmsjBxPk//LZAq+fwMUf0cOo/
 AVBXLz/2dGh2G6jmIcAPe2GQQ19Zseqj1uAsP4kRNu20i1gG4xbT545rfgFuf+F2IISJmfqvkZq
 c/dzPz05oBMzDeUgyp5VP0Jcqu0f77qIinQZ2/wQj0i74nMk=
X-Google-Smtp-Source: AGHT+IHUZMnmOyV8vNofvrGXYlYbX1MR21CRwNezTpLdazX0aDnoeOT0XDSZScHbd+ZHLKlzZmMREg==
X-Received: by 2002:a05:600c:4749:b0:450:d37d:7c with SMTP id
 5b1f17b1804b1-4538ee5d621mr153991875e9.21.1751380852217; 
 Tue, 01 Jul 2025 07:40:52 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4538f88efffsm140427435e9.17.2025.07.01.07.40.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 01 Jul 2025 07:40:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 06/68] accel/hvf: Add hvf_arch_cpu_realize() stubs
Date: Tue,  1 Jul 2025 16:39:14 +0200
Message-ID: <20250701144017.43487-7-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250701144017.43487-1-philmd@linaro.org>
References: <20250701144017.43487-1-philmd@linaro.org>
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
index d60446b85b8..b85284017c5 100644
--- a/accel/hvf/hvf-accel-ops.c
+++ b/accel/hvf/hvf-accel-ops.c
@@ -582,6 +582,8 @@ static void hvf_accel_ops_class_init(ObjectClass *oc, const void *data)
 {
     AccelOpsClass *ops = ACCEL_OPS_CLASS(oc);
 
+    ops->cpu_target_realize = hvf_arch_cpu_realize;
+
     ops->create_vcpu_thread = hvf_start_vcpu_thread;
     ops->kick_vcpu_thread = hvf_kick_vcpu_thread;
 
diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 42258cc2d88..6551cf1bed1 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1076,6 +1076,11 @@ int hvf_arch_init_vcpu(CPUState *cpu)
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


