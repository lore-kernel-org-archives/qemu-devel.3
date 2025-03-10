Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A71EC282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 23:11:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trmGc-00074s-1t; Mon, 10 Mar 2025 19:10:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1trmGa-00072r-2W; Mon, 10 Mar 2025 19:10:36 -0400
Received: from mail-vk1-xa2f.google.com ([2607:f8b0:4864:20::a2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1trmGY-0006T0-8A; Mon, 10 Mar 2025 19:10:35 -0400
Received: by mail-vk1-xa2f.google.com with SMTP id
 71dfb90a1353d-51eb1823a8eso2227779e0c.3; 
 Mon, 10 Mar 2025 16:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741648231; x=1742253031; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mB7J9pKOy2EnIGyufeEuF2v8jeCrtGwK6JtASiaaOBY=;
 b=bPSgK/IN6EJ27rrFix65OK4ASHBTOaEd3qAJgD0pmuYyT5HUJuEwRl10eaF3hHDCTx
 T2UUGtCxJ9GRBqPWbvi/+lVAY7RnyFXuFnEdPVXlyYCb0sn904a6PDlLSHZVVMo/p803
 V9+r3yf5tp6EiQH7SowqjchWLMUPNDGQK9bnJS1bsuf2unLE+2bOHpuzraruYKzqZ+3l
 jyCwBwg09s4LAR4spxpvsn4+AMY38d414TkBRxB1mBG3uURZC6wtffnvmzCbL8k8jCX3
 EP6tx3t4eQFQBpmOq6BlbMyUv+7OGTIhuInAeyPzgwp8E8VwB5hlzpKLcdmppM+3ynvm
 6iPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741648231; x=1742253031;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mB7J9pKOy2EnIGyufeEuF2v8jeCrtGwK6JtASiaaOBY=;
 b=EOZ208f0URPgITidbEqRI4pFbvjhBhnHHziaEUzgRbK9KbLmP30Vwv0kP6H/4V5oXA
 zNNERvMH8/jDRtgb48vp0pYK7+3zSuqkiDlUaLVOQNtiz+tyZ0zqasEzeuUXKRJtRrXA
 2FflAXeMQ96PZ1TDvk3LkrdlC9N5E1Ry3Joa74MKwEgQIjSK5eO9HsMPmXeGMa27iTT3
 lC67pe301C8OHZchrWnYc+65aEN1NfXqMM8mSSz3c2OnyatpjUziNOoGTHeKx1+ueIZY
 si88J9cxJbhG+CKF98rNCXOSBU2t29hYPZfExX6bVsdYmFWrPBzSlpreztWyxqrkn3Dj
 vhZw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUTpzG31zUQYZsq6fbpT0xxMJrg9/bB/72K25Wrhm65QOHyBfmJyWwOnCWTCX5qOtO5UejDjH26PAtmZw==@nongnu.org
X-Gm-Message-State: AOJu0YxKHmHzuDsCNYAur/iuCxkkWTq8++hAFEfq0ttkqvW75WweyIuU
 16PDd8i6D9pW8rYCAJNIbyNvPlo5nF6eI4YCO0F3w8UbPHlMy/W1B7djQeLM36gSo9A4Ha4mz30
 W36ENRlW3eiX2nm1d8LP4pa67Bno=
X-Gm-Gg: ASbGncvR1G6YmH28G1CYTeskGP3agE1uypuTy21IiHlkWbu/lq31zHoYXwCT9mBPlPK
 7XoTo9+4IaZypniei9k/fDtVJA+nuF7s7GwJw8qFqj/o9CsUZgx2K4E99V06SkZEvph7HAUHb1v
 I7odndvbAIqQf1eYlBF/AjVmbJ7afF6vDQkhHVVFrGQqekb1yjX2UpbT9E
X-Google-Smtp-Source: AGHT+IFh8LMDHRTua0iVZj0kn1r2TriB27mDwNTkFdTnL1p84lWZNEF4D4449g9TrgvgfGLGLww5tX1fFCYU5FK/7dU=
X-Received: by 2002:a05:6102:3a0b:b0:4c1:85d9:5641 with SMTP id
 ada2fe7eead31-4c30a5e7d37mr8907405137.11.1741648230986; Mon, 10 Mar 2025
 16:10:30 -0700 (PDT)
MIME-Version: 1.0
References: <20250308225902.1208237-1-richard.henderson@linaro.org>
 <20250308225902.1208237-3-richard.henderson@linaro.org>
In-Reply-To: <20250308225902.1208237-3-richard.henderson@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 11 Mar 2025 09:10:05 +1000
X-Gm-Features: AQ5f1JpOwDBE4ynATCvzlnTGSha4ENgxfzd1qTDtykaXla47p9sFpfFeP611p54
Message-ID: <CAKmqyKOTFQCp9gHvWvKeDoWDpbP+eh4=qXpDrZyS9S1R0jJKYw@mail.gmail.com>
Subject: Re: [PATCH v2] linux-user/riscv: Fix handling of cpu mask in
 riscv_hwprobe syscall
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, 
 Andreas Schwab <schwab@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2f;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2f.google.com
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

On Sun, Mar 9, 2025 at 9:00=E2=80=AFAM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The third argument of the syscall contains the size of the
> cpu mask in bytes, not bits.  Nor is the size rounded up to
> a multiple of sizeof(abi_ulong).
>
> Cc: qemu-stable@nongnu.org
> Reported-by: Andreas Schwab <schwab@suse.de>
> Fixes: 9e1c7d982d7 ("linux-user/riscv: Add syscall riscv_hwprobe")
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
>  linux-user/syscall.c | 55 +++++++++++++++++++++++---------------------
>  1 file changed, 29 insertions(+), 26 deletions(-)
>
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 02ea4221c9..fcc77c094d 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -9118,35 +9118,38 @@ static void risc_hwprobe_fill_pairs(CPURISCVState=
 *env,
>      }
>  }
>
> -static int cpu_set_valid(abi_long arg3, abi_long arg4)
> +/*
> + * If the cpumask_t of (target_cpus, cpusetsize) cannot be read: -EFAULT=
.
> + * If the cpumast_t has no bits set: -EINVAL.
> + * Otherwise the cpumask_t contains some bit set: 0.
> + * Unlike the kernel, we do not mask cpumask_t by the set of online cpus=
,
> + * nor bound the search by cpumask_size().
> + */
> +static int nonempty_cpu_set(abi_ulong cpusetsize, abi_ptr target_cpus)
>  {
> -    int ret, i, tmp;
> -    size_t host_mask_size, target_mask_size;
> -    unsigned long *host_mask;
> +    unsigned char *p =3D lock_user(VERIFY_READ, target_cpus, cpusetsize,=
 1);
> +    int ret =3D -TARGET_EFAULT;
>
> -    /*
> -     * cpu_set_t represent CPU masks as bit masks of type unsigned long =
*.
> -     * arg3 contains the cpu count.
> -     */
> -    tmp =3D (8 * sizeof(abi_ulong));
> -    target_mask_size =3D ((arg3 + tmp - 1) / tmp) * sizeof(abi_ulong);
> -    host_mask_size =3D (target_mask_size + (sizeof(*host_mask) - 1)) &
> -                     ~(sizeof(*host_mask) - 1);
> -
> -    host_mask =3D alloca(host_mask_size);
> -
> -    ret =3D target_to_host_cpu_mask(host_mask, host_mask_size,
> -                                  arg4, target_mask_size);
> -    if (ret !=3D 0) {
> -        return ret;
> -    }
> -
> -    for (i =3D 0 ; i < host_mask_size / sizeof(*host_mask); i++) {
> -        if (host_mask[i] !=3D 0) {
> -            return 0;
> +    if (p) {
> +        ret =3D -TARGET_EINVAL;
> +        /*
> +         * Since we only care about the empty/non-empty state of the cpu=
mask_t
> +         * not the individual bits, we do not need to repartition the bi=
ts
> +         * from target abi_ulong to host unsigned long.
> +         *
> +         * Note that the kernel does not round up cpusetsize to a multip=
le of
> +         * sizeof(abi_ulong).  After bounding cpusetsize by cpumask_size=
(),
> +         * it copies exactly cpusetsize bytes into a zeroed buffer.
> +         */
> +        for (abi_ulong i =3D 0; i < cpusetsize; ++i) {
> +            if (p[i]) {
> +                ret =3D 0;
> +                break;
> +            }
>          }
> +        unlock_user(p, target_cpus, 0);
>      }
> -    return -TARGET_EINVAL;
> +    return ret;
>  }
>
>  static abi_long do_riscv_hwprobe(CPUArchState *cpu_env, abi_long arg1,
> @@ -9163,7 +9166,7 @@ static abi_long do_riscv_hwprobe(CPUArchState *cpu_=
env, abi_long arg1,
>
>      /* check cpu_set */
>      if (arg3 !=3D 0) {
> -        ret =3D cpu_set_valid(arg3, arg4);
> +        ret =3D nonempty_cpu_set(arg3, arg4);
>          if (ret !=3D 0) {
>              return ret;
>          }
> --
> 2.43.0
>
>

