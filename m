Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D860BD6ACD4
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Dec 2025 09:08:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vW9zf-00089K-2Z; Thu, 18 Dec 2025 04:08:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vW9zd-00088Q-DR
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 04:08:17 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vW9za-0000n9-1N
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 04:08:17 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-47aa03d3326so2194895e9.3
 for <qemu-devel@nongnu.org>; Thu, 18 Dec 2025 01:08:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766048892; x=1766653692; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=W1PrEQSWkO1FbZAh3QVxw7kdZJBpNakOHzPge5csrVs=;
 b=qk6ph3cUZg362CyGIhU9Ae5pww2IEZKfpv9bwKuSk0QvDvNznYG0XW7F/NGvdGsAAx
 nnIC7VCtrBKYaZebHX0jsnvKsLr5TP7GNFSWH51zMC0fEK+6RYfOCVzgwwudtYQhDRrh
 3LSIhMPvpoGnK3VcpFxOPGoulob5At7yFngw+QDalfmm/dbL5cIwrsziyQEKeP/IB7SA
 41mU+ga0nX5ySwVocvZNVmyW/hO78PDWXj9RSm3RoNK0mRAxgVM0j30nS0iIb6niC4D4
 onRQk2mUnSCaI2FuZ4OixVoCk+Zx9N0lBf2VMDXoeTm7H6tRpebI/JPbB12Z9MR/HZ3d
 R8DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766048892; x=1766653692;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=W1PrEQSWkO1FbZAh3QVxw7kdZJBpNakOHzPge5csrVs=;
 b=fN137Jtz31A5TysLQ7x0dADyEOBQ5UUjTq/XByB5aTolMs9MAyN6WpNQKBy5vDa6gL
 Mrc3AJExnMBQdYsCS6nzL87qNxoqkXZBSWkeX9S+0PU0iTLVgtmh8483+V2+REauO/E/
 qHmnjCiebg2gmaDsVLwtjtfi8B6BXD8W+UcbnIn0NRIvWP5ngB49Ow31+K/C7imyYLWn
 2GiTZszy08HI5D/MKwuqwm1U84QkprgcaSnIa9Z8+WBrunhc6uy3T+dUPuW+wXgvdVLx
 2wxCiKUVKwSBYmo9gAPqlZt9+xTjs3wa+DRSRDWpj655JreFeA2DcfTYVvg2Qoajz25Q
 3kkQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLQiMUbcKZ6ogj7Yo3tSf/8rg45IoPOLTUT1RYeX/iH+OciNHSyALt0pScjMpqRIEWVZH/YkPiNf7h@nongnu.org
X-Gm-Message-State: AOJu0Yz4xIoVqgauWzG5Os/rPxihbH1H+b5vgjPbv1/DKRARAx0hn7Bk
 BeYcBA1/0Xk/lFCulZG0d8UcnuNtKeTLPtFpDllRn5iZU3NksKY+jCQLoHWckonhUBM=
X-Gm-Gg: AY/fxX4l9mH2j2lwD7cjMd9dxBMZA6YWAYPMUFNIyJ4sL8HQB/qFfxeFbVX0LBmq/fv
 sheYrReTGAU4So99NDozYBWuKrLzefKIZBUNXtkiuO0PRlMfRvQbxmu1UjwaYoO45avDIVLyUmv
 pMkTPFIsHdlmyscmygArXNfy6zJF366TEWu4E6kSswKUPKimkKgnQpAEx9Qy0fyDCjcrunlGbr/
 VcUR1LK7n1zaP1fRfkgEYj3DPdjlkPxBGmS2g7hUzZ67HMUt7EEGdFY9DZUh6E2jlCffDSUt2Sk
 bpk1ycc+g12ufGWv6BiZ6qVXom//vyFonkf7g637wN8fsXvQPHN7oY3sSyWk+OiG43qo23bHVj8
 rc8lYfw4R7MwUwPbmHKMbs12WG0B6bxzE9QztcTYSwprUNoEpIwvBeL92RTvK63vmJdzJAu4Mk2
 BZUuDG1vQ5Q8oMxWAGN2sPjc+Vg8GaR1W/iqE73T2AwG0T5g1hg6VDZw==
