Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FD11CD4F3C
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 01:43:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOn0q-0006ws-UA; Sun, 17 May 2026 21:43:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wOn0p-0006w9-66
 for qemu-devel@nongnu.org; Sun, 17 May 2026 21:43:19 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wOn0n-0001rS-Ix
 for qemu-devel@nongnu.org; Sun, 17 May 2026 21:43:18 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-b9d9971d059so239755866b.2
 for <qemu-devel@nongnu.org>; Sun, 17 May 2026 18:43:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779068596; cv=none;
 d=google.com; s=arc-20240605;
 b=B3AHqGJ8KT1GAoWKIWiVaKEyLo25YX45PY6EzgiWB51syGTHSWusrxCbuL2ijpwGoK
 v1G+UqeJErPxxN5KKMPLYJ5l+BhP7/xsR7uwYiUj9YK1k03oswKLdEew8pkxpm29GISt
 Nct3+N8SHRpb0Q1PArxIavySgs6y4YuxzKf5/AAqK0IdCrHs/9XAwY7Wfi3aNC2uaCKa
 iIiicEbSZe8vhOkJScuq7YfOjniZLNnlp3AOUtndgODxZzi2vs0UW50F+yioJhrkm4I0
 UAtB07qKCTcUX63ppmUoPrAag16ZQwiL+abo+Y6RwpLmTXGLycEl9NB7GJ9fqq9q7zeK
 VCzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=bAIgJ1gRBZ3kputObv+0kyiYnF1nuKVdOh2nfCz0peM=;
 fh=Dkcg10OlgQa9cpo79WQw4VyLH3xb5cyd06PVFY+226s=;
 b=IBJi6dczipc3spAT83MmPzZNwQOV9oEMK5iCBqx8peilm4RzhqoTZTZ2L73GkZdtKY
 Zh4e4iMS9MxoD6mvna/A1+S8WfET/ICdjKzG3/1GOvfYsp7p+JFveofl4MSHHW3bmZtH
 9fYKOfPZBz3P3dVhKxA3mmPJux0pgXXxBWcbF6SDMu7+60N7W0++IQIt4iIvXBP3AFyC
 mMvTTAUcOugnfv/N36YAgfxKlKk3BwTnP5WLVAfTc/GpjOQU4qmRBkXqelh5rg9DBrGz
 EgNPiFBMNJpjWRTKtpFQjhd/1IqeR6wKQXiegFnSmB0+drOK72AoRJIMo2eHEdRkmeJJ
 mpwg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779068596; x=1779673396; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bAIgJ1gRBZ3kputObv+0kyiYnF1nuKVdOh2nfCz0peM=;
 b=OQe6A1IJ+Dhcc+OOV4c/2wqV/MigJL4C/b3vLooTXQ0h+hkGKJqoZBH06+vJAttYLo
 FzkomL1dWIqHfEgP3Ut19Knb/TBY5RRf3KttzS8EZBaMEOH7l+ojoI9VIz5DpkBL8w1k
 UFPJ09lo5la+I3xFkr6yM/RCgMtbAkdHSAWlfcagLyi7uoHCB+ZitM0b85turLjPmbVj
 HPATonZr+lT9y9lJnk6VilUH5wj03cDtBo/OMljlMuh5Gq5LdKReV/PAHjsf5sMdr24l
 aN/IgA0k/rYD4pnvFmfwtm+tegT9ARnhl6KznO7AWyqKf5tm+93dM5vWKPneAEqcmayA
 AHZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779068596; x=1779673396;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bAIgJ1gRBZ3kputObv+0kyiYnF1nuKVdOh2nfCz0peM=;
 b=fXzTJlvkjRd8zCW5iwvMIZhtEt0Tg2qvFME4PmfLQG13RtqLTPdHhBlwfQH3+ULw9U
 X4nQQ2zva6U9VK+3NyPfvBu4nr3wz/CUEtiKc5kzSdQRTZtTjAtIFS4Ftnabt50d4AwG
 bOn6KJfETXl1/hxXyfDN0a2RESiCi5K2RnPGvuBL36skwBD9RFSLxP04vR/YMGqPqdMQ
 ZYRiBhInk0bg37FogOcen+yVpSA7zP5OC9j0IALQbF0kcVGg109bHEHo5Coa22kREgP6
 5ByYvxd4spVo+lsDZN4RypFzb4rz8edYWFeYxYxiQLinGctIMT4fEfldif5Jj1L3PZcF
 eTWQ==
X-Gm-Message-State: AOJu0YxgqczHS3ugu92OclueV+tprh3Sy8r83cbYQ9cUDpsSh9ARiOso
 A2Q4N7fqkTTsfHSIekhDOjCNE6kYNImAhwlGlKMzPeJAG88qZOww7pNIy1MoJQqIQXGIgp42ENi
 gfANxs9LXyjKv03f5Q6kZmAwDrgEZZ5U=
