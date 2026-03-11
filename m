Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 278E0103E2F2
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 23:47:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0TGs-00076L-E5; Wed, 11 Mar 2026 19:47:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w0TGo-000763-Q6
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 19:47:18 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w0TGn-0004EX-2d
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 19:47:18 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-66174cf4549so1051884a12.0
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 16:47:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773272833; cv=none;
 d=google.com; s=arc-20240605;
 b=HJ5nfxbMpQz5BFGgho10st50ZM+Aum7xxJLuE+8+UqYzEmnFjAY4BysTdTV/mNJ8H3
 ouS2rxE85pkrSZKnthn691asTiREkmJZ8hMkBvHTiY2MXkuF/XFue5k/d2t4ZsmKyv13
 gd2J4H9EgfoSvQQ13zv1ZoX65onYB7kqWY1GiqB46sQfVNyvfRc0lNb6K+1OnjKKnQhW
 aWiTjqs4H0wy/X++/9SBvso3L2Z9uVgb2ZrSxfUlfJkj1oKpn1fesBhfKPwRiLD3KusE
 30JX6QX66BliJBJk9Qbhmvw3y0OvBzGZLsfz92tsopTsxc4YWjmCITHfGLLYyN23Do0M
 9qpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=DIjGIwchBJcN0ZY4IMHWy6SNsbH3/egi433mj0Ot+3U=;
 fh=gyw2IT0S9ovlO7tplTyKntB9SC6GJkB+lS2xSPCbvkM=;
 b=D+CNOahFa8rn9c5bv5ADcTeWWFQzlYX603omRPVdbtEXdx/I83/KWZbekvvNaNstO9
 VJyDpEFInOD3aITiImAjNwt3njN5VmJX6muTB2XDYMyX/Wy/l40JWmk1R700le7E5FZk
 6yrWJRmrJuD6zc9ez8Ltruj9H38yaytkLOZXY08Cz0FbyWDAoAvkd/vD07WtxPYFqJTv
 MPTwGTROJvIH5SeB/aDiFcJrnrEqz8SSsIhpGF6PDA5GH+uQmpyLmtI25xpFSvDo2zu4
 4qqo9CLg7ckXpj7jUFkRLOf2jE0FaTmh1tpn7I7ZmZ9RauVzpEUrlrmgbdHU2Cx0Ddu5
 y0Iw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773272833; x=1773877633; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DIjGIwchBJcN0ZY4IMHWy6SNsbH3/egi433mj0Ot+3U=;
 b=Kra1guZSKsMMZFMcFV+BZl+nhFds022OrjDfz2JDkssSnUx3dp92kBtaN+HIrXGGg5
 2Q3Ot2ZWb/PwcOD3AS9XJapPBz2hEd7/tTChfMEugXARTnjhGN3d50f3fycuPOoDa9dM
 CgphfsMlzv3UHPmVdvzf+H/N0aAtdGFx9EqZPxY3hiIoqX9AVB0cTEhu7iPpHyBrwBe9
 xY1iEYonHJMfAWXXUbtaL0ei/Ih6FqOAKSO0k8Mf6VMyuHoIW9FTH2B2irCynbdQyLob
 fFcAlpO/KhAr8IB0N/a+gr/4vXH2DIN4hwH6YC/HqKUE1WQZnqsZEym6CEWZYrZVMzIN
 A/kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773272833; x=1773877633;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DIjGIwchBJcN0ZY4IMHWy6SNsbH3/egi433mj0Ot+3U=;
 b=GLrUENSgWoLa3voIdP1V41IYINhcHNKlcOQdH3XOla1r65zC36frjqy9j4L28wKla6
 BYJP1aWd1ydPtTBKl9z8IU0TRBavdpIIoquoTsTM8b6chslTHTgZOZg9UtCpZ16czbBW
 L7xGuSoWBog9H14DNWPnApKHnBF617eAziT8v/ygi3dQaMRDpdrb91IzxKkPnJL1Jrv9
 R+LvgUpw2BXD62VwWuUseog7cjO/DSozxuo8Oa1RdvbZ673Jnxcp4ulcW6ocUiAYuU/T
 T8AOXXcpjJFFhOl3vqWqak4H3biO3SE0ZO4LlcgYFy1T1SjZ0/DAp1+zOb2pX/YVyYeH
 fFVQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXudmikwT37y1BRR6fxWmsdFvsXoZkab8h51QBxYLGqoL4+YLK2ijEUrsnL2hvMe/DMdjFSQIuMXdm/@nongnu.org
X-Gm-Message-State: AOJu0YxHjIc8+dIjuD+AB81fOAblTliAQCmZEm79MYvPOhovvLcz76h7
 PwmkcY5BzmsrcWAuNA/Pws8fZyz0DNIHePirBOLXydnWhsaYGhMoiIID6+sLdOx2LsLt3JmNMG4
 TpnSniWndN0SdjB4tXM7LPaet/Eb8Fq0=
