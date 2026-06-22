Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E755CD98F6
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 04:38:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbWPz-0008OT-Sf; Mon, 22 Jun 2026 00:37:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wbWPy-0008OD-6n
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 00:37:54 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wbWPv-000431-9a
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 00:37:53 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-6977c8ec631so1068895a12.0
 for <qemu-devel@nongnu.org>; Sun, 21 Jun 2026 21:37:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782103069; cv=none;
 d=google.com; s=arc-20240605;
 b=gm3vH6erZalqE2TBI+0Oe5Nba7vxg5Wt+D9jbJhCrS0e9zGnSF9cPAseuyA51YL4II
 0N2f7KcQtquZKyrp4H7pCWi8O5OsAXMqg+Jo43aywEgbgk5Jo4ruPm3hjhGtbHegQGPJ
 hPr9wFouaefb/eXWFRNbFCT5V/GpEDxf9T1pJTJgZth+viOBPrSCCpYL+E63Qe14TIf0
 2uzf0JBovAi9qtu6yvQKGgn2wNQEnj45bvcvA0D/ej+1wF+19D6LJ78iPtTcUKVK7O81
 bW1fqHz1x2oEnPMWr0O3mIzVHbptVnSgX+zxTvpUYo6eX37p4wehYENg6sNAI3oHlSxa
 FQpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ZvwWnsYPbqP9YbcsqqybCePj+IN95sf0XEre4c2XXXY=;
 fh=xvUAS3Ah4kCnnEgFmn2C6JrVmkXxGO+K0K4XruOLTSA=;
 b=PMwvHrNG6b/MuF9EU6uwWD9EtRucg2v16B+tZea1/nMCbGjVlmOppJix0S2kNYsJ8N
 1uZaOFiYi21XE2xer3EsBwiPdCvtK9RH8/PVMFcJbVBYkPoFfke1Mb+C6apWrM822D3D
 ZOgXiDlWF2vVAdpQyEYpMat61aMz+j6ujtHpclM7InhywdIw4fgH0o3H2NDmpT8Uy2T2
 d0jDjPC/BUAf4NePqrFxssQJKtmrFqampAnvBTx7thpIK5RL1C/vwjq8wDs7SNp9SihE
 06FljkcNMUsElUS12Zi5visyTXYVg/jHS14kn2xFkj9/trY/j6mhoQ6FtclMr7gTvpkK
 E0ZQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782103069; x=1782707869; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZvwWnsYPbqP9YbcsqqybCePj+IN95sf0XEre4c2XXXY=;
 b=EISG1q4WV3PN770m0jb5GRsdSrSSGtVT18Euw+pAjGBoahEWwaflH7/99/xJbImhJK
 308VJzaYkEBdJbRSKTkAP9KvEyVBZkvRFsSPWJzSg8m9rqrOnIWcYTLJMAfBRS9DiE3W
 pUzpM5W1m8my87IXrH2gxxI+CJf177TiKbypzlbY9rBdbYUuyO07L/LxyGBbZ8BMscvz
 0D+OZjKwBBxcC1CbMPKVyIvUHqF5iBQwZugerWn03g9P/jaOT6QrtdpmZdP9bDh87MLT
 yGOfC234/n6e/4hUb768XWI3Oqer1wqqaiYPYne5kavN1eWAwAGWkrKQaez31X+3F9sF
 +vfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782103069; x=1782707869;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZvwWnsYPbqP9YbcsqqybCePj+IN95sf0XEre4c2XXXY=;
 b=Xfmnvtpa1+5isqnR8kW5RE71cgJNFRqNBuXI9YnmBMcglsLC/aFX6ppqNAWu93hT3N
 x780gPZbHGFkBKu29JpgRZfVfi+aAtl7045QhxiGC2bpjNOaUCMEzZ5giEnptNtw1KNG
 YMR36YsDL1ct+ChdIjtFGEUBUsxFnUF4rQlH/iB7PLXgUZC64yS0N3B8RV4xf2rVCVx4
 soiflFv2mGZmzaETafco9T7jBjhBUnlOeJC5RzwNuJ0vi27iplcOAVeW5g61X6JuGvUw
 dTzNL3OO+NriVGDxXJLK58qeUcdH/TGPHKpvHy/xj9JgYhqIdd4bfv/PAy2fztumuZ31
 teCg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/iVTlJ0NALUqbQmfrwxscHBLocVhi9wGjG8ntlfyiZqe4OqKjmTLJIGb8Q1F9pE4a7x6pgk0nkAnvg@nongnu.org
X-Gm-Message-State: AOJu0YzBkoR2jd1gidEdiqCi5DhcHd6yVtiKT4D4w8u8qAhgDZH8MwcC
 W/LLQAuhwzQefxUWaBR9Y7vR3+vIZDtiVRDmAEyLdcokifBp0u+g82QMDxRNz++YN5rkmiHjr6E
 t9YT6RkCRW837CO91b9lroPYnmVaqnUuqlwTZ4RQ=
