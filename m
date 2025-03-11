Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61BA7C28B2E
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 07:29:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tru3D-0004F2-PT; Tue, 11 Mar 2025 03:29:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rehn@rivosinc.com>) id 1tru3B-0004DE-Pa
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 03:29:17 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rehn@rivosinc.com>) id 1tru36-0007wk-LE
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 03:29:15 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2ff187f027fso8579698a91.1
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 00:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1741678147; x=1742282947;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zmr5Xnccv7/vYZgF8XA6ePFFrj/sFxqgRNZ4jJ5SBDo=;
 b=0aptRan8FR1+Eu1nMJIS8qZcFBuA3ZEbIfMaTX13vQMbKZM5MYTipq+qJib66jUBH9
 as6uIqFG1OwZk8S/MAztl+sRayZiAmvwr7/e1pEm9rPc8g2V9T8dh0Bb+3lMEcVgGYnH
 1KJcrkCb2WmjjKX7/MmWU2mpV6iwhpud4/sm1QyPNb7LxGysWjlhrlmDiaQHCsFCsf+I
 txum7U5QiGQxLWDXpYakgDVDV+6QpWVlToUGqPdAKKxBY4OfNONbeCnuMBcmmOxk5OIl
 uu9BkzcWySC++s73plWTtwrVIZiRzpwNtYyxXBpeNf+KWSrspjMDpygPGpt1FLdWv0Mn
 GWpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741678147; x=1742282947;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zmr5Xnccv7/vYZgF8XA6ePFFrj/sFxqgRNZ4jJ5SBDo=;
 b=W5mfri8HwGTNRAULEcpUUpjYvXQU9pXFk4ckohIYRggbHfrgbN5a0z6eAJQcI0eQxZ
 wCovu3iLeUaBNf2ehoh+MJ6zx+Ce5yHIcJEiP7TbuNI02+Igp/Rs4H5WyTbd1iidXvdH
 wpg7zpJAwmgeFEaaqrmoLJuVzhEFNk2791vIwKMmWl+AW7XT6y3T4cHUauTiP/SXEh5w
 /bvWcKtOvvhwLGRFAXChFgj//6US5iRlxrRBoxF1UcvuSGhkwH/6gy3teygoXrJbyW+2
 4UH2IBMw0JSsOhfravfKEj4H9sEqnPxy4gcLPBzO7PhlB0L1Pw0oG5qa6Y0ohuGlq7Nm
 hLEQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV6VXmRCFlS3zb6LXOmU1GLbojzNvpAmiSjS/YsaU0BFtmuFexg6fxZK5KS7H5Wb0h3fSbQ6dtUi9uX@nongnu.org
X-Gm-Message-State: AOJu0YwsU94eBhWyUYtSlJhu8N5cs3x62QECUdurLWs4sYYJYoy+V55Q
 gsc9Vhhk0F3Bsc1iaYGi5xRWbWed6d40BioUfYL8mXEKdWk/ivFZq1qXcL7Uz9S9XQNrUctkZN9
 TfUSZbrwoZIJFFYDDrzSuysCbmeaVvkLGtbGhyQ==
X-Gm-Gg: ASbGncuBQzUbXcwLU1cHkSv6UWlzbrq0RNfs3f6K01PY33lg5AbGkULOJZH5eICSyob
 JwUGL+lKTXJW6ukSEkkUyQxCEEAWK7B1PeBwtvQAGMgWld0bYAeDnrON+Lx1L4J6A0yg1odBJLk
 CFCETmrv0f0Cd+fZottl02h34rKRaWM+t6jQXhn+xNv7RS9YKsfBZdBI2tAf0=
X-Google-Smtp-Source: AGHT+IG92Qbs5+w2eMpTeeg+KXd/FMtRSPVWAXe9mXRpBAKBDkKe5BtoTswp73cHKv5ZRoKMJvNF8Ca1ozEsZCLuifI=
X-Received: by 2002:a17:90b:528a:b0:2ee:5c9b:35c0 with SMTP id
 98e67ed59e1d1-30100544832mr2965357a91.9.1741678146825; Tue, 11 Mar 2025
 00:29:06 -0700 (PDT)
