Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1551CD4F3C
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 01:05:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOmPn-0002Od-Vg; Sun, 17 May 2026 21:05:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wOmPi-0002NH-4j
 for qemu-devel@nongnu.org; Sun, 17 May 2026 21:04:58 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wOmPf-0006HQ-ML
 for qemu-devel@nongnu.org; Sun, 17 May 2026 21:04:57 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-bd3eb594960so218187466b.0
 for <qemu-devel@nongnu.org>; Sun, 17 May 2026 18:04:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779066293; cv=none;
 d=google.com; s=arc-20240605;
 b=aZ75tPrCkELZvWDX3EcZ0Azz3A8eTwBhOrk9LGaYMxoEC8ipqr1MTc314UO/h72Z6F
 kQybrEu7FtGEhQvbM8wA2xRMS+HhJQ7WIf8uNJPNuk3olwE9RGnaFz+nwmOXFHXYU3kE
 n8Qfbjsczu4PYYDeZjskBl/R5maOdsKigbOJS4UflwOfqkVJF/jskHdCRCYtQD4qlLuQ
 YJqrXcBSQlV+6q9Lys1FXavwQfzy/kQvCHcDaMnYVNnVtdUQ/uWCx3XFED1zzAoncq9x
 w72gq7Qm81u050fohXf1VHtmVZkcvETB1HpJ9zzbmUIOEUjN3+jMn8imoSEUDAu0Vi3w
 dQvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=/m8dc/nC8G+ORwaczqSEts8JTObdBNnSwE36BdNnARA=;
 fh=Ofc/7yYflL5fzGU4DVTgtdXtCN7XZwZQ8r7NIaePuJA=;
 b=CP2q8ZtA9U14E/62M0Li3JciC9KTtxFSVZrS+1XLI2tNY2Wrx5STb2yWwtGAZiIAhR
 M9brnT5reYLmxPxqbdz2WTi5IXXnHl6rzClOj6kVPE5OxkCY9VPEFTuPt0RADg0fcpMs
 nWFsm5Y0ph9JAWORFTrcCAh6vFJJVe8SZFXDyfk1+j/zUz1Bge9Q5jg132cntQgePn3M
 i94VqDTOBAuZYIxxZUHXnYAIl9UkQVajmXsw3CIboatoJXrx70z0XMVku2ti4MrY7KcQ
 QvIen5N4rEY2kshs1KmAJmcCOTtL2/JFvUgL5/s30uKAGZ34IvpHIantRMnLJxakype2
 UNyQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779066293; x=1779671093; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/m8dc/nC8G+ORwaczqSEts8JTObdBNnSwE36BdNnARA=;
 b=C+p6SyobhDbXjL1Raf725WqAYZSwZUxNJTt31rn5Zl38upLrsHAybiFaNMYAB2egkf
 Em9RR1uQFBjB0Exg4H2NthLilI6y77tezLPycaalKp4f5ywrNFrf/wp+0I3edpv1HgFw
 QY7Zb7tIvt9ubzRSYfmxhPFFvav3sWtOkrW3L5VX+QX7gszzgThOHjlsR5NYkx0snfBs
 7IRNSlQcODvGSALyU/aRO5nsb9a45E6/GK4/mDG0lmvqUAFXgNDkJ5WwiuPPcGp7vten
 UHrYYICkadpk5d3xWrjeOB38Rbp1J1Gv6p6S1yo0u4yXlnpCnOdB3SWgk8r8Ie1NYjCI
 sT7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779066293; x=1779671093;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/m8dc/nC8G+ORwaczqSEts8JTObdBNnSwE36BdNnARA=;
 b=UlchNjgdfE+kwqmOUrccRtJgRbjQ7izG8UxuN2WVzEJohrHfDbcOYUQYn1BHVcxbOi
 BmRiHUB5zVvJQ+luZndHMMoTWmFq0mp8pFMm/roACCGKUkzkbPnHi8GBRWsu1DVcUMeb
 c3EClYWeBUz6EDyOSeRdkqgcb3Rh7erc7s+D5MvlVULrViv39c7W2z23g+l3Bt/wL8uR
 Y3R0iwYOJhFRBSIFiya4WFtQNsSef8WdJMYF+U295f3/bvFkfcFZwEzj8+R1A9/hsOt9
 yJH5RBfHeDGZ+DSC+lUF1jjIRFezodWohQFg/T8tG5YJoWhWENg+87loCu5au9va2DoP
 cvsQ==
