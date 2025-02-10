Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2551FC0219B
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 00:57:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thI6f-0002xe-L7; Sun, 09 Feb 2025 19:57:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1thI6N-0002wk-Vb; Sun, 09 Feb 2025 19:56:47 -0500
Received: from mail-vs1-xe36.google.com ([2607:f8b0:4864:20::e36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1thI6L-00034Y-CJ; Sun, 09 Feb 2025 19:56:43 -0500
Received: by mail-vs1-xe36.google.com with SMTP id
 ada2fe7eead31-4ba7787f128so911203137.1; 
 Sun, 09 Feb 2025 16:56:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739149000; x=1739753800; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GkMSDi7t83wzn/gGJ+hK60wh68qHG6iInVe7uhWsQVY=;
 b=l5Nd6RcpvKMoYG3c+73ReUbELmyxBlcUZ3WxtfXYhUrCUPdbVcWztwUh4VuVTYXgIX
 G3H97BqTuPqlUuYxbEwGvkXKr/VJgp8sQ5JrnGiMicLvqE/jMlAf7bYA8/3XCANm5ZQe
 KKryHps81T/evr3cIWtQ3I5jLL3mSqklBewo4sF/zkFQSE9lF5YcISJhvopbuTAh3odu
 2ZkDAfLiNyPhQWABVkmv/U+3TaKdKQxNMm0yVCRU/iivoVEivfu/VGjB9PXvJblbuJJy
 BifDsQFJbvql/PcwnRQdnuNfxxEdKJBPnmxrpZJvMVZeISe7qSvtZcwZ48Uwz7Y/zB5l
 U/5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739149000; x=1739753800;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GkMSDi7t83wzn/gGJ+hK60wh68qHG6iInVe7uhWsQVY=;
 b=oxVBqUNG2vZw87ezNcFmc5icS+Tep5tB8ERsd0y86yj/fTknJUkSA5nXyCRpZeSApt
 cjEW0uZfgkEvsZTlI4QkrDnikOp4i5OCsm8Crr39TaFNvpMx2aHbEx80Kn4Y7GnZ/f6v
 dQ+Q0Y9xGugCtBLQ+SHN37Wr8XklWTQv5nxXwB1W2DSM5P0xnNN6b695lzABuDrw1KR1
 QTBhN96mi/q1ub7GatSfhdAPiTyv2BzvIjx8oQsO4gWKdaqlTMpMjEm56egRuP7Dyitx
 BWi7M47NCB8KyErHS/03DyzwBicx7p9Ivy5j+ln8m8/kB+IPNufMboU7913CxBFxs2EL
 kBKg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWXniCRsvqpBN4pqg003fBLyowmmLhJ79T5MuyXfdaoIdkw8v/efimgFiH3WKiMBLy0dyv+5bSSTlHP@nongnu.org
X-Gm-Message-State: AOJu0YyH9Ac9j1fETYT4nf6+XQXt0oaoOY5FgAi1w3sHyOddjAuo2KYs
 n+Sy8OFj9Jxl0a4GvoJZX8eLVl+DL7X0gA4OiOlbUiMtrwcZbga1ZRnexmp9Z+9RzvuzqzqmN/n
 I4+DitA58hLxTjK8Ov/AaN10Xx2Y=
X-Gm-Gg: ASbGncspVW67IQS6GdKGHvHHiCZ6dXfvSm+UP670qppI0b8rX5clYmU5NWTV2WsMmp2
 KTXVEOFsgyn/ptQajZC1T+U8FPDrVViMisUSo6FBlQjO5i9ZhNnWMDe4HJici40x5JMgRziYYjO
 K4f6LdpD9jVoLjD9AtrUrzAlh8jg==
X-Google-Smtp-Source: AGHT+IHER9OUl+dv2EB5Ja0mH8beUEXymlSr3Aosa0Da64Dvqn2cDIIzrOzguw+yVCpusCb3TCKxkz8qEt4Ts7AMvqk=
X-Received: by 2002:a05:6102:4187:b0:4bb:d394:46f4 with SMTP id
 ada2fe7eead31-4bbd3945611mr244802137.3.1739148999914; Sun, 09 Feb 2025
 16:56:39 -0800 (PST)
MIME-Version: 1.0
References: <20250206153410.236636-1-rbradford@rivosinc.com>
 <20250206153410.236636-3-rbradford@rivosinc.com>
In-Reply-To: <20250206153410.236636-3-rbradford@rivosinc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 10 Feb 2025 10:56:14 +1000
X-Gm-Features: AWEUYZmitIMBjKX4jZCreHJYjlPA6okUxyGq0dRuRi9lHxsNK4RoExoMaFdVkDA
Message-ID: <CAKmqyKPN4DLGVSgjTx_QF9rKd7MPqUDh2zfBA4Sdyid+jzCb1g@mail.gmail.com>
Subject: Re: [PATCH 2/2] disas/riscv: Add missing Sdtrig CSRs
To: Rob Bradford <rbradford@rivosinc.com>
Cc: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 qemu-riscv@nongnu.org, Alistair Francis <Alistair.Francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e36;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe36.google.com
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
> This reflects the latest frozen version of the RISC-V Debug
> specification (1.0.0-rc4) which includes the Sdtrig extension.
>
> Signed-off-by: Rob Bradford <rbradford@rivosinc.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  disas/riscv.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/disas/riscv.c b/disas/riscv.c
> index 305dd40ac4..85cd2a9c2a 100644
> --- a/disas/riscv.c
> +++ b/disas/riscv.c
> @@ -2438,9 +2438,11 @@ static const char *csr_name(int csrno)
>      case 0x07a1: return "tdata1";
>      case 0x07a2: return "tdata2";
>      case 0x07a3: return "tdata3";
> +    case 0x07a4: return "tinfo";
>      case 0x07b0: return "dcsr";
>      case 0x07b1: return "dpc";
> -    case 0x07b2: return "dscratch";
> +    case 0x07b2: return "dscratch0";
> +    case 0x07b3: return "dscratch1";
>      case 0x0b00: return "mcycle";
>      case 0x0b01: return "mtime";
>      case 0x0b02: return "minstret";
> --
> 2.48.1
>
>

