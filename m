Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80CD0D74974
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Dec 2025 09:52:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWX9T-0007Os-3h; Fri, 19 Dec 2025 04:51:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vWX9M-0007OQ-Or
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 04:51:52 -0500
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vWX9K-00072E-2H
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 04:51:52 -0500
Received: by mail-pl1-x641.google.com with SMTP id
 d9443c01a7336-2a1022dda33so13620765ad.2
 for <qemu-devel@nongnu.org>; Fri, 19 Dec 2025 01:51:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766137908; x=1766742708; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bm3wgVS0HYxlWO7oloafBAqTPQhUnbN5z2RWGNLIccM=;
 b=aNcpJvQBcWMa1uwMB5VkbwwczT+7tglBAnhatSFEr7wb5jLFJZ638/ZY+hOWI40CnQ
 Q3q7SCD6EXjRjNiirbRdKpOlKsE1DOa2/99N0du6drJ7fBjGCdwAnniDvvxR3QqBbRpd
 R6eQ9Wx4itxlWgGr55IGFYAwNK/4TCXqL2mf/ad7lntPHrynsNQ2Q+f845f1oOBVHSS3
 MGUGYYvDbgkmqh4/5kcQo0Umm5yiiTmghZs1lSRhheJmWSwypIVD01cIGwsw0qkup43F
 64qYrcZAc0dO47kG8ozfMyWg3/Ri/oJDnIEphvCbpGMivigRbpFoZ9sRaRFWaUftbI+t
 4JcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766137908; x=1766742708;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Bm3wgVS0HYxlWO7oloafBAqTPQhUnbN5z2RWGNLIccM=;
 b=HexFf2fxqJ952czgGA5lLfm4/YxMFYTmjC5mU1z33otT2qWyxs5Twkr52V8uFuc3bk
 m/iubt0JZw93yY/a2G0Ax/EQSlyuYXTrIM/aSbkGRd7xHOC9VgbwtyG2nwkgs5aGjlIR
 CTuZHBwMO0X5ariGtzstijpn7+EbTPAYIkHptAmW218jztZMI04Vs17BtSRzyPH7ZOjY
 LcnriVvioUFMWIh5O1x21+yBetdTelBiZ8QvpvDjH7bINZFOUtB4UR+lx8+s9v4VvTb7
 Q3QHuR7vikv4M6xy6SHoLNGDU5nr8e+0lhy6fNojLNyu49basIiNKUI89dKyPduaRlp5
 of9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQwMZfMOmbcN3uReRleE+zks4GmzIUfFvXNv7zNakrItzr3GFGDuH3OFyHVgPKvuar+RnozsUcz+7J@nongnu.org
X-Gm-Message-State: AOJu0YzB7y9t+C1eSicfV0Gr9QN5W7n3umyXEqz7AcVSlEt4WZEjEMco
 GvFzr1kupRDzWjKpJeDltrWrAoQNAXu68AWlBnF4SiPp86G9izM/y5tXUgfkVtV42wo=
X-Gm-Gg: AY/fxX7ZmxxQq8Rmy9L3JczZu0h+0H7OAKcVWujai54W08fj+aIOJa1s+0bFcrUmqRC
 ChRRYVMPiY1fpQ6v7lH+NBZ6U64yDx3O/AVKgr5bUZK86+G4W0BwtIhhqW+1fVxbD4XaXA1GmJ3
 FSHS1vLQ2EZbMPZtorQ90VGWbVdS07T6IgFW1ApLrWFoLlFIQuPDB9hw7j6wIAI7jlkxyUTsLT4
 biBYgXqbAjIFYIwqJA0BaNj9XuWcj/rZ3xd48VJXcb/z5CFQnMBBB3gdkyM0dPqnTaBcAGP00x0
 CL7TnXoW+WE3SmMw18DzaNHUEWy5HQGn+80PPR8sVhcjUV2EH6AFZqMPZXo0nQClJsYRP9PPBSl
 v5y5wTcTCMmeuokTCzDFwPqm47wIY1Udg5pQ2jI7We+h5qjBuPz3KAF4yui5PSqCRtD4UdhGkxR
 06tXPpvNDy4bgjA6Nc77WpkXIoql2wQyw=
X-Google-Smtp-Source: AGHT+IENS3mWGghjteG3nqTfbLBbbpo/pm3s62MeoFw7EjKWb1iMJXNRM1aTX0X9pt79mwcQ1+QiYA==
X-Received: by 2002:a17:903:2f82:b0:2a1:10f7:9717 with SMTP id
 d9443c01a7336-2a2f2c4cea2mr22406745ad.58.1766137908482; 
 Fri, 19 Dec 2025 01:51:48 -0800 (PST)
Received: from [127.0.0.1] ([218.81.29.112]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a2f3d4d869sm17890675ad.53.2025.12.19.01.51.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Dec 2025 01:51:48 -0800 (PST)
Message-ID: <36bf317b-3760-436c-9e5f-8afd32196b76@gmail.com>
Date: Fri, 19 Dec 2025 17:51:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] RISC-V: Initial support versioning of debug
 specification
