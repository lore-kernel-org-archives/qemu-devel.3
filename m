Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C75BBF36B97
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 01:22:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wB0ZZ-0006BF-60; Thu, 09 Apr 2026 21:22:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wB0ZY-0006AP-60
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 21:22:12 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wB0ZW-0003hQ-L9
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 21:22:11 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-b9825ba7e8dso207903966b.3
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2026 18:22:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775784129; cv=none;
 d=google.com; s=arc-20240605;
 b=Y2Bhk9gnC77TIpk7mLYBPvXzwbSg5sfTo+HGlQXlXxOwsuYSqQQR7Ml3tM+4MhW1Hd
 vwDvuX/21e/5DyvvrcPEwQO9SZo26f33YKVG2qN4CdbcTWwxZi/6v8N8ZUCKAhU7+jt+
 b8goK+PkEONcoID+Yvgi/JitvgUX7MK86zsRg0B6UqA8wC2f3osj4kx8kzH20e0q9yOh
 CcFK+PJ1Cz+bsGVrqLMapL4qAfjlW4nBcPT0gkIeudwjkMj2ULYDL9XMVRCSiHbdcHyx
 1vd60mKUu0B0T9MJvquP29nT0zxbmOyXkjLjeQM/ehJwgdb8s+olZredxfgzapMmrnmG
 mvZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=n7ybCpehmxz+hcqcVWTBu6jeVYUVszK4KXc+fbXvH5s=;
 fh=yA45nsw3/GlmR4yv0X4Y623/LexEZcgSQA1vCu7Dy/k=;
 b=THj7BGnWM/L7zP40sYhclCR8wtBOzgLq7YHmcGTpNgmp6VdEC7XDQboUH05MMg3jPb
 5VDy4ZkhTWoOFQ1AYXhrVSF8IhRdT2mAC/4rNfNCYI36sG35KDWW5ZBAl0ss1+BMkXib
 KGoULjlGhQoOiV+qdWM6Dn9RkuMvQ3seO/5dUMH2O/JEp6igUOygR+/iwCJnAJIL/62H
 NCXOFP2+2OR2L/h2tBSbWfJIzngBfXqHHAe0dGbLeWv2sLsv8ZdmECZ3t0kff0H0+2Fb
 pzCSJHMsyFKMCVqyzr9xR01MgU7r1xnvUPP3ZQLVBVuP42CGbDyJaUxxMkR3OsGJj91y
 CHdw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775784129; x=1776388929; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n7ybCpehmxz+hcqcVWTBu6jeVYUVszK4KXc+fbXvH5s=;
 b=qcncp71mQYJDZaFQfPZh0im0M4Yvm6b/mghR6dWJOkbLUaaSqecWcnmlffMLuQqUFH
 26SGghZw905WBEmIOCEm5hf1dza4npzT1HSill2EkNZLaFVcMjZbx9VRgX1vXTbkTUUm
 kYATqhNDWRD2cBCsB5rTc1ZAFGZB6xI5CBJU+OC9MDAQrJdx2kWrZPv8C0CtjG8NCLXe
 ntzbyCQwfUSr96kPljvsSAqKQwcQmBlrXF0T/rHt+pQ1PvYMu+f39s5js8c22BRlCAJf
 uzoA55EwNzoeYRau2PSyZFXqHXaz86h9wEiKm+ypDkzFWtGjP3qp46ZPK4LpIm1+SbxB
 V8IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775784129; x=1776388929;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=n7ybCpehmxz+hcqcVWTBu6jeVYUVszK4KXc+fbXvH5s=;
 b=dL7RVo8SPUzKq5CBRlABGOOwbsoPjKhVb+/4V1q2jpQbqJ+Z2QpLSDOg/BocQ8SkW3
 FR4zovQt+0wMJhFA/ouR6Q2GLNqdF7mZ7XpbMAQiwd1Dl3F9bBJTXN4RfD+0g1jx5Oup
 thL44VlZs0Vj6Q8kk3Js8JJTYZfpOhI3d2LPzgAMH78yyiTarIoMsy+uTxfU0o6Us3iu
 hCYWdWsWQ5xta1jH22JUkiRw+po8+Mb56SodbubQCVaLmIHXM0fh4dz5OxIr2BszPT9f
 pxhUs0yEv2W8gbl/bTgpRvK362gD+K/IHGuKBluy6zGYOKQvld4ctTmzBu807TW4vxNC
 abew==
