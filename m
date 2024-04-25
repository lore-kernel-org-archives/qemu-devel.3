Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA63BC4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 16:06:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s01bB-0005Ii-9s; Thu, 25 Apr 2024 12:05:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1s01aR-00051m-LO
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 12:04:42 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1s01aP-0005Bn-O6
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 12:04:39 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a4702457ccbso158514866b.3
 for <qemu-devel@nongnu.org>; Thu, 25 Apr 2024 09:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1714061074; x=1714665874; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=GSZg8KwbYzgqqpeSnMLetTGAtKlHzg08CQBiCEMD+vI=;
 b=oCAYX1QSMRtJt6bA2a5yL0Dz+9KBBxkgZsZdx9zPrGUrp/3/+OJjRyN/BJWFWp6b3T
 Vn41EFsVG8IteJk36LWIBrJ9uIQCmh9tuYlUhruUOsHvYf0n49acx3iktLpi9LX5fecu
 Z0sEaCRzziBp0ppIcq+kTbtDQbzQfZLKx1qRz23vVs5cJenVUL6BKCQ77iC9wGz/fh1E
 kQbSMtOyBKPFUmiTchY1d3yuNMG74L6CCUc7A1oPsLppcsluH3DnsSjBV18MPK5UGmrH
 GPq+bOV0L4UDNFY3PIFnARVtiJqCdVVmC59vdEG/EqFUh07FINe4RlWBIfkdWIWNuSBU
 RLeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714061074; x=1714665874;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GSZg8KwbYzgqqpeSnMLetTGAtKlHzg08CQBiCEMD+vI=;
 b=Aatk/HFijqXXPHaxUjn7/+FoE0eIWa9tC4GsnhQ0rku72wSPoUA2DUdk6FFzBf3vBY
 rszI4ZfwLSLQVZFa6JEn4VJZrORywH7/IiFrokXhs+b+d3S2AbeqWZYdF0ppSLyhGZEq
 4ePPUvHAC3EIfUSuYBg+56JMWUrU9NatLLz68Lhw6TMjDxZpdHZ99Pg+Te9Hnh1vUAIZ
 t9BNRqzVMWSIzDgenOPRp94jYTQ1OGm5A9esI9529IkwSD7DRWDK0w5nc/EbimxRcxLo
 NS/TskrvTySwnx30rVD57/sqaA5tWGy1rBaZdrwZP8sXq5AnO6bIiDrHv5XBLc1gho7p
 onMw==
X-Gm-Message-State: AOJu0Yx8FdeZqZHXD7LF5RASBAgiiFNA9q3CqOr9T2erQwbEPKx2qxEh
 vmmaa7UA12ZyJKa01U2+bi5f7CX0ki8PrLKobSDnHMJK80gfPzu7WH3GA+oUj10=
X-Google-Smtp-Source: AGHT+IEt/AUibwjvnDOLyOXXMZrmxHN/POSeJGeetdNEUcKayt22bVOAlgrviR8At3RVkkqr0TUcWw==
X-Received: by 2002:a17:907:1b27:b0:a58:97a4:25f1 with SMTP id
 mp39-20020a1709071b2700b00a5897a425f1mr162278ejc.1.1714061073949; 
 Thu, 25 Apr 2024 09:04:33 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
 by smtp.gmail.com with ESMTPSA id
 e7-20020a170906c00700b00a51bf97e63esm9620629ejz.190.2024.04.25.09.04.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Apr 2024 09:04:33 -0700 (PDT)
Date: Thu, 25 Apr 2024 18:04:32 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com
Subject: Re: [PATCH] target/riscv/kvm: implement SBI debug console (DBCN) calls
Message-ID: <20240425-885393eb6591f68e5d73e6d4@orel>
References: <20240425155012.581366-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240425155012.581366-1-dbarboza@ventanamicro.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=ajones@ventanamicro.com; helo=mail-ej1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, Apr 25, 2024 at 12:50:12PM GMT, Daniel Henrique Barboza wrote:
> SBI defines a Debug Console extension "DBCN" that will, in time, replace
> the legacy console putchar and getchar SBI extensions.
> 
> The appeal of the DBCN extension is that it allows multiple bytes to be
> read/written in the SBI console in a single SBI call.
> 
> As far as KVM goes, the DBCN calls are forwarded by an in-kernel KVM
> module to userspace. But this will only happens if the KVM module
> actually supports this SBI extension and we activate it.
> 
> We'll check for DBCN support during init time, checking if get-reg-list
> is advertising KVM_RISCV_SBI_EXT_DBCN. In that case, we'll enable it via
> kvm_set_one_reg() during kvm_arch_init_vcpu().
> 
> Finally, change kvm_riscv_handle_sbi() to handle the incoming calls for
> SBI_EXT_DBCN, reading and writing as required.
> 
> A simple KVM guest with 'earlycon=sbi', running in an emulated RISC-V
> host, takes around 20 seconds to boot without using DBCN. With this
> patch we're taking around 14 seconds to boot due to the speed-up in the
> terminal output.  There's no change in boot time if the guest isn't
> using earlycon.
> 
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>  target/riscv/kvm/kvm-cpu.c         | 111 +++++++++++++++++++++++++++++
>  target/riscv/sbi_ecall_interface.h |  17 +++++
>  2 files changed, 128 insertions(+)
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

