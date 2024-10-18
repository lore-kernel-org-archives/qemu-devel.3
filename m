Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DBABD2FFE0
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 09:48:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1jaj-0006qO-GR; Fri, 18 Oct 2024 05:48:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t1jai-0006pW-0l
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 05:48:16 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t1jag-0002K3-8M
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 05:48:15 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5c948c41edeso2161675a12.1
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2024 02:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729244893; x=1729849693; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Soh6jH0z+eTQKtZFMIbLZG9/1ikoWd+mxwUaxhi1Ds4=;
 b=D6E+9/BwVTNm/5sazC0ic1BNowbxMZkwKdALp2Edr4SAOqhpN5U83s/2DzfJ6cD9d2
 oKI/ENnE6iEDPLEJ2AUAXH6zXFd5jjsRMeODUt6g75IaINEDPeno/KwR4XSPbIIRgLrP
 eoDatA3sBtR0klEyVHYkYAYcU8J5UrPTZdQRRsJvI9bstmnBGojyrvnq2Hv0oPYW23J+
 bXpJn4R9mQXAGo3FZZ3sCM2PrVHfwQGowxTKfGQILie1cShxklVelA6sg8ouc2DK1hK7
 dCONSFMnys73k74DxWjSQe93SJvRbLEebd6ys9X7W9GeEMBtd7dVkFWK/0WpoyB9pfQq
 HeaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729244893; x=1729849693;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Soh6jH0z+eTQKtZFMIbLZG9/1ikoWd+mxwUaxhi1Ds4=;
 b=dbBKNx4m6685Cl54Sf04ZBR72f8DpfCDdWseGPUY9qzMw0QKVrD4M91jrG0SD03XtJ
 0iWm1OdI3BM3sC+5GL75qiYNM9kQLtCaGIc4oXv3u9JZQI6Anz+2Sb8qYHPndQ0dtHi2
 j1Un/dj8/H/tWfrzoGp+S/fGeH6N0BO+MT8dBP25cPx5z05BPlLfOjNLXhRevb1JbXCs
 w/aP399uoGvxuOffd3A/AfiZ9UlGr7hOsb+Aeb6kGPB9LxJ1PYu6SSi0ShcR96yQVQo6
 0QCVZBO8BI/w5c9KXr/BeiEW8MwFoNSlHi0nDih2L0GSSXiPlv45s5NnGy+YO+J7nPpi
 k6+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXqViihbfrGpJFWIH/PHXPucjOYBQFYbaTquu4974qjzoDLqbm7GVNfpyoEKQB6oi6GA7Tq2Mq/3B1j@nongnu.org
X-Gm-Message-State: AOJu0YxaZfcGGegCWp3M+7L91h41BsqM3me+TS4Myjvu1PiE5X9dn4fr
 TzxWRHtLpR/cuZ2ISCA+AQhdhebKwVTUpCBrRrbYKL1mxrz5vHqUwcEhgiV/1lgdGy5T+/vPw7n
 xP2r7MS7DPRcfwRfW0wRUd+Y8Wu6UhHNnlEWvcg==
X-Google-Smtp-Source: AGHT+IGwkBnt8S54HV5wpTluVRczh/eHb/pg8v+8S1HtQBQwTQ9hgVMWZh3zivyvuxuChXefK071wuCB0YFmrafJ2jY=
X-Received: by 2002:a05:6402:40d4:b0:5c9:3389:bdc3 with SMTP id
 4fb4d7f45d1cf-5ca0abe8729mr1177178a12.0.1729244892751; Fri, 18 Oct 2024
 02:48:12 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYvx05D7TfRjvdPtKM9iWS6i7b-EHuBAbHEQghvMEg221g@mail.gmail.com>
 <871q0daglh.fsf@draig.linaro.org>
In-Reply-To: <871q0daglh.fsf@draig.linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 18 Oct 2024 10:48:02 +0100
Message-ID: <CAFEAcA-39GRpvy5LOZSJL3=9FMspAq9c8GUtHv9CP4jU2uFi1w@mail.gmail.com>
Subject: Re: Qemu v9.0.2: Boot failed qemu-arm64 with Linux next-20241017 tag
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>,
 open list <linux-kernel@vger.kernel.org>, 
 Linux ARM <linux-arm-kernel@lists.infradead.org>, qemu-devel@nongnu.org, 
 lkft-triage@lists.linaro.org, Linux Regressions <regressions@lists.linux.dev>, 
 Catalin Marinas <catalin.marinas@arm.com>, Mark Brown <broonie@kernel.org>, 
 Anders Roxell <anders.roxell@linaro.org>, Arnd Bergmann <arnd@arndb.de>, 
 Dan Carpenter <dan.carpenter@linaro.org>, Aishwarya TCV <aishwarya.tcv@arm.com>,
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
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

On Fri, 18 Oct 2024 at 10:46, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> Naresh Kamboju <naresh.kamboju@linaro.org> writes:
>
> > The QEMU-arm64 boot has failed with the Linux next-20241017 tag.
> > The boot log is incomplete, and no kernel crash was detected.
> > However, the system did not proceed far enough to reach the login promp=
t.
> >
> > Please find the incomplete boot log links below for your reference.
> > The Qemu version is 9.0.2.
> > The arm64 devices boot pass.
>
> Can confirm it also fails on the current master of QEMU:
>
>   #0  __pthread_kill_implementation (threadid=3D<optimized out>, signo=3D=
signo@entry=3D6, no_tid=3Dno_tid@entry=3D0) at ./nptl/pthread_kill.c:44
>   #1  0x00007ffff4a3ae9f in __pthread_kill_internal (signo=3D6, threadid=
=3D<optimized out>) at ./nptl/pthread_kill.c:78
>   #2  0x00007ffff49ebfb2 in __GI_raise (sig=3Dsig@entry=3D6) at ../sysdep=
s/posix/raise.c:26
>   #3  0x00007ffff49d6472 in __GI_abort () at ./stdlib/abort.c:79
>   #4  0x00007ffff6e47ec8 in  () at /lib/x86_64-linux-gnu/libglib-2.0.so.0
>   #5  0x00007ffff6ea7e1a in g_assertion_message_expr () at /lib/x86_64-li=
nux-gnu/libglib-2.0.so.0
>   #6  0x0000555555f45732 in regime_is_user (env=3D0x555557f805f0, mmu_idx=
=3DARMMMUIdx_E10_0) at ../../target/arm/internals.h:978
>   #7  0x0000555555f5b0f1 in aa64_va_parameters (env=3D0x555557f805f0, va=
=3D18446744073709551615, mmu_idx=3DARMMMUIdx_E10_0, data=3Dtrue, el1_is_aa3=
2=3Dfalse)
>       at ../../target/arm/helper.c:12048
>   #8  0x0000555555f4e3e5 in tlbi_aa64_get_range (env=3D0x555557f805f0, mm=
uidx=3DARMMMUIdx_E10_0, value=3D107271103184929) at ../../target/arm/helper=
.c:5214

I investigated this yesterday when Catalin reported it
and sent a patch:
https://patchew.org/QEMU/20241017172331.822587-1-peter.maydell@linaro.org/

thanks
-- PMM

