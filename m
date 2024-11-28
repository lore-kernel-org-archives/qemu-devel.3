Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 513E8D69104
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 13:03:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGeAm-0008E3-Vl; Thu, 28 Nov 2024 08:03:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tGeAK-00085o-Eo
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 08:02:48 -0500
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tGeAG-0002ux-EQ
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 08:02:39 -0500
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2eb1433958dso583595a91.2
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2024 05:02:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1732798953; x=1733403753; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ChZRcupK90z3tHsfjdw/s47aIhOGMbgfXfo7ZaM8Npw=;
 b=R+nqChRTeTD62DohmPEXySL2YcyRP75TjktsuZySnbW5K5Q7Wklk99LTKqCUWItgbG
 +a+nyljqh2qhAXHH7rMGPiK87N7ItAvWdhWItvrdtFHuRdros5eoSNGFr0moXkyZb3Xw
 fUBPZsXhTsX+pr5GKguZ61kEtGYheab9EXZA2+sfnIyXwFLrwjkU/Bch06mHPpUjwGdl
 uy9Y3omHWIbHeKh5xhK8gfOOHJgPAgZmuKNmymTnv4IFQTQfHGnt0z1W7lUopceOnIKY
 dK4V1fRkH8+ZFu2OUIDmAIV2Bnsihjm6eT9OIv/btNLjwXGtoGnkew5Lx18eK68uSpK6
 U6vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732798953; x=1733403753;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ChZRcupK90z3tHsfjdw/s47aIhOGMbgfXfo7ZaM8Npw=;
 b=CFMD5zgSypBtfVe1Nh8zc+6T2E0kY/X9gnS9276/3xQchwqQrk53WftrzU9aHRHOWW
 gowRRkbByLvff788H2I8DzxSW57EN+MJtvdPHFdXoTUt7jVBQ8wRuR96i5+zIZcjhdpn
 riywXbWYQ+lwXVVevdqZXcVVnlOaan6wrFc44bilRMb6sy03MLAloqF9RjfUclWM/W9s
 SoIBkJnXu17PsU/V5wauGkLpONhR1CQKzpBce/hsMcNApouKJz1UJbW9CQepkOUDiK1O
 MLzUuOrrasUkV+XnPfXPHtdkhUn6ZzOYfFQg/gtVkYgdkC4bQWQv2+CkNXC0tqId6YPq
 KSKA==
X-Gm-Message-State: AOJu0Yxh6ZwoQKXAcnd3HBP9NTFSilaljjpdgfp50DhIIpDvAKSMLLRj
 UxFK3umgmRa/PpNw3of17e2lHbX/ES4WsDLBYPmxvRYwwOqySfd8CeefqNYv21A=
X-Gm-Gg: ASbGncuaKDcCt2BEJvT7S7xNlHpqSvNpbar1YN/c0M/fgiEjCCXWz9hs886RG3mfORn
 BBz62U0e0jM6Po4Fvja7kQQt2x/5Huv/qYnK/31LXR5/ObedPXzYoBSei1dyJVpzeSWbZkfsuKM
 oFdUGLqQln7y0gA8Wipu0OrRY3/0OydibDnsfeIW3zwQdqWt6aOq6WQm9jWKvETEC8dyDALKuE7
 Thj6G1vAfHU2s0UZ07ioJyPQhJ0cyU7zjM66s/K1sA2pQ9fudyc09uMOJ3Krs4=
X-Google-Smtp-Source: AGHT+IE3FIy/nwTcOC3MVOp8r2Nh8+b4cfqdG+aveg22eODYB7yGdZrtxwRFRRQQghM1Ipa2CQT7Aw==
X-Received: by 2002:a17:90b:17ce:b0:2ea:3836:33de with SMTP id
 98e67ed59e1d1-2ee08fca651mr10207601a91.20.1732798952888; 
 Thu, 28 Nov 2024 05:02:32 -0800 (PST)
