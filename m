Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BB65C369D5
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 16:39:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9RV7-0003JT-EN; Mon, 28 Apr 2025 12:38:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1u9RUx-0003H6-4O
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 12:38:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1u9RUl-0005aF-2x
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 12:38:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745858292;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dLeMmLBitMva57crvjAkV/QU3JbwDt0mhgNiT6DPem0=;
 b=KZ65BYuudJ7kQ/Bpmkzr5S5ku8WZhVVa4IlBSuQnibK0edqE2Fp2CjJJQwRJUCZ4656UY6
 9GlEDLbRiFXu5CgJUtjlR3BGz33EG4mJw/sTTB2qB75TLUOOzEihRTouKQemA+WkgVSCni
 dVyxiTbstr38HmOsec5n6PASmAhtMMM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-350-9QO1aH1wMoGGF0fcUE35Pg-1; Mon, 28 Apr 2025 12:38:09 -0400
X-MC-Unique: 9QO1aH1wMoGGF0fcUE35Pg-1
X-Mimecast-MFC-AGG-ID: 9QO1aH1wMoGGF0fcUE35Pg_1745858288
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43ce8f82e66so26407915e9.3
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 09:38:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745858288; x=1746463088;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dLeMmLBitMva57crvjAkV/QU3JbwDt0mhgNiT6DPem0=;
 b=Ur/TaMxnQrP2L0RgWtiMubg2EN0jOpOFgXex1v5pmWH6rqb2KPK2JiuT9RiaBp63BI
 jsdr6AUUbO3l/rvZJIQPigexUlyeGuhTYBQMXr9vL586FeuqTMtzEiM66x+C0KHWAa4t
 gjqYyH0GKpEbdhfhF62514YtySgqiCcIipbfgVxquDcwtORbyqmr0VZHt1iDlKjdROzb
 fDSb2lmMPzj9ZwTFmT7pCFtVteFV/5HgK7w+uKdwBHsj8YrxIjh1Yk4fhdp4P2aR9kfo
 re9aJhWmko56U5KbTJIyMYubm6vdUQoMd4PtBrvvAhh9QjMbaYKIDwtIyMuGmvHBlB20
 R5Rg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWObmfYlX7qVfVG2JWtBHWlAENsKLioXsyKbGrSC0e0A8DShBpTx/6i8ePrRhhN8euBVYkUdWZtSsYD@nongnu.org
X-Gm-Message-State: AOJu0Yxgf5dUekHk0eL1s87fRGDUiuDWVmTd2tlXjL04S+bOgZAjobu0
 NKqXo4WWthNmbVDAchAkvByZeFLJBH73lcEPDEjaymyI53+vTjpoZ75KMTfFwrEb47oHhhvECNd
 rbcFaAcgt/4IisJcb0z323oo/vWT2/DRqaMB0YN9fmwtguURlS+yG
X-Gm-Gg: ASbGncv4dnM30wLhSaeFkQX0fPWvUdgLlRgzMTAmtTC0TvfP1XcRE1tDYJHTVZd+dro
 TrLj35tfK0OBb2FDEG9VQLC0tNEu7HXsNe41HvUbIR2N6uDqD9HlD47QEKZVwh4I+yLqmxdbGTG
 MpPEdLjUgFi96cPppySxhgXjIp94cS5DXGIf/gWQYT8/lsPuuqJUNhMFbnYJM+0WIOO7OEKSSlb
 KcLw7TdYhImG7YHCheqMjXLUn+ZPa/Eh7bH4u1CQMMMP5Y0Lo3AWFA4VAcHc3qRX20Cu9b034wV
 OPqJT8xsax9EHsxTIJynSdow11SDHzJAUumSg+gWYxn35q4a7LoC6u6FOEU=
