Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24270D0E6FF
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 15:38:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNv7l-0001m0-Vp; Tue, 25 Nov 2025 10:38:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vNv7I-0001Xj-9z
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 10:38:08 -0500
Received: from mail-il1-x12e.google.com ([2607:f8b0:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vNv7G-0007Ry-3F
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 10:38:08 -0500
Received: by mail-il1-x12e.google.com with SMTP id
 e9e14a558f8ab-4332381ba9bso24956245ab.1
 for <qemu-devel@nongnu.org>; Tue, 25 Nov 2025 07:38:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764085084; x=1764689884; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/yzyG8jDa9ctxdkRcU3ry+un7DmCNbAaafVnZlDLrXI=;
 b=DiZR6B3UlS77e7RzaFCIH7SrJ0BzqAjJorAHufGRHa5BKg4SDzStamrP6DCc3o4rTR
 gfZEQV8NMZyBR9/+LISFiozrF9952aJJimIPavkTYeNW44WUBFNcC723jricUprCkAMS
 0l5S8nwh9rJvrEcfrAN2GS0ZEEyKmE/iZ9r1MQrrhpIy9njhKruCZMEI61UuHXYTjsC3
 ogDA/aivsRAGkHsqdXExqhyQJdfzmYtA+sw+w3MhBKykpu5Z41crb/P5XnTYyNPjRmTM
 HmFfVEcUUMmtMkI1RwF85S7Zu6Xxj9dzRIP22/AaaeKiDnau7NzDEW7W6Af3hriX8/Wu
 9WGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764085084; x=1764689884;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/yzyG8jDa9ctxdkRcU3ry+un7DmCNbAaafVnZlDLrXI=;
 b=ey1MvcKyOg9ZLI/GVGJgmRN4v+5wxyUGMkj74d4rIDGOyhuWjl4Lpq9MEXcU385n4o
 iGvbitkUau+Ujz2erHp1OgZzI6vLgJ/LeVFK82Yj8iQciYJqANLuKstX9ZZ3cLwvHvhf
 KXpOSJGwVf477D0DxDQPVBnoxitt4rnIy5cJVP4I0A6eT65v/TvPVErVofb52ru7BPR5
 eirWQAD2Mi2GCWCWEb4I/iX/MTUCnk/6m6G22xM9xdtc+V0EHfT8TYwcy2f7g924lu3L
 6IogFt6wutOmZ/fFgnUoEG1t0uRpBdMP7A6Xg/AWQWYwiAHAWgQ4u6yrDW1Ta6lI6+id
 vK0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXcoe0YQQg+cT+H0t0o+Hd5rG/mT8NPbDSsLrfssZUV9UjEsgj61wKo/MSdLrOnBgRv05ZAGwCKgcOI@nongnu.org
X-Gm-Message-State: AOJu0Yxr77I+AW9MTGzDDfVrrRU6Kyqhi3s663/KMH6PVooYE0cHKY9c
 /lMsgS+Rretlqh0qEweOio1zm4dEmur9QLQ7kBR6P/X7POk0/UMRiGPAy2h9y/RTUt8=
X-Gm-Gg: ASbGncsVAPva68sWE0J+YBEhcbOZAJcvcw1GnUOjVjuQGViilRFmoMKoTau9bEXSDBv
 8KuMRQsBuc8OAt0TwQCAJyqipxiLwqwOof7K6cujPfTOZFR8V2FqsBUkgmXm8JXaZj5X3qgBsk2
 h9yn8mBzCqchmk3ixWHHTffh5+a35nOAn5RAMthK4nr/D9n2LyLmHsnz/tsudYzRag6GBIOIliY
 szC50243FTEGI/qCJtUlikO5hjLDW+ZUblSATWktzklIMEEfIdnR7lkasu4dBjpQ/fK78+pz/2r
 GvLj+jSZs2LnS8ytvB9zto9DxRe63I3Tn8JtnUUEjcTf3oV12UowdvINAgYbWvejc8DjmvRDPNz
 WhloEmK1mgt0+aS6oJu7CqBTVZDIS+vaNFT/DfHOR1z1sT/kSw5swM9vl2oFj2+i+IHTeM6rHp4
 Q2NeDooqCE/2XKfDDQMXc9u21v5pAF/8jWGcIkQ2U=
X-Google-Smtp-Source: AGHT+IE5O69+miotbfLE4oOW4TqtNHjppV61qUApX1ozQJr1p3Y9J0H3YNNdxBivgdnrj+PhvVK3rA==
X-Received: by 2002:a05:6e02:b47:b0:433:80d9:708a with SMTP id
 e9e14a558f8ab-435dd06591cmr23946125ab.17.1764085084520; 
 Tue, 25 Nov 2025 07:38:04 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-5b954b48cb9sm6884263173.42.2025.11.25.07.38.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Nov 2025 07:38:04 -0800 (PST)
Message-ID: <8caeba48-95be-4944-8c0b-5fbfe5b13774@linaro.org>
Date: Tue, 25 Nov 2025 16:38:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] aspeed/{xdma,rtc,sdhci}: Fix endianness to
 DEVICE_LITTLE_ENDIAN
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>
References: <20251125142631.676689-1-clg@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251125142631.676689-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::12e;
 envelope-from=philmd@linaro.org; helo=mail-il1-x12e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 25/11/25 15:26, Cédric Le Goater wrote:
> When the XDMA, RTC and SDHCI device models of the Aspeed SoCs were
> first introduced, their MMIO regions inherited of a DEVICE_NATIVE_ENDIAN
> endianness. It should be DEVICE_LITTLE_ENDIAN. Fix that.
> 
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   hw/misc/aspeed_xdma.c | 2 +-
>   hw/rtc/aspeed_rtc.c   | 2 +-
>   hw/sd/aspeed_sdhci.c  | 2 +-
>   3 files changed, 3 insertions(+), 3 deletions(-)

\o/

Thanks for the help :)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


