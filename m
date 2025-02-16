Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11C66C02198
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 18:02:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjixP-000609-PF; Sun, 16 Feb 2025 13:01:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjixM-0005zl-02
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 13:01:28 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjixJ-00021o-TU
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 13:01:27 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-220c2a87378so50040595ad.1
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 10:01:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739728882; x=1740333682; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1ea4n7JPWKwr4uaFUdOWtkbUszakYylFc74wRblmi2s=;
 b=IP5nm3+VrvKUA+6Yx41Hiy0tvZJNxyTkdzm/N03oHPN/fRc+vTO9gIpAEfjhMWlDNU
 Kyns+YJqwoW9t5G4fFbPLbg8/5TDaqWOZGiHnn19niX/SXv2/jYx2jwIRQP05OsV0I1c
 YibHubFxrhk1lzW50fldmwqlb3yUVvbR+QTcn2FKv2YLy+AKOrvQJdr4W4Q/GBQIlQTU
 em37q2BOVZxdX9CLXJgcTOeMz0519pU27Zb++kVohIpzP1p9JIS9isCT+605vu+Xuejh
 hwJXdqZo5+/DqBlN34vovTCuDbfe4lCHsncfIYbLhtPtYi/tiEuTRUWr1hx9GhuAV5xD
 9HuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739728882; x=1740333682;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1ea4n7JPWKwr4uaFUdOWtkbUszakYylFc74wRblmi2s=;
 b=FIDlGx5mjN2AQkKGf3zAF9YWSmWeyZs9Bc3Z8+uyICX/pNhyHUXR8rrfB4x4OgbIlt
 OJ7uCIETReceu2tXT/qvEYWfkWxRuAo6PHyyw9uoyDLWrg42QrGrUuXOG6OKXkbe8P8h
 6oJ0eL2iTR9A8ULdbsLzISqYaQKCP2yEzU28Yv+Ivljl+Km+6HwprcxwTBaaxVhyjRw+
 DaWtgYfLRTca9hWCw7XAvicWsCiw+rd3bk4qiietBuU7GMw2dTks9aqhfsfwOx1Xjgcc
 bzoX1efbFO7sbpsfD4w9wd3NOFHR92261X2V3VM9LwymwiJR1KqjAF5byl0ASvNxaiGx
 hOQQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/kDkGzTzpydx8bFlC8bJn2DuFUmN+e2dkwVnJJVYJy6jbQYw/pe7Z0Pg57fznF9Vo7Cj1BgoAh/qH@nongnu.org
X-Gm-Message-State: AOJu0YzeGQ3GhkBWEVBgMJxddC7nZ8kg/Cd5RlN40alnlcam/zyC87+2
 Zr7ECwtB1TIEb3NhnYTooivI7qvXAC7ZgdMAhl2cqhRNcQjUgQ3qKdGz0WnvJtA=
X-Gm-Gg: ASbGncsWN8fCUx0teQ/wy/gekimOkSIwjobdHzxMsFiRHbFrQNiTdpNZ7w6f/dpncTV
 3Oxv9lGxx9VX0//AGQwtAdeANttj7yIjYcco4Akbm6Ib8pDJUlP1X1n5ZhLVK/bsl7iECK4bxWB
 m6K7rQ6Zrk+dJK0XAhAobWb7/gNJJXNqi2Jn3L0PzzLP2+PYENhC57SeDzjxmQ/LBoc5NQNrfmd
 CQYvQX7lMdI+gFDdNZNwLRLUmeML4jjfItOtd0W27UrsDdB7PoVgymzR89hlWk+sUZ5GLpHIDT5
 MyKKH0fY4ZJFALjlOo/pdP2Z7IFYYf3VMU5fod/6vCu96lK1UMd62Bw=
