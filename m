Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FEB4CCD183
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 16:37:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6tdT-0004fM-O6; Thu, 09 Oct 2025 12:36:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v6tdS-0004ed-Jm
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 12:36:58 -0400
Received: from mail-yx1-xb12c.google.com ([2607:f8b0:4864:20::b12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v6tdJ-00033Y-Ml
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 12:36:56 -0400
Received: by mail-yx1-xb12c.google.com with SMTP id
 956f58d0204a3-63b710f276fso1242154d50.1
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 09:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760027805; x=1760632605; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ISEsDYfRJnbaETlfdvzNPE2SdTEJ/sC4RuJ7kNzR684=;
 b=Aqr9ue71Q5OgfWlbbubqPYe0NVPAGiEb23QrcomJD0PTkIN/qY7sgO62yaUYagHzAX
 VQBAp//Vfhg6+bPyOKf1CCTI7zgDd5szAdvYg4q58dn6y6vB057ij7ucmVd0uouZ3GtT
 1lXiyapMEyO2vnngJ6rvzftw5SJz81pFOrYVItCJ4He4RTQy+h3MqTI5C6De8oGbV/kZ
 NwrLh2GpGiFrljHn5uGkKgcP6QpRyQnXnqWhbbgKawb/mhqKSvnBd2HJ+uutlQGjSHBG
 P2USOtsIlIoRjuP03NDjxe9dEvBaZJ/jL7sOulpNW+177mj0Haopr45eZvbSusN1OLPF
 HQnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760027805; x=1760632605;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ISEsDYfRJnbaETlfdvzNPE2SdTEJ/sC4RuJ7kNzR684=;
 b=ciK7KFqnSLeW4ZKS3SSoh4/RI7nl+/4aKi1aB2RbPhN2MSD9Cpc3ZyHKISrPRxuSKA
 HLJFE4zHcsMNID5PGPXu69qknlTcwYDjZo1+lILjp8Lj8ignMl09aDpOy9ksHJc+qW4q
 slcxAZKqrWugm8g4hzFvqKZqjmPyCUZ76XJej//Gb5pGUqi7aCGYAklSkug8jTEah9tg
 p/Y5sHzx6Rvwwd2e31D1sWp+SLCyurBilK8TV6cRY86ea6aJhO7PgXx1Du1OGP7VrchR
 qz9/ZCc8E/tqfmuqywaS7lK5BSW4PVLSt+Rtd4BRtTh5VsicIvWY9IaiVSfGv8kXCJqV
 YUlQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV2yWVPAn5Nj/XbFsZzsykK/KgDgOBT43OcmA7iAjNh2CPZmmQFk6qaB3vszPR0gkrzEl7igGH8qO0e@nongnu.org
X-Gm-Message-State: AOJu0YxH0o2bEBid+BtL8a0Z2XE+ZtwAT2C0Rh1uzqpu2vErVivXZAdZ
 j0/dyjaeAzxEREG7gA2AZGr13Vth01VlJMJjkjo8ByDaEmyQzsfsYiqZXc/JIGDiIINA0E1jrPu
 S/uEyJtWvwkT9uHkyi+y2WAzR3qgVVphdS72lR/RPWA==
X-Gm-Gg: ASbGncuA7i/ENnojZqLyluBQfHgCEd9wE0jQSGxuvYBHtIEjHN4KWhfzggU4zfi5BB0
 lSEW82VH9TR7PkeywHLY1/vCbtUyoFf+SWL2SBFLzS9s43Dy6aLg30R8h+Ez4OmDzgk1OM8gUta
 6jDHUuVSuMzQVq6xKTKFGNYGGDlQnOrAPqjTnvr0tOoexXCpb63GvgjC86C5gGXnPNVNftg31TU
 YBESxFjRfVoTBOjok1xnsjsUnqnALwJdhW2RhSxlHyWbyk=
X-Google-Smtp-Source: AGHT+IEw/yhF5vDCekLi1qi8P1pXjZwKXAGi+Q6H9roUj5HpiPiTJWyElrMvreoXiX3zq+crX8tGdlMTs38ymEP3d8I=
X-Received: by 2002:a05:690e:1597:20b0:63c:e3eb:20d2 with SMTP id
 956f58d0204a3-63ce3eb25d3mr1755504d50.52.1760027805485; Thu, 09 Oct 2025
 09:36:45 -0700 (PDT)
MIME-Version: 1.0
References: <CC5A0011-CD14-40F9-8023-8BF5F989BCCF@gmail.com>
 <20251007151157.5a601c3e@fedora>
 <DFAE42FB-786F-45D3-9FC5-C72DEC5A4301@gmail.com>
 <CAFEAcA8LQi+nVztx7oz6yGaYgKvnECj_0Xom3NbxLAFK82hWTQ@mail.gmail.com>
 <9961189C-3A61-4767-B620-C1B7315495CA@gmail.com>
In-Reply-To: <9961189C-3A61-4767-B620-C1B7315495CA@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 9 Oct 2025 17:36:34 +0100
X-Gm-Features: AS18NWBWMXORa97Z_ZqOOS4TVdnIUCgwIy1rK-0WLB6wkXfqAlO8fskLRcDOrAg
Message-ID: <CAFEAcA_t3zFfSiVaY++N8Li=tLv3hOpewZG1vB_OyKY2cWuwXg@mail.gmail.com>
Subject: Re: [PATCH] hw/arm: add pvpanic mmio device for arm
To: Alexander Gryanko <xpahos@gmail.com>
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, qemu-trivial@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12c.google.com
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

On Thu, 9 Oct 2025 at 17:30, Alexander Gryanko <xpahos@gmail.com> wrote:
> I added '-machine dumpdtb=3Dqemu.dtb', then converted dtb to dts 'dtc -I =
dtb -O dts -o qemu.dts qemu.dtb', added
>
>         pvpanic@9060000 {
>                 reg =3D <0x0 0x09060000 0x0 0x2>;
>                 compatible =3D "qemu,pvpanic-mmio";
>         };
>
> Then I compiled qemu without optimisation and set a breakpoint in =E2=80=
=98pvpanic_mmio_initfn'. It was never called with '-machine dtb=3Dfile.dtb'=
. 'info qtree' also does not show the device. Perhaps I have configured som=
ething incorrectly?

QEMU's virt board does not read the DTB and create
devices accordingly. It creates devices and writes
a DTB that matches what it has done. Editing the
DTB but not QEMU won't cause the device to be created,
it will just tell the guest kernel that there's a device
which doesn't really exist.

thanks
-- PMM

