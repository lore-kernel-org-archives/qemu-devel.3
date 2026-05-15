Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B435DCD4F3C
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 03:14:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNj0I-0005XL-Bv; Thu, 14 May 2026 23:14:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wNj0F-0005WC-JP
 for qemu-devel@nongnu.org; Thu, 14 May 2026 23:14:19 -0400
Received: from mail-dy1-x1344.google.com ([2607:f8b0:4864:20::1344])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wNj0D-00085e-09
 for qemu-devel@nongnu.org; Thu, 14 May 2026 23:14:18 -0400
Received: by mail-dy1-x1344.google.com with SMTP id
 5a478bee46e88-2f03d6cf77bso9934420eec.0
 for <qemu-devel@nongnu.org>; Thu, 14 May 2026 20:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778814855; x=1779419655; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=KyjJ94MLUytcJdH7VZ9HP3kWyrwG0DOWKUVVtipEco0=;
 b=d3FPjn7wmUiwmBKxWqfV2lQmXZhCV1xf5DH2bWXACsxl/FOsskJcfADBadtOLi+uDG
 +bbca+Zqm+Y8LiT/6T3ZkNBpA8QB/Ro/xooMgp6MTsEo5YSdPjz/8fSzhUfGbbYlC7js
 gwcfZaegeq3ZW5doW0k+Jfz4carzhwa0n1bZ8S5TYCMaOIM+o1XZHy6vgz3ELY7Pa/gY
 vZvNCn9ZJSbSlShIHDK5GFKsWEYPm3ZJCG57AfOFiJLBaZjGdLAyoqCgWmxQFrxWh6II
 aXBryFXq9iuvoNMCytvDX/2ew3PUfv6IlHeVl4wt2PGGzCbQQhnLKMgaCHEV/hoe3epp
 o+nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778814855; x=1779419655;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KyjJ94MLUytcJdH7VZ9HP3kWyrwG0DOWKUVVtipEco0=;
 b=U/tcmbAHjypdCy1qON3nU111RfPXsXLKQx81YQ4sTITMeJI98F4jmOoKOvyKvFv03U
 RnFZdIN+HNknCC+bvTxRcy5NrKQdxZgiMoiozx9k1Oz8f5CDcvLMc44ZA4SbFcDpjUer
 oEtw8PTbxmnYsg2swlWuhkem5sF7YilOINdms4+KgG+QCRkpqbLtuwXH9P18ujdTNVAG
 lxz68bo+Kg6aMyOTLHfdFgHlNGvr5PU+O+hd7/zKDjZ33r4Yi/yWE2A5wuIC+neMENGD
 0io80yiVpdbMxSha7siY4S2r+IbNAEonNgFeUR9SJGES23LGjf+cyaYTVx1AeQKp1BrA
 iFpQ==
X-Gm-Message-State: AOJu0Yx2aUEHpD50aeE5lMdttlt3LPYTdm0SWRhVA8CFQsPSendazmPm
 SBZmO3mJiEa7z+cpBHg1ZNzNnK1fTp/7EJAD7c0tGj5O26+mqceEfEcb
X-Gm-Gg: Acq92OFzccg9bH0+xiAlHcLv26WFY3dGFQI8FFs/s9Egi0JdbKcsJd1T01DBwRnlIEI
 SOdH6PSzvysETNEBcAzA7fyVrAs5tk1GDq7Rwvp6jDGkGkakMxs/vvc2HufXQ8GOY/SipXKPiJQ
 mUD99vcR5+HWV7I//Qa3jLRCHDacicCtfGAwPh+KpDEl2nP9Ljf8UPzexome9JYj6x1/FBhIZ9z
 nkvAfe2pIQ3dWQyJF+v6379IxDOt0iNoEpEwem0DH8MluiIugkCHgcAsVHYMS5UlfDFmtq7uu8L
 /tF3G5QjLISalmu1qLsA/c0EGZpspZ1CpVjeYF8T8mXs9RVriR4GZvvyT1Nq1BY9v87r7tAboWu
 EQebkCelAMdKPK3cu6LbcfvudmeTFcHpNJtt9Pc+0XaP7D2nBMDCa1BXNDXP9jD2g0H1un4wJyB
 IO5ELE1mTRQisbvuLsrswgyBZTV48GrTry935kgfTD2dwmrbNDwlupDndvvsCSPjqcGs8KR75Rj
 p22FEmOSv24NQ==
