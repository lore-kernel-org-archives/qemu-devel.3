Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18FDCCCD192
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 02:33:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8rJ0-0007FB-Ef; Tue, 14 Oct 2025 22:31:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v8rIy-0007F2-Sq
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 22:31:57 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v8rIu-0004hE-3d
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 22:31:55 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-63994113841so11314786a12.3
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 19:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760495504; x=1761100304; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XqUux0AQPbB5AT6nf1+t3MWAjlR79bWMPkbU7vu+9hA=;
 b=W9cjJUAnCTFOSjEBvXebPEHuGXMm87EoIh+TWMAatsdDSFqwlh2IiIV3/Eee0/WdxE
 Pd/lqwIWbqHU79p8TUwxhvoewWrurTRMNZLaDB9MD1agig0Lu+fjJeszJIURyBd/qahW
 9Hp78w4RwiRwqzKPdhJGe3wYPbjGkgjEYrVC+gdpowY4jHyjkn1FlKSJMTcZo20ZH//i
 8gGidNBbKO8RR65piRo6n+qDku75fvWNz4ny3Zpy7nvtUiu6Gi4j1pohDLPr4zpBWEP5
 H8KKMw9JwAHfh2K44IwgSr3bhECU8on9kp8OyEe5ldh//iyUJGiP9aFa6LPS/7k+I6XI
 VRSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760495504; x=1761100304;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XqUux0AQPbB5AT6nf1+t3MWAjlR79bWMPkbU7vu+9hA=;
 b=hG355KHVF14xTtIJdQCFYBpstBYE22+n7H8F3NhpB5eM3QUCsaU+W5H09wEBy2AUwb
 oLQAyMUD5AUsBEkJ+85kqDGyGPgQBIrM6rGXmqe1QfRtkL2QyZENIAHoT4l1Zm9D8HVm
 bDKRmHVYw9oryGlPxcTzovYjbwr1j4Nj9h/i5R6/vz5KRVYgi/36auY0HZVLg4NUaKcj
 WT7A27ZndzSRf/VYL6IkdZnHa0lxTLmLnOOJbhkJWEkKmss6bG4nrlcpnZQhjGpmxfa7
 i96kvs5KqIzIwE5ftrhwQZRhKiAKYbCZbGDqnOG0+Id1wxOyzptUGLUIdcdqqLXtARhi
 fQ1Q==
X-Gm-Message-State: AOJu0Yzu+7eq5RsHDi6s2LLbj8IrDfVd5gQjjcgCPB5ofR802IHlN10V
 qH4wpMuNN80g0DsLeN3A16M1CTsO1desvUgFSRYuRNWyq3+jW1JP/DPV9FxpFeAMvg6gaEYmNVw
 5xgfPqEXbT9hy0pK1gpiFkek4A72/ujk=
X-Gm-Gg: ASbGncskERwLlbWZ5Ci6TW7nDfzAxSnHgvYl7olzZT1i38oqb8fi1Q89ZYo7fMQN5pM
 huOtUJtwp0w59TCAYK/5tJ+eUa/3lcUBVFQNmoW9WNsfJcfjxIiLsCktcXj2zYZJNzS8cAWEgFX
 I6P7C5Et28a1agPjGF/ZK7jZl8T7CevLqh545+YcEM/cSuO3x0iXbf7recobB0T3um/KD4kxJaf
 ji1BmWJ0DkRavz/CliOEG0xRWJyHu8hh/MN5aVitCnYOHM6+Sy0FB5u
X-Google-Smtp-Source: AGHT+IF9vUJq7NpQSRnfoDt2DiDqAixHvCh6KXifOca9f5YAf98+fThZVwLcljhWUVD18dH6cI9OxhcdMr5JwA/OmBk=
X-Received: by 2002:a05:6402:5c8:b0:637:e490:4600 with SMTP id
 4fb4d7f45d1cf-639d5b80283mr25139574a12.16.1760495503831; Tue, 14 Oct 2025
 19:31:43 -0700 (PDT)
MIME-Version: 1.0
References: <20251013133242.1945681-1-jelly.zhao.42@gmail.com>
In-Reply-To: <20251013133242.1945681-1-jelly.zhao.42@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 15 Oct 2025 12:31:17 +1000
X-Gm-Features: AS18NWCcb-wfa9ZY4kCaGLgWq46oXhRq5jWEl6ht5DIJB8_SCehCz9ciflTgtJM
Message-ID: <CAKmqyKP-AvSfOk4rXAsT1vPdWGfVBxd6+pgw080_tAijEUY4Og@mail.gmail.com>
Subject: Re: [PATCH] hw/riscv: Correct mmu-type property of sifive_u harts in
 device tree
To: Zejun Zhao <jelly.zhao.42@gmail.com>
Cc: qemu-devel@nongnu.org, Alistair Francis <Alistair.Francis@wdc.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x52f.google.com
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

On Tue, Oct 14, 2025 at 1:00=E2=80=AFAM Zejun Zhao <jelly.zhao.42@gmail.com=
> wrote:
>
> Correct mmu-type property of sifive_u harts from Sv48 to Sv39 in 64-bit
> mode since it's the only supported SATP mode.
>
> Signed-off-by: Zejun Zhao <jelly.zhao.42@gmail.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
>  hw/riscv/sifive_u.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> index d69f942cfb..3e1ed209ca 100644
> --- a/hw/riscv/sifive_u.c
> +++ b/hw/riscv/sifive_u.c
> @@ -176,7 +176,7 @@ static void create_fdt(SiFiveUState *s, const MemMapE=
ntry *memmap,
>              if (is_32_bit) {
>                  qemu_fdt_setprop_string(fdt, nodename, "mmu-type", "risc=
v,sv32");
>              } else {
> -                qemu_fdt_setprop_string(fdt, nodename, "mmu-type", "risc=
v,sv48");
> +                qemu_fdt_setprop_string(fdt, nodename, "mmu-type", "risc=
v,sv39");
>              }
>              riscv_isa_write_fdt(&s->soc.u_cpus.harts[cpu - 1], fdt, node=
name);
>          } else {
> --
> 2.43.0
>
>

