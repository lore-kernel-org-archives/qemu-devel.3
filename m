Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAFB3C83F17
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Jul 2025 06:12:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uceJY-0007T1-Nt; Fri, 18 Jul 2025 02:11:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uceJM-0007Oa-M6
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 02:11:14 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uceJJ-0005D7-2B
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 02:11:10 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4538bc52a8dso13079765e9.2
 for <qemu-devel@nongnu.org>; Thu, 17 Jul 2025 23:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752819065; x=1753423865; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nZAac98V1Ph4SSzeeQOmmYePk1mOHcZMqMQb2F7bDrA=;
 b=OKEO+3wfRWi8MTV+axGgTS6Wdbr5DrCjjaSVpQx2RVfGiOpdpIh8y2wxsCe8RVndNe
 B+Jz923QHOmze+HWMhNVrJsqLsWE6jQ8gnamH50S3ru2gjtFygUrSQmqwUc7mVIJ7/vk
 1OP5aDGsgAPFC1otEjh5myBMKxFUHrA0ka4siPCIrL/WBw1et7i++XSAQ5bOXBUkVQgO
 RW1FDT9sGcFcaSwEhcA+FHIversbZS+vejqBwRIEHaKmeo40AgP0wvaSCyCJx+3xJ7Bn
 k74tEfNCyPqnTgLcs3Rsyh6U/DuxfWIEOjG9ijWQrNl2/xJQJOFEiJLheo9jk2CkmOZi
 jC/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752819065; x=1753423865;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nZAac98V1Ph4SSzeeQOmmYePk1mOHcZMqMQb2F7bDrA=;
 b=XIAyTBxfdimLtpIeY1TBy1q1uXl17alNvQQ7rvdxqREWUNzqd7uCVxHAqIn4JdvF0g
 AGAAiLPccbhnE1BUGZely1T1npvB9HpdD4zVvT/rdA4Zl3oN9mmevzJQ7bBLfZklImkG
 WXOErgE9SFO+QFOvdoW5u5+v1iu8K+K6Bo7Rc33ubTVLURWYaKvjvd49mtw5PBKgiLU6
 oi8WWw/4v7bbPZpFWHTcEF2dLyY9qOVyypk5oMIj9tfIIMBil2DGvArJMwfPr0FSnrf8
 9umALwi8AuC5VMe7hbq1qCJ8nR/5Fm+ogZ8PE6054/AMLOhaCdK6z8ih01GyZOwczbwQ
 WyRg==
X-Gm-Message-State: AOJu0Yzdzr7UFKOw5SZ5jCxFI79/dmT6T1JFnhwhjAprBzEIxBi5CVYV
 c4Jmy4+YAu9Duoj7TFT47IfDot9HD2hb7VoHvBCVXkFpd35sc3la7J+oAgsAoK9hbDM=
X-Gm-Gg: ASbGncsbafIOemLgGLGOA+uj79ayfWsPLADn/ZAjsJzcXBFho5NkBwuBfd1zw821L7R
 aZfRXSC0dKZTJ2DOX2Loide2/VodTW4/WfjOc5mer2Zbg1d0pEdkUL86m6k/e+JbUvC899lLfwd
 MaxnNLsC/kJt2CBdIIIKTxuYlQHnNUhW20gpc48T+MvnTC6+gCGTV0uSdzQAtIekSlH1y9xCZ1n
 U35DLv3z7Ezz0XHkZ+j6q4/FpLzaBN3H7hROdVAbcKa9Gs4Q2E8jun1eOb8A3OjigUA5eiS+JH9
 uvoIkoupt/+ezOzTS13iHTiCC0aNQ5c7gbDxuFhqLJSncIFXa61o/92nsH7e5GguyujFCEOqYgl
 YH+H8eo3R6ZSBfRmd8O53GXkYyXEPS67ToRmfdojuQN6VJVXi61H8WuepD3E/Eqhn9Q==
X-Google-Smtp-Source: AGHT+IEpCWyWwdv8CpeVxwa+3oJvNgqjEFe9x+XvDnznetGtywDcCAK2PdBu8fRRGwwbhMTCxYQCeA==
X-Received: by 2002:a05:600c:8205:b0:456:2020:165d with SMTP id
 5b1f17b1804b1-4563b8fcc48mr12436625e9.31.1752819065231; 
 Thu, 17 Jul 2025 23:11:05 -0700 (PDT)
Received: from [192.168.69.239] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4563b5a4055sm10883655e9.5.2025.07.17.23.11.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Jul 2025 23:11:04 -0700 (PDT)
Message-ID: <bf6df47b-8815-4d84-a01b-010281187d24@linaro.org>
Date: Fri, 18 Jul 2025 08:11:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1] hw/arm/smmu-common: Avoid using inlined
 functions with external linkage
To: JianChunfu <jansef.jian@hj-micro.com>, eric.auger@redhat.com,
 peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, Roman Kiryanov <rkir@google.com>,
 Will Hollins <whollins@google.com>
References: <20250214072029.515379-1-jansef.jian@hj-micro.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250214072029.515379-1-jansef.jian@hj-micro.com>
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

Hi,

(sorry for previously missing this patch)

(cc'ing Google folks for 
https://lore.kernel.org/qemu-devel/20250717205735.2345674-1-rkir@google.com/)

On 14/2/25 08:20, JianChunfu wrote:
> Similarly to commit 9de9fa5c ("hw/arm/smmu-common: Avoid using
> inlined functions with external linkage"):
> 
>    None of our code base require / use inlined functions with external
>    linkage. Some places use internal inlining in the hot path. These
>    two functions are certainly not in any hot path and don't justify
>    any inlining, so these are likely oversights rather than intentional.
> 
> Fixes: b8fa4c23 (hw/arm/smmu: Support nesting in the rest of commands)

I suppose b8fa4c233bd was copy/pasted before 0b796f38106 ("hw/arm/smmu:
Avoid using inlined functions with external linkage again").

> Signed-off-by: JianChunfu <jansef.jian@hj-micro.com>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> ---
>   hw/arm/smmu-common.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
> index 3f8272875..545d763ac 100644
> --- a/hw/arm/smmu-common.c
> +++ b/hw/arm/smmu-common.c
> @@ -298,7 +298,7 @@ void smmu_iotlb_inv_vmid(SMMUState *s, int vmid)
>       g_hash_table_foreach_remove(s->iotlb, smmu_hash_remove_by_vmid, &vmid);
>   }
>   
> -inline void smmu_iotlb_inv_vmid_s1(SMMUState *s, int vmid)
> +void smmu_iotlb_inv_vmid_s1(SMMUState *s, int vmid)
>   {
>       trace_smmu_iotlb_inv_vmid_s1(vmid);
>       g_hash_table_foreach_remove(s->iotlb, smmu_hash_remove_by_vmid_s1, &vmid);


