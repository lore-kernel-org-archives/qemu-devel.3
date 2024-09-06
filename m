Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B0BFCE7AE8
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 08:59:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smUo9-0003pH-HY; Fri, 06 Sep 2024 04:59:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1smUo5-0003jo-St
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 04:59:05 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1smUo4-00013B-30
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 04:59:05 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5c3d8d3ebbdso1926371a12.0
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2024 01:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725613142; x=1726217942; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wtHf3+DsGJifKQm+AitO1ZYVPBFoTyKb/UMXJh0snwk=;
 b=xePfW/uimQgfgIXSi1tXsdafKDkjJ0zmM/Ny42jxEZtnipY4fm0GsrtwdTTzUqwzuM
 qGtIAA+t+wzUC+Aw69aTzwNQr39HoweO9v+gqd29cxMO/2H6kAgXJxG+uzrRcsVpcOEV
 TMDke8qlrcclFjBezTA5pY3nf5deMoJ56n+Z3dKU9l4Nb1/0F+eIe5gJBwJg8WrU48nV
 RsVieta8kB3jOOiwkFPUYqGgZlrJ9VwOMBCrQ0DUIH3eBl8pZfRuD73S7LMLhiIS4LN0
 51M+1bCVslyr+anOyhGoFBgyL+MwPfZ7VMl14/uTT2Xc7r6Cxc4/PhT8goHbq6tFjuP9
 zojg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725613142; x=1726217942;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wtHf3+DsGJifKQm+AitO1ZYVPBFoTyKb/UMXJh0snwk=;
 b=qpmpkOqbr6vuPlSr15Bd4JJ9FsYmNs7TfhGAxFcbWyDNd8AffmrW3BjJbPXd6E5LP3
 RHfMD57Oj20yTYD1MqXOw7ZzVG1d1n3ZWR83auhXBKPdZrGTxENoQfh0w7kAoo+fxSVx
 zpDSfOM5bjHWx8zOuoZa2eDmirKBsBirj0MiUQQNyOBJleYkbYLehxK956BHCp03ssMD
 LiR8qUBnbbAIbZklcLjjCjG+0Tl6O1W/SAafZC1en3bzNwqKcHzMGz1L64pHgeQ8t7b2
 8fI7y4ZkeFolo6JtiFq0ny4SC0FWYJYNA3JFIthtuWItxX0NLnqMf74Izw+2ELsc6Pcc
 c7ew==
X-Gm-Message-State: AOJu0YxMPRJkAxctMfCynkeOn0bHiSm1NuY2rK1sDwpUvT1ImbqTuJPT
 0GVwxXZ+wiwjDCbCSGtsIQ5+7ahJLF+rRPTV05ZtCNbW6EuhzCkQZ2Tmrm/IqXMUoBnXP3Hl+Lx
 gl0Nl6ro7zeRTK6jyVqgC+qh0fTw/QuH66oj3xw==
X-Google-Smtp-Source: AGHT+IE4nbPm+TFh+fhiLKTOfnCV9yKfeQnxpbDES6JqHvbAYIa3KzDMkdOpMEB7fyW0yyrx6xdm/sEz4zYMDXGEv24=
X-Received: by 2002:a05:6402:4345:b0:5c3:ce35:d165 with SMTP id
 4fb4d7f45d1cf-5c3dbcbfa24mr2045468a12.12.1725613141548; Fri, 06 Sep 2024
 01:59:01 -0700 (PDT)
MIME-Version: 1.0
References: <20240906080928.710051-1-thuth@redhat.com>
In-Reply-To: <20240906080928.710051-1-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Sep 2024 09:58:50 +0100
Message-ID: <CAFEAcA9b5V8xY0bOn7VdMUuuhSsBF8xmagYxqhgzAyXbFjLNrg@mail.gmail.com>
Subject: Re: [PATCH] target/riscv/cpu_helper: Fix linking problem with
 semihosting disabled
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Fri, 6 Sept 2024 at 09:09, Thomas Huth <thuth@redhat.com> wrote:
>
> When QEMU has been configured with "--without-default-devices", the build
> is currently failing with:
>
>  /usr/bin/ld: libqemu-riscv32-softmmu.a.p/target_riscv_cpu_helper.c.o:
>   in function `riscv_cpu_do_interrupt':
>  .../qemu/target/riscv/cpu_helper.c:1678:(.text+0x2214): undefined
>   reference to `do_common_semihosting'
>
> Avoid calling into do_common_semihosting() if the corresponding Kconfig
> switch has not been set.

This would be inconsistent with Arm, where you always
get semihosting if you're using TCG. (For KVM, semihosting
is up to the kernel to provide, which is why we don't
want the code in that case.)

> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  target/riscv/cpu_helper.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index 395a1d9140..c7a6569e2d 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -34,6 +34,10 @@
>  #include "debug.h"
>  #include "tcg/oversized-guest.h"
>
> +#ifndef CONFIG_USER_ONLY
> +#include CONFIG_DEVICES
> +#endif
> +
>  int riscv_env_mmu_index(CPURISCVState *env, bool ifetch)
>  {
>  #ifdef CONFIG_USER_ONLY
> @@ -1674,10 +1678,12 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>      if (!async) {
>          /* set tval to badaddr for traps with address information */
>          switch (cause) {
> +#ifdef CONFIG_ARM_COMPATIBLE_SEMIHOSTING
>          case RISCV_EXCP_SEMIHOST:
>              do_common_semihosting(cs);
>              env->pc += 4;
>              return;
> +#endif
>          case RISCV_EXCP_LOAD_GUEST_ACCESS_FAULT:
>          case RISCV_EXCP_STORE_GUEST_AMO_ACCESS_FAULT:
>          case RISCV_EXCP_LOAD_ADDR_MIS:

If you do want to do this thhen this isn't sufficient, because
you would also need to change the code that generates the
RISCV_EXCP_SEMIHOST exception so that it instead generates
the "behave as if we don't have semihosting and the
semihosting-trap instruction sequence were executed "normally".
But I think the best thing is to use "select if TCG" in the Kconfig.

thanks
-- PMM

