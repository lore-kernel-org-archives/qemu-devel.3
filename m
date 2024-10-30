Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01630D6B6BF
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2024 18:56:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6Drg-0000NF-RU; Wed, 30 Oct 2024 14:56:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t6Dre-0000N0-K6
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 14:56:18 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t6Drd-0005Z0-8C
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 14:56:18 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5c9404c0d50so220465a12.3
 for <qemu-devel@nongnu.org>; Wed, 30 Oct 2024 11:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730314575; x=1730919375; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Bqt8gWHmst822Ac6KdhUeQwePOYcKeuYp0gJZ1sqBmw=;
 b=U7HViPTWaizoXzFJPJidH/di3dO3bxHbiymr0uZ2Hmv1qBJs0i7yozRK3DnM2BaCs8
 uunLeAd3qPDyKLPUQP8Orpv6TXDC6rLaP1KlPeSHTlPt5zKiJBlVN4Lla7PigrrE93h7
 vYfgYllZmonQa1x1UD7dPih+e1L7wYwuSoDz3alJ9Ts/zfqUEilALs7AR88l0cbWqJgn
 FWTilqELbC3OWhDn/liJzZZhubtntfQ2smoipqLEBN9Wr/elH48lRQ3PP5bGiYP/2wvR
 /0Q4try3ywIjNy3mkB4y3eQBiLQysaWolQpmx5EdbWLt5+nHrFTurAsoSEnW5AjUPoBJ
 EUWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730314575; x=1730919375;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Bqt8gWHmst822Ac6KdhUeQwePOYcKeuYp0gJZ1sqBmw=;
 b=mdSugcBQTdrNumEvz9QjUdEEKuBB4WE07h5sF8Slaculf7n1HvGHTgd3YvcaOKOyZm
 wCzz4MXcBd7h5W4Esy6ItU7P8AmnAZR2To+fsAMK2RoKXBQ5YrXqBsLNc4EqeYfrPble
 9PqQowIkSvhRcEWMwWHfN0cP3Zz9KLn2PLBC+Yk9u9LEMT7LWeQn7nrd6ngLMaynXr8t
 1dHmoNsFe6lZg/jFycRhfki4l6f//pee0CUsRnLP4wLCKBwXcKnTuLM1ldEeRaTIpjdp
 noO5wqfTJF858tp0I47k8olqsopGedGBghL5C+7JBAK0mF1p/lZcjviyhHE81Xu/RscZ
 /gEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVgOIFBoF+N44s1z4Kts+Z4gf6miMJmNYQYgyru87tBluwcSg29ihOL/wmju0MrBkTp2ZsXZwAmkVMp@nongnu.org
X-Gm-Message-State: AOJu0YxNRet6HEPYGSDApjIGWx2NkF90BfFFWFKQhq+mEm34+9diwVfE
 KBtj7L3qXkKCaOZOV7qEAtnHRWqkwkpQRc/JkrL873cmexciDlgUpD33hEBjRqo=
X-Google-Smtp-Source: AGHT+IHKAYr/i5TP6N0c8vtAbCoKQ+klfiBMMAf3mTiUc+fgwK8iGV/o2LKwX5OO0uwKW6Uux5Rv/Q==
X-Received: by 2002:a05:6402:280f:b0:5cb:674f:b0fc with SMTP id
 4fb4d7f45d1cf-5cbbf947c01mr12783993a12.23.1730314575364; 
 Wed, 30 Oct 2024 11:56:15 -0700 (PDT)
Received: from [192.168.243.226] ([91.209.212.192])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5cbb63196e2sm4943081a12.73.2024.10.30.11.56.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Oct 2024 11:56:14 -0700 (PDT)
Message-ID: <f938ec8e-b47b-47aa-94bd-fe263eb2da32@linaro.org>
Date: Wed, 30 Oct 2024 15:56:07 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] crypto: fix error check on gcry_md_open
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
References: <20241030101150.3023300-1-berrange@redhat.com>
 <20241030101150.3023300-2-berrange@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241030101150.3023300-2-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52d.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 30/10/24 07:11, Daniel P. Berrangé wrote:
> Gcrypt does not return negative values on error, it returns non-zero
> values. This caused QEMU not to detect failure to open an unsupported
> hash, resulting in a later crash trying to use a NULL context.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   crypto/hash-gcrypt.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


