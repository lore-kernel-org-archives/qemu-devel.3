Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABFE9FF8864
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 03:06:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHYmW-0005Q6-FD; Mon, 27 Apr 2026 23:06:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wHYmU-0005Ne-8K
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 23:06:38 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wHYmS-0003k4-NM
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 23:06:37 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-baa8c78ac7fso1020029366b.0
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 20:06:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777345594; cv=none;
 d=google.com; s=arc-20240605;
 b=eewhYE/VXSX72byruZyjkjqHCBcJenM+li9dYHvjccMUwOVrPQHWgDWonZGY+ouU+k
 CFn1MLkyX6RWZTeHV/e1Uq/3Xu97usue6jJg6pT88n6HWqN/pPapBe/qR0lD9oZlhEmg
 hfu4ysIF7uqM+oCEognaV076FVkhYJJ1EW3hTdGisdIoumXXenhyPfetz9FGNhJgCFbR
 O16WwG+4aem3lX5p4G2yZ9/KfL3KU7tk9Ryudalw1RJ5m2MtFkIYI0cloVo6ygj6tQG1
 xHtY1qxnd5ihPviQsDSR9lnES8jB0hbc1QDP93FaCssVEfALrVl9e8jtaoC1g7WQdJPD
 toLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=hdCiQjIn84i1DkVzPq1wsFv1a1YwAQzS7+7YDn4C7Yg=;
 fh=LooIvm3XqX8KsPkvrl6FxlquFJj5aKz3cS9aa4O7vws=;
 b=VvOwep799aeSj6fcLvxZbXoDsyZBQDXYhFgewySz2E70SjCpA/uVMvwDMYlnFQrrDq
 0lSBV0htYs6rTeqmoW/StGW/75py0ythU3gQj8iuHicNVB0ULESCApTNksNohGgEIxlR
 EFrKaV6SoXxSisoKjB3tOLBcZPR61D7yN+zNwjyQhvCViFRHwesAEWJsTeZ01i8+CLaL
 pN5lO1mFX4HtZvh+f5pT1FSHq001ZsOIujixi5phhVxzRG0MM7ScRykfQQ3XZW79wjI5
 ckV4TNUUutIXjEkIiqRG+vN5xGF2eOzZEN1z7+FR08ROyd/5pFX8KueMIgnI21Lw6FYJ
 DcsQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777345594; x=1777950394; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hdCiQjIn84i1DkVzPq1wsFv1a1YwAQzS7+7YDn4C7Yg=;
 b=bxbSqJvp0pFPsO+ENlg1GAm7EmGyg7bO3JYGvWy7joj+SfzTkff7PSuHijht82aH9o
 0fzpLCqpGIa3JDdUYkUsx4o9BpzIBQrHhOo7KzPV60zU0biR5sgHj4qGKKbTKEIKHdLc
 pmxX5zXybLaLaKucq33Xob3Wwwhk8EwFX3VcQt21f8aT526AqwzxOSe+6cPd7ls+wZhL
 96p64nv/kvzpiBKaDZswrznjLlZ3+stabu6xPz24idKfzVxtXoRvLkrp17GfK9Ztf2lB
 oqL83QiSwgfQ0qnT+WBXSQgwe/lZalcb5xEixpgrmBmEbTxMXtCl3GYdlQelu8xZYk5E
 bCFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777345594; x=1777950394;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hdCiQjIn84i1DkVzPq1wsFv1a1YwAQzS7+7YDn4C7Yg=;
 b=Qrx3HBFGlp8AZ6tQcXqvdIvx+6E8A4bpMFDqKyjlUNvID13yZrfO3m+P4sMW0axVft
 w11eW4xFNhIpKnIHOrLXJZCXbg9jU1Vu6VwW9zE7/4RyWUECH6FZU9u+po5CFrYcc+O3
 bjzbryBl+6Y71tNU//8ilce0UNTQoZk6AfTaJsmtiHcfgyExdzMQYI1HSEAB+dgvQCNu
 ec6lnkDzlEaqYaowAdhf/2U3k4t07MNJeSJHtKDX15oKJSJ2jXKMewysLMYRJsTPya7z
 cJgkOQmaFIImCm9mo+Lng976XOwmNceTXFwBuICnEvoiPgVnKHI8e/deJOdhqNhL+NeJ
 nRRg==
X-Gm-Message-State: AOJu0Ywz8fkQSHAYavhPfrr+J/QcrRxiXXPbN39gn4Q5JKdh2hWt0BoO
 0IUq8rYmtMBbgqSMCEcf0xrMui5zAztJ9W7ZENhl9ROZiu0rQvwRRfVilRyNhXMACHZVjHBLRlm
 3MtaaI6kh8is+ktoBgnSErlEIR3xXz78=
