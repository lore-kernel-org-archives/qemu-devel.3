Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36759CD6E55
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 03:07:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTsze-0006rM-94; Sun, 31 May 2026 23:07:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wTszb-0006qX-Jm
 for qemu-devel@nongnu.org; Sun, 31 May 2026 23:07:08 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wTszY-00038u-V4
 for qemu-devel@nongnu.org; Sun, 31 May 2026 23:07:07 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-bec441e4018so89400966b.2
 for <qemu-devel@nongnu.org>; Sun, 31 May 2026 20:07:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780283223; cv=none;
 d=google.com; s=arc-20240605;
 b=K8kWpeu0sUi0msDKOUR4Sj5GZDy0TEsu5HpZb6sei+5EDqNhTZUdptSN+aEdLjDnTL
 nk0aB6JHz21x2SmF4l7FRXtd/Air53n2rDCxR+KllqgxEfA5aB2Un3mYCm+fBPKZFdqP
 rl5hv2ZQXLKJFIJR1XvqmVDxVRHa6LiP6zH4Vp7mdgut3Nud/BZE/23kO2fwYYE5gjC4
 IU7Dsq4yQtFCrKBmfhHi3CGObxMw7zbfEyLWBhrtrQk2dxEePDyHsDw6JfgCdBHFwLaL
 er+eXSaT5+JvQ5ojhAZi7+ytPKjt0Jr8DWUeYUUOg94NK/G+cClamULSQLf5u9a7ksoZ
 RHlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=2bG2vXcHgdOad+pyBwpMkeEMzF2PgRDTgnOaa8Co4Yc=;
 fh=xLRgBsohad5DVstZxwA8FIEo2nCC2hNUIsrS92frplo=;
 b=iymm/XlRX2zJIRPU/666B/aVQPRLCeyabD1sQbwgpU5ArQVeW6/4RKkBcNEtGDHSP9
 39mHfcd/wZshtkkGzIwV5e8PlVHXGR3YBojUiQDmXWv9e46M8B/yBkbzRdWIuvTMnKZX
 IqR6PPRkTgAbrUxulXDQh+zjAcuvkrveRyUoRwhQzoYz/UF2bQjqCweXWpcm0ldNxxby
 vFvKYBbwunwhpcIjeqjHmR1CcLMI+0xEo2H3xt85GcnjL6Y6NGg/hNJaubjvztpP99WJ
 EhiMnS3q6Ym1j2dW1sYDkwypqjew26VagDeG/L+SQu/GOl4ULu1MCVCZHDZo5aA9dMzq
 iUlQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780283223; x=1780888023; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2bG2vXcHgdOad+pyBwpMkeEMzF2PgRDTgnOaa8Co4Yc=;
 b=GP+IdZ/vCVJXHy37E9uVIsZVNKio2S/SC3eONsJNtQDDYCpbVg9AYHIXB/IYhhSeKs
 ITXoW8LM3SZ/ySo3ay9qNIS3xd7FpXsxE1JH/rw7zeu1LjKzKnDy3avsJZMZZ1AUJ1ml
 ToCXhbJ0wOOmpVsjyYJ2hqkmrCrv+tQiKQswc/sEsMBmGEzBxP2MoB/i1t5fcJ006k8S
 OeVuIJDwzNF6k7sv4vSBm5RrqaUX2xMoj0fWsvWtHP0iZRrrURJn6KZlmLbfH0v72uzB
 uyKwNkMX5tmDbCy/DExHPJATRXStVT47bWSvsG4aw4C7gJzdugEUzB0nnNNFj3ysoOzP
 sB6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780283223; x=1780888023;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2bG2vXcHgdOad+pyBwpMkeEMzF2PgRDTgnOaa8Co4Yc=;
 b=o4teri9Wy5aTXu4mx+7/0JKhsODDNJFmFBEc4n0KuiNdGV8bsUKKTzas1E3cQq1yUu
 p4J5TEFThyKrxrYgFPqUOtvKLjo38n6ZEDCBcMLWggjjqigVxcADutic+wqCFTkKqKZI
 Og1Gsw8Qb47Ngi6tca1/JhCcz1bNpGwqNjh+b0cb0fFVVj3er0M+th6JODgXqO4MzYAO
 ZBEzPDhs6GqBJ69IzmjYQGCAFSFty6WPmjfemJoVdvHMfr9PIYhf9yolf08vUG0Yg+jL
 JtErpekAtYjJRTIPlmWVDmqV4YjBDnr7n2t1SbT92FF8yqW5IfGXNprL87loTHO8LbDU
 HwFw==
