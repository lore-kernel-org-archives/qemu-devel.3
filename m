Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 487C4CD6E4C
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 03:56:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTtl3-0006dh-77; Sun, 31 May 2026 23:56:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wTtkl-0006bz-MK
 for qemu-devel@nongnu.org; Sun, 31 May 2026 23:55:52 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wTtkj-0002oz-Fr
 for qemu-devel@nongnu.org; Sun, 31 May 2026 23:55:51 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-bd8f6ef4ba6so2386357066b.3
 for <qemu-devel@nongnu.org>; Sun, 31 May 2026 20:55:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780286148; cv=none;
 d=google.com; s=arc-20240605;
 b=VMch07oAJ7ZKXkXxUTmwgdXwgehoz886sqN2JCVEEsA4viPY2SFifFeQES/H8v7GmE
 cH+aUba6e5svmXH6ax4SQw5ESkPprgL0diZDKt5m2Eycdrk06IGz5KJNDM1+fSu17FLF
 4e2HHoicS2WJkPD4uzoWqO7KsZptm2hrUvP+1iwCviDqKLtum0f8ZaqzmnbUuTn9oVZE
 fqESAD3JiF/YnYJ77e2yZQUQGqZ9u4iPMe2mT9TiLpws6nZIZqhbBi4pwbV8tft/H37U
 ZgXTw6KLLmOkipJIa4GwhcVGqF/zfiH5zDOyrf9Rm9C+AIL29v8HHiydhU8b6pLVvc/+
 dMiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=nnOnrcJSjSN1lAmrzErKuLVAP/jlLgIKR/oTsGO10JE=;
 fh=oXbwLIQ6D7eZBIAfdMwTNx3JbGXBw4Kr6QcethzQnTk=;
 b=dDYiA2eiS7efNw2vCPq2jSmyjHwKjohHaLx4PsEUfh6CMfD8GRqYSKfdjR+HLk76YO
 sTjnEgZQwrso4ItXeXte0x/9KcK53kJVf7UF2gBL60Q9MgJ22GabKo6DeA7cLDqiBEZ5
 x8ke7W2hm08XGIkExwZJ04gpMOSePZVAk12q239/8obgYu4IgXWZLz1SzDZNFGja28OG
 tYnd6ttP41XI6fF+m0gGqRPqVvCgT1JvqLnjHtKKyCjFmoy4wGoRIMkIw6mUiX9iVhAU
 /Y773wlTm/sVRzvYRvSmcglHPxQC5e8g0Qz6TtFhUMY+OB9kZOxtT3APPDcDiNpiJ+hO
 ApYQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780286148; x=1780890948; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nnOnrcJSjSN1lAmrzErKuLVAP/jlLgIKR/oTsGO10JE=;
 b=lIzqMxQ2LvvquB7m5BRO/n4MfQwV8NgSsGozs9vZeQc0q8vEpJwb8fHPXlzLN84u5p
 7lLzzCsoGSYZj0hTVOi3a8A3Ho3IR/qpRLafYkOD3+lNlNcFyWCg936u7bRB4kLcsmxC
 CdjJek/+r7yZljmVuyw/eoEE13Tnu5uE2VcM0m7D0kiMNmZLdmiOJv6XJ1AkRuGN5f1o
 nMb/fkaWJOlv3oHjkZbKbYBTCYMM6ol/4LHc4J5nOp+czQObmMiflha4SvNrC+yxoNIe
 85rO0/MT3y/BZvE3bmBmaiEhym4UJHmuuYDzHnpZYyxI4qCEAEbbaPv0KMlYq80UPYtM
 fphA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780286148; x=1780890948;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nnOnrcJSjSN1lAmrzErKuLVAP/jlLgIKR/oTsGO10JE=;
 b=ToHgHx1dU+Qf01IvD+r6ApM365VcbPp7MDeZv8WL4YsqX0LdG15ntuLG8IQiYHWM4R
 Vb7h/b7dUqu6D9MGXLWigW3ID6CUOstOcTyOJwxW+0c2xxqG490msER1NRGk4Gnpiosg
 O0+H4lZjV08iCohV16jkpZmF0MmYk+6fm4BH/g2cFiXO55mKwi/7a4M0Dwj6qBZ4OB0O
 poJp0sWbhURLqhLSPRWO/uXx7UacsFGuk9W1rsJ7mGSlI8N0/B34GmRn/xzMOhqYVsXL
 fhyefCbLFQPj84uKMiOGWDt/b4YfJzlTSzcdaoHxdIGZpYqCOk1AeXSO19O/Ha8Z20KL
 O03g==
