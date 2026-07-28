Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B21EEC54F4C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 15:23:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wojeZ-00016y-Fh; Tue, 28 Jul 2026 11:23:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wojeS-0000lB-E7
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 11:23:28 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wojeP-0000MD-Qy
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 11:23:28 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-c197f968b3cso572857566b.2
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 08:23:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785252201; cv=none;
 d=google.com; s=arc-20260327;
 b=WQAgsdbrNnSa2fbr1XmPR6KX3Kr6n80e3pC2DHU7m0YTcBbHCKETNQRoqpWhfX0uPp
 mnBMIDltGNUnHKouGRGjyzzwDNtmciowBa06NGT9oWtLD93GcfxTyTsZh94d+wrBuSHt
 xE2mQMAoAjMvVhoMBa0BcjiKLTYbbkKE/iYN3gwlczXbvuelRvf+5sn/ud2zPha/0R7p
 aiCBZnSfV1UDLSncCuoHNvjffvQZEZIZ4ly1vQpp9nmHBuu6NTqjAaZSDWxPr71bgdft
 dl02eKdXv0QcqvT8Uo/Qj1nA7STndHXxtwssPpi1/mmXJz1OzcWyOmCmXoGQcj6k8Gl9
 ZRaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=3D9cl0lpRNgws1XwyCCcUEGTjvGjvczqkgCPVzYz//M=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=BBiUUgsJsV5CpziidhXj1JKlhyIapZHj/eDZgvFLWIgWlNwQPTNuP3cQIXzBN5ubmu
 ahzcNDqdk312SGI371lAy+IXSWoXNuhRgMEUf58wcaYFGk54UsfEKRasBN1cyfAK8Av+
 90m/yFKsENf3BdHc9wULIhtAauglbhXUYA5FOtt8mDmVtunhQCAmxT7M5wNOIl8RAB5M
 0nDMgPPA1gxK1V38/zrw3zJzcYk7yumAQXvWRH+cXOj2a3CNOm2WnnbsAnbRx6sB7l2j
 BVH7V4a0sK4JweeHAIug8JQDjoXLvUMo4+1sYC5uzC+RPzNAj/XqlJKDWaCRg0wUez8v
 CuSw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785252201; x=1785857001; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=3D9cl0lpRNgws1XwyCCcUEGTjvGjvczqkgCPVzYz//M=;
 b=goaq7mqBH8TexDGStFBtMmXTW9Yl9suV2sd15H8wo56JHqqgzIiJuwMZd1F4YYL+Oi
 wUXCGznQPE9f2L14bbMlPdQ729Gvk57RdqkwzArORW/8SyKOtux4rsqqecC2N3/L98Xd
 rX8Yq6IODDkSPE/CkG/2dPM02ecMPgt4AIEbZze9k1+tdQocNNTRq0DmkgLC3WjnO31P
 WtOOu8nBl80tJTv+vo3lK+g0rgK8tbqbI/ix+2Q6AUyCnaeaJxBqi+jyoQx6yiRBQCJe
 ZMwWNTrBcAmkraLbSR10fVYO0qlHXyH3iQNmg0elMyiP7gMqtdONwi5VhsXdACXj+1Kl
 E99A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785252201; x=1785857001;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=3D9cl0lpRNgws1XwyCCcUEGTjvGjvczqkgCPVzYz//M=;
 b=NT0yyLyzQQBZ7peDw9iPOtIcrsTn9Jq3B/e3uF1+lVBWcBdgNxsjdgQlrrn+QBsj6X
 9z6U2X2utY8mabwRoeuwjPWBxlX2rQYiKfJnBJi5/cxzpPDNnPwuOyMdcxgcnCwdnVfH
 SfazA1mNEMTZlS60DqOf3fDIREmJwxftixJeEK1A7R5R0V2uXPmwokzx/nJHenM4F7sO
 Kmn4s6EBEKsRrFd4obkhnx/qNFlsRihkaaH59JRGNMnEOH94ItEjaGGQr5es9f7Qqvid
 FcnyqdBmnN45btnL2C1tncS/KxuvB3p3+RhXR0bYABk6qnBt/SbnMsjfQwYDl192vSHL
 8VJg==
X-Gm-Message-State: AOJu0Yywxo85dKb9uOCGVYEQFYxCZDiJzpp0CBDacUtjAeFxvi8aFbZ0
 xCjYzslHoGUseUjLzMyZZUx4kNYp4QA6/MQ3gauxlFTMitk+2pXtHGsbTEgVaCIG6Pq0WB7DhmK
 SVLPO7o0FstouW0xGtd0V7X5p1cis/LAk87NZul1JAQ==
X-Gm-Gg: AR+sD10NFnR2c3Tq0d3gP3Lidu0XWo2ZF1+uoQckg07yXVMxFtItE7JIKYYxtD9rTft
 5mGFvzX3oG2AWySlBwHCW66BM0RiNmJSkwV2i/g9XWpE/fJBAEZuNj7lnNUo+GO90tM4ZR/te1d
 ukIX6GVN0qnn3FwauU5N7OHJGwITm+vNVpnnKXBEvRk7pMGx5Wmpbf2pH85+Q0NC4rwnwc5NhNs
 GdO4FRQh6lT6VUFeaXlNUXOg0oYNMKMZZpRFMJ78/gxQSvMuAYEmPSuZI0kQX8Ejvqp1y8HspA9
 LcU5VF9vv16vCcATGshKYlsGgyFD8tC68chwktNa2d2Mog==
X-Received: by 2002:a17:907:8b87:b0:c19:6ac7:89a3 with SMTP id
 a640c23a62f3a-c1f7221e4d5mr154431066b.37.1785252201276; Tue, 28 Jul 2026
 08:23:21 -0700 (PDT)
MIME-Version: 1.0
References: <20260721184656.530230-1-richard.henderson@linaro.org>
 <20260721184656.530230-5-richard.henderson@linaro.org>
In-Reply-To: <20260721184656.530230-5-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Jul 2026 16:23:06 +0100
X-Gm-Features: AUfX_mzb08mrtV5D-0Uf6X1HcfPyZA_M3dImyQREw1_zgg1lAtHnr6NWShOR9jY
Message-ID: <CAFEAcA8PA37omSTHFR0WDnT7TE6nNqdNofLJ2iOaqwHNob5HkA@mail.gmail.com>
Subject: Re: [PATCH 04/20] target/arm: Remove DO_ZPZZ_AH_FP_B16 from
 translate-sme.c
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x631.google.com
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

On Tue, 21 Jul 2026 at 19:52, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Expand the macro at each use site.
> Merge the two arrays and index by fpcr_ah.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

