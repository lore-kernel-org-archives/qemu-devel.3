Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 311A0C3DA7F
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2024 11:41:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdTQF-0001BW-2R; Mon, 12 Aug 2024 07:41:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sdTQ5-0001Ah-JJ
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 07:41:01 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sdTQ3-0006ry-Ac
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 07:41:01 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5a10835487fso5711377a12.1
 for <qemu-devel@nongnu.org>; Mon, 12 Aug 2024 04:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723462857; x=1724067657; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C0Hh7S5Rj1ylVdTCO58+9YFL5dCJoyV+fOPg8Zn8Iqc=;
 b=m6S8I0C9FUi8JeFWdEGtfi6D10Ke+Tosajcbog6hBcIk79h0fpp5nnMtqJamwF/Kpw
 SQKCRUMjEUQOG4ymLb52fdc4mXEc9AfPBtET5p8RStv5p4nC4WzDyn8VtDUAHIpM0+fb
 QPwScQ5CilnsqRQcqkv667GJOxyoipsFOJM/orEO77BZ1TWnxsKkFdphny2hb1OEtUKm
 oTQnlJDHKPaFLb5rysTb13X0sIIisnGWOzLj0UAqFDbo1U6bLE0If+thvj3vgJr/41wE
 ZQqND5NpDaqKE7Q0PF8TYTH7eK/BBrjdMafPAwLlysGdxAo3K7zsub5XS5H0E6nXEAb2
 WlOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723462857; x=1724067657;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C0Hh7S5Rj1ylVdTCO58+9YFL5dCJoyV+fOPg8Zn8Iqc=;
 b=TU4s6JiV+xQW2imDRLa/JXLchxqbZkZgaXNzgDZJXWR4AESGkSZfgrSZMCBfWGfYN+
 kvx+oYdt4+Hh1HEgDNRi5diWvWAcxofcu+G8TiRPdlnClQoqPIoN7Nyar02iWd8+kf+n
 lVV3j9a8XdlIIipbvOc6Vps3hJTEwKuLPTm8soGvEa3HVehv+qlaKLzOh5lrRJBBqfUP
 UvGqaMuO6PKdh7nXrOuJ8Tr3ZCknmvLZ6w8sGqJkoko9lf/IkOnnn6j30ee0W08KutlV
 cvwHW73qLmqOdCLBNUfaG6kP5Lix4NO5eN4O20dUvYnrvRg5OEwf6V9EMQsN7TeM+9tD
 4T+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXmtx75/66Ap5pBadKQvW1pUme8zMAmfXUnG69JV99RMqcJbT3oRVyfuY8w2Dq7gPzLkRpD8PTZnUhm@nongnu.org
X-Gm-Message-State: AOJu0YxzEydXBygLmCGEfivAY+7brv1LWUgJSEhd5t21bxdqDejbpRyM
 B8+nChRYk4IyvYHCk+V/8zPBYjs11CfBnVPLmjIUQm/Q8vbo0noJLEP1ruz5DSiBNBvJ/qMjAM1
 c7C4xTm9XG45JHJNJZKm2/ix4SoBkIp1XTnOe5w==
X-Google-Smtp-Source: AGHT+IHztHChl6BI3B1NgHGzJNL6k+UXBMAXkMM8wpVKem5n7zGEC1TQFLfl5Q+gI8WdlBHXhaPeIiV4HBg0VYY1DV0=
X-Received: by 2002:a50:c945:0:b0:5bb:8e11:6bf with SMTP id
 4fb4d7f45d1cf-5bd0a69d465mr4798651a12.38.1723462856790; Mon, 12 Aug 2024
 04:40:56 -0700 (PDT)
MIME-Version: 1.0
References: <20240809180835.1243269-1-peter.maydell@linaro.org>
 <20240809180835.1243269-10-peter.maydell@linaro.org>
 <945e5e14-9a15-4dfc-856f-f3a7d401a5bc@linaro.org>
 <CAFEAcA9nnzwm-OSpiAWTOtf2On27B1Hi2Fr3h=5jSKRPdnnQDQ@mail.gmail.com>
 <875xs6atfb.fsf@draig.linaro.org>
In-Reply-To: <875xs6atfb.fsf@draig.linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 12 Aug 2024 12:40:45 +0100
Message-ID: <CAFEAcA_-aBuXDK9e4X0ULXWZtXOnxjRuowc67hDBKOZC6+Bu=w@mail.gmail.com>
Subject: Re: [PULL 09/11] target/arm: add support for PMUv3 64-bit PMCCNTR in
 AArch32 mode
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52c.google.com
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

On Mon, 12 Aug 2024 at 12:10, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> Peter Maydell <peter.maydell@linaro.org> writes:
>
> > On Sun, 11 Aug 2024 at 22:36, Richard Henderson
> > <richard.henderson@linaro.org> wrote:
> >>
> >> On 8/10/24 04:08, Peter Maydell wrote:
> >> > From: Alex Richardson <alexrichardson@google.com>
> >> > diff --git a/target/arm/helper.c b/target/arm/helper.c
> >> > index 8fb4b474e83..94900667c33 100644
> >> > --- a/target/arm/helper.c
> >> > +++ b/target/arm/helper.c
> >> > @@ -5952,6 +5952,12 @@ static const ARMCPRegInfo v8_cp_reginfo[] =3D=
 {
> >> >         .access =3D PL1_RW, .accessfn =3D access_trap_aa32s_el1,
> >> >         .writefn =3D sdcr_write,
> >> >         .fieldoffset =3D offsetoflow32(CPUARMState, cp15.mdcr_el3) }=
,
> >> > +    { .name =3D "PMCCNTR", .state =3D ARM_CP_STATE_AA32,
> >> > +      .type =3D ARM_CP_ALIAS | ARM_CP_IO | ARM_CP_64BIT,
> >> > +      .cp =3D 15, .crm =3D 9, .opc1 =3D 0,
> >> > +      .access =3D PL0_RW, .resetvalue =3D 0, .fgt =3D FGT_PMCCNTR_E=
L0,
> >> > +      .readfn =3D pmccntr_read, .writefn =3D pmccntr_write,
> >> > +      .accessfn =3D pmreg_access_ccntr },
> >> >   };
> >> >
> >> >   /* These are present only when EL1 supports AArch32 */
> >>
> >> This fails testing:
> >>
> >> https://gitlab.com/qemu-project/qemu/-/jobs/7551982466
> >>
> >> FAIL: duplicate register {'name': 'PMCCNTR', 'regnum': 96} vs {'name':=
 'PMCCNTR',
> >> 'regnum': 79}
> >> FAIL: counted all 219 registers in XML
> >> FAIL: PMCCNTR 96 =3D=3D 79 (xml)
> >
> > Hmm, not sure why that didn't get caught by my local testing
> > or by my gitlab run -- does it only get run on an aarch64 host?
>
> It will depend what your local GDB is like - a modern gdb-multiarch
> should be fine but we do test for a minimum version to be able to probe
> the supported architectures.

Mmm, I found that a local "make check-tcg" does catch this for me,
so I guess the answer is "the gdb on the non aarch64 host CI jobs
is too old and/or we missed the coverage, and I forgot to run
this in my local checkout".

Why doesn't "make check" run "check-tcg" as a sub-test ?
Having it be separate is asking for people to forget to
run it, I think.

-- PMM

