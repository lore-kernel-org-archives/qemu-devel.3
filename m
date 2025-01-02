Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BF6EE77188
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 13:59:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTLih-0002t0-1H; Thu, 02 Jan 2025 08:58:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tTLid-0002sd-KH
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 08:58:35 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tTLib-0002cG-Ut
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 08:58:35 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43618283d48so82794635e9.1
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2025 05:58:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735826308; x=1736431108; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MqjEysdRf3BuMavFQ4ZLzmCCIYJWzm6gFgmAX7rlCIQ=;
 b=iuvtoHoU4x+0ReeIaW8fNy5hhclF01+1wE4+1nNE98vjQ5SJEBRM/O/kgO/HKLX+E6
 PyI/qEJiyp7t7UFbnnq8Qiko28uAQJ1U5RlGRXveXfl8CZ3KX8ZFI83u/m7JZNA13F4H
 4f08EXcvO24ki3dgwLELNossXEEe3K/oVzM0AIIoxKazPWjbKop5uQjMiQWyiqWwcfO1
 axRhCkAAZ8bPx36pQ4poMKGA7CR+4Sg1zClJxGbevklrDS5prO1Apa/DXVLVOddJaBGk
 OfgUl0tZF2pcU8N9O1s+8dYrGgSubCT0RrzpDkQS3BDXSzyPKhkwiYbjOLUvQjCaHmUa
 iRlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735826308; x=1736431108;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MqjEysdRf3BuMavFQ4ZLzmCCIYJWzm6gFgmAX7rlCIQ=;
 b=DPWr2MyaIJB8gPyGjik3QSLvSYkDVynzZlDNyBWfabuiW2fIkFExdsViwtAzbQDKWV
 Y0h/XxOf52U8pzHkHY4mcG87O+Bld7WFLJd1iPOHPC0BZGGi2s1EvshabnHoP/vs5i7C
 8CaRG7ws259rbE8V4aXhOhS4Mc0dtnohCRjnOR0acCEtAg5iPfkbZNp4+9qivRSNl2SX
 ClQvaLevyFRyf2o/cuipIIUaqn0Bjyaz+5NbBNXTyUnBwPA8wzxoxiUyRVH4XGodCuQj
 DlON8L4tpGffN6bFs9UEPZBrxeKNeA40WPmckE89fLohNL/i00prJcax5VIYoNXN5Agt
 1sbA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWbVHSPFzK/DMtBTHa4oxokCJ+KHFFG1bm5sPljAMWIZbmmTqsdEbZ884rj27gyF7fiNGpUULUQbRe@nongnu.org
X-Gm-Message-State: AOJu0YwrW/g3zWCqpzgFf8+90MF985QhT0e9cWXrdfydkJH9KiWYO0eJ
 vbPCJoLCCUcKg4DHnby9dSOh0NJOTRZZPfrn2+4vn8/NjtmPGJXVcq+kCOydlDU=
X-Gm-Gg: ASbGncutEfuapft/Q5U5Qve+eeFPsCvPnOlq5urTmRnLB70fj3B1YsFUg6hCPQAAatv
 rYlGfYlFyDaJiqdomK3zk9LisbRvUKQG0ynygxjQfgLMeI6yK7Dm0t5CN786ve8HnzuM4zh/fp/
 6re3zub8cYVDCFp2bbgNKBiwkOLNn+l3PsHSb0QgNsdh4BAekUGOCZXUUXzRv6SlohX1D+rqCgy
 gW/NRbpHYLz00B5F7Z80H9ZITWuH8FFaHyhMKQQWwksPyc89hDZ0BNoAR2oewj0ayQNvyn/MNz4
 n419H27/r8UPy3TVDeLrF+Yo
X-Google-Smtp-Source: AGHT+IExgXfdqabLAr7A4JiH+k8jU3GN+mH1CU7iKx297LjDvbRypxguNJdF4P7ForkV+DUQcDLbIw==
X-Received: by 2002:a05:600c:45cf:b0:434:f131:1e64 with SMTP id
 5b1f17b1804b1-4366864305emr402075155e9.9.1735826307551; 
 Thu, 02 Jan 2025 05:58:27 -0800 (PST)
Received: from [192.168.69.132] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43656b015absm487180615e9.13.2025.01.02.05.58.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jan 2025 05:58:26 -0800 (PST)
Message-ID: <3a9d3121-2056-440f-9809-94ebd4cac4f0@linaro.org>
Date: Thu, 2 Jan 2025 14:58:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/13] qom: Use machine_get_container()
To: Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Juraj Marcin <jmarcin@redhat.com>, =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block <qemu-block@nongnu.org>
References: <20241121192202.4155849-1-peterx@redhat.com>
 <20241121192202.4155849-11-peterx@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241121192202.4155849-11-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

(Cc'ing qemu-block@ for floppy disc device)

On 21/11/24 20:21, Peter Xu wrote:
> Use machine_get_container() whenever applicable across the tree.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   hw/core/gpio.c        | 3 +--
>   hw/core/qdev.c        | 3 +--
>   hw/core/sysbus.c      | 4 ++--
>   hw/i386/pc.c          | 4 ++--
>   system/ioport.c       | 2 +-
>   system/memory.c       | 2 +-
>   system/qdev-monitor.c | 6 +++---
>   system/vl.c           | 3 +--
>   8 files changed, 12 insertions(+), 15 deletions(-)


> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 317aaca25a..b8ec2506e1 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -460,7 +460,7 @@ static int check_fdc(Object *obj, void *opaque)
>   }
>   
>   static const char * const fdc_container_path[] = {
> -    "/unattached", "/peripheral", "/peripheral-anon"
> +    "unattached", "peripheral", "peripheral-anon"
>   };
>   
>   /*
> @@ -474,7 +474,7 @@ static ISADevice *pc_find_fdc0(void)
>       CheckFdcState state = { 0 };
>   
>       for (i = 0; i < ARRAY_SIZE(fdc_container_path); i++) {
> -        container = container_get(qdev_get_machine(), fdc_container_path[i]);
> +        container = machine_get_container(fdc_container_path[i]);
>           object_child_foreach(container, check_fdc, &state);

Orthogonal to this series, but noticing while giving another look at
it. Is this method really using the correct API? It seems to poke at
a lower level.

>       }
>   

