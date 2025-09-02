Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1B20CA1005
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 10:22:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utO9P-0006rh-GW; Tue, 02 Sep 2025 06:22:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utO9I-0006oZ-T8
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 06:22:01 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utO9G-00082s-Ae
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 06:22:00 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-45b8b1a104cso19528165e9.2
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 03:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756808516; x=1757413316; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=I2H0CPl24RUHVPwJV1KasKc5Bk1Uniw9WQcQ5TKh5BM=;
 b=iS+mVQ2iroIAM3dNalI+BEUtztSSjLRJPJVzpgKIEbGWdVKSAkhmuvHm4jM/wwl29E
 CNHnbydeE7UFMrDSG8QQxb9WRvK1ZBhb/dlyU9xUIBGk67zcpozzyW+S+oL2sSCFpinL
 ajftkuf1wvgSfP1/SiSXKt7RsAFofDCv8wkk6Sxry2f0Nc/w5iCx9+dMrBSqJ38lJ1RU
 rGZn5Dp33F9C7h08yhbz4DeiPklUwJyuOTABe2oWIORwHiZ1abI2QLr5wy2GVlGSvq4m
 NnVijSydbwzFGsjRF/B+pmZ84RGKfd7HplF7pxFjCajmgUi8M1TpUhkE9Kv8pR9eEWFl
 pkOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756808516; x=1757413316;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=I2H0CPl24RUHVPwJV1KasKc5Bk1Uniw9WQcQ5TKh5BM=;
 b=XxiRBvQtHaBweJX+alZ9C96fZhkCa4Y7SXFd9OAqcL5Cz+CuMB+bggFhXfFcfT7Qho
 J+0ErBeY73OLqbi55wKtD/51D9EVGnRYmoGEGigMRaufAUPR6OkLW1AMpnDbYECNMvaz
 ycot5FZf80F9c9Pa2ybTbDBp9c5fHBZ0Xu00aJzzXHFUpm5kc1jhvkqtllEG9LSPSJQg
 1IghacnzTrDwJGMV6VE4ERgeGiJ9C2zQL/s9ywp1nBhz3jxl37XtKg/pAi03FHwZsLYB
 HWWd3mlB3RxACYb3mGYOy7T3gkOEPWK0kQn5KQsJOHRmC+a7aaTP5UTXd+UXNxyaOXIG
 msNg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8q/VfarYOrEV9F/QTSUM8KQWsHu8Zfi8/Vwc28r/0dalASbHMOz/+wa5TWMAa0JT7B/wHkuOzayLr@nongnu.org
X-Gm-Message-State: AOJu0YwPqvM9VpiPY0UmLv0avCFHuI6cR2jJ8h0WmIsxu2FIZQp8fgg0
 cIh/O7xvceLXiFcOhlKYtX3SZ85Ro+bj8dWPS7mgWH/7Qy7g5ekMTt20/emSR5qIP0U=
X-Gm-Gg: ASbGncsbxM6UXWKaY1AITK5ygk80I6GpLaZ0eTouukOgs1Rpp0aJCFCHyVrMLw2g2hu
 71ZfL6gCavKoiUQD1Xk4yO0NqiyprjholFbR5cwrJXV89N86X+EuDUjPAA+AgS4I0Z9K5+kubNA
 DDBRVXesqbbORcDu2rnNb1H3Mg1yQowMGww4z4LdRxcP0afUvVlsCrjmzl1cxGluPJ6Rd039Bwm
 UHp89SiL9xRTWMdnFwkR50hOzufDjnO+Y/bbyU/9LWevAl7uShQL6plDnhGO4Vn4RLer9oN0tie
 xt0ygcQeICa7Iujxyjia37lbvNc6bd5ON38WXEXfsDXntp9ONHzVKLDu7LOawuue2cvLeVifdb2
 GMJrBjj/tRiyCzcmGM9P/34BTLIyulP39QoP+0q/P3/pRsv5kkaFVDp70XhxpwejXpg==
X-Google-Smtp-Source: AGHT+IFlqF7ST5Nw+61d5j+MENQ2VosNmsSMVNU8cguz9WrZqrbQyypEzopmLnNMgoerH72RZbix7A==
X-Received: by 2002:a05:600c:4f0b:b0:459:d821:a45b with SMTP id
 5b1f17b1804b1-45b87bf56e3mr89107745e9.9.1756808515880; 
 Tue, 02 Sep 2025 03:21:55 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b88007a60sm72572415e9.8.2025.09.02.03.21.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Sep 2025 03:21:55 -0700 (PDT)
Message-ID: <7333954a-f5e3-4d67-8e27-ed8e3b30b7e3@linaro.org>
Date: Tue, 2 Sep 2025 12:21:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] hw/irq: New qemu_init_irq_child() function
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20250821154053.2417090-1-peter.maydell@linaro.org>
 <20250821154053.2417090-2-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250821154053.2417090-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 21/8/25 17:40, Peter Maydell wrote:
> The qemu_init_irq() function initializes a TYPE_IRQ QOM object.  The
> caller is therefore responsible for eventually calling
> qemu_free_irq() to unref (and thus free) it.
> 
> In many places where we want to initialize an IRQ we are in
> the init/realize of some other QOM object; if we have a variant
> of this function that calls object_initialize_child() then the
> IRQ will be automatically cleaned up when its parent object is
> destroyed, and we don't need to remember to manually free it.
> 
> Implement qemu_init_irq_child(), which is to qemu_init_irq()
> what object_initialize_child() is to object_initialize().
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   include/hw/irq.h | 23 ++++++++++++++++++++++-
>   hw/core/irq.c    |  8 ++++++++
>   2 files changed, 30 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


