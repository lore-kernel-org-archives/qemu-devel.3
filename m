Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C908CCD8CB2
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 16:24:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWzF5-0004MJ-HE; Tue, 09 Jun 2026 12:23:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWzF4-0004M1-NN
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 12:23:54 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWzF3-0004ch-CV
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 12:23:54 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-bec429c2bb1so854858666b.1
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 09:23:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781022231; cv=none;
 d=google.com; s=arc-20240605;
 b=dOle67JOp2x79ZVG+iWkYZMMQlwPLEzvkpiSj5WPXJNNWnOQ/xvz/b/wFJpyeJhTnb
 y3V82sMbJylcST39CaX8OQggO69Xh9f0x0jwZZsHJNRVXAVj7cI9mA/KJpNvfPdDFUsR
 dqc8WFyWfew/UvNwtEp5lWJZxwh1HGTdNpzCOT8I2IyVE8/yY/HPyjKw9PZJcSA11qP9
 sOlbjR1p3xb+RaPfFYUJqPqhTbBM0czgvtSFkmi+sluRwX8OR+3FLyNxn1MAlA3Y+esD
 0RgYG482b0PLTEaBlkS6kFpvj8/9o9k1ZXnD/Tx4AqCWd21A1KHypiq+ugbv+8m9F4ga
 341A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Z+KgRu4cybzfId7TsQ7wz6qLEalcFcnFgAHvMpT/vF8=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=ijaOTNznKbK/v6siroWfjOWM0MhMlGn7zogvG5dtci4u+Gm+FgJt2W40lSHl9XFJox
 tvPml/oJTiLPNhfh93Mr3OoBNMB78A8zSoYQwyz2nJpDLb/wesbhRixUy3OIpHM05Tm8
 yhFoQ9A4cNjuizwEQTYysVLbww2xPc2y3pw61ihoUr6n5ivVrQVuSfcu0lL3ukrSIw19
 z9M2DMeUK9VDutxkZgunJDd1ELl9TZDU3KRKxRT5udmy8fNutY+d7b7TQJz5gkUyfC19
 YlXFieIdRwj9/A6Bw89rDFiDeRiLiD2F8CrRpSa4S7y5cKwyRace8hO/bbkA6rBXhcGs
 8ipw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781022231; x=1781627031; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Z+KgRu4cybzfId7TsQ7wz6qLEalcFcnFgAHvMpT/vF8=;
 b=jKGPJqWjs5Me1UY2uaMIt+etADlPtfGGQpRClzzGNS/L8+oYzGHzLSukABEhwUQ3H6
 ZOggkPFJEI9hQv0GqMATyh8TohM8FHZnlKEU+b1JDv45vssqzLnLtsTN9k7O7Z4wRUOV
 p/pP2rZo4Gjsox4rgxxrJzrFHt51PczsmGOW3pkbajRsD3n2Ktdyzn7X80SJUlR/Ap4O
 iMmJ1AU4Jk0aBuT9QCsJ//74BAir01qOHKCeSq3ngCsfn5dva5WXtXJrz6aU+439GqDy
 TQK0yy9vVOt3tHfsAk84S8Y+XwjOI6PwXBL5ZbtJvmnM70urDv4Mb6c5NHCrTHyZLPcT
 M+mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781022231; x=1781627031;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z+KgRu4cybzfId7TsQ7wz6qLEalcFcnFgAHvMpT/vF8=;
 b=jo1JTq1fIEc7NtquFOwr6kDQtzAZsgH6rqN2dZb6N/NAytwkMKPfIMEJ7WABr6K8No
 N5y/s9WFCUhDdsZRXLks5b94vKw55vagAUze+6nh434AQOzCqD1kg7vgtYb3n3SD9nuk
 w29SEgQECp0drG3GFTrhWXYSl+OHUpbzP6SxswKxnIdWz9j9ieCl1SqjKl0lhtrWLKhh
 G368bfKwDMEDOrJJW7hqhR1njofkpeLRV7ncBU4Bbu9kiIy3yI45SVhCVlQnC1cLrr2W
 JEexT9eOTYU3w07VDaeH1di83jNv5eKRda3a6EOSPDyybCnl+tCXbEkcQzecSVnW4qBt
 TAWA==
X-Gm-Message-State: AOJu0Yz1BlA+jtsc9wEdhQYLDIWtJ0MlZ8jXSWWe0MdmJfjt2agEyo6l
 6q+UpWWXx1b7SNpLi6t+Oi62k/amXyZAy3ygQaSdBKhMkYtOXsqIzUnC7NqJUTnD3XpNMq25HKe
 Ez1vVyNhbTmPJsKIr9ETe3Fh8MECuB6l/bXfjV0lyYlBUIcZNGjov
X-Gm-Gg: Acq92OHfSWNZ1xPoyCnQmUyqFY4iTi2MtusF65EP8K3cSxSV9WUlNUKcl0LCRVJERmO
 iGKdzFoiBUuUQORDhMM0h/jotVl6e5cUIY4OLBygWx03tSjPdTYHpA8mfi7X7KCe0G+ovppTG95
 3vbGtlGpWvZxv+Xhd7mkPX+0VQ/ljckddvI+mxrr0s9YHayLvhxc64bw5L617WeCU7LWZeUZR/4
 qLsgZtEpwmkcurMbvI1jYTxPCrcc5XuXpAiyDhQnAqgJ87fyoxbRtt+5TMzHKimM6sTGmscknYB
 BAz3vGmnCVIr4TjAvlaBSDyEezE5YQesIEJVLvGAN0iyXEHFSgHJWAD31WAp+LLMysmjO8MdoeH
 I9w==
X-Received: by 2002:a17:906:8a46:b0:bec:4b96:5fb9 with SMTP id
 a640c23a62f3a-bf3701806dcmr684123766b.3.1781022231395; Tue, 09 Jun 2026
 09:23:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260603032855.106930-1-richard.henderson@linaro.org>
 <20260603032855.106930-45-richard.henderson@linaro.org>
In-Reply-To: <20260603032855.106930-45-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Jun 2026 17:23:38 +0100
X-Gm-Features: AVVi8Cd_wKcDu922_dwvFi2FPOxRC_1XnRtW7TP4jo8twogu4Oq6lXiPg2lK2iQ
Message-ID: <CAFEAcA9sAzDU4LQ-mTpjPp9uOhT1EqY+fqSH2xNxMby7gctqvw@mail.gmail.com>
Subject: Re: [PATCH v9 44/45] target/arm: Implement FMMLA (FP8 to FP16) for SVE
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62c.google.com
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

On Wed, 3 Jun 2026 at 04:33, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/cpu-features.h      | 5 +++++
>  target/arm/tcg/translate-sve.c | 2 ++
>  target/arm/tcg/sve.decode      | 1 +
>  3 files changed, 8 insertions(+)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

