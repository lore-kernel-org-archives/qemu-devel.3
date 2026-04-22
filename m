Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AF0FF94CB8
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 00:02:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFL3H-0002Ku-OO; Tue, 21 Apr 2026 20:02:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wFL3G-0002Jl-3g
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 20:02:46 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wFL3E-0003af-Ge
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 20:02:45 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-b93698bb57aso891066266b.0
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2026 17:02:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776816163; cv=none;
 d=google.com; s=arc-20240605;
 b=ZX1mrk3NWOymnzGHf9cxf3zs7bPcUzQ7zRDZjPgXzVA2LmKRDmTvZo+5WQn56h9bfU
 Cr/w1Be5l3f0qvB7cW0VFjsJbWOnEAf+SzjDlp0cVWMGAflzXRzWoGTGLUdDK2aowVSe
 ERT2b83mVeXe7rsV5mwTVDHzrHyRtcUzxrTBUN0luhHIq1/uVmK6Dadz8rX4ywX4RnnS
 guZ+QJUUcqdikgfB7CHjIBOpDlp6paYFOtUy/bVjC1LtC0TFOXU2bV+nKpF03MlpJkF9
 cGgQgO8mEGdyGlatdMWCzr6e3nsArzBmEwNOCD1NyPBam0af/X61PEqgxRY62Y8WhIhc
 XoUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=hkYSnOg93MF7SWxRim7M54Pz/+4YU0wgnoBCdLocUGI=;
 fh=9ZBm7Jeorp9wSVPYF5AiPBCRDB4kcVwmpribd+uGcX8=;
 b=eV61E6XHJEdi8iAhER6A5uzBFDkBGnC+VVQpPcux0ktdmS6dwvT3vf5AbfZOSCA14p
 w34sWB6wuQdM5U119OVFNsWQ2Wd4iztmcOXMJ8B5AxZgBAe5kPpDMWPYMNWp1aZPl1Dc
 xByHBuOVdZOHIOltrqzXKgWU7Mu8Uj/3BEiSxQI1iuf9PNBcsNLcjEfv3knRGCUbJm2l
 mNXz20LIZ1zBUEj3micMh6P9qr+iX4TRo1xOvrOHpsEsi5fRCwFHL88m6WJ4bVccJG6G
 BeyR3l3ya4geGsz+5i4VDF8/aRAYUZK4pqMw27UB5LdLSjTcQIuFZJgq+Ux+PqhXn8E4
 QXHw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776816163; x=1777420963; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hkYSnOg93MF7SWxRim7M54Pz/+4YU0wgnoBCdLocUGI=;
 b=rEYJBzR8CWGbSsQ4BFDzyWGvOCJ1y14D9n0Wf0KzWtswIdpD3YmpVYW0r7vKTSEo+q
 8v1HVDKhnpg04aaZQws8ZXq+IFFyPoi1OAEWn+0NGUwtkmemGYilgAMrr/Hl13Fk28bk
 TuaTjwu1S1wA12XsumZj79LjwZMlm9ygrl2OWrYSqId9muxHgRp+kBpdWsDeiNb9O/sC
 2CefUe6wOwWQm48HxQDkzxPc3xmeCRFz6ewY3RXIq8kwxjycl4ckX7elW2fLA5dJtSCn
 QDSsCQGu8LqzC9An/+TtI9VzrHNkd5JpJ1cqInXfzUEc90cgcZm5j7FHlqoBJI6Qufjh
 T2IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776816163; x=1777420963;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hkYSnOg93MF7SWxRim7M54Pz/+4YU0wgnoBCdLocUGI=;
 b=rBGW34WzygoM5CeDI099PvUGaMa7MXBr6LMK+J8TYpIurnckDvLMk2mTeM+OoE/c2j
 yFL45NpbnwvkPnXRSPsWcFRfi4TiQt757qyz/Zo1ZgYFXLyOr2QCOaZ6cZf4OsrKifxu
 7pIMv67HFzErLnWAwtyC0RFGyW9DPfXf9kVLCVW0Fp0CJlToUoBls6zY7a3xlOjP7su0
 KDLgF51+dvNN5uPY1xuX41wqTrOJcUyutcXdMRmXdHqWiPolehInxyWbi5VcMVrowCQt
 YwL06QMiqLASGx1MAZUTRbPoBfItkbEIsZjCIB3yFFWmoPmIBZPV+iesg126YzKgCvRd
 efEQ==
X-Gm-Message-State: AOJu0YzN3voosd95CSdabCPhiMEqYcTyL8OWTOb1ikOMwf7kOXMYUU50
 ubkltZ5p55hzK+PxAOH9dQwo3RCjXMZ2SSE8aKYzRgk6YuIUielfO0UzPp38S++NsuO+xJqtyl4
 fkZ2vfAdwM+023UgJ0BFZA/7f8r8mijY=
