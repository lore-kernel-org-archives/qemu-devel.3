Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1632D7879C
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 17:17:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEAns-0001RA-AA; Thu, 21 Nov 2024 12:17:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tEAnp-0001QO-VI
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 12:17:13 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tEAnn-0004EO-RM
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 12:17:13 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-431688d5127so9282745e9.0
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2024 09:17:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732209430; x=1732814230; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0YUsV70Yj8MKXU157O36zAGQwVkHFyGXTDd61bcbs0U=;
 b=bBhG7WXrIy6YfAHoTaQQDT9Y64MsWzf/NhJb5l5wxnQALBEwkrtC9vx6OUJN95pco9
 AHykzrtPhz/GE5cFy5CYe+cpQlYHvkGcuhgMjz4AB1ZW4wTOJNUZ3MQPcfGmCCr4Jcut
 a9/WOndn6bB+wzLOkJVVX27C/d07W+ohts7Vlbhu4aG+lqjEi3PS1kJEuSe667A79MMl
 BIEs6D5O9XTi8nru8gb8o0pJLlPREf6jaOfoNlXGC+FacuQvMiAk3Bnp5yIasDNuLF7O
 KuWY9KfXozKbJrCUvdS2sexQObpYLgxUv/z8KxOXOCl2wgOyCjDX+feceS0iWAuxQCTn
 TkUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732209430; x=1732814230;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0YUsV70Yj8MKXU157O36zAGQwVkHFyGXTDd61bcbs0U=;
 b=arDptODA2RLu1jNnbHiU4LtX7c5GCr0Ek+ELftA2fpHsZeAYhbe3NHyWVfEaVymaKO
 swvRCPXXMiAgsgtUjADCe8NGlp9LHHuYKKPXvxrb7+sU5j3C74uLz9Z725uexCyaqs73
 6EG9+fsOWQDSiWqVfeHrTVEmhcUg1sW6iv0a3B26eVpjigbA7nKP+zUGF06DU6UYTesU
 At8MzJg9SQCaJ1NUmQZrOHORHXSIiaH19lMh36SLUlh63AouP0wlpD8zQCV9SG2witqi
 PUO7LLAUD/UIzKjBN8gzIn8NE5S54fsvNeWYJrnQqS25/epailJn9eVTEGTB30zFKitq
 jX/Q==
X-Gm-Message-State: AOJu0YzSmc+FVHFZPe369fdLsd6Ys61saH1alxg1g1GSj85POKDHZFS3
 G3wYPPaRmkssTA5upUTcw5+WrQ3H4Xfzb5d8zvnJk2eVZwj95tv9tO/V9utjoTY=
X-Gm-Gg: ASbGncsgESVH/cYFwZIVwmonIgK6UE4zBfyy/AGnXomP4Aj7sX81bO+IIjPcsxS/WVK
 PX7SIpFiGjeWqJLSmVgQZF3MxyN0skBYQGVTUlHN7UBPVbrxuasPuweerXhLQOxCqFHawFLN8Ie
 hmJdxxO37ELJA8gINeF99dtiwUTUhobEGCW1+7yc4m8kIdngI+hsqaxpUCRqXTQKdpUMNxHMjat
 4YK4xwudmX6hIoAp0UmfbJ3bkYOnmDAZ35UgF66mhBLvjt8dxO5tKebfUuGKO/0
X-Google-Smtp-Source: AGHT+IETjGtoO8RR5QSMKQB5pJXFwR+QsNaYFV5GXuKguFrW1jc8MsMuk0j7pi/Rt2TLsOfeeTfJ8w==
X-Received: by 2002:a05:600c:1d9e:b0:431:60d0:9088 with SMTP id
 5b1f17b1804b1-433489b4401mr64840255e9.13.1732209430164; 
 Thu, 21 Nov 2024 09:17:10 -0800 (PST)
