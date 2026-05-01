Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A563FF8864
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2026 04:17:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIfJ4-00011B-Qj; Fri, 01 May 2026 00:16:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wIfJ2-00010K-7w
 for qemu-devel@nongnu.org; Fri, 01 May 2026 00:16:48 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wIfJ0-0000jS-9u
 for qemu-devel@nongnu.org; Fri, 01 May 2026 00:16:47 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-ba7a1cc0380so260608566b.2
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 21:16:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777609005; cv=none;
 d=google.com; s=arc-20240605;
 b=Og+hlUowg0Me+XfAYlLDCKJbvCpdG7hNcIRuZ5dQq3eDwG6zvORq+lSL2VsYZK4Q3j
 yYfKTu8HuwDpy76yuaIxoKSXyqOzmF3nJU40TApdgDmXIJm6hFWN3WE7tXrz/LTELD3x
 yt2uT7lNIEW7JErW2EFuto9YOJ4cidPmLV38OdpTaX+GmEW/oelHDN+mrGz7kbiaZdk4
 NkBI3KJa8z5ZnmXR+D4PaSpeDC651aqArDOqmwnsYcg1PuayUJLEMQ1VWxvbasrKH1ZE
 /zB4vbozA7c/0RAs+1hrgW5KmEQNpJRdVIxdFdjtBmFrNyo05PY/FEPQeBfIK+C0OIQE
 MLig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=qEdfu0+04U0446mhaZyH4/XVereHfvhqp94rxS4g58Q=;
 fh=zex53l+6YmiJ9vrh6j+tZ7gQIT6HeZ+qSwrxHKq1nL8=;
 b=JF5AFksGu5yUUEkpyaRN9gee/ve5Md45q/LGGOQxZ+VoDOArtGE/HNc7AHmeWWF/qI
 L5XFcED9oRO/y8QYx/Haxl2uqnUWcVy5vWkYmfO4M6m2m99hmJv7sf32XQPn13HeMPPb
 OKAGOBzXgxfAtvGPP05CzNrA8h/NAGNJOaWCZKxnZflnrQL9PhqQKtWL1AJ8UrQP/vEm
 CxJ+pew6BPVBpdiHw57pDWXbymk/1PJ/+zOAirRAgNlTTqNqGlTALgMa/iU7e+/VrFhY
 Y/I5ZYYaagXrR32VL6GwuakXLEm4QF61FjluKeuQ88w8MUfTDHK3E8ULlIRWFcapiVU7
 W01Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777609005; x=1778213805; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qEdfu0+04U0446mhaZyH4/XVereHfvhqp94rxS4g58Q=;
 b=aZezShV7JygWOceMzH2BsqII9HaoME7pnYxmdsgkXH4EBbL9rOmFW/emb/iVDyAv1d
 92kzH5IPYgp7NoQU6k7icwSe5BJA1QK1yrMyTGbpBBZD0df90dpSAJvbuLzAARY7b+Yn
 /8DgW2r4G7qPFxEOdFRgwOjadO9esvYXPguR8sn8v2NC5MYEjsD5DfG95DQyfZcZhith
 ++v5mCfQ/2HXRQmStk+dNl2s/CzllOcbmQxs/MwIg+GnOdJWWHQHaSjEsYEnEp0tyEHZ
 AVY3l1rfD2HoJ4dmE87MGyu5Pda8uJ1EzngoiNYp1Iv1AIMh3FFdeCGEsoKvtb0x1S7t
 empA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777609005; x=1778213805;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qEdfu0+04U0446mhaZyH4/XVereHfvhqp94rxS4g58Q=;
 b=K44wfbKdg0rii/JiTTCyHVjcn/LpBa6kvsuldn6pMuYCCE2fWiCyWdjRKddiHdexVb
 a/EAvw3XEBpy8ZiE11t1Zh+dA5rMw8Md9RReSa2vt2oinTLulijtXsiXccxa0cvIxAON
 k+UyycsrKnsCPaAh51nnumf9WpU6j1v1+X/8sDd4UUzAqwZiSmlp9HwaGOhi+ivNqyG4
 7fYQL+W3WD+/HpoDsRoy0Ba27/1IRobKaj+Bfh5QO/pJZ1mcj16FZ1zdKkpdKW3CmsRO
 7Jhd4RbSgSUpew1GaQfyIBe7NXmJ1DCvK5L9t0laZ4M9nON5VdOx/Uq6e5qITMN6kwXW
 EjxA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8Pw8ZkHvZLyT/+s/IeSPxBvBApa65gwzzH56GIf5pGaZZAMc6Qq6imKcqeMZlG6YTzmXehnubtkXX6@nongnu.org
X-Gm-Message-State: AOJu0YxbEKyDVNyisrageB+XePFrR41BYkAYeFtsYe5WcAUru4cyQx1C
 eQc1+MlzeM4wAMc/gg1vP+eFuzcH3MFT4L8IqXaS+QHMtN3eTSdOd7qo/eZKVZxKN9fIDg+ZkXn
 nLJ/eHDizgRJ/KUYM8vnObHc1LRLDszc=