Received: from [192.168.68.110] ([187.101.65.72])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ee0f5b61adsm3411235a91.0.2024.11.28.05.02.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Nov 2024 05:02:32 -0800 (PST)
Message-ID: <1f2a4b6f-7a70-4f61-a073-f6c953003d32@ventanamicro.com>
Date: Thu, 28 Nov 2024 10:02:28 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] include virtualization mode as part of priv
To: Yanfeng <yfliu2008@qq.com>, Alistair Francis <alistair23@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Alistair Francis <alistair.francis@wdc.com>
References: <tencent_6FF30F7E2E640BEE260FD6523B6BA5486908@qq.com>
 <CAKmqyKMP093GyTEHdAPzaV9+O_pFSv0svQRb-31QTvn9i4fxMA@mail.gmail.com>
 <tencent_B97DED0E6971DEDD2F960CC63DFF414A2A05@qq.com>
 <CAKmqyKO6Wjknoc1sXVm6d0BGzwcuF7VBqJdg_a1gh=6zz=KZNQ@mail.gmail.com>
 <tencent_E6B51EACA466D65291C0E6BDFD34C8EADC09@qq.com>
 <CAKmqyKNOXNpfekTPNOyHyYEuCXKOewCeTSFZAHpsxuC7gUzpGQ@mail.gmail.com>
 <tencent_3335F7F1076629E3B507A48979413F43B207@qq.com>
 <CAKmqyKNS3GWKpatFMchYJM31PtgjLn9YX+m_L8Nv=qXNMXhWmw@mail.gmail.com>
 <tencent_F74852576B25481AF3647E0F647DEEEA0F08@qq.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <tencent_F74852576B25481AF3647E0F647DEEEA0F08@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pj1-x102e.google.com
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



On 11/28/24 3:39 AM, Yanfeng wrote:
> On Thu, 2024-11-28 at 14:46 +1000, Alistair Francis wrote:
>> On Thu, Nov 28, 2024 at 2:27 PM Yanfeng <yfliu2008@qq.com> wrote:
>>>
>>> On Thu, 2024-11-28 at 14:10 +1000, Alistair Francis wrote:
>>>> On Thu, Nov 28, 2024 at 2:05 PM Yanfeng <yfliu2008@qq.com> wrote:
>>>>>
>>>>> Alistair.
>>>>>
>>>>> My initial `git send-email" on Ubuntu 22.04 wasn't lukcy:
>>>>>
>>>>> ```shell
>>>>> $ git send-email
>>>>> git: 'send-email' is not a git command. See 'git --help'.
>>>>> ```
>>>>>
>>>>> I need time to find a solution.
>>>>
>>>> You will need to install git-send-email (or something like that)
>>>
>>> Yes, now the "git send-email" exists and I will see how to use it correctly.
>>>
>>>>
>>>>>
>>>>> As for seperate `virt` thing, my concern is that though the V and P
>>>>> status
>>>>> looks
>>>>> orthogonal, they are not so independent (e.g. `P=3` implies `V=0`).
>>>>> Having
>>>>> them
>>>>> in one `priv` register tells user that that they should be operated
>>>>> together
>>>>> using one command.
>>>>
>>>> True, but how can a user know what bit 8 means?
>>>
>>> Good point. Can we mention it in the user document for `priv` register?
>>
>> AFAIK we don't really have a place to document that. Which is why a
>> "virt" register would help as it's self documenting.
> 
> Okay, I will try adding a `virt` virtual register in a [PATCH v2] later.

Can you please also change the patch title/subject to:

"riscv: include virtualization mode as part of priv"

Adding 'riscv' at the beginning will help people from the common qemu-devel ML to
identify which subsystem/arch this patch is aimed at.


Thanks,

Daniel



>>
>> Alistair
>>
>>>
>>> I used bit(8) at my first try and it worked from GDB command line. Actually
>>> I
>>> also tried bit(4) but found GDB command takes that bit as part of P value so
>>> I
>>> withdrawed back to bit(8).
>>>
>>>
> 


