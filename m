Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BAA0CD5BD1
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 03:09:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTt1i-0007On-KR; Sun, 31 May 2026 23:09:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wTt1h-0007OA-Nn
 for qemu-devel@nongnu.org; Sun, 31 May 2026 23:09:17 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wTt1g-0004Yp-8L
 for qemu-devel@nongnu.org; Sun, 31 May 2026 23:09:17 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-687ed9aabb3so5117243a12.1
 for <qemu-devel@nongnu.org>; Sun, 31 May 2026 20:09:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780283354; cv=none;
 d=google.com; s=arc-20240605;
 b=C8TrVw4d3su1EYjhTjPLhYyxdLGqwyo1D4ivNzLEF67b/0haZFsTLxK0IS9XQOpfau
 mXHux6GGifn8Aah7HRvmmKXukXjuLZFKaN+urhczET0PqAemd353oZS5FXT4hsyxj67N
 7tf0KCL7ssBZdDHZalJlEyOixSZ5LnpKO1dDsBfAXNnQ/PVBioJtTYxGiYeJCwWowfZg
 RxnLkA/xdWMLsMPtygAA9O5HT+fG9KcPF6dXq0ap4NeVB16badQbcKgnurmvw0rc+UJ7
 WYJcheo+eqfhIxlLNchfuTPEZx05u7TlCr76o8Zf1UHCr06Ut4x6+Ug2nxPJSXD/hBKS
 isyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=n4sbSR2xC6UUdTGOGPF+IffDjA0MczriSf99ZJRi3X0=;
 fh=+dPXGxW3pQNYFrTSil53fSXYfdhGIs7bI6Dyql1Mx+Q=;
 b=AwxJji1WP7cYrKY1BeBUNDSXDFeN61UpD+U4/ogTGGv1Dw6EMgILomNqtYPLObNr94
 JxR7U0Ktb40T03MrkFgrCjE04b8It+ypLV+sVrwWunBqcxmvJ0W5dlyPM0gaGA7/0/Sw
 6/BWiF7bJEoiOZ899mDV6EvYqBROGj6YafIvdGFpZSNJWLuyJvJP2akr8ok5lf47Rtx6
 m8WyxSjt/krsnWzJ832dZao7SNcUKSYCJwjudBUZ08tJJRXLyGPWAWk3c7qh6NVvzZrV
 MqnOFVHrXwljsfGLKj0KtQ9O6LlSwF0OnjccQ8IHiCkWdlVcIjTujrq/dpAdr4LBdhM7
 HkaQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780283354; x=1780888154; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n4sbSR2xC6UUdTGOGPF+IffDjA0MczriSf99ZJRi3X0=;
 b=q84Pbz+Ojf0foHqrAvenV4i6FH3t5fXxZ/nETTc8Nvb18mm9Qm3msC3WUYtEDYBb3X
 KKubcOgVJ2vB939xX1p7BR/4T1QiaDsmzxG1vVVe9+CJl0/01D+CZUjBimlQkal8vpUi
 hCXhdAJ1+9gxqFS2LRxiwkH5kLnw3r1hj39t2q2obzV9pHJAG6yLJ6zqdvdCBPyLqP2H
 VMOsnNoUVV2zpTnMlPzw5WW3fezciGqYd+VMAFVE1iUBK4XmicCYZW6adfu5/T/yMad9
 XoYBMrNG6e2zed2S/lLljIjLggwPOJ2zKW8G2xqtWib1faqT3cnPC/SBN7jXqtglZEsB
 Ihtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780283354; x=1780888154;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=n4sbSR2xC6UUdTGOGPF+IffDjA0MczriSf99ZJRi3X0=;
 b=NXQZ6YacYX3hHqZMjnAvsoWuEBmwgCMYv5KxJQe7GsknpL+X18waM0yxtN9ahRdnSt
 lq33zIygYSdTCo7VGDs5nk+NiPmp3JJDz617NRnfSPOhCEsAq7bnUKbJXjqFFHXBlqSj
 FqFbUMvOb+eCd1sII0GZXY2lkbWx9p8yghf1gBuRyzKcUNyMeRfJXhA+7L//HXigGAZn
 0AF+tpmxhrjY+QuQj43HnGqMXoOFjmV79aY9zXK7NxIiCS8ETNb+UzvdE/lX3s23aSKD
 7Nyyg1czlqo2LzdtNwlUrcdEa8Z3NNaYKa0fZcK1bwMhabx00v2+Q56gueC/22H8jP56
 tHng==
