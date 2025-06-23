Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 527F7C77B7F
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 10:20:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTeI4-0004Ic-On; Mon, 23 Jun 2025 06:20:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uTeI2-0004IH-LY
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 06:20:38 -0400
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uTeI1-0008U8-4P
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 06:20:38 -0400
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-7111d02c777so32443847b3.3
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 03:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750674035; x=1751278835; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1bTvNO/R17rOdYWeDuIOmyTAd1R+AlfUESsJshkB6Q0=;
 b=FStW5Gw8GeaapAwUt+pKmB6mPJj6iDf9YWq2xIEwOEowREU7E8ZoHYCQOSCYFyljTM
 85HI3tQapp4xaQnO4MY+dLChNa3qGOSxzusf1jn9nd6WuHPYArd/Cywt4QoqTDjVwrAD
 aFNLoOy1rVxdkOD9qXVXtMVUWFo/uB2gpiHIVX56rR3jKuZuU5/lLSI6Yr1g+9r4Fs/k
 WVhM6VDuzv7jFDzNIOtXuBZTknElzc6ZI4nEibH7UEaWypiI2PxYQoOKz4fbpsR+tAR/
 Twyl+PHSvPI234Vr4gxFhuIgfCElcUTgX3vGNpXbmLLbq/2J090iJvP+m5kM6U/e8TYp
 gpDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750674035; x=1751278835;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1bTvNO/R17rOdYWeDuIOmyTAd1R+AlfUESsJshkB6Q0=;
 b=PDYaKK5nhYSJlaoLTnIqrvvFq6aRNT8LyPUoT7n3zjUNHG/gtcpZ4R4Up4eCOcxoF+
 maljY7z+XcXllNfCsld7Ui+TxSwn25nZEUAl62lnRPmLOfRnWGYvopmPHSUmafjEO+Q3
 tcqyO4LzwdYPIwDS2b280m9uBBMgFzRRbn0b58WsDfjYRFOTOuCRwAfCLs8gzc1Mmqj3
 SdNJdmyqU4f4ioQ1+Ga2V6aFaFGlgso5VvjfA9zBs9/k+hekbxP6QceO08/Bix6cvXts
 IAke1St2qSg7XfFJZl9vSVp0n+hbWXRl24BF9TzQsqXiZVpw+O2gwzn8kTnh0GeSXGS9
 rJug==
X-Gm-Message-State: AOJu0YzBLM5Vxx3WHchnM+1+EPf7LAq4k50HTnM4WaV7xO3bJsRfeAJg
 64o8w0J0LwcLfBhHcQau3ca/oNROlfFGrH12dmbIXVkKXp7Dku3bLJ5YTYWJODYSSlZEYTJdWhx
 psHAFlLSK2jDuRgyrXi9AAGtElrqGQ9BEbzEKnYQqPA==
X-Gm-Gg: ASbGnctAGlqBARaKBp2XomqAjO+vNqnAns4wziXRvqoewSw3W2WkPu2HdtcihPtNKrS
 QI7bxHpVZE5CgdKM6JUzj61B3HW23o5IOjHVrmcgLM5mFN25dVpA9LgKTTM0KYNfQ13hrjQ4PqO
 ukKXtKVDcKd3NOw9WSB2AHcH6RTdjQrUfQjYxlmLDGPFpNLeZiTjrZ8cQ=
X-Google-Smtp-Source: AGHT+IGjd+vp33dRuXsCgWXFPRygGonSkXRkryvXW2//P98lAdEG/BXLqQ+5CGsEnJaWjKJccLJb+x1sOGEPGQQ+IFo=
X-Received: by 2002:a05:690c:4b07:b0:710:f55f:7922 with SMTP id
 00721157ae682-712c6753483mr161390507b3.34.1750674035330; Mon, 23 Jun 2025
 03:20:35 -0700 (PDT)
MIME-Version: 1.0
References: <20250621235037.74091-1-richard.henderson@linaro.org>
 <20250621235037.74091-10-richard.henderson@linaro.org>
In-Reply-To: <20250621235037.74091-10-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Jun 2025 11:20:24 +0100
X-Gm-Features: AX0GCFtpOjXIHgWEnCSBubp9Z8djnoA8NVmj8mn6AGKKAtZFwxDwZxOIATn-7-8
Message-ID: <CAFEAcA8MxS0CBjDYrVZnhiF3kF=FbLb7ciqRqBTo6gBMu8BGHw@mail.gmail.com>
Subject: Re: [PATCH v2 009/101] tcg: Split out tcg_gen_gvec_dup_imm_var
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1129.google.com
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

On Sun, 22 Jun 2025 at 00:53, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  include/tcg/tcg-op-gvec-common.h |  3 +++
>  tcg/tcg-op-gvec.c                | 10 ++++++++--
>  2 files changed, 11 insertions(+), 2 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

