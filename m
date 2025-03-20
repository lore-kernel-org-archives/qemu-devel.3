Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F898C36001
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Mar 2025 14:46:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvH9X-0002Je-Sa; Thu, 20 Mar 2025 10:45:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tvH90-0002HM-FW
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 10:45:16 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tvH8t-0006go-LD
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 10:45:10 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-22403cbb47fso15759715ad.0
 for <qemu-devel@nongnu.org>; Thu, 20 Mar 2025 07:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1742481903; x=1743086703; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PsuhVBw/8QyJ+S/SJo4G6GOziRnwXF9TFNxIlgDhM/Q=;
 b=J3SxsMWkIlki14msBX0BaqgDkEs9n8eBq8fkELQdXo50/b2zFreP334+gHG1hEuoa7
 4j8qbKsV/m9x2zPG4FPKr7nyHQP6lllaYSB1xeaTtWtbuFj7UfHR1mTzeaRKxHnsqHje
 ITo6JO2idV4jYXwdIg66On1GK1Ht7jsI0Imdjw1CKTNtwCrneWsHDPt0FfeCt7pQaNOj
 W74+zGYgsM79AruX/w8HT5QejN1BRn7l0xkqN1QeZxJ3XkBDDshPbt7w0ruuyAtOoyhN
 rOCoXrAYrQGu4WnRk33anP+Zs64Pm0Ua8JyaFyrJVgqaj/rhDj9B9lfszvRcdMW+qsid
 dWyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742481903; x=1743086703;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PsuhVBw/8QyJ+S/SJo4G6GOziRnwXF9TFNxIlgDhM/Q=;
 b=vbT7hvmPGKthufPTBNARsxkt9BIFX6K5+jjKi8u4rZu17ZMV9cSkEv6UcQfyl6xHpv
 yaowNwIcbN7nee5CVzhJD5t64btd2WkMX3HHw9HW3GQwWI546YAna/wlk5L3tE9uY9d/
 nN1kHyx4lQFfJNioCkyyAlOlEZmidbjz4JuA2vEz23mHlNT257HaUprHxIJIMWmNHpRO
 QVYiyQMcAX9hgsMH4q74+IiTL/t+t15P+YeZ+cyRyJebEMTX6qYLPDfOKKKgHdECmIKD
 7+btT30gpVVSum6qQdbmybtKS9W8EOSD3PG/93fM1I79HAgmhTqbdt0rAU6G0/Wf1S4X
 i7BA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUk3+tWROyRL9u/I1MeDnLZIFi3nBPSCl6fjO+UpIseN5MwIBqQBNjgQhTWULl5srEU6Bho1gvQ2qAC@nongnu.org
X-Gm-Message-State: AOJu0YzgaYUd2orTqqPWQ4fd9mXnJKO6ykkArV3keH62Ulb/PWfqoEER
 zQguacSMVtEkHgqWlQ/w3wdivcVDa/QzXfQ8eLH9dnGg/jJ15TFDp5vR5bnFnG0=
X-Gm-Gg: ASbGnculW3+OIO74FkJxPAx+L4AtHn6jd1wS0i+AQoD36GBor1K96ey33AxQC4N0RpN
 xaWzC2DadlN1U+Qftr21dn976ihrfpnKzekXJeUPjysYhsDMQJPRF862BIbiyAFT9WayPwkSgE8
 00XNAMn433YDndxoilHkdy4S2uO1wRPGs8fd36gi/POGmx6aq7px/vpujDLy5cRBgTJhTTGG2X0
 OpYwshpbh75k7qmlyWgLCM8diyh9VTi1PDuD5U+rz9mNAd00xn7JIxsTpya9NjLi/JyF0l5VUrz
 ChCIxkztVZ19pgZuFO6227lMuUswfR/JQyF26PAMei4zVwXMv5FF33CeRgiYL9GBc3HUR9f61YE
 25LAq38DLCkFkpaOyZi2i
