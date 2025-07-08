Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD9C9C8303C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Jul 2025 20:12:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZEfs-0003Jj-Nn; Tue, 08 Jul 2025 16:12:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luxu.kernel@bytedance.com>)
 id 1uZDYV-0006b5-AV
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 15:00:43 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luxu.kernel@bytedance.com>)
 id 1uZDY8-0002HP-QG
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 15:00:34 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-748d982e97cso4201506b3a.1
 for <qemu-devel@nongnu.org>; Tue, 08 Jul 2025 11:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1752001180; x=1752605980; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kzL69JQNXTzzWE+QcQYF9KB+BS9wTnI7qk0XtFQ0Klc=;
 b=TmojcT0660JgJUYOwxJvftl5a5+c90Oqc6kcsA64RwT78zV5xidq0CqSuLhm65Frnr
 s5bAa0xSvnbBk87kIcp+6TTMbW62mi3mRA82XbVKikRP5r/e9BCdcNB9bmn4YLjFvpfH
 pmtn7Ny8YU+/TyEONbRYd7XA56prDNydtbCCzsKbfLf2LlLbLXNUel1qDQmEuKwFXxRz
 WsZ4Tjkm/8GyB3hy5vs4ZFEbsixcC0PAICLSKZYsppxHbkx4GgnfxoZhgXpvYU/zH8RU
 z5p34w+cA9qo43YfsTX3fWTYweYxdQDNUD8rqwmWEqaWYR1lK8UjsVwSR7kHyivTZlw8
 TabQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752001180; x=1752605980;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kzL69JQNXTzzWE+QcQYF9KB+BS9wTnI7qk0XtFQ0Klc=;
 b=LdnupZzAgdKd5zdGPNX6HAoucy314rH1S/hphoGeMsxd7DA3pwpu9FmVZ18/gO1IDt
 vBc4b7GPxkTiPBVKwXYdmaQkWQzYY08PH3vxKO6+r/t/irouCe0fmOIrbDwkcrvgX6Wi
 n6yLIJynhS8mfR4+BU/0rTJ9uOdmM1X18DGigFFI7Vu43eTpDC6b3RA+RRrGfca9s9kY
 poTfya8broy3cm1xOQElDCcEwKvEWOHy2zqfc4Lzg7UZNeVYXE9tpeKzGTw8DKOhSJ5r
 UbT61wOWP2beiEk/JJ/ka+elxMb8SUA7wHbQx7TTsoqYveL4FG9T/jrq2BHeYpN0Kf0c
 mCzQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWgJIREG2kIKeaJzLQMOz+DRJqOdccXMiMib1Y1dgDrbvNW24sjVSf2TJYOkFpj+KlATS9OLWm6JWVe@nongnu.org
X-Gm-Message-State: AOJu0YwlWpar4Bk34Q0ww+846Yi8L3vpkLiM0zLnTdKa2v9/MqWEN9d0
 xvXcbP4sfqbYF3H8u7p7a9qtHgIGvjlh+lShBc+ThyREBIbZhRLHXj1b2+kHQkwdwHAgKOOs9gF
 KbWCYxIw4vqekmPRgbXD6XjQK1n+vQ4KcQfNCi7cI+OZkKf4h/UUpclyPZYOoPSE=
X-Gm-Gg: ASbGncvooMEVE7QMFOJvOIx/jaC34UZU5QgDXPkPOYj1H5OhwAvlGohfYTfSsZZfEk4
 jq+Z/G3axs1yMydqv8MrUN6muTxv9tx3z0jVb9z0ujN3i9YD0TcSZSHUbC7CAh98CFBDZbb/Zal
 e0dbqvIc6wsotIWEfYFPZdpa/jrEUdpiywWaNRnrk4Mr5PSaHL8NwLLKDB
X-Google-Smtp-Source: AGHT+IEIj2+OWKEuHs/WuoR1eHIFaMEkUiiAoexdclbWszfNjKlbljISmiozjKqu3DLZwa3dMJvA+vOwNUlre/uap3I=
X-Received: by 2002:a17:902:f60b:b0:234:bfcb:5c1d with SMTP id
 d9443c01a7336-23c85eb06ccmr239449995ad.40.1751963564698; Tue, 08 Jul 2025
 01:32:44 -0700 (PDT)
MIME-Version: 1.0
References: <20250708060720.7030-1-luxu.kernel@bytedance.com>
In-Reply-To: <20250708060720.7030-1-luxu.kernel@bytedance.com>
From: Xu Lu <luxu.kernel@bytedance.com>
Date: Tue, 8 Jul 2025 16:32:33 +0800
X-Gm-Features: Ac12FXzx9nI_d6ljKnI48H3U1qt08GGNwpDcdOt0sS-TtGK4-7kgkxLq6cHAV3s
Message-ID: <CAPYmKFv9ye2_r5iMme9EXFyP8FKm-bkRb92_0XSK7kwnY-tONg@mail.gmail.com>
Subject: Re: [PATCH] target/riscv: Fix exception type when VU accesses
 supervisor CSRs
To: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com, 
 zhiwei_liu@linux.alibaba.com, apatel@ventanamicro.com
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=luxu.kernel@bytedance.com; helo=mail-pf1-x432.google.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_06_12=1.543,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

FYI, the discussion about whether vs insn fault or illegal insn fault
should be raised can be found from [1].

[1] https://lists.riscv.org/g/tech-privileged/message/2469

On Tue, Jul 8, 2025 at 2:07=E2=80=AFPM Xu Lu <luxu.kernel@bytedance.com> wr=
ote:
>
> When supervisor CSRs are accessed from VU-mode, a virtual instruction
> exception should be raised instead of an illegal instruction.
>
> Fixes: c1fbcecb3a (target/riscv: Fix csr number based privilege checking)
> Signed-off-by: Xu Lu <luxu.kernel@bytedance.com>
> ---
>  target/riscv/csr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index 8631be97c5..9bebfae3f0 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -5577,7 +5577,7 @@ static inline RISCVException riscv_csrrw_check(CPUR=
ISCVState *env,
>
>      csr_priv =3D get_field(csrno, 0x300);
>      if (!env->debugger && (effective_priv < csr_priv)) {
> -        if (csr_priv =3D=3D (PRV_S + 1) && env->virt_enabled) {
> +        if (csr_priv <=3D (PRV_S + 1) && env->virt_enabled) {
>              return RISCV_EXCP_VIRT_INSTRUCTION_FAULT;
>          }
>          return RISCV_EXCP_ILLEGAL_INST;
> --
> 2.20.1
>

