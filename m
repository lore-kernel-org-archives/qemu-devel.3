Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81056F531DE
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 22:54:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCQAM-0002NU-Ec; Mon, 13 Apr 2026 18:54:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wCQAK-0002Mx-Mn
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 18:54:00 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wCQAJ-00024M-9n
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 18:54:00 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4838c15e3cbso45890005e9.3
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2026 15:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776120838; x=1776725638; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=I6SyLIs8+nCm+Z5V5HlN214+IQrNgoczgPddffdg29s=;
 b=C53oW9Xo/au60sL8AjhqD9e7aC0A4dOtfnxjGi4YeUgua+d2FShBML8fcZzu4vUwlP
 zCD2C8AO4YXTPlD0dyrzRjEw/frurYgYwO2ZZkNVb7oI+FbxABUHNwFPGjCoLm0juMRv
 MBwlZ2dJtEKWJO0rQmiv/OlsM4eJtD00sW3l0mICSmyRi27X0Tmrvn7q1S4DlwZKP98A
 u9cQZn3uhbbK+ilGfknhftMTymv9aBlFvlop+pntHogmFoHezSGDtiNSj6I3zuS/ijzn
 4t+MwluF+zPQ6PyEdKvmGTZaoN9EMo4qS69uwBqjM4wMUY56IdspwOmbPwuRtZHF46B+
 YUIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776120838; x=1776725638;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=I6SyLIs8+nCm+Z5V5HlN214+IQrNgoczgPddffdg29s=;
 b=NYUgEjeOCQuYDErgIHtfEafAa0oE9CX9Avg9C+KOLymmtTwOUlyEJiCDb4LhIl2Mws
 2q30FXitKS4/Lbx+XaGPUYDcQ2BNapMFxOO8SEvHy3qRWwIn4qN8UYJ5J7Aj17w4xojO
 6MMUX87OcNV7L2Uy225ioHEE4aN+6fcQoXI9DrIsElAZy4i1Fj/wRNp6JXEB6tFh7Y3q
 4IO9/GFTTld1uaVJgdo815aqJnuJA5M5khmfgdrYhM8gTgav3HIu6Wu5i651xi+80T8O
 pEkcbwCdR7IydbqjqxQuViSnwdKyyNLPWMf8Tvf3jZ04wWhNw0eXg8o7JCN1DEci5jVN
 ZaBw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9zWV/f8KAgIcypWELPq7O37tWskZYqrr5zGlsauIL8AU2uMW+SwyVBGdNUiIgiOAN+F/Ssw2o/YCls@nongnu.org
X-Gm-Message-State: AOJu0YzakDALvyLE86QtF6GaaBm92gk4jmKydbfZkgk+1drjd8aFXptv
 AnBtVW975Zk/bhMEcvUE4670A69m5yYNK5fALpHAGp0aPzh6ig/MbIQ2mK0WRLdRWFA=
X-Gm-Gg: AeBDiesbe/Jisxa45HQt/XUa7KzUmEU4LHVzrPg45HGhzWowDpbY4gv3zsA9ecO8ywa
 3xv1JETqFyRDvEMwxqK+ai/9cmwb7uX6QNgd3367PC+Cd6v2fJ/E00g+DaQQBAYFAVLUxE0hxds
 VoXyeVSeHfraZrSQmZ9rRrN0F7KhTgTzuCRrvyr4JtZ46R7uVQVGiQrJWmdLNZR+dh954K0g94D
 NVeczavyamp5goaTxpTRtd+MApzTFT/gslzZtJN0gGJWIqvL42tTGbTyQIamD/GCi9V3+5/b+Jm
 vTe3wW1DGTIx+k+gqQXmEwfy/Z6jkJ1ipNc6qRgkmOhz4yVUWO/LxTOOrCeeuatXOxQEJ4aH2He
 YOgQrTMpYZq6295qo9QAbpoAmumLUXRIJKKMgiyMorKEqPo7xu6XWQP2rJA3csuClwcEIAELDVm
 OXykQ6/OCbwVsxinIWcvLaR+Sw1BGuMUTIMct1JBJwq74jRyjR9S1JTyXYa2nNSb8HnQ==
X-Received: by 2002:a05:600c:c088:b0:486:fa35:aef2 with SMTP id
 5b1f17b1804b1-488d67bf744mr146730085e9.4.1776120837638; 
 Mon, 13 Apr 2026 15:53:57 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488ee018b34sm887285e9.13.2026.04.13.15.53.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Apr 2026 15:53:56 -0700 (PDT)
Message-ID: <5dcb14ae-64ab-41c3-9ff2-27ed6d42db50@linaro.org>
Date: Tue, 14 Apr 2026 00:53:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 57/65] hw/arm/virt: Move MSI controller creation out of
 create_gic()
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
References: <20260327111700.795099-1-peter.maydell@linaro.org>
 <20260327111700.795099-58-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260327111700.795099-58-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 27/3/26 12:16, Peter Maydell wrote:
> The create_gic() function also creates the MSI controller; however
> there isn't really a strong linkage here, and for the GICv5 it will
> be more convenient to separate it out.  Move it to a new
> create_msi_controller() function.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> ---
>   hw/arm/virt.c | 15 +++++++++++++--
>   1 file changed, 13 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

