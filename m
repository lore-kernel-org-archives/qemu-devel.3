Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A26FCD98F0
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 03:07:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbUzz-00060b-5V; Sun, 21 Jun 2026 23:06:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wbUzx-0005zZ-Ac
 for qemu-devel@nongnu.org; Sun, 21 Jun 2026 23:06:57 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wbUzv-00075K-Ls
 for qemu-devel@nongnu.org; Sun, 21 Jun 2026 23:06:56 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-6974ef0c3b1so3488130a12.1
 for <qemu-devel@nongnu.org>; Sun, 21 Jun 2026 20:06:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782097614; cv=none;
 d=google.com; s=arc-20240605;
 b=Lopl86Yn4Ki7S7RDHwo8l0hu2L/DYplS51/UudtO5NynKjq79Fi14CRfWAdr6NxiSo
 D7zTHjeELjEBjPUQ+C/a5uRs9b0V+h67x0ziozCJhZIZjiY+XFsdKHsoT9iq3Vt4kbZU
 6cXssDoAesgkJ9xms51LFT7n6XVV3va3hKhcX9N40bu/jp7nforvNSAgfkbh0rXl89DL
 sXUam2Lt/b+h62VsVutvfn2H2vrq3uqwsQz8IBBTtEktBAGBYWFK8UoMh+cRbFwAIRBg
 riw3REfNDOG/CyESoCnP1OnWJ7egtcrVOR2RMyBYXL5fZMl8RnhrHfUa22ykCTYj8b1q
 jinQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=9lBpFvQgke2vv5Ml8b+qHrO31bIE4gs/UA33vAzhX5c=;
 fh=M8a7lnvwUIhzfmVXoF9CbZI/0WMj9cykP7fp5FCiUsU=;
 b=cfRTYNz5FG9KqI6iwpR5QdUzjnI8uoSWBb2V1JPwN/0GNMvO+YyvDn6opsAr+ZTLG8
 O4FxaT2ie+OCn1YqAab/efSXTepnoJpRzHzKJlhsU4DJGzJhNV8hzGuY8mxlU0UHQJc8
 kFKLYxsJ3MitqE2y49On/0XmV8W5o6noMyRe0/PCrZLOuquCLuJEEECAAPe8YmaHGECm
 rvKVZMZbakIITkg0q0UPu6kWuKY7lonA8SY/78q0juPby/MZ3luSQBif+DJM829vzVO8
 WNoj3+sE8eicZItnPBuxt4lIrdZS40yzJde1G8FCehj/HpCaSLJwTd0w3LIn1I0jPUSF
 KXSQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782097614; x=1782702414; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9lBpFvQgke2vv5Ml8b+qHrO31bIE4gs/UA33vAzhX5c=;
 b=UvRib+XvpH8YMTDRnnZInZu1GmB+4k5zCMidAk5BwMhpaXC+9dnII/khZMG3ZZPmvr
 PPsKA2Ui0HQw2mu7AOKL47dp34/Y1rNmWTRTql6IPFYp45H8UVfExV1L419WZx52kE+3
 RDmxfJzLp2eFd7lXACoFH8lX0rR/WwIHomBYasGpKRkk8M7OICRvQSL4UqxI4AYysfgJ
 MSEaOOg+npmkHdfR9lHrM2ZV4IoYlNj49b51GH0Wsg3VGf/ATwsJbn09bu2RKcC5fd/9
 a9x+K9TBTLhBCJLsHuZNSzheINQZDbmRqzwEpV6NtNazrgKpHG+q8uebnIVcTFxls8VF
 l3/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782097614; x=1782702414;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9lBpFvQgke2vv5Ml8b+qHrO31bIE4gs/UA33vAzhX5c=;
 b=irAX/kSAEME67wVvziLe9Vt4mjb0Bb3YcJCEwNiHgDW+SCxPu0pX6QFXs5jZD0mMmL
 /F+NjrpUHCJCH6yc80gG/fsDLA0wqzevK7qD33Pm5MVYSD9aID8aheGJD3FgQOw4ReOR
 hEiE5+Y4gW5pbsbBH+IVIxmWEJjsTU66t9wKSStgekmKUooug2n/67HTz6YdKRinT1DE
 1+FX+OZONrAxFCYNedF9hTl/HpR6K/YvRSihp9oZur9Fkm/e8zj0PJ1vfkP6ae38LNj9
 vjiVoZr6e8KckStqt8IjCLVC44eHBKmcUxjh+pdDJjsdOeSafuIg4LIb9GWxRBfQWYiK
 aqpw==
