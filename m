Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C04B1C02181
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2025 16:59:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tae40-0006uo-Cu; Wed, 22 Jan 2025 11:58:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tae3x-0006tL-Q1
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 11:58:45 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tae3u-0000OS-DX
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 11:58:45 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43626213fffso7586585e9.1
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2025 08:58:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737565120; x=1738169920; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zBb0+Z25iBU/ZlpKFdEkVNY3Zn1H2tU+69Z2eZLvuBU=;
 b=RrQhAs0VSbZrYnrTLHbqN35EvT30Kre9svUUEunF/0M1La6ylfZs+rZonTIEKPF9C7
 HTHNrMGfZb1lmLr4wCn5ZIGmZMqQD6nD4Y0yEhgMeqZNA6wWBkKvc3x1Vi8uwhA2TFtV
 1CNZbPW9MHw3Gqz9RspufSNCR9G7mpyz86cDXr0HxtpZCOGh99QdAKyNrd7x1ij+vkam
 CQvPyyBkagmqml/d3CQvUK2ALSFS28LmVpaEt1KLN9FcWyhNM5zEO3YJg4Gh5wkAebfu
 JoFA9F7poaD8BSRcJHrwFZxnEPetXnwtWCARpc0QhdZgzebL0Onry2o/4dyHbAZWaYPc
 6x4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737565120; x=1738169920;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zBb0+Z25iBU/ZlpKFdEkVNY3Zn1H2tU+69Z2eZLvuBU=;
 b=ZCScYVEQisTvQ7M5dXfYJTK8wdmAbZ/3uxOW3dMn4/yxm6uB9k9/tKPg055txfxSCP
 FeY8IY1IF2FqLwgmiwq9PSRgJA/PoSADlRNANuXm9fKyggWSblvPInAaF4J+v71LOK/e
 2/928GJWBWJsCs4goKmevymoAYlFtpTOfNyW+Rdm1Z3OsDpp1qK6Mj29Ig5tR3KVRa6G
 9qpeddXABbYxfmnBvvNkDFg748xNS/7z572NqVy0GxQxO3O11AlvT2HQdJdOY+s+cOsD
 I1d1jkpdSWBb9SyIuRMo1X0cEPGtKPbMEwTbBsH4YtvGB08zfxzSVvdyr7EHFDJSG21B
 uq2g==
X-Gm-Message-State: AOJu0Yw1gVQLpiKs4VNzvd7iVjdmfxHlY9UoIs/s12cq8VbV3NEG+3yn
 eqM4BeKGueuCHJM8fBP456Wt9BPnQfj6Br4LI7kVSUryiIdCi2ZMCfq5Yq966Mc=
X-Gm-Gg: ASbGncsHHY4neAUp2vMs1HL9UbapptBMQpZmkLMAoRR3/5lyFuqPPlUTfMCCKsShO83
 andbotgD7tfJqfGvcQuNsHB/qDfpt8Tu8nol0xQfmDvV4y2WbGwz/zDFGHw1WFjCl454qKM+BIW
 SEiB1v2M2NuLESIQ6k+UDLxPYgG5cbFKrAdNxHg0LQ71i8bouqGnfImXNGw1h2Ao8IgkYt2c5Ax
 lNx5CCO38R3sTAigIZsLQbUxkh4VwiH6WEUNi6B2x2rHpgsvCWhDaajsYFQSvjWfDXY/MvBPiDh
 bTEKB+QQ0v2JaPU6Gr816NrSzt7ajFp1IXN0MA==
X-Google-Smtp-Source: AGHT+IF7oM/QFCgoClUFVA8RcThbQLMdIzzFB2zrpHMCJqkoS64PBhTGB+SZ/2rWyFbIKShPTm29Cw==
X-Received: by 2002:adf:9ccf:0:b0:386:4332:cc99 with SMTP id
 ffacd0b85a97d-38bec505da6mr19793785f8f.17.1737565120299; 
 Wed, 22 Jan 2025 08:58:40 -0800 (PST)
