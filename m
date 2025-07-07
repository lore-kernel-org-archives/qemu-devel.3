Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 450A8C71130
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Jul 2025 23:00:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uYuo5-0006E2-VC; Mon, 07 Jul 2025 18:59:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uYunw-0005VL-GB
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 18:59:22 -0400
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uYunr-00031j-Cf
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 18:59:18 -0400
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-72c47631b4cso3116892a34.1
 for <qemu-devel@nongnu.org>; Mon, 07 Jul 2025 15:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751929154; x=1752533954; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=R0j5X5MDymO8m8T2LqtmuKWbmHxKuLrAzIPD/9rOxys=;
 b=wFhGN1KVqCWxPJW40eW77Q7JKAKDcGHYU03oyIXgC6rYYMGiLSg6Gz1R/oNwFBLHSl
 hxOuKkzcb6Cu+26UKijVUcr34UwGPtgaeru7yGhPbCQ3L6MqbPXrXg7T4pVmBn2M4OfJ
 zvv9B6WgE5DrDmuOgSXCRoXmsdqPISPVbHIjBfqgXLw81UKgkebhPrCNWW33cg1Kkjri
 pQ7yKkaH+idLOUhBnshcMPg4TphvPjGLynunPiZUjC7fKMZ04r3vlgRL5Oz6UWBVlSaQ
 sn65d8DRdvIRkRrreoQv6FGZUMtbKd0dJBN6C4j29eOsnUtOxHHbId4km5GZIpNLYe6+
 RbVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751929154; x=1752533954;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=R0j5X5MDymO8m8T2LqtmuKWbmHxKuLrAzIPD/9rOxys=;
 b=v6AnlAaKteqoFWaRCk9Rq7BTIfj7ONHBt8v2h7xXUnYT9muQmvlA9fhXHqmvlqyn8Q
 a1fmioJTu0I13Ilawbs114HfhSd9I03VezCGlvj7NuOivaXscGuENHzYZYnxXMuYRShk
 LSQItMvvWF8W9i8sVSEyU0EagV+ImrJ/AB2jm2lHuTfBbugiJt9LNKC1EkXB9Lv81lOl
 QQciiVx8Wu96waEiFLB36ByGANe2b7iWP1Ju5qLitz2muBOcJHoDD2v1KhMDkFhLEiES
 0mzhlk+tHb6yI4sxARfL4IB8OfbT3iYPaIMkqEp27yeQGR5q2kpbIvDHvUTOtdvLu7Mw
 K/qw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUiUyZc06KH4NQOk5Eh/Aj4RfM+cvIrjxCrq9+KzIRHS/KsqPBVY9RwgGbEVvqJ5NWJTm1wHgHSN62W@nongnu.org
X-Gm-Message-State: AOJu0YxZEBiQyLfB6lKQvSao0E4+HZCNxmeqX2pWiIwGUOfCxC9rdugd
 AQlZ9RZfRzYDMpKSqOL9XGm5LSd00U6UiCbxQ8F561MHdW5uKoAnJqJ/1In9qE80EqY=
X-Gm-Gg: ASbGncvVq+Fg1bfKkASr5i3KC9UPnim+l3qIIKMHOUlCU+b4bn2gIpAQcz4FpZ6ZoyP
 V2GQkv0pFNO9qIbpBzRlKFNBjJJ+aBI2IImgAd4DJdTS5Za2OiDBLiwA3sDBAWqfqly/DBlwhZT
 nwXmweCWPN40a91uMLzKQXIffoNwiVoLLVGCptMLHKuRrrtkoTY3T/VkUO2+6BP97E91yAcHBmS
 X46ZL6GCfWnzjCGr0YlVPpxRYHv+10lmTDtPBx6WCXBDIskJgQZNYt7aJn8KWbfFt0+syTvh2GY
 rtva/SVSb7bcQH2U+pqYRp4jzxPEeLEwld8yX9efX50I1uFuVH82hvdkloBfqJNwxi9p/if3RrP
 P8IAjwm8+eJoN634+cxTeXEWyLCJmNaQul9xKP1Az
X-Google-Smtp-Source: AGHT+IG28sglKTHo5b2qcR+h5/P2Z4mnesEnVRLFkzFYDZMo7gYZ8cLzwCRSk0mc0IdwDIev/flD0g==
X-Received: by 2002:a05:6870:80d3:b0:2ea:fc66:3775 with SMTP id
 586e51a60fabf-2f796e0fbcamr10269433fac.32.1751929153804; 
 Mon, 07 Jul 2025 15:59:13 -0700 (PDT)
Received: from [10.225.72.227] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2f7901a35c1sm2512233fac.25.2025.07.07.15.59.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Jul 2025 15:59:13 -0700 (PDT)
Message-ID: <59984d23-3e5f-4d86-8111-0255ae51e76c@linaro.org>
Date: Mon, 7 Jul 2025 16:59:03 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 v6 10/14] hw/core/null-machine: Define machine as
 generic QOM type
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-s390x@nongnu.org,
 qemu-arm@nongnu.org, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-block@nongnu.org,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-riscv@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>
References: <20250707172009.3884-1-philmd@linaro.org>
 <20250707172009.3884-11-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250707172009.3884-11-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32a;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32a.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 7/7/25 11:20, Philippe Mathieu-Daudé wrote:
> While DEFINE_MACHINE() is a succinct macro, it doesn't
> allow registering QOM interfaces to the defined machine.
> Convert to the generic DEFINE_TYPES() in preparation to
> register interfaces.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   hw/core/null-machine.c | 14 ++++++++++++--
>   1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/core/null-machine.c b/hw/core/null-machine.c
> index a6e477a2d88..3e03771d570 100644
> --- a/hw/core/null-machine.c
> +++ b/hw/core/null-machine.c
> @@ -42,8 +42,10 @@ static void machine_none_init(MachineState *mch)
>       }
>   }
>   
> -static void machine_none_machine_init(MachineClass *mc)
> +static void null_machine_class_init(ObjectClass *oc, const void *data)
>   {
> +    MachineClass *mc = MACHINE_CLASS(oc);
> +
>       mc->desc = "empty machine";
>       mc->init = machine_none_init;
>       mc->max_cpus = 1;
> @@ -55,4 +57,12 @@ static void machine_none_machine_init(MachineClass *mc)
>       mc->no_cdrom = 1;
>   }
>   
> -DEFINE_MACHINE("none", machine_none_machine_init)
> +static const TypeInfo null_machine_types[] = {
> +    {
> +        .name           = MACHINE_TYPE_NAME("none"),
> +        .parent         = TYPE_MACHINE,
> +        .class_init     = null_machine_class_init,
> +    },
> +};
> +
> +DEFINE_TYPES(null_machine_types)

Ought this use DEFINE_MACHINE_WITH_INTERFACES that you introduce later?

r~

