Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61601D637A4
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2024 18:07:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBHle-0007mZ-FJ; Wed, 13 Nov 2024 13:07:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tBHld-0007mM-8Y
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 13:07:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tBHlb-0000kU-NJ
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 13:07:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731521218;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=zHGil4zFWVB1dC6k5RpDLCueLmdtUVVuQDry9KYFhb8=;
 b=TFV0PBGyAAncQvsy8s01BAvWKdJXN5pf2QGZi9uhPqkORNOxe/D7Aq63KxYZlWLrLzmxY3
 d6+nhBQYsU66fJ4BwvQLmKS1e7QlQpgcjPVtoA56vT5jTaeXdG0nB0ZnzXg4GoKezYz4ml
 ztCoV+EGshUtv6Zy+Nh693fX4KRTJJk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-Gxv6WzJ3OD2RulCf_10clQ-1; Wed, 13 Nov 2024 13:06:57 -0500
X-MC-Unique: Gxv6WzJ3OD2RulCf_10clQ-1
X-Mimecast-MFC-AGG-ID: Gxv6WzJ3OD2RulCf_10clQ
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43159c07193so66283295e9.0
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2024 10:06:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731521216; x=1732126016;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zHGil4zFWVB1dC6k5RpDLCueLmdtUVVuQDry9KYFhb8=;
 b=edZJKyAPB47/PbU3jZHAKjp0unejX6w4v8HHnReg4ZVz4lInULmQ1dpJoe/OPUk7S9
 y+hvtrIjtTC6xE5pHzPi+1E5QHImH/beL3UCqoLtIxH4ETmFKA+rLo+X9E1i0AjQRIkc
 x4bVamyXO8n4ukre2ATGEQK19019RTbMSCcz/CimpqHNPtrzDsjAwKou4uglrDKuGY3e
 oucQqZ8rMYHRNXScVZKAiqTkqyfIPtuUC/iVdGewZPA5AHB6Z5qHB1jEwkta1p/G2HmM
 uadxnKcGZ7/mWh06TLvyP6Kin2Lnl3/sr9XTCPAXxEOfEkJPrlK8c2cWFvWWbQkmZqoh
 w7mA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWpdoeTXfN3mrolLFbVj0+VZ4WSRXq9AYjThG7N+0d2wt3CURBL4W0h4vqrzSD3mXjhMfjOJEcynM84@nongnu.org
X-Gm-Message-State: AOJu0YzXiRRv8Z5SIdP6kOnK/tmme+jfsQsrwr4SStyxnUOIvMzU8Mh9
 0M3lwhtKKh/KgMkcy2tx+I8yaR28VwOzCc5sYW4gcYnrnAUkTFHTAA/9zV0FwyKgWBpIgWTgQEO
 kyvkcK6ntpyocFFpJkYyCocBvCoSO2UJCk3926xxYGQrl7sWSGiZt
X-Received: by 2002:a05:600c:1d20:b0:430:57e8:3c7e with SMTP id
 5b1f17b1804b1-432b751ee6bmr205041185e9.28.1731521215883; 
 Wed, 13 Nov 2024 10:06:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGtF/Bm2sFvD8NMykTFnHKS/2fM8FKDNzbG9+c53bHdp6YlEv9GFdeiwAoFxnPEJlyF5VVV5w==
X-Received: by 2002:a05:600c:1d20:b0:430:57e8:3c7e with SMTP id
 5b1f17b1804b1-432b751ee6bmr205041015e9.28.1731521215539; 
 Wed, 13 Nov 2024 10:06:55 -0800 (PST)
Received: from [192.168.10.47] ([151.49.84.243])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-432d5503c63sm31784555e9.26.2024.11.13.10.06.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Nov 2024 10:06:55 -0800 (PST)
Message-ID: <02dcb7aa-f8d7-4044-93af-24b6d2e4c688@redhat.com>
Date: Wed, 13 Nov 2024 19:06:54 +0100
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
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.119,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

That's weird, can you check the preprocessor output?  The definition
of kvm_irqchip_in_kernel() should be just "false" on macOS, in fact
even the area you're changing should be simplified like

diff --git a/target/i386/kvm/kvm_i386.h b/target/i386/kvm/kvm_i386.h
index 9de9c0d3038..7edb154a16e 100644
--- a/target/i386/kvm/kvm_i386.h
+++ b/target/i386/kvm/kvm_i386.h
@@ -13,8 +13,7 @@

  #include "sysemu/kvm.h"

-#ifdef CONFIG_KVM
-
+/* always false if !CONFIG_KVM */
  #define kvm_pit_in_kernel() \
      (kvm_irqchip_in_kernel() && !kvm_irqchip_is_split())
  #define kvm_pic_in_kernel()  \
@@ -22,14 +21,6 @@
  #define kvm_ioapic_in_kernel() \
      (kvm_irqchip_in_kernel() && !kvm_irqchip_is_split())

-#else
-
-#define kvm_pit_in_kernel()      0
-#define kvm_pic_in_kernel()      0
-#define kvm_ioapic_in_kernel()   0
-
-#endif  /* CONFIG_KVM */
-
  bool kvm_has_smm(void);
  bool kvm_enable_x2apic(void);

Paolo

> 
> Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
> ---
>   target/i386/kvm/kvm_i386.h | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/target/i386/kvm/kvm_i386.h b/target/i386/kvm/kvm_i386.h
> index 9de9c0d3038..7ce47388d90 100644
> --- a/target/i386/kvm/kvm_i386.h
> +++ b/target/i386/kvm/kvm_i386.h
> @@ -21,17 +21,18 @@
>       (kvm_irqchip_in_kernel() && !kvm_irqchip_is_split())
>   #define kvm_ioapic_in_kernel() \
>       (kvm_irqchip_in_kernel() && !kvm_irqchip_is_split())
> +bool kvm_enable_x2apic(void);
>   
>   #else
>   
>   #define kvm_pit_in_kernel()      0
>   #define kvm_pic_in_kernel()      0
>   #define kvm_ioapic_in_kernel()   0
> +#define kvm_enable_x2apic()      0
>   
>   #endif  /* CONFIG_KVM */
>   
>   bool kvm_has_smm(void);
> -bool kvm_enable_x2apic(void);
>   bool kvm_hv_vpindex_settable(void);
>   bool kvm_enable_hypercall(uint64_t enable_mask);
>   


