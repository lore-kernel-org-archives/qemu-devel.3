Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1494BC25B74
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 05:07:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBSZb-0002eJ-Lj; Mon, 27 May 2024 01:07:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sBSZX-0002dk-So; Mon, 27 May 2024 01:07:01 -0400
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sBSZV-0007Qm-RF; Mon, 27 May 2024 01:06:59 -0400
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-52742fdd363so4285528e87.1; 
 Sun, 26 May 2024 22:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716786415; x=1717391215; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AVadOk/gUWgZpMyESbbLJmo/S0d6X48+QUSqrwZ8+Sk=;
 b=Wc0c1goaq2+MU+f8zOwfFGxB5oUQIJxJjAoEsxIHwMR6n0bJvCpVOtzyecR9vS+Ncq
 1I/pbuQLmmmfn4ZsIAU+N4mz8ILEaV0DXkWCDaZ2FlrPsCO7Bw+vb/p6uDi8usfj0Ams
 g8WdsrpYr+nS22fP1IWZ3xCuVt9tltW+memQeoQZ3XStoaY9yZdqQIlKH0Hj8MTzUUk2
 PnIdeLkGKV6uwcb4T/Q9umphpowGaiAMqiKzm+Eab5kVtbq6QKilcnUaRXY8PMSGANVe
 TORufWpH2IpJaqlDUAS9/AXDVxzyMDD7lzyXD/qg2H9UrBGzKZfmQXHYAJwhhBlGDbQZ
 z23Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716786415; x=1717391215;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AVadOk/gUWgZpMyESbbLJmo/S0d6X48+QUSqrwZ8+Sk=;
 b=HeYhDuaBj777h+EedKbSbx9m1pTFu7uQR1/J+rlCZZPJS92CDUVEn3KXQZxE1iFSAr
 WIKNeeLQ1MulJz8i8KXp6jZ5VF9cckJzC81o72e3K06vtTnwjIurEW0TIOgPEI6gibW3
 fE8WM9jTawIUmMVS6imd/3l5nUR1yVgMGVC7/UbOulqVYD/zC0RCkX3pOvpdRqpkC9GC
 WACM8p+GI7ZIZ13iSeLTM989iz1Uq3z154rWmZbKF6o/HJ5BtzkBB1+fhnG2tTfYesta
 k0nYxYsfBq+13yZi+/2//xgdpgN0BvB+5SAw5RaibEoefU13bdw44NFlOcikyBNpTzi4
 FSVQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWk66/noTTMltiq7jG65xXO4LY8wEKDqXhh870IygGhv4zmVTECE3Y+pOjhlAaNlftvni7UR3omknX3QnWbJXf9pVZLQBA=
X-Gm-Message-State: AOJu0Yw/HgTqqvSWDum2nxX+SiSIJfiUDWFJIzuTCPQedDdOGvqfc8hV
 pNwx/uWid1pzhbWM0ic+TkESJsKkuufF9TpCRvNQpOzCjobSb0/aFgnLAQccPV4qJKUXYdz5eHw
 Z3h+Gt1VWVXLgxo2+DnvQdc68OVU=
X-Google-Smtp-Source: AGHT+IHOdw14bogqzXayPj/YZ7ch6EYLiLkqVyy21aVMGHn5BC5wkXsp08Rc5DQm08jUAZS8AcrJ/JrNNXZfDZ8tCw0=
X-Received: by 2002:ac2:4e94:0:b0:524:6cb:586b with SMTP id
 2adb3069b0e04-52964baf2ecmr3783806e87.23.1716786414864; Sun, 26 May 2024
 22:06:54 -0700 (PDT)
MIME-Version: 1.0
References: <20240515091129.28116-1-yongxuan.wang@sifive.com>
In-Reply-To: <20240515091129.28116-1-yongxuan.wang@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 27 May 2024 15:06:06 +1000
Message-ID: <CAKmqyKO-MTy7OrNvQiWUJ0zrgy6_QYBbUzNVQBubUdrppfArtQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] target/riscv/kvm.c: Fix the hart bit setting of AIA
To: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, greentime.hu@sifive.com, 
 vincent.chen@sifive.com, frank.chang@sifive.com, jim.shu@sifive.com, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Andrew Jones <ajones@ventanamicro.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=alistair23@gmail.com; helo=mail-lf1-x12a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, May 15, 2024 at 7:12=E2=80=AFPM Yong-Xuan Wang <yongxuan.wang@sifiv=
e.com> wrote:
>
> In AIA spec, each hart (or each hart within a group) has a unique hart
> number to locate the memory pages of interrupt files in the address
> space. The number of bits required to represent any hart number is equal
> to ceil(log2(hmax + 1)), where hmax is the largest hart number among
> groups.
>
> However, if the largest hart number among groups is a power of 2, QEMU
> will pass an inaccurate hart-index-bit setting to Linux. For example, whe=
n
> the guest OS has 4 harts, only ceil(log2(3 + 1)) =3D 2 bits are sufficien=
t
> to represent 4 harts, but we passes 3 to Linux. The code needs to be
> updated to ensure accurate hart-index-bit settings.
>
> Additionally, a Linux patch[1] is necessary to correctly recover the hart
> index when the guest OS has only 1 hart, where the hart-index-bit is 0.
>
> [1] https://lore.kernel.org/lkml/20240415064905.25184-1-yongxuan.wang@sif=
ive.com/t/
>
> Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
> Changelog
> v2:
> - update commit message
> ---
>  target/riscv/kvm/kvm-cpu.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
> index 473416649fda..235e2cdaca1a 100644
> --- a/target/riscv/kvm/kvm-cpu.c
> +++ b/target/riscv/kvm/kvm-cpu.c
> @@ -1777,7 +1777,14 @@ void kvm_riscv_aia_create(MachineState *machine, u=
int64_t group_shift,
>          }
>      }
>
> -    hart_bits =3D find_last_bit(&max_hart_per_socket, BITS_PER_LONG) + 1=
;
> +
> +    if (max_hart_per_socket > 1) {
> +        max_hart_per_socket--;
> +        hart_bits =3D find_last_bit(&max_hart_per_socket, BITS_PER_LONG)=
 + 1;
> +    } else {
> +        hart_bits =3D 0;
> +    }
> +
>      ret =3D kvm_device_access(aia_fd, KVM_DEV_RISCV_AIA_GRP_CONFIG,
>                              KVM_DEV_RISCV_AIA_CONFIG_HART_BITS,
>                              &hart_bits, true, NULL);
> --
> 2.17.1
>
>

