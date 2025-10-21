Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B53B3CCD1A5
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 07:56:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vB7Dm-0004D1-FU; Tue, 21 Oct 2025 03:55:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vB7Dj-0004CX-R4
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 03:55:51 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vB7De-0003Aa-AB
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 03:55:51 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4711b95226dso40154755e9.0
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 00:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761033343; x=1761638143; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qzGFx25f9CU4f0k+8+/Qge7EPXnpJflLIxX31Ci50KI=;
 b=R/zWB8hg5lY9BlBE2gTGCmjMzdZKcAbNWJKY5B8H4lF6j99SIOfYtTptCH6wC96cI9
 vRMRa05F/4onm3K4RhfBlL2+vj1gFU6Sdf1Kld2nIl3Dm7wHIXEhwjxouYPbiiVx9qrh
 mWQtrr+xxu6r4biBNORaLIpM989NLRmGYVfuOz8pOYpc0INwrvxVYMa7Pdb+QXmwLvop
 4rHUWJEv4MNrgu3SIVb8Yr6K7qolKoFL/wOzQ/jEmqHAGn5f+HUyz+9VdLq1NpSWXxxq
 F0JlYD0UhTHgMgGeb6PJBFbnWeROufujHKoD7GIbJFEcwWsauNTcFOmBm2Lj3PBvWxoZ
 Lt5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761033343; x=1761638143;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qzGFx25f9CU4f0k+8+/Qge7EPXnpJflLIxX31Ci50KI=;
 b=J6LM1hpUPs1XvKb7FmAU7YkhOM3ioAAoV2w+p6VpfzAq87T7saxlsRwciwugGwLKef
 VGhjJuhwsIFzAduFOh7kIwxCU8r40neMQGSmu94ZJmkokxiP3xr1IMHDePloMdnBJ8e+
 DAWDFbnwLfLovOS9iQdt4qn4BThbfeYS7V3DHZDVq6t0FE26rowcdxxHKvT+nEwoSxKt
 nmjQbcwb8Cwy8LW0kbUJ76HTv3cMtkNr6mKmbeoo+sKLYC8H5bTeQlzvSzj8UA6nbBGi
 B0NqyonqC3ve76jk8XvI0voH2ubFHq4d26jgRgM3r/WdIX3k4MGV91EL2WGfvbIXxSbe
 pFbA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV03fmRjj0e+12d25WPaf0uOUnS+y7XBl1OG7fgmJptqRetUP9LlurqQn+icSkvJhslaPmw/rkkbr6X@nongnu.org
X-Gm-Message-State: AOJu0YzCiSGnTAT3rIYgz4wSkXdWfBHUbqQ8lPCZT4XXyiFR1DoEIDFf
 /tElLBtkbat+IYf/qGZmmCJbAM0GlMNGX1Grg8h99TQmW/xbnXCRiwbYAvBgjdw5JTI=
X-Gm-Gg: ASbGncv0tcVALcRo61+D3LaTizVfKu+HgAwZ4eG6nGc22c/SlFIzIX3fhlohozQ3Q0a
 JvXHUK9FHdhgXqwwlMqxrHisg6e6Ig2pdRSRr+g00b1A1EWANHontWSWuvj8de+723T591O6+zZ
 7XObntSC4dEhuELIeydGRGaMIgHeU+Qh0XsFwJHyBKcIWBxrF1stipYI3OIBClNXnZIptRWEcrE
 K018MA4+bfoo8nFCUyZTfvQ9MkU7ptR5KQ3wpdVUr8abJqbY/ScbzWQRnXZyyakFNMdSC3v/hzN
 dQjHj1F8CwqpVUDHkher71rA5ARKcy9xF6ZWBqteow/QX0eRv5FHDJW3joyaip1kx3Ml7w4/QgD
 z1A7RsSLuM+Dp0qxc60q0WtOUl4kgXXssmEnbUNzmU7PoZR5yn65DhkK2fyW+OMqYjB+MSg91fB
 ulAUYnz29m/aKAw1Pj52DYFUXwe/CUg9nwXexEklFSczw=
