Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ACCEC36002
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Apr 2025 05:14:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2NkV-0005MP-Ur; Wed, 09 Apr 2025 01:13:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u2NkR-0005M3-WB
 for qemu-devel@nongnu.org; Wed, 09 Apr 2025 01:13:16 -0400
Received: from mail-ua1-x92d.google.com ([2607:f8b0:4864:20::92d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u2NkQ-0005X5-FT
 for qemu-devel@nongnu.org; Wed, 09 Apr 2025 01:13:15 -0400
Received: by mail-ua1-x92d.google.com with SMTP id
 a1e0cc1a2514c-86d3805a551so2748150241.3
 for <qemu-devel@nongnu.org>; Tue, 08 Apr 2025 22:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744175593; x=1744780393; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kTl8tRVAwmebohJC/WDgIZgSYfT+P05D0/r7L/Iwdjk=;
 b=OaJ3uY7mzgzVnMX+/B9Khainkf6AmAvTzAEhMT/i24SyZM62nNfZUO7UY9+b5CW6Dn
 hi78Veb99vAGlQwy9IuHBhom25IqhQjLmCnJ+ztplmfEOJTmp2UvHorPtz2CXcg1/BV0
 gHW7Zc3zgnvpFToFpBbdZVbXPE6gRODP7cJOJzHNmQUGhHB5/42myY61LxF7lciM21lS
 vEWEGp5c8QCriPoV3mxSGOYOWQGOiio1MNb+jYyQSsVNWRtS9ssI/4RtDGWYwjwgH6NA
 8x5X4pL0kE2JuiS4M7uIaqLvh3b4LN0LlLdHdZyCtmd3C9IVxGKwx/q5o1nUHUSZ85yS
 cM0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744175593; x=1744780393;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kTl8tRVAwmebohJC/WDgIZgSYfT+P05D0/r7L/Iwdjk=;
 b=k9jqS3kfbpMUBDEbnuHzg1CYgxR8ZWYv+3UW/n3RI90tzLfcYoeq5pnt6WZFkc7+r7
 UyeXowdyu5+EgKWTjjObSFQbinHLtiVxapfLZGplDC/Y7MezW3yi8buX6l87AgyXh/u7
 vSPHCIHy1m+4AHhutPW7nwAdGTpTVXw/9RJ/pbasD3ZIzp3ujMXNxpi+4x86PfB3qJ6Y
 yqIJdVAWQq8yPhxoDzV2cFGhKygivJNRfetCaSpKRN15Lpd4jeYGAY11H/+Ec4NG7vra
 Dm8p4uJtXDYBNOsDHo4EqAJzAYJMO44pPjNPqbB4zWn7zCd+J6XQcTl3Vu8daJJoMB8R
 s/fg==
X-Gm-Message-State: AOJu0YzDzdNvHpmuqbiHSRH5GO9CA0yJ3efkxFyPE5QtQkfPem3vtlo4
 Hbu9TA32Qmeqk6xqVKZPDOj7KX6aFjzhogKW2Hy96o+c9BFp3QyMwfvgPUfKXlj4n8npivCLzgI
 ZvcxSymTWU9uQJhXFv+PKAe49hr7oGQ==
X-Gm-Gg: ASbGncsdW4jJSTs5pom0r4EydvaSYQHc2AMf7gTyUHLJYKTEKOPpYVXeBHOK3fHu8zb
 XUbfp8HSkvMaxwkRgqNsVRJrY/ledXoM/ONbKzJ60vdP3ZoawzqqQsZRhhtNnFuadAfcHQ5oCb5
 5Eipuw2nJKkpDNy9fTA3XDGil1PqPWTYG/pvSKlMvUhjA9kzGEw6Elk8Fv
X-Google-Smtp-Source: AGHT+IH9vchDNx1G06bCQ6P1sp68pU9FVXzWeSHQZBrb9N7Ht+Ny0vHyBIaWozu2v6zhhHeqaYwCyZp/SkQTO5mCD2w=
X-Received: by 2002:a05:6102:5719:b0:4c1:9439:f70 with SMTP id
 ada2fe7eead31-4c9c6a5c796mr500831137.6.1744175593216; Tue, 08 Apr 2025
 22:13:13 -0700 (PDT)
MIME-Version: 1.0
References: <20250406070254.274797-1-pbonzini@redhat.com>
 <20250406070254.274797-13-pbonzini@redhat.com>
In-Reply-To: <20250406070254.274797-13-pbonzini@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 9 Apr 2025 15:12:47 +1000
X-Gm-Features: ATxdqUE_8BnS8aE6B4n28L-BhxXRrtEwGqoF8mTLRw4LCsjd0jJQSD5Vn3zhAoo
Message-ID: <CAKmqyKPpGudud=J-f7pYcSZmw8rPBn2PfHu131yOQMROv3ApFw@mail.gmail.com>
Subject: Re: [PATCH 12/27] target/riscv: do not make RISCVCPUConfig fields
 conditional
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92d;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92d.google.com
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

On Sun, Apr 6, 2025 at 5:03=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com> =
wrote:
>
> Avoid the need for #ifdefs in CPU declarations, keeping them
> simple.  After all class_data used to be specified for all
> emulators, not just system ones.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu_cfg_fields.h.inc | 2 --
>  target/riscv/cpu.c                | 3 ---
>  2 files changed, 5 deletions(-)
>
> diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fie=
lds.h.inc
> index ef58826b2bc..59f134a4192 100644
> --- a/target/riscv/cpu_cfg_fields.h.inc
> +++ b/target/riscv/cpu_cfg_fields.h.inc
> @@ -164,9 +164,7 @@ TYPED_FIELD(uint16_t, cbom_blocksize, 0)
>  TYPED_FIELD(uint16_t, cbop_blocksize, 0)
>  TYPED_FIELD(uint16_t, cboz_blocksize, 0)
>
> -#ifndef CONFIG_USER_ONLY
>  TYPED_FIELD(int8_t, max_satp_mode, -1)
> -#endif
>
>  #undef BOOL_FIELD
>  #undef TYPED_FIELD
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 58cc2743a53..2c2a6a4b44a 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -1486,10 +1486,7 @@ static void riscv_cpu_init(Object *obj)
>      cpu->cfg.cbop_blocksize =3D 64;
>      cpu->cfg.cboz_blocksize =3D 64;
>      cpu->env.vext_ver =3D VEXT_VERSION_1_00_0;
> -
> -#ifndef CONFIG_USER_ONLY
>      cpu->cfg.max_satp_mode =3D -1;
> -#endif /* CONFIG_USER_ONLY */
>  }
>
>  static void riscv_bare_cpu_init(Object *obj)
> --
> 2.49.0
>

