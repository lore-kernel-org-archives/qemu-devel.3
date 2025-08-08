Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09BA1C87FCB
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 17:16:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukQg7-0007MJ-84; Fri, 08 Aug 2025 13:14:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ukQg5-00079W-F6
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 13:14:49 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ukQg3-0002Sj-UC
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 13:14:49 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-24014cd385bso25900765ad.0
 for <qemu-devel@nongnu.org>; Fri, 08 Aug 2025 10:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754673286; x=1755278086; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PC7pyqqca3zOKfWHTrtPy17QNkLEZYu1x4vHEZfjDzU=;
 b=UJqmV/mMrj78ZNcQ6a6l+QoXMTRqNGDzdmKZhnOFpYMr7tTArnld/D9sCSZKv6KvCG
 xg7B402Y2ULwtLrMr2RTiT5FQPAcFSPdiUEKeR4MFcIfbSW01N38aoqQK4In9YJkUDQw
 fJS4EoNQgBZsFLJUFpPZhDfKULwHWb4jBlCV5Lfy46BSjx+IxIAfVkU6df1lfwFE+mRb
 U/hSmeNbAfSqFEE07s9SFEmjMiifoRktpOmw94zrSkwIPkClNBdYt7AzEKx/vk6VZ1kz
 Jk+wMPNJHMMEU3WvYfw0810O9G2dUg4SGuA0peWMVMw5ThRrkb+EmOvsloAa/vor/Hic
 iEyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754673286; x=1755278086;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PC7pyqqca3zOKfWHTrtPy17QNkLEZYu1x4vHEZfjDzU=;
 b=xNzjwycimHExZK+XZcbsUfdASRLUsBMB6ztLYtD+s21v+anwHg2hjYJIKcqoZ8m6Zs
 jyM8P1XtUIboweoxdjyOopEjT30Djb6FLv3yOImzWW9MWbgeTRhKlSPWMqbWhEC9T49O
 kvos41yjWPsmGfQd2rfvt66aUvLZMhlM6s4EPQf2oO8MIqLIj0GyTa5ObSENU9iGD8fw
 DgVj9k2S7UqIEJEa0nK11axa6FiZ7ZK3+I29T+IxRPRGXeqp+pPwwSpCE3TjnIqxC08v
 zeVSsFF9l6G7ZhqTmCqy2Q/O6k3ERYwl0ze+66PbDAbHUgt9qZnRL05wTaCN3BcFXNzS
 PE8w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUg/QScm1q7SjSw6lkofx76BeS8n01ciqX+hQRdSMwAyIFTRF0YHjAYtqO5xPhTCtpLw5c/dPmFIsQY@nongnu.org
X-Gm-Message-State: AOJu0YxRGYrbk++UjbVXYk4/hsFoZHf0yGBeRL/hmGPZjUdYuKDzDw8Z
 ZSZPy6NMM5huc7GVBS9pGrooBH71f1kDQszlk5nVPGJ+gRzeATe+rc7YkKW0+IsYnr8=
X-Gm-Gg: ASbGncu9VScaHHrv2xww52E41SN3LaaAR9KoSTtsjlrqk7DX0qjXwA3ZEgOrouCTWoW
 O2Uj0E0//dzgVXIscJDNxgextIcR3LL9XIx14T3mhhrBZyg2DlRmB2cr1VXrdpim/ZQ48h5DLgO
 7C7JBoD+yWuqaDd7Jda/Fj7l5fkUGfNGHsWmkej/BwjfqbDRBWocSloNkehE/N8PPdPEq1wl2EJ
 4jfkEb/M3lfVkDzdLmDIHMSjvFfJXaeo7oHR9VCKjw3Kpow+nIatc0wlGtgCUUHC5l1OAwzReaR
 xuxpGDsmPwuXsZFLQu+OrQ/OnwpAUjNxJH2oHD4lzswEpgMWCSowcrDbew3I5MIrEQxzdfUzf/R
 9v74DTjPv+6fbkuaxTEQcCgK2LWIYE0P5Lb4=
