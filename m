Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4011CDE00B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 00:40:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcubo-0002ge-8U; Thu, 25 Jun 2026 20:39:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wcubm-0002g0-Uo
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 20:39:50 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wcubl-0004gS-II
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 20:39:50 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-697bd21fdc2so658561a12.1
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 17:39:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782434388; cv=none;
 d=google.com; s=arc-20260327;
 b=rJcXTXnuFjBNpNCkK8/deSbaRzT3UnGoyhcHhHI9zQbeXlLAj/NsBzh+VnxiQqkRSe
 6NemCuyuh0uLPMxIVAZGE4KpsXOClzisFWUm0o6b27Fa6m+nHLaBlW9aG/IPxhExBHFt
 b6xjKxbvU7zvJJrNzDBfE1KV5+vwm+VlehplrJBKicR19Jcr4++6YlXabLV8XL+Ey28H
 Lh7rzN9iS5zqWzLOdIcWmnOgx1ucjcNSzXGZO8tcF5+tzihmsLYBEKnaLgP+K2e/lg4s
 6v+/vOlknzfHAjK1EEct3E5f4tm83rU36X+4Ouu7J7+DpM47h5fp8EZx5UUqv9og1SYA
 6EyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=0tY7eeiHPpKhGIMhfzxHDid+o2cnG7nUgOBAi2VlDoc=;
 fh=9/4tzqKjgzJcjmYJcCvfm+LbcgW0ATp/rdwAYjKmbVo=;
 b=EFAFJJ+sV4u7UOIJIU9RHSXXreXAOjGYbhn+OX8Lgrn0AFWDUOt4ocb5C2W8VB50Ld
 8kYMLqV+knGnTLy1ah+oGvcORnvohSkW7Ql5kJ0gcRq68eDqayEnUKuQc4NHCcONRncl
 ZAkKkwFcKKO9C63hk69lZH/ModRIPx+o4kd85KZeb0LxzxDIPUbVoUY5O+SzSfnvH/N5
 TkThlZEJl1Pah4+wMDBPsIRE9gXScDrSJCYgzLUniC/rAvt+4VrzUKiiPpzJW4YtZ9oQ
 YhLXhk8izafv76Z2XSpxG9fMwoMF9mPns0J/RTau1u6nh7udcm7/NpnI7EkBSf/eTruc
 OgHA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782434388; x=1783039188; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0tY7eeiHPpKhGIMhfzxHDid+o2cnG7nUgOBAi2VlDoc=;
 b=ZSFhupl0V/Zd/xaAwUNJQ4qvYr+GnmaJt69YqakW2HXg1g63lXBgPsk6feMhx9yI76
 Yggb7SZ7QVi7fZLyCjC9jRHYdpCxODKOTgWv44Bx+syUVOoBBQlOWGCMXiOSke7WJpG2
 s6VQRJkUE3KKdv96zCFVrW+9F5dGbRYtkuxYc+IESNsXACf2Nd0/A/C3gMwjkZ4Tlj9F
 8k0B5Z5mDUWX6zkGAs3Cjs3NtgVt4SM3OGcD8h7B8J5En36cNEk824IXRSlCzucncYqh
 Dets89RZAQVcm0etq7kL0ofb5s9G3MQEc2Amb59u0dWe0Ywe9jCbx57cZwVXcTNFqBS0
 b7Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782434388; x=1783039188;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0tY7eeiHPpKhGIMhfzxHDid+o2cnG7nUgOBAi2VlDoc=;
 b=N50+OPkhnHPmmY1JY3vss/htqkIZRgb1BwRYX2MRHsl5tKcRrzGFuGCjsLaCywiS0W
 RdOJn6Gn8SsPBrA6vCasFfaGffSNdSulXxgikHbSNBaZ5wc0//xWyWtFHYL+eqjpx0Q1
 udxOr0AvcDjwGIv5LnkUuZdUGpMueTdUG/cunenOmfLjp+sESCisvYIE8e5PGY9dRaSM
 2QYFMPb5udyLrOsQY6YHkyh9Bv4ymIjogG1DUmHg4fyJmUqRQ5RNof0tVjlpA6mkYjU4
 DklPelo1CU/IpTaBSs+FII/dkMmJI/ubQR5/sK1WwE6e8NSAIe8b9FJ1aEKMkUprHzmt
 Y/JQ==
