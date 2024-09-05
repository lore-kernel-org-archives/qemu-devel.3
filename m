Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 531F5CD5BC8
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2024 13:46:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smCnu-0003Cz-He; Thu, 05 Sep 2024 09:45:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1smCns-0003Bt-NF
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 09:45:40 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1smCnr-0002Eo-1X
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 09:45:40 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5becd359800so788645a12.0
 for <qemu-devel@nongnu.org>; Thu, 05 Sep 2024 06:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725543936; x=1726148736; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VWyr4R+CD0xWZ0tg05S6aIejJ2G1Ekwr/jFNHZZ9iVc=;
 b=tT15NHtzgt+eKBYmchzwj/wXetoFSfzb34Wlr6Csnbt4VsKjf8vAtvjVY611hFxoFL
 UMdJhtzdferwSluwMdcpk7p+ncdY9zn5etpByOUwTpn1Pepl7mD6OJhOVIzMpfizKviO
 UjKOMhWTEC9Ly5/ls5nKuoU8V/2kr7YbeHI2FtXOzhoNEkwSH+8Vd/8YxnlczARIDGn5
 w+fyDWEGu8JF/H5FE4zUcL+2cDmhGZfDgQsgILfAsYepZgEYhBqvGyWbCDJvUlfD0b4c
 qfqD2vE+XKHgdcdJiNabjH+mVA9dXj5u0XorCoTit1hr5801EhXA1H0+DQHS60PwN/eb
 c5wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725543936; x=1726148736;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VWyr4R+CD0xWZ0tg05S6aIejJ2G1Ekwr/jFNHZZ9iVc=;
 b=fbVIDiszYCBL8PNr2eras6X43Iy19MK9hS6LN6QUt3pN+gl5rtp5If6Z9MPgVzmc0+
 LnJjnvyin5DP545uBEz7idsS+xwaaaCsHXzIjvnFq3BGN7f78KyZ0XXBUHfX+kRdJ+PO
 hiKWkFy53ZetgEWRb16eNHgasyuBdZTEjh6hfDb9crmgjVfEB8TW8cNydH96axisG/1k
 GRAmoBMJwesrIofOAgPdk6WnUhobTtlZTBC7/X9HOgtcEnFvgj/hfoi5A8RvGXf+i60u
 FSCAt17/nyx0Z9yO8yiwMpqp756L9hOby+IYZHNLXWDkK/MqCiOTNTK0ccSMm1FrGwM3
 9YqA==
X-Gm-Message-State: AOJu0YxndUTmOzvDrDrmOIa3pzZsuVta9SIcPI+NFaZuemKtmvjP5iEL
 aS/Q0I1zwuY9SWb746o2f3NvSEEvnYtLGSeci2c0uhvf//SwhPAedn1w0UgMcHQwTs99MndW5tl
 zHWPXw7e0JbqmbqzxtWEBwiEVCenuR++fkc6PM8HBJpGLwlYh
X-Google-Smtp-Source: AGHT+IF78cKJgvzfhHZvpwbayAEWjC4XfRBMrjmzUOL/F5H3/8gOxEX+Tw5B0AP5XEWZtl/zrr+nn+hh+0lFH8QKYe0=
X-Received: by 2002:a05:6402:1ed1:b0:5c3:c3f5:592e with SMTP id
 4fb4d7f45d1cf-5c3c3f55d14mr3691959a12.12.1725543936160; Thu, 05 Sep 2024
 06:45:36 -0700 (PDT)
MIME-Version: 1.0
References: <20240905112440.10438-1-mps@arvanta.net>
In-Reply-To: <20240905112440.10438-1-mps@arvanta.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Sep 2024 14:45:24 +0100
Message-ID: <CAFEAcA9KSNmqQL5AYoHg0y4mV9SJPg6-rRsp8JzWt_7q4B9TaA@mail.gmail.com>
Subject: Re: [PATCH] util/util/cpuinfo-riscv.c: fix riscv64 build on musl libc
To: =?UTF-8?Q?Milan_P=2E_Stani=C4=87?= <mps@arvanta.net>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Thu, 5 Sept 2024 at 14:19, Milan P. Stani=C4=87 <mps@arvanta.net> wrote:
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
> ---
>  util/cpuinfo-riscv.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/util/cpuinfo-riscv.c b/util/cpuinfo-riscv.c
> index 497ce12680..f4779ed1fb 100644
> --- a/util/cpuinfo-riscv.c
> +++ b/util/cpuinfo-riscv.c
> @@ -5,6 +5,7 @@
>
>  #include "qemu/osdep.h"
>  #include "host/cpuinfo.h"
> +#include "asm/unistd.h"
>
>  #ifdef CONFIG_ASM_HWPROBE_H
>  #include <asm/hwprobe.h>
> --

Hi; thanks for this patch. I think the new include line should
go inside the #ifdef CONFIG_ASM_HWPROBE_H block you can
see in the patch here, because the __NR_riscv_hwprobe symbol
we want from it is only used by code that's guarded by that ifdef.
(Otherwise we'll probably fail to compile on non-Linux hosts.)

System header includes should also use <...>, not "...".

thanks
-- PMM

