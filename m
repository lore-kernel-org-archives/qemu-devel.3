Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B90DCDE008
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 00:41:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcuck-00036X-Nr; Thu, 25 Jun 2026 20:40:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wcuch-00034u-9A
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 20:40:47 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wcucf-000539-MH
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 20:40:47 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-6980ae819f4so771980a12.0
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 17:40:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782434444; cv=none;
 d=google.com; s=arc-20260327;
 b=oHUKjhiIJBeMluVqE8JnhFYmKVyOiJzHHnh3TdyGk2V4HuyvhsCUJng+Jq/FveiTHo
 Uex46HyLlZ9brMbAvTTcZcIr1vZQCste75XJcJY9kX/dz8/nYMxWq1ZGDOfc6Amwjt83
 FBFkxHaRmxKdUXaZZ/70C89XMy89w/MhpCFtTUc5IFqm3HfRaytjJ92oUckMug0DUjJI
 KI7KWlHPySaWn4lkdQpmHYKppXPaYBDh5N5C5VBbV0Ra9mWaZPqfgHmUTo3FU/cG3p02
 IFCoTYWgNlzNJdouQCaT+O6KGRJe/Sm8m5Ukawj0zGW8X6bfSMsUFDQA92kenh/X0nir
 hsEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=N2qhV9Y+dxse1YUCKotDbk0zHvgvCc4B+P1JS5wdTYg=;
 fh=9/4tzqKjgzJcjmYJcCvfm+LbcgW0ATp/rdwAYjKmbVo=;
 b=TgOKsRONJrg9fstBiN7y3nqF6bNkf4+FrF76Tgm9g6UuVCvdk7vpJdmXw7wnWIF6aN
 6BsX2UNVTbDFlLyd9/DDKn/souiq39Ur12QmIf06sjUXy8in5g+ElGDKKv2uL3Z2BHlL
 A0Hmy/jGxeJa9kE5siVjCJsk859u2Hkjxg+rtC1uM8kxDNdlpxhpIETaJSZpC0bnfmlV
 oakYA5hcYxPbqn//jXPhnyzXs7wGMNAWPqZL3UjpHJWdhv2QziiUcu/cyW/4nFm2mNIr
 UesHBy6o8hMIGhv38t0A2p8+GuL5V3Tv7RHr6N1j4lbFMHDM3lOobDoiTOPldmPWdUqM
 DsUg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782434444; x=1783039244; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N2qhV9Y+dxse1YUCKotDbk0zHvgvCc4B+P1JS5wdTYg=;
 b=a3Vx+tN9Vsv72H6+anahMlneHdouQxUIjJRgyK+YBqxFNMLliMk/fzQPbAty3uPyAf
 47xN3r7ozlqsVErwtify3nZ1X2OjfOE0AiULtZjKJRfGybMafNQhiXlb4iKYrU+RnnQq
 DU1UyPyeJoWA9nWDZtFKNGSVHVfF9QNQWfCI5s3zRVJfX5/g1kt1FeRz1KpvkD0G2dn/
 4tgk4znl1WjSAyTxRnDhImzubw1LVSNteViSfI+izterqbIhyuFST0vKnuMGS18pJnr9
 r5YM+aNCGDM1jdlJlQ8ISIOoJqK6r7eDQgcYgTEGWEGr8TkX9N/s4Ax3Y+Y540xcQ7zi
 HvZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782434444; x=1783039244;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=N2qhV9Y+dxse1YUCKotDbk0zHvgvCc4B+P1JS5wdTYg=;
 b=iSm1RQJbiRFyZnDoHidV5SriINWcAw8Gd80dqAtqidTOlYCaoNTK3fCy+Y/F3TGW1x
 ZaaSxEgmNuCRrWWd1u3DNdD+jDuZGMCDWYlhgX0l7/4+2wUibeft1Me+ptz1S5o1fMI1
 JPuuWkDzWH3etyl9xUPv4blO2oKziioqh+FXNhhprxvntt8sOULr9JuY3mj0XH5Xd6zO
 RwGKyeAo1p0ATBryZNE7WwaOTCcPFZoCz+nMTjKp4wlwt5/AvYvIXuL+tJ/ZBK6M1NWu
 MrzqpVznl7tJ/y0K7ddqQriH3W8xZYZLHb1SDFmFPWrzZ0SadrNQy/+0nJFrzEmixnCG
 xNKg==
X-Gm-Message-State: AOJu0YwelBCHKp1C98amJ67d509EBKj0miyB0MYnodj+VtM7+63KwtfY
 MT1vh1oOPmqdkZEFHeJ2zMgEFSm/r/mJWUMhZaQcIa+Wy1QQ5DdLFmn4qv/UHNEn1SOBdTxlU0d
 WvlnUDRPmc9V064CttXWQ1ePZPjiVOcY=
