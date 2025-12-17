Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CEE1D65C5B
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Dec 2025 15:00:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVt0G-0007n2-3R; Wed, 17 Dec 2025 09:59:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vVt0E-0007mX-HE
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 09:59:46 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vVt0C-0004MW-Uk
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 09:59:46 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-477619f8ae5so45480925e9.3
 for <qemu-devel@nongnu.org>; Wed, 17 Dec 2025 06:59:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765983583; x=1766588383; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AqKdSwcE05MCSufPJevBhc2ZgSmGh9pj74NarAyxQ8k=;
 b=SIIdDXPqFxGE+pnAveJXiANyeFW499NHfuGg6B0ou1P4gxDaW0K8b9+NgsArUPUBQM
 PG+XnfQJsRh5Mo+/HQ9ffmDZAjLCF0P8XfLyD5qMqBnHkBeLfG6mdMZKcAc+CvdtLXKd
 74UK+hdy6syz4FwLhUpVAbOruKCQHHEMeGPwwpRYrwrKobFiwt1Xes/Fo94ai7gJVBC4
 xNHz1EHfdbDUsasEAKiM3MIxb/nsQU+vepXlsqTNavcTi/wz5TmMpXwfOUrfLH3iyxjy
 YbH7l/+yEi0Z7Y52fQc3wWXiLuy5OTpCf9GrL9ie9v6EHgmAe04YTJEPS9nTTfExXwm4
 SxwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765983583; x=1766588383;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AqKdSwcE05MCSufPJevBhc2ZgSmGh9pj74NarAyxQ8k=;
 b=eLB8GAD9Dcn2ZxZ5kpVfescx0XmRiQyKdnHZy/c3hhIxzxp3217MWVaUGDGR8ErnOG
 4cjbDiWN1b/vjt0y5q+NwS3KTXZevffq6a1n3bZXU+dSA7KjZgFa7cAbn+dcWtxdjL3m
 Pk2W12WHbiURxrrXT+C8HpwqzMuZNV5NSRusnNk2kLc7tsd59oLDoIMCyGVJlQRK9rVK
 9BrFmKgA2QhP07ctjsQ/dc/RTt5Br2abr133ikbAYvm1GxpgYvuy1LZ+mmOl6DY3l2x+
 lamoT5nqWXdnDbu0ItasCXVn8Q+oVHFXtnFQzEY522WnQhBjeKFJdUlU5YKDrwwAStea
 YgsA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXyZON2RpCXA40efRAUpnnLbUx9VDsNpe1zOuZ93Z96ZXINEEHFAjm18BWd/Uw9ksnEOxyh+T9hiWre@nongnu.org
X-Gm-Message-State: AOJu0YzTq9/f6Th7O4IgCtObGDHwTE/2C91FDeGN8AI5qt4cLrTxISRj
 73Q1ckSsS3hmD8BmcxY+wa4Z4gNyM1GGOQbWO4rBgT2HDiJE1SIn2NJwWJzZ3kJHSLv3QCyf69t
 DH+FUJeJgZQ==
X-Gm-Gg: AY/fxX7UTHMz1942P1tJ1oMRmgO/HaUnwlfKfZUsMgtpCOf5+0w+ku/48M0KnhZUBtW
 x/QiffrF81VQqvzPcgN9flPxqdZzjLl3TuUKm9H1DrXA+8HRYFFTJkZKyh1DmU8rbCvMeBK1FAH
 p31ZALUpODlZAXBqZJpgYLzbmkFQ1kznUubfZoQewlb4tDZ/KbdTiIJyyBiCo+/iSHOu1NgJdeB
 sr5audAYrFxvqPF5tK8fzPe+PHp79bohE9dRkxXqD3dFje3PA/zD3BIaovGrWSLX6n92KJ+PP4u
 njGRHGp/Y+hG9uG5GwSW5PCXgEUavyLlD9sDAbGejXyzwuk4Z/Uy2QkDg9JjAKH76XowgpOFuac
 n/S7zDsRGPjO69ZfJOi0O5BeTkRLnl47uvEZTagy4kHYjLXfxs0NhTznEXInL9F3XFc1vPKU7WA
 LqR8KW48n5wp38EWlvsZhqZoHl+JMf9xxVqxSayvB4QYJv9/QsdJYpkg==
X-Google-Smtp-Source: AGHT+IE/x7QTV9F6uNBJtYJJnbqQhRBUscLeeibZBuP7hwNVu51jLzxSfWPIiIHQC14hZuhuM5WfBA==
X-Received: by 2002:a05:600c:3e06:b0:471:786:94d3 with SMTP id
 5b1f17b1804b1-47a8f907f13mr149672895e9.22.1765983583207; 
 Wed, 17 Dec 2025 06:59:43 -0800 (PST)
Received: from [192.168.69.202] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47bdc1cb6a8sm40679515e9.2.2025.12.17.06.59.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Dec 2025 06:59:42 -0800 (PST)
Message-ID: <3c5328f2-f8e7-4154-bab5-e80f46306aae@linaro.org>
Date: Wed, 17 Dec 2025 15:59:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/char/cmsdk-apb-uart.c: log guest_errors for r/w to
 disabled uart
Content-Language: en-US
To: julia <midnight@trainwit.ch>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org
References: <20251217-cmsdk-uart-disabled-warning2-v1-1-847de48840bc@trainwit.ch>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251217-cmsdk-uart-disabled-warning2-v1-1-847de48840bc@trainwit.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

Hi Julia,

On 17/12/25 08:10, julia wrote:
> I don't want to admit how many hours I spent trying to figure out why
> nothing was being printed (as the enable-ing code hadn't yet run,
> even thought it existed).

You are not alone, few of us have been there too :/

This is why I added this commit for the PL011:
https://gitlab.com/qemu-project/qemu/-/commit/abf2b6a0
but it had to be reverted, see:
https://gitlab.com/qemu-project/qemu/-/commit/5b14454d

> 
> Signed-off-by: julia <midnight@trainwit.ch>
> ---
>   hw/char/cmsdk-apb-uart.c | 8 ++++++++
>   1 file changed, 8 insertions(+)

Anyway for your patch:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Regards,

Phil.

