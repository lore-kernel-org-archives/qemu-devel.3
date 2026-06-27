Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0237C43458
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jun 2026 11:51:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wdRZ5-0007Wl-6O; Sat, 27 Jun 2026 07:51:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wdRZ2-0007WV-L8
 for qemu-devel@nongnu.org; Sat, 27 Jun 2026 07:51:12 -0400
Received: from mail-dy1-x1344.google.com ([2607:f8b0:4864:20::1344])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wdRZ1-0008Ca-4i
 for qemu-devel@nongnu.org; Sat, 27 Jun 2026 07:51:12 -0400
Received: by mail-dy1-x1344.google.com with SMTP id
 5a478bee46e88-30b6dad2382so3735232eec.0
 for <qemu-devel@nongnu.org>; Sat, 27 Jun 2026 04:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782561069; x=1783165869; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=9IUnORiluSyuZ+mbZJuXI4pqG6fp6N1DpGQoJRa4eEg=;
 b=hPWhsj3aosfmaFV1up5AQm+ooVEVqhfZ+wDVR/akS9XNXad4stNWSmio2Dxb5t662M
 8OSuoZ8K2/7bRTGHq1aYF1gzbpXKVVFLDklWKc+1iQ9znYBd/5Z7g3aOfixjdY0ymz5j
 p4MqvzaxCRM1bge80LXtYBivr3eeym45S65YTeuu306lxQvVSn+elWafC0/PcPZF4N5n
 s6ecEBztGq1QDVk9rl4OCLgL5EG4JL55QQwyIkLsgpM9ElgUV4x2qj0XkmShrFOg9OzL
 rBOpqAb7bXZszstK5lrnaZXLRAs0d3ihb7lRDqRdtTb2x028dIeQYiL1xWMm2kNuAzJW
 umjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782561069; x=1783165869;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9IUnORiluSyuZ+mbZJuXI4pqG6fp6N1DpGQoJRa4eEg=;
 b=oQRZTOa4eKcqPXNWGhOL9wKxISeLjnhX1BIM5ks3rnvLfLuAWtQllAErxcftBTiPfQ
 i0fvm+KwLuBSjl3cigCN6AnWRJtToi9ZYv6KHbfOaiV0Wf9IOVvM1pylMElLmnXrGRLq
 +O4p89FssAcS1NccM/CG0ESsLQywcWjz0stDkViC9KEJoGDDbMc1TLYVurfOYigg/aU6
 eolydm9rrw+yTycitXBPzCwuvajAQefTiSmWvIuvEZ1aE8mYHyRZ6qseSGyaf8jQO5Br
 O4KsyQwAXOpa68mxaZB4SF5m+3zOdSwvRwx0imQqBW6+MQS3F9vBvUNDReBjcN6H6hLC
 IIFg==
X-Gm-Message-State: AOJu0YzkNHyny8bmNjaZm27MYFG3x0wnrguFKgyLYAg5pJFx7CZxTMhS
 mPB5Cj6LlpL7AGs9g5WfHuTnIO7hUS/AzDnEyRh8oq7IcYAPK996uKwB
X-Gm-Gg: AfdE7ckaiySREHJh/apkdiN5Hi8IeV4AmsBpSflApEEGktPKVcUC/2eROaB6L7TNnWK
 /oZ4rbmqDo8vUKaNtVJ0IplBUifN0GUsD2cZT48Udvb0EV4kxruAhAA/iKZ3n6lrToI6/3e/49j
 /CiUPz3/WrUpS8tgbCBrB3TbkV3QtlJ9dLrK38ZCFPQk2AumY15BQ6H/1n5IJT78CNRyBwh9vmu
 OTdFxH6NAPnLlrsLJq+v+kgoJ58flLo4wi2qsxifnaGBsY9zST2sKrMKcomHN+cu57An7Tpby34
 kscnohmWT4dvmFd7hMs5pGfGut/41cykBxtuXI/loDaJxMhoIyHp8qzBCjQKdbi0YO+6YGn6Icx
 vS9OOkP6U6eKrtZc+gwVHxHq0Q2EJ3w0av8QPnuMs9VjOvS3hBGRxXP6hpnd8FfLqj1WYoiYNJy
 f4CwH38OIKKWTNq3E6/gZMC8ixKEXQ2LW4xNIJ7OuQERdM3RR8
X-Received: by 2002:a05:7300:2d2c:b0:30c:41df:3734 with SMTP id
 5a478bee46e88-30c84caee33mr10337920eec.22.1782561069195; 
 Sat, 27 Jun 2026 04:51:09 -0700 (PDT)
Received: from localhost ([64.186.250.142]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7c8afc91sm28676797eec.14.2026.06.27.04.51.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Jun 2026 04:51:08 -0700 (PDT)
Date: Sat, 27 Jun 2026 19:51:06 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, philmd@oss.qualcomm.com, 
 pierrick.bouvier@oss.qualcomm.com, Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH 04/24] target/riscv: move pmp files to tcg subdir
Message-ID: <aj-5H76DGwxXs7pu@ChaodeMacBook-Pro.local>
References: <20260622193141.1449724-1-daniel.barboza@oss.qualcomm.com>
 <20260622193141.1449724-5-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260622193141.1449724-5-daniel.barboza@oss.qualcomm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1344;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-dy1-x1344.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Mon, Jun 22, 2026 at 04:31:20PM +0800, Daniel Henrique Barboza wrote:
> A trivial header change is required too.
> 
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>

> ---
>  target/riscv/cpu.h           | 2 +-
>  target/riscv/meson.build     | 1 -
>  target/riscv/tcg/meson.build | 1 +
>  target/riscv/{ => tcg}/pmp.c | 0
>  target/riscv/{ => tcg}/pmp.h | 0
>  5 files changed, 2 insertions(+), 2 deletions(-)
>  rename target/riscv/{ => tcg}/pmp.c (100%)
>  rename target/riscv/{ => tcg}/pmp.h (100%)
> 
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index bdd28d329b..f0c78c1474 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -183,7 +183,7 @@ extern RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rules[];
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
>  riscv_system_ss = ss.source_set()
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