X-Gm-Message-State: AOJu0Yy715wWHQTGwZhFT6B3pWn8hbniYIaNmlIfzpnqvuTCf0gQoUAZ
 K4gik945p0I5fpYSagHf6ZEftQz9CwFpCD/Vj3fdIHu7QUn2BQ1RgpHj/vDEYMcOxAPSXItU0YT
 n67nn8J79WECwmZMlgN9822InP3hh19Y=
X-Gm-Gg: AfdE7ck3jC3h8tYn8GLf+O0R/B/yKEAKcyJ0W1krshKtIOYOGgvdWqqKhEj4wmE7Cue
 jZ/Lp0pPzLzB2gAuJtCnKgB4YPsMoW/+anTdQDGe+oe6swiadDsrzohj3k9cKW4AJpnYFI/qmKE
 PEnRE8vESISFI2hmIMXq2QZVyMJS8AsL20EGy6ul/ccJg/KsLqdAK5Dmi7q4Do2BJJxM6Ry2OBt
 GO99jnrEvbRPcOdbuq2ryXyOoLS9+2w/ZwI0gywNp3u0irZM//CjhKOL+xD1vtrxrrU6nmDYYGd
 O0dldifoTExYp5DRu7N/VX9y/dQ=
X-Received: by 2002:a05:6402:a295:10b0:697:6415:1186 with SMTP id
 4fb4d7f45d1cf-697641513cfmr3035622a12.26.1782097613573; Sun, 21 Jun 2026
 20:06:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260604120017.398890-1-qingwei.hu@bytedance.com>
In-Reply-To: <20260604120017.398890-1-qingwei.hu@bytedance.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 22 Jun 2026 13:06:26 +1000
X-Gm-Features: AVVi8CdBPOQoFr1d7XH5ICUzI2Z-aKswEjlDkpU5HQho1LJgM9hOzLdk6MdWgLU
Message-ID: <CAKmqyKNpHNmrPOJqS_1Mzaf=evvxvuO_kosFHnLN6=bP55ZFyw@mail.gmail.com>
Subject: Re: [PATCH] hw/riscv/virt-acpi-build: Fix RINTC PLIC context ID for
 KVM
To: Qingwei Hu <qingwei.hu@bytedance.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, sunilvl@ventanamicro.com, 
 palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com, 
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com, 
 chao.liu.zevorn@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x531.google.com
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

On Thu, Jun 4, 2026 at 10:44=E2=80=AFPM Qingwei Hu <qingwei.hu@bytedance.co=
m> wrote:
>
> Each RISC-V MADT RINTC entry contains an External Interrupt Controller
> ID field. On the virt machine without AIA, this field identifies the
> S-mode PLIC context associated with the hart.
>
> TCG virt has both M-mode and S-mode PLIC contexts, so the S-mode context
> ID is odd and 2 * local_cpu_id + 1 is correct. KVM virt exposes only
> S-mode PLIC contexts, and those contexts are numbered contiguously from
> 0. Reporting the TCG context ID for KVM makes the guest enable a
> different PLIC context from the one used by QEMU.
>
> With ACPI enabled, this can leave PCI INTx interrupts pending in QEMU
> while the guest-programmed PLIC context remains disabled. A virtio-blk
> root disk can then stall during boot because its first interrupt is never
> delivered.
>
> Use local_cpu_id for KVM and keep the existing odd S-mode context ID for
> TCG.
>
> Fixes: d641da6ed43 ("hw/riscv/virt-acpi-build.c: Add PLIC in MADT")
> Signed-off-by: Qingwei Hu <qingwei.hu@bytedance.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
>  hw/riscv/virt-acpi-build.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
> index 413d47d70e..6b06d9aa87 100644
> --- a/hw/riscv/virt-acpi-build.c
> +++ b/hw/riscv/virt-acpi-build.c
> @@ -100,6 +100,8 @@ static void riscv_acpi_madt_add_rintc(uint32_t uid,
>          build_append_int_noprefix(entry,
>                                    ACPI_BUILD_INTC_ID(
>                                        arch_ids->cpus[uid].props.node_id,
> +                                      kvm_enabled() ?
> +                                      local_cpu_id :
>                                        2 * local_cpu_id + 1),
>                                    4);
>      } else {
> --
> 2.39.5
>
>

