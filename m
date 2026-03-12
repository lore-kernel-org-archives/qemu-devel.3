Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8619D103E2F5
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 00:28:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0Tun-00029T-SM; Wed, 11 Mar 2026 20:28:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w0Tuf-00020h-0U
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 20:28:30 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w0Tud-0002fL-5h
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 20:28:28 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-6611d20c026so593339a12.1
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 17:28:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773275304; cv=none;
 d=google.com; s=arc-20240605;
 b=MMOQm04jreyNglSX64BOS/VzKSPjC8fzDpR0ZA01DRTrXRq0fR+mE1z2OYUd4pnpeI
 3xLnPSx+YrcxPrnvEqzyL6Ylqw6TMvnTrzUS+bK5E3jgL2aO1fv/4q4EW5a7XaiiFEkH
 FSk1RN9d8Zf400yExDPH91EsFEuQ01IqT2VXy5p1/XuSKYA/QyPKNQ/f0X59RzmNXbiB
 2g0ve836OcCyto+nXv1IJ189R3/k7BTFRs1x1qgb/YvS5/FK0FebIs18FnLdl4scKswk
 yA7uWx4vFzAP3NZJ7kJAIpndPTfU/Vr/8D6GlEeJi2EUKvZhO5rPJ5tymyTut6ASXkA5
 qw9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=3kofmSAKVejnRmBkf1Hd8HejLWhwOqV1RF8NYJPBYeA=;
 fh=02yfZO3MCi97EyXeoLg1BYIgpUdGEMk3Yh61+offrCA=;
 b=Y4+c5ACTR0Rnp8R0VQMasHbvgR+xNJXKU4HObt1XLpHhzncTexT5zxnaE9BRAwBFvu
 cGhvPaiZgNdS0Aof9X5LflYXMO7shXUC1wTnNbMX0dg6x68RTJ8fDYatQMWsJRJLQfc8
 TbkPMnKBl+zjb/tz7QY//eJuy5P0jMiIU8m3TFYHMr54zJfnVACNsHuFHzhz1aIPE9hE
 bMvTdb4rSyYuXaTG7//hUkPnhwDIm5ntpEziPPqqgcLiiFNLt9lKiA+LaUN2NhfZmQum
 FHwcZcov2Zbv6kIjmxUMQwJBw9JraLUZ+IpIMSm8fpLuBbeBdGhnN+5wLlHsWiAxleS/
 y/eA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773275304; x=1773880104; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3kofmSAKVejnRmBkf1Hd8HejLWhwOqV1RF8NYJPBYeA=;
 b=PJ9MG9PB8T1/QogS7PcOWi/c2KrBsX3Bc1RPdj4lupKGEn7KHdPqIwYF16mbRGj7jO
 tKZGj+9P/jMjw6r/42OPHEWQ435eFb11sQmkV7WFVM73+F6oaZLPMRT7xEtoJy74MInH
 SK9rdz+uH2tZcpskRketbwLkUuJrr48KKx+kx0ORVPN+ADND/jEReA3+NA+ePyztVk2K
 tA2X4VLfuO2fEtZXyA+EHmYFNPXTBqThKdRb8u/eGUfAH3bbfgusLeyper/0fBfj3AhH
 g7ziajDbAXMGbTYq2Ld2BZbxTd7opekQJh0062zqPKt+cxaylUKREkwxc6JldBHgLlOK
 wsGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773275304; x=1773880104;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3kofmSAKVejnRmBkf1Hd8HejLWhwOqV1RF8NYJPBYeA=;
 b=cfDGlEQ8avZPZbcMZod0mBxNSuMwx3Cz5stieT8eXpUVlzr4s38eNILNmzHZRcvSxk
 hZcsWA2j3PX+7PuNbA5J6fk3cp8RaWO4dK7TaWQWfJiylCagwYxG9M0IL3QVC19d1AfV
 L4khU8STAma6orHtvwulJtncNt/A/qzGYAxy1rs7sgXFQZcywaiFcLfy+EbpWY6FxBTQ
 wqtjPfTv/nLqzk0rxbbUUCWcLbFz0p8a4MLZ8jngCITSgG0eMBa1HaD+FpB+jd1pSPBO
 wmj/XAbwGbiktVnmRHPXLc2Xidepo8Z0Zpy9NdYFXLrGHDDduR+JwdzgxEZ3E4xo7XQU
 w6Kw==
X-Gm-Message-State: AOJu0YwAiJxRVou1RJF9uB6/HDwUnpUZGGBnlTM3PmmeLav13OFfiFEE
 pzxC31cfymqQh+uEvnZC2FC8/ARu3H72re4UwpU1ZbOAjVRLz+Qxl5AuVYRFIZ10/r+Ygyp+fz3
 lSJ8lY1Qm61GTelN84IVOjdViYjpx31jr6xWZvEg=