X-Google-Smtp-Source: AGHT+IENHvVniBaGxRw8HU3ipAOeaw0gu9Kz09hG3M+IouJQu+n91CQLSkbofCnEmUFik64yIv7ZLQ==
X-Received: by 2002:a05:600d:b:b0:47a:94fc:d057 with SMTP id
 5b1f17b1804b1-47a94fcd555mr156277415e9.2.1766048891617; 
 Thu, 18 Dec 2025 01:08:11 -0800 (PST)
Received: from [192.168.69.202] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be3a0fb5bsm10409535e9.1.2025.12.18.01.08.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Dec 2025 01:08:11 -0800 (PST)
Message-ID: <84e7d797-c1ce-4afa-84b0-2bec582a4021@linaro.org>
Date: Thu, 18 Dec 2025 10:08:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] system/physmem: Enhance the Address Space API
Content-Language: en-US
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, richard.henderson@linaro.org, alex.bennee@linaro.org,
 peter.maydell@linaro.org
References: <20251217212018.93320-1-gustavo.romero@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251217212018.93320-1-gustavo.romero@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

Hi Gustavo,

On 17/12/25 22:20, Gustavo Romero wrote:
> The proposal in v1 was to allocate all CPUAddressSpace structures
> dynamically as the address spaces were added. However, after private
> discussions with Richard, Peter, and Phil, I agreed to take the opposite
> approach: allocating all defined address spaces (CPUAddressSpace struct)
> for a target statically.
> 
> This different approach simplifies the current AS API too for the
> definition of new address spaces for a target, while also simplifying
> the changes necessary to achieve it.
> 
> CPUAddressSpace is a tiny structure, so allocating it statically has
> negligible impact. Meanwhile, the AddressSpace struct (inside the
> CPUAddressSpace struct), although larger, is already allocated
> dynamically and allocated only when an address space is required.
> 
> The AS API simplification proposed here simply requires calling
> cpu_address_space_init() once to set the total number of ASes supported
> by a given target, and then adding the required address spaces using
> cpu_address_space_add(). Consequently, there is no longer a need to
> precompute the total number of ASes beforehand, which becomes clumsy for
> targets that require different combinations of ASes.
> 
> Finally, the problem of mapping a sparse sequence of AS indexes to a
> dense sequence of CPU AS indexes (array indexes) disappears, since a
> CPUAddressSpace struct is statically allocated for all defined ASes
> supported by the target.

What I had in mind is set the max per CPUClass, allocating them all
(currently 1, 2 or 4) then only use what is necessary. Smth like
(untested):

-- >8 --
Author: Philippe Mathieu-Daudé <philmd@linaro.org>
Date:   Thu Dec 18 09:39:16 2025 +0100

     cpus: Define maximum number of address spaces in CPUClass

     Since we know upfront the maximum number of address spaces
     a CPU can use, defined it as a CPUClass field, then rather
     than allocating on-demand in cpu_address_space_init() and
     optionally releasing, allocate them once in cpu_exec_initfn(),
     always releasing in cpu_common_finalize().
     Finally when possible, reduce the number of used AS in the
     CPU DeviceRealize handler, after all properties are set.

     Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index ab7b59aed2b..76e33749264 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -147,2 +147,4 @@ struct SysemuCPUOps;
   *                    related information.
+ * @address_spaces_max: Maximum number of address spaces usable by this
+ *                      architecture.
   *
@@ -197,2 +199,3 @@ struct CPUClass {
      bool gdb_stop_before_watchpoint;
+    unsigned address_spaces_max;
  };
diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
index 8c306c89e45..2921d075065 100644
--- a/hw/core/cpu-common.c
+++ b/hw/core/cpu-common.c
@@ -311,3 +311,2 @@ static void cpu_common_initfn(Object *obj)
      cpu->as = NULL;
-    cpu->num_ases = 0;
      /* user-mode doesn't have configurable SMP topology */
@@ -361,2 +360,3 @@ static void cpu_common_finalize(Object *obj)
      g_free(cpu->thread);
