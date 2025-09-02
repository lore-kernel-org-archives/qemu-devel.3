Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 424EBCA0FFE
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 11:17:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utP0A-0005yW-Hf; Tue, 02 Sep 2025 07:16:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utP04-0005ws-9V
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 07:16:32 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utP02-0007Jn-30
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 07:16:32 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3cbe70a7923so4115522f8f.2
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 04:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756811788; x=1757416588; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=RGDHzCBOYsTHS9fqqZ1Rw04K0F1XpiSYc7J+ZgyexRo=;
 b=eYgR9T+qQ2lDkBSAM2rVhynpAhx/Z65+DgnYI5gi3uObrOtxvKDWhQKYXwUZWHgiJK
 ag8Tnw/9FkIhD7o+WFJ8frQx+D2AcfonwEBTHyl1LeNX7YqR5seEcjrTEUSs5ebet4fr
 5Y7O/XLN1J7ayg0J23uRbDOvuu0fIaDmIJqI33AMxU6sRimm6TuzXSRMPlRgSEOk3tSv
 dI9BZTLqKZde9CpMqxfc1uWGtqONBduT+dTpXneA5RbUnoEOTltBuPTS8QSmVTQE2QPZ
 yv4PStsqtIx9W3hwP5gTpYjQ1HAq9+hGo0ekm2XQY7QAqCP8YLY2vm1+yG3GiA7o74VB
 qFAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756811788; x=1757416588;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RGDHzCBOYsTHS9fqqZ1Rw04K0F1XpiSYc7J+ZgyexRo=;
 b=HierTonOKYuAASB9cT15xRZ5SDMTXm+ORiPcoVdzWrJeRWoCQUJ9tGkdW3zYEXXVt4
 NBPHbaZ8BvgwHK6SzukifwYVUkVKoVcUszu+xrIEwXTgIW+MMU37zd6lW9dcAk/cU9Vs
 kDX88O7+QrV/b8WcSm8uM0Jldfl/x8/UJay2CYDhtVXiMS9HlQ+uM2lIqVI+yNu1Iy39
 4s+7bhNfYmFVsqJORaRl2w+V7tv0MbwQepjTXqWqrXppEqx5k/755HlAT3JrdKhiC53Y
 qcFq7OMgzM4iNzOz6XJhAmd6ipZkAW53Bt+f33DVq44gMRKQmKTpTdD2hrPL0G6Se4Zz
 AY0Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUT8AVa804yDT/Ztdq1yv2esKtY7kru/LYlqmHGup96M+GVgKpO+HdLfrcjzPh8j97Pa72iTlKxlFN8@nongnu.org
X-Gm-Message-State: AOJu0YyFW7+Te6BaXnHkJoChnGaERCKOlLq42MSeWsBIPj+A0wrguEiK
 EzEGL4tDv7L/h9pdD69Nyg+jcGkq7IQRyugGv3xmeJUm8UXaA7914zOG60oeejpv2tQ=
X-Gm-Gg: ASbGncsvUvCHnmgHr2qsQg7EqSz6K+kAQE5tJ/zT2aTbNSAeoHADBcqgGqCEs2vgBlf
 SieO/BbSU0kPWxEU8ixQoK8S1/KF1Vlc3JTJTJ0CPUWouHDtPv8ihLEP8tOdvsCE89KAnZKvc+d
 p3xF1VWdJIhVDwlrlQvfLkokWU3SkNPTybNeCLqH7rnTNC8Pz6nA9Fj29huZVSG+5KHS+HM9xBC
 qqn4gMFR6rwi/6k25121dvMRRcS228vNwtVov5nz5KYpfFwUPmNxNZLrAYnKyaPDuTu8pRg/SbD
 +9SgiQQyJ6k18kPNjAUkk19VHZ72i5DqlGtvYAxue7KWfm2Wd8pBlYTWKgjxu5aAvb6ODs82NFT
 7Lvkb5QB/atedU5CGVnH64XEnTaEo82sU0RZV6vdIuncZQRuzaJVwzcb6dEALQH4XZw==
X-Google-Smtp-Source: AGHT+IF/eyv23MDTaGUvpk+dDygR696bdyzAikKg6Li8P4ItL5wEUnLCdou2s7bVOb+LET3WIzpk1w==
X-Received: by 2002:a05:6000:40dd:b0:3d6:92ed:cae9 with SMTP id
 ffacd0b85a97d-3d692edce79mr5028072f8f.18.1756811787602; 
 Tue, 02 Sep 2025 04:16:27 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3cf33adf170sm20700601f8f.33.2025.09.02.04.16.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Sep 2025 04:16:27 -0700 (PDT)
