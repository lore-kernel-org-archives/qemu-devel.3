Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E73EC369DC
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 12:36:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAT8S-0000jJ-BU; Thu, 01 May 2025 08:35:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAT8Q-0000j1-6m
 for qemu-devel@nongnu.org; Thu, 01 May 2025 08:35:26 -0400
Received: from mail-io1-xd2b.google.com ([2607:f8b0:4864:20::d2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAT8O-0006N3-8l
 for qemu-devel@nongnu.org; Thu, 01 May 2025 08:35:25 -0400
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-864687c830aso81884139f.0
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 05:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746102922; x=1746707722; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OCoWouSDj7xQgUIVjzSkFwjZzpe31Z5F14doF7zHj8I=;
 b=ycuE+z5k5P3wxYV7zbUcs+TcYM4QlUO5q1LbDmvuALBIodFZIG96Cx9k5pp28SuaP/
 v6o5t0VfliI9ry40cCD6GmqUF/49+lz5jpPcFKw3aJxZRiIXtYJfp3SVYswj46TUyDT2
 KienV4Hf67n5aYf4CCPiXBpucQjOg8Jy/YvDhCxgiPG/ziQ2rMNQAhIFIXpjt5uqjG15
 8jF92LcYR7EWvs+CgfCHqHWbFLVLJtlvADDZXTdSByltePRzYEAl2UBU6NHp5Vt8ynbS
 gd37l51vHKV7/V5LcgF273QRTgQCNsQ+2ojae38/aV3ASyJD4xsqPAVIyQvg6OZmACYC
 Ybpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746102922; x=1746707722;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OCoWouSDj7xQgUIVjzSkFwjZzpe31Z5F14doF7zHj8I=;
 b=LYQWoLSkeehwKjwh10GGohDzcaPu3H54meTUdl3XaxNrJKFh33WDeppAYfomVlZKVB
 FnXwo+8MeMw8+JCc+nIAYhYCik8EpKD3Ychi7gXs08zazYLYIbtXGDzKtper6WhmDDJm
 23rG7pGcG/ZGowU/KtSEe3nsEza7Bww7JthA0ilqQRkoiSDHWjhmf2ulOIcjPg1iFGCW
 64xeJUvtASUG+utXkewo1gP8EDIiRVC6d/BsWkB9chQp+wmFDTk8nS9Z20bckUeieAAE
 8lSZ/5sgqzg5DzUKorNAKmhBFK3zOattxnglY+B2Lz9PbZGy2NCKIzrr1TFg3hc5itk/
 Qd3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDzkJ/BJapfHpjqCzHuA+zWUkZllU/KsFGGuKQtykX82oOL60erxU9XKVBXRgFsslPToJDmN7a03d4@nongnu.org
X-Gm-Message-State: AOJu0YzjqXY2RigkK8VH6hew5Javs6Q9YJxhHoHE61VoZOZI1Rk7Ls0W
 BHTWQxfnPHqlxnJg8ErgCOOH7RxWrN+rUKe5Y19XCPxSxE9lH5+NtXsdvw/A8/k=
X-Gm-Gg: ASbGnct+5ULps9Ynl+9fUS09ybh9yeBmBXipFFKjPjlyfOGlZBVZApQY7dTamZXfT8O
 v4qahx12rVoo3Hkm+N+Ly1YuvP2vUk1W4fR/OFnoi5s+9UgVFTVAUNgqZBGLTeLxkgrx4/AXu9d
 xCYCzNKTTjF5uEOTXKHW1Z2q18eLlOtliR94qsGvNj4FHO7OSWtsfRzclsmgI/gXD2Fv39GbKpQ
 NG0v3EbrHcnQVzoPM8bcG0hshcIYSNZJ6ODvd8HyWiZaEYxSg58t9bRRn/0Q3e8KPpedjpBiaf4
 HWlmaXIvyIRktpR41VpR7MxmuJy1EF4g2hNhnKSSld7dDUN99RzKNJp66190VHPxEPgYnQH44gY
 4De94Eigu
X-Google-Smtp-Source: AGHT+IEqTGffDgUoDfr36a5kVB2hmf9T8Yd9yCb9UcfLDNhAcJ8q6T1zkJFb6exuySmCL0Jw9rPe4w==
X-Received: by 2002:a05:6e02:1746:b0:3d9:2fbe:2bb1 with SMTP id
 e9e14a558f8ab-3d9676e4ef5mr86681365ab.12.1746102921943; 
 Thu, 01 May 2025 05:35:21 -0700 (PDT)
Received: from [192.168.69.226] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3d975ec99a8sm1087145ab.33.2025.05.01.05.35.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 May 2025 05:35:21 -0700 (PDT)
Message-ID: <6d17f9a1-67d9-4a97-ae1d-21a78d2592a4@linaro.org>
Date: Thu, 1 May 2025 14:35:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/1] Optimizing the print format of the QEMU monitor
 'info mtree'
To: Chao Liu <lc00631@tecorigin.com>, pbonzini@redhat.com, peterx@redhat.com, 
 david@redhat.com, armbru@redhat.com, balaton@eik.bme.hu
Cc: zhangtj@tecorigin.com, zqz00548@tecorigin.com, qemu-devel@nongnu.org
References: <cover.1746065388.git.lc00631@tecorigin.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <cover.1746065388.git.lc00631@tecorigin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::d2b;
 envelope-from=philmd@linaro.org; helo=mail-io1-xd2b.google.com
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

Hi Chao,

On 1/5/25 04:24, Chao Liu wrote:
> Hi, all:
> 
> Thanks to BALATON, and David for their reviews.
> 
> In PATCH v6:
> 1. Replaced the bool type with enum mtree_node_type to improve code readability.
> 2. Modified the output to use only one horizontal dash instead of two, and
>     aligned character printing for a cleaner look.
> 
> like this:
> 
> ```
> $ ./qemu-system-aarch64 -S -monitor stdio -M raspi4b
> (qemu) info mtree
> address-space: memory
> `- 0000000000000000-ffffffffffffffff (prio 0, i/o): system
>     |- 0000000000000000-000000007fffffff (prio 0, ram): ram
> ...
>     |- 00000000fe000000-00000000ff7fffff (prio 1, i/o): bcm2835-peripherals
>     |  |- 00000000fe900000-00000000fe907fff (prio -1000, i/o): bcm2835-dbus
>     |  |- 00000000fe910000-00000000fe917fff (prio -1000, i/o): bcm2835-ave0
>     |  |- 00000000fe980000-00000000fe990fff (prio 0, i/o): dwc2
>     |  |  |- 00000000fe980000-00000000fe980fff (prio 0, i/o): dwc2-io
>     |  |  `- 00000000fe981000-00000000fe990fff (prio 0, i/o): dwc2-fifo
>     |  |- 00000000fec00000-00000000fec00fff (prio -1000, i/o): bcm2835-v3d
>     |  |- 00000000fec11000-00000000fec110ff (prio -1000, i/o): bcm2835-clkisp
>     |  |- 00000000fee00000-00000000fee000ff (prio -1000, i/o): bcm2835-sdramc
>     |  `- 00000000fee05000-00000000fee050ff (prio 0, i/o): bcm2835-dma-chan15
>     |- 00000000ff800000-00000000ff8000ff (prio 0, i/o): bcm2836-control
> ...
>     |- 00000000ff845600-00000000ff8456ff (prio 0, i/o): gic_cpu
>     `- 00000000ff846000-00000000ff847fff (prio 0, i/o): gic_vcpu
> ```

Could we keep the address ranges aligned? I.e.:

 >   |--+     00000000fe000000-00000000ff7fffff (prio 1, i/o): 
bcm2835-peripherals
 >   |  |---- 00000000fe900000-00000000fe907fff (prio -1000, i/o): 
bcm2835-dbus
 >   |  |---- 00000000fe910000-00000000fe917fff (prio -1000, i/o): 
bcm2835-ave0
 >   |  |--+  00000000fe980000-00000000fe990fff (prio 0, i/o): dwc2
 >   |  |  |- 00000000fe980000-00000000fe980fff (prio 0, i/o): dwc2-io
 >   |  |  `- 00000000fe981000-00000000fe990fff (prio 0, i/o): dwc2-fifo
 >   |  |---- 00000000fec00000-00000000fec00fff (prio -1000, i/o): 
bcm2835-v3d
 >   |  |---- 00000000fec11000-00000000fec110ff (prio -1000, i/o): 
bcm2835-clkisp
 >   |  |---- 00000000fee00000-00000000fee000ff (prio -1000, i/o): 
bcm2835-sdramc
 >   |  `---- 00000000fee05000-00000000fee050ff (prio 0, i/o): 
bcm2835-dma-chan15
 >   |------- 00000000ff800000-00000000ff8000ff (prio 0, i/o): 
bcm2836-control

