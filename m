Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67B39CD98E4
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 03:02:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbUuR-0003Hy-1w; Sun, 21 Jun 2026 23:01:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wbUuI-0003Fh-Kj
 for qemu-devel@nongnu.org; Sun, 21 Jun 2026 23:01:08 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wbUuF-0004aj-MJ
 for qemu-devel@nongnu.org; Sun, 21 Jun 2026 23:01:06 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-69775980397so2853282a12.2
 for <qemu-devel@nongnu.org>; Sun, 21 Jun 2026 20:01:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782097262; cv=none;
 d=google.com; s=arc-20240605;
 b=I5EVmdN73qbfH5kkj3q+sq/3ZzsqR2papIcXpGXWhH2UeK8QDpIJbp9T5NJrG13/WP
 o/pJCcjo2Tu5hxIgIa8Lw1t4lWJiJG4XQ48G/cLUB35Et+ijHkKSF8H2qWpSQxmR/4NE
 0K0hEM8T4KT1XUdAD0AvMqIcxKtJ5P22tVdkr4Y1XqoVY4nYP9G42umEebwn5Z7Q9wtz
 73I3kLjCwUi9+tHwtotIhpwCmCg/v0UlInL89HikiFHH6HVliJUFsYyaMU7+EpB2oXE5
 +j3KMcn5jV7y0MUXl/cHYTSuDK2u0fIZEZHMo/EVS6Yk1snOn6e99wL9WkPkr9Wcc9N9
 HZpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=SGmWPYONqKaS6ZkXGsQTPMxd/hMHmErX0JzpBe3KCkc=;
 fh=37FU9UkQqTXJQCBirpdkGit3Ki/mSuB0AUPxzpAQmrk=;
 b=A5CokGtVbU62rSkmrL2CFSpFfCAtgWpJpv8ruW/N+kR4P6+NCZu3uBzUNKi7F+Ft0J
 D0r2QXXOusFcYnUh6dM80J5GlxadtxYtWgTMtMnqZ+PkxU26RcHfgVyxx9W19bv2AXxC
 97oxA2CMiEfoxsXPZbhtAAS4SF2zbM3eb9JdHfX4L3SgPKwG8mjVCwNZO1JbdCqxe6gy
 hyrm5TdFaVCoCM85Om15g/EtFhTdSyJCLoonneZ+jrmmHDtFKNSZUvWLryMhoC0ANtXA
 /WzqYyZzd68EEVk+dvmeMpxIJcWhud9wy2zut62+9YiryIUxgqra0ygCM2ybCGc/uwcu
 9AOA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782097262; x=1782702062; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SGmWPYONqKaS6ZkXGsQTPMxd/hMHmErX0JzpBe3KCkc=;
 b=fbTG5t+WHmPOG6Kr1El5fSxPEx2u3DD+iFgJBIR5FPFKmDLGm8s3Ol1LzlSscKfy4g
 gl/IyJzpkZLhKO7YfRyV3D3hDeqz9H+8jD0pGr20SpGLs6ia9308JLFiRNSF+ZhgUZT8
 C8oJ0sXHv/EQIBpRfSJLeHK6I6Yevoo7+F913QTS1x4RdAwroyVxocv/FZELJ8qDkmd5
 vSqKh67fJiNDEJz0dWZednnRMNmzObAHmrOI0jBelkySYzSIsFdXUTa7C2A9fxOoQNQ9
 6lfNvgOnJ5x6Zm925VNvRJf6VydKiVIubuyMeAL3nYZg8oTxGVjJrzB8Zkd5nRQp+c1K
 aeJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782097262; x=1782702062;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SGmWPYONqKaS6ZkXGsQTPMxd/hMHmErX0JzpBe3KCkc=;
 b=WHQUeerLV0hoPcnslLn/s9K2LyIaZHsIU77bxfunTTottdUvKU+iyzmaJXQ3fkzwAZ
 lPD1PiEMh9RXlEAqvMBqu/Zef+RXYImo6HqyHoC9h5pfwKJLpgLtKN4Ao9kcPyBhq1Nb
 MWY7KpRhlFpArD+8307X9jeCoNOU1+C3VoCjnpmisXDzHWWnKTecSi8hwkeBk0UCttCk
 kl5ExEQNJCxDuIPa4Ijab7YZcmEeaMyCcxP1HgL9p25TQoSDi/ZjcvV5736+UrTu6DV6
 XwT9RGKxqoc6WQ0zyZxzdbi0Jupv1/8xGh52gBaV3hNKv4GWTlFrl2M65StAStTPW9F/
 o0bQ==
