Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C2D9C5DF81
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 15:19:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwi4N-00031J-MP; Wed, 19 Aug 2026 11:19:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wwi4M-000312-VZ
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 11:19:10 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wwi4L-0004CP-Al
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 11:19:10 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2cf6d65d8a7so13520945ad.0
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 08:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787152748; x=1787757548; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=sxzs1t9yRoICMuR7HK4W1njfP3UiQZfFk0xiXq/K1Js=;
 b=QqrxIhIE0Nm+B49eYgRFmrLZNLHA1inGEMcL3xK1HgtLTObS+M1Zmzh4XG9TGd8qDP
 RMSxKeztkdctRfcW+/207dugc1uXLAAjZNkhAg4V2zeIW8UUpc1X+8i3WI4tJvfKu2P5
 A8A7CwYGN6l2vL/+k+XhGEj7C3mo9+usLnrqXtlgq5ZFIsDmKRgZb2dpkxBhW9PEq2qd
 8Gb4K/dTTAcWlDtIA08op08eVgSE+k+kWSq/JUqDir2VXisOr0u5tcOHXiZMh1DtYrZF
 0bHSYOFYPZrd4Kmcgw+o8YFJtM+QSsH/8R87G/3YdelULQHyhNYwjeOtD5QqcLyxezgb
 Sr7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787152748; x=1787757548;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=sxzs1t9yRoICMuR7HK4W1njfP3UiQZfFk0xiXq/K1Js=;
 b=QJXvUJJ4Yekmt2uxQngnhHQ7pPfXvkgEbJ0YSUt99YuIo42iWiCqbfeObXbSO6eCQN
 k5EuEdrJu9Ecw1Lr/j443HcIyk+YK0P1G31Jx0GqRfz6senWItlXrSzRiOZrQTW6d0na
 RR12vulP7K+tLRa0OEBAJ/PIYxGaqrMMW+92Y5McHKIQ9yXL0yBEj8i9qrh6/krlHHdZ
 JfiRVAocJ0dyEdlEc4+qwRS7+SSGsZuMsqt+SF1DmymvFGrmSU3Y1q3iB/tehSvamVLa
 fzT1rplWaqr9Zhw0Cpa8CpgFeWhQc+h3UAJACzaTuNRWLHiAtGwj+10tcj8wHMsLdzFg
 DGWw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqaeLA21l0RHK/uPIQaJkQUQJSmEULsAwch3vmnKMs+4SPxlJcoyOdTuMb6m4R+s8mc4ubTKJjtQJIO@nongnu.org
X-Gm-Message-State: AFuF++nyPPqRLWxsDOjJnQVTLTmpz3bTHY1oHJytMMZnwFJCxqhbhHOc
 KqDliKdh2K4qR9Kvp4Ui8tQNRbbjbffjoPs1BjxcGb02W5iPO7As4qTiXYtg1BEOL68=
X-Gm-Gg: AR+sD13YQJPQH/px2PM6PgUUIkXuxgPi26wfOUQh2y2hLT/C4eqxSWObFZnDznb77Vt
 cXYpv6x+OLW+dMTeO+MaPgOwniVvjvQx6FJpeDdsrNNkaNOH9WDQ1bqDM1CJPQ01GalIC9o/cCa
 4yQECJY0lNaE6D2Fzt2hAtyvh2dZC42tGboHGUBhj17s7heZNvUQoBWSAyD+NHLxv3ddP8Sz1KP
 JCUI7+Q539u/ewKMP6k9sOnoSmxKGcD4j4p5b3w8lSNGt/JZRHUBfgeyc2wdlJPLlW3UdvvMne8
 4JOTTUn8RnhJeewbkjfZcUT0/MV4HLJAjbGGZP0hKhGAJA43X8O4ko6Y2F+cSfaZfz05OVnSdEH
 JOmBHSgE0/TcjAC0MCtCoZjZcBHn+OzIOp6JDCwXkxQkHxm/RZ0OLBzbvJAE89dOtzHJO+uHJjZ
 iR13Q6aKcNd7LwKswdYTOBNzxh9Q/kmhnmngHcSIPYgxoK9yiUR69Cnoh7y7fO078rdHKKviYG2
 d9+lehafUKK2Q==
X-Received: by 2002:a17:903:350c:b0:2cc:aa36:c046 with SMTP id
 d9443c01a7336-2d601a8e888mr104703995ad.14.1787152747713; 
 Wed, 19 Aug 2026 08:19:07 -0700 (PDT)
Received: from [192.168.122.51] ([173.164.107.233])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d5c1f00b27sm25269335ad.83.2026.08.19.08.19.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Aug 2026 08:19:06 -0700 (PDT)
Message-ID: <c9941ab8-8af6-4010-9572-23e19f77e461@linaro.org>
Date: Wed, 19 Aug 2026 08:19:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/8] target/arm: Implement CPACR.D32DIS
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20260817123838.1578060-1-peter.maydell@linaro.org>
 <20260817123838.1578060-8-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260817123838.1578060-8-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

On 8/17/26 05:38, Peter Maydell wrote:
> On some v7A CPUs, CPACR.D32DIS is a bit allowing the guest to make
> VFP instructions that touch registers D16..D31 UNDEF.  Whether the
> CPU implements this or not is IMPDEF, and the only two CPUs we
> implement which have this are the Cortex-A7 and Cortex-A9.  In v8A
> the bit is no longer defined at all.
> 
> Since the only kind of trapping that needs to be done is a simple
> UNDEF, this is straightforward enough to implement.
> 
> Resolves:https://gitlab.com/qemu-project/qemu/-/work_items/1499
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/cpu.h               |  4 ++++
>   target/arm/helper.c            | 19 ++++++++++++++++---
>   target/arm/tcg/cpu32.c         |  2 ++
>   target/arm/tcg/hflags.c        | 20 ++++++++++++++++++++
>   target/arm/tcg/translate-vfp.c |  7 ++-----
>   target/arm/tcg/translate.c     |  6 ++++++
>   target/arm/tcg/translate.h     |  1 +
>   7 files changed, 51 insertions(+), 8 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

