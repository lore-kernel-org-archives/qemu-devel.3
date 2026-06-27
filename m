Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 390A0C43458
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jun 2026 11:05:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wdQqL-0007Z4-6K; Sat, 27 Jun 2026 07:05:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wdQqG-0007Y7-IR
 for qemu-devel@nongnu.org; Sat, 27 Jun 2026 07:04:58 -0400
Received: from mail-dl2-x00.google.com ([2607:f8b0:4864:38::])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wdQqB-0006Sc-6F
 for qemu-devel@nongnu.org; Sat, 27 Jun 2026 07:04:54 -0400
Received: by mail-dl2-x00.google.com with SMTP id
 a92af1059eb24-1379d339ad5so71905c88.0
 for <qemu-devel@nongnu.org>; Sat, 27 Jun 2026 04:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782558289; x=1783163089; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=a3KbHYjxLH8hcw+GZqHNEj1iZ2biC4lHxrMStrrM4KA=;
 b=O2qjFfE+pYWUxV1SOZwuUklTwftTE/0BUxZ+vFrrWjJSrnsBsIoXlWnAnvZQX0AxKm
 5CEfmKpsYgfUwauhN5CV7BOp5hmuGKNHZ1gPmBsScWRYqDLgK1ArjwVPrWqio5CodC7G
 lFzR2qxsom9qzNHIHNUCjjWa/5Np8t0wwBgclTe2ha6OtjddI0M7Iv6C8kmUkuatzHPK
 BAA8I9YDpl22G89ICdsn2H1uv3kDgIn/CbH2FleBoIhU66YsG/Vp6015aWbGLxvnaesH
 JecN3XpUc1cPk1J2+zfdXvpTi1XYKffoi6beknfKNUaTraGc+o2HXONREEO89a/kQogo
 jINw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782558289; x=1783163089;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a3KbHYjxLH8hcw+GZqHNEj1iZ2biC4lHxrMStrrM4KA=;
 b=D7Uw3s5uocA222KNcMcqQ9+70AzThTykljwt6fZsDAx5oYYIqaA2Zqpheb8DAiFsJ7
 Q5raIItgQR2tLcJdqUZGJwuLxlMYVBrONmnID9/nsdEMBHf0ME/mTCFxeh2H5kqqo+dn
 pdLQ+iH7QPPDiGfjuWhoWufkpq096uUPYHDtpsmZkAsHPjafpxqWB9Rf2DdWf1p7FXA1
 jeIjc6OTtB+nqYYwyCcS5yKczRLJf0CQwldvQB1PffL3SkggoUCP2rtui05cYUF3ZA+H
 Xqlcpi4nyyI59NFPZ9sqxSe1zv9tHIWsnKAb0UMwpEjSQ/pf5dnVtiVg1fABT1TtQoyM
 kaYQ==
X-Gm-Message-State: AOJu0YzqBVwwNJeoqEexVQk0eTzhhvDORjheqH3nFVNwU1xGbCjQWw6W
 vustIsAGhH2xJkYa9N1uA6KoxCvhcpoyzl5CgziT6mhJZWTh+Qr/kvDu
X-Gm-Gg: AfdE7cmvXkNGh0TDJ+5OjjwYQxLYsC8CPKGc1xp39t/FCxf7KshvOAnfIP4a/hMax1G
 99y1qERAMFQqWPz2XtDb9rhHI1O77zmqLJ1zrmoIKCxXE+TSGzF46tH+qqqETH/2Y1bmh6K+wSl
 mOW7fXH9O94S2vJZN5nKEAkxfekBZQbWjLCqBHI4MHhkjrWUOxTjjyuPkilaz7V8hZGnl/PH0F3
 GGDE1XtR8UznKh6mRoVTOkRCwgTDu5mNL6qxr+MlJYTViA2jaCCO4UFKYmdIZf5cqu+iXelI2Bu
 xBgxnl5+4Bh+kHZkIitjhY/InTlA35IoC6/FzmMH+bK9fgNjrxLndx6VLKYUJKosVXAO0vXSXaQ
 RA+8FhqUMVLdCE5Zg54FpRYupQFkNxD89n3hFtL9UToU+9DaOc9IR5829L0VQ6TOvbhJHsfkYj3
 U1e6HM73yH9j2tBEAyRo16zc2vOVnTr/lRxkIoM7rSqg+nKjVBBSCx73s63XQ=