To: =?UTF-8?B?QWx2aW4gQ2hlLUNoaWEgQ2hhbmco5by15ZOy5ZiJKQ==?=
 <alvinga@andestech.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "alistair.francis@wdc.com" <alistair.francis@wdc.com>,
 "bin.meng@windriver.com" <bin.meng@windriver.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>,
 "liwei1518@gmail.com" <liwei1518@gmail.com>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "vivahavey@gmail.com" <vivahavey@gmail.com>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>
References: <20251201014255.230069-1-alvinga@andestech.com>
 <0e543e10-970d-4a7c-aa79-d3a0a6358e72@zevorn.cn>
 <SEYPR03MB670057426CD1F169681C54C1A8A9A@SEYPR03MB6700.apcprd03.prod.outlook.com>
 <625299d1-b04e-4c8e-8e96-8f353510ad3c@gmail.com>
 <SEYPR03MB6700400BAC8C4BE3C80241B1A8A9A@SEYPR03MB6700.apcprd03.prod.outlook.com>
From: Chao Liu <chao.liu.zevorn@gmail.com>
In-Reply-To: <SEYPR03MB6700400BAC8C4BE3C80241B1A8A9A@SEYPR03MB6700.apcprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-pl1-x641.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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



On 12/19/2025 5:47 PM, Alvin Che-Chia Chang(張哲嘉) wrote:
> 
> 
>> -----Original Message-----
>> From: Chao Liu <chao.liu.zevorn@gmail.com>
>> Sent: Friday, December 19, 2025 5:24 PM
>> To: Alvin Che-Chia Chang(張哲嘉) <alvinga@andestech.com>;
>> qemu-devel@nongnu.org
>> Cc: alistair.francis@wdc.com; bin.meng@windriver.com;
>> dbarboza@ventanamicro.com; liwei1518@gmail.com;
>> qemu-riscv@nongnu.org; vivahavey@gmail.com;
>> zhiwei_liu@linux.alibaba.com
>> Subject: Re: [PATCH v3 0/2] RISC-V: Initial support versioning of debug
>> specification
>>
>> [EXTERNAL MAIL]
>>
>> On 12/19/2025 5:10 PM, Alvin Che-Chia Chang(張哲嘉) wrote:
>>> Hi Chao,
>>>
>>>> -----Original Message-----
>>>> From: Chao Liu <chao.liu@zevorn.cn>
>>>> Sent: Friday, December 19, 2025 4:09 PM
>>>> To: qemu-devel@nongnu.org
>>>> Cc: alistair.francis@wdc.com; Alvin Che-Chia Chang(張哲嘉)
>>>> <alvinga@andestech.com>; bin.meng@windriver.com;
>>>> dbarboza@ventanamicro.com; liwei1518@gmail.com;
>>>> qemu-riscv@nongnu.org; vivahavey@gmail.com;
>>>> zhiwei_liu@linux.alibaba.com
>>>> Subject: Re: [PATCH v3 0/2] RISC-V: Initial support versioning of
>>>> debug specification
>>>>
>>>> [EXTERNAL MAIL]
>>>>
>>>> On Mon, 1 Dec 2025 09:42:53 +0800, Alvin Chang via wrote:
>>>>> This series try to support versioning of debug specification. The
>>>>> early debug implementation supports debug specification v0.13, and
>>>>> later new trigger types were added which are defined in debug
>>>>> specification v1.0 version. To support both v0.13 and v1.0, we add
>>>>> 'debug-1.0' as CPU property to let user choose debug specification
>>>>> v1.0 by specifying "debug-1.0=true". The default version is still
>>>>> v0.13 if
>>>> 'debug-1.0' is not provided and set.
>>>>>
>>>>> For example, to enable debug specification v1.0 on max CPU:
>>>>> * -cpu max,debug-1.0=true
>>>>>
>>>>> Changes since v2:
>>>>> * Improve commit message and fix typo
>>>>> * Apply "Reviewed-by" tags
>>>>>
>>>>> Changes since v1:
>>>>> * Apply suggestions from Daniel. Using boolean property instead of string.
>>>>
>>>> This is great work! Thanks to Alvin Chang for refining the sdext. It
>>>> seems we are one step closer to merging rvsp-ref into the mainline.
>>>
>>> Thank you, Chao.
>>> Please note that this series doesn't implement Sdext infrastructure.
>>> We have some patches for Sdtrig based on Debug spec v1.0 and we want to
>> upstream those patches.
>>> We ever submitted the patches, but unfortunately the patches were blocked.
>>> The maintainer told me that QEMU should support both v0.13 and v1.0 for
>> backward compatibility, rather than eliminating v0.13.
>>> That why I submitted this series, trying to resolve the version issue.
>>>
>>>
>>> Sincerely,
>>> Alvin Chang
>>>
>>>
>> Oh, thank you for your clarification. I also noticed this when reviewing the
>> main patch series — it was my misunderstanding. Still, thank you for your
>> contribution!
>>
>> I have done some development work on Sdext before, but I noticed that
>> implementations of the DM module vary among different vendors. In addition,
>> how to achieve compatibility with gdbstub is also a challenge. I will send out
>> the RFC patches at an appropriate time in the future.
> 
> Nice work! I remember that Spike has DM module, so I think vendor compatibility is not a critical issue.
> It's better than nothing. Looking forward to your patches for DM module.
> 

That's great news! Haha, referring to the implementation of the DM module in
Spike is a good choice. Thanks again! :)

Thanks,
Chao


