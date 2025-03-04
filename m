Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64386C282D2
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 15:47:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpUTQ-00011D-1O; Tue, 04 Mar 2025 10:46:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1tpUSM-0000aG-BY
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 10:45:19 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1tpUSD-00086y-8B
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 10:45:12 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-390f5556579so2345801f8f.1
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 07:45:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1741103106; x=1741707906; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=iKp2omLbKRWiRwQwOc0T42zHQ7cbkg0n1YgTcwa2RAs=;
 b=Px5aqoxMXkHqE1FGOBoDcRnWjLzZHGNH+JTs/8pdRLart0gjhoj3XsYt5VN5POtCxt
 zfnPez44g0swZMCDj9MQSDRDYJ/+OCBD1T1Q84XAkhmD0ZZYaaC2gdUwqSMKGgaRc7VH
 7EUKnrboqX2uuyovLXEMR6PrYESQUjQoQcHQoRvcoLrNiV4JN/Y3MJKb4q5jMhgR7l0Z
 twc/XPQj9y1BWuQlullFWBCQrS3eShg/anXrfHiAeRQ80sZTjxS1JjUsWeb17SY6413s
 MJ7W/OLbEDHztMlNkG25fE7FWbOSJ7e+EZWGWB4zA0MDuh1zJtTLhp7L6+B+ksjgFQ8u
 ovhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741103106; x=1741707906;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iKp2omLbKRWiRwQwOc0T42zHQ7cbkg0n1YgTcwa2RAs=;
 b=Gvn1S7w6ZO+TiJTEXCyhqVpcFUSDHjZQjmGA/aopvfgB4WO/90j9yeKGk2/ZIfeBad
 q6Zj+2UD8lL/v9sxGsSsJsZbouPmSQbIA9+zGT5+MEgCUNlclDb7x4UKGNV0nhDng5q+
 TlIckBFYFAXjjUH5lrXUfVE8kd53TIYTCjK7gdGttgcYLiFN968DFk7rk6J0sxtKru1k
 YNVA533HBD3TTIGqfWDez4hktBuZnPv2BV2UhGw6CiBcCwYvx3mjULEp9wq2MPowc7Ff
 D9w2W4+VOD2vFJxOx/o2cznYBOt1IzIBVkBMTs7C/5WhN1w9IxC2cqDnWxjCOWoQuCv/
 mKuA==
X-Gm-Message-State: AOJu0YzfaMdSX7q2iD8L0PceCG0NYRbE1exC4dOQNazJkrGptPWrUXEQ
 rQkKqMudcJP/Wsxw7eoB5memR28DvrdGjTXWnePtMJNboPS01ElKu1TqHK//cxk=
X-Gm-Gg: ASbGncsoetRM3cLDHSt+wCvIJaDf/MkJH+WkBULaCednCosEOzRHioalvPYPNCtPIe/
 EX1UmLJJQlXsSkC+MMTyU50d3sAJLveQWhaIKuV4tWC3H9n3ocGkEXtsWIBRhLG6xni8RDoKXsj
 7Yxuu0kJWIrqCNh2TK/d6nxmwUGLwtbowNrFGMU9ElfXoLeXjIbu5itvaXeHXDpf1PMCHwyU4Me
 3rbo6OuhcDKbSXZ9OJ+9FR+2WroSfOfW+xpKQXQpJSDu/Us1Vpz5qmzw7lwK9LJbsnQeqKboZvs
 ZXBXsguypm5YAVhDqGKtrQ6YbQSMSbuL
X-Google-Smtp-Source: AGHT+IF9M6Pk908+Sw8P2vXfX2s3eJxeNQ3D/hlPwqjXBDdN6gHG4QGisCTw9aVgKtVWUHwBaxhdZQ==
X-Received: by 2002:a05:6000:270f:b0:390:ea34:7d83 with SMTP id
 ffacd0b85a97d-390ec9c166cmr13029763f8f.31.1741103106138; 
 Tue, 04 Mar 2025 07:45:06 -0800 (PST)
