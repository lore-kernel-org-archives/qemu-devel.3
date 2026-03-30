Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D8E71061B15
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 18:10:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7H3w-000509-11; Mon, 30 Mar 2026 14:10:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7H3R-0004tt-Nu
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 14:09:40 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7H3P-0002Uk-MQ
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 14:09:37 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-43b949bf4easo2782792f8f.0
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2026 11:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774894173; x=1775498973; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kKhsamchR/ffB/aYYhevOtJn/yKx061VmVI0QpKthlU=;
 b=XEl3axPLDPlwqj4d+dbkp6CRnIg00wJ07lNQ/gSE+PfImz+0qVXZHf5Qjxgxr+xYdZ
 WJwuy9nw7wwRu1pfW5cjo6kquXAcQXFr98Z4anJDrGy1LNmZICYIz7yi8Btr41QgMUld
 u12IECaZc+UoPqTsFgWfQZqUR4oOsXBi94nCZ11WbE9S9fHPbiAPySYZsepJD1yaukyB
 CuO77lXqgpmVrNND0iGJ/S7icvTiOVtngoLVavtku9VffzkLjLBdeLSlP5zUslqp/EoX
 ZfYXkJZu4IXceA1u+kFgKuyeZvFslfAxd0LsqKw68Ikn4MlOJBhOPpicCq9DV9gR7TVd
 jQKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774894173; x=1775498973;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kKhsamchR/ffB/aYYhevOtJn/yKx061VmVI0QpKthlU=;
 b=KVxrUYlk6G7WzCQ0wr6vCTu1l5BKwA31O0qM/FiOPa60m4yY9umRy7jWCVxmvAWwub
 gA0jaKkcTrjOuHuw4049q+Nu97yXNIwmTEcm9u9Sw1wqmZCVfuZ10/iYwr92N7yNfyzT
 uEA0VK/g9eYGI9UgsQVOmnuyBkIqgDER/NqlUaRz1MphDdxGLJfVVLE2j51v/b1x/fPQ
 L24Dvhfh5uCReWzy7BMTqAdqOiScb8n3V1BuIEoU8cMMxpZS98eXCO9oZm7Zsb5DVwLL
 sVuGmPFEfVcpYPGtHsdv+4hndKTTMjgm/3Itw8cxZSIrO7LdmcDMhewVjJJeImINQPcm
 Bz6Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVigtN1pQfYSSGZta5sXQ6nKAIHkLKDbZwv+z5iltdiEI+lx+xoiQ44HLrUVhVx/aPSzeLAWN1DX+BU@nongnu.org
X-Gm-Message-State: AOJu0YznefoM8RaL6+fB9ATsP1bfp7PqYfXYmNMIGALl62v1a2toLPep
 QaVW4Ppiactp8zAGijqYH5jZLOztttTaHcjeU1Xv9z15LaMKEupaVypsF1DSOjSRRKs=
X-Gm-Gg: ATEYQzz97Qp7gXL+U36Nk3ln88jsNYJvO0xn00huFv9mlGnTc5zaiIjNluFNeB1b9bs
 HLj8prQO+lxWrZQwokVpo/xowSmX+HEgXVCYlhRpGaAh93nZMoPz/vzYJr/KFuOpG+1uu+7+94s
 zfh5pPLP0mKh3DtY6xwoKYaaBOF+B6zwbIJnaNGJrVnTyinmc0Gkay76I8SG1eda3qlg+Vl0474
 tbi2fOym4+NWYf8zkQ8LfiHjK1qhq6Cpr84K+gPR2xUhqN3sCWBX6i8IRpmPfuIfijoiDy/1GeT
 87po4Wwj2nU3zd5z36wQ7GMW5iHjjY9i4WvBiPUS0CWHOYzVQUOadQfCuH+67ZbilaupHns9wBc
 ucrjJt+4payFzGEiMBN4G6bQB7zYpGF/QwfgG1+WsIzUG3MiU5f24aZj+mS0nUlbpsCQeU8HDAr
 R24ktZT+epFhLV2oJr2eQB4B8++cCnVQWck4J0BEaFDB/gN+ggc2QDauT+w95xYkbrQg==
X-Received: by 2002:a05:6000:18a1:b0:43c:f5d0:4f6a with SMTP id
 ffacd0b85a97d-43d0820be28mr950768f8f.21.1774894172880; 
 Mon, 30 Mar 2026 11:09:32 -0700 (PDT)
Received: from [10.193.39.66] (246.148.216.82.rev.sfr.net. [82.216.148.246])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43cf21ebef9sm21594523f8f.13.2026.03.30.11.09.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Mar 2026 11:09:32 -0700 (PDT)
Message-ID: <bdf00031-f778-412a-95a6-005bf855ab56@linaro.org>
Date: Mon, 30 Mar 2026 20:09:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 04/12] target/arm/tcg/translate.h: remove TARGET_AARCH64
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, jim.macarthur@linaro.org
References: <20260327165042.604105-1-pierrick.bouvier@linaro.org>
 <20260327165042.604105-5-pierrick.bouvier@linaro.org>
 <adafed36-b654-4176-a519-f6742c4eaba8@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <adafed36-b654-4176-a519-f6742c4eaba8@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

On 30/3/26 03:06, Richard Henderson wrote:
> On 3/28/26 02:50, Pierrick Bouvier wrote:
>> We need to stub a64_translate_init and gen_a64_update_pc.
>> At this point, we don't need to do anything for aarch64_translator_ops
>> since it's just an external symbol.
>>
>> We can now include target/arm/tcg/translate.h from common code, since
>> all target specific bits have been removed, or can be specialized with
>> specific defines.
>>
>> Signed-off-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
>> ---
>>   target/arm/tcg/translate.h | 10 ----------
>>   target/arm/tcg/stubs32.c   | 17 +++++++++++++++++
>>   target/arm/tcg/meson.build |  1 +
>>   3 files changed, 18 insertions(+), 10 deletions(-)
>>   create mode 100644 target/arm/tcg/stubs32.c
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> 
> t~

o_O