Received: from [192.168.69.181] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38bf3275622sm17053580f8f.69.2025.01.22.08.58.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Jan 2025 08:58:39 -0800 (PST)
Message-ID: <cf3f5611-2e66-4d31-bc20-d70e3bf4230a@linaro.org>
Date: Wed, 22 Jan 2025 17:58:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/boards: Convert MachineClass bitfields to boolean
To: Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-riscv@nongnu.org,
 qemu-arm@nongnu.org, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
References: <20250122103223.55523-1-philmd@linaro.org>
 <6393ca88-0613-415e-8178-18a34778b2ab@redhat.com>
 <CAFEAcA-+9xhH+gXWGfN9bN=rnsShyRs0i+Kd0NDfMYrSNVbF4w@mail.gmail.com>
 <a48356fd-d964-4bd8-b349-3f63c92431a2@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <a48356fd-d964-4bd8-b349-3f63c92431a2@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 22/1/25 16:27, Thomas Huth wrote:
> On 22/01/2025 15.33, Peter Maydell wrote:
>> On Wed, 22 Jan 2025 at 12:36, Thomas Huth <thuth@redhat.com> wrote:
>>>
>>> On 22/01/2025 11.32, Philippe Mathieu-Daudé wrote:
>>>> As Daniel mentioned:
>>>>
>>>>    "The number of instances of MachineClass is not large enough
>>>>     that we save a useful amount of memory through bitfields."
>>>>
>>>> Also, see recent commit ecbf3567e21 ("docs/devel/style: add a
>>>> section about bitfield, and disallow them for packed structures").
>>>>
>>>> Convert the MachineClass bitfields used as boolean as real ones.
>>>>
>>>> Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>> ---
>>>>    include/hw/boards.h        | 14 +++++++-------
>>>>    hw/arm/aspeed.c            |  6 +++---
>>>>    hw/arm/fby35.c             |  4 ++--
>>>>    hw/arm/npcm7xx_boards.c    |  6 +++---
>>>>    hw/arm/raspi.c             |  6 +++---
>>>>    hw/arm/sbsa-ref.c          |  2 +-
>>>>    hw/arm/virt.c              |  2 +-
>>>>    hw/arm/xilinx_zynq.c       |  2 +-
>>>>    hw/avr/arduino.c           |  6 +++---
>>>>    hw/core/null-machine.c     | 10 +++++-----
>>>>    hw/i386/microvm.c          |  2 +-
>>>>    hw/i386/pc_piix.c          |  2 +-
>>>>    hw/i386/pc_q35.c           |  4 ++--
>>>>    hw/loongarch/virt.c        |  2 +-
>>>>    hw/m68k/virt.c             |  6 +++---
>>>>    hw/ppc/pnv.c               |  2 +-
>>>>    hw/ppc/spapr.c             |  2 +-
>>>>    hw/riscv/virt.c            |  2 +-
>>>>    hw/s390x/s390-virtio-ccw.c |  8 ++++----
>>>>    hw/xtensa/sim.c            |  2 +-
>>>>    20 files changed, 45 insertions(+), 45 deletions(-)
>>>
>>> So if you are touching all these files, why not go with an even more
>>> meaningful rework instead? Flip the meaning of the "no_*" flags to the
>>> opposite, so that we e.g. have "has_default_cdrom" instead of 
>>> "no_cdrom",
>>> then new boards would not have to remember to set these ugly "no_" flags
>>> anymore. It's quite a bit of work, but it could certainly be helpful 
>>> in the
>>> long run.
>>
>> Well, that depends on what you think the default for new
>> boards should be. I suspect these are all no_foo because
>> when they were put in the idea was "all boards should
>> be default have a foo, and 'this board defaults to not
>> having a foo' is the rarer special case it has to set"...
> 
> That might have been the reasoning for the naming 20 years ago. But 
> times have changed... which recent board does still have a floppy drive? 
> parallel port? And the others are also not that common anymore...

I tried but not much interest:
https://lore.kernel.org/qemu-devel/219be312-4acc-46c9-8a56-16e5cb483ae4@linaro.org/

So Daniel suggested to clean the bad bitfield pattern in parallel.

