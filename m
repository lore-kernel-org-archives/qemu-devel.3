Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 277E2E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 09:54:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWBiA-0005Wr-BQ; Fri, 10 Jan 2025 04:53:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tWBi4-0005Vz-9f
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 04:53:44 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tWBi2-0002zk-B5
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 04:53:44 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-436a03197b2so13394745e9.2
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 01:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736502820; x=1737107620; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GQQi0wfVpsiJ4GzzTEsErqYPY5ioFnOeUn+QDwjt5Uk=;
 b=raHEYibX7saiXWKRiglhcCR9PQ8r9FK7M/io0zcL0QYA0hCy2I1pSpOJdepIdX7X2/
 6pfOlxCcCuBAjqjAAL9hVy9VAgyKY0MGlrmN+jjNiEKozWB9vDuCPU25R+Z5EAiuzLaH
 aIfBHP1KyE1tnpGBH7f9uibsnaxnzUB6vMEg5o1m49NoTec3R4942cD0CJW1OtEL5Mg7
 ftraZuSLTJkHNe01IDTYBd2rxxybgHw7TSafcysql3rcMXpryLQIyr7JSe3+vMohZy4r
 mIIOaFBDzYycuvPBontMTRehRGR0opzD6nCqwWs4miDXgCdly0z0ENEcFK/ibxF9VNgl
 lJcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736502820; x=1737107620;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GQQi0wfVpsiJ4GzzTEsErqYPY5ioFnOeUn+QDwjt5Uk=;
 b=WRenbn2ny33wevefjmgZ59H0JeCMdrEY9l/HSgBFt75LZsdNOM8g7bHQFbQJLWr/I1
 3d5K+AH1A5vzpaZy0oas+sbplhUpLdksJggrrFxQWrkHR2tAtyf8nwf7N5EC2bxGem/b
 dFQMcpKrcJP1nrlKlTSZCu/oKVVmxG9ApRLLLKh3vqchJuFEbzWcokFdbiVFkqQZUHzk
 senw6HDwgeJtzBYjrdQmFF/OIvXg2DO5SE/bgdJ2IYiIxM3ekOZSb4UkEFbBoLxzLnIs
 ktYhggDq4OgpoxwYKn8+8kV0ycbXXTjcZW9AzR5g/BxvIdcAI2miDGxPsglFkFjnvNlM
 eFdQ==
X-Gm-Message-State: AOJu0Yw8yTgSOM4hcIrRgcrf0npGJ8Qpa6LXb/t8Uw9bhfHXNCPNq5YI
 CtNupkaKDO43aGNeSDNYKNpfXtXpzX28CRmG0DIs0r0rPdA9rcS0Fg6/2TQZMRY=
X-Gm-Gg: ASbGncuGCVxr8VoyPfWgokAVnTV3UsVo/1S4gWOajFDm8mt0gqa666iqY9OpJv2ivxD
 bqS2ycT8V6vRz1hcIJ9JHdhV3n6BYB+y21dqgEYLzuaY7KdHisonQATcFgnfEXmUuKgRnwtTiE0
 1w3aYV5TsSY/W1r5ZtLhYlXY0SGtL86IWLDOco5nzIw2fBjKfwJfeOFVyhcwCsZcPJfwIFUunjC
 tiamLehZf4NN56e62ubuY5bEnMjK0od5gMQMGTvXQl95qgohCbSB6F7so414wJTYAaBE8Gjofa1
 7ZMJZdnp0sbn5GL5gmt/nA==
X-Google-Smtp-Source: AGHT+IFfnegUj5SYwLuqjcG6LnV/Nus0kVaG/bz0z+5xvJenmhmuPdqbAi1F94o2eb96QVNBX190Zw==
X-Received: by 2002:a05:6000:1a8c:b0:382:450c:2607 with SMTP id
 ffacd0b85a97d-38a872d2a99mr7299592f8f.4.1736502819930; 
 Fri, 10 Jan 2025 01:53:39 -0800 (PST)
Received: from [192.168.1.74] (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e37d2dfsm4034029f8f.7.2025.01.10.01.53.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jan 2025 01:53:39 -0800 (PST)
Message-ID: <0ced62b7-9219-405f-96e3-ea7c08366f46@linaro.org>
Date: Fri, 10 Jan 2025 10:53:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Subject: [PATCH] loader: Add register setting support via cli
To: Sam Price <thesamprice@gmail.com>, Alistair Francis <alistair23@gmail.com>
Cc: qemu-devel@nongnu.org, alistair@alistair23.me
References: <CAEekfLYJqvMDf5A_Yj=N6jMGQ4oj3rC+fv3xcCCfSBy8TDaY-Q@mail.gmail.com>
 <CAKmqyKPo=a=RHUvvgKZLB_DJnEXO=7u25MwNfXu5EDjak=y0vg@mail.gmail.com>
 <CAEekfLaW=-tpTo73or0Lv6zqOuCa67UoYSt9guyHFsw6yM37mg@mail.gmail.com>
 <CAKmqyKNeks-12czF7sWP7gr_t=WU9g309_y5Xk58iFBiVcAijg@mail.gmail.com>
 <CAEekfLYFsdzgRiscqJ4NsvpMsOaLrj_6QbjH-0f42mdggXbyDQ@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAEekfLYFsdzgRiscqJ4NsvpMsOaLrj_6QbjH-0f42mdggXbyDQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

Hi Sam,

On 8/1/25 03:28, Sam Price wrote:
> I made the changes, and added documentation.
> https://gitlab.com/thesamprice/qemu/-/compare/master...loader?from_project_id=11167699
> 
> I left it as [PREFIX]<RegNumber>
> 
> I can switch this to just RegNumber if desired.
> 
> I am still struggling with the email format sorry.

Possibly SourceHut can help you, see:
https://www.qemu.org/docs/master/devel/submitting-a-patch.html#if-you-cannot-send-patch-emails

> ---
> docs/system/generic-loader.rst | 98 ++++++++++++++++++++++++++++++++
> hw/core/generic-loader.c | 46 +++++++++++----
> include/hw/core/generic-loader.h | 7 +++
> 3 files changed, 139 insertions(+), 12 deletions(-)


