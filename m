Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72B94109E538
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 02:10:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5aAZ-0007Mi-CI; Wed, 25 Mar 2026 22:09:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w5aAX-0007M3-T4
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 22:09:57 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w5aAW-00082f-84
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 22:09:57 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-b9825ba7e8dso63281066b.3
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2026 19:09:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774490995; cv=none;
 d=google.com; s=arc-20240605;
 b=iTd5g/yHS/L6Ra8OtxkjZvf5mIjUczxiCre18mIeGc/aBabFwXrnOKaD0jiBxvw68u
 SIrCpVjBtt49klyLGpcOFidtcCB8Yr8G2vFj8N+cxru+pWTIDTZ9J/jLFUMq7HvoTUy6
 hasXi5S1zuorQEqf1BvIbQBjSspq8Ghs8nrP387wYm4hO0cx5rCiXdxPlnCi6usKUH9o
 FUg7guAjDFXs0V3PCz8eqmwQPwXbwbPd/3PHEwxxf+Nr5OW68UGtwUaKZ8ouhmXJyzfJ
 20AHp0uBkTomewBi8LLNUjJS66LjaSRLntboIp8NxmWMzTFcpCkyE4aVbdLEmTLVtA9u
 a2rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Iq4HKOl0tmQG3MVEjo8ohiH5uJH8rH8hnp5AJIhq17Q=;
 fh=0bIOm+75pw/QTN9FDs8ZhfYo0XBcsOIKWWC6mti+rTw=;
 b=bErIQISgKCWZNJl+mMl2aoFmu5SiemS1FULeYESDGZHGWkyzTMVpZP2N7ZkHQynRdv
 s+WWNHwFh5zJADTBuvgO7bm9UGTVxH0bDJeDAu0Ek5zxskbLzx17+Fq3vccnmSmzOaRH
 s/01Hoidf0BSrK2p6D+SdzFCpJs5zmxPLFu9v4QhmkZesb0Oq+rhnN1YWlQ5ErmalBRD
 ngh2ZTc+iGUdxzPoXNDppkHqn0ivfPB5IRvPEDUEx5/yBzC7BX0zaJD6Z2yW+/KEqI4E
 MZfZms2PhfRzLJ/S2I305e0Q8hTGXlj1bLr72/iKeARo+0MmuQiyL5JJvHgm/w24eXRj
 rDYQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774490995; x=1775095795; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Iq4HKOl0tmQG3MVEjo8ohiH5uJH8rH8hnp5AJIhq17Q=;
 b=WAgsWBZmaTaiFazX/dWUHl6R1eHbQYEtj/5g+rIEwZSuQH8CPk/OQMYb08j0rAtG6S
 FwSkSSu+0XwNUF4K4pxgTSFGe6VkQcCu5gfOS7hKEF6PElhIrFoD0W+R8nSfbSpLk0EE
 W8zRS/Vrf/V27c7F8/oeXBwiu1c62bs6lLw0zSDGmiHeV5f+TFF1yNDVK5p039bg4Kwh
 GkqfI1RPSV3a9KaoIOMJWYyptk0M4L9V72i1GhMqYPEqEgtwhYBuSZI8nuaWDbVtlXmI
 iRs0YK/AzNfNI5JGtRczbT+veMnNKNRGWKWtkGqRh5IS+8LAcjLNN2s4kR/xCs1HoFC9
 ANJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774490995; x=1775095795;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Iq4HKOl0tmQG3MVEjo8ohiH5uJH8rH8hnp5AJIhq17Q=;
 b=SiS3dEkMMpYDmdWHrNM7/0aKGJWvRSdgferkshP0gavreMR5I7c6anw3DSpouZ2lTj
 q0T9eU/VH2F/X6BMAUpqUHfggiNqbQ0Et3quELHJJRtKpmyd4MshmfL8y9cJF+uAUb+H
 WaRwHLXJlkr1FH6tLpp4zxLf1xsduZgFUhBnlsHE+zYLz7kC0dGghk95YWYfENsJWcU3
 20u0H9I0JiTmKGDERBlWuTr0m5ibHzTpk6nfROR0BebuG56uHbNUBjAshAqi45YFgnbV
 q3+DRjo73ihyGj6YjmzvaTYu8UdURrzG0ipdPBNz3UeaDzndPvf9PcqryUz67y/NCi1d
 uE8A==