X-Gm-Gg: AeBDievetKqO1yhv8t9k+tKaoHOvu7WTf7b9gwVUvDYX3iYJMe3eyExRCeup00s8vdO
 59koXG+fr6v1+gNNvdNikgyCMLkqbnutJm+dsevJVPtC/gRcEkdP+C74tUJVxxL9lmKp4kGyYrh
 eUyfTlDt8mBDJbEvJFXb2X59Pg9Ws5QibXWSr7DRRBpBpXUoYkAGct7H+y4AWYbqb1XAOWfw/VR
 TTdAwvs+5zUPbbqZ2vVmqTt1celZ5tHdtGYw4uq3k6notrraQXZgzChm8iOaojHAbDemkI2SjhI
 6vvvT00kvLIaTv7FsH46Ur/QCQSt+gHGDg/vfP/3AIio3M6b
X-Received: by 2002:a17:907:25cd:b0:bb7:e661:475e with SMTP id
 a640c23a62f3a-bb8029c2d3amr64060566b.19.1777345593931; Mon, 27 Apr 2026
 20:06:33 -0700 (PDT)
MIME-Version: 1.0
References: <20260421093715.2995067-1-frank.chang@sifive.com>
 <20260421093715.2995067-6-frank.chang@sifive.com>
In-Reply-To: <20260421093715.2995067-6-frank.chang@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 28 Apr 2026 13:06:06 +1000
X-Gm-Features: AVHnY4IgQ3KCyPE18XTMjVUW5XennbRDkb8qmlsFWjVeLlchGLbPcy8XJIN9Pwo
Message-ID: <CAKmqyKOREJ3WcpaujOd+8Y0um2hELr98oWkHpqPyGkhr4MuReg@mail.gmail.com>
Subject: Re: [PATCH v4 5/6] target/riscv: Rename riscv_pm_get_virt_pmm() to
 riscv_pm_get_vm_ldst_pmm()
To: frank.chang@sifive.com
Cc: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu.zevorn@gmail.com>, 
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x631.google.com
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

On Tue, Apr 21, 2026 at 7:38=E2=80=AFPM <frank.chang@sifive.com> wrote:
>
> From: Frank Chang <frank.chang@sifive.com>
>
> Rename riscv_pm_get_virt_pmm() to riscv_pm_get_vm_ldst_pmm() to better
> reflect its actual usage. This function is used when checking the PMM
> field for virtual-machine load/store instructions (HLV.* and HSV.*),
> rather than for VS/VU modes.
>
> Signed-off-by: Frank Chang <frank.chang@sifive.com>
> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.h        | 2 +-
>  target/riscv/cpu_helper.c | 2 +-
>  target/riscv/internals.h  | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 672f0dab0fb..138183e017c 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -890,7 +890,7 @@ bool riscv_cpu_is_32bit(RISCVCPU *cpu);
>
>  bool riscv_cpu_virt_mem_enabled(CPURISCVState *env);
>  RISCVPmPmm riscv_pm_get_pmm(CPURISCVState *env);
> -RISCVPmPmm riscv_pm_get_virt_pmm(CPURISCVState *env);
> +RISCVPmPmm riscv_pm_get_vm_ldst_pmm(CPURISCVState *env);
>  uint32_t riscv_pm_get_pmlen(RISCVPmPmm pmm);
>
>  RISCVException riscv_csrr(CPURISCVState *env, int csrno,
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index 2b3fea81d50..ef1ff7cb0bd 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -214,7 +214,7 @@ RISCVPmPmm riscv_pm_get_pmm(CPURISCVState *env)
>  #endif
>  }
>
> -RISCVPmPmm riscv_pm_get_virt_pmm(CPURISCVState *env)
> +RISCVPmPmm riscv_pm_get_vm_ldst_pmm(CPURISCVState *env)
>  {
>  #ifndef CONFIG_USER_ONLY
>      int priv_mode;
> diff --git a/target/riscv/internals.h b/target/riscv/internals.h
> index 43b77d30f27..82d24f433dc 100644
> --- a/target/riscv/internals.h
> +++ b/target/riscv/internals.h
> @@ -203,7 +203,7 @@ static inline target_ulong adjust_addr_body(CPURISCVS=
tate *env,
>
>      /* get pmm field depending on whether addr is */
>      if (is_virt_addr) {
> -        pmm =3D riscv_pm_get_virt_pmm(env);
> +        pmm =3D riscv_pm_get_vm_ldst_pmm(env);
>      } else {
>          pmm =3D riscv_pm_get_pmm(env);
>      }
> --
> 2.43.0
>
>

