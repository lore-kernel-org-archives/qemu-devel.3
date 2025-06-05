Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A52DCC61DB8
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 04:23:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uN27G-0004OS-Q7; Thu, 05 Jun 2025 00:22:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uN27E-0004Np-Tn; Thu, 05 Jun 2025 00:22:09 -0400
Received: from mail-ua1-x935.google.com ([2607:f8b0:4864:20::935])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uN27C-0003Xr-U5; Thu, 05 Jun 2025 00:22:08 -0400
Received: by mail-ua1-x935.google.com with SMTP id
 a1e0cc1a2514c-87ea6361feeso183770241.3; 
 Wed, 04 Jun 2025 21:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749097325; x=1749702125; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sibqm5Y47hMcrQiWaTMqQo7CiZui8P4lp3R71v2KIpg=;
 b=ELP13NKN/+/5Klds50ignt4zwYe64cQGcfXvtkuGEmqRDziY21IG1OSzDO0FqruEZz
 2SVcnccMkKvKC8PvZiVIUFIsTdNe0e7uMNOsmbyM9s7CtXCuhi2oPnQ0pPeF9+sqtzBg
 GkMTULTYpUjk7kZBJX3SXh51ETHAOZHyObkFX9SKWPSOPMmUSKI1tGiVFahOju3FPoea
 AnmkuqQbDOH2hOhpn+cN7chsmkNLxJAj6Ytsw66d82VGEY5pLy6+UJITvWHpmj8ls0zo
 m8jpDOLvAnX3OQLAOgv9QZ18ELXI2A6AzU9sFKZWlGAna31d3MjPIQ/YUaMOalgv4ffM
 K8yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749097325; x=1749702125;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sibqm5Y47hMcrQiWaTMqQo7CiZui8P4lp3R71v2KIpg=;
 b=MTrsk9Zqo0C51HZpYoIIGburdz1g7HE8G7EqrHnWUfslohZB7cnV6PXucOjlGl4INI
 O01hFtpKwkQ1B0liXEN6PHK9uKs7wEC8sLwNWdPAVxC7GdRvQcWXvezBTwC6bRPFZL+q
 h0/lSt4B3AFk7RarXUY1bOq5WP8iR/wnaoWJ7GxshanIQ99QPHN/wK4NUixd6AJoARez
 u9As8KOh1sIQHnMZBSDwjv9Xk9tUntO642KR0oA/5KEK0l1aqC6MoaCjFtzmmEVABajc
 7skFyRl8PbBWYk0Jbh3FqTAgbw5XAQA85nvjHqbVrYI09EdpmFod9YpTugNcemUglR0V
 7RMA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW0agqQuWbMNU52ZsXsDUXqIYxJ9GdBs1YX2E9lDQ4o9Y0VvordM/4+ZRzTFKvfB+PTwuNgR7sEtdLS@nongnu.org
X-Gm-Message-State: AOJu0YygFaZxQ0wwvqcA2X0jBvXNn3R+f0L4D1lmp0hWZo3MjjgoDwzM
 U+YHFsP3/rnurQSvgKtr2bI2KCbgAFXuxd1vyNPv/2Smj5Ur4m2iVvvNUL2qnYf9cpvA9FFiDGp
 VtTai3KpB0YzTpFmkJmzWiU3tMogBQNU=
X-Gm-Gg: ASbGnctNKq0FYw2c9tvYYeKxrgCMRnnFemc1yX9xH5+lKBLt9f/m1tMBU89KBj/u7yJ
 8szHkcSrxn9TQrtta9L1ELF6eBajp9mEXinJp9zEDuHjStyHh8/jYdM+uOwPRg51AYIt/zlMzlV
 gWzOitjxKWmR6AC2mzuv8obLv2UqxNBP5r/6Dc2sY/0Y8a8YTEIC2Sx/65naZLyh4=
X-Google-Smtp-Source: AGHT+IFfG/GUGWa49Kr+3fpmHFr8ujQmRh1xtuSi+Z9eTr/ROdzrMkAdw4xpdpdnJNQU71NPjy3eND0tYlBLpnc66wY=
X-Received: by 2002:a05:6102:3c8e:b0:4e1:52fa:748d with SMTP id
 ada2fe7eead31-4e746de0982mr4740183137.15.1749097325112; Wed, 04 Jun 2025
 21:22:05 -0700 (PDT)
MIME-Version: 1.0
References: <20250508094838.19394-1-jim.shu@sifive.com>
In-Reply-To: <20250508094838.19394-1-jim.shu@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 5 Jun 2025 14:21:38 +1000
X-Gm-Features: AX0GCFu_Z9QcqosB5eu325pLp-aLvI8DWrvK5qPXahas4Syls2PejG49Jlx0YMs
Message-ID: <CAKmqyKMr+2anHt8ff0f0NfrrNs5z+7TEhXwj_oQPHqiA_XnX0A@mail.gmail.com>
Subject: Re: [PATCH v2] target/riscv: support atomic instruction fetch (Ziccif)
To: Jim Shu <jim.shu@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::935;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x935.google.com
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

