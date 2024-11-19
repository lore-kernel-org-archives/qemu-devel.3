Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05E14D44177
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2024 15:48:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDQS8-0008E4-S3; Tue, 19 Nov 2024 10:47:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tDQS5-0008DG-Ew
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 10:47:42 -0500
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tDQS2-0002T9-L6
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 10:47:41 -0500
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a9a977d6cc7so271442666b.3
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2024 07:47:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732031255; x=1732636055; darn=nongnu.org;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nzexb3yCi5uTkY5TUNQEshYGu8PtZhkhkFWp83xNNog=;
 b=xglMgXj2w2WT/TaIwIh77jADuAmivJTmBBnC7PXgMLov99etCYyM+0wYUTqKOfJ8s9
 DgmMlREPHepzVTsaugXSe9GR2V7+mkWE21uodcsF74vUToH8y6WQ2lTObr7vE8RzoRO9
 DcYiLsYqjQPFeBEWYLkyIBLenUo616msLT+jXOoHgINV+fBYuRSQ+ma6OB47NRBwiSL/
 mk0v+ru9A9qkK9M2FvjJoEjU/qIcl2GTcba4m60VH4u/kcYbR0t93twWMLq/4jAb3DAa
 mu9dcTWWH4fkS3p6pH2edaoKXPF2w7wMFL+swVye+OhKDwEpjAniNSWE+59NBXpOlZjr
 rXcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732031255; x=1732636055;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nzexb3yCi5uTkY5TUNQEshYGu8PtZhkhkFWp83xNNog=;
 b=gd/cdq96WJ2mvERb1k6DH77B7EASUIERTkkdmG2cKrIGMu1hCDsVfkliwmtqQDTdvN
 osrihLRBORLqOc+XP2QdIGtetqoHYpv37NaOir2LqV+hXSXsGY3lqW0KHpiUHwwixb33
 uk3DtIJteTP0ElWbt67TBP4eLrvShyimTXhI5UZKboa/TEtOTAlDcJ1Q9vM8XXwdscsh
 QSpgURmnKyBsTcXl3UjFDDuEd7FgbrxErb/qEyvVwopabQd/9RUE4YgMARGPIVkHLO1P
 MlU7jX/gQtgFgq//9Y8BjdPkcpl0k0AvbSj6oVqrsWyVNc/YWpgfxyQUlLTvZL++EJm8
 erJQ==
X-Gm-Message-State: AOJu0YxGdpnfekDwPS/A+7THFZ88xQ0OAPGr5lLsan1PlEpzHGVkelHW
 8qmaezc6pirYGRuvh6CVSdNK61uN59ihe6PYsNPCxzF++dg7rXHsyuGS/RcFt+Jebgi1685k/of
 KIgFlTvDtbFDj7hwR+A1X6i5V1JaHgEJdY+HapVs1YRvG6MIz
X-Google-Smtp-Source: AGHT+IHqUG/77+06U6tGXBJ/2M03YZbG6M6RLzwKPRjChLu2CH5fgxxQncblKTnsI5/p3fe3tTo1iNwq24ReCbtpxj4=
X-Received: by 2002:a05:6402:50cb:b0:5cf:c22f:524a with SMTP id
 4fb4d7f45d1cf-5cfc22f524fmr11664126a12.8.1732031255604; Tue, 19 Nov 2024
 07:47:35 -0800 (PST)
MIME-Version: 1.0
References: <20241119142321.1853732-1-peter.maydell@linaro.org>
In-Reply-To: <20241119142321.1853732-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 19 Nov 2024 15:47:24 +0000
Message-ID: <CAFEAcA90eZNDhDB7Xhk16Fy8gHcDoT0vEKRzGuKdt02x-ieWAg@mail.gmail.com>
Subject: Re: [PULL 00/15] target-arm queue
To: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62f.google.com
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

On Tue, 19 Nov 2024 at 14:23, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> Some Arm bugfixes, and a few non-arm ones that I also picked up.
> Most of the diffstat is a test program.
>
> thanks
> -- PMM
>
> The following changes since commit af4c4fd128d3e73f7435a3723e9fcd2ec64c5f4c:
>
>   Merge tag 'pull-nbd-2024-11-18' of https://repo.or.cz/qemu/ericb into staging (2024-11-18 20:24:05 +0000)
>
> are available in the Git repository at:
>
>   https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20241119
>
> for you to fetch changes up to c5275c734233d6457f2340ca01d4577a971ea328:
>
>   trace: Don't include trace-root.h in control.c or control-target.c (2024-11-19 14:14:13 +0000)
>
> ----------------------------------------------------------------
> target-arm queue:
>  * hw/timer/exynos4210_mct: fix possible int overflow
>  * hw/net/rocker/rocker_of_dpa.c: Remove superfluous error check
>  * hw/intc/openpic: Avoid taking address of out-of-bounds array index
>  * hw/watchdog/cmsdk_apb_watchdog: Fix INTEN issues
>  * arm/ptw: Honour WXN/UWXN and SIF in short-format descriptors
>  * hw/intc/loongarch_extioi: Use set_bit32() and clear_bit32() to avoid UB
>  * system/dma-helpers.c: Move trace events to system/trace-events
>  * target/arm/hvf: Add trace.h header
>  * trace: Don't include trace-root.h in control.c or control-target.c


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.2
for any user-visible changes.

-- PMM

