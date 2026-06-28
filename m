Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6885CC43458
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jun 2026 23:30:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wdywk-0006fs-Ii; Sun, 28 Jun 2026 19:29:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wdywj-0006fb-8B
 for qemu-devel@nongnu.org; Sun, 28 Jun 2026 19:29:53 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wdywh-00016f-Kn
 for qemu-devel@nongnu.org; Sun, 28 Jun 2026 19:29:53 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-c125c082ee2so54633966b.0
 for <qemu-devel@nongnu.org>; Sun, 28 Jun 2026 16:29:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782689389; cv=none;
 d=google.com; s=arc-20260327;
 b=C0Paj6tYZpnIqLyDFxFXIoGwUkqrhodC53tNLZ++KpkBH3ZSitWe00LpGMVgOah2B8
 UtG4aZLO7Mbyec4g9WTRly/X4/EzC6zgzYG9+vT+FNMbQnL5IMROBwPwuCYoDX29V8Mp
 fA43FOd6v0/SdxvefAkzovJyv2Y7NxAZ2o1Pzsi8LOBYfXKEsTpZkthGKbcF/VfPy8Pj
 suWkxRxnyzKL2sQ47/YF/LbtirSkx3PSDK5arCKFR0o3trwUlvj7gSA+pRleUNefmi9K
 qrqBYTO7nc9w3UcfPVEwMflZyhidtgUHbxL5NfwzaV7AmGfCh7fnP3d2sVEwz90sxRCN
 pBlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=8usvzu6tjJ336nQdLGZEH/jxkhWEREKlsUPO74MbANI=;
 fh=weeZ+I/k7h7EVcDy63vo1ai172Vh7g4N1CNTsRAlT80=;
 b=KzwO39y46MEsiIQYDLOROF4L14rJP/8Jfj5r6+pFXsq0vLKh1TXOnWB9S6y3DzuU9q
 TIz5YLQHqkeoEwY1NVYBuQecKRaik6n4ZEwE/iko4XXN2BgjnLL45+wWSfQdjCpc7B0v
 8E+4sMgPKOeISbF9TWGHFAQZhIQAPj/SFSTNBE0oC7yTfPsBFnZrqK15zmxG/MMLpfeG
 oeLy/XJQEyxb937pA45CqYNIx/GdQrZ7X58hWdzQst+99LCaqQ6dsOcuKB1BRCD0UDp9
 bAK9ioui0N6yGFgwXF+P2B5DX9imCvFTGb5KOdbCJEZgxLPlLLizBIIFS/9Yi04Kb1Fl
 x7cQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782689389; x=1783294189; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8usvzu6tjJ336nQdLGZEH/jxkhWEREKlsUPO74MbANI=;
 b=EcK8837fVsPKk0zcNbpe1afasUFb2Xo/eKJVWWd9XLclhjnG36IJvkrUgN91VrYTkB
 R1Y6vg05QduWaEY9ZlV0IZTC06DgE8JNS8+rb1qG5vJ/F+JoQeDc75K8CworvQPk9lFc
 nAh3xtirVHS1PZTVkZGPx6HPldka0g569WFi7Waw/SkbYMgH9vUHvxcxCBGfje6D1GCP
 QqUOCZYcoXpn44xdvC/C5eAHtdCp7i2tSvToYKo8xgUcK+y8YDh8rskABDhybC+ZbdJv
 oFskEJO8kAv8mbgwiSbLnFbwhQFLC8OVLfPgZiKECjKw6BcBGSrkZjXEs4L5EFcZNj2B
 44rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782689389; x=1783294189;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8usvzu6tjJ336nQdLGZEH/jxkhWEREKlsUPO74MbANI=;
 b=FZ/G5Pk/F+Q2MJuc7aParhFThcgmBqjpCmMx5JGrI4uD2cmOuE/JLO0lZ+VwxF/pEF
 xN7OOTWoKzaJ/z0h6nnSHN1GSiyNub+BJCUtHlefBdRQOPnUwrRwXqbv8eZNjusHPL2d
 uFPXWJm4nLf93dT7HuJcWu6K/Ww72Eqgv+5aVKSsyXIcS8oVHlDYZqufmG5pldyKPf0g
 xtINO4sZ+OnLzs9vc5xTgqixFkcEkCQWZQGIgxdokjkThd5Azd5kC/tTn4iYzJRcl0Z4
 4rb9KKfH+KFPro/m7HuNWFNpVLjCwI8jN/kgpN3Mk9zWRgJsPRpteWz5t8kgPysWj5LU
 MUDw==
X-Gm-Message-State: AOJu0YyRWMvX2hKbE8U7BtY6rvvQncJ2NpDoawxRRJLHQTgrABP8qcGg
 3fmj5iD2S5/1AdoLOYmB6MUEnCx33RMsMmVjuARLEBe7rNskrLnWyWFt+k47ozctNhZDa3HNRPk
 aI1mftBd7ATMvg3cKc8k5QrM6Uo6caB0=
X-Gm-Gg: AfdE7cmau7SGFxvsk1h/YeK9BA4H3nJemVqQRUkIkS2aFAkKs7zHRz22zdeW7AVyFoo
 3aGGGfHkpR1BeuFyWmSQagDPBrRtApt3hjXoTa6gWQlHuVIK5B4R8ExnOf3Clb9Hc9XzmJVHcwF
 JGx/aJDwnHXCoBkzReKAbsRKMpNKhz7RsF98MOlNcZMO3EfO4UjJOXwT6NRMYBdxkRwovmTBfve
 tBf/DKQY2Cu2ay8o17Iw4+Rdx8/fntxjJ7uK0UuFnre0L1avJ1Bj2AWz/v7+tuQ3s318fK+OMl8
 gCQ184nG0HEfi2nSSiEvW9iUHcI=
