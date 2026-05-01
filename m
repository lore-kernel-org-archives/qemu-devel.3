Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36A3FCCFA13
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2026 13:24:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wInqN-0003kK-QL; Fri, 01 May 2026 09:23:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wInqM-0003k3-9S
 for qemu-devel@nongnu.org; Fri, 01 May 2026 09:23:46 -0400
Received: from mail-qt1-x844.google.com ([2607:f8b0:4864:20::844])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wInqK-00014I-Ox
 for qemu-devel@nongnu.org; Fri, 01 May 2026 09:23:45 -0400
Received: by mail-qt1-x844.google.com with SMTP id
 d75a77b69052e-50d7c12e48eso15834971cf.1
 for <qemu-devel@nongnu.org>; Fri, 01 May 2026 06:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777641823; x=1778246623; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=FNcFahTEu+4OqYJLNslC+9xgjNYdC1zmgAZc5D0sDCM=;
 b=JjubhIOgT7DnUfIGwyQIq7H848GMY5Z8fedxPeb+GDcjwLonsXESHZ5bye+ifPHYmr
 sxkF6LQ2VH078aiPY+W7J7WCnZNT/r0GNGArlb74P8b0uB4t2gBl9/pJ1sbY/ukp1euP
 G1tfkMj5CyXPB1lF9O+HR0fagi8jXd5euDmk2G7OxHjgmgWMnLVaf7FAUcscmxGYxvz+
 eIum9FU4K+Nqpjx56tg/LNNFkvrQTw0EpT9Db0wP2oaEjN0CyA2pOTdcMOWBV3UDm53q
 hr13Fa8U/q0yxPz4LwhlOfttuvzC7SJM9i3AKu5gDu6g2/alC9UyzuYfZqulMImnWrl6
 KOOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777641823; x=1778246623;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FNcFahTEu+4OqYJLNslC+9xgjNYdC1zmgAZc5D0sDCM=;
 b=LdRjDvq3xUMq7YSeT8TQ8L17sNLL1YsS6HN19D/jubgTUATSQWRnP6sav2sW9itPFN
 AxE0+8dJvnB6HJJpxdMw5fYtuRGuE4Pu8PHrOwEi7FHqv+CD2gjQ7Os9Y1KmyfT17HJQ
 +WrPLRlDOymmbTPB5LzU5vu183MOD9mkE6tJeVWaHSS+Z7pziDa/+VHCrvfqo29uFGlw
 0Mj3QiFTyqqwc8YxSgesAih62KtXVSi6RCNNfX2q65nkZ2YeU6VA3uwOJpCNkpBdVFtr
 30w6vnIDKWiTExSMYx43puaaOWGUulTTqP2iK78iSMp5W/qrW9tt8OMuEllCWdAUyNd+
 vL+A==
X-Forwarded-Encrypted: i=1;
 AFNElJ9k+R+/lNBwDDQN4GETOxRZlj+D9WkLzhGTzq6pu2D3nmW60/Cynb6K/Av7LvSQDEsvjA6DRMTUVSr1@nongnu.org
X-Gm-Message-State: AOJu0YxIqKek2wBPV+qpYK0513TfNnmZi7Tf3hqg4fiUMyhCp5XuQV0S
 Ky+r/GdiBqXANxF8PKEYKbL/X6gOkEt+VrYOPJT3jh+wahXhFwcb3ziF
X-Gm-Gg: AeBDieuRqYG96ERJOIUH0RgnTdVxM+Ne/x3TgaYg/XRRvx8J8dAsSIKkKAU3AAJGbVN
 ZVcZWh6gTHqkllo+8g0pBQa1d5r8cxtkpFxZ2aW84dv1lFRFChejPr7Gj1kmuC+MzofZLSLtdWh
 izvunlNJGk3M49QXll70ZGKZDhUyzKNxJXHRO83P77vwuQiw/RW9cDxnyHSVUfwIQbUSxoSlzya
 V7M7tkWLFHqGMHRo2arVpnJmtr/PBfGCO4+/gyveqteRzd8FVNWbSX55CNia+UzOpiIb8cuMrQP
 w5IPZawT7W9A6BBZR373yb0e9bp0cjioFEr6Vtgbp1qtY4oi7T51ZOo4EBH1l/UNKtGjd3NID2i
 5dN8WzBk0lZ6J7oU2QzvUeVgBpMhwlucFvUsEAgzweQaOHYgorJtHQ/G/f5xq2M4AWOyLowIrd8
 wLuoTVIVJyEDUfPElT4GvbRKDtjpF1lSLT1tsu0UGTeN5/HR4Rb6kfM1Vb6/2w8rY/if/UN8hkL
 nno1YFTig0=
