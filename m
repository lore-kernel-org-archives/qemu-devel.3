Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB6BFD6EBFF
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2024 11:24:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGz65-0005rY-Ld; Fri, 29 Nov 2024 06:23:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tGz62-0005rI-AU
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 06:23:38 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tGz60-0005dw-GP
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 06:23:38 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-434a852bb6eso15979315e9.3
 for <qemu-devel@nongnu.org>; Fri, 29 Nov 2024 03:23:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732879414; x=1733484214; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=184WGS+L/2J/Sc5nEtJoo2Jefox5y+0EIv3PfO9KZ2Q=;
 b=OhBTw5Vlu3BwInfG5PYu+RRaWxdizjgFJ1p/K4Nz1DHyWgvH8fDQmToFVRnG/f/9UI
 9yL2bAVJg0dUpkgVY93oNXXkJv95d1F2aKAo3QKGQlAMOBYB+tBVtPutfnkHx5H5Ibta
 5WxF0h1/eUuyC1dAeepi63qUVwKvebB+kiCwNiPVQsVUKdGzVyDFLi2EF6a+C5Ed8SEi
 LEvLVcri96FFFXaaUaDy8InFjXC5WQC8gbMXFEbzLq+RtipyVKxkfLPe3piSDBp66R/s
 GQB9Cz4Dq4ztyNED0zGxO7nMbyEZQM/n5+GOdzv4y9kUBxSj6svFk/GUcjAwwTG1IUmm
 AwwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732879414; x=1733484214;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=184WGS+L/2J/Sc5nEtJoo2Jefox5y+0EIv3PfO9KZ2Q=;
 b=I5JS9wpS5D/5pvwF+6he754ppz4aBoD1SFu+5Bop7WTcmBCROdYObBRDnRimr2CGS9
 X9CpnatOj6CTLLZP0n4RQiFPCvZ8eoVuUIMfZ3zVEV4CmTt7DnGZoQXXXP3fFxHBdUb5
 vi8QEXNpeCFYDsLvL2BeZTcoo7ZBu2yeE7sNrk9gCMjEKqiWF86K1feSNnCR4+zsf9Fo
 n+mXP9HIpSKIDQCJzkxKX+RD7omRyKHhB8wK6S3VcvmibmWldtllgd3f4iYzT8c9b5YG
 Cdtf7COEBAY52AeIlGWjPwNXHUkhEbdvfpCbH9GXtyhg46g2xgidd9AxI251qorYampn
 QCLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUiECgbhkuIoDVG7ONY715Oai9cAud3tZfApOzWqR8tH1smCeexFmDICAqWZkymSzE8Rcsox7pRse2p@nongnu.org
X-Gm-Message-State: AOJu0YwUzJTXNzBYsFoJV5r94ACCTP7kAN7L6XAPUFHNyWQ7Fa7/oK1I
 pxt9jCuabv8neaPrq+FZVbOSO0aXVMmrQImwv5dWIHoN1j8DqtXrs0j/j6IUfp0=
X-Gm-Gg: ASbGnctK8eatD+uVRy+Kjo4lFHLohgtrvgaO4Hxz6n52sk5RQMbfS4E3HPSlF8mNppn
 Kj7M5VWHEf6yOInRXiOVifAZLQoPIRwgxHHCU7cUTmI6cOGzJnejo+3WdDH1T2LZJVq/EsdLyA9
 3vkHEJd6VHmAtl9bmh/lv0g0eqv70cbdAYXp9LDKDZaJN2Fb1iWiGkT4GmSm94B62dBpw2YRvx+
 oUWFdgHfM5rNysfXf/NVBzm1wYPGpv2lxC2vEYVoGP3iKZiQPIhyzyxlusOxSmT6XUULW1E3jf6
 KKYOKP/zn7pTkxerwOEI
X-Google-Smtp-Source: AGHT+IG8dMJEJw7JiYWXA+9BUjWaAXcoWJPG+TvKnEQXpzjHlDhdT2/kWGW6bheIIgc1SuJ9t7f0eQ==
X-Received: by 2002:a05:600c:3b1a:b0:434:a160:3647 with SMTP id
 5b1f17b1804b1-434a9dc3eb6mr100320525e9.12.1732879414322; 
 Fri, 29 Nov 2024 03:23:34 -0800 (PST)
Received: from [192.168.1.74] (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434b0dc99b3sm49706385e9.24.2024.11.29.03.23.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Nov 2024 03:23:33 -0800 (PST)
Message-ID: <30da5962-b649-49da-98e8-0d5efbc4bbfb@linaro.org>
Date: Fri, 29 Nov 2024 12:23:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] amd_iommu: Fix kvm_enable_x2apic link error with clang in
 non-KVM builds
To: Sairaj Kodilkar <sarunkod@amd.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Santosh Shukla <santosh.shukla@amd.com>, Suravee.Suthikulpanit@amd.com
Cc: pbonzini@redhat.com, Vasant.Hegde@amd.com, qemu-devel@nongnu.org
References: <20241114114509.15350-1-sarunkod@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241114114509.15350-1-sarunkod@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

