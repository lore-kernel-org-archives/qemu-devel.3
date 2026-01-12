Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD757C9EC97
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 15:05:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfJKH-00007n-Dn; Mon, 12 Jan 2026 09:55:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vfJK3-00082k-8t
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 09:55:13 -0500
Received: from mail-yx1-xb136.google.com ([2607:f8b0:4864:20::b136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vfJK1-0001rT-LY
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 09:55:11 -0500
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-6481bd1763bso790654d50.3
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 06:55:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768229708; x=1768834508; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=66RAiGQHA8GMWTjt6n8PWtrv5ZOH1p/ZRrn2xlZl6Bw=;
 b=ekQz8qnPHTaMhtJvfOyu3q4HdbgrxniLBVZbdb/wpG08QCcZuTfpmpV27aBBqqsDoV
 vfSy75gf4L5uFUAKuG1f1HLFJpFbfFCtxOK9XLVr/6xFAcRQ7Hba1xYZGkGYv2j8iMrY
 l1l1BT7fjLMmWf9SoJbfLg8HSooWl7ROwFsoHsyGU0sEcvi7TSzgRkbXQrk44RnecO4M
 lGyLvx3pXFelAdouGzF1ZcXMB5cdoFlKtUPtACLzgibNY9dsx/2LVyUItJAZ8na1Scr2
 0TMqHF+KPqvcZ0j2xdAJBBVwsokK5thMKiLrOQIx1DlTfGqHK4cFnVhhobuoLkDBqsVW
 YVkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768229708; x=1768834508;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=66RAiGQHA8GMWTjt6n8PWtrv5ZOH1p/ZRrn2xlZl6Bw=;
 b=SuRgmzrqBio0AelmgQ+bKz6LQSQ7aMMxZJ0FTbjIJeOdrKRjBgCvwlghe3/KhsWgl0
 f6SLpNunpOpu+323/6Uqtj31M/Qdy2z0JczuBfcCwGYWb9X8MtMFvvYRYFjQmLmMf9Ku
 eM4L70FCh1ywdCnpa3YStyA9cD0IABOv6RkDgssN1KG/XM7znku+5F9Jo3M1zjPF9wau
 lvI9HfFZoVjW7o7SCGrj5iSJDa1bCAlbUqjb9ui/LW8EYkaaWNMP1t18p0qqDMemjF8d
 xvB09FtxjJhKYvwqm7nImK/E+hsjYSjs/dHiQfNl4hP1j5ph/8AUCknN3VKimU4tLstU
 TZSw==
X-Gm-Message-State: AOJu0YyJ9HyUmTuLda/KSEdm22vfzWIu7UNDFEWt+aVav6iR2S8ZKtgn
 XMW9SHnY7mLr8vS/1yHCdLUd7tIVE9ZdZPhIQAJ8EZhhJNSO4TdgnXrwvMEkSozduL5uZVbqwD7
 1Vi/NgJH167dsl0ta1gkMcUXVutxlek5LMEndWFFYpQ==
X-Gm-Gg: AY/fxX6/Z9hyItCvbEgp2WGTfF3H4OJboaWLp8Xel9WoVmlZNDCTxqMn1SNjRFmIf3O
 oB+FjQjc9LRbNI/DUQ6vz5B+nd1FFeaZ8pO2Zl/CUJ0jmMDMiqbxzbnLUUYdbvYiQpwljMuDwBS
 JZ97TQYndDQmMwDvFDvEj1B1MnBCi4RiMXrEk0Xehfy/0S3LZkxBjvUJRKBllI8pJguw1P3FO9r
 4P3SBWIrgp008GVMO6MKu0Qbe06JVrVCOel5AyYu+LpuBL16jrGlBItRj+fU5P+llnR0fcByLFQ
 tqjWNph008Nn4vdXWV0r81I=
X-Google-Smtp-Source: AGHT+IGn7LHteegYfZ9t2JQ9O1k8UAZYFlYopwwU+5PZ561ZBu0T8DbLaSyqlLUuDXGhnqAlVNd1+1peAp7HJI/9pvE=
X-Received: by 2002:a05:690e:1202:b0:645:54a9:11b6 with SMTP id
 956f58d0204a3-64716c67c2bmr15459992d50.52.1768229708199; Mon, 12 Jan 2026
 06:55:08 -0800 (PST)
MIME-Version: 1.0
References: <20251215170548.2594651-1-alex.bennee@linaro.org>
In-Reply-To: <20251215170548.2594651-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 12 Jan 2026 14:54:56 +0000
X-Gm-Features: AZwV_QjIMH7s6AS77QZdjwUlBptzLO-GUgV1qW68GeZpcCSFsWs5YfeSNYt-sUA
Message-ID: <CAFEAcA_b1=OFe1PnhhV0CPo=iHB2-gMCXONi0LUTTzHmm8jJJg@mail.gmail.com>
Subject: Re: [RFC PATCH] hw/misc: make the tz-ppc-port names more useful
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Jim MacArthur <jim.macarthur@linaro.org>, 
 "open list:ARM PrimeCell and..." <qemu-arm@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb136.google.com
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

On Mon, 15 Dec 2025 at 17:05, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> The TrustZone peripheral protection controller (tz-ppc) sits between
> peripherals and the main system. However this results in "info mtree"
> looking at bit confusing, especially as the sequence numbers can
> overlap and miss steps:
>
>       0000000000000000-ffffffffffffffff (prio -2, i/o): system
>         0000000000000000-00000000003fffff (prio 0, i/o): tz-mpc-upstream
>         0000000000400000-00000000007fffff (prio 0, i/o): alias ssram-0-al=
ias @tz-mpc-upstream 0000000000000000-00000000003fffff
>         0000000028000000-00000000281fffff (prio 0, i/o): tz-mpc-upstream
>         0000000028200000-00000000283fffff (prio 0, i/o): tz-mpc-upstream
>         0000000040080000-0000000040080fff (prio 0, i/o): iotkit-secctl-ns=
-regs
>         0000000040100000-0000000040100fff (prio 0, i/o): tz-ppc-port[1]
>         0000000040101000-0000000040101fff (prio 0, i/o): tz-ppc-port[2]
>         0000000040102000-0000000040102fff (prio 0, i/o): tz-ppc-port[3]
>         0000000040103000-0000000040103fff (prio 0, i/o): tz-ppc-port[4]
>         0000000040110000-0000000040110fff (prio 0, i/o): tz-ppc-port[0]
>         0000000040111000-0000000040111fff (prio 0, i/o): tz-ppc-port[1]

> So as a quality of life feature lets expose the name of the underlying
> region so we get something more useful:
>
>     0000000000000000-ffffffffffffffff (prio -2, i/o): system
>       0000000000000000-00000000003fffff (prio 0, i/o): tz-mpc-upstream
>       0000000000400000-00000000007fffff (prio 0, i/o): alias ssram-0-alia=
s @tz-mpc-upstream 0000000000000000-00000000003fffff
>       0000000028000000-00000000281fffff (prio 0, i/o): tz-mpc-upstream
>       0000000028200000-00000000283fffff (prio 0, i/o): tz-mpc-upstream
>       0000000040080000-0000000040080fff (prio 0, i/o): iotkit-secctl-ns-r=
egs
>       0000000040100000-0000000040100fff (prio 0, i/o): tz-ppc-port[gpio0]
>       0000000040101000-0000000040101fff (prio 0, i/o): tz-ppc-port[gpio1]
>       0000000040102000-0000000040102fff (prio 0, i/o): tz-ppc-port[gpio2]
>       0000000040103000-0000000040103fff (prio 0, i/o): tz-ppc-port[gpio3]

Maybe we should print both the port number and the downstream device,
so eg tz-ppc-port[1:gpio0], etc ? Especially for the uart ports
this would disambiguate:

>       0000000040200000-0000000040200fff (prio 0, i/o): tz-ppc-port[uart]
>       0000000040201000-0000000040201fff (prio 0, i/o): tz-ppc-port[uart]
>       0000000040202000-0000000040202fff (prio 0, i/o): tz-ppc-port[uart]
>       0000000040203000-0000000040203fff (prio 0, i/o): tz-ppc-port[uart]
>       0000000040204000-0000000040204fff (prio 0, i/o): tz-ppc-port[uart]

(and if you are actually programming the thing then knowing which port is
which might be helpful).

The other thing that is confusing in this output is that there are
multiple TYPE_TZ_PPC devices in this system, but we don't have
any indication of that in the output. (This is why the port numbers
repeat: port 1 on one TZ_PPC is different from port 1 on a different
TZ_PPC.) I was going to suggest that we could make "info mtree"
print the owner of the MR, but it looks like we already have
that, we just don't document it: there's an "owner=3D' suboption
that can be set to true...

thanks
-- PMM

