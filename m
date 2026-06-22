Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EF8FCD98E4
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 03:58:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbVne-00081T-KG; Sun, 21 Jun 2026 23:58:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wbVna-00080m-On
 for qemu-devel@nongnu.org; Sun, 21 Jun 2026 23:58:14 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wbVnY-0006bm-K1
 for qemu-devel@nongnu.org; Sun, 21 Jun 2026 23:58:14 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-697ad7f14b5so903910a12.1
 for <qemu-devel@nongnu.org>; Sun, 21 Jun 2026 20:58:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782100691; cv=none;
 d=google.com; s=arc-20240605;
 b=e4mw8+0+VelPTALPtoQ8VMHkPL9vp9vARCrVEeOTuvZyBBCFlXRJHhvnY7H0eURTyz
 IgMX7MMFvPErJChc2IlsMjj5DiEpnZ2aPGD1haszxu5Dfj/SWuUhDqT+9lD+DbyYRmUI
 FaKbzyuZYgLvPIz3QFNebPB6iOvQswt3Q4iQ4NQ5er3KD2EMBBh11pvo8MXrH/tDXjff
 hAYZGyZeP7LmWFiQZlj6aZSwyP7urBCzg607LOMcGmKUQMctnHM9EWhekqjx0eFAwVPQ
 Qev7i/ISNA2YE9eWNOYEF4h1QhAwYKGOPDr2Q/PSXuAAzq+bOjtjW7Ff5uzqWJosRz7N
 TEYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=M6zxMMTMiP24TZJkothVaHHhuOdAx9Dihn0jFOScWng=;
 fh=KxuOr3nWkm6g2k1L0PKIWO/Y2QnL079d8A1i30z2gYo=;
 b=RGF1noyOJiumI2/yN+sX5o0Y0tu8t2zoBvVFV4BH94SFrRGUFbrX/8RcSNFVlYNF/N
 WR+8+JcBTCbcQg6fNblJpKCzBm2vsdzE8eXPLqicRJq5wvBw2oXHXvmKLsDYL0v63CYY
 EHTW5VfjqL9uh9D1LdI3lITs/QPWAIls2I5edIee1X1tofZbH6T4mQ1PsuREy4LTXhC4
 t7gtxLU0cdDzKVFt4pQuC6zpKclSDq72xrm8J09Xbk5d+CntfIR+aNOd2QA8dK+IU0uN
 7kmNz8ZKg8goeBngZgI0dGSANelvUh843Q/KlX3upJk2k24WYObqfEuZiYJ7Ij91mSlH
 Wshw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782100691; x=1782705491; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M6zxMMTMiP24TZJkothVaHHhuOdAx9Dihn0jFOScWng=;
 b=F6j+3v6PpFxfeFaUEKFsaqSVijD/eAh9igPMNaUm+geiCLMfyXBcKXsihK4xGP8wE2
 kzwxZ/8Rc6suZpEyMFvjt0KKUeUIO8siDHWyUeWzPGassmIu7K5i3ARMS1GdGXuXWyxK
 J6NIE3V5Zfgo7SvfTnitLQzgZ4w4KlOuJ4YgPzTJZGX/gFsJY2IpdpNiM4ed5O1d8lRK
 I8noSUPaK2V+ni153sdlMQmKgDy+RD4dCwYjpf1kz/6bKoDRu1cF29JMmJXZAW7q3gtu
 rNg1EuohaivOHR5kZzC+95Mre0QecSbFIfVLfaXFAu8L2sMZLiM0CgIutRiZ/yoSgcRV
 1wWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782100691; x=1782705491;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=M6zxMMTMiP24TZJkothVaHHhuOdAx9Dihn0jFOScWng=;
 b=QzAo5lnVowNc6zPMtd/HW78Tf0FUUxYWIXaSki09eP/6dwIijElz9WrLW7qsVFQYal
 ir4k7yMQmHwj3oufofKN0KsYTTnlGaXZrR2eEfdpyybOcJziD1W3lAHR1p5el5RyfFvh
 mJOyEuNpx0Vj2v+D3qn458kkgTpHrhp7KiznGJ1AkuBU7Bplo8ngmFaRIDfU7BwN3iIr
 JNhzR6T95TBgHhsREpt2idApyc4wYGlUwg+hO2Xd6yEmOQ9URb8oguJ/WmZwJdJqY8fh
 DCGmon668iU5WxjztvkOkW8MiTg7mbtrU0uh/QJ9+8Beuiafa8IN9MRhxpe9fAIsbJci
 nnPA==
