Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E0C2C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 01:38:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgYHh-0008AF-0B; Sun, 05 Jul 2026 21:38:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wgYHc-00087g-Ru
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 21:38:04 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wgYHY-0005SP-9J
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 21:38:02 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-69a5ecbbfb2so331937a12.2
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2026 18:37:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783301879; cv=none;
 d=google.com; s=arc-20260327;
 b=ZfXPK95hHGKSUgVBVBvKyM4w3V4Frdxp9J4QZq3H1VNtNPB0Fd9i4QcbAoBbvAZdna
 VuvvA+q4EMvCSH+MjNDRJWhcNWXppTsmvCCodBVhbLawmEi7z8JsGGT4AdLXrxxJ3tWV
 x0s7L9Yu4J9zzkJ3y1IbEBTe8L3eWA/sfe14uIjejiFpZexL97p/Z8lo11LPobR7Avds
 QPVAW24W3w5URfyeDYXdchqbJ+GcBMgUzdV1NBYavfBd56pEJRlsjNd6IPZ+IgQjYV3q
 6GBPpxxHqvxdvFSSp1at+kXq0p+CsJgITTmAxtUSeVH0/K3cl76mQKLrzDvkf1B5+wCw
 eR9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=cagqnJtebSUxsWiRRYmJggy+TvLfrn0QVwFAUR6KUrw=;
 fh=+dPXGxW3pQNYFrTSil53fSXYfdhGIs7bI6Dyql1Mx+Q=;
 b=p51kaP7BfNRR0vIp4xnDPgdjqp9GCoEhSJVd1MddKGXzzGR4NIyYL/ABgpogCiHBG6
 rESyOb+7AiCsC5dYEzBZLprgrpOaooeTqy2gZh0BT8jbG3fUFcbgK85liW4WUbH76heo
 bbqlySh0hQTYHurK+rwRI9nP0nm1swBTuqelju8RcVxn1/DTDOqCHi3BQO2dbyFeXYEV
 Lh3tRWXTiMa0ufdZV27pbPth93N9Fub0TJRIk5QL2S7HNthzjbH13n/L8LPPAfxd3oOW
 fBWp1HwTr8JZXfiLNosLDKb4fJGsCkhIpWYlII5SnuiDMkuk54REBvkjD1XBUal/JkhG
 hsDg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783301879; x=1783906679; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=cagqnJtebSUxsWiRRYmJggy+TvLfrn0QVwFAUR6KUrw=;
 b=mgomw56JKuEliLOIQollvTW8MIQSiw+KrXceFNeNIZ7quUfqFFycLv6wdchyix7lpM
 CX8EG8eiAbEDEDAuZePbskFALOGb7OvF5ab6InqAbhDQiug1NGQ93vnXVaRCTmBthW7J
 5Wcfo1xrHHc09ngR+r67/AOelJZ+9MbpjMcle62506g2z9CBBXAR0yk4Q6HhYWklDsNm
 xk8TpJBN0hYbE2RgnLamSxT0AlEhiLt8ppqZjHSVVzvm2ZbknriUQDbuyVggg+EE93te
 +oPKpxS0Gr5fCiWK/kwsqo5KPCfU1ciyPO87+Ul5iZv7F49digipBybYZHkT1VJ/TIJt
 PVAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783301879; x=1783906679;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cagqnJtebSUxsWiRRYmJggy+TvLfrn0QVwFAUR6KUrw=;
 b=rIfbCVgT3EVFkap+z6677W1NZsbHDo3b276Cpt1rafsP4lLa4lBxH1wqPhpRV7M524
 Bfcd0pExlLZMFUJjKVA8DxuamJ3P9EgUCU7sbojX+p0g45uMTcqFjZOdkoDh9YRTPlSo
 zwvs8Re87mU+PKhFNfWKY5PUwJUHvjg2r/6iCkG7wryZbqn3LDUub84OXAUUND2HAS4l
 JGT7nP9RAh8l80J6uNxaUz3ulK3lG8pfo/8nNff5ZaLG+Do/NSjGsfs/jzYsbo6Cw6RU
 ReQyNejQuVHD1apGQoLdJxJdwUVJUlxezpzIHHXSzCOloOaKKB5MRb4T5koVHetQUHa0
 4X9w==
