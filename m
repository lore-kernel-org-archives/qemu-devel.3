Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C21DC02197
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 18:18:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfNUl-000852-H2; Tue, 04 Feb 2025 13:17:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tfNUj-0007xh-Cs
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 13:17:57 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tfNUh-00007o-Gx
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 13:17:57 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4362bae4d7dso42415505e9.1
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2025 10:17:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738693074; x=1739297874; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wBpKqCsukKzuAi+5774RG/H/pGNQalvIRrk0hjW3pjs=;
 b=XeR660dRQ7M6EMJ2D70L4joqYzI6FBKDEODjXefezzdT/vBva6B+H32JGzFEKFas16
 Wl/L9c8pvZtt4jqOR367NiPTKHTA1CehzjgrPMWcuhiY+xBOFgV0xw8Kw4RqovuV+6Zn
 dVBDLFAk6mpogaMbgmNOM34nlw+BNmK4So++N93v7Ys//F1gwyF0j35u/pJTlo1odyaH
 8sVDoSITfrOJMtiR+p7AD4B6oNo38weql19NbVXZkOkEYlsaho/OY2kmSvQrl+dNTPKH
 v0hQ3bHyj4+A1Yvm783Yjakae9zDnPxzzII6ySoWYNNeSYkqKBGX+FPuY2D3yLOg0+LT
 7wEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738693074; x=1739297874;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wBpKqCsukKzuAi+5774RG/H/pGNQalvIRrk0hjW3pjs=;
 b=GlnBhUxrtfWnNoBR9ldTO/+EHXnj3x3tDtdJNMFvBIJ7/j1tAk1vqkuJkYN+buLIlN
 McX+1LXBS8CPgyMD0RKeGdexuK9RVyXLAeEC2D43Ggbf+22DlxU8so82dnqd+WMeDUXW
 EK8lZ2DBB06ac/Y12TvsmxRgKMFH+4vq+w7PVjg2OA9EmpgiQfEbXpB/QMJIrgrOWG19
 AL6+Bf6WSreqBx/OUNcmZ8aonwJPRYZgHKTZ6zR6m02zilo7g4w7Dhva2AKzeh3jwpKQ
 Aq9536IZIEFxQWfMasXZHL0QrqqobtDER63vCp5LF+X0lMLCuzjC5Eayw9sLREuRTt6t
 SkUA==
X-Gm-Message-State: AOJu0YwtX8y8a0xUtRncECwb7r80JAoL0ILHwCPjJWhbIjyjU7oWjd1z
 +pOZHSu1BR5ABtyPyRR4Ev5tDiwiXGrJ4+Lq3OylSZjNMaQCYfLDYQkJIUVDlDc=
X-Gm-Gg: ASbGnctTFDLIAlI9U2dCT3+EWZzcwwMIdp56M1dyqEZ+K8iMl3NAbhTdvN+EQkGCB0r
 ubRKTO0gzuSSnQ8hfF2JIhvWhWSvRp+Q065T1aD8sDZ1myhu+kK04tZ8qf93DWFLW9MEFokuWcd
 LyrtgxNNTItbtDwlIvuamUg/4J4pTey3mOVAwd29wPi2BO7KeOxUGHAGEE2FAtavaWptRI2676L
 f/+xMwtu/OE//WtEN4COW5+dN3AZjmfnT+FIaFl7ngVBHOvdRUuagAAvRBEk+oqeTAaDsarNVtI
 F2RGM0PQ0u+2hDoJlo6jfwRF5lg0f4tZbHT7XKlUDMqK4Vwns/dZohB0abs=
X-Google-Smtp-Source: AGHT+IGClJ132DbGgNtp8uMwYK+YaLsRKWd6WNyQzPs5H8l3PuNWmwUvVcYRj3/1yCkH+8yxlkV8dA==
X-Received: by 2002:a05:600c:3ba7:b0:435:306:e5dd with SMTP id
 5b1f17b1804b1-438dc3fc40bmr209407195e9.22.1738693073920; 
 Tue, 04 Feb 2025 10:17:53 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438e244f0d2sm202761135e9.30.2025.02.04.10.17.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Feb 2025 10:17:53 -0800 (PST)
