Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEC25C0219B
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 00:56:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thI5W-0002KY-Le; Sun, 09 Feb 2025 19:55:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1thI5U-0002K5-9i; Sun, 09 Feb 2025 19:55:48 -0500
Received: from mail-vs1-xe29.google.com ([2607:f8b0:4864:20::e29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1thI5S-00031N-KZ; Sun, 09 Feb 2025 19:55:47 -0500
Received: by mail-vs1-xe29.google.com with SMTP id
 ada2fe7eead31-4bbbab48111so263984137.0; 
 Sun, 09 Feb 2025 16:55:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739148945; x=1739753745; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Df3b01eM+Jkric0lTW6NkxFkbinWZ+2IBGK1miF0/Ao=;
 b=nM4Lq54FCvK9CHWmAMC01JpM339flJRWlCbOU4Ns0rldebjkZZ9q8IoEjodImj+l7P
 FPjUuijKqKiol+KKKA9V0ZH8itB3j/DSNBznMKIcnV0QaTZx4WvCkSDFlxWmhRPEtJOe
 Y7QQIMHVMTICkpPxbEddt+6/RO1O9pHnXAx7QH7n/abd5ZmEpYRIjSvU8z/nFg1Cl7Va
 6ZTS+b7DgRlGsv+dE+j0uuk/fbd3qiOUsb98cizNJ9zpyvyNNA2dkIrCkQV+7tjl8jy5
 EixKnclhXJELge1rgl4fcyy44MfnqOv9XsFT+fy4/i7t38QK6pIg7RFSr2Wl2XQGKBg2
 w8sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739148945; x=1739753745;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Df3b01eM+Jkric0lTW6NkxFkbinWZ+2IBGK1miF0/Ao=;
 b=X/9NpPge5TZF2Y74Ja7iJ0ITdcdq6B1iGDI+Wj3Au5CqXO6WvhByav0x8623Vio4/O
 iwZIRaKgX6eY/SBYRCi3xII3T77S/0GoR4TA6s1DZFxaxmQYbzOQjXgx0UNN8AJC8OYh
 g7h8aEhfIcKEs5J0nFyHwKhMkWSBIZJq9YSEaEFU2cIPKaJAVvAnmE7NI6KlFs2X+b0L
 HBXuvyTMEE9fx4C2MoOyKwKedP0qlmo5UddcXgwlfdaox2kqagIVnTiNkoPIgHSueu6w
 i0h0CiSNuzT0hlQ1NtVqUrdb2iJgpYGx9PlNsG1kuFIWs/Hp8BvOFxEgJuuR6b+evVmq
 17YQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhkzASa+3KHqO+5BBxeiGmEL//0Je5Dnq3db35Pa8uuAs7BEuMA5GHqIf/Nvaj/+hFuUhlJQjeHP1k@nongnu.org
X-Gm-Message-State: AOJu0YwQyo6PVVWU1k4jLe/sw9LdElnF7yocoSmLQTsDx8magLMQ66x2
 IVVbPBuPqesbsw+gCZY5K6Qhzvruxgxur0pvSvFtYoUdABsgn/XlvNuHCYka9sh2YHqc/otnuRC
 Wn8TtP+N8dJOUQcxkesLo8pNhzUw=
X-Gm-Gg: ASbGncsIqXDUguD+ImZxNa6Wc1z5nyh1SpdHEUSnRdNlC9Mj6A++7dv74eLTlwKNkhH
 D7psPaIPxmjOoZQ4hHA+S0gL0jg/RXyUgOitsJglzusjGG9h/1ZNwyQOjhaXET4nQ2gN3ZgIori
 etIQrLgUQaUEWuk+Y5BiN8zPJuTA==
X-Google-Smtp-Source: AGHT+IGtaW3xFxcqYfJ1RRhWs89C7VZ6jNoGeJ9GbxI6o79zQjOhkGwL0SjPEMXTaP9TwG/jRtGtcfq6FJLt5n0luv4=
X-Received: by 2002:a05:6102:419f:b0:4bb:c0a7:39b8 with SMTP id
 ada2fe7eead31-4bbc0a75178mr1478058137.17.1739148944844; Sun, 09 Feb 2025
 16:55:44 -0800 (PST)
MIME-Version: 1.0
References: <20250206153410.236636-1-rbradford@rivosinc.com>
 <20250206153410.236636-2-rbradford@rivosinc.com>
In-Reply-To: <20250206153410.236636-2-rbradford@rivosinc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 10 Feb 2025 10:55:18 +1000
X-Gm-Features: AWEUYZkKgXuQMh8frlg7d4mWHjQprlt1aImv4fxEw2eQ0Y05WUfpBfgOCo19Gqk
Message-ID: <CAKmqyKOMRP3eW5jRMkqYqHmYdrEsu3Zkkmt7tFDO3SCK=EoPhA@mail.gmail.com>
Subject: Re: [PATCH 1/2] disas/riscv: Fix minor whitespace issues
To: Rob Bradford <rbradford@rivosinc.com>
Cc: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 qemu-riscv@nongnu.org, Alistair Francis <Alistair.Francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e29;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe29.google.com
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

On Fri, Feb 7, 2025 at 1:35=E2=80=AFAM Rob Bradford <rbradford@rivosinc.com=
> wrote:
>
> Some extra spaces made into into the RISC-V opcode data table.
>
> Signed-off-by: Rob Bradford <rbradford@rivosinc.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  disas/riscv.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/disas/riscv.c b/disas/riscv.c
> index 4075ed6bfe..305dd40ac4 100644
> --- a/disas/riscv.c
> +++ b/disas/riscv.c
> @@ -1662,7 +1662,7 @@ const rv_opcode_data rvi_opcode_data[] =3D {
>      { "aes32esi", rv_codec_k_bs, rv_fmt_rs1_rs2_bs, NULL, 0, 0, 0 },
>      { "aes32dsmi", rv_codec_k_bs, rv_fmt_rs1_rs2_bs, NULL, 0, 0, 0 },
>      { "aes32dsi", rv_codec_k_bs, rv_fmt_rs1_rs2_bs, NULL, 0, 0, 0 },
> -    { "aes64ks1i", rv_codec_k_rnum,  rv_fmt_rd_rs1_rnum, NULL, 0, 0, 0 }=
,
> +    { "aes64ks1i", rv_codec_k_rnum, rv_fmt_rd_rs1_rnum, NULL, 0, 0, 0 },
>      { "aes64ks2", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, 0, 0, 0 },
>      { "aes64im", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0 },
>      { "aes64esm", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, 0, 0, 0 },
> @@ -2214,11 +2214,11 @@ const rv_opcode_data rvi_opcode_data[] =3D {
>      { "mop.rr.5", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, 0, 0, 0 },
>      { "mop.rr.6", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, 0, 0, 0 },
>      { "mop.rr.7", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, 0, 0, 0 },
> -    { "c.mop.1",  rv_codec_ci_none, rv_fmt_none, NULL, 0, 0, 0 },
> -    { "c.mop.3",  rv_codec_ci_none, rv_fmt_none, NULL, 0, 0, 0 },
> -    { "c.mop.5",  rv_codec_ci_none, rv_fmt_none, NULL, 0, 0, 0 },
> -    { "c.mop.7",  rv_codec_ci_none, rv_fmt_none, NULL, 0, 0, 0 },
> -    { "c.mop.9",  rv_codec_ci_none, rv_fmt_none, NULL, 0, 0, 0 },
> +    { "c.mop.1", rv_codec_ci_none, rv_fmt_none, NULL, 0, 0, 0 },
> +    { "c.mop.3", rv_codec_ci_none, rv_fmt_none, NULL, 0, 0, 0 },
> +    { "c.mop.5", rv_codec_ci_none, rv_fmt_none, NULL, 0, 0, 0 },
> +    { "c.mop.7", rv_codec_ci_none, rv_fmt_none, NULL, 0, 0, 0 },
> +    { "c.mop.9", rv_codec_ci_none, rv_fmt_none, NULL, 0, 0, 0 },
>      { "c.mop.11", rv_codec_ci_none, rv_fmt_none, NULL, 0, 0, 0 },
>      { "c.mop.13", rv_codec_ci_none, rv_fmt_none, NULL, 0, 0, 0 },
>      { "c.mop.15", rv_codec_ci_none, rv_fmt_none, NULL, 0, 0, 0 },
> --
> 2.48.1
>
>

