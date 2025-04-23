Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 756DFC369D3
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 11:24:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7YCp-000297-DZ; Wed, 23 Apr 2025 07:23:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7YCU-00024r-Ef
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 07:23:37 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7YCS-0002YF-Bg
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 07:23:34 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43cf05f0c3eso46739965e9.0
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 04:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745407410; x=1746012210; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CFtAs9bHBO+puoarQmb5VFdBHM3gJ7FvC45474FFlxw=;
 b=ec0IaRt8hE+qPFD2LdKkom5wV7SZz9c9VPsGcqAUSiudrLNtMT74Y/jCDFQDmSHiSO
 HqB7QpFMXuNM6+6/df3aIjMeLLc4mxrexUn9BIW7FVFoZciF6t7hci4gD5+3HNXv/C04
 XPsfUt+P4kNprGl2dFBglQ0gfzYuPh3W6rIbvuzunek1GLtiqHmuqOiJhnsjhdj+Z4Jf
 pV0IoI9XY7stPuOh/jhL/MEdreGTEs+vdNz5/YWF1UIkFGRDo7DHuvBtY2kvdcet6PNw
 5LYIj0CwKDgjhs1WmUdcjHBziIZrXK/nF1JGdSLeRDU8A1Tla/uO1CtSlmGRVu5xBPe1
 Y4MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745407410; x=1746012210;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CFtAs9bHBO+puoarQmb5VFdBHM3gJ7FvC45474FFlxw=;
 b=WT9I2pDBn9S4REP3H9Ar68Np9PK67f6PyG23jPMo0UT3M0lJsy2teyzBt1mQWyYP6z
 e913a3a8OzpLq+y2EH6suRlCWO0WvuA+W7+eDqKlH8qDhGGudD2wy+P5Mrg1V7XKATgD
 +F836T9EZay87F8MHAwHkp5ph9qE6JFHXHLtv6+HBBqBYhUDc7Ur9IaPhMzjUAhMZHDu
 3V3xjl3GtrR1nXPZ8YUDizXVjirHdw4MlXseGQ4wm2i8cFGfoLF8fEoL45Zb4AY4eBLZ
 bRnEUxxjAndXUgveBlFE958dtvdeheCHk9bemkG+b/8Hnh6o/eeVYDf1B/lR9Qn8dLrJ
 xIxA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWyXh9Zg0/5al7EKPVNL1IvORw1UmQtBsw/aDW8iabXowNearY2d3mLEeJmoGA9PjKAF9T91DKQjtTr@nongnu.org
X-Gm-Message-State: AOJu0YxKQVQNLPt4EaPbibJiWSwqc6tAaJFYY9e/2VByEJW7gqhqzrsR
 4UPRKGtyoFbvI03v2PQQB4C2SlUiWcDjQdiYG7SlFqVexwcjmnvLI4PBKDLsClt0aDx9qFelLZB
 l
X-Gm-Gg: ASbGncskxWPTTiMXtZvVeCxLunorARtZ4r2Dn6urLTRo9r3i20MaT3XFfY9ViRBTgSm
 Mu9CT7iJfqYBBkt3kANvf/MUpkb70Y89/s881np3STR0WVr92ulHx8oN8MT8j4LEuxorMUOYW+B
 exMwku5kucpsq9RtH3HH+/kKUhPODMaSAGTYgVps1s2m8pNNHxoSoti4yQxja0oJzUo62QcnVTt
 aoTmb2M7yUKkL76roYVq+RYayBduPt1iPsLH6xK72Y5GUj1Lb/a1fjzbf1bWrXJr4nnWoeTz9ha
 Qkh3WZPvoNTvKZXsnsr2bywK6CexZP083Lre6Ts/6w2pkCltV70c2tWTqP5YTtrPu7/MCnch6b2
 6fTMb3qvE
X-Google-Smtp-Source: AGHT+IGc6fUvsPdyb8hcOx67exhfP/McQu09fXy/eafueZSXyITYdtGZ7rVxMVKYWpQO9D8oB63dgQ==
X-Received: by 2002:a05:600c:54c2:b0:43d:77c5:9c1a with SMTP id
 5b1f17b1804b1-4406b928b57mr135637505e9.4.1745407410608; 
 Wed, 23 Apr 2025 04:23:30 -0700 (PDT)
