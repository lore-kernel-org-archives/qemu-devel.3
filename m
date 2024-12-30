Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B86DE77188
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Dec 2024 21:29:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tSNJP-0004tV-5Y; Mon, 30 Dec 2024 16:28:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1tSNJH-0004t0-LU
 for qemu-devel@nongnu.org; Mon, 30 Dec 2024 16:28:24 -0500
Received: from mout.gmx.net ([212.227.15.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1tSNJF-0006a4-4g
 for qemu-devel@nongnu.org; Mon, 30 Dec 2024 16:28:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1735594092; x=1736198892; i=deller@gmx.de;
 bh=AHiPbIwizxMCvglt/cvx5wlSL8fZU0qsRJlGi+9PeTo=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=PJDYBtk+lmOju2WOkNaiMpvLn9ZeOF20pqBC7veufVvSzRj50PeY8n1O5M7SVyNM
 LUW2M7L0xSKpPChgckvyCgDbq2F1tswWAYz9ZW5WkocqCzVEjGphZl6zFeuzd6DZx
 fQHJ3r7yvwpeEkDNcLQdH9/0fkQk1MNSUfYrIyzKvNd30PCED9rA5CZUWme2nF+Jw
 g0xGnFCuPdQq+0CvVNjmULzLOGidgmbNKGxQ9ogdMI43ccIBG1rrgzOz3+YV/DvSO
 xemai6JzcoOEBvLdNs4oum5Zx/VET3PfpLp27Ef5Kx9d8tP8gtJOc+e9x78ztInxa
 fDJxQ1bd7o0g3h4jKA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.172] ([109.250.63.155]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MXp5a-1t0yWN3S8q-00Z0qS; Mon, 30
 Dec 2024 22:28:11 +0100
Message-ID: <53d3bc08-0423-4bf6-b1dc-f7f8a6100371@gmx.de>
Date: Mon, 30 Dec 2024 22:28:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/5] hppa CPU reset and speedup
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
References: <20241230152519.86291-1-philmd@linaro.org>
 <32a4d72c-6cc2-4c33-876d-ddf66b71fab4@gmx.de>
 <271cb1a7-88be-47c6-a574-605d294a2a98@linaro.org>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <271cb1a7-88be-47c6-a574-605d294a2a98@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:07dw5OcT6lcQAYYWC5y9R5oG7loWbB1/oyDO1ENh0+gdcHJH/jK
 ZgPe01PxwRypL4pfI6KLAQFeqafyFe5PearTCxu6OACrEqCijVtXT5NRcmG4SVvLQY6HNL9
 EUBNi8C6i96cZvwNtKnIXgS3AaIR3PgAj5M7FhAj4Y0+wwzegeF6fUuUpvaCH0RhaTWcG1a
 oC6Wpt+OaqFezJ0Im1tzQ==
UI-OutboundReport: notjunk:1;M01:P0:ztLsS5rvAWo=;IqboZaVLhhXNrsVxBcqIlwNoQ12
 AKjT3gFi/tZUKiEJyrOTqDCLahNCn5/DvBpUmo1zsKbJGroq4FrSmI1wryqTHY+Praz1iqMJB
 /unBlXtJ1gL4Yoi0Sa97kgvmeXoL/HqH0ZOJIodskIxOpWT13GR36DfZy4jHns7w3LQ3JM45p
 FvECO2eeFJm8U7POX0ugXgvr9ElNUCQVtIKcK6+suaw0V6TdOTeP/yPwUhSg2RJihBXv1yFpb
 NavZqjNXESxtHbMvV80qZGayMv58q5YrL8x+dqvJS+lXrGiC0BeBHu969v2xQdk2MXs2E6d0B
 B6M5lO0ZfJersqUvvracaFtJaLWPf2H0xi45RPATQdj8T966djFEn1/9IvOvV5HYioKopfJ84
 DGyawq9EhYRKrXOlPOhG2/+0Lj55ThnlmhWR4zqPvf9FKWawQEiPkV94q6gyyJYEk4JktMBc5
 jr4Hy+ROkHpGhzH9diui4sM0F3ibe4g3x5mMPvImRgltnfw1iyzm0nJpQrw1Z/l8ivnhzBAez
 +h05f0edsGAoHbSfzxBdLrjHaWQUmZ8Y3wOHOHQjjT4cOK9Y5AdmpqbNzy+/ne1h29xeDNxf3
 8l97QFGdeg37d6ARxp19JewgXlQWUTUV9Z15rsiAoOymdEkDNBqmXmp5rAqB6wNGAg2USPW57
 FY71iOP3HC1Rr+4EgNCfTuy7CnNWD6zCATxuYmqHpFw+Jes54Fyh+ZHd3PrMFY6lsFmIQ6w32
 7kx9qbZovV7jb32UJZ8vYJtkXcShB408bBHV2kYYrFH3X+hNkvBiV9DOxzEcdszC6Z7Z5Inqv
 zjGhQA6MlF0pAaxJCQGESu+DojQOrafMm9zGVQmsyNzSGhQB3jl531+VNDV492fCeQ31TxfuB
 S+sjtE7pfJe79+IMcw0athvz1YaTGdgooLCWG+xeAS5o5hHs263b2ZEUA+9T0GYpBQ+GFPgtp
 tJfP2UinI7pADYeA/LsNXAourcsr8VVTDZmRND4sSAdt65ebfE+T+DgnFVbrGmVN/d93G7xRW
 FabNVZUMeZgQw+nS4RqnbfPjiwa8XndP+/rX/WkGNZpOAh1KvcvljzV8PV/bDzcjQC5yeHImY
 S8aoneMtkgfNBT+JHTLCoZiwVTzbPi
Received-SPF: pass client-ip=212.227.15.18; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 12/30/24 21:36, Philippe Mathieu-Daud=C3=A9 wrote:
> On 30/12/24 21:24, Helge Deller wrote:
>> Hi Philippe,
>>
>> On 12/30/24 16:25, Philippe Mathieu-Daud=C3=A9 wrote:
>>> Respin of:
>>> https://lore.kernel.org/qemu-devel/20241229234154.32250-1- deller@kern=
el.org/
>>> "Add CPU reset function and speed up runtime and translation."
>>>
>>> - Remove hppa_cpu_init()
>>
>> Thanks for picking up my patches and integrating them properly
>> with the reset code.
>> But sadly your changes somehow break hppa 64-bit CPU support.
>> I think it's to when the reset code is called.
>>
>> Easy reproducer (no other options/disc/network needed):
>> ./qemu-system-hppa -smp cpus=3D4 -nographic -machine C3700
>
> [*]
>
>>
>>> - Reset PSW using M bit (untested)
>>
>> We haven't implemented PSW-M support and the first
>> thing the firmware does is to reprogram PSW.
>> So, basically it's not needed.
>>
>>> Helge, could we add a functional test booting Linux?
>>
>> What exactly are you looking for?
>> Some trivial preinstalled disc image with kernels?
>> Any examples?
>
> Your [*] example running SeaBIOS is perfect.
>
> See tests/functional/test_riscv_opensbi.py, but using:
>
>  =C2=A0 wait_for_console_pattern('SeaBIOS PA-RISC 64-bit Firmware')

Then I suggest 2 testcases (32-bit and 64-bit CPU, dropped SMP flag):
./qemu-system-hppa -nographic -machine B160L
./qemu-system-hppa -nographic -machine C3700

Helge

>
>>
>> Helge
>>
>>> Helge Deller (4):
>>> =C2=A0=C2=A0 target/hppa: Convert hppa_cpu_init() to ResetHold handler
>>> =C2=A0=C2=A0 hw/hppa: Reset vCPUs calling resettable_reset()
>>> =C2=A0=C2=A0 target/hppa: Set PC on vCPU reset
>>> =C2=A0=C2=A0 target/hppa: Speed up hppa_is_pa20()
>>>
>>> Philippe Mathieu-Daud=C3=A9 (1):
>>> =C2=A0=C2=A0 target/hppa: Only set PSW 'M' bit on reset
>>>
>>> =C2=A0 target/hppa/cpu.h | 11 +++++++++--
>>> =C2=A0 hw/hppa/machine.c |=C2=A0 6 +++---
>>> =C2=A0 target/hppa/cpu.c | 20 +++++++++++++++++---
>>> =C2=A0 3 files changed, 29 insertions(+), 8 deletions(-)
>>>
>>
>


