Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04E72C41513
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 15:18:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOIn2-0002y1-RX; Mon, 01 Jul 2024 11:18:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOImm-0002gd-85
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 11:17:44 -0400
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOImj-0000UA-8o
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 11:17:43 -0400
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-52e829086f3so2709700e87.3
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 08:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719847058; x=1720451858; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZiI5LK2QQEpisENJJU9AOaq36YG6/Nn0HRXtspRksmw=;
 b=sFll122oyjm78cjgWiNWCoo3hvTx2xSf9pw4GB7YrzvspTFBtAo2iCQDXTnpX0uXFI
 IKiHnY7HUZpINKvF+EfWP6dzR8N1eKjDgOtiiwbA+BUgjwzKDUFVaDuuntpANCpNm8xy
 mMxtPiP/W2BKJ5xetczrq+2wu4dYfSPYwb8tt+4g24lQb6unZq5iWG3GAz2/4N8z7qE7
 NkjQbLhZCrnmZHUrZtvcWoHk+FEJf/tP7dZkKfw3qzwZ2BOG6yWqUSAZWjm3t0Y/9any
 WE3BgpOlKA+NJ1cpEo1VOdFR1LgThZbRE9jNY7HKAW/b3pqfstuqiLaXMh8RockK05Rq
 w7aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719847058; x=1720451858;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZiI5LK2QQEpisENJJU9AOaq36YG6/Nn0HRXtspRksmw=;
 b=jbZK4IQWLX9CnXrLs47GLnIybAwLWwZbAOD1BXgOcHXBeLjr/emgEvh2ThSIJqs2bG
 A5Tb11lh9RBEku3fg+J/bRqyM9Mtgh8CvbaPYybDTGpfHhUynl/ED++IeQ8LitcWNaDb
 SUELs50Ey5aJ2DdpVHXVJ3hz4+ERMm1jvL2BSENr6YhMZ/u00bH116+7BkIupomGyLcn
 WgrlZ1aPOepACFXbQMWGF8I1/bjYuTtQDHO3q9+DLIKvPaMBLQo3yKTRfFicJLayjBvV
 OaGT9pT5HHa+Ohh0fsZWVGywlY3PxZqFgOE01gs27Gx+tO9tSYLs+J7SOuUODb0WAhh8
 BiWg==
X-Gm-Message-State: AOJu0YxLCrtWJumRTmShgKfKUWhu8N/vRdaCobzSb0WFmi7yv48FZg17
 LurnnRJPT54PPIxAxs8qvuiF2Z7F956QnidvB7C7rAHAS54dUyWOUeb6cVA776OIUN6d9aEMnLs
 s
X-Google-Smtp-Source: AGHT+IHOl3tIzTnI1sioiT7IjFGVOD+4fpLo1lqWCi0AW5FpzRGzDirg+St9PR2YWws/0KR5dEj55g==
X-Received: by 2002:a05:6512:3ca9:b0:52e:765b:c00e with SMTP id
 2adb3069b0e04-52e8264c2femr3876969e87.7.1719847058540; 
 Mon, 01 Jul 2024 08:17:38 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.177.159])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42578800bf1sm70523775e9.1.2024.07.01.08.17.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Jul 2024 08:17:37 -0700 (PDT)
Message-ID: <35b69169-5104-41c9-a0ce-b729488c7526@linaro.org>
Date: Mon, 1 Jul 2024 17:17:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] audio: Drop ifdef for macOS versions older than 12.0
To: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
References: <20240629-macos-v1-0-6e70a6b700a0@daynix.com>
 <20240629-macos-v1-2-6e70a6b700a0@daynix.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240629-macos-v1-2-6e70a6b700a0@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x132.google.com
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
>   audio/coreaudio.m | 5 -----
>   1 file changed, 5 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