X-Gm-Gg: AfdE7cnSlT6ekFQvkBTl1G3YXFMNnUq0ShH+1wR+woQhcQGsBeikrNkGf5X0e6Y7Zt8
 kae8KrX1d/ywoz4jk9MFB1IzAr8FvkFwnwxfzqBO9Q6RRD27jDQ9U2UAkvnYTYDIJRHjChdwb4z
 5B9ivy86X4kf6dj8lchlk3TIP6o5pkS14AwEqrv0kGISJ9XZ2pFabzGXppCl9CcdMndjlvazH3l
 l1PLz5Y2skuvTtDl5Vvvu6KdrlC1QZWIgU1Bd7LUSIjlK6O3gN9p+mpymnyNtTZFBKrrtNK0D5F
 r9JV0NZU8FfER6uciE5aAY671qU=
X-Received: by 2002:a05:6402:a51b:10b0:698:ff3:85ea with SMTP id
 4fb4d7f45d1cf-6980ff390a8mr475358a12.5.1782434444195; Thu, 25 Jun 2026
 17:40:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260624000632.2149359-1-daniel.barboza@oss.qualcomm.com>
 <20260624000632.2149359-5-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20260624000632.2149359-5-daniel.barboza@oss.qualcomm.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 26 Jun 2026 10:40:17 +1000
X-Gm-Features: AVVi8Cd7DTvw2za95Rxq6eXcYNIJ0mG2j5KNurcJxaSQ4LlPv5SAZjy6rSL7jXk
Message-ID: <CAKmqyKO9N=DjR2ztfg9bmr551jTo4N4cK5Ktrvvxa6Hz=U11aQ@mail.gmail.com>
Subject: Re: [PATCH v2 04/24] target/riscv: move pmp files to tcg subdir
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com, 
 pierrick.bouvier@oss.qualcomm.com, philmd@oss.qualcomm.com, 
 fritchleybohrer@gmail.com, Palmer Dabbelt <palmer@dabbelt.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x52d.google.com
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

On Wed, Jun 24, 2026 at 10:10=E2=80=AFAM Daniel Henrique Barboza
<daniel.barboza@oss.qualcomm.com> wrote:
>
> A trivial header change is required too.
>
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.h           | 2 +-
>  target/riscv/meson.build     | 1 -
>  target/riscv/tcg/meson.build | 1 +
>  target/riscv/{ =3D> tcg}/pmp.c | 0
>  target/riscv/{ =3D> tcg}/pmp.h | 0
>  5 files changed, 2 insertions(+), 2 deletions(-)
>  rename target/riscv/{ =3D> tcg}/pmp.c (100%)
>  rename target/riscv/{ =3D> tcg}/pmp.h (100%)
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index bdd28d329b..f0c78c1474 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -183,7 +183,7 @@ extern RISCVCPUImpliedExtsRule *riscv_multi_ext_impli=
ed_rules[];
>  #define MMU_USER_IDX 3
>
>  #if !defined(CONFIG_USER_ONLY)
> -#include "pmp.h"
> +#include "tcg/pmp.h"
>  #endif
>
>  #define RV_VLEN_MAX 1024
> diff --git a/target/riscv/meson.build b/target/riscv/meson.build
> index 61874ed0af..42d0f6d538 100644
> --- a/target/riscv/meson.build
> +++ b/target/riscv/meson.build
> @@ -22,7 +22,6 @@ riscv_ss.add(files(
>  riscv_system_ss =3D ss.source_set()
>  riscv_system_ss.add(files(
>    'arch_dump.c',
> -  'pmp.c',
>    'monitor.c',
>    'machine.c',
>    'time_helper.c',
> diff --git a/target/riscv/tcg/meson.build b/target/riscv/tcg/meson.build
> index 5684fcf985..a05ab642f4 100644
> --- a/target/riscv/tcg/meson.build
> +++ b/target/riscv/tcg/meson.build
> @@ -21,6 +21,7 @@ riscv_ss.add(files(
>  riscv_system_ss.add(files(
>    'debug.c',
>    'mips_csr.c',
> +  'pmp.c',
>    'pmu.c',
>    'th_csr.c',
>  ))
> diff --git a/target/riscv/pmp.c b/target/riscv/tcg/pmp.c
> similarity index 100%
> rename from target/riscv/pmp.c
> rename to target/riscv/tcg/pmp.c
> diff --git a/target/riscv/pmp.h b/target/riscv/tcg/pmp.h
> similarity index 100%
> rename from target/riscv/pmp.h
> rename to target/riscv/tcg/pmp.h
> --
> 2.43.0
>
>

