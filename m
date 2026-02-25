Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65CEDFD45EC
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 21:10:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvM98-0002GT-0Q; Wed, 25 Feb 2026 16:10:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vvM95-0002Db-RJ
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 16:10:12 -0500
Received: from mail-dy1-x1334.google.com ([2607:f8b0:4864:20::1334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vvM8q-0007fm-0A
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 16:09:58 -0500
Received: by mail-dy1-x1334.google.com with SMTP id
 5a478bee46e88-2ba6aa57d5fso73594eec.1
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 13:09:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772053794; x=1772658594; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EcpI4CrN7/cPL7IDRnRGTWS9aX2aFKkRid9LQak0Bcw=;
 b=f/7RSNevc+Jmu7w9lD6F8PV1Xidw4lyd6e9mFptTMFNjV640vf3SdE7cGLWa674yqA
 ytE3iQ00sD3+HvowaPubXg2yntbC9rmdsQ//Pbxa4G6LmlWnNhT9Dza8lJrsLCxTwC+x
 17vzd7kFzIY6a/2ySWKkgZgFZa25zmetdZYbko+rm3LpaziP27QnAi3EKHQl2vJ8MrZ/
 hUNq3oLXMsoPirVrdBDvaoigzzX0HAa0QBkBVx9zdddjslYP0UCChn8fka/L+V/O6Y9i
 a5n/ZNb03xyFfmPnax1dY4Z/SitBRB/Fj9qJKUEWQmYiCYgbDeIoRgJ+MuXvX8xLaAh+
 eGDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772053794; x=1772658594;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EcpI4CrN7/cPL7IDRnRGTWS9aX2aFKkRid9LQak0Bcw=;
 b=tmo5g1/4Q1V/Z5O+nTEDt65h5SFQqNI3qEd5ZUL3e727g69OcZaDKh+PQKy/fRJLk4
 bZzqvQXIEWhciStC02jZby8aJ3Bv5aoSrAbFkWC5L9CazSx0prNCuawz6ZMl8mi+K9RP
 2fP6PlMoacyiBfd6C2XaOmlbNUhbu4TyjmgTH5zqJnkQ0rX+LtWp1GOT/YkTKcKepjIG
 c30B75LkGQAT6kqiiCzyVRzF8tmXM5HrmWt0vhC76+vd5gW8jICUtxQT1e5IGjWoKVPr
 NiQ+Up1AIze/aXmVUku8sAFxOBXRqfr8hBopJxw9flyyyAvTVb8TfRDJo6oGdkmuf9eh
 NVQg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWh8O1tKOpo+Kye7figHOK7RNbXGSECiriMKds/p6VXfR0KH/W94JTwhXjwBMdYOoeyAPiqtTyvMCtp@nongnu.org
X-Gm-Message-State: AOJu0YwdEVApWox/39ljnRC/wBnear+lmnrcKQLVrU0ol17tDXrONHwO
 eEjosghJ2sbmDK+Hqq0m038/wZLvfoW35cvdPH2XNV6HfUN6XZMjnSxN+Qc8Ky8lEZXhCqAY2u2
 e1RDM
X-Gm-Gg: ATEYQzyohHU+FNE7D8TLsW4jGJ81Al+laMG8Jqvh6RpjmztYmolMxVjTK0PxGvWRjU2
 N4nVsd2nrnSpaXczUAlvBanAv/pPCGGIqrrxbuB6ugKi/wa3U/TEQJlXU/sHe57zq0tpEH4vvap
 fus7sfZeIFrpHfeI98zHKaVMo60WQetH0Tb38zdHhH/jjRsvS7KFxOs3fUarWIWshflGudfSUfB
 BI8tuUfzCeLzFtcUx6PsaOafcn920TVYpjfDEyRMTCpJDb0Q7IwO+xSU5lWR/YnJrA6bTqkoRZ6
 fEei4iO0iu8uvEeBAR5IkMtgd8PNRA7K8AsPpv7+y/hi99+z3NCNqrOz1FUS7CVLny0Q2E6NoBY
 Nm+5Dd2su5Ka6TzvaCuttjY4yqY67DjxTTvzE2L8VCgWC2ZS5yQtIXfDsiRd0ivkoA0GWtLMdnI
 jH7pXlx/sjosCIhwp0pO1sU+yif2aq7xJiUOELUy9PCE+yQ7X5B9R4lsvo/ULyMFF5fQ97Fr2GG
 Q==
X-Received: by 2002:a05:7300:ed01:b0:2ba:6c38:c79e with SMTP id
 5a478bee46e88-2bdcc075ebbmr760331eec.28.1772053793880; 
 Wed, 25 Feb 2026 13:09:53 -0800 (PST)
Received: from [10.34.149.227] ([172.56.178.189])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2bdd1f23c1csm134977eec.18.2026.02.25.13.09.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Feb 2026 13:09:53 -0800 (PST)
Message-ID: <5ea8c4e7-04e1-4053-941e-2084aca2a197@linaro.org>
Date: Thu, 26 Feb 2026 08:09:45 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] fpu: Fix repacking issues in the uncanonical step for
 E4M3 overflow
To: Max Chou <max.chou@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20260225110802.1217946-1-max.chou@sifive.com>
 <20260225110802.1217946-2-max.chou@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260225110802.1217946-2-max.chou@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1334;
 envelope-from=richard.henderson@linaro.org; helo=mail-dy1-x1334.google.com
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

On 2/25/26 22:08, Max Chou wrote:
> In the uncanonical step, the input FloatParts will be repacked to the
> target FloatFmt. This commit fixes following issues after calling
> uncanon_e4m3_overflow in the uncanon/uncanon_normal functions.
> 
> - Add the local exp update after calling uncanon_e4m3_overflow in the
>    parts_uncanon_normal function.
> - Add the fraction shift after calling uncanon_e4m3_overflow in the
>    parts_uncanon function.
> 
> Fixes: 27e989f99c ("fpu: Add conversion routines for OCP FP8 E4M3")
> Signed-off-by: Max Chou <max.chou@sifive.com>
> ---
>   fpu/softfloat-parts.c.inc | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
> index 61b07307bf..a738758aee 100644
> --- a/fpu/softfloat-parts.c.inc
> +++ b/fpu/softfloat-parts.c.inc
> @@ -387,6 +387,7 @@ static void partsN(uncanon_normal)(FloatPartsN *p, float_status *s,
>               case float_expmax_e4m3:
>                   if (exp > exp_max || p->frac_hi > E4M3_NORMAL_FRAC_MAX) {
>                       partsN(uncanon_e4m3_overflow)(p, s, fmt, overflow_norm);
> +                    exp = p->exp;
>                   }
>                   break;
>   
> @@ -496,6 +497,7 @@ static void partsN(uncanon)(FloatPartsN *p, float_status *s,
>                   break;
>               case float_expmax_e4m3:
>                   partsN(uncanon_e4m3_overflow)(p, s, fmt, saturate);
> +                frac_shr(p, fmt->frac_shift);
>                   break;
>               case float_expmax_normal:
>               default:

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

