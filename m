Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07C59C7115B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Jun 2025 16:34:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRZG2-0000kl-Uw; Tue, 17 Jun 2025 12:33:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uRZG1-0000kE-9c
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 12:33:57 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uRZFz-0000cS-1v
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 12:33:57 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3a54690d369so6093585f8f.3
 for <qemu-devel@nongnu.org>; Tue, 17 Jun 2025 09:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750178033; x=1750782833; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=7g71wEGz4iCfItRB+5Qq2e0WxZcJFHzJDCahI6238Rg=;
 b=OkU7t5h7VpJxVC8gtDEEUabYFanJcQxf4KZtMEh2Imb4+scoLHMIuEK9ea0AGL/bZh
 SsgVl3Y2/XyJ81P3YAI8uBeM3w032s681mlT76JKhe6pcWJNKkQCQGWyPP7AWFVY0tI2
 4ein5my4B80CAVzceOo/o82bN8LgMp3fR8A6C8FtrVNFh/6h7YBtzK7SH5Dux9NQhGdi
 KTCwPRseY8sGvYp3owIHo8ajSBN9PhpFtnGqdEAokyl/lFoIH8fWamoTyBUXfbSwJo9q
 YMfRBofUoyLfwiPiz4Av1tYUqFyeKKTZyPsbyD0DLsPSJ+2hylvQ7AZ6qvJwN69C7bAA
 XcNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750178033; x=1750782833;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7g71wEGz4iCfItRB+5Qq2e0WxZcJFHzJDCahI6238Rg=;
 b=bYcwu24Nso0lYhdVzirAVMpL7UoGxCBdIsfJfpeXJctcg455v4jwu3X8i39nRC2Y20
 yUwuNq09bvZWG706iLXJObxZfX0ZRC4bRHAdUO/Scza58X3QNDnWPiHjj/zxNRqUwLdb
 HfpOCZuu7MbhVeXfC5Ylzfhca4OGL1Lqm3LIzgcUbztYrHx14884YgbEjcEF2MP9xdt3
 4vggJu9/ExkSbJB1rapMyuh5r7q68vkVp+8oH8vL4XveGIvv+u167KJY3ofixH5sZBvs
 wYxNFYl01MIvs2KTLVHakrUWYECo9vMrUmbcwI9GnY4bVCC0LxQwGsyquO/E+cP+TFrC
 29QQ==
X-Gm-Message-State: AOJu0YzNzXbsJMZpQ/8CPESQAMaeeN0VN0ydFFTmTLlx+KF67JRz5wZ/
 55Gg/aMdesdPBYt6lRvoKTmKHU4suOyDnQQqqkvHtUihwpiYOXq1XfpoMGqfQafpeYQ=
X-Gm-Gg: ASbGncsFdTDNFA1lLemxk/AzQ6DtcV4MtKODISyMGlAaEqT3KxRmB5CQWcO+usJNZR5
 aSjGNmuE1XKHFkHxnk6tM7o5SoxoSeYRqcuj0UeKtSwURz9dhUQHzT3qFfCuTt3grTaSjS/+6ah
 ujWfTfIKyr9NDTgpdhU1qRZL0rSgCA3SIoKLS+U670r9Cne3MW0ntaHnpwhAkHzXv4pY8K7CkYN
 9+iLkwpWAD91BZibmvoiJsmbeCte9bLLPS7FMirEra5YS33EIfhypffnu4VpFOfQlWBddtTnTae
 SOWgv/Y2fpuuh0a722BTawRBo6zVkuvhkycaStRjF15ZcbtkjMURr0N+DgZiZPk=
X-Google-Smtp-Source: AGHT+IGXjDEcTadgL/tfpywilh4gF6w7AoZlWcBsmeY/+2CORMJLZuFGY8Lwl3XURIT66o/5GXOVnQ==
X-Received: by 2002:a05:6000:4021:b0:3a3:6595:9209 with SMTP id
 ffacd0b85a97d-3a5723a3986mr12184278f8f.36.1750178033049; 
 Tue, 17 Jun 2025 09:33:53 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4532e232e4asm178681425e9.11.2025.06.17.09.33.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Jun 2025 09:33:52 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id DB2275F834;
 Tue, 17 Jun 2025 17:33:51 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>, qemu-arm@nongnu.org,
 Mark Burton <mburton@qti.qualcomm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Alexander Graf <graf@amazon.com>,
 kvm@vger.kernel.org, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [RFC PATCH 00/11] kvm/arm: trap-me-harder implementation
