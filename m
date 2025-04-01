Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5496C36010
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 11:04:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzZPQ-0008Pe-Rv; Tue, 01 Apr 2025 07:03:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzZOR-0008FH-Ts
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 07:02:59 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzZOO-000172-Tz
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 07:02:55 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43d07ca6a80so28401875e9.1
 for <qemu-devel@nongnu.org>; Tue, 01 Apr 2025 04:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743505366; x=1744110166; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zYSuvZtNvmb2BkNKFiqLL6cd7zzg0fz+TLb29Cx/k+8=;
 b=OexVYvevXE8d2DDWaIBlVOi5+YKeQ1FU+X1V2TVUPLvLxUzwHXNrZKVDBt2Oe4PXV2
 B9xATg+cho49DTF60pXsS8UACqv9iQg96gaginI9CG4nkf/W3FaNVQPkYFSM9+qNuHtt
 gU0wQek+GH1UmBCUAUSGf+ETStD2Ymm2XWNmcFkkyYj9uvAp/E96PBFUnaLyS3uKuSXC
 O6lBUcP53bFQX8l/pFvnp/nS5cKaK+APeXlkvuIw1tfczHkoxXrfAPvKDz/NIZW8UDvX
 Cydaw2JeaCwjQhYLTxt8XpkX9LBccK4wFfLCs5dIk9YHTFVog4HeFeh2tjvwOY6PkNVt
 +dsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743505366; x=1744110166;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zYSuvZtNvmb2BkNKFiqLL6cd7zzg0fz+TLb29Cx/k+8=;
 b=hrDvOlkWG4SaJEaQfCNd/tZlySF2RhA2oeE1z/nkYdFK/cB0iu914x9eHuSJ3224i6
 1xGWDhS6/O5smQZao4IVAuaBgLH+IkMdgkRnplwCGcvrV8b9PkYOkcjobkff0wEJdT80
 3plrIAMadTg40YT/z+qK02PL5gBdtIilQqFOmZjqZ6WAQ+UB6liw5fdfsl34rBhArskL
 WY1gTW5FdFIuXP4gavZN4ZFVi7gpAyzOpQqtgn1v7Quy13xgH5JQR/59z/Jcfct4YPT6
 eYzKc4GVsk48jW45+svvNqZ9mf0uH/ij9yJjYKK1fzigF6zMRS+WA1DWxmYPd7YKV4Kj
 9gqQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMup1oRDm7e6E4NBn0RTHzUhQVgFod5kbFXq82ccDbACmtz65EKfLKOSRfuGRLRJFTrlYzlfpty7hr@nongnu.org
X-Gm-Message-State: AOJu0Yy2uikg2aQmiqB8rkemwgWLy/4rgQ9lhIcumxK9HkWg6M7w0l5K
 CkHGG/BgMSbrWv+POa3WDpg2ahaIGoh6BxqVMF78h6nPfxNibwVrE5bLObSrUTc=
X-Gm-Gg: ASbGnct7NjYnqiqAGDoGOCwI/GvkS8s306h1bwO3f6WU1xvP4EpvAIdDhtzMP/13whe
 QqYNIOJbkibuZVNEyyWfKftP1JFLLgM9Oeo5ck2c8QFUmhh/pY3/NikqP38WvQvDPxTCQZxM4Yl
 MDccRJSq13AAjuWy04YmjaX9xEmIbeFrgqbdglY7PnCCquCJRAY6lH+TaVkg0cGamEWr1YxOw+4
 6aN8Fn0K0nAXtI/QqbycCcVVloHaSOVm2cOvZvTx6CAsryNeGjGQFH6Jy0MVJZnb7iDvR7EAmoG
 BaRiXlODThAwtyC8WMMnbeZh8Zib5H8hcwX5uLeAEYrY3tqghhBwABWKTcOIpFZ22x5VSPQKJf1
 JhIdAO219wFBp
X-Google-Smtp-Source: AGHT+IFN/LPuJR225bWp1gMZtYLsZWl9lbfvTAgF8RiTMOvsE5xy2wFF7ZeUYKr2405gxKux9yt3vg==
X-Received: by 2002:a05:600c:1f8b:b0:43c:f332:703a with SMTP id
 5b1f17b1804b1-43dbc6fb97fmr126138175e9.31.1743505365692; 
 Tue, 01 Apr 2025 04:02:45 -0700 (PDT)
