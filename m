Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7041BD1CA09
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 22:58:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t861H-00021b-GT; Mon, 04 Nov 2024 17:57:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t861F-00021J-KD
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 17:57:57 -0500
Received: from mail-ua1-x92f.google.com ([2607:f8b0:4864:20::92f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t861D-0007Vs-R9
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 17:57:57 -0500
Received: by mail-ua1-x92f.google.com with SMTP id
 a1e0cc1a2514c-84fb1225a89so1407870241.2
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 14:57:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730761073; x=1731365873; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P2TII5jZZDP8qBX2oyf9/oX3ylHhHTxI5Xk7hYMeK7Q=;
 b=NCEUUrtANn3u/nKfzY6Mu2dpOOpBi/X+0Stn4YAZrBNXeCqaFTISKUfxu98vRWy9iw
 ubucxkIdJ3CgyPVIjyQxWihdB+i36kjB4hDZmlzdoRILCOkBzyNbU9d3j/XBwLcY2OsE
 SmUlRYOlbgdbcdqoU0gTklVvb1aUkX1sCy5yEKcDi1lKlhFd1PxKr/oAD/4YYidFg6yG
 qlb+BjzFsWKPMQSrkjNWL3jkBKMU43Cw9zsmkXZJ7R3W3EMksgxDJAJDfz0MRq17NUov
 DYLns62nAVDpGi/FmTpsSfH264gEW+7Q/1YZhwakKD9huWL1Z7x7C1mA7/Cg+V6rvy5Z
 edeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730761073; x=1731365873;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P2TII5jZZDP8qBX2oyf9/oX3ylHhHTxI5Xk7hYMeK7Q=;
 b=ZKpQ/COX3Qkt5i2Ax2niVBtrKWu9Fi+ovFe3s60nM5RGxUWOlLX5LNiLPXmQeGq/Rl
 q7xymGwVf1Y5JZiTRyDZQw9EjsDm5Xm+hnc1+YnZh09Vb0ZxmCycXQBvVOmqv6WU9TXh
 qYy3y59dg1h/jjTn3ZNfb/4t6EHPSEIWHwPggv5BcQHqdc29oQSGVP1vlkNC5pWdNf5i
 Q0/IV3dR/rDoPOo/p2kOH8CY+itsVsO7UIwQ5XcYZYpGGC//Lz3bnDmz9E15aSI6s+rn
 5sIJSeAulrIYbSh3odLD7Z9kwfpsboK0C+zUuV3vYcsqWqsnJkvp/T9w0s+68hA+atPs
 lZHg==
X-Gm-Message-State: AOJu0Yz+y+ZkZaCN2UZdhiC5UNp3tl6GjObviYM1IA/vYNwdERM4SQuV
 +D8CWQw3RmAKKHhZV70I7ryYpTwsvyipxgUYcZw3SXmfIh/pBh5vct23Jufst7DcdhO1oHlbmLj
 WVpDNpi76vIh9C8MAA/S6Wgr2SdQ=
X-Google-Smtp-Source: AGHT+IFtjgYVoxMLliJlTlDpdl6By3uUIwQP3nk6bO1BWV0jZn1XHfr/4vx/NOa+Et6yBbY0zbZtGuN1JPEh9Jp2G6k=
X-Received: by 2002:a05:6102:cc6:b0:4a4:7c8d:2a87 with SMTP id
 ada2fe7eead31-4a8cfb67e1bmr32991204137.16.1730761073429; Mon, 04 Nov 2024
 14:57:53 -0800 (PST)
MIME-Version: 1.0
References: <20241031035319.731906-1-alistair.francis@wdc.com>
 <a6fdfd2c-c8e5-4594-88ac-1976cf39537d@tls.msk.ru>
In-Reply-To: <a6fdfd2c-c8e5-4594-88ac-1976cf39537d@tls.msk.ru>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 5 Nov 2024 08:57:27 +1000
Message-ID: <CAKmqyKO58CqEqcFH61Tq=wW3xU0wLsyZmG68RRHfbCOLLPqMYg@mail.gmail.com>
Subject: Re: [PULL 00/50] riscv-to-apply queue
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, Alistair Francis <alistair.francis@wdc.com>, 
 Deepak Gupta <debug@rivosinc.com>,
 Evgenii Prokopiev <evgenii.prokopiev@syntacore.com>, 
 TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>, 
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Anton Blanchard <antonb@tenstorrent.com>, 
 Rob Bradford <rbradford@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92f;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92f.google.com
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

On Fri, Nov 1, 2024 at 11:40=E2=80=AFPM Michael Tokarev <mjt@tls.msk.ru> wr=
ote:
>
> 31.10.2024 06:52, Alistair Francis wrote:
>
> > ----------------------------------------------------------------
> > RISC-V PR for 9.2
> >
> > * Fix an access to VXSAT
> > * Expose RV32 cpu to RV64 QEMU
> > * Don't clear PLIC pending bits on IRQ lowering
> > * Make PLIC zeroth priority register read-only
> > * Set vtype.vill on CPU reset
> > * Check and update APLIC pending when write sourcecfg
> > * Avoid dropping charecters with HTIF
> > * Apply FIFO backpressure to guests using SiFive UART
> > * Support for control flow integrity extensions
> > * Support for the IOMMU with the virt machine
> > * set 'aia_mode' to default in error path
> > * clarify how 'riscv-aia' default works
>
> Is there anything in there which is worth picking up for qemu-stable?

Sorry, I forgot to CC the patches

I think these are all worth backporting, but aren't critical fixes so
if there are any issues applying them just skip them:

target/riscv/csr.c: Fix an access to VXSAT
hw/intc: Don't clear pending bits on IRQ lowering
target/riscv: Set vtype.vill on CPU reset
hw/intc/riscv_aplic: Check and update pending when write sourcecfg
target/riscv/kvm: set 'aia_mode' to default in error path
target/riscv/kvm: clarify how 'riscv-aia' default works
target/riscv: Fix vcompress with rvv_ta_all_1s

Alistair

> I see numerous "fixes" in there, but I'm not sure which is which and
> what is important to have working in 9.1, 9.0, 8.2 (ubuntu lts) or 7.2...
> (I've added some CCs)
>
> Thanks,
>
> /mjt
>
> > ----------------------------------------------------------------
> > Alistair Francis (2):
> >        hw/char: riscv_htif: Use blocking qemu_chr_fe_write_all
> >        hw/char: sifive_uart: Print uart characters async
> >
> > Anton Blanchard (1):
> >        target/riscv: Fix vcompress with rvv_ta_all_1s
> >
> > Daniel Henrique Barboza (6):
> >        pci-ids.rst: add Red Hat pci-id for RISC-V IOMMU device
> >        test/qtest: add riscv-iommu-pci tests
> >        qtest/riscv-iommu-test: add init queues test
> >        docs/specs: add riscv-iommu
> >        target/riscv/kvm: set 'aia_mode' to default in error path
> >        target/riscv/kvm: clarify how 'riscv-aia' default works
> >
> > Deepak Gupta (20):
> >        target/riscv: expose *envcfg csr and priv to qemu-user as well
> >        target/riscv: Add zicfilp extension
> >        target/riscv: Introduce elp state and enabling controls for zicf=
ilp
> >        target/riscv: save and restore elp state on priv transitions
> >        target/riscv: additional code information for sw check
> >        target/riscv: tracking indirect branches (fcfi) for zicfilp
> >        target/riscv: zicfilp `lpad` impl and branch tracking
> >        disas/riscv: enable `lpad` disassembly
> >        target/riscv: Expose zicfilp extension as a cpu property
> >        target/riscv: Add zicfiss extension
> >        target/riscv: introduce ssp and enabling controls for zicfiss
> >        target/riscv: tb flag for shadow stack instructions
> >        target/riscv: mmu changes for zicfiss shadow stack protection
> >        target/riscv: AMO operations always raise store/AMO fault
> >        target/riscv: update `decode_save_opc` to store extra word2
> >        target/riscv: implement zicfiss instructions
> >        target/riscv: compressed encodings for sspush and sspopchk
> >        disas/riscv: enable disassembly for zicfiss instructions
> >        disas/riscv: enable disassembly for compressed sspush/sspopchk
> >        target/riscv: Expose zicfiss extension as a cpu property
> >
> > Evgenii Prokopiev (1):
> >        target/riscv/csr.c: Fix an access to VXSAT
> >
> > LIU Zhiwei (2):
> >        target/riscv: Add max32 CPU for RV64 QEMU
> >        tests/avocado: Boot Linux for RV32 cpu on RV64 QEMU
> >
> > Rob Bradford (1):
> >        target/riscv: Set vtype.vill on CPU reset
> >
> > Sergey Makarov (2):
> >        hw/intc: Make zeroth priority register read-only
> >        hw/intc: Don't clear pending bits on IRQ lowering
> >
> > TANG Tiancheng (6):
> >        target/riscv: Add fw_dynamic_info32 for booting RV32 OpenSBI
> >        target/riscv: Adjust PMP size for no-MMU RV64 QEMU running RV32
> >        target/riscv: Correct SXL return value for RV32 in RV64 QEMU
> >        target/riscv: Detect sxl to set bit width for RV32 in RV64
> >        target/riscv: Correct mcause/scause bit width for RV32 in RV64 Q=
EMU
> >        target/riscv: Enable RV32 CPU support in RV64 QEMU
> >
> > Tomasz Jeznach (8):
> >        exec/memtxattr: add process identifier to the transaction attrib=
utes
> >        hw/riscv: add riscv-iommu-bits.h
> >        hw/riscv: add RISC-V IOMMU base emulation
> >        hw/riscv: add riscv-iommu-pci reference device
> >        hw/riscv/virt.c: support for RISC-V IOMMU PCIDevice hotplug
> >        hw/riscv/riscv-iommu: add Address Translation Cache (IOATC)
> >        hw/riscv/riscv-iommu: add ATS support
> >        hw/riscv/riscv-iommu: add DBG support
> >
> > Yong-Xuan Wang (1):
> >        hw/intc/riscv_aplic: Check and update pending when write sourcec=
fg
>
>

