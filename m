Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E025C5478C
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 19:46:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdbUJ-0003Fn-Ms; Fri, 23 Feb 2024 14:45:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rdaec-0007RX-U9
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 13:52:16 -0500
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rdaeb-0000AK-2N
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 13:52:14 -0500
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-563c403719cso1336651a12.2
 for <qemu-devel@nongnu.org>; Fri, 23 Feb 2024 10:52:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708714331; x=1709319131; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ERNgwyVq9X+VncDNCrBwHPDnxP8raLWVng2bJPO13RQ=;
 b=h7bqIgtrHdG3DFTEvxrgutocdZghAPLU5Gyt0oRatHtgB6X9GJo25B47e+VJSMzILS
 tv1yLN+a6iv9kdnNyMQTimbc1OMSypz3Oc1S8OrOaWoG0JHWadaJ2h8y2BGw5ysgtfNg
 q9LOYHL8eI2No76+DL6UkQmWZwjHJ3+xVHp6CTdlMLvsMT6ZQji5d9zenlSmI6+RBcG5
 D+6+Wt9jzLCctZFJeIkxzodZXJWgxMBJyWgcjUlpVG/q1EO5F8nN9JQnvuyP9EP7tcRp
 rYmU9bxz/lzlu43Wg23NuSpPEKNvtmfsfst6PR/GlBGHKJqyZhMoFdd8254e0xom2tnV
 THZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708714331; x=1709319131;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ERNgwyVq9X+VncDNCrBwHPDnxP8raLWVng2bJPO13RQ=;
 b=b4NJ2XmZNFYUytQtQOFeQ1Re0fopTfLhfptGbMbq8bt8M43Mysk9+bS53pZoZpSqZR
 GnP6Ic8YBhZc4l8U/GITuuRuEFXwY88h4OqyOvF9a3PGpnXrl3Pj0+mB07Q9wuB0aNlc
 HgduoGxE8X5oaJIiyN1Izgt+HjO7+pMaDF4dgGDmHVChihDaL/mt/Qfi1pBbcbyvVijd
 p5bfa8Sy6kKgZcRhX3ZkF/H5nCcnG/PULetONxTak3NYt1vP6cf0RQDWr99V5bQH4Q1+
 DJ+c+RYAh/xEoCobrvDtvFquaKD2dJTi2qXFw6job7g7B0nGbtl7Z5L+O2+qxAsgPkwM
 B9EA==
X-Gm-Message-State: AOJu0YzAPp8zdLft9N9LBX7fcmyP7vuJBB0LAFtitZKCNkDyiSl5Gh4W
 q9lhYCDi2CEyBQVIyfqhaq3kd7cHoZYv5Oud/0mX9AUNC1x4QYfnmayGrM6WvRuhDLSUNMc8i16
 A8RrEMu8ogLsOUHIl+ZfmI6mt3tbArrv0OKiBag==
X-Google-Smtp-Source: AGHT+IGqaG+RfwtsXwdVzrsTwgrwzvMigot5Ab7zsrhQSu4xgK+fJPrw4beNt5bpqeKwaDuBCZJawia9j1AJut6jSf8=
X-Received: by 2002:a05:6402:3456:b0:565:6bbc:3839 with SMTP id
 l22-20020a056402345600b005656bbc3839mr380531edc.40.1708714331050; Fri, 23 Feb
 2024 10:52:11 -0800 (PST)
MIME-Version: 1.0
References: <20240220192625.17944-1-philmd@linaro.org>
In-Reply-To: <20240220192625.17944-1-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Feb 2024 18:51:59 +0000
Message-ID: <CAFEAcA9T=EjG2TrgjwOxq=i-_5kXiO0RNpkxMwcuOeiYgqd5nA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] hw: Replace cpu_interrupt() calls by
 qemu_irq(QDev GPIO)
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <eduardo@habkost.net>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Bernhard Beschow <shentey@gmail.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, 
 Alexander Graf <agraf@csgraf.de>, Anton Johansson <anjo@rev.ng>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
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

On Tue, 20 Feb 2024 at 19:28, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
> cpu_interrupt() doesn't scale well with heterogenous machines
> because its mask is target specific (defined in target/ARCH/cpu.h).
>
> While it is (often...) used by target-specific hw to notify cpu,
> there is no restriction to use such target-specific hw in a
> heterogeneous setup, where it'd still target the same kind of
> target cpus.

When would this target-specific hw call cpu_interrupt()
on a CPU which is not of that target architecture?
For instance, in the typhoon code you change in patch 2,
the CPUState argument to cpu_interrupt() and cpu_reset_interrupt()
is always that of one of the 4 CPUs pointed to by the
TyphoonState struct, which are guaranteed to be Alpha CPUs.
In some hypothetical world where this machine type had an
Arm board-management CPU on it as well, that CPU would not
be one of the ones pointed to by the TyphoonState struct,
which would still all be Alpha.

I can see that you would run into slight awkwardness on
a device that wanted to do this same kind of thing on two
CPU types at once, just because the defines are in cpu.h
and you can't #include them both at once. But are we going to
in practice have those on a heterogenous machine?

> The Alpha Typhoon HW is unlikely to be used heterogeneously,
> but it is the simplest case I found to illustrate how I plan
> to remove cpu_interrupt() calls from hw/: use the QDev GPIO API.

I do generally think that it's probably nicer design to
have cpu_interrupt() be internal to target/foo (it's how
arm does it, except for a handful of calls in obsolete SoC
models). But I think it might be helpful if you could give
a description of what the immediate issue is that means that
we need to do this cleanup to progress with the heterogenous
machine work (and to what extent we can leave existing code
in old non-heterogenous board and device models alone).

thanks
-- PMM

