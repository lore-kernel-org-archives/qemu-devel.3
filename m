Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3C67C369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 10:48:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8GbB-0002Qs-BQ; Fri, 25 Apr 2025 06:48:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8GbA-0002Qj-1U
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 06:48:00 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8Gb7-00013E-U5
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 06:47:59 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43cfebc343dso13754525e9.2
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 03:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745578076; x=1746182876; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ypchpRLlfRQ09Ckjm2etbEojRQ1tDgJT3EJ3DeDQ64M=;
 b=OQyak3VNqNUveRCHhoQDf0OglpSoa4trE+rBA1Trz7xKjRkl133xkCkJbqXiKZAEJJ
 jjBQ3HPdKZ5DCJ6VD7MsFi+SfCaStEmFZpsqg3d9FuKD/iySjKPZuxV4qOM1U0gGf2Ev
 TeBzNnGtw3tFhAVqwn7SMo/iKlFIXQcNffp66r3/T2ywGYRq9MirCFXGGty0/vkog/4T
 7UkHqFLb/mhZhDG1UM5225TIlle4HKCRw/kSXBp7HzhZ+IXFDtVbUDyr7GXTqnwnrfAN
 +AwrM1WKwjQwUS+SQCSm5rhvxo+rxhtB9A1wKtD5RhpZL5ferIMnNtd+n+6yMPxrp2ZZ
 gNmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745578076; x=1746182876;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ypchpRLlfRQ09Ckjm2etbEojRQ1tDgJT3EJ3DeDQ64M=;
 b=pw6b/UCjeghLF7glPMvdzCmwD08n8zd0Q+uUrsLBQ7z+YIwipz4gMAFcTTysMnPDVw
 E5qzr0gO4DnlZWdsU9chYZi5HcK8djEXDzGtntvmRh0105regXo9hz2cehXEa2tHHNk3
 KocuBadHSMklY8deCf4sedUvpbRP4r1ZopRV6UR/IaeFVXEMLHSI4ek/eqnBDFQKT858
 C0qjv963D+i5G7489QuiO/Cg35wyo/2CrNfU7+ne6g/EaxBVyZxossX4V6gxqt8BuSfg
 hKiKEAAOjGcwx/k8zorK+Kjrxii/3c9dM2HJq35ihNqaM/01VWDI6bqafEYawtvcFmmQ
 e/VQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUkZzMM0097il32R+nwOq3QO5B66I/YOYmggBUTOVydB0pxHEROF+z2xrnmcVc8zR6rTFJzFgYQxzt8@nongnu.org
X-Gm-Message-State: AOJu0Yzs0eb9lsUB/16pYRp5bfrLJ4NrFTwLgp/ef53i2Lo0QFishVoS
 BSD2levPxRDUsBuehjwP60ddvTaYX7XkVXeYzltEa4Cqj0BgLCiPkGMfum4RRjY=
X-Gm-Gg: ASbGnctWYmeOBEQ5ba9DnfSwRpSZmo3sIjyloDbURI53Qb3DpvsN+082Cmoex4MlBF0
 mAOrg0Ny25ObFgdjrufNC59KGzVofRbqj0E+BwMGmT70PSXA3p0hFwW9nEMDSw8r+X4rBzxvUba
 1EhsT0JHCxtjrTaSbyiay8ayHQYcFphBQ0cqSauRXhpQedjF1dqtbPbgXTZ3D9hLda9K+cRbGWY
 JMtepFy9Vr+cMcNsfHAIS8glSZoYlcDnsuTwqnbsld4/TLjcK/ma6VQWajrpoiCgtcrkl9R0aCM
 1oT7dm+9IABn22g7cSt/dygndOo0h+fC7TDADqvxnFva/CYdzepxXS7JGIsy0gwkYKs8WHivVEm
 mZTWrAiIQ35jhBpfa5HA=