X-Gm-Message-State: AOJu0YwQMRptwGnX0r71J4ZMTAWsDTEslDZLffA6mJZxX/RLu0ylj8zQ
 wwLnxu4jkP4zSUGWgGSgkNmyX+Rg5JFl4waABULJbZHuAbp+92tgEppkDJ4JdHLYA/KTwZObRhc
 f6LuVylz4nZBhvt3KTOl9sXeo8Nz37VU=
X-Gm-Gg: ATEYQzxo+ADLWmo/eoTwXKQje0OUfYb/3VCZkXW7w8S6mHrIT2CVcyCBp3t+V1Q+AB7
 K+MphJf0/U6D++8gNXWn0m3otmg2grYQ+mVVk7ZMV6QN2TeKi3aACPoskVLxI02w7YOFi3fbipW
 Q9bbr3zh1XczmxoJEw8R4RjdsHLWtXflyKh/xD3YMZKTy9fGrmKya4KdRFXTn1P5NpIKkC5pSMY
 54HBT33lWVXg4vEzBGa3L3TthpiwlVWZM5LHTFoGz9rpRUtJwhsiA2s1eaNfYHkwlQFjDb2UAYV
 cYAeBEyHoZEBT6rBKcEWOS8Z7I5c9h2omrl4WA==
X-Received: by 2002:a17:907:1b21:b0:b98:1062:afdc with SMTP id
 a640c23a62f3a-b9a54221992mr338401666b.27.1774490994535; Wed, 25 Mar 2026
 19:09:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260318103122.97244-1-philmd@linaro.org>
 <20260318103122.97244-8-philmd@linaro.org>
In-Reply-To: <20260318103122.97244-8-philmd@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 26 Mar 2026 12:09:28 +1000
X-Gm-Features: AQROBzB_T7P1nV4hIeuIgaPA5afWcrG_7nfmKusiWXzI6DE10j-HccBTICG9wk8
Message-ID: <CAKmqyKPUG7tSY+pakQD0-tg__73Xv5HQ5Cwvt8epypE-+crJBA@mail.gmail.com>
Subject: Re: [PATCH-for-11.1 07/16] target/riscv: Factor tiny ldn() helper in
 gdbstub
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Weiwei Li <liwei1518@gmail.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Warner Losh <imp@bsdimp.com>, 
 =?UTF-8?B?RnLDqWTDqXJpYyBQw6l0cm90?= <frederic.petrot@univ-grenoble-alpes.fr>, 
 Vijai Kumar K <vijai@behindbytes.com>, Anton Johansson <anjo@rev.ng>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-riscv@nongnu.org, 
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
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

