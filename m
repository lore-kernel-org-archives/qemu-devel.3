Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48BEECD4F3C
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 09:27:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOuF8-0007wu-EU; Mon, 18 May 2026 05:26:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wOuF1-0007u1-99
 for qemu-devel@nongnu.org; Mon, 18 May 2026 05:26:29 -0400
Received: from mail-dl1-x1244.google.com ([2607:f8b0:4864:20::1244])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wOuEy-0005JZ-NQ
 for qemu-devel@nongnu.org; Mon, 18 May 2026 05:26:26 -0400
Received: by mail-dl1-x1244.google.com with SMTP id
 a92af1059eb24-12c1a170a50so2310180c88.0
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 02:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779096382; x=1779701182; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=n4tXgZ2VdfVwuoR7ZcesJszIB7OmCKdkbiXFP2nJs+s=;
 b=lZYeH5Kp5Vcgsg4pvKeyvJIJgmYdyajjKs9A/Ei3XDL/XTIiXlyvJZ8S9BWNUPUOH3
 5gb4BfVngOSfzkg8R1sxI3BWR/iP2qa2TG/1nbDmzWQmOX8Ap5UQSPILPG/F5sffWHHm
 EXbHsyBbyXB1605PPR5BbnxJKzQqn53FaH2KQJDSR+Ci5mGinMKvw2XidVDebrvvEkUK
 K3kRquSBZclpPB5Pnkz1SiprCP52W2+8LrGlKZpLgOiTtdTud46jCiNd9Pg5oO3D5Zbg
 yMiKPy0Nq/Jz3gQ1ajREkzESqnA8eeqgNwFKFQt75yfUrhUuZTcCdl/2B2V94noyQcTn
 NHvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779096382; x=1779701182;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=n4tXgZ2VdfVwuoR7ZcesJszIB7OmCKdkbiXFP2nJs+s=;
 b=kSQHxWE04uq5rlssWF5r6z2DZOaMXeUEHvD6u3U8OlfbldacDCKZ6foVmvrzDiD++Y
 7W0jbOvNAsJnBHRD/NQdDwx5EA2ZuAhQmoWY2WN4af5i6J8nY+TaIpoCMBYauGZQLYwJ
 NUuSY0SS57JAYmIRNTfXJ3U9mttEV9vvYZy+/n/YeMViSF3a/BXG0Sw7e+j97n0D68wP
 UJRt9B4nR9kTT8II3budj7ZVUGS3+fC3iA6DCuelNGOsVLhP4CSZOV2F3cYI67x+/1Bq
 TY9TmcIgscWlMGDcbhCdbOMANa0LDVjm96nOOeU3VPALiY4DVBo77L6mp88HnLw+Hi6H
 6fhQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/q5d65TT1vlf3C6TVpzKWmuRTtP4OQHGhWwNIND3mqKGhA5Sn91GDxv8iESrqK+ha8uAAOKrfZTcvo@nongnu.org
X-Gm-Message-State: AOJu0Yz5vqwjkWQy3csVakLG7XKRD4b1pY91D6EBLrWOLAItwaaCSiYA
 GTKrNqd+J8Kv/1bPuxB9bQDxRpBBWB/6Zgbo00r+ajjrEVpLqgXCfSgm
X-Gm-Gg: Acq92OFUQGvAUBkchtcus9nwJUzUN8z7QiBzktpjZqMVCxyJnPOLtDNFA17oWkXzOP1
 MwVi0pAy16SeqzdDxvC7Zf5if/aOQAvIcVUocCtAZHDPkD7ibWbY8VmU10WAY4HTKbGV3bZtT0G
 fsON3uMFbY/0QasOVYRzOBgKxH2iw0nUFWGBFbn51EOM1D6BvHgxwjAx5WAL7r8yyJJy5WuzaNC
 oDPS6dJmr0gUC9Idnmvp5eS8VNZUX3x4w/h2LehuYSJ92uZpBLx18SPXPDbhBZcC6gzzuxeX0E+
 tNfPmWiBWpl317jNPMIwryMqTSvSQovVS1RJBDU3KJZw/PTxKpv+2iwVcmvqIIfkEEbngVP/63Y
 AhUzVi3TH1mOFozZmPXY8LEIv5RsoJHfNfb8nb9nhOb7xxKYlE/Do4qn529VdopLLksu4Z0U+xu
 CqppiGQKOFCBMGPkhVkfXjb9xa4aDNRXnIeAK6dl6bJjfJND4ABOwT9IkJV/w=
