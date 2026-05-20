Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C251CD5BA4
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 17:48:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPl1a-00087I-5e; Wed, 20 May 2026 13:48:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPl1X-00086d-75
 for qemu-devel@nongnu.org; Wed, 20 May 2026 13:48:03 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPl1U-0000wW-QZ
 for qemu-devel@nongnu.org; Wed, 20 May 2026 13:48:02 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-488b0e1b870so75219725e9.2
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 10:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779299279; x=1779904079; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wDtAsynQvESibFqzdd4mHvMgbTEK6ZdN6NFkg5MUUIU=;
 b=e1adauOtmhhjiz1tQeMGzhNLmLrx0fgUqTjHfs3s/OKVZ4JB3wDRpb2fVQBeIjOP2c
 +EHAX3H+X5PhavUUZBtDZCX/Eubzv8nFCm+Faq8uvwdDLmBvmlNeZ9NN050ykC9lXCoV
 bKSOHMsi5ELdRXJ/dQ77ifmIxtR9H44+f7rdkuWDYumlfs0WIJNzL+VX6RizHyMO/m3j
 WNiagsiEFStL1EOc+eXIuqnf/qtfHujKKqaOnRzxk+ZYpolj1G6OHF0LlFyBi0hJacKm
 +gUyllQJTYbhE4zvEFRWSIVhiOljpWTDvVuRMmewItYTUVQGPSNtNuetYWOYJAZp47iW
 umFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779299279; x=1779904079;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wDtAsynQvESibFqzdd4mHvMgbTEK6ZdN6NFkg5MUUIU=;
 b=GA5JGATBeNJWW7SBN4+/kjSPHwd5aqucNPyyPturQVSaHbsjpX2CKEUwFTgd2W0jDU
 GrHbRDT85H22XG8DSPyRe/QDnCxKs3V5Sg2mdmSkR7BljWlEX+gSwvl6K4BSBpKP38mW
 9XgkjPSNluKeg4sM/HxdEGFK1ITWKGlXi7JRwIOT2AsyPi2Aevq7ifEYtquF+xd0Qzn5
 kOsTfVODTSB71nTmqz3+bvlje8MywDErytRtyforkFZDO8xD15jX+xFqZlRfH5F7RFOr
 9+s7t8Tm5sEwFk344RviaHKy6R2V1US6G26vrKb0+KLqZqczQOGfwIDfTKDtoMWdxkum
 051g==
X-Gm-Message-State: AOJu0YwEfaswPaQ+jsJZCpuzaMwafC7oP6zT2bE5eKhyL9nW6+/ufH9p
 4D6kFLmZASxXezERicIWZwKmR+ObIefftpDIjWKVFbRVxeagTce0NCd7sBSZTxbfF/g=
X-Gm-Gg: Acq92OFvKU6gdp43vFgNQhwgx9WsFbjFeVB647GI/pEqByr+E4RHqASZcArn/FKG0Mh
 mXkYVU1v0pP+sXpNKqzaBiVa4ieEyaj6LDxAtQelHHMxrXEg+ScGo5FBR27Ic3GtsWiAb6usoOu
 qt3vM+TISBuoQaDRBy8HPLK1BCieXHeItA0dGr4qQNG9htzdZj58gGp7CCrhNdvw7/bPD6etX3I
 yJ0nMqvJ8dLkWTJx57mDOJOv8hTbeegFfrTjZ7euKGsQ7svE6wqtZyCgslCkBtQgn+Ua8eFZdxK
 ng+yaXzK/Cmdvj0WbREkeQUVulggzgZYAeXaE0VsDv8eTCQb14DsibE5es6QeS34W1ivnbNLIcb
 Seri1+wlf23aHVFevQXCdGtC9otZ3+KKqic0gGGpiH0Z4+TuKP/UBLXK4r1HWKR73KfKyMu/dIu
 8pHaVWT6VvbdrkxGdO8IbyM8Zt0j9Z1ML9VcAj9J6pNguWHAsmHGSvx8P5WItrWOKD1g==
