Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21F98FEE4EF
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Feb 2026 15:40:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwMQT-0005Gb-AF; Sat, 28 Feb 2026 10:40:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vwMQR-0005Fr-By
 for qemu-devel@nongnu.org; Sat, 28 Feb 2026 10:40:15 -0500
Received: from mail-dl1-x1243.google.com ([2607:f8b0:4864:20::1243])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vwMQP-0002Kb-S3
 for qemu-devel@nongnu.org; Sat, 28 Feb 2026 10:40:15 -0500
Received: by mail-dl1-x1243.google.com with SMTP id
 a92af1059eb24-127380532eeso8506503c88.1
 for <qemu-devel@nongnu.org>; Sat, 28 Feb 2026 07:40:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772293212; x=1772898012; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=LkN8JK6dH8SjlS4djfalw7QB8CBbluwHhWIbabj17Nc=;
 b=aNK0ddc+iRK9ZKRI7RqnMpExdOFPMN6KWIlZw3rLbcu4TlabAG+o3ZWUzmFaQWEdXP
 xdycoKj24o/BK6xn6apDncVAGdHV7zeQ3ty3/CaXO0TawPW5PRvONC4UjBBB07rTVysj
 WXBNmkE+6KJSmLgmjvEn3r4fyjHuoUh5D1QWrlmOEomn0S3uDvP9MbCQQrOYdOwFmN9S
 aFrLc047WONzk7Ol1GbWIyA+lKjlQcLEcN0U+35hsRgV53nC+ylCnxwHcWyrVweUFTdf
 YCU6or7qCYhK6O8xnklwt4xVtAPUS5AeVzGM6nAphZej4ezupXXAofhRUaMeXPyzTZuC
 QX3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772293212; x=1772898012;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LkN8JK6dH8SjlS4djfalw7QB8CBbluwHhWIbabj17Nc=;
 b=l2DIN4kbVNBkv0p8Pby/k+6pmiCewmP41+1AtGHknbbGgIlHB9QtlgvqZ1kaQQ0ENG
 NlgrFFmLENMywpywGq7fPGG+Mp4Uibhyb7ozkdt6+rTKfGKpPIqHsz9NdT1ju5JI2QVX
 t9VUl9M7+4rtsnXeW7GlkcOt94/2UmOda/oeNzluuh+zkzc1bmQUNTnKwXpJmXwI0gU2
 dFh08g+WrBHZ5YDo9tapURJCGWFPXibQ7M3dWGK03zrgvANH3LmREar0bmLppVER/SIC
 1E0kyAZDUBAQu2n+qOzpnm+IvW0LDOhFNDwEcJpOpk+/A5iQtF6p+9W4fRVCwZx906hh
 fyyQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXLJro9BLYM0kYTZFDJIENoibq0e/vx+nh2k0JLklbT7oXwczYg8Leu5OJOVzwmCWpLGbUSh7ordwVa@nongnu.org
X-Gm-Message-State: AOJu0Ywi5pujiZMR0SipjVTzbUR4H1uyM7U9De+arQtkjgZHipP06mZA
 s4WY8Te9QY+wMN5NZcd+rXHW+J/h75BVGuh3Vz47kAxHPxj4jsMM4HQ/
X-Gm-Gg: ATEYQzxOJ3au48COH6LbUWzsvLp6nySOW11+sqjs+3i2mpK8njuOsr+jO5kc8F4eo3p
 cSDyMqBRIqdZBOK8CmRXtOOsLsfE9VkS+m7/KCdbZeeTETWGbfF8aDDd71JZbJ8B5Vhh9Jc9krz
 u7rsGkr1EWOR9tfGV0d3Qs8xMVRcaREUqrvX9PTE4rz6Twz00OEhz+7NyqOvK1/E71FPxsp6RI+
 xl1CFErT3+6fRML811T0cJp3dwOu6pRlobYPdZkiQoPU1B3yvHQFz/oSOan61h9kNj+y+b/yaMR
 3iqFmIMPuQ1rGbCGNNyoNaz7wrRIbXWrOMJ8OkPGP51lMQlpjU4u22j/Gzgqd4/0WsYM+ngfss4
 Wrrm08TQ216fXezkQatSQeOujzwCBZ8UjuA+eTS+L3jhMBad07JXWVosuTqaiU6ncyece9bWx/9
 nPuS/rLbXJQlvpRAtdUM64je1AEjT6NUjUPV3w/to/uSK4lWa/DPTikCIC3WFAou07WKD1VIv1m
 sf/tS6fBg3b6z8Fper62YSjbAeGdl/i53rA7hPm7g==
