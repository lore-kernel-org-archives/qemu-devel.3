Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75588C04FFE
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 11:23:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4fOA-000601-7y; Wed, 08 May 2024 07:23:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1s4fO4-0005ze-Mq
 for qemu-devel@nongnu.org; Wed, 08 May 2024 07:23:05 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1s4fO0-0004wF-Iv
 for qemu-devel@nongnu.org; Wed, 08 May 2024 07:23:04 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a59b097b202so829476666b.0
 for <qemu-devel@nongnu.org>; Wed, 08 May 2024 04:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1715167378; x=1715772178; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=kcN7Y/e+BB6wF3Yv0mgZmYGBhTiWbBmBjUa2QDZ+Z7U=;
 b=FPq9vFSMddub/LJr8EfjPRKrHhrJheADUE9mERL5jjNljoVCAo1/MvJwM2rAE8Spzc
 whNOwZGAcK5/9r3lRexJmuM9fVF8k2mOg9w+rtibTVdNLpPSCt5FgX4RhEp/Yk31Ae+X
 k7G21FMRhaWOx7I+A5IM1rSnXjWFIsEJcXck7MgzT3sNKDtJ2sn2fWd4v1cMi3tlPTUg
 ndYlwTMHCxbxOeZ6j3blXIgbGme/hPdlnprHZ9xgmX9QMjMNH/FWbVlmXeRoC5gvf8v7
 p73DSlxoLrfW//dCWO3TJwYt3HJ6AfkXrP9kFaxtFD+RErkUWO8lqCieRMe/KVwpkg1W
 jAJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715167378; x=1715772178;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kcN7Y/e+BB6wF3Yv0mgZmYGBhTiWbBmBjUa2QDZ+Z7U=;
 b=gQDuBpKGp/dacvm/OlFVEGPBR8gB/0H7E0ysjXG9oU+xfvbi4nECUgk5cMbVrgx2uT
 tTfAmFpPYHaKQsEEEjTa4fcqRBMNLDBKzrgqOsrXbh1fwNcb50whGjUeMvMlXEVyczRD
 WAmXpIkNyxROxGrLXMjjJR/VLGSfsMpFklQXL1EmPSBgRIn6n0Uz9py/TLvhILs+K3Zh
 aD/ar4HnQKz4JPidItnbBIO8JF6S/eT4bCKJqWQfrE4X3jQHP1d0e1FBLRaRjQkWZNlG
 KNQKJJNnsx5wnkxVNTV5pdNdccOkkTpDCVWrKRL4zUkeIRvg3f0dTAfc0JE6lCs/RiCi
 uA0A==
X-Gm-Message-State: AOJu0YwZaTQMQnGqae+tXbgKzzJT9wLc0dxyKyztZjIdzVDmsHxxbJDb
 HheRJK0kcrZEKFvFD53FzyQLC2hf0xwVhcqvvvohMvu8MCaUReHD+sYbdt5CzX4=
X-Google-Smtp-Source: AGHT+IFO9hgFTZDw3DdCruT0S07pcci/crQTZMJ9xZbn9n9TUQBLUkkZIBazM4zzjURlmvd1k5G/5w==
X-Received: by 2002:a17:906:da0b:b0:a59:9f4e:4e3d with SMTP id
 a640c23a62f3a-a59fb9211bdmr137711966b.3.1715167378232; 
 Wed, 08 May 2024 04:22:58 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
 by smtp.gmail.com with ESMTPSA id
 h26-20020a170906719a00b00a59ffa4b238sm804362ejk.28.2024.05.08.04.22.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 May 2024 04:22:57 -0700 (PDT)
Date: Wed, 8 May 2024 13:22:56 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Rob Bradford <rbradford@rivosinc.com>
Cc: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>
Subject: Re: [PATCH] target/riscv: Remove experimental prefix from "B"
 extension
Message-ID: <20240508-ff6bfb7f94499a3a8d6382f6@orel>
References: <20240507102721.55845-1-rbradford@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240507102721.55845-1-rbradford@rivosinc.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=ajones@ventanamicro.com; helo=mail-ej1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Tue, May 07, 2024 at 11:27:21AM GMT, Rob Bradford wrote:
> This extension has now been ratified:
> https://jira.riscv.org/browse/RVS-2006 so the "x-" prefix can be
> removed.
> 
> Signed-off-by: Rob Bradford <rbradford@rivosinc.com>
> ---
>  target/riscv/cpu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index eb1a2e7d6d..861d9f4350 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -1396,7 +1396,7 @@ static const MISAExtInfo misa_ext_info_arr[] = {
>      MISA_EXT_INFO(RVJ, "x-j", "Dynamic translated languages"),
>      MISA_EXT_INFO(RVV, "v", "Vector operations"),
>      MISA_EXT_INFO(RVG, "g", "General purpose (IMAFD_Zicsr_Zifencei)"),
> -    MISA_EXT_INFO(RVB, "x-b", "Bit manipulation (Zba_Zbb_Zbs)")
> +    MISA_EXT_INFO(RVB, "b", "Bit manipulation (Zba_Zbb_Zbs)")
>  };
>  
>  static void riscv_cpu_validate_misa_mxl(RISCVCPUClass *mcc)
> -- 
> 2.44.0
> 
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

I think we should also either change the false to true for RVB in
misa_ext_cfgs[] or at least ensure RVB is set for the 'max' cpu
type in riscv_init_max_cpu_extensions().

Thanks,
drew