Received: from [192.168.69.169] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4408d8d191bsm34617975e9.1.2025.04.23.04.23.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Apr 2025 04:23:30 -0700 (PDT)
Message-ID: <dc690610-8484-4da0-9233-74d711f263cf@linaro.org>
Date: Wed, 23 Apr 2025 13:23:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] Move device tree files in a subdir in pc-bios
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org
Cc: "Edgar E.Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Michael Tokarev <mjt@tls.msk.ru>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <cover.1745402140.git.balaton@eik.bme.hu>
 <f3501944-f278-45a8-91a7-0dab5a5416e0@nutanix.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <f3501944-f278-45a8-91a7-0dab5a5416e0@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

Hi Mark,

On 23/4/25 12:18, Mark Cave-Ayland wrote:
> On 23/04/2025 11:02, BALATON Zoltan wrote:
> 
>> Simple series doing what the subject says.
>>
>> v2:
>> - Added changes to qemu.nsi (Philippe)
>> - Changed order of enum to keep it sorted. This changes value of
>> existing define but the value is not relevant, always used by name.
>>
>> BALATON Zoltan (2):
>>    system/datadir: Add new type constant for DTB files
>>    pc-bios: Move device tree files in their own subdir
>>
>>   MAINTAINERS                                |   2 +-
>>   hw/microblaze/boot.c                       |   2 +-
>>   hw/ppc/ppc440_bamboo.c                     |   2 +-
>>   hw/ppc/sam460ex.c                          |   2 +-
>>   hw/ppc/virtex_ml507.c                      |   2 +-
>>   include/qemu/datadir.h                     |  11 +++++++---
>>   pc-bios/{ => dtb}/bamboo.dtb               | Bin
>>   pc-bios/{ => dtb}/bamboo.dts               |   0
>>   pc-bios/{ => dtb}/canyonlands.dtb          | Bin
>>   pc-bios/{ => dtb}/canyonlands.dts          |   0
>>   pc-bios/dtb/meson.build                    |  23 +++++++++++++++++++++
>>   pc-bios/{ => dtb}/petalogix-ml605.dtb      | Bin
>>   pc-bios/{ => dtb}/petalogix-ml605.dts      |   0
>>   pc-bios/{ => dtb}/petalogix-s3adsp1800.dtb | Bin
>>   pc-bios/{ => dtb}/petalogix-s3adsp1800.dts |   0
>>   pc-bios/meson.build                        |  23 +--------------------
>>   qemu.nsi                                   |   2 +-
>>   system/datadir.c                           |   5 ++++-
>>   18 files changed, 42 insertions(+), 32 deletions(-)
>>   rename pc-bios/{ => dtb}/bamboo.dtb (100%)
>>   rename pc-bios/{ => dtb}/bamboo.dts (100%)
>>   rename pc-bios/{ => dtb}/canyonlands.dtb (100%)
>>   rename pc-bios/{ => dtb}/canyonlands.dts (100%)
>>   create mode 100644 pc-bios/dtb/meson.build
>>   rename pc-bios/{ => dtb}/petalogix-ml605.dtb (100%)
>>   rename pc-bios/{ => dtb}/petalogix-ml605.dts (100%)
>>   rename pc-bios/{ => dtb}/petalogix-s3adsp1800.dtb (100%)
>>   rename pc-bios/{ => dtb}/petalogix-s3adsp1800.dts (100%)
> 
> In previous discussions we've had around what to do with pc-bios, wasn't 
> the consensus that we should aim towards dividing up the directory on a 
> per-target basis? I'm wondering if this is going in right direction, as 
> I can certainly see that a per-target split would be more useful to 
> packagers.

pc-bios/ is already a mess, packagers usually take it as a whole. This
series isn't making the current situation worse.

I don't recall a per-target split discussion, but one moving firmware
blobs out of tree in a more adapted storage like git-lfs.

My 2 cents...

Regards,

Phil.

