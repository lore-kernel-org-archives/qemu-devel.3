Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CC4ECCD1AB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 02:39:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBlDU-000670-2r; Wed, 22 Oct 2025 22:38:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vBlDR-00066f-5W
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 22:38:13 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vBlDP-0005h3-0K
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 22:38:12 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-63c4b41b38cso548404a12.3
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 19:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761187088; x=1761791888; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tZ1Li+zQnOnMqkypzcF/DnB9F+kM/ZRRwvZgQTomdNk=;
 b=XRvrbqdpeQZwb410xrA3zMmxXbOy8clN27Qa3DT/7Rc9cxTGKS8MZn+bF7sgT5Xoa0
 j8XjdBrQuMhINNBg3MEshIyjlOpi1CRvO9OQT5mEYEzS2Y2yo9YCiWCgu6FV432voZcf
 xs5Q+bZd+1zr9RFHaAnwfQSRUy2RooS9FdpGx0rssc50ch+R+sPDLN5Nez0Gl6PrVEkd
 KwRDsevz4/ZI7nQuXRAq0tXQxUg0Htu+9nYQm59E+ChvJ0gOJyT3tUiUIbVKXq70GnKU
 ZOW01etr2BHhcZAP8MfDxBpVd9yte9F3gKG72+jiysKmRxH4yVoTHteuAS0vMB0LVXka
 ZJ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761187088; x=1761791888;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tZ1Li+zQnOnMqkypzcF/DnB9F+kM/ZRRwvZgQTomdNk=;
 b=eigk2Ants9HlTcoCcoAtanSfflfcV4VQY8i6xGlEWWIVAGhc768aEZrwFM/RSSIpFs
 uOm2+wubPhkv90cO7f5P7umfiE+daMvCoHIEbOYzc3lavk+8COdD3k6aplqgO/y3Yu9m
 uUK8vkO6cjOczPmVkgvJ2du2spARU60376SGPKWJfhThdNpR225FyC06/Gig5j94CYxb
 09a8uWXOfnbNxprocJ59L6m05jXvov/dagmVwm/MDijbXiSsSk5cnu13bqEMxttWRu4z
 wjqa4omE6LLZgB+HfaMU0piYPO9/44vLyBCzhiA58mdDEId38rM/jZhrfuIF9yKbFaaa
 ewEQ==
X-Gm-Message-State: AOJu0YzUWoLOPQkK1O0SXF27IpvUevu1w5DLGbtxT8OrvXwpOir8qMjE
 dP7iYT6aEJk4sq2Vvet4KD9AXBNam6r4JAeukeheQ6jnmvTQPVHPFQd1OHlg82BYeydFJvVUPDX
 d49TKiDB8pAzVMGwn8ZdWWwaXk2fRiHc=
X-Gm-Gg: ASbGncv7EmCJ7yxitIHBxuZAQYk36Zis1BEkBVU5qI99sMoqprB+AoE76PdQyVTyU3j
 UjzBS4G/ncnwPI+xtUDsTzBVJnIUR4Fa4GI54wYG+ol0c6ZvvRGDJtsEjcfDp9UQNqTV2TLIIY1
 14yyOlMgxioxWrkvfh7jUpm7pE7TyiAb9BlYNL9BzmfCVc3sKdh2zEsF7zUmmspeuCwkXatUy83
 7pG2xsxzTyc9KxkbUQI8V8RIgMvqm8+uUryqLNaURezf8fQVSt5L1+Yd4WBeBXEzhmY3L2Clacu
 aVcD0cLoyQ12rSg5duDA4Tw4wQ==
X-Google-Smtp-Source: AGHT+IF/R3rsoj8+SzDwYHQzXDZKgOw6k+F2OmdxvFmpd8r04zcfm5TwqDf2gTMZqn6SRhvk7zebi3LDeQEROPZkqf4=
X-Received: by 2002:a05:6402:40c8:b0:63e:1354:d9ab with SMTP id
 4fb4d7f45d1cf-63e3dff6f32mr960540a12.8.1761187087957; Wed, 22 Oct 2025
 19:38:07 -0700 (PDT)
MIME-Version: 1.0
References: <20251022024141.42178-1-jay.chang@sifive.com>
In-Reply-To: <20251022024141.42178-1-jay.chang@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 23 Oct 2025 12:37:40 +1000
X-Gm-Features: AS18NWDtuopmd2qokXK6qlDe9gMrNQpJ_2-MDEDnWQj9SQCyLakiecmbviHzYto
Message-ID: <CAKmqyKNY1W6K1E=9Y98Ou24qOn5tn00VmdWs9orE9MgAQeSJsg@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] Make PMP granularity configurable
To: Jay Chang <jay.chang@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x533.google.com
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

On Wed, Oct 22, 2025 at 12:43=E2=80=AFPM Jay Chang <jay.chang@sifive.com> w=
rote:
>
> This patch series enhances QEMU's RISC-V PMP support to conform with
> the RISC-V Privileged Specification regarding PMP granularity and WARL
> constraints.
>
> Previously, QEMU always used a fixed minimum PMP granularity of 4 bytes.
> This series introduces a configurable "pmp-granularity" parameter, allowi=
ng
> platforms to specify larger granularity values. In addition, the handling=
 of
> pmpcfg and pmpaddr CSRs has been updated to follow WARL constraints. For
> example, when NA4 is not valid due to a larger granularity, it is silentl=
y
> ignored. TOR and NAPOT address ranges are also properly aligned according=
 to
> the configured granularity.
>
> A new CPU parameter `pmp-granularity` is now available on the QEMU comman=
d
> line. For example:
>
>     -cpu rv64,g=3Dtrue,c=3Dtrue,pmp=3Dtrue,pmp-granularity=3D1024
>
> If not provided, the default remains 4 bytes.
>
> ---
>
> Patch summary:
>
> 1. target/riscv: Make PMP granularity configurable
>    - Introduce CPU property `pmp-granularity` for platforms to configure
>      PMP granularity.
>    - Default remains 4 bytes if unspecified.
>
> 2. target/riscv: Make PMP CSRs conform to WARL constraints
>    - Update pmpcfg and pmpaddr handling to follow WARL semantics.
>    - Align start and end addresses of TOR regions to PMP granularity.
>    - Ensure software can read back correct values per the spec.
>
> PATCH v3 update
> Change UL type to ULL to prevent bit-width errors.
>
> Jay Chang (2):
>   target/riscv: Make PMP granularity configurable
>   target/riscv: Make PMP CSRs conform to WARL constraints

Thanks!

Applied to riscv-to-apply.next

Alistair

>
>  target/riscv/cpu.c                | 39 ++++++++++++++++++++++++++
>  target/riscv/cpu.h                |  1 +
>  target/riscv/cpu_cfg_fields.h.inc |  1 +
>  target/riscv/pmp.c                | 46 +++++++++++++++++++++++++++++++
>  4 files changed, 87 insertions(+)
>
> --
> 2.48.1
>
>