X-Gm-Gg: AfdE7cmFkH5UUAWO1uYcem9s/r7YK6STFBA1cntIa0YJc5Ugs5jSFE+yusUOSEiHfk6
 6mI3YLKTc/0IRdz3QIxhixZ5rJeqRENLJ1QjfrDVe92y6devh28yjGZCynvz0zT8ECnTXz3DaXh
 NL1xzyyEVxeWtyWcjjbRSdx15F6vSEK1S7F8lnsdKQ8Rs6b0aEYcbvRvDVI6y9pqWSYRVsgR73J
 jyAD+walqINyz+YztXSIWnl2NF3mP3jeIIBR7qWvpVFrpnCXwrCGSolQoAGlPceXSv+rgWNCyvJ
 O/lKAhYWwSsyQes1Vh/0PamZr4w=
X-Received: by 2002:a05:6402:13d5:b0:697:c176:c62e with SMTP id
 4fb4d7f45d1cf-697c176c838mr50365a12.16.1782103069326; Sun, 21 Jun 2026
 21:37:49 -0700 (PDT)
MIME-Version: 1.0
References: <20260518102118.2768383-1-mengzhuo@iscas.ac.cn>
In-Reply-To: <20260518102118.2768383-1-mengzhuo@iscas.ac.cn>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 22 Jun 2026 14:37:22 +1000
X-Gm-Features: AVVi8Cdrrg54O9E6bfne9VdbnsIP-_lR2TVB9JZnwl49hHwbeowVxXxoGRvClxU
Message-ID: <CAKmqyKOvJLvBhxd25=oLYW2-i2Uc9+NeF3Q-=kqQpesdFsnZow@mail.gmail.com>
Subject: Re: [PATCH v3] target/riscv/kvm: skip FP/Vector sync on
 KVM_PUT_RUNTIME_STATE
To: Meng Zhuo <mengzhuo@iscas.ac.cn>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
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

On Mon, May 18, 2026 at 8:23=E2=80=AFPM Meng Zhuo <mengzhuo@iscas.ac.cn> wr=
ote:
>
> During KVM exit processing (KVM_PUT_RUNTIME_STATE), QEMU never modifies
> FP or Vector registers =E2=80=94 only core GPRs/PC and CSRs are potential=
ly
> changed.  Re-syncing 32 FP and 32 Vector registers on every KVM exit
> wastes 36-68 individual KVM_SET_ONE_REG ioctls per vCPU exit.
>
> Follow the s390x pattern: early return on RUNTIME after syncing core
> registers and CSRs.  KVM_PUT_FULL_STATE and KVM_PUT_RESET_STATE continue
> to sync everything for correctness during migration and initialization.
>
> Signed-off-by: Meng Zhuo <mengzhuo@iscas.ac.cn>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
>  target/riscv/kvm/kvm-cpu.c | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
>
> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
> index b047ffa9c0..dd4193ea8b 100644
> --- a/target/riscv/kvm/kvm-cpu.c
> +++ b/target/riscv/kvm/kvm-cpu.c
> @@ -1385,6 +1385,17 @@ int kvm_arch_put_registers(CPUState *cs, KvmPutSta=
te level, Error **errp)
>          return ret;
>      }
>
> +    /*
> +     * For RUNTIME_STATE, KVM already has the correct FP and Vector stat=
e
> +     * from the preceding KVM_RUN exit. QEMU never modifies these regist=
ers
> +     * during exit handling, so re-syncing is unnecessary.  This saves ~=
68
> +     * KVM_SET_ONE_REG ioctls per vCPU exit.  See also s390x which uses
> +     * the same pattern.
> +     */
> +    if (KVM_PUT_RUNTIME_STATE =3D=3D level) {
> +        return ret;
> +    }
> +
>      ret =3D kvm_riscv_put_regs_fp(cs);
>      if (ret) {
>          return ret;
> @@ -1397,11 +1408,9 @@ int kvm_arch_put_registers(CPUState *cs, KvmPutSta=
te level, Error **errp)
>
>      if (KVM_PUT_RESET_STATE =3D=3D level) {
>          RISCVCPU *cpu =3D RISCV_CPU(cs);
> -        if (cs->cpu_index =3D=3D 0) {
> -            ret =3D kvm_riscv_sync_mpstate_to_kvm(cpu, KVM_MP_STATE_RUNN=
ABLE);
> -        } else {
> -            ret =3D kvm_riscv_sync_mpstate_to_kvm(cpu, KVM_MP_STATE_STOP=
PED);
> -        }
> +        int state =3D cs->cpu_index =3D=3D 0 ? KVM_MP_STATE_RUNNABLE
> +                                       : KVM_MP_STATE_STOPPED;
> +        ret =3D kvm_riscv_sync_mpstate_to_kvm(cpu, state);
>          if (ret) {
>              return ret;
>          }
> --
> 2.47.3
>
>

