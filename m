Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E35BC43458
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 13:00:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd6AE-0001MD-4D; Fri, 26 Jun 2026 09:00:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wd68w-0000nz-0f
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 08:58:51 -0400
Received: from mail-yx1-xb12d.google.com ([2607:f8b0:4864:20::b12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wd68s-0000iv-Vv
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 08:58:48 -0400
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-662fa4a4470so1054230d50.0
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 05:58:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782478725; cv=none;
 d=google.com; s=arc-20260327;
 b=Xaj4d5cLFp++3tW7tRV6ECPf0l5sOGLKb5GbGyKLoZN7YTTSe13n+cCBTx0cUxCjRJ
 yX6OGHm1Pbp/sqO2wr+Pda2ZJSkEfVndEa8sQLZ6Bbl9ZsgE2JEqw09DLMmpv+291IsG
 SNrcVaWsZb0szzMkT5XilvZ9xEcyfyl4E3uB18W39CWI1w4V6N1Dt1K/xxxmzex/Aun3
 x0+3c0K/UW2wvldcIFE+5UKmHc7jNtz4FW/aZYbrJKWbETNrqrbObpIB/zOi90DGFntL
 ollbW+pEwUjFMwtll7MceNf1/LB9U8eFj5XkqRyhE6Jo+kCsANnuOVY8yswRHXWImfIW
 9ehw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=KMriQSIoTveX/5Lf9JctRkml484nCp37hCXyI1oC8I4=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=Z6K/P5azntBlGUcO0cM29sU+mVReMVPao8o+rRgaEYk1Ped7B4taENGjyVjbOOLuZp
 iRYwIg79MDtzFySN1m1xLLtiHVtkSzzpSoxtnyRLrG4mXrcFagznCYNGWcly6LcrnvtX
 cQ8D9AS2nt0VVbTZ/XxRn3DmNDaCqCaJdgeiDLQXvlsAuRZMIqVJFjcdiNhIe4/5TxNF
 YojSFGwXtMk3vASWe5aMFwKRKggVVmwOK9YNYyzPLhPIHaSuajcXWUZyEWDSAkcEKSMp
 1J0XyhOAtKF5Kda3g/n0Ukyrm/EtAYhyx0GnyRB9XPQCbOSVaE4ilXSdLz8pa0hs0aYC
 nBHg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782478725; x=1783083525; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KMriQSIoTveX/5Lf9JctRkml484nCp37hCXyI1oC8I4=;
 b=u4dZJXEy/K3VW4X+nBLc9E6Klt5UtqsQXpw0lfJJO9TPt7h14LBCRm3D7164+hjVHr
 4aXlz749FISYJfpq3Qa9tW8vnU1nU7JZN+D37ytMErwH0FLpve2tOsCtgaYDK+dXO4YZ
 1aFY4dESH0LUFb4ZJKLFHD+02o7ExGuZSrSXYr9jPkY+DGmp2QwSLcDD4QeNooxBlyQl
 j6QFK0PI5yzxV0pBSKWXNgMMzb3Dyg2CmeABv2eUWt9kbcjhY0ilJzlPVSCkB99EImjA
 UMuSVHE+EerydEz9sCA21y4/xRKzf05ufwg9+c+ZU+tAT05GqOyA4mzRtg7jxxGtFxYb
 fKmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782478725; x=1783083525;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KMriQSIoTveX/5Lf9JctRkml484nCp37hCXyI1oC8I4=;
 b=Ck/aRAKFCuQGnC7eSNxJoi3EprdHZo/yfUxbYX6uWXWSycJfTqk9Ljjus/uzUzYU8L
 M+C3CHT1vrE3rZHk0rl6tLaUA6sZqU9NV0vN6LurpdwG1J63kdxzLSd82OxG95OGAbmc
 +SKNuQdjLR8tQ2CM8VfYDnzQIbDIZTH3raEDff9vglTnPVAFwEcdI/7+rmp3XeDI/we4
 6rtSKah2shgTF3nVJVnm8Q38n6Gw42ilKzgjulgx/4PVnLTh3w6f0KFtv7w4YyWFksXu
 LKTxOy4o9c696UcNzjuM2SxziR07/htSgsstsAzSpKji3ogNoCjptIv/Sc4QFpsOCFPv
 9Pvw==
X-Gm-Message-State: AOJu0Yxve0oXypgDDmeJiGvidH77oLCnbQ4gyvvCTdrVm864aMtX7QSd
 Jayy8XFvHkVS20Obuwl8Wj9ytlFt+3e2h98DxEkzNHauSJIpub9O6E2+eJu5bnvZlg8QjZC7khc
 QOCw86Jyx672wY4I7DiBrAjVp5dYO3AKbCkerw2CqqA==
X-Gm-Gg: AfdE7ck5vo8wjjT24Dr8vPjHqse9SPVRfbudmBkc9hfV4bsV3Trr7VhIJ/9fJv1GfGq
 k2AD8XZWRS1F8i7kC0uP1xsnTMIA+U9sB2mWhywfXijEcg7q+D6PtOBeLR7Rrpr4bBEPTl24XZj
 T4llG7qsOJTbg7rpLj+W3Ijm7PbMd/B7zfsJ6bwMqkIgl5jfGyfDyJhSWG3GOL9njKEQteSkHXh
 HyadqAGuLfs88nDtFruCHUzbKZsxVhwKJH3HW6gmAxqk7sj8NoW9fsXhOXepPlc1xPy21YqxoO+
 oOS2rjZA5CO4+yIu0XGrtFIR9hf0IN71+WuatoE83BrOo73B89KFk7vi
X-Received: by 2002:a05:690e:4511:20b0:660:3426:3fe1 with SMTP id
 956f58d0204a3-66487deb904mr4292233d50.24.1782478725576; Fri, 26 Jun 2026
 05:58:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260625223200.763198-1-richard.henderson@linaro.org>
 <20260625223200.763198-3-richard.henderson@linaro.org>
In-Reply-To: <20260625223200.763198-3-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 26 Jun 2026 13:58:34 +0100
X-Gm-Features: AVVi8Ce-yemMEUq2--ji5hjhf3INgNTLfn8xTWBhDYBYaKk05wd5vYyY_zFlO80
Message-ID: <CAFEAcA_Aj0p7jNRhrMysgLL2fyLPrmzUQOS8N+mwh1Ma_DFg8g@mail.gmail.com>
Subject: Re: [PATCH 02/15] target/arm: Implement FMOP4 (non-widening) for
 float16
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12d.google.com
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

On Thu, 25 Jun 2026 at 23:36, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

