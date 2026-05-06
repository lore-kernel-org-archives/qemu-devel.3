Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 383A4CD3436
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 09:10:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKYGq-0003li-UM; Wed, 06 May 2026 05:10:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKYGp-0003lE-10
 for qemu-devel@nongnu.org; Wed, 06 May 2026 05:10:19 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKYGn-0000u5-FG
 for qemu-devel@nongnu.org; Wed, 06 May 2026 05:10:18 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4891f625344so7283875e9.0
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 02:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778058615; x=1778663415; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=snPqNajal7y6qubnA9pyHb7+O7dHOfLjv5cOqMGADZQ=;
 b=R/VmTEs3M+zm2ibvIxYNarHeTaqERoQTpol1xp7SBcJ7pEQoYTdORsE46BTtR2nY6K
 A2n4aBzZ3uhAmfgHx6Dqq+Vc6SAgiAwenRE40RXEaPsob4ag1kEh9pKy0NMzo2nG6HUZ
 2BzB5h28V1QfuOhEqUo0sGBMLCf/QnudIxR0t7wBNZb/MMZlP9gZT7uiO9lpLLNMuRKX
 9Fm7wo1gkjLIgTmXH7tJ0Fs3jduMe8VdBzbfyh9i6fMk5oQLlFid//3EDvoi4i8dD/ba
 AxF9VA93i4sLkwq4pN6hkhDrSuNBspn0EZjDbYChmsDX4v7xmjhJyTa4gHNvtYG3Fl5i
 5reg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778058615; x=1778663415;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=snPqNajal7y6qubnA9pyHb7+O7dHOfLjv5cOqMGADZQ=;
 b=eDGN5FgdJ4i0qyLA+3L1YFFGDtlJT2wp0DcQ4sn6lSbhZhE26/7zV9cVwYeZhUJnqw
 QsgydNnrLVdBg00j6U7SCc0C5MUvL84SBA4/RRvWBiDBMciofysl6JzR/3tGBaRCSSWD
 Ysg1hTZKcBB9mabT/CPsRjDoq4KuOV/rD7ZGl32Q7pxgj8BurFfvH0QCT4ltP9LQ/zX8
 MAnxGKa36WVcNTeHmLV0eifufawtyh5uQ6iWAGojeCTO1Lo3Xoiy3z6oo2u0Mq3Axkhv
 4AUjSanZ1kv3WqztHoQ1kC1Rv9XgKubc9kWlL/6DVKVeVzxJmH8m5LD8WYEKlaxah3Fx
 xSRQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ93ngaMFY6iYx6ca9LEeWmf6hQjlMFViOTH+QyAvJRFgZSQLoA243vZ0Igd+oNEeghL2tuuFyAByVsU@nongnu.org
X-Gm-Message-State: AOJu0YxEddkq/2CNM9Vu9CftziCdBOrgiH5PWEanJPCEW3XdDauPgvHB
 8yRmQrt0uI/3zSCdHoep8gWbKMQzKLaTlJ75+jvEO97s+nN1c90+w1zfpLwvnPa7Dhc=
X-Gm-Gg: AeBDieu6+qF3gTI7uS7WbpJ5zxD4HMghrqQdvSSBFoll89YfUTd/bJhvK43tE+1rHLQ
 BUOuXiZkeuGu+EQxE9zX8ykKO/tEishV1GyLpf7b3wmdjLAu6eRv3fnlYNjDVH5yQaPaZHJyzEl
 /MkfKa/CpbsJuD7F6tj46n2epx+zF/8OqChEMAGDmVBFRJoaohGfXG6Rj+rDZz/cDD6GuzN6u7q
 xil8MvvzOpX87nV22WMIvw/maXaDSbT42PGPVbH2QG6gZ3ASaG7SzAHEnRxMeKYO/tuJQOZHaZS
 Xp7tGn5nhDIxAaKfJqcNESkojGqrNnNdBqbVY6Q+Fe9fkYYcVobKqION7c9FR/pXCShbiq5DhXr
 DNlqaixsFeFUJj98RV02gJqme2y8bAdjIaVVmQbETAbvqzZrqvaGtrE8VWh54rdXoya1Yg7aI1q
 ecLl4IjXfewq/Sr5CiQMezOZlGPRyRYaUAa/5zFTPjZLmNWFxPjXqUM3R2gylo0tDsUJmpwVoMB
 uNepr5pFJemYKE=
X-Received: by 2002:a05:600c:5747:b0:488:fbf6:ea59 with SMTP id
 5b1f17b1804b1-48d142654f9mr89061925e9.12.1778058615263; 
 Wed, 06 May 2026 02:10:15 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45054b02802sm11036870f8f.17.2026.05.06.02.10.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 May 2026 02:10:14 -0700 (PDT)
Message-ID: <7e37497a-212c-449d-9a12-cba93d7d48e7@linaro.org>
Date: Wed, 6 May 2026 11:10:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] hw/usb/hcd-ehci: Rename migration compatibility
 fetch address fields
Content-Language: en-US
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 "peterx@redhat.com" <peterx@redhat.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>, "farosas@suse.de" <farosas@suse.de>,
 "flwu@google.com" <flwu@google.com>,
 "nabihestefan@google.com" <nabihestefan@google.com>
References: <20260506032643.2510575-1-jamin_lin@aspeedtech.com>
 <20260506032643.2510575-2-jamin_lin@aspeedtech.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260506032643.2510575-2-jamin_lin@aspeedtech.com>
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 6/5/26 05:26, Jamin Lin wrote:
> Rename the 32-bit fetch address migration helper fields to make
> their purpose clearer.
> 
> These fields are only used for migration compatibility with older
> machine types that transfer 32-bit fetch addresses in the migration
> stream. They are not runtime fetch address state.
> 
> Also add comments to clarify the relationship between the migration
> compatibility fields and the runtime 64-bit fetch address fields.
> 
> No functional change.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   hw/usb/hcd-ehci.h | 17 ++++++++++++++---
>   hw/usb/hcd-ehci.c | 12 ++++++------
>   2 files changed, 20 insertions(+), 9 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

