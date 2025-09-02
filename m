Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E8F1CA1005
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 18:00:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utVIJ-0006PV-Vt; Tue, 02 Sep 2025 13:59:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utVIH-0006NP-QP
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 13:59:45 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utVID-0003yt-VM
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 13:59:45 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3cf48ec9fa4so3114998f8f.0
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 10:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756835980; x=1757440780; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=I2moUXp+72EwRvb7bvvDBSR4AmGddImMySB6D88EBOw=;
 b=bbUscMYxD8krw0l3x9VkKrm+3TN6jef3Di4dYSIfoszX127viWYBHNDi8FXw4eCmKc
 YOR7XliUsQ2EA4fmuVFtdp7TWxSQ1ZkafE74J/KoGQFVtFetDxa0jL2W2/RZKIS4gt2b
 oSY3qrcBsUP305GIV/lifMcNL+ZANfy4k8LfeO++eVhSN9/Go53RWzNy60dpiyAn/IRx
 LS7Rv0ecjqGw2eA1YV7GvbJyN9VLsO5T6TVq7J2BBRUNcZpGjiY/A6trSwdL/S20yADW
 dAvzLM5MansJE8puolWy2UuACAyUuoHXw7Spy7Ef1ZsWKzjhGj7o7X/XuGc4IyRb1emY
 Lu1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756835980; x=1757440780;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=I2moUXp+72EwRvb7bvvDBSR4AmGddImMySB6D88EBOw=;
 b=d6wih0bydSE0QnVkfyekfoK/hvd09Q0cTECAOuwDaYKLZMrCjc/o/mXoLoJTD2fxmG
 xG5OQGkzVjG0o1KngJqMb5unLfUY3cFb6JWbdagFtk7Z2QiUZ4KiVS0CbUZ4f7wTi+hR
 Wenec6sF5N0btwk6/fqQZaY+ZvMsBvUkVRKwNBQzUhIDDTs+4/nxG9xOULu76YVI3cjX
 FihxLU1lkztDKlfYvQmy0PJxlAFf7zr3wOXofJHnkvBiKXQKyZgTH0th1KIvKn+Kdzr4
 avs9M4xvPsXpOrw3r4JZ3yjvZe/Z1EBRQYWbO9n4KuN9l0DKBRno33b7yWzKolWZNQ2e
 MpFA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVEFsq+Xn39Z6I82CTgcImWyne5lorMnKTxgaAuKBT6QupkS277DCnHv3rFyns85iRUC+exT/rZ78tu@nongnu.org
X-Gm-Message-State: AOJu0Yx5w/nCCEhQjLCDKvgmnlgTfTkkZ3sRmj9f0PKSKM9SUQ1DGlOQ
 YJKRau26OcJdhZ3XsNU1mAmVpvWLMy2TPFJpC3PFn9lWD2ya8mPfAOTE13eYeIIzU08=
X-Gm-Gg: ASbGncvLkDhVOF2cAGplfMlqn6S1Q9KbVNRlrfcwgqRemgdKUx1HZhAwLhI+54QgMA2
 2yxufOp7nKTLNzh9hU0GdDnAf0Fr2Nq1g/0roz2CgGCOKz5dCj7dmhU+y2piGExQUSH4VoJ07rH
 3a/2em0xslRbzPA+GQqN+49SNz843mE+XwypF0XgGBE/qJ/4Gn/lZcIWN4rYd+ZRmoJ47dPUYep
 1NGS96k3gmJXSD8/b6hB5w8F/utj9eoBHXFtzngAQMlDaTd99Wynx8yvI+RnGpMuXrvcW7D39KB
 OdvqtndOzFKj4+kQ22vnmc445o8xX9YWGhr5gHKfQfePC+NIn/Q5XRBT0utye45CPFnetbd1MeM
 Gxx37YqacORG032gOdppRCz2TA6H2jHkXTlCydoOvfjKj25vqotFbCCW6IincYd00sxXcKNMdhd
 mc
