Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3C39CCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 07:25:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDe4K-0002Ls-Ew; Tue, 28 Oct 2025 03:24:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDe4I-0002La-9R
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 03:24:34 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDe4F-0003ov-OC
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 03:24:34 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-46fcf9f63b6so33108785e9.2
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 00:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761636269; x=1762241069; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5Wc5EMJcGF/yIZ1a3Xyle52cvqomflG7WNTE1Zfw/QI=;
 b=EISWoKcITGyIGkIJz0OjH0Ya9R83InLZc0eqHXuB1eVLJnkeJcQFQicjk0FyXGafsP
 9+QT1aa75xFiJtMCUL0fYcFC5v+0QGVQn8L1ozHYk6auIvynXCkiuo5U9RhZOnyoI1nd
 4lkMCEVtAQcI3BQroemIPaY9OyUysW2/3l4/8lmzgYDZi24QCsA3S1X/haywvA2p4J86
 0exGehJId/X6vkpoVW1yhXwB4dxgjoBf3eKRWdd29asx8xoVW0JZVmT2xYUzkBSDgxlz
 LhmDibAlvNifd0CH3yQuMFACnVGYdAR1FHaSa9v9HhzkTqNUgelNtH2agyHA11d05kni
 NCRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761636269; x=1762241069;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5Wc5EMJcGF/yIZ1a3Xyle52cvqomflG7WNTE1Zfw/QI=;
 b=LkjgxElYSTWkS11F8nAT+jsSP0XDhiXol14j5JGaT7RDKaSMxC+HdF+DbXTW6NRSiK
 5y6yCR1RQivMjcteizd1ilyZpBwywH9N6+v07BBGkzq10i0smQcl6xYNDDZbVHgJn7o2
 NXDzYHea81sXzAgYRJhYT8p/pxktb5+rYS1tNwa8twit8Gz/KoySS3cIiMF0vcHgmubD
 xV9bDUS1suW7QCV2wHs3aaNGiDJixJ6ZVn2HCAfnRMVbXdK2auZv46BSXBlWgCT90TgA
 RDwnCNeHymzOH8bYaq1eMbGNcpxiLMG5480poRqVsS9VL8KVYCWgETbskcbrcsNS/0x3
 cfpQ==
X-Gm-Message-State: AOJu0YzsV36JUxgtQDC6KcAT4qay3e9xIweYilGnybFqgw41iZ2FmGb9
 8KeP433aSkyjfxU+Tle/5aRTGIaa8s7PyBVR+ixupR0KBjm9hxkqrwhq6yJ4o+uAa7qPjfRnrRr
 DO9PtIHE=
X-Gm-Gg: ASbGncv0qjuJFPj8NXXjsB3BSEJSHPXTlK17DTU5F2gKSoiibrXBjsvSyOh7wxDY1Q7
 0hqAPcUFG0QNW2YtC8JgCtpDI5qdBnS8rfUtJc+xtI2ux8qcV4AsdFjRGY+EcrkWNs5VWuSQ5Bv
 /RO/KTpnEQMlJE1i+cQVEb3Zf/WFHLVDADlZEo03+MfAd2FlQNhegVK9iGga8/X2pDh4WRrqHhy
 7kShdPSzrlR2P/4hTpvydtPjiaF8VNJoWdnifU7F+uRFdrDtveoG3CLjzxFY5XZ+NvQlY3AFBlU
 7ulgezR/OAwrNOpTiaYcFiUytObxRDVdfiJ59dkvUwKr47PZ4TrS3P2HM/QFvxfaGe15UYxZidl
 9lfFiLwBfXmSmnqwTHDbpi2ImIMHwI0ABsgNvmStuwGKCU2jwJckgU+4/9znRewSqzHQ08I9yyl
 yuz3892mrpkh2MnCBhOj2sqcT6OSqWfpsUblZbPGy6Byu2ivZw
X-Google-Smtp-Source: AGHT+IHx5cG+9O/KFCGlN4IXvyg6Dpidl0xdTMmq9j7zCRvdamNWHN3JDp2Ap09izyNQnsEQWwsVpw==
X-Received: by 2002:a05:600c:5246:b0:471:12c2:201f with SMTP id
 5b1f17b1804b1-47717e40d7cmr21207195e9.32.1761636268991; 
 Tue, 28 Oct 2025 00:24:28 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475dd02ce46sm214378625e9.3.2025.10.28.00.24.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Oct 2025 00:24:28 -0700 (PDT)
