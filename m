Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED0E8C7EE39
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Jun 2025 00:53:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uW2lT-0008U7-L9; Sun, 29 Jun 2025 20:52:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uW2lR-0008Tf-MR; Sun, 29 Jun 2025 20:52:53 -0400
Received: from mail-ua1-x935.google.com ([2607:f8b0:4864:20::935])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uW2lQ-0000NX-9o; Sun, 29 Jun 2025 20:52:53 -0400
Received: by mail-ua1-x935.google.com with SMTP id
 a1e0cc1a2514c-87f36c458afso965908241.1; 
 Sun, 29 Jun 2025 17:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751244770; x=1751849570; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VyBUcrafNFXi+VRn/b6EMiGk/uyewRX9M4v1p5fGOEE=;
 b=S85doqCQbU3WZ1SIhYKA2/Eby96MEZTqVJnpDM0K4RpUe6sjvBEa2Rts7BnFpoYC/C
 iIdMQ2kNan4zlrlxkOShZHV9q1hMeuasIkLjGZg3zpwCVu9ow7930y57Npyg6w+bUVpO
 fMcWGZqJkM7ZUfXFitbkQIVI8PZcYLZny64ocFr+XdmTWRL6EOHEtQkK2+WEUqvVY4hW
 C/v94WguHlNp2YGGtMf8z/DTUpHl5RT8Y9zsr+2x4u5n5tclSqyM6SfLnRL7pxcF1NJZ
 zl5noI8UkPzTNkjQlq2njy0bIqt8efwRPA3qJLayaW9a6gC8eovGbZQlDnWFEh1+mI9Y
 esBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751244770; x=1751849570;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VyBUcrafNFXi+VRn/b6EMiGk/uyewRX9M4v1p5fGOEE=;
 b=rqNhb49C8DgDPRe/iU3GttHT5jNVlBifjUiFBimDTc32dYIaf+2fqhiJKZ63JiWe+2
 0tTLgFEFPWAuWea215JmGCVAyuMy3HgJfNp0vMesG9Lt1H4jjblRqZA8V6y3fKB4wClI
 Yw+ixu7YIAxJN7TCR/Y9JChuDBDn1pN3EBrn+OwuLLUqOZBojl8PZRBiTb4A26VaYLc4
 TO9HrKPVfpWsKVWPzjCwLwlJhZDXv9sgiCc/xthJcnFcLcTycgtcccEh5k5rP8rOAyuh
 wFOKYp5MCaEqKCjCD7qZhQvzIGhDwUnH1O8HKFOHpnOibzTIZL3J7wEzv91pTvrS2WZA
 xeZg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVUhhP7iOQYRoTzq+Iu4sXao8JoWG5cBTxAs1l2ql76cmN6x7wxy/s04uKJ90AMkBmzm62OpoYZyIak@nongnu.org
X-Gm-Message-State: AOJu0YwVl2phC9itZYN0ch0A59J/VIkaaOGCUd83rdVTqoc33IcaYbRj
 dYbOgFkiTlqzYn3wEpc6nR7ftW0frSVTiqnSy0DrbDtCybnk7cvxwQwq5HqHZjUG7mA1v76Shpk
 CqwPoB4sttbqPG36n81rlRYHuG/1+kZg=
X-Gm-Gg: ASbGncs41knNOxGPGcJSNefPRx9V1tMzXNLD2TEZC8LNoieBpy1oAgfyUwjCePGgT+D
 xMXJDlgthUEnaSH7ZuM6anm7U2nJvDDV/k4WlXuc41J1yGUtpa+LoBbLPhIwfZSbUYar7kHinGc
 jGqUb+l7Ft2Ri1K/AhMgj3yp+8pE44H6gdiN6N7Bva9yk15hYS/ogeyBi480fDNP70KHRr9gB6M
 w==
X-Google-Smtp-Source: AGHT+IGRomADjRDlAh+WqdQ4EGLCRfO4rren3DK9rHoILzPwfPmmA+9K+vS2jJgk0NJbfY8vk1w1Lop37aOPRxX0oak=
X-Received: by 2002:a05:6102:1613:b0:4e6:245b:cf57 with SMTP id
 ada2fe7eead31-4ee4fa05e70mr7088883137.24.1751244770490; Sun, 29 Jun 2025
 17:52:50 -0700 (PDT)
MIME-Version: 1.0
References: <20250627133013.443997-1-max.chou@sifive.com>
In-Reply-To: <20250627133013.443997-1-max.chou@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 30 Jun 2025 10:52:23 +1000
X-Gm-Features: Ac12FXxv_ltPuxPjXDwpymYMgKMNc3qKS0w50SSCl1uJ10lvuyTO1RcOc1u_clI
Message-ID: <CAKmqyKPeh6UK55oPZHOa6WfUJyZ3nbqau4oudUn_9kMP3otGEA@mail.gmail.com>
Subject: Re: [PATCH] target/riscv: rvv: Fix missing exit TB flow for ldff_trans
To: Max Chou <max.chou@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::935;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x935.google.com
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

On Fri, Jun 27, 2025 at 11:31=E2=80=AFPM Max Chou <max.chou@sifive.com> wro=
te:
>
> According to the V spec, the vector fault-only-first load instructions
> may change the VL CSR.
> So the ldff_trans TCG translation function should generate the
> lookup_and_goto_ptr flow as the vsetvl/vsetvli translation function to
> make sure the vl_eq_vlmax TB flag is correct.
>
> Signed-off-by: Max Chou <max.chou@sifive.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
>  target/riscv/insn_trans/trans_rvv.c.inc | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_=
trans/trans_rvv.c.inc
> index 2b6077ac067..4cd030c7eb3 100644
> --- a/target/riscv/insn_trans/trans_rvv.c.inc
> +++ b/target/riscv/insn_trans/trans_rvv.c.inc
> @@ -1361,6 +1361,12 @@ static bool ldff_trans(uint32_t vd, uint32_t rs1, =
uint32_t data,
>      fn(dest, mask, base, tcg_env, desc);
>
>      finalize_rvv_inst(s);
> +
> +    /* vector unit-stride fault-only-first load may modify vl CSR */
> +    gen_update_pc(s, s->cur_insn_len);
> +    lookup_and_goto_ptr(s);
> +    s->base.is_jmp =3D DISAS_NORETURN;
> +
>      return true;
>  }
>
> --
> 2.43.0
>
>

