Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FA7DCD98F0
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jun 2026 23:58:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbS3M-0001gl-SF; Sun, 21 Jun 2026 19:58:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wbS3M-0001gL-1I
 for qemu-devel@nongnu.org; Sun, 21 Jun 2026 19:58:16 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wbS3K-0004qF-9m
 for qemu-devel@nongnu.org; Sun, 21 Jun 2026 19:58:15 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-6977dc206afso2375528a12.1
 for <qemu-devel@nongnu.org>; Sun, 21 Jun 2026 16:58:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782086293; cv=none;
 d=google.com; s=arc-20240605;
 b=Tulj4S32AqfvN1e6n8bMx7DsDH8BUcluvzER9esuJXZcI6sR5n/TOiHpDOIxrZOAHK
 lIHr7u8UQ03LPIPH72J2EMbWPRHTKRW9ltWARDg0CPGLlTpH+Y9JDvVCjH5dHBI4Qc5R
 8g5Np+rnft19mdS+R6Vb+X+x7OPKVEpMHSRUKStlr/ClkScAqji8dufHkLzeba/EOvJI
 8y8Hwxgq4T1Ka5Lv5LMKd3rvbPz1gr+PlqLXeCPuJV12A1qdVi0ecimbi3jq47xwQ4AJ
 BFJ7gesJ6mwSU3vyfqERkuSvdL69epWI2L5BK6DOEe1YDt91UrdTyXksKML25x0nxO+i
 U8GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=2M9dSVH3v4ANsnK5FFfYjMxt1yfWmN6H6XpeXKttUwU=;
 fh=RNfHlsF+aQR2fsdicM7H+MqGc3Rl4jeVskW8znIgIvg=;
 b=KWipqIx4QQZuq3V80dRKbJS1DviBi2M5papzYrlJT+9nmonkX5yTE5jARUq2EAjlPJ
 YOlpkMVG7vnU2BYTkJFGh3kHrk6a36scHCX/Dy0DcODDDgAu9htxZjwPt62qxAthFUoP
 LtCVtr8n966H8lPT4xrFXHlz6Bn3a58vYRVYjLWemLbztX9+MoC1eRogFHm8J7LYhTsh
 Sjbf/kJ+o9C8zyt3U9NPhpXLBBxJqkSLk5NQgfYa5D8TlyDg28zkzqxRA3vA/kPTOBWW
 pieo6BsACgrrBuDcqEMQ0Aj+/Z6L+mVwDZHwS19a83JP2kKf3buoa6HTOZpdOL+Y5UHV
 mHwQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782086293; x=1782691093; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2M9dSVH3v4ANsnK5FFfYjMxt1yfWmN6H6XpeXKttUwU=;
 b=F0dkTbFFVN8xkYgiOcRarUSQDmTN/SSrBxS2QwLqFIqfv6Ak57HqMdICamw9S8AEeh
 zeZNtKM8R+ZZVIW2sL77FU6ASeAgdRkhwJtcleRqR+6Dhk+y0xc3kIqyGIVnnZUHRUY3
 ypKU7ULrww5DrEaCSlaIhBQfpmAygg25rEr0a9vNbvAT5zoc+Rrh0+T7wysUiJrj4VLu
 JwhQ0+2sL0kMqLnzTc+YDgESykkVS/IEorXf6wzqBhGuNxJoFEmcoodjTTJ9sLWVjuMX
 3iZ73Yo4OWVdxKO55AP/SGzN1dcuoNb/SrNU/7W8fqGKidwR77EI5E6fRiblTRZpq5hH
 8GmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782086293; x=1782691093;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2M9dSVH3v4ANsnK5FFfYjMxt1yfWmN6H6XpeXKttUwU=;
 b=NSaiHdO1UVXXxJy39PfkEt99CHqgHAqh05VC/5h4dmZ8m5cy/r3LKst76waE+womrg
 GhX9KL0b00rj6zHWj0I4P4BEUfl+Y9AC/UMI8ErmZLp84cOcBsVVvuZPUvnPAGgaTb8A
 MO7vAqgMt8w1bUyAt9k7wYlXm+lMIME/xufiypVKDqgUDz5RSZlzXFGSNfqoG98vrPxd
 JMB0hWtJcVJp71eyK48qR43Qif2jUtajRrr5J8xngMQvaj4iK2tXzGIDZ+8nPrgHsowW
 Bs1Qh1Qznk2KBuu/8M2RSA6WaxK1LlMDvsukME3k+/FnU1pOsiJ0QuFYsTvzeeoYbLjO
 n03g==
