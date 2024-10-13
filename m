Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B102CF2592
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Oct 2024 04:54:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1szqba-0003W0-Fe; Sun, 13 Oct 2024 00:53:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1szqbV-0003VT-Ct; Sun, 13 Oct 2024 00:53:18 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1szqbT-0000Fa-Fp; Sun, 13 Oct 2024 00:53:17 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-71e483c83dbso1476872b3a.3; 
 Sat, 12 Oct 2024 21:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728795191; x=1729399991; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
 bh=cyqqoW0zV4ZAbLML4YR5lPXmNCnISJ23jfqnR1RxmUA=;
 b=GqTDqOh8ugbgHLeze2SJZ+nIfhymI9ksfI33gsGRpeCPQcz68viGDOFJOa/BYO4MJK
 kRTQC1nX+lEcyaX1mQa2j6zowNFrwF2Up0IuDQKgvYNtDX50BNJYPTbHv2mzo/2PXJvJ
 c2XEwAUvhUHhaaGFPebv6n3KhlE9oduxqdK3NthBLkjAlr+LKD3Reu4ROCwVyW8KZSXN
 rRL8quMfs8I9gQocH41qmQEuK5zkppsbiXBAaQs7GNNqLFK+kJ1ju6lxueDSWyz2IGqZ
 gsrEbxZ/wKYgjYoNx7DdTmaxrIjXa/gUKLKnSJDnTshf0s5sSCUZLjrFLolh+NI173WM
 wM0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728795191; x=1729399991;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cyqqoW0zV4ZAbLML4YR5lPXmNCnISJ23jfqnR1RxmUA=;
 b=rHiiVw8/NkGhYVnSNVFN+pi9eNq2UkDVB6F1X8Q/GD2PjnTNe1YTErEyafo9vW22jp
 +1LXeYfljXLCF8Q9qFRdRaqbqc5/xs5RRqPQiL/LbAyFxrDGWD/yHr0+TCAO0+ld9zgd
 +iY8SN4JzSd4cCpVLm2MWeS5qroa2/WQR/xZHc+A+Mt58sjAXpsUzHTJ84Z6/evKpuD/
 jvG9ngb2QSyaNkfbuqQW6Su5vowaLF7SXqwKbg3iUK/YT97kKC19o2odXFAEU1VL8vHF
 6Q7e2j50cF2YOfs6X0J1eNC+duxxh1KLGJO2bWfqqFTOq0CDNuloTGWy4Z+o81/d5TPx
 LKUg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUlD3lGOa0gXzzbueuvrY26UYS9l70Y80lZ5COSY2vFVGFUtvgsuqyaNn8l3PE6yk6WojBysxF2GGQ=@nongnu.org,
 AJvYcCXCzpANoc2eIDyY1MxihMZKA2Izw9Vai1F3PVlz8Ub5iJUsHJFFy4H9/NB75nULNnJaAuI1y2nLQ6Ak@nongnu.org
X-Gm-Message-State: AOJu0YxUa7IQWRScRRdSKdK3ABgXabk7sr/s6eK5qhSIu5kGGExayATI
 DZO4O51cCWx2gdffuWJhr+v4EXnDgrWtH4YxLtJMCedU4aqdLtYX
X-Google-Smtp-Source: AGHT+IENsXVjOnPIa2injrOdcj0pireZ5GfGrDLo7gb34uWWsHWMGA0I9FbddMkDhsjDYKiEsyMWag==
X-Received: by 2002:a05:6a00:14d2:b0:71e:55e2:2c48 with SMTP id
 d2e1a72fcca58-71e55e23ed2mr4017499b3a.16.1728795190851; 
 Sat, 12 Oct 2024 21:53:10 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c?
 ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71e2aa937cesm5001855b3a.132.2024.10.12.21.53.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 12 Oct 2024 21:53:09 -0700 (PDT)
Message-ID: <f7fe9a16-4c21-442a-b5dc-9d367450346b@roeck-us.net>
Date: Sat, 12 Oct 2024 21:53:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/11] hw/sh4/r2d: Realize IDE controller before
 accessing it