Received: from [192.168.69.197] ([176.187.204.90])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fad62fasm81071f8f.15.2024.11.21.09.17.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Nov 2024 09:17:09 -0800 (PST)
Message-ID: <725f4e9d-e751-4eaa-8173-d6cfa60966db@linaro.org>
Date: Thu, 21 Nov 2024 18:17:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/12] ppc/e500: Avoid abuse of container_get()
To: Peter Xu <peterx@redhat.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Juraj Marcin <jmarcin@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Bharat Bhushan <r65777@freescale.com>,
 qemu-ppc@nongnu.org
References: <20241120215703.3918445-1-peterx@redhat.com>
 <20241120215703.3918445-8-peterx@redhat.com>
 <2c63bf58-108a-4785-ad7e-c7e6446970e4@redhat.com>
 <9e206447-86e6-4251-8e3b-b764b4bf6480@redhat.com> <Zz9irqNkWX3BSDqG@x1n>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <Zz9irqNkWX3BSDqG@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 21/11/24 17:41, Peter Xu wrote:
> On Thu, Nov 21, 2024 at 10:48:43AM +0100, Cédric Le Goater wrote:
>> On 11/21/24 10:38, Cédric Le Goater wrote:
>>> On 11/20/24 22:56, Peter Xu wrote:
>>>> container_get() is going to become strict on not allowing to return a
>>>> non-container.
>>>>
>>>> Switch the e500 user to use object_resolve_path_component() explicitly.
>>>>
>>>> Cc: Bharat Bhushan <r65777@freescale.com>
>>>> Cc: qemu-ppc@nongnu.org
>>>> Signed-off-by: Peter Xu <peterx@redhat.com>
>>>> ---
>>>>    hw/pci-host/ppce500.c | 4 ++--
>>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/hw/pci-host/ppce500.c b/hw/pci-host/ppce500.c
>>>> index b70631045a..65233b9e3f 100644
>>>> --- a/hw/pci-host/ppce500.c
>>>> +++ b/hw/pci-host/ppce500.c
>>>> @@ -418,8 +418,8 @@ static const VMStateDescription vmstate_ppce500_pci = {
>>>>    static void e500_pcihost_bridge_realize(PCIDevice *d, Error **errp)
>>>>    {
>>>>        PPCE500PCIBridgeState *b = PPC_E500_PCI_BRIDGE(d);
>>>> -    PPCE500CCSRState *ccsr = CCSR(container_get(qdev_get_machine(),
>>>> -                                  "/e500-ccsr"));
>>>> +    PPCE500CCSRState *ccsr = CCSR(
>>>> +        object_resolve_path_component(qdev_get_machine(), "e500-ccsr"));
>>>
>>>
>>> why not simply use :
>>>
>>>         CCSR(object_resolve_path("/machine/e500-ccsr", NULL));
>>
>>
>> I guess we want to avoid the absolute paths. If so,
> 
> It wasn't my intention, but what you said actually makes sense to me to
> avoid hard-coded "/machine" if possible.

Long term (heterogeneous emulation & dynamic machines in mind) I'm
unsure about qdev_get_machine() future. Not to take care now, but
I'm expecting it to evolve. So not using hardcoded path is better
IMHO.

> 
> OTOH, object_resolve_path_component() was actually tiny little faster when
> we know the depth of the path.
> 
>>
>> Reviewed-by: Cédric Le Goater <clg@redhat.com>
>>
>>
>> We might want to convert these lookups to object_resolve_path_component
>> too, not in this patchset.
>>
>> hw/i386/acpi-build.c:    host = PCI_HOST_BRIDGE(object_resolve_path("/machine/i440fx", NULL));
>> hw/i386/acpi-build.c:        host = PCI_HOST_BRIDGE(object_resolve_path("/machine/q35", NULL));
>> target/i386/kvm/kvm.c:        (MemoryRegion *) object_resolve_path("/machine/smram", NULL);
>> target/i386/tcg/sysemu/tcg-cpu.c:        (MemoryRegion *) object_resolve_path("/machine/smram", NULL);
> 
> Sounds reasonable to me to use the same style.  I'll stick with this patch
> as of now in the current series.
> 
> Thanks,
> 


