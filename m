Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E12AC54E41
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 14:13:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rebir-00046w-5N; Mon, 26 Feb 2024 09:12:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rebib-0003lk-6O
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 09:12:34 -0500
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rebiZ-0002Eq-OZ
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 09:12:32 -0500
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-55a8fd60af0so4018134a12.1
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 06:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708956750; x=1709561550; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gjCci5g3m1cdPDY+ARHKmFFSrEMmQtPvDpFEpLERfQE=;
 b=nadLZJuYGlnIwo1P6mEqVHquZuEkfIxp/aB/EMfANTnH/BS3fqM/v6lci30uI+i09G
 7gyYOrQOy9mOTW616LtbNlV4m/5yoXEsjH1aASORzQwngMV/XhiXgyV9Bydyk/0F33WR
 c7xYu3CnFAgVIcUZ0qVYFXb5Ma9Gy7MdtKGW7/pDOIl/gPc2Z1MT6Knc93Sof4YrSsXd
 7R1HUFq1yky/sxImUiMpZT/d+9ueQSTft3waR3J6PWu9IbdhHKTWH+5Wn9E2rQ63fZyp
 07L9qdBKbbGdAKLScvMD5h2YJ4FhFCfv201mrLusrDNFBmdbCHFGOQFjWfke4f4Uai2R
 dAEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708956750; x=1709561550;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gjCci5g3m1cdPDY+ARHKmFFSrEMmQtPvDpFEpLERfQE=;
 b=tlZ6XoMtnKqXxdALOAnZyqSsLixBk0gwGsbVchHJYX+R74Bkn9SeoUH2WuaVLNct19
 Hu/dOa+sUswf2n2B3ycgtMxe5xm5JzHJOJkZ39N7BrIaXwNOK4Pm6JzUcssWYlCYXEue
 18YX17cinZmrzZ02qkIOnBCpIKkWaDaBXRSQC9g4Gr8UZ1gjM1oXBbYb8Q1ij+WRaTYh
 Y0q6gMlt8oYnUSV6vTtoJjjcT0if6rU5nnTxp3AOhRK43sagx5HDVohCffqdjuGWseQV
 DuFQDm/K1n4lPGvCOFz7v+JUINacTfu9MipiMCl6ln3LWeRFwog2q16N0uOSimLcxLE6
 U1aQ==
X-Gm-Message-State: AOJu0YwGF5LLye5Vs7k8h/a3akGSRC/pFPyePLoCqx+mKkx32GXdj3XT
 1wBnOEpjcljkD9qeCPQlhKm7KtAHLBpuUbTp9sT0UggorZGOQVax+qXl50tsV8t2qmHcP+S6wJs
 JMJ9JW+xYNfoxFqYi6Hv1DhKDWRN8aXIQ2kRDbw==
X-Google-Smtp-Source: AGHT+IGughasO44d2xK82G4ryMlpdtXPRJMNaeLmZri/kuytdaeETHB8NhO9xCLNvnfEw/fQt6EGab9gQuF+oVff6wo=
X-Received: by 2002:aa7:c3c8:0:b0:565:f90c:1263 with SMTP id
 l8-20020aa7c3c8000000b00565f90c1263mr1549811edr.9.1708956750102; Mon, 26 Feb
 2024 06:12:30 -0800 (PST)
MIME-Version: 1.0
References: <20240223180102.7657-1-Jonathan.Cameron@huawei.com>
In-Reply-To: <20240223180102.7657-1-Jonathan.Cameron@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 26 Feb 2024 14:12:18 +0000
Message-ID: <CAFEAcA9X9Mvz4CL2-yFJN4a04eoODn6Yr_VcD-O6P-PJ1ioSKw@mail.gmail.com>
Subject: Re: [PATCH v3] arm/ptw: Handle atomic updates of page tables entries
 in MMIO during PTW.
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: qemu-devel@nongnu.org, Gregory Price <gregory.price@memverge.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 richard.henderson@linaro.org, linux-cxl@vger.kernel.org, linuxarm@huawei.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri, 23 Feb 2024 at 18:01, Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> Seen testing of CXL emulation on arm64 (currently out of tree).
>
> CXL interleave occurs at subpage granularity so is emulated using an IO
> Memory Region. The memory is general purpose and as such may contain page
> tables. FEAT_HADFS using atomic accesses from the page table walkers to
> update accessed and dirty bits.
>
> Note that disabling kernel support this ARM 8.1 feature avoids this issue
> as the PTW no longer does an atomic update of the page table entries, but
> that is a nasty workaround beyond its use in root causing this issue.
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---



Applied to target-arm.next, thanks.

-- PMM

