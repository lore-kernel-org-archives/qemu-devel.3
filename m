Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 321AEC52D7C
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2024 06:15:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdOKo-0000nq-8u; Mon, 12 Aug 2024 02:15:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sdOKh-0000mV-SY
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 02:15:07 -0400
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sdOKg-0003Gv-60
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 02:15:07 -0400
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2f1a7faa4d5so27636141fa.3
 for <qemu-devel@nongnu.org>; Sun, 11 Aug 2024 23:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723443304; x=1724048104; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=c1pB0uvd6Mj4Z5qZ+E641V40sbiQL7iECZ73k5RuI0E=;
 b=woQl56ZkrAeijPhG0AMTMSSzCP0FrZV8KwijPfguAoJBH0q1330+Ro6uk4D3vMvzzF
 AGij3Wlk1+q+n3q0G/2Zy4CbJp5OtUkTWLW603rR5ueqVTUAiu5lMtqCcT0BdLGlsCFE
 7QbvmKXYfOX5UHKESV259kDgQ691vKQoJjNrnadXzAu7B0JfzGPIeMfyRY5vR81SL2dV
 RJ7ZzpVWMkY2gxwwVHwNOHfFgl6dGf5ddcQelI8RySX5dxHsktrUzv+BR65DbPPnQa8N
 WvFLhf0/6OIPVEgPoERwo90gBZaM+CDj+bVkpWdHpnqYjW5mU1TulEMNWCfOgUcxn26H
 wDVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723443304; x=1724048104;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=c1pB0uvd6Mj4Z5qZ+E641V40sbiQL7iECZ73k5RuI0E=;
 b=UgFx5SQLHfN2DSpxpL7ho7h+ACRwkOdyCU2qMjyqsYYoNMh7xR44n2r3eGBE2sL5+F
 QGT8ZziYmFuSpEq7fyHzO8DO2Lq5pFfPseBDg8hkRPhyD66hjv8HsHm/iVefC5Bcc3qP
 VWGlDc9E6fta9RVOMVDQ8QHv013/vv8HQ9caEgpy/p4PAFLZNN/swJ+l66ZC7Z92HFtg
 6UIuJm2VgQZq7uLnCpIhQJS+puaVw63Cme8g4eExbKxn7FKwxNFDFe62dzUfYRnI3kmA
 T3YDOH+0AptWKAAOhCRzhyePNvrDzByGEjRutCl6X3In+J/6yY4Z9Hwx2gkpkLN2DUT1
 im6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6bIhryGuUBaHmvPPLQrtHsn5foD+aDo3qg69hxi0qV0GI6puN+gwwJ6yDKtBFJUzBqcNQIpM6r8l+DZtTHwZ7eORckaw=
X-Gm-Message-State: AOJu0Yxcffp+hTk0LtgTbYSJQacD/AB07g9T7RUBI19xQIB82A37pR77
 7BGLuDTrlPovfAKux7flE6r/D+0FyYBflj8bf3pkcwmiklaeQjpJtbmRA2mqw5s=
X-Google-Smtp-Source: AGHT+IFskaE+EQDd0394YEKtZNKGewOaEwCL9y8LBdwl2v3nTY7xDmua0FQ8bY7AD0Hk7NDabv8BUQ==
X-Received: by 2002:a2e:98cd:0:b0:2ef:216c:c97 with SMTP id
 38308e7fff4ca-2f1a6c65834mr55540581fa.19.1723443303783; 
 Sun, 11 Aug 2024 23:15:03 -0700 (PDT)
Received: from [192.168.71.175] (133.170.88.92.rev.sfr.net. [92.88.170.133])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-429c776074asm88858365e9.48.2024.08.11.23.14.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 11 Aug 2024 23:15:03 -0700 (PDT)
Message-ID: <6d6d5d2c-3696-45eb-b9ba-fb5a754fefba@linaro.org>
Date: Mon, 12 Aug 2024 08:14:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] qapi: Document QCryptodevBackendServiceType
To: zhenwei pi <pizhenwei@bytedance.com>, armbru@redhat.com
Cc: eblake@redhat.com, qemu-devel@nongnu.org, arei.gonglei@huawei.com
References: <20240812014252.1398754-1-pizhenwei@bytedance.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240812014252.1398754-1-pizhenwei@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::232;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x232.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 12/8/24 03:42, zhenwei pi wrote:
> QCryptodevBackendServiceType was introduced by
> bc304a6442e (cryptodev: Introduce server type in QAPI). However there
> is a lack of member description. Thanks to Markus for pointing out
> this.
> 
> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
> ---
>   qapi/cryptodev.json | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/qapi/cryptodev.json b/qapi/cryptodev.json
> index 68289f4984..9622c6d92b 100644
> --- a/qapi/cryptodev.json
> +++ b/qapi/cryptodev.json
> @@ -28,6 +28,16 @@
>   #
>   # The supported service types of a crypto device.
>   #
> +# @cipher: Symmetric Key Cipher service
> +#
> +# @hash: Hash service
> +#
> +# @mac: Message Authentication Codes service
> +#
> +# @aead: Authenticated Encryption with Associated Data service
> +#
> +# @akcipher: Asymmetric Key Cipher service

Can we drop all trailing "service"s?

> +#
>   # Since: 8.0
>   ##
>   { 'enum': 'QCryptodevBackendServiceType',


