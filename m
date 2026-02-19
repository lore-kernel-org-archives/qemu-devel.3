Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 606A5E9A04A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 14:20:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt4sq-0003TR-RO; Thu, 19 Feb 2026 09:20:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vt4sl-0003SJ-Kr
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 09:19:56 -0500
Received: from mail-yx1-xb129.google.com ([2607:f8b0:4864:20::b129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vt4sj-0007NF-0J
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 09:19:55 -0500
Received: by mail-yx1-xb129.google.com with SMTP id
 956f58d0204a3-64a28af2f4cso1357362d50.1
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 06:19:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771510791; cv=none;
 d=google.com; s=arc-20240605;
 b=MZNzHc6Lj2i4IxqoZQ/S/7cS6sotYRwRp2YSanMrOWsn8VmiaZDmQ3z/edD3fHHwVG
 Z9rHd49dXDq+gp5LepP9c0xcwCzncmEpkAUaemrKnzXOG5lwfH/KpyMtU9TFR2C6UXbN
 8MySBvbjyIWmQYmsQlfk49oEEbzG5FOnkthhgaenHf/IQYlXqpYe4m+q/9Wj/LG6CTUo
 UQrPvEPaPtapRd8Cl1C/sbr+CerW5KEDhZVvLbPAq9pN6p2yIvUd7PXjPEV9cAfO59uv
 C8SGV7b5MhPMBcGRGEn1uFhvVQeKHU8BEGrCGIaB1GtQ0Tsu6SOa9dgM1Cmw4Q6f+4zb
 /8Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=rgl3ezu6BsmX42S797EKbk/ktlmpTUMITug5ibuCN8g=;
 fh=BAyh76Dt9lJjY3uGbG9gye4E4bNa4dvV51FFfKIqCkc=;
 b=Du0r2F+kFS4pelCzG8dFNHOKLfvp/iuYWB5/MpIyPfuQEvKg2WHZd37ApfM2G2pYta
 oJJ7oHQUds1+9gY4jSKDRBVB5Z7wOr5LdWtXb+dJ4mDvfRMRxczkFVn/t9U5RLHzVT0L
 T4CVDXAX8sYnNG6e5G2E02XMiOepeT+m0ngIgEXLfF6i1gPHkjZ7PKjDFDRTF8wMBMRX
 bAcJ2hT+86oAUalndKxRRuCSED3Uacq/7/SXgDKWsyNI11SLe+FAsiqxbLitTX3Ih4MI
 vNY/r0ZinVM+wKMRCSyNxVHjA8mob6fqjDWhIHn6SWm/rR805vezUZGPw9ITsSm9vLRR
 FMHA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771510791; x=1772115591; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rgl3ezu6BsmX42S797EKbk/ktlmpTUMITug5ibuCN8g=;
 b=R7pjheGBeNGbGZUJksIxnI+cTgo7Dh8b9FvMYe2Kd857Mnus7Y8JklGoi6EFn9TSI5
 nM/Lljxexs/Dag+FiBtmFJzyYOYY/uzbAlbLLhKx82Yl818j8GYTYQ3XSMiAU7kMZGmH
 UbYZlwKc8Bb5qfHlRGBYPBks1Uvco3PWYzrqMOoVODFswDOTYJ58sNYVihecOsyS/LRA
 XIfATuoP6LTTRXDHJBAToIs2+AY0Xe6PhTj8RwcbG32gN5/NGW4oS9gd4X6lUErKravw
 tg4hx6fe0CT0OeM78s2r7ujP+XZBs0+JuFFCLtuzMFHl9C73cYp3ps3SeFYXHk+lDeoK
 QXTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771510791; x=1772115591;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rgl3ezu6BsmX42S797EKbk/ktlmpTUMITug5ibuCN8g=;
 b=Hqo9VuVyZlJO2ivMqZlG6lb8VeI8aEBufyEeJORuaBQQ2DUVfkbTl1RthEU8PrnG3g
 KLNQ+rsR/2BePCtD8jwzRv/SGL1cEBaIrA2ZdVjykY6qdfUzu3n696z9GNn4qHYQZyFk
 YKCBBg7l99Tdw7svGi3bqInb4ITR4CNd9mC+Lgpin63CLoEenlzk1lfWXwnjrP6U3Z3O
 698wGuzNiyHNZfV/p1jGT4nOaFHYyTyT2bMycMxn5eERWT7TN81dpqVSzYRTxHhKqDWM
 fcWfoDBCLdGWYpKGcJWs+/BJqN56wi28OgzwzhlvKp0U8EqbMfsHMbPPC5J91F2gttyc
 MMRw==
X-Gm-Message-State: AOJu0YzGAYV3U7J7QZUOrJrH769wGIO50f4XVgMlzT0CsV7UMsT17X/R
 nTQSOmHIKMLHt7lvAN2KVRfrW0Nyce2G1nk95GRiND1hGWPqu5gKgCmLgN9Hxmh4IMcwpNeA+n8
 M40nnXY4DM0ovljEuL8aH0GoDWkfH7lpqifqcJZo1CQ==
X-Gm-Gg: AZuq6aJicTREI4yyfV1u/L0Y3DyL8SErm8hIC8wa98dbU7AJC9r1I+bB/Q9CpYK20I+
 Lxe13ljmtrMV4yNAK9B7TTwL9BGFl2Zp5qmbRItPMVEP1ATbm7dVu+oMAwy5DrGgPruxx73e/7X
 Fp81X5R5gyUOQQ5opgbDhmJXajartV1AUe1DXNqTFlxDEri7zPFyfOCn2aqN9Fp4qVxnQui56ry
 AMLpqraubK72qqgnBAVoQ44f3X76vg6YRTV0rvLNu1ztTs3p0eFMyfZ1MOzNjTNTfwC8SIs12E1
 Mq0TJbc2K5asdCafsFY8QQCVcS227wR2QIZV/6dodakWv0i4po0fazxYrH7wHo4/7g4=
X-Received: by 2002:a05:690e:d0c:b0:64a:bde9:3423 with SMTP id
 956f58d0204a3-64c64067792mr1251518d50.9.1771510790968; Thu, 19 Feb 2026
 06:19:50 -0800 (PST)
MIME-Version: 1.0
References: <20260115-sme2-hvf-v2-0-2eca481bd7ee@linaro.org>
In-Reply-To: <20260115-sme2-hvf-v2-0-2eca481bd7ee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Feb 2026 14:19:39 +0000
X-Gm-Features: AZwV_QgTQSl-QBuOk4ymXW-n47fmtd4uKOfrRb1raTkjmhEH-iEpjXLQE6d8gdY
Message-ID: <CAFEAcA_Swd-oFXB6K1aDRaZm2XoKf0kXvK3teTyjjp5+fMryfQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] arm/hvf: Add SME2 support
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 =?UTF-8?Q?Phil_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Alexander Graf <agraf@csgraf.de>, Mads Ynddal <mads@ynddal.dk>,
 qemu-arm@nongnu.org, Mohamed Mediouni <mohamed@unpredictable.fr>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb129.google.com
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

On Thu, 15 Jan 2026 at 11:20, Manos Pitsidianakis
<manos.pitsidianakis@linaro.org> wrote:
>
> M4/M5 Macs support SME2, and HVF exposes this functionality in its
> public API.
>
> Add support for it in QEMU.
>
> This was tested by running an SME2 benchmark from Arm [0]. savevm and
> loadvm during the benchmark's run were used to verify migration works.

Hi -- I've just merged the "avoid gdb falling over on an SME-only CPU"
fixes to head-of-git, so if you could rebase this on current git I
think we should be able to land the next rev of this patchset.

thanks
-- PMM

