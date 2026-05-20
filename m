Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C76CCCD5BA4
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 18:08:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPlKz-0003by-75; Wed, 20 May 2026 14:08:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPlKw-0003bf-Qa
 for qemu-devel@nongnu.org; Wed, 20 May 2026 14:08:06 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPlKv-00055v-7n
 for qemu-devel@nongnu.org; Wed, 20 May 2026 14:08:06 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-488b0046078so45958465e9.1
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 11:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779300483; x=1779905283; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=C4GCe8D6r5uk24Ac7Sn1KCtJWqueODF5LPvyRP0dwwI=;
 b=LE67q4LLda65cZ4VQbNM/aTojkbq7VppzvadJRXjMekLNzAnk4VxoOXiZo9pkMd0Bi
 rb6D8Zmg3+WpOH3sPlXjGyNliOt3cs7TPphBq2pVG1GcclZAV4MotJLVW2pGFZh0REPj
 osFoaPvtdcA43c8gWqMj2CP5GzUQkCB3Pa7/a6G4zsnhER9bWEhBzwkCLsBlqdAvutry
 bJpWkkFcynNE97xP4lxrYOsO0qi0voFvzRb07Cis6V/PlAmsEqzPVs6+4nU1OueIGl7J
 Zd+KbeJ+KfQcEhN3gHagVAH0GBG7sPSgIAA7gIPfRW61quAWIdYcoS4v2YmdR+5JcD8+
 DlmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779300483; x=1779905283;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=C4GCe8D6r5uk24Ac7Sn1KCtJWqueODF5LPvyRP0dwwI=;
 b=DQiHPi00VnIIqi8tbKMXFoFAeYtw1sH9fesN1QCR/Tnyx9Bpixt98Hp9TZvi+r4aFx
 LgfFOHPqyYFbBvkJGncjr9/FqVs+s/Vgo8AqWArvrjhYtCiVxsdWKMnL4q8r2STRVxlU
 tUhg8s/OU9xa4MM4edLzFsTpckGeGFsS9rZ83K3V95IZqdC6zawiPPq3pXSOV5Z+h+XL
 aCX3qnOImzqWtzn3d9b03LdUdG2wNTgQ9LlaBLfgCFqVEYbLYhe8ziNIOOXsg1OxLT+D
 TgEGNEGRsxQiKG7GRArXne5stP54D2zbqv/I8oqH58acGTN7ylzzFYe7HcBdZ7EfDd4W
 LRvg==
X-Gm-Message-State: AOJu0YwuQSKVZYe3JUuAUfj9citC9nZ4RjznUaPrGOUYNdiPpFDSUJyO
 QkORqEooGhCSCtsVhBSxtyWFHgPN0jIqQMoJ7N4OQbhL6uEFcwh51X5js1qZJGzTlPF3KEUw8Ea
 9xd+v5aE=
X-Gm-Gg: Acq92OFGjRJOSEZuGrw1HZMbjztGIFDLyWcF49EGz/xg4bxxZ/5ZT0rq/Q9xwnnMqX0
 DTCtqLp0DCVHxmdhRUKKt9u2/hWtLp2RKqIRCAnKQAj14H1YvyCZp4SxWJMwqXkB1AYcTQRxeKe
 BQs1QrBy/nS9PMFxdJ+DGB4poDcApssogjWQs9iMBzhyvowc/iolbaOI2BYu1NDj3n8mr+csBOH
 D66h2llueU9dsCkdHPXxIZHwatpAQvuI1gnQlc51rTFXDbYNgOF5GR6nOW6WwoLCmfqVaNhYzLA
 9XLbYAlQv7AZ/8nEWGmY/1E2wHBLYot89xKVmygl8+nR2WEgUX61CAvecbako/xxKzHQjPA8vFV
 XhiSrBD1oxgIHg22d/mrkJkvJjN5xwgcw87v9ERN/BbqlophQ+Bdj3DduhHYw8HTlia+QIV5XdL
 TbztEcrxkcLBkSgl4idoT4aqQM4aCznt5pdqNalv2atW4NgtycFRCeatFlMscWl3Vj+nwWIF06k
 0/3
X-Received: by 2002:a05:600c:4ed0:b0:490:778:4fec with SMTP id
 5b1f17b1804b1-49007785052mr260786935e9.33.1779300482926; 
 Wed, 20 May 2026 11:08:02 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49033d9ee3bsm7487655e9.14.2026.05.20.11.08.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 May 2026 11:08:02 -0700 (PDT)
Message-ID: <a421bdcc-4312-44a9-a703-5ef58f0ddd1b@linaro.org>
Date: Wed, 20 May 2026 20:08:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 00/24] target/mips: add missing Octeon user-mode
 support (first half)
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: James Hilliard <james.hilliard1@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260520172313.23777-1-philmd@linaro.org>
In-Reply-To: <20260520172313.23777-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 20/5/26 19:22, Philippe Mathieu-Daudé wrote:

> James Hilliard (23):
>    linux-user/mips: implement sysmips(MIPS_FLUSH_CACHE)
>    linux-user/mips: implement sysmips(MIPS_ATOMIC_SET)
>    linux-user/mips, target/mips: honor MIPS_FIXADE for unaligned accesses
>    target/mips: expose Octeon68XX floating-point support
>    tests/tcg/mips: add Octeon instruction smoke test
>    target/mips: fix Octeon arithmetic destination handling
>    target/mips: drop Octeon zero-register fast paths
>    target/mips: split Octeon SEQ/SNE decode
>    target/mips: split Octeon SEQI/SNEI decode
>    target/mips: add Octeon LBX instruction
>    target/mips: add Octeon LHUX instruction
>    target/mips: add Octeon LWUX instruction
>    target/mips: add Octeon SAA instruction
>    target/mips: add Octeon SAAD instruction
>    target/mips: add Octeon ZCB and ZCBT instructions
>    target/mips: add Octeon multiplier state
>    target/mips: add Octeon MTM instructions
>    target/mips: add Octeon MTP instructions
>    target/mips: add Octeon VMULU instruction
>    target/mips: add Octeon VMM0 instruction
>    target/mips: add Octeon V3MULU instruction
>    target/mips: add Octeon QMAC instructions
>    target/mips: add Octeon LA* atomic instructions
> 
> Richard Henderson (1):
>    tcg: Introduce tcg_gen_addN_i64

Series queued, thanks.

