Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B764BE7717D
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 14:42:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM6ra-0004cM-7h; Fri, 13 Dec 2024 09:41:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tM6rY-0004bQ-Q2
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 09:41:52 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tM6rW-0006c0-1K
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 09:41:52 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-38632b8ae71so1334323f8f.0
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 06:41:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734100908; x=1734705708; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RDeHIIEreHXKHCcb1drZ8YwIdhzp72M3517m8MIhFwI=;
 b=CfABoBSy1+ommGg3N7HQjKKAUzs4YYmNt3dZM3BpqWgIUjhshf3dh6uwUbt3cMt8wB
 78Qufk9taVp1x7LHswn9s+eX2tqkLPkFnmXQ2Bbmu5DIuisxjZxTWsulSJISxmvVS+vl
 1nnGO8ceIsyTFeRy5XttyG2rMRXO4viHVa340l4JWPtHUY3+fPoRT0sLy3CDS7cTMDFf
 dnGAMIEB/O7z1coMbs5CnJR02kaxHZeXUrnZduKPGuuKAL7RPF7l2XD9GJv3JsBuZA0e
 1/2GAuHNS7VCLKtLGEo62jc6NyE7Af1lKru0+NTc52JEVhnTvGNM7xKtC/11Do0Jp4Ek
 JdDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734100908; x=1734705708;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RDeHIIEreHXKHCcb1drZ8YwIdhzp72M3517m8MIhFwI=;
 b=WC3yvkovR7lTsTmKmu4kavvJkdA6y/BAf3Z/QZsnel9v4OJelz5cp+MI6Jx0QEbM1p
 JtCehk0jeCh4Vk2CA1+Z18+k5iV5dpU37axCsBXonkXva5FV2sxknGfihcuDg3kBvK7C
 EM9yatv1lfoFSgYGGIo+g0c72/uanG5yZCP+/15envjsGHktq7OBVO33syQ8WFEzbna0
 mgUYCN+cz+9rpa2UZZ9TH1uYsJGiZjRFDIFG+BiPE1KvSO//iC39yrLMDvm/JT2tn5rU
 +uRtHnUjfnw19eM5EsVN75ZBcmGZyvJJMPQR0CzcWuN/Rl0c/USPmkATMpMSCVoPqc5t
 1dHg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVl5VlvhUAWEsJ2rCmrm+CQhgzeOZ7+1LT+vaph/7kpFyX0fQIbsxlEhYgQQbg/+tXYqg7KeXV76hpy@nongnu.org
X-Gm-Message-State: AOJu0Ywcz2XYbGtSMn51x6jer+VR6vQ+fLz6A1IfjtNqi7d+YcWy/j5U
 8y1vIjL96Qz8m1agRbzTfvgVAqfAzYwZF4v3gQSM3pBknjah8e53cjh/XUvQNAs=
X-Gm-Gg: ASbGnctYN1WVmzD6VW/Oy5gCv0lhaP5u9mwEXGx7zXSZrRqRlQUZWx7S+ZWIwuqkUs7
 spn9wZVpm/twcfuRyHahUV3Ss/lPy/Oie+EXCaoh8fUsY6EdYobPqXe7VuYhcKYj29C+iur8jOk
 GjvwUI7YgdauMU8iiyUn/i+XA618s4RcfkoZ1SGWPLR6qFer7g10VpOQ4JBrje8osyN0tvkuShq
 QvSC49PLprm03LpIPRACDf1opdUC8W+kc0g6StPEuDVkmmLk+YZuMOqI0HFt+xQMlV2aMrSslns
 0tUKRCyM54kh1t6HaKSECCuYHuIm0g==
X-Google-Smtp-Source: AGHT+IHV3NKkZRzUOKHS94J+pPIyqmSLEgi6isViiGAVn129o9YFBf0FI70JZ3CVgmjtzjEUL6Q76A==
X-Received: by 2002:a05:6000:2a5:b0:385:f840:e630 with SMTP id
 ffacd0b85a97d-3888e0b9bc0mr1604943f8f.37.1734100908066; 
 Fri, 13 Dec 2024 06:41:48 -0800 (PST)
Received: from [192.168.69.223] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-387824c5c98sm7221193f8f.58.2024.12.13.06.41.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Dec 2024 06:41:47 -0800 (PST)
Message-ID: <b87473d2-d132-42a4-8ca3-aaace8da7bf9@linaro.org>
Date: Fri, 13 Dec 2024 15:41:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] hw/ide/ahci: Decouple from PCI
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Peter Xu <peterx@redhat.com>, qemu-arm@nongnu.org,
 John Snow <jsnow@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20241212110926.23548-1-shentey@gmail.com>
 <20241212110926.23548-2-shentey@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241212110926.23548-2-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

On 12/12/24 12:09, Bernhard Beschow wrote:
> In some adhoc profiling booting Linux VMs, it's observed that ahci_irq_lower()
> can be a hot path (10000+ triggers until login prompt appears). Even though the
> parent device never changes, this method re-determines whether the parent device
> is a PCI device or not using the rather expensive object_dynamic_cast()
> function. Avoid this overhead by pushing the interrupt handling to the parent
> device, essentially turning AHCIState into an "IP block".
> 
> Note that this change also frees AHCIState from the PCI dependency which wasn't
> reflected in Kconfig.
> 
> Reported-by: Peter Xu <peterx@redhat.com>
> Inspired-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>   hw/ide/ahci-internal.h    |  1 -
>   include/hw/ide/ahci-pci.h |  2 ++
>   include/hw/ide/ahci.h     |  2 --
>   hw/ide/ahci.c             | 39 ++++-----------------------------------
>   hw/ide/ich.c              | 19 +++++++++++++++----
>   5 files changed, 21 insertions(+), 42 deletions(-)


>   static void pci_ich9_reset(DeviceState *dev)
>   {
>       AHCIPCIState *d = ICH9_AHCI(dev);
> @@ -102,7 +114,9 @@ static void pci_ich9_ahci_init(Object *obj)
>   {
>       AHCIPCIState *d = ICH9_AHCI(obj);
>   
> +    qemu_init_irq(&d->irq, pci_ich9_ahci_update_irq, d, 0);
>       ahci_init(&d->ahci, DEVICE(obj));
> +    d->ahci.irq = &d->irq;

Pre-existing, but we shouldn't set this directly.
Does the IRQState belong to AHCIState?

>   }
>   
>   static void pci_ich9_ahci_realize(PCIDevice *dev, Error **errp)
> @@ -125,8 +139,6 @@ static void pci_ich9_ahci_realize(PCIDevice *dev, Error **errp)
>       /* XXX Software should program this register */
>       dev->config[0x90]   = 1 << 6; /* Address Map Register - AHCI mode */
>   
> -    d->ahci.irq = pci_allocate_irq(dev);
> -
>       pci_register_bar(dev, ICH9_IDP_BAR, PCI_BASE_ADDRESS_SPACE_IO,
>                        &d->ahci.idp);
>       pci_register_bar(dev, ICH9_MEM_BAR, PCI_BASE_ADDRESS_SPACE_MEMORY,
> @@ -161,7 +173,6 @@ static void pci_ich9_uninit(PCIDevice *dev)
>   
>       msi_uninit(dev);
>       ahci_uninit(&d->ahci);
> -    qemu_free_irq(d->ahci.irq);
>   }
>   
>   static void ich_ahci_class_init(ObjectClass *klass, void *data)


