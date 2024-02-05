Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9389C4828D
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Feb 2024 04:34:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWqgG-0006fU-RH; Sun, 04 Feb 2024 23:34:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rWqgG-0006es-2c
 for qemu-devel@nongnu.org; Sun, 04 Feb 2024 23:34:04 -0500
Received: from mail-ua1-x92a.google.com ([2607:f8b0:4864:20::92a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rWqgE-0005gm-EG
 for qemu-devel@nongnu.org; Sun, 04 Feb 2024 23:34:03 -0500
Received: by mail-ua1-x92a.google.com with SMTP id
 a1e0cc1a2514c-7d2a67daa25so1870632241.0
 for <qemu-devel@nongnu.org>; Sun, 04 Feb 2024 20:34:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707107641; x=1707712441; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GLP/d0NA6vhDuj2n0pzWi+JABTXiI9Lz/skTS1/RxGA=;
 b=TmLbGMpz9w4K57yWjFsJA6FNwwP79ERA6o6e2UuAQqeea/iJwcaFiKDF35Y9YE/Y4c
 S8EenZnWpTiJlHl0ke0M+aSdrtqoUq4oHWkYQtrYZbWveRBz9dWDcZKkw4XyIuq9am1t
 lbL0uAlR4VP+sWcR6bWlz1wo19ab9Oo4FhkB15Zp5tBeXMykJlY2qhBDdpGhiaPjBXLH
 gsDX9D2Nv0EBSMjwsaxKiz5IKOkzk+TTPKlenSDy/51tx7bCoJ40a7mVL/ucvnF4tP69
 aSd83UxB2CjiS+XJeMkZjDJV19LaGnLJGR/2p3YB4wUi0W20FL9mNzrTh6FGfWstO8mS
 2+oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707107641; x=1707712441;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GLP/d0NA6vhDuj2n0pzWi+JABTXiI9Lz/skTS1/RxGA=;
 b=vwYfoBNeM5xuFBtoDdHJgNRoc1SQeG0UxXDzgYF0jw2yCcVrkT7Db6R+q0bP0ABmCC
 fT/pmmjH0UWuma1FW5wrXVIHblokUI6YAgFS+lpgJJfmaRGg/rbAoODDqfzKTqLyCr6t
 tYgwdcQzKaeyboVHEAhdjxvhEOQu713mw+OLEHh7yUYof4cDd+ERkGWZFSUNV9saA3+L
 Y063oIgZ3yPQ5N5235enWpzR0C/Nh0+iumRJwoRNq6REA1AeSTJDg2vJGyiaOq7WlQIo
 VDAB44IF2ezOEjApXlAv8Eb/7O+u/w/gpOFdSA6jvgG2kUJ5LmxoX++NY+frkDIeFCtV
 DnEQ==
X-Gm-Message-State: AOJu0Yx0yN1Mlk+Rk6ewG9IyuphpXwSW3A2Pem4DVJoWj5AAsmDorl/t
 TqTqdcVd8CYVsergCQHg3C+c/K9Dd09rgVHhPf4UfDFfeqrFU/aaoCmJH4qQ0jIU/57LOd4+ys5
 ixfyis3vXefyVz26TwTHaqGDud1E=
X-Google-Smtp-Source: AGHT+IFeHFxn04GzPV9orbxxpLfVD/Ox3y1sTZaaH3GBx/zqo515KuD4nQhMyii1B4BirulEf4Kj2d46KnVvhIY95Ss=
X-Received: by 2002:a05:6102:4186:b0:46d:295d:1c5a with SMTP id
 cd6-20020a056102418600b0046d295d1c5amr1704471vsb.30.1707107641301; Sun, 04
 Feb 2024 20:34:01 -0800 (PST)
MIME-Version: 1.0
References: <20240112220348.49021-1-richard.henderson@linaro.org>
In-Reply-To: <20240112220348.49021-1-richard.henderson@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 5 Feb 2024 14:33:35 +1000
Message-ID: <CAKmqyKOHJ9mXQDFDs=CC8v0UzP48FGTdLL=o4Kp8ySmMmhSEgw@mail.gmail.com>
Subject: Re: [PATCH] linux-user/riscv: Fix sizeof_reg typo in vdso unwind info
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Vineet Gupta <vineetg@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92a;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92a.google.com
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

On Sat, Jan 13, 2024 at 8:04=E2=80=AFAM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Reported-by: Vineet Gupta <vineetg@rivosinc.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Is there a branch with this so I can pull in the binary changes?

Alistair

> ---
>  linux-user/riscv/vdso-32.so | Bin 2900 -> 2900 bytes
>  linux-user/riscv/vdso-64.so | Bin 3856 -> 3856 bytes
>  linux-user/riscv/vdso.S     |   2 +-
>  3 files changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/linux-user/riscv/vdso-32.so b/linux-user/riscv/vdso-32.so
> index 1ad1e5cbbbb8b1fe36b0fe4bcb6c06fab8219ecd..5829c1dc90f1c1aafde69f5b9=
f5bc9afb85251f7 100755
> GIT binary patch
> delta 112
> zcmV-$0FVFF7StB71OXHyD|k<wiZ(XN!ME<$oE!73r-+KP7y<qQJ!67mgJFbVg<pnV
> zhh2zViCc<Vi&>0VjaQCVk5!OVkyDaVlTnmVl~0yVmra;VnM;~Vn@OBVokyNVpGC7%
> S1ndF^OjB%HZ#A<;2M+}Mt1p-U
>
> delta 112
> zcmV-$0FVFF7StB71OXI7ek-E|Z8Fh9(G%V1AYqwmRqNri7y<qQJz|1jgI<JOg<6JK
> zhgOJGiBgJCi%yJ8jY^J4k4BJ0kwTI{lRlI@l{%I<mo}I*nKGI%n=3DYIzohqIvpC+?Y
> S1ndF^P;+@qVQaHR2M+{CwJgd2
>
> diff --git a/linux-user/riscv/vdso-64.so b/linux-user/riscv/vdso-64.so
> index 83992bebe6d0182f24edfffc531015fd2f4e1cfb..de18e35537a493ba35307e93a=
2d33faaf489c0b3 100755
> GIT binary patch
> delta 118
> zcmV-+0Ez#Q9*`cepaB$miap5s7G5`$2#eqLH6<vG8d2V}v;pe_KY{^*fB}PkgnWg1
> zhIof|h;)f^ig1f=3DjBJf+j%bf&kYtf!l3<fwlw6fsmROfom{gfknoyfgoJ^fco=3DBfY
> YlidYEvmgdT0|snTdTn?%vuO#Z1^ZDlW&i*H
>
> delta 117
> zcmV-*0E+*R9*`cepaB$}OC4Olbn*vwtO;!U^UJ?5jVB4Sv;pe_K7av&e1mv|bcJw+
> zY=3D>xwWQkykT#HzYRE<!MOpi#AM3F#}Jd-$-G?g%xESD&lB$*(Z9Ge)N6rB*B44(*-
> X-UULl9|lAN23SxxMKVLPX$hwVbapOM
>
> diff --git a/linux-user/riscv/vdso.S b/linux-user/riscv/vdso.S
> index a86d8fc488..4b4e34aeea 100644
> --- a/linux-user/riscv/vdso.S
> +++ b/linux-user/riscv/vdso.S
> @@ -101,7 +101,7 @@ endf __vdso_flush_icache
>         .cfi_startproc simple
>         .cfi_signal_frame
>
> -#define sizeof_reg     (__riscv_xlen / 4)
> +#define sizeof_reg     (__riscv_xlen / 8)
>  #define sizeof_freg    8
>  #define B_GR   (offsetof_uc_mcontext - sizeof_rt_sigframe)
>  #define B_FR   (offsetof_uc_mcontext - sizeof_rt_sigframe + offsetof_fre=
g0)
> --
> 2.34.1
>
>