To: Bernhard Beschow <shentey@gmail.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 qemu-ppc@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Magnus Damm <magnus.damm@gmail.com>
References: <20240208181245.96617-1-philmd@linaro.org>
 <20240208181245.96617-8-philmd@linaro.org>
 <3434b32e-036a-485c-b3c2-3dd111e6152d@roeck-us.net>
 <7735d722-1047-49b2-ae2b-c95ead698a54@redhat.com>
 <61c38817-3b6e-4bc1-a65a-d2208869c53d@linaro.org>
 <08586e5f-6a5e-445c-b74b-e2c12560020f@redhat.com>
 <7CE8EB57-0A75-4AF1-B941-4BC88F9C042D@gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <7CE8EB57-0A75-4AF1-B941-4BC88F9C042D@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=groeck7@gmail.com; helo=mail-pf1-x434.google.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 10/12/24 07:06, Bernhard Beschow wrote:
> 
> 
> Am 12. Oktober 2024 09:40:27 UTC schrieb Thomas Huth <thuth@redhat.com>:
>> On 12/10/2024 00.48, Philippe Mathieu-Daudé wrote:
>>> On 11/10/24 05:23, Thomas Huth wrote:
>>>> On 03/05/2024 23.34, Guenter Roeck wrote:
>>>>> Hi,
>>>>>
>>>>> On Thu, Feb 08, 2024 at 07:12:40PM +0100, Philippe Mathieu-Daudé wrote:
>>>>>> We should not wire IRQs on unrealized device.
>>>>>>
>>>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>>>> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>>>>>> Reviewed-by: Yoshinori Sato <ysato@users.sourceforge.jp>
>>>>>
>>>>> qemu 9.0 fails to boot Linux from ide/ata drives with the sh4
>>>>> and sh4eb emulations. Error log is as follows.
>>>>>
>>>>> ata1.00: ATA-7: QEMU HARDDISK, 2.5+, max UDMA/100
>>>>> ata1.00: 16384 sectors, multi 16: LBA48
>>>>> ata1.00: configured for PIO
>>>>> scsi 0:0:0:0: Direct-Access     ATA      QEMU HARDDISK    2.5+ PQ: 0 ANSI: 5
>>>>> sd 0:0:0:0: [sda] 16384 512-byte logical blocks: (8.39 MB/8.00 MiB)
>>>>> sd 0:0:0:0: [sda] Write Protect is off
>>>>> sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
>>>>> ata1: lost interrupt (Status 0x58)
>>>>>
>>>>> [ and more similar errors ]
>>>>>
>>>>> qemu command line:
>>>>>
>>>>> qemu-system-sh4eb -M r2d -kernel arch/sh/boot/zImage \
>>>>>      -snapshot -drive file=rootfs.ext2,format=raw,if=ide \
>>>>>      -append "root=/dev/sda console=ttySC1,115200 noiotrap" \
>>>>>      -serial null -serial stdio -monitor null -nographic -no-reboot
>>>>>
>>>>> Bisect points to this patch (see below). Reverting it fixes the problem.
>>>
>>> Sorry Guenter for missing your email :(
>>>
>>>>
>>>>    Hi Philippe!
>>>>
>>>> Today I noticed that our sh4 test from tests/avocado/tuxrun_baselines.py is failing (which is not run by default, that's why nobody noticed), and bisection took me to the same result that Guenter already reported.
>>>
>>> "not run by default" because flaky.
>>>
>>> Having a quick look, the problem seems hw/ide/core.c uses non-QOM
>>> shortcuts. In particular ide_bus_init_output_irq() expects a preset
>>> IRQ. Not something trivial to fix.
>>
>> I wonder whether the other spots that use ide_bus_init_output_irq() or similar constructs are broken now, too. Bernhard apparently already fixed (reverted) one in commit 143f3fd3d8b51d6526c8ea80e8a2a085f6f01cdf.
>>
>> But what about fc432ba0f58343c8912b80e9056315bb9bd8df92 ?
> 
> There is an indirection going on in pmac_ide_irq() which triggers real_*_irq. These get wired via sysbus API after realize() while ide_bus_init_output_irq() wires to pmac_ide_irq(). So fc432ba0f58343c8912b80e9056315bb9bd8df92 seems safe to me (haven't tested it though).
> 

Not sure if that answers the question, but booting from ide works
for both mac99 and g3beige emulations.

Guenter


