Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 439B5E83040
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 03:23:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vn706-0000rT-PQ; Mon, 02 Feb 2026 22:22:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vn701-0000qX-G4
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 22:22:46 -0500
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vn6zz-0001yx-Ua
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 22:22:45 -0500
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-8230c2d3128so2740586b3a.0
 for <qemu-devel@nongnu.org>; Mon, 02 Feb 2026 19:22:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770088962; x=1770693762; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7tEujU2jd2apFY7pqHGMuuQHSmW7OYpmY+BZ1+J4E8g=;
 b=Y1Gn3QRRIOcIWvip61esMOfsnT8Xp9IOuIzDjPkOE/bP1PHQ3INIpY33UNkZ8JWtGg
 PfeydUu3vXt0nxCmQCwgswqsusbal5APz9XRhrCWRDbjUaCRk++g8IJI3gm9uO5QClu5
 TyAiQ6TcpH8U4Lh/rmer8cadjaJysY4+T+VlP9uA244KdhplbIqMNhHXXF6nTxgjSVLQ
 gUZaq7RUi7G7h8LMjTZX72TijMxU7qPjIyOFCCaAPRaL+jTVGqPa9TIMJ55shZ8b6GHM
 sxJwfsK6aPRF2fboEHgfMxquh61unVKdmE1KKcnFom2qHjkixVrfcZiW8OUZnZBkz85B
 x8Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770088962; x=1770693762;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7tEujU2jd2apFY7pqHGMuuQHSmW7OYpmY+BZ1+J4E8g=;
 b=i85gkFsEaTofFHLb02PUOVZZaF+im7n+eDn4nvvxFr6rN+XoksTECXC7ayD6uzgy5N
 oIEsMJbb7KHdX1OG2It272FZ02xJvZlDSn/N4PCT24E5kgQl4rdNEYNnCgkxnTZ9Uupw
 iywlWQH6hUNrURVDfGfElIJfDKPYuqUgZm2ye2yAMvCZDaVMFjOvWdYOKbfzXTh3//jS
 BuhftCwcrcBmIGq2j92T3Lrt2ib0qU+IJSLw+uEffGip9fPyANtNFN7P1NQ2795caUsN
 MA2mNVfNtuzYPjVQNERpy5bHeeeRuQ5L5phW0ggXasnYWY43tgAXMkCDJizfoiPfuzCb
 s4lQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVbK8AWM7m0eJM7yj41CCDwwH4yQwXbaZDEbillbFetyEfCGZVASWKk5XKeuKjYBe8mfz/6YF16dq8E@nongnu.org
X-Gm-Message-State: AOJu0YzcgK/aX2/+0DHT6w2oeqQOPXERR1zF50uvF/m3B0SMr5lo8R97
 Xp8I8SqQ43haZsxLNMFYpU2pvLIeqOQhFoN+Kx/erDejs7k9zp9KBMjbAibVc+b9FYc=
X-Gm-Gg: AZuq6aK9MJp5TsIUVvDYogQYHel7aYwecLAXUZBXcJXEvjGcpu/MkM9xh3GIJyuijLm
 QV6FRJ/uLjvIJBgImG8WHkzIEVnV0DXWsGKuY4ZMA+CMWSAv2vxRnukpk6mRhBpQLlTl/lcRw5R
 oeMjSWvS+ggfi2W36Ke750FZmifHmsy00gbA6sJuJ56H6z9NftAyLZksDoBLNs1bALbsT1nt+O8
 hlUpmoxyoWEREiTCyZzhY9zVeP9pXm3FeQBZLP6KXx6JLYzeK5+2RgCBJOp7SSzJvX23MKqdBwX
 uzIwjQsVlIGC/W589voS89WsHiBPxgnT3yQqCqdE5gAYCkw7DFJGRN4aDNZGtO4gBCMdo3hMvfT
 I54FczKQP+av+mwq5XCsQRbO6D9Sbn7/OMb5cvIyuhAhD+6DhNYBW/lREUV6tLJjVXO9/bB5oIu
 v2seBtVQDXjHA1dFBJyF2Gah3XD/X6bLchyO0AB46eiQ9Syi/ChMaaP63jCf/4+62cCjPp21iZ
X-Received: by 2002:a05:6a00:3688:b0:81f:17b:c70f with SMTP id
 d2e1a72fcca58-823aa6ea514mr13425740b3a.29.1770088962311; 
 Mon, 02 Feb 2026 19:22:42 -0800 (PST)
Received: from ?IPV6:2401:d002:dc0f:2100:1047:c02f:591b:6a5c?
 ([2401:d002:dc0f:2100:1047:c02f:591b:6a5c])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82379c24083sm17106430b3a.55.2026.02.02.19.22.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Feb 2026 19:22:41 -0800 (PST)
Message-ID: <a84842b6-32aa-48e8-9ea9-9220b98de561@linaro.org>
Date: Tue, 3 Feb 2026 13:22:36 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 13/15] target/arm: Don't squash all ID_AA64ZFR0_EL1
 fields for non-SVE
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20260202133353.2231685-1-peter.maydell@linaro.org>
 <20260202133353.2231685-14-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260202133353.2231685-14-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

On 2/2/26 23:33, Peter Maydell wrote:
> The ID register ID_AA64ZFR0_EL1's fields are not all for SVE
> exclusive features; some are also used to describe SME on an
> SME-only CPU:
> 
> SVE-only fields:
>   * F64MM, F32MM, F16MM, SM4, B16B16, SVEVer
> 
> Fields used for SVE and SME (in some cases there is also a
> field for SME in ID_AA64SMFR0_EL1, but it is just a "present
> or absent" single bit flag and the ZFR0 field then tells you
> what level of support is present):
>   * I8MM, SHA3, BF16, BitPerm, EltPerm, AES
> 
> Currently we zero the whole ID_AA64ZFR0_EL1 register in
> arm_cpu_sve_finalize() if SVE is not present, which wipes also the
> fields we need for SME.  Only clear the fields which are SVE-specific
> here, and clear the rest in arm_cpu_sme_finalize() if we
> have neither SME nor SVE.
> 
> This requires us to update our ID_AA64ZFR0 field definitions
> to match the rev M.a.a Arm ARM, as the F16MM SVE-only field
> is not one we had a definition for previously.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/cpu-features.h |  2 ++
>   target/arm/cpu64.c        | 16 ++++++++++++++--
>   2 files changed, 16 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