X-Gm-Message-State: AOJu0Yx/9geP4zxA4LbDSn6VovuWIdds/C4NZkICDJXt7mT+wz0X0Qdy
 0giVBvnfQus4BMRfo+pRkTVAmAqkiJ/UokMKSeFpyvOJHrtkaV8mZuArIrNB7ib9X/hROfq/3a+
 8Vkniir3UWe8WS1yWrq1jb9EEjGl3b50=
X-Gm-Gg: Acq92OHnDvlA9icNC3ANIVFnKwBKSTXm4Ihg6g4Xi4upkLvIMBJELpykAhj+kFEzgZo
 UcURQO7PtZB+TJpJ6NtCvFLHFj1EGHKyfGD8JiMcyzau2myShKjO7T9TURi92opGyzWlqXyfBNy
 A77MVH472dWr/61xD7YKGZGLmzioFNVNQb2OTu42VY8xo3mQgHpKod0/ygcYiNh3O/T5Gx0ck/y
 1c7U5JrfSuoTFrRL2stCdoNuAh2gB9sEdxsl4JqoikluSOr3Ola62reFXaCetU3dUGp04UKMaP+
 GA107/lE0aDso3U5daGku3Zu150C56VzPxWghA==
X-Received: by 2002:a17:906:6a03:b0:bd4:99f5:52f6 with SMTP id
 a640c23a62f3a-bd51796da7cmr596840566b.34.1779066293374; Sun, 17 May 2026
 18:04:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260515180437.23620-1-anjo@rev.ng>
 <20260515180437.23620-27-anjo@rev.ng>
In-Reply-To: <20260515180437.23620-27-anjo@rev.ng>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 18 May 2026 11:04:27 +1000
X-Gm-Features: AVHnY4KCfLBJleGa194Jg9J9lsW-dZx8jRbYPYk7vpyPwM9UdMo9IcoyrvQgvak
Message-ID: <CAKmqyKPX5qXtgwwBUnSgcc1nDhnyy8smKuEdktWDX4SO0hUBhQ@mail.gmail.com>
Subject: Re: [PATCH v6 26/27] target/riscv: Pass address as uint64_t in
 cpu_set_exception_base()
To: Anton Johansson <anjo@rev.ng>
Cc: qemu-devel@nongnu.org, pierrick.bouvier@linaro.org, philmd@linaro.org, 
 alistair.francis@wdc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x635.google.com
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

On Sat, May 16, 2026 at 4:03=E2=80=AFAM Anton Johansson via qemu developmen=
t
<qemu-devel@nongnu.org> wrote:
>
> The corresponding field CPUArchState::resetvec is uint64_t anyway, no
> need to use target_ulong.
>
> Signed-off-by: Anton Johansson <anjo@rev.ng>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.h | 2 +-
>  target/riscv/cpu.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 3352409676..ad5d23ee6b 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -679,7 +679,7 @@ uint8_t riscv_cpu_get_fflags(CPURISCVState *env);
>  void riscv_cpu_set_fflags(CPURISCVState *env, uint8_t);
>
>  #ifndef CONFIG_USER_ONLY
> -void cpu_set_exception_base(int vp_index, target_ulong address);
> +void cpu_set_exception_base(int vp_index, uint64_t address);
>  #endif
>
>  FIELD(TB_FLAGS, MEM_IDX, 0, 3)
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index daad317381..753f92307f 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -79,7 +79,7 @@ bool riscv_cpu_option_set(const char *optname)
>
>  #ifndef CONFIG_USER_ONLY
>  /* This is used in runtime only. */
> -void cpu_set_exception_base(int vp_index, target_ulong address)
> +void cpu_set_exception_base(int vp_index, uint64_t address)
>  {
>      RISCVCPU *cpu;
>      CPUState *cs =3D qemu_get_cpu(vp_index);
> --
> 2.52.0
>
>