X-Gm-Message-State: AOJu0Yyv01+GsSTvt34C/rfohfKjSEHO0evuE/h2SE8EY1ugkpYDSOAi
 k9O/sd0hz9t/FBI05rPmDrjpLdV5wmccUoObCS5bWprI3Z1Zb+qcza+c4WNlf5p5sL3l07ie8jF
 fbL2URmAFLm6x7dk7ZijbjX168pSjH8w=
X-Gm-Gg: AeBDietKRODETu7YFZv5df7cPUUCakf3KqmzaMqjKlvDMGuHoP4KBQbXupZDxVV4aLK
 UlmYattbQ1ZeLZBxa8V61N/xUsAuoor6N2ySE2/Mv8ZStPaWfJE5bN5l500ZyjYjiu8ET8MnkV3
 /+5c/ZbPGWng2yrsJte5SJogGescB7hS3sCTwzxoDM3g5Y23VdRWESQ0F0VBofTgjpuTUkZX+Lp
 Izzphse447++wlgmR6hBznVJzdN8OxorAjno7Yw2E0GImN1GdLgkYHbFxnc59Pa4Jayk80MSAdZ
 jHJBTy7mMgm56hP1yihbBTo+LY71dgxL5xZ14A==
X-Received: by 2002:a17:907:1c03:b0:b97:3bbe:e42b with SMTP id
 a640c23a62f3a-b9d729645f3mr70967766b.28.1775784128794; Thu, 09 Apr 2026
 18:22:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260409155344.2849233-1-bruno.vilaca.sa@gmail.com>
In-Reply-To: <20260409155344.2849233-1-bruno.vilaca.sa@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 10 Apr 2026 11:21:41 +1000
X-Gm-Features: AQROBzDzqFjZGtJJwdZ4FGzCWVLXwkpJ-w_QwzPBibD6Jqk54I0dhrUsAwPQYWw
Message-ID: <CAKmqyKO2y5g_ZtW0sjg6vmZ2bdr+9C6oWGRcZDbJk=ngKukbUg@mail.gmail.com>
Subject: Re: [PATCH 0/2] target/riscv: fix RV32 henvcfg/stateen CSR handling
To: Bruno Sa <bruno.vilaca.sa@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, palmer@dabbelt.com, 
 alistair.francis@wdc.com, liwei1518@gmail.com, dbarboza@ventanamicro.com, 
 zhiwei_liu@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x630.google.com
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

On Fri, Apr 10, 2026 at 3:27=E2=80=AFAM Bruno Sa <bruno.vilaca.sa@gmail.com=
> wrote:
>
> This series fixes two RV32-specific CSR handling issues in target/riscv.
>
> The first patch fixes write_henvcfg() so that an RV32 write to henvcfg
> does not clear the upper-half bits implemented in henvcfgh.
>
> The second patch fixes the RV32 split handling of the stateen CSRs by
> rejecting the xH CSRs on RV64, placing the upper-half mask bits in the
> *stateen0h write paths on RV32, and dropping the unsupported writable
> bits from sstateen0.
>
> Bruno Sa (2):
>   target/riscv: preserve RV32 henvcfgh on henvcfg writes
>   target/riscv: fix RV32 stateen CSR handling

Thanks for the patches.

I have applied patch 1 to my tree, but patch 2 doesn't seem to apply.
Do you mind rebasing it on
https://github.com/alistair23/qemu/tree/riscv-to-apply.next and
resending a v2

Alistair

>
>  target/riscv/csr.c | 122 ++++++++++++++++++++++++++++++++-------------
>  1 file changed, 86 insertions(+), 36 deletions(-)
>
> --
> 2.43.0
>