MIME-Version: 1.0
References: <mvmo6yglouz.fsf@suse.de>
 <CAKmqyKOdZn__jJH4Pzsqm5Rv2my1Kq3Gn8fefRb4+wKLko=pWA@mail.gmail.com>
In-Reply-To: <CAKmqyKOdZn__jJH4Pzsqm5Rv2my1Kq3Gn8fefRb4+wKLko=pWA@mail.gmail.com>
From: Robbin Ehn <rehn@rivosinc.com>
Date: Tue, 11 Mar 2025 08:28:55 +0100
X-Gm-Features: AQ5f1JpfI0rb5d0KvNHJ35ZfuOuL9oqx-m4LGSIKkt6Lfc0omIHulzDuy_wLc4o
Message-ID: <CAEEvPLDcmKkLRXfbS3zwwu7CobQRXEQ=N_98=ka2u2X=c9M-1Q@mail.gmail.com>
Subject: Re: [PATCH] linux-user: fix handling of cpu mask in riscv_hwprobe
 syscall
To: Alistair Francis <alistair23@gmail.com>
Cc: Andreas Schwab <schwab@suse.de>, Laurent Vivier <laurent@vivier.eu>, 
 Palmer Dabbelt <palmer@rivosinc.com>,
 Alistair Francis <alistair.francis@wdc.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=rehn@rivosinc.com; helo=mail-pj1-x102b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Tue, Mar 11, 2025 at 12:10=E2=80=AFAM Alistair Francis <alistair23@gmail=
.com> wrote:
>
> On Wed, Mar 5, 2025 at 2:54=E2=80=AFAM Andreas Schwab <schwab@suse.de> wr=
ote:
> >
> > The third argument of the riscv_hwprobe syscall contains the size of th=
e
> > cpu mask in bytes, not bits.
> >
> > Signed-off-by: Andreas Schwab <schwab@suse.de>
>
> Richard sent a v2 that I have applied:
>
> https://patchew.org/QEMU/20250308225902.1208237-3-richard.henderson@linar=
o.org/

Hey, thanks for fixing!

Acked-by: Robbin Ehn <rehn@rivosinc.com>

>
> Alistair
>
> > ---
> >  linux-user/syscall.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> > index a22a5df8cc..4cc1a31d0d 100644
> > --- a/linux-user/syscall.c
> > +++ b/linux-user/syscall.c
> > @@ -9120,16 +9120,16 @@ static void risc_hwprobe_fill_pairs(CPURISCVSta=
te *env,
> >
> >  static int cpu_set_valid(abi_long arg3, abi_long arg4)
> >  {
> > -    int ret, i, tmp;
> > +    int ret, i;
> >      size_t host_mask_size, target_mask_size;
> >      unsigned long *host_mask;
> >
> >      /*
> >       * cpu_set_t represent CPU masks as bit masks of type unsigned lon=
g *.
> > -     * arg3 contains the cpu count.
> > +     * arg3 contains the size of the cpu mask.
> >       */
> > -    tmp =3D (8 * sizeof(abi_ulong));
> > -    target_mask_size =3D ((arg3 + tmp - 1) / tmp) * sizeof(abi_ulong);
> > +    target_mask_size =3D (arg3 + (sizeof(abi_ulong) - 1)) &
> > +                       ~(sizeof(abi_ulong) - 1);
> >      host_mask_size =3D (target_mask_size + (sizeof(*host_mask) - 1)) &
> >                       ~(sizeof(*host_mask) - 1);
> >
> > --
> > 2.48.1
> >
> >
> > --
> > Andreas Schwab, SUSE Labs, schwab@suse.de
> > GPG Key fingerprint =3D 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B=
9D7
> > "And now for something completely different."
> >

