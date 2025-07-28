Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7CB2C87FC9
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Jul 2025 11:19:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugLrr-0001dD-G4; Mon, 28 Jul 2025 07:18:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ugLLl-00030I-Tg
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 06:45:10 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ugLLj-0006gK-NN
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 06:44:57 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-45629703011so29650485e9.0
 for <qemu-devel@nongnu.org>; Mon, 28 Jul 2025 03:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753699493; x=1754304293; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=H3zSWYbfc5Ko6bZj8SsT4+B83dmSsrThM72rQyD9d/s=;
 b=Y8i/1BVLQ6NQRUdF3jZzWX8GXYoVuYFFvkoRbdtZIUEFzsYUXzOBBzWOcfKgVMHHhZ
 BGZgUziPV8y9jk/jVz/yRgGGL2G1AR6/gtPrO7A5S9DzMttlId4/uCrB9IvaW/B4CEcq
 Trnqtym1LuSgPeVhacJiQw9n/X+VDaC6OSxpFwP2d7f/EElLEttdddfrYnJmUZHnMYP4
 d8vLlJktLOgWGLuW4tR29j3YW2OYFxxU9UQ84wnMEUZ6/aZVF4cFQGW/4TC02IICp+lu
 wNmCKHVTHHfXWWirusrwDN+fBGwMFjFtC829eTzQWVgM0qCSL0fUc0IoVvwU//q72UJ2
 /dBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753699493; x=1754304293;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=H3zSWYbfc5Ko6bZj8SsT4+B83dmSsrThM72rQyD9d/s=;
 b=gBjpqVxbOdUkY7Kx9KLwUgT4QDjPdv7jPlu7gSGx+xBqottQDk0K9WiIbPDkuaUPYp
 LsfLktAd3OC/GaCaB+Kdbei2iWO3ifv/T/Pj3gyrpggE3ovVlKPZPgJ5UDRMFjqBf0f2
 RCkwJNudgifPw12UqBwtp9oYXD9Q2ZwW+sM+So+Q6RllhBnWkCKb519o3Miv8qsRto9G
 INEInwRIhp5pMZWmhsq7yMXfabfGnIAU2pMba1je/XRaQwNY2zkLLo0MOu8M2MNWSSXP
 EfheAAk5yqIf6yisq3Ys505vgmstPhTAekXUjpngUdPRtGmIjt3lwct4PaXAOJYPf8Oo
 lCgg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX7C9JN6MeiwQazYrObfBtHXssi+TCokMA+dH1mxteoMqCOcvLFYxD8wFfPk+UCUVzRDyUv4XWCLaTn@nongnu.org
X-Gm-Message-State: AOJu0YxtyU9nlFJLvQTxqwCn0NFMRNYTpGeHgEcR8ferACM7i9Je6cQ7
 tmwoMulwNx1y27YhDbv2QjLSUGGLohS9KPJv/ev919FKp5jDvplr2D3o2CC/JJMptJI=
X-Gm-Gg: ASbGncvjCtesYcuGFkSUJSZsgRAsNZSB0C1PbkrePEwekoaGkAjFPe1pCqfk4WD7TQ+
 pAjAArmP9dhzPr2PazaNRNN8eun7psKOxhhmKeaad8EEKnDboAIP2dE4RwsUlxZB/d3okEpkTIr
 g7a8RyrkWY4QNhe+EJJYLpJ0VhPfg4qFvf6q4ZWILWQooGzvIUwmzn8x581ghrvjfbKCdNyXd7D
 MRa9JYT6luvCBHc/MobE58zfuA3RIBb3qoxYtm28+futCtVqr8HHlLT+Wrdql3FxrMX3iJJHlwe
 s6BvrVMDBa2uTU/EJ8/mnRP2ReYy6lS44g2enfU2MBn/xhAuzISPlwx4Ph87gXoR8cI9jl+Ru4Q
 YbIl9ZOR42hoQuQ1pfaP5zbrTCAfCVpvZdTUVs+e+ZTvMV+Y7j7ygYm0geIcaeCtVqw==
X-Google-Smtp-Source: AGHT+IFtmM7htQA5yERqYXVxbcEpTD67OGTPQcqNXs9RVUxb2VZGUbvWxePY/oFwZiTBXVpElhu3nA==
X-Received: by 2002:a5d:4086:0:b0:3b7:8b5e:831d with SMTP id
 ffacd0b85a97d-3b78b5e85a5mr803923f8f.17.1753699493479; 
 Mon, 28 Jul 2025 03:44:53 -0700 (PDT)
Received: from [192.168.69.209] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4586ec79441sm112486465e9.2.2025.07.28.03.44.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Jul 2025 03:44:51 -0700 (PDT)
Message-ID: <d01be1f3-bb30-4ed5-b935-e9fc74d1ec2e@linaro.org>
Date: Mon, 28 Jul 2025 12:44:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: remove myself as ppc maintainer/reviewer
To: Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, clg@redhat.com
References: <20250724123416.3115941-1-danielhb413@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250724123416.3115941-1-danielhb413@gmail.com>
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

On 24/7/25 14:34, Daniel Henrique Barboza wrote:
> It has been awhile since I actively did anything for qemu-ppc aside from
> reading the qemu-ppc inbox a couple of times each month. It's not enough
> to justify a reviewer role, let alone being a maintainer.
> 
> Given that we're doing qemu-ppc maintainership changes across the board
> I'll take the opportunity and remove myself from the premises too. Feel
> free to reach out with questions about code I did in the past, but at
> this moment I'm no longer able to keep up with qemu-ppc activities.
> 
> Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
> ---
>   MAINTAINERS | 3 ---
>   1 file changed, 3 deletions(-)

Thanks for your help with PPC Daniel!

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


