Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DDEFC61DB9
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 22:09:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x04lb-0006kD-7h; Fri, 28 Aug 2026 18:09:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x04la-0006k5-B8
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 18:09:42 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x04lY-0007Ay-Sn
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 18:09:42 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-38ea87caafeso1549581a91.3
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 15:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787954979; x=1788559779; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=KIjzvjpljpM5XiVLGQnGjUr8VZog5bVIyEQmEzlN0cI=;
 b=ErQzpHutXt9iNSzJWwFbz4XIICnfdoEaYX1GPsUBvrQDpa8vxHmdhx+itKPLQe7IoX
 sCWatmyapkKqs7qW1oeistIb7GZ+4dIrTb5TA1rjEnTN/pkl+57+fejd6cu9k/SC409u
 X6NR7mtU3ESauhae9IyxnA0VBXqBGE6md5b0vUyniHAJpxyGY6SzQUnlE3TtQmsgBq24
 uPZS0EyUbw8ijiiG65E79lFkWp1bIsMglqjQdrSZqG8GXYkjBGc/gGl7lCeWn6VupY95
 rd+14WBMIwFbRNKaqaBkP6O5mMuq7urrHKO9Z7TsDDWkQh5U2aO/ZBJ6SrwrIZr3nl+t
 t4mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787954979; x=1788559779;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KIjzvjpljpM5XiVLGQnGjUr8VZog5bVIyEQmEzlN0cI=;
 b=Fg+ypvMSgY7y7eqoBL+uIoPXdXUehLV6FplUN8rSWtpeFqeTMHkpTrsdHMF/TYTsrr
 uPzfTXESzOGrAXqptRVEKNwdjC1XkzUcLZdZAiiXnMp5oN9xDnR7SdixGY3jWbuxEeew
 l2ZyEU2j5E6EXvTae6BkyE0wtebd50JcjLBvz6cH9PBEz7z6hEcajn2c+FmEz/+KSBB5
 LH1t/pC+WhOQeiCL84EhiGPX3P4tI/uZxky+zThW1dsSnzh8SACO6HcfwV1SadzpjQuB
 dw3+1MwGX3i6gwslXzv+vjY8MgjoCzUJ6zJ2ANkXICID+abe+C845cOISeCqKh2CLag+
 tjRg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwmDN3ssGcupLUijJoN5ZLLEIYOZuZMEszzEsBS5Og9FjkI6lVIY50RzmMNAw6yBi4sww7yYMaypIvT@nongnu.org
X-Gm-Message-State: AFuF++nYROuEWK7i92GSNAdRJYzq3WaVMm7hy5NHfkeYyR6mYOgIvTy6
 2KjP9wdJkBCODp+oshm1nsoiJqLTEMJoB4GL1CAREl55iPxzwq7u3Ujf1qmoXDxjMeI=
X-Gm-Gg: AYBFou1u9ZQrDZ7YBUsRNdvLIGU3/5jaWKMy+659//hUPuWq0zI8JZPaaDahcLAy60q
 4lUU6bhJCWPWc5wEg1GGCHSXPWzZpIuZM7E8VZEtfXzWwQ1G4sHZm7LMy2QK0nI+qTYe1xYvt6S
 1T8o6dz46pKYc7H8BP472GhUJBCG0cJS8qSu6XA5t67nKXbIToEJwuDSO/tbt3Xd505OS0ozTcw
 M/3eSwBwb2Zu3lwHCnIL0OEmNmlQAGm3Dxg2qsj51rxTDuHxATnYck93oCCPRUbiLSMfDjmi9kI
 Ouyc26X1MUBljwVU/MMrtH2gAhUbgw/LWPGoZgMLvi/907N2JZI9O9WBYlwuAq4UHgItlmV8OAP
 rqo3xT3y6xXUYdNSB59plDxIXMkrfo0692hP5mwqzimPUNxypjchb9be40Jlo6AFhTCUk/JWZK/
 F5C5uMEQrxfgkupDhngSo/vQsraRcBQBzmfWv3imxVF226zTVLQ9UEhrxzsuei82MCSNiTWMcy5
 WgILXuQCgDNNUkZCfu4xZ2KCAU1jkM=
X-Received: by 2002:a17:90b:4ad2:b0:383:f52b:d616 with SMTP id
 98e67ed59e1d1-396d0fd53afmr15091715a91.10.1787954979336; 
 Fri, 28 Aug 2026 15:09:39 -0700 (PDT)
Received: from [192.168.0.4] (71-212-39-143.tukw.qwest.net. [71.212.39.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-396ddc58f3dsm4233064a91.16.2026.08.28.15.09.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Aug 2026 15:09:38 -0700 (PDT)
Message-ID: <f457a110-2f5d-4749-8985-7cf0f84a0eb3@linaro.org>
Date: Fri, 28 Aug 2026 15:09:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 046/105] tests/tcg/alpha: system tests
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Stafford Horne <shorne@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Bibo Mao <maobibo@loongson.cn>,
 Helge Deller <deller@gmx.de>, Max Filippov <jcmvbkbc@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Song Gao <17746591750@163.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>, Laurent Vivier
 <laurent@vivier.eu>, Nicholas Piggin <npiggin@gmail.com>,
 Aniket Sahu <asahu1x@linux.ibm.com>
References: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
 <20260827221506.91574-47-pierrick.bouvier@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260827221506.91574-47-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1029.google.com
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

On 8/27/26 15:14, Pierrick Bouvier wrote:
> Tested-by: Aniket Sahu<asahu1x@linux.ibm.com>
> Signed-off-by: Pierrick Bouvier<pierrick.bouvier@oss.qualcomm.com>
> ---
>   tests/tcg/alpha/Makefile.softmmu-target | 34 ------------------
>   tests/tcg/alpha/meson.build             |  2 ++
>   tests/tcg/alpha/system/meson.build      | 47 +++++++++++++++++++++++++
>   3 files changed, 49 insertions(+), 34 deletions(-)
>   delete mode 100644 tests/tcg/alpha/Makefile.softmmu-target
>   create mode 100644 tests/tcg/alpha/system/meson.build

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~



