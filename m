Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EF3CCA0FE1
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Aug 2025 09:48:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqTnQ-0002bT-8E; Mon, 25 Aug 2025 05:47:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uqTnO-0002bI-VC
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 05:47:22 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uqTnM-0001Du-Dr
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 05:47:22 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-45a1b0cbbbaso35472285e9.3
 for <qemu-devel@nongnu.org>; Mon, 25 Aug 2025 02:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756115236; x=1756720036; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dURSmvwRCfSn6n+MmFPue7FlqfaiNZWS+C0N3taMCIo=;
 b=P5E2N5jFyDT04W+PNrjfQddjV8PuhKeNsLbdzDBrxXnmxg4wVoZ8icAZEmJuz0LnMZ
 fJ217BmD/957yJqip4Z32Nd0BWc3wG6xTqbxsqOu2jqWM2w4duIUn5OES2/o6bsuvlCc
 H4GQdIbP4AGDtpC0rwHPNcR9psjQuUtqpfHgF1GoGPqzpVPCU1r+pmikAGaIe+iFijRi
 Mbrgpop2/k5G6N7POFV2dUYx4UsdwYG0nWNpsZtJX3UTrBgJNZ1MPS+fHJ4nHv06+jd0
 8lnvRXhuzWTkum6nR2J00fwZgQoQkFq0Z835qV2yTHb+I92KGU3KKb8SqKTSSyPNXKKI
 SHXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756115236; x=1756720036;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dURSmvwRCfSn6n+MmFPue7FlqfaiNZWS+C0N3taMCIo=;
 b=OQJXKzk9bwLACK75puyLQmT33ECT4douWIoyI1bzgknmikcrWKApVQu6sPRZ6I4pHv
 23MfWE1nohQJbMzmYqg3HWsJqBTwt1zqmG20HIjXzJVbD+YLMKK6QpNIogNxXFN0ID5e
 ZN1cTXIE3g3DQQAp2itxEqwhFFfsvj5/ITDaqS8KY+HjJ5QqSeyvMAGYsd6fr+XPX8xy
 MmMMBn8bPjdjSsLjMfBw5MVakONVVyTedKkDoFHaZFgMy3ihIPxU3t7l/ImWA68Ovzlt
 IQGP7mAlzoYvMGU8zVegz14FDrGJUKXPGFMbRwmhA0NCkqEq0iyiP4m2KNgdjO/I/fSD
 bpZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWflxVsJHRwy1PC996BLRjAwLoVNb/tV1CCfMnQir4EZP0hyEGO++MFDMNiXIK8HcrT8Ysv/UCXs7NQ@nongnu.org
X-Gm-Message-State: AOJu0YzUIhetdtQsxUXj7flG+ivWfiXyywdIZ0M4RHMS3Y7NfNAwIT2Q
 +6GIugCJIo/yIMbsTCv3UiInTGPpMugeEZaKY78sF9mOrlndHJhnADhiquGQ9z2IIPg=
X-Gm-Gg: ASbGncsvt1jcDj0Su3nlvy7CXZ5w1iIqYf0iYgKlLsLoG8gn5PX/6xILFKc+0uoIxks
 GSQkK09VakNuOOA8bnRk32Q+z1vM4q59bHrJNl+CqkmYVmb7vtj8W5oWPLI+rN4TKiO4IioFEPv
 hq/mn+tAMeOZEXdVNKaMHgvZNNtqAwHogyWXcOBUWgk8Q54Ku+P/JMQPyoNORLJ7LJilFQ7oVow
 cV75RpBPKNmNx18qPfQreEAl/6mRVpf6MgTMTaUxyfY8Trm+wvveVaZOtgo24yeMd4jMutj/nHl
 NPT1IueCgLak7g0NAIPRavR1oUrqVgY8mykJ4H9gFRM7XRkP4/9kr5zmWxwmLLqCV1/0N1vX1WV
 INS9W+KKAKTxsRIhnMOxVVsPL6mpTEV2TzCMafOfJg0kJstwucsVYNSHgBkNvVnJbL5z2OLtQgF
 Gz
X-Google-Smtp-Source: AGHT+IFNq4nJovP2BiLziXSWhG1U5Oj+Gb4V1C+I1PiKbarTjbKDqiNeyDKJf2mGPpexfvtF1X1A1w==
X-Received: by 2002:a05:600c:1d07:b0:459:d9a2:e952 with SMTP id
 5b1f17b1804b1-45b5179f2f9mr73290115e9.1.1756115235664; 
 Mon, 25 Aug 2025 02:47:15 -0700 (PDT)
Received: from [192.168.69.208] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b575736f1sm101500875e9.13.2025.08.25.02.47.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Aug 2025 02:47:15 -0700 (PDT)
Message-ID: <51a9f857-69ff-43f6-8f3d-c7e5d5870c99@linaro.org>
Date: Mon, 25 Aug 2025 11:47:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] hw/sd/sdcard: Handle RPMB MAC field
To: Jan Kiszka <jan.kiszka@siemens.com>, qemu-devel <qemu-devel@nongnu.org>
Cc: Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <cover.1756019920.git.jan.kiszka@siemens.com>
 <8ea56ae040ef1037e44fc864c159e2f96f23f059.1756019920.git.jan.kiszka@siemens.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <8ea56ae040ef1037e44fc864c159e2f96f23f059.1756019920.git.jan.kiszka@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

Hi Jan,

On 24/8/25 09:18, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> Implement correct setting of the MAC field when passing RPMB frames back
> to the guest. Also check the MAC on authenticated write requests.
> 
> As this depends on HMAC support for QCRYPTO_HASH_ALGO_SHA256, only
> register the eMMC class if that is available.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>   hw/sd/sd.c | 90 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 89 insertions(+), 1 deletion(-)


> @@ -3122,6 +3201,7 @@ static const TypeInfo sd_types[] = {
>           .parent         = TYPE_SD_CARD,
>           .class_init     = sd_spi_class_init,
>       },
> +    /* must be last element */
>       {
>           .name           = TYPE_EMMC,
>           .parent         = TYPE_SDMMC_COMMON,
> @@ -3129,4 +3209,12 @@ static const TypeInfo sd_types[] = {
>       },
>   };
>   
> -DEFINE_TYPES(sd_types)
> +static void sd_register_types(void)
> +{
> +    int num = ARRAY_SIZE(sd_types);
> +    if (!qcrypto_hmac_supports(QCRYPTO_HASH_ALGO_SHA256)) {
> +        num--;

Instead, expose RPMB feature in CSD when HMAC supported?

Something in emmc_set_ext_csd() in the lines of:

   if (qcrypto_hmac_supports(QCRYPTO_HASH_ALGO_SHA256)) {
       sd->ext_csd[EXT_CSD_REV] = 5;
       sd->ext_csd[EXT_CSD_RPMB_MULT] = sd->rpmb_part_size / (128 * KiB);
       sd->ext_csd[EXT_CSD_PARTITION_SUPPORT] = 0b111;
   } else {
       sd->ext_csd[EXT_CSD_REV] = 3;
   }

> +    }
> +    type_register_static_array(sd_types, num);
> +}
> +type_init(sd_register_types);


