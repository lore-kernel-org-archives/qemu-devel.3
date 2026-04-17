Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0B7BF8E4A7
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 05:48:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDc3f-00062T-Py; Fri, 17 Apr 2026 01:48:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wDc3d-00061e-GX
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 01:48:01 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wDc3b-0008TL-HR
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 01:48:01 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-43fe3e22e33so146391f8f.0
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 22:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776404878; x=1777009678; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XXjq9ejdu5k6sUuk7LPq/RN7D4LkGE+7//qIR7WGWBU=;
 b=k+2doz6d1v5h5kHfCOy8emHWz6Gj+32B1/XuSCjC0FLc4W9Nwn3RibuBVIx7OtIKAw
 qnL++OavxdbWcWtMfTG3/6kjOabGz/mK9++pLj4sg+l6ZL/lnHIAMLVGzgqBgwaGzjTw
 kfMkvDKjJBifROxU3kwGdi1TmT5eD+t8FO/RVtXYIZI6UG+teFrUHy54+3ZNQU41pqwV
 HGbql9nG9sikkpbx+PFLwj0MFPEeJrypcs3zmWqnsc0ATveBb/BMfLs2YxCArAJlHgX6
 NFoH9FFU3yeWkjGg3adgEmbRmlWqi49swaRrba0Fw2aiA1CzvbeFePRv2oyD4UfxudUV
 UAMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776404878; x=1777009678;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XXjq9ejdu5k6sUuk7LPq/RN7D4LkGE+7//qIR7WGWBU=;
 b=qym+D4fMNVAc36Yp54RGYEqQeie0ByFspKPwDjSqiBum0Z0SG5uTWVuTBOD7fWOzsk
 +t1LH9ZGYbW5iz3BetFazPQGR80Z8UVzNdMr5nRqW8I884vcYfPtgQCqDM6dM6/o74kh
 iPG313v6jRlssYzW1oanjxdIoe+3YRW87/QWt2IvFP6t3pzUSX0VYvu06vVmTztACcn2
 wXNRbpuOFPSWqyIm4Rtyri7eRkjOC3jbiyWI+CZy2qg5dpRbGgMa0eKLJHUxM0RkFB78
 rjmNH9BL9ZMo/iV3EA72tPYZW1Cik28KhkEJ9ksQ6qjhkrFg4/+Jx4e51RCT4u8CEPnK
 DcyQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8vM4SeJ6hRR2stzJhvLy087AcG9Cvauc1EBJNz4KVxZIEaDDa+HxR16oCoPO4ueMbhmo8k9EfDPaR5@nongnu.org
X-Gm-Message-State: AOJu0YyLS1viQ/aAV+lknH+DX8iAFBZahfGZfaGnb7NoI9iiQmmLdQKS
 OdvdF9QOZP7XzOJeJ5aEmgFvJk0eae/+XbLqNmZX0bCFEmcVAAjuIYwE6Ztl521icDU=
X-Gm-Gg: AeBDiev3wVZbE1k0df7CQQ+aXLglsmFmoOBJPDdOUyL81py3tTf+uJE+i/s+bPLhAxf
 N9TZsPxv44xDCctZMlHlf3nemuWtwnJCzNBFuUjYaa9KRzLGMRPvy8ErBhI+E8S/2PSJa5BCAOD
 6e/8wFQnVgFnxQTsb+Cbn4AAMAm07hSDM2H1ix9fIeMAc12ocxK6KBy2NPauD00QoM5jfdvuBVS
 hFLMmzZjq/zgRzX9UvGOVu/QyD1M5gp/R5MFt+qAhCmBPR23QRADkFKsEiNMNvbUfxTbGlgNhGj
 TMNt1KazNlaC1g75BKe0ALZ1EVs1TKOSNUXD9enYh6jvraQWlIUCjLLe9YIdIAli0itgzjChs5o
 yMXNuN33l8FL6uU/l1anK+y4wJOedq1/FwOVhWGfOU/M4nejO5fQO/sYKgovbACVGf4ajRncQyE
 4NcOqHs9Yfo94yUOrrcyivHCyGA4kfLzkmtmf0CYDAwS6vkSjuNVmBvD7BZ3NsL1R2hIXr/P10e
 5lo
X-Received: by 2002:a05:6000:2307:b0:43b:3e40:2223 with SMTP id
 ffacd0b85a97d-43fe3dcc52cmr1822448f8f.19.1776404877625; 
 Thu, 16 Apr 2026 22:47:57 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e3a7b4sm1690546f8f.22.2026.04.16.22.47.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Apr 2026 22:47:57 -0700 (PDT)
Message-ID: <649073ae-7135-47df-a3d7-fd032b1a5fc1@linaro.org>
Date: Fri, 17 Apr 2026 07:47:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 8/9] hw/hexagon: Define hexagon "virt" machine
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: ltaylorsimpson@gmail.com, matheus.bernardino@oss.qualcomm.com,
 marco.liebel@oss.qualcomm.com, quic_mburton@quicinc.com,
 sid.manning@oss.qualcomm.com, ale@rev.ng, anjo@rev.ng,
 pierrick.bouvier@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>
References: <20260416210305.2255579-1-brian.cain@oss.qualcomm.com>
 <20260416210305.2255579-9-brian.cain@oss.qualcomm.com>
 <edb437fa-66b4-43f2-bf88-1ccf8ea5d3e9@linaro.org>
In-Reply-To: <edb437fa-66b4-43f2-bf88-1ccf8ea5d3e9@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 16/4/26 23:32, Philippe Mathieu-Daudé wrote:
> On 16/4/26 23:03, Brian Cain wrote:
>> From: Brian Cain <bcain@quicinc.com>
>>
>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>> ---
>>   configs/devices/hexagon-softmmu/default.mak |   1 +
>>   configs/targets/hexagon-softmmu.mak         |   1 +
>>   include/hw/hexagon/virt.h                   |  43 ++
>>   hw/hexagon/virt.c                           | 456 ++++++++++++++++++++
>>   target/hexagon/cpu.c                        |   2 +
>>   hw/hexagon/Kconfig                          |  10 +
>>   hw/hexagon/meson.build                      |   2 +
>>   tests/qemu-iotests/testenv.py               |   1 +
>>   8 files changed, 516 insertions(+)
>>   create mode 100644 include/hw/hexagon/virt.h
>>   create mode 100644 hw/hexagon/virt.c


>> +    gsregs_dev = qdev_new(TYPE_HEXAGON_GLOBALREG);
>> +    object_property_add_child(OBJECT(ms), "global-regs", 
>> OBJECT(gsregs_dev));
>> +    qdev_prop_set_uint64(gsregs_dev, "config-table-addr", m_cfg- 
>> >cfgbase);
>> +    qdev_prop_set_uint32(gsregs_dev, "dsp-rev", v68_rev);
>> +    sysbus_realize_and_unref(SYS_BUS_DEVICE(gsregs_dev), &error_fatal);
>> +
>> +    tlb_dev = qdev_new(TYPE_HEXAGON_TLB);
> 
> Where is hw/hexagon/hexagon_tlb.h?

Found it in "part 1/3":

https://lore.kernel.org/qemu-devel/20260401152657.314902-35-brian.cain@oss.qualcomm.com/

> 
>> +    object_property_add_child(OBJECT(ms), "tlb", OBJECT(tlb_dev));
>> +    qdev_prop_set_uint32(tlb_dev, "num-entries",
>> +                         m_cfg->cfgtable.jtlb_size_entries);
>> +    sysbus_realize_and_unref(SYS_BUS_DEVICE(tlb_dev), &error_fatal);