Message-ID: <4a2073d0-121e-40c7-b228-d8fb83634061@linaro.org>
Date: Tue, 4 Feb 2025 19:17:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 3/3] hw/acpi: Add vmclock device
To: Peter Maydell <peter.maydell@linaro.org>,
 David Woodhouse <dwmw2@infradead.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Cornelia Huck <cohuck@redhat.com>,
 Peter Hilber <quic_philber@quicinc.com>,
 "Mohamed Abuelfotoh, Hazem" <abuehaze@amazon.com>, paul <paul@xen.org>,
 David Woodhouse <dwmw@amazon.co.uk>
References: <20250116140315.2455143-1-dwmw2@infradead.org>
 <20250116140315.2455143-4-dwmw2@infradead.org>
 <CAFEAcA9CKgumt-6V_EjCipm1DYdYw5GETNoSbUKeRsGEVhNv_Q@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA9CKgumt-6V_EjCipm1DYdYw5GETNoSbUKeRsGEVhNv_Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 4/2/25 14:49, Peter Maydell wrote:
> On Thu, 16 Jan 2025 at 14:05, David Woodhouse <dwmw2@infradead.org> wrote:
>>
>> From: David Woodhouse <dwmw@amazon.co.uk>
>>
>> The vmclock device addresses the problem of live migration with
>> precision clocks. The tolerances of a hardware counter (e.g. TSC) are
>> typically around ±50PPM. A guest will use NTP/PTP/PPS to discipline that
>> counter against an external source of 'real' time, and track the precise
>> frequency of the counter as it changes with environmental conditions.
> 
> Hi; I see this has already gone into git, but:
> 
>> +static void vmclock_realize(DeviceState *dev, Error **errp)
>> +{
>> +    VmclockState *vms = VMCLOCK(dev);
>> +
>> +    /*
>> +     * Given that this function is executing, there is at least one VMCLOCK
>> +     * device. Check if there are several.
>> +     */
>> +    if (!find_vmclock_dev()) {
>> +        error_setg(errp, "at most one %s device is permitted", TYPE_VMCLOCK);
>> +        return;
>> +    }
>> +
>> +    vms->physaddr = VMCLOCK_ADDR;
>> +
>> +    e820_add_entry(vms->physaddr, VMCLOCK_SIZE, E820_RESERVED);
>> +
>> +    memory_region_init_ram(&vms->clk_page, OBJECT(dev), "vmclock_page",
>> +                           VMCLOCK_SIZE, &error_abort);
>> +    memory_region_set_enabled(&vms->clk_page, true);
>> +    vms->clk = memory_region_get_ram_ptr(&vms->clk_page);
>> +    memset(vms->clk, 0, VMCLOCK_SIZE);
>> +
>> +    vms->clk->magic = cpu_to_le32(VMCLOCK_MAGIC);
>> +    vms->clk->size = cpu_to_le16(VMCLOCK_SIZE);
>> +    vms->clk->version = cpu_to_le16(1);
>> +
>> +    /* These are all zero and thus default, but be explicit */
>> +    vms->clk->clock_status = VMCLOCK_STATUS_UNKNOWN;
>> +    vms->clk->counter_id = VMCLOCK_COUNTER_INVALID;
>> +
>> +    qemu_register_reset(vmclock_handle_reset, vms);
> 
> No new calls to qemu_register_reset(), please. This is
> a device, use the device reset API.

Yeah, mentioned on v7 but then I missed this wasn't considered:
https://lore.kernel.org/qemu-devel/56e3ad5c-758b-4799-86a4-bb503aa34cea@linaro.org/

> 
>> +
>> +    vmclock_update_guest(vms);
>> +}
> 
> Can you send a patch to fix this, please?
> 
> thanks
> -- PMM
> 