X-Received: by 2002:a05:622a:d11:b0:50d:7a0f:faef with SMTP id
 d75a77b69052e-5102d1d0c5dmr67818571cf.22.1777641823161; 
 Fri, 01 May 2026 06:23:43 -0700 (PDT)
Received: from ZEVORN-PC.localdomain ([162.244.208.119])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b53d0702aasm25371056d6.43.2026.05.01.06.23.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 May 2026 06:23:42 -0700 (PDT)
Date: Fri, 1 May 2026 21:23:26 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: alistair23@gmail.com
Cc: palmer@dabbelt.com, liwei1518@gmail.com, 
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 qemu-riscv@nongnu.org, 
 qemu-devel@nongnu.org, Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH 1/2] target/riscv: Remove spike as default machine
Message-ID: <afSpPEjo4BLEzirM@ZEVORN-PC.localdomain>
References: <20260430052218.771358-1-alistair.francis@wdc.com>
 <20260430052218.771358-2-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260430052218.771358-2-alistair.francis@wdc.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::844;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-qt1-x844.google.com
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

On Thu, Apr 30, 2026 at 03:22:17PM +1000, alistair23@gmail.com wrote:
> From: Alistair Francis <alistair.francis@wdc.com>
> 
> In QEMU 10.0 we deprecated the default spike machine, let's finally
> remove spike as the default and require users to specify the machine.
> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>

> ---
>  docs/about/deprecated.rst | 19 -------------------
>  hw/riscv/spike.c          |  1 -
>  2 files changed, 20 deletions(-)
> 
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index 10de10dc23..f3622dcf93 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -282,25 +282,6 @@ firmware is available to boot it. It can be replaced by the
>  ``ast2700fc``, another multi-SoC machine based on the newer AST2700
>  SoCs which are excepted to receive better support in the future.
>  
> -
> -RISC-V default machine option (since 10.0)
> -''''''''''''''''''''''''''''''''''''''''''
> -
> -RISC-V defines ``spike`` as the default machine if no machine option is
> -given in the command line.  This happens because ``spike`` is the first
> -RISC-V machine implemented in QEMU and setting it as default was
> -convenient at that time.  Now we have 7 riscv64 and 6 riscv32 machines
> -and having ``spike`` as a default is no longer justified.  This default
> -will also promote situations where users think they're running ``virt``
> -(the most used RISC-V machine type in 10.0) when in fact they're
> -running ``spike``.
> -
> -Removing the default machine option forces users to always set the machine
> -they want to use and avoids confusion.  Existing users of the ``spike``
> -machine must ensure that they're setting the ``spike`` machine in the
> -command line (``-M spike``).
> -
> -
>  Backend options
>  ---------------
>  
> diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
> index 35c696f891..87fe0f242f 100644
> --- a/hw/riscv/spike.c
> +++ b/hw/riscv/spike.c
> @@ -341,7 +341,6 @@ static void spike_machine_class_init(ObjectClass *oc, const void *data)
>      mc->desc = "RISC-V Spike board";
>      mc->init = spike_board_init;
>      mc->max_cpus = SPIKE_CPUS_MAX;
> -    mc->is_default = true;
>      mc->default_cpu_type = TYPE_RISCV_CPU_BASE;
>      mc->possible_cpu_arch_ids = riscv_numa_possible_cpu_arch_ids;
>      mc->cpu_index_to_instance_props = riscv_numa_cpu_index_to_props;
> -- 
> 2.53.0
> 

