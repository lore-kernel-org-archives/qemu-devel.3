Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00D95C5B543
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 11:37:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOxHz-0003Rh-L8; Tue, 10 Jun 2025 07:37:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uOxHy-0003QD-2A; Tue, 10 Jun 2025 07:37:10 -0400
Received: from mail-vk1-xa35.google.com ([2607:f8b0:4864:20::a35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uOxHq-0000nB-BI; Tue, 10 Jun 2025 07:37:09 -0400
Received: by mail-vk1-xa35.google.com with SMTP id
 71dfb90a1353d-528ce9730cfso1638139e0c.3; 
 Tue, 10 Jun 2025 04:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749555420; x=1750160220; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BhQilxE3hibV+3HwBYnI18lXusrw5bAFAxoMF9ajj0M=;
 b=duPkq0W0FRvAa8biMOrVxQoKFxydwyQXdb3dpsgwrkOHlxxbZipchAexcLifBOnUNm
 JptiWmXe0wA9EIX2YYliy96iAF6lpBIiqZlfIFY0yOKD8qwrB/bnZ8XSkXTh2Kmkjq6W
 zskV6STE+ZVedGSRT79nRj/IlPqLENK9FEetVuIVSYnVO1z4aQzqIO+MTncPidLrIQbI
 LuzcB1sSTlw+/NAWNx2Dq4+wIKBya//Fzc1aoCgaYX16iFrdsc75Od1yryBVoSJ6KuVL
 dBG4LEPmtoi8gbTE6jX/oR7/DavFC30A1ccUNGzgkUKOo+Wrk3gsF6KgiI6BwNc6Otpn
 GDwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749555420; x=1750160220;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BhQilxE3hibV+3HwBYnI18lXusrw5bAFAxoMF9ajj0M=;
 b=kz94NLVkyA15OQU/WMQQh8OtZoouQvQRiWuW0d+yrhJoOSvDyXI7oTIGNknC0PpLYZ
 Ccjay28Wk+s+f1QA36XwrV6XZ6p3StgGho8OcPeK/CuS8fORRXFI//+vX4KHk8Ppqqfo
 7N7MGvTmt1t8wZyypHI9lda0WzIqrIzPyMHJai4uxmRLhI5HJ7MlHWQnOUYFvYJbtP7F
 VQ7AvgDeGvzK8ZWwkEXDOg0/bfS8K0PCTw1VXvvsSiwb9k680tsCUGsiM72+cxkHUwqV
 U5ae/ZeTrz3APqnzIHxd5JVbqJ+m2msON7Q/9p/0ihHY+hP5YjXGj6FlDmIaZN/6NCnK
 zyCw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWXlb1i/aHMqd+i4fCk86xEma/eXzknZUfwG6aYquHYBcvcqN1+QfFvX8dY6xX5ElO4U/hupKZkEvDg@nongnu.org,
 AJvYcCX/0b2/qI4b0PU91OQKjV3l0ADhSTzcEAJyuD9uPJRR+DZ0FNGhBVD0qnrpZotddLQrLUVYghsNxLltAQ==@nongnu.org
X-Gm-Message-State: AOJu0YxaAdvUQvZsppkrQC9lmDVJCl5gQjHfZ7iVEduiqEocOkwRG4WQ
 WLcCBjU2hJfE5RWTPxvllYOVHiQS4L3I4SaKlh/C7J7Kh3M+SF6+Q83Q+2oKS8amInNW5T4muQp
 McE7xVrbgL5APTm4FnPisNX3VQKjuGaN/Gdch
X-Gm-Gg: ASbGncuKj1KUH6+vsapB4G4ig/sHEiXzMR/GTpm2GhpdaSr9Jei4HfKVLvZGYdF5J9t
 11+HNQ1ONHUu9BZ9XfJsuQCDQGUSK2iajOgowLIMA0V6yboDpPw0gvDaYnLjfAmrj4lc5V3IPCw
 //SvDROX4HPJw2SWMnZUVxSgcXjC7YcVi0JJ7b0YnQjgNNunk6dRx9qx20YUvqlSzy/WG44myVt
 A==
X-Google-Smtp-Source: AGHT+IHMkutu5eT/E1981GiIb4lRgOKDfyKao0BaOBcd0w6lv4JlxwDkgOSTal33ErAe0gR7TVCRAOn32AxiYeM5CfY=
X-Received: by 2002:a05:6122:641b:10b0:531:19ee:93ea with SMTP id
 71dfb90a1353d-53119ef494bmr344471e0c.0.1749555420073; Tue, 10 Jun 2025
 04:37:00 -0700 (PDT)
MIME-Version: 1.0
References: <20250602131226.1137281-1-djordje.todorovic@htecgroup.com>
 <20250602131226.1137281-5-djordje.todorovic@htecgroup.com>
 <bf645bff-3ec2-4c14-8fe6-b1dd48682af2@linaro.org>
In-Reply-To: <bf645bff-3ec2-4c14-8fe6-b1dd48682af2@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 10 Jun 2025 21:36:34 +1000
X-Gm-Features: AX0GCFvsPKwjHN0DerzzghDOBMs8twfBqYvQcq2dnYrHKmXvZWaXKi4gYr7tfgI
Message-ID: <CAKmqyKMGPaQuneBy_K+XBG9TCJcT5mV_U4-a7xDPtE-ikNKyPg@mail.gmail.com>
Subject: Re: [PATCH v2 4/9] target/riscv: Add MIPS P8700 CSRs
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, 
 "cfu@mips.com" <cfu@mips.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a35;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa35.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Tue, Jun 10, 2025 at 5:42=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> On 2/6/25 15:12, Djordje Todorovic wrote:
> > Define MIPS CSRs used for P8700 CPU.
> >
> > Signed-off-by: Chao-ying Fu <cfu@mips.com>
> > Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
> > ---
> >   target/riscv/cpu.c       |   3 +
> >   target/riscv/cpu.h       |   7 ++
> >   target/riscv/meson.build |   1 +
> >   target/riscv/mips_csr.c  | 219 ++++++++++++++++++++++++++++++++++++++=
+
> >   4 files changed, 230 insertions(+)
> >   create mode 100644 target/riscv/mips_csr.c
>
>
> > diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> > index c0e048a66d..984f93dd4a 100644
> > --- a/target/riscv/cpu.h
> > +++ b/target/riscv/cpu.h
> > @@ -497,6 +497,10 @@ struct CPUArchState {
> >       target_ulong rnmip;
> >       uint64_t rnmi_irqvec;
> >       uint64_t rnmi_excpvec;
> > +
> > +    uint64_t mipstvec; /* MIPS tvec register */
> > +    uint64_t mipsconfig[12]; /* MIPS config register */
> > +    uint64_t mipspmacfg[15]; /* MIPS pmacfg register */
>
> Pointless comments (not helpful at all).
>
> Alternatively:
>
>         struct {
>             uint64_t tvec;
>             uint64_t config[12];
>             uint64_t pmacfg[15];
>         } mips;

We don't want to store these in the CPUArchState. So you will need to
create a vendor specific struct and you can then point to that from
CPUArchState, similar to the existing `RISCVCSR *custom_csrs`

Alistair

>
> >   };
>
>