X-Gm-Gg: ATEYQzyZgQZt7cO40GtiB/xmHFc8f0HgAt9BtBhEidWboUoAJ/xxaE/jTl0ICDymY/4
 ZGDTnERXCE6heBX0tD3kuevmizND2atAb3fbQ05JMLbaSdT88fV1s9ZjkI5Bj4aN207c3fsWzfZ
 HD0Tm1VA6sSPOJTtlnK2w31jPF9xnXi3Lv+aa75Np+9BhKdtFswqxkBg01mmMYWfZiMRQ+80WR0
 K1UXMfMkpUAy0dt2zQMJcsKBQlZZtztp1umQeUGQt4vzfU0gjdAcFKb8CsPavyzqMOjNHlBxyft
 lIRf2pPrZx2n1YPMtK9XFes6BzkSiuu7ueF6wg==
X-Received: by 2002:a05:6402:51c7:b0:65c:76a6:4bdc with SMTP id
 4fb4d7f45d1cf-6634fec8c8fmr787513a12.9.1773272833301; Wed, 11 Mar 2026
 16:47:13 -0700 (PDT)
MIME-Version: 1.0
References: <20260305171729291ZzfxmqZ48P2Tbz9TGCtST@zte.com.cn>
 <20260305171958533kl0ISsA1hGkh97tu5LUWy@zte.com.cn>
In-Reply-To: <20260305171958533kl0ISsA1hGkh97tu5LUWy@zte.com.cn>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 12 Mar 2026 09:46:47 +1000
X-Gm-Features: AaiRm523PZp0vchjoMBytPnAX1BT68HwJgaOK104NPw-hH83O5IS-LPbPpNPaNw
Message-ID: <CAKmqyKOwoh9Z0FmT37V6636vWgRK1JQjzZy_N5ACewx5NHdKRQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] target/riscv/kvm: create kvm_riscv_aia_access_reg
To: liu.xuemei1@zte.com.cn
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com, 
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, peterx@redhat.com, 
 farosas@suse.de, chao.liu.zevorn@gmail.com, qemu-riscv@nongnu.org, 
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

On Thu, Mar 5, 2026 at 7:21=E2=80=AFPM <liu.xuemei1@zte.com.cn> wrote:
>
> From: Xuemei Liu <liu.xuemei1@zte.com.cn>
>
> Create common function kvm_riscv_aia_access_reg to access APLIC
> and IMSIC regs
>
> Signed-off-by: Xuemei Liu <liu.xuemei1@zte.com.cn>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/kvm/kvm-cpu.c   | 7 ++++++-
>  target/riscv/kvm/kvm_riscv.h | 1 +
>  2 files changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
> index befcbb0a9a..2c29d8d07c 100644
> --- a/target/riscv/kvm/kvm-cpu.c
> +++ b/target/riscv/kvm/kvm-cpu.c
> @@ -58,6 +58,7 @@ void riscv_kvm_aplic_request(void *opaque, int irq, int=
 level)
>  }
>
>  static bool cap_has_mp_state;
> +static int aia_fd =3D -1;
>
>  #define KVM_RISCV_REG_ID_U32(type, idx) (KVM_REG_RISCV | KVM_REG_SIZE_U3=
2 | \
>                                           type | idx)
> @@ -1842,13 +1843,17 @@ void kvm_arch_accel_class_init(ObjectClass *oc)
>                                      "auto");
>  }
>
> +void kvm_riscv_aia_access_reg(int group, uint64_t addr, void *val, bool =
write)
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
> -    int aia_fd =3D -1;
>      uint64_t default_aia_mode;
>      uint64_t socket_count =3D riscv_socket_count(machine);
>      uint64_t max_hart_per_socket =3D 0;
> diff --git a/target/riscv/kvm/kvm_riscv.h b/target/riscv/kvm/kvm_riscv.h
> index 953db94160..cec13d9f31 100644
> --- a/target/riscv/kvm/kvm_riscv.h
> +++ b/target/riscv/kvm/kvm_riscv.h
> @@ -23,6 +23,7 @@
>
>  void kvm_riscv_reset_vcpu(RISCVCPU *cpu);
>  void kvm_riscv_set_irq(RISCVCPU *cpu, int irq, int level);
> +void kvm_riscv_aia_access_reg(int group, uint64_t addr, void *val, bool =
write);
>  void kvm_riscv_aia_create(MachineState *machine, uint64_t group_shift,
>                            uint64_t aia_irq_num, uint64_t aia_msi_num,
>                            uint64_t aplic_base, uint64_t imsic_base,
> --
> 2.27.0
>

