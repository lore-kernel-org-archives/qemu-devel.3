Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1808D106ACE4
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 19:38:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0lrf-0004E9-Ix; Thu, 12 Mar 2026 15:38:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu-daude@linaro.org>)
 id 1w0lre-0004E0-BC
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 15:38:34 -0400
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu-daude@linaro.org>)
 id 1w0lrc-0001AC-Pl
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 15:38:34 -0400
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7d75371d873so1695805a34.3
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 12:38:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773344311; cv=none;
 d=google.com; s=arc-20240605;
 b=A9rhgp6vxfSKvIqNPmclWEg1vdaXB9sQyOKlsRRk/7U5cdLPQZAMElqlL7HVG9rUnz
 GSwyFvWpRvoueCB3WstRdQkoFxkugaWyzri0fivUW5/nSAMCtP6kMrNwcdXl1xUDB+2X
 ii7UMNpnLyR93rVRgnvcS2wmmrgZO4Q0uHIK4fYdaUi3GDTJXpYu/i/5o81C78p6EB48
 eLD1eieYNlu9+jX2CakIaJmXEKjdUPw6MV1kgvLrOSVdGZyPswPueABIjPXT+lk10HW3
 RFDF3rtcxFMIgoilHSpv3hSH/t/4gT8/xqqqAd5x58h7RlSOE6MAphPSX+2ZBsw5AckS
 Q2xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=RkyJK2G+qyeFRx0aZtb9FPsN/N1pjCEIyEk831BjPBo=;
 fh=pape3/0syMcJQetntmmSiYOAfDFvMRDv5dKhfRdbkZ0=;
 b=ibj8IUqycV6BaRbf8Koc+fiID0Wg7UbdWXTu7nWGbA/hOR2uawvJ1ZC1BXzy5IsGdW
 C9vprUfIIhk6Emu5AaMa0VKHkS6e+d5OIuIXX73RMRMpZohCRiMGmt8QQ/TLpKaRaum+
 TiOhSo4CdXALoq0bVsf06oDCcH/SD4aKcAwCUR+b3kc2/XhEjg69+UsbXbRJmY1APrXb
 IkYwNhdUUoLdeLx99audEKuk4cekKj3lymd7av1/t1fw/H8s3vF3DP9x1lozXdTtY9/o
 xHA5DbdVQauH1wWNlD5hCQB6FbVD8gU0ZpLBgOXL+YDL4shSIDBGkZbIHH7V1BvM0qew
 zyEw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773344311; x=1773949111; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RkyJK2G+qyeFRx0aZtb9FPsN/N1pjCEIyEk831BjPBo=;
 b=EbPSiV/ABGTtgz8PWrjTIPogb9vmKuadFbSchS5smpjfqb5PDsEv6MpfBqHBjc0mkY
 zkYaYnItXLSclsNw4pZzuYZHQ3+B/mlRTmWc0eitgC0G6qPFAhjMZ/9IzjjvQ+myXP/G
 2notdieusOj4EZjcYwdXJZelKnDyVASLL3azeD5y7yM92odIzOcOrVmmUP3/OkZtYJMK
 ZgyJuL3WOyAU0J7RpWj4DuNgKY3wLjXr7+2c4DYzQdxXUxPqFfKolCu0wPAvm0bkWn/p
 uzGDgaIuT5WeYh+dG5purcQadieKyN1MjvHQzhTb2qpWRLTaWBBIGGgSMUgdQLCfFti2
 URYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773344311; x=1773949111;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RkyJK2G+qyeFRx0aZtb9FPsN/N1pjCEIyEk831BjPBo=;
 b=rmJS59TQ1VuKhYROIMVLkQLTPwm7V+MLck38r2Uck/UKL6mLCPjEii3xLUXxj7nAdR
 k4cEyzl0bocVlQwlKXDNZrP+U5eDVsfSIh9eGr3v4349YRWRoqpJB537EeeEbQVfY1uo
 x0FrAtipYACkoGEoE3z7m15Dg9+JYl2swZfaNzR2WUcu80bX/WifkfA3wUSPEaQoawUO
 mIes0hZcJQ58i8mtPKd4ORm1f1WA6DG2KRsgilpeWxZIAjApZuz0PPnysR+FUCQE6FB5
 z4aJC9hDil+dkP0O6aD7CpRS2pa82C911iaAkx+yA20R1CYXGcU+VX2nCbcPQUogP0Pj
 lFuw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVSUkmhFHt59pXG+lYJoNROW191r6BfZBYNzwZebXU8GIjQqUKDq9zXdKYKdYfhKJwRuwjtD1FfIg1f@nongnu.org
X-Gm-Message-State: AOJu0YyWCuoL+6k3STbF5GPBL9ZKiIxTsbqvcizTh48a3Fr7ZaY94YtD
 97+cGte158gWX29Hpy/pAl0edWLMgo846b/au7TydijtFz6nPgfcZ3tp0qmNA2CTVYDGwB/yMQv
 bIEm/5+q1Aop1DwxVvdKp19O0g5PLnqgbmPlWZALgyA==
