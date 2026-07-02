Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F6ACC43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 14:42:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfIbC-0007xt-GD; Thu, 02 Jul 2026 10:41:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wfIbA-0007x1-EK
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 10:41:04 -0400
Received: from mail-pz2-x00.google.com ([2607:f8b0:4864:3b::])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wfIb8-00062o-Cw
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 10:41:04 -0400
Received: by mail-pz2-x00.google.com with SMTP id
 41be03b00d2f7-c95bd574471so384568a12.0
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 07:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783003261; x=1783608061; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=sdyciNnm/7kG67/fNn1tHNgqawBqEsjzEGL+IroabrA=;
 b=GDsH03TbQQ/ZWMwR8IBfuI+kOf/UsBb91FAR2lpbQRBtIo5nctRPvdTEuDHsHcq6NT
 XsjFFTc15rOSD8n7mXQU3wqYXIpS2WNTu1LA22AMJky7k3H0Y6/uGJ3l4qQfpC8isXMZ
 EIFRAFnAEHF47jbCDDQuZdRWb23djMr6iFttCGzIMDJSQuj5iBJns8do7iIBI6+9ixrz
 sR00R7wxb8KWH3B5mlt/qFJtHTLBXA/M77mqaHkU7zW5zRWw2rxjGT+hFkl1NuBblZbz
 UxxM1W6IBpw7AMkrpZtWK526r2Xs2GY8t5gnrY+heKYh7paL2TybEvnUSNaXJrnVQwx5
 jh0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783003261; x=1783608061;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=sdyciNnm/7kG67/fNn1tHNgqawBqEsjzEGL+IroabrA=;
 b=S399RvtKGimnyw3kqtb7TJRTAuu7yXDTYLIS2WmIRgAKvLGEEzZ7+kWKQIKX2jd//R
 NzGN66KCFByXzy9HlAO0NE80JOzLEML23HH0QQSr1mMmX5gl3KbycLSQzVjR11DjPJsk
 9sz9EvOk3HnXk4k2k2qCJp3ikmgAOx56z4n6TqyindxYmu4fUHA0aFAC1EfXJ8ET2LMz
 s449CxlbOLsx+M/CmoNtn7fxggAy0rGeCAaXGZgbiYQW5cG45SG+AaSzRRsDRShjeVf4
 pNeF/CiWHgC9nf9iJrViG7nQsC7QVNblO2wQ2a674BaVz5rNSlEaCpx9ghxIhWCM3O7q
 e0Kg==
X-Gm-Message-State: AOJu0YyxMbjqtdGb7Lo/b2GNvYzIHZNkVQiHKd2BlKqY2I8EWU8r1VHx
 g+LCnbGEOpLu8sMt92CCmiGGTYr2ZRYdcZAuCxl3nBZhuRn2vqQ9Q2lo
X-Gm-Gg: AfdE7ck4cwWfuqVc+gi3lqhgl0pmZhIkgGkj+TZ+BfhYydwGnsRlfbi69f8IHp1dU1V
 UsQk+cwcL01fdW9w7IBLD6gPkX3ZybXCnoa51buJGAtZX1WOlP1a7rwCYpChuEsLwDTEsRRa60y
 1cxJOwkHU36abBwuhHOp6CxG/lq2lqog+UPeIrEH1ucJdxkkgNBPVHGtkzWETESDqsVVfmJCcdC
 HEAPaBRjcHCXOdWznyroH9jL6Eu357hMod37QbhqllHxWpcscGngEU0q60G/NvudR/+nqK4ujjl
 3nefN6j75p9Thv0q0vtHgZOwTD3AdgoyxTJEEIu68WOgRmWqa9Ej9FIp/y5cw9Tu8kkXDQp547j
 CZiGWR7AfBrjkhr7ukjDm4rKsfKOCVLpLx2J6zVLCHHJby8J/xsySQiIVft+0vj/VtrcJcnS9PH
 WdOXMETTwaVysWgikW5Io66lgIJ/DlQHH4/0fcB02McaCr72Nrnvdr1/9sH7A=
X-Received: by 2002:a05:6a21:4903:b0:3b3:241f:66c6 with SMTP id
 adf61e73a8af0-3bff4115630mr6596391637.26.1783003260711; 
 Thu, 02 Jul 2026 07:41:00 -0700 (PDT)