Message-ID: <693623a3-8d3b-4a02-98dc-f8859e211338@linaro.org>
Date: Tue, 2 Sep 2025 13:16:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fix: Fix build error with CONFIG_POWERNV disabled
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Aditya Gupta <adityag@linux.ibm.com>, Nicholas Piggin
 <npiggin@gmail.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Chinmay Rath <rathc@linux.ibm.com>
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, Thomas Huth <thuth@redhat.com>
References: <20250820122516.949766-2-adityag@linux.ibm.com>
 <aa71d2dc-ebd8-46bf-8693-4e17da3434ef@linaro.org>
 <4cbbede6-0846-4b22-9bce-ec0bc9888e2d@linaro.org>
Content-Language: en-US
In-Reply-To: <4cbbede6-0846-4b22-9bce-ec0bc9888e2d@linaro.org>
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

On 2/9/25 13:06, Philippe Mathieu-Daudé wrote:
> On 2/9/25 12:44, Philippe Mathieu-Daudé wrote:
>> On 20/8/25 14:25, Aditya Gupta wrote:
>>> Currently when CONFIG_POWERNV is not enabled, the build fails, such as
>>> with --without-default-devices:
>>>
>>>      $ ./configure --without-default-devices
>>>      $ make
>>>
>>>      [281/283] Linking target qemu-system-ppc64
>>>      FAILED: qemu-system-ppc64
>>>      cc -m64 @qemu-system-ppc64.rsp
>>>      /usr/bin/ld: libqemu-ppc64-softmmu.a.p/ 
>>> target_ppc_misc_helper.c.o: in function `helper_load_sprd':
>>>      .../target/ppc/misc_helper.c:335:(.text+0xcdc): undefined 
>>> reference to `pnv_chip_find_core'
>>>      /usr/bin/ld: libqemu-ppc64-softmmu.a.p/ 
>>> target_ppc_misc_helper.c.o: in function `helper_store_sprd':
>>>      .../target/ppc/misc_helper.c:375:(.text+0xdf4): undefined 
>>> reference to `pnv_chip_find_core'
>>>      collect2: error: ld returned 1 exit status
>>>      ...
>>>
>>> This is since target/ppc/misc_helper.c references PowerNV specific
>>> 'pnv_chip_find_core' call.
>>>
>>> Split the PowerNV specific SPRD code out of the generic PowerPC code, by
>>> moving the SPRD code to pnv.c
>>>
>>> Fixes: 9808ce6d5cb ("target/ppc: Big-core scratch register fix")
>>> Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> Reported-by: Thomas Huth <thuth@redhat.com>
>>> Suggested-by: Cédric Le Goater <clg@redhat.com>
>>> Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
>>> ---
>>> Note that while moving the code, the 'target_ulong' type for sprc has 
>>> been
>>> modified to 'uint64_t'.
>>>
>>> Based on the discussion happened on [1].
>>> Requires patch 1 and patch 2 of [1] to be applied, to fix the build.
>>>
>>> [1]: https://lore.kernel.org/qemu-devel/20250526112346.48744-1- 
>>> philmd@linaro.org/
>>> ---
>>> ---
>>>   hw/ppc/pnv.c             | 86 ++++++++++++++++++++++++++++++++++++++++
>>>   target/ppc/cpu.h         |  4 ++
>>>   target/ppc/misc_helper.c | 59 +++------------------------
>>>   3 files changed, 96 insertions(+), 53 deletions(-)
>>
>> Patch queued via hw-misc, thanks.
> 
> Dropping, as it doesn't pass on CI:

Sorry, wrong patch!

> ../target/ppc/kvm.c: In function ‘kvmppc_load_htab_chunk’:
> ../target/ppc/kvm.c:2763:32: error: ‘buf’ undeclared (first use in this 
> function)
>   2763 |     size_t chunksize = sizeof(*buf) + n_valid * HASH_PTE_SIZE_64;
>        |                                ^~~
> ../target/ppc/kvm.c:2763:32: note: each undeclared identifier is 
> reported only once for each function it appears in
> 
> https://gitlab.com/philmd/qemu/-/jobs/11214983966
> https://gitlab.com/philmd/qemu/-/jobs/11214983979


