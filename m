Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1291CE77173
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 13:19:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJYEd-00030W-QL; Fri, 06 Dec 2024 08:19:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tJYEU-0002wk-Fi
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 08:18:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tJYEQ-00083x-Jh
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 08:18:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733491133;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=+BCednIJTKjOfYLwTvHeB+hxntOeKOCDZvNo2vmdGjc=;
 b=YFUt1/QYZf42N522n2g29ri1msx06MfoSM9KR1DFghY/PrApcx8d3U5EHp2mq535FC8a9p
 iXbvZwhBde4vhQ5bnPz9+FArL//O41HW+eo5HpAbKQHqg/hq4hNDux0Pa6Cu+NWTzhtBTu
 BiwwGc+jhzZmRp82+i2+RJ55Z8V0t+c=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-CjLoelqSNVC6NmqrY82qYA-1; Fri, 06 Dec 2024 08:18:52 -0500
X-MC-Unique: CjLoelqSNVC6NmqrY82qYA-1
X-Mimecast-MFC-AGG-ID: CjLoelqSNVC6NmqrY82qYA
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6d8b3173b5bso35068706d6.3
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2024 05:18:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733491131; x=1734095931;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+BCednIJTKjOfYLwTvHeB+hxntOeKOCDZvNo2vmdGjc=;
 b=gRB6ulzsisa7N9ecRytLqAH80BdB8Hj/gJ1Qs9fLjJE5EYmZvbHOjR/PsKxciL6exd
 RdZVomtb/rIHQ+FfQicu1V38Dy+g7q126S3vyZ6V6l4mStSIEREvvXcA90JX2l/vzhdM
 LJvfCmRQ522wIHseaxaEhKlOuc98QifypoATVhRpI9i9HPrGjBE8k3AbZDPBOBPdkJGw
 TZjQFuXGr2wt3FmCl6Qi8p/CalgtgLIyoh2g5HoEpXL+xv8fctv7FjT+O//ddwPdKsv8
 UTFdG8Qs9ZV8m/uOeeODNTo2mryL6H3kqmglu1K2I68R/VeyXK2LiNnZSzy2QTYSY7hE
 u6yA==
X-Gm-Message-State: AOJu0Yw4EKOrDB+j5BDsm2kT1aXcF3KQplzMywZrE3MiWdOIWuNklao/
 pTZcYmgXXQNZGWGHdjWU5qCHGLGZl5eZSqgQnYmX71zn6UEatdy4zTsRpV3Qu+9SNPcinOBMFZF
 00b63ZaEOPUa0xJLjOYh7p5usZh4rcp9sUKEi+qPL8+fD64L7XL9F
X-Gm-Gg: ASbGncvuw63pwVa04AS71ZHIbppYc8sSRO5CsawuOl4/RKN0w4tX070SxL3PesDoLUv
 LpL6sn2cT7sTBZqPUdnp2F1PD6FP8tuH9ACrERrvCJhnbCGKbuozoYk67Q9pa78Tm3JR3XIAYyx
 fmxvEuLE6OKQAflXt3UNsDOS+6lo7pCouYSdphl+LwNp8FmpLRMHXAW/F4CfFn6GG24X7kvq6xA
 nnT+TSrHYRmJnEWjigd8pdcbvCGO3FvND0fHsN/o3dvHzk/YfxzQXxczccUp16W1sIDO7Y4z5eB
 NZxiExLYkQ69
X-Received: by 2002:a05:6214:2028:b0:6d8:8f14:2f5c with SMTP id
 6a1803df08f44-6d8e717de65mr62199496d6.23.1733491131399; 
 Fri, 06 Dec 2024 05:18:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFUlc84tRndYP1+hg+gST7LchGO6AvdBB77MQe+Leuwvhu8MjGxAs9LHflKsAdAHygIagI6Jw==
X-Received: by 2002:a05:6214:2028:b0:6d8:8f14:2f5c with SMTP id
 6a1803df08f44-6d8e717de65mr62199116d6.23.1733491131030; 
 Fri, 06 Dec 2024 05:18:51 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d8dac134efsm18752906d6.128.2024.12.06.05.18.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Dec 2024 05:18:50 -0800 (PST)
