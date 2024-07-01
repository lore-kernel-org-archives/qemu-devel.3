Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0CD6C2BD09
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 15:21:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOIq6-0005mU-KS; Mon, 01 Jul 2024 11:21:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOIq4-0005mJ-CO
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 11:21:09 -0400
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOIq1-0001Ya-OH
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 11:21:08 -0400
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2ec5fad1984so43545241fa.0
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 08:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719847263; x=1720452063; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=R97xohoH3K3kQGY1LMsX6+rQpWApjYKOmYEihReXYNY=;
 b=M0mpjoyXvYMxFf7f3g6PQP8ul5hvah8lhLROEsTf1cH1wD5yg5KE3C4VCnoT3fT7+l
 bmsCfvANIuZTb16kKr+G8I60LkU+ALfiX1ZIn2O0bl9ioVN/O2QRFVR49IogAqB5r7oN
 d4Osz7NdsAsXkREqY1ak/OaJGY21DaoTCHj70bkFit1Zh5iXvxsvjmT5pIvf9Q9Z55Ss
 fgQjaCgIrYxyqvivhJj20drdGToZ/IUR5+C8ye5W567A3nZQc8OWZzv+92LY/iqUOgLq
 IqeIvm31+r8KIkvSP1nMj+w1d86usDvWo+FkiJGExzGqi6BeKGBxm5/EP+v/VtvilFtG
 WQxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719847263; x=1720452063;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=R97xohoH3K3kQGY1LMsX6+rQpWApjYKOmYEihReXYNY=;
 b=wMV1cHO3dwIE9JfeDQEiIiNsI945nWOSDYH0wdTCEIETtRA/eVHeSOUWG6+fVZzImX
 nt0ekTioKeK98lJkrz2YfO/UvMQGGlH7nqTgbdawFXqxEjAUGbRoeXMfVLMI6ggCMMvp
 iLEwN6ly+2suTSzYh30mpnG1iwnOQinFrjaLLmFuSvCucUABmaGx/XgDTAgXChX90LPZ
 EiZIoypZkrcC9zPbGTc8txErSjakQkASqtBcEw3p90jva+U8PqXBfhlGT2XgmY851QnO
 d3xjyhsel9C1Kwz7aJ3ZLixZpGF09cstiY1UEKgEGk88BGbz+6sOyMBEBbZ5Vk9QPkK1
 fwzA==
X-Gm-Message-State: AOJu0YzheiFiWa2hnD9ucsJmptWcyoJOhGn2VH1KN/ISPoLCJaBeHwz3
 nIHyud15WiugmdoIoSoZddfUlfe2Q2lmwHWXmfGaqnxufETRhj95jI+4vkEqFhs=
X-Google-Smtp-Source: AGHT+IGio2hipHzpGIecEqxYlggK0QAJLEtCRVSxKEtXT7BYb/c6Of8HLpF1Ah9+LCjEriDZiQFUtw==
X-Received: by 2002:a05:6512:ad2:b0:52c:df4e:3343 with SMTP id
 2adb3069b0e04-52e8266ee75mr3730528e87.16.1719847263063; 
 Mon, 01 Jul 2024 08:21:03 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.177.159])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256b09a073sm157222725e9.32.2024.07.01.08.21.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Jul 2024 08:21:02 -0700 (PDT)
Message-ID: <68aedaef-407b-40cf-9da3-6c139df47805@linaro.org>
Date: Mon, 1 Jul 2024 17:21:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] hvf: Drop ifdef for macOS versions older than 12.0
To: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
References: <20240629-macos-v1-0-6e70a6b700a0@daynix.com>
 <20240629-macos-v1-1-6e70a6b700a0@daynix.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240629-macos-v1-1-6e70a6b700a0@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x231.google.com
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

On 29/6/24 08:24, Akihiko Odaki wrote:
> macOS versions older than 12.0 are no longer supported.
> 
> docs/about/build-platforms.rst says:
>> Support for the previous major version will be dropped 2 years after
>> the new major version is released or when the vendor itself drops
>> support, whichever comes first.
> 
> macOS 12.0 was released 2021:
> https://www.apple.com/newsroom/2021/10/macos-monterey-is-now-available/
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>   accel/hvf/hvf-all.c   |  3 ---
>   target/i386/hvf/hvf.c | 23 +----------------------
>   2 files changed, 1 insertion(+), 25 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


