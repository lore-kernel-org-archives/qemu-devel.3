Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 759FECAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 11:32:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uy7QJ-0002Ra-9I; Mon, 15 Sep 2025 07:31:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uy7QD-0002Pk-OJ
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 07:31:03 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uy7Q3-0000v8-5Y
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 07:31:00 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-7723cf6e4b6so3161970b3a.3
 for <qemu-devel@nongnu.org>; Mon, 15 Sep 2025 04:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1757935841; x=1758540641; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MHaPpaUUwTF3u2h7vgd4ZSfSpKG/v/F11o+xd7BuNAY=;
 b=dg7aAP/fLGmg7yo2x4vgCV5leelbubNAarQizQAFt8CQfQwIDJ8muv6X4oVnuR85f2
 +XeUiev04yZbJZB55I2y/2Z5vfABe8zygw8E5B2i5Sk9QkXf6nk5a1k1yMGy2XOgc9+i
 VGp5Y4zJZZg7PQ4qlEoh/ZTUw0PvO49JJIRx6CKCu2zcG/FuNaPKriMkJGrcRj1ctAfT
 J5VjmW3gQ+VlR4vvDIRMUZE31eBIGVx9kSiHQQlG1aZAjNabMHcKIoMl7XrtfX5KktN7
 EPcV0beoC23+wljKqYCh/OA7fVspB00DwJaXbWh3CYbXCRlLZQXEkQmv6nLgskqqL/i6
 7mfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757935841; x=1758540641;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MHaPpaUUwTF3u2h7vgd4ZSfSpKG/v/F11o+xd7BuNAY=;
 b=ikNwEIHG5/9Z18QPkYr3AJasZDk69heFLVs69aSyNlYaVnen5qHkrXp4KkrVtDdmgt
 V1nIUxVx8ZKFO23uoyWwWKjAPrAv4QSvY15Fx2HfuiQlzT1HZeDlSfmhF/fsVtukBa1s
 XaPa7c44a4eLdVVzoN2ZSrdbgIXu2SUIDEMvkZSp6fh1iysnmQzFmh1XG7pHhBxGTYOI
 kSOB2j1T0jQFYbitB9hgexy+WEA8W9BA3t2dUuKpcRl1gZ967eAjbfebh0SlFxPnBgB/
 lfeDiLN0hD+oSN+alWorYU2NnCAMxGWKyfz2ba4ycT/oRF+UYwaHmZ8D/ysS3WvvFak1
 x0Xw==
X-Gm-Message-State: AOJu0YwC3thxzQM1Jf+mKdVx/nPwkpNybOfTxpBhMPE4wYA+HpURI10f
 GH6mMNQ5xrJBj9Bsrftl+lT/bjwduSm/SuisfFf4C7YFoW1Kn8ultO/5k1nB+Ruit2zTdIHf9/O
 nIcSJ
X-Gm-Gg: ASbGncsQaplqOq15vwbj1Ne8SnvHJAiczyXhfDx6LgG2+yIJyZzFxeF6lqTA+O3GdiI
 q4/ctjij0g1CjjQb6ZArnEcf71HkAzwEKqq6dneFFBiXYqLCQCLko8S5jjWicdYdU0WkBraO/Gf
 1vjJbqAvUi7ENB5YziHRESEzR8QwXg/mjN3z5f+MhEo+rGa/X+Hb6FQ1zTgX96NVkdbW+H7jnnr
 A8qfz9tV8nk1Y/3r71PAT910CSbnTuvIu6wzBujCpG3Q88aPWW7ibo9//JLUdqRZ4UJsgwdVNmc
 hxC7T6TfHI8Tnko3lWtnwzr+N5sD3mbzJOfwO2CBUqahJeFBskk0uZhgGDlk3ajqGCmETi8mhlU
 JXmEOlQGdUDJZnwAxGVYE5MHeHxOw7hZYOBMkrckC2mVDIRsqNJ2AjkF2QnG9ZcloFKtne1z5WV
 ParU7on8IHTs4=
X-Google-Smtp-Source: AGHT+IGKDcR8Z01ZFprF8e0PG3KgimOJoUd5pK6sn2WYSmuQ7O7oB5kCQXe1Veo/AssAXD63X386KQ==
X-Received: by 2002:a05:6a20:3c8f:b0:262:b539:b889 with SMTP id
 adf61e73a8af0-262b539bcf9mr7297620637.40.1757935841200; 
 Mon, 15 Sep 2025 04:30:41 -0700 (PDT)
Received: from ?IPV6:2804:7f0:bcc0:a026:14f7:a39e:7d17:ef5a?
 ([2804:7f0:bcc0:a026:14f7:a39e:7d17:ef5a])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7761562f25dsm10079357b3a.74.2025.09.15.04.30.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Sep 2025 04:30:40 -0700 (PDT)
