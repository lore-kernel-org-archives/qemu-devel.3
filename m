Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E1C5C282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 18:27:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trhqh-0004w3-Gk; Mon, 10 Mar 2025 14:27:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trhqf-0004ru-Fp
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 14:27:33 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trhqc-0005FS-Vc
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 14:27:33 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3914a5def6bso857012f8f.1
 for <qemu-devel@nongnu.org>; Mon, 10 Mar 2025 11:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741631249; x=1742236049; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vmdCEnwkZ4b2bMvN4tcIf2KJNeH44T6fztnYQ1cjcMw=;
 b=BIzDyBDDBqowIe/ldf7/xjNXfQ1rYooWFiwq2TFsebk7Dy7G2Xl0OXz63rgV3NdEWz
 aq3WACNSnga5XNVKhDM358OGe0QZYtXW87NOjbp9+rQp+kRddc2FvRIALYAHMx06EH3G
 CDJNlr5HLddZepaeQBlOlec8zK7pQNeAnRB8d/sZcCROENCTcG7p+90Lkfq5E4V+pI2I
 2zkvYwOzlGFCg/EXt4DJfLykXMnk80M9l4CvmSXYW+5X8/4ch4ACviZhlZ52mkBLw5ke
 i1UYmWSthx8GL3HXa4XkS6CTrStTCAi1r8Xso2eenT8y20nlfdnw/i/Hcydl6JpNbL1R
 4Cyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741631249; x=1742236049;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vmdCEnwkZ4b2bMvN4tcIf2KJNeH44T6fztnYQ1cjcMw=;
 b=fez25oHYKpyeL6iLsgg9kwXxyTjyJNT+bIdDI23as2Z/yvYs6XBze9KdxmgFe+KYse
 28+EatjCT2HAsz0ZaaroC9PbCv5T9uEDQIt3jYjrT9XIF7Q24Q/5O/92ZYLbJiAUX/Li
 7PW5MLQ7nHf8lwpUFyOfiwdfSsEpy2rbpU2vdCW2ATUbTkFFlrdJrAsJZdK7IpZkb2oT
 3Nc/Hm57hpdC40qQGIhmi6vBcXYOwwVI0gTwwoJT2QAnoDzmdkYCHQkCGYMH8R7KJegL
 QOerbuLFzfRuOAxmdwS30qLxUmrpFEnqk6hR6ke2wplTiC2v+siCK6jbHObaDUqcXB+S
 YMwA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUbHOBTqE5fP8J0mz7N+3yrD6/fT/Lp5SbuFHMhk6gdLNP85fyu3Pl8936lL+Zcn6TOFgGOkXsqiWz3@nongnu.org
X-Gm-Message-State: AOJu0YzJrfVRXbwKAL8IIZQ+8OAlxGJvoTFeJnITy0zJwoKvW9j29OWN
 rktqXw9gAvX7/VmAmktNn8OZHkVJhkWThNjFFInm1lNp4hU73JMXCl/PRg4CvO4=
X-Gm-Gg: ASbGncs9y9zd6uxj6BcvTqXcKgNk4YmDNamGMCa/a2xWbBujQYpKsLgF72DLO735oFj
 J65Vcqre96n0g78rrqAJsCsym1lhFL0TfWlqbWj1jtJsJzoEmoqxx96ynq/ut5ZoUxy0rpBpCKh
 aj1huVcKTem8b9sCfEhFk4wd57hXTRzl/ONeolcYi2o5A7oVYEuzNWFZH4Z9N3eh6e67ZTb6AxR
 lkx74jqTLgOPt13lMcGn7R9d4Rm0KU1HbT/ib9nYJpAPpyjxHBHAVBQtD9meDA9jgtghuIi/eX9
 LNam+WZxWV8q1t7x8wL56DwNfjtQru8pXti+UzlyGgIoF/N5DDVyCDL8zckxvYRIU/VOF+SEmk8
 Q6GodrqtihpZl
X-Google-Smtp-Source: AGHT+IGkbbEYweu/+J9wOaUpp01xiq8tCAsovfwOvMG1Q4sc/xSm/XnBBjrDzfBVoDkuNiffQ9ZoJA==
X-Received: by 2002:a05:6000:1fa9:b0:391:31f2:b998 with SMTP id
 ffacd0b85a97d-39132d16fdcmr10029688f8f.6.1741631248833; 
 Mon, 10 Mar 2025 11:27:28 -0700 (PDT)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bd4352e29sm181160055e9.32.2025.03.10.11.27.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Mar 2025 11:27:28 -0700 (PDT)
Message-ID: <5bd88057-3e3e-4c34-9d06-68916c95f647@linaro.org>
Date: Mon, 10 Mar 2025 19:27:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/16] system/memory: make compilation unit common
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250310045842.2650784-1-pierrick.bouvier@linaro.org>
 <20250310045842.2650784-16-pierrick.bouvier@linaro.org>
 <76b4e445-0676-4982-a2c8-d273c49a9170@linaro.org>
 <2d631838-e8a5-48d9-8235-9a41ffc3381c@linaro.org>
 <76269a95-652a-4064-8f2f-6584b0677191@linaro.org>
 <b411c27f-3f38-4d22-97ff-fa36ae77fb6e@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <b411c27f-3f38-4d22-97ff-fa36ae77fb6e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

On 10/3/25 19:04, Pierrick Bouvier wrote:
> On 3/10/25 10:58, Richard Henderson wrote:
>> On 3/10/25 10:47, Pierrick Bouvier wrote:
>>>> Maybe better as
>>>>
>>>>        MemOp mop = (target_words_bigendian() ? MO_BE : MO_LE) | 
>>>> size_memop(size);
>>>>        adjust_endianness(mr, &mrfd.data, size_memop(size), mop);
>>>>
>>>
>>> Do you think defining MO_TE as this expression is a good idea?
>>
>> There are not so many references to MO_TE outside target/ or accel/tcg/.
>>
>> Indeed, after this change, the only ones left are in hw/arm/armv7m.c,
>> which (because it's Arm) can be changed to MO_LE.
>>
> 
> I see a bit more than that (17 files):
> hw/arm/armv7m.c
> include/exec/memop.h
> target/arm/tcg/helper-a64.c
> target/arm/tcg/translate.c
> target/hexagon/idef-parser/parser-helpers.c
> target/hppa/translate.c
> target/i386/tcg/emit.c.inc
> target/loongarch/tcg/insn_trans/trans_vec.c.inc
> target/m68k/translate.c
> target/mips/tcg/mips16e_translate.c.inc
> target/riscv/translate.c
> target/rx/translate.c
> target/s390x/tcg/mem_helper.c
> target/s390x/tcg/translate.c
> target/s390x/tcg/translate_vx.c.inc
> target/sparc/ldst_helper.c
> target/sparc/translate.c

For targets tied to single endianness, we can replace using gsed,
but using a helper is clearer (see for example commit 415aae543ed
target/microblaze: Consider endianness while translating code").

> Plus more (22 files) who relies on:
> MO_TE* variants (which relies on MO_TE transitively)
> 
> Thus my proposal to have a first change to MO_TE definition, and 
> eventually do the change later.
> 
> What do you think?

Removing MO_TE is in my TODO list.

I started with Microblaze (now merged) to get familiar, then had
a look at ARM (see i.e.
https://lore.kernel.org/qemu-devel/20240924191932.49386-1-philmd@linaro.org/ 
and
https://lore.kernel.org/qemu-devel/d831600a-9a61-45c1-a535-f75bb64cdff4@linaro.org/).
I also took care of MIPS few years ago but I need to rebase,
however it isn't in the priority list.

