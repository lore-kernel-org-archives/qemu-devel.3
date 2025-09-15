Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B5EECAC597
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 16:06:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyBi7-0008EA-LR; Mon, 15 Sep 2025 12:05:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uyBhu-0007yo-Qd
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 12:05:38 -0400
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uyBhd-0001uE-HJ
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 12:05:29 -0400
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-71d605c6501so30111997b3.3
 for <qemu-devel@nongnu.org>; Mon, 15 Sep 2025 09:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757952310; x=1758557110; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=i1+nafa16EBVNLzxQuQ1M3vX5Ab28TZOAsUJB48AWsk=;
 b=ik2EA561c3aTdTdf0EcIRd9S1KuGP8CVTjp6IVDWYMdqSR0O4TeIaSRv9Su6spq/Kc
 N5qIWqO5i3pX0/uMbUqlsZa8EkISQTz5+AtYaieoHuYv2xAEICwuTlbJbUypT6ToNL91
 OXhsfFr/Xv4dtDI4YddWGygRRt/iuXsnSmhYVSeESEydykFofsh9P4D1xpK8mnZUClI7
 V8x+Jl9OkO7IQBmWAnddxpEi/s6GVcCoITjletuMMrhRhHr4RYKEyD+jRywIT2WR+Fng
 pDOCfiNizavMqu0s+Zm9AWSU3FAYP7+wPGMRouL4hwwbWo/qf1Y2ba3VsVhhHL7wdBlP
 AD+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757952310; x=1758557110;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=i1+nafa16EBVNLzxQuQ1M3vX5Ab28TZOAsUJB48AWsk=;
 b=vUcjl+/0l5WxpAZIjLsJJCN66oZSempiE7z/6MR7B0ACJ66RFa4y8WeieCzkNpymiL
 yi/G6RZC6eQVFLbhX6UCcH3bVAK3lKL766CR2BoRaP+N+uhWGcBSpK/b6pOrlBSGe94i
 YY4FC8J2sh4Nl61HsE6sYVtoRDCavaIXZSHXQEmqgMGnPO6ap8FhWSv1qwgwIdiTFyOT
 S1Srk/yl0uOL1ePULtIt0vyOZGoU6Oi5sQ2EgtRA7l5eajaSoJ847oSMzS0R63QyGahy
 TmDu1rIkJBdI3cQ05abzRpaA5tsIh2DUyysmHfjuInl5YR6YoZ3RD0k0h3sKntlzJGda
 kbxg==
X-Gm-Message-State: AOJu0Yw49IehAdB/Os/PLQSaBMy3yNNMLhLW6DCVdwBh9g0ygfAFfpZe
 Gsawlq6qtH9LEHIDep2s8KP1/aaPsVCotg34P6BjgVATQeJIrGRal9X12DCtdL4zJ2ir3Q8qzX3
 EFjf1OnpdfgBgq1W75bhkR3ZOlFF5YRLjO2Vx9m634A==
X-Gm-Gg: ASbGncteyQBmx5zuZdXGN5MHxM/IcDrbT8t1L22cARJDYXBUT8FTuVYVeeDgnhKesUp
 4UUaq0UsoJBlMDS39JlsQhNVP2+802QhcihwKob44a226akk4PtZKqpGajHqiTZDPVeio7UPDlN
 fXPZ+5P9itT+WOWPVcBu66G9Y/SMwF9W0lulg4z3PzxHXauFYhvCJUjDX7G9Yv5qV03L3fYH7Gx
 qJnYNHYYLWDjc+6eZDAR9fMG3KvAg==
X-Google-Smtp-Source: AGHT+IHZ9sqn2j18TUV/dkuQsXY7X2NYCixT9VUEEPabPgdjp8gXkNQSNbwu+ehBzI5jS83/ouXyVdcBcbw+h+Q15XA=
X-Received: by 2002:a05:690c:3706:b0:722:7d35:e0c2 with SMTP id
 00721157ae682-730626d2dd2mr117174837b3.2.1757952309443; Mon, 15 Sep 2025
 09:05:09 -0700 (PDT)