X-Google-Smtp-Source: AGHT+IFtN7YhPZ/m4QZIp9s3D6nh1kUmHcc7xnhZ2BLHqhEB2Zf3fkTPWykjdryZPRRJofdvthWJSw==
X-Received: by 2002:a05:600c:34ce:b0:43d:fa58:81d3 with SMTP id
 5b1f17b1804b1-440a66b0803mr13762205e9.32.1745578076248; 
 Fri, 25 Apr 2025 03:47:56 -0700 (PDT)
Received: from [192.168.69.169] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-440a5303c68sm20472955e9.12.2025.04.25.03.47.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Apr 2025 03:47:55 -0700 (PDT)
Message-ID: <0604a5c5-3db0-43f7-a747-9d731bda28e8@linaro.org>
Date: Fri, 25 Apr 2025 12:47:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] Move device tree files in a subdir in pc-bios
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>
Cc: Mark Cave-Ayland <mark.caveayland@nutanix.com>, qemu-devel@nongnu.org,
 "Edgar E.Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Michael Tokarev <mjt@tls.msk.ru>, Thomas Huth <thuth@redhat.com>
References: <cover.1745402140.git.balaton@eik.bme.hu>
 <f3501944-f278-45a8-91a7-0dab5a5416e0@nutanix.com>
 <dc690610-8484-4da0-9233-74d711f263cf@linaro.org>
 <aAjTT6qRwp139RII@redhat.com>
 <fe7faa77-6480-b6cb-fb7e-b0ae17735646@eik.bme.hu>
 <aAjlEd5aSx578AJ0@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <aAjlEd5aSx578AJ0@redhat.com>
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

