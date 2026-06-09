Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12CF4CD8CB9
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 16:18:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWz9G-0001Ea-Bc; Tue, 09 Jun 2026 12:17:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWz8w-00013z-Mp
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 12:17:35 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWz8u-0001Kj-PY
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 12:17:34 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-bf1cdcfd6deso700555866b.3
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 09:17:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781021851; cv=none;
 d=google.com; s=arc-20240605;
 b=TDLTF1A+40OGL4UatgvysFFsgXVjFi2FFV2CYY/aoWovVc/3q0dMdXm6k4XjiJMqKm
 Aw0yrozUtaDwXxjcOcMGp9xqp3NTRONHV0kMqkFzzUmU04VcS5vADM/HWn2nrVj+RIem
 pDjrH3suO97N8KuFl29VVNNcKIsEcHvxGhYzq+zZO82n1CTOlc82TZGUTF4hFEChsdTp
 QORQCDiIvYe0koZrNVLEULzMZyMdb4SMelNU2b9cB06FqN3NlFo37VDf1hmi54ex+3yJ
 Uz7KINENB4HAtMsxJqFDI9IE32pzhc28ZOw654N0uwA9IUkZGmQCYDYmGSjch+dwiUnj
 thGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=EV6b8p62gD/RHU8mkv+v2jx/O0iQI+nv2OxNnCtoUsg=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=lUkhCFcFsrqdFza617gYzabfS25SJn/8Msi7DHycdRjEdX/na6y9nlOKDadEFP/2hU
 HhRPeEBHk1Y0YfRpREuYLYnuSwaaXtgPJrrnFPST4UCXKdo44LC5Jr7zAnCtPufyb6ca
 MObBb+LXwSGwALgSlaGlyupJ7vwaulLlvP+twxiGq7WSNFDYvm4ScvQO4pxo/+u+B9lT
 hj9Oz8kiU0nTvq5FiwNafk8kTQ9x99a0tssRHlhWScUyGs5WOTLNBMy3B4SyYTsLaA7v
 eXblqjSVsWKrNfh6nOHXwgMjPBcVdOrv6ya5UoLn6z63s+nW6MjQtdayT3EIKxZYbcdF
 jr1A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781021851; x=1781626651; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=EV6b8p62gD/RHU8mkv+v2jx/O0iQI+nv2OxNnCtoUsg=;
 b=bSpDF3K6H9oM9Itv4jsc/f9P8mbGIY9dz5Yx2I1M81Zy0L0s0wwZD4hx3orKwQzORL
 nIjLoGzH0m5/j+wbdYxNuCU4oirLHRJ+GALS7qcQNM71zCCgzY5IAXYU/s0eReoSd38r
 2xHBr2ww1m5mk1dx8CmUwV02r0nTP5sSDJNK29mj6LBCIRVb25x2LwNEm9ayyqsUQQ/u
 ISWNxYy4ZxaMTJDW3uEjhWM8wKUxCflnBvHjYqt7tHfFBP7RMqPDIUbgd6EVa7MZ4iMv
 CSig6rxVQ9nBEwCewQ/JNSB5b3YUbpB9ZgYxNSnym3O6d2XlL9+caAkHr/BDQeOjV1nv
 Xe2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781021851; x=1781626651;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EV6b8p62gD/RHU8mkv+v2jx/O0iQI+nv2OxNnCtoUsg=;
 b=ZMAU1xCwPSNHW2dLotcfBREKAWC4Fd7+pWJ01JtqnloGttd/iOZ2lxDlBahxV9JAtJ
 Dh86xmpVUVZAM+vnzeCp27Bo6Ryhvye554RL96lIvF1gEPfZ5w9mTKA0X3MV3joXkTWl
 hKBjm7ml/uD1K5nfuPzohziB/0r2dvsP/9Kyb5DYalD5RQC4kddSwcWNPNyYXCCzMTBJ
 OAo48/5qcrEgxxSjv8F7gyAOzeE9LdLVRdPiDgalZt3y2TD30ebLeybV0elinzDFT6fh
 twkYjQgaBOrsIltjzFZVMPR16n++Gc2QTTf1LvevgtsxqMIivhUMmE504AM6/hfSN3uX
 At0g==
X-Gm-Message-State: AOJu0YzFgxcmZ3FBbJIujbMcfPT+4ePW1ZMH5b7po8SiHHYzchjs1irx
 niz/UI4MDCBTqDUV7/gyLGb/RA3OFk/Jb99HdRh4tGLGPb6INgwdndjO5a/Iqk9lxCyTYzzUHpt
 viQCQUFqPB4vsE4UNrMw46Dvtu5YqCMJCX++tGDHCYw==
X-Gm-Gg: Acq92OFG34MJv2LPox3tmUeOXV1DxGqQhTaFKIILuH5eyGcESGRIcWY1muGnq+ImCZ9
 d6M4rML1CpXlEAl0auzuI4W1pspWe1Xv4gOiHvaFpxu4mZcc2RMIncwrBWkib3KKitWH91cIR2r
 3HCBIJ4LK2T9Ig1Vv1Q5LupUOMbEjkWdXgdP13ItTyYyaXdgOcoj/43ZOcXFOddOG8/aEKqWZjg
 pSmpknl4Z5XWnB0lRI+olVIMiZ4IVkMbH3hg7idw4PmExjUWxep2ykME4qgOa4t3BBUeJqSMd7Z
 q25mkUDk1b3iGC8knbJIS3+KDG3z+34eRyn4uK1Xo7WnVF4GhKBYB7a6aWTSDTgoQiwsONOdiyZ
 6pA==
X-Received: by 2002:a17:907:75f7:b0:bee:a25:b977 with SMTP id
 a640c23a62f3a-bf3745dce08mr753397566b.45.1781021851059; Tue, 09 Jun 2026
 09:17:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260603032855.106930-1-richard.henderson@linaro.org>
 <20260603032855.106930-40-richard.henderson@linaro.org>
In-Reply-To: <20260603032855.106930-40-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Jun 2026 17:17:18 +0100
X-Gm-Features: AVVi8Ce0l9tuDcTK7VaHj427P3KUD2qPcJ1SaU7xBYUoFWfI0Qg9ks8e6M7nphw
Message-ID: <CAFEAcA8M=cUusZOCcrPe4MsqfaWRjP4XKHKK_2R3xCH71DCQxg@mail.gmail.com>
Subject: Re: [PATCH v9 39/45] target/arm: Enable FEAT_FP8DOT2,
 FEAT_SSVE_FP8DOT2 for -cpu max
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

On Wed, 3 Jun 2026 at 04:30, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/aarch64/elfload.c  | 2 ++
>  target/arm/tcg/cpu64.c        | 2 ++
>  docs/system/arm/emulation.rst | 2 ++
>  3 files changed, 6 insertions(+)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

