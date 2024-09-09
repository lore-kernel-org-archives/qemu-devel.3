Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB4B7ECE577
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 17:56:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snicW-0000a9-0e; Mon, 09 Sep 2024 13:56:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1snicR-0008Tk-8Y
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 13:56:07 -0400
Received: from mail-lj1-x22c.google.com ([2a00:1450:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1snicP-0000VU-Hd
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 13:56:06 -0400
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2f75c0b78fbso26250231fa.1
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 10:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725904563; x=1726509363; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xf9geojBmL53D8UazZrGQqiR2/ncGPdJC/IXvO9uEzQ=;
 b=mV9o+E4M3S111Kpz5C3EQhyyyGy70J38I9LWLIjHDgjVr+y8DfVy9qiuo+yaK0CIGb
 +E4pmiaQ8Mix1JkhJ+E8g4SaQYS9fQBWe9o0lbLNrwB48Zk7SEwWtJjX7khzTfGzo/HP
 NUt9aEij4v1xeSA9HvAJ5vP+J5Ht3QlRgwDWKM4azyVRP5xEH9jqtV603J/1Kvu1BK33
 nEycs6NiZV7JSlIJkZATFEkscejNKumATB1+jnWdgUe89bmpEmAlWWJaRftdIUudXuJ9
 E2NRukR3+G8/P57pPjCjnV9thoJHAjZvZlidN/4mBE3FmW/j27mJGtw8ccwkdimHeHWp
 lCNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725904563; x=1726509363;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xf9geojBmL53D8UazZrGQqiR2/ncGPdJC/IXvO9uEzQ=;
 b=ArFdys7cZT7Nd4xJTApuq3bqu/GGvRwkhXZ0e684piXwt0zpKKPaEEwoeGwFw0zshu
 qbfBc9eKf5h9R8ekIb6ClJbCv7QO8y45kSjnXlZTVW6e8W5nhpM4w4fn6B9fClw3gQbb
 gGgDqOgJYwLBHNYIuubDS9Te0yKYIEquysd0QD/qVp+B80H4EyP4uEK42grfWE1bU3gb
 Hz/DZ4U3SiEFc4LqyeOhJNpoWTqzpfUj8Tr9AKcsu0e4fTL/2A9G/2Ji2gFV+yRqJA0g
 zuLAEmuV4ygiVtGjRzbQ6X17gCHch8Cj9epjQh/UhHsFQy76WoeXeJg/Q5F0OgresKWc
 6pAw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6CI6SUbrsOPW9ectqQYVanxpfVe1+Bk8hZTh3YDLh8JUC66mumGw1isfjU+I8/Hqk8PEKdvEclzYv@nongnu.org
X-Gm-Message-State: AOJu0Yxbi7+7NBRc/+0BeTyttZSrAZsr4nYfaEUuskr9AR8C7EwEjmd/
 UCi9UXpIh52hF4v96nSGzijqbmBpriUgH11R2u6iMC6sjG8y/J3tlLnzsW96rwU=
X-Google-Smtp-Source: AGHT+IFODqaqU4kh+cfLn9A0ci+5kyk6SVDWuwQBTDug4N0Nw6Od3GiNVEntdwWr5uwM8lpY7fMqwA==
X-Received: by 2002:a2e:859:0:b0:2f3:d8dd:a1f6 with SMTP id
 38308e7fff4ca-2f751f865c5mr71644781fa.40.1725904562998; 
 Mon, 09 Sep 2024 10:56:02 -0700 (PDT)
Received: from [192.168.69.100] (nsg93-h02-176-184-54-166.dsl.sta.abo.bbox.fr.
 [176.184.54.166]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-2f75c09a247sm8540791fa.124.2024.09.09.10.56.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Sep 2024 10:56:02 -0700 (PDT)
Message-ID: <137c4496-0837-44c8-a85a-6829ddbfc82e@linaro.org>
Date: Mon, 9 Sep 2024 19:56:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.2 48/53] hw/misc: Remove omap_tap device
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20240903160751.4100218-1-peter.maydell@linaro.org>
 <20240903160751.4100218-49-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240903160751.4100218-49-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22c;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22c.google.com
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

On 3/9/24 18:07, Peter Maydell wrote:
> The omap_tap device is OMAP2 only, and we are removing it.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   include/hw/arm/omap.h |   3 --
>   hw/misc/omap_tap.c    | 117 ------------------------------------------
>   hw/misc/meson.build   |   1 -
>   3 files changed, 121 deletions(-)
>   delete mode 100644 hw/misc/omap_tap.c

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>