MIME-Version: 1.0
References: <20250901-virt-v2-1-ac2379402c80@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20250901-virt-v2-1-ac2379402c80@rsg.ci.i.u-tokyo.ac.jp>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 15 Sep 2025 17:04:58 +0100
X-Gm-Features: Ac12FXyAtnCaX5thuSHWlCte6AqnLj_QyD8YAthoo1rEGJQnjRIA4hmVhnsWVFQ
Message-ID: <CAFEAcA9yUd1+TO+CrTo6i3b=BugLsU7E95iW8hnUQiuos1_c5A@mail.gmail.com>
Subject: Re: [PATCH v2] hw/arm/virt: Remove the lower bound of HighMem IO
 Regions
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Eric Auger <eric.auger@redhat.com>, Andrew Jones <ajones@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1134.google.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 TVD_SUBJ_WIPE_DEBT=1.004 autolearn=no autolearn_force=no
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

On Mon, 1 Sept 2025 at 13:00, Akihiko Odaki
<odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>
> Remove the lower bound of the Highmem IO Regions' addresses for the
> latest machine version to increase the chance to fit the regions in the
> PA space.
>
> The lower bound was especially problematic when using virt-install on
> Apple M2. virt-install 5.0.0 adds multiple pcie-root-port devices that
> require sufficient space in the ECAM region. However, the Highmem ECAM
> region did not fit in the limited PA space on the hardware, and the ECAM
> region size was limited to 16 MiB. If virt-install had added more than
> 16 devices to the root bridge, the region overflowed, which prevented
> edk2-stable202505 from scanning PCI devices, including the boot disk,
> causing boot failures.
>
> Ideally, a virtual machine with more than 16 devices added to the root
> bridge should just work so that users and management layers do not have
> to care whether they use constrained hardware.
>
> The base address of the Highmem IO Regions was fixed when commit
> f90747c4e8fb ("hw/arm/virt: GICv3 DT node with one or two redistributor
> regions") added the first Highmem IO Region. Later, commit 957e32cffa57
> ("hw/arm/virt: Dynamic memory map depending on RAM requirements")
> allowed moving the Highmem IO Regions to higher addresses to accommodate
> RAM more than 255 GiB, but the lower bound remained to keep the legacy
> memory map.
>
> Remove the lower bound for the latest machine version to accommodate more
> devices with the root bridge. Keeping the lower bound for the old
> machine versions ensures the compatibility is still maintained.
>
> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> ---

Hi; this fails "make check":

(1) fails the bios-tables-check (likely the golden-reference
files need updating if the memory layout has changed)

acpi-test: Warning! MCFG binary file mismatch. Actual
[aml:/tmp/aml-PD53C3], Expected
[aml:tests/data/acpi/aarch64/virt/MCFG].
See source file tests/qtest/bios-tables-test.c for instructions on how
to update expected files.
acpi-test: Warning! MCFG mismatch. Actual [asl:/tmp/asl-6N53C3.dsl,
aml:/tmp/aml-PD53C3], Expected [asl:/tmp/asl-FF33C3.dsl,
aml:tests/data/acpi/aarch64/virt/MCFG].
acpi-test: Warning! DSDT binary file mismatch. Actual
[aml:/tmp/aml-YK53C3], Expected
[aml:tests/data/acpi/aarch64/virt/DSDT].
See source file tests/qtest/bios-tables-test.c for instructions on how
to update expected files.
acpi-test: Warning! DSDT mismatch. Actual [asl:/tmp/asl-JEN4C3.dsl,
aml:/tmp/aml-YK53C3], Expected [asl:/tmp/asl-3ZF4C3.dsl,
aml:tests/data/acpi/aarch64/virt/DSDT].
**
ERROR:../../tests/qtest/bios-tables-test.c:554:test_acpi_asl:
assertion failed: (all_tables_match)


(2) qos-test now fails with a NULL pointer related problem
when running with a build with the sanitizers enabled:


# Start of e1000e-tests tests
# starting QEMU: exec ./qemu-system-aarch64 -qtest
unix:/tmp/qtest-1298136.sock -qtest-log /dev/null -chardev
socket,path=/tmp/qtest-1298136.qmp,id=char0 -mon
chardev=char0,mode=control -display none -audio none -M virt, -cpu max
-device e1000e,netdev=hs0 -netdev socket,fd=6,id=hs0  -accel qtest
----------------------------------- stderr -----------------------------------
../../tests/qtest/libqos/pci.c:394:15: runtime error: member access
within null pointer of type 'QPCIBus' (aka 'struct QPCIBus')
    #0 0x60d9ef616f23 in qpci_config_writel
/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-clang/../../tests/qtest/libqos/pci.c:394:15
    #1 0x60d9ef615cc6 in qpci_iomap
/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-clang/../../tests/qtest/libqos/pci.c:534:5
    #2 0x60d9ef632504 in e1000e_pci_create
/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-clang/../../tests/qtest/libqos/e1000e.c:189:19
    #3 0x60d9ef61334c in qos_driver_new
/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-clang/../../tests/qtest/libqos/qgraph.c:756:11
    #4 0x60d9ef6145a1 in allocate_objects
/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-clang/../../tests/qtest/libqos/qos_external.c:136:19
    #5 0x60d9ef6c0c3a in qos_allocate_objects
/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-clang/../../tests/qtest/qos-test.c:131:12
    #6 0x60d9ef6c0c3a in run_one_test
/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-clang/../../tests/qtest/qos-test.c:179:11
    #7 0x7753c4e80387
(/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x88387) (BuildId:
1eb6131419edb83b2178b682829a6913cf682d75)
    #8 0x7753c4e802a2
(/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x882a2) (BuildId:
1eb6131419edb83b2178b682829a6913cf682d75)
    #9 0x7753c4e802a2
(/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x882a2) (BuildId:
1eb6131419edb83b2178b682829a6913cf682d75)
    #10 0x7753c4e802a2
(/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x882a2) (BuildId:
1eb6131419edb83b2178b682829a6913cf682d75)
    #11 0x7753c4e802a2
(/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x882a2) (BuildId:
1eb6131419edb83b2178b682829a6913cf682d75)
    #12 0x7753c4e802a2
(/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x882a2) (BuildId:
1eb6131419edb83b2178b682829a6913cf682d75)
    #13 0x7753c4e802a2
(/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x882a2) (BuildId:
1eb6131419edb83b2178b682829a6913cf682d75)
    #14 0x7753c4e802a2
(/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x882a2) (BuildId:
1eb6131419edb83b2178b682829a6913cf682d75)
    #15 0x7753c4e80899 in g_test_run_suite
(/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x88899) (BuildId:
1eb6131419edb83b2178b682829a6913cf682d75)
    #16 0x7753c4e8092f in g_test_run
(/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x8892f) (BuildId:
1eb6131419edb83b2178b682829a6913cf682d75)
    #17 0x60d9ef6be7ae in main
/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-clang/../../tests/qtest/qos-test.c:347:5
    #18 0x7753c4a2a1c9 in __libc_start_call_main
csu/../sysdeps/nptl/libc_start_call_main.h:58:16
    #19 0x7753c4a2a28a in __libc_start_main csu/../csu/libc-start.c:360:3
    #20 0x60d9ef5cb224 in _start
(/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-clang/tests/qtest/qos-test+0x16c224)
(BuildId: 538375f704342381ea206855e1476b3ff0beef38)

SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior
../../tests/qtest/libqos/pci.c:394:15

thanks
-- PMM

