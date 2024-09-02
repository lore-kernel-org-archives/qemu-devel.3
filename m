Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE396CD13CF
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2024 11:50:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sl5ZH-0003Km-7p; Mon, 02 Sep 2024 07:49:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1sl5ZE-0003KB-Eu
 for qemu-devel@nongnu.org; Mon, 02 Sep 2024 07:49:56 -0400
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1sl5ZC-0002TH-7z
 for qemu-devel@nongnu.org; Mon, 02 Sep 2024 07:49:56 -0400
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2f3f0a31ab2so46813001fa.0
 for <qemu-devel@nongnu.org>; Mon, 02 Sep 2024 04:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725277792; x=1725882592; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:organization:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=n3RBm/4+x8Ii6qMbo3OkaDPBp3dY/M41qpdpEswMicY=;
 b=CFwAG70s32Zaqa0mNZm5K4gKL4LI5Q4Gio+sDyH3ERG5MnHS2EcZjqu3/+njY7b3Dr
 Fz6Mw/s/Q6TbEt0YtV9g/mRKTW67tORR5jGaasi2JcbPWgl1LSOMD5v1h+Ie6p6sGORA
 m/vbDJ9tyhsijwRYyvqKYgGRV9Vl94Pl1a/3zCytighQsozjy+OG4qUPzJW1w/+Z2cNE
 YSUFyQY4RXJK8ckZbllTA5lOG3kwTj/syuMVAdrupvbF91lg5AaP6Cq8gxMxTx61I+EH
 G3ALhWvsknaf5bzQOelohZeFzZPVlGa1YHrJCqI+1Kmp+ZETkim/08SVkhefm174KQTJ
 fhxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725277792; x=1725882592;
 h=content-transfer-encoding:in-reply-to:organization:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=n3RBm/4+x8Ii6qMbo3OkaDPBp3dY/M41qpdpEswMicY=;
 b=ADhmdIAkJgbW9A79GjS5Jd7NnB9EUdFgsGzynbUz16qShKfBJV2nNgL+frqT7fIaQl
 gDWIBmq+rRMdA7VXLQiGWO0/FJKgBBDtXyI+KRqdtPBagfxvvkPgAMOCysHz56F6Mlaa
 b2LJtqdif/EwR0MV1qRoqlEFMAHwa6ms8RRL+eQNMgkYb+wha5C6p8qBHlS+mqQMX26+
 7kjXPeXFIQj9Q7pxIBQVo7jddjeiMyT9YGneaE22C0cZYsAO1XKlw7P/y7RSTgcTQoZ3
 xCm/54yrUk0TqjQPyUFr0pZhYRzox/ZNZLGhQUxPND6l/whYai5jZUW516OAETTsdgTf
 EdQA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVF8wLXirHN7QB2im6G9aiGm5YLASDHsXOW7IpnC81ByCei4LSays57ct8dtB1XQIfBh7EPwSfEYuti@nongnu.org
X-Gm-Message-State: AOJu0Ywxo3hLVoqMWKLcJrof8rto6ORRK9SCjcUgSkQe6qeWDV5OhU7V
 wguVe5+BhRuexgaFMBEA0hgD5AVweUZiC96sC+YoUtbmbElVIEg073Zy5gta0us=
X-Google-Smtp-Source: AGHT+IFPbTGN8wQrTdgxgRdd8aBE2U+HlnHt9E7YI/BPVlZaHfBZN0+kGeodvyMHIWhnigidhmRPEQ==
X-Received: by 2002:a05:6512:ad1:b0:52e:9f76:53dc with SMTP id
 2adb3069b0e04-53546a59f62mr6619177e87.0.1725277790944; 
 Mon, 02 Sep 2024 04:49:50 -0700 (PDT)
Received: from [192.168.200.25] (83.11.24.101.ipv4.supernova.orange.pl.
 [83.11.24.101]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-53540828d77sm1609267e87.180.2024.09.02.04.49.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Sep 2024 04:49:50 -0700 (PDT)
Message-ID: <d457014f-104a-4fe3-8896-d22425a007e8@linaro.org>
Date: Mon, 2 Sep 2024 13:49:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/2] Specifying cache topology on ARM
To: Alireza Sanaee <alireza.sanaee@huawei.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
References: <20240823125446.721-1-alireza.sanaee@huawei.com>
From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Content-Language: pl-PL, en-GB
Organization: Linaro
In-Reply-To: <20240823125446.721-1-alireza.sanaee@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::235;
 envelope-from=marcin.juszkiewicz@linaro.org; helo=mail-lj1-x235.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 23.08.2024 14:54, Alireza Sanaee via wrote:

> Failure cases:
>      1) there are cases where QEMU might not have any clusters selected in the
>      -smp option, while user specifies caches to be shared at cluster level. In
>      this situations, qemu returns error.
> 
>      2) There are other scenarios where caches exist in systems' registers but
>      not left unspecified by users. In this case qemu returns failure.

