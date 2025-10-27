Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB97ECCF9EE
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 13:35:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDNMU-00081P-I5; Mon, 27 Oct 2025 09:34:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDNM8-0007pn-Dy
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 09:33:53 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDNLq-0006gr-PC
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 09:33:51 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-47118259fd8so34856685e9.3
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 06:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761572008; x=1762176808; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IGudUMXJypZmFhJTWH7zemPwnU0iRF1rcgzMtDBMZpg=;
 b=vDyJ+SsjgUB6y8QjamyrFocj1Dj6g71EUWtGPSrRFls5D31+9BWxHfEsYTydVWSWyA
 NNmHjTncJIv+wGghpMTD16KaZkP6BgAakcU74T5EM7S+LYa8z9lABDuZReboPjJEftIK
 ntR0t2mfSoKmc8DGHqRSmhOHx9i48K9zSBbCFfDysanL1b5LuwP80B36YXRYfGv9v/St
 t+nhdpZITCvyjBRKtLhjRWL9TPKbpjBeyjOpRhST5sTYt7wilVpI5JvQGZUEQaxR3B4c
 rnNq3Tkby69xmCxOf9Bt2Rn1REqHr/bpAD586oKULRuvXF4GIi2AIgRd9eQQqDKGa4sS
 B7og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761572008; x=1762176808;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IGudUMXJypZmFhJTWH7zemPwnU0iRF1rcgzMtDBMZpg=;
 b=uBNgjpDjHnC5b1r4ibEcLX7ATmRlNIGp5l+uwIin72/9duz9DlDMBM/sWR7Ye2v5er
 Td3h85rRsu/s8qdsP46iZmtvvZ/u4jRNtWu9q+CM2pogo9YPWodAvD0Fjlk2Wlf5YNbs
 AGzUWCRWmjDWA+48dUPs6O9RAW4umTcryCUZcH+lxNMTN895DfBNeYDWZOVGdP8eypdE
 7d+/BXHyWzlK4GZhl0SbLRfLk9JUxxN9DwGITQ3N3iIDpaytBa4ZjtCD6ayL1YRNtHrB
 mbHmt8aDbUL7PHybZUTGDIdL6pW5n+q6+KfzTnA6wlqp/IWqErSZlBdTYN8dN7ZHtEK2
 /6CQ==
X-Gm-Message-State: AOJu0Yz60p56UVRGFNMcOm8zz43eYBk8X509/W0hXxV7gu8qKnjphBkr
 tWCxeeD9alTquwhEBSdWmYRlTxpBH5rK4GjmFkHPZE/Rg7Uv7Dci4amfMznMnR4nVAQ=
X-Gm-Gg: ASbGncuWtXVT9j3u/DJEZckVcpEE4DO2k7ryooQDUFyp10a0KncNQ13gC04nWVdn2EI
 j1K0teM4AFgpKuBoDIwrktY7r5iTgoH6fa/StM3FvWCBKm49+ivICy5aP053RPYcVJzshqSaWJi
 S+Rx5+0EErkCBI6VBzG2+ZmlKnwK7tvHsQwqJwK3Dw5YFldrIbj/Qv/6RDzXdEzFrumx61Igap7
 xYhIVyTcm30xyqF7a+xWOwcYZGvCMBKS1teFOJZpwJmrV07wVWc962m7GZRLUbHM80an0S4RuC9
 25ohlsXlgMFTOcBSSK6/vIdrklJsUkeRAz4o+G4unyw/PlgDX7tqPiFx49TdQPr4wGcbEZcWj9C
 Hyf3ZZywgCJSi3TXlI3bZSMnut9HLYvtG8ognIQwxUUmW7VskVlRIzN+sSF0L/qEgt2BwNFeoTQ
 /rSdkishaiVhIkhS4cwSdPpz6Jj5iKkziye62cy8WOLAQ=
X-Google-Smtp-Source: AGHT+IHJakbpTxKXRiG+Xswm2d75kPagyjFoC83ZHRXF2T/F03OwFv5/Klg989EQhbEL7U9LPvwjqQ==
X-Received: by 2002:a05:600c:1c86:b0:477:fcb:226b with SMTP id
 5b1f17b1804b1-4770fcb2604mr42348315e9.2.1761572008144; 
 Mon, 27 Oct 2025 06:33:28 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475dcbe5587sm164670195e9.0.2025.10.27.06.33.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Oct 2025 06:33:27 -0700 (PDT)
Message-ID: <0199c5ce-9bb2-42f5-b545-8aaaf47364b0@linaro.org>
Date: Mon, 27 Oct 2025 14:33:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] hw: Log unassigned MMIO accesses with
 unassigned_mem_ops
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Joel Stanley <joel@jms.id.au>,
 qemu-arm@nongnu.org, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 David Hildenbrand <david@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Troy Lee <leetroy@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Helge Deller <deller@gmx.de>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Richard Henderson <richard.henderson@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Peter Xu <peterx@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>
References: <20251027123644.63487-1-philmd@linaro.org>
 <87pla8xzd2.fsf@draig.linaro.org>
 <CAFEAcA-hWZei6ytAik5sjFcsYqbKaM6K5mzHepmGQpggAdbQmw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA-hWZei6ytAik5sjFcsYqbKaM6K5mzHepmGQpggAdbQmw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On 27/10/25 14:26, Peter Maydell wrote:
> On Mon, 27 Oct 2025 at 13:12, Alex Bennée <alex.bennee@linaro.org> wrote:
>>
>> Philippe Mathieu-Daudé <philmd@linaro.org> writes:
>>
>>> Do not log unassigned MMIO accesses as I/O ones:
>>> expose unassigned_mem_ops then use it instead of
>>> unassigned_io_ops.
>>
>> But why? Is it because ioport.c is a x86 io thing?
> 
> 
> There is a behaviour difference: unassigned_mem_ops
> will fault (because of unassigned_mem_accepts()),
> but unassigned_io_ops will be "reads as -1, writes
> are ignored". This patch series doesn't mention any
> intention of introducing a behaviour difference, so
> I suspect this is not intended...

Oops... Good catch.

> There are a couple of different but related concepts
> here that we need to keep straight:
> 
> (1) x86 I/O ops, which are different CPU instructions
> that talk to a different memory-space than MMIO
> accesses. In QEMU we model these as accesses to the
> address_space_io AddressSpace. I believe no other
> target CPU has an equivalent to this.

This is also my understanding.

> (2) PCI "I/O" BARs. PCI devices can have both MMIO
> and IO BARs. A PCI controller on x86 maps IO BARs
> into the IO space, I think. On non-x86 the IO BARs
> typically appear in a different window for MMIO
> accesses. Behaviour of PCI I/O accesses to unimplemented
> regions is probably defined by the PCI spec somewhere.
> Behaviour of PCI accesses to unimplemented MMIO
> window areas is I think technically left unspecified
> by the PCI standard, but "write ignore/read -1" is
> what x86 does and what most software expects, so
> hardware that implements something else is making
> its life unnecessarily difficult.

Right, this is what I'd like to unify, ...

> I suspect we entangle the PCI IO BAR concept and
> implementation a bit more with the x86 I/O ops
> implementation than we ideally ought to.

... to disentangle that.