X-Received: by 2002:a05:7300:fd15:b0:2de:aafb:feff with SMTP id
 5a478bee46e88-3039818b0b2mr1029995eec.2.1778814855280; 
 Thu, 14 May 2026 20:14:15 -0700 (PDT)
Received: from ZEVORN-PC.localdomain ([64.186.250.142])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-302977a9474sm5473564eec.25.2026.05.14.20.14.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2026 20:14:14 -0700 (PDT)
Date: Fri, 15 May 2026 11:14:07 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 leif.lindholm@oss.qualcomm.com, 
 andrew.jones@oss.qualcomm.com, Fei Wu <wu.fei9@sanechips.com.cn>
Subject: Re: [PATCH v6 2/4] target/riscv: Add server platform reference cpu
Message-ID: <agaPcg2VZcCx4MGI@ZEVORN-PC.localdomain>
References: <20260514204640.2540054-1-daniel.barboza@oss.qualcomm.com>
 <20260514204640.2540054-3-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260514204640.2540054-3-daniel.barboza@oss.qualcomm.com>
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

On Thu, May 14, 2026 at 05:46:38PM -0300, Daniel Henrique Barboza wrote:
> From: Fei Wu <wu.fei9@sanechips.com.cn>
> 
> The harts requirements of RISC-V server platform [1] require RVA23 ISA
> profile support and others.
> 
> This patch provides a new "riscv-server-ref" CPU to go along with the
> future "riscv-server-ref" board.
> 
> [1] https://github.com/riscv-non-isa/riscv-server-platform/blob/main/server_platform_requirements.adoc
> 
> Signed-off-by: Fei Wu <wu.fei9@sanechips.com.cn>
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>

Thanks,
Chao
> ---
>  target/riscv/cpu-qom.h |  1 +
>  target/riscv/cpu.c     | 11 +++++++++++
>  2 files changed, 12 insertions(+)
> 
> diff --git a/target/riscv/cpu-qom.h b/target/riscv/cpu-qom.h
> index 30dcdcfaae..a150acd151 100644
> --- a/target/riscv/cpu-qom.h
> +++ b/target/riscv/cpu-qom.h
> @@ -42,6 +42,7 @@
>  #define TYPE_RISCV_CPU_RVA22S64         RISCV_CPU_TYPE_NAME("rva22s64")
>  #define TYPE_RISCV_CPU_RVA23U64         RISCV_CPU_TYPE_NAME("rva23u64")
>  #define TYPE_RISCV_CPU_RVA23S64         RISCV_CPU_TYPE_NAME("rva23s64")
> +#define TYPE_RISCV_CPU_RVSERVER_REF     RISCV_CPU_TYPE_NAME("riscv-server-ref")
>  #define TYPE_RISCV_CPU_IBEX             RISCV_CPU_TYPE_NAME("lowrisc-ibex")
>  #define TYPE_RISCV_CPU_SHAKTI_C         RISCV_CPU_TYPE_NAME("shakti-c")
>  #define TYPE_RISCV_CPU_SIFIVE_E         RISCV_CPU_TYPE_NAME("sifive-e")
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 586683b28a..c81aab08cd 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -3401,6 +3401,17 @@ static const TypeInfo riscv_cpu_type_infos[] = {
>  #endif
>      ),
>  
> +    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_RVSERVER_REF, TYPE_RISCV_BARE_CPU,
> +        .misa_mxl_max = MXL_RV64,
> +        .profile = &RVA23S64,
> +
> +        .cfg.ext_zkr = true,
> +        .cfg.ext_svadu = true,
> +        .cfg.ext_sdext = true,
> +
> +        .cfg.max_satp_mode = VM_1_10_SV48,
> +    ),
> +
>  #if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
>      DEFINE_RISCV_CPU(TYPE_RISCV_CPU_BASE128, TYPE_RISCV_DYNAMIC_CPU,
>          .cfg.max_satp_mode = VM_1_10_SV57,
> -- 
> 2.43.0
> 

