Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6442FCD4F4A
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 21:55:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wP5vk-0002pS-OL; Mon, 18 May 2026 17:55:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wP5vg-0002ks-NJ
 for qemu-devel@nongnu.org; Mon, 18 May 2026 17:55:16 -0400
Received: from mail-dl1-x1244.google.com ([2607:f8b0:4864:20::1244])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wP5vf-0001BB-0q
 for qemu-devel@nongnu.org; Mon, 18 May 2026 17:55:16 -0400
Received: by mail-dl1-x1244.google.com with SMTP id
 a92af1059eb24-12c1a170a50so3515417c88.0
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 14:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779141313; x=1779746113; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=oPU+5tKgnn3Vv1LebPQ71Rg0nkpBinTpv3fJU2LK7nU=;
 b=Xe93SWqw4hlOMuHILMiyIGljzJ62Sh5Nu/5U04jQEzPkwwvXNIrf0Kd/y2sT0UcLCi
 VQXnfLi65evG71Fpu8hTpfyg0Dl95o+MhTDK9sfdsvGRw/kBItszD2F21l0Yq8sEqROa
 9CRjIassXQFZziNP+8pHFtpMGVRca+2q7MTDTuGUkrK+A1h3Q4bMOpSlsyEPC80VTM1G
 0RwXKdfOYUyIDMfbEdu9jKYgBkgXf3gwYD9d+ECZFwzTxp7H8SVPq0Kr7FsY7Fo9vO12
 50bHlFVxie8qQJm4sJVuYHERH1MN+P7Kr0fh1Z2E84Y4hb7bjxZ0DxaylPEvb5aqzh/4
 z4rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779141313; x=1779746113;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oPU+5tKgnn3Vv1LebPQ71Rg0nkpBinTpv3fJU2LK7nU=;
 b=csRwb1IRxqNsoYdAayJWFHpSryYFtkRV9AQi7wD7a3jQUtNVtFxwWrlRVGmjKbJpks
 MNmuHluXIAbDnCtCgAq9kwZOfBXMCp47n0HOjSCwmRktKLrXmzZBXRvZROLTwC51rX0Y
 xPBDnlKAh1zPTNtgLhV0pc8fW4fUESHUULVmuauUkEvjQ9flG01bwU4tWHDi0KuBHnTZ
 nAOWxYhtZlqa3NB0bHVk0WRrutbST+xD13wwfe5GqFhZ1Y7H3p1FhUV7irU3aKyWFWtv
 wx4Aq+tUg4Fz6+wf5R8qCl/gOpZXW7QhsBw209DO4qE/7f3qZYTqZrBGFGM63OwfHB8c
 nIhw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+JdsvoYybWmiyLv3UsAmDvCFcezOp2pjoauDiYB8FyJeYX+sTDzZ/GrDjHaahbsmF9I+dlJBURb4f3@nongnu.org
X-Gm-Message-State: AOJu0Yw9SRrCtWwq6wy+0LezyAmRrGQ0HN9uFb/DKByeG8EIs6oI0Zer
 AArm6xyPOo/+s8HaxtDc3sv1/0ubrSEVWUEHpVzFLlHDtNV6TdCd3tIX
X-Gm-Gg: Acq92OFc1TFyAIY1aEb7Rduv06pHG/0QAtSa3lHfQniQ3Ca8lx8xqcCvQhnSPhh9WjX
 /0VcFfXnqXecaKq/ES2by/kZ+rxXwssgdOeNHo5/XEaJX+1VdpoL4QGulRQrC6d9AxFXdJPVkp7
 ggEmG5/SYxPCQ2dhZ7JNxP/8R2Xuyq9N4Ax5ZgsRWiWgRw3ZhnbvHO+eNMnAEnMquYs8jwPGWu3
 Prfe7Y71PF1ZOAS9ZNvlkR9PwrbV/adl+pDNkWSvkh04/1/ZfRkM5uew7jg6IQ76RKE/zRB2qt/
 eydH4wA3o2/pKYoBlE4e7ChmMR5We1aSgX2gBG7kurw6EoJJfr8AbOgKmx4fhTbpG7EBYxnG/Yw
 UHC+2xG/smMXyo9R0ah6/zVaPcE3d3PnZYgYD7xMeCx9aU7G+zxG+CG6c9DYdoKbNG6VHgf5t6O
 Om2MZpinVmhVl4gCct9yT4vN8kb3irPJYxguEVe8OCElw6R8gh1Pad/2TD7tMECsZdDbx59Q==
X-Received: by 2002:a05:7022:eacd:b0:12a:6c7e:bef2 with SMTP id
 a92af1059eb24-1350440ae0fmr7645586c88.7.1779141312995; 
 Mon, 18 May 2026 14:55:12 -0700 (PDT)
Received: from localhost ([64.186.250.142]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-134cbcb9ef5sm20652432c88.2.2026.05.18.14.55.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 14:55:12 -0700 (PDT)
Date: Tue, 19 May 2026 05:55:09 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Meng Zhuo <mengzhuo@iscas.ac.cn>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v3] target/riscv/kvm: skip FP/Vector sync on
 KVM_PUT_RUNTIME_STATE
Message-ID: <aguKnZW7EZLSjIwg@ChaodeMBP.bbrouter>
References: <20260518102118.2768383-1-mengzhuo@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260518102118.2768383-1-mengzhuo@iscas.ac.cn>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1244;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-dl1-x1244.google.com
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

On Mon, May 18, 2026 at 06:21:18PM +0800, Meng Zhuo wrote:
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
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>

Thanks,
Chao
> ---
>  target/riscv/kvm/kvm-cpu.c | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
> index b047ffa9c0..dd4193ea8b 100644
> --- a/target/riscv/kvm/kvm-cpu.c
> +++ b/target/riscv/kvm/kvm-cpu.c
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
> +    if (KVM_PUT_RUNTIME_STATE == level) {
> +        return ret;
> +    }
> +
>      ret = kvm_riscv_put_regs_fp(cs);
>      if (ret) {
>          return ret;
> @@ -1397,11 +1408,9 @@ int kvm_arch_put_registers(CPUState *cs, KvmPutState level, Error **errp)
>  
>      if (KVM_PUT_RESET_STATE == level) {
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
> -- 
> 2.47.3
> 
> 