X-Gm-Gg: AeBDiet5iAlHBl4H0qocTxCvgfsbVG1fXu0/Fm0hGC4RDjL4ZBiAMA1gNC7JsJv+COG
 8MVtiBU90LmlxIGmr148Wob2bhYuur0ZkWk7Tlb32Affunm2rzBS1YXW5kYVEtbDL9bHv3s45gQ
 aAvWyzqdzxG9TKLNi47Onke792YxD39zvE/CxPeTpoWEFkecp5NUbRZfSkMAPvTCtqPhApK1IBn
 6BOlJSZFrFWR1OwF2tQcba9+1h+SoCPBqK4AjsfmMVFyMQAyc53zMPBf0hqu598PAsbSsItu4xD
 TUkNwxgbjDlv0ugDzBdC6jszxzb6p8NjPZ316JyXwuQVNBUB
X-Received: by 2002:a17:907:9341:b0:b9e:503:5923 with SMTP id
 a640c23a62f3a-ba4229dc662mr725632666b.30.1776816162680; Tue, 21 Apr 2026
 17:02:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260421075906.2928317-1-frank.chang@sifive.com>
 <20260421075906.2928317-2-frank.chang@sifive.com>
In-Reply-To: <20260421075906.2928317-2-frank.chang@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 22 Apr 2026 10:02:16 +1000
X-Gm-Features: AQROBzBR2RFrYw_T6oGvl6s6mSLSFhmRhMkoWuHVc1cDiemiXDiWixqdb_EALoo
Message-ID: <CAKmqyKMgOdADSQzuooxx8nKFdXrX9omL2Wsp5ndZzhrRXWoE+Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] target/riscv: Update MISA.C for Zc* extensions
To: frank.chang@sifive.com
Cc: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu.zevorn@gmail.com>, 
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>,
 Max Chou <max.chou@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x62f.google.com
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

On Tue, Apr 21, 2026 at 6:01=E2=80=AFPM <frank.chang@sifive.com> wrote:
>
> From: Frank Chang <frank.chang@sifive.com>
>
> MISA.C is set if the following extensions are selected:
>   * Zca and not F.
>   * Zca, Zcf and F (but not D) is specified (RV32 only).
>   * Zca, Zcf and Zcd if D is specified (RV32 only).
>   * Zca, Zcd if D is specified (RV64 only).
>
> Therefore, we need to set MISA.C according to the rules for Zc*
> extensions.
>
> Signed-off-by: Frank Chang <frank.chang@sifive.com>
> Reviewed-by: Max Chou <max.chou@sifive.com>
> ---
>  target/riscv/tcg/tcg-cpu.c | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index f3f78088956..0f68560bac1 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -1163,6 +1163,37 @@ static void riscv_cpu_enable_implied_rules(RISCVCP=
U *cpu)
>      }
>  }
>
> +/*
> + * MISA.C is set if the following extensions are selected:
> + *   - Zca and not F.
> + *   - Zca, Zcf and F (but not D) is specified on RV32.
> + *   - Zca, Zcf and Zcd if D is specified on RV32.
> + *   - Zca, Zcd if D is specified on RV64.
> + */
> +static void riscv_cpu_update_misa_c(RISCVCPU *cpu)
> +{
> +    CPURISCVState *env =3D &cpu->env;
> +
> +    if (cpu->cfg.ext_zca && !riscv_has_ext(env, RVF)) {
> +        riscv_cpu_set_misa_ext(env, env->misa_ext | RVC);
> +        return;
> +    }
> +
> +    if (riscv_cpu_mxl(env) =3D=3D MXL_RV32 &&
> +        cpu->cfg.ext_zca && cpu->cfg.ext_zcf &&
> +        (riscv_has_ext(env, RVD) ? cpu->cfg.ext_zcd :
> +                                   riscv_has_ext(env, RVF))) {
> +        riscv_cpu_set_misa_ext(env, env->misa_ext | RVC);
> +        return;
> +    }
> +
> +    if (riscv_cpu_mxl(env) =3D=3D MXL_RV64 &&
> +        cpu->cfg.ext_zca && cpu->cfg.ext_zcd) {
> +        riscv_cpu_set_misa_ext(env, env->misa_ext | RVC);
> +        return;
> +    }
> +}
> +
>  void riscv_tcg_cpu_finalize_features(RISCVCPU *cpu, Error **errp)
>  {
>      CPURISCVState *env =3D &cpu->env;
> @@ -1170,6 +1201,7 @@ void riscv_tcg_cpu_finalize_features(RISCVCPU *cpu,=
 Error **errp)
>
>      riscv_cpu_init_implied_exts_rules();
>      riscv_cpu_enable_implied_rules(cpu);
> +    riscv_cpu_update_misa_c(cpu);

What happens if a user has disabled C?

Alistair

>
>      riscv_cpu_validate_misa_priv(env, &local_err);
>      if (local_err !=3D NULL) {
> --
> 2.43.0
>
>

