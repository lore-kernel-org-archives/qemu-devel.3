Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D4A0CAC59A
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Sep 2025 16:02:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyubc-0004tp-DU; Wed, 17 Sep 2025 12:02:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uyuba-0004rr-Fy
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 12:02:02 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uyubY-0007XF-NZ
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 12:02:02 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-b4e84a61055so4562069a12.0
 for <qemu-devel@nongnu.org>; Wed, 17 Sep 2025 09:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758124918; x=1758729718; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZZDmunlvUXfYoPx+TjhOyIN7WODU3fkgILedlMP8VxY=;
 b=NsTNUuiwEnCY9i62Q+7NjUz4WVVELLZK8ToEFKBO2BjUibbM1lQm391vNB4YsnXn9z
 QFHespZVqnkqQB5JJPIfXcekVLc9bSY7WaD76J2czWc4ABUfZ4w3L/HpEJ9uOoiReht1
 TRfan0nmHecg9oCnrYG1H+boRp9xoMwIUw+Cy0Tdzanyn655wYHUnhtxFjl5gF8Mk1I8
 wiE78aO0cNt4RjnYFpF8PVc+d2UEjH7nQDdLpJdt/+PKGjn8u0zu8CRNhMK6cyagNwjl
 +zflCKpaAsuoMjbGTVH0OBlTk8VvBdR3r6+0DWKJgO33eqwb2V8hz0aGYHftiNMnzbD0
 6Gew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758124918; x=1758729718;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZZDmunlvUXfYoPx+TjhOyIN7WODU3fkgILedlMP8VxY=;
 b=F98OvHGTy8AeFq1YYhDbbZsW1yQq1vo8PXa4sxWWCZLK61CuYMIMBdgty/kGAmKi9/
 0UP9FYEycyKMKuaqWqkkppBQPHHFxz87Y34JRMRlRWCXnU8JJfNfZCUGRvTNstEWhNRU
 edyiZID9HjvFNYTXmOgInCRN3Zrnhd/pcWS1KHbNSEF66zf6FQ6NA1wW+fCch4EiToWr
 g7buFlQQhxaxC5XIN/2qtzyKdvwnw5QTZ0yxb6qoT0Rc443TESdVKrA9b1xaMsuGRusE
 Q2WxaGDhFaaO7U5Me+cNqM8PTXgEHHzdhdWqLdOcYq5/HmX+xSqNo04njDtV6lar45Yl
 +tYw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUSH3ES2UQO/b8DNAr3TicLdvNlDiXeDrDBJuqJ2fCz8EnbrL0CCL8BqMKDiV2QoMqPghyUuBBo0/6z@nongnu.org
X-Gm-Message-State: AOJu0YwxhJYwakYeP7NP16WEhgxfd3P8JZN2yVghFLaes08buWfxVJYC
 C7WqCysPadXnbO/iNnhe72/Uv6dfXApJGQP9UVvfadDeJ6pLl4UXrJTl2gQCrIgVmK4CSxfa3Ly
 v/trW
X-Gm-Gg: ASbGncs4D3PgRPGXnKNdLQRb8deQpgJLtBEi/rYDqgvI0Y7hrrmM5SWC6DzgmvAbfoz
 w77ae9p3tP6IryiZ7+KI+LABKDrWKlBPYVFd2gHh4emOWGJzW2uvmjhA7cJ0CgpyIHwzk15aGjX
 EupiRmKDrhIXdqwW7ZgxPg/pJ/u5v2A0pXzNYKuIH5ix6rQpH+SxKAZClV2lGyVRTQbIqJPZD/x
 Ezj/LprJcEN5H7zWx5AVhzDp8sHtIuEpQLKN2h2Bcd3rQSt4jxMS9YCpAa6lr8SdZsf8QnyBnDl
 JL1IIAIQmWxyLHUogdLhVccePfVTy/zQz1cuDYT7W2CxwKSH/MA5pbYIXWBDsz2Hov5Zfd+mxgZ
 XKEkhPdBh2ahibY9Em1SNrjoutlldHPglJ1D3
X-Google-Smtp-Source: AGHT+IG7jopirO7rwPJh5cEbcYQlzbmcgc/qd7VLJ0+e7BM0GzXLZ9jRLzsLYfErWQd4JhybuMEIgQ==
X-Received: by 2002:a17:903:1b25:b0:266:d648:bf53 with SMTP id
 d9443c01a7336-268119b832bmr35331995ad.7.1758124918232; 
 Wed, 17 Sep 2025 09:01:58 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-269800541adsm62735ad.4.2025.09.17.09.01.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Sep 2025 09:01:57 -0700 (PDT)
Message-ID: <a392927d-74cb-4005-95f6-6e7fa1eaae1b@linaro.org>
Date: Wed, 17 Sep 2025 09:01:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 35/35] memory: Drop non-QOM AddressSpace support
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org
References: <20250917-qom-v1-0-7262db7b0a84@rsg.ci.i.u-tokyo.ac.jp>
 <20250917-qom-v1-35-7262db7b0a84@rsg.ci.i.u-tokyo.ac.jp>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250917-qom-v1-35-7262db7b0a84@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x535.google.com
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

On 9/17/25 05:56, Akihiko Odaki wrote:
> Now all AddressSpace instances are converted to QOM so drop
> non-QOM AddressSpace support.
> 
> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> ---
>   include/system/memory.h | 13 -------------
>   system/memory.c         | 26 +++++---------------------
>   2 files changed, 5 insertions(+), 34 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

