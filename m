Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B95E9CD5BC9
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 02:29:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRhXp-0007eL-7Y; Mon, 25 May 2026 22:29:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wRhXl-0007dl-Pg
 for qemu-devel@nongnu.org; Mon, 25 May 2026 22:29:21 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wRhXk-0001x3-AU
 for qemu-devel@nongnu.org; Mon, 25 May 2026 22:29:21 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-bce57c132b2so1874503766b.0
 for <qemu-devel@nongnu.org>; Mon, 25 May 2026 19:29:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779762558; cv=none;
 d=google.com; s=arc-20240605;
 b=eZHaCIfYk21ZrE6mpfo2HpcOtEaUKqaB1gkklJbuZHIcSLwFiEvjO11w4RYlOnKtuL
 rVw157++qDC+bgNIwFW/qOSgH42sHESFDyuBs1mDfoPPDB5qKR0fxxFaWA8utAdqOJYX
 Tc0P6EHwqSQmhulcMRbqdRL3hh7j1TpRd4M/903HwbwNSUJfuSVHlJ/cq293djmjGhGy
 7jDQ1eldukclkqsHtixAhUgxwVsDhdzRhWkGi19IhT8IP3A2vZDc3mGt9V74LvjXc7ZL
 vzo5zem11DfUGu8Vgtp7ug3s/qpiDbWfz5fGs5/erjTrOIXBo1JPF+QcLOneTCF2oQFB
 F++w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=8DZUitsK0FCfZxW2R4rZzJBL/uFXY+1PL2l6E6uWuM0=;
 fh=+dPXGxW3pQNYFrTSil53fSXYfdhGIs7bI6Dyql1Mx+Q=;
 b=gmOKPt4MN134vF5AdF+oA2zQbrkpJIQJYpZQVtYiqcM4z07j6rg8tpOSKtVkUengkl
 VHmynueYxVwGGZYiLZ6WM/FGfP082Q3EgJAJj4knrIlcZllgKPZwrL/YBLzPc5OiArZ4
 9AKmPcaJdoLR9X4r+0TLa1MIsZCeW7e9oG0b3mvwMCqwMtxew1kSqx5umAISUAF8G7gV
 bFyWzUKfIhPly2kYm3Sf9bn4nKD6L5HonXDs3d6twvWxk6PyVQjXv3vffwMFbp2CQFxm
 lSEQQygWvG0MwB3mU4aeQBD4wt/2aIAS8JDQBfxIpPPUpGQx9/UAhdODqKFri/Q2BFcT
 uzQA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779762558; x=1780367358; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8DZUitsK0FCfZxW2R4rZzJBL/uFXY+1PL2l6E6uWuM0=;
 b=Qys48X7Q7ZFU+23vTaAdOA40+JHw8JasO8rET+gYK1KpToGhio+Q1ZSQBkNyL7unE4
 d9vDJMdYz9U1nI2IFWKQPJ/WYm24I8H+fpVPLx04Lj5Z+zu17PWF/9I0NV35cpCLbdA7
 YuXuN+nPtUibEVZRPZaHB2dzLzaDZp2r4qqqDPXD9KbS4GjoV+IQ/277VfMCD85xYSrY
 G35fqQZW6Etfzm1aunDkzjt6Am4Lfysje0tPy/MWU7V1WYF6rsGuRGMtW6KBok2M91ob
 /ghAvOJEHTsfcm+AsbQ6MktKp51Bfk1haLzTcmo89c2hMMXs2guYYUnoNoH8o2gC+WLJ
 5R1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779762558; x=1780367358;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8DZUitsK0FCfZxW2R4rZzJBL/uFXY+1PL2l6E6uWuM0=;
 b=mueuFDTG9fYkH88SP/TdtfIJBz/9DiAtR2CKnXRJEARwvz7vEyJGNJhvtNqB7MVFUt
 5YJh07uBOKthK668zuyliSJelsLOEbLVMgBMRiltQbd07ccOTF6XoQm6OeOAhog1Zdg3
 KsGu2DIXPZ0vArUlKTt7TpozUp/6rhjL5V9d5eIw+bvgdsYSZxJ7FUUU2YL3Z8GsvFyd
 cHPxh+3vwCxIkTRyGhaCwRn++rYDt1BKkTR1EJhU6/d8n8WAtlb8jIrU06ZOPkK7zGHm
 DBC0JTyYehusVGzDiR3LfY6NsJzg8UzLTjpzoQ1+FaFwjHYB1pOB3cnB6qbIcOQKF1yI
 Wjqg==