Date: Tue, 17 Jun 2025 17:33:40 +0100
Message-ID: <20250617163351.2640572-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The following is an RFC to explore how KVM would look if we forwarded
almost all traps back to QEMU to deal with.

Why - won't it be horribly slow?
--------------------------------

Maybe, that's why its an RFC.

Traditionally KVM tries to avoid full vmexit's to QEMU because the
additional context switches add to the latency of servicing requests.
For things like the GIC where latency really matters the normal KVM
approach is to implement it in the kernel and then just leave QEMU to
handling state saving and migration matters.

Where we have to exit, for example for device emulation, platforms
like VirtIO try really hard minimise the number of times we exit for
any data transfer.

However hypervisors can't virtualise everything and for some QEMU
use-cases you might want to run the full software stack (firmware,
hypervisor et all). This is the idea for the proposed SplitAccel where
EL1/EL0 are run under a hypervisor and EL2+ get run under TCG's
emulation. For this to work QEMU needs to be aware of the whole system
state and have full control over anything that is virtualised by the
hypervisor. We have an initial PoC for SplitAccel that works with
HVF's much simpler programming model.

This series is a precursor to implementing a SplitAccel for KVM and
investigates how hacky it might look.

Kernel
------

For this to work you need a modified kernel. You can find my tree
here:

  https://git.linaro.org/plugins/gitiles/people/alex.bennee/linux/+/refs/heads/kvm/trap-me-harder

I will be posting the kernel patches to LKML in due course but the
changes are pretty simple. We add a new creation flag
(KVM_VM_TYPE_ARM_TRAP_ALL) that when activated implement an
alternative table in KVM's handle_exit() code.

The ESR_ELx_EC_IABT_LOW/ESR_ELx_EC_DABT_LOW exceptions are still
handled by KVM as the kernel general has to deal with paging in the
required memory. I've also left the debug exceptions to be processed
in KVM as the handling of pstate gets tricky and takes care when
re-entering the guest.

Everything else exits with a new exit reason called
KVM_EXIT_ARM_TRAP_HARDER when exposed the ESR_EL1 and a few other
registers so QEMU can deal with things.

QEMU Patches
------------

Patches 1-2 - minor tweaks that make debugging easier
Patch   3   - bring in the uapi headers from Kernel
Patches 4-5 - plumbing in -accel kvm,trap-harder=on
Patches 6-7 - allow creation of an out-of-kernel GIC (kernel-irqchip=off)
Patches 8-11- trap handlers for the kvm_arm_handle_hard_trap path

Testing
-------

Currently I'm testing everything inside an emulated QEMU, so the guest
host is booted with a standard Debian Trixie although I use virtiofsd to
mount my real host home inside the guest hosts home:

  ./qemu-system-aarch64 \
             -machine type=virt,virtualization=on,pflash0=rom,pflash1=efivars,gic-version=max \
             -blockdev node-name=rom,driver=file,filename=(pwd)/pc-bios/edk2-aarch64-code.fd,read-only=true \
             -blockdev node-name=efivars,driver=file,filename=$HOME/images/qemu-arm64-efivars \
             -cpu cortex-a76 \
             -m 8192 \
             -object memory-backend-memfd,id=mem,size=8G,share=on \
             -numa node,memdev=mem \
             -smp 4 \
             -accel tcg \
             -serial mon:stdio \
             -device virtio-net-pci,netdev=unet \
             -netdev user,id=unet,hostfwd=tcp::2222-:22 \
             -device virtio-scsi-pci \
             -device scsi-hd,drive=hd \
             -blockdev driver=raw,node-name=hd,file.driver=host_device,file.filename=/dev/zen-ssd2/trixie-arm64,discard=unmap \
             -kernel /home/alex/lsrc/linux.git/builds/arm64/arch/arm64/boot/Image \
             -append "root=/dev/sda2" \
             -chardev socket,id=vfs,path=/tmp/virtiofsd.sock \
             -device vhost-user-fs-pci,chardev=vfs,tag=home \
             -display none -s -S

