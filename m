Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CAB5CCF9E0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 16:32:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCKhR-0001yY-J9; Fri, 24 Oct 2025 12:31:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vCKhO-0001xv-F6
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 12:31:30 -0400
Received: from mail-yw1-x1136.google.com ([2607:f8b0:4864:20::1136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vCKhM-0002Gl-IP
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 12:31:30 -0400
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-7829fc3b7deso18315267b3.3
 for <qemu-devel@nongnu.org>; Fri, 24 Oct 2025 09:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761323487; x=1761928287; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XCHxeZcUKToA4Lb05QdesZghIE5s3k+8NronWtFxWyA=;
 b=BiDmcXIoMn3U6wGD9hhvA7/68YLxEFw8gyW8+wI9HdMQ8w23l5w8rpUgqUnL4yERhr
 eOFQO0cMh+Eo7KRe2KwQl93NvRG2gQvHpwp02Yn0Sg113nZtscgUl1gNhiO7lWPiN5/k
 lHtRLUl4ztHyQWWCByFGWyq4Wjzesxq/HVro7/9BcrOGS3eig4lkk+k29AS5XlHJF7oF
 qJFw300B0Fzh/eiMekktjx71gGnqVPcw1bqPFJvEOzp8EOhBCrogVQRya+V6E27tjoM6
 l/6ygKz6ZqRZe5LqP894aOVsYjZkoOok/OEoHlZqYyKs1qzS8gABJAbzoSIJEABjRsvh
 NiGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761323487; x=1761928287;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XCHxeZcUKToA4Lb05QdesZghIE5s3k+8NronWtFxWyA=;
 b=HS2Tglkbj9A5o7x+OlVyJtswMmyDiPxSmEbG6MjC3w0wnHsktFaofgDU+m70DosGop
 5rsveVGjxmLycDWQbUiI3jPRs926o7YI4bD5bFVWsaCNGb0w/pvI75YpjfSS7SCa/fCl
 P5wzkhSKRHFRYVO9hvWX2H9Qj+aROCY1H/AhaYSt8mMpmkbVDDBuszE73WTwm9eJnO4G
 3oXFp1q2INOvIrE11dUG1mNjf3jJpkAN/fM5RV2Gqjod9X8nRkJqTIEJsHR+sUm1Aa01
 w6taR+ShAQbPKUjTPVPc2+I3Yrcb49OkIdFv+ajXdFrmL1vqOBp9Ko4cf1iBAuuduO/I
 88sg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQlTE6xB3bYstN5fs6J3QKv4Urv3oLmIp3cuj6qcQNBdurwPdJl8AKATbhB+MzrlAhe/gvBifSXlIW@nongnu.org
X-Gm-Message-State: AOJu0YzFe+zs9BWlhAK0hVFdvKKTMG6uLx8QHaRjyvk8S14kHJSROYes
 w3caPXVa4aY2kui96YRogEWbrx8iLok476hqyNkA/6o2erCM3FZH93P4oZAOx1TRR7/dHwhBHVy
 mYNjO5IybTzNYMvoUxIgWzC30WB+42GR/Kq4FseQfVw==
X-Gm-Gg: ASbGnctY/7mXk6BaxdshfhsTcWEwe8UlDuK2W/O67fv2C1Jxn0BZq7lvmwA6VNEoxgE
 oYadbiAzmRVqd3DwKfKs6iG17D3g1np2daxQ0vddav7JNEHQrWdtTszlTqVi45yE5kyB18JlI6c
 WnYbRL2r4ORT/PmK6GJjkUUfJluvaoJhG5+fmrFxASEYyOudkMpUaDs158B0ep9iZECYWN9DXHZ
 BNjVmIuiMTrnaO9vcKw2PhuteYHKiYPGZYS742vFenXl5gn71q6vvNXySQftg==
X-Google-Smtp-Source: AGHT+IGxdYZk3y7WnRXSJWIEo4CNchDzY0y0iklOGHaDOQX+1VhNeO2/miP1bV4WhGQBZHLb8Nz9bax55Hjsi5dr0GY=
X-Received: by 2002:a05:690e:4085:b0:63c:e19c:d7c6 with SMTP id
 956f58d0204a3-63e160d88a6mr24074830d50.10.1761323486540; Fri, 24 Oct 2025
 09:31:26 -0700 (PDT)
MIME-Version: 1.0
References: <20250519040555.3797167-1-alistair.francis@wdc.com>
 <20250519040555.3797167-48-alistair.francis@wdc.com>
 <CAFEAcA_6zma2=nsBWB7ebb35Jt1cNAChiMG0xnkT3WPEY8csiw@mail.gmail.com>
 <f9c1c814-c083-4c9b-831c-4cd5ce162002@ventanamicro.com>
In-Reply-To: <f9c1c814-c083-4c9b-831c-4cd5ce162002@ventanamicro.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 Oct 2025 17:31:14 +0100
X-Gm-Features: AS18NWCSh2DPYM1A1o1Qxyo_9hvigqmohyDuZCQqLQR3P42rAS8k29o_BqoZBD4
Message-ID: <CAFEAcA_6fLs=xmCzhxYuJqqRky2uPLFFW-9f=4ABMx+bTekVXQ@mail.gmail.com>
Subject: Re: [PULL 47/56] target/riscv/kvm: add scounteren CSR
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: alistair23@gmail.com, qemu-devel@nongnu.org, 
 Andrew Jones <ajones@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Michael Tokarev <mjt@tls.msk.ru>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1136.google.com
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

On Fri, 24 Oct 2025 at 17:17, Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
>
>
> On 10/24/25 10:43 AM, Peter Maydell wrote:
> > On Mon, 19 May 2025 at 05:25, <alistair23@gmail.com> wrote:
> >>
> >> From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> >>
> >> Add support for the scounteren KVM CSR. Note that env->scounteren is a
> >> 32 bit and all KVM CSRs are target_ulong, so scounteren will be capped
> >> to 32 bits read/writes.
> >>
> >> Reported-by: Andrew Jones <ajones@ventanamicro.com>
> >> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> >> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> >> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> >> Message-ID: <20250429124421.223883-10-dbarboza@ventanamicro.com>
> >> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> >> ---
> >>   target/riscv/kvm/kvm-cpu.c | 2 ++
> >>   1 file changed, 2 insertions(+)
> >>
> >> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
> >> index ca171d5457..82f9728636 100644
> >> --- a/target/riscv/kvm/kvm-cpu.c
> >> +++ b/target/riscv/kvm/kvm-cpu.c
> >> @@ -251,6 +251,7 @@ static KVMCPUConfig kvm_csr_cfgs[] = {
> >>       KVM_CSR_CFG("stval",      stval,      RISCV_CSR_REG(stval)),
> >>       KVM_CSR_CFG("sip",        mip,        RISCV_CSR_REG(sip)),
> >>       KVM_CSR_CFG("satp",       satp,       RISCV_CSR_REG(satp)),
> >> +    KVM_CSR_CFG("scounteren", scounteren, RISCV_CSR_REG(scounteren)),
> >>       KVM_CSR_CFG("senvcfg",    senvcfg,    RISCV_CSR_REG(senvcfg)),
> >>   };
> >>
> >> @@ -701,6 +702,7 @@ static void kvm_riscv_reset_regs_csr(CPURISCVState *env)
> >>       env->stval = 0;
> >>       env->mip = 0;
> >>       env->satp = 0;
> >> +    env->scounteren = 0;
> >>       env->senvcfg = 0;
> >>   }
> >
> > Hi -- this came up in a conversation on IRC. Does this new
> > CPU state field need migration support adding in machine.c ?
>
>
> Hmm, I believe it already has, doesn't it?
>
> target/riscv/machine.c:

>         VMSTATE_UINT32(env.scounteren, RISCVCPU),  <-------

So it does. I'm not sure how I missed that in my grep.
Sorry for the noise.

-- PMM

