Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D111CD5BDE
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 00:58:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wS2aK-0000wb-4j; Tue, 26 May 2026 20:57:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wS2aC-0000vH-DE
 for qemu-devel@nongnu.org; Tue, 26 May 2026 20:57:16 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wS2aA-0003i8-Uq
 for qemu-devel@nongnu.org; Tue, 26 May 2026 20:57:16 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-687e7edaafeso7636154a12.1
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 17:57:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779843433; cv=none;
 d=google.com; s=arc-20240605;
 b=MXmieoyAd7it8ZRcEwQIjtEVx8HwEJvgV+NELvwVHP+cppYWc6y4fkFPOU+1s3IqZE
 i0XQwsiYYVhYhuhqV4gQw7XJz1Jv138hVd+UwjglkJOv9tgbPn/48j5rqsRG+c6ocL4Y
 GGK8tirwq/cjrkez64kXncrvSc6y0wgMtaATqv9jkpEOIUpP4Kd/4M0J/HJdsBw6OzWi
 fV3yuvrEc1I1ONhYJcBGOM/cuQ1e9CkVZduWb19qcfKqTRoZaY+NC4UwwJn59Ow6wnlX
 dibpyp7c21GJ84o9rgesjfjLfTSrnrepdY2m6pVsjjqJAIBwPU0Wpg0mORZso9zCYnfq
 GZWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=qqs0dfe14J0R0dMM55M2yZYsn8/dUpwZHmofUuHZR2M=;
 fh=RUA1RkU/KHcJyisHKBC8qNBuqq0+V5pLGgc008yaKkA=;
 b=KKzM96JZ5mxC2uyuHBT8pYCrxRqx67Me8diwr/vIsGE3Z++i6AJzJsvFy9br+71l5a
 b4TTC1LgJPK+WuLX5GeGMydrgUmEvymO+U7QawWxbyCUhMkSHKsVW20EqIEiXc+SlYph
 gRRA64VIFpqTk/ESFwp1cN5Z2qhzmZBhTy41IyItHWE4c8Xm9gO5gDYw6II3W8eksmED
 ufp7IOTvHdb4QXX1h2VXnmFtexI6d94ZhRwcC6jEWJG7MdJfLMxviBEqlEHnYSJccy4V
 6TiKbDshE9VCUeTOfBMduXOo5/WKb6L3mvj0zBGSDuClUx9tDuFEkiiXWy3WsV3r1kWN
 yr7g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779843433; x=1780448233; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qqs0dfe14J0R0dMM55M2yZYsn8/dUpwZHmofUuHZR2M=;
 b=Ht0e1OYIA4opRpGurZAZk5bbGacuzffr51I1kXhGKM5L5/mUOjZnPuvnPW06g4U5Nm
 mlu5MX8vUQiyMTJQ6/UNTmYs6UxWIS4fZJo7BnKJtMS3A/q3snJZa14WO2LMgMrORscH
 bmMugtrM1rRcNGbW3cos6lPED7TuIYiGnnGdQmCcWOOO1hf2oEY4PkwI3f+Az0qcMz4H
 cyBwZCb4BwMsaHm77bC3gJVDfspgzKl6k3gHud9yZKPKZprkDygkxp1b8gegX9gWr1fm
 tV0p6K0+5RmEcWeWRqA6EBPpNW9o0ay8CQT1JzF+awjYIpQalaj2k57Uh/n1IZi+u76F
 Z0Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779843433; x=1780448233;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qqs0dfe14J0R0dMM55M2yZYsn8/dUpwZHmofUuHZR2M=;
 b=qEkzxJ5t2R93tDqlNieUUbb1sKD57fC08kJovMx2ukW0vkUidfOpNAWeh0+oNbMnOe
 5HVm0t+gJYZsDyeN6+NNaq9DgssvavnHVG30O/ANitk31Ji+ZKmTZztxJimEzIDnhPT9
 QyYgjeyXHjuCfF/CzH4/izo5deYD4mp6+JMjpJYm38dc1iCwMq6nno7KcIROWyVBsrWD
 F6TpvgyDcrkaVLFDrxpOZWFJRrNHsqzgusQGh9ST0CrB/w1CKib91rGSx7dfBYZuAH6U
 3srDcu9FEQ+yLeh+cNx7w0CiQhtEj6bK2qQzErOacr1oYYN7+exiP+mXJYmu+eXd14Va
 OsTg==