X-Google-Smtp-Source: AGHT+IEhLMan6NE95k5qpUeyTzN1VkiWFNaJskz7cGA6Qf7j4pgIY9J2gb5xTlWTQm4+Xneq0iKUyA==
X-Received: by 2002:a05:6000:2889:b0:428:3fbb:83f9 with SMTP id
 ffacd0b85a97d-4283fbb8f1amr6296064f8f.40.1761033343153; 
 Tue, 21 Oct 2025 00:55:43 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4711442dbaesm270415835e9.8.2025.10.21.00.55.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Oct 2025 00:55:42 -0700 (PDT)
Message-ID: <27316450-54a9-43af-a6a3-a02373aa8e43@linaro.org>
Date: Tue, 21 Oct 2025 09:55:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 08/30] hw/arm: Filter machine types for
 qemu-system-arm/aarch64 binaries
Content-Language: en-US
To: Jan Kiszka <jan.kiszka@web.de>, qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anton Johansson <anjo@rev.ng>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Bernhard Beschow <shentey@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Samuel Tardieu <sam@rfc1149.net>, Beniamino Galvani <b.galvani@gmail.com>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 Antony Pavlov <antonynpavlov@gmail.com>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, Rob Herring <robh@kernel.org>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>,
 Alistair Francis <alistair@alistair23.me>, Tyrone Ting <kfting@nuvoton.com>,
 Hao Wu <wuhaotsh@google.com>, Felipe Balbi <balbi@kernel.org>,
 Niek Linnenbank <nieklinnenbank@gmail.com>,
 Radoslaw Biernacki <rad@semihalf.com>,
 Leif Lindholm <leif.lindholm@oss.qualcomm.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
References: <20251020220941.65269-1-philmd@linaro.org>
 <20251020220941.65269-9-philmd@linaro.org>
 <29fe5291-9517-4c47-a16a-6de639bdd932@web.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <29fe5291-9517-4c47-a16a-6de639bdd932@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On 21/10/25 07:41, Jan Kiszka wrote:
> On 21.10.25 00:09, Philippe Mathieu-Daudé wrote:
>> Register machines to be able to run with the qemu-system-arm
>> and qemu-system-aarch64 binaries, except few machines which
>> are only available on the qemu-system-aarch64 binary:
>>
> 
> ...
> 
>> diff --git a/hw/arm/musicpal.c b/hw/arm/musicpal.c
>> index 329b162eb20..548c218a039 100644
>> --- a/hw/arm/musicpal.c
>> +++ b/hw/arm/musicpal.c
>> @@ -15,6 +15,7 @@
>>   #include "hw/sysbus.h"
>>   #include "migration/vmstate.h"
>>   #include "hw/arm/boot.h"
>> +#include "hw/arm/machines-qom.h"
>>   #include "net/net.h"
>>   #include "system/system.h"
>>   #include "hw/boards.h"
>> @@ -1346,7 +1347,7 @@ static void musicpal_machine_init(MachineClass *mc)
>>       machine_add_audiodev_property(mc);
>>   }
>>   
>> -DEFINE_MACHINE("musicpal", musicpal_machine_init)
>> +DEFINE_MACHINE_ARM_AARCH64("musicpal", musicpal_machine_init)
> 
> This is modelling a real, ancient device which only had a single CPU
> type and runs the original firmware - makes no sense.

The goal of this effort is to have a single qemu-system-aarch64 binary
absorbing the qemu-system-arm one. At this point we are trying to do
preparatory work with no single change for the users.

Are you suggesting to directly add a DEFINE_MACHINE_ARM() macro for
these 32-bit only machines? This was planned to be done on top, but
maybe you are right, since we have to review this change, better
start with it now...

> Wouldn't be surprised if there are more of this kind in the list.
> 
> Jan
> 

