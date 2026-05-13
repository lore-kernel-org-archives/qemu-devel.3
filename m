Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8183CD37AC
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 18:25:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNEG9-0000uQ-6p; Wed, 13 May 2026 14:24:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wNEG3-0000t9-18
 for qemu-devel@nongnu.org; Wed, 13 May 2026 14:24:35 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wNEG1-00042a-6L
 for qemu-devel@nongnu.org; Wed, 13 May 2026 14:24:34 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-366330b6751so4823662a91.1
 for <qemu-devel@nongnu.org>; Wed, 13 May 2026 11:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778696670; x=1779301470; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bSvKDxxs4qB2u2UEZlOU/XoRlJJHnpJOLY+9xpr1lOk=;
 b=hHWve3CVpt7MC3uETlPCnzJILwL6t6OjZ9Sn07AxE9DNC0arVMwzbEiQiT+ZNBJlXp
 MKKI+va1Vgw+mPnwFI8KwJstpc7/ICLupv00n7LHQ7EJcFwl4QlwgQpxAOG4NfBVte5W
 gM6IfiYlUoUiZ4t7dpW/NxaAKEfuFvX/Z3RjcDZev8celsXM/REw+muF4h8UkHCaZbsf
 1KVhGMcZ2smq9SojFh2HddK7e9otA5AJkRB7aPC6s8VomUEhhbznxdc/Q6iUVGcBX77A
 I9KppRe+5POuyDzJDwK4YPCP6EQMa9spPMyLAPoqZM1hhVohvEno2m7qGTN2qHALaMif
 9X0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778696670; x=1779301470;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bSvKDxxs4qB2u2UEZlOU/XoRlJJHnpJOLY+9xpr1lOk=;
 b=Gbfz9tFP94H+C34I5GFf/4perth0EnlsCUga1KrZr9HyvzYrhLvQCk2ssC1NYdmSG5
 z7MMajgsP2+ZyJAyvAbpacvhQpWr1iFxh993sKn+OBYZGnDja895AUgKCypjkDkUn+Y+
 HSizkRx1lZSg2UNL11O30ZykA6RhtcF1RW7Rflo1WaQ2TamFzhZ1J2TOi+HSjdR0VXAd
 bHIxgkmLgonwHe+6tgrAW4AWLgLSTjY2saTlENLJhVOKLnVYdxN9NEH/W4Hazth99uyv
 kJtXs+4WTc9Nb4gAkpFhbqo1WckJn5TzaWThfj9qClC0rtFrEft+rsCCpXIT85m5H643
 xnoA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+wnIvW0a5aUqP3CeceImAkDPbdJEo/50r04YY2MCA90mMW6yrkX/2LqqWARD7Tsxs27yGFDDFiBEta@nongnu.org
X-Gm-Message-State: AOJu0Yx0zzkRaYQDNNfeucCll776Y9EjZ0cQfWmNARzDvjXooO0IHJe/
 7TwEKMr48lZbHJtDBrbm4UQeC3Jp42dz5EPBrwlyAr21/pu28nh2JybGFeChu8JxDLM=
X-Gm-Gg: Acq92OEzJGnT3LAEmpwIx/uIgin3VzjjsuknvxDhZXIDBPphwgWC+Pk/7KtsyQJj1gt
 nknKbzUdzcTeNCrWVOO1ve9UKYVhXhqUW26c5DAWKxQCL6mtpNaHTM0S4YVku6lEm5gpgobiRi+
 9Y76R6lWML0z2zhEpCX7aV3zZ0C43BP+fwCE1LLVPf4ro25EXBI+3x9rM8UTkotMXhGjyyXt8Nd
 8KMfEtK43l4AJKOPF8igh8bnA7nOg4+V3Y/iwuDKYlqF2BwUiLvQ3AsRU1HQsSsLSCSqNIwIkUR
 urpboFC1HzOR+8KmcAXRdV1879PJcyfD1WeqZykZBMrGmu9w4cmsP/5r2bJIbL1tLPYHTtZdvoA
 pf7B8cZT2KkVKU/vtOaFsBL6c6w3j7pqUB0b8JXtVi++bPXuvU9x4U+XP2e3EX4OB1/ceh6nJOJ
 FbHDW6uqqZUtW5ZtRgb6AQBeY/zeUewI519yvB7lF3D4uq4H4=
X-Received: by 2002:a17:903:1b24:b0:2bc:9110:8208 with SMTP id
 d9443c01a7336-2bd30636feemr39243235ad.40.1778696670331; 
 Wed, 13 May 2026 11:24:30 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.142.33])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2baf1e35bcfsm171611835ad.38.2026.05.13.11.24.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 May 2026 11:24:29 -0700 (PDT)
Message-ID: <d9bf52a2-f100-4bbf-b015-1bd303f5fe34@linaro.org>
Date: Wed, 13 May 2026 11:24:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] target/sh4: Re-allow unaligned access on system
 emulation
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Yoshinori Sato <yoshinori.sato@nifty.com>, qemu-stable@nongnu.org,
 Guenter Roeck <linux@roeck-us.net>
References: <20260513065438.8680-1-philmd@linaro.org>
 <20260513065438.8680-2-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260513065438.8680-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102c.google.com
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

On 5/12/26 23:54, Philippe Mathieu-Daudé wrote:
> The change 0 -> MO_ALIGN in commit eb978e50e42 ("target/sh4: Use
> MO_ALIGN for system UNALIGN()") would have been correct if it was
> merged before commit 1fceff9c3ca ("tcg: Remove TARGET_ALIGNED_ONLY")
> which defined MO_UNALN -> 0. What we really want here now is
> MO_UNALN (MO_ALIGN is dealt with in commit 03a0d87e8dd "target/sh4:
> Use MO_ALIGN where required").

Not correct.  All system mode accesses are aligned, or trap.

All of the UNALIGN are unaligned for linux-user only, in that those are the insns that the 
linux kernel emulates.  Since the linux kernel does not emulate all insns, all other insns 
must be aligned -- that's what 03a0d87e8dd is about.

> Use the correct definition, otherwise we get when booting Linux:
> 
>    ok 14 bitfields
>        KTAP version 1
>        # Subtest: blackholedev
>        # module: blackhole_dev_kunit
>        1..1
>    delay-slot-insn faulting in handle_unaligned_delayslot: 0000 [#1]
>    Modules linked in:
>    CPU: 0 UID: 0 PID: 298 Comm: kunit_try_catch Tainted: G                 N
>    6.17.0-12907-g8765f467912f #1 NONE
>    Tainted: [N]=TEST
>    PC is at test_blackholedev+0xc6/0x1c8
>    PR is at test_blackholedev+0xca/0x1c8
>    PC  : 8c228d16 SP  : 8d40bed0 SR  : 40008001 TEA : 8cce4026
>    R0  : 00000000 R1  : 00000000 R2  : 000000d2 R3  : 8cc77b80
>    R4  : 8cc77b40 R5  : 0000000e R6  : 8c228cea R7  : 8cce400e
>    R8  : 8cc77b40 R9  : 8cc77bbc R10 : 8cc77bbe R11 : 8c4b46b0
>    R12 : 8c78310c R13 : 8cc29cf4 R14 : 8c6e3a88
>    MACH: 0000d80d MACL: e554cb0f GBR : 00000000 PR  : 8c228d1a
>    Call trace:
>     [<8c05b378>] pick_next_task_fair+0x94/0x164
>     [<8c5c2bce>] __schedule+0x306/0x6ec
>     [<8c21fa68>] kunit_try_run_case+0x58/0x174
>    ...

That would be a kernel bug then.


r~