Message-ID: <3d1b6446-46f8-479f-b777-0dd4072d3e57@redhat.com>
Date: Fri, 6 Dec 2024 14:18:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/10] vfio/igd: Enable legacy mode on more devices
To: Tomita Moeko <tomitamoeko@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Corvin_K=C3=B6hne?=
 <c.koehne@beckhoff.com>
References: <20241206122749.9893-1-tomitamoeko@gmail.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20241206122749.9893-1-tomitamoeko@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On 12/6/24 13:27, Tomita Moeko wrote:
> This patchset extends the support of legacy mode igd passthrough to
> all Intel Gen 11 and 12 devices (including Ice Lake, Jasper Lake,
> Rocket Lake, Alder Lake and Raptor Lake), and emulates GGC register
> in MMIO BAR0 for better compatibiltiy (It is tested Windows and GOP
> driver will read this MMIO register).
> 
> It also replaces magic numbers with macros to improve readability,
> and aligns behavior (BDSM registor mirroring and GGMS calculation for
> gen7) with i915 driver to avoid possible issues.
> 
> The x-igd-gms option removed in 971ca22f041b ("vfio/igd: don't set
> stolen memory size to zero") is also added back so that data stolen
> memory size can be specified for guest. It is tested that GMS may
> related to framebuffer size, a small GMS value may cause display issues
> like blackscreen. It can be changed by DVMT Pre-allocated option in
> host BIOS, but not all BIOS comes with this option. Having it in QEMU
> helps resolves such issues.
> 
> This patchset was verified on Intel i9-12900K CPU(UHD 770, 8086:4680)
> with custom OVMF firmware [1] and IntelGopDriver extracted from host
> bios. IGD device works well in both Windows and Linux guests, and
> scored 726 in 3DMark Time Spy Graphics on Windows guest.
> 
> [1] https://github.com/tomitamoeko/edk2/commits/igd-pt-adl/
> 
> Btw, IO BAR4 seems never be used by guest, and it the IO BAR itself
> is not working on Gen11+ devices in my experiments. There is no hints
> about that in old commit message and mailing list. It would be greatly
> appreciated if someone shares the background.
> 
> Changelog:
> v4:
> * Move "vfio/igd: fix GTT stolen memory size calculation for gen 8+" to
>    the first.
> Link: https://lore.kernel.org/qemu-devel/20241205105535.30498-1-tomitamoeko@gmail.com/

A v4 was not necessary for just this change. Anyhow, It seems the
series is ready and an overall 'Acked-by' from Alex or Corvin would
be appreciated before applying to vfio-next.


Thanks,

C.




> 
> v3:
> * Added new patch to fix GTT stolen memory size calculation for gen 8+
>    devicess.
> * Fixed quirk index in "vfio/igd: add macro for declaring mirrored
>    registers"
> * Fixed condition in "vfio/igd: add x-igd-gms option back to set DSM
>    region size for guest"
> * Updated comments and commit message.
> Link: https://lore.kernel.org/qemu-devel/20241203133548.38252-1-tomitamoeko@gmail.com/
> 
> v2:
> * Droped "vfio/igd: fix GTT stolen memory size calculation for gen 7".
> * Fixed conditions when calculating GGMS size.
> * Added Gemini Lake and Comet Lake device ids.
> * Splited mirroring register declaration macro into a new patch.
> * Minor fixes.
> Link: https://lore.kernel.org/qemu-devel/20241201160938.44355-1-tomitamoeko@gmail.com/
> 
> Tomita Moeko (10):
>    vfio/igd: fix GTT stolen memory size calculation for gen 8+
>    vfio/igd: remove unsupported device ids
>    vfio/igd: align generation with i915 kernel driver
>    vfio/igd: canonicalize memory size calculations
>    vfio/igd: add Gemini Lake and Comet Lake device ids
>    vfio/igd: add Alder/Raptor/Rocket/Ice/Jasper Lake device ids
>    vfio/igd: add macro for declaring mirrored registers
>    vfio/igd: emulate GGC register in mmio bar0
>    vfio/igd: emulate BDSM in mmio bar0 for gen 6-10 devices
>    vfio/igd: add x-igd-gms option back to set DSM region size for guest
> 
>   hw/vfio/igd.c | 262 +++++++++++++++++++++++++++++++-------------------
>   1 file changed, 165 insertions(+), 97 deletions(-)
> 


