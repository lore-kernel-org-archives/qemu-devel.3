Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18DF5CD8CA4
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 09:00:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWsK9-0002HN-Q2; Tue, 09 Jun 2026 05:00:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWsK7-0002ED-Il
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 05:00:39 -0400
Received: from mail-yx1-xb12c.google.com ([2607:f8b0:4864:20::b12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWsK5-0006Mr-Qr
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 05:00:39 -0400
Received: by mail-yx1-xb12c.google.com with SMTP id
 956f58d0204a3-66039d3efcbso5376792d50.2
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 02:00:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780995636; cv=none;
 d=google.com; s=arc-20240605;
 b=UttqVSQcRAW5APzs1xjmwHGSJq+dcmdcWOKjkvCU11x/7+EEzcWSPRTOcIjCT5vl5T
 fkIgf6od+m/T7b8pCNP2d3fo0vL6NrKdMluIWXjM+URdap0GxOHNihW5f1jq+DYl3Y1p
 aGdEj57KL9PR82Rs34u0TUf+tUbCLi+9+rJ3orXOR/Kx29pIGd3efUpcuN7quciVIAMT
 VHTGK6UNeEkStbdyRW4UAFu99+f1GwFkJdRdcYH7DyUgOZDqjnCl08HNC0JnmJFyEV0G
 eXL3URA5OMSmUFr56B0S5fn7dWqCbEqcQ0O5mbouc921uwR0wyqOvViHNaIQOoekeRv8
 xrtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=cdvyM+brOEXM6M8zyW6kbJRdYM5C4WyqiI8qJXr5MwU=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=ak7HyQJCcTqt/UK8Wq6Gi0VvABs2HgJG7XC8sTM8cNvIABtTQ8NwHsBTcAaHY5Y3EI
 n9Om7FVo1yPhKNea666x2NAkaKcqMEtbnIAPEPiQv13UeONw9VO3tRVEuOQm1idZqIaf
 LBFzg5pcgA9TXuo/JIswFOpQtVdcGxcFga+MtxN5Xpk/wMTut67jnW9TVOb1jjjn8gZo
 yGLZMGJNWaCtYsF641nfjH7krPyPdMUweqUHnfS0YTCxJ6kRGBOTzZqxt0pOqviJglZT
 SZlpNHVewG7BTsOn2WUQqRatBkxEcP5BFMLBgUR4PTt/j12ibRNvyq84rJyPljtsMnSm
 vt8A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780995636; x=1781600436; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cdvyM+brOEXM6M8zyW6kbJRdYM5C4WyqiI8qJXr5MwU=;
 b=Ty+WU62jgy6vTvvjSizZKJq/w0mn6illiV1pnFoiI8h5cuhM5u8pJeMyjSYOiIm1y+
 hGN0hJsmwVa94ARiYIJ7ddSaP05b9LUMBaum7XJ0wUjkt+zDXeC0nzXcS4+BlJZwx9Ge
 Sg/Dxxerlt8waWmZ3nhYLC8JCPcvmkRgzJScCUEJ9aYrI6F4/iJQTdFa50/pW0vtB40e
 fFW2bJkOMJ6M4CIETNBeNkHWuH2GGPrC/9u1+N4YM+5vb+ByOa/ghkHad9lNxjgrQNag
 91JtZh1p55ZJ9FjJcJ8Ip/80ZCrxoQbhbmKrzB6c4Gwvb232jdIFgF5xFLAWrBXmEqhp
 yuYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780995636; x=1781600436;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cdvyM+brOEXM6M8zyW6kbJRdYM5C4WyqiI8qJXr5MwU=;
 b=qwhs1PIReAScHrumZYq6B7WeS1mWwycS+b/IEJUUqvjy8TiUaOhuAO8cUJ/NsDRs4L
 4flfuFgK18014yZUKlAmzYDFjoTiwsgPEbkAWSifWa/qTb6qLFueEbA82sAH9L5bNxVn
 rzhGHcNNlpsLLBzY29fjvt+zedJGhrWfCiEP0jjt32XruZlom4Grl5mH+wrjl+ydrQ7f
 +QtqBriOxsUFgWMBzY4YkUVjgCFvtDedmNm9vJJovPeyeKv/5KE0GCXKmb8VnzLzOec6
 NK6webtlORDuPEkX+DD7cETZk8P0p5OFjWugLEBsQLXDcqoL3/44TmQl+D8YjlL0Qfwg
 +Rcg==
X-Gm-Message-State: AOJu0YxJ9uz00CpFD5xVtAtF4yrwI1vg4zb6T04jsIxCb7DAEXyZI1ly
 i9CnbYytl5jA3lOfxQrgSa+6/N4a5x3hfx7GFbX1Zlx00b0DRJHCjOv0cDmz9so+qVv2KIITH0N
 yEWU5m2u5C3iMqIwFFQZhiZXTe83eMEOQ6Zl9m/PUVQ==
X-Gm-Gg: Acq92OFZDDt+O7x3SMlfbnlOptUlYeh4RW5ntSxWE7mubEOScjHVJv7UKzX/HqMjd3j
 WqyE5iR7UXLuH1AzeGg9cjbiERm4GHcS2/QgrJwiU/El/UdkGghG0p7TziRGbT+knkNNiO1n5oI
 o2zYBfmPJ5exzjpgVlBqiivNbPdKxsdP/3vcIcB2uS8V+NqY22+EKRchawZN2uHbxRJX1BlgkF4
 VafRxfcF0p3MZTBJwYXgTmjlFr3gYvMqbbmWvD2Ua9q1uoFcLVpBgIMJhhPok7RS6diS3Weorgo
 h43OrxvF3QoebQdgB3aErbbJFe7uW7YxqbFlcm/8h6XuIoxqmT9DKCXhu+4OBLN7Sg5aP8G9uCu
 KKXawrX9XYQ6x
X-Received: by 2002:a05:690e:1908:b0:651:bf58:446b with SMTP id
 956f58d0204a3-66106e004f2mr17374836d50.10.1780995636303; Tue, 09 Jun 2026
 02:00:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260603032855.106930-1-richard.henderson@linaro.org>
 <20260603032855.106930-18-richard.henderson@linaro.org>
In-Reply-To: <20260603032855.106930-18-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Jun 2026 10:00:22 +0100
X-Gm-Features: AVVi8Cd9N7Sfw0gLxceCieuEypaylimcYx9I5mZZWKr1e38oWm_Lk8R_TLN_iaU
Message-ID: <CAFEAcA8C7Q+NaM2jaijD5PHDkkKiMbAuN_J6w=EGHXL2ZDkAMQ@mail.gmail.com>
Subject: Re: [PATCH v9 17/45] target/arm: Implement FCVTN (16- to 8-bit fp)
 for SVE
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12c.google.com
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

On Wed, 3 Jun 2026 at 04:30, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

> @@ -4100,6 +4100,8 @@ TRANS_FEAT_STREAMING_IF(BF1CVTLT, aa64_sme2_or_sve2_f8cvt, aa64_sme2,
>  TRANS_FEAT_STREAMING_IF(BF2CVTLT, aa64_sme2_or_sve2_f8cvt, aa64_sme2,
>                          do_f8cvt, a, gen_helper_sve2_bfcvt, true, true)
>
> +TRANS_FEAT(FCVTN, aa64_sme2_or_sve2_f8cvt, do_f8cvt,
> +           a, gen_helper_sve2_fcvtn_bh, false, false)

This also I think should be streaming-if-SME2.

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