X-Received: by 2002:a05:600c:348b:b0:43d:54a:221c with SMTP id
 5b1f17b1804b1-441ac861d66mr20965e9.18.1745858288295; 
 Mon, 28 Apr 2025 09:38:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF09OX4DldWlH3xXjtGa0wqs9dyZdcDrIN5MrAKJLX78b0Nv/aKDVbTMellSTBrJhFR1500IQ==
X-Received: by 2002:a05:600c:348b:b0:43d:54a:221c with SMTP id
 5b1f17b1804b1-441ac861d66mr20685e9.18.1745858287840; 
 Mon, 28 Apr 2025 09:38:07 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-440a531dc6csm128148625e9.24.2025.04.28.09.38.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Apr 2025 09:38:07 -0700 (PDT)
Message-ID: <4218aec4-473e-44cc-9d9b-999e6c9e160b@redhat.com>
Date: Mon, 28 Apr 2025 18:38:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-10.1 v5 13/13] arm/cpu: switch to a generated
 cpu-sysregs.h.inc
Content-Language: en-US
To: Cornelia Huck <cohuck@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvmarm@lists.linux.dev,
 peter.maydell@linaro.org, richard.henderson@linaro.org,
 alex.bennee@linaro.org, maz@kernel.org, oliver.upton@linux.dev,
 sebott@redhat.com, shameerali.kolothum.thodi@huawei.com, armbru@redhat.com,
 berrange@redhat.com, abologna@redhat.com, jdenemar@redhat.com,
 agraf@csgraf.de
Cc: shahuang@redhat.com, mark.rutland@arm.com, philmd@linaro.org,
 pbonzini@redhat.com
References: <20250409144304.912325-1-cohuck@redhat.com>
 <20250409144304.912325-14-cohuck@redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250409144304.912325-14-cohuck@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.484,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 4/9/25 4:43 PM, Cornelia Huck wrote:
