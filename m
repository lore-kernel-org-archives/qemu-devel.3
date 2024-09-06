Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 723D6CE7AA5
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 01:30:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smNmg-0001A7-NT; Thu, 05 Sep 2024 21:29:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1smNme-00019Z-OY
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 21:29:09 -0400
Received: from mail-vs1-xe32.google.com ([2607:f8b0:4864:20::e32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1smNmd-0001wu-5d
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 21:29:08 -0400
Received: by mail-vs1-xe32.google.com with SMTP id
 ada2fe7eead31-49bd6c284bcso296621137.2
 for <qemu-devel@nongnu.org>; Thu, 05 Sep 2024 18:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725586146; x=1726190946; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x71ZqPWDKjM2kAThk+8aKjSw0auMnnz159sB53b4/ic=;
 b=AxKy+lIe1KhYEy1bSEF51sWI5M6M4LmVJbzhQ6+pDMMLwIUl2Uyqvm4EnPFHWFj9wu
 nwWfMtP0C6ggMWZLJVn38EzYeW1c9yGYw085r9Yy4JtA2H5bnJpxz5CvEc/qjG5Ta/Lx
 SxQVTxbxGtATt4BNqlAqPSwThvCGk8kg6WxZEDt/PxSUJLCav2FTT4dJLTdIwO7sG/Yd
 rcFJyPSLUs++YeiHRmjiGI95B+uN1dPNlxh0ey4xWUyp/votJ9iOjBTbg4DoOJyM4ZEN
 iD7kpgU/5E365DrWESWZHt/M1UNvGbEejADOEiEn9fVZlGKPFEts82YfDdlIXgqfXxWY
 6pkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725586146; x=1726190946;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x71ZqPWDKjM2kAThk+8aKjSw0auMnnz159sB53b4/ic=;
 b=dmKrW0Qd4hwj0zVLoUKINOLVPxN4tPT5PA1NczUpQhquwoWM+6ykVVDUPwVqE7GN1X
 c1gPgnOtdSHButP8pACjPDTn9ZVVpg0kdrCAMOsF6PfRoU6a7ZtSV44SfkDtNvup6DSB
 nlsgHfVYjeLiKbDjuE8Mg7AMeDWFJx4Z43Eu0+d6b4Gb9hCfXJz+wIKWu24pAk+kcdq+
 XKuJHTsV/hrxkGv4GJYr3jJ1IDBTJIikUQBY7r+YynQoV7lpdb2GveMvJ+tWiqfKS8pn
 5CFEbn/uaTXaEpLiU//c1RxRO6YrmYj1GE8gsBupGqDMdFthN4uvztyoK135fTpSoa4c
 y0fg==
X-Gm-Message-State: AOJu0Yymuasp52Ee7Uljg8VL12X8CmAIk/duj7Xb6Aqa5LWlnmplrT6Q
 GJ92gB1hJuCloWyUeclMS4WOyqNUZo8wGzXm4O5SSIBvZ0UbZKFH+vjxAMg0z0D8a3yX4Wg7Et7
 vtXfNT58V7xQL3zZo8ZWbeygkm6E=
X-Google-Smtp-Source: AGHT+IGHY3dMPX3jl8QKP+CjyV0+GbGnHVNPNqy3l5+Ks7wPs2hKJvRI5zPVjBeaIAlieFmH8p2cLLeVwkyd/nI+pxo=
X-Received: by 2002:a05:6102:4412:b0:493:9781:11a7 with SMTP id
 ada2fe7eead31-49bde13d6aamr1272510137.1.1725586146002; Thu, 05 Sep 2024
 18:29:06 -0700 (PDT)
MIME-Version: 1.0
References: <20240905150702.2484-1-mps@arvanta.net>
In-Reply-To: <20240905150702.2484-1-mps@arvanta.net>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 6 Sep 2024 11:28:39 +1000
Message-ID: <CAKmqyKPwZPS0N29ANk0LEMoUHaNCH4z3cBE0OzjhCvuBA8AanQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] util/util/cpuinfo-riscv.c: fix riscv64 build on
 musl libc
To: =?UTF-8?Q?Milan_P=2E_Stani=C4=87?= <mps@arvanta.net>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e32;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe32.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri, Sep 6, 2024 at 1:08=E2=80=AFAM Milan P. Stani=C4=87 <mps@arvanta.ne=
t> wrote:
>
> build fails on musl libc (alpine linux) with this error:
>
> ../util/cpuinfo-riscv.c: In function 'cpuinfo_init':
> ../util/cpuinfo-riscv.c:63:21: error: '__NR_riscv_hwprobe' undeclared (fi=
rst use in this function); did you mean 'riscv_hwprobe'?
>    63 |         if (syscall(__NR_riscv_hwprobe, &pair, 1, 0, NULL, 0) =3D=
=3D 0
>       |                     ^~~~~~~~~~~~~~~~~~
>       |                     riscv_hwprobe
> ../util/cpuinfo-riscv.c:63:21: note: each undeclared identifier is report=
ed only once for each function it appears in
> ninja: subcommand failed
>
> add '#include "asm/unistd.h"' to util/cpuinfo-riscv.c fixes build
>
> Signed-off-by: Milan P. Stani=C4=87 <mps@arvanta.net>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
>  util/cpuinfo-riscv.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/util/cpuinfo-riscv.c b/util/cpuinfo-riscv.c
> index 497ce12680..8cacc67645 100644
> --- a/util/cpuinfo-riscv.c
> +++ b/util/cpuinfo-riscv.c
> @@ -9,6 +9,7 @@
>  #ifdef CONFIG_ASM_HWPROBE_H
>  #include <asm/hwprobe.h>
>  #include <sys/syscall.h>
> +#include <asm/unistd.h>
>  #endif
>
>  unsigned cpuinfo;
> --
> 2.46.0
>
>

