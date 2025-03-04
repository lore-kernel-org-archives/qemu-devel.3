Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 992A6C282C6
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 13:54:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpSiR-0008Sp-Hc; Tue, 04 Mar 2025 08:53:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tpSiN-0008S6-Ny
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 08:53:43 -0500
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tpSiM-0002mS-5x
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 08:53:43 -0500
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-6fd64eea9c1so26728607b3.2
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 05:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741096421; x=1741701221; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B5Bua8Sv8DmaOHigQ+O29Nri5KVliZGRJklBQwiDsTI=;
 b=xwH51ZyNRiZX2lPfNl02hLr7ybE50iHE6EppYdBh2fi/Bp9Su7ep7vsaKx1boH66Tj
 oaqywiNo5dx10ABRQDfmCjjeXJN6HRCGYYyrn9BX2YNYRxpH9mTAxNwy41FH8Btt8jAH
 5z8L3HMW0y6K32jQGDv4gaT4D4EF5If/Brx8gHGe7uIBXlsHIWIVDMR4Wgo1kNtuTdBO
 8XCW3PGeF4y4ZJKpcbXl6kAmbwwLvwbo4nv1zBJl1sLiYIljUVKdjp6hJ+y+Mkza2AQ8
 tici4wF9tHrZ+aG/TsXuto3V/pB1J02vHWIm09NqzPgDyBA8rih5qZJUGknHuPePyZWk
 k5JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741096421; x=1741701221;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B5Bua8Sv8DmaOHigQ+O29Nri5KVliZGRJklBQwiDsTI=;
 b=ojm3386iPu63n2K8NCvGU+vbEZBZ0z5ro1WnL+tZPq/GR7/ewzp/MJkcyoc+EpdMTW
 GhXlhVzECLsVLk3He6BcFpfQ+I3MoyOia3kQ6PWq79ZMVbv7j2N6D/uKWt6VIoKJiwEO
 3csmjXpnU4pNeO5dV7ADX2XtLx8XbjYtZ8vNoKgvBZiGVo6qKj6Y465ivGWcplhNGLce
 i1wFzztMYCJoNFHrU0aHC6HnxKEBuskv2P0I++dWax/ZV8aad9CMVn3TE4IfDQ6Z5Sb/
 7VcQCg+T0K0rnL5X4gHgUtiPWF1YlW5bvVSXPfdBvfk0oj3PTKWtwowTrfBKbE8Q6kAz
 rdJA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUqoj6LU2wEAj+KyPeZ0yMpleroqVYQPsfwvqfiRi9Qus0HZXFJVHu+XRQP19WA8NiqyqPrz4FMpmLN@nongnu.org
X-Gm-Message-State: AOJu0YyB8wX3DJBn8iTFl1cvXV/MZ87FUQkwAF2TzsgcNUyEEPh5UEWa
 VsS/8xqgBmn2oEZwiKwx6B+VUJ9TMTll3jMjREtKncbq2TN1U8tKRxkYsXY+gCRWEX6FLQntcgh
 XF7K+YJVfrRKVyj+BcfjAUet0+R/5ERTwN4lmvw==
X-Gm-Gg: ASbGnctxXBPh4aM+zUG6mWz9CAB7k2KCQDvzOSx7O+kId3DCXc8js5XuKVA5wgug9Y8
 E2AnYEkApFLs8ZDKt5n/5TXMQw1iT5iAjBCYV1OjSv0jtL6sKMCUF86st5YFrugJliUzzFYmJRL
 a51kODuCFcTQTkI8F4DM1dl/DKxVs=
X-Google-Smtp-Source: AGHT+IFPt4oMxoGtAFg2NbT2/mX+2dkabA5s11S/572DjqtK/l5qXv12HppkAOhlmBs/T2rLOjIywFBAftADXutUp1M=
X-Received: by 2002:a05:690c:4801:b0:6fb:9b8c:4b4f with SMTP id
 00721157ae682-6fd4a1516aemr235229897b3.31.1741096420787; Tue, 04 Mar 2025
 05:53:40 -0800 (PST)
MIME-Version: 1.0
References: <20250227141343.1675415-1-peter.maydell@linaro.org>
 <87o6yh57r2.fsf@draig.linaro.org>
 <CAFEAcA9VDtWKoQ09dOt+ZxJ2MhdRTFY_X1ON58pEjYTM_NtZ-A@mail.gmail.com>
 <87ikoo6hbm.fsf@draig.linaro.org>
In-Reply-To: <87ikoo6hbm.fsf@draig.linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 4 Mar 2025 13:53:28 +0000
X-Gm-Features: AQ5f1Joo0UoM_orNX6t55Axb3MpVw2jcjqvIZ3Ahf6Lifwi1gUS_Cg3vh7193OE
Message-ID: <CAFEAcA9mFHo=U=F+7on-9m+VWh_b2rQXtEJovU3fuj3MZxHTyw@mail.gmail.com>
Subject: Re: [PATCH] tests/tcg: Suppress compiler false-positive warning on
 sha1.c
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Brian Cain <brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112d.google.com
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

On Tue, 4 Mar 2025 at 13:44, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
>
> Peter Maydell <peter.maydell@linaro.org> writes:
> > I think it's new-ish (gcc 11?). On the other hand
> > -Wno-unknown-warning-option is quite old, and would suppress
> > this error. If we do
> >  CFLAGS+=3D-Wno-unknown-warning-option -Wno-stringop-overread
> >
> > does that work?
>
> Yes, I did:
>
> modified   tests/tcg/hexagon/Makefile.target
> @@ -18,7 +18,7 @@
>  # Hexagon doesn't support gdb, so skip the EXTRA_RUNS
>  EXTRA_RUNS =3D
>
> -CFLAGS +=3D -Wno-incompatible-pointer-types -Wno-undefined-internal
> +CFLAGS +=3D -Wno-incompatible-pointer-types -Wno-undefined-internal -Wno=
-unknown-warning-option
>  CFLAGS +=3D -fno-unroll-loops -fno-stack-protector

I think we should do this where we add -Wno-stringop-overread,
not just for the hexagon tests -- or are the tcg tests
guaranteed to be run with a fixed compiler from a container
regardless of the local dev environment?

-- PMm