> Generated against Linux 6.14-rc1.
>
> Reviewed-by: Sebastian Ott <sebott@redhat.com>
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  target/arm/cpu-sysregs.h.inc | 43 +++++++++++++++++++++++++-----------
>  1 file changed, 30 insertions(+), 13 deletions(-)
>
> diff --git a/target/arm/cpu-sysregs.h.inc b/target/arm/cpu-sysregs.h.inc
> index 6c9f9981cc5d..02aae133eb67 100644
> --- a/target/arm/cpu-sysregs.h.inc
> +++ b/target/arm/cpu-sysregs.h.inc
> @@ -1,18 +1,8 @@
> -DEF(ID_AA64PFR0_EL1, 3, 0, 0, 4, 0)
> -DEF(ID_AA64PFR1_EL1, 3, 0, 0, 4, 1)
> -DEF(ID_AA64SMFR0_EL1, 3, 0, 0, 4, 5)
> -DEF(ID_AA64DFR0_EL1, 3, 0, 0, 5, 0)
> -DEF(ID_AA64DFR1_EL1, 3, 0, 0, 5, 1)
> -DEF(ID_AA64ISAR0_EL1, 3, 0, 0, 6, 0)
> -DEF(ID_AA64ISAR1_EL1, 3, 0, 0, 6, 1)
> -DEF(ID_AA64ISAR2_EL1, 3, 0, 0, 6, 2)
> -DEF(ID_AA64MMFR0_EL1, 3, 0, 0, 7, 0)
> -DEF(ID_AA64MMFR1_EL1, 3, 0, 0, 7, 1)
> -DEF(ID_AA64MMFR2_EL1, 3, 0, 0, 7, 2)
> -DEF(ID_AA64MMFR3_EL1, 3, 0, 0, 7, 3)
> +
>  DEF(ID_PFR0_EL1, 3, 0, 0, 1, 0)
>  DEF(ID_PFR1_EL1, 3, 0, 0, 1, 1)
>  DEF(ID_DFR0_EL1, 3, 0, 0, 1, 2)
> +DEF(ID_AFR0_EL1, 3, 0, 0, 1, 3)
>  DEF(ID_MMFR0_EL1, 3, 0, 0, 1, 4)
>  DEF(ID_MMFR1_EL1, 3, 0, 0, 1, 5)
>  DEF(ID_MMFR2_EL1, 3, 0, 0, 1, 6)
> @@ -23,13 +13,40 @@ DEF(ID_ISAR2_EL1, 3, 0, 0, 2, 2)
>  DEF(ID_ISAR3_EL1, 3, 0, 0, 2, 3)
>  DEF(ID_ISAR4_EL1, 3, 0, 0, 2, 4)
>  DEF(ID_ISAR5_EL1, 3, 0, 0, 2, 5)
> -DEF(ID_MMFR4_EL1, 3, 0, 0, 2, 6)
>  DEF(ID_ISAR6_EL1, 3, 0, 0, 2, 7)
> +DEF(ID_MMFR4_EL1, 3, 0, 0, 2, 6)
>  DEF(MVFR0_EL1, 3, 0, 0, 3, 0)
>  DEF(MVFR1_EL1, 3, 0, 0, 3, 1)
>  DEF(MVFR2_EL1, 3, 0, 0, 3, 2)
>  DEF(ID_PFR2_EL1, 3, 0, 0, 3, 4)
>  DEF(ID_DFR1_EL1, 3, 0, 0, 3, 5)
>  DEF(ID_MMFR5_EL1, 3, 0, 0, 3, 6)
> +DEF(ID_AA64PFR0_EL1, 3, 0, 0, 4, 0)
> +DEF(ID_AA64PFR1_EL1, 3, 0, 0, 4, 1)
> +DEF(ID_AA64PFR2_EL1, 3, 0, 0, 4, 2)
>  DEF(ID_AA64ZFR0_EL1, 3, 0, 0, 4, 4)
> +DEF(ID_AA64SMFR0_EL1, 3, 0, 0, 4, 5)
> +DEF(ID_AA64FPFR0_EL1, 3, 0, 0, 4, 7)
> +DEF(ID_AA64DFR0_EL1, 3, 0, 0, 5, 0)
> +DEF(ID_AA64DFR1_EL1, 3, 0, 0, 5, 1)
> +DEF(ID_AA64DFR2_EL1, 3, 0, 0, 5, 2)
> +DEF(ID_AA64AFR0_EL1, 3, 0, 0, 5, 4)
> +DEF(ID_AA64AFR1_EL1, 3, 0, 0, 5, 5)
> +DEF(ID_AA64ISAR0_EL1, 3, 0, 0, 6, 0)
> +DEF(ID_AA64ISAR1_EL1, 3, 0, 0, 6, 1)
> +DEF(ID_AA64ISAR2_EL1, 3, 0, 0, 6, 2)
> +DEF(ID_AA64ISAR3_EL1, 3, 0, 0, 6, 3)
> +DEF(ID_AA64MMFR0_EL1, 3, 0, 0, 7, 0)
> +DEF(ID_AA64MMFR1_EL1, 3, 0, 0, 7, 1)
> +DEF(ID_AA64MMFR2_EL1, 3, 0, 0, 7, 2)
> +DEF(ID_AA64MMFR3_EL1, 3, 0, 0, 7, 3)
> +DEF(ID_AA64MMFR4_EL1, 3, 0, 0, 7, 4)
> +DEF(CCSIDR_EL1, 3, 1, 0, 0, 0)
> +DEF(CLIDR_EL1, 3, 1, 0, 0, 1)
> +DEF(CCSIDR2_EL1, 3, 1, 0, 0, 2)
> +DEF(GMID_EL1, 3, 1, 0, 0, 4)
> +DEF(SMIDR_EL1, 3, 1, 0, 0, 6)
> +DEF(CSSELR_EL1, 3, 2, 0, 0, 0)
>  DEF(CTR_EL0, 3, 3, 0, 0, 1)
> +DEF(DCZID_EL0, 3, 3, 0, 0, 7)
> +