X-Gm-Message-State: AOJu0YzDe+VFnROj8sNZ27Pgk/SGVbC8vSzDbKUif8Q8my6v88Z02zVo
 r/6TAxdHDrFbgZTlW3uj1rqgswLBoM7K5s0mEbhNQgWJtFsBDx4AoBNOXI/RMJNxGNLvqled7qP
 eCTZ5TXeYZz+lWLYEPcwMEjKdfQ8Z40U=
X-Gm-Gg: Acq92OG7QIhWbjrH4agZG0TUP68IYAkdY6q49XCTVSCnW2cwSLb6g07aCmjvLDKn6pN
 ddroU+nG/ZfwdpYbhrmSijhwNUqK+Iy1BHU8NnJnmKD8MLrzE1lOFpiUOJ4Zz8spNHog2O5v6rA
 2SpoUCxq2sz+OVcezhpz/3yhYTHyGsPo9Fe3Red5W9fSe/Ru0pIL2fuGE9DXPVDtF5Lo15gJfq1
 BrIwDy83T0lFLo1xRheQEu2Q6JUkeHhCVRK/9kkKHDXAE2VUEDYvVFvctRR1IGfkGRj2xfoqJNx
 hOz23fxJWglphCgPelNvTps4FMe457s3Epwq9MDFpIuR4kzj
X-Received: by 2002:a17:906:cc0d:b0:bd8:f907:ecc9 with SMTP id
 a640c23a62f3a-bdd4a0997b1mr635443366b.12.1779762558577; Mon, 25 May 2026
 19:29:18 -0700 (PDT)
MIME-Version: 1.0
References: <20260514194537.2416243-1-daniel.barboza@oss.qualcomm.com>
 <20260514194537.2416243-2-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20260514194537.2416243-2-daniel.barboza@oss.qualcomm.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 26 May 2026 12:28:51 +1000
X-Gm-Features: AVHnY4LyB_T0I9rG-eJMBoza1fGy0UinzsVp4vow87OFr0qFGLfCDxwfGqUhSQw
Message-ID: <CAKmqyKNUwBLaS-h76-Tor1i6ds=hL1Si2BnAk5sh5KGWd8t9pw@mail.gmail.com>
Subject: Re: [PATCH 1/2] target/riscv/csr.c: do not allow mstatus MPV/GVA
 writes
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x635.google.com
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

On Fri, May 15, 2026 at 5:47=E2=80=AFAM Daniel Henrique Barboza
<daniel.barboza@oss.qualcomm.com> wrote:
>
> The priv spec states the following about mstatus.MPV:
>
> "The MPV bit (Machine Previous Virtualization Mode) is written by the
> implementation whenever a trap is taken into M-mode."
>
> And, about mstatus.GVA:
>
> "Field GVA (Guest Virtual Address) is written by the implementation
> whenever a trap is taken into M-mode."
>
> Both are written during riscv_cpu_do_interrupt().  They're not supposed
> to be written by userspace.  As far as write_mstatus goes these fields
> are read only.  The same applies for mstatush.MPV/mstatush.GVA.
>
> Fixes: 03dd405dd5 ("target/riscv: Support MSTATUS.MPV/GVA only when RVH i=
s enabled")
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/csr.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index e1cd4a299c..74f5f868f0 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -2040,9 +2040,6 @@ static RISCVException write_mstatus(CPURISCVState *=
env, int csrno,
>      }
>
>      if (xl !=3D MXL_RV32 || env->debugger) {
> -        if (riscv_has_ext(env, RVH)) {
> -            mask |=3D MSTATUS_MPV | MSTATUS_GVA;
> -        }
>          if ((val & MSTATUS64_UXL) !=3D 0) {
>              mask |=3D MSTATUS64_UXL;
>          }
> @@ -2079,7 +2076,7 @@ static RISCVException write_mstatush(CPURISCVState =
*env, int csrno,
>                                       target_ulong val, uintptr_t ra)
>  {
>      uint64_t valh =3D (uint64_t)val << 32;
> -    uint64_t mask =3D riscv_has_ext(env, RVH) ? MSTATUS_MPV | MSTATUS_GV=
A : 0;
> +    uint64_t mask =3D 0;
>
>      if (riscv_cpu_cfg(env)->ext_smdbltrp) {
>          mask |=3D MSTATUS_MDT;
> --
> 2.43.0
>
>

