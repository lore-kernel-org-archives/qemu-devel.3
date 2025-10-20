Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E4C1CCD199
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 14:35:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAqyA-0008KE-JD; Mon, 20 Oct 2025 10:34:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vAqy8-0008Hv-1H
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 10:34:40 -0400
Received: from mail-yx1-xb12a.google.com ([2607:f8b0:4864:20::b12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vAqy5-0002Bi-C6
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 10:34:39 -0400
Received: by mail-yx1-xb12a.google.com with SMTP id
 956f58d0204a3-63bc1aeb427so4625988d50.3
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 07:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760970874; x=1761575674; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7UwMaxirHap1HZypl22fJti1ssipPMA7weTK45fA2uU=;
 b=pyTLZVUNwQW4Jx3CFyS4S+34Tn4olq4W37a/+7TRF0P6ZMTLRx1+Fw0YnfwyzcHex0
 5AUDZd/c0SduJIxd1jw/uTvzJUzJQF7thf4MfnQmnyzLtJ1Ai3HVswnMCSnSRy23VGFe
 2WwBLMo0+1kyZnsgmMcl6LoIc5uSOAAtN6Un+3krp/RoziBN/05fTpRUCpHnc/RfkaiS
 VdKOXQdWX7pCegnDnXsLZ4cLXCabh82QY95k+TJrPB2vMb39jLM+blir6xwX7mu7n6OP
 ZInrvNtps3eNnCa1SGdEZK2rUOXAG8HA0odWxr6Xgs0WXP6nJ2o9c+MBfDv7G9QlxbZE
 jNrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760970874; x=1761575674;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7UwMaxirHap1HZypl22fJti1ssipPMA7weTK45fA2uU=;
 b=Ez1WmCqBHOopeBWXFWMDfx8NEzW31uApBoQbOdiOZWHbA/s+8rV5WSeNipioOaJ1E4
 Lr+F6UFbIOBhfFUjLzO2dy4cR/vE81rksa0WL1EF+hkatxrwF2JvF6VR/2EjSsCVapTa
 /xPM8R0bfsszHgSNX1q4SHzsSnLW2LnSC9L+xjhPgwI7V/23VXwoZChhYDTSvYJ3XXBP
 t2fmVGR2vA8TqI3PwKgmLnXsLUU3YhQ8Raz9dAi1ylOv8M0dU3OwzxACsHOJ7DBDFLDy
 /gGku2h0D5DA9ecDOFfMimqCw7+cvsTqDbxI+la+gAoOwutgjrjeBrwRpav6ifjznwWa
 mYcw==
X-Gm-Message-State: AOJu0YzxYxSwDfhJfT2zdZm0Fk/dY//l0ZfEbaQMJqhh93M1emti1mkP
 b2xFuHntRQGlLXyzWbmLFYRMllW2r4lfjmSMKPdTtB4Dc9Cg62GM25DUXWG3UYFa/CMSHB2jhZF
 DX/Eh0ZxTS/6qbHmVWfcNcQBPjet/M0Qn8AmiO68Kmg==
X-Gm-Gg: ASbGncvK8d0JTynkT/x1jg3tkSKwohVng0u2JROqhWssaQebzHySY+JynKrEq1Mxmf4
 AZj3vPsufrHsX7h+S1Hrar2Y6jRC/jqIPxPhmmzJVm27VbhjodAfdy91X5H24sCChwYwAwKo0Nk
 JwvuQh9G5Ia6Pksn2SClWC16XgKMCeU4rqsLFbTOCcj7E1rdE9YC+PlXLmpP8mDiGix0HVnw1Yo
 AJr0GSrluBEFu2zbEiyYiUcKrxYQtz2Zhd8ew65uROH/vy01wCnvIk0iAplQw==
X-Google-Smtp-Source: AGHT+IGWG0T7+WHOeVgwf6/s4jgRPK7qnnyrCYPlKE2niqLLNqGkozk5lCUJbgxrrZfQAkGwmX7f6FATbQuxngkXa9g=
X-Received: by 2002:a05:690e:241:b0:63d:a5d0:f30a with SMTP id
 956f58d0204a3-63e161dacd3mr7971787d50.52.1760970874205; Mon, 20 Oct 2025
 07:34:34 -0700 (PDT)
MIME-Version: 1.0
References: <20251014200718.422022-1-richard.henderson@linaro.org>
 <20251014200718.422022-27-richard.henderson@linaro.org>
In-Reply-To: <20251014200718.422022-27-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Oct 2025 15:34:23 +0100
X-Gm-Features: AS18NWAyEo_TezdXhexZgv_2ED9AUS1iJWrcFDQNaMTeDO2_3vBUj47XCTA5APk
Message-ID: <CAFEAcA_8SNoUhPHROyDEPH4y58Kdiy7bDhCF3kPQsNFLAkaMNg@mail.gmail.com>
Subject: Re: [PATCH v2 26/37] target/arm: Implement TLBIP IPAS2E1, IPAS2LE1
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12a.google.com
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

On Tue, 14 Oct 2025 at 21:11, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/tlb-insns.c | 26 ++++++++++++++++++++++----
>  1 file changed, 22 insertions(+), 4 deletions(-)


Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