X-Received: by 2002:a05:7022:41:b0:119:e569:f874 with SMTP id
 a92af1059eb24-139db9f54fcmr6745049c88.17.1782558287735; 
 Sat, 27 Jun 2026 04:04:47 -0700 (PDT)
Received: from localhost ([64.186.250.142]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139d8f31866sm37585713c88.1.2026.06.27.04.04.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Jun 2026 04:04:47 -0700 (PDT)
Date: Sat, 27 Jun 2026 19:04:44 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, philmd@oss.qualcomm.com, 
 pierrick.bouvier@oss.qualcomm.com, Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH 02/24] target/riscv: move TCG only files to tcg subdir
Message-ID: <aj-uQGobIWJ9PTam@ChaodeMacBook-Pro.local>
References: <20260622193141.1449724-1-daniel.barboza@oss.qualcomm.com>
 <20260622193141.1449724-3-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260622193141.1449724-3-daniel.barboza@oss.qualcomm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:38::;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-dl2-x00.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, Jun 22, 2026 at 04:31:18PM +0800, Daniel Henrique Barboza wrote:
> We have *way* too much TCG-only code hanging around in target/riscv,
> where ideally we would have things that are shared between accelerators.
> 
> We'll follow the example of other targets like i386 and loongarch and
> move everything to the tcg subir.  This will not only cleanup target/riscv
> but it will also expose what is common code but it's buried inside a TCG
> helper.
> 
> We're leaving some stuff behind because these require a little more
> case to not end up breaking KVM.  We'll take care of them next.
> 
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>