X-Gm-Message-State: AOJu0YzafYL2zA/2HvwP7lxHAGaYm0FW8iEh7MhmGucnAGZRdW43Iz10
 F7MdzNTrb2Y3m+ql+aV5Bh75uR3AdYRdFfKrvjNAhwriwlWG/6xrxL4wFOXkINR3Ad/e5+qJIFo
 VeZLcecnufwTQ7Ujh5CTPPIY4iKyU4Zs=
X-Gm-Gg: Acq92OG6x5YnbxYTstbAv59R2mBp7wQRdSCVBDau6Xmhje2HFsdgEg6rovCj/lQ6Dt1
 WVdrvTAaryDigc9KuPSXFdX3xpEvVhzNo8SUbdK8tt4QW9sfUwmq3V9H2H0xJLd7DK118p9W5t2
 TKME+f3pbQT8mEbXtVRkrL13B8YI6BDQMHPrUpmZc8yP4c+EwERod7gXXvcT3ZzLEUL5K5R4b1j
 uzt43DJzBMM8EB3JTkoz5d7RP33icbOEOvGnQ3nbQMjALRzO2mk6li6Z+GoG3jHyQTOQc1fIn5d
 jJW5KrskgkLlbiwwf6nkowCsHZn+BDrIBV/USmtTbigtNstUbGeZN5YWHk0=
X-Received: by 2002:a17:907:80b:b0:bdb:6077:a168 with SMTP id
 a640c23a62f3a-beab5af5f66mr486141766b.26.1780286147462; Sun, 31 May 2026
 20:55:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260527201348.29511-1-philmd@linaro.org>
 <20260527201348.29511-6-philmd@linaro.org>
In-Reply-To: <20260527201348.29511-6-philmd@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 1 Jun 2026 13:55:19 +1000
X-Gm-Features: AVHnY4KnXJr-PqtZ0cNvu9t-sEHPgWxO1vm6OKJi6U97YcjdWz1LO7JOyCwPpCg
Message-ID: <CAKmqyKMfUXfy_5ptMRTQch9hXMwN3rKtECoNi+5-y0FoNbwbcQ@mail.gmail.com>
Subject: Re: [PATCH v11 05/12] target/riscv: Remove target_ulong use in
 get_physical_address()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-riscv@nongnu.org, 
 Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 Anton Johansson <anjo@rev.ng>, 
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu.zevorn@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>,
 Christoph Muellner <christoph.muellner@vrull.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x62b.google.com
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

On Thu, May 28, 2026 at 6:15=E2=80=AFAM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> Use uint32_t for RV32, uint64_t otherwise.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu_helper.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index 6da67e132eb..fd7c6ac1b23 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -1625,16 +1625,18 @@ static int get_physical_address(CPURISCVState *en=
v, hwaddr *physical,
>              return TRANSLATE_FAIL;
>          }
>
> -        target_ulong *pte_pa =3D qemu_map_ram_ptr(mr->ram_block, addr1);
> -        target_ulong old_pte;
> +        void *pte_pa =3D qemu_map_ram_ptr(mr->ram_block, addr1);
> +        uint64_t old_pte;
>
>          if (riscv_cpu_sxl(env) =3D=3D MXL_RV32) {
> -            old_pte =3D qatomic_cmpxchg((uint32_t *)pte_pa, cpu_to_le32(=
pte),
> -                                      cpu_to_le32(updated_pte));
> +            uint32_t cmp =3D cpu_to_le32(pte);
> +            uint32_t val =3D cpu_to_le32(updated_pte);
> +            old_pte =3D qatomic_cmpxchg((uint32_t *)pte_pa, cmp, val);
>              old_pte =3D le32_to_cpu(old_pte);
>          } else {
> -            old_pte =3D qatomic_cmpxchg(pte_pa, cpu_to_le64(pte),
> -                                      cpu_to_le64(updated_pte));
> +            uint64_t cmp =3D cpu_to_le64(pte);
> +            uint64_t val =3D cpu_to_le64(updated_pte);
> +            old_pte =3D qatomic_cmpxchg((uint64_t *)pte_pa, cmp, val);
>              old_pte =3D le64_to_cpu(old_pte);
>          }
>          if (old_pte !=3D pte) {
> --
> 2.53.0
>
>

