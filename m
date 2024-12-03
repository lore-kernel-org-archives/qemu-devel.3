Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06592E64ABB
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 15:42:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIV2V-0008Uy-MR; Tue, 03 Dec 2024 10:42:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tIV2L-0008US-NE
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 10:42:06 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tIV2K-0001PJ-Cb
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 10:42:05 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-385e3621518so2779361f8f.1
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 07:42:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733240522; x=1733845322; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sFyp1eGfY2hanT5c5Sc4NgG3FhTDlNkm0Oajfp97nao=;
 b=N6/qoGxxsNdHA4uWnOJK8Q3wt6ZHdOHpzaYYqQUthHw+UgBsSt/DOe+AGENc/ZK8tf
 tyABY9PTSUT+mk/5NbGPFcmWYY2b66FPivdmjTHR8qcU/79sUefp9G46qqutbFQhGT5m
 gK7y1Znb2wo+oUwJJaQFZheosHSCRuxworM31dk/y+b1UQy4Yez3qnmZF92uG/qk8PA7
 cV215w9A6WP5xZ5TUWzKbNhXuhBxANO7/40re+o7PRaHhF8tWxNgJPIbEai07Tggm8+a
 vVwclRm9s3JsDdZBY1RkGUBI+hZbhLE75hFf7YixCHNVMh+czZS6FGhOirk0DJTFtg7R
 kQag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733240522; x=1733845322;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sFyp1eGfY2hanT5c5Sc4NgG3FhTDlNkm0Oajfp97nao=;
 b=aKnDNQCS8+NfKyTkHTrbpPxaKUYC/bKypxv6NKmrDKw0mdfUCZ9fbdlWvjFBQMQ2ep
 YTDhGtEBO5X0A/cwdTF4+Yq8xpZ2P7C07WvSZSUKuWK8JThQlxTGf1itX+qmZy5JPOgx
 X/Ycqr59qpA87Zfl/f07KSYCxPE8fzIwUJ7sluoUNNU5Jl8Ziv2nNA14INXxgywyPw2Q
 FxLI9FFGCcmnHXglC3hPsDHoM40oYuaYn1f0g029Kz+hiOoL9jZ38CDzduHcMChkNAHW
 1vraMy5tW8Q9BRaYHkjiiLOMTrJZ9TYYXDfrncS3/JWXuxDmWbegtmeeWGGOuGlFOQjq
 W/9g==
X-Gm-Message-State: AOJu0YzJ7J0MH6Wx6QEvQyiktQiyrSGGp/WpJZABvBFHhSXfY+pVVS2G
 gQeo3iKoUIIl17/w4Cd5lb5/KYH+apute65GBNLAHU1QOjOGzzY+hZOUYqiftH8=
X-Gm-Gg: ASbGncvVskmervyp/XXbPKisDHwCIyOuK/hZJMybzHq3FXMBEKCdsTMjWb8ZU6lTfXs
 ttOD0lL/rU71GyfPN1aRF02fJpsUf3qIDlGjmDX3umtYyJgaShrenuq0mMT082HtZeqZrTp7ROg
 t8Isj8mjNC/eBrDnWndW8DUqCsDdCl3ntUtDRtybufdjzSRw+Qi2BuqBlK78EoeGhRZuyL528kw
 J2P0XEFZErmmQ9aIdEMqNxtyH9Je5ChzA/cRI3SI2xo6Twisg1gYky3nPcC2thH0w==
X-Google-Smtp-Source: AGHT+IHWlrirI9Xp7fDkF4Pc9VhGeB0RrAPTNHUxUAxPGkhp5nggDE1rHO+dd4vnFP7f6sNvd/vm+w==
X-Received: by 2002:a05:6000:4024:b0:385:f349:ffdf with SMTP id
 ffacd0b85a97d-385fd53ee1bmr2340699f8f.45.1733240522381; 
 Tue, 03 Dec 2024 07:42:02 -0800 (PST)
Received: from [192.168.69.223] ([176.187.209.146])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385fa330ca0sm3623517f8f.11.2024.12.03.07.42.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Dec 2024 07:42:01 -0800 (PST)
Message-ID: <ed9c627a-f781-4988-91be-5c41ab2b4437@linaro.org>
Date: Tue, 3 Dec 2024 16:42:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: add myself as the maintainer for LoongArch
 VirtMachine
To: Bibo Mao <maobibo@loongson.cn>, Thomas Huth <thuth@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org
References: <20241112073714.1953481-1-maobibo@loongson.cn>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241112073714.1953481-1-maobibo@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

On 12/11/24 08:37, Bibo Mao wrote:
> Song Gao is will be sick leave for a long time, I apply for maintainer
> for LoongArch VirtMachien during this period, LoongArch TCG keeps unchanged
> since I am not familiar with it. The maintainer duty will transfer to him
> after he comes back to work.
> 
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>   MAINTAINERS | 1 +
>   1 file changed, 1 insertion(+)

Patch queued, thanks.

