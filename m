Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 276E5C43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 00:43:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfRz4-0003aq-UP; Thu, 02 Jul 2026 20:42:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wfRyy-0003aK-6h
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 20:42:16 -0400
Received: from mail-pj2-x04.google.com ([2607:f8b0:4864:39::4])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wfRyv-0000m1-Ov
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 20:42:14 -0400
Received: by mail-pj2-x04.google.com with SMTP id
 d9443c01a7336-2cac634f921so2377545ad.0
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 17:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783039332; x=1783644132; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=w6sgO3pxP1u1ptsEcUL8X7ENH3Oa5DPFXcfJQJ1ODgs=;
 b=OtZWYzx39a4pkm/mz008F6EWDV8qfXrkwoE327hfso+5qYxU3IJxDEG2KNGBk+5jue
 7OkMnSM2pZUupz1kwD2uevCzgQeE8Vf1Ij529yXNTJje+BWitNbGdCjaa4Lapm24W6oN
 +xSwXDhFzJuy2UsdKXgyUfcIqqJfY545OQ0oD4FqnzYyTfhEeLbXpz7UbXhcAKGjJ2vN
 LhzB4yVPK9uwp4nnxpWiMxx5Zu3EHGcS+i9yhnv2RTLV17LTj3kyparXYpNA/EPBQE/P
 PAWSVTsUcFpKdQkUJgenVql4n5gxsvoFrTlgmgTzkGFOcdy+FygI/3HWkkKtZkRXQjGI
 YFxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783039332; x=1783644132;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=w6sgO3pxP1u1ptsEcUL8X7ENH3Oa5DPFXcfJQJ1ODgs=;
 b=c3f4W/Lr/CqTYOgCpSn4qm75AP/WmsHQhYXfkLn+Amg8MtqEXP0hChzmOyB0LoAq5y
 I1lvaFCfmv2oZIolqHNw5J3qT2VssO7DtlRzxb9I7wQTZzuTzqzoXe1A0R1ZUbZbyCBS
 q102f2InjxfyjduGtyAsLPWPJK8JmatFXiTqWeRZ1dsON0zVo/bxuOxV782nEUXuF3AB
 YKzbzSaAcno6OtwN3Kd8vNGn8HgaC+NkPFKMU6mz82u5J5bIQl85dxKHfHs139dqViv/
 5mYsll+9pXIw/KnU4ggMi23gAZ4LZXEzelQM6mZ1bP9bqygVL3W4vsYgAzUtJE4rVrgN
 ZnSw==
X-Gm-Message-State: AOJu0YzJKCjQtqnSH7EDjGHy4F0v3FT4lL/TW5iYM6Q1oq49DZvYLmjn
 x+KuNARkG4jtcwxJiNAzjVUYypZmtY05do5QZe2JLo617FRYMkym9+iT
X-Gm-Gg: AfdE7ckUGA4VLYadhM+UhPS6YUEoQOvXCJpvPFyqzKNjSWg9MyQAPmdxBFaP0zbSULo
 3O8b1q0T+F+ukOpKarkt4ejqz+X+sDM5lQLaGwbxu1KHGf3uPWF8ia0xDMSffINsjciOfbPK0rr
 3Q5fUpGwv8ssyM+lZ70Phh9Ery6IygE2isdEhFPFY7dKgs8D9WmHG7b8Sotl+zsm0lf7YL9x5y3
 lr3ChzhbfIoR6mPbEJJvNoVBT/Fxh7kUYHHwKRV+RP05lXAZFoehaC3jYEeFmyroPT4sp7YjUGw
 /++tq99O/6qqD90yA8uPafdqpBH+LzbKLxKGMcs+K/URdk1LrvExwjNmHRJQnJsMmHxZwOQb40c
 i2FUXc866+xSpN9NhHydEuYBp8OaJj2OLrg24k1m7H0LPBiHHNRUkJT7xmqNs6NBUWg2me/bxTj
 aZIVrlUu0Rg0hbM7AhrNG0VUZp2JLekQWEjwenpySKBMJhjKLkg3OkILVGKOw=
