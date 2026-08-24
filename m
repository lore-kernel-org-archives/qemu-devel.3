Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3F66C5DF9C
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 10:43:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyS96-0008Pv-K8; Mon, 24 Aug 2026 06:43:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wyS91-0008PH-6D
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 06:43:11 -0400
Received: from mail-yx1-xb12e.google.com ([2607:f8b0:4864:20::b12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wyS8z-0005dl-IU
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 06:43:10 -0400
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-66c82b32121so4798287d50.1
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 03:43:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787568188; cv=none;
 d=google.com; s=arc-20260327;
 b=aAmyQjsYXfJoKKTB+AlNkBP+qRw1bDcMqk2fZrVuizBVxxsmJOt3qK1QeNba2N87Jh
 koyVvCmJN9V7bALJJnoif7vMgxX8JRs96lugSADKgsL1mrSl1V2ZCRU2url7oV2g3lcK
 ZBiNVc14SH2aRQ5qOfXHMzz4KYNS3AFHgXKRwCpeliJOSXxGAD2+ve0S+9NGsRdksb6G
 IeVXDnUI8auqkEQpwz9EGqwkRPtbNNRqLW8XThvK+FU/X+o1mfsyW6f9K7+ZKDqAFeQq
 enezKyhkXq6WLCg2CMDVz5+RKUvoWSsDNRGHDMobQx2dbJVDlUGH3/FfmlyZfno6rcyM
 klvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :dkim-signature;
 bh=asuRtl1zHe/+aUY58NMVomp87dqiRzLQvVILhFYgao0=;
 fh=cxIbHr1HE7sx/NNLpPAPt7h0ceuP31zMm7eyudyi2eU=;
 b=bzc+mK0k+6gG8y4cjWx8I10DZ4Ral9vKMULEn//5RandrdSUTHjRZq/aIKRQddeaCM
 gAKWjx/0vQWGCSCRtiiz8lkAyUrY2QuKNaPM1o4cNgi3YOtnP0PXsC82uoH1GAdarp1V
 1ClGl6AVRD1HuUVhPg6PIewGgqHKJ7u7J94P2sP6q7wBUr/ZGKj3FXKS6LGoF6m6i+AS
 XpbiNGcEfdK+/I+4d3VzGiWKDBNSfQlVo00Q0g4l7WPLq2MWc9WCgnyLJhMuylcdoBBT
 kmUoQx/WBLPwvMrbOh+nazUTelEqK2n8ia0HRhMGvXX7Fhn2SI9dmEEiqERlFn2AB5s6
 Dsug==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787568188; x=1788172988; darn=nongnu.org;
 h=content-type:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=asuRtl1zHe/+aUY58NMVomp87dqiRzLQvVILhFYgao0=;
 b=rfmuMBSkOyd+AkMgw064maQjyi7IEsB0Hdi1XYbR3fZHsJbXRwouiJYcoFg5T9wQbu
 iT5LSJKWLfEMX0eO/b1RMhM/qPr7riP0U1xVRKpTwinb/uDDHWHhf33SHzdBUBCWQ0Ml
 VGtX+mvUSKqO03DHvOBedf3lb6ZxQsdteBdxO1EDJ9XXeF6wIQV3i85d/vLKmQB9rM5D
 Nc+at5n5byv/++MIs/AZUYjITPpa2xbqYgsU0uoJvFCL7hUImcWyEmUaQQG7Ps+Gx3oc
 0N/DNs7jse72taIPXzt3yNz6ZPya5cIZzTS0yMZ1lvTXh2FGy4fm2DCMN6svlaLKnrGX
 hlyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787568188; x=1788172988;
 h=content-type:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=asuRtl1zHe/+aUY58NMVomp87dqiRzLQvVILhFYgao0=;
 b=IkyVUITWAFUJYp61pHd0Y2UjCt4IJKiKWJzRaUstgszEW2Z2wemcEONVbcodjiAoT/
 VjwHItBavQcvqBd9IaUGf+3oP+/rmmCy1SsyVAqK2xvIl0+IP3aDFQdUabYln0QKKLfS
 pFa2vXZERmPP/EJTg/fvfmxyGSXtc6xYbs0mGjU4IS2I5QIta4cSldV0IzGUt9yuQYnb
 TcpCaSOCViTvLPDmicCcDMnLZYm1AiNgmQ7XuAz0wkPMEZXpOGLtBoJXoCB5HsCPDWd/
 W2RiilBGJxvzmONqePrxqgV985++TF20OqfDOwS+X+0aLbLzvO03QyFyVMz/qMJkN2Sv
 tSMQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RotfET5pykrMNB7zClzeyndrwAPPaxTW+nGXjYy8OkdHiq5Em3TFW5m1TBd1sc4JAMLckiM+gjicvB4@nongnu.org
X-Gm-Message-State: AFuF++kYdOpYp06VA+alr3kC+8yuZlfy5pgRLWyZDUGNi7sookuBicga
 WQ1DDHLv7bWGlQpu4+IM4+EUOrq3+InohmmQ4T1ZFZHTRcgJ4JaXdveoPT0Kn9GRHXOnSTO+w7a
 II1GqlNrZdk4y6ClYbLDEN+njPNxYOjDlyRZCCDTnupCuAkiaZL7kM6E=
X-Gm-Gg: AR+sD138jJdc8cIfAmFceGyOI3bgj80wzUNa9q88DM22EDJxbBeexemFWkMIAua1bV/
 CvIz/DZqjj/NXOs2tGAkXrrbBlAyefSlbYmCcvBQw/QokZr5l/MsGfxw5QOeSFqJnf4BUHQ3RCr
 VXpWK5Wm+zLhFuFseH2BWq1NEV7CTCm+dGBCYBjx//1weYQceBaNBmcyvStIs6pf73b4E5t0hbC
 pj8N39Zo90OIlQ9LBW1sf8g1ZC2dOF5djG0U19BcAHd7jItYvf0QIzOCEG0FEfAVnKMo335ZxB/
 hlB7ilaLoLmpi74Ji2P1pUdkZkYnj6CA1TqdwhkOxag5k2ngMTu3c6IqGvKKEXcmPa8roFqtKrr
 3Hw8dC3Xil54k5ynV61Z8WauqbzoC
X-Received: by 2002:a05:690e:144c:b0:66c:f6a3:32a5 with SMTP id
 956f58d0204a3-66cf6a332d6mr4985477d50.15.1787568188333; Mon, 24 Aug 2026
 03:43:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260824102805.639072-1-peter.maydell@linaro.org>
 <20260824102805.639072-3-peter.maydell@linaro.org>
In-Reply-To: <20260824102805.639072-3-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 24 Aug 2026 11:42:56 +0100
X-Gm-Features: AcwNN1Wanb0eIUgALoE0LNplv9wNHxuKpl_wreP3FI0AMEh5gOdDEmrTLsMggSM
Message-ID: <CAFEAcA_HM1jTVfSn8TJNT5GwNRm531hraLvBJ+VUmd9au7BcyQ@mail.gmail.com>
Subject: Re: [PATCH 2/6] hw/intc/arm_gicv5: Ignore low bits in L1_ISTE.L2_ADDR
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12e.google.com
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

On Mon, 24 Aug 2026 at 11:28, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> The GICv5 spec defines that an L2 IST is always aligned to its size,
> by stating that bits [N:0] of the address are 0 where
>     N = 11 + (2 * L2SZ)
>
> We were missing this check, and only aligning by applying
> R_L1_ISTE_L2_ADDR_MASK, so we would only enforce 4K alignment even if
> the L2 IST was 16K or 64K.
>
> Add the missing masking of low bits.  We already needed to calculate
> the number of bits needed to index each byte in the L2 table, so add
> it to the GICv5ISTConfig to save having to re-calculate it later.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/intc/arm_gicv5.c         | 6 ++++++
>  include/hw/intc/arm_gicv5.h | 1 +
>  2 files changed, 7 insertions(+)
>
> diff --git a/hw/intc/arm_gicv5.c b/hw/intc/arm_gicv5.c
> index cdc6c9d3466..20680a5c225 100644
> --- a/hw/intc/arm_gicv5.c
> +++ b/hw/intc/arm_gicv5.c
> @@ -595,6 +595,11 @@ static bool get_l2_iste_addr(GICv5Common *cs, const GICv5ISTConfig *cfg,
>              return false;
>          }
>          l2_base = l1_iste & R_L1_ISTE_L2_ADDR_MASK;
> +        /*
> +         * The effective base address of the L2 table is always
> +         * aligned to the size of the L2 table.
> +         */
> +        l2_base &= MAKE_64BIT_MASK(0, cfg->l2bits);

Here too we are missing a ~ .

-- PMM