Message-ID: <5319bc5d-ee82-43e0-adb2-2657b150a0ea@ventanamicro.com>
Date: Mon, 15 Sep 2025 08:30:34 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-10.1 1/1] roms/opensbi: Update to v1.7
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com
References: <20250723094213.2975268-1-dbarboza@ventanamicro.com>
 <20250723094213.2975268-2-dbarboza@ventanamicro.com>
 <CAKmqyKPirO4wLus3kWeHk_ir6kOTru6U745AVUW1jNzYXbzr2Q@mail.gmail.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Language: en-US
In-Reply-To: <CAKmqyKPirO4wLus3kWeHk_ir6kOTru6U745AVUW1jNzYXbzr2Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x433.google.com
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



On 9/15/25 12:27 AM, Alistair Francis wrote:
> On Wed, Jul 23, 2025 at 7:43 PM Daniel Henrique Barboza
> <dbarboza@ventanamicro.com> wrote:
>>
>> Update OpenSBI and the pre-built opensbi32 and opensbi64 images to
>> version 1.7.
>>
>> It has been almost an year since we last updated OpenSBI (at the time,
>> up to v1.5.1) and we're missing a lot of good stuff from both v1.6 and
>> v1.7, including SBI 3.0 and RPMI 1.0.
>>
>> The changelog is too large and tedious to post in the commit msg so I
>> encourage referring to [1] and [2] to see the new features we're adding
>> into the QEMU roms.
>>
>> [1] https://github.com/riscv-software-src/opensbi/releases/tag/v1.6
>> [2] https://github.com/riscv-software-src/opensbi/releases/tag/v1.7
>>
>> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
>> ---
>>   .../opensbi-riscv32-generic-fw_dynamic.bin    | Bin 268312 -> 268752 bytes
>>   .../opensbi-riscv64-generic-fw_dynamic.bin    | Bin 272504 -> 273048 bytes
>>   roms/opensbi                                  |   2 +-
>>   3 files changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/pc-bios/opensbi-riscv32-generic-fw_dynamic.bin b/pc-bios/opensbi-riscv32-generic-fw_dynamic.bin
>> index b2e740010b..02be3a72a8 100644
>> Binary files a/pc-bios/opensbi-riscv32-generic-fw_dynamic.bin and b/pc-bios/opensbi-riscv32-generic-fw_dynamic.bin differ
>> diff --git a/pc-bios/opensbi-riscv64-generic-fw_dynamic.bin b/pc-bios/opensbi-riscv64-generic-fw_dynamic.bin
>> index 018b4731a7..cce35c65c2 100644
>> Binary files a/pc-bios/opensbi-riscv64-generic-fw_dynamic.bin and b/pc-bios/opensbi-riscv64-generic-fw_dynamic.bin differ
>> diff --git a/roms/opensbi b/roms/opensbi
>> index 43cace6c36..a32a910691 160000
>> --- a/roms/opensbi
>> +++ b/roms/opensbi
>> @@ -1 +1 @@
>> -Subproject commit 43cace6c3671e5172d0df0a8963e552bb04b7b20
>> +Subproject commit a32a91069119e7a5aa31e6bc51d5e00860be3d80
> 
> https://gitlab.com/qemu-project/opensbi needs to be updated, but I
> don't know how to do that...

I don't think we need to do anything aside from upstreaming this patch. The roms/opensbi
repo will just fetch the new subproject commit.

Note that this is a no-binary patch and can't be directly applied, so you'll need to
cherry-pick from the repo I pointed in the commit msg. This is the commit:

https://gitlab.com/danielhb/qemu/-/commit/ad1292586b2ec3ceb836fb7e46982bfa19920d9f


And then:

$ git submodule update --init roms/opensbi
Submodule 'roms/opensbi' (https://gitlab.com/qemu-project/opensbi.git) registered for path 'roms/opensbi'
Submodule path 'roms/opensbi': checked out 'a32a91069119e7a5aa31e6bc51d5e00860be3d80'
$
$ cd roms/opensbi/
$ ls
CONTRIBUTORS.md  COPYING.BSD  docs  firmware  include  Kconfig  lib  Makefile  platform  README.md  scripts  ThirdPartyNotices.md
$
$ git log
commit a32a91069119e7a5aa31e6bc51d5e00860be3d80 (HEAD, tag: v1.7)
Author: Anup Patel <apatel@ventanamicro.com>
Date:   Mon Jun 30 08:37:30 2025 +0530

     include: Bump-up version to 1.7
     
     Update the OpenSBI version to 1.7 as part of release preparation.
     
     Signed-off-by: Anup Patel <apatel@ventanamicro.com>
     Signed-off-by: Anup Patel <anup@brainfault.org>


Note that 'git submodule' already used https://gitlab.com/qemu-project/opensbi.git to retrieve
the commit we want. I don't think we need to do anything special w.r.t the submodule per se.


Thanks,

Daniel


> 
> Alistair
> 
>> --
>> 2.50.1
>>
>>


