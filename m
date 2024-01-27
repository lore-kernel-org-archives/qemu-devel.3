Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C8B8C47422
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jan 2024 03:10:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTZ4O-0002Sp-Gt; Fri, 26 Jan 2024 22:09:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTZ4M-0002Rf-QQ
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 22:09:22 -0500
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTZ4L-0007Jc-3p
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 22:09:22 -0500
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-3bd6581bc66so935023b6e.1
 for <qemu-devel@nongnu.org>; Fri, 26 Jan 2024 19:09:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706324960; x=1706929760; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=brvN+T3G8ChesX+gJm3C8l7IDzprPjl4zysU1+vcnIw=;
 b=UQGH34L3+wC+ATmetlZinYnv41wloRmNfWYvNKkxlhyElE3WpLgyXdyGJzibjjvhe0
 eKorJH//UteQcDGV9oUd+DfvjB7eSSAhhsaWXAuazndS9sBG6RyDgQLXedBBqO6PFWJ2
 PxO5Lt2aSDYkvqBeD5Q+JHBKRfrtoTGcneF5lct0mYTOpXiOQZfroHq3IjXyd02vDkoh
 hCBZCBlRUxWTaGe3VjuOmt1DtAihHmScJZgSjOpz1GpZsD1h1WmyEv7ZSBWPs1Y7+1Ir
 2J3cNZosL8Ot7/6Q3RYkZ1NM8IpoNWO/Fbd1XBDEW3GMm0wbDgtAnEQrHSF48fNeq1nB
 JuPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706324960; x=1706929760;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=brvN+T3G8ChesX+gJm3C8l7IDzprPjl4zysU1+vcnIw=;
 b=dFZwEIsdjZvtLTe1sfmpBwoWWJm6tfZtbQMmElKfVLUF1Il6sbDq41c3+Gj8UqHWZN
 YGwTdJOttivYLrA23GnKpmj0/9x+ofM+28KJ20IN5BY2vBmZA0phvGsnPlJk8SmflKic
 OAGxBsMpbENSLoWGkY6JkZ4v5YZ0Dcx7vsMvxfWBO2b1nAZ4pxbryKLERqfaSn6Js9f+
 hd7B/6xuLLN4el8v/1cBuraI0i3U+HDO4RVcsBHmNk3fCyaNYSOQpw7vDEEMaqcUZUKD
 mH2VivDWjJLolYrXgmokWmv4ftmbuoA/9DHS5fhz43FMW4iOTpHO7922WQmwjNMXzrNo
 pvbA==
X-Gm-Message-State: AOJu0YwmmkvN1gIqDjPD68ggKtz7lC/kuoIImQo8zubD40ZVOC1CxuS1
 uDYpKXEgUkfwXgCzC8wckCobblzAkQPAl7+AIV2QSbL7Zdr8zkM4j9Q33XkKqfo=
X-Google-Smtp-Source: AGHT+IGUQm1flWdoDuqIVD6/FEdvmgcbBpZvbJinDT+4r1th52gWtavzVeLR6QyUDKIZi0Z7G/I1TQ==
X-Received: by 2002:a05:6808:1314:b0:3be:174c:1888 with SMTP id
 y20-20020a056808131400b003be174c1888mr457260oiv.44.1706324959685; 
 Fri, 26 Jan 2024 19:09:19 -0800 (PST)
Received: from ?IPV6:2001:8003:c96c:3c00:b5dc:ba0f:990f:fb9e?
 ([2001:8003:c96c:3c00:b5dc:ba0f:990f:fb9e])
 by smtp.gmail.com with ESMTPSA id
 jw16-20020a056a00929000b006d99056c4edsm1784168pfb.187.2024.01.26.19.09.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Jan 2024 19:09:19 -0800 (PST)
Message-ID: <87c249b0-8f08-40e6-91c1-1d3c970b567a@linaro.org>
Date: Sat, 27 Jan 2024 13:09:13 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/arm: Add ID_AA64ZFR0_EL1.B16B16 to the
 exposed-to-userspace set
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20240125134304.1470404-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240125134304.1470404-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::229;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x229.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 1/25/24 23:43, Peter Maydell wrote:
> In kernel commit 5d5b4e8c2d9ec ("arm64/sve: Report FEAT_SVE_B16B16 to
> userspace") Linux added ID_AA64ZFR0_el1.B16B16 to the set of ID
> register fields which it exposes to userspace.  Update our
> exported_bits mask to include this.
> 
> (This doesn't yet change any behaviour for us, because we don't yet
> have any CPUs that implement this feature, which is part of SVE2.)
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
> This is a loose end from last year: in commit 5f7b71fb99dc I
> updated our mask values to match the kernel, and when I was
> doing that I noticed that the kernel had forgotten to add
> B16B16 to its report-to-userspace list when adding support
> for that architectural feature. Now the kernel has fixed its
> side, we can update again to match it.
> ---
>   target/arm/helper.c         | 1 +
>   tests/tcg/aarch64/sysregs.c | 2 +-
>   2 files changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

