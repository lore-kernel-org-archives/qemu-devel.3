Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CFC1CCD184
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 03:38:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8sJv-0006Rm-FM; Tue, 14 Oct 2025 23:36:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v8sJt-0006RO-Ds
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 23:36:57 -0400
Received: from mail-yw1-x1130.google.com ([2607:f8b0:4864:20::1130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v8sJq-0004XD-6k
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 23:36:57 -0400
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-781421f5bf5so25153357b3.3
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 20:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760499410; x=1761104210; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dOJa5dAemTev4Uz8NZdQRrOF0mfQI5ZIzajG1m3vCNk=;
 b=Q+1GOPSDollrPPx/xgV7N5hFBe1TN9Mp6Bwc8fSzmgWbxcTt/LRuUv45PlR8Go7dLv
 juioaHv0i03gv9MjkPBGBoEECE0s6iQw5LmqTsZfAXJe5nllEv+6ijeayCbkiiioQMoV
 Cay/9917LGJC3snyx1zWcAcluDIR24pYaxsuNutnwu3s2vVGzKYH73QePfPcp7XiZXPM
 gc4oV+mfec6RVo5tKfs93nbX54Yn2D3d5wDFqusXE8a2axUYNRQKf/Q8iQ10RoPSDvgM
 BsCI32xQdydQYMsde54h04cYlXNlv9jOIvRt2OE7ci+S8/GAIPQY8U7zB44h8SnBGbxF
 fDfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760499410; x=1761104210;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dOJa5dAemTev4Uz8NZdQRrOF0mfQI5ZIzajG1m3vCNk=;
 b=HuHVez7EH0W6RCcElXh2IRrvRtojrBjCSYE1oFTWE6L6elXnTeJZkMXNqbJ2uEKHN0
 4NC6LqHZup6w1H/5wg1n+d6Jzl6dXNrrf2KhQ8X88WARS0X2wF8FbQ7BuYjRJu3qwW8O
 JG/FKQwl8KssTrcv51Gb/5og7S5TQcxMjH0Y/pAub7EYkJiqS1gqWzVMcETAjC63yylG
 Qmywf1kMAzuaLwB6qSmmfqtSpCRsVIvo40XJtq4biDgZ4ws7RhdwpMgA+nbYAX4vqg/Y
 Bgkg/btlVrXaxBotjG/PNlDtNt0rXS5Fijmrl+AvUSvlTcFBrTPsuCsCAfXz0sou5OsM
 Vpqw==
X-Gm-Message-State: AOJu0YxBh7n8F9gZfRpbwGCwS5ChRz0MvUusOXUnNQeau8AIyAmt3+Z5
 z7PS7LJtVvsvG6JEjAe5EEGviubNqtZKe1geml/fPMt75YPUL8wNwp9BTh6PTmnyZDVWuU00HMC
 KbvhyjJ/zmDeQstDoI4NSdEYW2Kjsnag=
X-Gm-Gg: ASbGnct+aXsULSOYfag2N3iGAhr9ZEzkxbFvN0N6PcV69Jwj6EBO6Q+Yp06cYUB8uME
 wBwnR8yled1hZuJTOTVHBR8HNjRWRGbOH1jAbGrmisyQba3Uzu4QOEWodC6Hluka5Vi+Ixk9E35
 tWhtZFy6adoREuAydjmqVv5S9nZoEJ98qcPy2IGoV5AzscNMlmB2p85FNGJUZjLzGlycxF5KmKq
 heIPdjcfmO2o1cUbeZk0tj6dPa48uKtoFLkrMreVFX4RDv0+WookNAPKgXMjIEpzt4=
X-Google-Smtp-Source: AGHT+IGrENmNmtwm/dX35G+69kFX8oAz+K1GXYcJwY5O/bYdnEdog9y4N4ca9pql9fn4mhA58KHyR8pXdRtkPAuD/CI=
X-Received: by 2002:a05:690c:4a0c:b0:780:fdbb:5265 with SMTP id
 00721157ae682-780fdbb5de0mr334804317b3.19.1760499409821; Tue, 14 Oct 2025
 20:36:49 -0700 (PDT)
MIME-Version: 1.0
References: <20251003104443.51501-1-djordje.todorovic@htecgroup.com>
 <20251003104443.51501-3-djordje.todorovic@htecgroup.com>
In-Reply-To: <20251003104443.51501-3-djordje.todorovic@htecgroup.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 15 Oct 2025 13:36:22 +1000
X-Gm-Features: AS18NWD2d44Au1cj75AIooclTBgZYYwmHAqWXsRgvExNey_bq4wwlpXSxWZIMhg
Message-ID: <CAKmqyKP=Lu_1kq98LzuykGC=FK0-28OKtR=Pwixqg034NR3wLQ@mail.gmail.com>
Subject: Re: [PATCH v10 02/13] target/riscv: Add cpu_set_exception_base
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::1130;
 envelope-from=alistair23@gmail.com; helo=mail-yw1-x1130.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, Oct 3, 2025 at 8:45=E2=80=AFPM Djordje Todorovic
<Djordje.Todorovic@htecgroup.com> wrote:
>
> Add a new function, so we can change reset vector from platforms
> during runtime.
>
> Signed-off-by: Chao-ying Fu <cfu@mips.com>
> Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>  target/riscv/cpu.c | 15 +++++++++++++++
>  target/riscv/cpu.h |  4 ++++
>  2 files changed, 19 insertions(+)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index d055ddf462..d42cf9d70e 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -73,6 +73,21 @@ bool riscv_cpu_option_set(const char *optname)
>      return g_hash_table_contains(general_user_opts, optname);
>  }
>
> +#ifndef CONFIG_USER_ONLY
> +/* This is used in runtime only. */
> +void cpu_set_exception_base(int vp_index, target_ulong address)
> +{
> +    CPUState *cpu_state =3D qemu_get_cpu(vp_index);

We usually use `CPUState *cs` in QEMU

> +    if (cpu_state =3D=3D NULL) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "cpu_set_exception_base: invalid vp_index: %u",
> +                      vp_index);
> +    }
> +    RISCVCPU *vp =3D RISCV_CPU(cpu_state);

This should be `RISCVCPU *cpu` and should be defined at the top of the func=
tion

Otherwise

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> +    vp->env.resetvec =3D address;
> +}
> +#endif
> +
>  static void riscv_cpu_cfg_merge(RISCVCPUConfig *dest, const RISCVCPUConf=
ig *src)
>  {
>  #define BOOL_FIELD(x) dest->x |=3D src->x;
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 4a862da615..34751bd414 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -672,6 +672,10 @@ G_NORETURN void riscv_raise_exception(CPURISCVState =
*env,
>  target_ulong riscv_cpu_get_fflags(CPURISCVState *env);
>  void riscv_cpu_set_fflags(CPURISCVState *env, target_ulong);
>
> +#ifndef CONFIG_USER_ONLY
> +void cpu_set_exception_base(int vp_index, target_ulong address);
> +#endif
> +
>  FIELD(TB_FLAGS, MEM_IDX, 0, 3)
>  FIELD(TB_FLAGS, FS, 3, 2)
>  /* Vector flags */
> --
> 2.34.1