X-Gm-Gg: ATEYQzxuO4gWvVRNSOB/uemTkMCES5ed/YHjqIexSo8+gdE8mKg48CEqR07chk69P4E
 BUDFORVfZ+HmQA09PQyOhhs+9NxIZHtTdhVzifbfcmeExjao7NYngqez8n/401lu0toMbTOeMqD
 pGvRR8F9e5StQViLuWP086mW6lHV+7Eocf4YPQXontT3Ene4e8M1XDkOA8k2MUNNtaAffzmQl+r
 rMgyXxLqBO2yJXXrjdFLw9hF5SToWYPo9NhcnDEfX+hPMp68f6MavRmn+YRTNrRHPXkIEo+YuFl
 VgMqIYbqXZv3oHSGJr1MqF1DtPteAIew4u+CUg==
X-Received: by 2002:a05:6402:520b:b0:661:5890:6dc9 with SMTP id
 4fb4d7f45d1cf-6631aaccb2cmr2384207a12.32.1773275304384; Wed, 11 Mar 2026
 17:28:24 -0700 (PDT)
MIME-Version: 1.0
References: <20260311115910.564481-1-djordje.todorovic@htecgroup.com>
 <20260311115910.564481-3-djordje.todorovic@htecgroup.com>
In-Reply-To: <20260311115910.564481-3-djordje.todorovic@htecgroup.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 12 Mar 2026 10:27:58 +1000
X-Gm-Features: AaiRm518b68C_FxZkAC1F7ev-1KNVQUavVtf294fq9PYd6GpfjoKvBnJaRyYHG0
Message-ID: <CAKmqyKM_bNO36+ZD2yNjUVEFQvxqwEA8NS0hZ5drxfoRmm9UZw@mail.gmail.com>
Subject: Re: [PATCH v3 2/9] target/riscv: Use MO_LE for instruction fetch
To: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, 
 "cfu@mips.com" <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>, 
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>, 
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>,
 "philmd@linaro.org" <philmd@linaro.org>, 
 "thuth@redhat.com" <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x536.google.com
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

On Wed, Mar 11, 2026 at 9:59=E2=80=AFPM Djordje Todorovic
<Djordje.Todorovic@htecgroup.com> wrote:
>
> RISC-V instructions are always little-endian regardless of the data
> endianness mode configured via mstatus SBE/MBE/UBE bits.
>
> Currently, instruction fetches in decode_opc() and the page boundary
> check use mo_endian(ctx), which returns MO_TE. This happens to work
> today because RISC-V targets are little-endian only, but is
> semantically incorrect and will break once mo_endian() is updated to
> respect runtime data endianness for big-endian support.
>
> Use MO_LE explicitly for all instruction fetch paths. Data memory
> operations (AMOs, loads/stores via mxl_memop) continue to use
> mo_endian(ctx) as they should respect the configured data endianness.

Missing Signed-off-by

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair


> ---
>  target/riscv/translate.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> index cb4f443601..413911f7f9 100644
> --- a/target/riscv/translate.c
> +++ b/target/riscv/translate.c
> @@ -1255,7 +1255,7 @@ static void decode_opc(CPURISCVState *env, DisasCon=
text *ctx)
>           * additional page fault.
>           */
>          opcode =3D translator_ldl_end(env, &ctx->base, ctx->base.pc_next=
,
> -                                    mo_endian(ctx));
> +                                    MO_LE);
>      } else {
>          /*
>           * For unaligned pc, instruction preload may trigger additional
> @@ -1263,7 +1263,7 @@ static void decode_opc(CPURISCVState *env, DisasCon=
text *ctx)
>           */
>          opcode =3D (uint32_t) translator_lduw_end(env, &ctx->base,
>                                                  ctx->base.pc_next,
> -                                                mo_endian(ctx));
> +                                                MO_LE);
>      }
>      ctx->ol =3D ctx->xl;
>
> @@ -1285,7 +1285,7 @@ static void decode_opc(CPURISCVState *env, DisasCon=
text *ctx)
>              opcode =3D deposit32(opcode, 16, 16,
>                                 translator_lduw_end(env, &ctx->base,
>                                                     ctx->base.pc_next + 2=
,
> -                                                   mo_endian(ctx)));
> +                                                   MO_LE));
>          }
>          ctx->opcode =3D opcode;
>
> @@ -1401,7 +1401,7 @@ static void riscv_tr_translate_insn(DisasContextBas=
e *dcbase, CPUState *cpu)
>              if (page_ofs > TARGET_PAGE_SIZE - MAX_INSN_LEN) {
>                  uint16_t next_insn =3D
>                      translator_lduw_end(env, &ctx->base, ctx->base.pc_ne=
xt,
> -                                        mo_endian(ctx));
> +                                        MO_LE);
>                  int len =3D insn_len(next_insn);
>
>                  if (!translator_is_same_page(&ctx->base, ctx->base.pc_ne=
xt + len - 1)) {
> --
> 2.34.1