X-Gm-Message-State: AOJu0YySqQh2OcmVz09BomBX3cuIIIUj40W0npQjCUTQ7ecxM9cIh6Bm
 +ZTlDGYJcLNUaStJDND40hGZwEpT5/aOGnCDDj/hQGJAxbL/gG/fgcxz2WpCECHhMpjle8Jwh2p
 BOxKmHKUko/ZFnPT+3ZPa15p0v7it8Jo=
X-Gm-Gg: AfdE7ckBcr44qpN3tlXoL0EyDTu6sIGR72+F8fLSE0yc8oZY6o8Cdv3xqr4zRK8Kpae
 39NPfZeGuVbiIWh7DiJ7mxCD7d4wGx8uzB4WmKYaZKchS0+YNboC2MZDaDwaFCBw7T8Uhh3JbZo
 TJirhC80H2ZH4z4/9cUw8XZp4suU4KyXJQJq7IFHnHJO1vt1DTxG7T4Jxpr4eJUyyMPa6ifwwAv
 eReR9YIyvHUZOE2P/m3tr25H4BC+gHfLoxtDrkgFGGXRg0fOj5vhsT8Ae8s/U5ucqCaukVZClA6
 rXd5xaLY223HrmVsPIkf7cQXOGs=
X-Received: by 2002:a05:6402:2552:b0:698:c167:91f7 with SMTP id
 4fb4d7f45d1cf-69a1a3bffcdmr2932626a12.34.1783301878609; Sun, 05 Jul 2026
 18:37:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260703180538.3346781-1-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20260703180538.3346781-1-daniel.barboza@oss.qualcomm.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 6 Jul 2026 11:37:31 +1000
