Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E6FBC48BF6
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Feb 2024 14:20:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdssM-0008FY-G2; Sat, 24 Feb 2024 09:19:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rdssK-0008F9-RG
 for qemu-devel@nongnu.org; Sat, 24 Feb 2024 09:19:36 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rdssJ-0006QI-2b
 for qemu-devel@nongnu.org; Sat, 24 Feb 2024 09:19:36 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1dc49b00bdbso15733725ad.3
 for <qemu-devel@nongnu.org>; Sat, 24 Feb 2024 06:19:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1708784373; x=1709389173;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sL7AXmg2/WGVYQ0ZtRCkJnAzTFCjo6PV+RI/0vO+oPQ=;
 b=g1lmAj7qqpGsAKgdLtmbPEerx6QFoFOg/eLxPRwzEcEpgT5UyGSfk9YvsqkzgLMWKX
 BaRTfSQk980BO8wQ3c9w+i3NZKWdgZGu2SWmx2KSduET6+NG3G9bWMFAO9GG54mgaMda
 j9EUUQAW8uVFHbloRSpObefjYm9D8HNWrpsX8KGi8UirwCl+HYvGaErqwZOkTuWImteh
 cb+eINBkhMdcMWe+80gTweAxl6GxuO6kl8Igf+1+9TG5LQgv9LZpaYNJHFqDvjRqjvXO
 5rBkEUJubFapk+AHw2gVg4hgFEICa73xX/PgqUlNk45rvLZPOx8w3P7LlTTTHmpFxGS3
 ESaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708784373; x=1709389173;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sL7AXmg2/WGVYQ0ZtRCkJnAzTFCjo6PV+RI/0vO+oPQ=;
 b=vH8X5hzLx2gqax/MEAlrsRpVzx2bfQommzXPYKLZ1EKYp4wgOBFwo6/lzbPIxvk+1H
 l1CXbI1Bjj6ngmplM+ldzJ+rOmEdWARpYVGbRDRfUBECKWXUkaSIPibbJ723GxPHLGTg
 PQ8/WfksTrbOqe7yynS/g5sZnqrKilqUGGTnMRgy4+jSmGsolmsyaEZg+7AbnYPjnhOR
 Q7cRMhaOQgnRdrDlGOau9lIDvJeb2G0QNE878R/WXaoPyqRm33KIfrz3EMXcmIHgtMHN
 mGvuwa8oR3Pe4yQixb42XyhMv/VbtjqAObqT2Y+B6KEXidtoFSphh3tEI56EdFEIecVf
 yUFw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU6d3tj2KO6mRs/3Swod5ZOEDO297aXUc39pNrlB7SyJ0EN2XFqrReFgcJ1Khpb7bMfemMGmfqSnJHCD2KrZEMRACWAQT8=
X-Gm-Message-State: AOJu0YwAylkVSVASpaTWyiQJcNZ/VwRkY67XX8zjWKphqAIdP4xdY/uk
 pHhCnUuL9Oe1QlkWGvTktkhY5vyKABFEVT/yQngvSnUWXp40bFFfuByQcxD5YyM=
X-Google-Smtp-Source: AGHT+IGICiVaPlJTeYuTBlvwzO8G+l1hK+AfqS2ImDhvz0b5s04GC7R5shHgQ8HxuT2ql1ybTiWvPA==
X-Received: by 2002:a17:902:e84e:b0:1db:f965:471e with SMTP id
 t14-20020a170902e84e00b001dbf965471emr2996092plg.58.1708784373587; 
 Sat, 24 Feb 2024 06:19:33 -0800 (PST)
Received: from ?IPV6:2400:4050:a840:1e00:9ac7:6d57:2b16:6932?
 ([2400:4050:a840:1e00:9ac7:6d57:2b16:6932])
 by smtp.gmail.com with ESMTPSA id
 kx4-20020a170902f94400b001dc214f7353sm1076942plb.249.2024.02.24.06.19.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 24 Feb 2024 06:19:32 -0800 (PST)
Message-ID: <0dfce9a1-568c-4a1c-8d96-0523674c6873@daynix.com>
Date: Sat, 24 Feb 2024 23:19:29 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ui/cocoa: Fix window clipping on macOS 14
Content-Language: en-US
To: David Parsons <dave@daveparsons.net>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, mjt@tls.msk.ru, philmd@linaro.org,
 kraxel@redhat.com, marcandre.lureau@redhat.com
References: <20240224140620.39200-1-dave@daveparsons.net>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20240224140620.39200-1-dave@daveparsons.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::634;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x634.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2024/02/24 23:06, David Parsons wrote:
> macOS Sonoma changes the NSView.clipsToBounds to false by default
> where it was true in earlier version of macOS. This causes the window
> contents to be occluded by the frame at the top of the window. This
> fixes the issue by conditionally compiling the clipping on Sonoma to
> true. NSView only exposes the clipToBounds in macOS 14 and so has
> to be fixed via conditional compilation.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1994
> Signed-off-by: David Parsons <dave@daveparsons.net>

Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>

> ---
>   ui/cocoa.m | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/ui/cocoa.m b/ui/cocoa.m
> index eb99064bee..bbf9704b8c 100644
> --- a/ui/cocoa.m
> +++ b/ui/cocoa.m
> @@ -54,6 +54,10 @@
>   #define MAC_OS_X_VERSION_10_13 101300
>   #endif
>   
> +#ifndef MAC_OS_VERSION_14_0
> +#define MAC_OS_VERSION_14_0 140000
> +#endif
> +
>   /* 10.14 deprecates NSOnState and NSOffState in favor of
>    * NSControlStateValueOn/Off, which were introduced in 10.13.
>    * Define for older versions
> @@ -365,6 +369,9 @@ - (id)initWithFrame:(NSRect)frameRect
>           screen.width = frameRect.size.width;
>           screen.height = frameRect.size.height;
>           kbd = qkbd_state_init(dcl.con);
> +#if MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_VERSION_14_0
> +        [self setClipsToBounds:YES];
> +#endif
>   
>       }
>       return self;