X-Google-Smtp-Source: AGHT+IFfnWyaGLt5KToT3/BdiPq66qDxsW6nKd9aPL5GhexGaWbpNbaj9u70Q6ExPZf2HbaXHD3saQ==
X-Received: by 2002:a05:6000:2288:b0:3c9:9b3b:53c9 with SMTP id
 ffacd0b85a97d-3d1dea8d81bmr10329216f8f.44.1756835980059; 
 Tue, 02 Sep 2025 10:59:40 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b7e8879cesm205297205e9.12.2025.09.02.10.59.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Sep 2025 10:59:39 -0700 (PDT)
Message-ID: <84b6866f-e36f-4794-81f2-52c2f8c37355@linaro.org>
Date: Tue, 2 Sep 2025 19:59:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/8] hw/sd/sdcard: Fix size check for backing block
 image
To: Jan Kiszka <jan.kiszka@siemens.com>, Warner Losh <imp@bsdimp.com>
Cc: =?UTF-8?Q?Jan_L=C3=BCbbe?= <jlu@pengutronix.de>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 qemu-devel <qemu-devel@nongnu.org>, Joel Stanley <joel@jms.id.au>,
 Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 qemu-arm <qemu-arm@nongnu.org>, Alistair Francis <alistair@alistair23.me>,
 Alexander Bulekov <alxndr@bu.edu>
References: <cover.1756706188.git.jan.kiszka@siemens.com>
 <11808e86-cee0-48bf-8fbd-de13a9a25ed0@linaro.org>
 <4c039b3c-dc2c-4478-b1bb-90b925e56245@linaro.org>
 <c8e1a073-7702-4bad-b7f1-2b4f51da47f4@kaod.org>
 <03a51e36-9a15-4b49-a310-c36a4d0af360@linaro.org>
 <2abbaeda-f9dc-4045-a9f7-b2b48451255f@kaod.org>
 <42310bdb-4fad-4df2-b7ad-3ff3f863e248@linaro.org>
 <d21f6449-e646-42fc-8277-b011a886e9c9@linaro.org>
 <41d2e67e-3345-4720-b3aa-1051224025de@siemens.com>
 <21b6726a-1ceb-4782-a219-36f32cebb774@siemens.com>
 <a1463f9e36d8b3e6289859bec9a0a5a758709316.camel@pengutronix.de>
 <CANCZdfprQZTVskt-EPgT-ALMO3HU-akdcw+yZ5=9Cmu1F00etQ@mail.gmail.com>
 <85b059c1-4a08-447b-a908-8af6b22d06c3@siemens.com>
 <CANCZdfp5AvUQNJ5m8V=z=R14CRwauSP7Qg+1FZ7VV_Ztb5Rb7A@mail.gmail.com>
 <CANCZdfrqiFBP9vP76yjvurmE5KX=OvC7c6vnUp66xr8jc0zaMg@mail.gmail.com>
 <1a7e47de-0021-4180-90a1-b249af8d22e0@siemens.com>
 <CANCZdfrgB5NXNSa+KHs9AcgFW8Qy+raj1a75DkuQeX2Lt1=aAw@mail.gmail.com>
 <85e230b8-75f5-43c7-897f-5abb18799d52@siemens.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <85e230b8-75f5-43c7-897f-5abb18799d52@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