X-Gm-Gg: Acq92OFTegYji8BIjJ/Yu+r0lkwvAoimuGVYo7xNaRj/JbdCmwduDUmyL9Ek+4Z6kM4
 UR1TXExYyNLI3PDoFRKw8ouMYPM9ZQeo37sEv7+pdxBhAXgnqYPXw3VRZe5ccfYdRPyZSaiOMmD
 qElQXiokD9FB6NH+DE0tu0P9D9au86OcPv/9VLfAPddprCIZECgmfDZLND3qs3i+xBCN7FC6Fji
 cjSKp2/gmaK96Ox6rdUdqYUqVQqSMbViC3zvB9yVW8c2Irq0hN87ayoFY6W/Q4P8O5+4tD8nNit
 WqejOLwpU43i5T/Txy6KRKsWINkJM1xpwemWg1NGU+Qdr2qI
X-Received: by 2002:a17:907:3cc7:b0:bd5:18e8:1ad8 with SMTP id
 a640c23a62f3a-bd518e82334mr620551766b.4.1779068595620; Sun, 17 May 2026
 18:43:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260424191129.1494381-1-daniel.barboza@oss.qualcomm.com>
 <20260424191129.1494381-4-daniel.barboza@oss.qualcomm.com>
 <CAKmqyKNZiA=rYVD6ighyFO+qmhdYVk=UgbaznBHrZ2yt1ZvOtA@mail.gmail.com>
 <c4709186-97ec-4ecb-804e-ac96d527c569@oss.qualcomm.com>
In-Reply-To: <c4709186-97ec-4ecb-804e-ac96d527c569@oss.qualcomm.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 18 May 2026 11:42:48 +1000
X-Gm-Features: AVHnY4Knl0K0o-uKIGGZjBKOvI4hmY6LRgc3rcmmPxEeDYL-1xrrV6UJ6x47g8w
Message-ID: <CAKmqyKMd4Am=kmvN4egaWJidbtaX0LzOMSjLjgwXM+ZKZnszmw@mail.gmail.com>
Subject: Re: [PATCH v5 3/4] hw/riscv: server platform reference machine
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com, 
 leif.lindholm@oss.qualcomm.com, Fei Wu <wu.fei9@sanechips.com.cn>, 
 andrew.jones@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x636.google.com
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

On Tue, May 5, 2026 at 4:56=E2=80=AFAM Daniel Henrique Barboza
<daniel.barboza@oss.qualcomm.com> wrote:
>
>
>
> On 5/1/2026 12:27 AM, Alistair Francis wrote:
> > On Sat, Apr 25, 2026 at 5:13=E2=80=AFAM Daniel Henrique Barboza
> > <daniel.barboza@oss.qualcomm.com> wrote:
> >>
> >> From: Fei Wu <wu.fei9@sanechips.com.cn>
> >>
> >> The RISC-V Server Platform specification [1] defines a standardized se=
t
> >> of hardware and software capabilities, that portable system software,
> >> such as OS and hypervisors can rely on being present in a RISC-V serve=
r
> >> platform.
> >>
> >> The main features included in this emulation are:
> >>
> >> - Based on riscv virt machine type;
> >> - A new memory map as close as virt machine as possible;
> >> - An always present IOMMU platform device (riscv-iommu-sys) that uses
> >>    IRQs 36 to 39, one IRQ for queue, similar to the 'virt' board;
> >> - AIA;
> >> - PCIe AHCI;
> >> - PCIe NIC;
> >> - No virtio device;
> >> - No fw_cfg device;
> >> - No ACPI table provided;
> >> - Only minimal device tree nodes.
> >
> > Can you describe why we actually need/want this? The virt machine
> > already covers a lot of this and OSes and Hypervisors can pretty
> > easily target that. I'm not clear what this buys us in QEMU. Maintaing
> > a machine isn't that hard, but it would be nice to have a good reason
> > to support it.
>
> I'm late to the discussions but following up what Leif and Peter already
> commented: this is a similar use case as ARM's sbsa-ref machine.  It is a
> development focused board that adheres to a reference spec, it is not a
> board to be used for overall consumption - for that we have 'virt'.

That is all good information to add to the documentation :)

>
> If the reference spec changes the emulation will follow suit, and existin=
g
> software that was working previously can stop working.  The assumption ma=
de
> here is that, when a spec change happens, developers must strive to make
> the SW work on the updated spec/reference machine.

I'm not sure people will like that though. If you are mid-way through
making hardware to target v1.0 and v2.0 comes out you don't expect
QEMU to update and break your entire setup.

But no one is going to expect to migrate, so we could just add a new
machine when v2.0 comes out. So hopefully it isn't too much of a
hassle

>
> Last but not the least, this design decision also spare us from dealing w=
ith
> machine versioning.

Yep, seems fair

Alistair

