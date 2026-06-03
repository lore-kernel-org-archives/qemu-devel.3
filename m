Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8751CCD6E5D
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 00:59:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUZx8-0004jX-Uv; Tue, 02 Jun 2026 20:59:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wUZx2-0004io-0N
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 20:59:21 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wUZx0-0007at-9t
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 20:59:19 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-bef47b1ac01so237170766b.2
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2026 17:59:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780448357; cv=none;
 d=google.com; s=arc-20240605;
 b=U1bdS3Ol3YyF3YXKdb7xtfKvQM/mGRUTEnDZVLGfyWeFryj46DdRcREa3aurViLTu7
 vYViUaNb2sa4Y9m0Zh4R4IP+ofAkcGP86EyAD2OYdFqzDSE3V9x1KXJmNGIsWj75thDh
 W4lsH1LrARryKf3ATVE7P2dNPyPNC4oWT7E/5ylNSBYzfRtbGU7D46Z5wj/sSn+Vj9DA
 OtPSt4Q0Fsus3k+SGZpw1erUVKmZIYH052g+A5wns7DZCbB4KyFBjQE21DowWYbP+Cxc
 zZSYfvYc4to4WlRelFVLe7jCi9b1tdt4a4iqM9DXgkgZDiES9DRxRjp9XdNchczhOniJ
 S6mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=LUe+j5C8frOjbnZ0XLm3wUu16M4PlKL1OBlgCGFrUhk=;
 fh=VHujqg+9hTfq6vg2mTI39Ti1R8WOgkqd9mnsMag08lc=;
 b=U0GhhO0tECkYZi5KIYC6K9H8dLIJZoJwzcWS2YxUMy8YlNQb15XreiHX3kIoZ+hAFl
 KrPx+PLaZp7yiW43+Ap1YFTWyEpNvJDU8U6y8lmUwwy2Xd8a5xH3eyYd/jhBhEDx+pEf
 hwnee06m/Vyb772vVRimDvniS61gx97OcnOAygGljrYSocN1Nc7ImrinyIT/CFayjQLN
 Z5MGlcish0efNzfjDS74UQMqLnDhnAAhfwFGI5Amkq+6DKP3ljDEBGc7kURrHExJlkNQ
 jInw6ekL9r/0IKSgaHEUAl3nF8Sqlq+l31dK0KWencQSID+kNlFiSz1yZGeLZ5ZARznO
 /Mrg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780448357; x=1781053157; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LUe+j5C8frOjbnZ0XLm3wUu16M4PlKL1OBlgCGFrUhk=;
 b=JjoaMIawZse/j92c3X2Cy9mBPSiZErzsVaIfg/kJPuddKJNq5rWBrdkmDhr3mxaADQ
 d6LRdEA+oY9uSigfHUgGwyL9uXREehQ8AZDuJ+uMcEdeSbn4Vu9qJyBMPQcXZbi6GL8M
 IScSMy7bLcxtOsaQuauZlMvAhLskv4/+HxImp3prGn0pYtn9mhg/s0+k4V9i03+pFZeX
 8VEHzMme2Y8yqLqOkVH5Cy1eZCJ0fqOpgJQvVCtddyz6TnFMZ83TP2C0HqRqNoRyUwZp
 pYRp81Mlhcpqi8HfQRBZxXqroxSLU1pyXTvQuTgSH2FyXiBqeO9NqaevAdEB/t4iOymn
 fM/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780448357; x=1781053157;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LUe+j5C8frOjbnZ0XLm3wUu16M4PlKL1OBlgCGFrUhk=;
 b=ovFgC/MrAD9RSMZ4gfYNfEmhC9fApZLgIOqjobxSrmIRkvzajy0wK78Eq9e3CkCsee
 IvCb1zS4BCB7+tEBenXzwb+04HFJQcWjQqiQ8s464xx6MND7kjxdA2GAMF8Ivnv2Px3G
 0l9y4vjqJnjJA+0oOsBoMdfizJ6lHCqgtbKnWSJTxDnNUf9ziJPp1anlrIkB3sTPrC+h
 qcQ7GN1wfWHh7TAB3H+I/PqTPDUzhjYB8loEW+9gwEHkKImmfjZ0yKPopyQhD6TVzhil
 dHXVWM+GY4I6yzFbedP/9xkZ/Z4tSJMx+AvwB27e+eiC64ySbT6Gjao3A2rqdNrN2PWz
 8ZDA==
