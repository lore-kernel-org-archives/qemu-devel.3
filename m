Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39037C369DC
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 22:40:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9X9C-0003tf-V1; Mon, 28 Apr 2025 18:40:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u9X9A-0003se-Oy; Mon, 28 Apr 2025 18:40:20 -0400
Received: from mail-ua1-x92c.google.com ([2607:f8b0:4864:20::92c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u9X98-0002Dz-Ew; Mon, 28 Apr 2025 18:40:20 -0400
Received: by mail-ua1-x92c.google.com with SMTP id
 a1e0cc1a2514c-86f9c719d63so2156536241.1; 
 Mon, 28 Apr 2025 15:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745880013; x=1746484813; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xRO92B9LpqVuZNh+Lt90T5xvgUdoVVjmZMY6zNa0f+Q=;
 b=j7VrvVMBwLDAWNPuJLdEVYzZgvnBuZHcNufKHPuO27cr2WHtaQ+A0bqNuhnxX2MuDn
 cJmhmLTZH+XWanYozmIgYjq5xbbQnF9EAeXwcGtruwCKhGJ6Gwn9orDmUw7bFccwfW3e
 UI0smd6EGR8Dgs3n7aF/LtL9qcNvKxNtdZiQpWYJn+HjYc8qpImvHQlTj0IO6w0hAgOf
 ZUf4GKmVyX9IKRP+u8Zoz4me00RO9rC26S4dBYyoPg6uMUxyDP8uQl8yw8pYWciGO5O4
 gi7rxzWCqkXHhvmbM0gGW2Dg57PrmKEvCXBHS3L6HIYcowSxTDooQzEwUBuw9iEndPVl
 JfYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745880013; x=1746484813;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xRO92B9LpqVuZNh+Lt90T5xvgUdoVVjmZMY6zNa0f+Q=;
 b=gRK6mMH4MWuIcCG9Ec0qo1Y39BuRprQqnMjLO1qBaE0d+oXT8JyoJJgsti5JKN4LnH
 cW3GlMIrNXaVSTa5QOe+TEVeLfPpfVKFw4P8KF1o59bb6JuAF/iMy+H7stGkdARc961F
 bJsWOzyQ7+dauq1DqHJpTCs/qvVH87HoWkrCM+ts2sbly7WnhOAIRN2EdqwoKyCboKIK
 et1TC8oHagczJ7zduPa/2VdfLlfiPtYBb9E2dj6lWAwXsY/+yEhPVABdXWEzqB0Vq9TO
 f86EIM7EFHOQm3rLIL+bhRQLfg+I5FAkdTNCIlRrm+3Va0MjYME516U8MshSIkodQ3Bi
 NJhA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJ1URC4F0/RrIGmz7QhswFyox6Ruttov1/8Hn0sA5ZO8An6xHhsno7Ed1CZ+nt0M/vIMV8HzyixQKa@nongnu.org
X-Gm-Message-State: AOJu0YzGNr83fNo50NwOZlPzkbcLIJj2gygBKjK14yutX9VlH0POJazm
 IRTuFULy86pMf/fEdSyO68PkULbrbC7OBLXrqk9wL4fy4SxcwZXepO4seajMHRDWK/EXYt8XFRJ
 evsZfxZtPJZBRbZpVVoL+yXCPlbQ=
X-Gm-Gg: ASbGnctTeuzBSPihbPVzw5EX15yzHhvLkAAVoK313KmLrdZKJRQ1j4NprCHJl51VEy1
 VDUPtJPKKPHFO7nsy7lpVftF7+/c/Ju4/PJszRxpRkYkEMQOFD71TR/Xfod/uoWlze3VH7l4nOh
 ocqYz5myz7UXvDrPy8CRJbFzXjG65G3F18TXgZXWfggPK+h79N9gGD
X-Google-Smtp-Source: AGHT+IGQxKu7ZwN1Ot7EUbIhAkc5BFBP0mskvbFvOYSwfLmuYdmViFOvf9fYJKFoArsAlYOX+SIBgOn9Q4diu38OBvo=
X-Received: by 2002:a05:6102:3f0a:b0:4c5:5aba:94bb with SMTP id
 ada2fe7eead31-4da7f03e664mr1343710137.3.1745880013394; Mon, 28 Apr 2025
 15:40:13 -0700 (PDT)
MIME-Version: 1.0
References: <20250425152311.804338-1-richard.henderson@linaro.org>
 <20250425152311.804338-8-richard.henderson@linaro.org>
In-Reply-To: <20250425152311.804338-8-richard.henderson@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 29 Apr 2025 08:39:47 +1000
X-Gm-Features: ATxdqUFcs4Kfye6Ep8xEFhrn0XKjqwOXJ2_Ij-ARZGUgTpvhHc4eEprtss97atg
Message-ID: <CAKmqyKMAx-FEW4vUbjUazJsjZApLVQ8sNNBk7jJxxVnzNXk-rg@mail.gmail.com>
Subject: Re: [PATCH 7/7] target/riscv: Fix write_misa vs aligned next_pc
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 dbarboza@ventanamicro.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92c;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92c.google.com
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

On Sat, Apr 26, 2025 at 1:26=E2=80=AFAM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Do not examine a random host return address, but
> properly compute the next pc for the guest cpu.
>
> Fixes: f18637cd611 ("RISC-V: Add misa runtime write support")
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/csr.c | 22 +++++++++++++++++-----
>  1 file changed, 17 insertions(+), 5 deletions(-)
>
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index a663f527a4..85f9b4c3d2 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -30,6 +30,8 @@
>  #include "exec/icount.h"
>  #include "qemu/guest-random.h"
>  #include "qapi/error.h"
> +#include "tcg/insn-start-words.h"
> +#include "internals.h"
>  #include <stdbool.h>
>
>  /* CSR function table public API */
> @@ -2099,6 +2101,19 @@ static RISCVException read_misa(CPURISCVState *env=
, int csrno,
>      return RISCV_EXCP_NONE;
>  }
>
> +static target_ulong get_next_pc(CPURISCVState *env, uintptr_t ra)
> +{
> +    uint64_t data[TARGET_INSN_START_WORDS];
> +
> +    /* Outside of a running cpu, env contains the next pc. */
> +    if (ra =3D=3D 0 || !cpu_unwind_state_data(env_cpu(env), ra, data)) {
> +        return env->pc;
> +    }
> +
> +    /* Within unwind data, [0] is pc and [1] is the opcode. */
> +    return data[0] + insn_len(data[1]);
> +}
> +
>  static RISCVException write_misa(CPURISCVState *env, int csrno,
>                                   target_ulong val, uintptr_t ra)
>  {
> @@ -2114,11 +2129,8 @@ static RISCVException write_misa(CPURISCVState *en=
v, int csrno,
>      /* Mask extensions that are not supported by this hart */
>      val &=3D env->misa_ext_mask;
>
> -    /*
> -     * Suppress 'C' if next instruction is not aligned
> -     * TODO: this should check next_pc
> -     */
> -    if ((val & RVC) && (GETPC() & ~3) !=3D 0) {
> +    /* Suppress 'C' if next instruction is not aligned. */
> +    if ((val & RVC) && (get_next_pc(env, ra) & ~3) !=3D 0) {
>          val &=3D ~RVC;
>      }
>
> --
> 2.43.0
>
>

