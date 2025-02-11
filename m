Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E33E8C0219B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 18:49:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thvIq-0000kw-08; Tue, 11 Feb 2025 13:48:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thvIl-0000kX-SR
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 13:48:08 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thvIj-000676-7W
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 13:48:06 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43934d41730so32773115e9.2
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 10:48:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739299682; x=1739904482; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GhSlOdKNqW4GhGe47R5419vgc3RA6fiWjHwxKk/A0mw=;
 b=XLBr2sZjIMr3WHV9d6dIJt2UItMBMioJETPN3xI9gpiRhEC8yPf70AX8s3LwMEu2+L
 cw0h3V0moIii0nAeJZHOihCuGEeERkiiYe5MvSaOdkQgYWZs7i5CYc1xiJwNDxyGzevx
 2q3NWjxWAwyPkAdxFmfod0yICIsUFnxdYkeYGaMVueianpECI+aTIl22FLDeG80rNBPN
 9CZ8GFpmi5DueLypjq+zgWSLX1yesR37kQDSNahdzD5p1EUueq3DN9uGxoiNb4V9SAAu
 8iEfyjmRJ9HJza0m/N8aFIbJ5hKAjG0aXG8RruHiJekm4f1bgXSC1a8IiU4qv2z19Kiu
 pj6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739299682; x=1739904482;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GhSlOdKNqW4GhGe47R5419vgc3RA6fiWjHwxKk/A0mw=;
 b=LMlzERt3PxsGu81lvEyXaY5tq7ZVuGNkaTWs5sPn5oQbu4RVfSDNFlc/CpNsGDAmXt
 LGmubowUQCfEJQye1rWGugAU2JWCMrudXnneeyNxKDndwth1BsLB+tnIFMC2gXuYn1Hu
 8cJ1Zj20/FWDluXNtJAEFn+D8ZP1LvaQuGSDVJ2gCbzZIr5QQnjOc6oAYsXfIdgSMIx0
 zAC5NqeGi4Pgp0i5gySl5dcX4URfKbPMqpzM+zONgGBVsjv+Nuvj94sZm4tjJWaeHl1U
 ym/iyDTreowvPKy1odwlREP0e+d1i+pvmK/uPoS5/ed0hwK3Aek5pJmQT4WPKpz7luWm
 z4Yg==
X-Gm-Message-State: AOJu0YyZt+24SkDiiw5gxLyr8KtZ3Mx9w9d6kmL0O1/ouYKMJYzilNtF
 YuBxtpCw+5Q8tMZVEnPJY9J6zMwzhhtnxmfP0DTiX6rak7WT3XPV92A0QLKD95Ros6xbuBEHBaO
 6q6Q=
X-Gm-Gg: ASbGncurssMk6MXOn7vScED0RsFtlEAoedVZHLnTRhHJ/lFkKqa0EaZd52SkgN11FPj
 s5kRuaPdGVm4ZOCUeLJMk32mCz0SApuozOf60qMbsKkKTO00Q72nc18x6V3X5l2Ab0Yc9/dscRL
 S6+6UTdh36LLetnNrzQCv7+4Jm4KKjdKfVE9OwCxzYfNEAQ8qt520jh5sgfWssWpuDZxSKtg2Dc
 8+56etyarFnBxaUCj6D16vKx9aqVuM1mhuU4OrA7t7IBuwSgYp1oVZb5Uo1B+Lcy96+heE+90G5
 v3Uk6JAWrlAMjwox2EzzVNtHJmLrlAUoCZcgo0vyiHCOV+OKJVH1qaLxejA=
X-Google-Smtp-Source: AGHT+IF15CObsFE0wlHlJ7iHKQ81gzvedHmo8L5KkhSlQlhzPI/Hw3xrZLFUngDEkUdkHKTciBKjoQ==
X-Received: by 2002:a5d:584c:0:b0:38d:e149:f868 with SMTP id
 ffacd0b85a97d-38dea2f945fmr57239f8f.52.1739299682168; 
 Tue, 11 Feb 2025 10:48:02 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dcd8213f2sm12487072f8f.67.2025.02.11.10.48.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Feb 2025 10:48:01 -0800 (PST)
Message-ID: <f28e0b87-9bb2-4bb3-8c10-1f3ff0f784c2@linaro.org>
Date: Tue, 11 Feb 2025 19:48:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/32] Misc HW patches for 2025-02-10
To: Stefan Hajnoczi <stefanha@gmail.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20250210204204.54407-1-philmd@linaro.org>
 <CAJSP0QWH2+sLaNGwwLTQr5Kud6kKLML_Y24M=Kz1GSX9yRxDQw@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAJSP0QWH2+sLaNGwwLTQr5Kud6kKLML_Y24M=Kz1GSX9yRxDQw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 11/2/25 19:26, Stefan Hajnoczi wrote:
> On Mon, Feb 10, 2025 at 3:43 PM Philippe Mathieu-Daudé
> <philmd@linaro.org> wrote:
>>
>> The following changes since commit 54e91d1523b412b4cff7cb36c898fa9dc133e886:
>>
>>    Merge tag 'pull-qapi-2025-02-10-v2' of https://repo.or.cz/qemu/armbru into staging (2025-02-10 10:47:31 -0500)
>>
>> are available in the Git repository at:
>>
>>    https://github.com/philmd/qemu.git tags/hw-misc-20250210
>>
>> for you to fetch changes up to 1078a376932cc1d1c501ee3643fef329da6a189a:
>>
>>    hw/net/smc91c111: Ignore attempt to pop from empty RX fifo (2025-02-10 21:30:44 +0100)
>>
>> ----------------------------------------------------------------
>> Misc HW patches
>>
>> - Use qemu_hexdump_line() in TPM backend (Philippe)
>> - Make various Xilinx devices endianness configurable (Philippe)
>> - Remove magic number in APIC (Phil)
>> - Disable thread-level cache topology (Zhao)
>> - Xen QOM style cleanups (Bernhard)
>> - Introduce TYPE_DYNAMIC_SYS_BUS_DEVICE (Philippe)
>> - Invert logic of machine no_sdcard flag (Philippe)
>> - Housekeeping in MicroBlaze functional tests (Philippe)
> 
> Please take a look at this CI failure:
> https://gitlab.com/qemu-project/qemu/-/jobs/9106591368

Hmm I can not reproduce locally this error:

   Exception: Asset cache is invalid and downloads disabled

https://gitlab.com/qemu-project/qemu/-/jobs/9106591368/artifacts/external_file/build/tests/functional/microblazeel/test_microblazeel_s3adsp1800.MicroblazeLittleEndianMachine.test_microblaze_s3adsp1800_legacy_le/base.log 
content is:

   2025-02-11 16:24:55,525 - DEBUG: Extract 
/builds/qemu-project/qemu/functional-cache/download/b9b3d43c5dd79db88ada495cc6e0d1f591153fe41355e925d791fbf44de50c22 
format=Nonesub_dir=None member=None

which is correct:

$ sha256sum day13.tar.gz
b9b3d43c5dd79db88ada495cc6e0d1f591153fe41355e925d791fbf44de50c22 
day13.tar.gz

Did you restart the job to see if it is a network issue?

Regards,

Phil.