+    g_free(cpu->cpu_ases);
  }
diff --git a/hw/core/cpu-system.c b/hw/core/cpu-system.c
index 8b31c72da4b..fa6aa857981 100644
--- a/hw/core/cpu-system.c
+++ b/hw/core/cpu-system.c
@@ -190,8 +190,2 @@ void cpu_exec_class_post_init(CPUClass *cc)

-void cpu_exec_initfn(CPUState *cpu)
-{
-    cpu->memory = get_system_memory();
-    object_ref(OBJECT(cpu->memory));
-}
-
  static int cpu_common_post_load(void *opaque, int version_id)
diff --git a/system/cpus.c b/system/cpus.c
index ef2d2f241fa..4b9c94d402c 100644
--- a/system/cpus.c
+++ b/system/cpus.c
@@ -720,3 +720,3 @@ void qemu_init_vcpu(CPUState *cpu)
           */
-        cpu->num_ases = 1;
+        assert(cpu->num_ases == 1);
          cpu_address_space_init(cpu, 0, "cpu-memory", cpu->memory);
diff --git a/system/physmem.c b/system/physmem.c
index cc148d3a409..f5d362c6ea4 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -778,2 +778,13 @@ hwaddr memory_region_section_get_iotlb(CPUState *cpu,

+void cpu_exec_initfn(CPUState *cpu)
+{
+    unsigned max_ases = cpu->cc->address_spaces_max ?: 1;
+
+    cpu->cpu_ases = g_new0(CPUAddressSpace, max_ases);
+    cpu->num_ases = max_ases;
+
+    cpu->memory = get_system_memory();
+    object_ref(OBJECT(cpu->memory));
+}
+
  void cpu_address_space_init(CPUState *cpu, int asidx,
@@ -798,6 +809,2 @@ void cpu_address_space_init(CPUState *cpu, int asidx,

-    if (!cpu->cpu_ases) {
-        cpu->cpu_ases = g_new0(CPUAddressSpace, cpu->num_ases);
-    }
-
      newas = &cpu->cpu_ases[asidx];
@@ -834,4 +841,2 @@ void cpu_destroy_address_spaces(CPUState *cpu)
      }
-
-    g_clear_pointer(&cpu->cpu_ases, g_free);
  }
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index f1e9ea0a0f8..e9467b68846 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2393,2 +2393,3 @@ static void arm_cpu_class_init(ObjectClass *oc, 
const void *data)
  #ifndef CONFIG_USER_ONLY
+    cc->address_spaces_max = 4; /* See ARMASIdx */
      cc->sysemu_ops = &arm_sysemu_ops;
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 64177757863..4074183ec67 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -46,2 +46,3 @@
  #include "hw/i386/sgx-epc.h"
+#include "hw/i386/x86.h"
  #endif
@@ -9520,2 +9521,6 @@ static void x86_cpu_realizefn(DeviceState *dev, 
Error **errp)

+    if (!x86_machine_is_smm_enabled(X86_MACHINE(ms))) {
+        cs->num_ases = 1;
+    }
+
      qemu_register_reset(x86_cpu_machine_reset_cb, cpu);
@@ -10108,2 +10113,3 @@ static void 
x86_cpu_common_class_init(ObjectClass *oc, const void *data)
  #ifndef CONFIG_USER_ONLY
+    cc->address_spaces_max = 2; /* See X86ASIdx */
      cc->sysemu_ops = &i386_sysemu_ops;
diff --git a/target/i386/kvm/kvm-cpu.c b/target/i386/kvm/kvm-cpu.c
index 9c25b558395..855edd164d2 100644
--- a/target/i386/kvm/kvm-cpu.c
+++ b/target/i386/kvm/kvm-cpu.c
@@ -100,3 +100,2 @@ static bool kvm_cpu_realizefn(CPUState *cs, Error 
**errp)
       */
-    cs->num_ases = 
x86_machine_is_smm_enabled(X86_MACHINE(current_machine)) ? 2 : 1;
      cpu_address_space_init(cs, X86ASIdx_MEM, "cpu-memory", cs->memory);

---

