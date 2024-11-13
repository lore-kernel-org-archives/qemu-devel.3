Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EC91D637A4
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2024 18:12:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBHpt-0000TQ-RT; Wed, 13 Nov 2024 13:11:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tBHps-0000Su-0x
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 13:11:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tBHpq-00019j-HG
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 13:11:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731521480;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=0YxfwgFTLzupDkk+ne1gwmOE+mfnRoLpiNTNWB7//10=;
 b=Sw/FLJlXk1XMim1QDdC1j4Sy+V0sYA2qfqO4LWnVnonWLzWbe1lc0S6z7AC3OQ1HO8rbWy
 au6zLYwyNNGMTnweZ+/MrYd5odXWAnSnD1cVY4p4kJ30G1vlI34k/djY1lBWOx7fzPVbJz
 XNqHA8oHWjQzwykoTz6ZWHLqseXdswg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-421-kZEhjrhUPIuAJYg8rdko3A-1; Wed, 13 Nov 2024 13:11:19 -0500
X-MC-Unique: kZEhjrhUPIuAJYg8rdko3A-1
X-Mimecast-MFC-AGG-ID: kZEhjrhUPIuAJYg8rdko3A
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-37d432f9f5eso3751537f8f.0
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2024 10:11:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731521478; x=1732126278;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0YxfwgFTLzupDkk+ne1gwmOE+mfnRoLpiNTNWB7//10=;
 b=Jh1RCwoMnTvXETB3yZTSbcworMjH0RSOqAfIe9Hs3AokKlbBORMoHvAFCNoRyTvi2L
 bdVEi9AcfMKigHn9hO0AWQs+kSelyGCM+YZRP9ZzgbsxSrQZPDi7VESf6r7Hr+BUwWhk
 MNWd4CZx2zEhJl3K2J9rMoZN8U92w8VSFyc8sxDlw9Df6Qz9Q1lMqmmQkNiCh13E8WaD
 2E1227xEfRfhDMUmdjc05s8Kl5B5IgB4ZezTTGrTA9osa+DmdjnLW8/1XO1AXBAGR9/A
 qs1EGC6b0W//obrv2cFCM03gRZjmYnD3wLcvWTbrvlKGc2Aq8iAhFC9XSUKbnFgr8SoU
 k0ew==
X-Forwarded-Encrypted: i=1;
 AJvYcCVcqC/KjoEmVNWywWnx9wqiX4r/SLjHaKSS0COJM6ilqN0OU33Vy827JjhrZ2sDRWs9q/CxE8lLDbBo@nongnu.org
X-Gm-Message-State: AOJu0Yz6AdlGcLpmhnQBeXPCKCEcGLE44/30Ym4HjMLFy+WT//xeDdqR
 2SX5OQu3rHQYphvHKoVs6iHtjJFKoh2bmesIF6OPEpzsSTvW1rFD76mIgeGfQp+N5fsYUzziBa/
 ACOLTzxrbV1v8106PX2hkCc03TS7gqFhh5Sa+ho06e8rr8ywkHCV/
X-Received: by 2002:a05:6000:470f:b0:382:6d2:2aa9 with SMTP id
 ffacd0b85a97d-3820833ab47mr5676232f8f.37.1731521478003; 
 Wed, 13 Nov 2024 10:11:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG/tazobe7GwAJVavzhuXfFhy7pRxGJgNBF0T2pVOsD0Pp4IqH4neTWDhou5gY9cocs+igfKw==
X-Received: by 2002:a05:6000:470f:b0:382:6d2:2aa9 with SMTP id
 ffacd0b85a97d-3820833ab47mr5676215f8f.37.1731521477623; 
 Wed, 13 Nov 2024 10:11:17 -0800 (PST)
Received: from [192.168.10.47] ([151.49.84.243])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-381ed9ea587sm19302499f8f.78.2024.11.13.10.11.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Nov 2024 10:11:17 -0800 (PST)
Message-ID: <b772f6e7-e506-4f87-98d1-5cbe59402b2b@redhat.com>
Date: Wed, 13 Nov 2024 19:11:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] i386/kvm: Fix kvm_enable_x2apic link error in non-KVM
 builds
To: Phil Dennis-Jordan <phil@philjordan.eu>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, mtosatti@redhat.com
Cc: santosh.shukla@amd.com, suravee.suthikulpanit@amd.com
References: <20241113144923.41225-1-phil@philjordan.eu>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20241113144923.41225-1-phil@philjordan.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.119,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.738,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 11/13/24 15:49, Phil Dennis-Jordan wrote:
> It appears that existing call sites for the kvm_enable_x2apic()
> function rely on the compiler eliding the calls during optimisation
> when building with KVM disabled, or on platforms other than Linux,
> where that function is declared but not defined.
> 
> This fragile reliance recently broke down when commit b12cb38 added
> a new call site which apparently failed to be optimised away when
> building QEMU on macOS with clang, resulting in a link error.
> 
> This change moves the function declaration into the existing
> #if CONFIG_KVM
> block in the same header file, while the corresponding
> #else
> block now #defines the symbol as 0, same as for various other
> KVM-specific query functions.
> 
> Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>

Nevermind, this actually rung a bell and seems to be the same as
this commit from last year:

commit c04cfb4596ad5032a9869a8f77fe9114ca8af9e0
Author: Daniel Hoffman <dhoff749@gmail.com>
Date:   Sun Nov 19 12:31:16 2023 -0800

     hw/i386: fix short-circuit logic with non-optimizing builds
     
     `kvm_enabled()` is compiled down to `0` and short-circuit logic is
     used to remove references to undefined symbols at the compile stage.
     Some build configurations with some compilers don't attempt to
     simplify this logic down in some cases (the pattern appears to be
     that the literal false must be the first term) and this was causing
     some builds to emit references to undefined symbols.
     
     An example of such a configuration is clang 16.0.6 with the following
     configure: ./configure --enable-debug --without-default-features
     --target-list=x86_64-softmmu --enable-tcg-interpreter
     
     Signed-off-by: Daniel Hoffman <dhoff749@gmail.com>
     Message-Id: <20231119203116.3027230-1-dhoff749@gmail.com>
     Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
     Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

So, this should work:

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 13af7211e11..af0f4da1f69 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -1657,9 +1657,11 @@ static void amdvi_sysbus_realize(DeviceState *dev, Error **errp)
          error_report("AMD IOMMU with x2APIC confguration requires xtsup=on");
          exit(EXIT_FAILURE);
      }
-    if (s->xtsup && kvm_irqchip_is_split() && !kvm_enable_x2apic()) {
-        error_report("AMD IOMMU xtsup=on requires support on the KVM side");
-        exit(EXIT_FAILURE);
+    if (s->xtsup) {
+        if (kvm_irqchip_is_split() && !kvm_enable_x2apic()) {
+            error_report("AMD IOMMU xtsup=on requires support on the KVM side");
+            exit(EXIT_FAILURE);
+        }
      }
  
      pci_setup_iommu(bus, &amdvi_iommu_ops, s);


It's admittedly a bit brittle, but it's already done in the neighboring
hw/i386/intel_iommu.c so I guess it's okay.

Paolo


