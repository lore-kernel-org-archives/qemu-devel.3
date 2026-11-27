Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D8C606A31F
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 16:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=QycwG4mJ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWyM9-00032P-KK; Fri, 27 Nov 2026 10:59:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xWyLV-0002yJ-TG
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 10:59:01 -0500
Received: from mail-yx1-xb132.google.com ([2607:f8b0:4864:20::b132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xWyLT-0003vV-SZ
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 10:58:45 -0500
Received: by mail-yx1-xb132.google.com with SMTP id
 956f58d0204a3-67dc7eb1442so8967781d50.0
 for <qemu-devel@nongnu.org>; Fri, 27 Nov 2026 07:58:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795795120; cv=none;
 d=google.com; s=arc-20260327;
 b=pg38OdUS1+wQ2giCkVNJKAfKTI0DNrfILtX/vg4UVDibjJl7F+9CB4ZF26583hUHrD
 Axo6dJDXoYU6tn1PfiryfgnLKrwx7/5ZrZgR+unbf5FP4wa9dvnS66ebOsxUV6q81hjt
 rtGnZPXGAtrRI+9WGd7uPmeiWckYB4gCPajEYrVX259DNdaYUMY+Az1IoeoRkxnLzjvS
 /tuSUNOltqcC5GiSMGwM681cCYJsKtET2KkUh1FU2nlTKMW0WKSZTaBvy2ClXviDzolG
 dwcM3mCzzZQPQ1YvGx3gNHRXma1fjT/Iu9H8B3wW4DEESC3ZbE73knEWt4cfATDFLXVm
 KMVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=eYLK3VnoQy1h0HHjLJQ0vb1q1uHf1xQ83x42X7r/mKY=;
 fh=Ox8XejlXvwDCsEwczJmG+K644NQuJfcWGfIo0cR6yQc=;
 b=hYsOeDvolFHyxVxpRjme9gYGIstjlYWcrzNYdPv/G9P8ZIcx8xCntPPIb4AOmxNApg
 BuIkoJqeYd8yH/4Zs2wNhlQ1FmZmun/yMym6OMVJwo/MFG6TEpe6kRHEzMrJokSikf9E
 kssvw7rsLwXBP2YPIJ+lSqETYaWjbNPf32UuL60OgeCuu13oYermOykT/VF62vUge0Jm
 QXWFni8jAXxJB+Z2/EW0jA5w1Ct421nr8iiY6AoLCWu8C4gJIsKasyf6U9ttBWh895d8
 XtPHRZAwvKL+QJ8bbRerZKxaljrkNKuV32Ug1d3ELwk2CDt7wPtNCDjLYPewaoMEwShI
 ZzNw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795795120; x=1796399920; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=eYLK3VnoQy1h0HHjLJQ0vb1q1uHf1xQ83x42X7r/mKY=;
 b=QycwG4mJNlG7yVc5YoHBBLnR3Y6dVk9riHj2Om/ID30hSKvjyVEuFcRAYOSkYpN1Kw
 wL9CdD1h4hP7qDejCNDoEgoO4K2ecnt9G7ADvu8wl1aHQkjBJ4RVB8dxZVflUNAz9l+d
 4K9VSH0LadyczNujRl/pHI3PZWUPo9q5B+KKCH5bDhZjfDawYYGL+M9HwZQqjIqkShcl
 x554zET7enHswaUqlFU5Ccen1lSYBgKK3nrgQ9tJWX98aoN/7OhEZd5YwEw4DFh5mh94
 cnU3uwWHrLzX4gAVwvgsqY2fyBCJYaiCfq6kLJ6yZyVOyVituSEVfg4hSRHwRSMxalyh
 wX7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795795120; x=1796399920;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=eYLK3VnoQy1h0HHjLJQ0vb1q1uHf1xQ83x42X7r/mKY=;
 b=eGpkVq2yYU/ZCzm9yeT3aEoLKuMc/pRN/9ZCRM6I170Um/ZctVSAwAYzIB1fnTvV1b
 EkUjVgegamD5oHSGMO8Mo5KYqRu0G+nyYFnMnpjga23iMITJTC7HEdWGUNS2yT14hDAy
 IUR7mBOQpTmfcQ6qCMynprY+3A+6yqM4bW/htiuf3KCBBsiQg+ZfKFMW+rNe6Zi0G1dw
 v7LvkTe77L2ODN43tKXH41mhGNKEraCR+d11T/Tu1ywF/0SHv/Y7P2oWKOYVlFYS0Vq4
 HFOMNdwe80tPwu5EJ8FdOslmVfQE65boWHcl2fei88lSLtY6kSc062wcB8AgzqitdLjw
 vXMQ==
X-Gm-Message-State: APuU4Z9B3AsEwBuEZdlq8NQ2MjWL5ONapWgs2NKGV2x81KrQSD0V0p2W
 uYIJRpG0aWnv4euK2JAdMFKRrgFr/laDxkTFNqWaS55V3aZAoaNClewZM1GjfpV7NVcoEe3N4aE
 LXbki6JUVHBraA0qIQQ1MY5V4emM7Zs2JUWOQ1Hv0cA==
X-Gm-Gg: AZFdTZc1P0Y9SJSFlu/GTYYRZQ65wKs5wI4Eo4wkMUiFegEFFKAu0W5ZrpMWOkR7rN/
 HJHTszIBt7hcaE5I4dbyDgnaVhYmDQW4XXT9RnsUdjkLVS+PlDN1cKSxipsm4sW3nGd0AlIOuSK
 9G0hQpSDE8uZnfXtEVHJBwguPhwm9DfqVmShYFXPcFc/2o2YQ3FxPRsColGDQnIQSUa3vl8GRwp
 p4LHEdmmNJkWUn3JaldhZM0NWWSHKDNlyRA1SItdvfZfIWWJACoXk6J2wjhqg8CKh+cKzSmgQpc
 MxyYzHW1a3RRFCUZ+LfMLJzpFb2O2jtXm706nZyHJxYIhFGV1/Fa09U4x/VJO4YRn1CDDU0SqZx
 iauoI9y9QfBliyDxUOwxe5huVoJX5siBKjodNEzkShyWd4vs7r7196Fcc2SBmefIwGXaN9JJUXc
 k6+Va5i8PsmwAHO28EHld7
X-Received: by 2002:a05:690e:1385:b0:67c:2674:ec72 with SMTP id
 956f58d0204a3-67df42b4b16mr13303812d50.4.1795795120277; Fri, 27 Nov 2026
 07:58:40 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261030185551.193092-1-richard.henderson@linaro.org>
 <20261030185551.193092-6-richard.henderson@linaro.org>
In-Reply-To: <20261030185551.193092-6-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Nov 2026 15:58:28 +0000
X-Gm-Features: Aa3M54qzeFZEdHRbMUOd8HkPirord4FWKFEvv-t6zbtZJF6Z7LPmJN9SEx8mHJc
Message-ID: <CAFEAcA8Ez7N_EZpt8ra4beMCTWsV2Tsk5xgNpAm1772w6eSD1A@mail.gmail.com>
Subject: Re: [PATCH v7 05/14] target/s390x/tcg: Remove DISAS_PC_UPDATED
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, iii@linux.ibm.com, mattst88@gmail.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb132.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 30 Oct 2026 at 18:57, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> This value is unused.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/s390x/tcg/translate.c | 9 ---------
>  1 file changed, 9 deletions(-)
>
> diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
> index ce55edb93a..3a29555605 100644
> --- a/target/s390x/tcg/translate.c
> +++ b/target/s390x/tcg/translate.c
> @@ -1025,11 +1025,6 @@ typedef struct {
>
>  /* Return values from translate_one, indicating the state of the TB.  */
>
> -/* We are not using a goto_tb (for whatever reason), but have updated
> -   the PC (for whatever reason), so there's no need to do it again on
> -   exiting the TB.  */
> -#define DISAS_PC_UPDATED        DISAS_TARGET_0
> -
>  /* We have updated the PC and CC values.  */
>  #define DISAS_PC_CC_UPDATED     DISAS_TARGET_2
>
> @@ -6397,10 +6392,6 @@ static void s390x_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
>          break;
>      case DISAS_TOO_MANY:
>          update_psw_addr(dc);
> -        /* FALLTHRU */
> -    case DISAS_PC_UPDATED:
> -        /* Next TB starts off with CC_OP_DYNAMIC, so make sure the
> -           cc op type is in env */
>          update_cc_op(dc);
>          /* FALLTHRU */
>      case DISAS_PC_CC_UPDATED:

The last use of these went away in 5331339651d ("target/s390x: Raise
exception from helper_per_branch") in 2024; all the code paths use
DISAS_PC_CC_UPDATED instead now.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