X-Gm-Features: AVVi8CdfDPx7-Qo9atBjDMZbTv_XunilxWlR2WYbh5rb7LkjuFnQYxa0Gg00K7M
Message-ID: <CAKmqyKN5UzBz1_W_HpgkoMwqgUKPv=eT9UnPGGFsoLt0Ao0-RQ@mail.gmail.com>
Subject: Re: [PATCH v4 00/24] target/riscv: move TCG files and fix
 --disable-tcg
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Sat, Jul 4, 2026 at 4:09=E2=80=AFAM Daniel Henrique Barboza
<daniel.barboza@oss.qualcomm.com> wrote:
>
> Greetings,
>
> In this version a couple of changes were made based on Phil's feedback
> on v3.
>
> Most notably, patch 06:
>
> [PATCH v3 06/24] target/riscv: move pmu.h to tcg subdir
>
> was splitted into a patch that does the PMU FDT code move (patch 03) and
> the pmu.h path change was squashed into patch 04 ("move TCG only files
> to tcg subdir").  I kept the acks/rb-s since it's just an organizational
> change and no logic was changed.
>
> No other major changes made.  Patches based on 'master'.  They can also
> be fetched from:
>
> https://gitlab.com/danielhb/qemu/-/tree/riscv_disabletcg_v4/
>
> All patches acked/reviewed.
>
> Changes from v3:
> - former patch 6 ("target/riscv: move pmu.h to tcg subdir"):
>   - PMU FDT code move put into a new patch:
>     "hw/riscv, target/riscv: move pmu fdt function to fdt-common.c"
>   - pmu.h file path change squashed into patch 4
> - former patch 3 ("target/riscv/machine.c: do not migrate pmp state with =
kvm")
>   - use "ifdef CONFIG_TCG" in pmp_post_load()
> - v3 link: https://lore.kernel.org/qemu-devel/20260702135128.1188021-1-da=
niel.barboza@oss.qualcomm.com/
>
>
> Daniel Henrique Barboza (22):
>   target/riscv: move valid_vm_* satp arrays to cpu.c
>   hw/riscv, target/riscv: move pmu fdt function to fdt-common.c
>   target/riscv: move TCG only files to tcg subdir
>   target/riscv/machine.c: do not migrate pmp state with kvm
>   target/riscv: move pmp files to tcg subdir
>   target/riscv: tidy up riscv_sysemu_ops
>   target/riscv: move debug.h to tcg subdir
>   target/riscv: remove csr.h from kvm-cpu.c
>   target/riscv: move csr.h to tcg subdir
>   target/riscv: move custom_csrs logic to tcg-cpu.c
>   target/riscv: move riscv_cpu_set_nmi() to tcg-cpu.c
>   target/riscv: move some irq helpers to cpu.c
>   target/riscv: move riscv_cpu_claim_interrupts to cpu.c
>   target/riscv/cpu.c: handle TCG bits of riscv_cpu_dump_state
>   target/riscv: gate riscv_cpu_update_mip with tcg_enabled()
>   target/riscv/cpu.c: filter TCG only bits in riscv_cpu_reset_hold()
>   hw/riscv/riscv_hart.c isolate tcg only bits
>   target/riscv/gdbstub.c: isolate TCG only checks
>   target/riscv: move riscv_cpu_set_rdtime_fn to riscv_aclint
>   target/riscv/tcg: remove unused riscv_cpu_get_geilen()
>   target/riscv: move riscv_cpu_set_geilen() to riscv-imsic
>   target/riscv: move riscv_cpu_set_aia_ireg_rmw_cb() to riscv_imsic
>
> Zephyr Li (2):
>   target/riscv: Remove unused tcg/tcg.h include
>   gitlab-ci.d/crossbuilds: add riscv64 KVM-only build job

Thanks!

Applied to riscv-to-apply.next

Alistair

>
>  .gitlab-ci.d/crossbuilds.yml                  |   8 +
>  hw/intc/riscv_aclint.c                        |   8 +
>  hw/intc/riscv_imsic.c                         |  24 ++
>  hw/riscv/fdt-common.c                         |  52 +++
>  hw/riscv/riscv_hart.c                         |   8 +-
>  hw/riscv/tt_atlantis.c                        |   1 -
>  hw/riscv/virt.c                               |   1 -
>  include/hw/riscv/fdt-common.h                 |   1 +
>  target/riscv/cpu.c                            | 318 +++++++++++++++---
>  target/riscv/cpu.h                            |  24 +-
>  target/riscv/gdbstub.c                        |  10 +-
>  target/riscv/kvm/kvm-cpu.c                    |   1 -
>  target/riscv/machine.c                        |  15 +-
>  target/riscv/meson.build                      |  17 -
>  target/riscv/monitor.c                        |   4 +-
>  target/riscv/riscv-qmp-cmds.c                 |   2 +-
>  target/riscv/{ =3D> tcg}/bitmanip_helper.c      |   0
>  target/riscv/{ =3D> tcg}/cpu_helper.c           | 253 +-------------
>  target/riscv/{ =3D> tcg}/crypto_helper.c        |   0
>  target/riscv/{ =3D> tcg}/csr.c                  |  45 +--
>  target/riscv/{ =3D> tcg}/csr.h                  |   6 +-
>  target/riscv/{ =3D> tcg}/debug.c                |   2 +-
>  target/riscv/{ =3D> tcg}/debug.h                |   0
>  target/riscv/{ =3D> tcg}/fpu_helper.c           |   0
>  .../insn_trans/trans_privileged.c.inc         |   0
>  .../{ =3D> tcg}/insn_trans/trans_rva.c.inc      |   0
>  .../{ =3D> tcg}/insn_trans/trans_rvb.c.inc      |   0
>  .../{ =3D> tcg}/insn_trans/trans_rvbf16.c.inc   |   0
>  .../{ =3D> tcg}/insn_trans/trans_rvd.c.inc      |   0
>  .../{ =3D> tcg}/insn_trans/trans_rvf.c.inc      |   0
>  .../{ =3D> tcg}/insn_trans/trans_rvh.c.inc      |   0
>  .../{ =3D> tcg}/insn_trans/trans_rvi.c.inc      |   0
>  .../{ =3D> tcg}/insn_trans/trans_rvk.c.inc      |   0
>  .../{ =3D> tcg}/insn_trans/trans_rvm.c.inc      |   0
>  .../{ =3D> tcg}/insn_trans/trans_rvv.c.inc      |   0
>  .../{ =3D> tcg}/insn_trans/trans_rvvk.c.inc     |   0
>  .../{ =3D> tcg}/insn_trans/trans_rvzabha.c.inc  |   0
>  .../{ =3D> tcg}/insn_trans/trans_rvzacas.c.inc  |   0
>  .../{ =3D> tcg}/insn_trans/trans_rvzalasr.c.inc |   0
>  .../{ =3D> tcg}/insn_trans/trans_rvzawrs.c.inc  |   0
>  .../{ =3D> tcg}/insn_trans/trans_rvzce.c.inc    |   0
>  .../{ =3D> tcg}/insn_trans/trans_rvzcmop.c.inc  |   0
>  .../{ =3D> tcg}/insn_trans/trans_rvzfa.c.inc    |   0
>  .../{ =3D> tcg}/insn_trans/trans_rvzfh.c.inc    |   0
>  .../{ =3D> tcg}/insn_trans/trans_rvzicbo.c.inc  |   0
>  .../insn_trans/trans_rvzicfiss.c.inc          |   0
>  .../{ =3D> tcg}/insn_trans/trans_rvzicond.c.inc |   0
>  .../{ =3D> tcg}/insn_trans/trans_rvzimop.c.inc  |   0
>  .../{ =3D> tcg}/insn_trans/trans_svinval.c.inc  |   0
>  .../{ =3D> tcg}/insn_trans/trans_xlrbr.c.inc    |   0
>  .../{ =3D> tcg}/insn_trans/trans_xmips.c.inc    |   0
>  .../{ =3D> tcg}/insn_trans/trans_xthead.c.inc   |   0
>  .../insn_trans/trans_xventanacondops.c.inc    |   0
>  .../{ =3D> tcg}/insn_trans/trans_zilsd.c.inc    |   0
>  target/riscv/{ =3D> tcg}/m128_helper.c          |   0
>  target/riscv/tcg/meson.build                  |  31 +-
>  target/riscv/{ =3D> tcg}/mips_csr.c             |   2 +-
>  target/riscv/{ =3D> tcg}/op_helper.c            |   2 +-
>  target/riscv/{ =3D> tcg}/pmp.c                  |   2 +-
>  target/riscv/{ =3D> tcg}/pmp.h                  |   0
>  target/riscv/{ =3D> tcg}/pmu.c                  |  52 ---
>  target/riscv/{ =3D> tcg}/pmu.h                  |   0
>  target/riscv/tcg/tcg-cpu.c                    |  30 +-
>  target/riscv/{ =3D> tcg}/th_csr.c               |   2 +-
>  target/riscv/{ =3D> tcg}/translate.c            |   0
>  target/riscv/{ =3D> tcg}/vcrypto_helper.c       |   0
>  target/riscv/{ =3D> tcg}/vector_helper.c        |   0
>  target/riscv/{ =3D> tcg}/vector_internals.c     |   0
>  target/riscv/{ =3D> tcg}/vector_internals.h     |   0
>  target/riscv/{ =3D> tcg}/zce_helper.c           |   0
>  target/riscv/time_helper.c                    |  33 +-
>  71 files changed, 513 insertions(+), 441 deletions(-)
>  rename target/riscv/{ =3D> tcg}/bitmanip_helper.c (100%)
>  rename target/riscv/{ =3D> tcg}/cpu_helper.c (92%)
>  rename target/riscv/{ =3D> tcg}/crypto_helper.c (100%)
>  rename target/riscv/{ =3D> tcg}/csr.c (99%)
>  rename target/riscv/{ =3D> tcg}/csr.h (96%)
>  rename target/riscv/{ =3D> tcg}/debug.c (99%)
>  rename target/riscv/{ =3D> tcg}/debug.h (100%)
>  rename target/riscv/{ =3D> tcg}/fpu_helper.c (100%)
>  rename target/riscv/{ =3D> tcg}/insn_trans/trans_privileged.c.inc (100%)
>  rename target/riscv/{ =3D> tcg}/insn_trans/trans_rva.c.inc (100%)
>  rename target/riscv/{ =3D> tcg}/insn_trans/trans_rvb.c.inc (100%)
>  rename target/riscv/{ =3D> tcg}/insn_trans/trans_rvbf16.c.inc (100%)
>  rename target/riscv/{ =3D> tcg}/insn_trans/trans_rvd.c.inc (100%)
>  rename target/riscv/{ =3D> tcg}/insn_trans/trans_rvf.c.inc (100%)
>  rename target/riscv/{ =3D> tcg}/insn_trans/trans_rvh.c.inc (100%)
>  rename target/riscv/{ =3D> tcg}/insn_trans/trans_rvi.c.inc (100%)
>  rename target/riscv/{ =3D> tcg}/insn_trans/trans_rvk.c.inc (100%)
>  rename target/riscv/{ =3D> tcg}/insn_trans/trans_rvm.c.inc (100%)
>  rename target/riscv/{ =3D> tcg}/insn_trans/trans_rvv.c.inc (100%)
>  rename target/riscv/{ =3D> tcg}/insn_trans/trans_rvvk.c.inc (100%)
>  rename target/riscv/{ =3D> tcg}/insn_trans/trans_rvzabha.c.inc (100%)
>  rename target/riscv/{ =3D> tcg}/insn_trans/trans_rvzacas.c.inc (100%)
>  rename target/riscv/{ =3D> tcg}/insn_trans/trans_rvzalasr.c.inc (100%)
>  rename target/riscv/{ =3D> tcg}/insn_trans/trans_rvzawrs.c.inc (100%)
>  rename target/riscv/{ =3D> tcg}/insn_trans/trans_rvzce.c.inc (100%)
>  rename target/riscv/{ =3D> tcg}/insn_trans/trans_rvzcmop.c.inc (100%)
>  rename target/riscv/{ =3D> tcg}/insn_trans/trans_rvzfa.c.inc (100%)
>  rename target/riscv/{ =3D> tcg}/insn_trans/trans_rvzfh.c.inc (100%)
>  rename target/riscv/{ =3D> tcg}/insn_trans/trans_rvzicbo.c.inc (100%)
>  rename target/riscv/{ =3D> tcg}/insn_trans/trans_rvzicfiss.c.inc (100%)
>  rename target/riscv/{ =3D> tcg}/insn_trans/trans_rvzicond.c.inc (100%)
>  rename target/riscv/{ =3D> tcg}/insn_trans/trans_rvzimop.c.inc (100%)
>  rename target/riscv/{ =3D> tcg}/insn_trans/trans_svinval.c.inc (100%)
>  rename target/riscv/{ =3D> tcg}/insn_trans/trans_xlrbr.c.inc (100%)
>  rename target/riscv/{ =3D> tcg}/insn_trans/trans_xmips.c.inc (100%)
>  rename target/riscv/{ =3D> tcg}/insn_trans/trans_xthead.c.inc (100%)
>  rename target/riscv/{ =3D> tcg}/insn_trans/trans_xventanacondops.c.inc (=
100%)
>  rename target/riscv/{ =3D> tcg}/insn_trans/trans_zilsd.c.inc (100%)
>  rename target/riscv/{ =3D> tcg}/m128_helper.c (100%)
>  rename target/riscv/{ =3D> tcg}/mips_csr.c (99%)
>  rename target/riscv/{ =3D> tcg}/op_helper.c (99%)
>  rename target/riscv/{ =3D> tcg}/pmp.c (99%)
>  rename target/riscv/{ =3D> tcg}/pmp.h (100%)
>  rename target/riscv/{ =3D> tcg}/pmu.c (86%)
>  rename target/riscv/{ =3D> tcg}/pmu.h (100%)
>  rename target/riscv/{ =3D> tcg}/th_csr.c (99%)
>  rename target/riscv/{ =3D> tcg}/translate.c (100%)
>  rename target/riscv/{ =3D> tcg}/vcrypto_helper.c (100%)
>  rename target/riscv/{ =3D> tcg}/vector_helper.c (100%)
>  rename target/riscv/{ =3D> tcg}/vector_internals.c (100%)
>  rename target/riscv/{ =3D> tcg}/vector_internals.h (100%)
>  rename target/riscv/{ =3D> tcg}/zce_helper.c (100%)
>
> --
> 2.43.0
>
>