Received: from localhost ([64.186.250.142]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30f116065c5sm8180042eec.11.2026.07.02.07.40.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 07:41:00 -0700 (PDT)
Date: Thu, 2 Jul 2026 22:40:57 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 andrew.jones@oss.qualcomm.com, 
 leif.lindholm@oss.qualcomm.com, uwu@icenowy.me,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH v8 2/7] target/riscv: add riscv-server-ref CPU
Message-ID: <akZ4bFNKEZrVBStU@ChaodeMacBook-Pro.local>
References: <20260610214133.1882563-1-daniel.barboza@oss.qualcomm.com>
 <20260610214133.1882563-3-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260610214133.1882563-3-daniel.barboza@oss.qualcomm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:3b::;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-pz2-x00.google.com
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

On Wed, Jun 10, 2026 at 06:41:28PM +0800, Daniel Henrique Barboza wrote:
> The harts requirements of RISC-V server platform [1] require RVA23 ISA
> profile support and others.
> 
> We're going for a profile-based implementation, instead of a regular CPU
> that can inherit RVA23, to allow future CPUs to use it internally as a
> starting base for their own extension sets.  There's also a new
> 'rvserver-ref-1.0' flag that can be used to set the extensions in the
> command line for other CPUs, which can be used for testing/debugging
> purposes.
> 
> Note that for all intents and purposes "riscv-server-ref" is a regular
> CPU and no, we're not trying to set a precedent of calling the riscv
> server platform spec a profile.
> 
> [1] defines in rule SEE_020 that we must support at least 11 debug
> triggers (4 for insn address, 4 for insn load/store, 1 for icount,
> one for int, one for excp).  We're going for the minimum.  If more
> triggers are needed users can set any trigger amount with:
> 
> -cpu riscv-server-ref,trigger-count=N
> 
> Note that N must be <= 128.
> 
> [1] https://github.com/riscv-non-isa/riscv-server-platform/blob/main/server_platform_requirements.adoc
> 
> Suggested-by: Icenowy Zheng <uwu@icenowy.me>
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>

> ---
>  target/riscv/cpu-qom.h |  1 +
>  target/riscv/cpu.c     | 31 +++++++++++++++++++++++++++++++
>  2 files changed, 32 insertions(+)
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
> index e02d53cbba..63fbc4b98e 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -2063,11 +2063,35 @@ static RISCVCPUProfile RVA23S64 = {
>      }
>  };
>  
> +/*
> + * The riscv-server-ref spec isn't a profile per se but its
> + * CPU definition can be modelled as a profile that extends
> + * RVA23, with additional things on top of it, and allowing
> + * future CPUs to derive from it via
> + * ".profile = &RVServerRef1_0;".
> + */
> +static RISCVCPUProfile RVServerRef1_0 = {
> +    .s_parent = &RVA22S64,
> +    .name = "rvserver-ref-1.0",
> +    .satp_mode = VM_1_10_SV48,
> +    .ext_offsets = {
> +        CPU_CFG_OFFSET(ext_zkr),
> +        CPU_CFG_OFFSET(ext_sdtrig),
> +        CPU_CFG_OFFSET(ext_ssaia),
> +        CPU_CFG_OFFSET(ext_ssccfg),
> +        /* ssstrict is always enabled for PRIV_VER_1_12 */
> +
> +        RISCV_PROFILE_EXT_LIST_END
> +    }
> +};
> +
> +
>  RISCVCPUProfile *riscv_profiles[] = {
>      &RVA22U64,
>      &RVA22S64,
>      &RVA23U64,
>      &RVA23S64,
> +    &RVServerRef1_0,
>      NULL,
>  };
>  
> @@ -3326,6 +3350,13 @@ static const TypeInfo riscv_cpu_type_infos[] = {
>  #endif
>      ),
>  
> +    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_RVSERVER_REF, TYPE_RISCV_BARE_CPU,
> +        .profile = &RVServerRef1_0,
> +        .misa_mxl_max = MXL_RV64,
> +        .cfg.max_satp_mode = VM_1_10_SV57,
> +        .num_triggers = 11,
> +    ),
> +
>  #if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
>      DEFINE_RISCV_CPU(TYPE_RISCV_CPU_BASE128, TYPE_RISCV_DYNAMIC_CPU,
>          .cfg.max_satp_mode = VM_1_10_SV57,
> -- 
> 2.43.0
> 

