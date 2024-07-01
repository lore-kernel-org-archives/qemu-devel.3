Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAAC2C2BD09
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 15:18:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOInL-00034W-Mz; Mon, 01 Jul 2024 11:18:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOImx-0002zo-GQ
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 11:17:56 -0400
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOImu-0000YX-7h
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 11:17:54 -0400
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2ec50d4e47bso30370691fa.2
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 08:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719847070; x=1720451870; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QGvoMgVhrKesZbV9X6rZChmy8lge7d3h4APpAs6oSQw=;
 b=KQ6ZyQadZ/R6NJeFrCYpxhtZ3KGcZv2k0GbnbGmB2BFFWJVJlAnFKNYHn5TzqTZ45X
 Zcww9DuiNwYVbAY3kMaEpgQHi5P56KzIzSjofu+hdZfvTv47qJOwVbVU5i1P+hb38nUn
 6l2YOWo1GEFAiQvrxdkLXx/y4br3SuMV44NFXAOwT5lqW7CyshsDr63aEp9QtHpm4H4I
 u3A0dDFn9nf8gjY4x3PH1Yf+YfuUYDPq84WHS7QzCYu4PZ1GS5CFn804HtXLnnysMIq+
 aU0rUvkVn5HTzNBCnycZFwGcty64VPA/ruWmPhlqZO4NC6pk18heN21hAQWzYUuYIenF
 6dHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719847070; x=1720451870;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QGvoMgVhrKesZbV9X6rZChmy8lge7d3h4APpAs6oSQw=;
 b=snCD/nJahS+OcRnSIerXxnCLS8CqRcpEYlAVcrqWmRiAR2FfEjtoMDf+Js6uXzNXO4
 QCxorV+Lge3wKE5pcN9W9BCxiN5d5VP5JtLE+OhkO8mKmIIYH5ZoiC6Mq0Ftt2Ozngnk
 RYRLoRFqY5EMmrS6D+Tcy4WfZ6QiAsN756ID32xMSkrxDWzrlNAbff0XvufZ561dM+V9
 GjGBaFNZXg0rjlUxh7Db/3FZQavji6TWKtYeZ5xK2eeUgOdXpL7Xcm5YoObxhlLmJ/m6
 /FFOZUphkwbR1I+TibDaM4K0Rz7RINApBi/Ub+8jxlTZ8XPvU2MUpvRcAD8TBMDWvKpo
 d6nA==
X-Gm-Message-State: AOJu0Yz/63dQSUv2siTc3lNEErWS42akgvFQ/Ma4D4dQnx6ErUXVOC3Z
 pxZqA/y8q0u99yn9TX48xKUyiCk1tGvry17cd4F+U+NJJpYvDG72YK7Tia7zzqU=
X-Google-Smtp-Source: AGHT+IG9DEGbJtWE2mD/b8CNFthnMeXrOLz7vpT2d/sTon7F446Qgf6aqtokLlqTkz5hmoJG2aPI8g==
X-Received: by 2002:a2e:b889:0:b0:2ec:3d2e:2408 with SMTP id
 38308e7fff4ca-2ee5e6bc703mr38732661fa.33.1719847070256; 
 Mon, 01 Jul 2024 08:17:50 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.177.159])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42578578b69sm106770335e9.42.2024.07.01.08.17.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Jul 2024 08:17:49 -0700 (PDT)
Message-ID: <45a054e9-43fe-49b9-a567-186c522be137@linaro.org>
Date: Mon, 1 Jul 2024 17:17:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] block/file-posix: Drop ifdef for macOS versions older
 than 12.0
To: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
References: <20240629-macos-v1-0-6e70a6b700a0@daynix.com>
 <20240629-macos-v1-3-6e70a6b700a0@daynix.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240629-macos-v1-3-6e70a6b700a0@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22d;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22d.google.com
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
>   block/file-posix.c | 5 -----
>   1 file changed, 5 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


