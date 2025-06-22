Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 185B2C7115C
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Jun 2025 02:07:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTA6j-0002HJ-D3; Sat, 21 Jun 2025 22:06:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTA6i-0002H7-Dc
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 22:06:56 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTA6f-0008HD-BX
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 22:06:56 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-7481600130eso3734455b3a.3
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 19:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750558012; x=1751162812; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OM+BEwNST/KBr+JI4iy8saFJg+NXOI3+UiTb+zrHsEk=;
 b=kHb5tAHC5Nl8Um9rMDxInSy3L/ob+q7z2FshmKLr5jcXDp5+hwmziMeObd4G3fqyZT
 DiMV6ua9VZXcrbm7eW465dfmmLd/7dEH93vW+lQMXHD7ierTf6J+BJ6FUt0bSs2DXtiq
 xKB7W6/yanuFY6gzvvD/beQfaRoEAuv6z7nG2/zejoYWVcbpJtmbwji8WLUC1ioGmCQB
 GiOuHfUaCv8y4KXtKC3+tlv3xozBTTK47sdrdC92U4q3ST6MEbKGE/ofddvAJKHBheol
 3/cgpzoI0YpccC+neu/0SQFA6yBlTDu8gK8JFcgE7hF4tZaYjd+K6Zi602CetblSbZ3f
 z0Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750558012; x=1751162812;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OM+BEwNST/KBr+JI4iy8saFJg+NXOI3+UiTb+zrHsEk=;
 b=RedXzNwTVZoG3k+K8lCBZj+xIt9vYlFkzfGhNQQlGS5T+VU1VHLz6ysIgd1YpxG0hC
 Kg4oObHoEksDnD8/JZS062pszjETQKRPindlQpHQZ2uqUmWNhXDgfhBsZWF9eysMHyLG
 WVCWtJBsRBoDhy0yD+xsFdR2o/EkH0S0giL7gfdsL+s8gpXejgPHxdAyzG+wxBMSNWVw
 vLMx7USjYkz3xg4i+PC8jEpWem1n172G7ELVq8H3+BcMzmtfjFkUBGj6BUJ9EGxKupFr
 zlj1Cy4Y6vz7svjQsYH5rXcTYTUQD38a+6evZmdCowyTiOAgBUD5hvaTGko82M3B8xbc
 9JLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/YZlGvO9bjK7NO/244XWvZFAxuXZAbcpSe6T4x7sskqumzeAQoI5zoj0yPJw6vuCyGE9NwTBCOMIy@nongnu.org
X-Gm-Message-State: AOJu0Ywom8c7H8pCKMI8EIU6p22qgQv6rpQ3Vsp3fgRccqBsoNQXyTgA
 vmX6m/PgJUUm4hxO1wRTG/53yu0cxBZggF670zLSPUsR0VySqGS/yFZhJnw2rtkt/0c=
X-Gm-Gg: ASbGncvkJVArbuBdLsitlfGqx3Dln55MAt3/rUrndyokDg4se1xfOdEvRonjxxcooCG
 VkutXprlmnyki2zsrUmsTTGqV5r0IL2/iIUvIAlOOLtn9R2OhNxJwEbBq+U7jbGDCtNWxQU3CB/
 6wu+L01VCDl+ri9McQxiBOAc+NEz2EiRfTW7oNUlZojiOjqVntff6uIKQr7YrGyhMDyn2HXhUnX
 pW/ebNqQdYa3s4U7UPp1PlKcnlncxM1b60VbYAeAPMy7+ZPLZIFlwxT+n0s88DTbQIGWY9LFx/t
 Hn1UB4UHSXDk8XlxL7mzAJ82v57hHqYQeTo/sMQetGwpkWzKu7uUXxR2XgCtKOT1y+PlxH5oxvr
 TE5C9V/bG4kKdYnYPoBHzCyfqoxv9
X-Google-Smtp-Source: AGHT+IFBLbHYugmYIWYBZCvG5H5JHTYyyGVkT+NkeX0DOJ5MA9wXNio4MlEqLav5F3/7N6eopllpYg==
X-Received: by 2002:a05:6a00:4fc2:b0:748:fb2f:d838 with SMTP id
 d2e1a72fcca58-7490da278afmr13041700b3a.24.1750558011921; 
 Sat, 21 Jun 2025 19:06:51 -0700 (PDT)
Received: from [192.168.0.4] (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7490a628132sm5095816b3a.92.2025.06.21.19.06.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Jun 2025 19:06:51 -0700 (PDT)
Message-ID: <6533f8e0-9f84-495a-9415-89c8c013f806@linaro.org>
Date: Sat, 21 Jun 2025 19:06:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 37/48] accel/nvmm: Expose nvmm_enabled() to common
 code
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20250620171342.92678-1-philmd@linaro.org>
 <20250620171342.92678-38-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250620171342.92678-38-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

On 6/20/25 10:13, Philippe Mathieu-Daudé wrote:
> Currently nvmm_enabled() is restricted to target-specific code.
> By defining CONFIG_NVMM_IS_POSSIBLE we allow its use anywhere.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   include/system/nvmm.h       | 23 ++++++++++++-----------
>   accel/stubs/nvmm-stub.c     | 12 ++++++++++++
>   target/i386/nvmm/nvmm-all.c |  6 ------
>   accel/stubs/meson.build     |  1 +
>   4 files changed, 25 insertions(+), 17 deletions(-)
>   create mode 100644 accel/stubs/nvmm-stub.c

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