On 14/11/24 12:45, Sairaj Kodilkar wrote:
> Commit b12cb3819 (amd_iommu: Check APIC ID > 255 for XTSup) throws
> linking error for the `kvm_enable_x2apic` when kvm is disabled
> and Clang is used for compilation.
> 
> This issue comes up because Clang does not remove the function callsite
> (kvm_enable_x2apic in this case) during optimization when if condition
> have variable. Intel IOMMU driver solves this issue by creating separate
> if condition for checking variables, which causes call site being
> optimized away by virtue of `kvm_irqchip_is_split()` being defined as 0.
> Implement same solution for the AMD driver.
> 
> Fixes: b12cb3819baf (amd_iommu: Check APIC ID > 255 for XTSup)
> Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
> Signed-off-by: Santosh Shukla <santosh.shukla@amd.com>
> Tested-by: Phil Dennis-Jordan <phil@philjordan.eu>
> ---
>   hw/i386/amd_iommu.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
> index 13af7211e11d..af0f4da1f69e 100644
> --- a/hw/i386/amd_iommu.c
> +++ b/hw/i386/amd_iommu.c
> @@ -1657,9 +1657,11 @@ static void amdvi_sysbus_realize(DeviceState *dev, Error **errp)
>           error_report("AMD IOMMU with x2APIC confguration requires xtsup=on");
>           exit(EXIT_FAILURE);
>       }
> -    if (s->xtsup && kvm_irqchip_is_split() && !kvm_enable_x2apic()) {
> -        error_report("AMD IOMMU xtsup=on requires support on the KVM side");
> -        exit(EXIT_FAILURE);
> +    if (s->xtsup) {
> +        if (kvm_irqchip_is_split() && !kvm_enable_x2apic()) {
> +            error_report("AMD IOMMU xtsup=on requires support on the KVM side");
> +            exit(EXIT_FAILURE);
> +        }
>       }
>   
>       pci_setup_iommu(bus, &amdvi_iommu_ops, s);

Actually I think a clearer fix is:

-- >8 --
diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 13af7211e11..9456f494385 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -1652,14 +1652,15 @@ static void amdvi_sysbus_realize(DeviceState 
*dev, Error **errp)
      memory_region_add_subregion_overlap(&s->mr_sys, AMDVI_INT_ADDR_FIRST,
                                          &s->mr_ir, 1);

-    /* AMD IOMMU with x2APIC mode requires xtsup=on */
-    if (x86ms->apic_id_limit > 255 && !s->xtsup) {
-        error_report("AMD IOMMU with x2APIC confguration requires 
xtsup=on");
-        exit(EXIT_FAILURE);
-    }
-    if (s->xtsup && kvm_irqchip_is_split() && !kvm_enable_x2apic()) {
-        error_report("AMD IOMMU xtsup=on requires support on the KVM 
side");
-        exit(EXIT_FAILURE);
+    if (kvm_enabled()) {
+        if (x86ms->apic_id_limit > 255 && !s->xtsup) {
+            error_report("AMD IOMMU with x2APIC configuration requires 
xtsup=on");
+            exit(EXIT_FAILURE);
+        }
+        if (s->xtsup && kvm_irqchip_is_split() && !kvm_enable_x2apic()) {
+            error_report("AMD IOMMU xtsup=on requires support on the 
KVM side");
+            exit(EXIT_FAILURE);
+        }
      }

      pci_setup_iommu(bus, &amdvi_iommu_ops, s);

---

Although half of these checks are already done in x86_cpus_init():

     /*
      * Can we support APIC ID 255 or higher?  With KVM, that requires
      * both in-kernel lapic and X2APIC userspace API.
      *
      * kvm_enabled() must go first to ensure that kvm_* references are
      * not emitted for the linker to consume (kvm_enabled() is
      * a literal `0` in configurations where kvm_* aren't defined)
      */
     if (kvm_enabled() && x86ms->apic_id_limit > 255 &&
         kvm_irqchip_in_kernel() && !kvm_enable_x2apic()) {
         error_report("current -smp configuration requires kernel "
                      "irqchip and X2APIC API support.");
         exit(EXIT_FAILURE);
     }

So the fix can be simplified as:

-- >8 --
diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 13af7211e11..39b6d6ef295 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -1652,13 +1652,8 @@ static void amdvi_sysbus_realize(DeviceState 
*dev, Error **errp)
      memory_region_add_subregion_overlap(&s->mr_sys, AMDVI_INT_ADDR_FIRST,
                                          &s->mr_ir, 1);

-    /* AMD IOMMU with x2APIC mode requires xtsup=on */
-    if (x86ms->apic_id_limit > 255 && !s->xtsup) {
-        error_report("AMD IOMMU with x2APIC confguration requires 
xtsup=on");
-        exit(EXIT_FAILURE);
-    }
-    if (s->xtsup && kvm_irqchip_is_split() && !kvm_enable_x2apic()) {
-        error_report("AMD IOMMU xtsup=on requires support on the KVM 
side");
+    if (kvm_enabled() && x86ms->apic_id_limit > 255 && !s->xtsup) {
+        error_report("AMD IOMMU with x2APIC configuration requires 
xtsup=on");
          exit(EXIT_FAILURE);
      }

---

WDYT?