X-Gm-Message-State: AOJu0Ywd8+AHCZJrRoqFFnPVLeeh3y30E1tRG0GEgRdDK9qcyPCzkCKJ
 mLF/hRxplVDUcWwpWGu2YV7yKJQLNWf70HIYw5IUkrkqsZYhzLf1xegyTi6A9qVQysYtbBOzkvc
 MIj+/ibcLPPzFdkN/cRzlb28eNdD24ns=
X-Gm-Gg: Acq92OHl1zUBhyd6l4oHs3yVexQ62E2v02rili6J0yTjrBJTwyhq+Pct9C70g8KhwGZ
 Zd1vA1LN/A7iLFRa90u4zQayw45YIUK/SmPYsPaIjdh7x2WTs081vbwJHb8iYKeau6bx8Nx5NOw
 VTYiyoh7fxY7SvxIVbWDsY5yl/yDr9I/aia6BKHrnJ6k7IS1I/RwOFRPNZ+r8mCNf4j3uZZ2dBe
 s0TXf0IDbB3J+SZvrCqi9hFM2qnDo9FmBLMgOKVNfoUsFzIp+Y9yzT96CgybKM113CQjUCRUEwA
 gPZZGHLC7k+UODRhDnzbo9/xvvFt7R9lpst1GMmp9sxSReJk
X-Received: by 2002:a17:907:6d1c:b0:bf0:1c43:bd2f with SMTP id
 a640c23a62f3a-bf0ac4044dfmr36966966b.2.1780448356579; Tue, 02 Jun 2026
 17:59:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260530102100.78150-1-314abh@gmail.com>
In-Reply-To: <20260530102100.78150-1-314abh@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 3 Jun 2026 10:58:50 +1000
X-Gm-Features: AVHnY4JFQsf-TaydXflYKL_pggqak1LzD_YtYvskbUK7FPXlVNZ61zF-0dWk888
Message-ID: <CAKmqyKM3BpEyGMLG4sA79L28zkKb5nO0ug1r_4j=gU4LxVFdvg@mail.gmail.com>
Subject: Re: [PATCH v2] target/riscv: mask vxrm csrw write to the low 2 bits
To: Abhigyan Kumar <314abh@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu.zevorn@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x62d.google.com
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

On Sat, May 30, 2026 at 8:22=E2=80=AFPM Abhigyan Kumar <314abh@gmail.com> w=
rote:
>
> Citing the RISC-V specification:
>
>     "The vector fixed-point rounding-mode register holds a two-bit
>     read-write rounding-mode field in the least-significant bits
>     (vxrm[1:0]). The upper bits, vxrm[XLEN-1:2], should be written as
>     zeros."
>
> QEMU wrote full value into env->vxrm causing read of upper bits too.
> Used existing macros for bit-masking. Previous had a hard-coded value.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3470
> Signed-off-by: Abhigyan Kumar <314abh@gmail.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
>  target/riscv/csr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index 5514e0f45..7b98d66db 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -977,7 +977,7 @@ static RISCVException write_vxrm(CPURISCVState *env, =
int csrno,
>  #if !defined(CONFIG_USER_ONLY)
>      env->mstatus |=3D MSTATUS_VS;
>  #endif
> -    env->vxrm =3D val;
> +    env->vxrm =3D val & (VCSR_VXRM >> VCSR_VXRM_SHIFT);
>      return RISCV_EXCP_NONE;
>  }
>
> --
> 2.54.0
>
>