X-Gm-Gg: ATEYQzxnYbI7l/Im4H+CPo1P9/hl6KZeNGvm2MNR+jcX+3TnIr1nZ4jA9i1zVg1WSTy
 SqlHn3zlsY+ZtF0vUQ4uxebgElGg+UReX25Tm3YyVqw2v57jl6F/ldJX++nHhGeZObinuJeoFLF
 6sZc3TwadglDuOD6iXIYiqa7zd35r2rsfs1h1SFu8pjm7YSNzgQgqp7tUQM2XGIbO8bAYYWTzbv
 PWjLp1Zg7tCmRwRUAjcb7mM91DoUAf3iHhsPcP4qAEf+cgWnDR0Pvr/9esqeq1A4xL0n2gNcBgs
 x8tPVSI=
X-Received: by 2002:a05:6820:211:b0:67b:b22c:f79e with SMTP id
 006d021491bc7-67bda991959mr466041eaf.2.1773344311178; Thu, 12 Mar 2026
 12:38:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260311-semihosting-cpu-tswap-v3-0-8e239575ec08@eonerc.rwth-aachen.de>
 <20260311-semihosting-cpu-tswap-v3-2-8e239575ec08@eonerc.rwth-aachen.de>
 <bde55593-a51d-421c-bfa5-4a0c774f4b61@linaro.org>
 <CAFEAcA_Qvo86Ek2W7xGQqGP94400c7wx-C0=zpBUF5NoM2jhfQ@mail.gmail.com>
 <80ad84b1-0c4d-45de-93d4-90a471f7f751@linaro.org>
In-Reply-To: <80ad84b1-0c4d-45de-93d4-90a471f7f751@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Date: Thu, 12 Mar 2026 20:38:19 +0100
X-Gm-Features: AaiRm51MtYZGAS15SUcTZ2zzh6HF2_t8sq-6Z8yp91kbcuFPYmrZ97dWQuAbCsI
Message-ID: <CAPMQPEJVPfaPdcrWKBBMPJZ1-Y76VdvBLE2py4zX2Jn9-VsoDA@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] include/exec: Provide the cpu_internal_tswap()
 functions
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?Q?Martin_Kr=C3=B6ning?= <martin.kroening@eonerc.rwth-aachen.de>, 
 qemu-devel@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::32e;
 envelope-from=philippe.mathieu-daude@linaro.org; helo=mail-ot1-x32e.google.com
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

On Thu, 12 Mar 2026 at 20:37, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> On 12/3/26 20:30, Peter Maydell wrote:
> > On Thu, 12 Mar 2026 at 19:29, Philippe Mathieu-Daud=C3=A9 <philmd@linar=
o.org> wrote:
> >>
> >> On 11/3/26 17:27, Martin Kr=C3=B6ning wrote:
> >>> These functions are needed to support semihosting on CPUs that suppor=
t
> >>> runtime-configurable endianness. They should not be used in other con=
texts.
> >>
> >> Another note is these function are not target-specific, which is great=
!
> >>
> >> These can also be used outside of semihosting.
> >>
> >> Matter of taste I'd have named them using this shorter pattern:
> >>
> >> cpu_internal_tswap16() -> tswap16_cpu()
> >
> > We specifically didn't want to use a name that might tempt
> > people to use them -- these are only wanted for the very
> > few niche use cases that are outside the CPU but need to
> > know information about the CPU's internals, which is basically
> > legacy-virtio and semihosting.
>
> This was the missing piece to make qtest target-agnostic:
>
> -- >8 --
> diff --git a/system/qtest.c b/system/qtest.c
> index cf90cd53adb..392c1394656 100644
> --- a/system/qtest.c
> +++ b/system/qtest.c
> @@ -523,18 +523,15 @@ static void qtest_process_command(CharFrontend
> *chr, gchar **words)
>               address_space_write(first_cpu->as, addr,
> MEMTXATTRS_UNSPECIFIED,
>                                   &data, 1);
>           } else if (words[0][5] =3D=3D 'w') {
> -            uint16_t data =3D value;
> -            tswap16s(&data);
> +            uint16_t data =3D cpu_internal_tswap16(first_cpu, value);
>               address_space_write(first_cpu->as, addr,
> MEMTXATTRS_UNSPECIFIED,
>                                   &data, 2);
>           } else if (words[0][5] =3D=3D 'l') {
> -            uint32_t data =3D value;
> -            tswap32s(&data);
> +            uint32_t data =3D cpu_internal_tswap32(first_cpu, value);
>               address_space_write(first_cpu->as, addr,
> MEMTXATTRS_UNSPECIFIED,
>                                   &data, 4);
>           } else if (words[0][5] =3D=3D 'q') {
> -            uint64_t data =3D value;
> -            tswap64s(&data);
> +            uint64_t data =3D cpu_internal_tswap64(first_cpu, value);
>               address_space_write(first_cpu->as, addr,
> MEMTXATTRS_UNSPECIFIED,
>                                   &data, 8);
>           }
> ---
>
> QTest is already dubious by always accessing the first CPU AS, so
> using the first CPU endianness is good enough for me IMO. (Ideally
> QTest would support multiple address-spaces).

And these endianness checks in QTest framework are only there to test
legacy virtio, so we are good, this isn't even another niche use case.

