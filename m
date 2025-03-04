Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72DA8C021B8
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 14:37:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpTOH-0006Tp-3x; Tue, 04 Mar 2025 09:37:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tpTOC-0006SI-3i
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 09:36:56 -0500
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tpTOA-0001P9-Fa
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 09:36:55 -0500
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-6fd9d9ae47cso3115307b3.3
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 06:36:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741099013; x=1741703813; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7cWQYOWnqy4Gwrd8HosQID6tt4wRQqdObtZVgA0+p2U=;
 b=Sx/Pb3RHLcEQoZvVeg+7Cu87BIskyJFCdktk3+HDh6GBjwTE8dFFqWWZF7zPdsbtcO
 sy9uq1qiHxnR5ocLvk316gDDtddSP7KDVUwelhZz5AKNqULYeRUren9WnAkt81fYC1NN
 MvRM/bm8WZFIOax6TDqzlPlopybrCV9qTxtDKTqCaL1sbUiKbO6Rp/noN+80W1O8rGOW
 ea4ebjJZVNWCZo726gXI8XOBMPq8DoGhwCEbHfwtVRkVOMqsO0+yo02zecxxo1RbudQP
 WshdWjZ5mjbQf7kROSnpLTgQQk7MNdREvjXX0WMs71462Iiieh+s29Ss7WzhgV2O9JOy
 Bj1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741099013; x=1741703813;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7cWQYOWnqy4Gwrd8HosQID6tt4wRQqdObtZVgA0+p2U=;
 b=S5suA8w95MTg7ne8cioW6OsrFqkPx8zSeHN7Ni7LpvRInRo2DEkNqqigRseC3i5cQw
 Z3H9+53508JV8f1AcgVyq/EjSTzMobhlroPH3hAXXgl0ixoOt8Lx8RanRjQwRLJzQ8WF
 r32M+h0dmFLlSez9guBq8uOf2yc+2/6K3wpYg5QlBtk/SFIRmVXtC/IBFhYKaVcGdZSP
 65XraqBlIWB+/v1VAc3WSypnemxxzRIz1oXlPRHXfeYKnM4HUMERqMRUbmh9DaGlK4Xe
 rWgZN867E0J3mPbNhr9oqC52H4jKpoCyxe+xGzx+h6BSrenm9RakEFehaL+ABO8Gsdv/
 wIdg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUAMmJ9sz0L4A33tK9CQI/cmovi7pScWzuZtfxP0CXl3KVH9bEariYcJQgzoPqPtnF+oY0HeptmfAuM@nongnu.org
X-Gm-Message-State: AOJu0YzxvJmTdai286zzlt95pem/z/oQFzjPy/5AriHdclY66v+Fe4/c
 SQPv6mtQnc5ObjvoREz5VZZ/UbK+EBoXeUO/S/Q83GkRPnieLuVpoQLX6oevSt04VV0tBceEDF2
 AV6AspatxAGT5r2YC+QpDcGdKLfxEGSwXe77+1g==
X-Gm-Gg: ASbGncvS+lOeluOUGFrMTWDnPU+qOuA54unSKK/v8dk2zI3ZS3FyfUgSrWh97XaFDls
 7QJWK9iHp6GsnKcfujn5cipXAgnQXWPjixE31T2dKtVK9FF7oQzuk49KFT8m9VCj2eyB7l3mh4K
 XgxPtX9KP+ZlX1nkrElXqg1wfI0Lc=
X-Google-Smtp-Source: AGHT+IG8VxfFSCtC43Hxz6L23TAjI/RL/tr7NkMy99QU5VfxAdDkR/3wU5XbGt7r5/5I+/4PUdmQQosGmLqa++M7iHs=
X-Received: by 2002:a05:690c:60c8:b0:6fd:346f:97ba with SMTP id
 00721157ae682-6fd49fcd7a6mr243540617b3.11.1741099013445; Tue, 04 Mar 2025
 06:36:53 -0800 (PST)
MIME-Version: 1.0
References: <20250227141343.1675415-1-peter.maydell@linaro.org>
 <87o6yh57r2.fsf@draig.linaro.org>
 <CAFEAcA9VDtWKoQ09dOt+ZxJ2MhdRTFY_X1ON58pEjYTM_NtZ-A@mail.gmail.com>
 <87ikoo6hbm.fsf@draig.linaro.org>
 <CAFEAcA9mFHo=U=F+7on-9m+VWh_b2rQXtEJovU3fuj3MZxHTyw@mail.gmail.com>
 <877c546f9r.fsf@draig.linaro.org>
In-Reply-To: <877c546f9r.fsf@draig.linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 4 Mar 2025 14:36:42 +0000
X-Gm-Features: AQ5f1JoNbuN3lcdrdqRIq1AtATgoYPUDWNAElwAT0MFUW3IDAIgmulaae5o0vSg
Message-ID: <CAFEAcA_nbax7qq7Lxc-Qo8xTaxxTn9dJ5VQYuQTy+Qp1_2mNXg@mail.gmail.com>
Subject: Re: [PATCH] tests/tcg: Suppress compiler false-positive warning on
 sha1.c
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Brian Cain <brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112e.google.com
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

On Tue, 4 Mar 2025 at 14:29, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
>
> Peter Maydell <peter.maydell@linaro.org> writes:
>
> > On Tue, 4 Mar 2025 at 13:44, Alex Benn=C3=A9e <alex.bennee@linaro.org> =
wrote:
> >>
> >> Peter Maydell <peter.maydell@linaro.org> writes:
> >> > I think it's new-ish (gcc 11?). On the other hand
> >> > -Wno-unknown-warning-option is quite old, and would suppress
> >> > this error. If we do
> >> >  CFLAGS+=3D-Wno-unknown-warning-option -Wno-stringop-overread
> >> >
> >> > does that work?
> >>
> >> Yes, I did:
> >>
> >> modified   tests/tcg/hexagon/Makefile.target
> >> @@ -18,7 +18,7 @@
> >>  # Hexagon doesn't support gdb, so skip the EXTRA_RUNS
> >>  EXTRA_RUNS =3D
> >>
> >> -CFLAGS +=3D -Wno-incompatible-pointer-types -Wno-undefined-internal
> >> +CFLAGS +=3D -Wno-incompatible-pointer-types -Wno-undefined-internal -=
Wno-unknown-warning-option
> >>  CFLAGS +=3D -fno-unroll-loops -fno-stack-protector
> >
> > I think we should do this where we add -Wno-stringop-overread,
> > not just for the hexagon tests -- or are the tcg tests
> > guaranteed to be run with a fixed compiler from a container
> > regardless of the local dev environment?
>
> I can move it, but hexagon is unusual in being clang based. However the
> oldest compilers we use are 10.2 in the qemu/debian-legacy-test-cross
> container.

My question was more "do we only ever build this test with
a fixed set of compilers that we control, or are we instead
maybe sometimes using the user's clang/cc/gcc" ?
If the latter, we definitely need to associate the
"don't warn about unknown warnings" with the place we are
adding the option that's not known across all our supported
compilers. If the former, then putting it in the hexagon
specific file seems OK I guess.

-- PMM

