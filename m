Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DD5EF94CDE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 08:25:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFStR-0008Qw-Il; Wed, 22 Apr 2026 04:25:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wFStQ-0008QF-8O
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 04:25:08 -0400
Received: from mail-vk1-xa44.google.com ([2607:f8b0:4864:20::a44])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wFStO-0007TC-MY
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 04:25:07 -0400
Received: by mail-vk1-xa44.google.com with SMTP id
 71dfb90a1353d-56d93355337so3230824e0c.0
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 01:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776846305; x=1777451105; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=lewLsNPUZWdfGM3DgYyaa0oNCz6045ebqGs4+kYySYw=;
 b=NjtPOgTaaW4KWfCmW8n8JHwBjAnOWzS9KjddPrdJrhDT16+676FkS3RpbGgAM5+K6q
 oN+NU75qrYOTwudicDV+Y5hr01pWLHxlZHifsjhOIrWpAwHRweMiSMP326icBPTOXHXE
 4qrnk0amX5+/vLsghaL3cPFHV1R9ijpNIYVm4GcsqlrpjqIJBLMl+is0VKB9MEcwy5eM
 0JPAKdQxMwNuGmKV2CfgEL+kxqMjf33Y3VDqVk1Jo3YclMnpGno8yp4fSfoU/wSgrNfH
 V7QTcexO4IX0BoOQ3FPo8XEx4VQBc1BavqEXz+BN/n+QBrkjE+ei4LhfqGxWefPz9F6P
 QfgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776846305; x=1777451105;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lewLsNPUZWdfGM3DgYyaa0oNCz6045ebqGs4+kYySYw=;
 b=PXFuXXfhPU9d57Au2f1Do8eOz8seZHoz26Hx+obrjyU4YoXIVz67RIBH8zXh63Hhdu
 3bFS4Yp+6sj+DmkcbUne5xlZtAXl/Ew8zntgZRIFN9nT9ZN/bzcBAPVVmylbGmQtsLI3
 Pf9SP5Wn+taMyV0NbI5iP1SapEMDHMD6tS4t8rOtHZQtI6sN4cgUNheWD88HHrLSmYBF
 zl7PVj+HZMe62Rs3qdJVX3nLI2MH/0HlDO7Ck/kp6EVz+oRj+yEikWSytYJkJf8WVuNg
 McLjiBiybOFY4AdD6oHTFSljJFXzqfUecQjwerTtMYj5IM5RkyQVkPEEOGhBE9F96B8n
 08TQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8XdlK0xefKX2wDYmpyKopfH7eqPGj5O9EXqs4Y6x+22A+mIE6q0D7ZsCmglex5pVQfIHWmFEJbf63V@nongnu.org
X-Gm-Message-State: AOJu0YxcR2rkHk7HDVqzTXypzUJgPs8nZI1uZTCI0w6QhOkB7K1MOq1p
 xC0BQdflMAHV8ahUOc9B665knOPAKdvt5LzfvvfYjZdMOrzsqXBenTWP
X-Gm-Gg: AeBDieuDa3usbzfTqdJPw47sdkk3Frwr6+70Ja0b1dIlmB94I9BC2TKueuvnv7xGgV1
 HYmCQaSM/YW74GOIeM7Y0tTOeY0kLq21rLcKxfCyHxIAjbTE29j+fmAGs2KW8NFU51nTyoaHMMr
 S97U4S85tKIwMH9EozLfSZwpN2h63+W35j/IXE55QLUUj3+dge3nXusiqN+Tmsnqs+XMyjF4eLH
 NIiefEhNHP03nZEc6IkZdElLUMru4Up3kR7hPZnIvQhlCu4ouCn+l9oml5SnoGDmw3IYO4J1qeH
 pr0xP8MCmZONxt6CdZM/eWGNfRKb8O8EVJgM0k7UMYlZvgI9Gw/RHt3QaCD5IdyKA+5R1wiDnfQ
 x0D8KewqPkfLD+lfiefQhtBMXXtk8wM/SBlDgtfFdO0+N7xurN78zLBwjw4qLxMO9bbZbgLD2TR
 Ytm5eaSeb/aIt+MvE2+ewIvUyMZzknlXDFJkDlNsZ78lmMTxN5W0vpEOrBSmNQ2BJ9fEBIoXCml
 KuQFBjSY1I=
X-Received: by 2002:a05:6122:82a9:b0:56f:b0bd:2276 with SMTP id
 71dfb90a1353d-56fb0bd24ddmr9955559e0c.0.1776846304719; 
 Wed, 22 Apr 2026 01:25:04 -0700 (PDT)
Received: from ZEVORN-PC.localdomain ([162.244.208.119])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-56fa91ed4e1sm9963728e0c.6.2026.04.22.01.24.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 01:25:03 -0700 (PDT)
Date: Wed, 22 Apr 2026 16:24:48 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Joel Stanley <joel@jms.id.au>
Cc: Alistair Francis <alistair.francis@wdc.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Nicholas Piggin <npiggin@gmail.com>, 
 Michael Ellerman <mpe@kernel.org>, Joel Stanley <jms@oss.tenstorrent.com>, 
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v3 07/13] target/riscv: tt-ascalon: Enable Zkr extension
Message-ID: <aeiFt7xWPZboWVH5@ZEVORN-PC.localdomain>
References: <20260421053140.752059-1-joel@jms.id.au>
 <20260421053140.752059-8-joel@jms.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260421053140.752059-8-joel@jms.id.au>
Received-SPF: pass client-ip=2607:f8b0:4864:20::a44;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-vk1-xa44.google.com
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

On Tue, Apr 21, 2026 at 03:31:32PM +1000, Joel Stanley wrote:
> From: Nicholas Piggin <npiggin@gmail.com>
> 
> Ascalon supports Zkr and the SEED CSR.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> Signed-off-by: Joel Stanley <joel@jms.id.au>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>

Thanks,
Chao
> ---
>  target/riscv/cpu.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 72c6f4f0f14b..df01a729bc6d 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -3189,6 +3189,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
>          .cfg.ext_zba = true,
>          .cfg.ext_zbb = true,
>          .cfg.ext_zbs = true,
> +        .cfg.ext_zkr = true,
>          .cfg.ext_zkt = true,
>          .cfg.ext_zvbb = true,
>          .cfg.ext_zvbc = true,
> -- 
> 2.47.3
> 
> 

