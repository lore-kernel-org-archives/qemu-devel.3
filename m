Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59638F3C9AF
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 16:47:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuvYo-0003Pz-NL; Tue, 24 Feb 2026 11:46:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuvYm-0003Ni-6V
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 11:46:56 -0500
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuvYk-00028L-LH
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 11:46:55 -0500
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-b884d5c787bso921012166b.0
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 08:46:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771951613; cv=none;
 d=google.com; s=arc-20240605;
 b=fNGKknpBeKNspjpm9k+G0v2ZUQghNFZqMyCXK05P0iBrTivldZzbicvzMmHc96xgz9
 lAZGgjip/wls7Lv016jIBOvmA7E38oEk1dDJ2sFOoxulH5S+fmPxioYezReGqRWS+Ibm
 Z1t9aCshehQq/WsdVsV2jUFLqLuVTMjLG/F2UiuavWd5fxDqXmDGN/druJzFRIhTr1On
 bjhN5uZg3vorzhlt9I2JIRwyJEm9IaOI1aWtLk2s19IWtOtSXLacxVBBfHYtU0Nm+Jfw
 1lJZzofSaD93XMWwy8qn1KRK5L6okz/TNTYWwa7IKulE/RB5MclfrOnPs12YWXt/tDt6
 s4EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=GYj7Ej3Sl2ORXW9spqON4Wq5UccehnD4DXMFcmnE6Ic=;
 fh=GI2e/SBiq4MTIPc9mHou6R6WJe3VvhdDMWKbaXflkfU=;
 b=KwhZdc3Ur8Bnc9XlQjYm2tzEPYUoExwuCHwnyy1zbKE/1WbAhavYS3k/6Wg7r4Tqg2
 envg9OGio+10l7A8do6xu3/uthhwOuPwIBeP7gVdPgq7SvahPsU6c/dHSOmQKOTz2xpS
 ayhdJ2eXMnbps90LUj3dvcGnPf7FvgW/skuAhl2nhUUOIgtbKF9pk1x0Xn5v+xb6FoVL
 I+UIVyCaB/QJNFk06LE7+CbVcq7lXfgBP5XqclZhiOEU1JIsHR6V5tm2Kfgxq3b/pj1P
 w28EzQhCL5lmbY0kbRm3XXM/DXvU7O12fD17kvbg7sjgohWiR/hdvTOy3/c/KrlYbDV0
 bTTg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771951613; x=1772556413; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GYj7Ej3Sl2ORXW9spqON4Wq5UccehnD4DXMFcmnE6Ic=;
 b=cLDDHTk2cyd/e0b9s/ylVWdmPu8mG5rvOt4XvVtyfuoKaPK2x/oagOlWlua3ztCSOL
 F255VH7HT1jLN9SUgQqxY/N7QJZzzm5yWj4OEXL9gN7cVSACIQ744s1bqWoiEKDN1AaY
 t9I/lQi6+ZhwQjE+/aGffBUEP039D+CdgDU+MNtjxucllgCxFy02+wfuSBOxyMBz5COm
 YDtnWTcTyeYU+NV7m+6nRM2aQroWPfqgxJymvTh0V9oSCnS0jYcVS9J+8c0CWeIjAHaK
 XUxIOIxFXKTwEGMzHeLx05VYmUf76iYv0cCAqabzcuf5WffGwkBGJhvDr9PN0ILpXyWK
 SAdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771951613; x=1772556413;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GYj7Ej3Sl2ORXW9spqON4Wq5UccehnD4DXMFcmnE6Ic=;
 b=Wuur82taL9/4anRisp0coNboM7AfUUZ0Z40k58xEW6fCAvUfPrxVt7qmcJi4rLbdbk
 SSDXwd71bddj9tvdQzAxt6mjyVOVYkTJBB2TznM5fVZ1xHbY6KmVdyYc31IB0v2Nr2vq
 TrYHN0TKgzH06h2CpcHAJU46V+je1x3K+N/6wi3yUT65zIFF9jwlpmTxtkN6SrqjOncT
 o6ZAueUTvpG2s2ghSlqRwIxBy9GvnRwjKbqq++XPLRIFQaltQQPOKcUvg+zxDeKVLhV0
 hw7xtw+vzPKPAvNuiInrT2zc5BCNHW3U5KzA1Men6Po3AKWsbGbeLhL6x8XR+LqRXhbO
 H9Cw==
X-Gm-Message-State: AOJu0YwmhhDtYjPsLpFQ1PyXR8GzBLPz+ycGCB2lHHJy8pwj0Es5/hMr
 pFoiah4wmL9ua9oNjcF8+DVvB1vRhLEDnIhRE6yruoxhXWhmb/3QGUnMNCySGyNMJ8JSRdM84yp
 My6RtHqA9vXdYSIHvqYBxMlcKDSvckC12oC8hf6CP8A==
X-Gm-Gg: ATEYQzwvCqudAZzAnL4GLFz6exaLF9h4grjCaGFDAHbwa2K5+VhH9g60GtpzMfLIFim
 kjRsISD8jbaGCi+XcWW7t7PQErKlpi2F6XcXosnIAcsTwkVyaq5RLZiuQUy047KupfQ6kCHzM3l
 89eo58aw9CCTfqE76ijsC9DE8Vha4jEWuoO0Yjvf74HcNmWCdui/pCRZq7imsoIp+hIkiMozpky
 Tvl02Qklsi1ER0SQCCmK9cyddk1UEZ0of7ARpw/Zcm+FyDiEfR0CQ4bX/sNWzYkhsC37hPLln0b
 rFokk+bCRHP+rOo+qF8PsDqE5TzEps2Q8YATh1yq8cVliU0AwWQh93/FO7p9Jvv6hJw=
X-Received: by 2002:a17:907:3d12:b0:b86:ecfe:b3d with SMTP id
 a640c23a62f3a-b9081b22197mr857470566b.43.1771951612936; Tue, 24 Feb 2026
 08:46:52 -0800 (PST)
MIME-Version: 1.0
References: <20260216034432.23912-1-richard.henderson@linaro.org>
 <20260216034432.23912-3-richard.henderson@linaro.org>
In-Reply-To: <20260216034432.23912-3-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Feb 2026 16:46:40 +0000
X-Gm-Features: AaiRm50Y_pZ9etaFmDwvgeY0VXVpR2Yh1jThV1sB9Av2EYwnO8srq1B-_RdPk_A
Message-ID: <CAFEAcA-Mi1+S3JpCFqyYo=uQsX6dRhdtj2Vt1S81yAGmCEyG7A@mail.gmail.com>
Subject: Re: [RFC PATCH 02/13] target/arm: Remove aarch64 test for kvm
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62b.google.com
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

On Mon, 16 Feb 2026 at 03:45, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> We no longer support kvm for aarch32, therefore the aarch64
> test is trivially true.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/cpu64.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
> index 5d7c6b7fbb..10c6796548 100644
> --- a/target/arm/cpu64.c
> +++ b/target/arm/cpu64.c
> @@ -767,9 +767,7 @@ static void aarch64_host_initfn(Object *obj)
>      ARMCPU *cpu = ARM_CPU(obj);
>  #if defined(CONFIG_KVM)
>      kvm_arm_set_cpu_features_from_host(cpu);
> -    if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
> -        aarch64_add_sve_properties(obj);
> -    }
> +    aarch64_add_sve_properties(obj);
>  #elif defined(CONFIG_HVF)
>      hvf_arm_set_cpu_features_from_host(cpu);
>  #elif defined(CONFIG_WHPX)


Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