On Thu, May 8, 2025 at 7:49=E2=80=AFPM Jim Shu <jim.shu@sifive.com> wrote:
>
> Support 4-byte atomic instruction fetch when instruction is natural
> aligned.
>
> Current implementation is not atomic because it loads instruction twice
> for first and last 2 bytes. We load 4 bytes at once to keep the
> atomicity. This instruction preload method only applys when instruction
> is 4-byte aligned. If instruction is unaligned, it could be across pages
> so that preload will trigger additional page fault.
>
> We encounter this issue when doing pressure test of enabling & disabling
> Linux kernel ftrace. Ftrace with kernel preemption requires concurrent
> modification and execution of instruction, so non-atomic instruction
> fetch will cause the race condition. We may fetch the wrong instruction
> which is the mixing of 2 instructions.
>
> Also, RISC-V Profile wants to provide this feature by HW. RVA20U64
> Ziccif protects the atomicity of instruction fetch when it is
> natural aligned.
>
> This commit depends on the atomic read support of translator_ld in
> the commit 6a9dfe1984b0c593fb0ddb52d4e70832e6201dd6.
>
> Signed-off-by: Jim Shu <jim.shu@sifive.com>
> Reviewed-by: Frank Chang <frank.chang@sifive.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/translate.c | 46 +++++++++++++++++++++++++++++-----------
>  1 file changed, 34 insertions(+), 12 deletions(-)
>
> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> index 85128f997b..77edf04803 100644
> --- a/target/riscv/translate.c
> +++ b/target/riscv/translate.c
> @@ -1222,13 +1222,35 @@ const RISCVDecoder decoder_table[] =3D {
>
>  const size_t decoder_table_size =3D ARRAY_SIZE(decoder_table);
>
> -static void decode_opc(CPURISCVState *env, DisasContext *ctx, uint16_t o=
pcode)
> +static void decode_opc(CPURISCVState *env, DisasContext *ctx)
>  {
> +    uint32_t opcode;
> +    bool pc_is_4byte_align =3D ((ctx->base.pc_next % 4) =3D=3D 0);
> +
>      ctx->virt_inst_excp =3D false;
> -    ctx->cur_insn_len =3D insn_len(opcode);
> +    if (pc_is_4byte_align) {
> +        /*
> +         * Load 4 bytes at once to make instruction fetch atomically.
> +         *
> +         * Note: When pc is 4-byte aligned, 4-byte instruction wouldn't =
be
> +         * across pages. We could preload 4 bytes instruction no matter
> +         * real one is 2 or 4 bytes. Instruction preload wouldn't trigge=
r
> +         * additional page fault.
> +         */
> +        opcode =3D translator_ldl(env, &ctx->base, ctx->base.pc_next);
> +    } else {
> +        /*
> +         * For unaligned pc, instruction preload may trigger additional
> +         * page fault so we only load 2 bytes here.
> +         */
> +        opcode =3D (uint32_t) translator_lduw(env, &ctx->base, ctx->base=
.pc_next);
> +    }
> +    ctx->ol =3D ctx->xl;
> +
> +    ctx->cur_insn_len =3D insn_len((uint16_t)opcode);
>      /* Check for compressed insn */
>      if (ctx->cur_insn_len =3D=3D 2) {
> -        ctx->opcode =3D opcode;
> +        ctx->opcode =3D (uint16_t)opcode;
>          /*
>           * The Zca extension is added as way to refer to instructions in=
 the C
>           * extension that do not include the floating-point loads and st=
ores
> @@ -1238,15 +1260,17 @@ static void decode_opc(CPURISCVState *env, DisasC=
ontext *ctx, uint16_t opcode)
>              return;
>          }
>      } else {
> -        uint32_t opcode32 =3D opcode;
> -        opcode32 =3D deposit32(opcode32, 16, 16,
> -                             translator_lduw(env, &ctx->base,
> -                                             ctx->base.pc_next + 2));
> -        ctx->opcode =3D opcode32;
> +        if (!pc_is_4byte_align) {
> +            /* Load last 2 bytes of instruction here */
> +            opcode =3D deposit32(opcode, 16, 16,
> +                               translator_lduw(env, &ctx->base,
> +                                               ctx->base.pc_next + 2));
> +        }
> +        ctx->opcode =3D opcode;
>
>          for (guint i =3D 0; i < ctx->decoders->len; ++i) {
>              riscv_cpu_decode_fn func =3D g_ptr_array_index(ctx->decoders=
, i);
> -            if (func(ctx, opcode32)) {
> +            if (func(ctx, opcode)) {
>                  return;
>              }
>          }
> @@ -1324,10 +1348,8 @@ static void riscv_tr_translate_insn(DisasContextBa=
se *dcbase, CPUState *cpu)
>  {
>      DisasContext *ctx =3D container_of(dcbase, DisasContext, base);
>      CPURISCVState *env =3D cpu_env(cpu);
> -    uint16_t opcode16 =3D translator_lduw(env, &ctx->base, ctx->base.pc_=
next);
>
> -    ctx->ol =3D ctx->xl;
> -    decode_opc(env, ctx, opcode16);
> +    decode_opc(env, ctx);
>      ctx->base.pc_next +=3D ctx->cur_insn_len;
>
>      /*
> --
> 2.17.1
>
>

