Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1284FC8302F
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 10:05:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWXqi-0003BK-4L; Tue, 01 Jul 2025 06:04:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWXqd-0003A0-Iz
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 06:04:19 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWXqX-0008JF-Bo
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 06:04:19 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-450ccda1a6eso25914255e9.2
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 03:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751364251; x=1751969051; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HLQ4lbWS09FtfHl3Qk3gA2j755T2lzvZSEUiWspkTiM=;
 b=Rni1bNtBIWC8KykbdIZDJhSD8UHe7PQrSUwXw1SrW5wnFsZUNwi71f66NoUTd7VNXP
 RQZCpxtDdSd87oho+YDg/Mk23+1QRxyb9Z3LMWREKTfsVoPb0bh5YYxHksXB+Pwm/q6W
 wgxfDyPizEiindlg870ryVWIz2lgeuNcUEA/eqDvOIVsahD7WvewvXD8VWu5sCuW1/iA
 swy8qHuMoNYjyrXD+81Qm0nBBuSH4TlhxndZMegsOs3JmkZZ8bI/FMTKf8CEVqr11Cke
 Z2xzEaBEFOjaaXXOsMg4Q5Pehg+gkqeiTUZCKQHskIb/JfuordRFdMjaeOOsdLprLe5W
 /ZjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751364251; x=1751969051;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HLQ4lbWS09FtfHl3Qk3gA2j755T2lzvZSEUiWspkTiM=;
 b=fV/5qX/OUaOjuSkqt29VjQWRRtlN+2KU4oZ7C+A4k2LVwflyXdKPepuoN+wAcsHZAF
 DUcnq09YosKwgBI1ERPfxvIRz61muNX3dRwCcD8W4571LHIQt6ecAnW+OAIv3UfXgkKf
 PLDpFyIWO6Mfcybq4PuSqYZBr9hd9oYe2P4JJ4SNT3NCDTbYC8IIk1egyJn517hT9UzL
 MYbYJKbmyIZbwPx5Fhhx7/wzsfYM+tHM+4A/fFmx9ngY51BhwtueO0Ny2FH3fdY6QF+S
 n20OetjUBjXa4E6NRlsxjCFt+s+P/ZokURTNqYEuvKMxPoDsiZxOKcwIt75i/kNoHEOg
 oGxg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXREz9g+nDwOqXNQvzL95aylWJL+1gCo1/Wnt3oYaRT32OiUywvdXKTKLFt+zd0XEiC/fuGAvP6Tejh@nongnu.org
X-Gm-Message-State: AOJu0YyoZ6+8N+wVvewIztta6hnP+Jjk/vVOUfkQxau20hvHcsJUiEjU
 +C96aAWO2EcNOvatSsBL+bR6MfwlTFGU9nY6LBcObYiBAP6wplBE8nS5MXgZvn0ROMw=
X-Gm-Gg: ASbGnct4Odi0mmT7AKuLONwdkesduCnzFXF+h7g6f/cJswg7gejMfc1fC3PHXPRQxsq
 nAtiFD8uy6xt3K81eKxTIy3hbO138BxMZieSKZkJ5k7tY17Vg+QOgvFyv1KYLn39LsgcDfOZrGh
 p8g3yDNetQGqrm0eqPirtK7DFQG0SOp6o/zJm6iw7Skahw/sin0dcqV4A8PR35TFkgAlqQrqkK8
 gLBynXrXK92stn9AQ5OTv3ctyL4eUPULxDXG+9pefFJMa1JEuY4qZbP8m/EXlOjMzeBk0FBFtfk
 ZUlk3gqNfqHyHc3v2puwp9nDLwE3XmOH2FzLPB3Ow+DEJ6wbKoQhVv/sS6MEcdtXorgcwyUtZtA
 TbuikMKu2qmxqbXGHwIHr7fdC4YPfSB8zEAIhgn7M
X-Google-Smtp-Source: AGHT+IGEAGjZric2dT4Y3S/1c0v1r0290cj+Uu3daT3gHwsvsNT6WcFL2/gM+y8CkqGKGvjK+4ZC4Q==
X-Received: by 2002:a05:600c:3ba0:b0:453:aca:4d05 with SMTP id
 5b1f17b1804b1-454a07dac04mr7526115e9.31.1751364250668; 
 Tue, 01 Jul 2025 03:04:10 -0700 (PDT)
Received: from [192.168.69.166] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a88c7fa8aasm12620751f8f.27.2025.07.01.03.04.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Jul 2025 03:04:09 -0700 (PDT)
Message-ID: <23065936-513e-4240-afaf-3d25de747dcd@linaro.org>
Date: Tue, 1 Jul 2025 12:04:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] b4: Drop linktrailermask
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20250630172301.519848-1-clg@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250630172301.519848-1-clg@redhat.com>
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

On 30/6/25 19:23, Cédric Le Goater wrote:
> 
> When grabbing a patch series, the link trailer is replaced with a
> Message-ID, which is not useful compared to an URL. Fix that by
> dropping the linktrailermask config.
> 
> Cc: Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Hmm :)

> Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
> Fixes: 838cf72b5d2c ("Add a b4 configuration file")
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   .b4-config | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/.b4-config b/.b4-config
> index 4b9b2fe290f9..126f503ded74 100644
> --- a/.b4-config
> +++ b/.b4-config
> @@ -11,4 +11,3 @@
>       prep-perpatch-check-cmd = scripts/checkpatch.pl -q --terse --no-summary --mailback -
>       searchmask = https://lore.kernel.org/qemu-devel/?x=m&t=1&q=%s
>       linkmask = https://lore.kernel.org/qemu-devel/%s
> -    linktrailermask = Message-ID: <%s>