X-Received: by 2002:a17:903:2f86:b0:2ca:1551:f63d with SMTP id
 d9443c01a7336-2ca7e6f3ee7mr87816815ad.6.1783039332117; 
 Thu, 02 Jul 2026 17:42:12 -0700 (PDT)
Received: from localhost ([64.186.250.142]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b3c7ef5b3sm18497931c88.1.2026.07.02.17.42.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 17:42:11 -0700 (PDT)
Date: Fri, 3 Jul 2026 08:41:53 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, 
 Peter Maydell <peter.maydell@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>, 
 Zhao Liu <zhao1.liu@intel.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 qemu-ppc@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 01/33] cpu: Constify CPUState::cc (cached CPUClass pointer)
Message-ID: <akcFRn_hnz3gwAtd@ChaodeMacBook-Pro.local>
References: <20260630220100.1289-1-philmd@oss.qualcomm.com>
 <20260630220100.1289-2-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260630220100.1289-2-philmd@oss.qualcomm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:39::4;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-pj2-x04.google.com
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

On Wed, Jul 01, 2026 at 12:00:28AM +0800, Philippe Mathieu-Daudé wrote:
> Various CPUState can share the same CPUClass parent,
> and must not update its fields. Protect the CPUClass
> by marking the CPUState pointer const.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>

Thanks,
Chao
> ---
>  include/hw/core/cpu.h     | 2 +-
>  accel/tcg/cpu-exec.c      | 2 +-
>  accel/tcg/translate-all.c | 3 +--
>  gdbstub/gdbstub.c         | 2 +-
>  4 files changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> index 59d601465b4..60a23d6f38b 100644
> --- a/include/hw/core/cpu.h
> +++ b/include/hw/core/cpu.h
> @@ -480,7 +480,7 @@ struct CPUState {
>      /*< private >*/
>      DeviceState parent_obj;
>      /* cache to avoid expensive CPU_GET_CLASS */
> -    CPUClass *cc;
> +    const CPUClass *cc;
>      /*< public >*/
>  
>      int nr_threads;
> diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
> index 9c754b03656..d7f91dce9db 100644
> --- a/accel/tcg/cpu-exec.c
> +++ b/accel/tcg/cpu-exec.c
> @@ -460,7 +460,7 @@ cpu_tb_exec(CPUState *cpu, TranslationBlock *itb, int *tb_exit)
>           * counter hit zero); we must restore the guest PC to the address
>           * of the start of the TB.
>           */
> -        CPUClass *cc = cpu->cc;
> +        const CPUClass *cc = cpu->cc;
>          const TCGCPUOps *tcg_ops = cc->tcg_ops;
>  
>          if (tcg_ops->synchronize_from_tb) {
> diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
> index 3f1a3a28438..328d96aba30 100644
> --- a/accel/tcg/translate-all.c
> +++ b/accel/tcg/translate-all.c
> @@ -575,7 +575,7 @@ void tb_check_watchpoint(CPUState *cpu, uintptr_t retaddr)
>  void cpu_io_recompile(CPUState *cpu, uintptr_t retaddr)
>  {
>      TranslationBlock *tb;
> -    CPUClass *cc;
> +    const CPUClass *cc = cpu->cc;
>      uint32_t n;
>  
>      tb = tcg_tb_lookup(retaddr);
> @@ -591,7 +591,6 @@ void cpu_io_recompile(CPUState *cpu, uintptr_t retaddr)
>       * to account for the re-execution of the branch.
>       */
>      n = 1;
> -    cc = cpu->cc;
>      if (cc->tcg_ops->io_recompile_replay_branch &&
>          cc->tcg_ops->io_recompile_replay_branch(cpu, tb)) {
>          cpu->neg.icount_decr.u16.low++;
> diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
> index c3c944e965b..26366acb674 100644
> --- a/gdbstub/gdbstub.c
> +++ b/gdbstub/gdbstub.c
> @@ -578,7 +578,7 @@ static void gdb_register_feature(CPUState *cpu, int base_reg,
>  
>  static const char *gdb_get_core_xml_file(CPUState *cpu)
>  {
> -    CPUClass *cc = cpu->cc;
> +    const CPUClass *cc = cpu->cc;
>  
>      /*
>       * The CPU class can provide the XML filename via a method,
> -- 
> 2.53.0
> 

