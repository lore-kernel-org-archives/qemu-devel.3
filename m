Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E2F0C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 00:46:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgXTT-0007Qm-Og; Sun, 05 Jul 2026 20:46:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wgXTS-0007QO-0X
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 20:46:14 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wgXTQ-00058a-EL
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 20:46:13 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-698aa7ba320so4287754a12.1
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2026 17:46:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783298771; cv=none;
 d=google.com; s=arc-20260327;
 b=o90c4hizVadrVXRyh3ucGUHmtJaB67XdE2TIxrtbDvY6yEzlgr+JMpHWGb5IrrMuhQ
 hJtLz34Nv4EYy/lTlGKnlIHfv0etmsVLMQCt0j6I75kc73/Bwr4lvqi2r3PdfGLm2MLy
 +G5gngCXzgGVkVfxGZD3O+AAhd+zzVGfeqO5cgSqer4AnfguJ4kIOpSjPb9bhwG9KajC
 d6vrlM4LhZGGUgT7wqmuqCt7JulyMR0Othf9k5PDaM2KBmp67H/gkPxpc7uiHytYlOgI
 mr3coTQ3PLdJj5CmsFHbzbYRI/vxeexxfBN3YIk6PvIJW36QMejvgzcgofYr6SRD8Ia8
 jK+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=B2FA8iGDLf9MABeDEiYb3p07hX/E50KoRlwiiqvYMlE=;
 fh=F2jHHLOhAUdxIpT/mOESKAzlhKPgUW33d0+z1UtXHTg=;
 b=PZZF1rM87Hij+DKTxAgeYBGvXh9msIvPZX2FVqI17hCEr3VHQDoUFAlquFzKBmhEXI
 tcQomChBerDa1dPsT5cAkV1X5ciFC/Lq56ZunSw7TK+tZanZtCBMSUWP31RzM8uMFpjV
 zxb58hXQjlGPleCG6u3U3D+dt3fpfX+YwCJxjTdVglXMnqx6F0QCjMbMjtW3AN6SUerv
 6Xf+XkTOB6wFPtMKy9I6E7W7TQ6D1EBvLLM1Dvl1dMW0xlObh4zQzdDFfeG1zXo8Mzvk
 uUiL6xYr7+wPvtPoSTdtFhKqfzSrvpuNyPwJghA9yHrMAgtI+xZTCGpCPqls1y4xEsa8
 PIag==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783298771; x=1783903571; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B2FA8iGDLf9MABeDEiYb3p07hX/E50KoRlwiiqvYMlE=;
 b=eir9EHjh1KPwFcmrT0u4jMiC2/hXaSztpBkPkl88OtmAnEPvxOVhHiMnv1C+IcBe0O
 DJWKTWtkkiv0Jv+77SnK00HgGkfNkwPkvWgfwedx9S9zrtj++zAtuQmRFkZjONzkosfU
 +IJ1AQ9PhAc374ogxj2O5nw2I85tLMMx1Y0WXLCJvIlPfsKu6Od+qqe3XKcZDQ4QKV/s
 jjypGDr8VQWiC8XxZ8x1HxP5xEookbKHnsyHEByJWtWzDqPMf1Aiote9sH1TMRIw/mS0
 ugtd16GYrSSV9yt+/aokGdN1Z36umKfg3oVZvtDOUo0lNvPdH/MIJjQ7UVNtQ0/zk6i5
 W9pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783298771; x=1783903571;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=B2FA8iGDLf9MABeDEiYb3p07hX/E50KoRlwiiqvYMlE=;
 b=r0moMziX1xSo4vqRvXk023AV1n1VXoRzfo396vBYS5FH1FqdRPSSyntgcXCMCjFoFV
 9gRyUUSScdIyhwnLp7fO3pHBss1NqGiULefxGTefnnGiCHV0gljKeV6lnha40rBmIXwn
 JN2FqsjjpSAvVQSHNpYlckybdk+pELwi9S0wD3i86B69geoLcdwuvHt2Qw1AFdPeUrMa
 7E9IeMNzmHpLzHc6KBW2lg5mw5aZ2UKjDkKBWk4htIGC1UYBgxYoOBiLsgttUMCjlZy+
 NhLxpTcjof/qs8KPVGYMGPn9otcpdlvd6xZTUrXd8uudjtqbl0o55Tex62zMqHMTSHkB
 jjWA==
X-Gm-Message-State: AOJu0YwHpmUjT0BRrn7PD0MZvG31ibG+5AKYWEIGxAjz07XPYql0hfPy
 HJChwUNu4/YQXvqDGrQvI1tBYl7sSUyJbpiUxHg/RscmJmi0AVYjj9/JDdVznWPihIfH3P6MN11
 qDnKDgRJ4Lo8PLdlluc+Q/RzfQB159NE=
X-Gm-Gg: AfdE7clsxzwLPHgja7dSO+1tOvQgS3xE3SgC1r6Rfr3XyquMC7EYaf2yF+r7+6NQxpz
 vCqIUQVapq6RLE3iI7+sMUrzUFTIdQevmv4d+YyrWdxiDTGZJr7qIMIgw2lx52bjmh7RWw5NHfk
 GKSOeCSs4+SHJg1Lpx0sOLr9qSbOp3uC5P1l6q4RFapyJ3q//ljiVPibNDjYunIhXiAiwtyzfdR
 Z/IP/YeljwoRSer5V/yGI7ONpBhz5oF6YB5J4Otzkx64Jja6seOTwQ7dvnGiNbdcncouRVRWn0J
 gIjJyJ1sAZkQFrVDvsTchbUA4e8=
X-Received: by 2002:aa7:d305:0:b0:698:86ce:8dc8 with SMTP id
 4fb4d7f45d1cf-698c10acd82mr3577817a12.10.1783298770788; Sun, 05 Jul 2026
 17:46:10 -0700 (PDT)
MIME-Version: 1.0
References: <20260703180538.3346781-1-daniel.barboza@oss.qualcomm.com>
 <20260703180538.3346781-6-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20260703180538.3346781-6-daniel.barboza@oss.qualcomm.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 6 Jul 2026 10:45:44 +1000
X-Gm-Features: AVVi8CeYR1Jn88ndWApj2Lert9f9rkzB7vn7Pb0b4H5mdhB_J6CJKMVIgff61bk
Message-ID: <CAKmqyKP3eHjO57v4i1Luy_v8MDHW26ha1MhKUpmrXjrCQc55Rg@mail.gmail.com>
Subject: Re: [PATCH v4 05/24] target/riscv/machine.c: do not migrate pmp state
 with kvm
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x533.google.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Sat, Jul 4, 2026 at 4:08=E2=80=AFAM Daniel Henrique Barboza
<daniel.barboza@oss.qualcomm.com> wrote:
>
> The PMP emulation isn't present in the KVM driver.
>
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/machine.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/target/riscv/machine.c b/target/riscv/machine.c
> index ba96ceceef..ef0a8eae24 100644
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
> @@ -29,21 +30,25 @@ static bool pmp_needed(void *opaque)
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
>  {
> +#ifdef CONFIG_TCG
>      RISCVCPU *cpu =3D opaque;
>      CPURISCVState *env =3D &cpu->env;
> -    int i;
>      uint8_t pmp_regions =3D riscv_cpu_cfg(env)->pmp_regions;
>
> -    for (i =3D 0; i < pmp_regions; i++) {
> +    for (int i =3D 0; i < pmp_regions; i++) {
>          pmp_update_rule_addr(env, i);
>      }
>      pmp_update_rule_nums(env);
> -
> +#endif
>      return 0;
>  }
>
> --
> 2.43.0
>
>