Received: from [192.168.69.235] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d82e6a63esm197120435e9.11.2025.04.01.04.02.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Apr 2025 04:02:45 -0700 (PDT)
Message-ID: <d994ed32-472f-4cfb-9177-c92fc4d18690@linaro.org>
Date: Tue, 1 Apr 2025 13:02:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] target/ppc: Deprecate Power8E and Power8NVL
To: Aditya Gupta <adityag@linux.ibm.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, Thomas Huth <thuth@redhat.com>
References: <20250329142641.2502003-1-adityag@linux.ibm.com>
 <9eca6d79-7910-43df-850a-bc55a701d964@kaod.org>
 <fk3bm7neihwf2dkvgpw3xjdjdvds7ajxl5xy5t5ve23czxuzgm@6sh5sqglvf6z>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <fk3bm7neihwf2dkvgpw3xjdjdvds7ajxl5xy5t5ve23czxuzgm@6sh5sqglvf6z>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

On 1/4/25 12:01, Aditya Gupta wrote:
> On 25/03/31 08:41AM, Cédric Le Goater wrote:
>> On 3/29/25 15:26, Aditya Gupta wrote:
>>> Power8E and Power8NVL variants are not of much use in QEMU now, and not
>>> being maintained either.
>>>
>>> Newer skiboot might not be able to boot Power8NVL since skiboot v7.0
>>>
>>
>> It is worth mentioning commit c5424f683ee3 ("Remove support for
>> POWER8 DD1") too. In fact, I prefer the cover letter section below
>> for a commit log.
>>
>> This commit log is not mentioning the introduction of POWERPC_DEPRECATED_CPU.
>> I suggest adding an extra patch for it.
> 
> Got it. Sure will include that mention in patch deprecating 8e/8nvl.
> 
>>
>>> Deprecate the 8E and 8NVL variants.
>>>
>>> After deprecation, QEMU will print a warning like below when the
>>> CPU/Chips are used:
>>>
>>>       $ ./build/qemu-system-ppc64 -M powernv8 --cpu power8nvl -nographic
>>>       qemu-system-ppc64: warning: CPU model power8nvl_v1.0-powerpc64-cpu is deprecated -- CPU is unmaintained.
>>>       ...
>>>       $ ./build/qemu-system-ppc64 -M powernv8 --cpu power8e -nographic
>>>       qemu-system-ppc64: warning: CPU model power8e_v2.1-powerpc64-cpu is deprecated -- CPU is unmaintained.
>>>       ...
>>>       $ ./build/qemu-system-ppc64 -M pseries --cpu power8e -nographic
>>>       qemu-system-ppc64: warning: CPU model power8e_v2.1-powerpc64-cpu is deprecated -- CPU is unmaintained.
>>>       ...
>>
>> This is not very useful and it belongs to a patch adding
>> POWERPC_DEPRECATED_CPU.
> 
> Got it.
> 
>>
>>> Also, print '(deprecated)' for deprecated CPUs in 'qemu-system-ppc64
>>> --cpu ?':
>>>
>>>       $ ./build/qemu-system-ppc64 --cpu help
>>>         ...
>>>         power8e_v2.1     PVR 004b0201 (deprecated)
>>>         power8e          (alias for power8e_v2.1)
>>>         power8nvl_v1.0   PVR 004c0100 (deprecated)
>>>         power8nvl        (alias for power8nvl_v1.0)
>>>         power8_v2.0      PVR 004d0200
>>>         power8           (alias for power8_v2.0)
>>>         power9_v2.0      PVR 004e1200
>>>         power9_v2.2      PVR 004e1202
>>
>>
>> ditto.
> 
> Got it.
> 
>>
>>> Suggested-by: Cédric Le Goater <clg@kaod.org>
>>> Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
>>>
>>> ---


> By PowerNV deprecation, you mean Power8E/8NVL CPUs right ?
> 
> Like there's no powernv8e machine as such, and powernv8e chip doesn't
> have a way to deprecate. I can add a 'deprecation_note' kind of field,
> but feel that is unnecessary, as it only gets used when power8e CPU is
> used, which will show one deprecation warning already.
> 
>>
>> Also, we have time : the QEMU 10.1 development phase has not started
>> and the soft freeze should be around July. No rush needed.

Pre-release period is normally OK to deprecate things (Cc'ing Thomas
in doubt...).