Sockets, clusters, cores, threads. And then caches. Sounds like more fun
than it is already.

IIRC Arm hardware can have up to 16 cores per cluster (virt uses 16,
sbsa-ref uses 8) as this is GIC limitation.

I have a script to visualize Arm topology:

https://github.com/hrw/sbsa-ref-status/blob/main/parse-pptt-log.py

It uses 'EFIShell> acpiview -s PPTT' output and gives something like this:

-smp 24,sockets=1,clusters=2,cores=3,threads=4
socket:        offset: 0x24 parent: 0x0
   cluster:     offset: 0x38 parent: 0x24
     core:      offset: 0x4C parent: 0x38 cpuId: 0x0 L1i: 0x68 L1d: 0x84
       cache:   offset: 0x68 cacheId: 1 size: 0x10000 next: 0xA0
       cache:   offset: 0x84 cacheId: 2 size: 0x10000 next: 0xA0
       cache:   offset: 0xA0 cacheId: 3 size: 0x80000
       thread:  offset: 0xBC parent: 0x4C cpuId: 0x0
       thread:  offset: 0xD0 parent: 0x4C cpuId: 0x1
       thread:  offset: 0xE4 parent: 0x4C cpuId: 0x2
       thread:  offset: 0xF8 parent: 0x4C cpuId: 0x3
     core:      offset: 0x10C parent: 0x38 cpuId: 0x0 L1i: 0x128 L1d: 0x144
       cache:   offset: 0x128 cacheId: 4 size: 0x10000 next: 0x160
       cache:   offset: 0x144 cacheId: 5 size: 0x10000 next: 0x160
       cache:   offset: 0x160 cacheId: 6 size: 0x80000
       thread:  offset: 0x17C parent: 0x10C cpuId: 0x4
       thread:  offset: 0x190 parent: 0x10C cpuId: 0x5
       thread:  offset: 0x1A4 parent: 0x10C cpuId: 0x6
       thread:  offset: 0x1B8 parent: 0x10C cpuId: 0x7
     core:      offset: 0x1CC parent: 0x38 cpuId: 0x0 L1i: 0x1E8 L1d: 0x204
       cache:   offset: 0x1E8 cacheId: 7 size: 0x10000 next: 0x220
       cache:   offset: 0x204 cacheId: 8 size: 0x10000 next: 0x220
       cache:   offset: 0x220 cacheId: 9 size: 0x80000
       thread:  offset: 0x23C parent: 0x1CC cpuId: 0x8
       thread:  offset: 0x250 parent: 0x1CC cpuId: 0x9
       thread:  offset: 0x264 parent: 0x1CC cpuId: 0xA
       thread:  offset: 0x278 parent: 0x1CC cpuId: 0xB
   cluster:     offset: 0x28C parent: 0x24
     core:      offset: 0x2A0 parent: 0x28C cpuId: 0x0 L1i: 0x2BC L1d: 0x2D8
       cache:   offset: 0x2BC cacheId: 10 size: 0x10000 next: 0x2F4
       cache:   offset: 0x2D8 cacheId: 11 size: 0x10000 next: 0x2F4
       cache:   offset: 0x2F4 cacheId: 12 size: 0x80000
       thread:  offset: 0x310 parent: 0x2A0 cpuId: 0xC
       thread:  offset: 0x324 parent: 0x2A0 cpuId: 0xD
       thread:  offset: 0x338 parent: 0x2A0 cpuId: 0xE
       thread:  offset: 0x34C parent: 0x2A0 cpuId: 0xF
     core:      offset: 0x360 parent: 0x28C cpuId: 0x0 L1i: 0x37C L1d: 0x398
       cache:   offset: 0x37C cacheId: 13 size: 0x10000 next: 0x3B4
       cache:   offset: 0x398 cacheId: 14 size: 0x10000 next: 0x3B4
       cache:   offset: 0x3B4 cacheId: 15 size: 0x80000
       thread:  offset: 0x3D0 parent: 0x360 cpuId: 0x10
       thread:  offset: 0x3E4 parent: 0x360 cpuId: 0x11
       thread:  offset: 0x3F8 parent: 0x360 cpuId: 0x12
       thread:  offset: 0x40C parent: 0x360 cpuId: 0x13
     core:      offset: 0x420 parent: 0x28C cpuId: 0x0 L1i: 0x43C L1d: 0x458
       cache:   offset: 0x43C cacheId: 16 size: 0x10000 next: 0x474
       cache:   offset: 0x458 cacheId: 17 size: 0x10000 next: 0x474
       cache:   offset: 0x474 cacheId: 18 size: 0x80000
       thread:  offset: 0x490 parent: 0x420 cpuId: 0x14
       thread:  offset: 0x4A4 parent: 0x420 cpuId: 0x15
       thread:  offset: 0x4B8 parent: 0x420 cpuId: 0x16
       thread:  offset: 0x4CC parent: 0x420 cpuId: 0x17

You may find it useful. I tested it only with cache at either core or
cluster level.

