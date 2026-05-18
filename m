Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07A17CD4F3C
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 00:31:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOltA-0003RK-JQ; Sun, 17 May 2026 20:31:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wOlt8-0003Ph-QS
 for qemu-devel@nongnu.org; Sun, 17 May 2026 20:31:18 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wOlt6-0003Km-Tw
 for qemu-devel@nongnu.org; Sun, 17 May 2026 20:31:18 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-67179ed133dso2045350a12.2
 for <qemu-devel@nongnu.org>; Sun, 17 May 2026 17:31:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779064275; cv=none;
 d=google.com; s=arc-20240605;
 b=E/MIDCfppXpotynatvQRrLy0KxN/cdL2deContdMUwpkjRpahXNLcvpnycB/adqusI
 XXGQqYRFIj80tdQBIc/BF6JVnXFHFDVvCBdJKFXi9MYb8tPUdU+A6SnSyDOM0SuErDll
 38D9/WXX3KDnSk12+gY+tf3gBcsiPpH7ak6WXS7E9lwWKt5BA8toxj0q3TgHNSZ6hhME
 x/z+Rm8xd1AWjUc4zTb30CFJ4cK9SeVr8tVHKFZ4nN5UcOgkxiSyDrIOuJzV5hYWbENi
 /PJz9cMT7qjUcsu/IKrGH2TwoGrIZPxStMjsSVotp6H1eP69cmF1Cois3uwK+sFVRWoI
 LbAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ao18OrPK59ADZagYZZqGbWwS8VztrM60bRTxETz1Htc=;
 fh=3Sf9BLDVZ4JX9vg6z70n+7pXurqJuwEJaRk/xKNPJpo=;
 b=Ue6vU0EqoRfVhr86DyQkXPTz5e7ElwOx5zB4neU77S+DJv4rsF5/wPfbPTFdH+gkJj
 /NYx/ZzTptj3ZvnEu/Sqhztj2LD165dwXV9uJeZcW0SfIPxin1cpX7MUnocVJpMd0wKu
 kCXYcfs9zrI5SBBOVAqMFPVmVLLMBweCpFnHCaRkOBtwBdDU3Q9VtVmiSN2QHx8JnMWP
 145xiNBS7X3vudyXZlyC5/l/uWFIZLp1Yy+uGdTG0Cuh+6QdEOFJCDg5DA1xZhlLHEli
 Clplv/faAqP051eJvOXkkWgi5ry17cQF8EKCNROs5XuTy6PMopruxFtIjeBfQ+4XQn5Q
 w/aA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779064275; x=1779669075; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ao18OrPK59ADZagYZZqGbWwS8VztrM60bRTxETz1Htc=;
 b=lVznaTKUFm+1UhODug2HFU+tJgFLB+/DKeZRjBMlXJJb1+0hy82h7hYMyaCTtbT3He
 BnfWu03sFFwNF0z2Zn9UIHIW/K5UgMsuzfrJqym20v2lOCXHyHrxa1zilYR5bD/6tOH7
 0gjj2aA/R9PvgxjxDD4FcDgl6UAO5K2wIdMPTElqQo8ms31I4IhC7xUX9VrboEbcEzwS
 fX0MeWVJcRIQm6AFOxtVT7WxpG26QckMyfED2R5PQECCpSHVNcHBbSVzNZsNtvnJpS/2
 g3lNk7B2+lVMXwfCLmqJs17zhi3W4EhWytnHoyAxfX/dLbryU3BPRe8ZSwsSaIhroekH
 vavg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779064275; x=1779669075;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ao18OrPK59ADZagYZZqGbWwS8VztrM60bRTxETz1Htc=;
 b=Cw3UYZq3+ddqcTY+jyp6gtzWL7EX9rQx1H1JOa5whJ7p9+jonlXc5LVyUH+Gh7y9Jk
 48F+x2XOZdZ6pRSPdrvdEVI1rSHUjN7EF2pxKbw485/yU3xh7xz6BxYsQK4tgN1xYswb
 2EyU4brokBWpn4vvDS/uH9NCyIz9euU8KYqEdlEdUfe8/kEi8coXQqaSjZdDEA8V83DM
 pIVrAIx6rrJ0Xc94yL6va2YNdOU/pUdHtbm1NsyomjVQeHqiFW26TBiCB72t6m11x2Dx
 5/nZ0Azt9AYIKuAX/EUosoU8g82LFEOwqeIoJYzTziLDa7uEkVVdI+IFBztijMqHaMtc
 WmaA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/FuE5fj71S8u5yVJmxXJOq1SZPRTJ7kv21X/PSxhbHRUiCJfJ7UPXOUeXdqi59/DfOsKG5cUdm3Fzb@nongnu.org
