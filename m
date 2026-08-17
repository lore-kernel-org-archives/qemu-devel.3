Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C383C5DF66
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 15:51:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvzcH-0003WV-Qt; Mon, 17 Aug 2026 11:51:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wvzcC-0003Lc-Ls
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 11:51:09 -0400
Received: from mail-yx1-xb133.google.com ([2607:f8b0:4864:20::b133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wvzc9-0004Km-Ee
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 11:51:08 -0400
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-66ca4bdccfaso1676800d50.3
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 08:51:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786981864; cv=none;
 d=google.com; s=arc-20260327;
 b=UfP/UkHgSQIPXtXV9YrutZ4bpwgqVuo7cTdxyuLfZ2nxG9Jyvy3AWRZiPwP4Sn/4JL
 19pf1SXutoRaS0ThjjZfBw3m/IDrtOtmPipU5Z3nWX3/3xm+VgfytDxtm3R7jakytH63
 01NNC+hlG+BcTLj8Li1Eokm1KRlf8/e8qyxfuHyVl9Hgq4aEmfI65y66FvzFiRK9CWl/
 Fe1XWJBERRymwamrwcyyVZ/dr/RBk/kRcpdxrauo8FqdARf7KzweqV9j7MPh46JW3eyA
 peHFrz4jb6EcX74mwqBIsFDQwiOQ+OFuo/Gq82AL5y3vXuvRQ9+lP8zj/v7ba0ByaQsA
 FBVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=vM5BNPuePd2kR65SJoqxnhvEPlvFj+pZbFCJNrLvjxs=;
 fh=xChv7ieWS1sj6jE9IHpGYXOFSuW+3i48YUpPGYmP/DA=;
 b=rzIEeNhYfTlzSf+TZA4WYeSioG2JgYAqtCDFPJmwb7aoLwfHhOnUf4WbcgEOB0GXLp
 0WlFg9sNgmU/ID1cKMk2XHr0b9V9JpSJXPg5Bbahb1Gt9yaJ5jLtlZl22aZDuEtLe5Uk
 PfNMD4s6wYHQkvAXvpItievIVBvSf4YfLpnOnvpuq/6HpVNqfL7/H/pLThG0W/3FFqkk
 2KXUXdOAV7ENNUSIHog9r7xcMO9J1DhM5eySmIhFNT9SX78Ygsq5eLOAsekCvuSZW929
 pDBio7FOMI4d+FRLhmH2izti0UYOUZw27TvkJg98fNoq4qS1IRk1soWen+o4GichuXbV
 4qCg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786981864; x=1787586664; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=vM5BNPuePd2kR65SJoqxnhvEPlvFj+pZbFCJNrLvjxs=;
 b=DIZ2xFKanMs4MRxkZIwCTFDbBlep5Ax6mJFiCDYBA79Uakbb5Vl8ioAfxtWt4tHxQy
 PYAi+LBsCJSHuHblP8+C8gvgQ2FPWLsz5GCVD3OERaod0Vb1wHZzD1DnYw1QTEgz18XD
 FFRIayfVqd/sg3kf9Jkk5B/6YQPGfAxtpgJO63YX3vEbFJQ+85ffpYgY6tvnVM2JkLW0
 9lQ26W8cvq59WaAYELAYVEexUzNA4T2zvZUbLVQjrnq3VAvw6b7xh+3F5KjGRlfWM9Ep
 9K7fEPMZ1dx8zcL9byv3DeKZ7Kvxt2Hcx+a3yaku5+BiuNZoLdO83XuerhvT/xxTjPkD
 5PVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786981864; x=1787586664;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=vM5BNPuePd2kR65SJoqxnhvEPlvFj+pZbFCJNrLvjxs=;
 b=EtPNyrWNj85kdqrUNtmsbzilxvfFUyQmjDWjD18/1T0kbBCJCGJN6LS5B6kRW/GRBc
 ogzFG6pi+Qe9MGMSNtorJw1AxdYvBw87KwKoXOsEAAOLFReoiCZiWNLezU3UlY0/nTSq
 6fQi2LSNbdPGQKpVHiiN8zuwx19EDms13zsWb4CGH8+nX5X+ICKKzYiDDUASHtWw82hl
 +/v2FjWDLP9YlGn6jbBkp7R7FO6h8vSYkWuiIPoIKKz0dYURxWg2f7Zq0bh+9XKKkYcc
 3BshefuFKIq3d3o/mpS/XFAzRvNoC01royL+lOgej/2VSsLhuAbX2s9cAEWzf6AN4psM
 wvPw==
X-Gm-Message-State: AOJu0YwIbtQH39LsWho98jCstxfeoKi5bJr/TmSg/zha959dXemx4Bvt
 D1TdAKuq07hoNHKgjd0/YvTFpYLCEU5IBmzyV9o4yVFZf6GpIb+87R+ISjPJgQpdZZzby54ikmy
 cb4vTKGpFC6Aq59Emzkb32Gtwd+BmJLyxH7BtkA77cw==
X-Gm-Gg: AR+sD13VsiZ0bNRDOFBCFuf9aOXKSFJq1d+rw29z5A65VjJxHGjBHLx3Gmnm88DEuWi
 nuaBbXyZ4ENeBlvDkIGF8KuGNCcDFjCq6quXOfRk3FIXx29DY/AFIODpRVW4/el2PzCHcmgPGly
 jVClNhmF7FnbUhW5FtpP85r27vPD2mAhD4N9VMRl6UJhi7hMaM6Xq6KYB/gaDFG5edGCAGXJa9m
 /7QbAGK5OkMfW+kfbmoEv7jrVDbDIP4Jl5t6YpDQxDxWT8OxZu0hVw2EN5ONptFnprP1zZrRdmO
 YnlDLqm7kn56AnkTqFmCeOBQl7ySNFuc8mhKV9qr9nbvn3W9OK92qEBwta8SWvvwwnYLX/TW/n1
 mCBnNgJs5VDl/Pdp+Pl3Nk+jfFUv1
X-Received: by 2002:a05:690e:12c9:b0:66b:26cf:6e35 with SMTP id
 956f58d0204a3-66c72c7b4bcmr11014684d50.30.1786981863905; Mon, 17 Aug 2026
 08:51:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260805153005.9989-1-simonxhy0404@gmail.com>
 <20260805153005.9989-9-simonxhy0404@gmail.com>
In-Reply-To: <20260805153005.9989-9-simonxhy0404@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 17 Aug 2026 16:50:51 +0100
X-Gm-Features: AcwNN1UBdjNCKN9qGaOYl5lGsSeiqGNYuKZMgH7BbOV7xcFHq0y2CUSDd7xoQsc
Message-ID: <CAFEAcA_fMJA4m_HYoTh70=t2XhsdSOn_g+X2=1LVgXXxa7GqqA@mail.gmail.com>
Subject: Re: [PATCH v2 8/9] hw/arm/mps2-tz.c add Arm mps3-an555 board
To: Simon Xu <simonxhy0404@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Owen Giles <owen.giles@hpe.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Robert Elliott <elliott@hpe.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb133.google.com
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

On Wed, 5 Aug 2026 at 16:30, Simon Xu <simonxhy0404@gmail.com> wrote:
>
> Add mps3-an555 board modeled after the existing mps3-an547 board.
> Add UnimplementedDeivceState for timing adapters and qspi controllers
> in MPS2TZMachineState.
>
> Changes in AN555:
> Timing adapters in APB PPC EX0 instead of MPC.
> Additional QSPI controllers in AHB PPC EX0.
> Additional AHB PPC EX1 with DMA.
> Create standalone unimplemented devices for MPC instead of timing adapters.
>
> Include documentation for SSE-310 and mps3-an555.
>
> Arm mps3-an555 TRM: https://developer.arm.com/documentation/107642/latest/
>
> Reviewed-by: Owen Giles <owen.giles@hpe.com>
> Reviewed-by: Robert Elliott <elliott@hpe.com>
> Signed-off-by: Simon Xu <simonxhy0404@gmail.com>
> ---
> v1 -> v2
>         Move board and application note documentation locations
>         Revert MPS2TZ_NUMIRQ_MAX to 96 from 100
>         Fix timing adapter and MPC creation location
>         Add QSPI controller to AHB PPC EX0
>         Add GPIOALT2 register to FPGAIO block in next patch
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

