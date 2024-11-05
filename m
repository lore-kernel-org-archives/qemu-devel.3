Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5DB5D2B944
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 15:47:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8LmS-0002ze-LT; Tue, 05 Nov 2024 10:47:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t8LmP-0002tI-Pf
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 10:47:41 -0500
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t8LmO-00063Y-5b
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 10:47:41 -0500
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5c937b5169cso767379a12.1
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 07:47:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730821658; x=1731426458; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ik95ZXJC3ZL1WpqIauyqIHpPImrSIFUzk9xSRVgVePg=;
 b=UI9b1S2Sih8TWQBmi7ZHfSZOWaQuRLzgo2+1wrdhFyMQW1vwDDaWeejO0inFGtHCYe
 wDoAl9WS+gxGlbbDnClwsBD8Ca+45O/W2KH8hjP+po1p6G/RUXuu137yCEYeq1smS8V+
 rvzf4ebg/AgGqqunSOKe2mXb/0PRS4G0DSe87nraRe09YukapHm3Ev4EvLDVf0s0fpw0
 lgDoAtHCko6clSNChW5ZoZf45lcUChpmu2E5SvGAy/LSAPBo0dRkDzrPvFmOCaoST65t
 OBymFB9KgLxV9A5ZStNeYsCV9QkBsRlNWOqZS4noPSPuhPGwSFmt1IiJ6kPKMLzYTkyq
 D9Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730821658; x=1731426458;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ik95ZXJC3ZL1WpqIauyqIHpPImrSIFUzk9xSRVgVePg=;
 b=wU6fHPu+IMOpmdp8Trgy65USj8eMzP1t4VJgxkIHBM+Y+rVq2q5QqJo/Up/yjzYOCf
 aYa+NbNvkcYP/FoflyB2sgQ5brrhurF3o3+wyW15o4MKZntMqUd/7acFwP8WTsYSFUFl
 5q5Jbq4EDzBwxXwHXxj7YcTXS6P7Dv5AbYT3KNVHhjvsN1RB2dqkeVKWbUggFFok4SYX
 gkJTLnxbXnndqMLkNS0yMvD+3z/f36nYZkOZ9bz90ibEcpOoZ0O2BOGthHmTKxtSVB9F
 MMySUzAMuj50GVrxp19hls8jizTFEbn8uuC8vkghLjmJkd72dROtr9eeU0VOEObZeep4
 l9sw==
X-Gm-Message-State: AOJu0Ywx7tcknGi4ZM2SKPGh0qyvx2r3EEIVTeIoxVWGK1LkpKfuZWj4
 WnU6cKGJTouuexTPbgDXk65Zvgz9YFrTfhVFT7Y1kp+tAG/cDFU5/RhFoj/uMJs/gLDnGzfTyR5
 uSHDF2LgfzBBf68vcYZHZ+xvoSMWTgAG+ju4IoA==
X-Google-Smtp-Source: AGHT+IGBUYU2FmZ8yhGB2SPnT1Sj5m9Zz8LVUfSAUNzpHijWLEyIX8vm03e8/p/uZWl2SAv97e8l0wpW75Eq2pP4Tl8=
X-Received: by 2002:a05:6402:2811:b0:5c9:3f1:e5cd with SMTP id
 4fb4d7f45d1cf-5ceb8b49f3fmr15931686a12.0.1730821658406; Tue, 05 Nov 2024
 07:47:38 -0800 (PST)
MIME-Version: 1.0
References: <20241104105250.57818-1-philmd@linaro.org>
In-Reply-To: <20241104105250.57818-1-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 Nov 2024 15:47:26 +0000
Message-ID: <CAFEAcA9oXyqcpHxHHed4FTBWUKQx2YHa=Mp45TA=vqEdzfk=dQ@mail.gmail.com>
Subject: Re: [PULL 00/14] MIPS patches for 2024-11-04
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
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

On Mon, 4 Nov 2024 at 10:53, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org=
> wrote:
>
> The following changes since commit 92ec7805190313c9e628f8fc4eb4f932c15247=
bd:
>
>   Merge tag 'pull-riscv-to-apply-20241031-1' of https://github.com/alista=
ir23/qemu into staging (2024-10-31 16:34:25 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/philmd/qemu.git tags/mips-20241104
>
> for you to fetch changes up to a144a3baa61e3fca1a7946685128c349dd92c76f:
>
>   target/mips: Remove unused CPUMIPSState::current_fpu field (2024-11-03 =
05:52:49 -0300)
>
> ----------------------------------------------------------------
> MIPS patches queue
>
> - Migrate missing CP0 TLB MemoryMapID register (Yongbok)
> - Enable MSA ASE for mips32r6-generic (Aleksandar)
> - Convert Loongson LEXT opcodes to decodetree (Philippe)
> - Introduce ase_3d_available and disas_mt_available helpers (Philippe)
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.2
for any user-visible changes.

-- PMM

