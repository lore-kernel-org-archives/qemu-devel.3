Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45B6FCCFA18
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Nov 2025 23:05:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIxQW-00060f-PO; Tue, 11 Nov 2025 18:05:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1vIxQV-000609-5j
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 18:05:27 -0500
Received: from mail-il1-x144.google.com ([2607:f8b0:4864:20::144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1vIxQS-0001TU-SB
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 18:05:26 -0500
Received: by mail-il1-x144.google.com with SMTP id
 e9e14a558f8ab-4332381ba9bso1966725ab.1
 for <qemu-devel@nongnu.org>; Tue, 11 Nov 2025 15:05:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1762902323; x=1763507123; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=xu2zjvNPwfXJElMnr2ftCDAL/r+SerTzkT7dPyfJeuA=;
 b=l9uVwTPZ6bpuhpfcSv2GTcsWev5YmTfh5xPN7lTDO3GuRanUr8ilIExIeBLiUviB+s
 ImEz6VxzLkBpPw3D79fgKtzcXC9X83qgBJ1UM7xrkUbab9jxPs424WtZwb7mrRehwgxS
 gKjHc05tAwtw7I++d52DvKHtFf+8nJ9RqI9VjvfHgK3kfLGZnBF8BCv4MmikElCT8qKd
 I6fC5BNnOi3gSx41QdN0dYDip1QQVmHerQG6j/IDPOnoOc82csf7CzHv7KztBM8moVkF
 SCl3C8QKtkTshgjtIBvPcTlaiHE0aZpt7xMvFIUGU+KXo4vB55D3AQ2AYzCxeyCToVpc
 0G0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762902323; x=1763507123;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xu2zjvNPwfXJElMnr2ftCDAL/r+SerTzkT7dPyfJeuA=;
 b=t3sAqzS8X74UQTJ6oRqKBwqFCiye7+IHGZahJlsjSBakIFtKqL89FRgdKdLaAsgW7c
 qO8Fkio5wMa/XpN3eIjHzEm173Ehu8yAdTETsw23lMxSwAfM/Pi+SWofnu7JDNuRO93v
 U5ai5hqSiiNTN6MNhEMcGp8ktOUWCG4Ks0n9nJrEvjzue+J6C8Ch1WfB5n0IuBQpXqUd
 Yro///kjkEmFj2yMvwjwAT9r3Q8crgjbP8o0pKHD7Rspa+dcY5WMIlW57lHITqRhar5R
 ++QbyXLzOcpBy+j/5SqR5WjEYwOdwHhx/wKjI66/zRdlYBOCKCuyW1iCjxLe889mUayK
 LspQ==
X-Gm-Message-State: AOJu0Yxfwv6y1WenuHuOJZ3ZJtsiBjkGG6pJTuqzGmciNOQPfelCwy90
 Txjsrq7cDY7tSTBHo32yzjBFYVeUQrkdoVRndURyISerjvHkOz/eoibU5Yp7sio1pNk=
X-Gm-Gg: ASbGncv8dzA55YtEqWOoUYEIUqrUQhNScStBDWVv3AwAoNsaHv6WPbPt3wNIKg975l+
 2jMteIOeDj1pno3OpfmNNesPlWz5v9frlmyAZUuE6bMdyRIrnXf07/D6qJ/UlsRDoSj+DAmLN36
 WXrP60yhQOFCmUm+1naW43miGsQuRuFWTI4m3y1IS1a7VOVSjcsLlYngTNlH1TxI72OVhZNA6xN
 pbA3weH7QcyM7fbLIRdzlb4aUxKgpaiBRjKU9TiL2eAqRCcqRtOYpczuX2k8Acfp9fNm0ArLLxw
 jTtS6NslNjMGKPOA3+AkBu+q5ZwEpDm8yzZuIG0GJs1jkAL/gfLW8OxvjYSe8Ob1xoAZVPfWW2I
 3ZYQ23QJ7YVIbeaGn/ZgmjIMCZlXK5ECb6cG8h/d/1YOjpT4KNSlOlLgzRvfyb0fkKl9nLX/l9+
 FAHqILCOsbM5Bz
X-Google-Smtp-Source: AGHT+IFytowOARwSQiwTd9ecD8L4diQzeVskDBDMuoT0MUfBuUufpMqoY5tp1PkiNJtXrtDDZcYJng==
X-Received: by 2002:a05:6e02:2187:b0:433:3564:66a5 with SMTP id
 e9e14a558f8ab-43473d1b7d9mr13695415ab.14.1762902322735; 
 Tue, 11 Nov 2025 15:05:22 -0800 (PST)
Received: from localhost ([140.82.166.162]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-434733a3854sm3902925ab.34.2025.11.11.15.05.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Nov 2025 15:05:21 -0800 (PST)
Date: Tue, 11 Nov 2025 17:05:20 -0600
From: Andrew Jones <ajones@ventanamicro.com>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com, 
 Fei Wu <wu.fei9@sanechips.com.cn>
Subject: Re: [PATCH v4 2/5] target/riscv: Add server platform reference cpu
Message-ID: <20251111-e4f4062f326aef78ef820d00@orel>
References: <20251111182944.2895892-1-dbarboza@ventanamicro.com>
 <20251111182944.2895892-3-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251111182944.2895892-3-dbarboza@ventanamicro.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::144;
 envelope-from=ajones@ventanamicro.com; helo=mail-il1-x144.google.com
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

On Tue, Nov 11, 2025 at 03:29:41PM -0300, Daniel Henrique Barboza wrote:
> From: Fei Wu <wu.fei9@sanechips.com.cn>
> 
> The harts requirements of RISC-V server platform [1] require RVA23 ISA
> profile support, plus Sv48, Svadu, H, Sscofmpf etc.
> 
> This patch provides a CPU type (rvsp-ref) to go along with the rvsp-ref
> board.
> 
> [1] https://github.com/riscv-non-isa/riscv-server-platform/blob/main/server_platform_requirements.adoc
> 
> Signed-off-by: Fei Wu <fei2.wu@intel.com>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>  target/riscv/cpu-qom.h |  1 +
>  target/riscv/cpu.c     | 14 ++++++++++++++
>  2 files changed, 15 insertions(+)
> 
> diff --git a/target/riscv/cpu-qom.h b/target/riscv/cpu-qom.h
> index 75f4e43408..07e96a14ba 100644
> --- a/target/riscv/cpu-qom.h
> +++ b/target/riscv/cpu-qom.h
> @@ -42,6 +42,7 @@
>  #define TYPE_RISCV_CPU_RVA22S64         RISCV_CPU_TYPE_NAME("rva22s64")
>  #define TYPE_RISCV_CPU_RVA23U64         RISCV_CPU_TYPE_NAME("rva23u64")
>  #define TYPE_RISCV_CPU_RVA23S64         RISCV_CPU_TYPE_NAME("rva23s64")
> +#define TYPE_RISCV_CPU_RVSP_REF         RISCV_CPU_TYPE_NAME("rvsp-ref")
>  #define TYPE_RISCV_CPU_IBEX             RISCV_CPU_TYPE_NAME("lowrisc-ibex")
>  #define TYPE_RISCV_CPU_SHAKTI_C         RISCV_CPU_TYPE_NAME("shakti-c")
>  #define TYPE_RISCV_CPU_SIFIVE_E         RISCV_CPU_TYPE_NAME("sifive-e")
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 975f7953e1..3ddb249970 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -3305,6 +3305,20 @@ static const TypeInfo riscv_cpu_type_infos[] = {
>          .cfg.max_satp_mode = VM_1_10_SV48,
>      ),
>  
> +    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_RVSP_REF, TYPE_RISCV_BARE_CPU,
> +        .misa_mxl_max = MXL_RV64,
> +        .profile = &RVA23S64,
> +
> +        /*
> +         * ISA extensions
> +         * NOTE: we're missing 'sdext'.
> +         */
> +        .cfg.ext_zkr = true,
> +        .cfg.ext_svadu = true,

Svadu is no longer required.

> +
> +        .cfg.max_satp_mode = VM_1_10_SV57,

Shouldn't this be SV48 and then allow instantiations to use
rvsp-ref,sv57=on.

We also need Ssccfg and Sdtrig.

> +    ),
> +
>  #if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
>      DEFINE_RISCV_CPU(TYPE_RISCV_CPU_BASE128, TYPE_RISCV_DYNAMIC_CPU,
>          .cfg.max_satp_mode = VM_1_10_SV57,
> -- 
> 2.51.1
> 
>

Thanks,
drew