On 23/4/25 15:03, Daniel P. Berrangé wrote:
> On Wed, Apr 23, 2025 at 02:54:26PM +0200, BALATON Zoltan wrote:
>> On Wed, 23 Apr 2025, Daniel P. Berrangé wrote:
>>> On Wed, Apr 23, 2025 at 01:23:28PM +0200, Philippe Mathieu-Daudé wrote:
>>>> Hi Mark,
>>>>
>>>> On 23/4/25 12:18, Mark Cave-Ayland wrote:
>>>>> On 23/04/2025 11:02, BALATON Zoltan wrote:
>>>>>
>>>>>> Simple series doing what the subject says.
>>>>>>
>>>>>> v2:
>>>>>> - Added changes to qemu.nsi (Philippe)
>>>>>> - Changed order of enum to keep it sorted. This changes value of
>>>>>> existing define but the value is not relevant, always used by name.
>>>>>>
>>>>>> BALATON Zoltan (2):
>>>>>>     system/datadir: Add new type constant for DTB files
>>>>>>     pc-bios: Move device tree files in their own subdir
>>>>>>
>>>>>>    MAINTAINERS                                |   2 +-
>>>>>>    hw/microblaze/boot.c                       |   2 +-
>>>>>>    hw/ppc/ppc440_bamboo.c                     |   2 +-
>>>>>>    hw/ppc/sam460ex.c                          |   2 +-
>>>>>>    hw/ppc/virtex_ml507.c                      |   2 +-
>>>>>>    include/qemu/datadir.h                     |  11 +++++++---
>>>>>>    pc-bios/{ => dtb}/bamboo.dtb               | Bin
>>>>>>    pc-bios/{ => dtb}/bamboo.dts               |   0
>>>>>>    pc-bios/{ => dtb}/canyonlands.dtb          | Bin
>>>>>>    pc-bios/{ => dtb}/canyonlands.dts          |   0
>>>>>>    pc-bios/dtb/meson.build                    |  23 +++++++++++++++++++++
>>>>>>    pc-bios/{ => dtb}/petalogix-ml605.dtb      | Bin
>>>>>>    pc-bios/{ => dtb}/petalogix-ml605.dts      |   0
>>>>>>    pc-bios/{ => dtb}/petalogix-s3adsp1800.dtb | Bin
>>>>>>    pc-bios/{ => dtb}/petalogix-s3adsp1800.dts |   0
>>>>>>    pc-bios/meson.build                        |  23 +--------------------
>>>>>>    qemu.nsi                                   |   2 +-
>>>>>>    system/datadir.c                           |   5 ++++-
>>>>>>    18 files changed, 42 insertions(+), 32 deletions(-)
>>>>>>    rename pc-bios/{ => dtb}/bamboo.dtb (100%)
>>>>>>    rename pc-bios/{ => dtb}/bamboo.dts (100%)
>>>>>>    rename pc-bios/{ => dtb}/canyonlands.dtb (100%)
>>>>>>    rename pc-bios/{ => dtb}/canyonlands.dts (100%)
>>>>>>    create mode 100644 pc-bios/dtb/meson.build
>>>>>>    rename pc-bios/{ => dtb}/petalogix-ml605.dtb (100%)
>>>>>>    rename pc-bios/{ => dtb}/petalogix-ml605.dts (100%)
>>>>>>    rename pc-bios/{ => dtb}/petalogix-s3adsp1800.dtb (100%)
>>>>>>    rename pc-bios/{ => dtb}/petalogix-s3adsp1800.dts (100%)
>>>>>
>>>>> In previous discussions we've had around what to do with pc-bios, wasn't
>>>>> the consensus that we should aim towards dividing up the directory on a
>>>>> per-target basis? I'm wondering if this is going in right direction, as
>>>>> I can certainly see that a per-target split would be more useful to
>>>>> packagers.
>>
>> One problem is that pc-bios doesn't only contain machine firmware but also
>> card ROMs which would belong to more targets (or archs) as e.g. PCI cards
>> work on multiple archs. So it's not trivial to split by target, you'd still
>> have a lot of files not easily assigned to any target.
>>
>> This series is in preparation for another that will add a dtb for pegasos2
>> and I did not want to increase the mess and took the opportunity to try to
>> tidy it a bit. I don't intend to do any major refactoring of the pc-bios
>> dir, that's out of scope of these patches.
>>
>>>> pc-bios/ is already a mess, packagers usually take it as a whole. This
>>>> series isn't making the current situation worse.
>>>>
>>>> I don't recall a per-target split discussion, but one moving firmware
>>>> blobs out of tree in a more adapted storage like git-lfs.
>>>
>>> Talking about the pc-bios dir in general is a bit of a can of worms
>>> and we never make concrete progress historically :-(
>>>
>>> Probably best to split up the problem to some extent.
>>>
>>> The device tree files are conceptually quite different from the
>>> 3rd party pre-built firmware images, which are diffferent from
>>> the keymaps.
>>>
>>> IIUC, device tree files are tied to specific machine types, so
>>> I wonder if they should not simply live alongside their machine
>>> type .c impl file, completely outside of pc-bios ?
>>>
>>> eg
>>>
>>>   petalogix-ml605.{dts,dtb} live alongside hw/microblaze/petalogix_ml605_mmu.c
>>>   babmboo.{dts,dtb} live alongside ./hw/ppc/ppc440_bamboo.c
>>
>> You need the dtbs at run time and the dir where we can look files up is the
>> pc-bios. So these need to be installed there at the end. We could scatter
>> them around in the source to put them next their machines but that would
>> make installation of them more difficult than having it in one dir.
>>
>>> For the keymaps it feels like an probable easy win to move them to a
>>> ui/keymaps/ directory instead.
>>
>> Currently you can run a git build directly from build dir and it will find
>> the roms/dtbs/keymaps. You can also run a binary copied elsewhere if you
>> pass -L path/to/pc-bios. Moving things out of it would break this and may
>> cause more problems than it would solve.
> 
> 
> This is just describing a limitation of the current resource locating
> implementation. For running in tree there's no reason why we can't
> look in a different directory for keymaps/dtbs - we just took the
> lazy option historically of putting them alongside firmware. That
> can be fixed.

That can still be fixed later ;) I'm queuing this series as it tidies
a bit the pc-bios/ directory.

Regards,

Phil.

