Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2611DC5B543
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 11:31:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOxBc-0008V2-NS; Tue, 10 Jun 2025 07:30:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uOxBR-0008Tx-KH; Tue, 10 Jun 2025 07:30:25 -0400
Received: from mail-ua1-x92c.google.com ([2607:f8b0:4864:20::92c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uOxBP-0008PR-WE; Tue, 10 Jun 2025 07:30:25 -0400
Received: by mail-ua1-x92c.google.com with SMTP id
 a1e0cc1a2514c-87eeca0d038so195633241.0; 
 Tue, 10 Jun 2025 04:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749555022; x=1750159822; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T8ESx4ZkWoFQTW7Q6XIzDvmCu8W5od9QHK2M3ZOSUbc=;
 b=Glp3EH8ht9hCwKUTSs46Tr15XH4yhng0LMvn6W+Rbae1thByxhZMli9WoSL0z887TH
 2HYGHXCGOzYk2+hjx7/znusurx8MPiJwQAAFQijBdK6mrkpBUiqDUZNMQNaMSJGAVcO1
 zXlDkPFGt++zP3w9PR7K/QfXM0BXOh1m3aiiXwzqsphMD/IVbu4sFdXV8kj0jpuXdRML
 r7Cmxm2Uvizhf05yPzWYrcSw3qf3cejhflZn4YAcwWC50elhXNfQ5+MJQ2tNrgG/d7un
 qzOGPLsghaVcrx3yBMSHm1cjG64zEXHwVsIlYMV2JdWbj1ukzTjT/ZcLOwO7XE0CptL/
 LLqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749555022; x=1750159822;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T8ESx4ZkWoFQTW7Q6XIzDvmCu8W5od9QHK2M3ZOSUbc=;
 b=R8+HmRFCLF037xDupiG9ahIYe0FYXzxiyxz/fqnd6v4ai/hvik84/62tgrxKI37GWD
 tf7/eYAWhmS8tsH63paBfZRIzSG/TfcfLfgz35J6vnTNUehTlpQ+S414u9ss9t5JjYhl
 dhSh679G7vxUtGQTxbOGGElObZ8gE6YS+DVIhhxN3gHhYuzVZIKNj6VX1qUvALyd+gLf
 xc6dtWC094tY0y1TSJ5gEph8i6Y/Pvn+53cIjuUsj48y2UJtW7TR/VKQcfev3kMQsaHr
 K8HHbezeh62Ucr9LE79qdV2qNMQheE0kXZS83fvKswVLySw3rXcmWC1Ntkb5GFtDO9/g
 EuYw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8AIrLqYMAGrReWRJ6gNac9atBfxNtWngyrbhZbobU/vam3uf1h1C7Uy7rG/mnYkkM81j/NLy/9cwJ@nongnu.org
X-Gm-Message-State: AOJu0YxwtEt+nTZEYKloC4NWLBXXX6KD8Z0Cqog0sMjE5diCaYuBgdF5
 cocEixOPaD6wQ3nub2TD97+qAKXOSnvTvavyDmvNeaQ0rfmXiJ5lUHWgIX/dgvkbm2DQURqYuXz
 VNmHks2UxmH+yrwVWlLFHhwGDLrl3HYo=
X-Gm-Gg: ASbGncv//m82ZL9sZbVRWsPm0wKXlHXtHjNAY7759NJHHSdsjqHXUTpx5GkVkcY+0nG
 ckVD+5hRFa9WmAihCa7BwqTvTDTzTCbjO27074SQtR8tgHVKUu0oy1crnJ/SWXZoNEpzs43M3vG
 7UKhV7JZTjvUQp6Oi4QujcRsQlDGS/TGUdtkEHlcba0dpoSEEu1fB1pHqttx26BVwfOo6GvXlZd
 A==
X-Google-Smtp-Source: AGHT+IFczZyeXHXgwCH76s1MxG+t5fE6FOpVAwBBYc9EHPbDqAxWoOVWLxWOWC9L/3tx4ZDLsWAPferw41oVb+KkP98=
X-Received: by 2002:a05:6102:3c9f:b0:4e6:a338:a41d with SMTP id
 ada2fe7eead31-4e7728e359fmr14855726137.11.1749555021738; Tue, 10 Jun 2025
 04:30:21 -0700 (PDT)
MIME-Version: 1.0
References: <20250602131226.1137281-1-djordje.todorovic@htecgroup.com>
 <20250602131226.1137281-3-djordje.todorovic@htecgroup.com>
In-Reply-To: <20250602131226.1137281-3-djordje.todorovic@htecgroup.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 10 Jun 2025 21:29:53 +1000
X-Gm-Features: AX0GCFtII4fFzfuaZ6sVxEkCY7lG4mmNZyQnoY_YjzyTASf7BDtN_zLNU04W4Kc
Message-ID: <CAKmqyKMW_avMGtQ73oRLKt_3VjpHDknH_KsRAt0jrmT0Qfkm-A@mail.gmail.com>
Subject: Re: [PATCH v2 2/9] target/riscv: Add cpu_set_exception_base
To: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, 
 "cfu@mips.com" <cfu@mips.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92c;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92c.google.com
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

On Mon, Jun 2, 2025 at 11:15=E2=80=AFPM Djordje Todorovic
<Djordje.Todorovic@htecgroup.com> wrote:
>
> Add a new function, so we can change reset vector from platforms.

You can use the "resetvec" property instead, there are a range of
RISC-V machines already doing this. Have a look at
hw/riscv/opentitan.c or hw/riscv/sifive_u.c for examples

Alistair

>
> Signed-off-by: Chao-ying Fu <cfu@mips.com>
> Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
> ---
>  target/riscv/cpu.h       | 2 ++
>  target/riscv/translate.c | 8 ++++++++
>  2 files changed, 10 insertions(+)
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 229ade9ed9..c0e048a66d 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -656,6 +656,8 @@ G_NORETURN void riscv_raise_exception(CPURISCVState *=
env,
>  target_ulong riscv_cpu_get_fflags(CPURISCVState *env);
>  void riscv_cpu_set_fflags(CPURISCVState *env, target_ulong);
>
> +void cpu_set_exception_base(int vp_index, target_ulong address);
> +
>  FIELD(TB_FLAGS, MEM_IDX, 0, 3)
>  FIELD(TB_FLAGS, FS, 3, 2)
>  /* Vector flags */
> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> index d7a6de02df..2cba1a26a7 100644
> --- a/target/riscv/translate.c
> +++ b/target/riscv/translate.c
> @@ -1427,3 +1427,11 @@ void riscv_translate_init(void)
>      load_val =3D tcg_global_mem_new(tcg_env, offsetof(CPURISCVState, loa=
d_val),
>                               "load_val");
>  }
> +
> +void cpu_set_exception_base(int vp_index, target_ulong address)
> +{
> +#ifndef CONFIG_USER_ONLY
> +    RISCVCPU *vp =3D RISCV_CPU(qemu_get_cpu(vp_index));
> +    vp->env.resetvec =3D address;
> +#endif
> +}
> --
> 2.34.1
>