Received: from localhost ([2a02:8308:a00c:e200::688c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bc03dcb13sm81318325e9.37.2025.03.04.07.45.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 07:45:05 -0800 (PST)
Date: Tue, 4 Mar 2025 16:45:04 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, greentime.hu@sifive.com, 
 vincent.chen@sifive.com, frank.chang@sifive.com, jim.shu@sifive.com, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v2 5/8] target/riscv/kvm: rewrite kvm_riscv_handle_csr
Message-ID: <20250304-b89365aae1f0776e67d0aa0a@orel>
References: <20250224082417.31382-1-yongxuan.wang@sifive.com>
 <20250224082417.31382-6-yongxuan.wang@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224082417.31382-6-yongxuan.wang@sifive.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=ajones@ventanamicro.com; helo=mail-wr1-x42d.google.com
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

On Mon, Feb 24, 2025 at 04:24:12PM +0800, Yong-Xuan Wang wrote:
> Rewrite the kvm_riscv_handle_csr() to support additional CSR emulation
> in user space with KVM acceleration. This update reuses the TCG CSR
> emulation function to simplify the implementation and reduce the
> redundant work. Also it introduces two hook functions for certain CSRs.
> Before emulation, the related VS mode context of the CSR can be loaded
> from host in context_load() hook. After the CSR handling, the modified
> VS context is written back in context_put() hook.
> 
> Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
> ---
>  target/riscv/cpu.h         |  2 --
>  target/riscv/csr.c         | 18 +++-------
>  target/riscv/kvm/kvm-cpu.c | 68 ++++++++++++++++++++++++++++++++------
>  3 files changed, 61 insertions(+), 27 deletions(-)
> 
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index df10ff63474b..81b8081d81e0 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -928,8 +928,6 @@ static inline const char *riscv_get_csr_name(int csr_no)
>  }
>  
>  void riscv_cpu_register_gdb_regs_for_features(CPUState *cs);
> -target_ulong riscv_new_csr_seed(target_ulong new_value,
> -                                target_ulong write_mask);
>  
>  uint8_t satp_mode_max_from_map(uint32_t map);
>  const char *satp_mode_str(uint8_t satp_mode, bool is_32_bit);
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index d0068ce98c15..a2830888d010 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -5389,8 +5389,10 @@ static int write_mnstatus(CPURISCVState *env, int csrno, target_ulong val)
>  #endif
>  
>  /* Crypto Extension */
> -target_ulong riscv_new_csr_seed(target_ulong new_value,
> -                                target_ulong write_mask)
> +static RISCVException rmw_seed(CPURISCVState *env, int csrno,
> +                               target_ulong *ret_value,
> +                               target_ulong new_value,
> +                               target_ulong write_mask)
>  {
>      uint16_t random_v;
>      Error *random_e = NULL;
> @@ -5414,18 +5416,6 @@ target_ulong riscv_new_csr_seed(target_ulong new_value,
>          rval = random_v | SEED_OPST_ES16;
>      }
>  
> -    return rval;
> -}
> -
> -static RISCVException rmw_seed(CPURISCVState *env, int csrno,
> -                               target_ulong *ret_value,
> -                               target_ulong new_value,
> -                               target_ulong write_mask)
> -{
> -    target_ulong rval;
> -
> -    rval = riscv_new_csr_seed(new_value, write_mask);
> -
>      if (ret_value) {
>          *ret_value = rval;
>      }
> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
> index d421c7a1b65d..b088b947adae 100644
> --- a/target/riscv/kvm/kvm-cpu.c
> +++ b/target/riscv/kvm/kvm-cpu.c
> @@ -1626,26 +1626,72 @@ static int kvm_riscv_handle_sbi(CPUState *cs, struct kvm_run *run)
>      return ret;
>  }
>  
> +/* User-space CSR emulation */
> +struct kvm_riscv_emu_csr_data {
> +    target_ulong csr_num;
> +    int (*context_load)(CPUState *cs);
> +    int (*context_put)(CPUState *cs);
> +};
> +
> +struct kvm_riscv_emu_csr_data kvm_riscv_emu_csr_data[] = {
> +    { CSR_SEED, NULL, NULL },

Needing to ensure TCG state is correct, and therefore introducing the
load/put callbacks, makes me wonder if this is a good idea at all. Sharing
code is good, but, other than the TCG state concerns, we also will have to
deal with potentially wanting to compile with CONFIG_TCG=n when we only
want QEMU to be a KVM VMM.

> +};
> +
>  static int kvm_riscv_handle_csr(CPUState *cs, struct kvm_run *run)
>  {
> +    CPURISCVState *env = cpu_env(cs);
>      target_ulong csr_num = run->riscv_csr.csr_num;
>      target_ulong new_value = run->riscv_csr.new_value;
>      target_ulong write_mask = run->riscv_csr.write_mask;
> -    int ret = 0;
> +    struct kvm_riscv_emu_csr_data *emu_csr_data = NULL;
> +    target_ulong ret_value;
> +    RISCVException ret_excp;
> +    int i, ret;
>  
> -    switch (csr_num) {
> -    case CSR_SEED:
> -        run->riscv_csr.ret_value = riscv_new_csr_seed(new_value, write_mask);
> -        break;
> -    default:
> +    for (i = 0; i < ARRAY_SIZE(kvm_riscv_emu_csr_data); i++) {
> +        if (csr_num == kvm_riscv_emu_csr_data[i].csr_num) {
> +            emu_csr_data = &kvm_riscv_emu_csr_data[i];
> +

remove this extra blank line

> +            break;
> +        }
> +    }
> +
> +    if (!emu_csr_data) {
>          qemu_log_mask(LOG_UNIMP,
> -                      "%s: un-handled CSR EXIT for CSR %lx\n",
> -                      __func__, csr_num);
> -        ret = -1;
> -        break;
> +                      "%s: un-handled CSR EXIT for CSR %s\n",
> +                      __func__, riscv_get_csr_name(csr_num));
> +
> +        return -1;
>      }
>  
> -    return ret;
> +    if (emu_csr_data->context_load) {
> +        ret = emu_csr_data->context_load(cs);
> +        if (ret) {
> +            goto handle_failed;
> +        }
> +    }
> +
> +    ret_excp = riscv_csrrw(env, csr_num, &ret_value, new_value, write_mask);
> +    if (ret_excp != RISCV_EXCP_NONE) {
> +        goto handle_failed;
> +    }
> +    run->riscv_csr.ret_value = ret_value;
> +
> +    if (emu_csr_data->context_put) {
> +        ret = emu_csr_data->context_put(cs);
> +        if (ret) {
> +            goto handle_failed;
> +        }
> +    }
> +
> +    return 0;
> +
> +handle_failed:
> +    qemu_log_mask(LOG_UNIMP,
> +                  "%s: failed to handle CSR EXIT for CSR %s\n",
> +                  __func__, riscv_get_csr_name(csr_num));
> +
> +    return -1;
>  }
>  
>  static bool kvm_riscv_handle_debug(CPUState *cs)
> -- 
> 2.17.1
>

So, as I said above, I'm skeptical of this approach, since I'm not sure we
maintain TCG state well enough when using KVM to trust riscv_csrrw() nor
am I sure we can always have such simple load/put functions like the next
patch proposes for AIA registers.

I vote we manage CSRs case-by-case. SEED is already managed and shares
code at a point that is easy to audit, proving there are no TCG state
dependencies in the emulation. AIA should do the same, at least until
we've decided to build a KVM->TCG model that ensures TCG state is always
correct, in which case I don't think the load/put functions would be
necessary here.

(On a related note, Radim Krcmar suggested we consider forwarding more
SBI calls from KVM to QEMU where QEMU could then use OpenSBI's
implementation. That makes sense to me, but we'd need to create that
KVM->TCG model first for it too.)

Thanks,
drew

