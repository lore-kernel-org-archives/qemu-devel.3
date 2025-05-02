Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0702C3ABAA
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 14:59:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uArqR-0003Q8-0f; Fri, 02 May 2025 10:58:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uArqO-0003Oc-Qj
 for qemu-devel@nongnu.org; Fri, 02 May 2025 10:58:28 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uArqM-0002rn-Ij
 for qemu-devel@nongnu.org; Fri, 02 May 2025 10:58:28 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-acbb48bad09so373304366b.0
 for <qemu-devel@nongnu.org>; Fri, 02 May 2025 07:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746197903; x=1746802703; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=J8YzoanIk5Tc3h7ufmslO4S+l5crv4KBw80pyEGyvdo=;
 b=o831xw2e6pPYej0ygl1BmFFjbgIzKSuU5tENzQIDiCVOjCf50egyiXqno47QpKgj/t
 WExthDr4TGZp5Fh87otuiOqQfPFO278n7QUyUIXrHJfhAg2sFcPn/OiP+WW49zRUFwex
 PocRDHs30fBotErmrij+9B1nzxwNR4wCkM8IPqAiCfvtfvAA9AN9hyybAmyoe2ykffZv
 SqwiNZcEazWtzF4Om3Pn9mdydybxZoTJq4woo5UMUUSJD0m+LfDntk5IW8GJsNuqJOIG
 5CZ46ceNvrFBtzuKA+B3YUBrCbcshQP6Au25CYcvhSud1FYus3m0qPjjISgIMJJ0mYCX
 52MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746197903; x=1746802703;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=J8YzoanIk5Tc3h7ufmslO4S+l5crv4KBw80pyEGyvdo=;
 b=rPOMxJq+1rqteLOHUxhgLcEKeoblMwlmdZLH5ckdp18CMsEL2N7HBFanOZAnMQ1CmL
 i4fpbf140NkUA0nBKNmnAy1ghQHGjjbj/2noLwTMky9+LJfDwTuwTaw/RXEYeiYxf7sJ
 MzMSwt8TYQwVHbjnar4DAOZDS/sC2nlQikJT5OqB8DZQN3PMpm4tmVe5Z76ep00tlpPb
 x/X52dUMwnt62myflXLCrG2Qbi4Ni4R3P9IINd+I1e+2Rw5XlsJLZLwMHxcLLFQD3mtO
 dwPTLueEtScswQbblFNmq9ppnpoLgQ/NgAIsjHKHjdDEVKiLDiiWrGsJLHZxJidJnkOi
 43Dg==
X-Gm-Message-State: AOJu0YzjtOJIIao4Aqn+55YTIMLgLEPnw48l0sKI8B1oSodOGL3GSQd5
 quvwjInGIgQLabGBKWbC8FTx52dkUrAR30+yzi06mCHCimW8ZnskDSlU3bokfqACg9YX/XZXPGC
 u
X-Gm-Gg: ASbGnctD6k3ZW47qxYCu8i0IlMNHkP8l2z0YYczauwfQV9EAcqTVgm4SVK1FJHJId1v
 QRdAA1CKgTvwCNP49Gc7DhlbNZzBg87sCPlopjdePdkj6FMeKDOZfnf8FX2z3ughlE9W1/4Arfn
 5JwxMVbA5fNMlSSrxeu2pgqM8p8k+guqusbxxflm75Qt92xs2dcIwjFC8/Mu9OiIDqRqodemVn7
 mp15njwcAzCpMPhgjZupGPypmZnpy6mrYav24sOMUc9kLyocpuWNoshOtiKYqsHiTp05kt1yH+v
 /CmDo4Xf7WaAFJchGzdek8CLwIB8fc6fm8AfDcBUqthKeNSMJNZiUnNy7ZHbtJknbX85y/VbcJG
 VIwxmBSw2
X-Google-Smtp-Source: AGHT+IESGAHOjKyvHEicqbK35gMlhd0KHndF1neEyMssJpffZrvCQvz9m5fNRsBd1AVqM3MFSCP3AQ==
X-Received: by 2002:a17:907:9998:b0:acf:8d:bf9a with SMTP id
 a640c23a62f3a-ad17aefcb1fmr303274666b.47.1746197903199; 
 Fri, 02 May 2025 07:58:23 -0700 (PDT)
Received: from [192.168.69.244] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad1895087f4sm59030966b.134.2025.05.02.07.58.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 May 2025 07:58:22 -0700 (PDT)
Message-ID: <c25fad27-df4b-4eba-9dff-217b0ca18941@linaro.org>
Date: Fri, 2 May 2025 16:58:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 v2 00/13] hw/arm: Remove virt-2.6 up to virt-2.12
 machines
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>,
 Andrew Jones <ajones@ventanamicro.com>, Thomas Huth <thuth@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>, qemu-arm@nongnu.org
References: <20250116145944.38028-1-philmd@linaro.org>
 <CAFEAcA_7KfbhMj4c=HD4m+xivTK4NZcYc0O4NXt6MtVJ6bSitA@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA_7KfbhMj4c=HD4m+xivTK4NZcYc0O4NXt6MtVJ6bSitA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x632.google.com
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

On 2/5/25 15:37, Peter Maydell wrote:
> On Thu, 16 Jan 2025 at 14:59, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> The versioned 'virt' machines up to 2.12 been marked as deprecated
>> two releases ago, and are older than 6 years, so according to our
>> support policy we can remove them. Remove associated dead code.
>>
>> Since v1:
>> - Corrected disallow_affinity_adjustment removal (Thomas)
>> - Do not modify docs/about/removed-features.rst (Thomas & Daniel)
>>
>> Philippe Mathieu-Daudé (13):
>>    hw/arm/virt: Remove deprecated virt-2.6 machine
>>    hw/arm/virt: Remove VirtMachineClass::no_pmu field
>>    hw/arm/virt: Remove VirtMachineClass::disallow_affinity_adjustment
>>    hw/arm/virt: Remove deprecated virt-2.7 machine
>>    hw/arm/virt: Remove VirtMachineClass::no_its field
>>    hw/arm/virt: Remove deprecated virt-2.8 machine
>>    hw/arm/virt: Remove VirtMachineClass::claim_edge_triggered_timers
>>      field
>>    hw/arm/virt: Remove deprecated virt-2.9 machine
>>    hw/arm/virt: Remove deprecated virt-2.10 machine
>>    hw/arm/virt: Remove deprecated virt-2.11 machine
>>    hw/arm/virt: Remove VirtMachineClass::smbios_old_sys_ver field
>>    hw/arm/virt: Remove deprecated virt-2.12 machine
>>    hw/arm/virt: Remove VirtMachineClass::no_highmem_ecam field
> 
> Applied to target-arm.next, thanks (with the tweak RTH points
> out to avoid a compilation failure in patch 3).

Thank you for tweaking :)