X-Google-Smtp-Source: AGHT+IF5E6Q38WsetPX4vGjTIp7+4v4tQn9kBod1/eK/qLw8gXZApqPEHPs5n/x6eUB0m0t0AU9H6g==
X-Received: by 2002:a17:902:dacd:b0:240:5549:7094 with SMTP id
 d9443c01a7336-242c200e82emr56046905ad.18.1754673286061; 
 Fri, 08 Aug 2025 10:14:46 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241e8ab3da8sm213752765ad.175.2025.08.08.10.14.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Aug 2025 10:14:45 -0700 (PDT)
Message-ID: <96a27883-e02e-4d76-9dde-41ae1a19e0c3@linaro.org>
Date: Fri, 8 Aug 2025 10:14:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] gdbstub/aarch64: add CurrentEL register
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Gustavo Romero <gustavo.romero@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org
References: <20250808-gdbstub-aarch64-pstate-regs-v1-0-14ba70be1b3d@linaro.org>
 <20250808-gdbstub-aarch64-pstate-regs-v1-1-14ba70be1b3d@linaro.org>
 <CAFEAcA-2Zt7HTDX_bdBHjJyQS7o=csE1x6eDymyEPkV3K+pXrg@mail.gmail.com>
 <CAAjaMXbZK=n_HJGrmuGv1DZZ3AeaX7-fK-soFto4J=w-9=vdmQ@mail.gmail.com>
 <6190716c-09da-4abe-94e5-2b713855f0e9@linaro.org>
 <CAFEAcA-QcjtkAUUUGVvaUVrJBqP3NvSX0DuXQ==MGcPrjNtGQw@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <CAFEAcA-QcjtkAUUUGVvaUVrJBqP3NvSX0DuXQ==MGcPrjNtGQw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x633.google.com
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

On 8/8/25 9:14 AM, Peter Maydell wrote:
> On Fri, 8 Aug 2025 at 17:11, Pierrick Bouvier
> <pierrick.bouvier@linaro.org> wrote:
>>
>> On 8/8/25 5:26 AM, Manos Pitsidianakis wrote:
>>> On Fri, Aug 8, 2025 at 3:21 PM Peter Maydell <peter.maydell@linaro.org> wrote:
>>>>
>>>> On Fri, 8 Aug 2025 at 12:30, Manos Pitsidianakis
>>>> <manos.pitsidianakis@linaro.org> wrote:
>>>> The debugger already has this information in the 'cpsr'
>>>> register, so it could implement convenience views of
>>>> the subfields itself if it liked.
>>>
>>> Yep, but consider: it is a register, architecturally, so it's nice to
>>> include it for consistency. It's redundant only because gdb has cpsr
>>> which is not a register. So this is about more about being technically
>>> correct than correcting an actual problem.
>>>
>>
>> I agree with Manos on this.
>> As mentioned on a previous thread, cpsr is not even supposed to exist
>> for aarch64. So adding architecturally defined registers, even if data
>> is redundant with cpsr, should not be a problem.
>> I'm sure gdb folks can understand this too.
> 
> I'm not saying this is the wrong way to represent this.
> I'm just saying we're not the only gdbstub in the world,
> and it would be nice to have a wider discussion than just
> QEMU folks so we are consistent about how we represent
> PSTATE (including what we want to do about the new
> bits that appear in the high 32 bits of an SPSR), before
> we commit to any particular direction.
>

Considering we have our own set of gdb xml, is that really important to 
agree on pstate layout before we simply make those registers visible on 
our side?
The new registers added in this series on gdb/kgdb side at the moment, 
so we don't really break anything.

I agree it would be good to see this on gdb side, but my point is that 
we are not necessarily stuck and we can make this visible without 
waiting two releases. As well, it would be a good motivation to add this 
on gdb showing QEMU already exposes this.

> -- PMM


