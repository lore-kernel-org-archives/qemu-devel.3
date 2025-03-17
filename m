Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABE60C282EC
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 04:33:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tu29q-0002YL-QM; Mon, 17 Mar 2025 00:32:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tu21g-0000Iw-0t; Mon, 17 Mar 2025 00:24:32 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tu21d-0000oT-Dj; Mon, 17 Mar 2025 00:24:30 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2232aead377so85623405ad.0; 
 Sun, 16 Mar 2025 21:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742185466; x=1742790266; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=huoqUTp7ZtbwawFX3uJ5a51YaBtU9ooDniZbVgpzX2Y=;
 b=LF/ERNuMAaBHtTGZRay9HZs9Rpmmt4a1V538VDojTjlO4Vn8zXng/297nkXGeE6mIZ
 WhlUZEwm3NxwFVoCthWASiaI7HosZSToYsSW5LRaQyLyJMUQOuQDNOvb6tA/UD6Asjab
 O7JNFLNAudy0IbyB0UrpZW627ni1IQvdbVecEN5ldvLYRIHIb6v1h0r/yY1LoaP3uri7
 RRwde+YWDkY7ar5gTgwjZhudmZNBGV3e/b/R077fvpXGkNg+BsFZ5afjIXzQ4p5j9RAs
 RAHmfah7WwdAVoj8ko72SAdITQxgSZ8muSB8yiBHV82+KtVU8LRgFRpkLLAZU474eZGI
 07Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742185466; x=1742790266;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=huoqUTp7ZtbwawFX3uJ5a51YaBtU9ooDniZbVgpzX2Y=;
 b=hSYU2QGCeHLETTBA7ZcZf7my8GGLhDlCowx9sVeeuh0LatvHospqGMM9qWVHtcm04g
 SKqZNqxcmx7L/ChhvNQ20EGf6EorwGGqIL9KyRUuvOaB4TyBbMvlcv8pRdXVvZWwQ6p+
 Aq/n0V0otbc9UBXrwIKR2/ph3tSPnwVs/sWMQ+6jQ7HG66FYRNcUp6k4mnAIrnjFODUU
 rKrrgYv7zA4oyQ05gs5Z6hSlq4LEjKbjT3fGMoKJ5vLWM/96fvfmv+Gi1l/Ho8kwnp8+
 1aTVRvxqwGvmDUwQAt53Z2eZ4obBUxzOksgkRRSYKTKW1yqBUYTEJyZ0zjlLyBZwWEqa
 88mQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4Girvv+aer8Omv66bDfAfauG7rqlf6pXd6BnFInJRA6/M509F8o+tmRbGtBqjsLzoT3s95oQsxGQ=@nongnu.org,
 AJvYcCWHcxhmSXokya1NIQiy5nNl8OtEXjVNOX7qktBYdfzl7H4aPmlCBWpIrZe4G6yjeIvW7UxsG/R4Rqbj@nongnu.org
X-Gm-Message-State: AOJu0YyNHyavLDyIwUmG4nl+LxYF775NCYuiQ9EynI26F9h5GQs3DgF9
 Lc7uv8M1+PXYz1T5676zOVY0nt2LXxWFn+Xscf7zhUHu0U8AG1HBG/0bXA==
X-Gm-Gg: ASbGncu9Ip0noXlC6eLqG6lyaAZy30XTX4fbQitboJXZMU2Cq19+9+Xsbdx/UKmk7zu
 aTG9HMA2LZo+RecpY/IPgN7GlXbmyk+fNfhJvw1ueBsSHFYwflK1q6zUhj1I7gnSsPqV9ZP8VAg
 oAGIACr/b3STvC8p+CL2CsFoyo4OotID4TITwj7Y9KYmXLvzY2TcDI53V0tdDksNExscrKHB3fF
 GYDb4dn5RDiWl/v33KaOVqi0g9E8xzLCGScBKsnD08YzRBtS2gO0s0vzJJ9Y23puycGltYNci7v
 NMiK/xXssoDQua4tQSO17i8O5P+RyDhDeSDIMOI=
X-Google-Smtp-Source: AGHT+IGJGL6G83MYc76m0+kXLG8QevetYL3SzRX8i0D7m8payplS7OmIUvKN0eHnAtUB7j6IgoVY5A==
X-Received: by 2002:a17:903:40ce:b0:224:2717:7993 with SMTP id
 d9443c01a7336-225e0b0ed1dmr143828325ad.45.1742185466367; 
 Sun, 16 Mar 2025 21:24:26 -0700 (PDT)
Received: from localhost ([118.208.135.36]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-225c6bbeb94sm65061435ad.199.2025.03.16.21.24.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 16 Mar 2025 21:24:25 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 17 Mar 2025 14:24:22 +1000
Message-Id: <D8I97CI501PM.29Q1AWDR7ZM09@gmail.com>
Subject: Re: [PATCH] target/ppc: Add PIR to ppc_cpu_dump_state() for debug
 print out
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.19.0
References: <20250316144341.39E6F4E6014@zero.eik.bme.hu>
In-Reply-To: <20250316144341.39E6F4E6014@zero.eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Mon Mar 17, 2025 at 12:43 AM AEST, BALATON Zoltan wrote:
> Some CPU variants have a Processor Identification Register which was
> not printed in register dump. Add it to ppc_cpu_dump_state() which is
> used by debug options to print CPU register values.
>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>

Looks okay. I suppose it's not worth a ppc_cpu_get_pir() type function
to get it...

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

Thanks,
Nick

> ---
>  target/ppc/cpu_init.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
> index 8b590e7f17..b1f32662ed 100644
> --- a/target/ppc/cpu_init.c
> +++ b/target/ppc/cpu_init.c
> @@ -7606,9 +7606,14 @@ void ppc_cpu_dump_state(CPUState *cs, FILE *f, int=
 flags)
>      int i;
> =20
>      qemu_fprintf(f, "NIP " TARGET_FMT_lx "   LR " TARGET_FMT_lx " CTR "
> -                 TARGET_FMT_lx " XER " TARGET_FMT_lx " CPU#%d\n",
> -                 env->nip, env->lr, env->ctr, cpu_read_xer(env),
> -                 cs->cpu_index);
> +                 TARGET_FMT_lx " XER " TARGET_FMT_lx,
> +                 env->nip, env->lr, env->ctr, cpu_read_xer(env));
> +    if (env->spr_cb[SPR_PIR].name) {
> +        qemu_fprintf(f, " PIR " TARGET_FMT_lx, env->spr[SPR_PIR]);
> +    } else if (env->spr_cb[SPR_BOOKE_PIR].name) {
> +        qemu_fprintf(f, " PIR " TARGET_FMT_lx, env->spr[SPR_BOOKE_PIR]);
> +    }
> +    qemu_fprintf(f, " CPU#%d\n", cs->cpu_index);
>      qemu_fprintf(f, "MSR " TARGET_FMT_lx " HID0 " TARGET_FMT_lx "  HF "
>                   "%08x iidx %d didx %d\n",
>                   env->msr, env->spr[SPR_HID0], env->hflags,