X-Google-Smtp-Source: AGHT+IFUndwYhsUU5Agg7bHR7F749DRZm2oHRQqHE4Aakg8s9eloFRnDDCutWixld52be+p+DUZAgw==
X-Received: by 2002:a17:903:1d1:b0:216:501e:e314 with SMTP id
 d9443c01a7336-22104056963mr101528235ad.20.1739728882381; 
 Sun, 16 Feb 2025 10:01:22 -0800 (PST)
Received: from [192.168.0.4] (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-adb5a92d3basm6042711a12.75.2025.02.16.10.01.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 16 Feb 2025 10:01:21 -0800 (PST)
Message-ID: <05f94ee7-a0ea-4e8f-bf84-0674a98cdb96@linaro.org>
Date: Sun, 16 Feb 2025 10:01:20 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tcg: refactor pool data for simplicity and comprehension
To: Michael Clark <michael@anarch128.org>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20250215021120.1647083-1-michael@anarch128.org>
 <a62ee246-4249-458c-9f9b-bad79816ce5e@linaro.org>
 <aedcfd05-96fc-4e8a-9fcb-3763e30a6663@anarch128.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <aedcfd05-96fc-4e8a-9fcb-3763e30a6663@anarch128.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

On 2/16/25 00:00, Michael Clark wrote:
> On 2/16/25 06:58, Richard Henderson wrote:
>>
>>> the label member is merely a pointer to the instruction text to
>>> be updated with the relative address of the constant, the primary
>>> data is the constant data pool at the end of translation blocks.
>>> this relates more closely to .data sections in offline codegen
>>> if we were to imagine a translation block has .text and .data.
>>
>> No, it doesn't.  It relates most closely to data emitted within .text, accessed via pc- 
>> relative instructions with limited offsets.
>>
>> This isn't a thing you'd have ever seen on x86 or x86_64, but it is quite common for 
>> arm32 (12-bit offsets), sh4 (8-bit offsets), m68k (16- bit offsets) and such.  Because 
>> the offsets are so small, they could even be placed *within* functions not just between 
>> them.
> 
> I mentioned before I like the idea and have thought about architectures with constant 
> streams and constant branch units.
> 
> say for arguments sake we considered it 'TCData' with embedded label and reloc (the 
> purpose is the constant after after all, just it is not a TCGTemp, it's an explicitly 
> reified constant in the codegen emitters). wondering if we could add a "disposition" field 
> to control placement. TCG_DISP_TEXT_TB, TCG_DISP_DATA, etc. this way you could ask the 
> code generator to do something more conventional while still supporting the short relative 
> constant islands. "disposition" might be better than section as a name. also a DATA 
> section could be mmap R without X perms to lessen the risk of injecting code as constants.

I don't think there's any point to doing anything differently than we currently do: place 
the data at the end of the TB.

(1) The architectures that we host and use the constant pool currently have
     relatively large displacements: aarch64 (21 bit), x86_64 (32 bit),
     ppc (16 or 34 bit (power10 only)), riscv (32 bit), s390x (34 bit).

(2) The size of a TB pretty generally maxes out at 3-4k, but is firmly capped at 64k
     by uint16_t TranslationBlock.jmp_reset_offset.

(3) The 16 and 21-bit offsets are not large enough to stretch to a read-only mapping.

(4) Memory management of TranslationBlocks becomes *much* more complicated.

> TCGConstant is another alternative I would consider as okay. distinct from TCGTemp of type 
> TEMP_CONST which is heavier weight. it makes one wonder about reification of large 
> implicit constants as opposed to the explicitly emitted ones we are talking about here.

TCGConstant isn't bad, but I think I prefer TCGPoolData as mooted before.

> i'm looking at a TCG source-compatible code generator as an option so I may experiment 
> locally. it is a private interface at the moment anyhow. that just seemed inconsistent as 
> most structure definitions are in the header. but I understand it is a private interface.

The organization of tcg.h is from antiquity.  I am actively trying to reduce the size of 
the exported API.


r~

