Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCCB3C52D7C
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 17:21:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdvCF-0001UP-FV; Tue, 13 Aug 2024 13:20:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew.cooper@cloud.com>)
 id 1sdvC7-0001SO-9F
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 13:20:27 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <andrew.cooper@cloud.com>)
 id 1sdvBu-00058i-Q4
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 13:20:27 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-428fb103724so475165e9.1
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2024 10:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.com; s=google; t=1723569609; x=1724174409; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=84sx66JI+FulYoVmyiqu6uT4YzhJNSXXhPlav9Qus3U=;
 b=JxTxbmx/q2tQDRkJgsmIYxMmWAMwIzs8KJkC1mgSHrj+dvpg+/cy0dctcR82SFEEo7
 +IIiaFgZWbMdh0A8/yYNVdFLnTfeWiHTdc8MwEFK17Kt+68EEA3jIyDX9NRRsJAaoe80
 kQSGty9pBXYhg8Rm7k7BcH+4q94dFqKRhTp6s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723569609; x=1724174409;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=84sx66JI+FulYoVmyiqu6uT4YzhJNSXXhPlav9Qus3U=;
 b=rCIYwmhvBjFmhfqWhhTAEHL8SHPNEns1mKq8nT4jEVfFpwfQCDz9/AzCMWUI98TMZw
 D9eunxHJ2xsqco3DepYJfjlTfanAYvCvJoDikoVEB5lpDOfDxO8QiD/rOhA1Acd6JNMN
 MbcIM8N5Pr3wxgh5oufbh3Caf9tQsZ25R6PEHOvB4nASeYY5tQl5le8e/WDCiYNAgqVz
 Icxx7047lxk+JzZe4wL+UHf2bWsQGXRi4jxHHWtFjUEjyCrE87vqePaUNR6W+xYx/+m4
 Bzts8bzsVbunAQByFX2GaCbFvzVxB5o7BzXYD8888LA+wgVyZgv+Nym3cw+jX8a0gjCo
 SIfg==
X-Gm-Message-State: AOJu0YzzJYHqI5k8tyPmmogDF+hUUAjITBW3qZ9a2sqsOfl5pCqNIzM6
 ItgQ7edKa4Ue1MdZ/3aTsiIUVbHZwD/pW7W1HK5xA0VTjGIL75kpL8SOBWzG/gE=
X-Google-Smtp-Source: AGHT+IFTGC62jSGYkGCBeBoI9MiD8GQfXOo+KENKk3RMxfPXu/2PblHRt3RsejLkmmxd/OqMpwzjUw==
X-Received: by 2002:adf:ebca:0:b0:362:ad01:5435 with SMTP id
 ffacd0b85a97d-371775c6b2bmr355964f8f.29.1723569608962; 
 Tue, 13 Aug 2024 10:20:08 -0700 (PDT)
Received: from [192.168.1.10] (host-92-26-98-202.as13285.net. [92.26.98.202])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36e4e51e876sm10981474f8f.73.2024.08.13.10.20.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Aug 2024 10:20:08 -0700 (PDT)
Message-ID: <a93b9398-9cc3-48ed-9570-47204ab80d5f@citrix.com>
Date: Tue, 13 Aug 2024 18:20:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 04/10] hw/arm: xenpvh: Add support for SMP guests
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Stefano Stabellini <sstabellini@kernel.org>
Cc: qemu-devel@nongnu.org, anthony@xenproject.org, paul@xen.org,
 peter.maydell@linaro.org, alex.bennee@linaro.org, xenia.ragiadakou@amd.com,
 jason.andryuk@amd.com, edgar.iglesias@amd.com,
 xen-devel@lists.xenproject.org, qemu-arm@nongnu.org
References: <20240812130606.90410-1-edgar.iglesias@gmail.com>
 <20240812130606.90410-5-edgar.iglesias@gmail.com>
 <alpine.DEB.2.22.394.2408121650590.298534@ubuntu-linux-20-04-desktop>
 <ZruRm34zIMtUm7oH@zapote>
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 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
 6+ahAA==
In-Reply-To: <ZruRm34zIMtUm7oH@zapote>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=andrew.cooper@cloud.com; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 13/08/2024 6:02 pm, Edgar E. Iglesias wrote:
> On Mon, Aug 12, 2024 at 06:47:17PM -0700, Stefano Stabellini wrote:
>> On Mon, 12 Aug 2024, Edgar E. Iglesias wrote:
>>> From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>
>>>
>>> Add SMP support for Xen PVH ARM guests. Create max_cpus ioreq
>>> servers to handle hotplug.
>>>
>>> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
>>> ---
>>>  hw/arm/xen_arm.c | 5 +++--
>>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/hw/arm/xen_arm.c b/hw/arm/xen_arm.c
>>> index 5f75cc3779..ef8315969c 100644
>>> --- a/hw/arm/xen_arm.c
>>> +++ b/hw/arm/xen_arm.c
>>> @@ -173,7 +173,7 @@ static void xen_arm_init(MachineState *machine)
>>>  
>>>      xen_init_ram(machine);
>>>  
>>> -    xen_register_ioreq(xam->state, machine->smp.cpus, &xen_memory_listener);
>>> +    xen_register_ioreq(xam->state, machine->smp.max_cpus, &xen_memory_listener);
>>>  
>>>      xen_create_virtio_mmio_devices(xam);
>>>  
>>> @@ -218,7 +218,8 @@ static void xen_arm_machine_class_init(ObjectClass *oc, void *data)
>>>      MachineClass *mc = MACHINE_CLASS(oc);
>>>      mc->desc = "Xen PVH ARM machine";
>>>      mc->init = xen_arm_init;
>>> -    mc->max_cpus = 1;
>>> +    /* MAX number of vcpus supported by Xen.  */
>>> +    mc->max_cpus = GUEST_MAX_VCPUS;

The only suitable number here is the one you get back from XEN_DMOP_nr_vcpus

GUEST_MAX_VCPUS is and has always been bogus as a compile time constant
in the Xen public headers (yes, ARM inherited it from x86, but it should
have never been copied to start with).  Please do not introduce any
further uses of it.

~Andrew