X-Received: by 2002:a05:7022:4381:b0:11b:a3a7:65cd with SMTP id
 a92af1059eb24-1278fc48265mr2631460c88.12.1772293212165; 
 Sat, 28 Feb 2026 07:40:12 -0800 (PST)
Received: from ZEVORN-PC.localdomain ([38.95.120.198])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12789a32863sm7203579c88.10.2026.02.28.07.40.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Feb 2026 07:40:11 -0800 (PST)
Date: Sat, 28 Feb 2026 23:40:02 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: liu.xuemei1@zte.com.cn
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com, 
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Subject: Re: [PATCH 1/3] target/riscv/kvm: create kvm_riscv_aia_access_reg
Message-ID: <aaML8y9PsZ-L8Qxs@ZEVORN-PC.localdomain>
References: <20260227180104794YvW9Rb2I_kAGzUruZL11Q@zte.com.cn>
 <20260227180243309RupzclQ90f5u2KZTabSn0@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260227180243309RupzclQ90f5u2KZTabSn0@zte.com.cn>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1243;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-dl1-x1243.google.com
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

On Fri, Feb 27, 2026 at 06:02:43PM +0800, liu.xuemei1@zte.com.cn wrote:
> From: Xuemei Liu <liu.xuemei1@zte.com.cn>
> 
> Create common function kvm_riscv_aia_access_reg to access APLIC
> and IMSIC regs
Missing period.

LGTM.

Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>

Thanks,
Chao
> 
> Signed-off-by: Xuemei Liu <liu.xuemei1@zte.com.cn>
> ---
>  target/riscv/kvm/kvm-cpu.c   | 7 ++++++-
>  target/riscv/kvm/kvm_riscv.h | 1 +
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
> index befcbb0a9a..2c29d8d07c 100644
> --- a/target/riscv/kvm/kvm-cpu.c
> +++ b/target/riscv/kvm/kvm-cpu.c
> @@ -58,6 +58,7 @@ void riscv_kvm_aplic_request(void *opaque, int irq, int level)
>  }
> 
>  static bool cap_has_mp_state;
> +static int aia_fd = -1;
> 
>  #define KVM_RISCV_REG_ID_U32(type, idx) (KVM_REG_RISCV | KVM_REG_SIZE_U32 | \
>                                           type | idx)
> @@ -1842,13 +1843,17 @@ void kvm_arch_accel_class_init(ObjectClass *oc)
>                                      "auto");
>  }
> 
> +void kvm_riscv_aia_access_reg(int group, uint64_t addr, void *val, bool write)
> +{
> +    kvm_device_access(aia_fd, group, addr, val, write, &error_abort);
> +}
> +
>  void kvm_riscv_aia_create(MachineState *machine, uint64_t group_shift,
>                            uint64_t aia_irq_num, uint64_t aia_msi_num,
>                            uint64_t aplic_base, uint64_t imsic_base,
>                            uint64_t guest_num)
>  {
>      int ret, i;
> -    int aia_fd = -1;
>      uint64_t default_aia_mode;
>      uint64_t socket_count = riscv_socket_count(machine);
>      uint64_t max_hart_per_socket = 0;
> diff --git a/target/riscv/kvm/kvm_riscv.h b/target/riscv/kvm/kvm_riscv.h
> index 953db94160..cec13d9f31 100644
> --- a/target/riscv/kvm/kvm_riscv.h
> +++ b/target/riscv/kvm/kvm_riscv.h
> @@ -23,6 +23,7 @@
> 
>  void kvm_riscv_reset_vcpu(RISCVCPU *cpu);
>  void kvm_riscv_set_irq(RISCVCPU *cpu, int irq, int level);
> +void kvm_riscv_aia_access_reg(int group, uint64_t addr, void *val, bool write);
>  void kvm_riscv_aia_create(MachineState *machine, uint64_t group_shift,
>                            uint64_t aia_irq_num, uint64_t aia_msi_num,
>                            uint64_t aplic_base, uint64_t imsic_base,
> -- 
> 2.27.0
> 