X-Gm-Gg: AeBDieujmkhp8/vkNpTAoi2w2jTtShiz/SvYusjfMrNb2k3hqvhJhr8bWcHhpFB8oJC
 vjawn6jCM0EGRut42IvXoTKhNk9fxZMSa2FXsJhJFRhqcheB1HMLWpRPOchesK1llcmUjU2wWju
 wIAbNYSxjjZt51U6DT5HJ5mAuUPPoABvjsKXQ0Z4S2PkQLbRLFBXREMH3vw5moLP10JPwD6IM6x
 gvjYS3rFGODtsVec2a+VtP+ldVipZM+LgamwoxFDygDh4QCDgIngYPUhrbN0evGWz3QoHlu4c+I
 i5gxPREtjY9ZyIS74WQ9z7bhvoiDbpkUDkowUShcAGz2CCu5PTxPSka0b2M=
X-Received: by 2002:a17:907:3d12:b0:b9d:8697:73b8 with SMTP id
 a640c23a62f3a-bbac6abd699mr375818966b.22.1777609004615; Thu, 30 Apr 2026
 21:16:44 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1776438369.git.chao.liu.zevorn@gmail.com>
 <3340676ead334e862b9eaf33297c87da158c0437.1776438369.git.chao.liu.zevorn@gmail.com>
In-Reply-To: <3340676ead334e862b9eaf33297c87da158c0437.1776438369.git.chao.liu.zevorn@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 1 May 2026 14:16:17 +1000
X-Gm-Features: AVHnY4LUNGJEMIg1y57Yn1orTBSAoMHXKYSfbPyPiDkw1dbScEcRDtRMZ8XSxQs
Message-ID: <CAKmqyKOKr02Cq7ko5wHkSuYrn4i=crjnkGEuFJeeWFYtG3X=UQ@mail.gmail.com>
Subject: Re: [PATCH v6 5/5] docs/system/riscv: add documentation for k230
 machine
To: Chao Liu <chao.liu.zevorn@gmail.com>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Christoph Muellner <christoph.muellner@vrull.eu>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 qemu-devel@nongnu.org, 
 qemu-riscv@nongnu.org, Chao Liu <chao.liu@zevorn.cn>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x62c.google.com
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

On Sat, Apr 18, 2026 at 1:13=E2=80=AFAM Chao Liu <chao.liu.zevorn@gmail.com=
> wrote:
>
> From: Chao Liu <chao.liu@zevorn.cn>
>
> Add documentation for k230 virt reference platform.
>
> Signed-off-by: Chao Liu <chao.liu.zevorn@gmail.com>
> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>  MAINTAINERS                  |  1 +
>  docs/system/riscv/k230.rst   | 48 ++++++++++++++++++++++++++++++++++++
>  docs/system/target-riscv.rst |  1 +
>  3 files changed, 50 insertions(+)
>  create mode 100644 docs/system/riscv/k230.rst
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b5b4acf6bd..d8d68cc123 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1776,6 +1776,7 @@ F: include/hw/riscv/xiangshan_kmh.h
>  K230 Machines
>  M: Chao Liu <chao.liu.zevorn@gmail.com>
>  S: Maintained
> +F: docs/system/riscv/k230.rst
>  F: hw/riscv/k230.c
>  F: hw/watchdog/k230_wdt.c
>  F: include/hw/riscv/k230.h
> diff --git a/docs/system/riscv/k230.rst b/docs/system/riscv/k230.rst
> new file mode 100644
> index 0000000000..3e6ca295df
> --- /dev/null
> +++ b/docs/system/riscv/k230.rst
> @@ -0,0 +1,48 @@
> +Kendryte K230 virt reference platform (``k230``)
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +The ``k230`` machine is compatible with with Kendryte K230 SDK.
> +
> +The K230 is a chip from the AIoT SoC series made by Kendryte =C2=AE =E2=
=80=94 a part of
> +Canaan Inc. It uses a brand-new multi-heterogeneous unit accelerated com=
puting
> +structure.
> +
> +This chip has 2 RISC-V computing cores and a new-generation KPU (Knowled=
ge
> +Process Unit) smart computing unit.
> +
> +It has multi-precision AI computing ability, works with many common AI c=
omputing
> +frameworks, and for some typical networks, its usage rate is over 70%. B=
esides,
> +the K230 chip supports many peripheral connections and has several speci=
al
> +hardware acceleration units (like 2D and 2.5D accelerators). It can spee=
d up
> +different tasks (such as image processing, video processing, audio proce=
ssing
> +and AI computing). It also has many good features: low delay, high perfo=
rmance,
> +low power use and fast start-up.

This seems like a bit too much marketing, let's remove this paragraph.

> +
> +For more information, see <https://www.kendryte.com/en/proDetail/230>
> +
> +Supported devices
> +-----------------
> +The ``k230`` machine supports the following devices:
> +
> +* 1 c908 cores
> +* Core Local Interruptor (CLINT)
> +* Incoming MSI Controller (IMSIC)
> +* 2 K230 Watchdog Timer
> +* 4 UART
> +
> +Boot options
> +------------
> +The ``k230`` machine can start using the standard ``-bios``
> +functionality for loading the boot image. You need to compile and link
> +the firmware, kernel, and Device Tree (FDT) into a single binary file wi=
th
> +K230 SDK(k230_canmv_defconfig), such as ``uboot``.
> +
> +Running
> +-------
> +Below is an example command line for running the ``k230``
> +machine:
> +
> +.. code-block:: bash
> +
> +   $ qemu-system-riscv64 -machine k230 \
> +      -bios k230_sdk/output/k230_canmv_defconfig/little/uboot/u-boot \
> +      -nographic

Does -kernel not work?

Alistair