X-Received: by 2002:a05:600c:198d:b0:487:5c0:671f with SMTP id
 5b1f17b1804b1-48fe60e552cmr440533605e9.9.1779299278950; 
 Wed, 20 May 2026 10:47:58 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da0a17ec2sm52384700f8f.24.2026.05.20.10.47.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 May 2026 10:47:58 -0700 (PDT)
Message-ID: <f830c901-f39b-48e0-8374-7de5cb9adcaf@linaro.org>
Date: Wed, 20 May 2026 19:47:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 0/7] Add RISC-V big-endian target support
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>,
 "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>
References: <20260511083819.206216-1-djordje.todorovic@htecgroup.com>
 <20260520101034-mutt-send-email-mst@kernel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260520101034-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 20/5/26 16:12, Michael S. Tsirkin wrote:
> On Mon, May 11, 2026 at 08:38:26AM +0000, Djordje Todorovic wrote:
>> Rebase on top of master.
> 
> is Linux going to support this, ever? given this history:
> 
> https://lore.kernel.org/lkml/CAHk-%3DwgYcOiFvsJzFb%2BHfB4n6Wj6zM5H5EghUMfpXSCzyQVSfA@mail.gmail.com/t/#mce138059dc56014643bbda330810183031ef5c06
> 
> pls include a cover letter explaining why we should bother with this.

We can run any kind of guests, not limiting ourselves to Linux kernel.

> 
>> Djordje Todorovic (7):
>>    target/riscv: Define MSTATUS_SBE and MSTATUS_MBE bit masks
>>    target/riscv: Add big-endian CPU configuration field and reset logic
>>    target/riscv: Implement runtime data endianness via MSTATUS bits
>>    hw/riscv: Make boot code endianness-aware at runtime
>>    target/riscv: Fix page table walk endianness for big-endian harts
>>    target/riscv: Expose big-endian CPU property and add documentation
>>    target/riscv: Add endianness test for RISC-V BE
>>
>>   docs/system/target-riscv.rst                  | 24 ++++++
>>   hw/riscv/boot.c                               | 81 ++++++++++++++++---
>>   include/hw/riscv/boot.h                       |  1 +
>>   target/riscv/cpu.c                            | 11 +--
>>   target/riscv/cpu.h                            | 23 ++++++
>>   target/riscv/cpu_bits.h                       |  2 +
>>   target/riscv/cpu_cfg_fields.h.inc             |  1 +
>>   target/riscv/cpu_helper.c                     | 28 +++++--
>>   target/riscv/insn_trans/trans_rva.c.inc       |  4 +-
>>   target/riscv/insn_trans/trans_rvd.c.inc       |  4 +-
>>   target/riscv/insn_trans/trans_rvf.c.inc       |  4 +-
>>   target/riscv/insn_trans/trans_rvi.c.inc       |  8 +-
>>   target/riscv/insn_trans/trans_rvzacas.c.inc   |  4 +-
>>   target/riscv/insn_trans/trans_rvzalasr.c.inc  |  4 +-
>>   target/riscv/insn_trans/trans_rvzce.c.inc     |  4 +-
>>   target/riscv/insn_trans/trans_rvzfh.c.inc     |  4 +-
>>   target/riscv/insn_trans/trans_rvzicfiss.c.inc |  4 +-
>>   target/riscv/insn_trans/trans_xmips.c.inc     |  8 +-
>>   target/riscv/insn_trans/trans_xthead.c.inc    | 16 ++--
>>   target/riscv/insn_trans/trans_zilsd.c.inc     |  4 +-
>>   target/riscv/internals.h                      |  9 +--
>>   target/riscv/tcg/tcg-cpu.c                    |  3 +
>>   target/riscv/translate.c                      | 22 ++---
>>   tests/functional/riscv64/meson.build          |  1 +
>>   tests/functional/riscv64/test_endianness.py   | 57 +++++++++++++
>>   25 files changed, 251 insertions(+), 80 deletions(-)
>>   create mode 100644 tests/functional/riscv64/test_endianness.py
>>
>> -- 
>> 2.34.1
> 