X-Forwarded-Encrypted: i=1;
 AFNElJ+j/EeShQMFVsQSqIjFR1IkXwb9kHu/RmVifcOiRQ/mxXK86IZ/DE7hNfUWZHcQszHj+BoFWzLB8Zmy@nongnu.org
X-Gm-Message-State: AOJu0YzO0iUvCvndfEh65FFW7bgcA/puAB/NlaOo0aVlPbXrBl72yKZW
 FZeIQ264BCU8k07q6r3GYQS8Ejf0z+D2JCwi5s1yvpVW4mrD3hpqoC5DmSqfZqd2Kp/eDbPaUDw
 kH88za1YZlSClMrulMV132wyjYG/ZB9s=
X-Gm-Gg: AfdE7clfiIdf80iGPNgNkt/ynXciDTEOVCDz2HlpkYEO+LY6pCn5bztXU4MLDlF6c89
 MUazNMTTDeHhElhiU5OsQ4txIZe07ewvHdm46WOmRBWqOfC1PKJy8JTkQArB5/aGz/IK+8Sc0sv
 Bkva/kxI1FO0RoPqcl58feKhMT3ka6LVJATS3G2NNkqIPMlQPBzp8mp8ybo4RBqQNDrpgp7BBHw
 cu1eBwRAj+rUDFr12WAgo7St8a9dJ+mlvIqYV7DN0ig11IEYmegS023tQjzFdcA9N2+ezE15COC
 Lqycs+WO/RyFukX+Td4GCLTETnQ=
X-Received: by 2002:a05:6402:3705:b0:691:afd5:77e7 with SMTP id
 4fb4d7f45d1cf-696e51067d0mr5733317a12.22.1782086292772; Sun, 21 Jun 2026
 16:58:12 -0700 (PDT)
MIME-Version: 1.0
References: <20260617054034.1020724-1-joel@jms.id.au>
 <20260617054034.1020724-3-joel@jms.id.au>
In-Reply-To: <20260617054034.1020724-3-joel@jms.id.au>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 22 Jun 2026 09:57:45 +1000
X-Gm-Features: AVVi8CdZfgkHCFwtNXGQtx5vArKbqxAwAaTvMFid-_pX53iQTmXXW-LJzIg5kr8
Message-ID: <CAKmqyKMFMtR4UQfNOtNB-GT8Pd9_WZKkA+ECpSv_cbBob60j7g@mail.gmail.com>
Subject: Re: [PATCH 2/3] tests/functional/riscv64: Use newer kernel for tuxrun
 boot
To: Joel Stanley <joel@jms.id.au>
Cc: alistair.francis@wdc.com, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Anton Johansson <anjo@rev.ng>, qemu-riscv@nongnu.org, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x529.google.com
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

On Wed, Jun 17, 2026 at 3:42=E2=80=AFPM Joel Stanley <joel@jms.id.au> wrote=
:
>
> The published tuxrun kernel is 6.4 which predates the introduction of
> AIA support in Linux. Update it to a 6.11 kernel, the newest build
> on the tuxrun site.
>
> Boot times on a laptop are slightly longer but still reasonable:
>
>                        | v6.4.16 | v6.11.9
>   ---------------------|---------|--------
>    test_riscv64        | 4.82s   | 5.56s
>   ---------------------|---------|--------
>    test_riscv64_maxcpu | 4.94s   | 5.30s
>
> Signed-off-by: Joel Stanley <joel@jms.id.au>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  tests/functional/riscv64/test_tuxrun.py | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tests/functional/riscv64/test_tuxrun.py b/tests/functional/r=
iscv64/test_tuxrun.py
> index 0d8de36204a3..43d1242be52b 100755
> --- a/tests/functional/riscv64/test_tuxrun.py
> +++ b/tests/functional/riscv64/test_tuxrun.py
> @@ -17,8 +17,8 @@
>  class TuxRunRiscV64Test(TuxRunBaselineTest):
>
>      ASSET_RISCV64_KERNEL =3D Asset(
> -        'https://storage.tuxboot.com/buildroot/20241119/riscv64/Image',
> -        '2bd8132a3bf21570290042324fff48c987f42f2a00c08de979f43f0662ebadb=
a')
> +        'https://storage.tuxboot.com/kernels/6.11.9/riscv64/Image',
> +        '174f8bb87f08961e54fa3fcd954a8e31f4645f6d6af4dd43983d5e9841490fb=
0')
>      ASSET_RISCV64_ROOTFS =3D Asset(
>          'https://storage.tuxboot.com/buildroot/20241119/riscv64/rootfs.e=
xt4.zst',
>          'aa4736a9872651dfc0d95e709465eedf1134fd19d42b8cb305bfd776f980100=
4')
> --
> 2.47.3
>
>