Inside the guest host I have built QEMU with:

  ../../configure --disable-docs \
    --enable-debug-info --extra-ldflags=-gsplit-dwarf \
    --disable-tcg --disable-xen --disable-tools \
    --target-list=aarch64-softmmu

  make qemu-system-aarch64 -j(nproc)

Even with a cut down configuration this can take awhile to build under
softmmu emulation!

And finally I can boot my guest image with:

  ./qemu-system-aarch64 \
             -machine type=virt,gic-version=3 \
             -cpu host \
             -smp 1 \
             -accel kvm,kernel-irqchip=off,trap-harder=on \
             -serial mon:stdio \
             -m 4096 \
             -kernel ~/lsrc/linux.git/builds/arm64.initramfs/arch/arm64/boot/Image \
             -append "console=ttyAMA0" \
             -display none -d unimp,trace:kvm_hypercall,trace:kvm_wfx_trap

And you can witness the system slowly booting up. Currently the system
hangs before displaying the login prompt because its not being woken
up from the WFI:

  [    0.315642] Serial: AMBA PL011 UART driver
  [    0.345625] 9000000.pl011: ttyAMA0 at MMIO 0x9000000 (irq = 13, base_baud = 0) is a PL011 rev1
  [    0.348138] printk: console [ttyAMA0] enabled
  Saving 256 bits of creditable seed for next boot
  Starting syslogd: OK
  Starting klogd: OK
  Running sysctl: OK
  Populating /dev using udev: done
  Starting system message bus: done
  Starting network: udhcpc: started, v1.37.0
  kvm_wfx_trap 0: WFI @ 0xffffffc080cf9be4

Next steps
----------

I need to figure out whats going on with the WFI failing. I also
intend to boot up my Aarch64 system and try it out on real hardware.
Then I can start looking into the actual performance and what
bottlenecks this might introduce.

Once Philippe has posted the SplitAccel RFC I can look at what it
would take to integrate this approach so we can boot a full-stack with
EL3/EL2 starting.

Alex Bennée (11):
  target/arm: allow gdb to read ARM_CP_NORAW regs (!upstream)
  target/arm: re-arrange debug_cp_reginfo
  linux-headers: Update to Linux 6.15.1 with trap-mem-harder (WIP)
  kvm: expose a trap-harder option to the command line
  target/arm: enable KVM_VM_TYPE_ARM_TRAP_ALL when asked
  kvm/arm: allow out-of kernel GICv3 to work with KVM
  target/arm: clamp value on icc_bpr_write to account for RES0 fields
  kvm/arm: plumb in a basic trap harder handler
  kvm/arm: implement sysreg trap handler
  kvm/arm: implement a basic hypercall handler
  kvm/arm: implement WFx traps for KVM

 include/standard-headers/linux/virtio_pci.h |   1 +
 include/system/kvm_int.h                    |   4 +
 linux-headers/linux/kvm.h                   |   8 +
 linux-headers/linux/vhost.h                 |   4 +-
 target/arm/kvm_arm.h                        |  17 ++
 target/arm/syndrome.h                       |   4 +
 hw/arm/virt.c                               |  18 +-
 hw/intc/arm_gicv3_common.c                  |   4 -
 hw/intc/arm_gicv3_cpuif.c                   |   5 +-
 target/arm/cpu.c                            |   2 +-
 target/arm/debug_helper.c                   |  12 +-
 target/arm/gdbstub.c                        |   6 +-
 target/arm/helper.c                         |  15 +-
 target/arm/kvm-stub.c                       |   5 +
 target/arm/kvm.c                            | 243 ++++++++++++++++++++
 hw/intc/Kconfig                             |   2 +-
 target/arm/trace-events                     |   4 +
 17 files changed, 334 insertions(+), 20 deletions(-)

-- 
2.47.2