X-Gm-Message-State: AOJu0Yyxa6HZVcutzrdJBnRZtfrtA2WUIObsbznFQB34WedMt8Tc5Qd7
 LH+lORrqb0YkX3o++KnXAyJhaHbMQIXXZjt7GVf8AkP2BTJLR9uuxIrrl+vb01AXbVRzNiUmzAa
 AawZ6NujZSFZwf/LoG2ZUf1wEBHIa49U=
X-Gm-Gg: AfdE7cnlWxxQOBhqIvhWCWcMlp/KNg2Wrq/N21ZR5MoaCxjtNn0zYAwTV0S9+zclXkU
 Ddzdv5c/OMr4z+K4FLceGsOmFKb5nhoQvx3bh6NpChqXLGUYyz9mdmZ2EBXreZ2FvZxv7B3fqsx
 ac7vkW4F2LNPz+dnseOJOQ/A+7rGPoAWSOgXytdRLyy2VIa92LSNU98dSOMCDSCcY9Y1FcWHLTO
 TI7SiwZlb/IWnrET2BsZGph/tX6WrwxhUCZfDLiJzso3wJrblGtKciXvW70QszkGGh0L8iEEXQl
 ceapaM7c0lQ1iECvzamv0LwKklg=
X-Received: by 2002:a05:6402:3581:b0:691:b158:b424 with SMTP id
 4fb4d7f45d1cf-69810a456f8mr808066a12.5.1782434387897; Thu, 25 Jun 2026
 17:39:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260624000632.2149359-1-daniel.barboza@oss.qualcomm.com>
 <20260624000632.2149359-4-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20260624000632.2149359-4-daniel.barboza@oss.qualcomm.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 26 Jun 2026 10:39:21 +1000
X-Gm-Features: AVVi8CeUR4rAOilicponoAHTMt2Mi4R7Mx4j6B9es0ABeuGk3jNKiRSfjqigSLo
Message-ID: <CAKmqyKMb8gAwWe3ad=O2TOFX2e0zBfzeyPP5J+5tBggTSm5Hxg@mail.gmail.com>
Subject: Re: [PATCH v2 03/24] target/riscv/machine.c: do not migrate pmp state
 with kvm
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com, 
 pierrick.bouvier@oss.qualcomm.com, philmd@oss.qualcomm.com, 
 fritchleybohrer@gmail.com, Palmer Dabbelt <palmer@dabbelt.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x532.google.com
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

On Wed, Jun 24, 2026 at 10:09=E2=80=AFAM Daniel Henrique Barboza
<daniel.barboza@oss.qualcomm.com> wrote:
>
> The PMP emulation isn't present in the KVM driver.
>
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/machine.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
>
> diff --git a/target/riscv/machine.c b/target/riscv/machine.c
> index ba96ceceef..e1cbcaa349 100644
> --- a/target/riscv/machine.c
> +++ b/target/riscv/machine.c
> @@ -20,6 +20,7 @@
>  #include "cpu.h"
>  #include "qemu/error-report.h"
>  #include "system/kvm.h"
> +#include "system/tcg.h"
>  #include "migration/cpu.h"
>  #include "exec/icount.h"
>  #include "target/riscv/debug.h"
> @@ -29,7 +30,11 @@ static bool pmp_needed(void *opaque)
>  {
>      RISCVCPU *cpu =3D opaque;
>
> -    return cpu->cfg.pmp;
> +    if (kvm_enabled()) {
> +        return false;
> +    }
> +
> +    return tcg_enabled() && cpu->cfg.pmp;
>  }
>
>  static int pmp_post_load(void *opaque, int version_id)
> @@ -39,10 +44,12 @@ static int pmp_post_load(void *opaque, int version_id=
)
>      int i;
>      uint8_t pmp_regions =3D riscv_cpu_cfg(env)->pmp_regions;
>
> -    for (i =3D 0; i < pmp_regions; i++) {
> -        pmp_update_rule_addr(env, i);
> +    if (tcg_enabled()) {
> +        for (i =3D 0; i < pmp_regions; i++) {
> +            pmp_update_rule_addr(env, i);
> +        }
> +        pmp_update_rule_nums(env);
>      }
> -    pmp_update_rule_nums(env);
>
>      return 0;
>  }
> --
> 2.43.0
>
>

