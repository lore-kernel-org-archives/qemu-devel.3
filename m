Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FED6E7716E
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 22:21:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJKDx-0003O8-N4; Thu, 05 Dec 2024 17:21:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tJKDv-0003NV-Ip
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 17:21:27 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tJKDs-0005WR-MH
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 17:21:27 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-434a8640763so10623295e9.1
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 14:21:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733437282; x=1734042082; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qjd8XZhXH/oSft8UPc2Cp81YMGeK2cTivrQQIoMMjiQ=;
 b=hFxwqdUbMSLuXsH3P+/gFVMCLTDZt4qL+DL5M24ldXBk2vZnbk49Eoh2qF1HrO8+y8
 Qd9NRMtIEgWPrBm3NlXc336jW3WxHUXw2DJe5ymMclpLZ38dG6uwtlIcx/cqCasAS0dp
 W9XfRboRqHISafi+eOgMcTihhQl4NkgtJOCDkG8D/pGdBtazvK+lpfUut0WIC5nYfdZU
 YrwsQFeKmD5UXi2X/8ZXYs4kpY2I552U31iVOfDNTRRDgJz1qmTAW8ewn95xeS8RKZcH
 E/jPsKlNp4+dvLvZutJw5e9oa4YA6zMJDMOi544UpmNdDDjc4MnuH+Rc46Zt+GHaKslB
 k6GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733437282; x=1734042082;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qjd8XZhXH/oSft8UPc2Cp81YMGeK2cTivrQQIoMMjiQ=;
 b=vSw4T3lQBz2EWDJrtmrVYOl9NyiJadHtKuE3Q1bFmNM67o6M0sMYFn6Vq/fmVcpxNN
 lCwYvkRwnl67BtWWLkfYorvUlPpSLhH/Xr1cyou0sOdRAV5OkHjEwt0bUlQ8emC1NRJ9
 9ZORv3jai65t6dd3JTgJtb/7OY0F8gkP2lLPzbPMb6u92MyKUBJ3Z9C7f5b+Kcm4AGQD
 8Mi8gLK9w+ytVOpTSrAFtts0arvH+Pr9DlbpTn9Lne9QGi+ydc3nP587Jp5G7bNXrPVF
 17H09D+XSTPk8d3x5fJU2aU1731V5wvjW3Uv5BqKgzn/BXF3ycC+zXbBz9QdGuBXQ8YG
 zpNg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVKhlq85Uk3FgyWNdLGesRCNCkDIQo4XIK69rqq8MAkn2KNGIQ1FWiCzCVDIfZJoZJqIfUolg1jnAy1@nongnu.org
X-Gm-Message-State: AOJu0YzBgzt6cBIDUM7fboXiRziZS2rkaENDVkp+1NlXLK+8v1Pk1dss
 Ar0RS3JvP+Y2oKDnRpbrDOf7ghKIKp2rOD+FDLm0SnGl/Pf0sMPpybG9cupu1EI=
X-Gm-Gg: ASbGncuWi4Hqalnf/ZTmwDWpDHSkZtULYEauxcKI08n27GwDUjmm9gfdgPAevmoYT15
 SjscVLMTqNEoI4qorEXY0a38KjZlsrcJYQImXVx1EmW1NI+Q5EZxTZm2/cdekil6whQ9DE/XiTb
 Cq0riOmM82j3BHZhtfvjWSOdYMdjIOGc9VORQz0e6eO9d4fcG2W/qWMf/hkeOGKduHs0XW/6Sl+
 c9cKEBWv7s5iwq2YAI0tn6nOAhXhrTTnFeOUKKyTQlSDS08pWsjeNk3YpLG7ltJw8r3OI28PZFs
 U0aCIKoMn0xC1jGA3g==
X-Google-Smtp-Source: AGHT+IFIeZkaM1Mzi+J2zwcoJ7G1xSCENfq2HICboEOHeyOK4eC3SyqmcQbjkdQV/BY1mh6pZmTgwA==
X-Received: by 2002:a05:600c:4f87:b0:431:40ca:ce5d with SMTP id
 5b1f17b1804b1-434dded699cmr6663405e9.23.1733437281770; 
 Thu, 05 Dec 2024 14:21:21 -0800 (PST)
Received: from [192.168.69.223] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3861fd465dcsm2984623f8f.51.2024.12.05.14.21.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Dec 2024 14:21:20 -0800 (PST)
Message-ID: <ba650cb5-488c-4127-a307-ea16c9e44b5d@linaro.org>
Date: Thu, 5 Dec 2024 23:21:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 24/26] hw/core/loader: Add fields to RomLoaderNotify
To: Jean-Philippe Brucker <jean-philippe@linaro.org>, peter.maydell@linaro.org
Cc: richard.henderson@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 alex.bennee@linaro.org
References: <20241125195626.856992-2-jean-philippe@linaro.org>
 <20241125195626.856992-26-jean-philippe@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241125195626.856992-26-jean-philippe@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 25/11/24 20:56, Jean-Philippe Brucker wrote:
> In order to write an event log, the ROM load notification handler needs
> two more fields.

IMHO it makes more sense to squash that in the "hw/core/loader:
Add ROM loader notifier" patch introducing that API.

> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
> v2->v3: New
> ---
>   include/hw/loader.h | 2 ++
>   hw/core/loader.c    | 2 ++
>   2 files changed, 4 insertions(+)
> 
> diff --git a/include/hw/loader.h b/include/hw/loader.h
> index 0cd9905f97..73f317966d 100644
> --- a/include/hw/loader.h
> +++ b/include/hw/loader.h
> @@ -355,6 +355,8 @@ ssize_t rom_add_option(const char *file, int32_t bootindex);
>   
>   typedef struct RomLoaderNotify {
>       /* Parameters passed to rom_add_blob() */
> +    const char *name;

Description of the loaded ROM.

> +    uint8_t *data;

Or 'blob', blob_ptr. Maybe declare as 'const void *'?

>       hwaddr addr;

Now easier to document, where 'data' is addressed in guest memory.

>       size_t len;

Size of 'data'.

>       size_t max_len;

Still unused. Drop?

