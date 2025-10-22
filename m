Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A443ACCD1BE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 23:58:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBii4-0004ST-GS; Wed, 22 Oct 2025 19:57:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vBii2-0004RM-Rs
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 19:57:38 -0400
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vBii0-0003PT-UX
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 19:57:38 -0400
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-7849f01e56eso2262207b3.0
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 16:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761177455; x=1761782255; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XMPRTuQWnHVvVcdEtHlUA7TNmKlGkGfYrVz2tXnkjw8=;
 b=OPEtGYS2tc/dGfvSnMvQb+pdEUa9En18fwV1qToieB6GjVRHP1rjhtud3ILS5HhGET
 PWlsbc8f1l4SZe8QC/+pNsMzHk4KlnL7CMiolpckGF+n2FixDv6z1a/4al38a8enUmfI
 3XR7dk31ca7WXqICBL5864meEz9SNJqI1oxtoyUY5/wJCpOo5Y6J/MBqWqBEhEBm24jK
 sUBbCipjO0AhX2dtzlhkD7ljku2rQCglf896Rq/0QM7xDqe+cx6lbAuViV3JqsUR/TKM
 aH0i3Vl8uFvXkC/jHDAxuQyEZ2c0rRFDwl5m8NJ77wEjRboV1pYqI39xxxTNOn8Jo+7o
 hmlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761177455; x=1761782255;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XMPRTuQWnHVvVcdEtHlUA7TNmKlGkGfYrVz2tXnkjw8=;
 b=aFMX/u8+/s4wt0YnAHwoposD/C1f26p9TCmGnXH7EeAz8m8Oy6hIFypSmkQIawGIop
 khXG0PC2Y/YvZ9PfpNo5BZsl5zPB/gMghSOxLkTLqlUUYc163QQroxo+eO1rLwUE7fxA
 FABAsI/uKCf4vZ85mKm5cCcxoiOYoPr5indN4uuN7QCZ/3J3X9AfdhyF2HMheH2v+Dom
 4a8wt/77uF6pC8IDX9Gge2xC6Q5axvwUsFn4r/ZMIajl+SchJonflk5UlDzSqa/nvppB
 X7k+j6dey+5Exq1/jsVX7a0gpZsCpwGj1xjYhP7YCkYglZfCfDf6VmychSD34oMI41m2
 2wAw==
X-Gm-Message-State: AOJu0YwL7udHyifPBzEv8nnn6thOEFd7WBgotC4G5lmp8j/JeoJyU+Wu
 QU+Pk9ntYrRIVTqulSvLSDMgm7MLWgigIelT3W5ltasce9k55YELVtxHgooXfkgdftA+XlOUGWB
 IRZYCJoMk1KI5Q4et4TrgxC8YtqIo440=
X-Gm-Gg: ASbGnctjNGfLNX3DLzYZ/1iEOmpMoZckGsdj49NhtT+YliqpCqLW8Lzop9xV+Hy8ide
 sJqQu+sTbMuE1ei21N5C1w8GJDuNQtjx5vjLW1uQTUd+5eoHW4ztDmgVqMP+bNcSusb9Vj642pw
 2e/slF5kB1yWRL1HXdBfo95PN6JIXI1QC/cWXIXRo9ZORvvo4yuoz6TpY+APwuwizywEoKj1H9I
 wXVwkZ2bhqWq/CePa/4q7cKvgxaeW8Wp4SgV760j822NLTxF33otxbnsJc8hp8GPcIDnpYVfnop
 duN1u1s5sYRs+b4=
X-Google-Smtp-Source: AGHT+IHjKK77EoQUL/3nFesR/wOi5ZWMSi8GZ1vcVDDQ2PrMPNc8/Cexbq/815/iKEwVn206osdmuzMJ2OEOP3XctSo=
X-Received: by 2002:a05:690c:22c6:b0:784:8286:fde3 with SMTP id
 00721157ae682-78482870f7emr155994957b3.42.1761177454948; Wed, 22 Oct 2025
 16:57:34 -0700 (PDT)
MIME-Version: 1.0
References: <20251022111105.483992-1-dbarboza@ventanamicro.com>
In-Reply-To: <20251022111105.483992-1-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 23 Oct 2025 09:57:07 +1000
X-Gm-Features: AS18NWDWA0_3xqlTQWfNW3p1IZtMs5d3eUdgfeOWzia3JvT4rXzScXLNhdZHvog
Message-ID: <CAKmqyKP5GK0w=vN9R467dVPha+GeUeiHN1gf5h3U3xp5BAKsDg@mail.gmail.com>
Subject: Re: [PATCH] target/riscv/kvm: fix env->priv setting in
 reset_regs_csr()
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com, 
 qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1129;
 envelope-from=alistair23@gmail.com; helo=mail-yw1-x1129.google.com
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

On Wed, Oct 22, 2025 at 9:12=E2=80=AFPM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> This patch was originally made by Gitlab user Bo Gan (@ganboing) 4
> months ago in the context of issue [1]. I asked the author to send a
> patch to the mailing list ~3 months ago and got no reply. I'm sending
> the patch myself because we already missed 10.1 without this fix.
>
> I'll also just post verbatim Bo Gan comment in the commit msg:
>
> "In RISCV Linux with KVM enabled, gdbstub is broken. The
> get_physical_address isn't able to page-walk correctly and resolve the
> physical page. This is due to that the vcpu is being treated as starting
> in M mode even if KVM enabled. However, with KVM, the vcpu is actually
> started in S mode. The mmu_idx will give 3 (M), instead of 1 (S),
> resulting in Guest PA =3D=3D VA (wrong)!"
>
> Set env->priv to PRV_S in kvm_riscv_reset_regs_csr() since the VCPU is
> always started in S-mode for KVM.
>
> [1] https://gitlab.com/qemu-project/qemu/-/issues/2991
>
> Cc: qemu-stable@nongnu.org
> Closes: https://gitlab.com/qemu-project/qemu/-/issues/2991
> Originally-by: Bo Gan (@ganboing in Gitlab)
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
>  target/riscv/kvm/kvm-cpu.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
> index 0dd0d59d41..000e44b2b7 100644
> --- a/target/riscv/kvm/kvm-cpu.c
> +++ b/target/riscv/kvm/kvm-cpu.c
> @@ -705,6 +705,7 @@ static void kvm_riscv_reset_regs_csr(CPURISCVState *e=
nv)
>      env->satp =3D 0;
>      env->scounteren =3D 0;
>      env->senvcfg =3D 0;
> +    env->priv =3D PRV_S;
>  }
>
>  static int kvm_riscv_get_regs_fp(CPUState *cs)
> --
> 2.51.0
>
>

