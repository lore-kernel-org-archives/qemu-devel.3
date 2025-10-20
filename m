Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96E6ECCD193
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 14:50:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vArDV-0008Qz-Cy; Mon, 20 Oct 2025 10:50:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vArDT-0008PY-Ty
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 10:50:31 -0400
Received: from mail-yx1-xb130.google.com ([2607:f8b0:4864:20::b130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vArDR-0004Rf-JJ
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 10:50:31 -0400
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-63cd60ca2b2so4587745d50.2
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 07:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760971827; x=1761576627; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ndRZkqcU56h8E7a0PHlhQiBdb/If24Z16pIA7ywxeMM=;
 b=XQ2WnCUrbS4tIRGB0KftWDawrjP11oEFzcU5UKbrbWizZlw9PfqxDmZxDm/QVUIFKv
 Ccv9AVvmj/9Nb8GXIs/APFehFYHg5OWGfv9dw21i62EjC0Rx/3ZTPVZ2BU0LCaYbOzY4
 l/PYGKHwkRmc/hNvvrVyrZXXLBjqu/GhvmKsSRHllbXzhtGzvwHdXQx78Bm07ka8O66i
 1jZ5wX9XLek9LbcsGcZ62DkGTBgPS4iXDwNOWBNg3FlnAVEbQgjUb9CST1uIH731JFFY
 o4wiOPnMRSyeW9+d8ZHkYloAOQ/bJxj5EoTEuferznMJZj7noWZNgyhdFtsC6y1ZTsll
 5evg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760971827; x=1761576627;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ndRZkqcU56h8E7a0PHlhQiBdb/If24Z16pIA7ywxeMM=;
 b=OJcAUadSN+f8pgO2GBLkn23WcNV3vm3GSxz2LuN+ZxNqgUl1dOZZJMdiick/CP9x01
 90GvUbspWkL0x7gjga/6wKS+O6B8zoWjzxRyhN/GeYVFcEtI/QTqeC59R5DRpKtnBTla
 2mCDVQXZhHqBl3gRH1BpKPiLaDtpyw9na1iLW6520w/QVIdMguiyEJHIsU3UZzwdqe23
 ybqqZMd962FFnO+RRP35OVk22KMTYU6QjPicmnLolbiwkUfi+fCT4B/408JZd2zyA+3v
 iWBKExxJLaYkPXr9mY2MecnA41groXPCW36RunMl956vYesPXYzw3ogzgl8daZvSmVZx
 9nIQ==
X-Gm-Message-State: AOJu0YyPmRfcyGfRrSwmPsqxzKXHYTSJGBO60TQKmmzH8RtfCEc7MGSN
 1nB6VQTHkSeu9XN1N/gMlrFKM8rrKymCrKZmwGDwLtIs6MwTECbbX7Y+ciE6FT01+gsYskJJmRY
 /NJPSSgrNu/SvpcX9GWI0VKcKiCyqUW2SfDyiZtMWDA==
X-Gm-Gg: ASbGncvT5JXkJo2f15ZJoNsI2xWFFW2VUAKLGecDAsiinHDI8NimC/qU5qe7MESVg7v
 0ZOmCrthrLzjSqxBzwjQJKpw2fsz9ERF2GQMN3UdEHfytFYq1GNRme/pt1I3ipfMsAepLValPas
 65mm5NwMdrJHo2DcLUWIvRsJVfqnCTnr6up7Htsnwulz72Le87w9vlBdP4KC39hqBJPDBjXSorx
 ROxT22JEqWDkoc5S+xYKVITyR1CHR8wpUnkbH0hpQJtSVHD4gYQ7SdXS0ldtbTY+Yq3Kv6S7DUk
 e/qyzPs=
X-Google-Smtp-Source: AGHT+IHEGT8WEyne+HAhaYxprJ90OJgGfruhhepbboRmcpLxjZ2b7J3v28t4UBCDzuORvy7FXMqFhiBhWzT5mCMkHNo=
X-Received: by 2002:a05:690e:408b:b0:63e:221e:bd38 with SMTP id
 956f58d0204a3-63e221ebe30mr8741397d50.64.1760971826947; Mon, 20 Oct 2025
 07:50:26 -0700 (PDT)
MIME-Version: 1.0
References: <20251014200718.422022-1-richard.henderson@linaro.org>
 <20251014200718.422022-31-richard.henderson@linaro.org>
In-Reply-To: <20251014200718.422022-31-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Oct 2025 15:50:15 +0100
X-Gm-Features: AS18NWAYlZQZ0kEvYCaJjGuAW7Voyhqa4k-evTfWOg8HX0IOgFpMNHMXyEphWAg
Message-ID: <CAFEAcA_Zb8BbCRMC=y4o+1fD=UKbkZkzg1VbLb8XiqKL70=f+g@mail.gmail.com>
Subject: Re: [PATCH v2 30/37] target/arm: Implement TLBIP RVA{L}E2{IS,OS}
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb130.google.com
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

On Tue, 14 Oct 2025 at 21:10, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/tlb-insns.c | 52 +++++++++++++++++++++++++++-----------
>  1 file changed, 37 insertions(+), 15 deletions(-)
>
> diff --git a/target/arm/tcg/tlb-insns.c b/target/arm/tcg/tlb-insns.c
> index 6c07839e3f..cbab7f81f9 100644
> --- a/target/arm/tcg/tlb-insns.c
> +++ b/target/arm/tcg/tlb-insns.c
> @@ -1031,11 +1031,16 @@ static void tlbi_aa64_rvae2_write(CPUARMState *env,
>       * since we don't support flush-for-specific-ASID-only or
>       * flush-last-level-only.
>       */
> -

Stray whitespace change ?

>      do_rvae_write(env, value, vae2_tlbmask(env),
>                    tlb_force_broadcast(env));
> +}
>

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

