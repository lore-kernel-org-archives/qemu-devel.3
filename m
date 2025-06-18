Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33A02C71157
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Jun 2025 02:13:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRiIl-0003ZU-DY; Tue, 17 Jun 2025 22:13:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uRiIj-0003ZE-VI
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 22:13:22 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uRiIi-0001DI-Dy
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 22:13:21 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-311e2cc157bso5289935a91.2
 for <qemu-devel@nongnu.org>; Tue, 17 Jun 2025 19:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750212798; x=1750817598; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5BmP+yE/7cNER20o1mWXCs5Qrjhn0BN1QP8EsRF6Hbk=;
 b=bNpYUFGQ4u3BgopStQ0SgXvvUopGMrN79QSx2w5XzfuXvmU1OM9hbbsQt+fiSZTK61
 KtzmsmAdPZET0ydwwDRYcqsBo9IiP+yJRZcmk/s4Eswq82Vu0HrLO/isO5eiHbsBgfSD
 3/+FQuRlsy+WLJOpS2fVZ+UI9SaOoCiZBWUhofqi7MVMk0qzjjYGXyrvFLO6c8eOp71I
 2h9elB9UJArnJw306ByN261yAceWtxQVacXT7jEEdEoSIXCllHfIFR1MlfTyzFAe+MhX
 tuyIVlPdEXmaSfWSW3t7AxJYzERdIrQTDXaO3MaGlIqmmZGnoSxiqr7s0gPuOT/hS5aY
 aMjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750212798; x=1750817598;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5BmP+yE/7cNER20o1mWXCs5Qrjhn0BN1QP8EsRF6Hbk=;
 b=IzZX7KykEIHRTSAcyZUmXaOo5P6hc5RiKX519WB+GuRetdhYIkzyhlcRqlypuIAznw
 CVVXcYvHOxmBcMg6m/rnRcZPuDo40yb9F2zCczmvSu7KqL7UnQEwjTajSld2oRguZBn0
 h3eV98ZSUDCPdadz1z+a1shmz/l8Alwqptj1HVVMhD7PD8bVoPXAodcwmn66PBlwWD6n
 PEUSNLRjyoP6DgDeZqN6e2oQcJBCfBdAuDWeNkt5z8YEArfXK43EVgDmH0Gb+n4WwtNR
 FI7v7PJ8SGs08UjkO5QmAv/sB5D8aIcx1PElbQlJxMwmTJyyv305S7959yV41w2OMQKP
 4oXw==
X-Gm-Message-State: AOJu0YyUh/4owbAGavZdezSsOdiOIxVHsrW02DU4054ZJ8JmMp9sX0tm
 P2NF8wnHsrLkkKCWUOcfLsJyggPy1sUScOiwjvV3KpVIlcWprdWwEn3Qj9QTR6sDidxqnQ5ZAgZ
 XXCJ50sA=
X-Gm-Gg: ASbGncv90HYIYc/py6DxE+GDgXV1KjfxqUdDAWdQg8j/WIh36SBCwkBHsCntKSYXr7E
 1coXmzqI9cpNTJn5zaxjaOkAyrAlrAMoVRYm1vor5p0cG/2LVOC+2lNAOXvSFTvpLLs+1kzatd6
 OsqeVPHisZGkueaxzCnR0HCIujN61twOYItUsf4dpPf43wEq7kaSLZXBKL8rKvBkdxKJ03g6Db4
 Kpy/gnqFzitlq1Rl1zJdhGIpy2Wyn9czwRqDXzaHK/gQBThUFqcXV6qF45EnN0lX7hXXkVJ5wiJ
 QTNimoiPhiiOQQsHKOD1qCBBxfEKTlrcTrV13CuTxB3kBAFsFtaiFWQJYa+VDpqfdSANT2MPlN2
 dDQCOIJZOcS/zCW/2G0GOQtisdUA/
X-Google-Smtp-Source: AGHT+IF3E3ZqYhltOdraHqYaj2hx58hoecp3mo9ox9Qmuw7ZjHpfLvH/xD4/5eRBTxJme1wjUf+dcA==
X-Received: by 2002:a17:90b:278d:b0:311:c970:c9bc with SMTP id
 98e67ed59e1d1-313f1d0734dmr23240597a91.30.1750212798297; 
 Tue, 17 Jun 2025 19:13:18 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2369eb1fc31sm9122135ad.200.2025.06.17.19.13.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Jun 2025 19:13:17 -0700 (PDT)
Message-ID: <c0bbe37c-f926-4425-9cc8-7719035bc06a@linaro.org>
Date: Tue, 17 Jun 2025 19:13:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] target/arm: clamp value to account for RES0 fields
To: qemu-devel@nongnu.org
References: <20250616201042.2196127-1-alex.bennee@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250616201042.2196127-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102d.google.com
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

On 6/16/25 13:10, Alex Bennée wrote:
> If the user writes a large value to the register but with the bottom
> bits unset we could end up with something illegal. By clamping ahead
> of the check we at least assure we won't assert(bpr > 0) later in the
> GIC interface code.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   hw/intc/arm_gicv3_cpuif.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/intc/arm_gicv3_cpuif.c b/hw/intc/arm_gicv3_cpuif.c
> index 4b4cf09157..165f7e9c2f 100644
> --- a/hw/intc/arm_gicv3_cpuif.c
> +++ b/hw/intc/arm_gicv3_cpuif.c
> @@ -1797,6 +1797,9 @@ static void icc_bpr_write(CPUARMState *env, const ARMCPRegInfo *ri,
>       trace_gicv3_icc_bpr_write(ri->crm == 8 ? 0 : 1,
>                                 gicv3_redist_affid(cs), value);
>   
> +    /* clamp the value to 2:0, the rest os RES0 */
> +    value = deposit64(0, 0, 3, value);

Surely extract, not deposit.

r~

> +
>       if (grp == GICV3_G1 && gicv3_use_ns_bank(env)) {
>           grp = GICV3_G1NS;
>       }
> @@ -1820,7 +1823,7 @@ static void icc_bpr_write(CPUARMState *env, const ARMCPRegInfo *ri,
>           value = minval;
>       }
>   
> -    cs->icc_bpr[grp] = value & 7;
> +    cs->icc_bpr[grp] = value;
>       gicv3_cpuif_update(cs);
>   }
>   


