Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14E41CD6E5D
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 00:53:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUZqL-0002m4-Dz; Tue, 02 Jun 2026 20:52:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wUZqJ-0002ln-Nj
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 20:52:23 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wUZqI-0005pX-3B
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 20:52:23 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-bed2b9bfa02so369172866b.1
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2026 17:52:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780447940; cv=none;
 d=google.com; s=arc-20240605;
 b=fhOL5Aje7dX7AFLNMX4SWn4i2HmEQN3IbaZlM9RWdxJpUTt1lrFkCsk1bgnLN0zWvk
 Uc8XNyC6nNov85JwqJ6jPG/kGVxZltHptQRa3wc0zKmZioUt8CEIyVwaRCr+tYlJb9uJ
 30pPDCe4+QDN9YnSpnXuyJdECn4vtiu5mlkoJYmbWxq6x2xQqT4BA2J323Zk9H5OoOai
 2gnR73STpcewRwVEbZhYa9z9eIbuQ1TulalVo0LvvlkW5iQGxbGq2burjc2iqaRM7UOL
 fFjoTD2WwZ4NFNhS2oMlae2hvpOW8NLVEHt1TZJULmYakxi2m6HPjwXBTiFT4VrVGuHL
 lGJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=jJSaa7yH6vcF1eiZfyeUn17OYenY/LbbDnBTWb9NWyY=;
 fh=uqr/DpQacYcsRXO1RgcDHJmf4HNnoXaKHl6JDk/PLmQ=;
 b=AZIOwbOxH131tFznUwW/Qlbo931/UL90TDnMWRFJMr02QG4hieixh5HwViNo3UIjel
 J7M/CoZh6n0173nVwogWv+fHHS9vzRMhYzSiriGLM/2s7Psx57E5wqQZIcO8uJIQ9DT0
 jweiTK3B8aBTEdT0azUGA6/KcujJuF0wcvhkC4mikOJJTnKc5M09BdpCycydNUh3eRgF
 E1by80b9kQNUAmp4T6W9fWdqhzJ7lhYIlYTut9aATVLCA6YTp20ZKlNw26Y5uZ9VzgTv
 b69cJJMOBjMbFgNkAF2SNvfOArmFSI/JwQGwSfGvyOgsHMCZoP5sEcoN2v8VRxLd26jY
 PPeA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780447940; x=1781052740; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jJSaa7yH6vcF1eiZfyeUn17OYenY/LbbDnBTWb9NWyY=;
 b=E1g5tY8mCpq2upXhjRS55HP+MhBTzWaKlXbBLo0mbtuh2R37tsgyj1jN7C39vqs3EZ
 C9vJ0BDoTHAqs+12pvfmnt7QS9qbXNdCf5LQfug8suUyRL4oYM47fteONNfNyOL1VGoO
 ILCZg6AGo3VJN9EcABprVMCD3d7JYPozyzPCHAyO0LQX+JnH6NcGb/FCM3Kuj736Ms63
 ePuOF8avNId9HPq8trOSx4JCLEq5j0P38qoSaffB01NXYRF8AtsDPRYMozWN88GpERZh
 2+ox+6JySF9QPiVXj5IvjElL99cjd5zZeLhkxmWkEW4wSJQAcb5zKkmeX4awG9fO5qQi
 8vQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780447940; x=1781052740;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jJSaa7yH6vcF1eiZfyeUn17OYenY/LbbDnBTWb9NWyY=;
 b=lq5n8mNndhDxKodYRPXdiFL9MJ7QyL4i+hzDbwq1t2trh20n2asEruCHwWv3yGb05P
 wP3amSXwhnbDS31HI6gTcEyF5cMuC2Px9z+VtJy17VXSkB2KIIw6eXxbWsGiKK+nLXR0
 GDmqF6NzhEjJpe3vzfDfWhDns2XtbYHHXRgL9bThHbOX+z+3GzR87QdGuWjePN8qIJeL
 /zWrB/WTLqaFEgmvCQJo6twa8MCEpVuwC/rWA4Y9HDScKQIVP8dM3LHYmnZbE4B1mrTx
 e3svu6zDVll2ncZudUu6H2qhuYQtwpOCE1oW/MbyibIM7SvWM7UlUQWPXjQSdJlYaIiF
 uwqA==
X-Gm-Message-State: AOJu0YzbAiNVuLj3ICQ7Noh8Aa3+LTDF8yEOUJJxY7FEbOJ174iI/6BC
 lclvrtPkWhIyV1xPXwstpVAYD4HnbYh7DcO32NJtC3TWguB7PVMhIKPqS4RG16ur0/TVs2FHjAH
 xSNwKLVEq6jQrnKNSR/pWlcG3sOy6T0U=
