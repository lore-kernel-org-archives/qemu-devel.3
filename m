Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A30EC47DB3
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 00:41:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUcBU-0000yV-ML; Mon, 29 Jan 2024 19:41:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rUcB5-0000jX-07
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 19:40:42 -0500
Received: from mail-ua1-x92d.google.com ([2607:f8b0:4864:20::92d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rUcB2-00027Q-M8
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 19:40:38 -0500
Received: by mail-ua1-x92d.google.com with SMTP id
 a1e0cc1a2514c-7ce55932330so1049052241.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 16:40:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706575235; x=1707180035; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kUwDKgC0XLtEiNvv3DtQd3Dq8ffozL4Eax/QpX2aGWc=;
 b=C6Rgl8CocKcqY8sFOywKFMY325fiEn4/8EBqBiUeYq1gSnluAi/ZZjLcYcZ99GrufG
 eejk9e8CdWSCOe0kliRQfq8gjbEj3nxm0XKM7+b6ODGrlRxcgwOmWjur0C1QBu/jv47B
 NkR2tNCdtz/bVoW7BHX45B9K45dBxPQf+501Bt1uKfhexGhbob8XwTL51F9dBSlEe0TW
 9vkXZpU1bkRurOh7PjGolF8Dn8YDWFO9qnRz33fwtqLsnEXJtsoMpcQDEWiSg5Jq0bHK
 rBPxmpXvtPZPjUmPqBVYq15T1OuNPX3QGjoUcx/tuU+9WmrbPDB/o/ztAjNtHvR8Vp+o
 L0dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706575235; x=1707180035;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kUwDKgC0XLtEiNvv3DtQd3Dq8ffozL4Eax/QpX2aGWc=;
 b=UQ31NpZVPn6WDcWeqbRzKYcEXUQxhf9hJJQPUS3UOu8XBvMkOvS2QfKQEs5mLFxUaI
 cOgz5VsJJf9NFJ8fBc/wv8Tm02arIcVTU6O6TLTQrXdoqT5txluN9q5+c0f/0ObihijY
 wmSzH4L/FQtoPcKu8Eb3oeQd+ClE3ZFuj2/w4vrVmd1yGIX6Z3q7L2AwetdjUau0jUeb
 Fn6m4XhMeiUyJuv9siKrSALMKl4HFHAYnT3lqXGyFSCFaaq29t4f6nwXxrvjYitaTWUE
 LbfqVe13A3WmB2HZlDmqZle8ZM0YJwDL3S/3CucDk0PNVsHAgq9OznaT7KX29O3CM/9i
 bGYg==
X-Gm-Message-State: AOJu0Yz7S2kSj6I4Ce2MTrrz8Y9TWnlET/mXcXCnpIM+ft3KxNLyuL4w
 o6YvWyrXb5IyRhj6qg9AG1W0va5xjW7v9gB30M96Eify3GO2RG4K/xruXo2R0w4q9FfnsFzoHjR
 pUAObpCSjM7MpqxuWGU+LNt3Cru0=
X-Google-Smtp-Source: AGHT+IGextyoATUpHSRBtuCFd2bKWaD6fnJExDS0XAP1siFKqV6+pEqvbmdnny/rnvLJams7K14M2CtaGFnUccZAA1Q=
X-Received: by 2002:a05:6102:1884:b0:46b:3e04:19d4 with SMTP id
 ji4-20020a056102188400b0046b3e0419d4mr2474776vsb.29.1706575234837; Mon, 29
 Jan 2024 16:40:34 -0800 (PST)
MIME-Version: 1.0
References: <20240129233043.34558-1-richard.henderson@linaro.org>
 <20240129233043.34558-23-richard.henderson@linaro.org>
In-Reply-To: <20240129233043.34558-23-richard.henderson@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 30 Jan 2024 10:40:08 +1000
Message-ID: <CAKmqyKOm74JMuh26ExB-4e4vcb0qR2W53eGM8v--KO-mmD_WsQ@mail.gmail.com>
Subject: Re: [PATCH 22/33] target/riscv: Rename riscv_cpu_mmu_index to
 riscv_env_mmu_index
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, anjo@rev.ng
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92d;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, Jan 30, 2024 at 9:39=E2=80=AFAM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Free up the riscv_cpu_mmu_index name for other usage;
> emphasize that the argument is 'env'.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.h        | 4 ++--
>  target/riscv/cpu_helper.c | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 5f3955c38d..9c825c7b51 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -498,7 +498,7 @@ target_ulong riscv_cpu_get_geilen(CPURISCVState *env)=
;
>  void riscv_cpu_set_geilen(CPURISCVState *env, target_ulong geilen);
>  bool riscv_cpu_vector_enabled(CPURISCVState *env);
>  void riscv_cpu_set_virt_enabled(CPURISCVState *env, bool enable);
> -int riscv_cpu_mmu_index(CPURISCVState *env, bool ifetch);
> +int riscv_env_mmu_index(CPURISCVState *env, bool ifetch);
>  G_NORETURN void  riscv_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
>                                                 MMUAccessType access_type=
,
>                                                 int mmu_idx, uintptr_t re=
taddr);
> @@ -507,7 +507,7 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, =
int size,
>                          bool probe, uintptr_t retaddr);
>  char *riscv_isa_string(RISCVCPU *cpu);
>
> -#define cpu_mmu_index riscv_cpu_mmu_index
> +#define cpu_mmu_index riscv_env_mmu_index
>
>  #ifndef CONFIG_USER_ONLY
>  void riscv_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index c7cc7eb423..15f87ecdb0 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -33,7 +33,7 @@
>  #include "debug.h"
>  #include "tcg/oversized-guest.h"
>
> -int riscv_cpu_mmu_index(CPURISCVState *env, bool ifetch)
> +int riscv_env_mmu_index(CPURISCVState *env, bool ifetch)
>  {
>  #ifdef CONFIG_USER_ONLY
>      return 0;
> --
> 2.34.1
>
>