On 2/9/25 19:53, Jan Kiszka wrote:
> On 02.09.25 19:48, Warner Losh wrote:
>>
>>
>> On Tue, Sep 2, 2025 at 11:37 AM Jan Kiszka <jan.kiszka@siemens.com
>> <mailto:jan.kiszka@siemens.com>> wrote:
>>
>>      On 02.09.25 19:30, Warner Losh wrote:
>>      >
>>      >
>>      > On Tue, Sep 2, 2025 at 11:22 AM Warner Losh <imp@bsdimp.com
>>      <mailto:imp@bsdimp.com>
>>      > <mailto:imp@bsdimp.com <mailto:imp@bsdimp.com>>> wrote:
>>      >
>>      >
>>      >
>>      >     On Tue, Sep 2, 2025 at 11:18 AM Jan Kiszka
>>      <jan.kiszka@siemens.com <mailto:jan.kiszka@siemens.com>
>>      >     <mailto:jan.kiszka@siemens.com
>>      <mailto:jan.kiszka@siemens.com>>> wrote:
>>      >
>>      >         On 02.09.25 19:07, Warner Losh wrote:
>>      >         >
>>      >         >
>>      >         > On Tue, Sep 2, 2025 at 10:49 AM Jan Lübbe
>>      <jlu@pengutronix.de <mailto:jlu@pengutronix.de>
>>      >         <mailto:jlu@pengutronix.de <mailto:jlu@pengutronix.de>>
>>      >         > <mailto:jlu@pengutronix.de <mailto:jlu@pengutronix.de>
>>      <mailto:jlu@pengutronix.de <mailto:jlu@pengutronix.de>>>> wrote:
>>      >         >
>>      >         >     On Tue, 2025-09-02 at 18:39 +0200, Jan Kiszka wrote:
>>      >         >     > > > I expect us to be safe and able to deal with non-
>>      >         pow2 regions
>>      >         >     if we use
>>      >         >     > > > QEMUSGList from the "system/dma.h" API. But
>>      this is
>>      >         a rework
>>      >         >     nobody had
>>      >         >     > > > time to do so far.
>>      >         >     > >
>>      >         >     > > We have to tell two things apart: partitions
>>      sizes on
>>      >         the one
>>      >         >     side and
>>      >         >     > > backing storage sizes. The partitions sizes are
>>      (to my
>>      >         reading)
>>      >         >     clearly
>>      >         >     > > defined in the spec, and the user partition (alone!)
>>      >         has to be
>>      >         >     power of
>>      >         >     > > 2. The boot and RPMB partitions are multiples of
>>      128K.
>>      >         The sum
>>      >         >     of them
>>      >         >     > > all is nowhere limited to power of 2 or even only
>>      >         multiples of 128K.
>>      >         >     > >
>>      >         >     >
>>      >         >     > Re-reading the part of the device capacity, the rules
>>      >         are more
>>      >         >     complex:
>>      >         >     >  - power of two up to 2 GB
>>      >         >     >  - multiple of 512 bytes beyond that
>>      >         >     >
>>      >         >     > So that power-of-two enforcement was and still is
>>      likely
>>      >         too strict.
>>      >         >
>>      >         >
>>      >         > It is. Version 0 (and MMC) cards had the capacity
>>      encoded like so:
>>      >         >                 m = mmc_get_bits(raw_csd, 128, 62, 12);
>>      >         >                 e = mmc_get_bits(raw_csd, 128, 47, 3);
>>      >         >                 csd->capacity = ((1 + m) << (e + 2)) * csd-
>>      >         >read_bl_len;
>>      >         > so any card less than 2GB (well, technically 4GB, but 4GB
>>      >         version 0
>>      >         > cards were
>>      >         > rare and broke some stacks... I have one and I love it on my
>>      >         embedded
>>      >         > ARM board
>>      >         > that can't do version 1 cards). Version 1 cards encoded
>>      it like:
>>      >         >                 csd->capacity =
>>      >         ((uint64_t)mmc_get_bits(raw_csd, 128,
>>      >         > 48, 22) +
>>      >         >                     1) * 512 * 1024;
>>      >         > So it's a multiple of 512k. These are also called 'high
>>      >         capacity' cards.
>>      >         >
>>      >         > Version 4 introduces an extended CSD, which had a pure
>>      sector
>>      >         count in
>>      >         > the EXT CSD. I think this
>>      >         > is only for MMC cards. And also the partition information.
>>      >         >
>>      >         >
>>      >         >     > But I still see no indication, neither in the existing
>>      >         eMMC code
>>      >         >     of QEMU
>>      >         >     > nor the spec, that the boot and RPMB partition
>>      sizes are
>>      >         included
>>      >         >     in that.
>>      >         >
>>      >         >     Correct. Non-power-of-two sizes are very common for real
>>      >         eMMCs.
>>      >         >     Taking a random
>>      >         >     one from our lab:
>>      >         >     [    1.220588] mmcblk1: mmc1:0001 S0J56X 14.8 GiB
>>      >         >     [    1.228055]  mmcblk1: p1 p2 p3 p4
>>      >         >     [    1.230375] mmcblk1boot0: mmc1:0001 S0J56X 31.5 MiB
>>      >         >     [    1.233651] mmcblk1boot1: mmc1:0001 S0J56X 31.5 MiB
>>      >         >     [    1.236682] mmcblk1rpmb: mmc1:0001 S0J56X 4.00 MiB,
>>      >         chardev (244:0)
>>      >         >
>>      >         >     For eMMCs using MLC NAND, you can also configure part of
>>      >         the user
>>      >         >     data area to
>>      >         >     be pSLC (pseudo single level cell), which changes the
>>      >         available
>>      >         >     capacity (after
>>      >         >     a required power cycle).
>>      >         >
>>      >         >
>>      >         > Yes. Extended partitions are a feature of version 4
>>      cards, so
>>      >         don't have
>>      >         > power-of-2 limits since they are a pure sector count in the
>>      >         ext_csd.
>>      >         >
>>      >
>>      >         JESD84-B51A (eMMC 5.1A):
>>      >
>>      >         "The C_SIZE parameter is used to compute the device
>>      capacity for
>>      >         devices
>>      >         up to 2 GB of density. See 7.4.52, SEC_COUNT [215:212] , for
>>      >         details on
>>      >         calculating densities greater than 2 GB."
>>      >
>>      >         So I would now continue to enforce power-of-2 for 2G
>>      (including)
>>      >         cards,
>>      >         and relax to multiples of 512 for larger ones.
>>      >
>>      >
>>      >     It's a multiple of 512k unless the card has a ext_csd, in
>>      which case
>>      >     it's a multiple of 512.
>>      >
>>      >
>>      > More completely, this is from MMC 4.0 and newer. Extended Capacity SD
>>      > cards report this in units of 512k bytes for all cards > 2GiB.
>>      >
>>
>>      I'm not sure which spec version you are referring to, but JESD84-A441
>>      and JESD84-B51A mention nothing about 512K, rather "Device density =
>>      SEC_COUNT x 512B". And these are the specs we very likely need to follow
>>      here.
>>
>>
>> You are right that this is in the MMC spec. However, the SD spec is
>> controlling for SD cards.
>>
>> SD Specifications Part 1 Physical Layer Simplified Specification Version
>> 9.10
>> December 1, 2023
>>
>> Section 5.3 describes the CSD. Version 1.0 (which I'd called version 0
>> in an earlier email because of its encoding) is the 2GB rule. Version
> 
> < 2G or <= 2G? For eMMC, it is <=.
> 
>> 2.0 and 3.0 encode it as 512k count (from 5.3.3):
>>
>> C_SIZE
>> This field is expanded to 28 bits and can indicate up to 128 TBytes.
>>
>> This parameter is used to calculate the user data area capacity in the
>> SD memory card (note that size of the protected area is zero for SDUC
>> card). The user data area capacity is calculated from C_SIZE as follows:
>>
>> memory capacity = (C_SIZE+1) * 512KByte
>>
>> The Minimum user area size of SDUC Card is 4,294,968,320 sectors
>> (2TB+0.5MB).
>> The Minimum value of C_SIZE for SDUC in CSD Version 3.0 is 0400000h
>> (4194304). The Maximum user area size of SDUC Card is 274,877,906,944
>> sectors (128TB).
>> The Maximum value of C_SIZE for SDUC in CSD Version 3.0 is FFFFFFFh
>> (268435455).
>>
>> So SD cards are yet again gratuitously different than MMC cards.

FTR so far QEMU only models SD spec v2.00 and v3.01, and eMMC spec 4.3.

