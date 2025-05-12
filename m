Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A097C3ABC3
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 12:43:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uESUO-0002Xt-K4; Mon, 12 May 2025 08:42:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uESUM-0002XX-U1
 for qemu-devel@nongnu.org; Mon, 12 May 2025 08:42:34 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uESUJ-0004Ut-Po
 for qemu-devel@nongnu.org; Mon, 12 May 2025 08:42:33 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43cf05f0c3eso26809625e9.0
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 05:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747053748; x=1747658548; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=5+TnG5LQAlKBg5fC8esBDA7aRIaLjjVKcVIqX6VMLvE=;
 b=U0gIOoEyuItHSSdQrR7atX6AFxZqcvwR59yflY0UQiNVY9QwMzcOU09oz+bBHMm+Xx
 B5ritOVAIn1mzinoyWDbyOqRHhRt+1ZgWGEOvnx4q8Q7TtnPjjRxF12bCuYlYaHxhE6F
 vhj4szOvjuvI0GKcKpsKSrDtH1tCqMsmd7+9l0ZPpqkVqguIJKUh6hpsi6ssB96ZXPhP
 1PdpVymH+ZVXLF0sidlQXk4qRa/yxhqr7ieNA761nrHOMWMO/AtiXdW+d2zIGAsOXbRU
 D373EoDhqpWA5NNfrDZuzaWaoFTBmgrWjZB4LonFlEJtMxOhmD7rk4q1Mr8FhjrfxHie
 GpnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747053748; x=1747658548;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5+TnG5LQAlKBg5fC8esBDA7aRIaLjjVKcVIqX6VMLvE=;
 b=pFh/v4QZiyjn7SPRtu0tjUTEsV/UOdo2jUZxRyikhDtWcRRL9oRS+dXHG/K99H3XCR
 7DPlCGtsXc4SB68/nRGTnhfZkkoKifP+gK7p0WlqwEG4o0v9DdiG1Y9AInxgUj1kAJFx
 nPBzdD6MrZIZmUDIjshWQxOrP9nat+SNudokwiWu8/xCWtMRr+cEvtBE3KgoNehceVEf
 b37DeLvoUqHcVNiW9N3mepxkl/OroiuY8NsVoke0DBhO5AvlZRy8xhQr3XbdzKcAKAld
 PMkyxU4VAZr+2Swi1GgKCT9z6jzLYAQIeD+wTcr9xHoBr68xAUuaT93hqriCefZYmB9c
 GVMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWK3Cs1YDpJV35NU/RZNCUuHIycBWGvoGzFCOxdcFbxHFn3XcUk3MiiN0U71jfpCyiRVT2r45UNtQzE@nongnu.org
X-Gm-Message-State: AOJu0YwWLH/ko3kuBqwzXIs2ccXIV4pocYoPlUnLN2DTZyLEDJDZw4N2
 2ZAPhgQAkmjdTn90Va5mQ0RsegNkN+Kmb6j3yUEmFOq9NdGKctOzHugpyHKt41g=
X-Gm-Gg: ASbGncskH/OLif3dGjzirSijJzHwQknujwegm55YZYjMW/an+JsrqDxyNitwqGNAm4f
 ksoNOM3geZ/JQVFRhYbfm5v98BpRk/AKvNrMjsezxXK9z0MeLs1jN0+15djQo/qtVGSXLFhrfuj
 VyBKwmq7VjzEs4ywPvLCHUGD2uUPnKeQp5TAJUyNTI7/w2IG0IfqZa7HKM2qKzBdnifNy8s2epY
 ooG/SrNgGpq6NPUh4K4GPbhtpTZttdSpWEm7VLIPDTKRQv0h+h7z/ENMMrww76PRKWbmahRa6Dt
 y+mdpRAADZ98huX08LCT7Xas9aZ0gf200w2ehInaa7iaCGH/ysFOiOsiHCv+B7MK8IuD08ubtpf
 NGymvKkGx9y5UoDyJF8sfnys=
X-Google-Smtp-Source: AGHT+IEhbq9ZU2isMItL5DyLOHQUhD2LySNhNiSuglUIKU9atxrnW11vrpmPVr88IRQo52W+OIhnOQ==
X-Received: by 2002:a05:6000:2582:b0:3a0:aee0:c640 with SMTP id
 ffacd0b85a97d-3a1f64ae206mr8518039f8f.56.1747053748039; 
 Mon, 12 May 2025 05:42:28 -0700 (PDT)
Received: from [10.93.5.179] (110.8.30.213.rev.vodafone.pt. [213.30.8.110])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a1f58f2fe6sm12613858f8f.58.2025.05.12.05.42.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 May 2025 05:42:27 -0700 (PDT)
Message-ID: <9b2e6fa8-30f2-42ef-a6d6-86c6500a9718@linaro.org>
Date: Mon, 12 May 2025 13:42:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/functional: Add PCI hotplug test for aarch64
From: Gustavo Romero <gustavo.romero@linaro.org>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: eric.auger@redhat.com, alex.bennee@linaro.org, philmd@linaro.org,
 peter.maydell@linaro.org
References: <20250509232156.106465-1-gustavo.romero@linaro.org>
 <80e7eacc-0b71-4e1c-981e-607a4ce8a7bd@redhat.com>
 <e25812d6-cc1d-4727-b24e-208dbbe54afa@linaro.org>
Content-Language: en-US
In-Reply-To: <e25812d6-cc1d-4727-b24e-208dbbe54afa@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=gustavo.romero@linaro.org; helo=mail-wm1-x32e.google.com
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

Hi Thomas,

On 5/12/25 09:08, Gustavo Romero wrote:
> Hi Thomas,
> 
> Thanks for the review.
> 
> On 5/12/25 04:59, Thomas Huth wrote:
>>   Hi!
>>
>> On 10/05/2025 01.19, Gustavo Romero wrote:
>>> Add a functional test, aarch64_hotplug_pci, to exercise PCI hotplug and
>>> hot-unplug on arm64. Currently, the aarch64 'virt' machine uses the PCIe
>>> native controller and does not support ACPI-based hotplugging. However,
>>> since support is planned, this test sets 'acpi=force' and specifies an
>>> EDK2 firmware image in advance. This is harmless and prepares for future
>>> ACPI support.
>>>
>>> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
>>> ---
>>>   tests/functional/meson.build                 |  1 +
>>>   tests/functional/test_aarch64_hotplug_pci.py | 73 ++++++++++++++++++++
>>>   2 files changed, 74 insertions(+)
>>>   create mode 100755 tests/functional/test_aarch64_hotplug_pci.py
>>
>> Could you also add the test file to one of the sections in the MAINTAINERS file, please?
> 
> Any idea under which section I should add this test?
> 
> Currently, it's only TCG, but in the future probably there will be
> 1) a variant with --enable-kvm option and 2) it will have a variant
> with ACPI enabled. Hence, currently it doesn't seem to fit neither
> under "PCI" nor under "ARM ACPI Subsystem", I think I can create a
> section tho? Maybe "ARM PCI Hotplug"? Could you please advise?

Well, I'll introduce all these variants into the test so I created a new
section "ARM PCI Hotplug" and added me as the maintainer. When I introduce
the variants I can change the section name to fit it better.

I just sent a v2.


Cheers,
Gustavo