X-Gm-Message-State: AOJu0YxDXD22Lk6H+VcOX/g+3Wm8PJOwWkUUniEMcSU7Tk7FH1VWU6Nv
 M98Z1Jl4TlsWsKcjOYf3EIhafXQIDupUux6OqrSGhUtT9KDQ3UK6ghDDGVg1GeTIcKnMSPnd4NN
 ygfEV7gJ4G5TVfFWjXWUtM0vxqHMYgl0=
X-Gm-Gg: Acq92OGoyBlg2CfRMdCaukfgEWNrCu7RCFv+jF8D+JehtsjlTsP9PCjPJ8rpfZ4eYO2
 ff6/iG3eiBioIc4E4TaMB0v0iCvsGrCVJfCu1PvKMrBpY6RvuAh97/3wKFHlrN6udy13bh7sEB6
 FhIDYG6DOH4Ah89mYlUOgg4NASr2l4p9a6nMjqBLGUagBbyegdVtvte1aaMjd22z5OiFxaFmFtb
 TZG9D0q7yYp9FJrCe9lak5g2TggPznfyTxYZePREY8dS/WKTL8QI2dWWoUjUWoUdynYxtkYE6nd
 LqyCJcl+oxKfsu2WvvIbU+kzpv42lb5ahVid+2VynPwN4PweA0C8jfP8XL8=
X-Received: by 2002:a17:907:a2c5:b0:bed:9a7:5ed1 with SMTP id
 a640c23a62f3a-bed09a768a4mr156000866b.5.1780283223014; Sun, 31 May 2026
 20:07:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260514204640.2540054-1-daniel.barboza@oss.qualcomm.com>
 <20260514204640.2540054-5-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20260514204640.2540054-5-daniel.barboza@oss.qualcomm.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 1 Jun 2026 13:06:35 +1000
X-Gm-Features: AVHnY4KhQnxn9iTub1d8SKP7MGJHvKYAqWRB6Q9ZO2yHUoNl56ONKi4qeLoPUUw
Message-ID: <CAKmqyKNNHh70cxDXEwncFk0Hngje2HbiBdmwc8KxOP8m47+HRw@mail.gmail.com>
Subject: Re: [PATCH v6 4/4] docs: add riscv-server-ref.rst
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com, 
 leif.lindholm@oss.qualcomm.com, andrew.jones@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x629.google.com
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

On Fri, May 15, 2026 at 6:48=E2=80=AFAM Daniel Henrique Barboza
<daniel.barboza@oss.qualcomm.com> wrote:
>
> Add documentation for the new riscv-server-ref board.
>
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> ---
>  docs/system/riscv/riscv-server-ref.rst | 37 ++++++++++++++++++++++++++
>  docs/system/target-riscv.rst           |  1 +
>  2 files changed, 38 insertions(+)
>  create mode 100644 docs/system/riscv/riscv-server-ref.rst
>
> diff --git a/docs/system/riscv/riscv-server-ref.rst b/docs/system/riscv/r=
iscv-server-ref.rst
> new file mode 100644
> index 0000000000..7803133b77
> --- /dev/null
> +++ b/docs/system/riscv/riscv-server-ref.rst
> @@ -0,0 +1,37 @@
> +.. SPDX-License-Identifier: GPL-2.0-or-later
> +
> +RISC-V Server Platform Reference board (``riscv-server-ref``)
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +The RISC-V Server Platform specification `spec`_ defines a standardized
> +set of hardware and software capabilities that portable system software,
> +such as OS and hypervisors, can rely on being present in a RISC-V server
> +platform.  This machine aims to emulate this specification, providing
> +an environment for firmware/OS development and testing.
> +
> +`spec`_ is version 1.0 at the introduction of this board.  New spec vers=
ions
> +might trigger a revision of the emulation itself, which will strive to a=
lways
> +match the latest version available.  In case the emulation changes aren'=
t
> +backwards compatible we'll introduce a versioning scheme, probably via
> +a machine property, to allow older SW to run with older spec versions.
> +
> +The main features included in the riscv-server-ref board are:
> +
> +* IOMMU platform device (riscv-iommu-sys)
> +* AIA
> +* PCIe AHCI
> +* PCIe NIC
> +* No virtio mmio bus
> +* No fw_cfg device
> +* No ACPI table
> +* Minimal device tree nodes
> +
> +There are multiple ways of using this reference board, some of them bein=
g:
> +
> +* BIOS: u-boot-spl.bin; SD-CARD: <disk_containing_FIT>; NVME: <distro_di=
sk>
> +* BIOS: fw_dynamic.bin; KERNEL: u-boot.bin; NVME: <distro_disk>
> +* BIOS: fw_dynamic.bin; KERNEL: EDK2.fd; NVME: <distro_disk>
> +* BIOS: fw_dynamic.bin; KERNEL: <linux_image>; INITRD: <busybox_initrd>

Can we add a test case that boots something?

Alistair