X-Received: by 2002:a05:7022:6992:b0:132:956b:3c6 with SMTP id
 a92af1059eb24-13504947ba7mr4588572c88.33.1779096381359; 
 Mon, 18 May 2026 02:26:21 -0700 (PDT)
Received: from localhost ([64.186.250.142]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-134cbcb9ed3sm19187559c88.1.2026.05.18.02.26.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 02:26:20 -0700 (PDT)
Date: Mon, 18 May 2026 17:26:18 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Meng Zhuo <mengzhuo@iscas.ac.cn>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH] target/riscv/kvm: skip FP/Vector sync on
 KVM_PUT_RUNTIME_STATE
Message-ID: <agrW1UKghzgrLzqj@ChaodeMBP.bbrouter>
References: <20260513100447.2167615-1-mengzhuo@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260513100447.2167615-1-mengzhuo@iscas.ac.cn>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1244;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-dl1-x1244.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, May 13, 2026 at 06:04:47PM +0800, Meng Zhuo wrote:
> During KVM exit processing (KVM_PUT_RUNTIME_STATE), QEMU never modifies
> FP or Vector registers — only core GPRs/PC and CSRs are potentially
> changed.  Re-syncing 32 FP and 32 Vector registers on every KVM exit
> wastes 36-68 individual KVM_SET_ONE_REG ioctls per vCPU exit.
> 
> Follow the s390x pattern: early return on RUNTIME after syncing core
> registers and CSRs.  KVM_PUT_FULL_STATE and KVM_PUT_RESET_STATE continue
> to sync everything for correctness during migration and initialization.
> 
> Signed-off-by: Meng Zhuo <mengzhuo@iscas.ac.cn>
> ---
>  target/riscv/kvm/kvm-cpu.c | 25 +++++++++++++++++--------
>  1 file changed, 17 insertions(+), 8 deletions(-)
> 
> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
> index b047ffa9c0..12a440971e 100644
> --- a/target/riscv/kvm/kvm-cpu.c
> +++ b/target/riscv/kvm/kvm-cpu.c
> @@ -1373,7 +1373,7 @@ int kvm_riscv_sync_mpstate_to_kvm(RISCVCPU *cpu, int state)
>  
>  int kvm_arch_put_registers(CPUState *cs, KvmPutState level, Error **errp)
>  {
> -    int ret = 0;
> +    int ret;
>  
>      ret = kvm_riscv_put_regs_core(cs);
>      if (ret) {
> @@ -1385,6 +1385,17 @@ int kvm_arch_put_registers(CPUState *cs, KvmPutState level, Error **errp)
>          return ret;
>      }
>  
> +    /*
> +     * For RUNTIME_STATE, KVM already has the correct FP and Vector state
> +     * from the preceding KVM_RUN exit. QEMU never modifies these registers
> +     * during exit handling, so re-syncing is unnecessary.  This saves ~68
> +     * KVM_SET_ONE_REG ioctls per vCPU exit.  See also s390x which uses
> +     * the same pattern.
> +     */
> +    if (level == KVM_PUT_RUNTIME_STATE) {
> +        return 0;
Why do we return 0 directly instead of returning `ret`? Is there any benefit to
doing it this way?

> +    }
> +
>      ret = kvm_riscv_put_regs_fp(cs);
>      if (ret) {
>          return ret;
> @@ -1395,19 +1406,17 @@ int kvm_arch_put_registers(CPUState *cs, KvmPutState level, Error **errp)
>          return ret;
>      }
>  
> -    if (KVM_PUT_RESET_STATE == level) {
> +    if (level == KVM_PUT_RESET_STATE) {
This line doesn’t need to be changed.

Thanks,
Chao
>          RISCVCPU *cpu = RISCV_CPU(cs);
> -        if (cs->cpu_index == 0) {
> -            ret = kvm_riscv_sync_mpstate_to_kvm(cpu, KVM_MP_STATE_RUNNABLE);
> -        } else {
> -            ret = kvm_riscv_sync_mpstate_to_kvm(cpu, KVM_MP_STATE_STOPPED);
> -        }
> +        int state = cs->cpu_index == 0 ? KVM_MP_STATE_RUNNABLE
> +                                       : KVM_MP_STATE_STOPPED;
> +        ret = kvm_riscv_sync_mpstate_to_kvm(cpu, state);
>          if (ret) {
>              return ret;
>          }
>      }
>  
> -    return ret;
> +    return 0;
>  }
>  
>  int kvm_arch_release_virq_post(int virq)
> -- 
> 2.47.3
> 
> 