X-Received: by 2002:a17:907:6d0f:b0:c12:6f98:d6a1 with SMTP id
 a640c23a62f3a-c126f98e49emr19130166b.62.1782689388859; Sun, 28 Jun 2026
 16:29:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260628114925.418293-1-bin.meng@processmission.com>
In-Reply-To: <20260628114925.418293-1-bin.meng@processmission.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 29 Jun 2026 09:29:22 +1000
X-Gm-Features: AVVi8CeMUcXWCk1q8FmiVmZFVAwnl562rUwBGFrMRDwyJUuEVb1wrFeOBjMNusU
Message-ID: <CAKmqyKMzUgs=1LMJZHoFUt1j2PSWTTKbAbg7gvzjZx83V041OQ@mail.gmail.com>
Subject: Re: [PATCH] docs/system/arm: Document Zynq Buildroot boot
To: Bin Meng <bin.meng@processmission.com>
Cc: QEMU <qemu-devel@nongnu.org>, Alistair Francis <alistair@alistair23.me>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x632.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 WEIRD_QUOTING=0.001 autolearn=unavailable autolearn_force=no
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

On Sun, Jun 28, 2026 at 9:51=E2=80=AFPM Bin Meng <bin.meng@processmission.c=
om> wrote:
>
> The Zynq board documentation only showed a generic direct kernel
> boot command.
>
> Add Buildroot ZC702 commands for booting through U-Boot proper
> with the generic loader and for direct Linux boot from the
> generated SD image.
>
> Signed-off-by: Bin Meng <bin.meng@processmission.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

>
> ---
>
>  docs/system/arm/xlnx-zynq.rst | 54 ++++++++++++++++++++++++++++++-----
>  1 file changed, 47 insertions(+), 7 deletions(-)
>
> diff --git a/docs/system/arm/xlnx-zynq.rst b/docs/system/arm/xlnx-zynq.rs=
t
> index aa37df2926..95538cd32f 100644
> --- a/docs/system/arm/xlnx-zynq.rst
> +++ b/docs/system/arm/xlnx-zynq.rst
> @@ -30,16 +30,56 @@ The QEMU xilinx-zynq-a9 board supports the following =
devices:
>  - DDR Memory
>  - USB 2.0 x2
>
> -Running
> -"""""""
> -Direct Linux boot of a generic Arm upstream Linux kernel:
> +Running Buildroot ZC702 Images
> +""""""""""""""""""""""""""""""
> +
> +Buildroot has a ZC702 defconfig. Buildroot 2026.05 release is tested at =
the
> +time of writing. From the Buildroot source tree:
> +
> +.. code-block:: bash
> +
> +  $ make zynq_zc702_defconfig
> +  $ make
> +
> +The generated files are in ``output/images/``. The examples below use:
> +
> + * ``u-boot.bin``
> + * ``uImage``
> + * ``sdcard.img``
> +
> +QEMU's SD card model requires a power-of-two image size. Work on a copy
> +of the Buildroot SD image and resize the copy, not the original output:
> +
> +.. code-block:: bash
> +
> +  $ cp output/images/sdcard.img sdcard-qemu.img
> +  $ qemu-img resize -f raw sdcard-qemu.img 128M
> +
> +To boot through the U-Boot image generated by Buildroot, use the generic
> +loader device to place the raw ``u-boot.bin`` at the address it was link=
ed
> +for and start the CPU there.  The ``zynq_zc702_defconfig`` U-Boot image =
is
> +U-Boot proper, not a Zynq boot ROM image, and is linked at ``0x04000000`=
`:
> +
> +.. code-block:: bash
> +
> +  $ qemu-system-arm -M xilinx-zynq-a9 -m 1G \
> +      -machine boot-mode=3Dsd \
> +      -display none -serial null -serial mon:stdio \
> +      -device loader,file=3Doutput/images/u-boot.bin,addr=3D0x04000000,c=
pu-num=3D0 \

I'm surprised you can't use -kernel here

Alistair

> +      -drive file=3Dsdcard-qemu.img,if=3Dsd,format=3Draw
> +
> +Direct Linux boot of the generated Buildroot image is also supported. Th=
e Zynq
> +ZC702 DTB is generated by Buildroot and is located in
> +``output/images/zynq-zc702.dtb``. The kernel image is generated as a uIm=
age:
>
>  .. code-block:: bash
>
> -  $ qemu-system-aarch64 -M xilinx-zynq-a9 \
> -        -dtb zynq-zc702.dtb  -serial null -serial mon:stdio \
> -        -display none  -m 1024 \
> -        -initrd rootfs.cpio.gz -kernel zImage
> +  $ qemu-system-arm -M xilinx-zynq-a9 -m 1G \
> +      -display none -serial null -serial mon:stdio \
> +      -kernel output/images/uImage \
> +      -dtb output/images/zynq-zc702.dtb \
> +      -append "console=3DttyPS0,115200 root=3D/dev/mmcblk0p2 rw rootwait=
" \
> +      -drive file=3Dsdcard-qemu.img,if=3Dsd,format=3Draw
>
>  For configuring the boot-mode provide the following on the command line:
>
> --
> 2.34.1
>
>