X-Gm-Gg: Acq92OEVbutCVRTcR3oGOEAJ0/nspth7LU5/2o0T6ASZs0wnFKGXb1McOooylEnUFSY
 zrQIjjHa7xo6JOAeBDzFFfiukZHbotcT0wXkh6wCERqySY5hwdO2EcdBHbRh0Jr9ewcwD4n0Fe8
 Z36hIQnQGfFNsUNmOVgaRv8WId1lra6Sjcy+ZRfAUVIPe8AJP33SRKVusasc/+GaTPOPTz3T7mN
 NROLljseTw/hxdcOq10Yh2ku4EL5+Ou+/JiKfHeYWdKC2Yr5PAQsIoy3Llwb0s6LMn3wbrSI+cG
 qMR8bCZGR46IiuhvLWRehYG0IePC03Z1mSuuhdOQg2Km7Q/a
X-Received: by 2002:a17:906:730d:b0:bef:d3a1:5065 with SMTP id
 a640c23a62f3a-bf0b15d6602mr31513566b.18.1780447940346; Tue, 02 Jun 2026
 17:52:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260529053519.1224019-1-antonb@tenstorrent.com>
 <20260529053519.1224019-2-antonb@tenstorrent.com>
In-Reply-To: <20260529053519.1224019-2-antonb@tenstorrent.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 3 Jun 2026 10:51:53 +1000
X-Gm-Features: AVHnY4KaXzrLsMs_6btxqyJM7mWJgCNvoZjL1dUHzwIGRzuTGtpbbonosafHRI4
Message-ID: <CAKmqyKM9_Xg7r9s_dTxFaQbe95dMBXW9BLQqVBVEpGR+YNLNGg@mail.gmail.com>
Subject: Re: [PATCH 2/2] target/riscv: Improve alignment in
 riscv_cpu_dump_state
To: Anton Blanchard <antonb@tenstorrent.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 daniel.barboza@oss.qualcomm.com, palmer@dabbelt.com, liwei1518@gmail.com, 
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x62b.google.com
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

On Fri, May 29, 2026 at 3:37=E2=80=AFPM Anton Blanchard <antonb@tenstorrent=
.com> wrote:
>
> Align all the CSR values. mcountinhibit is the longest CSR name at
> 13 characters, so use that width for PC, implicit state, and CSR names.
> Also remove the redundant '=3D' from the implicit state lines.t
>
> Signed-off-by: Anton Blanchard <antonb@tenstorrent.com>

Thanks!

Applied to riscv-to-apply.next

In future please make sure a multi-patch series includes a cover
letter. It makes it easier for the tools to apply the patches

Alistair

> ---
>  target/riscv/cpu.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> This makes it easier to read the output in my eyes, but I wasn't sure if =
the
> format is set in stone. Feel free to drop it if so.
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index b38ddc39ea..883aa906a1 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -575,7 +575,7 @@ static void riscv_dump_csr(CPURISCVState *env, int cs=
rno, FILE *f)
>       * to do the filtering of the registers that are present.
>       */
>      if (res =3D=3D RISCV_EXCP_NONE) {
> -        qemu_fprintf(f, " %-8s " TARGET_FMT_lx "\n",
> +        qemu_fprintf(f, " %-13s " TARGET_FMT_lx "\n",
>                       csr_ops[csrno].name, val);
>      }
>  }
> @@ -604,17 +604,17 @@ static void riscv_cpu_dump_state(CPUState *cs, FILE=
 *f, int flags)
>      uint8_t *p;
>
>  #if !defined(CONFIG_USER_ONLY)
> -    qemu_fprintf(f, " %s %s\n", "priv   =3D  ", riscv_priv_str(env->priv=
));
> +    qemu_fprintf(f, " %-13s %s\n", "priv", riscv_priv_str(env->priv));
>
>      if (riscv_has_ext(env, RVH)) {
> -        qemu_fprintf(f, " %s %d\n", "V      =3D  ", env->virt_enabled);
> +        qemu_fprintf(f, " %-13s %d\n", "V", env->virt_enabled);
>      }
>
>      if (cpu->cfg.ext_zicfilp) {
> -        qemu_fprintf(f, " %s %d\n", "elp    =3D  ", env->elp);
> +        qemu_fprintf(f, " %-13s %d\n", "elp", env->elp);
>      }
>  #endif
> -    qemu_fprintf(f, " %s %" PRIx64 "\n", "pc      ", env->pc);
> +    qemu_fprintf(f, " %-13s %" PRIx64 "\n", "pc", env->pc);
>  #ifndef CONFIG_USER_ONLY
>      for (i =3D 0; i < ARRAY_SIZE(csr_ops); i++) {
>          int csrno =3D i;
> --
> 2.34.1
>
>

