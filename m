Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45C09E7716E
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 22:24:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJKFg-00054O-Rg; Thu, 05 Dec 2024 17:23:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tJKFf-00051r-BH
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 17:23:15 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tJKFd-00084Q-Tf
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 17:23:15 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-385e075255fso1093597f8f.0
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 14:23:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733437392; x=1734042192; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jjEy9XAcN6y2V7r9qJdG8tlarDEayd1oY0lUiCyQNYc=;
 b=kq8bqLk1b6mm4H14MZU++3rRA3vDdI6ANEzcaEFf0N05vPRM6ytSt/oYXVfJK6/zp8
 YTei+ip59u6EMBeARsur82Sv5YoJvdkG8EC2xQ51nZI17ZPmWWu+g1RGm4/W3mMT1NBN
 pld3TLkHbAa+ctqFRW8n1QH+DrqvZlahK+lMWgG3WcxPMrdzmkeWBdlxyvj1L6bE8J4T
 sIWTbPjCD4+OWztCtK3IXQIr54snDb9VFCye5x6x7+Qtdmzr/8Xj2ymHrrVW66fdp+sD
 Fj6dTpyK9T1h0kOBkS42WjqbbFxXshrzxsYwiigmSEPkoiBjZ0d8O88w5u+nCG697dtW
 t6pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733437392; x=1734042192;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jjEy9XAcN6y2V7r9qJdG8tlarDEayd1oY0lUiCyQNYc=;
 b=QMZkyBQ6Lnm9omImnF5gFGTx1iNHxm56KLHRumqB4LalC9qNKDMxcFT0ZWYP2cUfPS
 OrKiY0vJt8XuzrvZr2o5ye9ajkJGc1YViKEVDy/NsZSWr0fZ2DrwHrI5lwvwpCEmYdgo
 ThdUQiMVnCw7xzK0xRWJ82z6KOUiql2uEEqHYKBuWR9SwaX9HGFMRWOdlLmCylwYT1SI
 cioRzR5Q1WHaXAAmgtUgVEe46KDVnHJw5nVKY4ECNLmjGI4GsJPwoMJqEpQk6B03MRca
 X9sligBShv8f9/CENo6iHGMyBeKnwvv+nH6L8QFTcmBDV+GT8b46rqRrBFbvBVhW++F5
 WupA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUxu6TR/FQvu78ylQn616Iw9h6WlWMl7J/tEtWJ4TliK8RiKgmzZ8+8aKs6+HfZFjmES5537BFQMvWj@nongnu.org
X-Gm-Message-State: AOJu0Yxp3sJt/3HpVCx18afI1KyU2zuhGGq2Dh0PbJgeFdTACRyNORsj
 wiHTVts/+1tNPDhyLJEmwyV//d45j6lvif7BaOH5LF6qViAPWuRx6YRvCq1nBMQ=
X-Gm-Gg: ASbGncudG5z5RT56AJ0STg02S2EUCEPkJPUYU+YdXFcntgzGItU3GSjnjLmyE7qYQCv
 i5iLGyER5AZ9MheH9Ml/Uyza7uToG9rUm/j5E5vceA70Zuuua8OhvNgdq4QgPJ/rFkhvk2ucBQj
 kifScVhXpE5TFY0Sm17prFvJ7ZZ20bzaMEEhGEOYN44BMZUIuP3CLOQR6io4F53pDIN4nLUusDq
 LMJOgELI75h8l7DZeN7pNGe9/le1xvUraZ8a3ly7N+b/a75RxirWcQhPqGSG793LVW8VnV0pGsG
 Pca4ZrWeOVAnDqmPqw==
X-Google-Smtp-Source: AGHT+IEwiDNtXRDBMfSzag4lgR8m6pRSmbDvnu7TGo5QlLRVTLPEybjuH4gExpvfOIOv3yL+/1MgyA==
X-Received: by 2002:a05:6000:2cd:b0:385:e877:c035 with SMTP id
 ffacd0b85a97d-3862b3f5655mr574759f8f.53.1733437392018; 
 Thu, 05 Dec 2024 14:23:12 -0800 (PST)
Received: from [192.168.69.223] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3861fd46cdesm3058947f8f.57.2024.12.05.14.23.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Dec 2024 14:23:11 -0800 (PST)
Message-ID: <edae9f1e-1f80-4f22-9340-c88f440a5523@linaro.org>
Date: Thu, 5 Dec 2024 23:23:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 26/26] hw/arm/virt: Add measurement log for
 confidential boot
To: Jean-Philippe Brucker <jean-philippe@linaro.org>, peter.maydell@linaro.org
Cc: richard.henderson@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 alex.bennee@linaro.org, Stefan Berger <stefanb@linux.vnet.ibm.com>
References: <20241125195626.856992-2-jean-philippe@linaro.org>
 <20241125195626.856992-28-jean-philippe@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241125195626.856992-28-jean-philippe@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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
> Create a measurement log describing operations performed by QEMU to
> initialize the guest, and load it into guest memory above the DTB.
> 
> Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
> v2->v3: New
> ---
>   include/hw/arm/boot.h |  3 +++
>   include/hw/arm/virt.h |  1 +
>   hw/arm/boot.c         | 47 +++++++++++++++++++++++++++++++++++++++++++
>   hw/arm/virt.c         | 23 +++++++++++++++++++++
>   4 files changed, 74 insertions(+)
> 
> diff --git a/include/hw/arm/boot.h b/include/hw/arm/boot.h
> index 5fcbaa2625..f2518c4e81 100644
> --- a/include/hw/arm/boot.h
> +++ b/include/hw/arm/boot.h
> @@ -147,6 +147,9 @@ struct arm_boot_info {
>        * Confidential guest boot loads everything into RAM so it can be measured.
>        */
>       bool confidential;
> +    /* measurement log location in guest memory */
> +    hwaddr log_start;

One expects a stop/end after "start", maybe 'log_paddr'?

> +    size_t log_size;
>   };

