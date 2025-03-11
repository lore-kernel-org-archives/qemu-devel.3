Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF089C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 19:00:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ts4pZ-00087M-Jd; Tue, 11 Mar 2025 14:59:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ts4pQ-0007zi-3h
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 14:59:51 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ts4pO-000850-1l
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 14:59:47 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2feb91a25bdso9159756a91.1
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 11:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741719579; x=1742324379; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jm8mwg02UjcwLjJ8M75kyMiN4uD6fZT2pZoox1K2hcg=;
 b=ilL/JdHuamz2L2UojZ3gmFvbAMabkC4FRV6kFlSfyWKiLLMuk0XMkrqPU+7eAHEi4g
 IuRGRuIvxopzk6N/hpQZNo467BEx+7Zq3xB54x8umt6Cb0e5LS+T0PYvXtJSXAOQskoL
 3DH3G+7HjPYzhjInvHvgbK8uoC3sc1NZ+reKhseJSzbDYLOquTYxuJXWjYm0DwRH6RqA
 sEUsu2w/TWPH8+U0RyqHTy2S7+OBK/gLPlvEGy0k1KlgYF1RczHnSkLQPbQ/JTnsOh5i
 AydH8y9Qyud9a4D8KotAOPdemw6qw1rLiV3um5WfH9gfQCqfY17XnyJaYl4DS3FlAUBh
 76Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741719579; x=1742324379;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jm8mwg02UjcwLjJ8M75kyMiN4uD6fZT2pZoox1K2hcg=;
 b=wzVOg7lLYgkRZFHDjLADPEBrWWxIb01SI1raae5ZVFjoM/Krul7kosAhdUaoB7uI2D
 WoGsBIqltofkZWVdAypSc5P/k3AqjyG+zYSdBTjT998IgzsA4dlAZWULAKrUkzMKUXST
 GI3Ofi5P8+eEjXLBpKHWYcP7DK5TqtnElj6tXpZnD4Ge2yfWMWB1MxHAeS3UgU9+ONt6
 BtpV/RPHItY+a8uJIF4NyyALlWl2lyqjQYXUjHmKFCsOyODz6rs6AjtChfPlkj4edERt
 P0DjXZVxWUw1jfaZufYWd5a+f8Ry9tbNmTHvERaEC0DpJf4qT0yv8sKucMOkXEUl62/w
 fkwA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5OZ/i21I3vhoLxe2bloc0i/eKgyodv1uhpPk+T2OMcPl4U+uefu5vUHydDjhBnGz3dXNsLFdkQrOY@nongnu.org
X-Gm-Message-State: AOJu0YzzQmeKeURx9jMqTe27LnHmJs/BF0cC0KozSGHXdod7adoj0T//
 qKY+tWhY3HBiNs/iX7TSg6LSp0qNCrCKn86PxkLwVe5Knd9TihZDtd98ywp0+Q0G/IeSSY8Bk1A
 S
X-Gm-Gg: ASbGncsE4EvRtczfnoSwp/dUYolIfzAYOcXOfTY5MMCkRkLSFAsi5TZBOkssoe7d2qq
 nSnksebMgCAleRpW15jwAOZycbCAR5wFP95ysyYiakOv4prRSRfVY6/x9iAGF0EJA6ZtGaSWTI2
 /Axe9Ppv61j9NlvsnmepsehoWA9O6EF6DODRunQFScTFVFBE4mPm79yaj1nJk/LZI4mCuz3g/GI
 EVD1YdzASB6f05Lncxz8EX0+SXOhbQuaE1ruqvSDxDEzDiqn0yvJgrgTwCyhfOWJfSPIl0p/k4F
 iUnrcQ8aGPS/KHxQ2Y+2r+7GcmhDt5HBaUb5dD01Yo445AruCBzvpP0+OGLgqk6QvSGeadMAULi
 ph5QAJ5iP
X-Google-Smtp-Source: AGHT+IF1DksY990uY5AZXlJ5QmkPinpMqLBfxNzOYkcNrYB9P93BcTpVYTWwLsqcwy4scOYvAH3Slw==
X-Received: by 2002:a17:90b:53cf:b0:2fe:99cf:f579 with SMTP id
 98e67ed59e1d1-300ff0a4428mr6186897a91.4.1741719579132; 
 Tue, 11 Mar 2025 11:59:39 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ff6933a9cesm10389683a91.7.2025.03.11.11.59.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Mar 2025 11:59:38 -0700 (PDT)
Message-ID: <dfc5ce05-eb68-4ac5-b3cf-49afa4a7a1ca@linaro.org>
Date: Tue, 11 Mar 2025 11:59:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/14] arm/cpu: Store id_dfr0/1 into the idregs array
To: Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
References: <20250311162824.199721-1-cohuck@redhat.com>
 <20250311162824.199721-12-cohuck@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250311162824.199721-12-cohuck@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1036.google.com
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

On 3/11/25 09:28, Cornelia Huck wrote:
> From: Eric Auger<eric.auger@redhat.com>
> 
> Signed-off-by: Eric Auger<eric.auger@redhat.com>
> Signed-off-by: Cornelia Huck<cohuck@redhat.com>
> ---
>   hw/intc/armv7m_nvic.c     |  2 +-
>   target/arm/cpu-features.h | 16 ++++++++--------
>   target/arm/cpu.c          | 13 +++++--------
>   target/arm/cpu.h          |  2 --
>   target/arm/cpu64.c        |  4 ++--
>   target/arm/helper.c       |  4 ++--
>   target/arm/kvm.c          |  6 ++----
>   target/arm/tcg/cpu-v7m.c  | 12 ++++++------
>   target/arm/tcg/cpu32.c    | 30 ++++++++++++++----------------
>   target/arm/tcg/cpu64.c    | 16 ++++++++--------
>   10 files changed, 48 insertions(+), 57 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

