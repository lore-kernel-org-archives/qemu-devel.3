Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E287C4828D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 20:51:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXSPk-0000XY-IV; Tue, 06 Feb 2024 15:51:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexghiti@rivosinc.com>)
 id 1rXSPi-0000Wz-MG
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 15:51:30 -0500
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexghiti@rivosinc.com>)
 id 1rXSPg-000239-S0
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 15:51:30 -0500
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-55ee686b5d5so8011093a12.0
 for <qemu-devel@nongnu.org>; Tue, 06 Feb 2024 12:51:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1707252687; x=1707857487;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n4jerX5u3GdPAZFbbFtgIwY0JRsEck8JPJyOaDuM158=;
 b=m3p9Te+R//kHUNLl8kQems6brxnSCwSTEdSWX/gupoU3132rvSBdiy27dF1S6iz0RQ
 ME8J/I+DrK2zacRI0Qw89BY+3bCjNIk5JIb/iGFjJ/DjDeWvsDO2/RvNzFXc9sxjCMP+
 zvTcBBetRjLa8oaPdTbs/11MU5F2vNvLU0edk67hOBQRqxz4jJGTf7yBlvVj+y2nOoHT
 uUqCMY4H2bpfVZW4Au//LwkM7f25OSp9ln4ianc6XzeL0uXb7quY0wVSbzacWR+TIPxc
 fardE6AUEW8biaWuw0QrZnKkeyglNMIH5vH++W0dKrmb4FWoUU5Q07Ph+ylEax/ws4tV
 8WrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707252687; x=1707857487;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n4jerX5u3GdPAZFbbFtgIwY0JRsEck8JPJyOaDuM158=;
 b=sMn1a2wFgIrSFbriorBvFX2f0jmrUbDmHc4oXoMsZ4BMfc+Sxjv4POan1CttYR9pzZ
 4/hNDJUHX9Y+zHdZHMX4mH5j1vkap4qvhrPbPfwkVPqxjFf6f5PVDs+bcofhndxwzcw6
 GxC6/bQsul0O5KoKz+kRGNw3TbowPjTOGOCLG4pUv3JVz419Frh0O5S8bLvl0NoXtonb
 8XEKcmgTgVE1970p9r6CU5tXbLEcO5FdDAHcwnw8MDAbqhIa2oUiKtsMiipajCSq943j
 Y5kclwXsrftZj4+bFKX81sT8HO4uLujOp6wR+EjAdJyOCuLyFwZL/G9T2KalzYVvFNob
 Ln3A==
X-Gm-Message-State: AOJu0YzuWUjJETET4m45jVz9G9+4Jwyg0dszQyoXjBTFoqjeojsiZEUG
 HE55B4paFo+n7U3Hzag53i0GxCF3jy34krvocJFbehETarX9gqa/mIg44il/g02di+dG+nv+ybZ
 UvKjIxktP4q3cbwaFonMEyD5QnIxwEGAtqxGGuw==
X-Google-Smtp-Source: AGHT+IEWJnGudiUYr6ric8rXBRWclUp8D6Nafoz+KOK3qLOkk/KJhR4q9DXFcuSLlXVfSDtK4tDJe5hcKLGh3m6Z1BY=
X-Received: by 2002:a17:906:5651:b0:a30:d5ae:2833 with SMTP id
 v17-20020a170906565100b00a30d5ae2833mr2651236ejr.56.1707252686997; Tue, 06
 Feb 2024 12:51:26 -0800 (PST)
MIME-Version: 1.0
References: <20240206154042.514698-1-alexghiti@rivosinc.com>
 <c8817977-a8ad-4f94-9847-a43d08c5b4df@ventanamicro.com>
In-Reply-To: <c8817977-a8ad-4f94-9847-a43d08c5b4df@ventanamicro.com>
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Tue, 6 Feb 2024 21:51:16 +0100
Message-ID: <CAHVXubgZq5rjpBPFirYVX0v7+Hjd7wVUO0pFbHxiirRDAoxPeg@mail.gmail.com>
Subject: Re: [PATCH v2] hw: riscv: Allow large kernels to boot by moving the
 initrd further away in RAM
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liwei1518@gmail.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=alexghiti@rivosinc.com; helo=mail-ed1-x529.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, Feb 6, 2024 at 9:39=E2=80=AFPM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
>
>
> On 2/6/24 12:40, Alexandre Ghiti wrote:
> > Currently, the initrd is placed at 128MB, which overlaps with the kerne=
l
> > when it is large (for example syzbot kernels are). From the kernel side=
,
> > there is no reason we could not push the initrd further away in memory
> > to accommodate large kernels, so move the initrd at 512MB when possible=
.
> >
> > The ideal solution would have been to place the initrd based on the
> > kernel size but we actually can't since the bss size is not known when
> > the image is loaded by load_image_targphys_as() and the initrd would
> > then overlap with this section.
> >
> > Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> > ---
>
> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Thanks for your help!

Alex

>
> >
> > Changes in v2:
> > - Fix typos in commit log (Daniel) and title
> > - Added to the commit log why using the kernel size does not work
> >    (Daniel)
> >
> >   hw/riscv/boot.c | 12 ++++++------
> >   1 file changed, 6 insertions(+), 6 deletions(-)
> >
> > diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
> > index 0ffca05189..9a367af2fa 100644
> > --- a/hw/riscv/boot.c
> > +++ b/hw/riscv/boot.c
> > @@ -188,13 +188,13 @@ static void riscv_load_initrd(MachineState *machi=
ne, uint64_t kernel_entry)
> >        * kernel is uncompressed it will not clobber the initrd. However
> >        * on boards without much RAM we must ensure that we still leave
> >        * enough room for a decent sized initrd, and on boards with larg=
e
> > -     * amounts of RAM we must avoid the initrd being so far up in RAM
> > -     * that it is outside lowmem and inaccessible to the kernel.
> > -     * So for boards with less  than 256MB of RAM we put the initrd
> > -     * halfway into RAM, and for boards with 256MB of RAM or more we p=
ut
> > -     * the initrd at 128MB.
> > +     * amounts of RAM, we put the initrd at 512MB to allow large kerne=
ls
> > +     * to boot.
> > +     * So for boards with less than 1GB of RAM we put the initrd
> > +     * halfway into RAM, and for boards with 1GB of RAM or more we put
> > +     * the initrd at 512MB.
> >        */
> > -    start =3D kernel_entry + MIN(mem_size / 2, 128 * MiB);
> > +    start =3D kernel_entry + MIN(mem_size / 2, 512 * MiB);
> >
> >       size =3D load_ramdisk(filename, start, mem_size - start);
> >       if (size =3D=3D -1) {