X-Gm-Message-State: AOJu0YzW6p15hIu2nIuqy6UxhgNxwQ4/iqyrrwl8hkcPb8ZFF/v4EKfp
 czTHKHCPUrfxWpjeCPJQEpEtYFJ3PM1k9G5Od8Qgyqq+NhJaW+aKAvKBW6mqMomObv8v2uWat96
 hQFRFvRBcU7wE49d0LvIAw1cCHSUU+9Q=
X-Gm-Gg: Acq92OG+Et1p5TRcnWD3t/VCm6T18414c82xkdGh3b9as1ToG4d9IXTXCeaFI2/ZiUE
 hVYKLIWlDMOmWkYHC0f/NDrvTwHr9G1tlZ5WyZbKXv9mYx8UCT/t9vs68woE/VBcNefpe3A40TH
 HY+BTMAYrpyHRA3Bz+Q0YS6EArQ0fX7MDsKlpSG1vcOVuKE7XHUEqx2rDtsvdMTtJxc0UkyX+Kb
 orH6XWjiNW1Mbf8PaGhcrnF3bPk6WIEItGlyERF2pP7Yq/mtqsiqQK1iTpt7GqUl+CB7uISxqta
 v1uoQUQWPdFYuFcLBvx5aKzb/bsiApd6sVViqQ==
X-Received: by 2002:a17:907:c714:b0:bd0:7949:a931 with SMTP id
 a640c23a62f3a-bd517960723mr691216966b.27.1779064274905; Sun, 17 May 2026
 17:31:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260508174917.371667-1-vulab@iscas.ac.cn>
In-Reply-To: <20260508174917.371667-1-vulab@iscas.ac.cn>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 18 May 2026 10:30:48 +1000
X-Gm-Features: AVHnY4LhiyDxjn9Pc8rH5QEyWfuVYwKdFr50GNG5kHxPxwc-mRLK9Hp8FCEh7kg
Message-ID: <CAKmqyKNjcVLUnLM8Zs3e-c7fNYDt-D7AZf3ASFk3Sag38d9J5g@mail.gmail.com>
Subject: Re: [PATCH v2] target/riscv: Fix missing CDE check for scountinhibit
To: Zishun Yi <vulab@iscas.ac.cn>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu.zevorn@gmail.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x536.google.com
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

On Sat, May 9, 2026 at 3:51=E2=80=AFAM Zishun Yi <vulab@iscas.ac.cn> wrote:
>
> According to the RISC-V smcdeleg specification: "When menvcfg.CDE=3D0,
> attempts to access scountinhibit raise an illegal-instruction
> exception."
>
> The current implementation of scountinhibit_pred() only checks the
> hardware extensions (ext_ssccfg, ext_smcdeleg) and virtualization
> status, but completely misses the runtime environment configuration
> check (menvcfg.CDE).  This allows S-mode to access scountinhibit even
> when the M-mode has explicitly disabled counter delegation.
>
> This issue was discovered by the SpecHunter tool
> (https://github.com/yizishun/rv-isa-sec/blob/master/output/riscv-isa-manu=
al/pr-2571/qemu.txt).
>
> Fixes: 6247dc2ef70b ("target/riscv: Add counter delegation/configuration =
support")
> Signed-off-by: Zishun Yi <vulab@iscas.ac.cn>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
> v2: Removed mistakenly added #include "cpu_bits.h".
>
>  target/riscv/csr.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index da366cf56271..9ae8d553dcf1 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -398,6 +398,10 @@ static RISCVException scountinhibit_pred(CPURISCVSta=
te *env, int csrno)
>          return RISCV_EXCP_ILLEGAL_INST;
>      }
>
> +    if (!get_field(env->menvcfg, MENVCFG_CDE)) {
> +        return RISCV_EXCP_ILLEGAL_INST;
> +    }
> +
>      if (env->virt_enabled) {
>          return RISCV_EXCP_VIRT_INSTRUCTION_FAULT;
>      }
> --
> 2.51.2
>
>

