Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53AE3C83038
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 17:37:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWeuV-0005tg-N6; Tue, 01 Jul 2025 13:36:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uWeuN-0005no-NL
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 13:36:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uWeuG-0000Gw-TG
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 13:36:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751391390;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=luy9hP+C1+jCcXEoM0Q3nN3pMN/n+lvKWFy0GZW2BMM=;
 b=UKYTSV+m5MCRhrdi1k2coBWjxV7K+IZBMvm1z5LrW/x52gCijW/53ffN6Bp+kRQrPJ3ZtA
 GKirDPOFA0jtTXW/DVli1ymQZCeSVYnYMadwyHMxMudxnOeO06BNLY1TOyMgLHwCIz1JnN
 COmjvKbd9/kTBW+65P39AJpvVA6/Mqo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-600-cLjngP3tPqqt6veHpvNZSw-1; Tue, 01 Jul 2025 13:18:10 -0400
X-MC-Unique: cLjngP3tPqqt6veHpvNZSw-1
X-Mimecast-MFC-AGG-ID: cLjngP3tPqqt6veHpvNZSw_1751390290
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3a4f6ff23ccso3974234f8f.2
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 10:18:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751390289; x=1751995089;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=luy9hP+C1+jCcXEoM0Q3nN3pMN/n+lvKWFy0GZW2BMM=;
 b=JsCgMP5lvqcXszt3khCpzqOTYCXhOzaDhcvm/geQIJopsVCdTX78qPYkoIjiycuYY4
 L3afmHJGuPXl7K7cnOdC9BQ8T2Xr3zScnh2+LA4W8bLnM9V2SGMluJas8a0ce/eKrqOE
 lICIlg17IcNu65s5ACnBXrlsXWmDUWasp6Ta0i+R53N1wZM9ci+nydBsGENQv+sE2cux
 35U+7P8bjXFr7JC/6wSm5DXA226Uqz59ru4RcZXdzXeJKa9NnaeOg588v5OP4jtSpdZ+
 HPVvBHTGJ0fromZaS2nmL1nCZaOk5g8IB5Y9PRSHkMyOKGW+UXefr+KYuP3+Gg5ftaVZ
 cv8g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUH/lNpLShKPY3qqj2FWYVewCTNmk7USexv8PG7bVEfU06nz0iT9JATXn07YDnOaQt8XaUlu8v0nl8I@nongnu.org
X-Gm-Message-State: AOJu0Yymqt2U7CvEnKskExOAiSKeARZLmTpml/rKMpVUm6mls5JiuL4p
 tRgmffeExIXydsR/TVHNfMILwZ24MlVRcWlGmkctuTPbkTSHYHnmNGJMxL8i3/xobd3wRzA7Jl2
 80UCQQHni+tjznMFCvuyaW+JjVHKeWZukEjRG6DYDr2L62AwXcyZ8mdPFumOV81Qs
X-Gm-Gg: ASbGncuU5qMzuAvaqmJkTx1Dp8YUYzT6fJ77UMx+5Dwzfj32fob2U/88I9Y8+m5o1j7
 dPP4ZpiNkA96kj5/RUx1534xX1DjkFI1V85Bqd2hS1beA208qzsx2SD5LhhEa+lKEYa/TQ/re2m
 nD7ZwGRl1vlYsgIcwLaz/rNj4CaPVSYTcxIRblYolFRB9LTAiUi7hSRPsAnLCQ15Z3fmEbC45C8
 Ehq4Ii7zb1yoCpVW0dDR0zI7lsQBeDFcScoizqYtJFlD3eZwpLKKiIgwNdTu6CcQPOjKwaKbdS8
 03Wrgyl3U3fPJ8t6v2qIRFJsbFpIL7dtbf7KYx6v35qgUzcCBWqPkMB7J8m6WA==
X-Received: by 2002:adf:b651:0:b0:3a6:ec41:b9df with SMTP id
 ffacd0b85a97d-3a91818bdeemr13312633f8f.49.1751390289407; 
 Tue, 01 Jul 2025 10:18:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHTZr20L8Trh5Mcysi6zvPyYngKNIPyUIOFWpmzOc6YPN4r9bXaH+FmM8OAXF3atCsq7i+Pjg==
X-Received: by 2002:adf:b651:0:b0:3a6:ec41:b9df with SMTP id
 ffacd0b85a97d-3a91818bdeemr13312603f8f.49.1751390288931; 
 Tue, 01 Jul 2025 10:18:08 -0700 (PDT)
Received: from [192.168.0.6] (ltea-047-064-114-041.pools.arcor-ip.net.
 [47.64.114.41]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45391c6aa0asm135323155e9.26.2025.07.01.10.18.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Jul 2025 10:18:08 -0700 (PDT)
Message-ID: <cf8846e8-24b1-4c76-acfe-88a62913c8e9@redhat.com>
Date: Tue, 1 Jul 2025 19:18:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] MAINTAINERS: update docs file extensions (.txt ->
 .rst)
To: Sean Wei <me@sean.taipei>, qemu-devel@nongnu.org
Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
References: <20250616.qemu.relocated@sean.taipei>
 <20250616.qemu.relocated.01@sean.taipei>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250616.qemu.relocated.01@sean.taipei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 16/06/2025 17.47, Sean Wei wrote:
> The documentation tree has been converted to reStructuredText, but
> two entries in MAINTAINERS still point to the removed *.txt files.
> 
> This prevents scripts/get_maintainer.pl from matching the documents.
> 
> Update those entries to *.rst so the maintainer script works again.
> 
> Related commits:
>    8472cc5dbe6 (Sep 2023): docs/specs/vmw_pvscsi-spec: Convert to rST
>    8e72ceee5cd (Jun 2022): Rename docs/specs/fw_cfg.txt to .rst
> 
> Signed-off-by: Sean Wei <me@sean.taipei>
> ---
>   MAINTAINERS | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 28b3dd2684..fed8619874 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2531,7 +2531,7 @@ F: hw/net/net_tx_pkt*
>   Vmware
>   M: Dmitry Fleytman <dmitry.fleytman@gmail.com>
>   S: Maintained
> -F: docs/specs/vmw_pvscsi-spec.txt
> +F: docs/specs/vmw_pvscsi-spec.rst
>   F: hw/display/vmware_vga.c
>   F: hw/net/vmxnet*
>   F: hw/scsi/vmw_pvscsi*
> @@ -2736,7 +2736,7 @@ Firmware configuration (fw_cfg)
>   M: Philippe Mathieu-Daudé <philmd@linaro.org>
>   R: Gerd Hoffmann <kraxel@redhat.com>
>   S: Supported
> -F: docs/specs/fw_cfg.txt
> +F: docs/specs/fw_cfg.rst
>   F: hw/nvram/fw_cfg*.c
>   F: stubs/fw_cfg.c
>   F: include/hw/nvram/fw_cfg.h

Reviewed-by: Thomas Huth <thuth@redhat.com>


