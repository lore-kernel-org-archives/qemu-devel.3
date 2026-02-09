Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 507C1EF070B
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 05:13:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpJa2-0003Cb-8b; Mon, 09 Feb 2026 00:13:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vpJWM-0002Vg-OD
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 00:09:15 -0500
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vpJWL-00085T-3n
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 00:09:14 -0500
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-8217f2ad01eso3395898b3a.2
 for <qemu-devel@nongnu.org>; Sun, 08 Feb 2026 21:09:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770613750; x=1771218550; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=H9/1jawVuRkI1L+N0DjtmxsYJhIanQWdbekURSZOiDw=;
 b=io/ZvgQxqZ8aa+17evMsfHRTNGPV+xqlNxDa4XIY3sJ01mGFFeTxbE+aV3IrjMgHAG
 pAJ8g+qrhVQJBDn1lQFhxL/ZLihJtQoL+m8S4Lk2RybQNYJzMiy5CU39wmaURkS6gysd
 NibvCyBzkdrgU/w66E9Avy4jRjW1huF43l1EAolqAW9EAeeNSyy7fKy2Xcy3eP0OAPJ3
 JE+H9AOu6IFS2aMJMSvK0b3a1rFzlVrpXZLo9dkRrqHeuS0AXsh258Lx5vZQ0cQbNN/u
 dhPOhD3H/jU2WY3Rh3uTQVluXbvBU+vSljzqhZuyjZ/uv3dDT5nUrpy+teqynair/Kft
 yZVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770613750; x=1771218550;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=H9/1jawVuRkI1L+N0DjtmxsYJhIanQWdbekURSZOiDw=;
 b=ifpN5tFeKg/8qCMOJ/wodOCPJwZh94ICz5eJSJsvNjFACYa3L6OE9QNtZAuCVxkv3r
 glnRZblua48d4D5BJ7L29WmLr87WrN+Wp0gOpMDum3l9aqMP9PL29lACF+XbaHevjio3
 OWJwvsByjRmxmZB5RJc4fJCP+9wJckugaM5mAjEt0IMbYbB6DMXwM3piyOFTVB7VDnmc
 724qt6LQ9BLZMtlBzMjWroCJdn70igu/cw/JoS3TxNCweO7aaySDYF+VXBo28G1FkIIp
 Hq1hZ6yK/d9tx/F/B8DWtRngcGrjP5uRXw9CeT+fNv9hP3j2LzHXKgwUlLhJihSgqd4k
 ybTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX7oj9bri/3GjZc4KcsgOfB1hyz+GnGr/7+CyseQ7AfqcqaJQeYOfwbCSA6v5sSQQqQ23fv+k0rGlM+@nongnu.org
X-Gm-Message-State: AOJu0YymLw3t8Ow8obaKQDLsVAUGZabY7WY6i2VSjAcEQCwAUjHNwNK+
 TSSAVsA759wq6zze1rXZ/zpZQ/3+V6j3ax9AJRUoTqrETTjV/ykoCGGBQ92bIQi6kec=
X-Gm-Gg: AZuq6aK0C1rHhUpEQX0a6MVozv+PRHRTMaONpbr4yJOBAIWXbhaOYdj2YfYYNsNFqYS
 H5AhqUcxpA1X603R+DHZgdsrJfTdt53I9CJa3xAJ40RRx0itvTwIfqeOoO8ugPGX0rRBuDfMczQ
 jvvoyLr+HKYSypzIejtx/onafmuqlaFv1WNWObBx00KfU1VoEgnbNSLt39izYgtj1F6ixqbOxsk
 stVTqBQL2o+NhlCgkQaszsGZk+qfhwKhU8U1T/rTkGB2rtjeMIed58AtEO5rkn25ivCaYfghlox
 czJFD9wwIVYRT8oEwnKOqshJ6HQCSIsPomaRA13saAT1/W4yi563cgKXdFMuYoXdIvMwlRQs2jt
 vIyPgLMgg/4S9H7B08z1Ckz5ROjeJ5EPGhn/m2eYTyLk5LkT6XT463PWm4HChnPxUf9toSFdmya
 Nq21J1NvVwA97vcrVvjTGPPbmN+LCb7hDT3yptWnzq7QEQdyMMnmiDiFLZQUqQ+ME=
X-Received: by 2002:a05:6a00:f0d:b0:81f:31c3:2e34 with SMTP id
 d2e1a72fcca58-8244162fa69mr10269391b3a.25.1770613750478; 
 Sun, 08 Feb 2026 21:09:10 -0800 (PST)
Received: from ?IPV6:2001:8003:e109:dd00:9c4:a3d:914:f9b?
 ([2001:8003:e109:dd00:9c4:a3d:914:f9b])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c6dcb5e5f98sm9324749a12.17.2026.02.08.21.09.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 08 Feb 2026 21:09:10 -0800 (PST)
Message-ID: <8f64a18c-b2ca-4665-898b-917031c53cbf@linaro.org>
Date: Mon, 9 Feb 2026 15:09:01 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/12] target/arm: move exec/helper-* plumbery to
 helper.h
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: anjo@rev.ng, Jim MacArthur <jim.macarthur@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, kvm@vger.kernel.org, qemu-arm@nongnu.org
References: <20260206042150.912578-1-pierrick.bouvier@linaro.org>
 <20260206042150.912578-8-pierrick.bouvier@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260206042150.912578-8-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

On 2/6/26 14:21, Pierrick Bouvier wrote:
> Since we cleaned helper.h, we can continue further and remove
> all exec/helper-* inclusion. This way, all helpers use the same pattern,
> and helper include details are limited to those headers.
> 
> Signed-off-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
> ---
>   target/arm/helper.h                        | 13 ++++++++++++-
>   target/arm/tcg/{helper.h => helper-defs.h} |  0
>   target/arm/tcg/translate.h                 |  2 +-
>   target/arm/debug_helper.c                  |  4 +---
>   target/arm/helper.c                        |  5 +++--
>   target/arm/tcg/arith_helper.c              |  4 +---
>   target/arm/tcg/crypto_helper.c             |  4 +---
>   target/arm/tcg/helper-a64.c                |  2 +-
>   target/arm/tcg/hflags.c                    |  4 +---
>   target/arm/tcg/m_helper.c                  |  2 +-
>   target/arm/tcg/mte_helper.c                |  2 +-
>   target/arm/tcg/mve_helper.c                |  2 +-
>   target/arm/tcg/neon_helper.c               |  4 +---
>   target/arm/tcg/op_helper.c                 |  2 +-
>   target/arm/tcg/pauth_helper.c              |  2 +-
>   target/arm/tcg/psci.c                      |  2 +-
>   target/arm/tcg/sme_helper.c                |  2 +-
>   target/arm/tcg/sve_helper.c                |  2 +-
>   target/arm/tcg/tlb_helper.c                |  4 +---
>   target/arm/tcg/translate.c                 |  6 +-----
>   target/arm/tcg/vec_helper.c                |  2 +-
>   target/arm/tcg/vfp_helper.c                |  4 +---
>   22 files changed, 34 insertions(+), 40 deletions(-)
>   rename target/arm/tcg/{helper.h => helper-defs.h} (100%)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

