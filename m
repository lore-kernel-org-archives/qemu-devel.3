Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 141C9C3ABC9
	for <qemu-devel@archiver.kernel.org>; Fri, 16 May 2025 14:39:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFwCw-0003qu-2t; Fri, 16 May 2025 10:38:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uFwCs-0003qI-1c
 for qemu-devel@nongnu.org; Fri, 16 May 2025 10:38:38 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uFwCp-000197-JG
 for qemu-devel@nongnu.org; Fri, 16 May 2025 10:38:37 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-441d1ed82faso16459215e9.0
 for <qemu-devel@nongnu.org>; Fri, 16 May 2025 07:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747406314; x=1748011114; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=F0CjMs1XSYy24otmuCyLRNbjIt9s0zQtbEQl74Ak5Wc=;
 b=aMa1+ym2jttEY0N32hXXvJXmBKwNQbUKh3Il7UZ1Btqoy/2xLoEQDyOmsgFPTmuhH1
 GE73ycuzbtXtz5+pkN7g5kucF/nj6NNCsuBxpdNsYo5iQTRXXrcH3dzNetbdMGq0IPlA
 CM8a/b1rqfaxxpogRjmAHB+6lBhdWubDNxpDdE/cIRvIm+XrSUKXTdV72ZK5jJpNhYdB
 uDj8pO6lbaC1dXUAkMZKKvVpse5Owr3UCTw2+KylJUAEvLGmo/vNMh2Mil+rZlpeHgy0
 3PbobXH3NkzoreeIYcP08l5nASD1EY2sw2XWJhJlDmyGu9utgy08V3jDo5LhnXvzobxN
 2cpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747406314; x=1748011114;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=F0CjMs1XSYy24otmuCyLRNbjIt9s0zQtbEQl74Ak5Wc=;
 b=CFkaZ+D/wSRoqMAUKm5CY8PDebUTiJ3x2NAAtwHkRIwVURmPggGyAge3b9erjNzU8/
 rtEvN0279qjABkUJyHvAlhEx0kQlduBDdDpve64uNkvUB8dCGlwr7mqClxThSXqFE6fK
 /4IPjCMORsVkmdG00F75bgTSzguu9MvCNs82pLPsPdbTBLi72icFvhb8B7MBP9Ki5TXs
 6sYvN2D5R3K48pmmVa0GDSvIQ/cGkGKTi3hZf9zRzGtZQHSmmQ5KUgSo+rMn2w+wsmmw
 kuk/g9zmKLhhRTUtLY1bZCZzpUYK2jlrIeGlmA0EgwTZF/oLwCNuveART13721R+FWHq
 c0BQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWDpwu5RVa9Q/69X3epREbd1SUQNRNr+jZrTSnW17hyt5IikA7IAipPnhWq3O9yxNjxSIeStw3qF21Y@nongnu.org
X-Gm-Message-State: AOJu0YyVa6XSUDUtBOQ8Ym6/4BSUoPoO6lpzkENTg/pDcA6LapOUOcu1
 8i+xzJpCw7weggQDw5prLg+x1/W5vPjiX7Msp94kGtZuor9Vc6Kkb9iF0wqkI45lmHM=
X-Gm-Gg: ASbGncuPp1K0XEriXR4EllnHF7eBvVsXxtDaOrQw6Q1sMSX7fwrADSlK9r/iV/KLVFl
 O+hZGA0t5YPe1AzQnVaucK4nC45TED4JnbpqCaIceAUk2OsZ0PqxwlhcMkS7ehUq2iuS1/4JN1P
 qiOwdrkZxntzFbRiknA6qc7jzB5gK7Z+QexV/5AN/uhQvB26qV2sPqTAcTDe9aAvTu+w8iCUT1r
 MfGwKfvcwJAFIyRIWqmkpGJdwADa1X0h5peeBVzn+u7W/of8WCnADFTmjcRB2KUmjwqHEjCyZDQ
 TaJNpGxrIsvp3A/yP0Lv6pDi1pOPPyQCCta5mP1z0Tppi5iXtYHJGND4WWJ8H2MN3/bggun8RZI
 GjcERztq3Kvlw
X-Google-Smtp-Source: AGHT+IHYgidxJSgEmTkTik7MSSRLzRG8LbaiQR/hDnoSUsnF6WcD60Q5Fs2DiwoJmeBqUgAR6NGYoQ==
X-Received: by 2002:a05:600c:548e:b0:442:dc6f:7a21 with SMTP id
 5b1f17b1804b1-442fefd5f18mr34247895e9.3.1747406313669; 
 Fri, 16 May 2025 07:38:33 -0700 (PDT)
Received: from [10.61.1.248] (110.8.30.213.rev.vodafone.pt. [213.30.8.110])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442fd516a51sm36118515e9.24.2025.05.16.07.38.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 May 2025 07:38:33 -0700 (PDT)
Message-ID: <e10a625b-31d2-4759-b775-9b7d8409de53@linaro.org>
Date: Fri, 16 May 2025 15:38:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] hw/i386/amd_iommu: Fix xtsup when vcpus < 255
To: Sairaj Kodilkar <sarunkod@amd.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com, marcel.apfelbaum@gmail.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, eduardo@habkost.net,
 suravee.suthikulpanit@amd.com, alejandro.j.jimenez@oracle.com,
 joao.m.martins@oracle.com, Vasant Hegde <vasant.hegde@amd.com>
References: <20250516100535.4980-1-sarunkod@amd.com>
 <20250516100535.4980-3-sarunkod@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250516100535.4980-3-sarunkod@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

Hi,

On 16/5/25 12:05, Sairaj Kodilkar wrote:
> From: Vasant Hegde <vasant.hegde@amd.com>
> 
> If vCPUs > 255 then x86 common code (x86_cpus_init()) call kvm_enable_x2apic().
> But if vCPUs <= 255 then the common code won't calls kvm_enable_x2apic().
> 
> This is because commit 8c6619f3e692 ("hw/i386/amd_iommu: Simplify non-KVM
> checks on XTSup feature") removed the call to kvm_enable_x2apic when xtsup
> is "on", which break things when guest is booted with x2apic mode and
> there are <= 255 vCPUs.
> 
> Fix this by adding back kvm_enable_x2apic() call when xtsup=on.
> 
> Fixes: 8c6619f3e692 ("hw/i386/amd_iommu: Simplify non-KVM checks on XTSup feature")
> Reported-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
> Tested-by: Tested-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
> Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
> Cc: Joao Martins <joao.m.martins@oracle.com>
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
> ---
>   hw/i386/amd_iommu.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
> index df8ba5d39ada..af85706b8a0d 100644
> --- a/hw/i386/amd_iommu.c
> +++ b/hw/i386/amd_iommu.c
> @@ -1649,6 +1649,14 @@ static void amdvi_sysbus_realize(DeviceState *dev, Error **errp)
>           exit(EXIT_FAILURE);
>       }
>   
> +    if (s->xtsup) {

I suppose we need:

        if (s->xtsup && kvm_enabled()) {

otherwise that will trigger back the problem I tried to fix.
Did you try building QEMU with KVM disabled?

> +        if (kvm_irqchip_is_split() && !kvm_enable_x2apic()) {
> +            error_report("AMD IOMMU xtsup=on requires x2APIC support on "
> +                          "the KVM side");
> +            exit(EXIT_FAILURE);
> +        }
> +    }
> +
>       pci_setup_iommu(bus, &amdvi_iommu_ops, s);
>       amdvi_init(s);
>   }