> ---
>  target/riscv/meson.build                      | 16 ----------
>  target/riscv/{ => tcg}/bitmanip_helper.c      |  0
>  target/riscv/{ => tcg}/cpu_helper.c           |  0
>  target/riscv/{ => tcg}/crypto_helper.c        |  0
>  target/riscv/{ => tcg}/csr.c                  |  0
>  target/riscv/{ => tcg}/debug.c                |  0
>  target/riscv/{ => tcg}/fpu_helper.c           |  0
>  .../insn_trans/trans_privileged.c.inc         |  0
>  .../{ => tcg}/insn_trans/trans_rva.c.inc      |  0
>  .../{ => tcg}/insn_trans/trans_rvb.c.inc      |  0
>  .../{ => tcg}/insn_trans/trans_rvbf16.c.inc   |  0
>  .../{ => tcg}/insn_trans/trans_rvd.c.inc      |  0
>  .../{ => tcg}/insn_trans/trans_rvf.c.inc      |  0
>  .../{ => tcg}/insn_trans/trans_rvh.c.inc      |  0
>  .../{ => tcg}/insn_trans/trans_rvi.c.inc      |  0
>  .../{ => tcg}/insn_trans/trans_rvk.c.inc      |  0
>  .../{ => tcg}/insn_trans/trans_rvm.c.inc      |  0
>  .../{ => tcg}/insn_trans/trans_rvv.c.inc      |  0
>  .../{ => tcg}/insn_trans/trans_rvvk.c.inc     |  0
>  .../{ => tcg}/insn_trans/trans_rvzabha.c.inc  |  0
>  .../{ => tcg}/insn_trans/trans_rvzacas.c.inc  |  0
>  .../{ => tcg}/insn_trans/trans_rvzalasr.c.inc |  0
>  .../{ => tcg}/insn_trans/trans_rvzawrs.c.inc  |  0
>  .../{ => tcg}/insn_trans/trans_rvzce.c.inc    |  0
>  .../{ => tcg}/insn_trans/trans_rvzcmop.c.inc  |  0
>  .../{ => tcg}/insn_trans/trans_rvzfa.c.inc    |  0
>  .../{ => tcg}/insn_trans/trans_rvzfh.c.inc    |  0
>  .../{ => tcg}/insn_trans/trans_rvzicbo.c.inc  |  0
>  .../insn_trans/trans_rvzicfiss.c.inc          |  0
>  .../{ => tcg}/insn_trans/trans_rvzicond.c.inc |  0
>  .../{ => tcg}/insn_trans/trans_rvzimop.c.inc  |  0
>  .../{ => tcg}/insn_trans/trans_svinval.c.inc  |  0
>  .../{ => tcg}/insn_trans/trans_xlrbr.c.inc    |  0
>  .../{ => tcg}/insn_trans/trans_xmips.c.inc    |  0
>  .../{ => tcg}/insn_trans/trans_xthead.c.inc   |  0
>  .../insn_trans/trans_xventanacondops.c.inc    |  0
>  .../{ => tcg}/insn_trans/trans_zilsd.c.inc    |  0
>  target/riscv/{ => tcg}/m128_helper.c          |  0
>  target/riscv/tcg/meson.build                  | 30 +++++++++++++++++--
>  target/riscv/{ => tcg}/mips_csr.c             |  0
>  target/riscv/{ => tcg}/op_helper.c            |  0
>  target/riscv/{ => tcg}/pmu.c                  |  0
>  target/riscv/{ => tcg}/th_csr.c               |  0
>  target/riscv/{ => tcg}/translate.c            |  0
>  target/riscv/{ => tcg}/vcrypto_helper.c       |  0
>  target/riscv/{ => tcg}/vector_helper.c        |  0
>  target/riscv/{ => tcg}/vector_internals.c     |  0
>  target/riscv/{ => tcg}/vector_internals.h     |  0
>  target/riscv/{ => tcg}/zce_helper.c           |  0
>  49 files changed, 28 insertions(+), 18 deletions(-)
>  rename target/riscv/{ => tcg}/bitmanip_helper.c (100%)
>  rename target/riscv/{ => tcg}/cpu_helper.c (100%)
>  rename target/riscv/{ => tcg}/crypto_helper.c (100%)
>  rename target/riscv/{ => tcg}/csr.c (100%)
>  rename target/riscv/{ => tcg}/debug.c (100%)
>  rename target/riscv/{ => tcg}/fpu_helper.c (100%)
>  rename target/riscv/{ => tcg}/insn_trans/trans_privileged.c.inc (100%)
>  rename target/riscv/{ => tcg}/insn_trans/trans_rva.c.inc (100%)
>  rename target/riscv/{ => tcg}/insn_trans/trans_rvb.c.inc (100%)
>  rename target/riscv/{ => tcg}/insn_trans/trans_rvbf16.c.inc (100%)
>  rename target/riscv/{ => tcg}/insn_trans/trans_rvd.c.inc (100%)
>  rename target/riscv/{ => tcg}/insn_trans/trans_rvf.c.inc (100%)
>  rename target/riscv/{ => tcg}/insn_trans/trans_rvh.c.inc (100%)
>  rename target/riscv/{ => tcg}/insn_trans/trans_rvi.c.inc (100%)
>  rename target/riscv/{ => tcg}/insn_trans/trans_rvk.c.inc (100%)
>  rename target/riscv/{ => tcg}/insn_trans/trans_rvm.c.inc (100%)
>  rename target/riscv/{ => tcg}/insn_trans/trans_rvv.c.inc (100%)
>  rename target/riscv/{ => tcg}/insn_trans/trans_rvvk.c.inc (100%)
>  rename target/riscv/{ => tcg}/insn_trans/trans_rvzabha.c.inc (100%)
>  rename target/riscv/{ => tcg}/insn_trans/trans_rvzacas.c.inc (100%)
>  rename target/riscv/{ => tcg}/insn_trans/trans_rvzalasr.c.inc (100%)
>  rename target/riscv/{ => tcg}/insn_trans/trans_rvzawrs.c.inc (100%)
>  rename target/riscv/{ => tcg}/insn_trans/trans_rvzce.c.inc (100%)
>  rename target/riscv/{ => tcg}/insn_trans/trans_rvzcmop.c.inc (100%)
>  rename target/riscv/{ => tcg}/insn_trans/trans_rvzfa.c.inc (100%)
>  rename target/riscv/{ => tcg}/insn_trans/trans_rvzfh.c.inc (100%)
>  rename target/riscv/{ => tcg}/insn_trans/trans_rvzicbo.c.inc (100%)
>  rename target/riscv/{ => tcg}/insn_trans/trans_rvzicfiss.c.inc (100%)
>  rename target/riscv/{ => tcg}/insn_trans/trans_rvzicond.c.inc (100%)
>  rename target/riscv/{ => tcg}/insn_trans/trans_rvzimop.c.inc (100%)
>  rename target/riscv/{ => tcg}/insn_trans/trans_svinval.c.inc (100%)
>  rename target/riscv/{ => tcg}/insn_trans/trans_xlrbr.c.inc (100%)
>  rename target/riscv/{ => tcg}/insn_trans/trans_xmips.c.inc (100%)
>  rename target/riscv/{ => tcg}/insn_trans/trans_xthead.c.inc (100%)
>  rename target/riscv/{ => tcg}/insn_trans/trans_xventanacondops.c.inc (100%)
>  rename target/riscv/{ => tcg}/insn_trans/trans_zilsd.c.inc (100%)
>  rename target/riscv/{ => tcg}/m128_helper.c (100%)
>  rename target/riscv/{ => tcg}/mips_csr.c (100%)
>  rename target/riscv/{ => tcg}/op_helper.c (100%)
>  rename target/riscv/{ => tcg}/pmu.c (100%)
>  rename target/riscv/{ => tcg}/th_csr.c (100%)
>  rename target/riscv/{ => tcg}/translate.c (100%)
>  rename target/riscv/{ => tcg}/vcrypto_helper.c (100%)
>  rename target/riscv/{ => tcg}/vector_helper.c (100%)
>  rename target/riscv/{ => tcg}/vector_internals.c (100%)
>  rename target/riscv/{ => tcg}/vector_internals.h (100%)
>  rename target/riscv/{ => tcg}/zce_helper.c (100%)
> 
> diff --git a/target/riscv/meson.build b/target/riscv/meson.build
> index 79f36abd63..61874ed0af 100644
> --- a/target/riscv/meson.build
> +++ b/target/riscv/meson.build
> @@ -16,31 +16,15 @@ riscv_ss.add(when: 'CONFIG_ARM_COMPATIBLE_SEMIHOSTING',
>  
>  riscv_ss.add(files(
>    'cpu.c',
> -  'cpu_helper.c',
> -  'csr.c',
> -  'fpu_helper.c',
>    'gdbstub.c',
> -  'op_helper.c',
> -  'vector_helper.c',
> -  'vector_internals.c',
> -  'bitmanip_helper.c',
> -  'translate.c',
> -  'm128_helper.c',
> -  'crypto_helper.c',
> -  'zce_helper.c',
> -  'vcrypto_helper.c'
>  ))
>  
>  riscv_system_ss = ss.source_set()
>  riscv_system_ss.add(files(
>    'arch_dump.c',
>    'pmp.c',
> -  'debug.c',
>    'monitor.c',
>    'machine.c',
> -  'mips_csr.c',
> -  'pmu.c',
> -  'th_csr.c',
>    'time_helper.c',
>    'riscv-qmp-cmds.c',
>  ))
> diff --git a/target/riscv/bitmanip_helper.c b/target/riscv/tcg/bitmanip_helper.c
> similarity index 100%
> rename from target/riscv/bitmanip_helper.c
> rename to target/riscv/tcg/bitmanip_helper.c
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/tcg/cpu_helper.c
> similarity index 100%
> rename from target/riscv/cpu_helper.c
> rename to target/riscv/tcg/cpu_helper.c
> diff --git a/target/riscv/crypto_helper.c b/target/riscv/tcg/crypto_helper.c
> similarity index 100%
> rename from target/riscv/crypto_helper.c
> rename to target/riscv/tcg/crypto_helper.c
> diff --git a/target/riscv/csr.c b/target/riscv/tcg/csr.c
> similarity index 100%
> rename from target/riscv/csr.c
> rename to target/riscv/tcg/csr.c
> diff --git a/target/riscv/debug.c b/target/riscv/tcg/debug.c
> similarity index 100%
> rename from target/riscv/debug.c
> rename to target/riscv/tcg/debug.c
> diff --git a/target/riscv/fpu_helper.c b/target/riscv/tcg/fpu_helper.c
> similarity index 100%
> rename from target/riscv/fpu_helper.c
> rename to target/riscv/tcg/fpu_helper.c
> diff --git a/target/riscv/insn_trans/trans_privileged.c.inc b/target/riscv/tcg/insn_trans/trans_privileged.c.inc
> similarity index 100%
> rename from target/riscv/insn_trans/trans_privileged.c.inc
> rename to target/riscv/tcg/insn_trans/trans_privileged.c.inc
> diff --git a/target/riscv/insn_trans/trans_rva.c.inc b/target/riscv/tcg/insn_trans/trans_rva.c.inc
> similarity index 100%
> rename from target/riscv/insn_trans/trans_rva.c.inc
> rename to target/riscv/tcg/insn_trans/trans_rva.c.inc
> diff --git a/target/riscv/insn_trans/trans_rvb.c.inc b/target/riscv/tcg/insn_trans/trans_rvb.c.inc
> similarity index 100%
> rename from target/riscv/insn_trans/trans_rvb.c.inc
> rename to target/riscv/tcg/insn_trans/trans_rvb.c.inc
> diff --git a/target/riscv/insn_trans/trans_rvbf16.c.inc b/target/riscv/tcg/insn_trans/trans_rvbf16.c.inc
> similarity index 100%
> rename from target/riscv/insn_trans/trans_rvbf16.c.inc
> rename to target/riscv/tcg/insn_trans/trans_rvbf16.c.inc
> diff --git a/target/riscv/insn_trans/trans_rvd.c.inc b/target/riscv/tcg/insn_trans/trans_rvd.c.inc
> similarity index 100%
> rename from target/riscv/insn_trans/trans_rvd.c.inc
> rename to target/riscv/tcg/insn_trans/trans_rvd.c.inc
> diff --git a/target/riscv/insn_trans/trans_rvf.c.inc b/target/riscv/tcg/insn_trans/trans_rvf.c.inc
> similarity index 100%
> rename from target/riscv/insn_trans/trans_rvf.c.inc
> rename to target/riscv/tcg/insn_trans/trans_rvf.c.inc
> diff --git a/target/riscv/insn_trans/trans_rvh.c.inc b/target/riscv/tcg/insn_trans/trans_rvh.c.inc
> similarity index 100%
> rename from target/riscv/insn_trans/trans_rvh.c.inc
> rename to target/riscv/tcg/insn_trans/trans_rvh.c.inc
> diff --git a/target/riscv/insn_trans/trans_rvi.c.inc b/target/riscv/tcg/insn_trans/trans_rvi.c.inc
> similarity index 100%
> rename from target/riscv/insn_trans/trans_rvi.c.inc
> rename to target/riscv/tcg/insn_trans/trans_rvi.c.inc
> diff --git a/target/riscv/insn_trans/trans_rvk.c.inc b/target/riscv/tcg/insn_trans/trans_rvk.c.inc
> similarity index 100%
> rename from target/riscv/insn_trans/trans_rvk.c.inc
> rename to target/riscv/tcg/insn_trans/trans_rvk.c.inc
> diff --git a/target/riscv/insn_trans/trans_rvm.c.inc b/target/riscv/tcg/insn_trans/trans_rvm.c.inc
> similarity index 100%
> rename from target/riscv/insn_trans/trans_rvm.c.inc
> rename to target/riscv/tcg/insn_trans/trans_rvm.c.inc
> diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/tcg/insn_trans/trans_rvv.c.inc
> similarity index 100%
> rename from target/riscv/insn_trans/trans_rvv.c.inc
> rename to target/riscv/tcg/insn_trans/trans_rvv.c.inc
> diff --git a/target/riscv/insn_trans/trans_rvvk.c.inc b/target/riscv/tcg/insn_trans/trans_rvvk.c.inc
> similarity index 100%
> rename from target/riscv/insn_trans/trans_rvvk.c.inc
> rename to target/riscv/tcg/insn_trans/trans_rvvk.c.inc
> diff --git a/target/riscv/insn_trans/trans_rvzabha.c.inc b/target/riscv/tcg/insn_trans/trans_rvzabha.c.inc
> similarity index 100%
> rename from target/riscv/insn_trans/trans_rvzabha.c.inc
> rename to target/riscv/tcg/insn_trans/trans_rvzabha.c.inc
> diff --git a/target/riscv/insn_trans/trans_rvzacas.c.inc b/target/riscv/tcg/insn_trans/trans_rvzacas.c.inc
> similarity index 100%
> rename from target/riscv/insn_trans/trans_rvzacas.c.inc
> rename to target/riscv/tcg/insn_trans/trans_rvzacas.c.inc
> diff --git a/target/riscv/insn_trans/trans_rvzalasr.c.inc b/target/riscv/tcg/insn_trans/trans_rvzalasr.c.inc
> similarity index 100%
> rename from target/riscv/insn_trans/trans_rvzalasr.c.inc
> rename to target/riscv/tcg/insn_trans/trans_rvzalasr.c.inc
> diff --git a/target/riscv/insn_trans/trans_rvzawrs.c.inc b/target/riscv/tcg/insn_trans/trans_rvzawrs.c.inc
> similarity index 100%
> rename from target/riscv/insn_trans/trans_rvzawrs.c.inc
> rename to target/riscv/tcg/insn_trans/trans_rvzawrs.c.inc
> diff --git a/target/riscv/insn_trans/trans_rvzce.c.inc b/target/riscv/tcg/insn_trans/trans_rvzce.c.inc
> similarity index 100%
> rename from target/riscv/insn_trans/trans_rvzce.c.inc
> rename to target/riscv/tcg/insn_trans/trans_rvzce.c.inc
> diff --git a/target/riscv/insn_trans/trans_rvzcmop.c.inc b/target/riscv/tcg/insn_trans/trans_rvzcmop.c.inc
> similarity index 100%
> rename from target/riscv/insn_trans/trans_rvzcmop.c.inc
> rename to target/riscv/tcg/insn_trans/trans_rvzcmop.c.inc
> diff --git a/target/riscv/insn_trans/trans_rvzfa.c.inc b/target/riscv/tcg/insn_trans/trans_rvzfa.c.inc
> similarity index 100%
> rename from target/riscv/insn_trans/trans_rvzfa.c.inc
> rename to target/riscv/tcg/insn_trans/trans_rvzfa.c.inc
> diff --git a/target/riscv/insn_trans/trans_rvzfh.c.inc b/target/riscv/tcg/insn_trans/trans_rvzfh.c.inc
> similarity index 100%
> rename from target/riscv/insn_trans/trans_rvzfh.c.inc
> rename to target/riscv/tcg/insn_trans/trans_rvzfh.c.inc
> diff --git a/target/riscv/insn_trans/trans_rvzicbo.c.inc b/target/riscv/tcg/insn_trans/trans_rvzicbo.c.inc
> similarity index 100%
> rename from target/riscv/insn_trans/trans_rvzicbo.c.inc
> rename to target/riscv/tcg/insn_trans/trans_rvzicbo.c.inc
> diff --git a/target/riscv/insn_trans/trans_rvzicfiss.c.inc b/target/riscv/tcg/insn_trans/trans_rvzicfiss.c.inc
> similarity index 100%
> rename from target/riscv/insn_trans/trans_rvzicfiss.c.inc
> rename to target/riscv/tcg/insn_trans/trans_rvzicfiss.c.inc
> diff --git a/target/riscv/insn_trans/trans_rvzicond.c.inc b/target/riscv/tcg/insn_trans/trans_rvzicond.c.inc
> similarity index 100%
> rename from target/riscv/insn_trans/trans_rvzicond.c.inc
> rename to target/riscv/tcg/insn_trans/trans_rvzicond.c.inc
> diff --git a/target/riscv/insn_trans/trans_rvzimop.c.inc b/target/riscv/tcg/insn_trans/trans_rvzimop.c.inc
> similarity index 100%
> rename from target/riscv/insn_trans/trans_rvzimop.c.inc
> rename to target/riscv/tcg/insn_trans/trans_rvzimop.c.inc
> diff --git a/target/riscv/insn_trans/trans_svinval.c.inc b/target/riscv/tcg/insn_trans/trans_svinval.c.inc
> similarity index 100%
> rename from target/riscv/insn_trans/trans_svinval.c.inc
> rename to target/riscv/tcg/insn_trans/trans_svinval.c.inc
> diff --git a/target/riscv/insn_trans/trans_xlrbr.c.inc b/target/riscv/tcg/insn_trans/trans_xlrbr.c.inc
> similarity index 100%
> rename from target/riscv/insn_trans/trans_xlrbr.c.inc
> rename to target/riscv/tcg/insn_trans/trans_xlrbr.c.inc
> diff --git a/target/riscv/insn_trans/trans_xmips.c.inc b/target/riscv/tcg/insn_trans/trans_xmips.c.inc
> similarity index 100%
> rename from target/riscv/insn_trans/trans_xmips.c.inc
> rename to target/riscv/tcg/insn_trans/trans_xmips.c.inc
> diff --git a/target/riscv/insn_trans/trans_xthead.c.inc b/target/riscv/tcg/insn_trans/trans_xthead.c.inc
> similarity index 100%
> rename from target/riscv/insn_trans/trans_xthead.c.inc
> rename to target/riscv/tcg/insn_trans/trans_xthead.c.inc
> diff --git a/target/riscv/insn_trans/trans_xventanacondops.c.inc b/target/riscv/tcg/insn_trans/trans_xventanacondops.c.inc
> similarity index 100%
> rename from target/riscv/insn_trans/trans_xventanacondops.c.inc
> rename to target/riscv/tcg/insn_trans/trans_xventanacondops.c.inc
> diff --git a/target/riscv/insn_trans/trans_zilsd.c.inc b/target/riscv/tcg/insn_trans/trans_zilsd.c.inc
> similarity index 100%
> rename from target/riscv/insn_trans/trans_zilsd.c.inc
> rename to target/riscv/tcg/insn_trans/trans_zilsd.c.inc
> diff --git a/target/riscv/m128_helper.c b/target/riscv/tcg/m128_helper.c
> similarity index 100%
> rename from target/riscv/m128_helper.c
> rename to target/riscv/tcg/m128_helper.c
> diff --git a/target/riscv/tcg/meson.build b/target/riscv/tcg/meson.build
> index 061df3d74a..5684fcf985 100644
> --- a/target/riscv/tcg/meson.build
> +++ b/target/riscv/tcg/meson.build
> @@ -1,2 +1,28 @@
> -riscv_ss.add(when: 'CONFIG_TCG', if_true: files(
> -  'tcg-cpu.c'))
> +if 'CONFIG_TCG' not in config_all_accel
> +  subdir_done()
> +endif
> +
> +riscv_ss.add(files(
> +  'bitmanip_helper.c',
> + 'cpu_helper.c',
> +  'csr.c',
> +  'crypto_helper.c',
> +  'fpu_helper.c',
> +  'm128_helper.c',
> +  'op_helper.c',
> +  'translate.c',
> +  'tcg-cpu.c',
> +  'vcrypto_helper.c',
> +  'vector_helper.c',
> +  'vector_internals.c',
> +  'zce_helper.c'))
> +
> +
> +riscv_system_ss.add(files(
> +  'debug.c',
> +  'mips_csr.c',
> +  'pmu.c',
> +  'th_csr.c',
> +))
> +
> +
> diff --git a/target/riscv/mips_csr.c b/target/riscv/tcg/mips_csr.c
> similarity index 100%
> rename from target/riscv/mips_csr.c
> rename to target/riscv/tcg/mips_csr.c
> diff --git a/target/riscv/op_helper.c b/target/riscv/tcg/op_helper.c
> similarity index 100%
> rename from target/riscv/op_helper.c
> rename to target/riscv/tcg/op_helper.c
> diff --git a/target/riscv/pmu.c b/target/riscv/tcg/pmu.c
> similarity index 100%
> rename from target/riscv/pmu.c
> rename to target/riscv/tcg/pmu.c
> diff --git a/target/riscv/th_csr.c b/target/riscv/tcg/th_csr.c
> similarity index 100%
> rename from target/riscv/th_csr.c
> rename to target/riscv/tcg/th_csr.c
> diff --git a/target/riscv/translate.c b/target/riscv/tcg/translate.c
> similarity index 100%
> rename from target/riscv/translate.c
> rename to target/riscv/tcg/translate.c
> diff --git a/target/riscv/vcrypto_helper.c b/target/riscv/tcg/vcrypto_helper.c
> similarity index 100%
> rename from target/riscv/vcrypto_helper.c
> rename to target/riscv/tcg/vcrypto_helper.c
> diff --git a/target/riscv/vector_helper.c b/target/riscv/tcg/vector_helper.c
> similarity index 100%
> rename from target/riscv/vector_helper.c
> rename to target/riscv/tcg/vector_helper.c
> diff --git a/target/riscv/vector_internals.c b/target/riscv/tcg/vector_internals.c
> similarity index 100%
> rename from target/riscv/vector_internals.c
> rename to target/riscv/tcg/vector_internals.c
> diff --git a/target/riscv/vector_internals.h b/target/riscv/tcg/vector_internals.h
> similarity index 100%
> rename from target/riscv/vector_internals.h
> rename to target/riscv/tcg/vector_internals.h
> diff --git a/target/riscv/zce_helper.c b/target/riscv/tcg/zce_helper.c
> similarity index 100%
> rename from target/riscv/zce_helper.c
> rename to target/riscv/tcg/zce_helper.c
> -- 
> 2.43.0
> 