X-Gm-Message-State: AOJu0YzOAer/hZaatvOk7fEzAyoYID8zMmIpmxhMAgmuCImhHneKAgJA
 Mh43Hv/JOllMdxQkJ6oUfiLoLwek27PEVzMvZoKP9iCnoxDp7J4SQPboikKE0JMb5ZjOhBlSzPW
 JNHxWuIw9YlZTPjW1AlugxbIn4MQlrtE=
X-Gm-Gg: Acq92OG+pI9xOrEUYDDuojNCb++vixrK02Bj9kE3dbnbsW5Uyy3I4rXmHlT3rOrFuLZ
 /PMJ1SecQNCLDS1dAySpcjBR0wmXxA07WIqe/xUma0ogXPQsJ6a909B8T4E1rLOiBiQOhGtn6BT
 hoWoN8YjFe4OddePLytO6Y7FzfGCGVBfZtAbECQTpqjFqpc/KTY3IGZYE6nmLbLnRBt26WXrhsz
 W6QRAzHw5TqvUQHUR2d0mbW95zIHuhGA/hU8eNWr9vaqtx3z5DO4gy/troXVQVzLTvFpF+vunwY
 7rRIAFSthfiwowTr7cP7qeyoxhi3TorOjwxZI8rvHrz5hJLt
X-Received: by 2002:a17:907:1dc7:b0:bec:929b:cee6 with SMTP id
 a640c23a62f3a-bec929bd40bmr141662666b.20.1780283353776; Sun, 31 May 2026
 20:09:13 -0700 (PDT)
MIME-Version: 1.0
References: <20260527200355.2068879-1-daniel.barboza@oss.qualcomm.com>
 <20260527200355.2068879-2-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20260527200355.2068879-2-daniel.barboza@oss.qualcomm.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 1 Jun 2026 13:08:46 +1000
X-Gm-Features: AVHnY4LGYH77SdW-Q81ino76eRCbfO5-aUZoEUlHxUGh2FWBaMDE6gnhCm2yQ68
Message-ID: <CAKmqyKPAVkCfjcN6kyLTu_EVkU35k3T85qM99MGaw7qVHoqzHw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] disas/riscv.c: fix inst_length()
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com
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

On Thu, May 28, 2026 at 6:05=E2=80=AFAM Daniel Henrique Barboza
<daniel.barboza@oss.qualcomm.com> wrote:
>
> inst_length() can return 0 if 'inst' happens to not match any known
> encoding (like [1]).  Returning 0 is not desirable, even for unknown
> encodings, given that it will cause a loop in target_disas() later on.
>
> The most recent version of the RISC-V unpriv spec ditched the
> sophisticated instruction-length encoding.  We're now supporting only
> 16-bit and 32-bit length instructions, where:
>
> "All the 32-bit instructions in the base ISA have their lowest two bits
> set to 11.  The optional compressed 16-bit instruction-set extensions
> have their lowest two bits equal to 00, 01, or 10."
>
> So the code is now simpler, never returning 0, and in fact it's the same
> thing we're already doing in insn_len() from target/riscv/internals.h.
> Due to include shenarigans we can't use that function in disas/riscv.c,
> but I believe we can cut ourselves some slack this time and not lose
> sleep over a 1 line of duplicated logic.  We're documenting it though!
>
> [1] https://gitlab.com/qemu-project/qemu/-/work_items/3479
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3479
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  disas/riscv.c | 20 ++------------------
>  1 file changed, 2 insertions(+), 18 deletions(-)
>
> diff --git a/disas/riscv.c b/disas/riscv.c
> index d416a4d6b3..fbdb24fcea 100644
> --- a/disas/riscv.c
> +++ b/disas/riscv.c
> @@ -5057,26 +5057,10 @@ static bool check_constraints(rv_decode *dec, con=
st rvc_constraint *c)
>      return true;
>  }
>
> -/* instruction length */
> -
> +/* Same as insn_len() from target/riscv/internals.h */
>  static size_t inst_length(rv_inst inst)
>  {
> -    /* NOTE: supports maximum instruction size of 64-bits */
> -
> -    /*
> -     * instruction length coding
> -     *
> -     *      aa - 16 bit aa !=3D 11
> -     *   bbb11 - 32 bit bbb !=3D 111
> -     *  011111 - 48 bit
> -     * 0111111 - 64 bit
> -     */
> -
> -    return (inst &      0b11) !=3D 0b11      ? 2
> -         : (inst &   0b11100) !=3D 0b11100   ? 4
> -         : (inst &  0b111111) =3D=3D 0b011111  ? 6
> -         : (inst & 0b1111111) =3D=3D 0b0111111 ? 8
> -         : 0;
> +    return (inst & 3) =3D=3D 3 ? 4 : 2;
>  }
>
>  /* format instruction */
> --
> 2.43.0
>
>

