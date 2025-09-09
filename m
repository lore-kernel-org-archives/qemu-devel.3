Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41681CAC582
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Sep 2025 17:19:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uw1zA-0002nU-LT; Tue, 09 Sep 2025 13:18:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uw1z4-0002mq-AW
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 13:18:23 -0400
Received: from mail-yb1-xb31.google.com ([2607:f8b0:4864:20::b31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uw1ys-0002O9-Dq
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 13:18:20 -0400
Received: by mail-yb1-xb31.google.com with SMTP id
 3f1490d57ef6-e98a18faa35so5902905276.0
 for <qemu-devel@nongnu.org>; Tue, 09 Sep 2025 10:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757438287; x=1758043087; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hVf57Exq+i4MX6DWLzMNdWHsuJ/gzLw7JVgON5poEIM=;
 b=Jeyny8CB975PGSyl8AUiufrXO+Cea72fyh8dOXPU/lNiCI2c13OyaOvz1ZKkt17aWi
 oeYx3szKNdkWLGHTtUv/ykOCOUSjAqs5pD9E3dT+ex3wyxDiPMTamO1v2JHB1LGXjWFA
 cpMtV7e9tX1F6rlOPlxMD57n9xU/pS3UxmWoKHzdCJVktYcEMPg7X08EpVmajSxUvYz5
 Ly52dn0l5FUoMQ1/dE31WkkOSxcej0Vh53d0KD+eN1bZLNk2h0o+cI2qr9eZbagNR5kQ
 1woa/K3LhTxg8lD2rXBaqfpCQDoED395dImeoLFJlN2eNcVGBSEpaoP9TcHGknOQeAUJ
 TV4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757438287; x=1758043087;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hVf57Exq+i4MX6DWLzMNdWHsuJ/gzLw7JVgON5poEIM=;
 b=GAQGH3Smq0ZHTJgdEgQdzrjTCZ4NDgqLuVV31o+BNXoozj0II/6jAcSk6tewWNh8Je
 RH61X8/CoHQu7/TGDzJw6kELJ9bCOgy6HEbD3e2cy92RQoI37I8LmaEe4whtvVDcIP+T
 R4D8dQsWwCPMIH5ScYjceskwxdjAoUqFVqC2QXVkRhPr5w5lvHjCmXXQpo53U9p+fxiC
 EdvLJ+NX2AqYQZkoHpcOtLqPwhsg9ChTNB15MhmI4Uo25b6ViQVynZpyOhdEACQNsJGG
 0/ijpIrntC+TvzCIx7lnFY6MZYWSfyxr837PdUlLYNAFEx+Scon7mkMR13A14lU4XVn3
 EZUg==
X-Gm-Message-State: AOJu0YyeVgz3GkinP7wLOUfXyrp4mAPhj0vGbmuE5rl2Vmb6dCPVmP42
 ogwSuxzXM5iKQpXpA+mxmg5V5vV2LiZNiAPB8aGjWKpGSDc6DvUIYAyAa13D+Ys/Z6K8Zigl6FR
 7yfac+iK5B4KzNyv3rq7Tm7/6hx6WqEAw6Ujsh/9nwQ==
X-Gm-Gg: ASbGnct9hjkWlxB//zA5bgHO8m/3iPD+8MbEucez0S5ocPvkpzwZFqsk84ZKCU/fZrl
 N2tFQfqqbFCPXJL8DEveZE7gtb7G5z79kkguPeOnhopWY7clEZJ9D0tHXe9fYFEU2ObpbY48Trn
 WCCLDkAymvs7ZUuht4pTO5LAgnbautZStReTCQ6uENIIHu9d274LlVl+1V1sxyFIpNXvLvOjcu7
 IlX77WD
X-Google-Smtp-Source: AGHT+IEkWM+2KJjaGQfSaCLWvx38j9fN+VflawMcdyzyHOoi6EFStnYQi3TGfns7h5BnR2kDSP/96t+bH9icZi6zAIw=
X-Received: by 2002:a05:690e:4308:b0:603:512c:c641 with SMTP id
 956f58d0204a3-610223a823amr7024498d50.3.1757438287082; Tue, 09 Sep 2025
 10:18:07 -0700 (PDT)
MIME-Version: 1.0
References: <20250830054128.448363-1-richard.henderson@linaro.org>
 <20250830054128.448363-69-richard.henderson@linaro.org>
In-Reply-To: <20250830054128.448363-69-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Sep 2025 18:17:55 +0100
X-Gm-Features: Ac12FXxR9xHlreh87jX9JLHyvciiWNvMnGC15MtJnv8r_o6rOZEJcBDQKoYzKl0
Message-ID: <CAFEAcA-X-=f=6XTjzMRna9i2Rt+qDDzKSfO4J1kRyVVGJb8B4w@mail.gmail.com>
Subject: Re: [PATCH v4 68/84] target/arm: Add gcs record for BLR with PAuth
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b31;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb31.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On Sat, 30 Aug 2025 at 18:04, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/translate-a64.c | 31 ++++++++++++++++---------------
>  1 file changed, 16 insertions(+), 15 deletions(-)
>
> diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
> index 8230ac0fab..20e18687d5 100644
> --- a/target/arm/tcg/translate-a64.c
> +++ b/target/arm/tcg/translate-a64.c
> @@ -1842,20 +1842,20 @@ static bool trans_BRAZ(DisasContext *s, arg_braz *a)
>
>  static bool trans_BLRAZ(DisasContext *s, arg_braz *a)
>  {
> -    TCGv_i64 dst, lr;
> +    TCGv_i64 dst, link;
>
>      if (!dc_isar_feature(aa64_pauth, s)) {
>          return false;
>      }
> -
>      dst = auth_branch_target(s, cpu_reg(s, a->rn), tcg_constant_i64(0), !a->m);

auth_branch_target() can return its 'dst' argument
directly if pauth is disabled...

> -    lr = cpu_reg(s, 30);
> -    if (dst == lr) {

...which is why we had this check for dst and lr being
the same thing. Now we don't, but...

> -        TCGv_i64 tmp = tcg_temp_new_i64();
> -        tcg_gen_mov_i64(tmp, dst);
> -        dst = tmp;
> +
> +    link = tcg_temp_new_i64();
> +    gen_pc_plus_diff(s, link, 4);
> +    if (s->gcs_en) {
> +        gen_add_gcs_record(s, link);
>      }
> -    gen_pc_plus_diff(s, lr, curr_insn_len(s));
> +    tcg_gen_mov_i64(cpu_reg(s, 30), link);

...here we update X30 with the link pointer before we
set the PC from dst, so if Xn is X30 and pauth is
disabled we'll jump to the wrong target, I think.

> +
>      gen_a64_set_pc(s, dst);

We could fix this by (like trans_BLR in the previous patch)
writing the new PC before we write link to X30.

>      set_btype_for_blr(s);
>      s->base.is_jmp = DISAS_JUMP;
> @@ -1892,19 +1892,20 @@ static bool trans_BRA(DisasContext *s, arg_bra *a)
>
>  static bool trans_BLRA(DisasContext *s, arg_bra *a)
>  {
> -    TCGv_i64 dst, lr;
> +    TCGv_i64 dst, link;
>
>      if (!dc_isar_feature(aa64_pauth, s)) {
>          return false;
>      }
>      dst = auth_branch_target(s, cpu_reg(s, a->rn), cpu_reg_sp(s, a->rm), !a->m);
> -    lr = cpu_reg(s, 30);
> -    if (dst == lr) {
> -        TCGv_i64 tmp = tcg_temp_new_i64();
> -        tcg_gen_mov_i64(tmp, dst);
> -        dst = tmp;
> +
> +    link = tcg_temp_new_i64();
> +    gen_pc_plus_diff(s, link, 4);
> +    if (s->gcs_en) {
> +        gen_add_gcs_record(s, link);
>      }
> -    gen_pc_plus_diff(s, lr, curr_insn_len(s));
> +    tcg_gen_mov_i64(cpu_reg(s, 30), link);
> +
>      gen_a64_set_pc(s, dst);

Similarly here.

>      set_btype_for_blr(s);
>      s->base.is_jmp = DISAS_JUMP;
> --

thanks
-- PMM