X-Gm-Message-State: AOJu0YxOiUwq6He4Nmw/6ILHoKRyNM6i0WJsw2299pUuBGmSejwCJlB2
 mbPWegA9wx52d8q4jBaZPNcR8atCIF3K1iMeNeHZ2kd2/iHuPUkEq7Kqb1qQZVLM9d9Abrkwm7B
 fXRyingbKo6OTkSSFBMqx0Du/jBiolPA=
X-Gm-Gg: Acq92OFY5jQzMQkmZSoxux9OA8hexdNvZIU5fbqPRGgwKHghUXQnr8VJTJ+HCU3KeKA
 XwAr96uOc1KXJ6oy8zZoplug8IYf0eCBh9FQAmKhs3WsidDVGW2j3IxeLTG+R7pj9n8CR+i5NMM
 CVpFo/gj2nOM6gFhWpJGKFeAxmdFOtmQXqonAYUB8IABf5hBDVHbxkS1DiXisdVe6XejSHNmk9p
 TnjUHdDX5ab8xO89jj3ExWaVLM37jrNWh1INbZNBbwCjpuF1du8xAerkzWmCIx33FFtfRqpXXWW
 4aX/ML4/Uoj+g9+RFAbB2SBiPmfeQOkP7kLuWGjPymnR1+8D
X-Received: by 2002:a17:907:2723:b0:bdb:5c26:d489 with SMTP id
 a640c23a62f3a-bdd24f44facmr826581166b.13.1779843433060; Tue, 26 May 2026
 17:57:13 -0700 (PDT)
MIME-Version: 1.0
References: <20241231032654.133039-1-frank.chang@sifive.com>
 <20241231032654.133039-3-frank.chang@sifive.com>
In-Reply-To: <20241231032654.133039-3-frank.chang@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 27 May 2026 10:56:46 +1000
X-Gm-Features: AVHnY4IdnkpIuCYqMj7KJn-Ue4sANVL8HxQlqWAtNKG8qXSyxb1dDUgSqgOAUyM
Message-ID: <CAKmqyKNvZQ2XEAgwCDpOHVfV_NPnmMBD+ZV2q5dRAhoaKcpvug@mail.gmail.com>
Subject: Re: [PATCH v11 2/6] target/riscv: Add Smrnmi CSRs
To: frank.chang@sifive.com
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Tommy Wu <tommy.wu@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x534.google.com
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

On Tue, Dec 31, 2024 at 1:28=E2=80=AFPM <frank.chang@sifive.com> wrote:
>
> From: Tommy Wu <tommy.wu@sifive.com>
>
> The Smrnmi extension adds the 'mnscratch', 'mnepc', 'mncause',
> 'mnstatus' CSRs.
>
> Signed-off-by: Frank Chang <frank.chang@sifive.com>
> Signed-off-by: Tommy Wu <tommy.wu@sifive.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  target/riscv/cpu.c      |  5 +++
>  target/riscv/cpu.h      |  7 ++++
>  target/riscv/cpu_bits.h | 11 ++++++
>  target/riscv/csr.c      | 82 +++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 105 insertions(+)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 58bb5196a8..c5d5c2f7df 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -1127,6 +1127,11 @@ static void riscv_cpu_reset_hold(Object *obj, Rese=
tType type)
>          riscv_trigger_reset_hold(env);
>      }
>
> +    if (cpu->cfg.ext_smrnmi) {
> +        env->rnmip =3D 0;
> +        env->mnstatus =3D set_field(env->mnstatus, MNSTATUS_NMIE, false)=
;
> +    }
> +
>      if (kvm_enabled()) {
>          kvm_riscv_reset_vcpu(cpu);
>      }
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 284b112821..a2cb471b3c 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -486,6 +486,13 @@ struct CPUArchState {
>      uint64_t kvm_timer_state;
>      uint64_t kvm_timer_frequency;
>  #endif /* CONFIG_KVM */
> +
> +    /* RNMI */
> +    target_ulong mnscratch;
> +    target_ulong mnepc;
> +    target_ulong mncause; /* mncause without bit XLEN-1 set to 1 */
> +    target_ulong mnstatus;
> +    target_ulong rnmip;

These have been added to the wrong part of the struct, they should be
above the comment

/* Fields from here on are preserved across CPU reset. */

Can you fix this up please?

Alistair