X-Google-Smtp-Source: AGHT+IG5SQQzqohHtdEsn55E7n7yWHLm5WxOmSEQqZlf4+h4b7UzTHgIppaWnELt05MqYWEfJWQN4A==
X-Received: by 2002:a17:902:ce07:b0:223:5e54:c521 with SMTP id
 d9443c01a7336-2265ea35407mr56144505ad.0.1742481903240; 
 Thu, 20 Mar 2025 07:45:03 -0700 (PDT)
Received: from [192.168.68.110] (201-69-66-189.dial-up.telesp.net.br.
 [201.69.66.189]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-225c688da8csm136416005ad.48.2025.03.20.07.45.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Mar 2025 07:45:02 -0700 (PDT)
Message-ID: <0b237809-80f1-416b-ba50-ea4bd4bbec03@ventanamicro.com>
Date: Thu, 20 Mar 2025 11:44:59 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] target/riscv/kvm: add missing KVM CSRs
To: Andrew Jones <ajones@ventanamicro.com>,
 Andrea Bolognani <abologna@redhat.com>
Cc: Alistair Francis <alistair23@gmail.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com
References: <20250224123120.1644186-1-dbarboza@ventanamicro.com>
 <20250224123120.1644186-4-dbarboza@ventanamicro.com>
 <CAKmqyKNmpRA8kphbWnA-AqTSUSGf+koSbCmuk6VgZEWde2NFBw@mail.gmail.com>
 <CABJz62OfUDHYkQ0T3rGHStQprf1c7_E0qBLbLKhfv=+jb0SYAw@mail.gmail.com>
 <20250320-3cb60e99a0abb54e2bb56838@orel>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20250320-3cb60e99a0abb54e2bb56838@orel>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x633.google.com
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



On 3/20/25 11:41 AM, Andrew Jones wrote:
> On Thu, Mar 20, 2025 at 07:25:07AM -0700, Andrea Bolognani wrote:
>> On Mon, Mar 03, 2025 at 01:46:53PM +1000, Alistair Francis wrote:
>>> On Mon, Feb 24, 2025 at 10:32 PM Daniel Henrique Barboza <dbarboza@ventanamicro.com> wrote:
>>>> We're missing scounteren and senvcfg CSRs, both already present in the
>>>> KVM UAPI.
>>>>
>>>> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
>>>> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
>>>
>>> Acked-by: Alistair Francis <alistair.francis@wdc.com>
>>
>> This patch seems to have broken KVM acceleration for me:
>>
>>    $ ./build/qemu-system-riscv64 -display none -M virt,accel=kvm -cpu host
>>    qemu-system-riscv64: Failed to put registers after init: No such
>> file or directory
>>
>> Reverting it makes QEMU work again.
>>
>> My host is a SiFive HiFive Premier P550 board running Fedora 41. Note
>> that, since the upstreaming effort for this SoC has just recently
>> started, I'm using the 6.6-based vendor kernel.
> 
> Ancient :-)
> 
>>
>> Perhaps the KVM UAPI additions mentioned in the commit message are
>> more recent than that, and we need to make QEMU's use of them
>> conditional rather than unconditional?
> 
> scounteren has been around since the dawn of riscv kvm, but senvcfg has
> only been there since 6.7 (just missed your ancient cut-off).
> 
> The true fix for this is to start using get-reg-list, which should
> hopefully work with the 6.6 kernel too since get-reg-list support has
> been around since 6.6.

That's the plan. We need to make the same treatment we're already doing with
the extensions with these CSRs.

> 
> A quick fix for this is to just drop senvcfg for now since nobody
> noticed it was missing before (well, I noticed it was missing, but by
> inspection, not test).

We can do that in case the proper fix turns out to be more complex than
we've anticipated and we'll miss the cut for the release. I think we have
time to do it properly, but let's see.

Thanks,

Daniel

> 
> Thanks,
> drew


