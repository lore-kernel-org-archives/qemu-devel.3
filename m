Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5D94C98304
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 20:54:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9TyS-0008LE-K0; Wed, 23 Sep 2026 16:53:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x9TyK-0008Jx-FL
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 16:53:44 -0400
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x9TyI-0006w4-VG
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 16:53:44 -0400
Received: by mail-pj2-x10.google.com with SMTP id
 98e67ed59e1d1-396cccbba91so773110a91.1
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 13:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790196821; x=1790801621; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=a30oX7q6ipaVXfhtzL+femr1p4CeTPsvQJEgRmutiz0=;
 b=ne2U5fqPk1Nbb/t8RCtoAf+QImORnAEOzqYNitsDyS1nS9BwYmIOKg8q0rQTnXuKOV
 UxtlhvCr6w+iKJLT12jQX2ep+ICrzpI0pk5KN/ezUjWbJ91g3VVtMP6OMsEncJNLYGZR
 1fpbj/RIYFx055kL70ERgbWpP8x0Z6i8/vsETYT5y4bNKKCBRf+pY09elluZCLs1i5sP
 okUYWyiFN93caJNHNKz5Kdwxmtz5dWhKvkMr1BGHxsNt1MQ+ADR3ifEplHmUSm+XfmDr
 lLG2cTF7zBHeMcfM2msSv6UVHcb63ULmDHyiE5X4X8Exxl/QgE4zbdq3dMTim8AWnngn
 WRBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790196821; x=1790801621;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=a30oX7q6ipaVXfhtzL+femr1p4CeTPsvQJEgRmutiz0=;
 b=TEsbq4eeOi2JN/w/JnYvDQNR0P0S9XBxxxJnk/Exc6cJqzjmAJR1n9PmMf8X/5Cw4B
 RolCOv3+E60/rZBP5pPmwvM1wlz8eHkDnZwDVgk0ga3cbn1QFc/k29eom5HTE5YdtTnt
 Qxon+/xX2iX2vIle/j5ECioX2QbNLfjeiCqEG2LX31Bc/sKEIyONr+/Hw0NwHOwxrSC0
 yKW9oAAYckexkGAYEuGShU9o0JJTZX2Gex/8KcXYFMXjzbnViP1D/rs4GjIZQv7DVAPR
 wDg32Pgrk5OQP0q+Tu+dBdHkKqWVLq87t0EER/STPJ4kHGWTwYr5Gu9kujdweTNIiFSw
 GC4A==
X-Forwarded-Encrypted: i=1;
 AKwUvBwery6Y4OUMjQiCU+EyAlbV/vBUB51R8uR0OeKsxKrK/J56GLlUazV0xmWbiHzixJN87zY2zOiej48X@nongnu.org
X-Gm-Message-State: AFuF++mHX5PNtO4VujUvunHEOtwxrUqsHMdgVYnM+xgRh9d/jzuORQ2P
 UoTvZk+se/xvVgaUyA+uDEVs3QR1Zh6D2v6RERnH3FPrYtR6BsXsShm1eM429QqypC4=
X-Gm-Gg: AYBFou1q+A+3VWKN+W/mZNHP4MJwdwaoxwgwcLlH+h705JckkxmjS9HsN9I2zfLoM1P
 McsPNs6K1AMKWcDkd1eYx9jCuw+ydyL0XT4laxWtSIHdDqY7zHgDjbKZ04W8Spz3yyXU1/Av3i1
 u1fEBZw95SdSUwo3vRkMdG95LJ90DQLGJA894KxdvDecv4kqJfLs54q8I2Lg+afzbmfON+HsWgk
 UdHOhizXyDy4ikLeAaTMPHMbuAUGBnDsUm9AzkhLzzFk99e2YXLpUcznpFhx9w+H8BmySkzhDvz
 9sS8uxn5pSM0pi+ibqUxrM2Ao/EUywGaSFul/BLN6ZFLaAg1YNMGKDXWPJFyKY8YiifWepWscdf
 7JejH8YN9OGeCxMJ8ZFqOc00mjdZwlbr+usGWUbbOG6/75kBqZ7ZxFYqA80P0RIMdFuVlZPE2Z3
 f7cqJInI0J+WXGouXy/oOGHaa4ywvQilOXiUSBBVUycE2jGkYMBHcnNzZe4q5wgnAz5k5EVZz+W
 uuBdXUAq+n6X6l9B2pTCInCCHSNbTZmgmbIRXwm
X-Received: by 2002:a17:90b:1e53:b0:3a0:71d3:bb64 with SMTP id
 98e67ed59e1d1-3a09860b71amr296306a91.27.1790196821149; 
 Wed, 23 Sep 2026 13:53:41 -0700 (PDT)
Received: from [192.168.0.4] (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0972b11d4sm863831a91.4.2026.09.23.13.53.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Sep 2026 13:53:38 -0700 (PDT)
Message-ID: <70ef8524-f301-4247-b0a5-2a63f2d79f53@linaro.org>
Date: Wed, 23 Sep 2026 13:53:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/8] target/arm: Don't use arm_cp_reset_ignore when
 fieldoffset is 0
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Tao Ding <dingtao0430@163.com>
References: <20260907130223.3148989-1-peter.maydell@linaro.org>
 <20260907130223.3148989-5-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260907130223.3148989-5-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x10.google.com
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

On 9/7/26 06:02, Peter Maydell wrote:
> In cp_reg_reset(), we treat an ARMCPRegInfo::fieldoffset value of 0
> as "reset is handled elsewhere".  So we don't need to explicitly set
> ri->resetfn to arm_cp_reset_ignore() when we haven't defined a
> fieldoffset in the cpreg struct.
> 
> Remove the setting of resetfn to arm_cp_reset_ignore in the handful
> of places where we were doing this unnecessarily.  These are all
> timer registers, and doing this brings them in to line with the other
> timer registers (e.g.  CNTPCT_EL0 has no resetfn, and now CNTPCT
> doesn't either).
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/helper.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

