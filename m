Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72EC4C3ABA4
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 15:21:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9QI9-0005Lt-24; Mon, 28 Apr 2025 11:21:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u9QI3-0005LS-K5
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 11:21:03 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u9QHw-0008AG-Sn
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 11:21:02 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43cec5cd73bso24825345e9.3
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 08:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745853655; x=1746458455; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MG0MUBzXjP2v6t6hU65/zkXrD2tUtKAmyz+JQjpNIWU=;
 b=Cpbpz0P5VKcf3GczTc85yksDxUjeo3Yq6PVBaa0DKRAu3AMr0MkzI7dlvebZDawFLY
 jcrNANm2zwrzGYyN4o2+UBfaNnY8dU4sgjFHD7PAMfS+wntk+LCO4KYp/Jz94CwlMnJS
 Wh8SllSPDQYbqizHrYIcHGa1DNOIUUamnLirBpJBrfb8dBmJERl9YzTf4ZXcSojwhrrn
 t/0Iki2IuCn4X8TaLfraPSD3myB/9dwZoOiSKrWVnxt9q+cp80ns9PHTpP6nZ/gkM8Dt
 NH1TtW8fHv5tHp7W9iokLETZp5jkLTjyKSHXWyQ4AWXXnG/w9DoR2oxCbcX67lczjsNS
 aJpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745853655; x=1746458455;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MG0MUBzXjP2v6t6hU65/zkXrD2tUtKAmyz+JQjpNIWU=;
 b=DvgzyZ/xJ0s29Jw2FI7zEhG6n5rIu9S8507Y16tza4PS8YV+Bl0bxUk+NE3VIB41dB
 KHIYT+oYtvE3WJi9dz3er05llEYLnloFgaTE1ZENi2Hx8+NFt9w9NbfgQQheb35dPYtD
 YLEGQTS68fS7pGyx0JAaEkfo7/gKNN7clmowuSkslEvHhbbsLTG+gBJNP87EBWhqw8gg
 zfJBuWEd0k1hBuMJo8EpdZmPxM2rEM8EE1Hk9au6hmpKZ5TnNC1MmahO77Nex6v0vsdI
 MrP/2KkSiRXZcT7RfDOaZjhErHvLEfrMObI6adnlWsk15C+MUnNHKNqXpxR0csZ85JT2
 UtrQ==
X-Gm-Message-State: AOJu0YyBlXRWVku1Cv5EXCwVY5s/RcDvs8waSUvbdx0d42ldHjpNB7IE
 zrn1ydpgaRbnVEzdq0w4rm/kKVhgSRpBatsO+ZOVgRG5VjnuEYxbSKzzmB1F8oE=
X-Gm-Gg: ASbGncsyO4W2rQWqtaS032UU3ctQJkraHOHDehF1Ao4ndv7mK2aELyylQpx6S0y9GbI
 PqEds9/HbLG5hQDI+fL1FNocJVPNSXnG5a/giSCZXmfXEd9X1nlV9X9JQ4UWVUAHFSja2BHVx7Q
 GWWQMUo1UHJ04NLFzg/Nnp9Rg0CYJrzePBLNlHQ/1I4yt3h8dnyRheS384QvsW3OFLTfPoN7NZg
 Jg94DGiVRjT9eE+Y8ucvpibCTFuMkeIk6QPv4HLKQyIK2Ls/LkF+ZSy5bOOH20onq1pZXG3N3EE
 Khz9/QMMGPz5h/bPuRSg9MH79fg9Xm02h0DhtA1y6Hp6+3CpAgUYtAitueD6m/yL0nAvCcIc9ve
 6diTIxY6jHpVXtw==
X-Google-Smtp-Source: AGHT+IFLIL2ACJFJnOFRplLKYh2/RjUw4A4Cr4Prau0HUa5cfuSNnOY8wTzv+FGbeK0uW7RndoKyng==
X-Received: by 2002:a05:600c:3b23:b0:43c:e2dd:98ea with SMTP id
 5b1f17b1804b1-440a66abcbemr96433515e9.22.1745853654926; 
 Mon, 28 Apr 2025 08:20:54 -0700 (PDT)
Received: from [192.168.69.226] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4409d2e0241sm160329475e9.37.2025.04.28.08.20.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Apr 2025 08:20:54 -0700 (PDT)
Message-ID: <7cf90706-05e8-40b7-aef5-108c2d7234df@linaro.org>
Date: Mon, 28 Apr 2025 17:20:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/26] target/riscv: store RISCVCPUDef struct directly in
 the class
To: Paolo Bonzini <pbonzini@redhat.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, alistair.francis@wdc.com
References: <20250428073442.315770-1-pbonzini@redhat.com>
 <20250428073442.315770-9-pbonzini@redhat.com>
 <30770d2b-ac76-4d13-b8f2-ca39c0b82e0f@ventanamicro.com>
 <CABgObfZX1j4N=Oeq9Y=_YeccCq7--s0=r5DaANA+iA1UnoJyVg@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CABgObfZX1j4N=Oeq9Y=_YeccCq7--s0=r5DaANA+iA1UnoJyVg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

On 28/4/25 14:17, Paolo Bonzini wrote:
> On Mon, Apr 28, 2025 at 1:50 PM Daniel Henrique Barboza
> <dbarboza@ventanamicro.com> wrote:
>>
>>
>>
>> On 4/28/25 4:34 AM, Paolo Bonzini wrote:
>>> Prepare for adding more fields to RISCVCPUDef and reading them in
>>> riscv_cpu_init: instead of storing the misa_mxl_max field in
>>> RISCVCPUClass, ensure that there's always a valid RISCVCPUDef struct
>>> and go through it.
>>>
>>> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
>>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>>> ---
>>>    target/riscv/cpu.h         |  2 +-
>>>    hw/riscv/boot.c            |  2 +-
>>>    target/riscv/cpu.c         | 23 ++++++++++++++++++-----
>>>    target/riscv/gdbstub.c     |  6 +++---
>>>    target/riscv/kvm/kvm-cpu.c | 21 +++++++++------------
>>>    target/riscv/machine.c     |  2 +-
>>>    target/riscv/tcg/tcg-cpu.c | 10 +++++-----
>>>    target/riscv/translate.c   |  2 +-
>>>    8 files changed, 39 insertions(+), 29 deletions(-)


>> Are we sure this patch compiles?
> 
> No, you're right; I was not aware that RISC-V KVM is not covered by
> CI. I'm sorry.

I remember doing it and Daniel reviewed it...:
https://lore.kernel.org/qemu-devel/20230703183145.24779-1-philmd@linaro.org/

I suppose the shame is on me for not insisting getting it merged,
wasting my own time.

