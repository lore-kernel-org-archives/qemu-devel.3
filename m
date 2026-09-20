Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 529ADC982DA
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2026 21:46:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8PMb-0003eo-7t; Sun, 20 Sep 2026 17:46:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1x8PMY-0003dk-Py
 for qemu-devel@nongnu.org; Sun, 20 Sep 2026 17:46:18 -0400
Received: from mail-lf2-x10.google.com ([2a00:1450:4864:36::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1x8PMW-0006dE-Tb
 for qemu-devel@nongnu.org; Sun, 20 Sep 2026 17:46:18 -0400
Received: by mail-lf2-x10.google.com with SMTP id
 2adb3069b0e04-5b5e4f1e419so888515e87.0
 for <qemu-devel@nongnu.org>; Sun, 20 Sep 2026 14:46:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789940774; cv=none;
 d=google.com; s=arc-20260327;
 b=bn652J13Hpkm04eYw+hO1ILbSnC85Euk8yNjAX81fCntz6HahLdpv0Xj76ZApeN2ng
 fmZn6NqpDzFIiYkTRiO38XYtx2TduG6VFrG9yMM9cW1uBj4aEGySrUSsPaf3h0294iAS
 ICrC0Sabhk7e14+okk9nCpuFi6zmWSB5FgOl6JiIidnzy3GjhYNAabQZurJzS5VQffk+
 H5lR0d2bWJuSwDV5Tx5dupoStK1lHzWiIizrGwOTQQZDh0PTz1a599qpdxwFWhNTAhxS
 XNr/pU0vmzPPiBonHB46noQXoicCXCSxhqOBD2SMVX3R4eXYNO/oRAAQSKpDdfNPl0Ht
 yBUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=GoI51iHVUlz34MyG5I0dLx/zT2GNZ8BOA/2vorQH00A=;
 fh=As83UklfS/tEI+2YiN8BqNnyk+rw8YeizYHxIK03tjk=;
 b=WuvolyQKlSpMoLA+e9elrdHI+Yy3eJMVRPetmREyw1/LQOjMHg6tstVRdKP141w0Vh
 BqhXJaQvm5XCK6r1GdhXKmyorMMedN7K/1RXNaKB1EcOoauBZ024aM7fZtUiv4X5Nu9J
 3uYxYcZULwdZ9R8J1RcH4WIdAf6Gx2G0jvESk4mnaMA0Hm4ePvOf4fSg5gkPNUh0ja7T
 KJQa0ojSFZpyZlBlaZJoscVPDDBFI7BxZeg69DsoTKaTLKyJJFEQkXlwIsqj4mtay/vX
 gyK5D5s9aY3MqGkGR0ZHvFsAIp1dYq8F77hTefIVv2YmkTNlOZuJXCwh1xN8lkaPn/O0
 CLUg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789940774; x=1790545574; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=GoI51iHVUlz34MyG5I0dLx/zT2GNZ8BOA/2vorQH00A=;
 b=EW9d11ndPb2+vTepCOmmQxxit0KkDGw9TtZeV7+q3uMUhYIR3ghlC1b7t397DP+NN8
 x5duPg7/sz2DmO+YCRCbIG7Y2Catdw/sAlrZj9+y/lm2kGxAEJKI9RpDJ5mCKRmgygHR
 VOU2oKtRCB4nRdPSHFm8jQAnYasTJqgnrXw7w+9C9VxUSU1rzozWAIRdgdGCi9NzGQ6u
 ow0MJpRscD9UM7+t3ZkL3NFz1kLGCPgcOMduiZf18ipdVtkOoq/6HUvetv3so3ugKy8N
 hHjiqoqoisyS3zz9JSs5U4FWYZ0lX2rI0ebmX6uy6geksDKtRfMrKt8YgVk3DwT7wUBY
 RyfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789940774; x=1790545574;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GoI51iHVUlz34MyG5I0dLx/zT2GNZ8BOA/2vorQH00A=;
 b=1uhNaPl559BfsroAVg9odX7WaV4C34uPjrPIrNj84cnD0KVnFLmbr7a8EjDf1JrbeO
 ofsX/4CkDjNPFEbsqyR1YwRQTjFc99x2qVe2hOWz/ilWPWtURyrGUhJCuOiWd98t3/dD
 NMwitZk2WZ4evVODBigS9sU9XbHUC2mUHk/om9VY0OwdaSEyLREtiE0Bf//+5LegeApq
 16oF4wE5OWUw1wP8tzZd84WoOkt4KKWHGT17erfgrZqDdhx2dUs7mxRjDxFszjChLXsP
 qWZVyuTjnH3X04Zn8dPJO2dE4cEyLbED9RAvDf9qK+h+xHbA0PWL1jlUVlsjOGOeM4oc
 Mm8Q==
X-Gm-Message-State: AFuF++mPNLAMH2/xHQMjgd/pF2D9v5U0pVJpAfBUggZUNDuyCC1Xd9zN
 SVH7S53jXQwD4CL6ePgPC1xMxITVA9SUSYx9Zid/8lQzsxFErdPNS4t5tqlyEViCsV1nFeVhHSU
 X2PXxiWmsq3UbfETf90H/M8mvQjC7o+U=
X-Gm-Gg: AYBFou2n5Md02h12HG15Oc/KkflWtCZQ2RK93waYJmfYsdTHYtTApWy20ImBuwIcZSB
 Kb7EZeCpBgqjja5c6vJgV69522jQU1vtQOU17DpCKF9109OdLsnkD/RaoJAO78zmI+a+Xp4DCYS
 Ozh/CoQZjZNJgHNeKfqBWY/HrOoqfSGNZabDGFC5AK5E/bvqqgUn2MvoCySinveDU0rvY5Hl7Wf
 dCEQr3IJov64FhHeh5/StpwhnFI+8DVZrcVCjBSQ4S3Dk/47GT7aN4cx5+NPLMtWb9lt04lmOdf
 xmIV3KdqkvIMP58nubqUeASUXyv93jlUxWjT3mk744gJYoj0YI5S4IqUKf8C71z0SGwhWR7F0/E
 vzNTIB3FqcfYKpg==
X-Received: by 2002:a05:6512:15a0:b0:5b7:f0b4:de57 with SMTP id
 2adb3069b0e04-5b8c143b104mr2352819e87.6.1789940773777; Sun, 20 Sep 2026
 14:46:13 -0700 (PDT)
MIME-Version: 1.0
References: <20260917220718.60899-1-richard.henderson@linaro.org>
 <20260917220718.60899-2-richard.henderson@linaro.org>
 <CAEdQ38GUXfAvrgCjb6gqKk4Ph72HrGXZYo28QwTGtHZpuTaWOw@mail.gmail.com>
 <428adde7-03da-4385-9138-06831afd26e6@linaro.org>
In-Reply-To: <428adde7-03da-4385-9138-06831afd26e6@linaro.org>
From: Matt Turner <mattst88@gmail.com>
Date: Sun, 20 Sep 2026 17:46:00 -0400
X-Gm-Features: AcwNN1Xgq8AiLoPM-l0TBo_y07Y7ur6a94nb2DEnXU1aEwNfkdqJj0u41WTOlc4
Message-ID: <CAEdQ38GPJn-n5hyoN8ciYjAtLwh7SscThkezq-WJ2JServBVgg@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] tests/guest-debug/run-test: Add --pargs
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:36::10;
 envelope-from=mattst88@gmail.com; helo=mail-lf2-x10.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Sun, Sep 20, 2026 at 5:44=E2=80=AFPM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 9/19/26 15:27, Matt Turner wrote:
> > On Thu, Sep 17, 2026 at 6:07=E2=80=AFPM Richard Henderson
> > <richard.henderson@linaro.org> wrote:
> >>
> >> Add --pargs <string> to pass command-line arguments to
> >> the user-mode program.
> >>
> >> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> >
> > Reviewed-by: Matt Turner <mattst88@gmail.com>
> >
> > One observation: --pargs is only appended in the user-mode branch, so i=
n
> > the system-mode branch it is accepted and then silently dropped. That
> > matches the option's stated purpose, since there is no program to pass
> > arguments to there, but a silent drop is easy to spend time on. Perhaps
> > worth either a comment or an explicit error.
>
> Thanks.  I've added an "assert !args.pargs" on the system side.
>
> Since this is developer facing rather than consumer facing, I think
> that's sufficient as an error message.  Especially since we can't detect
> system mode until after argument parsing is complete.

Works for me. Thanks!