X-Gm-Message-State: AOJu0YwlOQ9R1VfOZrBneWpPVg1c+LSPO2AF/k2sXAvd5du3Du4Jxq0r
 ILjyeOXmygtJqpwWTVUxWad/oEP7xdT1O09INAizUjEgS8cquWpQEvSH2trmJ70zfOnzZj+SEUV
 WbXPGUCLqiI4waiq6tQZzkW+Q9PoaFAc=
X-Gm-Gg: AfdE7cnMJgBWhFHGJJXOqdPQs5rn0l1FXwsSeHBDnfPPZNBVSEuy2vlD3LA6wvh315J
 WDcKxQVxb7gaF3Qckq3bkZJPTnQG8KzFCXGIn16M6M0LVlDOBDj2hlAFNmmDdYeKT+FSqynKPia
 Fhl7q7x+mET8gX1t8cXjISPKqaUN7gETp2klr0kSdH8X4mXbcqGRREMfq4WaFQ/Q2b1GM497nWo
 Tyt0nK8CcgIRy4CTth5CRu/tIcWxvmwdE/ROQD9DuGr3p8gsNK63pYuwcku20ZUi95gfHWrHY1S
 9FtJS+Pl6nWjud6IyKFKs6Z0Jec=
X-Received: by 2002:a05:6402:280f:b0:697:a037:8dad with SMTP id
 4fb4d7f45d1cf-697a037903bmr1389615a12.28.1782097261789; Sun, 21 Jun 2026
 20:01:01 -0700 (PDT)
MIME-Version: 1.0
References: <tencent_CA380CBF4A98C990C07BC04A9E748C438309@qq.com>
In-Reply-To: <tencent_CA380CBF4A98C990C07BC04A9E748C438309@qq.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 22 Jun 2026 13:00:34 +1000
X-Gm-Features: AVVi8Cc75Q-8Ht24soZuaja0o9vwvsRPHeDfAhrLTah2lYGZvKTbrhMmkWWfjts
Message-ID: <CAKmqyKM+=1YOv7avz7uUSimS5PqXp3hO79Z_FS3ww_rhFASVAg@mail.gmail.com>
Subject: Re: [PATCH v3] target/riscv: raise access fault for Zicbom MMIO-like
 accesses
To: ZhengXiang Qin <qinzhengxiang@foxmail.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x52c.google.com
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

On Sun, Jun 21, 2026 at 10:48=E2=80=AFPM ZhengXiang Qin
<qinzhengxiang@foxmail.com> wrote:
>
> check_zicbom_access() currently treats any probe_access_flags() result
> other than TLB_INVALID_MASK as a successful access. However, a result
> with TLB_MMIO means that the target is MMIO-like and should not be
> treated as a normal cache block management target.
>
> Raise a store/AMO access fault for Zicbom accesses to MMIO-like regions
> so that cbo.clean, cbo.flush and cbo.inval do not silently succeed on
> non-cacheable/MMIO-like memory.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3501
> Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>
> Signed-off-by: ZhengXiang Qin <qinzhengxiang@foxmail.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
> Changes since v2:
> - Add else before the success path for readability.
> - Keep fault_addr as target_ulong since CPURISCVState::badaddr is target_=
ulong.
> - Add Philippe's Reviewed-by tag.
>
> Changes since v1:
> - Use a bit test for TLB_MMIO since probe_access_flags() returns a bitmas=
k.
> - Keep Reviewed-by tags from v1.
>
>  target/riscv/op_helper.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
> index 81873014cb..50fd1b73ea 100644
> --- a/target/riscv/op_helper.c
> +++ b/target/riscv/op_helper.c
> @@ -218,6 +218,7 @@ static void check_zicbom_access(CPURISCVState *env,
>      void *phost;
>      int ret;
>
> +    target_ulong fault_addr =3D address;
>      /* Mask off low-bits to align-down to the cache-block. */
>      address &=3D ~(cbomlen - 1);
>
> @@ -235,7 +236,10 @@ static void check_zicbom_access(CPURISCVState *env,
>       */
>      ret =3D probe_access_flags(env, address, cbomlen, MMU_DATA_LOAD,
>                               mmu_idx, true, &phost, ra);
> -    if (ret !=3D TLB_INVALID_MASK) {
> +    if (ret & TLB_MMIO) {
> +        env->badaddr =3D fault_addr;
> +        riscv_raise_exception(env, RISCV_EXCP_STORE_AMO_ACCESS_FAULT, ra=
);
> +    } else if (ret !=3D TLB_INVALID_MASK) {
>          /* Success: readable */
>          return;
>      }
> --
> 2.43.0
>
>

