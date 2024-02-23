Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFAA9C5478C
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 10:05:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdSQU-0002ER-U3; Fri, 23 Feb 2024 05:05:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rdSQO-0002Bn-90
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 05:05:00 -0500
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rdSQL-0005cV-L7
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 05:04:58 -0500
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-563c595f968so756161a12.0
 for <qemu-devel@nongnu.org>; Fri, 23 Feb 2024 02:04:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708682696; x=1709287496; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4M5ntZVMWz/vrWsPij9TMstviqJG8jMeX2xD54Q+6R0=;
 b=YY4IZ/5SpK0ICHScBN/s4hK+FIfibrnbsBuHlssT6GSw3J4dAMWzFKkeyTWXCMjMuC
 AS1YIBfyrqJULnrfXJpSsnUp8oW3yxo53bxVqCpdtJIUJRrpDp3+0/aOkHDV8YceGxA6
 oxqqat1dCv2NqirMQhkb/Ha/Y4YKhKXpo956vY8TmhPBw2cjr7hiU0ObmOBCoLcNo3t7
 vmd/GqO4YpIqrywDC3viXgwjErg/sTKmsgMVoHT7gy9ReIQXLbZAOoAcNJ4ddvI+OKRt
 TvWUrGABTqAt7ZZdVzM6CyimxRQX1bzgZVaCAUjuK7149kKLyynyogGdeh7Brs3ASFXL
 6Nqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708682696; x=1709287496;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4M5ntZVMWz/vrWsPij9TMstviqJG8jMeX2xD54Q+6R0=;
 b=NM0karHL0/6wkidwcOhObKj/oumMhfp0nBXSRcFJdU8apM46ma9A8Fr44RndLRehFc
 2MnMJyt/ftOZg1jhUE/h9Uz7ct+b93YBRz+c1PoS1EnVhUjlCOQGjjYbsM4NgzvigJLb
 DGSoACg/8EpyBBK/iqcnokSOfyEr14GzeQEXS/G7S4RDqTksW1vcwDPiel92rrR73BOo
 K+Qj3f+qftSQQXMQV2S3NL2h39zS4jDPbbtPsEshpJX3wwO1+WNQruvC4ZqmsEj7wTXK
 hk+EGPPL9Z6Ew3bw4cJ1Bf82Dd9dJ539hbTVU1DEzKmBm6Tkos+nGUFlGT55L0QoLcLP
 eaeQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUngEjyGfn2srigRUAIKwTILLkyaEMl4sBWcN2RdjP7rJVqvuxioNq5sxhFSNh0zbbGhQ+Tno7cFruqeccD8/4bP7f66S4=
X-Gm-Message-State: AOJu0Yzi1jYiycgPEk2z+JYpl04t3ELMsPbDMGKaxTXTElihTJdoi7uK
 vWq5DoUjPHYjXWwdJIIyG/YWU9JPbttwwRfn6WIBFUeFqBknQiqxL8/m+Dp//j9R1APaf+9rph8
 dWqIounb2+4+xWNe/OYMALu/nRh1DJTIhuV4JJQ==
X-Google-Smtp-Source: AGHT+IHeDjUCH631mr9r3r9hVRY7K/HLvjfYX0PiyvoiqdF3dROyL4iGzQo7ygCv+y/b0vUO0ILYBJpY6jgtCdMrGi0=
X-Received: by 2002:aa7:da5a:0:b0:564:66c1:d527 with SMTP id
 w26-20020aa7da5a000000b0056466c1d527mr798979eds.36.1708682696021; Fri, 23 Feb
 2024 02:04:56 -0800 (PST)
MIME-Version: 1.0
References: <20240220134120.2961059-1-rayhan.faizel@gmail.com>
 <CAFEAcA8GFFQ-L6zGcft9q8arJxuggraHYRhcAf4q+Oi+VMSP3Q@mail.gmail.com>
 <fe96d71d-6abc-43f7-9b83-8bec93ab5512@linaro.org>
In-Reply-To: <fe96d71d-6abc-43f7-9b83-8bec93ab5512@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Feb 2024 10:04:44 +0000
Message-ID: <CAFEAcA_70D8t3xjM9TgnzzM31U8rqHFthY72nPk-te-2yEitxA@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] Add support for I2C in BCM2835 boards
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Rayhan Faizel <rayhan.faizel@gmail.com>, qemu-devel@nongnu.org,
 pbonzini@redhat.com, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52b.google.com
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

On Fri, 23 Feb 2024 at 06:23, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> Hi Peter,
>
> On 22/2/24 18:54, Peter Maydell wrote:
> > On Tue, 20 Feb 2024 at 13:42, Rayhan Faizel <rayhan.faizel@gmail.com> w=
rote:
> >>
> >> This patch series implements support for the Broadcom Serial Controlle=
r used
> >> by BCM2835 based boards for I2C.
>
>
> >> Rayhan Faizel (3):
> >>    hw/i2c: Implement Broadcom Serial Controller (BSC)
> >>    hw/arm: Connect BSC to BCM2835 board as I2C0, I2C1 and I2C2
> >>    tests/qtest: Add testcase for BCM2835 BSC
> >
> >
> >
> > Applied to target-arm.next, thanks.
>
> Sorry I didn't notice earlier, the I2C[3] IRQ lines have
> to be OR-ed using a TYPE_OR_IRQ object before reaching the
> INTC. I'd rather a v4, but if you already posted your PR
> this can get fixed on top.

Oops, yes, you're right. I didn't notice that. I haven't yet
got to the point of making a pullreq, so I'll drop this series,
and send my r-by tags to the list for the other patches.

thanks
-- PMM

