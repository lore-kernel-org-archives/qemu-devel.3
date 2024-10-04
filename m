Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE063CF8840
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2024 18:12:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swmmB-0006yY-Cq; Fri, 04 Oct 2024 14:11:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1swmm9-0006uN-Tn
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 14:11:37 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1swmm8-0001Ic-8z
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 14:11:37 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5c718bb04a3so3002634a12.3
 for <qemu-devel@nongnu.org>; Fri, 04 Oct 2024 11:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728065494; x=1728670294; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sjJUBNfRiyu/itUjSNiYGb5Kt7u8EGa9eU/c7Nllk8g=;
 b=izE5CEnLe9X6mYA3UeuFUqItsNuFv5YHw07umNShvbwh6wWXIxzijzrhe6jQEAuCFY
 WG5ITlExkqM2Pa5Y0OsxA7FJXsvVoTSPT18wBfn73KQCfDa65k2ats2bTp4iTBniK1XW
 TD8qFTRu+m3eMk5d+W56gnp/f/KkdJ0bcD+C/9Ll2wvvN0R7M8xJYSzOwjYP8ycaZoI2
 qvvjE2Q4ENReg18nhltLLy/B5j1UPga/JeSw+vnX/N/2acsPkIbq1zeYR4Ih6UOJHTE0
 jTCPVd8/co0tqWQ+FFrRCzNu1CA7EIC1TYSPNKbhdL2iSDvw6/ZDoLpCHFwXyeHajI8o
 m5BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728065494; x=1728670294;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sjJUBNfRiyu/itUjSNiYGb5Kt7u8EGa9eU/c7Nllk8g=;
 b=fRtSBFn3AH4EcE5/w5+WXzkrjzR5pLLDqhHYLmYe6TWc26UsPIqNbtD8pDV0ys4uXI
 f1A+7dtot6+5q9sLF4WIAEQPa5Ab0vm2GadeJIj+9ZfGGhc3TuQrENIpdE+IJnBylgRk
 JteMkMvQTcPEd3PgTxttpD+CgraLcabBGMRmOOB+w5kmjvpEF3fqyD2ChelbTOBaptr/
 /4rUo1ezSz+gVicShrGkWyu4p3pKiATQVscOEeX9E/taez5brd0sV2PDQ7XmhTiNjZ0i
 /3MmJAwA0rkUQeKYixRL0iwF0ZAayNbZfMi5e/QTo3PZFg/HV1UTFkxKGMhyIe4qqYcb
 CFfw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVoLSrDElOyPPzn4AMfouKS5BxmX6x7VmfqM6D3C1QcBXanRbc7S5H5w+yzmjwhs+z7HY2oKkugDViE@nongnu.org
X-Gm-Message-State: AOJu0Yy1pAaI8g5UzH7m61vfYRZtVXVGX3bhzeX4LJ2Xklx9Z4C/y4vP
 aGbQmc1Rde6tr/5YwvNuh9gu5EEC5e9PEL5X9wQDJ/Y/xq+J2Zjh66TKS2EIZ+mu8OPwCH4Oo3q
 5CcnVCh+ailDuMIFCNagjSf7GGoimpbbjrfWt/heREemSdlcs
X-Google-Smtp-Source: AGHT+IF0k6ak3EoLvMsNNIxfd5L0e/PtjFtLARF6au7NefafHSMXhD8Lwl/R04GVBD+BJ+wulr1Z9N7u3MMn89uWSLQ=
X-Received: by 2002:a05:6402:5208:b0:5c8:a117:b31a with SMTP id
 4fb4d7f45d1cf-5c8d2e2ca65mr2805711a12.17.1728065494414; Fri, 04 Oct 2024
 11:11:34 -0700 (PDT)
MIME-Version: 1.0
References: <20240927150738.57786-1-rcardenas.rod@gmail.com>
In-Reply-To: <20240927150738.57786-1-rcardenas.rod@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 4 Oct 2024 19:11:22 +0100
Message-ID: <CAFEAcA-CcJLKmy_9_jMceWrLA7MDxSJK8L8kb+U3N1=40B=Sqg@mail.gmail.com>
Subject: Re: [PATCH 1/4] STM32F4: new RCC device
To: =?UTF-8?B?Um9tw6FuIEPDoXJkZW5hcyBSb2Ryw61ndWV6?= <rcardenas.rod@gmail.com>
Cc: qemu-arm@nongnu.org, alistair@alistair23.me, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x529.google.com
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

On Fri, 27 Sept 2024 at 16:08, Rom=C3=A1n C=C3=A1rdenas Rodr=C3=ADguez
<rcardenas.rod@gmail.com> wrote:
>
> Generic RCC class for STM32 devices. It can be used for most of STM32 chi=
ps.
> Note that it only implements enable and reset capabilities.
>
> Signed-off-by: Roman Cardenas Rodriguez <rcardenas.rod@gmail.com>

Patches 1 and 2 looked OK to me, so I've applied them
to target-arm.next. Thanks!

PS: for future submissions, if you send a multi-patch series
could you send it with a cover letter, please (of the kind
that "git format-patch --cover-letter" produces)? Our automatic
tooling expects multi-patch threads to have a cover letter,
so having one makes the process a bit smoother.

-- PMM

