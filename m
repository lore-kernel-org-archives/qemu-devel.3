Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60B12C982DA
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2026 22:35:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8Q7R-0002s3-Qz; Sun, 20 Sep 2026 18:34:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x8Q7K-0002p3-Vu
 for qemu-devel@nongnu.org; Sun, 20 Sep 2026 18:34:39 -0400
Received: from mail-pj2-x11.google.com ([2607:f8b0:4864:39::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x8Q7I-0006QE-QB
 for qemu-devel@nongnu.org; Sun, 20 Sep 2026 18:34:38 -0400
Received: by mail-pj2-x11.google.com with SMTP id
 d9443c01a7336-2d747f05ffdso16977115ad.1
 for <qemu-devel@nongnu.org>; Sun, 20 Sep 2026 15:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789943675; x=1790548475; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=tHOkF4MkIIPtDg4jsEvkT2pptne2AyfaSmpdK12a1qI=;
 b=ujRvcVFGyDr09nfml2tIorHG2woRpE3a2on/7Y2zOfqGN2IFhRQR98OT/2A1QOYVDk
 hVTUbkHc+TA42fgvMjU0gSMj6+Jup+HodK52z39JHa3U4aPdrFkgVWBWadf04Cf9UqGP
 R4WbCKKWUSEZKnXs7ozgnxsifUzJ0+W9rWZDYf0gT61ljwDvCxRf23B48slUslIbe+gp
 GoFEOJ8/NZDT3Lzghbh4R7gtO18HcMrbiRWkP5NCiqOamSth7O+a7b6GuXxhSBJ0XB0s
 N6p6UHY/djvLUC/mnXIl7TH/E+wvrKJgODTj2Y1oYSQonvVEYXsfKSHVqAuZeiOzsyop
 TgTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789943675; x=1790548475;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tHOkF4MkIIPtDg4jsEvkT2pptne2AyfaSmpdK12a1qI=;
 b=rkHcyqrQyOhL+jsWCMPXhqjSspwOyx06J+Ki8lv/vxmMlT4M7t4pEBl5t1UuxOIr8E
 5qNo7QkQLJ+EtkbMsfuFQS1MeXzulNeWzNpYyWKexAIaR1HCr6BNxzAaYcbbnthEbFF4
 j1M3NCEfq1uIkw9wVQmmA3eVuZ8j4mpKdOIva5lt+4mme3kkDy9ED6uQs59UUz1ZupZg
 kJ4JCdbSJ0Xh3I97N6y3dA55leddk7RURGIqJg86sGXcsBBIzgTnPKD8eBnAlGDKKQgq
 ADH4mLUmhC/9OWRmeIw+VwMeVTkKHScUlUVn2KBXz8xHB7OGPB0N0z5008bjk6nqWoNk
 UKHg==
X-Forwarded-Encrypted: i=1;
 AKwUvByq2sBhX/F9niyTd/nY5LzoKak40g7RaCTMDJ2CXrwLO+1ud8r7YbqiQkYZXfRf2kCqEk2ziw6oL7yX@nongnu.org
X-Gm-Message-State: AFuF++nHCRbaF1cVrwp+dJb+lV/2I8Y9oYcVJ67rD1Qkd/e3AR76pN/4
 1Q3ju2ACFYKOgz8p4bxMswMLwmDH3ttqLoJjwZgbdaxN3Q1k4e+qevldgPT8gmH1/HU=
X-Gm-Gg: AYBFou0t1ZJOw2CeFu0CjKS3cyEGIqNMNweVomSoD4L21yMckj2ee33YJ73XzT6dRo4
 txIfckhmKsDWjXnfq2pWzKt6Krv0dZvPqAUZJBl8/EVKtcduTnbDSInV/jWMz3BcDDHqHeZbn73
 lqBdj/ndMFUO1GbY9JIUWkVoi4DQfM3i1r0eeJEmJ40g2fvfxwZ6TDps5e9Q3EU5YyOiRJpY0wd
 Ytw5tMgKeBDGnJuNSL7Pv00uJW7kyk80tiNjPuR8/28Id/pBWiylM2duQD4u6TZ/LFrWW11VgOn
 HGewuP+DDaZtIA8qFneSOH4ZqWAV5IOx0mgBTIOJgiSM7HnKf+ht+IvHCb0LCNu1SqMPeAFHK0A
 NvGDjUMrugBh6S8P309xd9LkdDYbEDqLmHyqHIC5tARJtfa4+7ua2TVw1NVNtR1UzBqaOxZ4+aW
 mB5jbh9cuS7z1SydQizH09tegpX/JLPOR5LQsqVR0lBvvwCV7v/qTzRxFeWFyF3+ULeGk6tXaeT
 hmEAVjuihOdEDkEsLBlCWxD+dRARge1wF5K+Ctv/ICIWpzhbdonRxpffJcdKjQ=
X-Received: by 2002:a17:90b:1c88:b0:39e:6c6a:209c with SMTP id
 98e67ed59e1d1-39e6c6a2322mr8220474a91.61.1789943675321; 
 Sun, 20 Sep 2026 15:34:35 -0700 (PDT)
Received: from ?IPV6:2603:800c:7900:ed00:e836:65a9:3e76:872e?
 ([2603:800c:7900:ed00:e836:65a9:3e76:872e])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-144da432647sm22649880c88.5.2026.09.20.15.34.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 20 Sep 2026 15:34:34 -0700 (PDT)
Message-ID: <e9d99c1b-5722-48be-9393-3747de189be7@linaro.org>
Date: Sun, 20 Sep 2026 12:34:32 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/14] bsd-user: Remove host-os.h
To: Warner Losh <imp@bsdimp.com>, qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>
References: <20260919-misc-2025q4-v1-0-ebfa61049bd7@bsdimp.com>
 <20260919-misc-2025q4-v1-14-ebfa61049bd7@bsdimp.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260919-misc-2025q4-v1-14-ebfa61049bd7@bsdimp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::11;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 9/19/26 19:20, Warner Losh wrote:
> host-os.h was used to just set the default bsd flavor, but it's no
> longer used. Retire it.
> 
> Signed-off-by: Warner Losh<imp@bsdimp.com>
> ---
>   bsd-user/freebsd/host-os.h | 25 -------------------------
>   bsd-user/main.c            |  2 --
>   2 files changed, 27 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