X-Gm-Message-State: AOJu0YwsurucFtg+ModGcov56Kj6MrXZ/r9ebg4uVUmqFJ8DoFlBUT8z
 1G89xMfwEiy37UQDRsmquGDnzd+VVi3tsZ+eY0fPQAWgCh4nF6poH4UnRfmqcmBFCvKtRhMOXWm
 Nw7HXXCsBH1N8xXKVdFzM/qvPhNyXX2M=
X-Gm-Gg: AfdE7ckMPQcyFxQuwhUjzQ3CCercRD0hSjZ/WuyklFyikzI+9xDlL5Gw5SbJA1Pxk+u
 TbaMypT+VuZsIxiIxyhq7hPKI/Uh2EGKU5RQyFmoLEBWkZvmqzVqkmHwRJFyavgecN/ZOI15gP7
 0LKArTEYsnW/souPy+0rxS0gSDaoqeYiruowrLjh9qlDmZCHUhsfWYgDmMUQlo1LSZFenDqp/yy
 HeL1VwktI2mo1TinaGJ5OdcbR20dTm3VsjFm5xG3OnQjSBu0RI9Rs05yj/hSspjBWUR8EKGNQas
 Piz8VePkZSAx9OayY4N1chkesM4=
X-Received: by 2002:a05:6402:158e:b0:696:76d2:eee5 with SMTP id
 4fb4d7f45d1cf-69775e95a2fmr3242871a12.15.1782100690680; Sun, 21 Jun 2026
 20:58:10 -0700 (PDT)
MIME-Version: 1.0
References: <20260615131925.3019370-1-qingwei.hu@bytedance.com>
 <20260615131925.3019370-3-qingwei.hu@bytedance.com>
In-Reply-To: <20260615131925.3019370-3-qingwei.hu@bytedance.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 22 Jun 2026 13:57:44 +1000
X-Gm-Features: AVVi8CexJLtdyMsdyw25GQkF_lf8IsaMCYbwmy3yStv75bEHKFOL-oWJNd96YEs
Message-ID: <CAKmqyKOiRR5XT_DE4Tx2XGhZLZZMEqWfnEoEc8HRYtNzp+3O5Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] hw/intc: riscv_imsic: Skip reset for KVM irqchip
To: Qingwei Hu <qingwei.hu@bytedance.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, palmer@dabbelt.com, 
 alistair.francis@wdc.com, liwei1518@gmail.com, 
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com, 
 chao.liu.zevorn@gmail.com, jim.shu@sifive.com, nutty.liu@hotmail.com
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, Jun 15, 2026 at 11:20=E2=80=AFPM Qingwei Hu <qingwei.hu@bytedance.c=
om> wrote:
>
> The emulated IMSIC state arrays are only allocated when QEMU handles
> the interrupt controller state itself. With KVM AIA/APLIC-IMSIC, the
> interrupt controller state is owned by the KVM in-kernel irqchip, so
> these emulated state arrays are not allocated.
>
> The IMSIC reset handler still clears those arrays unconditionally. This
> makes qemu_system_reset(), which runs during machine creation,
> dereference NULL pointers with -machine virt,aia=3Daplic-imsic and KVM.
>
> Skip the emulated IMSIC reset path when the interrupt controller is
> handled by KVM. The emulated path is unchanged for TCG and for
> configurations that use QEMU emulation.
>
> Fixes: 766391483b ("hw/intc: riscv_imsic: Add reset API to IMSIC")
> Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
> Signed-off-by: Qingwei Hu <qingwei.hu@bytedance.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/intc/riscv_imsic.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/hw/intc/riscv_imsic.c b/hw/intc/riscv_imsic.c
> index ac59496c22..f1f23c3a3e 100644
> --- a/hw/intc/riscv_imsic.c
> +++ b/hw/intc/riscv_imsic.c
> @@ -347,6 +347,10 @@ static void riscv_imsic_reset_enter(Object *obj, Res=
etType type)
>      RISCVIMSICState *imsic =3D RISCV_IMSIC(obj);
>      int i;
>
> +    if (kvm_irqchip_in_kernel()) {
> +        return;
> +    }
> +
>      memset(imsic->eidelivery, 0, sizeof(uint32_t) * imsic->num_pages);
>      memset(imsic->eithreshold, 0, sizeof(uint32_t) * imsic->num_pages);
>
> --
> 2.47.3
>
>

