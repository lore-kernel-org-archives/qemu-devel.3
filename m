Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9862EC5DF81
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 15:06:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwhrc-0008DU-Tu; Wed, 19 Aug 2026 11:06:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wwhrb-0008D1-5m
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 11:05:59 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wwhrZ-00024H-KB
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 11:05:58 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2cc7e86e7aeso12758965ad.2
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 08:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787151956; x=1787756756; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=br9fDUNcd96vwGhn1ZNCB/BiQhDD6ktjxAW0cbXVXL8=;
 b=QrdIxcFKLm60zW+a9MkM2hFZiIktpu5d97IZTjlX9v/u8ltMPxlBHl+HVpeRjxKf5x
 ZWQNpMzSidQvg+jOWvOl3NaNEr9e9pdMFBNoBfMFAiyuS3smUS9/x26CikDfQFpTu1Hj
 UoDFSJDtik+MSlnKmI5GSFsxsYo+0ll3AaIkwg0eAN5kHpfo/xkJyoDAK/naILcJCQNI
 niavXoQ2JWRUC+5NoamQxR4n6FWkjT/txB55j1kL7dzF2vqecMOSALz4b3MPrHbZGiEz
 LW4FpQjfifWIPZ7sWN7+MplyeChpTDMVgoC24P6Y/CKVo9riohCROuG7ABmw7ui0bqsz
 Couw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787151956; x=1787756756;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=br9fDUNcd96vwGhn1ZNCB/BiQhDD6ktjxAW0cbXVXL8=;
 b=YdySqg7xktLeHGn+IbQjtdhfYEDATUWtN17fjkd7A4/F0bEIb+Rra3NwtLsh2EXfo1
 QHB/pNRDQRiBvAbyCOdqjYIpCuO16dwWQ9c92lhp33jEUKsjOd51GSnYveav5dKbUK15
 l/LR+jJ5kNVSAQTW5U/08oZZXBeNZTBMvV5p8abNe1xxXIa7vQgAO7keD7MofmSV0Hy9
 4wCnNXpJnzTTX634j7fXCYhBfS1jUku7lBlnUgsZfr1XOiTN39lcL/xPzFK5D1Lon2rf
 UZQlDkXBbiYJMvUqOd/8pJcmr6ty+p6oRYYFEEE51af8yLNeSw4LNMgp50vnUlW7c4/P
 AUdw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqMCXdxacNQ89FdeO3uex/abdmPfKc9OJkQyUAoVj1m07y2w3lIzxzrAbJwyDVc1i9F/+kXghdujnU2@nongnu.org
X-Gm-Message-State: AFuF++natt3QYrPCukm6oDEbdqd7eKBp/Zv6X8T9FGNjo3PbkTs/HBWM
 c5vInI8YbzVug/lCzrg2RZ8xFZJmNsHMNYF/f4+NpF2clp0p3UqR4syTERYgN7qGDtw=
X-Gm-Gg: AR+sD10aRbSP5jgEA2tIWD+Lx4ySmMbCNrmXMU9sUHqo6K1/m4rQb6Qy5BTh4wWkgpk
 b1wk/Am9Ipg8rloL9gv2REo1yhw6JwJecSnMV/PmmrdNCSt16xzoJvi1zvbmdwzOvAY/vCxu3/J
 nbO/dbv5NZ6Q/Yxnih9cGlO+YBdxIfgxWn4zAPCthPepl/GBwwwMi1p4sKRSIOC1hw6Z4kJFFN5
 KhbgHn+tGLY1uF0N7eKu6p6JEN76Ie1yc6uJlptTNCBsXGYZhLdOb17SmglblYqs+yxc+8Vl6E6
 XgpnJLjPuRU1QmRsj2THGyHZ7tJ80OCQ4p8krnXTCiTKqMAjMaPs5KuGHBYTONeUTl4bSubWgYr
 NfRCMF8Jaj961odcEsb5CcKUvDXKrXk0vLccbJ+gJUcHGzFxQb3YLMTRbrAMVsT/nrPpErd3YQS
 kRidrMGltJDDBxIPWWtesVNsjWAZqkOLLuyNX0biDE1MVFtkOkBsTz4UaW1if+PexbP2icDyd6W
 31QUYKtwgA5cEpAIikB
X-Received: by 2002:a17:902:e80d:b0:2d3:a6db:299 with SMTP id
 d9443c01a7336-2d5fd703145mr92823625ad.6.1787151955835; 
 Wed, 19 Aug 2026 08:05:55 -0700 (PDT)
Received: from [10.213.131.227] ([172.56.154.52])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d5bb4dfe6dsm28479065ad.18.2026.08.19.08.05.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Aug 2026 08:05:55 -0700 (PDT)
Message-ID: <c1c0c724-0d3c-4bdf-9e9d-86f4caeff6b7@linaro.org>
Date: Wed, 19 Aug 2026 07:55:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/8] target/arm: Add new feature ARM_FEATURE_NEON_TRAPS
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20260817123838.1578060-1-peter.maydell@linaro.org>
 <20260817123838.1578060-5-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260817123838.1578060-5-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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
> The traps configurable via CPACR.ASEDIS and HCPTR.TASE that trap only
> Neon instructions are unfortunately IMPDEF about whether they are
> implemented or not, and there is no ID register field that identifies
> whether they are present.  In practice, they are present on every
> implementation I have checked except for the Cortex-A8 (which was the
> first CPU with Neon).
> 
> Add a new feature ARM_FEATURE_NEON_TRAPS which we set on every
> ARM_FEATURE_NEON CPU except the Cortex-A8, and make the CPACR.ASEDIS
> and HCPTR.TASE bits RAZ/WI unless the CPU has ARM_FEATURE_NEON and
> ARM_FEATURE_NEON_TRAPS.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
> We seem to be a little confused about whether ARM_FEATURE_NEON
> means "AArch32 Neon" or "AArch32 Neon or AArch64 ASIMD". I have
> not attempted to unpick that here. I have also not gone so far
> as to set NEON_TRAPS for the accelerator CPUs, since they won't
> be using the sysreg access functions anyway and (other than KVM)
> they don't support AArch32.
> ---
>   target/arm/cpu-max.c   |  1 +
>   target/arm/cpu.h       |  7 +++++++
>   target/arm/cpu64.c     |  1 +
>   target/arm/helper.c    | 17 +++++++++++++++--
>   target/arm/tcg/cpu32.c |  8 ++++++++
>   target/arm/tcg/cpu64.c | 10 ++++++++++
>   6 files changed, 42 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