Message-ID: <5602536a-d57f-466f-8913-0d6264c13eda@linaro.org>
Date: Tue, 28 Oct 2025 08:24:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/pci-host: Set DEVICE_CATEGORY_BRIDGE once in parent
 class_init()
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org, Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>, Troy Lee <leetroy@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Glenn Miles <milesg@linux.ibm.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goat?=
 =?UTF-8?Q?er?= <clg@kaod.org>, Paul Burton <paulburton@kernel.org>,
 Joel Stanley <joel@jms.id.au>, Jagannathan Raman <jag.raman@oracle.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Aurelien Jarno <aurelien@aurel32.net>, BALATON Zoltan <balaton@eik.bme.hu>,
 Aditya Gupta <adityag@linux.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Bernhard Beschow <shentey@gmail.com>,
 qemu-arm@nongnu.org, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Steven Lee <steven_lee@aspeedtech.com>, Nicholas Piggin <npiggin@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Andrey Smirnov <andrew.smirnov@gmail.com>, qemu-ppc@nongnu.org
References: <20251027112306.57634-1-philmd@linaro.org>
 <CAJ+F1CKRRQY9w=e8XnxxMNTLoJqWiN-TBtu7qV_+2pAaEhM5fA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAJ+F1CKRRQY9w=e8XnxxMNTLoJqWiN-TBtu7qV_+2pAaEhM5fA@mail.gmail.com>
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

On 28/10/25 08:16, Marc-André Lureau wrote:
> On Mon, Oct 27, 2025 at 3:37 PM Philippe Mathieu-Daudé
> <philmd@linaro.org> wrote:
>>
>> No need to set DEVICE_CATEGORY_BRIDGE for each device
>> implementing TYPE_PCI_HOST_BRIDGE: set it once in the
>> parent.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> this will also categorize a bunch of devices

Indeed:

$ git grep -l parent.*TYPE_PCI_HOST_BRIDGE
hw/alpha/typhoon.c
hw/pci-bridge/pci_expander_bridge.c
hw/pci-host/articia.c
hw/pci-host/astro.c
hw/pci-host/bonito.c
hw/pci-host/designware.c
hw/pci-host/dino.c
hw/pci-host/grackle.c
hw/pci-host/gt64120.c
hw/pci-host/i440fx.c
hw/pci-host/mv64361.c
hw/pci-host/ppc440_pcix.c
hw/pci-host/ppc4xx_pci.c
hw/pci-host/ppce500.c
hw/pci-host/raven.c
hw/pci-host/sabre.c
hw/pci-host/sh_pci.c
hw/pci-host/uninorth.c
hw/pci-host/versatile.c
hw/pci/pcie_host.c
hw/ppc/spapr_pci.c
hw/s390x/s390-pci-bus.c

So the following ones are categorized:

hw/alpha/typhoon.c
hw/pci-bridge/pci_expander_bridge.c
hw/pci-host/astro.c
hw/pci-host/bonito.c
hw/pci-host/dino.c
hw/pci-host/i440fx.c
hw/pci-host/ppc440_pcix.c
hw/pci-host/ppc4xx_pci.c
hw/pci-host/sh_pci.c
hw/pci-host/versatile.c
hw/pci/pcie_host.c
hw/ppc/spapr_pci.c
hw/s390x/s390-pci-bus.c

I'll update the description.

> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Thanks!

> 
>> ---
>>   hw/pci-host/articia.c     | 1 -
>>   hw/pci-host/aspeed_pcie.c | 1 -
>>   hw/pci-host/designware.c  | 3 ---
>>   hw/pci-host/gpex.c        | 2 --
>>   hw/pci-host/grackle.c     | 1 -
>>   hw/pci-host/gt64120.c     | 1 -
>>   hw/pci-host/mv64361.c     | 1 -
>>   hw/pci-host/pnv_phb.c     | 1 -
>>   hw/pci-host/ppce500.c     | 1 -
>>   hw/pci-host/q35.c         | 1 -
>>   hw/pci-host/raven.c       | 1 -
>>   hw/pci-host/remote.c      | 1 -
>>   hw/pci-host/sabre.c       | 1 -
>>   hw/pci-host/uninorth.c    | 4 ----
>>   hw/pci-host/xilinx-pcie.c | 2 --
>>   hw/pci/pci_host.c         | 1 +
>>   16 files changed, 1 insertion(+), 22 deletions(-)