On Wed, Mar 18, 2026 at 8:33=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> In preparation of having this helper handle CPU runtime
> endianness changes, factor the ldn() helper out.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/gdbstub.c | 22 +++++++++++++---------
>  1 file changed, 13 insertions(+), 9 deletions(-)
>
> diff --git a/target/riscv/gdbstub.c b/target/riscv/gdbstub.c
> index 6a5b7a82fd4..be42566bcc8 100644
> --- a/target/riscv/gdbstub.c
> +++ b/target/riscv/gdbstub.c
> @@ -47,6 +47,11 @@ static const struct TypeSize vec_lanes[] =3D {
>      { "uint8", "bytes", 8, 'b' },
>  };
>
> +static uint64_t ldn(CPURISCVState *env, uint8_t *mem_buf, size_t regsz)
> +{
> +    return ldn_p(mem_buf, regsz);
> +}
> +
>  int riscv_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n=
)
>  {
>      RISCVCPUClass *mcc =3D RISCV_CPU_GET_CLASS(cs);
> @@ -84,15 +89,15 @@ int riscv_cpu_gdb_write_register(CPUState *cs, uint8_=
t *mem_buf, int n)
>
>      switch (mcc->def->misa_mxl_max) {
>      case MXL_RV32:
> -        tmp =3D (int32_t)ldl_p(mem_buf);
> +        tmp =3D (int32_t)ldn(env, mem_buf, 4);
>          length =3D 4;
>          break;
>      case MXL_RV64:
>      case MXL_RV128:
>          if (env->xl < MXL_RV64) {
> -            tmp =3D (int32_t)ldq_p(mem_buf);
> +            tmp =3D (int32_t)ldn(env, mem_buf, 8);
>          } else {
> -            tmp =3D ldq_p(mem_buf);
> +            tmp =3D ldn(env, mem_buf, 8);
>          }
>          length =3D 8;
>          break;
> @@ -130,7 +135,7 @@ static int riscv_gdb_set_fpu(CPUState *cs, uint8_t *m=
em_buf, int n)
>      CPURISCVState *env =3D &cpu->env;
>
>      if (n < 32) {
> -        env->fpr[n] =3D ldq_p(mem_buf); /* always 64-bit */
> +        env->fpr[n] =3D ldn(env, mem_buf, 8); /* always 64-bit */
>          return sizeof(uint64_t);
>      }
>      return 0;
> @@ -162,7 +167,7 @@ static int riscv_gdb_set_vector(CPUState *cs, uint8_t=
 *mem_buf, int n)
>      if (n < 32) {
>          int i;
>          for (i =3D 0; i < vlenb; i +=3D 8) {
> -            env->vreg[(n * vlenb + i) / 8] =3D ldq_p(mem_buf + i);
> +            env->vreg[(n * vlenb + i) / 8] =3D ldn(env, mem_buf + i, 8);
>          }
>          return vlenb;
>      }
> @@ -194,7 +199,7 @@ static int riscv_gdb_set_csr(CPUState *cs, uint8_t *m=
em_buf, int n)
>      const unsigned regsz =3D riscv_cpu_is_32bit(cpu) ? 4 : 8;
>
>      if (n < CSR_TABLE_SIZE) {
> -        uint64_t val =3D ldn_p(mem_buf, regsz);
> +        uint64_t val =3D ldn(env, mem_buf, regsz);
>          int result;
>
>          result =3D riscv_csrrw_debug(env, n, NULL, val, -1);
> @@ -230,8 +235,7 @@ static int riscv_gdb_set_virtual(CPUState *cs, uint8_=
t *mem_buf, int n)
>          const unsigned regsz =3D riscv_cpu_is_32bit(cpu) ? 4 : 8;
>  #ifndef CONFIG_USER_ONLY
>          CPURISCVState *env =3D &cpu->env;
> -
> -        target_ulong new_priv =3D ldn_p(mem_buf, regsz) & 0x3;
> +        uint64_t new_priv =3D ldn(env, mem_buf, regsz) & 0x3;
>          bool new_virt =3D 0;
>
>          if (new_priv =3D=3D PRV_RESERVED) {
> @@ -239,7 +243,7 @@ static int riscv_gdb_set_virtual(CPUState *cs, uint8_=
t *mem_buf, int n)
>          }
>
>          if (new_priv !=3D PRV_M) {
> -            new_virt =3D (ldn_p(mem_buf, regsz) & BIT(2)) >> 2;
> +            new_virt =3D (ldn(env, mem_buf, regsz) & BIT(2)) >> 2;
>          }
>
>          if (riscv_has_ext(env, RVH) && new_virt !=3D env->virt_enabled) =
{
> --
> 2.53.0
>
>

