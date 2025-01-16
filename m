Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA7AEC0218A
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 17:48:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYTyK-00049w-Q1; Thu, 16 Jan 2025 12:48:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYTyI-00046v-Q9
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 12:47:58 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYTyH-0004aC-DC
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 12:47:58 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2165cb60719so23273525ad.0
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 09:47:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737049676; x=1737654476; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6YROudZoktewCrIG37F0FdKd2ku4h+A7lHg+CnLv2Ac=;
 b=tIZ5vENloOPA2HNTn1dSV+9Tdlyjwib325nQ9qWYU2i7gC7+3ggOlPjxQH5jmW6BMQ
 CA4ufnQ1OZPt/znzfbelBU2sG2OBN9UCEt+9BNSIKcOI0eqdzyFlzzEJNhNU5OCCyMoP
 gYHSSLEWma56H0p3SsRToUrntEO1BAfStsxYHgyh+Dt70Rq0DiXVVD+2Ge2V62v2/WxM
 SaXU5cLZ0s2ngQQREVIsNIh1FhT/Aj6nI7yxlH8z6npRn+x3gCR8dSY3C5HMmcP0kbDx
 aHWgZfTIGN5XcHyYTUByQPugwFYID/3XuWuMEipwuEGGAaNBTxSWx5T5NzfUknT/Eie9
 IJpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737049676; x=1737654476;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6YROudZoktewCrIG37F0FdKd2ku4h+A7lHg+CnLv2Ac=;
 b=TPYqqpqPEDln+v1b8fLgw+2r10wBtahSjDr/dw16on531yq5cbbVzLr3rKXZg/yyGh
 rX3VjAcuWofbwbzKNiNHGAITUH/Vop0l5E6C9U7fO+CvfM3tNQFThKupF8mGkSU2PK0Z
 qQeM+510PKOqt/9EGEmaLjBXDw1yLgYRDHPHgSYgIZLhAJbX4rBcVCuztdWlEf3dza1K
 x7kxGlqcB193+nBUgZYUx3SZfF/sllNA4oo/j5d+Emo7gl4Vat1sdNIz531DTioHamAQ
 Uztem1t+9kx1G/jfQ7cZs8wFlaQWqIC74ZoxTWGG430rqx6fKLIEZKupyQqGIxM2Jp4Q
 UxIQ==
X-Gm-Message-State: AOJu0YyEZoG72tvp9xqo88iMZ0a9V3Ro2bDfMi8AYLuxl5+pT1h0zCdg
 09jGJcHfq6i/jtIhL6MvHNkQCi+PhU+7NZXyfs0mwFVgSLDKnf/aqDLa0N80KT+ZexmsOLFPLbV
 7
X-Gm-Gg: ASbGncsiYg+CAGyzEffiFbHv5ZrqT0wpuK5qcJTAmi9EXWb7AXln0gUkYMrVM2e+JEA
 QcDT5ASF/Uc4gWBjoQwh90A632/BxUciW5LITCZmd1UkmjQZnDM2TMHkKL01rUn8Bg0GMtzyfNi
 xu/v1XG/joPBEb5X8bDlL3tMW7WUvCY5MdmwhvLnn5rPhVriLIXR5+UHlgdQ3Sr8KVEbUfOCEr2
 wHde0slyHqvtQHx7cd6fu2SBdqKe8NTcPhfB+8eJxgrkIo4xblfbWbI0EbReanpwNosv/Vf4cjc
 kw4su8dNqLZM/KZ6SVAUDLU=
X-Google-Smtp-Source: AGHT+IHxi+DMta3e6sa9HcK2lmxqcf5g18Ygyz+WQQST95JCqwk7r2k3FC66ZQCbxgKpbD+PQtjgKQ==
X-Received: by 2002:a17:902:ea09:b0:216:2a36:5b2e with SMTP id
 d9443c01a7336-21a83f76879mr522029725ad.32.1737049676157; 
 Thu, 16 Jan 2025 09:47:56 -0800 (PST)
Received: from [192.168.0.4] (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2d3dd93esm2837465ad.164.2025.01.16.09.47.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jan 2025 09:47:55 -0800 (PST)
Message-ID: <dfe217f2-1464-4617-8029-fdff8c7f7273@linaro.org>
Date: Thu, 16 Jan 2025 09:47:54 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 v2 04/13] hw/arm/virt: Remove deprecated virt-2.7
 machine
To: qemu-devel@nongnu.org
References: <20250116145944.38028-1-philmd@linaro.org>
 <20250116145944.38028-5-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250116145944.38028-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

On 1/16/25 06:59, Philippe Mathieu-Daudé wrote:
> This machine has been supported for a period of more than 6 years.
> According to our versioned machine support policy (see commit
> ce80c4fa6ff "docs: document special exception for machine type
> deprecation & removal") it can now be removed.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/arm/virt.c | 13 -------------
>   1 file changed, 13 deletions(-)
> 
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 53f4a96e517..eb27305dcd3 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -3589,16 +3589,3 @@ static void virt_machine_2_8_options(MachineClass *mc)
>       vmc->claim_edge_triggered_timers = true;
>   }
>   DEFINE_VIRT_MACHINE(2, 8)
> -
> -static void virt_machine_2_7_options(MachineClass *mc)
> -{
> -    VirtMachineClass *vmc = VIRT_MACHINE_CLASS(OBJECT_CLASS(mc));
> -
> -    virt_machine_2_8_options(mc);
> -    compat_props_add(mc->compat_props, hw_compat_2_7, hw_compat_2_7_len);
> -    /* ITS was introduced with 2.8 */
> -    vmc->no_its = true;
> -    /* Stick with 1K pages for migration compatibility */
> -    mc->minimum_page_bits = 0;
> -}
> -DEFINE_VIRT_MACHINE(2, 7)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

