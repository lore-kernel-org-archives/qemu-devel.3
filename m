Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2892BE77188
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 16:17:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOfgZ-0006pj-CP; Fri, 20 Dec 2024 11:17:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOfgM-0006Zo-UO
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 11:17:02 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOfgH-0007WF-AG
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 11:16:54 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4361fe642ddso21051735e9.2
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2024 08:16:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734711406; x=1735316206; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0l1pn/leJfuTjyFeBOdjM73sd+UGFYplb8vmisyRKS4=;
 b=hkTOtaR4zkTqYOvKyZgQS/MfSI74hwM9p4+zc8OwDrzLAjRC0PyQ6PbEpVm5C1O20v
 v8N3LzznCXCSQJqAePbVvuvDXjLRRoHR9KUJECgmp6UrPXxclmhD8t2Pi9CGIhaJiSFU
 dJzQK/gJhX3ythNYP9ew+C1fM/Ofrl1NdZ1W1lVFAgHC8LpY3hM9m3ApiHK75FXd9Ky6
 qS9Bp3/Bn7cZXEz8VB2CTpp9nYscscNDn6Eu8n59G8nVyJq5BoWYEt8LWV06bCxsMjPP
 vXP776NveRVleKb2qck+0RHWXy2Jj1uU0EwV6CefQnAol3CiZzB4Il7DMppV2tXC1vsL
 wSww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734711406; x=1735316206;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0l1pn/leJfuTjyFeBOdjM73sd+UGFYplb8vmisyRKS4=;
 b=twDqdE3PSz7vtglMFEuzTdaUmfdrJaZXCbbImHc2+Gq9tQ5bLIca3Bu1lrQ3ojiutq
 5Doo7qXycyJo8szvsXFk8I8xRbQIj6Uj1gCR3uTFzhSmJv3V49VQk0xLgAstbWGDsrix
 tvnw+RDXl7b09DKdkdTiGQI5WtrD0u2CVSfAvyGiqXgz3S1JbjzzMzaPkvyumzvqGkQZ
 Jsw+9sjTroUoeOw+pr4GCeA4Y9Z9vADet9g0aqxquz1Ww1InTf7SgiEDPL77NBdSE2cO
 U5zDPbesraSWUJkqfK9ylMDr95p42lpVUv3S3yUYtmvi9rBXdggci4b7SJncdVR0nJN6
 FiAg==
X-Gm-Message-State: AOJu0YwLt/+R6SdZqVXw+bzmMCI63u1AO5Cifiyx3qPmySRZc1q7mQPP
 bRGPFXjWwrVXY08o2S7pk7KAoz4Y7Z7SwEfA0arhtszWOqj4HKiO9NlApoHg0wICGWgLi/oNh7R
 A
X-Gm-Gg: ASbGncvDZ48CRDQwvoL1WnPizQXx/gvl/dMX6NXoXBCO4uzgEaXIo55ZJTyDlrOE7fu
 3dzThI6FnF8/jB/RKWeRDib4aY0pmuxnGfRnh/NXk6TrcQiRUGxTmA64ubMVLtNxi4OEfuk/DWF
 +0XUorH4n32Ld/yGi7AUkiWCW9xvZAd//llIXR8oYpZ1RAS3xPiMIFBpGuJtkSl4dFOyumYFMEA
 Ytqui+ebO6jqnFJFhrCRIqVoIJ0CsAwAxlaPQVf48I9LlhPJ3f9ERwC8zZA4pnyXGJqqnpi/90=
X-Google-Smtp-Source: AGHT+IEV4lP5DXZ4A4sd2bGCGAmK74eUncPouxcL+Qj6CyjpCdU84M4Gvhcrnz1XcVJPjOOLV3Q9YA==
X-Received: by 2002:a05:600c:548e:b0:434:f753:600f with SMTP id
 5b1f17b1804b1-436686473c2mr32457535e9.19.1734711405067; 
 Fri, 20 Dec 2024 08:16:45 -0800 (PST)
Received: from localhost.localdomain ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c828e7asm4355174f8f.21.2024.12.20.08.16.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Dec 2024 08:16:43 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Lei Yang <leiyang@redhat.com>
Subject: [PULL 11/59] include: Rename sysemu/ -> system/
Date: Fri, 20 Dec 2024 17:15:02 +0100
Message-ID: <20241220161551.89317-12-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241220161551.89317-1-philmd@linaro.org>
References: <20241220161551.89317-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Headers in include/sysemu/ are not only related to system
*emulation*, they are also used by virtualization. Rename
as system/ which is clearer.

Files renamed manually then mechanical change using sed tool.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Lei Yang <leiyang@redhat.com>
Message-Id: <20241203172445.28576-1-philmd@linaro.org>
---
 MAINTAINERS                                   | 76 +++++++++----------
 docs/specs/tpm.rst                            |  8 +-
 accel/kvm/kvm-cpus.h                          |  2 +-
 accel/tcg/tcg-accel-ops.h                     |  2 +-
 backends/tpm/tpm_int.h                        |  2 +-
 block/coroutines.h                            |  2 +-
 block/export/virtio-blk-handler.h             |  2 +-
 dump/win_dump.h                               |  2 +-
 hw/acpi/hmat.h                                |  2 +-
 hw/block/dataplane/xen-block.h                |  2 +-
 hw/tpm/tpm_prop.h                             |  2 +-
 hw/tpm/tpm_tis.h                              |  2 +-
 hw/usb/hcd-dwc2.h                             |  2 +-
 hw/usb/hcd-ehci.h                             |  2 +-
 hw/usb/hcd-ohci.h                             |  2 +-
 hw/usb/hcd-xhci.h                             |  2 +-
 hw/vfio/pci.h                                 |  2 +-
 include/exec/ram_addr.h                       |  4 +-
 include/hw/acpi/tpm.h                         |  2 +-
 include/hw/arm/allwinner-a10.h                |  2 +-
 include/hw/arm/allwinner-h3.h                 |  2 +-
 include/hw/arm/allwinner-r40.h                |  2 +-
 include/hw/arm/virt.h                         |  2 +-
 include/hw/boards.h                           |  4 +-
 include/hw/core/sysemu-cpu-ops.h              |  6 +-
 include/hw/dma/xlnx-zdma.h                    |  2 +-
 include/hw/dma/xlnx_dpdma.h                   |  2 +-
 include/hw/hyperv/vmbus.h                     |  4 +-
 include/hw/i386/hostmem-epc.h                 |  2 +-
 include/hw/ide/ide-dev.h                      |  2 +-
 include/hw/isa/superio.h                      |  2 +-
 include/hw/nvram/fw_cfg.h                     |  2 +-
 include/hw/nvram/xlnx-bbram.h                 |  2 +-
 include/hw/nvram/xlnx-efuse.h                 |  2 +-
 include/hw/pci/pci.h                          |  4 +-
 include/hw/ppc/mac_dbdma.h                    |  2 +-
 include/hw/ppc/spapr.h                        |  2 +-
 include/hw/ppc/spapr_drc.h                    |  2 +-
 include/hw/ppc/spapr_vio.h                    |  2 +-
 include/hw/ppc/xive.h                         |  2 +-
 include/hw/riscv/numa.h                       |  2 +-
 include/hw/s390x/css.h                        |  2 +-
 include/hw/s390x/s390-pci-inst.h              |  2 +-
 include/hw/tricore/triboard.h                 |  2 +-
 include/hw/vfio/vfio-common.h                 |  6 +-
 include/hw/virtio/virtio-balloon.h            |  2 +-
 include/hw/virtio/virtio-blk.h                |  6 +-
 include/hw/virtio/virtio-crypto.h             |  4 +-
 include/hw/virtio/virtio-gpu.h                |  2 +-
 include/hw/virtio/virtio-input.h              |  2 +-
 include/hw/virtio/virtio-iommu.h              |  2 +-
 include/hw/virtio/virtio-mem.h                |  2 +-
 include/hw/virtio/virtio-rng.h                |  2 +-
 include/hw/virtio/virtio-scsi.h               |  2 +-
 include/hw/xen/xen-block.h                    |  2 +-
 include/hw/xen/xen-hvm-common.h               |  8 +-
 include/qemu/main-loop.h                      |  2 +-
 include/qemu/osdep.h                          |  8 +-
 include/{sysemu => system}/accel-blocker.h    |  2 +-
 include/{sysemu => system}/accel-ops.h        |  0
 include/{sysemu => system}/arch_init.h        |  0
 include/{sysemu => system}/balloon.h          |  0
 .../{sysemu => system}/block-backend-common.h |  0
 .../block-backend-global-state.h              |  0
 include/{sysemu => system}/block-backend-io.h |  0
 include/{sysemu => system}/block-backend.h    |  0
 .../{sysemu => system}/block-ram-registrar.h  |  0
 include/{sysemu => system}/blockdev.h         |  0
 include/{sysemu => system}/cpu-throttle.h     |  6 +-
 .../{sysemu => system}/cpu-timers-internal.h  |  0
 include/{sysemu => system}/cpu-timers.h       |  6 +-
 include/{sysemu => system}/cpus.h             |  2 +-
 .../{sysemu => system}/cryptodev-vhost-user.h |  2 +-
 include/{sysemu => system}/cryptodev-vhost.h  |  2 +-
 include/{sysemu => system}/cryptodev.h        |  0
 include/{sysemu => system}/device_tree.h      |  0
 include/{sysemu => system}/dirtylimit.h       |  0
 include/{sysemu => system}/dirtyrate.h        |  0
 include/{sysemu => system}/dma.h              |  0
 include/{sysemu => system}/dump-arch.h        |  0
 include/{sysemu => system}/dump.h             |  4 +-
 include/{sysemu => system}/event-loop-base.h  |  0
 .../{sysemu => system}/host_iommu_device.h    |  0
 include/{sysemu => system}/hostmem.h          |  6 +-
 include/{sysemu => system}/hvf.h              |  0
 include/{sysemu => system}/hvf_int.h          |  0
 include/{sysemu => system}/hw_accel.h         |  8 +-
 include/{sysemu => system}/iommufd.h          |  6 +-
 include/{sysemu => system}/iothread.h         |  2 +-
 include/{sysemu => system}/kvm.h              |  0
 include/{sysemu => system}/kvm_int.h          |  2 +-
 include/{sysemu => system}/kvm_xen.h          |  6 +-
 include/{sysemu => system}/memory_mapping.h   |  0
 include/{sysemu => system}/numa.h             |  4 +-
 include/{sysemu => system}/nvmm.h             |  0
 include/{sysemu => system}/os-posix.h         |  0
 include/{sysemu => system}/os-win32.h         |  0
 include/{sysemu => system}/qtest.h            |  0
 include/{sysemu => system}/replay.h           |  4 +-
 include/{sysemu => system}/reset.h            |  4 +-
 include/{sysemu => system}/rng-random.h       |  0
 include/{sysemu => system}/rng.h              |  0
 include/{sysemu => system}/rtc.h              |  4 +-
 include/{sysemu => system}/runstate-action.h  |  0
 include/{sysemu => system}/runstate.h         |  4 +-
 include/{sysemu => system}/seccomp.h          |  0
 include/{sysemu => system}/spdm-socket.h      |  0
 include/{sysemu => system}/stats.h            |  0
 include/{sysemu/sysemu.h => system/system.h}  |  4 +-
 include/{sysemu => system}/tcg.h              |  4 +-
 include/{sysemu => system}/tpm.h              |  0
 include/{sysemu => system}/tpm_backend.h      |  2 +-
 include/{sysemu => system}/tpm_util.h         |  8 +-
 .../{sysemu => system}/vhost-user-backend.h   |  0
 include/{sysemu => system}/watchdog.h         |  0
 include/{sysemu => system}/whpx.h             |  0
 include/{sysemu => system}/xen-mapcache.h     |  2 +-
 include/{sysemu => system}/xen.h              |  6 +-
 migration/dirtyrate.h                         |  2 +-
 migration/migration.h                         |  2 +-
 monitor/monitor-internal.h                    |  2 +-
 nbd/nbd-internal.h                            |  2 +-
 rust/wrapper.h                                |  2 +-
 target/arm/kvm_arm.h                          |  2 +-
 target/i386/cpu-internal.h                    |  2 +-
 target/i386/cpu.h                             |  2 +-
 target/i386/hvf/vmx.h                         |  4 +-
 target/i386/kvm/hyperv.h                      |  2 +-
 target/i386/kvm/kvm_i386.h                    |  2 +-
 target/i386/nvmm/nvmm-accel-ops.h             |  2 +-
 target/i386/whpx/whpx-accel-ops.h             |  2 +-
 target/mips/helper.h                          |  2 +-
 target/ppc/kvm_ppc.h                          |  2 +-
 target/s390x/kvm/pv.h                         |  2 +-
 target/s390x/s390x-internal.h                 |  6 +-
 tests/qtest/tpm-emu.h                         |  2 +-
 ...ysemu_helper.h.inc => system_helper.h.inc} |  2 +-
 accel/accel-blocker.c                         |  2 +-
 accel/accel-system.c                          |  2 +-
 accel/dummy-cpus.c                            |  2 +-
 accel/hvf/hvf-accel-ops.c                     |  8 +-
 accel/hvf/hvf-all.c                           |  4 +-
 accel/kvm/kvm-accel-ops.c                     |  8 +-
 accel/kvm/kvm-all.c                           | 16 ++--
 accel/qtest/qtest.c                           |  4 +-
 accel/stubs/kvm-stub.c                        |  2 +-
 accel/stubs/xen-stub.c                        |  2 +-
 accel/tcg/cpu-exec-common.c                   |  4 +-
 accel/tcg/cpu-exec.c                          |  6 +-
 accel/tcg/icount-common.c                     | 12 +--
 accel/tcg/monitor.c                           |  6 +-
 accel/tcg/tb-maint.c                          |  2 +-
 accel/tcg/tcg-accel-ops-icount.c              |  4 +-
 accel/tcg/tcg-accel-ops-mttcg.c               |  6 +-
 accel/tcg/tcg-accel-ops-rr.c                  |  6 +-
 accel/tcg/tcg-accel-ops.c                     |  6 +-
 accel/tcg/tcg-all.c                           |  4 +-
 accel/tcg/translate-all.c                     |  6 +-
 accel/tcg/watchpoint.c                        |  4 +-
 accel/xen/xen-all.c                           |  6 +-
 audio/audio.c                                 |  6 +-
 backends/cryptodev-builtin.c                  |  2 +-
 backends/cryptodev-lkcf.c                     |  2 +-
 backends/cryptodev-vhost-user.c               |  4 +-
 backends/cryptodev-vhost.c                    |  4 +-
 backends/cryptodev.c                          |  4 +-
 backends/host_iommu_device.c                  |  2 +-
 backends/hostmem-epc.c                        |  2 +-
 backends/hostmem-file.c                       |  2 +-
 backends/hostmem-memfd.c                      |  2 +-
 backends/hostmem-ram.c                        |  2 +-
 backends/hostmem-shm.c                        |  2 +-
 backends/hostmem.c                            |  2 +-
 backends/iommufd.c                            |  2 +-
 backends/rng-builtin.c                        |  4 +-
 backends/rng-egd.c                            |  2 +-
 backends/rng-random.c                         |  4 +-
 backends/rng.c                                |  2 +-
 backends/spdm-socket.c                        |  2 +-
 backends/tpm/tpm_backend.c                    |  4 +-
 backends/tpm/tpm_emulator.c                   |  6 +-
 backends/tpm/tpm_passthrough.c                |  4 +-
 backends/tpm/tpm_util.c                       |  4 +-
 backends/vhost-user.c                         |  4 +-
 block.c                                       |  2 +-
 block/accounting.c                            |  2 +-
 block/backup.c                                |  2 +-
 block/blkdebug.c                              |  2 +-
 block/blkio.c                                 |  2 +-
 block/blkreplay.c                             |  2 +-
 block/block-backend.c                         |  8 +-
 block/block-copy.c                            |  2 +-
 block/block-ram-registrar.c                   |  4 +-
 block/commit.c                                |  2 +-
 block/copy-before-write.c                     |  2 +-
 block/crypto.c                                |  2 +-
 block/export/export.c                         |  4 +-
 block/export/fuse.c                           |  2 +-
 block/io.c                                    |  4 +-
 block/io_uring.c                              |  2 +-
 block/iscsi.c                                 |  4 +-
 block/linux-aio.c                             |  2 +-
 block/mirror.c                                |  2 +-
 block/monitor/block-hmp-cmds.c                |  6 +-
 block/nfs.c                                   |  2 +-
 block/null.c                                  |  2 +-
 block/nvme.c                                  |  4 +-
 block/parallels.c                             |  2 +-
 block/{qapi-sysemu.c => qapi-system.c}        |  4 +-
 block/qapi.c                                  |  2 +-
 block/qcow.c                                  |  2 +-
 block/qcow2-snapshot.c                        |  2 +-
 block/qcow2.c                                 |  2 +-
 block/qed.c                                   |  2 +-
 block/rbd.c                                   |  2 +-
 block/replication.c                           |  2 +-
 block/snapshot-access.c                       |  2 +-
 block/snapshot.c                              |  2 +-
 block/stream.c                                |  2 +-
 block/throttle-groups.c                       |  4 +-
 block/vdi.c                                   |  2 +-
 block/vhdx.c                                  |  2 +-
 block/vmdk.c                                  |  2 +-
 block/vpc.c                                   |  2 +-
 blockdev-nbd.c                                |  4 +-
 blockdev.c                                    | 12 +--
 blockjob.c                                    |  2 +-
 chardev/char-fe.c                             |  2 +-
 chardev/char-mux.c                            |  2 +-
 chardev/char.c                                |  2 +-
 cpu-common.c                                  |  2 +-
 cpu-target.c                                  |  4 +-
 dump/dump.c                                   |  6 +-
 dump/win_dump.c                               |  2 +-
 event-loop-base.c                             |  2 +-
 gdbstub/gdbstub.c                             |  4 +-
 gdbstub/syscalls.c                            |  2 +-
 gdbstub/system.c                              |  6 +-
 hw/9pfs/9p-synth.c                            |  2 +-
 hw/9pfs/virtio-9p-device.c                    |  2 +-
 hw/acpi/aml-build.c                           |  2 +-
 hw/acpi/core.c                                |  2 +-
 hw/acpi/cpu.c                                 |  2 +-
 hw/acpi/erst.c                                |  2 +-
 hw/acpi/generic_event_device.c                |  2 +-
 hw/acpi/hmat.c                                |  2 +-
 hw/acpi/ich9.c                                |  4 +-
 hw/acpi/ich9_tco.c                            |  2 +-
 hw/acpi/piix4.c                               |  6 +-
 hw/acpi/vmgenid.c                             |  2 +-
 hw/arm/allwinner-a10.c                        |  2 +-
 hw/arm/allwinner-h3.c                         |  2 +-
 hw/arm/allwinner-r40.c                        |  2 +-
 hw/arm/armv7m.c                               |  2 +-
 hw/arm/aspeed.c                               |  6 +-
 hw/arm/aspeed_ast10x0.c                       |  2 +-
 hw/arm/aspeed_ast2400.c                       |  2 +-
 hw/arm/aspeed_ast2600.c                       |  2 +-
 hw/arm/aspeed_ast27x0.c                       |  2 +-
 hw/arm/bcm2835_peripherals.c                  |  2 +-
 hw/arm/boot.c                                 | 12 +--
 hw/arm/digic.c                                |  2 +-
 hw/arm/digic_boards.c                         |  2 +-
 hw/arm/exynos4210.c                           |  4 +-
 hw/arm/fby35.c                                |  4 +-
 hw/arm/fsl-imx25.c                            |  2 +-
 hw/arm/fsl-imx31.c                            |  2 +-
 hw/arm/fsl-imx6.c                             |  2 +-
 hw/arm/fsl-imx6ul.c                           |  2 +-
 hw/arm/fsl-imx7.c                             |  2 +-
 hw/arm/highbank.c                             |  4 +-
 hw/arm/imx25_pdk.c                            |  2 +-
 hw/arm/integratorcp.c                         |  4 +-
 hw/arm/kzm.c                                  |  4 +-
 hw/arm/mcimx6ul-evk.c                         |  2 +-
 hw/arm/mcimx7d-sabre.c                        |  2 +-
 hw/arm/microbit.c                             |  2 +-
 hw/arm/mps2-tz.c                              |  4 +-
 hw/arm/mps2.c                                 |  2 +-
 hw/arm/mps3r.c                                |  2 +-
 hw/arm/msf2-soc.c                             |  2 +-
 hw/arm/musca.c                                |  2 +-
 hw/arm/musicpal.c                             |  8 +-
 hw/arm/npcm7xx.c                              |  2 +-
 hw/arm/npcm7xx_boards.c                       |  6 +-
 hw/arm/omap1.c                                | 12 +--
 hw/arm/omap_sx1.c                             |  2 +-
 hw/arm/raspi4b.c                              |  2 +-
 hw/arm/realview.c                             |  2 +-
 hw/arm/sabrelite.c                            |  2 +-
 hw/arm/sbsa-ref.c                             | 10 +--
 hw/arm/stellaris.c                            |  2 +-
 hw/arm/stm32f100_soc.c                        |  2 +-
 hw/arm/stm32f205_soc.c                        |  2 +-
 hw/arm/stm32f405_soc.c                        |  2 +-
 hw/arm/stm32l4x5_soc.c                        |  2 +-
 hw/arm/strongarm.c                            |  4 +-
 hw/arm/versatilepb.c                          |  2 +-
 hw/arm/vexpress.c                             |  4 +-
 hw/arm/virt-acpi-build.c                      |  6 +-
 hw/arm/virt.c                                 | 16 ++--
 hw/arm/xen-pvh.c                              |  2 +-
 hw/arm/xen-stubs.c                            |  2 +-
 hw/arm/xilinx_zynq.c                          |  4 +-
 hw/arm/xlnx-versal-virt.c                     |  2 +-
 hw/arm/xlnx-versal.c                          |  4 +-
 hw/arm/xlnx-zcu102.c                          |  2 +-
 hw/arm/xlnx-zynqmp.c                          |  4 +-
 hw/audio/ac97.c                               |  2 +-
 hw/audio/es1370.c                             |  2 +-
 hw/audio/intel-hda.c                          |  2 +-
 hw/audio/virtio-snd.c                         |  2 +-
 hw/avr/atmega.c                               |  2 +-
 hw/block/block.c                              |  4 +-
 hw/block/dataplane/xen-block.c                |  4 +-
 hw/block/fdc-isa.c                            |  6 +-
 hw/block/fdc.c                                |  6 +-
 hw/block/hd-geometry.c                        |  2 +-
 hw/block/m25p80.c                             |  2 +-
 hw/block/nand.c                               |  2 +-
 hw/block/pflash_cfi01.c                       |  6 +-
 hw/block/pflash_cfi02.c                       |  2 +-
 hw/block/swim.c                               |  2 +-
 hw/block/vhost-user-blk.c                     |  4 +-
 hw/block/virtio-blk.c                         |  8 +-
 hw/block/xen-block.c                          |  6 +-
 hw/char/goldfish_tty.c                        |  2 +-
 hw/char/parallel-isa.c                        |  2 +-
 hw/char/parallel.c                            |  4 +-
 hw/char/riscv_htif.c                          |  4 +-
 hw/char/serial-isa.c                          |  2 +-
 hw/char/serial.c                              |  4 +-
 hw/char/xen_console.c                         |  2 +-
 hw/core/clock.c                               |  2 +-
 hw/core/cpu-common.c                          |  4 +-
 hw/core/{cpu-sysemu.c => cpu-system.c}        |  2 +-
 hw/core/generic-loader.c                      |  4 +-
 hw/core/guest-loader.c                        |  4 +-
 hw/core/loader-fit.c                          |  2 +-
 hw/core/loader.c                              |  6 +-
 hw/core/machine-hmp-cmds.c                    |  2 +-
 hw/core/machine-qmp-cmds.c                    | 10 +--
 hw/core/machine.c                             | 14 ++--
 hw/core/numa.c                                |  6 +-
 hw/core/ptimer.c                              |  4 +-
 hw/core/qdev-properties-system.c              |  4 +-
 hw/core/reset.c                               |  2 +-
 hw/core/sysbus-fdt.c                          |  4 +-
 hw/core/vm-change-state-handler.c             |  2 +-
 hw/cpu/a15mpcore.c                            |  2 +-
 hw/cxl/cxl-host.c                             |  2 +-
 hw/cxl/cxl-mailbox-utils.c                    |  2 +-
 hw/display/cirrus_vga.c                       |  2 +-
 hw/display/qxl-render.c                       |  2 +-
 hw/display/qxl.c                              |  2 +-
 hw/display/ramfb.c                            |  2 +-
 hw/display/vga.c                              |  2 +-
 hw/display/virtio-gpu-gl.c                    |  2 +-
 hw/display/virtio-gpu-udmabuf.c               |  2 +-
 hw/display/virtio-gpu.c                       |  6 +-
 hw/display/xenfb.c                            |  2 +-
 hw/dma/pl330.c                                |  2 +-
 hw/dma/sifive_pdma.c                          |  2 +-
 hw/dma/sparc32_dma.c                          |  2 +-
 hw/dma/xilinx_axidma.c                        |  2 +-
 hw/dma/xlnx-zynq-devcfg.c                     |  2 +-
 hw/dma/xlnx_csu_dma.c                         |  2 +-
 hw/gpio/gpio_pwr.c                            |  2 +-
 hw/hppa/machine.c                             |  8 +-
 hw/hyperv/hv-balloon.c                        |  6 +-
 hw/hyperv/hyperv.c                            |  2 +-
 hw/i386/acpi-build.c                          |  8 +-
 hw/i386/fw_cfg.c                              |  2 +-
 hw/i386/intel_iommu.c                         |  6 +-
 hw/i386/kvm/apic.c                            |  4 +-
 hw/i386/kvm/clock.c                           |  6 +-
 hw/i386/kvm/i8254.c                           |  4 +-
 hw/i386/kvm/i8259.c                           |  2 +-
 hw/i386/kvm/ioapic.c                          |  2 +-
 hw/i386/kvm/xen_evtchn.c                      |  4 +-
 hw/i386/kvm/xen_gnttab.c                      |  4 +-
 hw/i386/kvm/xen_overlay.c                     |  4 +-
 hw/i386/kvm/xen_primary_console.c             |  4 +-
 hw/i386/kvm/xen_xenstore.c                    |  4 +-
 hw/i386/microvm-dt.c                          |  2 +-
 hw/i386/microvm.c                             | 10 +--
 hw/i386/multiboot.c                           |  2 +-
 hw/i386/nitro_enclave.c                       |  2 +-
 hw/i386/pc.c                                  |  8 +-
 hw/i386/pc_piix.c                             |  8 +-
 hw/i386/pc_q35.c                              |  6 +-
 hw/i386/pc_sysfw.c                            |  4 +-
 hw/i386/port92.c                              |  2 +-
 hw/i386/sgx.c                                 |  4 +-
 hw/i386/vapic.c                               | 10 +--
 hw/i386/vmport.c                              |  6 +-
 hw/i386/x86-common.c                          |  6 +-
 hw/i386/x86-cpu.c                             |  6 +-
 hw/i386/x86-iommu.c                           |  2 +-
 hw/i386/x86.c                                 |  4 +-
 hw/i386/xen/xen-pvh.c                         |  2 +-
 hw/i386/xen/xen_platform.c                    |  4 +-
 hw/ide/ahci-allwinner.c                       |  2 +-
 hw/ide/ahci.c                                 |  4 +-
 hw/ide/atapi.c                                |  2 +-
 hw/ide/cmd646.c                               |  4 +-
 hw/ide/core.c                                 | 12 +--
 hw/ide/ich.c                                  |  2 +-
 hw/ide/ide-bus.c                              |  6 +-
 hw/ide/ide-dev.c                              |  6 +-
 hw/ide/isa.c                                  |  2 +-
 hw/ide/macio.c                                |  4 +-
 hw/ide/mmio.c                                 |  2 +-
 hw/ide/pci.c                                  |  2 +-
 hw/ide/via.c                                  |  2 +-
 hw/input/pckbd.c                              |  4 +-
 hw/input/ps2.c                                |  4 +-
 hw/intc/apic.c                                |  2 +-
 hw/intc/apic_common.c                         |  2 +-
 hw/intc/arm_gic.c                             |  4 +-
 hw/intc/arm_gic_common.c                      |  2 +-
 hw/intc/arm_gic_kvm.c                         |  2 +-
 hw/intc/arm_gicv2m.c                          |  2 +-
 hw/intc/arm_gicv3_common.c                    |  2 +-
 hw/intc/arm_gicv3_cpuif.c                     |  4 +-
 hw/intc/arm_gicv3_its_common.c                |  2 +-
 hw/intc/arm_gicv3_its_kvm.c                   |  4 +-
 hw/intc/arm_gicv3_kvm.c                       |  4 +-
 hw/intc/armv7m_nvic.c                         |  4 +-
 hw/intc/ioapic.c                              |  4 +-
 hw/intc/mips_gic.c                            |  4 +-
 hw/intc/openpic_kvm.c                         |  2 +-
 hw/intc/pnv_xive.c                            |  6 +-
 hw/intc/pnv_xive2.c                           |  8 +-
 hw/intc/riscv_aplic.c                         |  4 +-
 hw/intc/riscv_imsic.c                         |  4 +-
 hw/intc/s390_flic_kvm.c                       |  2 +-
 hw/intc/sifive_plic.c                         |  2 +-
 hw/intc/spapr_xive.c                          |  4 +-
 hw/intc/spapr_xive_kvm.c                      |  6 +-
 hw/intc/xics.c                                |  4 +-
 hw/intc/xics_kvm.c                            |  2 +-
 hw/intc/xive.c                                |  6 +-
 hw/intc/xive2.c                               |  4 +-
 hw/ipmi/ipmi.c                                |  2 +-
 hw/ipmi/ipmi_bmc_sim.c                        |  2 +-
 hw/isa/isa-bus.c                              |  2 +-
 hw/isa/isa-superio.c                          |  2 +-
 hw/isa/lpc_ich9.c                             |  4 +-
 hw/isa/piix.c                                 |  2 +-
 hw/loongarch/acpi-build.c                     |  6 +-
 hw/loongarch/boot.c                           |  4 +-
 hw/loongarch/fw_cfg.c                         |  2 +-
 hw/loongarch/virt.c                           | 20 ++---
 hw/m68k/an5206.c                              |  2 +-
 hw/m68k/mcf5206.c                             |  2 +-
 hw/m68k/mcf5208.c                             |  4 +-
 hw/m68k/next-cube.c                           |  4 +-
 hw/m68k/q800.c                                |  8 +-
 hw/m68k/virt.c                                |  8 +-
 hw/mem/cxl_type3.c                            |  4 +-
 hw/mem/memory-device.c                        |  2 +-
 hw/mem/nvdimm.c                               |  2 +-
 hw/mem/pc-dimm.c                              |  4 +-
 hw/mem/sparse-mem.c                           |  2 +-
 hw/microblaze/boot.c                          |  4 +-
 hw/microblaze/petalogix_ml605_mmu.c           |  2 +-
 hw/microblaze/petalogix_s3adsp1800_mmu.c      |  2 +-
 hw/mips/boston.c                              | 10 +--
 hw/mips/cps.c                                 |  4 +-
 hw/mips/fuloong2e.c                           |  6 +-
 hw/mips/jazz.c                                |  6 +-
 hw/mips/loongson3_virt.c                      |  8 +-
 hw/mips/malta.c                               |  8 +-
 hw/mips/mips_int.c                            |  2 +-
 hw/mips/mipssim.c                             |  6 +-
 hw/misc/arm_sysctl.c                          |  2 +-
 hw/misc/bcm2835_powermgt.c                    |  2 +-
 hw/misc/bcm2835_property.c                    |  2 +-
 hw/misc/debugexit.c                           |  2 +-
 hw/misc/exynos4210_pmu.c                      |  2 +-
 hw/misc/imx7_snvs.c                           |  6 +-
 hw/misc/iotkit-sysctl.c                       |  2 +-
 hw/misc/ivshmem.c                             |  4 +-
 hw/misc/lasi.c                                |  4 +-
 hw/misc/mac_via.c                             |  6 +-
 hw/misc/macio/cuda.c                          |  4 +-
 hw/misc/macio/mac_dbdma.c                     |  2 +-
 hw/misc/macio/pmu.c                           |  4 +-
 hw/misc/npcm7xx_clk.c                         |  2 +-
 hw/misc/pci-testdev.c                         |  2 +-
 hw/misc/pvpanic-isa.c                         |  2 +-
 hw/misc/pvpanic-pci.c                         |  2 +-
 hw/misc/pvpanic.c                             |  2 +-
 hw/misc/sbsa_ec.c                             |  2 +-
 hw/misc/sifive_e_aon.c                        |  2 +-
 hw/misc/sifive_test.c                         |  4 +-
 hw/misc/sifive_u_otp.c                        |  4 +-
 hw/misc/slavio_misc.c                         |  2 +-
 hw/misc/virt_ctrl.c                           |  2 +-
 hw/misc/vmcoreinfo.c                          |  2 +-
 hw/misc/zynq_slcr.c                           |  2 +-
 hw/net/allwinner-sun8i-emac.c                 |  2 +-
 hw/net/cadence_gem.c                          |  2 +-
 hw/net/e1000.c                                |  4 +-
 hw/net/e1000e.c                               |  2 +-
 hw/net/e1000e_core.c                          |  2 +-
 hw/net/eepro100.c                             |  6 +-
 hw/net/ftgmac100.c                            |  2 +-
 hw/net/igb.c                                  |  2 +-
 hw/net/igb_core.c                             |  2 +-
 hw/net/imx_fec.c                              |  2 +-
 hw/net/lance.c                                |  2 +-
 hw/net/lasi_i82596.c                          |  2 +-
 hw/net/mv88w8618_eth.c                        |  2 +-
 hw/net/ne2000-isa.c                           |  2 +-
 hw/net/ne2000-pci.c                           |  2 +-
 hw/net/npcm7xx_emc.c                          |  2 +-
 hw/net/npcm_gmac.c                            |  2 +-
 hw/net/pcnet-pci.c                            |  4 +-
 hw/net/rtl8139.c                              |  4 +-
 hw/net/spapr_llan.c                           |  2 +-
 hw/net/sungem.c                               |  2 +-
 hw/net/sunhme.c                               |  2 +-
 hw/net/tulip.c                                |  2 +-
 hw/net/virtio-net.c                           |  6 +-
 hw/net/vmxnet3.c                              |  2 +-
 hw/nvme/ctrl.c                                |  8 +-
 hw/nvme/dif.c                                 |  2 +-
 hw/nvme/ns.c                                  |  4 +-
 hw/nvram/chrp_nvram.c                         |  2 +-
 hw/nvram/eeprom_at24c.c                       |  2 +-
 hw/nvram/fw_cfg.c                             |  6 +-
 hw/nvram/mac_nvram.c                          |  2 +-
 hw/nvram/spapr_nvram.c                        |  8 +-
 hw/nvram/xlnx-bbram.c                         |  2 +-
 hw/nvram/xlnx-efuse.c                         |  2 +-
 hw/openrisc/boot.c                            |  6 +-
 hw/openrisc/cputimer.c                        |  2 +-
 hw/openrisc/openrisc_sim.c                    |  8 +-
 hw/openrisc/virt.c                            |  8 +-
 hw/pci-bridge/pci_expander_bridge.c           |  2 +-
 hw/pci-host/bonito.c                          |  2 +-
 hw/pci-host/pnv_phb.c                         |  2 +-
 hw/pci-host/pnv_phb3.c                        |  2 +-
 hw/pci-host/pnv_phb3_msi.c                    |  2 +-
 hw/pci-host/pnv_phb4_pec.c                    |  2 +-
 hw/pci-host/ppc4xx_pci.c                      |  2 +-
 hw/pci-host/sabre.c                           |  2 +-
 hw/pci/msi.c                                  |  2 +-
 hw/pci/msix.c                                 |  2 +-
 hw/pci/pci.c                                  |  6 +-
 hw/ppc/amigaone.c                             |  4 +-
 hw/ppc/e500.c                                 | 12 +--
 hw/ppc/e500plat.c                             |  4 +-
 hw/ppc/mac_newworld.c                         |  6 +-
 hw/ppc/mac_oldworld.c                         |  6 +-
 hw/ppc/mpc8544_guts.c                         |  2 +-
 hw/ppc/mpc8544ds.c                            |  2 +-
 hw/ppc/pef.c                                  |  2 +-
 hw/ppc/pegasos2.c                             | 10 +--
 hw/ppc/pnv.c                                  | 16 ++--
 hw/ppc/pnv_chiptod.c                          |  2 +-
 hw/ppc/pnv_core.c                             |  2 +-
 hw/ppc/pnv_homer.c                            |  2 +-
 hw/ppc/pnv_i2c.c                              |  2 +-
 hw/ppc/pnv_pnor.c                             |  4 +-
 hw/ppc/pnv_psi.c                              |  2 +-
 hw/ppc/pnv_xscom.c                            |  2 +-
 hw/ppc/ppc.c                                  |  8 +-
 hw/ppc/ppc405_boards.c                        |  6 +-
 hw/ppc/ppc405_uc.c                            |  4 +-
 hw/ppc/ppc440_bamboo.c                        |  8 +-
 hw/ppc/ppc440_uc.c                            |  2 +-
 hw/ppc/ppc_booke.c                            |  4 +-
 hw/ppc/ppce500_spin.c                         |  2 +-
 hw/ppc/prep.c                                 |  4 +-
 hw/ppc/prep_systemio.c                        |  2 +-
 hw/ppc/sam460ex.c                             | 10 +--
 hw/ppc/spapr.c                                | 20 ++---
 hw/ppc/spapr_caps.c                           |  4 +-
 hw/ppc/spapr_cpu_core.c                       | 10 +--
 hw/ppc/spapr_drc.c                            |  4 +-
 hw/ppc/spapr_events.c                         |  4 +-
 hw/ppc/spapr_hcall.c                          |  6 +-
 hw/ppc/spapr_iommu.c                          |  4 +-
 hw/ppc/spapr_irq.c                            |  2 +-
 hw/ppc/spapr_pci.c                            |  8 +-
 hw/ppc/spapr_rng.c                            |  4 +-
 hw/ppc/spapr_rtas.c                           | 12 +--
 hw/ppc/spapr_rtc.c                            |  4 +-
 hw/ppc/spapr_tpm_proxy.c                      |  2 +-
 hw/ppc/spapr_vio.c                            |  4 +-
 hw/ppc/spapr_vof.c                            |  2 +-
 hw/ppc/virtex_ml507.c                         |  6 +-
 hw/ppc/vof.c                                  |  2 +-
 hw/remote/message.c                           |  4 +-
 hw/remote/mpqemu-link.c                       |  2 +-
 hw/remote/proxy.c                             |  2 +-
 hw/remote/remote-obj.c                        |  2 +-
 hw/remote/vfio-user-obj.c                     |  4 +-
 hw/riscv/boot.c                               |  8 +-
 hw/riscv/microchip_pfsoc.c                    |  4 +-
 hw/riscv/numa.c                               |  2 +-
 hw/riscv/opentitan.c                          |  2 +-
 hw/riscv/riscv_hart.c                         |  2 +-
 hw/riscv/shakti_c.c                           |  2 +-
 hw/riscv/sifive_e.c                           |  2 +-
 hw/riscv/sifive_u.c                           |  6 +-
 hw/riscv/spike.c                              |  4 +-
 hw/riscv/virt-acpi-build.c                    |  2 +-
 hw/riscv/virt.c                               | 12 +--
 hw/rtc/allwinner-rtc.c                        |  2 +-
 hw/rtc/aspeed_rtc.c                           |  2 +-
 hw/rtc/ds1338.c                               |  2 +-
 hw/rtc/exynos4210_rtc.c                       |  2 +-
 hw/rtc/goldfish_rtc.c                         |  4 +-
 hw/rtc/ls7a_rtc.c                             |  4 +-
 hw/rtc/m41t80.c                               |  2 +-
 hw/rtc/m48t59.c                               |  8 +-
 hw/rtc/mc146818rtc.c                          | 10 +--
 hw/rtc/pl031.c                                |  4 +-
 hw/rtc/xlnx-zynqmp-rtc.c                      |  4 +-
 hw/rx/rx-gdbsim.c                             |  6 +-
 hw/rx/rx62n.c                                 |  2 +-
 hw/s390x/ipl.c                                |  6 +-
 hw/s390x/s390-ccw.c                           |  2 +-
 hw/s390x/s390-pci-bus.c                       |  4 +-
 hw/s390x/s390-pci-inst.c                      |  2 +-
 hw/s390x/s390-skeys-kvm.c                     |  2 +-
 hw/s390x/s390-skeys.c                         |  4 +-
 hw/s390x/s390-stattrib-kvm.c                  |  2 +-
 hw/s390x/s390-virtio-ccw.c                    |  6 +-
 hw/s390x/sclpcpu.c                            |  2 +-
 hw/s390x/sclpquiesce.c                        |  2 +-
 hw/s390x/tod-kvm.c                            |  2 +-
 hw/s390x/tod-tcg.c                            |  2 +-
 hw/s390x/tod.c                                |  6 +-
 hw/s390x/virtio-ccw.c                         |  4 +-
 hw/scsi/lsi53c895a.c                          |  2 +-
 hw/scsi/megasas.c                             |  6 +-
 hw/scsi/mptendian.c                           |  2 +-
 hw/scsi/mptsas.c                              |  2 +-
 hw/scsi/scsi-bus.c                            | 10 +--
 hw/scsi/scsi-disk.c                           | 10 +--
 hw/scsi/scsi-generic.c                        |  2 +-
 hw/scsi/vhost-scsi.c                          |  2 +-
 hw/scsi/vhost-user-scsi.c                     |  2 +-
 hw/scsi/virtio-scsi-dataplane.c               |  2 +-
 hw/scsi/virtio-scsi.c                         |  4 +-
 hw/sd/allwinner-sdhost.c                      |  4 +-
 hw/sd/bcm2835_sdhost.c                        |  2 +-
 hw/sd/pl181.c                                 |  2 +-
 hw/sd/sd.c                                    |  2 +-
 hw/sd/sdhci.c                                 |  2 +-
 hw/sd/ssi-sd.c                                |  2 +-
 hw/sh4/r2d.c                                  |  6 +-
 hw/sh4/sh7750.c                               |  2 +-
 hw/smbios/smbios.c                            |  2 +-
 hw/smbios/smbios_legacy.c                     |  2 +-
 hw/sparc/leon3.c                              |  6 +-
 hw/sparc/sun4m.c                              |  6 +-
 hw/sparc64/niagara.c                          |  6 +-
 hw/sparc64/sparc64.c                          |  2 +-
 hw/sparc64/sun4u.c                            |  4 +-
 hw/ssi/xilinx_spips.c                         |  2 +-
 hw/timer/a9gtimer.c                           |  2 +-
 hw/timer/pxa2xx_timer.c                       |  4 +-
 hw/tpm/tpm_crb.c                              |  8 +-
 hw/tpm/tpm_ppi.c                              |  2 +-
 hw/tpm/tpm_spapr.c                            |  4 +-
 hw/tpm/tpm_tis_common.c                       |  4 +-
 hw/ufs/lu.c                                   |  2 +-
 hw/usb/bus-stub.c                             |  2 +-
 hw/usb/bus.c                                  |  2 +-
 hw/usb/dev-network.c                          |  2 +-
 hw/usb/dev-storage-classic.c                  |  4 +-
 hw/usb/hcd-ehci.c                             |  2 +-
 hw/usb/hcd-uhci.c                             |  2 +-
 hw/usb/host-libusb.c                          |  4 +-
 hw/usb/libhw.c                                |  2 +-
 hw/usb/redirect.c                             |  4 +-
 hw/vfio/ap.c                                  |  2 +-
 hw/vfio/ccw.c                                 |  2 +-
 hw/vfio/common.c                              |  8 +-
 hw/vfio/container.c                           |  2 +-
 hw/vfio/cpr.c                                 |  2 +-
 hw/vfio/iommufd.c                             |  4 +-
 hw/vfio/migration.c                           |  2 +-
 hw/vfio/pci.c                                 |  6 +-
 hw/vfio/platform.c                            |  4 +-
 hw/vfio/spapr.c                               |  2 +-
 hw/virtio/vdpa-dev.c                          |  4 +-
 hw/virtio/vhost-user-fs.c                     |  2 +-
 hw/virtio/vhost-user-scsi-pci.c               |  2 +-
 hw/virtio/vhost-user.c                        |  6 +-
 hw/virtio/vhost.c                             |  2 +-
 hw/virtio/virtio-balloon.c                    |  2 +-
 hw/virtio/virtio-crypto.c                     |  2 +-
 hw/virtio/virtio-iommu.c                      |  6 +-
 hw/virtio/virtio-mem.c                        |  8 +-
 hw/virtio/virtio-mmio.c                       |  4 +-
 hw/virtio/virtio-pci.c                        |  4 +-
 hw/virtio/virtio-pmem.c                       |  2 +-
 hw/virtio/virtio-rng.c                        |  4 +-
 hw/virtio/virtio.c                            |  4 +-
 hw/watchdog/allwinner-wdt.c                   |  2 +-
 hw/watchdog/cmsdk-apb-watchdog.c              |  2 +-
 hw/watchdog/sbsa_gwdt.c                       |  4 +-
 hw/watchdog/watchdog.c                        |  4 +-
 hw/watchdog/wdt_aspeed.c                      |  2 +-
 hw/watchdog/wdt_diag288.c                     |  4 +-
 hw/watchdog/wdt_i6300esb.c                    |  2 +-
 hw/watchdog/wdt_ib700.c                       |  2 +-
 hw/watchdog/wdt_imx2.c                        |  2 +-
 hw/xen/xen-bus.c                              |  2 +-
 hw/xen/xen-mapcache.c                         |  4 +-
 hw/xen/xen-pvh-common.c                       |  6 +-
 hw/xen/xen_devconfig.c                        |  4 +-
 hw/xenpv/xen_machine_pv.c                     |  4 +-
 hw/xtensa/sim.c                               |  4 +-
 hw/xtensa/virt.c                              |  2 +-
 hw/xtensa/xtfpga.c                            |  8 +-
 iothread.c                                    |  4 +-
 migration/block-dirty-bitmap.c                |  4 +-
 migration/colo.c                              |  6 +-
 migration/cpu-throttle.c                      |  4 +-
 migration/dirtyrate.c                         |  4 +-
 migration/global_state.c                      |  2 +-
 migration/migration-hmp-cmds.c                |  4 +-
 migration/migration.c                         | 14 ++--
 migration/multifd.c                           |  2 +-
 migration/options.c                           |  4 +-
 migration/postcopy-ram.c                      |  2 +-
 migration/ram.c                               |  8 +-
 migration/savevm.c                            | 12 +--
 monitor/fds.c                                 |  2 +-
 monitor/hmp-cmds-target.c                     |  2 +-
 monitor/hmp-cmds.c                            |  2 +-
 monitor/hmp-target.c                          |  2 +-
 monitor/hmp.c                                 |  2 +-
 monitor/monitor.c                             |  2 +-
 monitor/qmp-cmds-control.c                    |  2 +-
 monitor/qmp-cmds.c                            | 10 +--
 net/colo-compare.c                            |  2 +-
 net/dump.c                                    |  2 +-
 net/filter-replay.c                           |  2 +-
 net/hub.c                                     |  2 +-
 net/net.c                                     |  2 +-
 net/slirp.c                                   |  2 +-
 net/tap.c                                     |  2 +-
 os-posix.c                                    |  2 +-
 os-win32.c                                    |  2 +-
 qemu-img.c                                    |  2 +-
 qemu-io-cmds.c                                |  2 +-
 qemu-io.c                                     |  2 +-
 qemu-nbd.c                                    |  4 +-
 replay/replay-audio.c                         |  2 +-
 replay/replay-char.c                          |  2 +-
 replay/replay-debugging.c                     |  4 +-
 replay/replay-events.c                        |  2 +-
 replay/replay-input.c                         |  2 +-
 replay/replay-internal.c                      |  4 +-
 replay/replay-net.c                           |  2 +-
 replay/replay-random.c                        |  2 +-
 replay/replay-snapshot.c                      |  2 +-
 replay/replay-time.c                          |  2 +-
 replay/replay.c                               |  8 +-
 replay/stubs-system.c                         |  2 +-
 stats/stats-qmp-cmds.c                        |  2 +-
 storage-daemon/qemu-storage-daemon.c          |  2 +-
 stubs/blk-commit-all.c                        |  2 +-
 stubs/change-state-handler.c                  |  2 +-
 stubs/cpu-get-clock.c                         |  2 +-
 stubs/cpu-synchronize-state.c                 |  2 +-
 stubs/cpus-virtual-clock.c                    |  2 +-
 stubs/dump.c                                  |  2 +-
 stubs/get-vm-name.c                           |  2 +-
 stubs/icount.c                                |  2 +-
 stubs/qemu-timer-notify-cb.c                  |  2 +-
 stubs/qtest.c                                 |  2 +-
 stubs/replay-mode.c                           |  2 +-
 stubs/replay-tools.c                          |  2 +-
 stubs/runstate-check.c                        |  2 +-
 stubs/vm-stop.c                               |  2 +-
 system/arch_init.c                            |  2 +-
 system/balloon.c                              |  4 +-
 system/bootdevice.c                           |  4 +-
 system/cpu-timers.c                           | 10 +--
 system/cpus.c                                 | 12 +--
 system/device_tree.c                          |  2 +-
 system/dirtylimit.c                           |  6 +-
 system/dma-helpers.c                          |  6 +-
 system/globals.c                              |  4 +-
 system/main.c                                 |  2 +-
 system/memory.c                               |  6 +-
 system/memory_mapping.c                       |  2 +-
 system/physmem.c                              | 18 ++---
 system/qdev-monitor.c                         |  6 +-
 system/qemu-seccomp.c                         |  2 +-
 system/qtest.c                                |  6 +-
 system/rtc.c                                  |  6 +-
 system/runstate-action.c                      |  4 +-
 system/runstate.c                             | 16 ++--
 system/tpm.c                                  |  4 +-
 system/vl.c                                   | 38 +++++-----
 target/alpha/sys_helper.c                     |  4 +-
 target/alpha/translate.c                      |  2 +-
 target/arm/arch_dump.c                        |  2 +-
 target/arm/arm-powerctl.c                     |  2 +-
 target/arm/cpu.c                              |  6 +-
 target/arm/cpu64.c                            |  8 +-
 target/arm/debug_helper.c                     |  2 +-
 target/arm/gdbstub.c                          |  2 +-
 target/arm/helper.c                           |  6 +-
 target/arm/hvf/hvf.c                          | 10 +--
 target/arm/kvm.c                              |  8 +-
 target/arm/machine.c                          |  4 +-
 target/arm/tcg/psci.c                         |  2 +-
 target/hppa/sys_helper.c                      |  4 +-
 target/i386/arch_dump.c                       |  4 +-
 target/i386/arch_memory_mapping.c             |  2 +-
 target/i386/cpu-apic.c                        |  6 +-
 target/i386/{cpu-sysemu.c => cpu-system.c}    |  2 +-
 target/i386/cpu.c                             |  4 +-
 target/i386/helper.c                          |  4 +-
 target/i386/host-cpu.c                        |  2 +-
 target/i386/hvf/hvf-cpu.c                     |  4 +-
 target/i386/hvf/hvf.c                         |  8 +-
 target/i386/hvf/x86_cpuid.c                   |  2 +-
 target/i386/hvf/x86_task.c                    |  2 +-
 target/i386/hvf/x86hvf.c                      |  2 +-
 target/i386/kvm/kvm-cpu.c                     |  2 +-
 target/i386/kvm/kvm.c                         |  8 +-
 target/i386/kvm/xen-emu.c                     |  6 +-
 target/i386/machine.c                         |  6 +-
 target/i386/nvmm/nvmm-accel-ops.c             |  6 +-
 target/i386/nvmm/nvmm-all.c                   |  6 +-
 .../{sev-sysemu-stub.c => sev-system-stub.c}  |  0
 target/i386/sev.c                             |  6 +-
 target/i386/tcg/excp_helper.c                 |  2 +-
 .../i386/tcg/{sysemu => system}/bpt_helper.c  |  2 +-
 .../i386/tcg/{sysemu => system}/excp_helper.c |  2 +-
 .../i386/tcg/{sysemu => system}/fpu_helper.c  |  2 +-
 .../i386/tcg/{sysemu => system}/misc_helper.c |  2 +-
 .../i386/tcg/{sysemu => system}/seg_helper.c  |  2 +-
 .../i386/tcg/{sysemu => system}/smm_helper.c  |  2 +-
 .../i386/tcg/{sysemu => system}/svm_helper.c  |  2 +-
 target/i386/tcg/{sysemu => system}/tcg-cpu.c  |  4 +-
 target/i386/tcg/translate.c                   |  2 +-
 target/i386/whpx/whpx-accel-ops.c             |  6 +-
 target/i386/whpx/whpx-all.c                   |  6 +-
 target/i386/whpx/whpx-apic.c                  |  4 +-
 target/loongarch/arch_dump.c                  |  2 +-
 target/loongarch/cpu.c                        |  8 +-
 target/loongarch/kvm/kvm.c                    |  8 +-
 target/loongarch/machine.c                    |  2 +-
 target/mips/cpu.c                             |  4 +-
 target/mips/kvm.c                             |  6 +-
 target/mips/{sysemu => system}/addr.c         |  0
 target/mips/{sysemu => system}/cp0.c          |  0
 target/mips/{sysemu => system}/cp0_timer.c    |  2 +-
 target/mips/{sysemu => system}/machine.c      |  0
 .../mips/{sysemu => system}/mips-qmp-cmds.c   |  0
 target/mips/{sysemu => system}/physaddr.c     |  0
 .../mips/tcg/{sysemu => system}/cp0_helper.c  |  0
 .../mips/tcg/{sysemu => system}/lcsr_helper.c |  0
 .../mips/tcg/{sysemu => system}/mips-semi.c   |  0
 .../tcg/{sysemu => system}/semihosting-stub.c |  0
 .../tcg/{sysemu => system}/special_helper.c   |  0
 .../mips/tcg/{sysemu => system}/tlb_helper.c  |  0
 target/mips/tcg/translate.c                   |  2 +-
 target/ppc/arch_dump.c                        |  4 +-
 target/ppc/compat.c                           |  6 +-
 target/ppc/cpu.c                              |  2 +-
 target/ppc/cpu_init.c                         |  6 +-
 target/ppc/excp_helper.c                      |  6 +-
 target/ppc/helper_regs.c                      |  4 +-
 target/ppc/kvm.c                              | 14 ++--
 target/ppc/machine.c                          |  6 +-
 target/ppc/mmu-hash32.c                       |  2 +-
 target/ppc/mmu-hash64.c                       |  2 +-
 target/ppc/mmu-radix64.c                      |  2 +-
 target/ppc/mmu_common.c                       |  2 +-
 target/ppc/mmu_helper.c                       |  2 +-
 target/riscv/arch_dump.c                      |  2 +-
 target/riscv/cpu.c                            |  6 +-
 target/riscv/cpu_helper.c                     |  2 +-
 target/riscv/csr.c                            |  2 +-
 target/riscv/debug.c                          |  2 +-
 target/riscv/kvm/kvm-cpu.c                    |  8 +-
 target/riscv/machine.c                        |  4 +-
 target/riscv/pmu.c                            |  4 +-
 target/riscv/riscv-qmp-cmds.c                 |  4 +-
 target/s390x/arch_dump.c                      |  2 +-
 target/s390x/cpu-dump.c                       |  2 +-
 target/s390x/{cpu-sysemu.c => cpu-system.c}   | 18 ++---
 target/s390x/cpu.c                            | 14 ++--
 target/s390x/cpu_models.c                     |  6 +-
 ...pu_models_sysemu.c => cpu_models_system.c} |  4 +-
 target/s390x/diag.c                           |  4 +-
 target/s390x/gdbstub.c                        |  4 +-
 target/s390x/helper.c                         |  6 +-
 target/s390x/interrupt.c                      |  4 +-
 target/s390x/kvm/kvm.c                        | 10 +--
 target/s390x/kvm/pv.c                         |  4 +-
 target/s390x/machine.c                        |  4 +-
 target/s390x/mmu_helper.c                     |  4 +-
 target/s390x/sigp.c                           |  6 +-
 target/s390x/tcg/misc_helper.c                |  4 +-
 target/sh4/helper.c                           |  2 +-
 target/sparc/int32_helper.c                   |  2 +-
 tests/qtest/fuzz/fuzz.c                       |  6 +-
 tests/qtest/vhost-user-test.c                 |  2 +-
 tests/unit/test-bdrv-drain.c                  |  2 +-
 tests/unit/test-bdrv-graph-mod.c              |  2 +-
 tests/unit/test-block-backend.c               |  2 +-
 tests/unit/test-block-iothread.c              |  2 +-
 tests/unit/test-blockjob-txn.c                |  2 +-
 tests/unit/test-blockjob.c                    |  2 +-
 tests/unit/test-char.c                        |  2 +-
 tests/unit/test-image-locking.c               |  2 +-
 tests/unit/test-replication.c                 |  2 +-
 tests/unit/test-seccomp.c                     |  2 +-
 tests/unit/test-throttle.c                    |  2 +-
 tests/unit/test-timed-average.c               |  2 +-
 tests/unit/test-yank.c                        |  2 +-
 ui/curses.c                                   |  2 +-
 ui/dbus-clipboard.c                           |  2 +-
 ui/dbus-listener.c                            |  2 +-
 ui/dbus.c                                     |  2 +-
 ui/egl-helpers.c                              |  2 +-
 ui/gtk-egl.c                                  |  2 +-
 ui/gtk-gl-area.c                              |  2 +-
 ui/gtk.c                                      |  4 +-
 ui/input-barrier.c                            |  2 +-
 ui/input-linux.c                              |  2 +-
 ui/input.c                                    |  6 +-
 ui/sdl2.c                                     |  6 +-
 ui/spice-app.c                                |  2 +-
 ui/spice-core.c                               |  4 +-
 ui/vnc.c                                      |  4 +-
 ui/win32-kbd-hook.c                           |  2 +-
 util/async.c                                  |  2 +-
 util/main-loop.c                              |  4 +-
 util/oslib-posix.c                            |  2 +-
 util/qemu-timer.c                             |  6 +-
 crypto/akcipher-gcrypt.c.inc                  |  2 +-
 crypto/akcipher-nettle.c.inc                  |  2 +-
 block/meson.build                             |  6 +-
 hw/core/meson.build                           |  2 +-
 net/vmnet-common.m                            |  2 +-
 scripts/clean-includes                        |  6 +-
 .../codeconverter/test_regexps.py             |  4 +-
 scripts/coverity-scan/COMPONENTS.md           |  4 +-
 target/i386/meson.build                       |  5 +-
 target/i386/tcg/meson.build                   |  2 +-
 .../i386/tcg/{sysemu => system}/meson.build   |  0
 target/mips/meson.build                       |  2 +-
 target/mips/{sysemu => system}/meson.build    |  0
 target/mips/tcg/meson.build                   |  2 +-
 .../mips/tcg/{sysemu => system}/meson.build   |  0
 target/s390x/meson.build                      |  4 +-
 target/s390x/trace-events                     |  2 +-
 ui/cocoa.m                                    | 10 +--
 965 files changed, 1708 insertions(+), 1707 deletions(-)
 rename include/{sysemu => system}/accel-blocker.h (98%)
 rename include/{sysemu => system}/accel-ops.h (100%)
 rename include/{sysemu => system}/arch_init.h (100%)
 rename include/{sysemu => system}/balloon.h (100%)
 rename include/{sysemu => system}/block-backend-common.h (100%)
 rename include/{sysemu => system}/block-backend-global-state.h (100%)
 rename include/{sysemu => system}/block-backend-io.h (100%)
 rename include/{sysemu => system}/block-backend.h (100%)
 rename include/{sysemu => system}/block-ram-registrar.h (100%)
 rename include/{sysemu => system}/blockdev.h (100%)
 rename include/{sysemu => system}/cpu-throttle.h (95%)
 rename include/{sysemu => system}/cpu-timers-internal.h (100%)
 rename include/{sysemu => system}/cpu-timers.h (96%)
 rename include/{sysemu => system}/cpus.h (97%)
 rename include/{sysemu => system}/cryptodev-vhost-user.h (97%)
 rename include/{sysemu => system}/cryptodev-vhost.h (99%)
 rename include/{sysemu => system}/cryptodev.h (100%)
 rename include/{sysemu => system}/device_tree.h (100%)
 rename include/{sysemu => system}/dirtylimit.h (100%)
 rename include/{sysemu => system}/dirtyrate.h (100%)
 rename include/{sysemu => system}/dma.h (100%)
 rename include/{sysemu => system}/dump-arch.h (100%)
 rename include/{sysemu => system}/dump.h (99%)
 rename include/{sysemu => system}/event-loop-base.h (100%)
 rename include/{sysemu => system}/host_iommu_device.h (100%)
 rename include/{sysemu => system}/hostmem.h (97%)
 rename include/{sysemu => system}/hvf.h (100%)
 rename include/{sysemu => system}/hvf_int.h (100%)
 rename include/{sysemu => system}/hw_accel.h (83%)
 rename include/{sysemu => system}/iommufd.h (96%)
 rename include/{sysemu => system}/iothread.h (97%)
 rename include/{sysemu => system}/kvm.h (100%)
 rename include/{sysemu => system}/kvm_int.h (99%)
 rename include/{sysemu => system}/kvm_xen.h (93%)
 rename include/{sysemu => system}/memory_mapping.h (100%)
 rename include/{sysemu => system}/numa.h (98%)
 rename include/{sysemu => system}/nvmm.h (100%)
 rename include/{sysemu => system}/os-posix.h (100%)
 rename include/{sysemu => system}/os-win32.h (100%)
 rename include/{sysemu => system}/qtest.h (100%)
 rename include/{sysemu => system}/replay.h (99%)
 rename include/{sysemu => system}/reset.h (98%)
 rename include/{sysemu => system}/rng-random.h (100%)
 rename include/{sysemu => system}/rng.h (100%)
 rename include/{sysemu => system}/rtc.h (98%)
 rename include/{sysemu => system}/runstate-action.h (100%)
 rename include/{sysemu => system}/runstate.h (98%)
 rename include/{sysemu => system}/seccomp.h (100%)
 rename include/{sysemu => system}/spdm-socket.h (100%)
 rename include/{sysemu => system}/stats.h (100%)
 rename include/{sysemu/sysemu.h => system/system.h} (99%)
 rename include/{sysemu => system}/tcg.h (88%)
 rename include/{sysemu => system}/tpm.h (100%)
 rename include/{sysemu => system}/tpm_backend.h (99%)
 rename include/{sysemu => system}/tpm_util.h (94%)
 rename include/{sysemu => system}/vhost-user-backend.h (100%)
 rename include/{sysemu => system}/watchdog.h (100%)
 rename include/{sysemu => system}/whpx.h (100%)
 rename include/{sysemu => system}/xen-mapcache.h (98%)
 rename include/{sysemu => system}/xen.h (92%)
 rename target/mips/tcg/{sysemu_helper.h.inc => system_helper.h.inc} (99%)
 rename block/{qapi-sysemu.c => qapi-system.c} (99%)
 rename hw/core/{cpu-sysemu.c => cpu-system.c} (98%)
 rename target/i386/{cpu-sysemu.c => cpu-system.c} (99%)
 rename target/i386/{sev-sysemu-stub.c => sev-system-stub.c} (100%)
 rename target/i386/tcg/{sysemu => system}/bpt_helper.c (99%)
 rename target/i386/tcg/{sysemu => system}/excp_helper.c (99%)
 rename target/i386/tcg/{sysemu => system}/fpu_helper.c (99%)
 rename target/i386/tcg/{sysemu => system}/misc_helper.c (99%)
 rename target/i386/tcg/{sysemu => system}/seg_helper.c (99%)
 rename target/i386/tcg/{sysemu => system}/smm_helper.c (99%)
 rename target/i386/tcg/{sysemu => system}/svm_helper.c (99%)
 rename target/i386/tcg/{sysemu => system}/tcg-cpu.c (96%)
 rename target/mips/{sysemu => system}/addr.c (100%)
 rename target/mips/{sysemu => system}/cp0.c (100%)
 rename target/mips/{sysemu => system}/cp0_timer.c (99%)
 rename target/mips/{sysemu => system}/machine.c (100%)
 rename target/mips/{sysemu => system}/mips-qmp-cmds.c (100%)
 rename target/mips/{sysemu => system}/physaddr.c (100%)
 rename target/mips/tcg/{sysemu => system}/cp0_helper.c (100%)
 rename target/mips/tcg/{sysemu => system}/lcsr_helper.c (100%)
 rename target/mips/tcg/{sysemu => system}/mips-semi.c (100%)
 rename target/mips/tcg/{sysemu => system}/semihosting-stub.c (100%)
 rename target/mips/tcg/{sysemu => system}/special_helper.c (100%)
 rename target/mips/tcg/{sysemu => system}/tlb_helper.c (100%)
 rename target/s390x/{cpu-sysemu.c => cpu-system.c} (96%)
 rename target/s390x/{cpu_models_sysemu.c => cpu_models_system.c} (99%)
 rename target/i386/tcg/{sysemu => system}/meson.build (100%)
 rename target/mips/{sysemu => system}/meson.build (100%)
 rename target/mips/tcg/{sysemu => system}/meson.build (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 430a0f4f8c4..d4bf8162872 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -170,8 +170,8 @@ F: include/exec/helper*.h
 F: include/exec/helper*.h.inc
 F: include/exec/helper-info.c.inc
 F: include/exec/page-protection.h
-F: include/sysemu/cpus.h
-F: include/sysemu/tcg.h
+F: include/system/cpus.h
+F: include/system/tcg.h
 F: include/hw/core/tcg-cpu-ops.h
 F: host/include/*/host/cpuinfo.h
 F: util/cpuinfo-*.c
@@ -434,7 +434,7 @@ F: */*/kvm*
 F: accel/kvm/
 F: accel/stubs/kvm-stub.c
 F: include/hw/kvm/
-F: include/sysemu/kvm*.h
+F: include/system/kvm*.h
 F: scripts/kvm/kvm_flightrecorder
 
 ARM KVM CPUs
@@ -447,7 +447,7 @@ MIPS KVM CPUs
 M: Huacai Chen <chenhuacai@kernel.org>
 S: Odd Fixes
 F: target/mips/kvm*
-F: target/mips/sysemu/
+F: target/mips/system/
 
 PPC KVM CPUs
 M: Nicholas Piggin <npiggin@gmail.com>
@@ -481,7 +481,7 @@ Xen emulation on X86 KVM CPUs
 M: David Woodhouse <dwmw2@infradead.org>
 M: Paul Durrant <paul@xen.org>
 S: Supported
-F: include/sysemu/kvm_xen.h
+F: include/system/kvm_xen.h
 F: target/i386/kvm/xen*
 F: hw/i386/kvm/xen*
 F: tests/avocado/kvm_xen_guest.py
@@ -493,7 +493,7 @@ M: Richard Henderson <richard.henderson@linaro.org>
 R: Paolo Bonzini <pbonzini@redhat.com>
 S: Maintained
 F: include/qemu/accel.h
-F: include/sysemu/accel-*.h
+F: include/system/accel-*.h
 F: include/hw/core/accel-cpu.h
 F: accel/accel-*.c
 F: accel/Makefile.objs
@@ -517,14 +517,14 @@ M: Roman Bolshakov <rbolshakov@ddn.com>
 W: https://wiki.qemu.org/Features/HVF
 S: Maintained
 F: accel/hvf/
-F: include/sysemu/hvf.h
-F: include/sysemu/hvf_int.h
+F: include/system/hvf.h
+F: include/system/hvf_int.h
 
 WHPX CPUs
 M: Sunil Muthuswamy <sunilmut@microsoft.com>
 S: Supported
 F: target/i386/whpx/
-F: include/sysemu/whpx.h
+F: include/system/whpx.h
 
 Guest CPU Cores (Xen)
 ---------------------
@@ -550,8 +550,8 @@ F: hw/i386/xen/
 F: hw/pci-host/xen_igd_pt.c
 F: include/hw/block/dataplane/xen*
 F: include/hw/xen/
-F: include/sysemu/xen.h
-F: include/sysemu/xen-mapcache.h
+F: include/system/xen.h
+F: include/system/xen-mapcache.h
 F: stubs/xen-hw-stub.c
 F: docs/system/arm/xenpvh.rst
 F: docs/system/i386/xenpvh.rst
@@ -561,7 +561,7 @@ Guest CPU Cores (NVMM)
 NetBSD Virtual Machine Monitor (NVMM) CPU support
 M: Reinoud Zandijk <reinoud@netbsd.org>
 S: Maintained
-F: include/sysemu/nvmm.h
+F: include/system/nvmm.h
 F: target/i386/nvmm/
 
 Hosts
@@ -579,7 +579,7 @@ POSIX
 M: Paolo Bonzini <pbonzini@redhat.com>
 S: Maintained
 F: os-posix.c
-F: include/sysemu/os-posix.h
+F: include/system/os-posix.h
 F: util/*posix*.c
 F: include/qemu/*posix*.h
 
@@ -1866,7 +1866,7 @@ R: Yanan Wang <wangyanan55@huawei.com>
 R: Zhao Liu <zhao1.liu@intel.com>
 S: Supported
 F: hw/core/cpu-common.c
-F: hw/core/cpu-sysemu.c
+F: hw/core/cpu-system.c
 F: hw/core/machine-qmp-cmds.c
 F: hw/core/machine.c
 F: hw/core/machine-smp.c
@@ -1879,7 +1879,7 @@ F: qapi/machine-target.json
 F: include/hw/boards.h
 F: include/hw/core/cpu.h
 F: include/hw/cpu/cluster.h
-F: include/sysemu/numa.h
+F: include/system/numa.h
 F: tests/functional/test_cpu_queries.py
 F: tests/functional/test_empty_cpu_model.py
 F: tests/unit/test-smp-parse.c
@@ -2189,9 +2189,9 @@ M: Eric Auger <eric.auger@redhat.com>
 M: Zhenzhong Duan <zhenzhong.duan@intel.com>
 S: Supported
 F: backends/iommufd.c
-F: include/sysemu/iommufd.h
+F: include/system/iommufd.h
 F: backends/host_iommu_device.c
-F: include/sysemu/host_iommu_device.h
+F: include/system/host_iommu_device.h
 F: include/qemu/chardev_open.h
 F: util/chardev_open.c
 F: docs/devel/vfio-iommufd.rst
@@ -2205,7 +2205,7 @@ F: docs/interop/vhost-user.json
 F: docs/interop/vhost-user.rst
 F: contrib/vhost-user-*/
 F: backends/vhost-user.c
-F: include/sysemu/vhost-user-backend.h
+F: include/system/vhost-user-backend.h
 F: subprojects/libvhost-user/
 
 vhost-shadow-virtqueue
@@ -2233,7 +2233,7 @@ F: docs/interop/virtio-balloon-stats.rst
 F: hw/virtio/virtio-balloon*.c
 F: include/hw/virtio/virtio-balloon.h
 F: system/balloon.c
-F: include/sysemu/balloon.h
+F: include/system/balloon.h
 F: tests/qtest/virtio-balloon-test.c
 
 virtio-9p
@@ -2315,7 +2315,7 @@ R: Amit Shah <amit@kernel.org>
 S: Supported
 F: hw/virtio/virtio-rng.c
 F: include/hw/virtio/virtio-rng.h
-F: include/sysemu/rng*.h
+F: include/system/rng*.h
 F: backends/rng*.c
 F: tests/qtest/virtio-rng-test.c
 
@@ -2841,7 +2841,7 @@ F: hw/block/
 F: qapi/block*.json
 F: qapi/transaction.json
 F: include/block/
-F: include/sysemu/block-*.h
+F: include/system/block-*.h
 F: qemu-img*
 F: docs/tools/qemu-img.rst
 F: qemu-io*
@@ -2980,7 +2980,7 @@ M: Alistair Francis <alistair.francis@wdc.com>
 R: David Gibson <david@gibson.dropbear.id.au>
 S: Maintained
 F: system/device_tree.c
-F: include/sysemu/device_tree.h
+F: include/system/device_tree.h
 
 Dump
 S: Supported
@@ -2989,8 +2989,8 @@ F: dump/
 F: hw/misc/vmcoreinfo.c
 F: include/hw/misc/vmcoreinfo.h
 F: include/qemu/win_dump_defs
-F: include/sysemu/dump-arch.h
-F: include/sysemu/dump.h
+F: include/system/dump-arch.h
+F: include/system/dump.h
 F: qapi/dump.json
 F: scripts/dump-guest-memory.py
 F: stubs/dump.c
@@ -3036,7 +3036,7 @@ F: include/exec/memop.h
 F: include/exec/memory.h
 F: include/exec/ram_addr.h
 F: include/exec/ramblock.h
-F: include/sysemu/memory_mapping.h
+F: include/system/memory_mapping.h
 F: system/dma-helpers.c
 F: system/ioport.c
 F: system/memory.c
@@ -3089,8 +3089,8 @@ Main loop
 M: Paolo Bonzini <pbonzini@redhat.com>
 S: Maintained
 F: include/qemu/main-loop.h
-F: include/sysemu/runstate.h
-F: include/sysemu/runstate-action.h
+F: include/system/runstate.h
+F: include/system/runstate-action.h
 F: util/main-loop.c
 F: util/qemu-timer*.c
 F: system/vl.c
@@ -3153,7 +3153,7 @@ M: David Hildenbrand <david@redhat.com>
 M: Igor Mammedov <imammedo@redhat.com>
 S: Maintained
 F: backends/hostmem*.c
-F: include/sysemu/hostmem.h
+F: include/system/hostmem.h
 F: docs/system/vm-templating.rst
 T: git https://gitlab.com/ehabkost/qemu.git machine-next
 
@@ -3161,7 +3161,7 @@ Cryptodev Backends
 M: Gonglei <arei.gonglei@huawei.com>
 M: zhenwei pi <pizhenwei@bytedance.com>
 S: Maintained
-F: include/sysemu/cryptodev*.h
+F: include/system/cryptodev*.h
 F: backends/cryptodev*.c
 F: qapi/cryptodev.json
 
@@ -3310,7 +3310,7 @@ M: Laurent Vivier <lvivier@redhat.com>
 R: Paolo Bonzini <pbonzini@redhat.com>
 S: Maintained
 F: system/qtest.c
-F: include/sysemu/qtest.h
+F: include/system/qtest.h
 F: accel/qtest/
 F: tests/qtest/
 F: docs/devel/qgraph.rst
@@ -3361,7 +3361,7 @@ T: git https://people.debian.org/~sthibault/qemu.git slirp
 
 Stats
 S: Orphan
-F: include/sysemu/stats.h
+F: include/system/stats.h
 F: stats/
 F: qapi/stats.json
 
@@ -3402,7 +3402,7 @@ S: Maintained
 F: system/tpm*
 F: hw/tpm/*
 F: include/hw/acpi/tpm.h
-F: include/sysemu/tpm*
+F: include/system/tpm*
 F: qapi/tpm.json
 F: backends/tpm/
 F: tests/qtest/*tpm*
@@ -3413,7 +3413,7 @@ SPDM
 M: Alistair Francis <alistair.francis@wdc.com>
 S: Maintained
 F: backends/spdm-socket.c
-F: include/sysemu/spdm-socket.h
+F: include/system/spdm-socket.h
 
 Checkpatch
 S: Odd Fixes
@@ -3448,10 +3448,10 @@ Migration dirty limit and dirty page rate
 M: Hyman Huang <yong.huang@smartx.com>
 S: Maintained
 F: system/dirtylimit.c
-F: include/sysemu/dirtylimit.h
+F: include/system/dirtylimit.h
 F: migration/dirtyrate.c
 F: migration/dirtyrate.h
-F: include/sysemu/dirtyrate.h
+F: include/system/dirtyrate.h
 F: docs/devel/migration/dirty-limit.rst
 
 Detached LUKS header
@@ -3479,7 +3479,7 @@ Seccomp
 M: Daniel P. Berrange <berrange@redhat.com>
 S: Odd Fixes
 F: system/qemu-seccomp.c
-F: include/sysemu/seccomp.h
+F: include/system/seccomp.h
 F: tests/unit/test-seccomp.c
 
 Cryptography
@@ -3592,7 +3592,7 @@ F: replay/*
 F: block/blkreplay.c
 F: net/filter-replay.c
 F: include/exec/replay-core.h
-F: include/sysemu/replay.h
+F: include/system/replay.h
 F: docs/devel/replay.rst
 F: docs/system/replay.rst
 F: stubs/replay.c
@@ -3711,7 +3711,7 @@ M: Peter Maydell <peter.maydell@linaro.org>
 S: Maintained
 F: include/hw/resettable.h
 F: include/hw/core/resetcontainer.h
-F: include/sysemu/reset.h
+F: include/system/reset.h
 F: hw/core/reset.c
 F: hw/core/resettable.c
 F: hw/core/resetcontainer.c
diff --git a/docs/specs/tpm.rst b/docs/specs/tpm.rst
index 1ad36ad7099..b630a351b4f 100644
--- a/docs/specs/tpm.rst
+++ b/docs/specs/tpm.rst
@@ -205,8 +205,8 @@ to be used with the passthrough backend or the swtpm backend.
 
 QEMU files related to TPM backends:
  - ``backends/tpm.c``
- - ``include/sysemu/tpm.h``
- - ``include/sysemu/tpm_backend.h``
+ - ``include/system/tpm.h``
+ - ``include/system/tpm_backend.h``
 
 The QEMU TPM passthrough device
 -------------------------------
@@ -240,7 +240,7 @@ PCRs.
 QEMU files related to the TPM passthrough device:
  - ``backends/tpm/tpm_passthrough.c``
  - ``backends/tpm/tpm_util.c``
- - ``include/sysemu/tpm_util.h``
+ - ``include/system/tpm_util.h``
 
 
 Command line to start QEMU with the TPM passthrough device using the host's
@@ -301,7 +301,7 @@ command.
 QEMU files related to the TPM emulator device:
  - ``backends/tpm/tpm_emulator.c``
  - ``backends/tpm/tpm_util.c``
- - ``include/sysemu/tpm_util.h``
+ - ``include/system/tpm_util.h``
 
 The following commands start the swtpm with a UnixIO control channel over
 a socket interface. They do not need to be run as root.
diff --git a/accel/kvm/kvm-cpus.h b/accel/kvm/kvm-cpus.h
index 171b22fd294..b5435286e42 100644
--- a/accel/kvm/kvm-cpus.h
+++ b/accel/kvm/kvm-cpus.h
@@ -10,7 +10,7 @@
 #ifndef KVM_CPUS_H
 #define KVM_CPUS_H
 
-#include "sysemu/cpus.h"
+#include "system/cpus.h"
 
 int kvm_init_vcpu(CPUState *cpu, Error **errp);
 int kvm_cpu_exec(CPUState *cpu);
diff --git a/accel/tcg/tcg-accel-ops.h b/accel/tcg/tcg-accel-ops.h
index 44c4079972a..6feeb3f3e9b 100644
--- a/accel/tcg/tcg-accel-ops.h
+++ b/accel/tcg/tcg-accel-ops.h
@@ -12,7 +12,7 @@
 #ifndef TCG_ACCEL_OPS_H
 #define TCG_ACCEL_OPS_H
 
-#include "sysemu/cpus.h"
+#include "system/cpus.h"
 
 void tcg_cpu_destroy(CPUState *cpu);
 int tcg_cpu_exec(CPUState *cpu);
diff --git a/backends/tpm/tpm_int.h b/backends/tpm/tpm_int.h
index ba6109306e5..2319a1ce0c4 100644
--- a/backends/tpm/tpm_int.h
+++ b/backends/tpm/tpm_int.h
@@ -13,7 +13,7 @@
 #define BACKENDS_TPM_INT_H
 
 #include "qemu/option.h"
-#include "sysemu/tpm.h"
+#include "system/tpm.h"
 
 #define TPM_STANDARD_CMDLINE_OPTS \
     { \
diff --git a/block/coroutines.h b/block/coroutines.h
index f3226682d6c..79e5efbf752 100644
--- a/block/coroutines.h
+++ b/block/coroutines.h
@@ -28,7 +28,7 @@
 #include "block/block_int.h"
 
 /* For blk_bs() in generated block/block-gen.c */
-#include "sysemu/block-backend.h"
+#include "system/block-backend.h"
 
 /*
  * I/O API functions. These functions are thread-safe.
diff --git a/block/export/virtio-blk-handler.h b/block/export/virtio-blk-handler.h
index 150d44cff24..cca1544e9fe 100644
--- a/block/export/virtio-blk-handler.h
+++ b/block/export/virtio-blk-handler.h
@@ -13,7 +13,7 @@
 #ifndef VIRTIO_BLK_HANDLER_H
 #define VIRTIO_BLK_HANDLER_H
 
-#include "sysemu/block-backend.h"
+#include "system/block-backend.h"
 
 #define VIRTIO_BLK_SECTOR_BITS 9
 #define VIRTIO_BLK_SECTOR_SIZE (1ULL << VIRTIO_BLK_SECTOR_BITS)
diff --git a/dump/win_dump.h b/dump/win_dump.h
index c9b49f87dc8..9d6cfa47c56 100644
--- a/dump/win_dump.h
+++ b/dump/win_dump.h
@@ -11,7 +11,7 @@
 #ifndef WIN_DUMP_H
 #define WIN_DUMP_H
 
-#include "sysemu/dump.h"
+#include "system/dump.h"
 
 /* Check Windows dump availability for the current target */
 bool win_dump_available(Error **errp);
diff --git a/hw/acpi/hmat.h b/hw/acpi/hmat.h
index fd989cb6619..362b05e2ddf 100644
--- a/hw/acpi/hmat.h
+++ b/hw/acpi/hmat.h
@@ -28,7 +28,7 @@
 #define HMAT_H
 
 #include "hw/acpi/bios-linker-loader.h"
-#include "sysemu/numa.h"
+#include "system/numa.h"
 
 /*
  * ACPI 6.3: 5.2.27.3 Memory Proximity Domain Attributes Structure,
diff --git a/hw/block/dataplane/xen-block.h b/hw/block/dataplane/xen-block.h
index 7b8e9df09f7..eb70327db38 100644
--- a/hw/block/dataplane/xen-block.h
+++ b/hw/block/dataplane/xen-block.h
@@ -10,7 +10,7 @@
 
 #include "hw/block/block.h"
 #include "hw/xen/xen-bus.h"
-#include "sysemu/iothread.h"
+#include "system/iothread.h"
 
 typedef struct XenBlockDataPlane XenBlockDataPlane;
 
diff --git a/hw/tpm/tpm_prop.h b/hw/tpm/tpm_prop.h
index bbd4225d667..c4df74805a7 100644
--- a/hw/tpm/tpm_prop.h
+++ b/hw/tpm/tpm_prop.h
@@ -22,7 +22,7 @@
 #ifndef HW_TPM_PROP_H
 #define HW_TPM_PROP_H
 
-#include "sysemu/tpm_backend.h"
+#include "system/tpm_backend.h"
 #include "hw/qdev-properties.h"
 
 extern const PropertyInfo qdev_prop_tpm;
diff --git a/hw/tpm/tpm_tis.h b/hw/tpm/tpm_tis.h
index 6f14896b979..184632ff66b 100644
--- a/hw/tpm/tpm_tis.h
+++ b/hw/tpm/tpm_tis.h
@@ -24,7 +24,7 @@
 #ifndef TPM_TPM_TIS_H
 #define TPM_TPM_TIS_H
 
-#include "sysemu/tpm_backend.h"
+#include "system/tpm_backend.h"
 #include "tpm_ppi.h"
 
 #define TPM_TIS_NUM_LOCALITIES      5     /* per spec */
diff --git a/hw/usb/hcd-dwc2.h b/hw/usb/hcd-dwc2.h
index 9c3d88ea14b..2d5a5690fc2 100644
--- a/hw/usb/hcd-dwc2.h
+++ b/hw/usb/hcd-dwc2.h
@@ -23,7 +23,7 @@
 #include "hw/irq.h"
 #include "hw/sysbus.h"
 #include "hw/usb.h"
-#include "sysemu/dma.h"
+#include "system/dma.h"
 #include "qom/object.h"
 
 #define DWC2_MMIO_SIZE      0x11000
diff --git a/hw/usb/hcd-ehci.h b/hw/usb/hcd-ehci.h
index 56a1c09d1f3..ffd6c5108eb 100644
--- a/hw/usb/hcd-ehci.h
+++ b/hw/usb/hcd-ehci.h
@@ -20,7 +20,7 @@
 
 #include "qemu/timer.h"
 #include "hw/usb.h"
-#include "sysemu/dma.h"
+#include "system/dma.h"
 #include "hw/pci/pci_device.h"
 #include "hw/sysbus.h"
 
diff --git a/hw/usb/hcd-ohci.h b/hw/usb/hcd-ohci.h
index e1827227ac3..3cc35a5cdc5 100644
--- a/hw/usb/hcd-ohci.h
+++ b/hw/usb/hcd-ohci.h
@@ -22,7 +22,7 @@
 #define HCD_OHCI_H
 
 #include "hw/sysbus.h"
-#include "sysemu/dma.h"
+#include "system/dma.h"
 #include "hw/usb.h"
 #include "qom/object.h"
 
diff --git a/hw/usb/hcd-xhci.h b/hw/usb/hcd-xhci.h
index fe16d7ad055..9609b835141 100644
--- a/hw/usb/hcd-xhci.h
+++ b/hw/usb/hcd-xhci.h
@@ -25,7 +25,7 @@
 
 #include "hw/usb.h"
 #include "hw/usb/xhci.h"
-#include "sysemu/dma.h"
+#include "system/dma.h"
 
 OBJECT_DECLARE_SIMPLE_TYPE(XHCIState, XHCI)
 
diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index 5ad090a2297..43c166680ab 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -19,7 +19,7 @@
 #include "qemu/queue.h"
 #include "qemu/timer.h"
 #include "qom/object.h"
-#include "sysemu/kvm.h"
+#include "system/kvm.h"
 
 #define PCI_ANY_ID (~0)
 
diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
index 891c44cf2d9..53785cdb87c 100644
--- a/include/exec/ram_addr.h
+++ b/include/exec/ram_addr.h
@@ -21,8 +21,8 @@
 
 #ifndef CONFIG_USER_ONLY
 #include "cpu.h"
-#include "sysemu/xen.h"
-#include "sysemu/tcg.h"
+#include "system/xen.h"
+#include "system/tcg.h"
 #include "exec/ramlist.h"
 #include "exec/ramblock.h"
 #include "exec/exec-all.h"
diff --git a/include/hw/acpi/tpm.h b/include/hw/acpi/tpm.h
index 579c45f5baf..9d0fe6f2f96 100644
--- a/include/hw/acpi/tpm.h
+++ b/include/hw/acpi/tpm.h
@@ -19,7 +19,7 @@
 #include "qemu/units.h"
 #include "hw/registerfields.h"
 #include "hw/acpi/aml-build.h"
-#include "sysemu/tpm.h"
+#include "system/tpm.h"
 
 #ifdef CONFIG_TPM
 
diff --git a/include/hw/arm/allwinner-a10.h b/include/hw/arm/allwinner-a10.h
index e5815b0d12b..445ba1be212 100644
--- a/include/hw/arm/allwinner-a10.h
+++ b/include/hw/arm/allwinner-a10.h
@@ -14,7 +14,7 @@
 #include "hw/i2c/allwinner-i2c.h"
 #include "hw/ssi/allwinner-a10-spi.h"
 #include "hw/watchdog/allwinner-wdt.h"
-#include "sysemu/block-backend.h"
+#include "system/block-backend.h"
 
 #include "target/arm/cpu.h"
 #include "qom/object.h"
diff --git a/include/hw/arm/allwinner-h3.h b/include/hw/arm/allwinner-h3.h
index 24ba4e1bf41..db897c86f0b 100644
--- a/include/hw/arm/allwinner-h3.h
+++ b/include/hw/arm/allwinner-h3.h
@@ -49,7 +49,7 @@
 #include "hw/i2c/allwinner-i2c.h"
 #include "hw/watchdog/allwinner-wdt.h"
 #include "target/arm/cpu.h"
-#include "sysemu/block-backend.h"
+#include "system/block-backend.h"
 
 /**
  * Allwinner H3 device list
diff --git a/include/hw/arm/allwinner-r40.h b/include/hw/arm/allwinner-r40.h
index 614e74b7ed4..f8a0e94251e 100644
--- a/include/hw/arm/allwinner-r40.h
+++ b/include/hw/arm/allwinner-r40.h
@@ -35,7 +35,7 @@
 #include "hw/usb/hcd-ehci.h"
 #include "hw/watchdog/allwinner-wdt.h"
 #include "target/arm/cpu.h"
-#include "sysemu/block-backend.h"
+#include "system/block-backend.h"
 
 enum {
     AW_R40_DEV_SRAM_A1,
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index aca4f8061b1..c8e94e6aedc 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -36,7 +36,7 @@
 #include "hw/arm/boot.h"
 #include "hw/arm/bsa.h"
 #include "hw/block/flash.h"
-#include "sysemu/kvm.h"
+#include "system/kvm.h"
 #include "hw/intc/arm_gicv3_common.h"
 #include "qom/object.h"
 
diff --git a/include/hw/boards.h b/include/hw/boards.h
index 5723ee76bde..2ad711e56db 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -4,8 +4,8 @@
 #define HW_BOARDS_H
 
 #include "exec/memory.h"
-#include "sysemu/hostmem.h"
-#include "sysemu/blockdev.h"
+#include "system/hostmem.h"
+#include "system/blockdev.h"
 #include "qapi/qapi-types-machine.h"
 #include "qemu/module.h"
 #include "qom/object.h"
diff --git a/include/hw/core/sysemu-cpu-ops.h b/include/hw/core/sysemu-cpu-ops.h
index 24d003fe041..0df5b058f50 100644
--- a/include/hw/core/sysemu-cpu-ops.h
+++ b/include/hw/core/sysemu-cpu-ops.h
@@ -7,8 +7,8 @@
  * See the COPYING file in the top-level directory.
  */
 
-#ifndef SYSEMU_CPU_OPS_H
-#define SYSEMU_CPU_OPS_H
+#ifndef SYSTEM_CPU_OPS_H
+#define SYSTEM_CPU_OPS_H
 
 #include "hw/core/cpu.h"
 
@@ -89,4 +89,4 @@ typedef struct SysemuCPUOps {
 
 } SysemuCPUOps;
 
-#endif /* SYSEMU_CPU_OPS_H */
+#endif /* SYSTEM_CPU_OPS_H */
diff --git a/include/hw/dma/xlnx-zdma.h b/include/hw/dma/xlnx-zdma.h
index efc75217d59..9c57c499102 100644
--- a/include/hw/dma/xlnx-zdma.h
+++ b/include/hw/dma/xlnx-zdma.h
@@ -31,7 +31,7 @@
 
 #include "hw/sysbus.h"
 #include "hw/register.h"
-#include "sysemu/dma.h"
+#include "system/dma.h"
 #include "qom/object.h"
 
 #define ZDMA_R_MAX (0x204 / 4)
diff --git a/include/hw/dma/xlnx_dpdma.h b/include/hw/dma/xlnx_dpdma.h
index 40537a848b4..1ec0d265be2 100644
--- a/include/hw/dma/xlnx_dpdma.h
+++ b/include/hw/dma/xlnx_dpdma.h
@@ -27,7 +27,7 @@
 
 #include "hw/sysbus.h"
 #include "ui/console.h"
-#include "sysemu/dma.h"
+#include "system/dma.h"
 #include "qom/object.h"
 
 #define XLNX_DPDMA_REG_ARRAY_SIZE (0x1000 >> 2)
diff --git a/include/hw/hyperv/vmbus.h b/include/hw/hyperv/vmbus.h
index 5c505852f22..06b948bbb08 100644
--- a/include/hw/hyperv/vmbus.h
+++ b/include/hw/hyperv/vmbus.h
@@ -10,8 +10,8 @@
 #ifndef HW_HYPERV_VMBUS_H
 #define HW_HYPERV_VMBUS_H
 
-#include "sysemu/sysemu.h"
-#include "sysemu/dma.h"
+#include "system/system.h"
+#include "system/dma.h"
 #include "hw/qdev-core.h"
 #include "migration/vmstate.h"
 #include "hw/hyperv/vmbus-proto.h"
diff --git a/include/hw/i386/hostmem-epc.h b/include/hw/i386/hostmem-epc.h
index 846c7260854..3988deca854 100644
--- a/include/hw/i386/hostmem-epc.h
+++ b/include/hw/i386/hostmem-epc.h
@@ -12,7 +12,7 @@
 #ifndef QEMU_HOSTMEM_EPC_H
 #define QEMU_HOSTMEM_EPC_H
 
-#include "sysemu/hostmem.h"
+#include "system/hostmem.h"
 
 #define TYPE_MEMORY_BACKEND_EPC "memory-backend-epc"
 
diff --git a/include/hw/ide/ide-dev.h b/include/hw/ide/ide-dev.h
index 9a0d71db4e1..92e88687800 100644
--- a/include/hw/ide/ide-dev.h
+++ b/include/hw/ide/ide-dev.h
@@ -20,7 +20,7 @@
 #ifndef IDE_DEV_H
 #define IDE_DEV_H
 
-#include "sysemu/dma.h"
+#include "system/dma.h"
 #include "hw/qdev-properties.h"
 #include "hw/block/block.h"
 
diff --git a/include/hw/isa/superio.h b/include/hw/isa/superio.h
index 0dc45104d47..14d051348b4 100644
--- a/include/hw/isa/superio.h
+++ b/include/hw/isa/superio.h
@@ -10,7 +10,7 @@
 #ifndef HW_ISA_SUPERIO_H
 #define HW_ISA_SUPERIO_H
 
-#include "sysemu/sysemu.h"
+#include "system/system.h"
 #include "hw/isa/isa.h"
 #include "qom/object.h"
 
diff --git a/include/hw/nvram/fw_cfg.h b/include/hw/nvram/fw_cfg.h
index c60361dc9ee..47578ccc7f2 100644
--- a/include/hw/nvram/fw_cfg.h
+++ b/include/hw/nvram/fw_cfg.h
@@ -4,7 +4,7 @@
 #include "exec/hwaddr.h"
 #include "standard-headers/linux/qemu_fw_cfg.h"
 #include "hw/sysbus.h"
-#include "sysemu/dma.h"
+#include "system/dma.h"
 #include "qom/object.h"
 
 #define TYPE_FW_CFG     "fw_cfg"
diff --git a/include/hw/nvram/xlnx-bbram.h b/include/hw/nvram/xlnx-bbram.h
index bce8e89d905..58acbe9f51b 100644
--- a/include/hw/nvram/xlnx-bbram.h
+++ b/include/hw/nvram/xlnx-bbram.h
@@ -26,7 +26,7 @@
 #ifndef XLNX_BBRAM_H
 #define XLNX_BBRAM_H
 
-#include "sysemu/block-backend.h"
+#include "system/block-backend.h"
 #include "hw/qdev-core.h"
 #include "hw/irq.h"
 #include "hw/sysbus.h"
diff --git a/include/hw/nvram/xlnx-efuse.h b/include/hw/nvram/xlnx-efuse.h
index cff7924106a..ef14fb0528a 100644
--- a/include/hw/nvram/xlnx-efuse.h
+++ b/include/hw/nvram/xlnx-efuse.h
@@ -27,7 +27,7 @@
 #ifndef XLNX_EFUSE_H
 #define XLNX_EFUSE_H
 
-#include "sysemu/block-backend.h"
+#include "system/block-backend.h"
 #include "hw/qdev-core.h"
 
 #define TYPE_XLNX_EFUSE "xlnx-efuse"
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index 603c456c3a8..cefeb388bde 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -2,8 +2,8 @@
 #define QEMU_PCI_H
 
 #include "exec/memory.h"
-#include "sysemu/dma.h"
-#include "sysemu/host_iommu_device.h"
+#include "system/dma.h"
+#include "system/host_iommu_device.h"
 
 /* PCI includes legacy ISA access.  */
 #include "hw/isa/isa.h"
diff --git a/include/hw/ppc/mac_dbdma.h b/include/hw/ppc/mac_dbdma.h
index c774f6bf84f..672c2be4715 100644
--- a/include/hw/ppc/mac_dbdma.h
+++ b/include/hw/ppc/mac_dbdma.h
@@ -25,7 +25,7 @@
 
 #include "exec/memory.h"
 #include "qemu/iov.h"
-#include "sysemu/dma.h"
+#include "system/dma.h"
 #include "hw/sysbus.h"
 #include "qom/object.h"
 
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index af4aa1cb0fb..a6c0547e313 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -2,7 +2,7 @@
 #define HW_SPAPR_H
 
 #include "qemu/units.h"
-#include "sysemu/dma.h"
+#include "system/dma.h"
 #include "hw/boards.h"
 #include "hw/ppc/spapr_drc.h"
 #include "hw/mem/pc-dimm.h"
diff --git a/include/hw/ppc/spapr_drc.h b/include/hw/ppc/spapr_drc.h
index 02a63b36666..9ff42909c93 100644
--- a/include/hw/ppc/spapr_drc.h
+++ b/include/hw/ppc/spapr_drc.h
@@ -15,7 +15,7 @@
 
 #include <libfdt.h>
 #include "qom/object.h"
-#include "sysemu/runstate.h"
+#include "system/runstate.h"
 #include "hw/qdev-core.h"
 #include "qapi/error.h"
 
diff --git a/include/hw/ppc/spapr_vio.h b/include/hw/ppc/spapr_vio.h
index 7eae1a48478..b8de4b06fb1 100644
--- a/include/hw/ppc/spapr_vio.h
+++ b/include/hw/ppc/spapr_vio.h
@@ -23,7 +23,7 @@
  */
 
 #include "hw/ppc/spapr.h"
-#include "sysemu/dma.h"
+#include "system/dma.h"
 #include "hw/irq.h"
 #include "qom/object.h"
 
diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
index ebee9825282..ea5d03a3463 100644
--- a/include/hw/ppc/xive.h
+++ b/include/hw/ppc/xive.h
@@ -140,7 +140,7 @@
 #ifndef PPC_XIVE_H
 #define PPC_XIVE_H
 
-#include "sysemu/kvm.h"
+#include "system/kvm.h"
 #include "hw/sysbus.h"
 #include "hw/ppc/xive_regs.h"
 #include "qom/object.h"
diff --git a/include/hw/riscv/numa.h b/include/hw/riscv/numa.h
index 8f5280211d1..147f01619b9 100644
--- a/include/hw/riscv/numa.h
+++ b/include/hw/riscv/numa.h
@@ -21,7 +21,7 @@
 
 #include "hw/boards.h"
 #include "hw/sysbus.h"
-#include "sysemu/numa.h"
+#include "system/numa.h"
 
 /**
  * riscv_socket_count:
diff --git a/include/hw/s390x/css.h b/include/hw/s390x/css.h
index 8289e458370..cd97e2b7075 100644
--- a/include/hw/s390x/css.h
+++ b/include/hw/s390x/css.h
@@ -15,7 +15,7 @@
 #include "hw/s390x/adapter.h"
 #include "hw/s390x/s390_flic.h"
 #include "hw/s390x/ioinst.h"
-#include "sysemu/kvm.h"
+#include "system/kvm.h"
 #include "target/s390x/cpu-qom.h"
 
 /* Channel subsystem constants. */
diff --git a/include/hw/s390x/s390-pci-inst.h b/include/hw/s390x/s390-pci-inst.h
index a55c448aad2..5cb8da540be 100644
--- a/include/hw/s390x/s390-pci-inst.h
+++ b/include/hw/s390x/s390-pci-inst.h
@@ -15,7 +15,7 @@
 #define HW_S390_PCI_INST_H
 
 #include "s390-pci-bus.h"
-#include "sysemu/dma.h"
+#include "system/dma.h"
 
 /* Load/Store status codes */
 #define ZPCI_PCI_ST_FUNC_NOT_ENABLED        4
diff --git a/include/hw/tricore/triboard.h b/include/hw/tricore/triboard.h
index 4fdd2d7d97b..82504706436 100644
--- a/include/hw/tricore/triboard.h
+++ b/include/hw/tricore/triboard.h
@@ -20,7 +20,7 @@
 
 #include "qapi/error.h"
 #include "hw/boards.h"
-#include "sysemu/sysemu.h"
+#include "system/system.h"
 #include "exec/address-spaces.h"
 #include "qom/object.h"
 
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index e0ce6ec3a9b..d57111843da 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -29,10 +29,10 @@
 #ifdef CONFIG_LINUX
 #include <linux/vfio.h>
 #endif
-#include "sysemu/sysemu.h"
+#include "system/system.h"
 #include "hw/vfio/vfio-container-base.h"
-#include "sysemu/host_iommu_device.h"
-#include "sysemu/iommufd.h"
+#include "system/host_iommu_device.h"
+#include "system/iommufd.h"
 
 #define VFIO_MSG_PREFIX "vfio %s: "
 
diff --git a/include/hw/virtio/virtio-balloon.h b/include/hw/virtio/virtio-balloon.h
index 5139cf8ab68..b12c18a43b6 100644
--- a/include/hw/virtio/virtio-balloon.h
+++ b/include/hw/virtio/virtio-balloon.h
@@ -17,7 +17,7 @@
 
 #include "standard-headers/linux/virtio_balloon.h"
 #include "hw/virtio/virtio.h"
-#include "sysemu/iothread.h"
+#include "system/iothread.h"
 #include "qom/object.h"
 
 #define TYPE_VIRTIO_BALLOON "virtio-balloon-device"
diff --git a/include/hw/virtio/virtio-blk.h b/include/hw/virtio/virtio-blk.h
index 5c14110c4b1..8a16218c409 100644
--- a/include/hw/virtio/virtio-blk.h
+++ b/include/hw/virtio/virtio-blk.h
@@ -17,9 +17,9 @@
 #include "standard-headers/linux/virtio_blk.h"
 #include "hw/virtio/virtio.h"
 #include "hw/block/block.h"
-#include "sysemu/iothread.h"
-#include "sysemu/block-backend.h"
-#include "sysemu/block-ram-registrar.h"
+#include "system/iothread.h"
+#include "system/block-backend.h"
+#include "system/block-ram-registrar.h"
 #include "qom/object.h"
 #include "qapi/qapi-types-virtio.h"
 
diff --git a/include/hw/virtio/virtio-crypto.h b/include/hw/virtio/virtio-crypto.h
index 348749f5d5c..2d56513693e 100644
--- a/include/hw/virtio/virtio-crypto.h
+++ b/include/hw/virtio/virtio-crypto.h
@@ -16,8 +16,8 @@
 
 #include "standard-headers/linux/virtio_crypto.h"
 #include "hw/virtio/virtio.h"
-#include "sysemu/iothread.h"
-#include "sysemu/cryptodev.h"
+#include "system/iothread.h"
+#include "system/cryptodev.h"
 #include "qom/object.h"
 
 
diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
index 8c977beebdc..bd93672185e 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -19,7 +19,7 @@
 #include "ui/console.h"
 #include "hw/virtio/virtio.h"
 #include "qemu/log.h"
-#include "sysemu/vhost-user-backend.h"
+#include "system/vhost-user-backend.h"
 
 #include "standard-headers/linux/virtio_gpu.h"
 #include "standard-headers/linux/virtio_ids.h"
diff --git a/include/hw/virtio/virtio-input.h b/include/hw/virtio/virtio-input.h
index e69c0aeca38..e097b0b5217 100644
--- a/include/hw/virtio/virtio-input.h
+++ b/include/hw/virtio/virtio-input.h
@@ -4,7 +4,7 @@
 #include "hw/virtio/vhost-user.h"
 #include "hw/virtio/vhost-user-base.h"
 #include "ui/input.h"
-#include "sysemu/vhost-user-backend.h"
+#include "system/vhost-user-backend.h"
 
 /* ----------------------------------------------------------------- */
 /* virtio input protocol                                             */
diff --git a/include/hw/virtio/virtio-iommu.h b/include/hw/virtio/virtio-iommu.h
index 7db4210b160..3b86050f2cf 100644
--- a/include/hw/virtio/virtio-iommu.h
+++ b/include/hw/virtio/virtio-iommu.h
@@ -25,7 +25,7 @@
 #include "hw/pci/pci.h"
 #include "qom/object.h"
 #include "qapi/qapi-types-virtio.h"
-#include "sysemu/host_iommu_device.h"
+#include "system/host_iommu_device.h"
 
 #define TYPE_VIRTIO_IOMMU "virtio-iommu-device"
 #define TYPE_VIRTIO_IOMMU_PCI "virtio-iommu-pci"
diff --git a/include/hw/virtio/virtio-mem.h b/include/hw/virtio/virtio-mem.h
index a1af144c284..b23946b770c 100644
--- a/include/hw/virtio/virtio-mem.h
+++ b/include/hw/virtio/virtio-mem.h
@@ -17,7 +17,7 @@
 #include "hw/resettable.h"
 #include "hw/virtio/virtio.h"
 #include "qapi/qapi-types-misc.h"
-#include "sysemu/hostmem.h"
+#include "system/hostmem.h"
 #include "qom/object.h"
 
 #define TYPE_VIRTIO_MEM "virtio-mem"
diff --git a/include/hw/virtio/virtio-rng.h b/include/hw/virtio/virtio-rng.h
index 82734255d99..7e6d27f9f08 100644
--- a/include/hw/virtio/virtio-rng.h
+++ b/include/hw/virtio/virtio-rng.h
@@ -13,7 +13,7 @@
 #define QEMU_VIRTIO_RNG_H
 
 #include "hw/virtio/virtio.h"
-#include "sysemu/rng.h"
+#include "system/rng.h"
 #include "standard-headers/linux/virtio_rng.h"
 #include "qom/object.h"
 
diff --git a/include/hw/virtio/virtio-scsi.h b/include/hw/virtio/virtio-scsi.h
index 7be01059185..be230cd4bfc 100644
--- a/include/hw/virtio/virtio-scsi.h
+++ b/include/hw/virtio/virtio-scsi.h
@@ -22,7 +22,7 @@
 #include "hw/virtio/virtio.h"
 #include "hw/scsi/scsi.h"
 #include "chardev/char-fe.h"
-#include "sysemu/iothread.h"
+#include "system/iothread.h"
 
 #define TYPE_VIRTIO_SCSI_COMMON "virtio-scsi-common"
 OBJECT_DECLARE_SIMPLE_TYPE(VirtIOSCSICommon, VIRTIO_SCSI_COMMON)
diff --git a/include/hw/xen/xen-block.h b/include/hw/xen/xen-block.h
index d692ea75802..449a7f75fb5 100644
--- a/include/hw/xen/xen-block.h
+++ b/include/hw/xen/xen-block.h
@@ -11,7 +11,7 @@
 #include "hw/xen/xen-bus.h"
 #include "hw/block/block.h"
 #include "hw/block/dataplane/xen-block.h"
-#include "sysemu/iothread.h"
+#include "system/iothread.h"
 #include "qom/object.h"
 
 typedef enum XenBlockVdevType {
diff --git a/include/hw/xen/xen-hvm-common.h b/include/hw/xen/xen-hvm-common.h
index 0f586c43847..c1ea2c0d787 100644
--- a/include/hw/xen/xen-hvm-common.h
+++ b/include/hw/xen/xen-hvm-common.h
@@ -8,10 +8,10 @@
 #include "hw/hw.h"
 #include "hw/xen/xen_native.h"
 #include "hw/xen/xen-legacy-backend.h"
-#include "sysemu/runstate.h"
-#include "sysemu/sysemu.h"
-#include "sysemu/xen.h"
-#include "sysemu/xen-mapcache.h"
+#include "system/runstate.h"
+#include "system/system.h"
+#include "system/xen.h"
+#include "system/xen-mapcache.h"
 #include "qemu/error-report.h"
 #include <xen/hvm/ioreq.h>
 
diff --git a/include/qemu/main-loop.h b/include/qemu/main-loop.h
index 646306c272f..2d71f24cb3a 100644
--- a/include/qemu/main-loop.h
+++ b/include/qemu/main-loop.h
@@ -27,7 +27,7 @@
 
 #include "block/aio.h"
 #include "qom/object.h"
-#include "sysemu/event-loop-base.h"
+#include "system/event-loop-base.h"
 
 #define SIG_IPI SIGUSR1
 
diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index fdff07fd992..b94fb5fab8c 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -8,7 +8,7 @@
  * To avoid getting into possible circular include dependencies, this
  * file should not include any other QEMU headers, with the exceptions
  * of config-host.h, config-target.h, qemu/compiler.h,
- * sysemu/os-posix.h, sysemu/os-win32.h, glib-compat.h and
+ * system/os-posix.h, system/os-win32.h, glib-compat.h and
  * qemu/typedefs.h, all of which are doing a similar job to this file
  * and are under similar constraints.
  *
@@ -128,7 +128,7 @@ QEMU_EXTERN_C int daemon(int, int);
 #include <sys/stat.h>
 #include <sys/time.h>
 #include <assert.h>
-/* setjmp must be declared before sysemu/os-win32.h
+/* setjmp must be declared before system/os-win32.h
  * because it is redefined there. */
 #include <setjmp.h>
 #include <signal.h>
@@ -161,11 +161,11 @@ QEMU_EXTERN_C int daemon(int, int);
 #include "glib-compat.h"
 
 #ifdef _WIN32
-#include "sysemu/os-win32.h"
+#include "system/os-win32.h"
 #endif
 
 #ifdef CONFIG_POSIX
-#include "sysemu/os-posix.h"
+#include "system/os-posix.h"
 #endif
 
 #ifdef __cplusplus
diff --git a/include/sysemu/accel-blocker.h b/include/system/accel-blocker.h
similarity index 98%
rename from include/sysemu/accel-blocker.h
rename to include/system/accel-blocker.h
index f07f3683585..e10099d6a9a 100644
--- a/include/sysemu/accel-blocker.h
+++ b/include/system/accel-blocker.h
@@ -14,7 +14,7 @@
 #ifndef ACCEL_BLOCKER_H
 #define ACCEL_BLOCKER_H
 
-#include "sysemu/cpus.h"
+#include "system/cpus.h"
 
 void accel_blocker_init(void);
 
diff --git a/include/sysemu/accel-ops.h b/include/system/accel-ops.h
similarity index 100%
rename from include/sysemu/accel-ops.h
rename to include/system/accel-ops.h
diff --git a/include/sysemu/arch_init.h b/include/system/arch_init.h
similarity index 100%
rename from include/sysemu/arch_init.h
rename to include/system/arch_init.h
diff --git a/include/sysemu/balloon.h b/include/system/balloon.h
similarity index 100%
rename from include/sysemu/balloon.h
rename to include/system/balloon.h
diff --git a/include/sysemu/block-backend-common.h b/include/system/block-backend-common.h
similarity index 100%
rename from include/sysemu/block-backend-common.h
rename to include/system/block-backend-common.h
diff --git a/include/sysemu/block-backend-global-state.h b/include/system/block-backend-global-state.h
similarity index 100%
rename from include/sysemu/block-backend-global-state.h
rename to include/system/block-backend-global-state.h
diff --git a/include/sysemu/block-backend-io.h b/include/system/block-backend-io.h
similarity index 100%
rename from include/sysemu/block-backend-io.h
rename to include/system/block-backend-io.h
diff --git a/include/sysemu/block-backend.h b/include/system/block-backend.h
similarity index 100%
rename from include/sysemu/block-backend.h
rename to include/system/block-backend.h
diff --git a/include/sysemu/block-ram-registrar.h b/include/system/block-ram-registrar.h
similarity index 100%
rename from include/sysemu/block-ram-registrar.h
rename to include/system/block-ram-registrar.h
diff --git a/include/sysemu/blockdev.h b/include/system/blockdev.h
similarity index 100%
rename from include/sysemu/blockdev.h
rename to include/system/blockdev.h
diff --git a/include/sysemu/cpu-throttle.h b/include/system/cpu-throttle.h
similarity index 95%
rename from include/sysemu/cpu-throttle.h
rename to include/system/cpu-throttle.h
index 420702b8d32..44bf6a53893 100644
--- a/include/sysemu/cpu-throttle.h
+++ b/include/system/cpu-throttle.h
@@ -16,8 +16,8 @@
  * <http://www.gnu.org/licenses/gpl-2.0.html>
  */
 
-#ifndef SYSEMU_CPU_THROTTLE_H
-#define SYSEMU_CPU_THROTTLE_H
+#ifndef SYSTEM_CPU_THROTTLE_H
+#define SYSTEM_CPU_THROTTLE_H
 
 #include "qemu/timer.h"
 
@@ -79,4 +79,4 @@ void cpu_throttle_dirty_sync_timer_tick(void *opaque);
  */
 void cpu_throttle_dirty_sync_timer(bool enable);
 
-#endif /* SYSEMU_CPU_THROTTLE_H */
+#endif /* SYSTEM_CPU_THROTTLE_H */
diff --git a/include/sysemu/cpu-timers-internal.h b/include/system/cpu-timers-internal.h
similarity index 100%
rename from include/sysemu/cpu-timers-internal.h
rename to include/system/cpu-timers-internal.h
diff --git a/include/sysemu/cpu-timers.h b/include/system/cpu-timers.h
similarity index 96%
rename from include/sysemu/cpu-timers.h
rename to include/system/cpu-timers.h
index 7bfa960fbd6..64ae54f6d6c 100644
--- a/include/sysemu/cpu-timers.h
+++ b/include/system/cpu-timers.h
@@ -7,8 +7,8 @@
  * See the COPYING file in the top-level directory.
  *
  */
-#ifndef SYSEMU_CPU_TIMERS_H
-#define SYSEMU_CPU_TIMERS_H
+#ifndef SYSTEM_CPU_TIMERS_H
+#define SYSTEM_CPU_TIMERS_H
 
 #include "qemu/timer.h"
 
@@ -101,4 +101,4 @@ int64_t cpus_get_virtual_clock(void);
 void cpus_set_virtual_clock(int64_t new_time);
 int64_t cpus_get_elapsed_ticks(void);
 
-#endif /* SYSEMU_CPU_TIMERS_H */
+#endif /* SYSTEM_CPU_TIMERS_H */
diff --git a/include/sysemu/cpus.h b/include/system/cpus.h
similarity index 97%
rename from include/sysemu/cpus.h
rename to include/system/cpus.h
index b4a566cfe75..3d8fd368f32 100644
--- a/include/sysemu/cpus.h
+++ b/include/system/cpus.h
@@ -1,7 +1,7 @@
 #ifndef QEMU_CPUS_H
 #define QEMU_CPUS_H
 
-#include "sysemu/accel-ops.h"
+#include "system/accel-ops.h"
 
 /* register accel-specific operations */
 void cpus_register_accel(const AccelOpsClass *i);
diff --git a/include/sysemu/cryptodev-vhost-user.h b/include/system/cryptodev-vhost-user.h
similarity index 97%
rename from include/sysemu/cryptodev-vhost-user.h
rename to include/system/cryptodev-vhost-user.h
index 60710502c2d..5138c146fa2 100644
--- a/include/sysemu/cryptodev-vhost-user.h
+++ b/include/system/cryptodev-vhost-user.h
@@ -24,7 +24,7 @@
 #ifndef CRYPTODEV_VHOST_USER_H
 #define CRYPTODEV_VHOST_USER_H
 
-#include "sysemu/cryptodev-vhost.h"
+#include "system/cryptodev-vhost.h"
 
 #define VHOST_USER_MAX_AUTH_KEY_LEN    512
 #define VHOST_USER_MAX_CIPHER_KEY_LEN  64
diff --git a/include/sysemu/cryptodev-vhost.h b/include/system/cryptodev-vhost.h
similarity index 99%
rename from include/sysemu/cryptodev-vhost.h
rename to include/system/cryptodev-vhost.h
index 4c3c22acae5..b0bb09e70a3 100644
--- a/include/sysemu/cryptodev-vhost.h
+++ b/include/system/cryptodev-vhost.h
@@ -28,7 +28,7 @@
 #include "hw/virtio/vhost-backend.h"
 #include "chardev/char.h"
 
-#include "sysemu/cryptodev.h"
+#include "system/cryptodev.h"
 
 
 typedef struct CryptoDevBackendVhostOptions {
diff --git a/include/sysemu/cryptodev.h b/include/system/cryptodev.h
similarity index 100%
rename from include/sysemu/cryptodev.h
rename to include/system/cryptodev.h
diff --git a/include/sysemu/device_tree.h b/include/system/device_tree.h
similarity index 100%
rename from include/sysemu/device_tree.h
rename to include/system/device_tree.h
diff --git a/include/sysemu/dirtylimit.h b/include/system/dirtylimit.h
similarity index 100%
rename from include/sysemu/dirtylimit.h
rename to include/system/dirtylimit.h
diff --git a/include/sysemu/dirtyrate.h b/include/system/dirtyrate.h
similarity index 100%
rename from include/sysemu/dirtyrate.h
rename to include/system/dirtyrate.h
diff --git a/include/sysemu/dma.h b/include/system/dma.h
similarity index 100%
rename from include/sysemu/dma.h
rename to include/system/dma.h
diff --git a/include/sysemu/dump-arch.h b/include/system/dump-arch.h
similarity index 100%
rename from include/sysemu/dump-arch.h
rename to include/system/dump-arch.h
diff --git a/include/sysemu/dump.h b/include/system/dump.h
similarity index 99%
rename from include/sysemu/dump.h
rename to include/system/dump.h
index d702854853f..607bd7b220e 100644
--- a/include/sysemu/dump.h
+++ b/include/system/dump.h
@@ -39,8 +39,8 @@
 #define DUMP_LEVEL                  (1)
 #define DISKDUMP_HEADER_BLOCKS      (1)
 
-#include "sysemu/dump-arch.h"
-#include "sysemu/memory_mapping.h"
+#include "system/dump-arch.h"
+#include "system/memory_mapping.h"
 
 typedef struct QEMU_PACKED MakedumpfileHeader {
     char signature[16];     /* = "makedumpfile" */
diff --git a/include/sysemu/event-loop-base.h b/include/system/event-loop-base.h
similarity index 100%
rename from include/sysemu/event-loop-base.h
rename to include/system/event-loop-base.h
diff --git a/include/sysemu/host_iommu_device.h b/include/system/host_iommu_device.h
similarity index 100%
rename from include/sysemu/host_iommu_device.h
rename to include/system/host_iommu_device.h
diff --git a/include/sysemu/hostmem.h b/include/system/hostmem.h
similarity index 97%
rename from include/sysemu/hostmem.h
rename to include/system/hostmem.h
index 67f45abe392..5c21ca55c01 100644
--- a/include/sysemu/hostmem.h
+++ b/include/system/hostmem.h
@@ -10,10 +10,10 @@
  * See the COPYING file in the top-level directory.
  */
 
-#ifndef SYSEMU_HOSTMEM_H
-#define SYSEMU_HOSTMEM_H
+#ifndef SYSTEM_HOSTMEM_H
+#define SYSTEM_HOSTMEM_H
 
-#include "sysemu/numa.h"
+#include "system/numa.h"
 #include "qapi/qapi-types-machine.h"
 #include "qom/object.h"
 #include "exec/memory.h"
diff --git a/include/sysemu/hvf.h b/include/system/hvf.h
similarity index 100%
rename from include/sysemu/hvf.h
rename to include/system/hvf.h
diff --git a/include/sysemu/hvf_int.h b/include/system/hvf_int.h
similarity index 100%
rename from include/sysemu/hvf_int.h
rename to include/system/hvf_int.h
diff --git a/include/sysemu/hw_accel.h b/include/system/hw_accel.h
similarity index 83%
rename from include/sysemu/hw_accel.h
rename to include/system/hw_accel.h
index c71b77e71f3..380e9e640b6 100644
--- a/include/sysemu/hw_accel.h
+++ b/include/system/hw_accel.h
@@ -12,10 +12,10 @@
 #define QEMU_HW_ACCEL_H
 
 #include "hw/core/cpu.h"
-#include "sysemu/kvm.h"
-#include "sysemu/hvf.h"
-#include "sysemu/whpx.h"
-#include "sysemu/nvmm.h"
+#include "system/kvm.h"
+#include "system/hvf.h"
+#include "system/whpx.h"
+#include "system/nvmm.h"
 
 void cpu_synchronize_state(CPUState *cpu);
 void cpu_synchronize_post_reset(CPUState *cpu);
diff --git a/include/sysemu/iommufd.h b/include/system/iommufd.h
similarity index 96%
rename from include/sysemu/iommufd.h
rename to include/system/iommufd.h
index 4c4886c7787..cbab75bfbf6 100644
--- a/include/sysemu/iommufd.h
+++ b/include/system/iommufd.h
@@ -11,13 +11,13 @@
  * SPDX-License-Identifier: GPL-2.0-or-later
  */
 
-#ifndef SYSEMU_IOMMUFD_H
-#define SYSEMU_IOMMUFD_H
+#ifndef SYSTEM_IOMMUFD_H
+#define SYSTEM_IOMMUFD_H
 
 #include "qom/object.h"
 #include "exec/hwaddr.h"
 #include "exec/cpu-common.h"
-#include "sysemu/host_iommu_device.h"
+#include "system/host_iommu_device.h"
 
 #define TYPE_IOMMUFD_BACKEND "iommufd"
 OBJECT_DECLARE_TYPE(IOMMUFDBackend, IOMMUFDBackendClass, IOMMUFD_BACKEND)
diff --git a/include/sysemu/iothread.h b/include/system/iothread.h
similarity index 97%
rename from include/sysemu/iothread.h
rename to include/system/iothread.h
index 2102a90eca6..d95c17a6456 100644
--- a/include/sysemu/iothread.h
+++ b/include/system/iothread.h
@@ -17,7 +17,7 @@
 #include "block/aio.h"
 #include "qemu/thread.h"
 #include "qom/object.h"
-#include "sysemu/event-loop-base.h"
+#include "system/event-loop-base.h"
 
 #define TYPE_IOTHREAD "iothread"
 
diff --git a/include/sysemu/kvm.h b/include/system/kvm.h
similarity index 100%
rename from include/sysemu/kvm.h
rename to include/system/kvm.h
diff --git a/include/sysemu/kvm_int.h b/include/system/kvm_int.h
similarity index 99%
rename from include/sysemu/kvm_int.h
rename to include/system/kvm_int.h
index a1e72763da1..4de6106869b 100644
--- a/include/sysemu/kvm_int.h
+++ b/include/system/kvm_int.h
@@ -13,7 +13,7 @@
 #include "qapi/qapi-types-common.h"
 #include "qemu/accel.h"
 #include "qemu/queue.h"
-#include "sysemu/kvm.h"
+#include "system/kvm.h"
 #include "hw/boards.h"
 #include "hw/i386/topology.h"
 #include "io/channel-socket.h"
diff --git a/include/sysemu/kvm_xen.h b/include/system/kvm_xen.h
similarity index 93%
rename from include/sysemu/kvm_xen.h
rename to include/system/kvm_xen.h
index 961c702c4e7..7d0e69f1334 100644
--- a/include/sysemu/kvm_xen.h
+++ b/include/system/kvm_xen.h
@@ -9,8 +9,8 @@
  *
  */
 
-#ifndef QEMU_SYSEMU_KVM_XEN_H
-#define QEMU_SYSEMU_KVM_XEN_H
+#ifndef QEMU_SYSTEM_KVM_XEN_H
+#define QEMU_SYSTEM_KVM_XEN_H
 
 /* The KVM API uses these to indicate "no GPA" or "no GFN" */
 #define INVALID_GPA UINT64_MAX
@@ -41,4 +41,4 @@ uint16_t kvm_xen_get_evtchn_max_pirq(void);
 #define XEN_SPECIAL_PFN(x) ((XEN_SPECIAL_AREA_ADDR >> TARGET_PAGE_BITS) + \
                             XEN_SPECIALPAGE_##x)
 
-#endif /* QEMU_SYSEMU_KVM_XEN_H */
+#endif /* QEMU_SYSTEM_KVM_XEN_H */
diff --git a/include/sysemu/memory_mapping.h b/include/system/memory_mapping.h
similarity index 100%
rename from include/sysemu/memory_mapping.h
rename to include/system/memory_mapping.h
diff --git a/include/sysemu/numa.h b/include/system/numa.h
similarity index 98%
rename from include/sysemu/numa.h
rename to include/system/numa.h
index 04676141470..96d4ff9b85a 100644
--- a/include/sysemu/numa.h
+++ b/include/system/numa.h
@@ -1,5 +1,5 @@
-#ifndef SYSEMU_NUMA_H
-#define SYSEMU_NUMA_H
+#ifndef SYSTEM_NUMA_H
+#define SYSTEM_NUMA_H
 
 #include "qemu/bitmap.h"
 #include "qapi/qapi-types-machine.h"
diff --git a/include/sysemu/nvmm.h b/include/system/nvmm.h
similarity index 100%
rename from include/sysemu/nvmm.h
rename to include/system/nvmm.h
diff --git a/include/sysemu/os-posix.h b/include/system/os-posix.h
similarity index 100%
rename from include/sysemu/os-posix.h
rename to include/system/os-posix.h
diff --git a/include/sysemu/os-win32.h b/include/system/os-win32.h
similarity index 100%
rename from include/sysemu/os-win32.h
rename to include/system/os-win32.h
diff --git a/include/sysemu/qtest.h b/include/system/qtest.h
similarity index 100%
rename from include/sysemu/qtest.h
rename to include/system/qtest.h
diff --git a/include/sysemu/replay.h b/include/system/replay.h
similarity index 99%
rename from include/sysemu/replay.h
rename to include/system/replay.h
index cba74fa9bce..8926d8cf4bc 100644
--- a/include/sysemu/replay.h
+++ b/include/system/replay.h
@@ -8,8 +8,8 @@
  * See the COPYING file in the top-level directory.
  *
  */
-#ifndef SYSEMU_REPLAY_H
-#define SYSEMU_REPLAY_H
+#ifndef SYSTEM_REPLAY_H
+#define SYSTEM_REPLAY_H
 
 #ifdef CONFIG_USER_ONLY
 #error Cannot include this header from user emulation
diff --git a/include/sysemu/reset.h b/include/system/reset.h
similarity index 98%
rename from include/sysemu/reset.h
rename to include/system/reset.h
index 0e297c0e021..97131d94cfc 100644
--- a/include/sysemu/reset.h
+++ b/include/system/reset.h
@@ -24,8 +24,8 @@
  * THE SOFTWARE.
  */
 
-#ifndef QEMU_SYSEMU_RESET_H
-#define QEMU_SYSEMU_RESET_H
+#ifndef QEMU_SYSTEM_RESET_H
+#define QEMU_SYSTEM_RESET_H
 
 #include "hw/resettable.h"
 #include "qapi/qapi-events-run-state.h"
diff --git a/include/sysemu/rng-random.h b/include/system/rng-random.h
similarity index 100%
rename from include/sysemu/rng-random.h
rename to include/system/rng-random.h
diff --git a/include/sysemu/rng.h b/include/system/rng.h
similarity index 100%
rename from include/sysemu/rng.h
rename to include/system/rng.h
diff --git a/include/sysemu/rtc.h b/include/system/rtc.h
similarity index 98%
rename from include/sysemu/rtc.h
rename to include/system/rtc.h
index 0fc8ad6fdf1..cde83fab15f 100644
--- a/include/sysemu/rtc.h
+++ b/include/system/rtc.h
@@ -22,8 +22,8 @@
  * THE SOFTWARE.
  */
 
-#ifndef SYSEMU_RTC_H
-#define SYSEMU_RTC_H
+#ifndef SYSTEM_RTC_H
+#define SYSTEM_RTC_H
 
 /**
  * qemu_get_timedate: Get the current RTC time
diff --git a/include/sysemu/runstate-action.h b/include/system/runstate-action.h
similarity index 100%
rename from include/sysemu/runstate-action.h
rename to include/system/runstate-action.h
diff --git a/include/sysemu/runstate.h b/include/system/runstate.h
similarity index 98%
rename from include/sysemu/runstate.h
rename to include/system/runstate.h
index 11c7ff3ffbb..bffc3719d41 100644
--- a/include/sysemu/runstate.h
+++ b/include/system/runstate.h
@@ -1,5 +1,5 @@
-#ifndef SYSEMU_RUNSTATE_H
-#define SYSEMU_RUNSTATE_H
+#ifndef SYSTEM_RUNSTATE_H
+#define SYSTEM_RUNSTATE_H
 
 #include "qapi/qapi-types-run-state.h"
 #include "qemu/notify.h"
diff --git a/include/sysemu/seccomp.h b/include/system/seccomp.h
similarity index 100%
rename from include/sysemu/seccomp.h
rename to include/system/seccomp.h
diff --git a/include/sysemu/spdm-socket.h b/include/system/spdm-socket.h
similarity index 100%
rename from include/sysemu/spdm-socket.h
rename to include/system/spdm-socket.h
diff --git a/include/sysemu/stats.h b/include/system/stats.h
similarity index 100%
rename from include/sysemu/stats.h
rename to include/system/stats.h
diff --git a/include/sysemu/sysemu.h b/include/system/system.h
similarity index 99%
rename from include/sysemu/sysemu.h
rename to include/system/system.h
index 7ec419ce132..5364ad4f276 100644
--- a/include/sysemu/sysemu.h
+++ b/include/system/system.h
@@ -1,5 +1,5 @@
-#ifndef SYSEMU_H
-#define SYSEMU_H
+#ifndef SYSTEM_H
+#define SYSTEM_H
 /* Misc. things related to the system emulator.  */
 
 #include "qemu/timer.h"
diff --git a/include/sysemu/tcg.h b/include/system/tcg.h
similarity index 88%
rename from include/sysemu/tcg.h
rename to include/system/tcg.h
index 5e2ca9aab3d..73229648c63 100644
--- a/include/sysemu/tcg.h
+++ b/include/system/tcg.h
@@ -7,8 +7,8 @@
 
 /* header to be included in non-TCG-specific code */
 
-#ifndef SYSEMU_TCG_H
-#define SYSEMU_TCG_H
+#ifndef SYSTEM_TCG_H
+#define SYSTEM_TCG_H
 
 #ifdef CONFIG_TCG
 extern bool tcg_allowed;
diff --git a/include/sysemu/tpm.h b/include/system/tpm.h
similarity index 100%
rename from include/sysemu/tpm.h
rename to include/system/tpm.h
diff --git a/include/sysemu/tpm_backend.h b/include/system/tpm_backend.h
similarity index 99%
rename from include/sysemu/tpm_backend.h
rename to include/system/tpm_backend.h
index 7fabafefee1..01b11f629c4 100644
--- a/include/sysemu/tpm_backend.h
+++ b/include/system/tpm_backend.h
@@ -15,7 +15,7 @@
 
 #include "qom/object.h"
 #include "qemu/option.h"
-#include "sysemu/tpm.h"
+#include "system/tpm.h"
 #include "qapi/error.h"
 
 #ifdef CONFIG_TPM
diff --git a/include/sysemu/tpm_util.h b/include/system/tpm_util.h
similarity index 94%
rename from include/sysemu/tpm_util.h
rename to include/system/tpm_util.h
index 08f05172a71..18586932257 100644
--- a/include/sysemu/tpm_util.h
+++ b/include/system/tpm_util.h
@@ -19,10 +19,10 @@
  * License along with this library; if not, see <http://www.gnu.org/licenses/>
  */
 
-#ifndef SYSEMU_TPM_UTIL_H
-#define SYSEMU_TPM_UTIL_H
+#ifndef SYSTEM_TPM_UTIL_H
+#define SYSTEM_TPM_UTIL_H
 
-#include "sysemu/tpm.h"
+#include "system/tpm.h"
 #include "qemu/bswap.h"
 
 void tpm_util_write_fatal_error_response(uint8_t *out, uint32_t out_len);
@@ -69,4 +69,4 @@ static inline void tpm_cmd_set_error(void *b, uint32_t error)
 void tpm_util_show_buffer(const unsigned char *buffer,
                           size_t buffer_size, const char *string);
 
-#endif /* SYSEMU_TPM_UTIL_H */
+#endif /* SYSTEM_TPM_UTIL_H */
diff --git a/include/sysemu/vhost-user-backend.h b/include/system/vhost-user-backend.h
similarity index 100%
rename from include/sysemu/vhost-user-backend.h
rename to include/system/vhost-user-backend.h
diff --git a/include/sysemu/watchdog.h b/include/system/watchdog.h
similarity index 100%
rename from include/sysemu/watchdog.h
rename to include/system/watchdog.h
diff --git a/include/sysemu/whpx.h b/include/system/whpx.h
similarity index 100%
rename from include/sysemu/whpx.h
rename to include/system/whpx.h
diff --git a/include/sysemu/xen-mapcache.h b/include/system/xen-mapcache.h
similarity index 98%
rename from include/sysemu/xen-mapcache.h
rename to include/system/xen-mapcache.h
index b5e3ea1bc02..b68f196ddd5 100644
--- a/include/sysemu/xen-mapcache.h
+++ b/include/system/xen-mapcache.h
@@ -10,7 +10,7 @@
 #define XEN_MAPCACHE_H
 
 #include "exec/cpu-common.h"
-#include "sysemu/xen.h"
+#include "system/xen.h"
 
 typedef hwaddr (*phys_offset_to_gaddr_t)(hwaddr phys_offset,
                                          ram_addr_t size);
diff --git a/include/sysemu/xen.h b/include/system/xen.h
similarity index 92%
rename from include/sysemu/xen.h
rename to include/system/xen.h
index d70eacfbe28..990c19a8ef0 100644
--- a/include/sysemu/xen.h
+++ b/include/system/xen.h
@@ -7,11 +7,11 @@
 
 /* header to be included in non-Xen-specific code */
 
-#ifndef SYSEMU_XEN_H
-#define SYSEMU_XEN_H
+#ifndef SYSTEM_XEN_H
+#define SYSTEM_XEN_H
 
 #ifdef CONFIG_USER_ONLY
-#error Cannot include sysemu/xen.h from user emulation
+#error Cannot include system/xen.h from user emulation
 #endif
 
 #include "exec/cpu-common.h"
diff --git a/migration/dirtyrate.h b/migration/dirtyrate.h
index 869c0609412..35225c36b69 100644
--- a/migration/dirtyrate.h
+++ b/migration/dirtyrate.h
@@ -13,7 +13,7 @@
 #ifndef QEMU_MIGRATION_DIRTYRATE_H
 #define QEMU_MIGRATION_DIRTYRATE_H
 
-#include "sysemu/dirtyrate.h"
+#include "system/dirtyrate.h"
 
 /*
  * Sample 512 pages per GB as default.
diff --git a/migration/migration.h b/migration/migration.h
index 3857905c0e8..7b6e718690c 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -25,7 +25,7 @@
 #include "net/announce.h"
 #include "qom/object.h"
 #include "postcopy-ram.h"
-#include "sysemu/runstate.h"
+#include "system/runstate.h"
 #include "migration/misc.h"
 
 #define  MIGRATION_THREAD_SNAPSHOT          "mig/snapshot"
diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
index cb628f681df..088960a503e 100644
--- a/monitor/monitor-internal.h
+++ b/monitor/monitor-internal.h
@@ -31,7 +31,7 @@
 #include "qapi/qmp/dispatch.h"
 #include "qapi/qmp/json-parser.h"
 #include "qemu/readline.h"
-#include "sysemu/iothread.h"
+#include "system/iothread.h"
 
 /*
  * Supported types:
diff --git a/nbd/nbd-internal.h b/nbd/nbd-internal.h
index 91895106a95..715d92d6efc 100644
--- a/nbd/nbd-internal.h
+++ b/nbd/nbd-internal.h
@@ -10,7 +10,7 @@
 #ifndef NBD_INTERNAL_H
 #define NBD_INTERNAL_H
 #include "block/nbd.h"
-#include "sysemu/block-backend.h"
+#include "system/block-backend.h"
 #include "io/channel-tls.h"
 
 #include "qemu/iov.h"
diff --git a/rust/wrapper.h b/rust/wrapper.h
index 285d0eb6ad0..a9bc67af0d5 100644
--- a/rust/wrapper.h
+++ b/rust/wrapper.h
@@ -50,7 +50,7 @@ typedef enum memory_order {
 #include "qemu/osdep.h"
 #include "qemu/module.h"
 #include "qemu-io.h"
-#include "sysemu/sysemu.h"
+#include "system/system.h"
 #include "hw/sysbus.h"
 #include "exec/memory.h"
 #include "chardev/char-fe.h"
diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index 2e6b49bf137..05c3de8cd46 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -11,7 +11,7 @@
 #ifndef QEMU_KVM_ARM_H
 #define QEMU_KVM_ARM_H
 
-#include "sysemu/kvm.h"
+#include "system/kvm.h"
 
 #define KVM_ARM_VGIC_V2   (1 << 0)
 #define KVM_ARM_VGIC_V3   (1 << 1)
diff --git a/target/i386/cpu-internal.h b/target/i386/cpu-internal.h
index 9baac5c0b45..37c61a1bc3d 100644
--- a/target/i386/cpu-internal.h
+++ b/target/i386/cpu-internal.h
@@ -1,5 +1,5 @@
 /*
- * i386 CPU internal definitions to be shared between cpu.c and cpu-sysemu.c
+ * i386 CPU internal definitions to be shared between cpu.c and cpu-system.c
  *
  *  Copyright (c) 2003 Fabrice Bellard
  *
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 4c239a6970f..dbd8f1ffc79 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -20,7 +20,7 @@
 #ifndef I386_CPU_H
 #define I386_CPU_H
 
-#include "sysemu/tcg.h"
+#include "system/tcg.h"
 #include "cpu-qom.h"
 #include "kvm/hyperv-proto.h"
 #include "exec/cpu-defs.h"
diff --git a/target/i386/hvf/vmx.h b/target/i386/hvf/vmx.h
index 3954ef883df..80ce26279bf 100644
--- a/target/i386/hvf/vmx.h
+++ b/target/i386/hvf/vmx.h
@@ -30,8 +30,8 @@
 #include "vmcs.h"
 #include "cpu.h"
 #include "x86.h"
-#include "sysemu/hvf.h"
-#include "sysemu/hvf_int.h"
+#include "system/hvf.h"
+#include "system/hvf_int.h"
 
 #include "exec/address-spaces.h"
 
diff --git a/target/i386/kvm/hyperv.h b/target/i386/kvm/hyperv.h
index e3982c8f4dd..e45a4512fe9 100644
--- a/target/i386/kvm/hyperv.h
+++ b/target/i386/kvm/hyperv.h
@@ -15,7 +15,7 @@
 #define TARGET_I386_HYPERV_H
 
 #include "cpu.h"
-#include "sysemu/kvm.h"
+#include "system/kvm.h"
 #include "hw/hyperv/hyperv.h"
 
 #ifdef CONFIG_KVM
diff --git a/target/i386/kvm/kvm_i386.h b/target/i386/kvm/kvm_i386.h
index 7edb154a16e..88565e8dbac 100644
--- a/target/i386/kvm/kvm_i386.h
+++ b/target/i386/kvm/kvm_i386.h
@@ -11,7 +11,7 @@
 #ifndef QEMU_KVM_I386_H
 #define QEMU_KVM_I386_H
 
-#include "sysemu/kvm.h"
+#include "system/kvm.h"
 
 /* always false if !CONFIG_KVM */
 #define kvm_pit_in_kernel() \
diff --git a/target/i386/nvmm/nvmm-accel-ops.h b/target/i386/nvmm/nvmm-accel-ops.h
index 7c5461bd759..931bb5ca243 100644
--- a/target/i386/nvmm/nvmm-accel-ops.h
+++ b/target/i386/nvmm/nvmm-accel-ops.h
@@ -10,7 +10,7 @@
 #ifndef TARGET_I386_NVMM_ACCEL_OPS_H
 #define TARGET_I386_NVMM_ACCEL_OPS_H
 
-#include "sysemu/cpus.h"
+#include "system/cpus.h"
 
 int nvmm_init_vcpu(CPUState *cpu);
 int nvmm_vcpu_exec(CPUState *cpu);
diff --git a/target/i386/whpx/whpx-accel-ops.h b/target/i386/whpx/whpx-accel-ops.h
index 7a1bb1ab575..e6cf15511d4 100644
--- a/target/i386/whpx/whpx-accel-ops.h
+++ b/target/i386/whpx/whpx-accel-ops.h
@@ -10,7 +10,7 @@
 #ifndef TARGET_I386_WHPX_ACCEL_OPS_H
 #define TARGET_I386_WHPX_ACCEL_OPS_H
 
-#include "sysemu/cpus.h"
+#include "system/cpus.h"
 
 int whpx_init_vcpu(CPUState *cpu);
 int whpx_vcpu_exec(CPUState *cpu);
diff --git a/target/mips/helper.h b/target/mips/helper.h
index 0f8462febb5..7e400418281 100644
--- a/target/mips/helper.h
+++ b/target/mips/helper.h
@@ -594,7 +594,7 @@ DEF_HELPER_FLAGS_3(wrdsp, 0, void, tl, tl, env)
 DEF_HELPER_FLAGS_2(rddsp, 0, tl, tl, env)
 
 #ifndef CONFIG_USER_ONLY
-#include "tcg/sysemu_helper.h.inc"
+#include "tcg/system_helper.h.inc"
 #endif /* !CONFIG_USER_ONLY */
 
 #include "tcg/msa_helper.h.inc"
diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
index 1975fb5ee6c..1d8cb76a6be 100644
--- a/target/ppc/kvm_ppc.h
+++ b/target/ppc/kvm_ppc.h
@@ -9,7 +9,7 @@
 #ifndef KVM_PPC_H
 #define KVM_PPC_H
 
-#include "sysemu/kvm.h"
+#include "system/kvm.h"
 #include "exec/hwaddr.h"
 #include "cpu.h"
 
diff --git a/target/s390x/kvm/pv.h b/target/s390x/kvm/pv.h
index 4b408174391..5e9c8bd3510 100644
--- a/target/s390x/kvm/pv.h
+++ b/target/s390x/kvm/pv.h
@@ -13,7 +13,7 @@
 #define HW_S390_PV_H
 
 #include "qapi/error.h"
-#include "sysemu/kvm.h"
+#include "system/kvm.h"
 #include "hw/s390x/s390-virtio-ccw.h"
 
 #ifdef CONFIG_KVM
diff --git a/target/s390x/s390x-internal.h b/target/s390x/s390x-internal.h
index 825252d7284..4cc435042c8 100644
--- a/target/s390x/s390x-internal.h
+++ b/target/s390x/s390x-internal.h
@@ -240,10 +240,10 @@ uint32_t calc_cc(CPUS390XState *env, uint32_t cc_op, uint64_t src, uint64_t dst,
 #ifndef CONFIG_USER_ONLY
 unsigned int s390_cpu_halt(S390CPU *cpu);
 void s390_cpu_unhalt(S390CPU *cpu);
-void s390_cpu_init_sysemu(Object *obj);
-bool s390_cpu_realize_sysemu(DeviceState *dev, Error **errp);
+void s390_cpu_system_init(Object *obj);
+bool s390_cpu_system_realize(DeviceState *dev, Error **errp);
 void s390_cpu_finalize(Object *obj);
-void s390_cpu_class_init_sysemu(CPUClass *cc);
+void s390_cpu_system_class_init(CPUClass *cc);
 void s390_cpu_machine_reset_cb(void *opaque);
 
 #else
diff --git a/tests/qtest/tpm-emu.h b/tests/qtest/tpm-emu.h
index 712cee9b7a5..59c8009f4c5 100644
--- a/tests/qtest/tpm-emu.h
+++ b/tests/qtest/tpm-emu.h
@@ -21,7 +21,7 @@
 
 #include "qemu/sockets.h"
 #include "io/channel.h"
-#include "sysemu/tpm.h"
+#include "system/tpm.h"
 #include "libqtest.h"
 
 struct tpm_hdr {
diff --git a/target/mips/tcg/sysemu_helper.h.inc b/target/mips/tcg/system_helper.h.inc
similarity index 99%
rename from target/mips/tcg/sysemu_helper.h.inc
rename to target/mips/tcg/system_helper.h.inc
index 1861d538de1..eaac5e2c6f0 100644
--- a/target/mips/tcg/sysemu_helper.h.inc
+++ b/target/mips/tcg/system_helper.h.inc
@@ -1,5 +1,5 @@
 /*
- *  QEMU MIPS sysemu helpers
+ *  QEMU MIPS TCG system helpers
  *
  *  Copyright (c) 2004-2005 Jocelyn Mayer
  *  Copyright (c) 2006 Marius Groeger (FPU operations)
diff --git a/accel/accel-blocker.c b/accel/accel-blocker.c
index 75daaa29113..51132d1b8a0 100644
--- a/accel/accel-blocker.c
+++ b/accel/accel-blocker.c
@@ -29,7 +29,7 @@
 #include "qemu/thread.h"
 #include "qemu/main-loop.h"
 #include "hw/core/cpu.h"
-#include "sysemu/accel-blocker.h"
+#include "system/accel-blocker.h"
 
 static QemuLockCnt accel_in_ioctl_lock;
 static QemuEvent accel_in_ioctl_event;
diff --git a/accel/accel-system.c b/accel/accel-system.c
index 61d689935e1..a7596aef59d 100644
--- a/accel/accel-system.c
+++ b/accel/accel-system.c
@@ -26,7 +26,7 @@
 #include "qemu/osdep.h"
 #include "qemu/accel.h"
 #include "hw/boards.h"
-#include "sysemu/cpus.h"
+#include "system/cpus.h"
 #include "qemu/error-report.h"
 #include "accel-system.h"
 
diff --git a/accel/dummy-cpus.c b/accel/dummy-cpus.c
index f32d8c8dc3b..867276144fa 100644
--- a/accel/dummy-cpus.c
+++ b/accel/dummy-cpus.c
@@ -13,7 +13,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/rcu.h"
-#include "sysemu/cpus.h"
+#include "system/cpus.h"
 #include "qemu/guest-random.h"
 #include "qemu/main-loop.h"
 #include "hw/core/cpu.h"
diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c
index d60874d3e6b..945ba720513 100644
--- a/accel/hvf/hvf-accel-ops.c
+++ b/accel/hvf/hvf-accel-ops.c
@@ -54,10 +54,10 @@
 #include "exec/exec-all.h"
 #include "gdbstub/enums.h"
 #include "hw/boards.h"
-#include "sysemu/cpus.h"
-#include "sysemu/hvf.h"
-#include "sysemu/hvf_int.h"
-#include "sysemu/runstate.h"
+#include "system/cpus.h"
+#include "system/hvf.h"
+#include "system/hvf_int.h"
+#include "system/runstate.h"
 #include "qemu/guest-random.h"
 
 HVFState *hvf_state;
diff --git a/accel/hvf/hvf-all.c b/accel/hvf/hvf-all.c
index 6ca0850b20e..d404e01adef 100644
--- a/accel/hvf/hvf-all.c
+++ b/accel/hvf/hvf-all.c
@@ -10,8 +10,8 @@
 
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
-#include "sysemu/hvf.h"
-#include "sysemu/hvf_int.h"
+#include "system/hvf.h"
+#include "system/hvf_int.h"
 
 const char *hvf_return_string(hv_return_t ret)
 {
diff --git a/accel/kvm/kvm-accel-ops.c b/accel/kvm/kvm-accel-ops.c
index c239dfc87ac..a81e8f3b03b 100644
--- a/accel/kvm/kvm-accel-ops.c
+++ b/accel/kvm/kvm-accel-ops.c
@@ -16,10 +16,10 @@
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
 #include "qemu/main-loop.h"
-#include "sysemu/kvm.h"
-#include "sysemu/kvm_int.h"
-#include "sysemu/runstate.h"
-#include "sysemu/cpus.h"
+#include "system/kvm.h"
+#include "system/kvm_int.h"
+#include "system/runstate.h"
+#include "system/cpus.h"
 #include "qemu/guest-random.h"
 #include "qapi/error.h"
 
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 801cff16a5a..672050e8009 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -28,10 +28,10 @@
 #include "hw/pci/msix.h"
 #include "hw/s390x/adapter.h"
 #include "gdbstub/enums.h"
-#include "sysemu/kvm_int.h"
-#include "sysemu/runstate.h"
-#include "sysemu/cpus.h"
-#include "sysemu/accel-blocker.h"
+#include "system/kvm_int.h"
+#include "system/runstate.h"
+#include "system/cpus.h"
+#include "system/accel-blocker.h"
 #include "qemu/bswap.h"
 #include "exec/memory.h"
 #include "exec/ram_addr.h"
@@ -42,15 +42,15 @@
 #include "qapi/visitor.h"
 #include "qapi/qapi-types-common.h"
 #include "qapi/qapi-visit-common.h"
-#include "sysemu/reset.h"
+#include "system/reset.h"
 #include "qemu/guest-random.h"
-#include "sysemu/hw_accel.h"
+#include "system/hw_accel.h"
 #include "kvm-cpus.h"
-#include "sysemu/dirtylimit.h"
+#include "system/dirtylimit.h"
 #include "qemu/range.h"
 
 #include "hw/boards.h"
-#include "sysemu/stats.h"
+#include "system/stats.h"
 
 /* This check must be after config-host.h is included */
 #ifdef CONFIG_EVENTFD
diff --git a/accel/qtest/qtest.c b/accel/qtest/qtest.c
index bf14032d294..ad7e3441a5a 100644
--- a/accel/qtest/qtest.c
+++ b/accel/qtest/qtest.c
@@ -18,8 +18,8 @@
 #include "qemu/option.h"
 #include "qemu/config-file.h"
 #include "qemu/accel.h"
-#include "sysemu/qtest.h"
-#include "sysemu/cpus.h"
+#include "system/qtest.h"
+#include "system/cpus.h"
 #include "qemu/guest-random.h"
 #include "qemu/main-loop.h"
 #include "hw/core/cpu.h"
diff --git a/accel/stubs/kvm-stub.c b/accel/stubs/kvm-stub.c
index 8e0eb22e61c..ecfd7636f5f 100644
--- a/accel/stubs/kvm-stub.c
+++ b/accel/stubs/kvm-stub.c
@@ -11,7 +11,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "sysemu/kvm.h"
+#include "system/kvm.h"
 #include "hw/pci/msi.h"
 
 KVMState *kvm_state;
diff --git a/accel/stubs/xen-stub.c b/accel/stubs/xen-stub.c
index 7054965c480..cf929b644b7 100644
--- a/accel/stubs/xen-stub.c
+++ b/accel/stubs/xen-stub.c
@@ -6,7 +6,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "sysemu/xen.h"
+#include "system/xen.h"
 #include "qapi/qapi-commands-migration.h"
 
 bool xen_allowed;
diff --git a/accel/tcg/cpu-exec-common.c b/accel/tcg/cpu-exec-common.c
index bc9b1a260e8..6ecfc4e7c21 100644
--- a/accel/tcg/cpu-exec-common.c
+++ b/accel/tcg/cpu-exec-common.c
@@ -18,8 +18,8 @@
  */
 
 #include "qemu/osdep.h"
-#include "sysemu/cpus.h"
-#include "sysemu/tcg.h"
+#include "system/cpus.h"
+#include "system/tcg.h"
 #include "qemu/plugin.h"
 #include "internal-common.h"
 
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 8163295f34b..c13f4a7cbbf 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -30,11 +30,11 @@
 #include "qemu/rcu.h"
 #include "exec/log.h"
 #include "qemu/main-loop.h"
-#include "sysemu/cpus.h"
+#include "system/cpus.h"
 #include "exec/cpu-all.h"
-#include "sysemu/cpu-timers.h"
+#include "system/cpu-timers.h"
 #include "exec/replay-core.h"
-#include "sysemu/tcg.h"
+#include "system/tcg.h"
 #include "exec/helper-proto-common.h"
 #include "tb-jmp-cache.h"
 #include "tb-hash.h"
diff --git a/accel/tcg/icount-common.c b/accel/tcg/icount-common.c
index 30bf8500dc4..b178dccec45 100644
--- a/accel/tcg/icount-common.c
+++ b/accel/tcg/icount-common.c
@@ -27,16 +27,16 @@
 #include "migration/vmstate.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
-#include "sysemu/cpus.h"
-#include "sysemu/qtest.h"
+#include "system/cpus.h"
+#include "system/qtest.h"
 #include "qemu/main-loop.h"
 #include "qemu/option.h"
 #include "qemu/seqlock.h"
-#include "sysemu/replay.h"
-#include "sysemu/runstate.h"
+#include "system/replay.h"
+#include "system/runstate.h"
 #include "hw/core/cpu.h"
-#include "sysemu/cpu-timers.h"
-#include "sysemu/cpu-timers-internal.h"
+#include "system/cpu-timers.h"
+#include "system/cpu-timers-internal.h"
 
 /*
  * ICOUNT: Instruction Counter
diff --git a/accel/tcg/monitor.c b/accel/tcg/monitor.c
index 093efe97144..ae1dbeb79f8 100644
--- a/accel/tcg/monitor.c
+++ b/accel/tcg/monitor.c
@@ -13,9 +13,9 @@
 #include "qapi/type-helpers.h"
 #include "qapi/qapi-commands-machine.h"
 #include "monitor/monitor.h"
-#include "sysemu/cpus.h"
-#include "sysemu/cpu-timers.h"
-#include "sysemu/tcg.h"
+#include "system/cpus.h"
+#include "system/cpu-timers.h"
+#include "system/tcg.h"
 #include "tcg/tcg.h"
 #include "internal-common.h"
 #include "tb-context.h"
diff --git a/accel/tcg/tb-maint.c b/accel/tcg/tb-maint.c
index cc0f5afd475..97d2e39ec0d 100644
--- a/accel/tcg/tb-maint.c
+++ b/accel/tcg/tb-maint.c
@@ -26,7 +26,7 @@
 #include "exec/page-protection.h"
 #include "exec/tb-flush.h"
 #include "exec/translate-all.h"
-#include "sysemu/tcg.h"
+#include "system/tcg.h"
 #include "tcg/tcg.h"
 #include "tb-hash.h"
 #include "tb-context.h"
diff --git a/accel/tcg/tcg-accel-ops-icount.c b/accel/tcg/tcg-accel-ops-icount.c
index 9e1ae66f651..d6b472a0b0e 100644
--- a/accel/tcg/tcg-accel-ops-icount.c
+++ b/accel/tcg/tcg-accel-ops-icount.c
@@ -24,8 +24,8 @@
  */
 
 #include "qemu/osdep.h"
-#include "sysemu/replay.h"
-#include "sysemu/cpu-timers.h"
+#include "system/replay.h"
+#include "system/cpu-timers.h"
 #include "qemu/main-loop.h"
 #include "qemu/guest-random.h"
 #include "exec/exec-all.h"
diff --git a/accel/tcg/tcg-accel-ops-mttcg.c b/accel/tcg/tcg-accel-ops-mttcg.c
index 49814ec4aff..ba7cf6819d6 100644
--- a/accel/tcg/tcg-accel-ops-mttcg.c
+++ b/accel/tcg/tcg-accel-ops-mttcg.c
@@ -24,9 +24,9 @@
  */
 
 #include "qemu/osdep.h"
-#include "sysemu/tcg.h"
-#include "sysemu/replay.h"
-#include "sysemu/cpu-timers.h"
+#include "system/tcg.h"
+#include "system/replay.h"
+#include "system/cpu-timers.h"
 #include "qemu/main-loop.h"
 #include "qemu/notify.h"
 #include "qemu/guest-random.h"
diff --git a/accel/tcg/tcg-accel-ops-rr.c b/accel/tcg/tcg-accel-ops-rr.c
index 8ebadf8e9e1..028b385af9a 100644
--- a/accel/tcg/tcg-accel-ops-rr.c
+++ b/accel/tcg/tcg-accel-ops-rr.c
@@ -25,9 +25,9 @@
 
 #include "qemu/osdep.h"
 #include "qemu/lockable.h"
-#include "sysemu/tcg.h"
-#include "sysemu/replay.h"
-#include "sysemu/cpu-timers.h"
+#include "system/tcg.h"
+#include "system/replay.h"
+#include "system/cpu-timers.h"
 #include "qemu/main-loop.h"
 #include "qemu/notify.h"
 #include "qemu/guest-random.h"
diff --git a/accel/tcg/tcg-accel-ops.c b/accel/tcg/tcg-accel-ops.c
index 3c19e68a79e..d9a35b7667c 100644
--- a/accel/tcg/tcg-accel-ops.c
+++ b/accel/tcg/tcg-accel-ops.c
@@ -26,9 +26,9 @@
  */
 
 #include "qemu/osdep.h"
-#include "sysemu/tcg.h"
-#include "sysemu/replay.h"
-#include "sysemu/cpu-timers.h"
+#include "system/tcg.h"
+#include "system/replay.h"
+#include "system/cpu-timers.h"
 #include "qemu/main-loop.h"
 #include "qemu/guest-random.h"
 #include "qemu/timer.h"
diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
index 2090907dba4..c2565758876 100644
--- a/accel/tcg/tcg-all.c
+++ b/accel/tcg/tcg-all.c
@@ -24,9 +24,9 @@
  */
 
 #include "qemu/osdep.h"
-#include "sysemu/tcg.h"
+#include "system/tcg.h"
 #include "exec/replay-core.h"
-#include "sysemu/cpu-timers.h"
+#include "system/cpu-timers.h"
 #include "tcg/startup.h"
 #include "tcg/oversized-guest.h"
 #include "qapi/error.h"
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index fdf6d8ac191..a8b24be0b96 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -53,9 +53,9 @@
 #include "qemu/cacheinfo.h"
 #include "qemu/timer.h"
 #include "exec/log.h"
-#include "sysemu/cpus.h"
-#include "sysemu/cpu-timers.h"
-#include "sysemu/tcg.h"
+#include "system/cpus.h"
+#include "system/cpu-timers.h"
+#include "system/tcg.h"
 #include "qapi/error.h"
 #include "hw/core/tcg-cpu-ops.h"
 #include "tb-jmp-cache.h"
diff --git a/accel/tcg/watchpoint.c b/accel/tcg/watchpoint.c
index d3aab114588..ca641eb95cf 100644
--- a/accel/tcg/watchpoint.c
+++ b/accel/tcg/watchpoint.c
@@ -22,8 +22,8 @@
 #include "qemu/error-report.h"
 #include "exec/exec-all.h"
 #include "exec/translate-all.h"
-#include "sysemu/tcg.h"
-#include "sysemu/replay.h"
+#include "system/tcg.h"
+#include "system/replay.h"
 #include "hw/core/tcg-cpu-ops.h"
 #include "hw/core/cpu.h"
 
diff --git a/accel/xen/xen-all.c b/accel/xen/xen-all.c
index 0bdefce5375..852e9fbe5fe 100644
--- a/accel/xen/xen-all.c
+++ b/accel/xen/xen-all.c
@@ -18,9 +18,9 @@
 #include "hw/xen/xen_igd.h"
 #include "chardev/char.h"
 #include "qemu/accel.h"
-#include "sysemu/cpus.h"
-#include "sysemu/xen.h"
-#include "sysemu/runstate.h"
+#include "system/cpus.h"
+#include "system/xen.h"
+#include "system/runstate.h"
 #include "migration/misc.h"
 #include "migration/global_state.h"
 #include "hw/boards.h"
diff --git a/audio/audio.c b/audio/audio.c
index af0ae33fedb..87b4e9b6f2f 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -38,9 +38,9 @@
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "qemu/help_option.h"
-#include "sysemu/sysemu.h"
-#include "sysemu/replay.h"
-#include "sysemu/runstate.h"
+#include "system/system.h"
+#include "system/replay.h"
+#include "system/runstate.h"
 #include "ui/qemu-spice.h"
 #include "trace.h"
 
diff --git a/backends/cryptodev-builtin.c b/backends/cryptodev-builtin.c
index b1486be630c..764cee43119 100644
--- a/backends/cryptodev-builtin.c
+++ b/backends/cryptodev-builtin.c
@@ -22,7 +22,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "sysemu/cryptodev.h"
+#include "system/cryptodev.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "standard-headers/linux/virtio_crypto.h"
diff --git a/backends/cryptodev-lkcf.c b/backends/cryptodev-lkcf.c
index 38deac07179..41cf24b7379 100644
--- a/backends/cryptodev-lkcf.c
+++ b/backends/cryptodev-lkcf.c
@@ -30,7 +30,7 @@
 #include "qemu/error-report.h"
 #include "qemu/queue.h"
 #include "qom/object.h"
-#include "sysemu/cryptodev.h"
+#include "system/cryptodev.h"
 #include "standard-headers/linux/virtio_crypto.h"
 
 #include <keyutils.h>
diff --git a/backends/cryptodev-vhost-user.c b/backends/cryptodev-vhost-user.c
index e33fb78521f..43efdf97477 100644
--- a/backends/cryptodev-vhost-user.c
+++ b/backends/cryptodev-vhost-user.c
@@ -27,9 +27,9 @@
 #include "qemu/error-report.h"
 #include "hw/virtio/vhost-user.h"
 #include "standard-headers/linux/virtio_crypto.h"
-#include "sysemu/cryptodev-vhost.h"
+#include "system/cryptodev-vhost.h"
 #include "chardev/char-fe.h"
-#include "sysemu/cryptodev-vhost-user.h"
+#include "system/cryptodev-vhost-user.h"
 #include "qom/object.h"
 
 
diff --git a/backends/cryptodev-vhost.c b/backends/cryptodev-vhost.c
index 93523732f39..8718c973262 100644
--- a/backends/cryptodev-vhost.c
+++ b/backends/cryptodev-vhost.c
@@ -24,13 +24,13 @@
 
 #include "qemu/osdep.h"
 #include "hw/virtio/virtio-bus.h"
-#include "sysemu/cryptodev-vhost.h"
+#include "system/cryptodev-vhost.h"
 
 #ifdef CONFIG_VHOST_CRYPTO
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "hw/virtio/virtio-crypto.h"
-#include "sysemu/cryptodev-vhost-user.h"
+#include "system/cryptodev-vhost-user.h"
 
 uint64_t
 cryptodev_vhost_get_max_queues(
diff --git a/backends/cryptodev.c b/backends/cryptodev.c
index d8bd2a1ae61..1157a149d02 100644
--- a/backends/cryptodev.c
+++ b/backends/cryptodev.c
@@ -22,8 +22,8 @@
  */
 
 #include "qemu/osdep.h"
-#include "sysemu/cryptodev.h"
-#include "sysemu/stats.h"
+#include "system/cryptodev.h"
+#include "system/stats.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-cryptodev.h"
 #include "qapi/qapi-types-stats.h"
diff --git a/backends/host_iommu_device.c b/backends/host_iommu_device.c
index 8f2dda1beb9..cea76c6925c 100644
--- a/backends/host_iommu_device.c
+++ b/backends/host_iommu_device.c
@@ -10,7 +10,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "sysemu/host_iommu_device.h"
+#include "system/host_iommu_device.h"
 
 OBJECT_DEFINE_ABSTRACT_TYPE(HostIOMMUDevice,
                             host_iommu_device,
diff --git a/backends/hostmem-epc.c b/backends/hostmem-epc.c
index 6c024d6217d..eb4b95dfd73 100644
--- a/backends/hostmem-epc.c
+++ b/backends/hostmem-epc.c
@@ -14,7 +14,7 @@
 #include <sys/ioctl.h>
 #include "qom/object_interfaces.h"
 #include "qapi/error.h"
-#include "sysemu/hostmem.h"
+#include "system/hostmem.h"
 #include "hw/i386/hostmem-epc.h"
 
 static bool
diff --git a/backends/hostmem-file.c b/backends/hostmem-file.c
index 7e5072e33ef..46321fda842 100644
--- a/backends/hostmem-file.c
+++ b/backends/hostmem-file.c
@@ -15,7 +15,7 @@
 #include "qemu/error-report.h"
 #include "qemu/module.h"
 #include "qemu/madvise.h"
-#include "sysemu/hostmem.h"
+#include "system/hostmem.h"
 #include "qom/object_interfaces.h"
 #include "qom/object.h"
 #include "qapi/visitor.h"
diff --git a/backends/hostmem-memfd.c b/backends/hostmem-memfd.c
index 9f890a813e1..d4d0620e6c5 100644
--- a/backends/hostmem-memfd.c
+++ b/backends/hostmem-memfd.c
@@ -11,7 +11,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "sysemu/hostmem.h"
+#include "system/hostmem.h"
 #include "qom/object_interfaces.h"
 #include "qemu/memfd.h"
 #include "qemu/module.h"
diff --git a/backends/hostmem-ram.c b/backends/hostmem-ram.c
index f7d81af783a..39aac6bf35b 100644
--- a/backends/hostmem-ram.c
+++ b/backends/hostmem-ram.c
@@ -11,7 +11,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "sysemu/hostmem.h"
+#include "system/hostmem.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
 #include "qom/object_interfaces.h"
diff --git a/backends/hostmem-shm.c b/backends/hostmem-shm.c
index 374edc3db87..5551ba78a69 100644
--- a/backends/hostmem-shm.c
+++ b/backends/hostmem-shm.c
@@ -11,7 +11,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "sysemu/hostmem.h"
+#include "system/hostmem.h"
 #include "qapi/error.h"
 
 #define TYPE_MEMORY_BACKEND_SHM "memory-backend-shm"
diff --git a/backends/hostmem.c b/backends/hostmem.c
index 181446626ae..bceca1a8d9f 100644
--- a/backends/hostmem.c
+++ b/backends/hostmem.c
@@ -11,7 +11,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "sysemu/hostmem.h"
+#include "system/hostmem.h"
 #include "hw/boards.h"
 #include "qapi/error.h"
 #include "qapi/qapi-builtin-visit.h"
diff --git a/backends/iommufd.c b/backends/iommufd.c
index 9bc466a89c4..7b4fc8ec460 100644
--- a/backends/iommufd.c
+++ b/backends/iommufd.c
@@ -11,7 +11,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "sysemu/iommufd.h"
+#include "system/iommufd.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
 #include "qom/object_interfaces.h"
diff --git a/backends/rng-builtin.c b/backends/rng-builtin.c
index f367eb665cf..4cfa7e578bc 100644
--- a/backends/rng-builtin.c
+++ b/backends/rng-builtin.c
@@ -6,11 +6,11 @@
  */
 
 #include "qemu/osdep.h"
-#include "sysemu/rng.h"
+#include "system/rng.h"
 #include "qemu/main-loop.h"
 #include "qemu/guest-random.h"
 #include "qom/object.h"
-#include "sysemu/replay.h"
+#include "system/replay.h"
 
 OBJECT_DECLARE_SIMPLE_TYPE(RngBuiltin, RNG_BUILTIN)
 
diff --git a/backends/rng-egd.c b/backends/rng-egd.c
index 684c3cf3d61..82da46365d3 100644
--- a/backends/rng-egd.c
+++ b/backends/rng-egd.c
@@ -11,7 +11,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "sysemu/rng.h"
+#include "system/rng.h"
 #include "chardev/char-fe.h"
 #include "qapi/error.h"
 #include "qapi/qmp/qerror.h"
diff --git a/backends/rng-random.c b/backends/rng-random.c
index 489c0917f09..3ce6cc9b4af 100644
--- a/backends/rng-random.c
+++ b/backends/rng-random.c
@@ -11,8 +11,8 @@
  */
 
 #include "qemu/osdep.h"
-#include "sysemu/rng-random.h"
-#include "sysemu/rng.h"
+#include "system/rng-random.h"
+#include "system/rng.h"
 #include "qapi/error.h"
 #include "qapi/qmp/qerror.h"
 #include "qemu/main-loop.h"
diff --git a/backends/rng.c b/backends/rng.c
index 9bbd0c77b69..1f6fb106aea 100644
--- a/backends/rng.c
+++ b/backends/rng.c
@@ -11,7 +11,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "sysemu/rng.h"
+#include "system/rng.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
 #include "qom/object_interfaces.h"
diff --git a/backends/spdm-socket.c b/backends/spdm-socket.c
index d0663d696ca..2c709c68c87 100644
--- a/backends/spdm-socket.c
+++ b/backends/spdm-socket.c
@@ -11,7 +11,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "sysemu/spdm-socket.h"
+#include "system/spdm-socket.h"
 #include "qapi/error.h"
 
 static bool read_bytes(const int socket, uint8_t *buffer,
diff --git a/backends/tpm/tpm_backend.c b/backends/tpm/tpm_backend.c
index 485a20b9e09..8cf80043ac5 100644
--- a/backends/tpm/tpm_backend.c
+++ b/backends/tpm/tpm_backend.c
@@ -13,9 +13,9 @@
  */
 
 #include "qemu/osdep.h"
-#include "sysemu/tpm_backend.h"
+#include "system/tpm_backend.h"
 #include "qapi/error.h"
-#include "sysemu/tpm.h"
+#include "system/tpm.h"
 #include "qemu/thread.h"
 #include "qemu/main-loop.h"
 #include "qemu/module.h"
diff --git a/backends/tpm/tpm_emulator.c b/backends/tpm/tpm_emulator.c
index aa05dab6aef..00fe015a94e 100644
--- a/backends/tpm/tpm_emulator.c
+++ b/backends/tpm/tpm_emulator.c
@@ -32,9 +32,9 @@
 #include "qemu/sockets.h"
 #include "qemu/lockable.h"
 #include "io/channel-socket.h"
-#include "sysemu/runstate.h"
-#include "sysemu/tpm_backend.h"
-#include "sysemu/tpm_util.h"
+#include "system/runstate.h"
+#include "system/tpm_backend.h"
+#include "system/tpm_util.h"
 #include "tpm_int.h"
 #include "tpm_ioctl.h"
 #include "migration/blocker.h"
diff --git a/backends/tpm/tpm_passthrough.c b/backends/tpm/tpm_passthrough.c
index 179697a3a94..09a6abf02d2 100644
--- a/backends/tpm/tpm_passthrough.c
+++ b/backends/tpm/tpm_passthrough.c
@@ -26,8 +26,8 @@
 #include "qemu/error-report.h"
 #include "qemu/module.h"
 #include "qemu/sockets.h"
-#include "sysemu/tpm_backend.h"
-#include "sysemu/tpm_util.h"
+#include "system/tpm_backend.h"
+#include "system/tpm_util.h"
 #include "tpm_int.h"
 #include "qapi/clone-visitor.h"
 #include "qapi/qapi-visit-tpm.h"
diff --git a/backends/tpm/tpm_util.c b/backends/tpm/tpm_util.c
index cf138551df1..f5feb48acf5 100644
--- a/backends/tpm/tpm_util.c
+++ b/backends/tpm/tpm_util.c
@@ -26,8 +26,8 @@
 #include "tpm_int.h"
 #include "exec/memory.h"
 #include "hw/qdev-properties.h"
-#include "sysemu/tpm_backend.h"
-#include "sysemu/tpm_util.h"
+#include "system/tpm_backend.h"
+#include "system/tpm_util.h"
 #include "trace.h"
 
 /* tpm backend property */
diff --git a/backends/vhost-user.c b/backends/vhost-user.c
index 94c6a82d526..d0e4d71a633 100644
--- a/backends/vhost-user.c
+++ b/backends/vhost-user.c
@@ -15,8 +15,8 @@
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "qom/object_interfaces.h"
-#include "sysemu/vhost-user-backend.h"
-#include "sysemu/kvm.h"
+#include "system/vhost-user-backend.h"
+#include "system/kvm.h"
 #include "io/channel-command.h"
 #include "hw/virtio/virtio-bus.h"
 
diff --git a/block.c b/block.c
index 7d90007cae8..f60606f2428 100644
--- a/block.c
+++ b/block.c
@@ -42,7 +42,7 @@
 #include "qapi/qmp/qstring.h"
 #include "qapi/qobject-output-visitor.h"
 #include "qapi/qapi-visit-block-core.h"
-#include "sysemu/block-backend.h"
+#include "system/block-backend.h"
 #include "qemu/notify.h"
 #include "qemu/option.h"
 #include "qemu/coroutine.h"
diff --git a/block/accounting.c b/block/accounting.c
index 2829745377a..3e46159569e 100644
--- a/block/accounting.c
+++ b/block/accounting.c
@@ -27,7 +27,7 @@
 #include "block/accounting.h"
 #include "block/block_int.h"
 #include "qemu/timer.h"
-#include "sysemu/qtest.h"
+#include "system/qtest.h"
 
 static QEMUClockType clock_type = QEMU_CLOCK_REALTIME;
 static const int qtest_latency_ns = NANOSECONDS_PER_SECOND / 1000;
diff --git a/block/backup.c b/block/backup.c
index a1292c01ec4..79652bf57bc 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -23,7 +23,7 @@
 #include "block/dirty-bitmap.h"
 #include "qapi/error.h"
 #include "qemu/cutils.h"
-#include "sysemu/block-backend.h"
+#include "system/block-backend.h"
 #include "qemu/bitmap.h"
 #include "qemu/error-report.h"
 
diff --git a/block/blkdebug.c b/block/blkdebug.c
index c95c818c388..f5008246085 100644
--- a/block/blkdebug.c
+++ b/block/blkdebug.c
@@ -37,7 +37,7 @@
 #include "qapi/qmp/qlist.h"
 #include "qapi/qmp/qstring.h"
 #include "qapi/qobject-input-visitor.h"
-#include "sysemu/qtest.h"
+#include "system/qtest.h"
 
 /* All APIs are thread-safe */
 
diff --git a/block/blkio.c b/block/blkio.c
index e0e765af636..003cb638323 100644
--- a/block/blkio.c
+++ b/block/blkio.c
@@ -18,7 +18,7 @@
 #include "qemu/error-report.h"
 #include "qapi/qmp/qdict.h"
 #include "qemu/module.h"
-#include "sysemu/block-backend.h"
+#include "system/block-backend.h"
 #include "exec/memory.h" /* for ram_block_discard_disable() */
 
 #include "block/block-io.h"
diff --git a/block/blkreplay.c b/block/blkreplay.c
index 792d980aa9d..16d8b12dd99 100644
--- a/block/blkreplay.c
+++ b/block/blkreplay.c
@@ -13,7 +13,7 @@
 #include "qemu/module.h"
 #include "block/block-io.h"
 #include "block/block_int.h"
-#include "sysemu/replay.h"
+#include "system/replay.h"
 #include "qapi/error.h"
 
 typedef struct Request {
diff --git a/block/block-backend.c b/block/block-backend.c
index 85bcdedcef6..c93a7525ad0 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -11,15 +11,15 @@
  */
 
 #include "qemu/osdep.h"
-#include "sysemu/block-backend.h"
+#include "system/block-backend.h"
 #include "block/block_int.h"
 #include "block/blockjob.h"
 #include "block/coroutines.h"
 #include "block/throttle-groups.h"
 #include "hw/qdev-core.h"
-#include "sysemu/blockdev.h"
-#include "sysemu/runstate.h"
-#include "sysemu/replay.h"
+#include "system/blockdev.h"
+#include "system/runstate.h"
+#include "system/replay.h"
 #include "qapi/error.h"
 #include "qapi/qapi-events-block.h"
 #include "qemu/id.h"
diff --git a/block/block-copy.c b/block/block-copy.c
index eddb0b81e00..1826c2e1c7b 100644
--- a/block/block-copy.c
+++ b/block/block-copy.c
@@ -20,7 +20,7 @@
 #include "block/block_int-io.h"
 #include "block/dirty-bitmap.h"
 #include "block/reqlist.h"
-#include "sysemu/block-backend.h"
+#include "system/block-backend.h"
 #include "qemu/units.h"
 #include "qemu/co-shared-resource.h"
 #include "qemu/coroutine.h"
diff --git a/block/block-ram-registrar.c b/block/block-ram-registrar.c
index 25dbafa789c..fcda2b86afb 100644
--- a/block/block-ram-registrar.c
+++ b/block/block-ram-registrar.c
@@ -5,8 +5,8 @@
  */
 
 #include "qemu/osdep.h"
-#include "sysemu/block-backend.h"
-#include "sysemu/block-ram-registrar.h"
+#include "system/block-backend.h"
+#include "system/block-ram-registrar.h"
 #include "qapi/error.h"
 
 static void ram_block_added(RAMBlockNotifier *n, void *host, size_t size,
diff --git a/block/commit.c b/block/commit.c
index 7c3fdcb0cae..5df3d05346e 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -20,7 +20,7 @@
 #include "qapi/error.h"
 #include "qemu/ratelimit.h"
 #include "qemu/memalign.h"
-#include "sysemu/block-backend.h"
+#include "system/block-backend.h"
 
 enum {
     /*
diff --git a/block/copy-before-write.c b/block/copy-before-write.c
index 81afeff1c72..c00bc2351b7 100644
--- a/block/copy-before-write.c
+++ b/block/copy-before-write.c
@@ -26,7 +26,7 @@
 #include "qemu/osdep.h"
 #include "qapi/qmp/qjson.h"
 
-#include "sysemu/block-backend.h"
+#include "system/block-backend.h"
 #include "qemu/cutils.h"
 #include "qapi/error.h"
 #include "block/block_int.h"
diff --git a/block/crypto.c b/block/crypto.c
index 80b2dba17a9..d4226cc68a4 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -22,7 +22,7 @@
 
 #include "block/block_int.h"
 #include "block/qdict.h"
-#include "sysemu/block-backend.h"
+#include "system/block-backend.h"
 #include "crypto/block.h"
 #include "qapi/opts-visitor.h"
 #include "qapi/qapi-visit-crypto.h"
diff --git a/block/export/export.c b/block/export/export.c
index 6d51ae8ed78..79c71ee2456 100644
--- a/block/export/export.c
+++ b/block/export/export.c
@@ -14,8 +14,8 @@
 #include "qemu/osdep.h"
 
 #include "block/block.h"
-#include "sysemu/block-backend.h"
-#include "sysemu/iothread.h"
+#include "system/block-backend.h"
+#include "system/iothread.h"
 #include "block/export.h"
 #include "block/fuse.h"
 #include "block/nbd.h"
diff --git a/block/export/fuse.c b/block/export/fuse.c
index 3307b640896..465cc9891d6 100644
--- a/block/export/fuse.c
+++ b/block/export/fuse.c
@@ -28,7 +28,7 @@
 #include "qapi/error.h"
 #include "qapi/qapi-commands-block.h"
 #include "qemu/main-loop.h"
-#include "sysemu/block-backend.h"
+#include "system/block-backend.h"
 
 #include <fuse.h>
 #include <fuse_lowlevel.h>
diff --git a/block/io.c b/block/io.c
index 301514c8808..d369b994dff 100644
--- a/block/io.c
+++ b/block/io.c
@@ -24,7 +24,7 @@
 
 #include "qemu/osdep.h"
 #include "trace.h"
-#include "sysemu/block-backend.h"
+#include "system/block-backend.h"
 #include "block/aio-wait.h"
 #include "block/blockjob.h"
 #include "block/blockjob_int.h"
@@ -37,7 +37,7 @@
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "qemu/main-loop.h"
-#include "sysemu/replay.h"
+#include "system/replay.h"
 
 /* Maximum bounce buffer for copy-on-read and write zeroes, in bytes */
 #define MAX_BOUNCE_BUFFER (32768 << BDRV_SECTOR_BITS)
diff --git a/block/io_uring.c b/block/io_uring.c
index d11b2051abd..f52b66b3407 100644
--- a/block/io_uring.c
+++ b/block/io_uring.c
@@ -17,7 +17,7 @@
 #include "qemu/coroutine.h"
 #include "qemu/defer-call.h"
 #include "qapi/error.h"
-#include "sysemu/block-backend.h"
+#include "system/block-backend.h"
 #include "trace.h"
 
 /* Only used for assertions.  */
diff --git a/block/iscsi.c b/block/iscsi.c
index 979bf90cb79..a5f89214263 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -28,7 +28,7 @@
 #include <poll.h>
 #include <math.h>
 #include <arpa/inet.h>
-#include "sysemu/sysemu.h"
+#include "system/system.h"
 #include "qemu/config-file.h"
 #include "qemu/error-report.h"
 #include "qemu/bitops.h"
@@ -41,7 +41,7 @@
 #include "qemu/module.h"
 #include "qemu/option.h"
 #include "qemu/uuid.h"
-#include "sysemu/replay.h"
+#include "system/replay.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-machine.h"
 #include "qapi/qmp/qdict.h"
diff --git a/block/linux-aio.c b/block/linux-aio.c
index e3b5ec9abae..194c8f434f1 100644
--- a/block/linux-aio.c
+++ b/block/linux-aio.c
@@ -16,7 +16,7 @@
 #include "qemu/coroutine.h"
 #include "qemu/defer-call.h"
 #include "qapi/error.h"
-#include "sysemu/block-backend.h"
+#include "system/block-backend.h"
 
 /* Only used for assertions.  */
 #include "qemu/coroutine_int.h"
diff --git a/block/mirror.c b/block/mirror.c
index 2afe700b4d6..a53582f17bb 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -19,7 +19,7 @@
 #include "block/blockjob_int.h"
 #include "block/block_int.h"
 #include "block/dirty-bitmap.h"
-#include "sysemu/block-backend.h"
+#include "system/block-backend.h"
 #include "qapi/error.h"
 #include "qemu/ratelimit.h"
 #include "qemu/bitmap.h"
diff --git a/block/monitor/block-hmp-cmds.c b/block/monitor/block-hmp-cmds.c
index bdf2eb50b68..1d312513fc4 100644
--- a/block/monitor/block-hmp-cmds.c
+++ b/block/monitor/block-hmp-cmds.c
@@ -37,8 +37,8 @@
 
 #include "qemu/osdep.h"
 #include "hw/boards.h"
-#include "sysemu/block-backend.h"
-#include "sysemu/blockdev.h"
+#include "system/block-backend.h"
+#include "system/blockdev.h"
 #include "qapi/qapi-commands-block.h"
 #include "qapi/qapi-commands-block-export.h"
 #include "qapi/qmp/qdict.h"
@@ -49,7 +49,7 @@
 #include "qemu/sockets.h"
 #include "qemu/cutils.h"
 #include "qemu/error-report.h"
-#include "sysemu/sysemu.h"
+#include "system/system.h"
 #include "monitor/monitor.h"
 #include "monitor/hmp.h"
 #include "block/nbd.h"
diff --git a/block/nfs.c b/block/nfs.c
index 0500f60c08f..7d34b587501 100644
--- a/block/nfs.c
+++ b/block/nfs.c
@@ -39,7 +39,7 @@
 #include "qemu/module.h"
 #include "qemu/option.h"
 #include "qemu/cutils.h"
-#include "sysemu/replay.h"
+#include "system/replay.h"
 #include "qapi/qapi-visit-block-core.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qstring.h"
diff --git a/block/null.c b/block/null.c
index 4730acc1eb2..81350558343 100644
--- a/block/null.c
+++ b/block/null.c
@@ -18,7 +18,7 @@
 #include "qemu/option.h"
 #include "block/block-io.h"
 #include "block/block_int.h"
-#include "sysemu/replay.h"
+#include "system/replay.h"
 
 #define NULL_OPT_LATENCY "latency-ns"
 #define NULL_OPT_ZEROES  "read-zeroes"
diff --git a/block/nvme.c b/block/nvme.c
index 3b588b139f6..5ba6a0c9c9b 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -26,8 +26,8 @@
 #include "qemu/vfio-helpers.h"
 #include "block/block-io.h"
 #include "block/block_int.h"
-#include "sysemu/block-backend.h"
-#include "sysemu/replay.h"
+#include "system/block-backend.h"
+#include "system/replay.h"
 #include "trace.h"
 
 #include "block/nvme.h"
diff --git a/block/parallels.c b/block/parallels.c
index 071b6dcaf8b..23751b28a9d 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -33,7 +33,7 @@
 #include "qapi/error.h"
 #include "block/block_int.h"
 #include "block/qdict.h"
-#include "sysemu/block-backend.h"
+#include "system/block-backend.h"
 #include "qemu/module.h"
 #include "qemu/option.h"
 #include "qapi/qmp/qdict.h"
diff --git a/block/qapi-sysemu.c b/block/qapi-system.c
similarity index 99%
rename from block/qapi-sysemu.c
rename to block/qapi-system.c
index e4282631d23..3277f37fd02 100644
--- a/block/qapi-sysemu.c
+++ b/block/qapi-system.c
@@ -36,8 +36,8 @@
 #include "qapi/error.h"
 #include "qapi/qapi-commands-block.h"
 #include "qapi/qmp/qdict.h"
-#include "sysemu/block-backend.h"
-#include "sysemu/blockdev.h"
+#include "system/block-backend.h"
+#include "system/blockdev.h"
 
 static BlockBackend *qmp_get_blk(const char *blk_name, const char *qdev_id,
                                  Error **errp)
diff --git a/block/qapi.c b/block/qapi.c
index 2b5793f1d9b..902ecb08e06 100644
--- a/block/qapi.c
+++ b/block/qapi.c
@@ -39,7 +39,7 @@
 #include "qapi/qmp/qnum.h"
 #include "qapi/qmp/qstring.h"
 #include "qemu/qemu-print.h"
-#include "sysemu/block-backend.h"
+#include "system/block-backend.h"
 
 BlockDeviceInfo *bdrv_block_device_info(BlockBackend *blk,
                                         BlockDriverState *bs,
diff --git a/block/qcow.c b/block/qcow.c
index 84d1cca2968..37be7e7cb43 100644
--- a/block/qcow.c
+++ b/block/qcow.c
@@ -27,7 +27,7 @@
 #include "qemu/error-report.h"
 #include "block/block_int.h"
 #include "block/qdict.h"
-#include "sysemu/block-backend.h"
+#include "system/block-backend.h"
 #include "qemu/module.h"
 #include "qemu/option.h"
 #include "qemu/bswap.h"
diff --git a/block/qcow2-snapshot.c b/block/qcow2-snapshot.c
index 92e47978bf9..1e8dc48be1c 100644
--- a/block/qcow2-snapshot.c
+++ b/block/qcow2-snapshot.c
@@ -23,7 +23,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "sysemu/block-backend.h"
+#include "system/block-backend.h"
 #include "qapi/error.h"
 #include "qcow2.h"
 #include "qemu/bswap.h"
diff --git a/block/qcow2.c b/block/qcow2.c
index 803ca73a2ff..d732162391e 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -25,7 +25,7 @@
 #include "qemu/osdep.h"
 
 #include "block/qdict.h"
-#include "sysemu/block-backend.h"
+#include "system/block-backend.h"
 #include "qemu/main-loop.h"
 #include "qemu/module.h"
 #include "qcow2.h"
diff --git a/block/qed.c b/block/qed.c
index fa5bc110855..8b335945461 100644
--- a/block/qed.c
+++ b/block/qed.c
@@ -23,7 +23,7 @@
 #include "qemu/memalign.h"
 #include "trace.h"
 #include "qed.h"
-#include "sysemu/block-backend.h"
+#include "system/block-backend.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/qapi-visit-block-core.h"
diff --git a/block/rbd.c b/block/rbd.c
index 04ed0e242e6..e8148566094 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -23,7 +23,7 @@
 #include "block/qdict.h"
 #include "crypto/secret.h"
 #include "qemu/cutils.h"
-#include "sysemu/replay.h"
+#include "system/replay.h"
 #include "qapi/qmp/qstring.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qjson.h"
diff --git a/block/replication.c b/block/replication.c
index 0415a5e8b78..2ce16f05898 100644
--- a/block/replication.c
+++ b/block/replication.c
@@ -19,7 +19,7 @@
 #include "block/blockjob.h"
 #include "block/block_int.h"
 #include "block/block_backup.h"
-#include "sysemu/block-backend.h"
+#include "system/block-backend.h"
 #include "qapi/error.h"
 #include "qapi/qmp/qdict.h"
 #include "block/replication.h"
diff --git a/block/snapshot-access.c b/block/snapshot-access.c
index 84d0d13f867..71ac83c01f0 100644
--- a/block/snapshot-access.c
+++ b/block/snapshot-access.c
@@ -22,7 +22,7 @@
 
 #include "qemu/osdep.h"
 
-#include "sysemu/block-backend.h"
+#include "system/block-backend.h"
 #include "qemu/cutils.h"
 #include "block/block_int.h"
 
diff --git a/block/snapshot.c b/block/snapshot.c
index 8fd17567773..d27afe7c0eb 100644
--- a/block/snapshot.c
+++ b/block/snapshot.c
@@ -30,7 +30,7 @@
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qstring.h"
 #include "qemu/option.h"
-#include "sysemu/block-backend.h"
+#include "system/block-backend.h"
 
 QemuOptsList internal_snapshot_opts = {
     .name = "snapshot",
diff --git a/block/stream.c b/block/stream.c
index 90762031931..9a06c0decb2 100644
--- a/block/stream.c
+++ b/block/stream.c
@@ -18,7 +18,7 @@
 #include "qapi/error.h"
 #include "qapi/qmp/qdict.h"
 #include "qemu/ratelimit.h"
-#include "sysemu/block-backend.h"
+#include "system/block-backend.h"
 #include "block/copy-on-read.h"
 
 enum {
diff --git a/block/throttle-groups.c b/block/throttle-groups.c
index f5c0fac5814..32553b39e39 100644
--- a/block/throttle-groups.c
+++ b/block/throttle-groups.c
@@ -23,13 +23,13 @@
  */
 
 #include "qemu/osdep.h"
-#include "sysemu/block-backend.h"
+#include "system/block-backend.h"
 #include "block/throttle-groups.h"
 #include "qemu/throttle-options.h"
 #include "qemu/main-loop.h"
 #include "qemu/queue.h"
 #include "qemu/thread.h"
-#include "sysemu/qtest.h"
+#include "system/qtest.h"
 #include "qapi/error.h"
 #include "qapi/qapi-visit-block-core.h"
 #include "qom/object.h"
diff --git a/block/vdi.c b/block/vdi.c
index 26f7638f1fc..a2da6ecab01 100644
--- a/block/vdi.c
+++ b/block/vdi.c
@@ -58,7 +58,7 @@
 #include "qapi/qapi-visit-block-core.h"
 #include "block/block_int.h"
 #include "block/qdict.h"
-#include "sysemu/block-backend.h"
+#include "system/block-backend.h"
 #include "qemu/module.h"
 #include "qemu/option.h"
 #include "qemu/bswap.h"
diff --git a/block/vhdx.c b/block/vhdx.c
index 5aa1a135062..42c919f51a8 100644
--- a/block/vhdx.c
+++ b/block/vhdx.c
@@ -19,7 +19,7 @@
 #include "qapi/error.h"
 #include "block/block_int.h"
 #include "block/qdict.h"
-#include "sysemu/block-backend.h"
+#include "system/block-backend.h"
 #include "qemu/module.h"
 #include "qemu/option.h"
 #include "qemu/crc32c.h"
diff --git a/block/vmdk.c b/block/vmdk.c
index 78f64336079..6ef266df873 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -26,7 +26,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "block/block_int.h"
-#include "sysemu/block-backend.h"
+#include "system/block-backend.h"
 #include "qapi/qmp/qdict.h"
 #include "qemu/error-report.h"
 #include "qemu/module.h"
diff --git a/block/vpc.c b/block/vpc.c
index d95a204612b..6489ee756ab 100644
--- a/block/vpc.c
+++ b/block/vpc.c
@@ -27,7 +27,7 @@
 #include "qapi/error.h"
 #include "block/block_int.h"
 #include "block/qdict.h"
-#include "sysemu/block-backend.h"
+#include "system/block-backend.h"
 #include "qemu/module.h"
 #include "qemu/option.h"
 #include "migration/blocker.h"
diff --git a/blockdev-nbd.c b/blockdev-nbd.c
index b36f41b7c5a..9e61fbaf2b2 100644
--- a/blockdev-nbd.c
+++ b/blockdev-nbd.c
@@ -10,8 +10,8 @@
  */
 
 #include "qemu/osdep.h"
-#include "sysemu/blockdev.h"
-#include "sysemu/block-backend.h"
+#include "system/blockdev.h"
+#include "system/block-backend.h"
 #include "hw/block/block.h"
 #include "qapi/error.h"
 #include "qapi/clone-visitor.h"
diff --git a/blockdev.c b/blockdev.c
index 6740663fda2..218024497b1 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -31,8 +31,8 @@
  */
 
 #include "qemu/osdep.h"
-#include "sysemu/block-backend.h"
-#include "sysemu/blockdev.h"
+#include "system/block-backend.h"
+#include "system/blockdev.h"
 #include "hw/block/block.h"
 #include "block/blockjob.h"
 #include "block/dirty-bitmap.h"
@@ -53,12 +53,12 @@
 #include "qapi/qmp/qerror.h"
 #include "qapi/qmp/qlist.h"
 #include "qapi/qobject-output-visitor.h"
-#include "sysemu/sysemu.h"
-#include "sysemu/iothread.h"
+#include "system/system.h"
+#include "system/iothread.h"
 #include "block/block_int.h"
 #include "block/trace.h"
-#include "sysemu/runstate.h"
-#include "sysemu/replay.h"
+#include "system/runstate.h"
+#include "system/replay.h"
 #include "qemu/cutils.h"
 #include "qemu/help_option.h"
 #include "qemu/main-loop.h"
diff --git a/blockjob.c b/blockjob.c
index d5f29e14af2..e94a840d7f9 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -29,7 +29,7 @@
 #include "block/blockjob_int.h"
 #include "block/block_int.h"
 #include "block/trace.h"
-#include "sysemu/block-backend.h"
+#include "system/block-backend.h"
 #include "qapi/error.h"
 #include "qapi/qapi-events-block-core.h"
 #include "qapi/qmp/qerror.h"
diff --git a/chardev/char-fe.c b/chardev/char-fe.c
index 8ac6bebb6f7..158a5f4f551 100644
--- a/chardev/char-fe.c
+++ b/chardev/char-fe.c
@@ -24,7 +24,7 @@
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
-#include "sysemu/replay.h"
+#include "system/replay.h"
 
 #include "chardev/char-fe.h"
 #include "chardev/char-io.h"
diff --git a/chardev/char-mux.c b/chardev/char-mux.c
index e13042d3810..d5f7e1a9cf5 100644
--- a/chardev/char-mux.c
+++ b/chardev/char-mux.c
@@ -28,7 +28,7 @@
 #include "qemu/option.h"
 #include "qemu/bitops.h"
 #include "chardev/char.h"
-#include "sysemu/block-backend.h"
+#include "system/block-backend.h"
 #include "qapi/qapi-commands-control.h"
 #include "chardev-internal.h"
 
diff --git a/chardev/char.c b/chardev/char.c
index d06698228a5..44ff116fcda 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -33,7 +33,7 @@
 #include "qapi/error.h"
 #include "qapi/qapi-commands-char.h"
 #include "qapi/qmp/qerror.h"
-#include "sysemu/replay.h"
+#include "system/replay.h"
 #include "qemu/help_option.h"
 #include "qemu/module.h"
 #include "qemu/option.h"
diff --git a/cpu-common.c b/cpu-common.c
index 0d607bbe493..4248b2d727e 100644
--- a/cpu-common.c
+++ b/cpu-common.c
@@ -21,7 +21,7 @@
 #include "qemu/main-loop.h"
 #include "exec/cpu-common.h"
 #include "hw/core/cpu.h"
-#include "sysemu/cpus.h"
+#include "system/cpus.h"
 #include "qemu/lockable.h"
 #include "trace/trace-root.h"
 
diff --git a/cpu-target.c b/cpu-target.c
index 2ae07a779ea..5480cfb7218 100644
--- a/cpu-target.c
+++ b/cpu-target.c
@@ -34,8 +34,8 @@
 #include "exec/address-spaces.h"
 #include "exec/memory.h"
 #endif
-#include "sysemu/cpus.h"
-#include "sysemu/tcg.h"
+#include "system/cpus.h"
+#include "system/tcg.h"
 #include "exec/tswap.h"
 #include "exec/replay-core.h"
 #include "exec/cpu-common.h"
diff --git a/dump/dump.c b/dump/dump.c
index 45e84428aea..15bbcc0c619 100644
--- a/dump/dump.c
+++ b/dump/dump.c
@@ -17,9 +17,9 @@
 #include "qemu/bswap.h"
 #include "exec/target_page.h"
 #include "monitor/monitor.h"
-#include "sysemu/dump.h"
-#include "sysemu/runstate.h"
-#include "sysemu/cpus.h"
+#include "system/dump.h"
+#include "system/runstate.h"
+#include "system/cpus.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-dump.h"
 #include "qapi/qapi-events-dump.h"
diff --git a/dump/win_dump.c b/dump/win_dump.c
index 0e4fe692ce0..2c2576672a5 100644
--- a/dump/win_dump.c
+++ b/dump/win_dump.c
@@ -9,7 +9,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "sysemu/dump.h"
+#include "system/dump.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "exec/cpu-defs.h"
diff --git a/event-loop-base.c b/event-loop-base.c
index d5be4dc6fcf..0cfb1c94962 100644
--- a/event-loop-base.c
+++ b/event-loop-base.c
@@ -15,7 +15,7 @@
 #include "qom/object_interfaces.h"
 #include "qapi/error.h"
 #include "block/thread-pool.h"
-#include "sysemu/event-loop-base.h"
+#include "system/event-loop-base.h"
 
 typedef struct {
     const char *name;
diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index b1def7e71d2..e366df12d4a 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -41,8 +41,8 @@
 #endif
 #include "hw/core/cpu.h"
 
-#include "sysemu/hw_accel.h"
-#include "sysemu/runstate.h"
+#include "system/hw_accel.h"
+#include "system/runstate.h"
 #include "exec/replay-core.h"
 #include "exec/hwaddr.h"
 
diff --git a/gdbstub/syscalls.c b/gdbstub/syscalls.c
index 4ddd5cae067..e855df21aba 100644
--- a/gdbstub/syscalls.c
+++ b/gdbstub/syscalls.c
@@ -13,7 +13,7 @@
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
 #include "semihosting/semihost.h"
-#include "sysemu/runstate.h"
+#include "system/runstate.h"
 #include "gdbstub/user.h"
 #include "gdbstub/syscalls.h"
 #include "gdbstub/commands.h"
diff --git a/gdbstub/system.c b/gdbstub/system.c
index c9f236e94f7..2d9fdff2fe0 100644
--- a/gdbstub/system.c
+++ b/gdbstub/system.c
@@ -19,9 +19,9 @@
 #include "gdbstub/commands.h"
 #include "exec/hwaddr.h"
 #include "exec/tb-flush.h"
-#include "sysemu/cpus.h"
-#include "sysemu/runstate.h"
-#include "sysemu/replay.h"
+#include "system/cpus.h"
+#include "system/runstate.h"
+#include "system/replay.h"
 #include "hw/core/cpu.h"
 #include "hw/cpu/cluster.h"
 #include "hw/boards.h"
diff --git a/hw/9pfs/9p-synth.c b/hw/9pfs/9p-synth.c
index 0ac79a500b4..2abaf3a2918 100644
--- a/hw/9pfs/9p-synth.c
+++ b/hw/9pfs/9p-synth.c
@@ -24,7 +24,7 @@
 #include "qemu/rcu.h"
 #include "qemu/rcu_queue.h"
 #include "qemu/cutils.h"
-#include "sysemu/qtest.h"
+#include "system/qtest.h"
 
 /* Root node for synth file system */
 static V9fsSynthNode synth_root = {
diff --git a/hw/9pfs/virtio-9p-device.c b/hw/9pfs/virtio-9p-device.c
index b764e4cd3db..4f30054cc32 100644
--- a/hw/9pfs/virtio-9p-device.c
+++ b/hw/9pfs/virtio-9p-device.c
@@ -26,7 +26,7 @@
 #include "hw/virtio/virtio-access.h"
 #include "qemu/iov.h"
 #include "qemu/module.h"
-#include "sysemu/qtest.h"
+#include "system/qtest.h"
 
 static void virtio_9p_push_and_notify(V9fsPDU *pdu)
 {
diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
index 72282b173ec..331de43dad4 100644
--- a/hw/acpi/aml-build.c
+++ b/hw/acpi/aml-build.c
@@ -24,7 +24,7 @@
 #include "hw/acpi/aml-build.h"
 #include "qemu/bswap.h"
 #include "qemu/bitops.h"
-#include "sysemu/numa.h"
+#include "system/numa.h"
 #include "hw/boards.h"
 #include "hw/acpi/tpm.h"
 #include "hw/pci/pci_host.h"
diff --git a/hw/acpi/core.c b/hw/acpi/core.c
index ec5e127d172..870391ed7c8 100644
--- a/hw/acpi/core.c
+++ b/hw/acpi/core.c
@@ -31,7 +31,7 @@
 #include "qemu/error-report.h"
 #include "qemu/module.h"
 #include "qemu/option.h"
-#include "sysemu/runstate.h"
+#include "system/runstate.h"
 #include "trace.h"
 
 struct acpi_table_header {
diff --git a/hw/acpi/cpu.c b/hw/acpi/cpu.c
index 5cb60ca8bc7..9d530a24da5 100644
--- a/hw/acpi/cpu.c
+++ b/hw/acpi/cpu.c
@@ -5,7 +5,7 @@
 #include "qapi/error.h"
 #include "qapi/qapi-events-acpi.h"
 #include "trace.h"
-#include "sysemu/numa.h"
+#include "system/numa.h"
 
 #define ACPI_CPU_SELECTOR_OFFSET_WR 0
 #define ACPI_CPU_FLAGS_OFFSET_RW 4
diff --git a/hw/acpi/erst.c b/hw/acpi/erst.c
index 5ef5ddccb68..536092039b8 100644
--- a/hw/acpi/erst.c
+++ b/hw/acpi/erst.c
@@ -24,7 +24,7 @@
 #include "hw/acpi/aml-build.h"
 #include "hw/acpi/bios-linker-loader.h"
 #include "exec/address-spaces.h"
-#include "sysemu/hostmem.h"
+#include "system/hostmem.h"
 #include "hw/acpi/erst.h"
 #include "trace.h"
 
diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
index 8c4706f8cff..dbcd0f53660 100644
--- a/hw/acpi/generic_event_device.c
+++ b/hw/acpi/generic_event_device.c
@@ -19,7 +19,7 @@
 #include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "qemu/error-report.h"
-#include "sysemu/runstate.h"
+#include "system/runstate.h"
 
 static const uint32_t ged_supported_events[] = {
     ACPI_GED_MEM_HOTPLUG_EVT,
diff --git a/hw/acpi/hmat.c b/hw/acpi/hmat.c
index 9b1662b6b8a..ca7b183d9eb 100644
--- a/hw/acpi/hmat.c
+++ b/hw/acpi/hmat.c
@@ -26,7 +26,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/units.h"
-#include "sysemu/numa.h"
+#include "system/numa.h"
 #include "hw/acpi/aml-build.h"
 #include "hw/acpi/hmat.h"
 
diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
index c15e5b82811..c7a735bf642 100644
--- a/hw/acpi/ich9.c
+++ b/hw/acpi/ich9.c
@@ -31,8 +31,8 @@
 #include "migration/vmstate.h"
 #include "qemu/timer.h"
 #include "hw/core/cpu.h"
-#include "sysemu/reset.h"
-#include "sysemu/runstate.h"
+#include "system/reset.h"
+#include "system/runstate.h"
 #include "hw/acpi/acpi.h"
 #include "hw/acpi/ich9_tco.h"
 #include "hw/acpi/ich9_timer.h"
diff --git a/hw/acpi/ich9_tco.c b/hw/acpi/ich9_tco.c
index 81606219f73..6300db65b72 100644
--- a/hw/acpi/ich9_tco.c
+++ b/hw/acpi/ich9_tco.c
@@ -8,7 +8,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "sysemu/watchdog.h"
+#include "system/watchdog.h"
 #include "hw/southbridge/ich9.h"
 #include "migration/vmstate.h"
 
diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
index 2bfaf5a38d3..85fbd1ab686 100644
--- a/hw/acpi/piix4.c
+++ b/hw/acpi/piix4.c
@@ -28,9 +28,9 @@
 #include "hw/acpi/acpi.h"
 #include "hw/acpi/pcihp.h"
 #include "hw/acpi/piix4.h"
-#include "sysemu/runstate.h"
-#include "sysemu/sysemu.h"
-#include "sysemu/xen.h"
+#include "system/runstate.h"
+#include "system/system.h"
+#include "system/xen.h"
 #include "qapi/error.h"
 #include "qemu/range.h"
 #include "hw/acpi/cpu_hotplug.h"
diff --git a/hw/acpi/vmgenid.c b/hw/acpi/vmgenid.c
index 9c2ca85cc7c..8f32c0c6165 100644
--- a/hw/acpi/vmgenid.c
+++ b/hw/acpi/vmgenid.c
@@ -20,7 +20,7 @@
 #include "hw/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
 #include "migration/vmstate.h"
-#include "sysemu/reset.h"
+#include "system/reset.h"
 
 void vmgenid_build_acpi(VmGenIdState *vms, GArray *table_data, GArray *guid,
                         BIOSLinker *linker, const char *oem_id)
diff --git a/hw/arm/allwinner-a10.c b/hw/arm/allwinner-a10.c
index 52327d92106..a829913f1b5 100644
--- a/hw/arm/allwinner-a10.c
+++ b/hw/arm/allwinner-a10.c
@@ -23,7 +23,7 @@
 #include "hw/sysbus.h"
 #include "hw/arm/allwinner-a10.h"
 #include "hw/misc/unimp.h"
-#include "sysemu/sysemu.h"
+#include "system/system.h"
 #include "hw/boards.h"
 #include "hw/usb/hcd-ohci.h"
 #include "hw/loader.h"
diff --git a/hw/arm/allwinner-h3.c b/hw/arm/allwinner-h3.c
index fd7638dbe83..2efced3f66a 100644
--- a/hw/arm/allwinner-h3.c
+++ b/hw/arm/allwinner-h3.c
@@ -28,7 +28,7 @@
 #include "hw/misc/unimp.h"
 #include "hw/usb/hcd-ehci.h"
 #include "hw/loader.h"
-#include "sysemu/sysemu.h"
+#include "system/system.h"
 #include "hw/arm/allwinner-h3.h"
 #include "target/arm/cpu-qom.h"
 #include "target/arm/gtimer.h"
diff --git a/hw/arm/allwinner-r40.c b/hw/arm/allwinner-r40.c
index c6f7cab1da0..47b3180f0ec 100644
--- a/hw/arm/allwinner-r40.c
+++ b/hw/arm/allwinner-r40.c
@@ -30,7 +30,7 @@
 #include "hw/misc/unimp.h"
 #include "hw/usb/hcd-ehci.h"
 #include "hw/loader.h"
-#include "sysemu/sysemu.h"
+#include "system/system.h"
 #include "hw/arm/allwinner-r40.h"
 #include "hw/misc/allwinner-r40-dramc.h"
 #include "target/arm/cpu-qom.h"
diff --git a/hw/arm/armv7m.c b/hw/arm/armv7m.c
index e20f719c9bd..74f4d36e61b 100644
--- a/hw/arm/armv7m.c
+++ b/hw/arm/armv7m.c
@@ -16,7 +16,7 @@
 #include "hw/qdev-properties.h"
 #include "hw/qdev-clock.h"
 #include "elf.h"
-#include "sysemu/reset.h"
+#include "system/reset.h"
 #include "qemu/error-report.h"
 #include "qemu/module.h"
 #include "qemu/log.h"
diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 556498f2a06..a18d4ed1fb1 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -23,13 +23,13 @@
 #include "hw/sensor/tmp105.h"
 #include "hw/misc/led.h"
 #include "hw/qdev-properties.h"
-#include "sysemu/block-backend.h"
-#include "sysemu/reset.h"
+#include "system/block-backend.h"
+#include "system/reset.h"
 #include "hw/loader.h"
 #include "qemu/error-report.h"
 #include "qemu/units.h"
 #include "hw/qdev-clock.h"
-#include "sysemu/sysemu.h"
+#include "system/system.h"
 
 static struct arm_boot_info aspeed_board_binfo = {
     .board_id = -1, /* device-tree-only board */
diff --git a/hw/arm/aspeed_ast10x0.c b/hw/arm/aspeed_ast10x0.c
index 9f98ad8e87a..e76c7100a1d 100644
--- a/hw/arm/aspeed_ast10x0.c
+++ b/hw/arm/aspeed_ast10x0.c
@@ -12,7 +12,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "exec/address-spaces.h"
-#include "sysemu/sysemu.h"
+#include "system/system.h"
 #include "hw/qdev-clock.h"
 #include "hw/misc/unimp.h"
 #include "hw/arm/aspeed_soc.h"
diff --git a/hw/arm/aspeed_ast2400.c b/hw/arm/aspeed_ast2400.c
index 3c1b4199452..8784b6e7930 100644
--- a/hw/arm/aspeed_ast2400.c
+++ b/hw/arm/aspeed_ast2400.c
@@ -20,7 +20,7 @@
 #include "qemu/error-report.h"
 #include "hw/i2c/aspeed_i2c.h"
 #include "net/net.h"
-#include "sysemu/sysemu.h"
+#include "system/system.h"
 #include "target/arm/cpu-qom.h"
 
 #define ASPEED_SOC_IOMEM_SIZE       0x00200000
diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c
index b5703bd064c..07210483bb2 100644
--- a/hw/arm/aspeed_ast2600.c
+++ b/hw/arm/aspeed_ast2600.c
@@ -15,7 +15,7 @@
 #include "qemu/error-report.h"
 #include "hw/i2c/aspeed_i2c.h"
 #include "net/net.h"
-#include "sysemu/sysemu.h"
+#include "system/system.h"
 #include "target/arm/cpu-qom.h"
 
 #define ASPEED_SOC_IOMEM_SIZE       0x00200000
diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
index 23571584b2f..fee37558372 100644
--- a/hw/arm/aspeed_ast27x0.c
+++ b/hw/arm/aspeed_ast27x0.c
@@ -18,7 +18,7 @@
 #include "qemu/error-report.h"
 #include "hw/i2c/aspeed_i2c.h"
 #include "net/net.h"
-#include "sysemu/sysemu.h"
+#include "system/system.h"
 #include "hw/intc/arm_gicv3.h"
 #include "qapi/qmp/qlist.h"
 #include "qemu/log.h"
diff --git a/hw/arm/bcm2835_peripherals.c b/hw/arm/bcm2835_peripherals.c
index ac153a96b9a..adc9730c2ed 100644
--- a/hw/arm/bcm2835_peripherals.c
+++ b/hw/arm/bcm2835_peripherals.c
@@ -15,7 +15,7 @@
 #include "hw/arm/bcm2835_peripherals.h"
 #include "hw/misc/bcm2835_mbox_defs.h"
 #include "hw/arm/raspi_platform.h"
-#include "sysemu/sysemu.h"
+#include "system/system.h"
 
 /* Peripheral base address on the VC (GPU) system bus */
 #define BCM2835_VC_PERI_BASE 0x7e000000
diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index 5301d8d318c..68fe8654e6c 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -14,15 +14,15 @@
 #include <libfdt.h>
 #include "hw/arm/boot.h"
 #include "hw/arm/linux-boot-if.h"
-#include "sysemu/kvm.h"
-#include "sysemu/tcg.h"
-#include "sysemu/sysemu.h"
-#include "sysemu/numa.h"
+#include "system/kvm.h"
+#include "system/tcg.h"
+#include "system/system.h"
+#include "system/numa.h"
 #include "hw/boards.h"
-#include "sysemu/reset.h"
+#include "system/reset.h"
 #include "hw/loader.h"
 #include "elf.h"
-#include "sysemu/device_tree.h"
+#include "system/device_tree.h"
 #include "qemu/config-file.h"
 #include "qemu/option.h"
 #include "qemu/units.h"
diff --git a/hw/arm/digic.c b/hw/arm/digic.c
index 6df55479773..5836619d9fe 100644
--- a/hw/arm/digic.c
+++ b/hw/arm/digic.c
@@ -25,7 +25,7 @@
 #include "qemu/module.h"
 #include "hw/arm/digic.h"
 #include "hw/qdev-properties.h"
-#include "sysemu/sysemu.h"
+#include "system/system.h"
 
 #define DIGIC4_TIMER_BASE(n)    (0xc0210000 + (n) * 0x100)
 
diff --git a/hw/arm/digic_boards.c b/hw/arm/digic_boards.c
index 4093af09cb2..2492fafeb85 100644
--- a/hw/arm/digic_boards.c
+++ b/hw/arm/digic_boards.c
@@ -31,7 +31,7 @@
 #include "hw/arm/digic.h"
 #include "hw/block/flash.h"
 #include "hw/loader.h"
-#include "sysemu/qtest.h"
+#include "system/qtest.h"
 #include "qemu/units.h"
 #include "qemu/cutils.h"
 
diff --git a/hw/arm/exynos4210.c b/hw/arm/exynos4210.c
index e3f1de26317..dd0edc81d5c 100644
--- a/hw/arm/exynos4210.c
+++ b/hw/arm/exynos4210.c
@@ -27,8 +27,8 @@
 #include "cpu.h"
 #include "hw/cpu/a9mpcore.h"
 #include "hw/irq.h"
-#include "sysemu/blockdev.h"
-#include "sysemu/sysemu.h"
+#include "system/blockdev.h"
+#include "system/system.h"
 #include "hw/sysbus.h"
 #include "hw/arm/boot.h"
 #include "hw/loader.h"
diff --git a/hw/arm/fby35.c b/hw/arm/fby35.c
index c9964bd283f..83d08e578b7 100644
--- a/hw/arm/fby35.c
+++ b/hw/arm/fby35.c
@@ -8,8 +8,8 @@
 #include "qemu/osdep.h"
 #include "qemu/units.h"
 #include "qapi/error.h"
-#include "sysemu/sysemu.h"
-#include "sysemu/block-backend.h"
+#include "system/system.h"
+#include "system/block-backend.h"
 #include "hw/boards.h"
 #include "hw/qdev-clock.h"
 #include "hw/arm/aspeed_soc.h"
diff --git a/hw/arm/fsl-imx25.c b/hw/arm/fsl-imx25.c
index 48763b03feb..58d818d0026 100644
--- a/hw/arm/fsl-imx25.c
+++ b/hw/arm/fsl-imx25.c
@@ -25,7 +25,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "hw/arm/fsl-imx25.h"
-#include "sysemu/sysemu.h"
+#include "system/system.h"
 #include "hw/qdev-properties.h"
 #include "chardev/char.h"
 #include "target/arm/cpu-qom.h"
diff --git a/hw/arm/fsl-imx31.c b/hw/arm/fsl-imx31.c
index 4b8d9b8e4fe..9de0f2148f6 100644
--- a/hw/arm/fsl-imx31.c
+++ b/hw/arm/fsl-imx31.c
@@ -22,7 +22,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "hw/arm/fsl-imx31.h"
-#include "sysemu/sysemu.h"
+#include "system/system.h"
 #include "exec/address-spaces.h"
 #include "hw/qdev-properties.h"
 #include "chardev/char.h"
diff --git a/hw/arm/fsl-imx6.c b/hw/arm/fsl-imx6.c
index 236d15bc9cb..7f56d68b931 100644
--- a/hw/arm/fsl-imx6.c
+++ b/hw/arm/fsl-imx6.c
@@ -26,7 +26,7 @@
 #include "hw/usb/imx-usb-phy.h"
 #include "hw/boards.h"
 #include "hw/qdev-properties.h"
-#include "sysemu/sysemu.h"
+#include "system/system.h"
 #include "chardev/char.h"
 #include "qemu/error-report.h"
 #include "qemu/module.h"
diff --git a/hw/arm/fsl-imx6ul.c b/hw/arm/fsl-imx6ul.c
index 1e0bbbb5d77..4aceefaa0f5 100644
--- a/hw/arm/fsl-imx6ul.c
+++ b/hw/arm/fsl-imx6ul.c
@@ -22,7 +22,7 @@
 #include "hw/misc/unimp.h"
 #include "hw/usb/imx-usb-phy.h"
 #include "hw/boards.h"
-#include "sysemu/sysemu.h"
+#include "system/system.h"
 #include "qemu/error-report.h"
 #include "qemu/module.h"
 #include "target/arm/cpu-qom.h"
diff --git a/hw/arm/fsl-imx7.c b/hw/arm/fsl-imx7.c
index 0310c15b0cf..4c388761013 100644
--- a/hw/arm/fsl-imx7.c
+++ b/hw/arm/fsl-imx7.c
@@ -23,7 +23,7 @@
 #include "hw/arm/fsl-imx7.h"
 #include "hw/misc/unimp.h"
 #include "hw/boards.h"
-#include "sysemu/sysemu.h"
+#include "system/system.h"
 #include "qemu/error-report.h"
 #include "qemu/module.h"
 #include "target/arm/cpu-qom.h"
diff --git a/hw/arm/highbank.c b/hw/arm/highbank.c
index f103921d495..495704d9726 100644
--- a/hw/arm/highbank.c
+++ b/hw/arm/highbank.c
@@ -25,8 +25,8 @@
 #include "hw/arm/boot.h"
 #include "hw/loader.h"
 #include "net/net.h"
-#include "sysemu/runstate.h"
-#include "sysemu/sysemu.h"
+#include "system/runstate.h"
+#include "system/system.h"
 #include "hw/boards.h"
 #include "qemu/error-report.h"
 #include "hw/char/pl011.h"
diff --git a/hw/arm/imx25_pdk.c b/hw/arm/imx25_pdk.c
index 7dfddd49e23..c9c2e5dd3b1 100644
--- a/hw/arm/imx25_pdk.c
+++ b/hw/arm/imx25_pdk.c
@@ -30,7 +30,7 @@
 #include "hw/arm/boot.h"
 #include "hw/boards.h"
 #include "qemu/error-report.h"
-#include "sysemu/qtest.h"
+#include "system/qtest.h"
 #include "hw/i2c/i2c.h"
 #include "qemu/cutils.h"
 
diff --git a/hw/arm/integratorcp.c b/hw/arm/integratorcp.c
index ee6c7e0c0d9..d85564893d6 100644
--- a/hw/arm/integratorcp.c
+++ b/hw/arm/integratorcp.c
@@ -17,8 +17,8 @@
 #include "hw/net/smc91c111.h"
 #include "net/net.h"
 #include "exec/address-spaces.h"
-#include "sysemu/runstate.h"
-#include "sysemu/sysemu.h"
+#include "system/runstate.h"
+#include "system/system.h"
 #include "qemu/log.h"
 #include "qemu/error-report.h"
 #include "hw/char/pl011.h"
diff --git a/hw/arm/kzm.c b/hw/arm/kzm.c
index fbd140e3833..08d2b3025cf 100644
--- a/hw/arm/kzm.c
+++ b/hw/arm/kzm.c
@@ -23,8 +23,8 @@
 #include "net/net.h"
 #include "hw/net/lan9118.h"
 #include "hw/char/serial-mm.h"
-#include "sysemu/qtest.h"
-#include "sysemu/sysemu.h"
+#include "system/qtest.h"
+#include "system/system.h"
 #include "qemu/cutils.h"
 
 /* Memory map for Kzm Emulation Baseboard:
diff --git a/hw/arm/mcimx6ul-evk.c b/hw/arm/mcimx6ul-evk.c
index 500427e94be..690cb64ef36 100644
--- a/hw/arm/mcimx6ul-evk.c
+++ b/hw/arm/mcimx6ul-evk.c
@@ -17,7 +17,7 @@
 #include "hw/boards.h"
 #include "hw/qdev-properties.h"
 #include "qemu/error-report.h"
-#include "sysemu/qtest.h"
+#include "system/qtest.h"
 
 static void mcimx6ul_evk_init(MachineState *machine)
 {
diff --git a/hw/arm/mcimx7d-sabre.c b/hw/arm/mcimx7d-sabre.c
index 693a1023b6c..b3e8e50779f 100644
--- a/hw/arm/mcimx7d-sabre.c
+++ b/hw/arm/mcimx7d-sabre.c
@@ -19,7 +19,7 @@
 #include "hw/boards.h"
 #include "hw/qdev-properties.h"
 #include "qemu/error-report.h"
-#include "sysemu/qtest.h"
+#include "system/qtest.h"
 
 static void mcimx7d_sabre_init(MachineState *machine)
 {
diff --git a/hw/arm/microbit.c b/hw/arm/microbit.c
index 50df3620882..374fbcb3618 100644
--- a/hw/arm/microbit.c
+++ b/hw/arm/microbit.c
@@ -12,7 +12,7 @@
 #include "qapi/error.h"
 #include "hw/boards.h"
 #include "hw/arm/boot.h"
-#include "sysemu/sysemu.h"
+#include "system/system.h"
 #include "exec/address-spaces.h"
 
 #include "hw/arm/nrf51_soc.h"
diff --git a/hw/arm/mps2-tz.c b/hw/arm/mps2-tz.c
index 8edf57a66d4..0136e419bfd 100644
--- a/hw/arm/mps2-tz.c
+++ b/hw/arm/mps2-tz.c
@@ -55,8 +55,8 @@
 #include "hw/or-irq.h"
 #include "hw/boards.h"
 #include "exec/address-spaces.h"
-#include "sysemu/sysemu.h"
-#include "sysemu/reset.h"
+#include "system/system.h"
+#include "system/reset.h"
 #include "hw/misc/unimp.h"
 #include "hw/char/cmsdk-apb-uart.h"
 #include "hw/timer/cmsdk-apb-timer.h"
diff --git a/hw/arm/mps2.c b/hw/arm/mps2.c
index 50919ee46d7..efb3500742f 100644
--- a/hw/arm/mps2.c
+++ b/hw/arm/mps2.c
@@ -34,7 +34,7 @@
 #include "hw/or-irq.h"
 #include "hw/boards.h"
 #include "exec/address-spaces.h"
-#include "sysemu/sysemu.h"
+#include "system/system.h"
 #include "hw/qdev-properties.h"
 #include "hw/misc/unimp.h"
 #include "hw/char/cmsdk-apb-uart.h"
diff --git a/hw/arm/mps3r.c b/hw/arm/mps3r.c
index 4d55a6564c6..2b104671db8 100644
--- a/hw/arm/mps3r.c
+++ b/hw/arm/mps3r.c
@@ -30,7 +30,7 @@
 #include "qapi/qmp/qlist.h"
 #include "exec/address-spaces.h"
 #include "cpu.h"
-#include "sysemu/sysemu.h"
+#include "system/system.h"
 #include "hw/boards.h"
 #include "hw/or-irq.h"
 #include "hw/qdev-clock.h"
diff --git a/hw/arm/msf2-soc.c b/hw/arm/msf2-soc.c
index 5d7c3f2e5a0..0f0ac46dab5 100644
--- a/hw/arm/msf2-soc.c
+++ b/hw/arm/msf2-soc.c
@@ -30,7 +30,7 @@
 #include "hw/arm/msf2-soc.h"
 #include "hw/misc/unimp.h"
 #include "hw/qdev-clock.h"
-#include "sysemu/sysemu.h"
+#include "system/system.h"
 
 #define MSF2_TIMER_BASE       0x40004000
 #define MSF2_SYSREG_BASE      0x40038000
diff --git a/hw/arm/musca.c b/hw/arm/musca.c
index e2c9d49af58..3c3b534cb72 100644
--- a/hw/arm/musca.c
+++ b/hw/arm/musca.c
@@ -23,7 +23,7 @@
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "exec/address-spaces.h"
-#include "sysemu/sysemu.h"
+#include "system/system.h"
 #include "hw/arm/boot.h"
 #include "hw/arm/armsse.h"
 #include "hw/boards.h"
diff --git a/hw/arm/musicpal.c b/hw/arm/musicpal.c
index 33ece06bbd6..a712ff954bd 100644
--- a/hw/arm/musicpal.c
+++ b/hw/arm/musicpal.c
@@ -16,7 +16,7 @@
 #include "migration/vmstate.h"
 #include "hw/arm/boot.h"
 #include "net/net.h"
-#include "sysemu/sysemu.h"
+#include "system/system.h"
 #include "hw/boards.h"
 #include "hw/char/serial-mm.h"
 #include "qemu/timer.h"
@@ -29,9 +29,9 @@
 #include "hw/irq.h"
 #include "hw/or-irq.h"
 #include "hw/audio/wm8750.h"
-#include "sysemu/block-backend.h"
-#include "sysemu/runstate.h"
-#include "sysemu/dma.h"
+#include "system/block-backend.h"
+#include "system/runstate.h"
+#include "system/dma.h"
 #include "ui/pixel_ops.h"
 #include "qemu/cutils.h"
 #include "qom/object.h"
diff --git a/hw/arm/npcm7xx.c b/hw/arm/npcm7xx.c
index 2960b63b596..49ea8f949bf 100644
--- a/hw/arm/npcm7xx.c
+++ b/hw/arm/npcm7xx.c
@@ -26,7 +26,7 @@
 #include "qapi/error.h"
 #include "qemu/bswap.h"
 #include "qemu/units.h"
-#include "sysemu/sysemu.h"
+#include "system/system.h"
 #include "target/arm/cpu-qom.h"
 
 /*
diff --git a/hw/arm/npcm7xx_boards.c b/hw/arm/npcm7xx_boards.c
index e229efb4472..7727e0dc4bb 100644
--- a/hw/arm/npcm7xx_boards.c
+++ b/hw/arm/npcm7xx_boards.c
@@ -27,9 +27,9 @@
 #include "qapi/error.h"
 #include "qemu/datadir.h"
 #include "qemu/units.h"
-#include "sysemu/blockdev.h"
-#include "sysemu/sysemu.h"
-#include "sysemu/block-backend.h"
+#include "system/blockdev.h"
+#include "system/system.h"
+#include "system/block-backend.h"
 #include "qemu/error-report.h"
 
 
diff --git a/hw/arm/omap1.c b/hw/arm/omap1.c
index 25030c7e404..f3a0ac40e48 100644
--- a/hw/arm/omap1.c
+++ b/hw/arm/omap1.c
@@ -29,13 +29,13 @@
 #include "hw/qdev-properties.h"
 #include "hw/arm/boot.h"
 #include "hw/arm/omap.h"
-#include "sysemu/blockdev.h"
-#include "sysemu/sysemu.h"
+#include "system/blockdev.h"
+#include "system/system.h"
 #include "hw/arm/soc_dma.h"
-#include "sysemu/qtest.h"
-#include "sysemu/reset.h"
-#include "sysemu/runstate.h"
-#include "sysemu/rtc.h"
+#include "system/qtest.h"
+#include "system/reset.h"
+#include "system/runstate.h"
+#include "system/rtc.h"
 #include "qemu/range.h"
 #include "hw/sysbus.h"
 #include "qemu/cutils.h"
diff --git a/hw/arm/omap_sx1.c b/hw/arm/omap_sx1.c
index 62d7915fb8f..623ebd66395 100644
--- a/hw/arm/omap_sx1.c
+++ b/hw/arm/omap_sx1.c
@@ -33,7 +33,7 @@
 #include "hw/boards.h"
 #include "hw/arm/boot.h"
 #include "hw/block/flash.h"
-#include "sysemu/qtest.h"
+#include "system/qtest.h"
 #include "exec/address-spaces.h"
 #include "qemu/cutils.h"
 #include "qemu/error-report.h"
diff --git a/hw/arm/raspi4b.c b/hw/arm/raspi4b.c
index 85877880fc7..1264e0d6eed 100644
--- a/hw/arm/raspi4b.c
+++ b/hw/arm/raspi4b.c
@@ -15,7 +15,7 @@
 #include "hw/display/bcm2835_fb.h"
 #include "hw/registerfields.h"
 #include "qemu/error-report.h"
-#include "sysemu/device_tree.h"
+#include "system/device_tree.h"
 #include "hw/boards.h"
 #include "hw/loader.h"
 #include "hw/arm/boot.h"
diff --git a/hw/arm/realview.c b/hw/arm/realview.c
index b186f965c68..9900a98f3b8 100644
--- a/hw/arm/realview.c
+++ b/hw/arm/realview.c
@@ -19,7 +19,7 @@
 #include "hw/pci/pci.h"
 #include "hw/qdev-core.h"
 #include "net/net.h"
-#include "sysemu/sysemu.h"
+#include "system/system.h"
 #include "hw/boards.h"
 #include "hw/i2c/i2c.h"
 #include "qemu/error-report.h"
diff --git a/hw/arm/sabrelite.c b/hw/arm/sabrelite.c
index 56f184b9ae7..1eb47042eca 100644
--- a/hw/arm/sabrelite.c
+++ b/hw/arm/sabrelite.c
@@ -17,7 +17,7 @@
 #include "hw/boards.h"
 #include "hw/qdev-properties.h"
 #include "qemu/error-report.h"
-#include "sysemu/qtest.h"
+#include "system/qtest.h"
 
 static struct arm_boot_info sabrelite_binfo = {
     /* DDR memory start */
diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index e3195d54497..581655d7716 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -23,11 +23,11 @@
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "qemu/units.h"
-#include "sysemu/device_tree.h"
-#include "sysemu/kvm.h"
-#include "sysemu/numa.h"
-#include "sysemu/runstate.h"
-#include "sysemu/sysemu.h"
+#include "system/device_tree.h"
+#include "system/kvm.h"
+#include "system/numa.h"
+#include "system/runstate.h"
+#include "system/system.h"
 #include "exec/hwaddr.h"
 #include "kvm_arm.h"
 #include "hw/arm/boot.h"
diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
index e31884b23e9..1fee37a7c13 100644
--- a/hw/arm/stellaris.c
+++ b/hw/arm/stellaris.c
@@ -20,7 +20,7 @@
 #include "hw/boards.h"
 #include "qemu/log.h"
 #include "exec/address-spaces.h"
-#include "sysemu/sysemu.h"
+#include "system/system.h"
 #include "hw/arm/armv7m.h"
 #include "hw/char/pl011.h"
 #include "hw/input/stellaris_gamepad.h"
diff --git a/hw/arm/stm32f100_soc.c b/hw/arm/stm32f100_soc.c
index 808b783515d..53b56364525 100644
--- a/hw/arm/stm32f100_soc.c
+++ b/hw/arm/stm32f100_soc.c
@@ -32,7 +32,7 @@
 #include "hw/qdev-properties.h"
 #include "hw/qdev-clock.h"
 #include "hw/misc/unimp.h"
-#include "sysemu/sysemu.h"
+#include "system/system.h"
 
 /* stm32f100_soc implementation is derived from stm32f205_soc */
 
diff --git a/hw/arm/stm32f205_soc.c b/hw/arm/stm32f205_soc.c
index a451e21f59c..47a54e592be 100644
--- a/hw/arm/stm32f205_soc.c
+++ b/hw/arm/stm32f205_soc.c
@@ -30,7 +30,7 @@
 #include "hw/arm/stm32f205_soc.h"
 #include "hw/qdev-properties.h"
 #include "hw/qdev-clock.h"
-#include "sysemu/sysemu.h"
+#include "system/system.h"
 
 /* At the moment only Timer 2 to 5 are modelled */
 static const uint32_t timer_addr[STM_NUM_TIMERS] = { 0x40000000, 0x40000400,
diff --git a/hw/arm/stm32f405_soc.c b/hw/arm/stm32f405_soc.c
index 72ae62156f3..18d8824f29d 100644
--- a/hw/arm/stm32f405_soc.c
+++ b/hw/arm/stm32f405_soc.c
@@ -25,7 +25,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "exec/address-spaces.h"
-#include "sysemu/sysemu.h"
+#include "system/system.h"
 #include "hw/arm/stm32f405_soc.h"
 #include "hw/qdev-clock.h"
 #include "hw/misc/unimp.h"
diff --git a/hw/arm/stm32l4x5_soc.c b/hw/arm/stm32l4x5_soc.c
index 16e3505dcb8..dbf75329f7d 100644
--- a/hw/arm/stm32l4x5_soc.c
+++ b/hw/arm/stm32l4x5_soc.c
@@ -25,7 +25,7 @@
 #include "qemu/units.h"
 #include "qapi/error.h"
 #include "exec/address-spaces.h"
-#include "sysemu/sysemu.h"
+#include "system/system.h"
 #include "hw/or-irq.h"
 #include "hw/arm/stm32l4x5_soc.h"
 #include "hw/char/stm32l4x5_usart.h"
diff --git a/hw/arm/strongarm.c b/hw/arm/strongarm.c
index 4c4ff21e804..051b1d87a1d 100644
--- a/hw/arm/strongarm.c
+++ b/hw/arm/strongarm.c
@@ -38,8 +38,8 @@
 #include "hw/arm/boot.h"
 #include "chardev/char-fe.h"
 #include "chardev/char-serial.h"
-#include "sysemu/sysemu.h"
-#include "sysemu/rtc.h"
+#include "system/system.h"
+#include "system/rtc.h"
 #include "hw/ssi/ssi.h"
 #include "qapi/error.h"
 #include "qemu/cutils.h"
diff --git a/hw/arm/versatilepb.c b/hw/arm/versatilepb.c
index d48235453e4..bc4522989ec 100644
--- a/hw/arm/versatilepb.c
+++ b/hw/arm/versatilepb.c
@@ -14,7 +14,7 @@
 #include "hw/arm/boot.h"
 #include "hw/net/smc91c111.h"
 #include "net/net.h"
-#include "sysemu/sysemu.h"
+#include "system/system.h"
 #include "hw/pci/pci.h"
 #include "hw/i2c/i2c.h"
 #include "hw/i2c/arm_sbcon_i2c.h"
diff --git a/hw/arm/vexpress.c b/hw/arm/vexpress.c
index de815d84cc6..42c67034061 100644
--- a/hw/arm/vexpress.c
+++ b/hw/arm/vexpress.c
@@ -30,11 +30,11 @@
 #include "hw/net/lan9118.h"
 #include "hw/i2c/i2c.h"
 #include "net/net.h"
-#include "sysemu/sysemu.h"
+#include "system/system.h"
 #include "hw/boards.h"
 #include "hw/loader.h"
 #include "hw/block/flash.h"
-#include "sysemu/device_tree.h"
+#include "system/device_tree.h"
 #include "qemu/error-report.h"
 #include <libfdt.h>
 #include "hw/char/pl011.h"
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 620992c92c1..94c3248212a 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -51,9 +51,9 @@
 #include "hw/intc/arm_gicv3_its_common.h"
 #include "hw/mem/nvdimm.h"
 #include "hw/platform-bus.h"
-#include "sysemu/numa.h"
-#include "sysemu/reset.h"
-#include "sysemu/tpm.h"
+#include "system/numa.h"
+#include "system/reset.h"
+#include "system/tpm.h"
 #include "migration/vmstate.h"
 #include "hw/acpi/ghes.h"
 #include "hw/acpi/viot.h"
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 333eaf67ea3..f9b33808157 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -42,14 +42,14 @@
 #include "hw/vfio/vfio-amd-xgbe.h"
 #include "hw/display/ramfb.h"
 #include "net/net.h"
-#include "sysemu/device_tree.h"
-#include "sysemu/numa.h"
-#include "sysemu/runstate.h"
-#include "sysemu/tpm.h"
-#include "sysemu/tcg.h"
-#include "sysemu/kvm.h"
-#include "sysemu/hvf.h"
-#include "sysemu/qtest.h"
+#include "system/device_tree.h"
+#include "system/numa.h"
+#include "system/runstate.h"
+#include "system/tpm.h"
+#include "system/tcg.h"
+#include "system/kvm.h"
+#include "system/hvf.h"
+#include "system/qtest.h"
 #include "hw/loader.h"
 #include "qapi/error.h"
 #include "qemu/bitops.h"
diff --git a/hw/arm/xen-pvh.c b/hw/arm/xen-pvh.c
index 33f0dd5982d..d1509bd235d 100644
--- a/hw/arm/xen-pvh.c
+++ b/hw/arm/xen-pvh.c
@@ -8,7 +8,7 @@
 #include "qemu/error-report.h"
 #include "qapi/qapi-commands-migration.h"
 #include "hw/boards.h"
-#include "sysemu/sysemu.h"
+#include "system/system.h"
 #include "hw/xen/xen-pvh-common.h"
 #include "hw/xen/arch_hvm.h"
 
diff --git a/hw/arm/xen-stubs.c b/hw/arm/xen-stubs.c
index 4ac6a56a96f..34beb8b08cb 100644
--- a/hw/arm/xen-stubs.c
+++ b/hw/arm/xen-stubs.c
@@ -8,7 +8,7 @@
 #include "qemu/error-report.h"
 #include "qapi/qapi-commands-migration.h"
 #include "hw/boards.h"
-#include "sysemu/sysemu.h"
+#include "system/system.h"
 #include "hw/xen/xen-hvm-common.h"
 #include "hw/xen/arch_hvm.h"
 
diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
index fde4d946b7c..8477b828745 100644
--- a/hw/arm/xilinx_zynq.c
+++ b/hw/arm/xilinx_zynq.c
@@ -21,7 +21,7 @@
 #include "hw/sysbus.h"
 #include "hw/arm/boot.h"
 #include "net/net.h"
-#include "sysemu/sysemu.h"
+#include "system/system.h"
 #include "hw/boards.h"
 #include "hw/block/flash.h"
 #include "hw/loader.h"
@@ -35,7 +35,7 @@
 #include "hw/cpu/a9mpcore.h"
 #include "hw/qdev-clock.h"
 #include "hw/misc/unimp.h"
-#include "sysemu/reset.h"
+#include "system/reset.h"
 #include "qom/object.h"
 #include "exec/tswap.h"
 #include "target/arm/cpu-qom.h"
diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
index 8b12d3e7cb8..1401d37959e 100644
--- a/hw/arm/xlnx-versal-virt.c
+++ b/hw/arm/xlnx-versal-virt.c
@@ -12,7 +12,7 @@
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
-#include "sysemu/device_tree.h"
+#include "system/device_tree.h"
 #include "hw/block/flash.h"
 #include "hw/boards.h"
 #include "hw/sysbus.h"
diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index 3adbe7b1fbf..6eb8acf4f1d 100644
--- a/hw/arm/xlnx-versal.c
+++ b/hw/arm/xlnx-versal.c
@@ -16,8 +16,8 @@
 #include "qemu/module.h"
 #include "hw/sysbus.h"
 #include "net/net.h"
-#include "sysemu/sysemu.h"
-#include "sysemu/kvm.h"
+#include "system/system.h"
+#include "system/kvm.h"
 #include "hw/arm/boot.h"
 #include "kvm_arm.h"
 #include "hw/misc/unimp.h"
diff --git a/hw/arm/xlnx-zcu102.c b/hw/arm/xlnx-zcu102.c
index 4667cb333ca..70fb444bbd9 100644
--- a/hw/arm/xlnx-zcu102.c
+++ b/hw/arm/xlnx-zcu102.c
@@ -22,7 +22,7 @@
 #include "hw/boards.h"
 #include "qemu/error-report.h"
 #include "qemu/log.h"
-#include "sysemu/device_tree.h"
+#include "system/device_tree.h"
 #include "qom/object.h"
 #include "net/can_emu.h"
 #include "audio/audio.h"
diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
index 1082c62c30f..3974392946f 100644
--- a/hw/arm/xlnx-zynqmp.c
+++ b/hw/arm/xlnx-zynqmp.c
@@ -22,8 +22,8 @@
 #include "hw/intc/arm_gic_common.h"
 #include "hw/misc/unimp.h"
 #include "hw/boards.h"
-#include "sysemu/kvm.h"
-#include "sysemu/sysemu.h"
+#include "system/kvm.h"
+#include "system/system.h"
 #include "kvm_arm.h"
 #include "target/arm/cpu-qom.h"
 #include "target/arm/gtimer.h"
diff --git a/hw/audio/ac97.c b/hw/audio/ac97.c
index 8033bbbaed4..667286207c1 100644
--- a/hw/audio/ac97.c
+++ b/hw/audio/ac97.c
@@ -24,7 +24,7 @@
 #include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "qemu/module.h"
-#include "sysemu/dma.h"
+#include "system/dma.h"
 #include "qom/object.h"
 #include "ac97.h"
 
diff --git a/hw/audio/es1370.c b/hw/audio/es1370.c
index 6170425a5a1..513f987cc4b 100644
--- a/hw/audio/es1370.c
+++ b/hw/audio/es1370.c
@@ -32,7 +32,7 @@
 #include "migration/vmstate.h"
 #include "qemu/cutils.h"
 #include "qemu/module.h"
-#include "sysemu/dma.h"
+#include "system/dma.h"
 #include "qom/object.h"
 #include "trace.h"
 
diff --git a/hw/audio/intel-hda.c b/hw/audio/intel-hda.c
index 3e4a7552287..fe9f4058fea 100644
--- a/hw/audio/intel-hda.c
+++ b/hw/audio/intel-hda.c
@@ -30,7 +30,7 @@
 #include "intel-hda.h"
 #include "migration/vmstate.h"
 #include "intel-hda-defs.h"
-#include "sysemu/dma.h"
+#include "system/dma.h"
 #include "qapi/error.h"
 #include "qom/object.h"
 
diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
index e2b112e0593..4c89ed3fc97 100644
--- a/hw/audio/virtio-snd.c
+++ b/hw/audio/virtio-snd.c
@@ -20,7 +20,7 @@
 #include "qemu/log.h"
 #include "qemu/error-report.h"
 #include "qemu/lockable.h"
-#include "sysemu/runstate.h"
+#include "system/runstate.h"
 #include "trace.h"
 #include "qapi/error.h"
 #include "hw/audio/virtio-snd.h"
diff --git a/hw/avr/atmega.c b/hw/avr/atmega.c
index ce630ec572f..1f38fa21c8b 100644
--- a/hw/avr/atmega.c
+++ b/hw/avr/atmega.c
@@ -14,7 +14,7 @@
 #include "qapi/error.h"
 #include "exec/memory.h"
 #include "exec/address-spaces.h"
-#include "sysemu/sysemu.h"
+#include "system/system.h"
 #include "hw/qdev-properties.h"
 #include "hw/sysbus.h"
 #include "qom/object.h"
diff --git a/hw/block/block.c b/hw/block/block.c
index 3ceca7dce69..1d405e02bf8 100644
--- a/hw/block/block.c
+++ b/hw/block/block.c
@@ -9,8 +9,8 @@
 
 #include "qemu/osdep.h"
 #include "block/block_int-common.h"
-#include "sysemu/blockdev.h"
-#include "sysemu/block-backend.h"
+#include "system/blockdev.h"
+#include "system/block-backend.h"
 #include "hw/block/block.h"
 #include "qapi/error.h"
 #include "qapi/qapi-types-block.h"
diff --git a/hw/block/dataplane/xen-block.c b/hw/block/dataplane/xen-block.c
index 98501e6885e..48c2e315f31 100644
--- a/hw/block/dataplane/xen-block.c
+++ b/hw/block/dataplane/xen-block.c
@@ -27,8 +27,8 @@
 #include "hw/xen/xen.h"
 #include "hw/block/xen_blkif.h"
 #include "hw/xen/interface/io/ring.h"
-#include "sysemu/block-backend.h"
-#include "sysemu/iothread.h"
+#include "system/block-backend.h"
+#include "system/iothread.h"
 #include "xen-block.h"
 
 typedef struct XenBlockRequest {
diff --git a/hw/block/fdc-isa.c b/hw/block/fdc-isa.c
index 2b9f667fe44..4d9b6d53d3d 100644
--- a/hw/block/fdc-isa.c
+++ b/hw/block/fdc-isa.c
@@ -39,9 +39,9 @@
 #include "hw/qdev-properties-system.h"
 #include "migration/vmstate.h"
 #include "hw/block/block.h"
-#include "sysemu/block-backend.h"
-#include "sysemu/blockdev.h"
-#include "sysemu/sysemu.h"
+#include "system/block-backend.h"
+#include "system/blockdev.h"
+#include "system/system.h"
 #include "exec/ioport.h"
 #include "qemu/log.h"
 #include "qemu/main-loop.h"
diff --git a/hw/block/fdc.c b/hw/block/fdc.c
index 57d68448063..3790d5685f3 100644
--- a/hw/block/fdc.c
+++ b/hw/block/fdc.c
@@ -39,9 +39,9 @@
 #include "hw/qdev-properties-system.h"
 #include "migration/vmstate.h"
 #include "hw/block/block.h"
-#include "sysemu/block-backend.h"
-#include "sysemu/blockdev.h"
-#include "sysemu/sysemu.h"
+#include "system/block-backend.h"
+#include "system/blockdev.h"
+#include "system/system.h"
 #include "qemu/log.h"
 #include "qemu/main-loop.h"
 #include "qemu/module.h"
diff --git a/hw/block/hd-geometry.c b/hw/block/hd-geometry.c
index 2b0af4430f0..f3939e73f42 100644
--- a/hw/block/hd-geometry.c
+++ b/hw/block/hd-geometry.c
@@ -31,7 +31,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "sysemu/block-backend.h"
+#include "system/block-backend.h"
 #include "qapi/qapi-types-block.h"
 #include "qemu/bswap.h"
 #include "hw/block/block.h"
diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
index ca97365926b..bc055c9d85e 100644
--- a/hw/block/m25p80.c
+++ b/hw/block/m25p80.c
@@ -23,7 +23,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/units.h"
-#include "sysemu/block-backend.h"
+#include "system/block-backend.h"
 #include "hw/block/block.h"
 #include "hw/block/flash.h"
 #include "hw/qdev-properties.h"
diff --git a/hw/block/nand.c b/hw/block/nand.c
index b6e6bfac236..385deb2a918 100644
--- a/hw/block/nand.c
+++ b/hw/block/nand.c
@@ -23,7 +23,7 @@
 #include "hw/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
 #include "hw/block/flash.h"
-#include "sysemu/block-backend.h"
+#include "system/block-backend.h"
 #include "migration/vmstate.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
index 20f4fc67a03..26bf6e46016 100644
--- a/hw/block/pflash_cfi01.c
+++ b/hw/block/pflash_cfi01.c
@@ -41,7 +41,7 @@
 #include "hw/block/flash.h"
 #include "hw/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
-#include "sysemu/block-backend.h"
+#include "system/block-backend.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "qemu/bitops.h"
@@ -50,8 +50,8 @@
 #include "qemu/option.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
-#include "sysemu/blockdev.h"
-#include "sysemu/runstate.h"
+#include "system/blockdev.h"
+#include "system/runstate.h"
 #include "trace.h"
 
 #define PFLASH_BE          0
diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
index c82002d665e..6a7d16b855b 100644
--- a/hw/block/pflash_cfi02.c
+++ b/hw/block/pflash_cfi02.c
@@ -41,7 +41,7 @@
 #include "qemu/error-report.h"
 #include "qemu/bitmap.h"
 #include "qemu/timer.h"
-#include "sysemu/block-backend.h"
+#include "system/block-backend.h"
 #include "qemu/host-utils.h"
 #include "qemu/module.h"
 #include "hw/sysbus.h"
diff --git a/hw/block/swim.c b/hw/block/swim.c
index c336d83bdc1..7b392e0dead 100644
--- a/hw/block/swim.c
+++ b/hw/block/swim.c
@@ -13,7 +13,7 @@
 #include "qemu/osdep.h"
 #include "qemu/main-loop.h"
 #include "qapi/error.h"
-#include "sysemu/block-backend.h"
+#include "system/block-backend.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
 #include "hw/block/block.h"
diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
index f3ac0071080..879913a42bc 100644
--- a/hw/block/vhost-user-blk.c
+++ b/hw/block/vhost-user-blk.c
@@ -29,8 +29,8 @@
 #include "hw/virtio/virtio.h"
 #include "hw/virtio/virtio-bus.h"
 #include "hw/virtio/virtio-access.h"
-#include "sysemu/sysemu.h"
-#include "sysemu/runstate.h"
+#include "system/system.h"
+#include "system/runstate.h"
 
 static const int user_feature_bits[] = {
     VIRTIO_BLK_F_SIZE_MAX,
diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index 9ca60fbc070..89d9279eda2 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -22,10 +22,10 @@
 #include "trace.h"
 #include "hw/block/block.h"
 #include "hw/qdev-properties.h"
-#include "sysemu/blockdev.h"
-#include "sysemu/block-ram-registrar.h"
-#include "sysemu/sysemu.h"
-#include "sysemu/runstate.h"
+#include "system/blockdev.h"
+#include "system/block-ram-registrar.h"
+#include "system/system.h"
+#include "system/runstate.h"
 #include "hw/virtio/virtio-blk.h"
 #include "scsi/constants.h"
 #ifdef __linux__
diff --git a/hw/block/xen-block.c b/hw/block/xen-block.c
index 0c0817f4987..990d8f3d76b 100644
--- a/hw/block/xen-block.c
+++ b/hw/block/xen-block.c
@@ -23,9 +23,9 @@
 #include "hw/qdev-properties.h"
 #include "hw/xen/xen-block.h"
 #include "hw/xen/xen-backend.h"
-#include "sysemu/blockdev.h"
-#include "sysemu/block-backend.h"
-#include "sysemu/iothread.h"
+#include "system/blockdev.h"
+#include "system/block-backend.h"
+#include "system/iothread.h"
 #include "dataplane/xen-block.h"
 #include "hw/xen/interface/io/xs_wire.h"
 #include "trace.h"
diff --git a/hw/char/goldfish_tty.c b/hw/char/goldfish_tty.c
index 68e261236ec..e3461e00a8f 100644
--- a/hw/char/goldfish_tty.c
+++ b/hw/char/goldfish_tty.c
@@ -16,7 +16,7 @@
 #include "qemu/log.h"
 #include "trace.h"
 #include "exec/address-spaces.h"
-#include "sysemu/dma.h"
+#include "system/dma.h"
 #include "hw/char/goldfish_tty.h"
 
 #define GOLDFISH_TTY_VERSION 1
diff --git a/hw/char/parallel-isa.c b/hw/char/parallel-isa.c
index a5ce6ee13a4..b6dfb6cc31a 100644
--- a/hw/char/parallel-isa.c
+++ b/hw/char/parallel-isa.c
@@ -10,7 +10,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "sysemu/sysemu.h"
+#include "system/system.h"
 #include "hw/isa/isa.h"
 #include "hw/qdev-properties.h"
 #include "hw/char/parallel-isa.h"
diff --git a/hw/char/parallel.c b/hw/char/parallel.c
index 15191698f5f..6560341419b 100644
--- a/hw/char/parallel.c
+++ b/hw/char/parallel.c
@@ -33,8 +33,8 @@
 #include "migration/vmstate.h"
 #include "hw/char/parallel-isa.h"
 #include "hw/char/parallel.h"
-#include "sysemu/reset.h"
-#include "sysemu/sysemu.h"
+#include "system/reset.h"
+#include "system/system.h"
 #include "trace.h"
 #include "qom/object.h"
 
diff --git a/hw/char/riscv_htif.c b/hw/char/riscv_htif.c
index 0345088e8b3..2a283a2dec3 100644
--- a/hw/char/riscv_htif.c
+++ b/hw/char/riscv_htif.c
@@ -30,8 +30,8 @@
 #include "qemu/error-report.h"
 #include "exec/address-spaces.h"
 #include "exec/tswap.h"
-#include "sysemu/dma.h"
-#include "sysemu/runstate.h"
+#include "system/dma.h"
+#include "system/runstate.h"
 
 #define RISCV_DEBUG_HTIF 0
 #define HTIF_DEBUG(fmt, ...)                                                   \
diff --git a/hw/char/serial-isa.c b/hw/char/serial-isa.c
index 2cf50eb0bbb..9472abf917c 100644
--- a/hw/char/serial-isa.c
+++ b/hw/char/serial-isa.c
@@ -26,7 +26,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
-#include "sysemu/sysemu.h"
+#include "system/system.h"
 #include "hw/acpi/acpi_aml_interface.h"
 #include "hw/char/serial.h"
 #include "hw/char/serial-isa.h"
diff --git a/hw/char/serial.c b/hw/char/serial.c
index 85dba02ace4..76a17f1a4b4 100644
--- a/hw/char/serial.c
+++ b/hw/char/serial.c
@@ -31,8 +31,8 @@
 #include "chardev/char-serial.h"
 #include "qapi/error.h"
 #include "qemu/timer.h"
-#include "sysemu/reset.h"
-#include "sysemu/runstate.h"
+#include "system/reset.h"
+#include "system/runstate.h"
 #include "qemu/error-report.h"
 #include "trace.h"
 #include "hw/qdev-properties.h"
diff --git a/hw/char/xen_console.c b/hw/char/xen_console.c
index c20c1b4b84e..88e12bb4102 100644
--- a/hw/char/xen_console.c
+++ b/hw/char/xen_console.c
@@ -25,7 +25,7 @@
 #include <termios.h>
 
 #include "qapi/error.h"
-#include "sysemu/sysemu.h"
+#include "system/system.h"
 #include "chardev/char-fe.h"
 #include "hw/xen/xen-backend.h"
 #include "hw/xen/xen-bus-helper.h"
diff --git a/hw/core/clock.c b/hw/core/clock.c
index 391095eb4e5..a81f888e62a 100644
--- a/hw/core/clock.c
+++ b/hw/core/clock.c
@@ -14,7 +14,7 @@
 #include "qemu/osdep.h"
 #include "qemu/cutils.h"
 #include "qapi/visitor.h"
-#include "sysemu/qtest.h"
+#include "system/qtest.h"
 #include "hw/clock.h"
 #include "trace.h"
 
diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
index 09c79035949..1edc16f65c8 100644
--- a/hw/core/cpu-common.c
+++ b/hw/core/cpu-common.c
@@ -21,13 +21,13 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "hw/core/cpu.h"
-#include "sysemu/hw_accel.h"
+#include "system/hw_accel.h"
 #include "qemu/log.h"
 #include "qemu/main-loop.h"
 #include "qemu/lockcnt.h"
 #include "exec/log.h"
 #include "exec/gdbstub.h"
-#include "sysemu/tcg.h"
+#include "system/tcg.h"
 #include "hw/boards.h"
 #include "hw/qdev-properties.h"
 #include "trace.h"
diff --git a/hw/core/cpu-sysemu.c b/hw/core/cpu-system.c
similarity index 98%
rename from hw/core/cpu-sysemu.c
rename to hw/core/cpu-system.c
index 2a9a2a4eb54..6aae28a349a 100644
--- a/hw/core/cpu-sysemu.c
+++ b/hw/core/cpu-system.c
@@ -1,5 +1,5 @@
 /*
- * QEMU CPU model (system emulation specific)
+ * QEMU CPU model (system specific)
  *
  * Copyright (c) 2012-2014 SUSE LINUX Products GmbH
  *
diff --git a/hw/core/generic-loader.c b/hw/core/generic-loader.c
index c1cddecf604..fca9ac0e36f 100644
--- a/hw/core/generic-loader.c
+++ b/hw/core/generic-loader.c
@@ -32,8 +32,8 @@
 
 #include "qemu/osdep.h"
 #include "exec/tswap.h"
-#include "sysemu/dma.h"
-#include "sysemu/reset.h"
+#include "system/dma.h"
+#include "system/reset.h"
 #include "hw/boards.h"
 #include "hw/loader.h"
 #include "hw/qdev-properties.h"
diff --git a/hw/core/guest-loader.c b/hw/core/guest-loader.c
index 74af00cee70..fb23882786a 100644
--- a/hw/core/guest-loader.c
+++ b/hw/core/guest-loader.c
@@ -26,13 +26,13 @@
 
 #include "qemu/osdep.h"
 #include "hw/core/cpu.h"
-#include "sysemu/dma.h"
+#include "system/dma.h"
 #include "hw/loader.h"
 #include "hw/qdev-properties.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
 #include "guest-loader.h"
-#include "sysemu/device_tree.h"
+#include "system/device_tree.h"
 #include "hw/boards.h"
 
 /*
diff --git a/hw/core/loader-fit.c b/hw/core/loader-fit.c
index 7ccc9d5fbc5..9bdd4fa17c6 100644
--- a/hw/core/loader-fit.c
+++ b/hw/core/loader-fit.c
@@ -25,7 +25,7 @@
 #include "hw/loader-fit.h"
 #include "qemu/cutils.h"
 #include "qemu/error-report.h"
-#include "sysemu/device_tree.h"
+#include "system/device_tree.h"
 
 #include <libfdt.h>
 #include <zlib.h>
diff --git a/hw/core/loader.c b/hw/core/loader.c
index 31593a11717..c0407e2d0db 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -53,15 +53,15 @@
 #include "disas/disas.h"
 #include "migration/vmstate.h"
 #include "monitor/monitor.h"
-#include "sysemu/reset.h"
-#include "sysemu/sysemu.h"
+#include "system/reset.h"
+#include "system/system.h"
 #include "uboot_image.h"
 #include "hw/loader.h"
 #include "hw/nvram/fw_cfg.h"
 #include "exec/memory.h"
 #include "hw/boards.h"
 #include "qemu/cutils.h"
-#include "sysemu/runstate.h"
+#include "system/runstate.h"
 #include "tcg/debuginfo.h"
 
 #include <zlib.h>
diff --git a/hw/core/machine-hmp-cmds.c b/hw/core/machine-hmp-cmds.c
index 8701f00cc7c..916727961c1 100644
--- a/hw/core/machine-hmp-cmds.c
+++ b/hw/core/machine-hmp-cmds.c
@@ -22,7 +22,7 @@
 #include "qapi/qmp/qdict.h"
 #include "qapi/string-output-visitor.h"
 #include "qemu/error-report.h"
-#include "sysemu/numa.h"
+#include "system/numa.h"
 #include "hw/boards.h"
 
 void hmp_info_cpus(Monitor *mon, const QDict *qdict)
diff --git a/hw/core/machine-qmp-cmds.c b/hw/core/machine-qmp-cmds.c
index 130217da8f9..4eefe6ba860 100644
--- a/hw/core/machine-qmp-cmds.c
+++ b/hw/core/machine-qmp-cmds.c
@@ -20,11 +20,11 @@
 #include "qapi/type-helpers.h"
 #include "qemu/uuid.h"
 #include "qom/qom-qobject.h"
-#include "sysemu/hostmem.h"
-#include "sysemu/hw_accel.h"
-#include "sysemu/numa.h"
-#include "sysemu/runstate.h"
-#include "sysemu/sysemu.h"
+#include "system/hostmem.h"
+#include "system/hw_accel.h"
+#include "system/numa.h"
+#include "system/runstate.h"
+#include "system/system.h"
 
 /*
  * fast means: we NEVER interrupt vCPU threads to retrieve
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 3d734f8c18d..008d3379e15 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -13,7 +13,7 @@
 #include "qemu/osdep.h"
 #include "qemu/units.h"
 #include "qemu/accel.h"
-#include "sysemu/replay.h"
+#include "system/replay.h"
 #include "hw/boards.h"
 #include "hw/loader.h"
 #include "qemu/error-report.h"
@@ -21,12 +21,12 @@
 #include "qapi/qapi-visit-machine.h"
 #include "qemu/madvise.h"
 #include "qom/object_interfaces.h"
-#include "sysemu/cpus.h"
-#include "sysemu/sysemu.h"
-#include "sysemu/reset.h"
-#include "sysemu/runstate.h"
-#include "sysemu/xen.h"
-#include "sysemu/qtest.h"
+#include "system/cpus.h"
+#include "system/system.h"
+#include "system/reset.h"
+#include "system/runstate.h"
+#include "system/xen.h"
+#include "system/qtest.h"
 #include "hw/pci/pci_bridge.h"
 #include "hw/mem/nvdimm.h"
 #include "migration/global_state.h"
diff --git a/hw/core/numa.c b/hw/core/numa.c
index 1b5f44baeac..218576f7455 100644
--- a/hw/core/numa.c
+++ b/hw/core/numa.c
@@ -24,15 +24,15 @@
 
 #include "qemu/osdep.h"
 #include "qemu/units.h"
-#include "sysemu/hostmem.h"
-#include "sysemu/numa.h"
+#include "system/hostmem.h"
+#include "system/numa.h"
 #include "exec/cpu-common.h"
 #include "exec/ramlist.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "qapi/opts-visitor.h"
 #include "qapi/qapi-visit-machine.h"
-#include "sysemu/qtest.h"
+#include "system/qtest.h"
 #include "hw/core/cpu.h"
 #include "hw/mem/pc-dimm.h"
 #include "hw/boards.h"
diff --git a/hw/core/ptimer.c b/hw/core/ptimer.c
index 1d8964d8044..7f63d17ca19 100644
--- a/hw/core/ptimer.c
+++ b/hw/core/ptimer.c
@@ -11,8 +11,8 @@
 #include "migration/vmstate.h"
 #include "qemu/host-utils.h"
 #include "exec/replay-core.h"
-#include "sysemu/cpu-timers.h"
-#include "sysemu/qtest.h"
+#include "system/cpu-timers.h"
+#include "system/qtest.h"
 #include "block/aio.h"
 #include "hw/clock.h"
 
diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
index 22ea1ed3583..c91c3835115 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -29,8 +29,8 @@
 
 #include "audio/audio.h"
 #include "chardev/char-fe.h"
-#include "sysemu/block-backend.h"
-#include "sysemu/blockdev.h"
+#include "system/block-backend.h"
+#include "system/blockdev.h"
 #include "net/net.h"
 #include "hw/pci/pci.h"
 #include "hw/pci/pcie.h"
diff --git a/hw/core/reset.c b/hw/core/reset.c
index 14a2639fbfb..8a3e0e518f0 100644
--- a/hw/core/reset.c
+++ b/hw/core/reset.c
@@ -24,7 +24,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "sysemu/reset.h"
+#include "system/reset.h"
 #include "hw/resettable.h"
 #include "hw/core/resetcontainer.h"
 
diff --git a/hw/core/sysbus-fdt.c b/hw/core/sysbus-fdt.c
index eebcd28f9a3..774c0aed41b 100644
--- a/hw/core/sysbus-fdt.c
+++ b/hw/core/sysbus-fdt.c
@@ -29,8 +29,8 @@
 #endif
 #include "hw/core/sysbus-fdt.h"
 #include "qemu/error-report.h"
-#include "sysemu/device_tree.h"
-#include "sysemu/tpm.h"
+#include "system/device_tree.h"
+#include "system/tpm.h"
 #include "hw/platform-bus.h"
 #include "hw/vfio/vfio-platform.h"
 #include "hw/vfio/vfio-calxeda-xgmac.h"
diff --git a/hw/core/vm-change-state-handler.c b/hw/core/vm-change-state-handler.c
index 8e2639224e7..7064995578f 100644
--- a/hw/core/vm-change-state-handler.c
+++ b/hw/core/vm-change-state-handler.c
@@ -17,7 +17,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/qdev-core.h"
-#include "sysemu/runstate.h"
+#include "system/runstate.h"
 
 static int qdev_get_dev_tree_depth(DeviceState *dev)
 {
diff --git a/hw/cpu/a15mpcore.c b/hw/cpu/a15mpcore.c
index 5346b8b6c6e..993550583f1 100644
--- a/hw/cpu/a15mpcore.c
+++ b/hw/cpu/a15mpcore.c
@@ -24,7 +24,7 @@
 #include "hw/cpu/a15mpcore.h"
 #include "hw/irq.h"
 #include "hw/qdev-properties.h"
-#include "sysemu/kvm.h"
+#include "system/kvm.h"
 #include "kvm_arm.h"
 #include "target/arm/gtimer.h"
 
diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
index e9f2543c43c..2c6b43cd0d3 100644
--- a/hw/cxl/cxl-host.c
+++ b/hw/cxl/cxl-host.c
@@ -10,7 +10,7 @@
 #include "qemu/bitmap.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
-#include "sysemu/qtest.h"
+#include "system/qtest.h"
 #include "hw/boards.h"
 
 #include "qapi/qapi-visit-machine.h"
diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index ce9aa18364d..516c01d8402 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -19,7 +19,7 @@
 #include "qemu/log.h"
 #include "qemu/units.h"
 #include "qemu/uuid.h"
-#include "sysemu/hostmem.h"
+#include "system/hostmem.h"
 #include "qemu/range.h"
 
 #define CXL_CAPACITY_MULTIPLIER   (256 * MiB)
diff --git a/hw/display/cirrus_vga.c b/hw/display/cirrus_vga.c
index 198ed9ed9be..6dbf06f6e97 100644
--- a/hw/display/cirrus_vga.c
+++ b/hw/display/cirrus_vga.c
@@ -36,7 +36,7 @@
 #include "qemu/module.h"
 #include "qemu/units.h"
 #include "qemu/log.h"
-#include "sysemu/reset.h"
+#include "system/reset.h"
 #include "qapi/error.h"
 #include "trace.h"
 #include "hw/pci/pci_device.h"
diff --git a/hw/display/qxl-render.c b/hw/display/qxl-render.c
index 335d01edde7..eda6d3de37c 100644
--- a/hw/display/qxl-render.c
+++ b/hw/display/qxl-render.c
@@ -21,7 +21,7 @@
 
 #include "qemu/osdep.h"
 #include "qxl.h"
-#include "sysemu/runstate.h"
+#include "system/runstate.h"
 #include "trace.h"
 
 static void qxl_blit(PCIQXLDevice *qxl, QXLRect *rect)
diff --git a/hw/display/qxl.c b/hw/display/qxl.c
index 949949d374b..f38a602aabe 100644
--- a/hw/display/qxl.c
+++ b/hw/display/qxl.c
@@ -29,7 +29,7 @@
 #include "qemu/main-loop.h"
 #include "qemu/module.h"
 #include "hw/qdev-properties.h"
-#include "sysemu/runstate.h"
+#include "system/runstate.h"
 #include "migration/vmstate.h"
 #include "trace.h"
 
diff --git a/hw/display/ramfb.c b/hw/display/ramfb.c
index 6086baf7a98..8c0f907673d 100644
--- a/hw/display/ramfb.c
+++ b/hw/display/ramfb.c
@@ -17,7 +17,7 @@
 #include "hw/display/ramfb.h"
 #include "hw/display/bochs-vbe.h" /* for limits */
 #include "ui/console.h"
-#include "sysemu/reset.h"
+#include "system/reset.h"
 
 struct QEMU_PACKED RAMFBCfg {
     uint64_t addr;
diff --git a/hw/display/vga.c b/hw/display/vga.c
index b074b58c90d..b01f67c65fb 100644
--- a/hw/display/vga.c
+++ b/hw/display/vga.c
@@ -24,7 +24,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/units.h"
-#include "sysemu/reset.h"
+#include "system/reset.h"
 #include "qapi/error.h"
 #include "exec/tswap.h"
 #include "hw/display/vga.h"
diff --git a/hw/display/virtio-gpu-gl.c b/hw/display/virtio-gpu-gl.c
index 6f31149e1ee..d8a1e1d8db4 100644
--- a/hw/display/virtio-gpu-gl.c
+++ b/hw/display/virtio-gpu-gl.c
@@ -16,7 +16,7 @@
 #include "qemu/module.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
-#include "sysemu/sysemu.h"
+#include "system/system.h"
 #include "hw/virtio/virtio.h"
 #include "hw/virtio/virtio-gpu.h"
 #include "hw/virtio/virtio-gpu-bswap.h"
diff --git a/hw/display/virtio-gpu-udmabuf.c b/hw/display/virtio-gpu-udmabuf.c
index c02ec6d37dc..85ca23cb321 100644
--- a/hw/display/virtio-gpu-udmabuf.c
+++ b/hw/display/virtio-gpu-udmabuf.c
@@ -20,7 +20,7 @@
 #include "hw/virtio/virtio-gpu-pixman.h"
 #include "trace.h"
 #include "exec/ramblock.h"
-#include "sysemu/hostmem.h"
+#include "system/hostmem.h"
 #include <sys/ioctl.h>
 #include <linux/memfd.h>
 #include "qemu/memfd.h"
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 82741d19e56..96baa40231a 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -14,12 +14,12 @@
 #include "qemu/osdep.h"
 #include "qemu/units.h"
 #include "qemu/iov.h"
-#include "sysemu/cpus.h"
+#include "system/cpus.h"
 #include "ui/console.h"
 #include "ui/rect.h"
 #include "trace.h"
-#include "sysemu/dma.h"
-#include "sysemu/sysemu.h"
+#include "system/dma.h"
+#include "system/system.h"
 #include "hw/virtio/virtio.h"
 #include "migration/qemu-file-types.h"
 #include "hw/virtio/virtio-gpu.h"
diff --git a/hw/display/xenfb.c b/hw/display/xenfb.c
index 314d378a1b3..22822fecea3 100644
--- a/hw/display/xenfb.c
+++ b/hw/display/xenfb.c
@@ -29,7 +29,7 @@
 
 #include "ui/input.h"
 #include "ui/console.h"
-#include "sysemu/sysemu.h"
+#include "system/system.h"
 #include "hw/xen/xen-legacy-backend.h"
 
 #include "hw/xen/interface/io/fbif.h"
diff --git a/hw/dma/pl330.c b/hw/dma/pl330.c
index d5a0a1caa20..94f42c933b0 100644
--- a/hw/dma/pl330.c
+++ b/hw/dma/pl330.c
@@ -22,7 +22,7 @@
 #include "migration/vmstate.h"
 #include "qapi/error.h"
 #include "qemu/timer.h"
-#include "sysemu/dma.h"
+#include "system/dma.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "trace.h"
diff --git a/hw/dma/sifive_pdma.c b/hw/dma/sifive_pdma.c
index 1dd88f3479d..25b3d6a155a 100644
--- a/hw/dma/sifive_pdma.c
+++ b/hw/dma/sifive_pdma.c
@@ -28,7 +28,7 @@
 #include "hw/qdev-properties.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
-#include "sysemu/dma.h"
+#include "system/dma.h"
 #include "hw/dma/sifive_pdma.h"
 
 #define DMA_CONTROL         0x000
diff --git a/hw/dma/sparc32_dma.c b/hw/dma/sparc32_dma.c
index 9fdba16603e..280b7475212 100644
--- a/hw/dma/sparc32_dma.c
+++ b/hw/dma/sparc32_dma.c
@@ -32,7 +32,7 @@
 #include "hw/sparc/sun4m_iommu.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
-#include "sysemu/dma.h"
+#include "system/dma.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
 #include "trace.h"
diff --git a/hw/dma/xilinx_axidma.c b/hw/dma/xilinx_axidma.c
index f09452d0b52..e02aec78bc1 100644
--- a/hw/dma/xilinx_axidma.c
+++ b/hw/dma/xilinx_axidma.c
@@ -33,7 +33,7 @@
 #include "qemu/log.h"
 #include "qemu/module.h"
 
-#include "sysemu/dma.h"
+#include "system/dma.h"
 #include "hw/stream.h"
 #include "qom/object.h"
 #include "trace.h"
diff --git a/hw/dma/xlnx-zynq-devcfg.c b/hw/dma/xlnx-zynq-devcfg.c
index b8544d07314..0fd0d23f578 100644
--- a/hw/dma/xlnx-zynq-devcfg.c
+++ b/hw/dma/xlnx-zynq-devcfg.c
@@ -29,7 +29,7 @@
 #include "hw/irq.h"
 #include "migration/vmstate.h"
 #include "qemu/bitops.h"
-#include "sysemu/dma.h"
+#include "system/dma.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
 
diff --git a/hw/dma/xlnx_csu_dma.c b/hw/dma/xlnx_csu_dma.c
index d78dc6444bd..41707143513 100644
--- a/hw/dma/xlnx_csu_dma.c
+++ b/hw/dma/xlnx_csu_dma.c
@@ -25,7 +25,7 @@
 #include "hw/qdev-properties.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
-#include "sysemu/dma.h"
+#include "system/dma.h"
 #include "hw/ptimer.h"
 #include "hw/stream.h"
 #include "hw/register.h"
diff --git a/hw/gpio/gpio_pwr.c b/hw/gpio/gpio_pwr.c
index dbaf1c70c88..2d14f8b344c 100644
--- a/hw/gpio/gpio_pwr.c
+++ b/hw/gpio/gpio_pwr.c
@@ -24,7 +24,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
-#include "sysemu/runstate.h"
+#include "system/runstate.h"
 
 #define TYPE_GPIOPWR "gpio-pwr"
 OBJECT_DECLARE_SIMPLE_TYPE(GPIO_PWR_State, GPIOPWR)
diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index 4e673353225..65259308e2e 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -11,10 +11,10 @@
 #include "elf.h"
 #include "hw/loader.h"
 #include "qemu/error-report.h"
-#include "sysemu/reset.h"
-#include "sysemu/sysemu.h"
-#include "sysemu/qtest.h"
-#include "sysemu/runstate.h"
+#include "system/reset.h"
+#include "system/system.h"
+#include "system/qtest.h"
+#include "system/runstate.h"
 #include "hw/rtc/mc146818rtc.h"
 #include "hw/timer/i8254.h"
 #include "hw/char/serial-mm.h"
diff --git a/hw/hyperv/hv-balloon.c b/hw/hyperv/hv-balloon.c
index 74897b1604f..ba622e80ff4 100644
--- a/hw/hyperv/hv-balloon.c
+++ b/hw/hyperv/hv-balloon.c
@@ -32,9 +32,9 @@
 #include "qemu/module.h"
 #include "qemu/units.h"
 #include "qemu/timer.h"
-#include "sysemu/balloon.h"
-#include "sysemu/hostmem.h"
-#include "sysemu/reset.h"
+#include "system/balloon.h"
+#include "system/hostmem.h"
+#include "system/reset.h"
 #include "hv-balloon-our_range_memslots.h"
 #include "hv-balloon-page_range_tree.h"
 #include "trace.h"
diff --git a/hw/hyperv/hyperv.c b/hw/hyperv/hyperv.c
index ba94bf9f8db..831e04f2142 100644
--- a/hw/hyperv/hyperv.c
+++ b/hw/hyperv/hyperv.c
@@ -13,7 +13,7 @@
 #include "qapi/error.h"
 #include "exec/address-spaces.h"
 #include "exec/memory.h"
-#include "sysemu/kvm.h"
+#include "system/kvm.h"
 #include "qemu/bitops.h"
 #include "qemu/error-report.h"
 #include "qemu/lockable.h"
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 9fcc2897b84..733b8f0851a 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -40,18 +40,18 @@
 #include "hw/acpi/acpi_aml_interface.h"
 #include "hw/input/i8042.h"
 #include "hw/acpi/memory_hotplug.h"
-#include "sysemu/tpm.h"
+#include "system/tpm.h"
 #include "hw/acpi/tpm.h"
 #include "hw/acpi/vmgenid.h"
 #include "hw/acpi/erst.h"
 #include "hw/acpi/piix4.h"
-#include "sysemu/tpm_backend.h"
+#include "system/tpm_backend.h"
 #include "hw/rtc/mc146818rtc_regs.h"
 #include "migration/vmstate.h"
 #include "hw/mem/memory-device.h"
 #include "hw/mem/nvdimm.h"
-#include "sysemu/numa.h"
-#include "sysemu/reset.h"
+#include "system/numa.h"
+#include "system/reset.h"
 #include "hw/hyperv/vmbus-bridge.h"
 
 /* Supported chipsets: */
diff --git a/hw/i386/fw_cfg.c b/hw/i386/fw_cfg.c
index 0e4494627c2..91bf1df0f2e 100644
--- a/hw/i386/fw_cfg.c
+++ b/hw/i386/fw_cfg.c
@@ -13,7 +13,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "sysemu/numa.h"
+#include "system/numa.h"
 #include "hw/acpi/acpi.h"
 #include "hw/acpi/aml-build.h"
 #include "hw/firmware/smbios.h"
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index a5b268342fc..fa28c33f21d 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -32,9 +32,9 @@
 #include "hw/i386/apic-msidef.h"
 #include "hw/i386/x86-iommu.h"
 #include "hw/pci-host/q35.h"
-#include "sysemu/kvm.h"
-#include "sysemu/dma.h"
-#include "sysemu/sysemu.h"
+#include "system/kvm.h"
+#include "system/dma.h"
+#include "system/system.h"
 #include "hw/i386/apic_internal.h"
 #include "kvm/kvm_i386.h"
 #include "migration/vmstate.h"
diff --git a/hw/i386/kvm/apic.c b/hw/i386/kvm/apic.c
index a72c28e8a7d..602c7696565 100644
--- a/hw/i386/kvm/apic.c
+++ b/hw/i386/kvm/apic.c
@@ -14,8 +14,8 @@
 #include "qemu/module.h"
 #include "hw/i386/apic_internal.h"
 #include "hw/pci/msi.h"
-#include "sysemu/hw_accel.h"
-#include "sysemu/kvm.h"
+#include "system/hw_accel.h"
+#include "system/kvm.h"
 #include "kvm/kvm_i386.h"
 
 static inline void kvm_apic_set_reg(struct kvm_lapic_state *kapic,
diff --git a/hw/i386/kvm/clock.c b/hw/i386/kvm/clock.c
index 71150ed2e0a..610af634cc6 100644
--- a/hw/i386/kvm/clock.c
+++ b/hw/i386/kvm/clock.c
@@ -16,9 +16,9 @@
 #include "qemu/osdep.h"
 #include "qemu/host-utils.h"
 #include "qemu/module.h"
-#include "sysemu/kvm.h"
-#include "sysemu/runstate.h"
-#include "sysemu/hw_accel.h"
+#include "system/kvm.h"
+#include "system/runstate.h"
+#include "system/hw_accel.h"
 #include "kvm/kvm_i386.h"
 #include "migration/vmstate.h"
 #include "hw/sysbus.h"
diff --git a/hw/i386/kvm/i8254.c b/hw/i386/kvm/i8254.c
index 2933d3f4581..eb9a6f79fed 100644
--- a/hw/i386/kvm/i8254.c
+++ b/hw/i386/kvm/i8254.c
@@ -29,11 +29,11 @@
 #include "qapi/error.h"
 #include "qemu/module.h"
 #include "qemu/timer.h"
-#include "sysemu/runstate.h"
+#include "system/runstate.h"
 #include "hw/timer/i8254.h"
 #include "hw/timer/i8254_internal.h"
 #include "hw/qdev-properties-system.h"
-#include "sysemu/kvm.h"
+#include "system/kvm.h"
 #include "target/i386/kvm/kvm_i386.h"
 #include "qom/object.h"
 
diff --git a/hw/i386/kvm/i8259.c b/hw/i386/kvm/i8259.c
index 9c2fb645fed..272c04df0b7 100644
--- a/hw/i386/kvm/i8259.c
+++ b/hw/i386/kvm/i8259.c
@@ -16,7 +16,7 @@
 #include "qemu/module.h"
 #include "hw/intc/kvm_irqcount.h"
 #include "hw/irq.h"
-#include "sysemu/kvm.h"
+#include "system/kvm.h"
 #include "qom/object.h"
 
 #define TYPE_KVM_I8259 "kvm-i8259"
diff --git a/hw/i386/kvm/ioapic.c b/hw/i386/kvm/ioapic.c
index 217ff43b982..b8bc46518bb 100644
--- a/hw/i386/kvm/ioapic.c
+++ b/hw/i386/kvm/ioapic.c
@@ -15,7 +15,7 @@
 #include "hw/qdev-properties.h"
 #include "hw/intc/ioapic_internal.h"
 #include "hw/intc/kvm_irqcount.h"
-#include "sysemu/kvm.h"
+#include "system/kvm.h"
 #include "kvm/kvm_i386.h"
 
 /* PC Utility function */
diff --git a/hw/i386/kvm/xen_evtchn.c b/hw/i386/kvm/xen_evtchn.c
index 07bd0c9ab80..bd2a3cbee09 100644
--- a/hw/i386/kvm/xen_evtchn.c
+++ b/hw/i386/kvm/xen_evtchn.c
@@ -41,8 +41,8 @@
 #include "xen_overlay.h"
 #include "xen_xenstore.h"
 
-#include "sysemu/kvm.h"
-#include "sysemu/kvm_xen.h"
+#include "system/kvm.h"
+#include "system/kvm_xen.h"
 #include <linux/kvm.h>
 #include <sys/eventfd.h>
 
diff --git a/hw/i386/kvm/xen_gnttab.c b/hw/i386/kvm/xen_gnttab.c
index 245e4b15db7..7b843a72b14 100644
--- a/hw/i386/kvm/xen_gnttab.c
+++ b/hw/i386/kvm/xen_gnttab.c
@@ -27,8 +27,8 @@
 #include "xen_gnttab.h"
 #include "xen_primary_console.h"
 
-#include "sysemu/kvm.h"
-#include "sysemu/kvm_xen.h"
+#include "system/kvm.h"
+#include "system/kvm_xen.h"
 
 #include "hw/xen/interface/memory.h"
 #include "hw/xen/interface/grant_table.h"
diff --git a/hw/i386/kvm/xen_overlay.c b/hw/i386/kvm/xen_overlay.c
index 3483a332a6b..db9aa7942d4 100644
--- a/hw/i386/kvm/xen_overlay.c
+++ b/hw/i386/kvm/xen_overlay.c
@@ -23,8 +23,8 @@
 #include "hw/xen/xen.h"
 #include "xen_overlay.h"
 
-#include "sysemu/kvm.h"
-#include "sysemu/kvm_xen.h"
+#include "system/kvm.h"
+#include "system/kvm_xen.h"
 #include <linux/kvm.h>
 
 #include "hw/xen/interface/memory.h"
diff --git a/hw/i386/kvm/xen_primary_console.c b/hw/i386/kvm/xen_primary_console.c
index abe79f565be..8ad2363d18e 100644
--- a/hw/i386/kvm/xen_primary_console.c
+++ b/hw/i386/kvm/xen_primary_console.c
@@ -20,8 +20,8 @@
 #include "xen_overlay.h"
 #include "xen_primary_console.h"
 
-#include "sysemu/kvm.h"
-#include "sysemu/kvm_xen.h"
+#include "system/kvm.h"
+#include "system/kvm_xen.h"
 
 #include "trace.h"
 
diff --git a/hw/i386/kvm/xen_xenstore.c b/hw/i386/kvm/xen_xenstore.c
index 1a9bc342b88..59691056670 100644
--- a/hw/i386/kvm/xen_xenstore.c
+++ b/hw/i386/kvm/xen_xenstore.c
@@ -28,8 +28,8 @@
 #include "xen_primary_console.h"
 #include "xen_xenstore.h"
 
-#include "sysemu/kvm.h"
-#include "sysemu/kvm_xen.h"
+#include "system/kvm.h"
+#include "system/kvm_xen.h"
 
 #include "trace.h"
 
diff --git a/hw/i386/microvm-dt.c b/hw/i386/microvm-dt.c
index fc5db6ed7ff..cb27dfd732e 100644
--- a/hw/i386/microvm-dt.c
+++ b/hw/i386/microvm-dt.c
@@ -33,7 +33,7 @@
 #include "qemu/osdep.h"
 #include "qemu/cutils.h"
 #include "qapi/error.h"
-#include "sysemu/device_tree.h"
+#include "system/device_tree.h"
 #include "hw/char/serial-isa.h"
 #include "hw/i386/fw_cfg.h"
 #include "hw/rtc/mc146818rtc.h"
diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
index 86637afa0f3..c3d7fe3c428 100644
--- a/hw/i386/microvm.c
+++ b/hw/i386/microvm.c
@@ -22,11 +22,11 @@
 #include "qapi/error.h"
 #include "qapi/visitor.h"
 #include "qapi/qapi-visit-common.h"
-#include "sysemu/sysemu.h"
-#include "sysemu/cpus.h"
-#include "sysemu/numa.h"
-#include "sysemu/reset.h"
-#include "sysemu/runstate.h"
+#include "system/system.h"
+#include "system/cpus.h"
+#include "system/numa.h"
+#include "system/reset.h"
+#include "system/runstate.h"
 #include "acpi-microvm.h"
 #include "microvm-dt.h"
 
diff --git a/hw/i386/multiboot.c b/hw/i386/multiboot.c
index b2648bff71a..1d66ca3204a 100644
--- a/hw/i386/multiboot.c
+++ b/hw/i386/multiboot.c
@@ -29,7 +29,7 @@
 #include "multiboot.h"
 #include "hw/loader.h"
 #include "elf.h"
-#include "sysemu/sysemu.h"
+#include "system/system.h"
 #include "qemu/error-report.h"
 
 /* Show multiboot debug output */
diff --git a/hw/i386/nitro_enclave.c b/hw/i386/nitro_enclave.c
index acbbc06b715..a058608afcb 100644
--- a/hw/i386/nitro_enclave.c
+++ b/hw/i386/nitro_enclave.c
@@ -22,7 +22,7 @@
 #include "hw/virtio/virtio-mmio.h"
 #include "hw/virtio/virtio-nsm.h"
 #include "hw/virtio/vhost-user-vsock.h"
-#include "sysemu/hostmem.h"
+#include "system/hostmem.h"
 
 static BusState *find_free_virtio_mmio_bus(void)
 {
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 92047ce8c9d..53a2f226d03 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -30,7 +30,7 @@
 #include "hw/hyperv/hv-balloon.h"
 #include "hw/i386/fw_cfg.h"
 #include "hw/i386/vmport.h"
-#include "sysemu/cpus.h"
+#include "system/cpus.h"
 #include "hw/ide/ide-bus.h"
 #include "hw/timer/hpet.h"
 #include "hw/loader.h"
@@ -39,9 +39,9 @@
 #include "hw/timer/i8254.h"
 #include "hw/input/i8042.h"
 #include "hw/audio/pcspk.h"
-#include "sysemu/sysemu.h"
-#include "sysemu/xen.h"
-#include "sysemu/reset.h"
+#include "system/system.h"
+#include "system/xen.h"
+#include "system/reset.h"
 #include "kvm/kvm_i386.h"
 #include "hw/xen/xen.h"
 #include "qapi/qmp/qlist.h"
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index e4365cbdb0a..04d2957adcd 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -43,7 +43,7 @@
 #include "hw/ide/isa.h"
 #include "hw/ide/pci.h"
 #include "hw/irq.h"
-#include "sysemu/kvm.h"
+#include "system/kvm.h"
 #include "hw/i386/kvm/clock.h"
 #include "hw/sysbus.h"
 #include "hw/i2c/smbus_eeprom.h"
@@ -51,7 +51,7 @@
 #include "hw/acpi/acpi.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
-#include "sysemu/xen.h"
+#include "system/xen.h"
 #ifdef CONFIG_XEN
 #include <xen/hvm/hvm_info_table.h>
 #include "hw/xen/xen_pt.h"
@@ -61,8 +61,8 @@
 #include "hw/xen/xen.h"
 #include "migration/global_state.h"
 #include "migration/misc.h"
-#include "sysemu/runstate.h"
-#include "sysemu/numa.h"
+#include "system/runstate.h"
+#include "system/numa.h"
 #include "hw/hyperv/vmbus-bridge.h"
 #include "hw/mem/nvdimm.h"
 #include "hw/i386/acpi-build.h"
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index bbbdacda8e4..77536dd697f 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -35,8 +35,8 @@
 #include "hw/loader.h"
 #include "hw/i2c/smbus_eeprom.h"
 #include "hw/rtc/mc146818rtc.h"
-#include "sysemu/tcg.h"
-#include "sysemu/kvm.h"
+#include "system/tcg.h"
+#include "system/kvm.h"
 #include "hw/i386/kvm/clock.h"
 #include "hw/pci-host/q35.h"
 #include "hw/pci/pcie_port.h"
@@ -55,7 +55,7 @@
 #include "hw/usb/hcd-uhci.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
-#include "sysemu/numa.h"
+#include "system/numa.h"
 #include "hw/hyperv/vmbus-bridge.h"
 #include "hw/mem/nvdimm.h"
 #include "hw/i386/acpi-build.h"
diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
index e6271e10208..1eeb58ab37f 100644
--- a/hw/i386/pc_sysfw.c
+++ b/hw/i386/pc_sysfw.c
@@ -25,7 +25,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "sysemu/block-backend.h"
+#include "system/block-backend.h"
 #include "qemu/error-report.h"
 #include "qemu/option.h"
 #include "qemu/units.h"
@@ -35,7 +35,7 @@
 #include "hw/loader.h"
 #include "hw/qdev-properties.h"
 #include "hw/block/flash.h"
-#include "sysemu/kvm.h"
+#include "system/kvm.h"
 #include "target/i386/sev.h"
 
 #define FLASH_SECTOR_SIZE 4096
diff --git a/hw/i386/port92.c b/hw/i386/port92.c
index 1b03b34f1d1..1ba3f328871 100644
--- a/hw/i386/port92.c
+++ b/hw/i386/port92.c
@@ -7,7 +7,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "sysemu/runstate.h"
+#include "system/runstate.h"
 #include "migration/vmstate.h"
 #include "hw/irq.h"
 #include "hw/isa/isa.h"
diff --git a/hw/i386/sgx.c b/hw/i386/sgx.c
index 4900dd414a1..e665e2111cc 100644
--- a/hw/i386/sgx.c
+++ b/hw/i386/sgx.c
@@ -21,8 +21,8 @@
 #include "qemu/error-report.h"
 #include "qapi/qapi-commands-misc-target.h"
 #include "exec/address-spaces.h"
-#include "sysemu/hw_accel.h"
-#include "sysemu/reset.h"
+#include "system/hw_accel.h"
+#include "system/reset.h"
 #include <sys/ioctl.h>
 #include "hw/acpi/aml-build.h"
 
diff --git a/hw/i386/vapic.c b/hw/i386/vapic.c
index ef7f8b967f3..0e6d058d063 100644
--- a/hw/i386/vapic.c
+++ b/hw/i386/vapic.c
@@ -11,11 +11,11 @@
 
 #include "qemu/osdep.h"
 #include "qemu/module.h"
-#include "sysemu/sysemu.h"
-#include "sysemu/cpus.h"
-#include "sysemu/hw_accel.h"
-#include "sysemu/kvm.h"
-#include "sysemu/runstate.h"
+#include "system/system.h"
+#include "system/cpus.h"
+#include "system/hw_accel.h"
+#include "system/kvm.h"
+#include "system/runstate.h"
 #include "exec/address-spaces.h"
 #include "hw/i386/apic_internal.h"
 #include "hw/sysbus.h"
diff --git a/hw/i386/vmport.c b/hw/i386/vmport.c
index cab6e720898..7be25524f18 100644
--- a/hw/i386/vmport.c
+++ b/hw/i386/vmport.c
@@ -33,9 +33,9 @@
 #include "hw/i386/vmport.h"
 #include "hw/qdev-properties.h"
 #include "hw/boards.h"
-#include "sysemu/sysemu.h"
-#include "sysemu/hw_accel.h"
-#include "sysemu/qtest.h"
+#include "system/system.h"
+#include "system/hw_accel.h"
+#include "system/qtest.h"
 #include "qemu/log.h"
 #include "trace.h"
 #include "qom/object.h"
diff --git a/hw/i386/x86-common.c b/hw/i386/x86-common.c
index 3f781826923..a7d46c31059 100644
--- a/hw/i386/x86-common.c
+++ b/hw/i386/x86-common.c
@@ -26,9 +26,9 @@
 #include "qemu/units.h"
 #include "qemu/datadir.h"
 #include "qapi/error.h"
-#include "sysemu/numa.h"
-#include "sysemu/sysemu.h"
-#include "sysemu/xen.h"
+#include "system/numa.h"
+#include "system/system.h"
+#include "system/xen.h"
 #include "trace.h"
 
 #include "hw/i386/x86.h"
diff --git a/hw/i386/x86-cpu.c b/hw/i386/x86-cpu.c
index ab2920522d1..c876e6709e0 100644
--- a/hw/i386/x86-cpu.c
+++ b/hw/i386/x86-cpu.c
@@ -21,15 +21,15 @@
  * THE SOFTWARE.
  */
 #include "qemu/osdep.h"
-#include "sysemu/whpx.h"
-#include "sysemu/cpu-timers.h"
+#include "system/whpx.h"
+#include "system/cpu-timers.h"
 #include "trace.h"
 
 #include "hw/i386/x86.h"
 #include "target/i386/cpu.h"
 #include "hw/intc/i8259.h"
 #include "hw/irq.h"
-#include "sysemu/kvm.h"
+#include "system/kvm.h"
 
 /* TSC handling */
 uint64_t cpu_get_tsc(CPUX86State *env)
diff --git a/hw/i386/x86-iommu.c b/hw/i386/x86-iommu.c
index 155f6262ea1..06d91c6c131 100644
--- a/hw/i386/x86-iommu.c
+++ b/hw/i386/x86-iommu.c
@@ -25,7 +25,7 @@
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "trace.h"
-#include "sysemu/kvm.h"
+#include "system/kvm.h"
 
 void x86_iommu_iec_register_notifier(X86IOMMUState *iommu,
                                      iec_notify_fn fn, void *data)
diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index 01fc5e65627..69bfc00b9a5 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -27,8 +27,8 @@
 #include "qapi/qapi-visit-common.h"
 #include "qapi/qapi-visit-machine.h"
 #include "qapi/visitor.h"
-#include "sysemu/qtest.h"
-#include "sysemu/numa.h"
+#include "system/qtest.h"
+#include "system/numa.h"
 #include "trace.h"
 
 #include "hw/acpi/aml-build.h"
diff --git a/hw/i386/xen/xen-pvh.c b/hw/i386/xen/xen-pvh.c
index f1f02d33118..33c10279763 100644
--- a/hw/i386/xen/xen-pvh.c
+++ b/hw/i386/xen/xen-pvh.c
@@ -10,7 +10,7 @@
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
 #include "hw/boards.h"
-#include "sysemu/sysemu.h"
+#include "system/system.h"
 #include "hw/xen/arch_hvm.h"
 #include <xen/hvm/hvm_info_table.h>
 #include "hw/xen/xen-pvh-common.h"
diff --git a/hw/i386/xen/xen_platform.c b/hw/i386/xen/xen_platform.c
index ec0e536e852..0f68c3fe7b3 100644
--- a/hw/i386/xen/xen_platform.c
+++ b/hw/i386/xen/xen_platform.c
@@ -30,8 +30,8 @@
 #include "migration/vmstate.h"
 #include "net/net.h"
 #include "trace.h"
-#include "sysemu/xen.h"
-#include "sysemu/block-backend.h"
+#include "system/xen.h"
+#include "system/block-backend.h"
 #include "qemu/error-report.h"
 #include "qemu/module.h"
 #include "qom/object.h"
diff --git a/hw/ide/ahci-allwinner.c b/hw/ide/ahci-allwinner.c
index 9620de8ce84..575be36fc5c 100644
--- a/hw/ide/ahci-allwinner.c
+++ b/hw/ide/ahci-allwinner.c
@@ -18,7 +18,7 @@
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
 #include "qemu/module.h"
-#include "sysemu/dma.h"
+#include "system/dma.h"
 #include "migration/vmstate.h"
 #include "hw/ide/ahci-sysbus.h"
 
diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index c02357735ed..1303c21cb70 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -28,8 +28,8 @@
 #include "qemu/error-report.h"
 #include "qemu/log.h"
 #include "qemu/main-loop.h"
-#include "sysemu/block-backend.h"
-#include "sysemu/dma.h"
+#include "system/block-backend.h"
+#include "system/dma.h"
 #include "ahci-internal.h"
 #include "ide-internal.h"
 
diff --git a/hw/ide/atapi.c b/hw/ide/atapi.c
index e82959dc2d3..a42b7485218 100644
--- a/hw/ide/atapi.c
+++ b/hw/ide/atapi.c
@@ -26,7 +26,7 @@
 #include "qemu/osdep.h"
 #include "qemu/cutils.h"
 #include "hw/scsi/scsi.h"
-#include "sysemu/block-backend.h"
+#include "system/block-backend.h"
 #include "scsi/constants.h"
 #include "ide-internal.h"
 #include "trace.h"
diff --git a/hw/ide/cmd646.c b/hw/ide/cmd646.c
index 942f6c470c8..20410c81fae 100644
--- a/hw/ide/cmd646.c
+++ b/hw/ide/cmd646.c
@@ -29,8 +29,8 @@
 #include "migration/vmstate.h"
 #include "qemu/module.h"
 #include "hw/isa/isa.h"
-#include "sysemu/dma.h"
-#include "sysemu/reset.h"
+#include "system/dma.h"
+#include "system/reset.h"
 
 #include "hw/ide/pci.h"
 #include "ide-internal.h"
diff --git a/hw/ide/core.c b/hw/ide/core.c
index 08d92184554..f9baba59e93 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -32,15 +32,15 @@
 #include "qemu/timer.h"
 #include "qemu/hw-version.h"
 #include "qemu/memalign.h"
-#include "sysemu/sysemu.h"
-#include "sysemu/blockdev.h"
-#include "sysemu/dma.h"
+#include "system/system.h"
+#include "system/blockdev.h"
+#include "system/dma.h"
 #include "hw/block/block.h"
-#include "sysemu/block-backend.h"
+#include "system/block-backend.h"
 #include "qapi/error.h"
 #include "qemu/cutils.h"
-#include "sysemu/replay.h"
-#include "sysemu/runstate.h"
+#include "system/replay.h"
+#include "system/runstate.h"
 #include "ide-internal.h"
 #include "trace.h"
 
diff --git a/hw/ide/ich.c b/hw/ide/ich.c
index c99a44df8e1..a83128465f2 100644
--- a/hw/ide/ich.c
+++ b/hw/ide/ich.c
@@ -66,7 +66,7 @@
 #include "migration/vmstate.h"
 #include "qemu/module.h"
 #include "hw/isa/isa.h"
-#include "sysemu/dma.h"
+#include "system/dma.h"
 #include "hw/ide/pci.h"
 #include "hw/ide/ahci-pci.h"
 #include "ahci-internal.h"
diff --git a/hw/ide/ide-bus.c b/hw/ide/ide-bus.c
index 37d003dd9ad..437502b5b4f 100644
--- a/hw/ide/ide-bus.c
+++ b/hw/ide/ide-bus.c
@@ -21,9 +21,9 @@
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "qemu/module.h"
-#include "sysemu/block-backend.h"
-#include "sysemu/blockdev.h"
-#include "sysemu/runstate.h"
+#include "system/block-backend.h"
+#include "system/blockdev.h"
+#include "system/runstate.h"
 #include "ide-internal.h"
 
 static char *idebus_get_fw_dev_path(DeviceState *dev);
diff --git a/hw/ide/ide-dev.c b/hw/ide/ide-dev.c
index cc92531f1ce..6eae80c588f 100644
--- a/hw/ide/ide-dev.c
+++ b/hw/ide/ide-dev.c
@@ -23,9 +23,9 @@
 #include "qemu/error-report.h"
 #include "qemu/module.h"
 #include "hw/ide/ide-dev.h"
-#include "sysemu/block-backend.h"
-#include "sysemu/blockdev.h"
-#include "sysemu/sysemu.h"
+#include "system/block-backend.h"
+#include "system/blockdev.h"
+#include "system/system.h"
 #include "qapi/visitor.h"
 #include "ide-internal.h"
 
diff --git a/hw/ide/isa.c b/hw/ide/isa.c
index a0a7e4837c2..b5425491604 100644
--- a/hw/ide/isa.c
+++ b/hw/ide/isa.c
@@ -29,7 +29,7 @@
 #include "migration/vmstate.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
-#include "sysemu/dma.h"
+#include "system/dma.h"
 
 #include "hw/ide/isa.h"
 #include "qom/object.h"
diff --git a/hw/ide/macio.c b/hw/ide/macio.c
index 25f8403e80f..f5579bb896e 100644
--- a/hw/ide/macio.c
+++ b/hw/ide/macio.c
@@ -30,8 +30,8 @@
 #include "migration/vmstate.h"
 #include "qemu/module.h"
 #include "hw/misc/macio/macio.h"
-#include "sysemu/block-backend.h"
-#include "sysemu/dma.h"
+#include "system/block-backend.h"
+#include "system/dma.h"
 
 #include "ide-internal.h"
 
diff --git a/hw/ide/mmio.c b/hw/ide/mmio.c
index 43ab66f3478..71a17fe41ce 100644
--- a/hw/ide/mmio.c
+++ b/hw/ide/mmio.c
@@ -27,7 +27,7 @@
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
 #include "qemu/module.h"
-#include "sysemu/dma.h"
+#include "system/dma.h"
 
 #include "hw/ide/mmio.h"
 #include "hw/qdev-properties.h"
diff --git a/hw/ide/pci.c b/hw/ide/pci.c
index a008fe7316a..0ed72e42233 100644
--- a/hw/ide/pci.c
+++ b/hw/ide/pci.c
@@ -27,7 +27,7 @@
 #include "hw/irq.h"
 #include "hw/pci/pci.h"
 #include "migration/vmstate.h"
-#include "sysemu/dma.h"
+#include "system/dma.h"
 #include "qemu/error-report.h"
 #include "qemu/module.h"
 #include "hw/ide/pci.h"
diff --git a/hw/ide/via.c b/hw/ide/via.c
index c88eb6c025f..89fd28f646c 100644
--- a/hw/ide/via.c
+++ b/hw/ide/via.c
@@ -29,7 +29,7 @@
 #include "migration/vmstate.h"
 #include "qemu/module.h"
 #include "qemu/range.h"
-#include "sysemu/dma.h"
+#include "system/dma.h"
 #include "hw/isa/vt82c686.h"
 #include "hw/ide/pci.h"
 #include "hw/irq.h"
diff --git a/hw/input/pckbd.c b/hw/input/pckbd.c
index 24a133fd252..6338a7525a8 100644
--- a/hw/input/pckbd.c
+++ b/hw/input/pckbd.c
@@ -34,8 +34,8 @@
 #include "hw/irq.h"
 #include "hw/input/i8042.h"
 #include "hw/qdev-properties.h"
-#include "sysemu/reset.h"
-#include "sysemu/runstate.h"
+#include "system/reset.h"
+#include "system/runstate.h"
 
 #include "trace.h"
 
diff --git a/hw/input/ps2.c b/hw/input/ps2.c
index d6f834443dd..6a41b024c80 100644
--- a/hw/input/ps2.c
+++ b/hw/input/ps2.c
@@ -30,8 +30,8 @@
 #include "migration/vmstate.h"
 #include "ui/console.h"
 #include "ui/input.h"
-#include "sysemu/reset.h"
-#include "sysemu/runstate.h"
+#include "system/reset.h"
+#include "system/runstate.h"
 #include "qapi/error.h"
 
 #include "trace.h"
diff --git a/hw/intc/apic.c b/hw/intc/apic.c
index 4186c57b34c..d1d343d4216 100644
--- a/hw/intc/apic.c
+++ b/hw/intc/apic.c
@@ -26,7 +26,7 @@
 #include "hw/intc/kvm_irqcount.h"
 #include "hw/pci/msi.h"
 #include "qemu/host-utils.h"
-#include "sysemu/kvm.h"
+#include "system/kvm.h"
 #include "trace.h"
 #include "hw/i386/apic-msidef.h"
 #include "qapi/error.h"
diff --git a/hw/intc/apic_common.c b/hw/intc/apic_common.c
index 8be9f22de82..85ded28032d 100644
--- a/hw/intc/apic_common.c
+++ b/hw/intc/apic_common.c
@@ -28,7 +28,7 @@
 #include "hw/intc/kvm_irqcount.h"
 #include "trace.h"
 #include "hw/boards.h"
-#include "sysemu/kvm.h"
+#include "system/kvm.h"
 #include "hw/qdev-properties.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
diff --git a/hw/intc/arm_gic.c b/hw/intc/arm_gic.c
index 2a48f0da2fe..3581ff8e8a2 100644
--- a/hw/intc/arm_gic.c
+++ b/hw/intc/arm_gic.c
@@ -27,8 +27,8 @@
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "trace.h"
-#include "sysemu/kvm.h"
-#include "sysemu/qtest.h"
+#include "system/kvm.h"
+#include "system/qtest.h"
 
 /* #define DEBUG_GIC */
 
diff --git a/hw/intc/arm_gic_common.c b/hw/intc/arm_gic_common.c
index e961cd91565..5eba8badb8c 100644
--- a/hw/intc/arm_gic_common.c
+++ b/hw/intc/arm_gic_common.c
@@ -26,7 +26,7 @@
 #include "hw/arm/linux-boot-if.h"
 #include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
-#include "sysemu/kvm.h"
+#include "system/kvm.h"
 
 static int gic_pre_save(void *opaque)
 {
diff --git a/hw/intc/arm_gic_kvm.c b/hw/intc/arm_gic_kvm.c
index e2a73337b1e..40adb028654 100644
--- a/hw/intc/arm_gic_kvm.c
+++ b/hw/intc/arm_gic_kvm.c
@@ -23,7 +23,7 @@
 #include "qapi/error.h"
 #include "qemu/module.h"
 #include "migration/blocker.h"
-#include "sysemu/kvm.h"
+#include "system/kvm.h"
 #include "kvm_arm.h"
 #include "gic_internal.h"
 #include "vgic_common.h"
diff --git a/hw/intc/arm_gicv2m.c b/hw/intc/arm_gicv2m.c
index ffa830b433c..66d4377cde0 100644
--- a/hw/intc/arm_gicv2m.c
+++ b/hw/intc/arm_gicv2m.c
@@ -31,7 +31,7 @@
 #include "hw/irq.h"
 #include "hw/pci/msi.h"
 #include "hw/qdev-properties.h"
-#include "sysemu/kvm.h"
+#include "system/kvm.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "qom/object.h"
diff --git a/hw/intc/arm_gicv3_common.c b/hw/intc/arm_gicv3_common.c
index a8ec615a3fe..67d0ab71cc1 100644
--- a/hw/intc/arm_gicv3_common.c
+++ b/hw/intc/arm_gicv3_common.c
@@ -31,7 +31,7 @@
 #include "migration/vmstate.h"
 #include "gicv3_internal.h"
 #include "hw/arm/linux-boot-if.h"
-#include "sysemu/kvm.h"
+#include "system/kvm.h"
 
 
 static void gicv3_gicd_no_migration_shift_bug_post_load(GICv3State *cs)
diff --git a/hw/intc/arm_gicv3_cpuif.c b/hw/intc/arm_gicv3_cpuif.c
index ea1d1b34551..9cad8313a3a 100644
--- a/hw/intc/arm_gicv3_cpuif.c
+++ b/hw/intc/arm_gicv3_cpuif.c
@@ -22,8 +22,8 @@
 #include "cpu.h"
 #include "target/arm/cpregs.h"
 #include "target/arm/cpu-features.h"
-#include "sysemu/tcg.h"
-#include "sysemu/qtest.h"
+#include "system/tcg.h"
+#include "system/qtest.h"
 
 /*
  * Special case return value from hppvi_index(); must be larger than
diff --git a/hw/intc/arm_gicv3_its_common.c b/hw/intc/arm_gicv3_its_common.c
index 0b97362cd21..70dbee83a65 100644
--- a/hw/intc/arm_gicv3_its_common.c
+++ b/hw/intc/arm_gicv3_its_common.c
@@ -24,7 +24,7 @@
 #include "hw/intc/arm_gicv3_its_common.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
-#include "sysemu/kvm.h"
+#include "system/kvm.h"
 
 static int gicv3_its_pre_save(void *opaque)
 {
diff --git a/hw/intc/arm_gicv3_its_kvm.c b/hw/intc/arm_gicv3_its_kvm.c
index 68a6144add8..62961b62b4b 100644
--- a/hw/intc/arm_gicv3_its_kvm.c
+++ b/hw/intc/arm_gicv3_its_kvm.c
@@ -24,8 +24,8 @@
 #include "qemu/error-report.h"
 #include "hw/intc/arm_gicv3_its_common.h"
 #include "hw/qdev-properties.h"
-#include "sysemu/runstate.h"
-#include "sysemu/kvm.h"
+#include "system/runstate.h"
+#include "system/kvm.h"
 #include "kvm_arm.h"
 #include "migration/blocker.h"
 #include "qom/object.h"
diff --git a/hw/intc/arm_gicv3_kvm.c b/hw/intc/arm_gicv3_kvm.c
index 9ea6b8e2189..8e17cab2a0f 100644
--- a/hw/intc/arm_gicv3_kvm.c
+++ b/hw/intc/arm_gicv3_kvm.c
@@ -24,8 +24,8 @@
 #include "hw/intc/arm_gicv3_common.h"
 #include "qemu/error-report.h"
 #include "qemu/module.h"
-#include "sysemu/kvm.h"
-#include "sysemu/runstate.h"
+#include "system/kvm.h"
+#include "system/runstate.h"
 #include "kvm_arm.h"
 #include "gicv3_internal.h"
 #include "vgic_common.h"
diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index 6e2803b1234..10a773c07f6 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -18,8 +18,8 @@
 #include "hw/intc/armv7m_nvic.h"
 #include "hw/irq.h"
 #include "hw/qdev-properties.h"
-#include "sysemu/tcg.h"
-#include "sysemu/runstate.h"
+#include "system/tcg.h"
+#include "system/runstate.h"
 #include "target/arm/cpu.h"
 #include "target/arm/cpu-features.h"
 #include "exec/exec-all.h"
diff --git a/hw/intc/ioapic.c b/hw/intc/ioapic.c
index 6d566165b02..d101df1ca0a 100644
--- a/hw/intc/ioapic.c
+++ b/hw/intc/ioapic.c
@@ -30,8 +30,8 @@
 #include "hw/intc/ioapic_internal.h"
 #include "hw/pci/msi.h"
 #include "hw/qdev-properties.h"
-#include "sysemu/kvm.h"
-#include "sysemu/sysemu.h"
+#include "system/kvm.h"
+#include "system/system.h"
 #include "hw/i386/apic-msidef.h"
 #include "hw/i386/x86-iommu.h"
 #include "trace.h"
diff --git a/hw/intc/mips_gic.c b/hw/intc/mips_gic.c
index 996db095c38..f34f0bc3502 100644
--- a/hw/intc/mips_gic.c
+++ b/hw/intc/mips_gic.c
@@ -15,8 +15,8 @@
 #include "qapi/error.h"
 #include "hw/sysbus.h"
 #include "exec/memory.h"
-#include "sysemu/kvm.h"
-#include "sysemu/reset.h"
+#include "system/kvm.h"
+#include "system/reset.h"
 #include "kvm_mips.h"
 #include "hw/intc/mips_gic.h"
 #include "hw/irq.h"
diff --git a/hw/intc/openpic_kvm.c b/hw/intc/openpic_kvm.c
index 135fe8301af..13aa653aa12 100644
--- a/hw/intc/openpic_kvm.c
+++ b/hw/intc/openpic_kvm.c
@@ -30,7 +30,7 @@
 #include "hw/pci/msi.h"
 #include "hw/qdev-properties.h"
 #include "hw/sysbus.h"
-#include "sysemu/kvm.h"
+#include "system/kvm.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "qom/object.h"
diff --git a/hw/intc/pnv_xive.c b/hw/intc/pnv_xive.c
index 581659839b2..c374aed43ab 100644
--- a/hw/intc/pnv_xive.c
+++ b/hw/intc/pnv_xive.c
@@ -12,9 +12,9 @@
 #include "qemu/module.h"
 #include "qapi/error.h"
 #include "target/ppc/cpu.h"
-#include "sysemu/cpus.h"
-#include "sysemu/dma.h"
-#include "sysemu/reset.h"
+#include "system/cpus.h"
+#include "system/dma.h"
+#include "system/reset.h"
 #include "hw/ppc/fdt.h"
 #include "hw/ppc/pnv.h"
 #include "hw/ppc/pnv_chip.h"
diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
index 5dd305453ae..ae6da95df2f 100644
--- a/hw/intc/pnv_xive2.c
+++ b/hw/intc/pnv_xive2.c
@@ -11,8 +11,8 @@
 #include "qemu/log.h"
 #include "qapi/error.h"
 #include "target/ppc/cpu.h"
-#include "sysemu/cpus.h"
-#include "sysemu/dma.h"
+#include "system/cpus.h"
+#include "system/dma.h"
 #include "hw/ppc/fdt.h"
 #include "hw/ppc/pnv.h"
 #include "hw/ppc/pnv_chip.h"
@@ -24,8 +24,8 @@
 #include "hw/ppc/xive2_regs.h"
 #include "hw/ppc/ppc.h"
 #include "hw/qdev-properties.h"
-#include "sysemu/reset.h"
-#include "sysemu/qtest.h"
+#include "system/reset.h"
+#include "system/qtest.h"
 
 #include <libfdt.h>
 
diff --git a/hw/intc/riscv_aplic.c b/hw/intc/riscv_aplic.c
index 353eec81360..b56edecb500 100644
--- a/hw/intc/riscv_aplic.c
+++ b/hw/intc/riscv_aplic.c
@@ -30,8 +30,8 @@
 #include "hw/intc/riscv_aplic.h"
 #include "hw/irq.h"
 #include "target/riscv/cpu.h"
-#include "sysemu/sysemu.h"
-#include "sysemu/kvm.h"
+#include "system/system.h"
+#include "system/kvm.h"
 #include "kvm/kvm_riscv.h"
 #include "migration/vmstate.h"
 
diff --git a/hw/intc/riscv_imsic.c b/hw/intc/riscv_imsic.c
index adc36151b4c..cfd9eca8bcd 100644
--- a/hw/intc/riscv_imsic.c
+++ b/hw/intc/riscv_imsic.c
@@ -31,8 +31,8 @@
 #include "hw/irq.h"
 #include "target/riscv/cpu.h"
 #include "target/riscv/cpu_bits.h"
-#include "sysemu/sysemu.h"
-#include "sysemu/kvm.h"
+#include "system/system.h"
+#include "system/kvm.h"
 #include "migration/vmstate.h"
 
 #define IMSIC_MMIO_PAGE_LE             0x00
diff --git a/hw/intc/s390_flic_kvm.c b/hw/intc/s390_flic_kvm.c
index 7930d72390c..10aaafbb312 100644
--- a/hw/intc/s390_flic_kvm.c
+++ b/hw/intc/s390_flic_kvm.c
@@ -16,7 +16,7 @@
 #include "qemu/error-report.h"
 #include "qemu/module.h"
 #include "qapi/error.h"
-#include "sysemu/kvm.h"
+#include "system/kvm.h"
 #include "hw/s390x/s390_flic.h"
 #include "hw/s390x/adapter.h"
 #include "hw/s390x/css.h"
diff --git a/hw/intc/sifive_plic.c b/hw/intc/sifive_plic.c
index 49895be803d..5b011b2a7d9 100644
--- a/hw/intc/sifive_plic.c
+++ b/hw/intc/sifive_plic.c
@@ -30,7 +30,7 @@
 #include "target/riscv/cpu.h"
 #include "migration/vmstate.h"
 #include "hw/irq.h"
-#include "sysemu/kvm.h"
+#include "system/kvm.h"
 
 static bool addr_between(uint32_t addr, uint32_t base, uint32_t num)
 {
diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index 09f643d633a..bb9b2a4a12a 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -13,8 +13,8 @@
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "target/ppc/cpu.h"
-#include "sysemu/cpus.h"
-#include "sysemu/reset.h"
+#include "system/cpus.h"
+#include "system/reset.h"
 #include "migration/vmstate.h"
 #include "hw/ppc/fdt.h"
 #include "hw/ppc/spapr.h"
diff --git a/hw/intc/spapr_xive_kvm.c b/hw/intc/spapr_xive_kvm.c
index 7a86197fc95..26d30b41c15 100644
--- a/hw/intc/spapr_xive_kvm.c
+++ b/hw/intc/spapr_xive_kvm.c
@@ -12,9 +12,9 @@
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "target/ppc/cpu.h"
-#include "sysemu/cpus.h"
-#include "sysemu/kvm.h"
-#include "sysemu/runstate.h"
+#include "system/cpus.h"
+#include "system/kvm.h"
+#include "system/runstate.h"
 #include "hw/ppc/spapr.h"
 #include "hw/ppc/spapr_cpu_core.h"
 #include "hw/ppc/spapr_xive.h"
diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index 81bbfdd84b2..aa3f7d7daaf 100644
--- a/hw/intc/xics.c
+++ b/hw/intc/xics.c
@@ -37,8 +37,8 @@
 #include "migration/vmstate.h"
 #include "hw/intc/intc.h"
 #include "hw/irq.h"
-#include "sysemu/kvm.h"
-#include "sysemu/reset.h"
+#include "system/kvm.h"
+#include "system/reset.h"
 #include "target/ppc/cpu.h"
 
 void icp_pic_print_info(ICPState *icp, GString *buf)
diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
index 9719d98a179..ee72969f5f1 100644
--- a/hw/intc/xics_kvm.c
+++ b/hw/intc/xics_kvm.c
@@ -28,7 +28,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "trace.h"
-#include "sysemu/kvm.h"
+#include "system/kvm.h"
 #include "hw/ppc/spapr.h"
 #include "hw/ppc/spapr_cpu_core.h"
 #include "hw/ppc/xics.h"
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 308e5743bdb..5994e4ce36f 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -12,9 +12,9 @@
 #include "qemu/module.h"
 #include "qapi/error.h"
 #include "target/ppc/cpu.h"
-#include "sysemu/cpus.h"
-#include "sysemu/dma.h"
-#include "sysemu/reset.h"
+#include "system/cpus.h"
+#include "system/dma.h"
+#include "system/reset.h"
 #include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "hw/irq.h"
diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
index 3233d3f14e0..91d3d68705e 100644
--- a/hw/intc/xive2.c
+++ b/hw/intc/xive2.c
@@ -12,8 +12,8 @@
 #include "qemu/module.h"
 #include "qapi/error.h"
 #include "target/ppc/cpu.h"
-#include "sysemu/cpus.h"
-#include "sysemu/dma.h"
+#include "system/cpus.h"
+#include "system/dma.h"
 #include "hw/qdev-properties.h"
 #include "hw/ppc/xive.h"
 #include "hw/ppc/xive2.h"
diff --git a/hw/ipmi/ipmi.c b/hw/ipmi/ipmi.c
index 850b3bc4630..a1cb853d921 100644
--- a/hw/ipmi/ipmi.c
+++ b/hw/ipmi/ipmi.c
@@ -26,7 +26,7 @@
 #include "hw/ipmi/ipmi.h"
 #include "hw/qdev-properties.h"
 #include "qom/object_interfaces.h"
-#include "sysemu/runstate.h"
+#include "system/runstate.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
 #include "hw/nmi.h"
diff --git a/hw/ipmi/ipmi_bmc_sim.c b/hw/ipmi/ipmi_bmc_sim.c
index 8a55893e89b..bd02e8244ea 100644
--- a/hw/ipmi/ipmi_bmc_sim.c
+++ b/hw/ipmi/ipmi_bmc_sim.c
@@ -23,7 +23,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "sysemu/sysemu.h"
+#include "system/system.h"
 #include "qemu/timer.h"
 #include "hw/ipmi/ipmi.h"
 #include "qemu/error-report.h"
diff --git a/hw/isa/isa-bus.c b/hw/isa/isa-bus.c
index f1e0f140078..2599c1219a5 100644
--- a/hw/isa/isa-bus.c
+++ b/hw/isa/isa-bus.c
@@ -22,7 +22,7 @@
 #include "qemu/module.h"
 #include "qapi/error.h"
 #include "hw/sysbus.h"
-#include "sysemu/sysemu.h"
+#include "system/system.h"
 #include "hw/isa/isa.h"
 
 static ISABus *isabus;
diff --git a/hw/isa/isa-superio.c b/hw/isa/isa-superio.c
index cff756e791b..4260da547c6 100644
--- a/hw/isa/isa-superio.c
+++ b/hw/isa/isa-superio.c
@@ -14,7 +14,7 @@
 #include "qemu/error-report.h"
 #include "qemu/module.h"
 #include "qapi/error.h"
-#include "sysemu/blockdev.h"
+#include "system/blockdev.h"
 #include "chardev/char.h"
 #include "hw/char/parallel.h"
 #include "hw/block/fdc.h"
diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
index 378244aa8fc..46a74fd6ef3 100644
--- a/hw/isa/lpc_ich9.c
+++ b/hw/isa/lpc_ich9.c
@@ -46,8 +46,8 @@
 #include "hw/acpi/ich9_timer.h"
 #include "hw/pci/pci_bus.h"
 #include "hw/qdev-properties.h"
-#include "sysemu/runstate.h"
-#include "sysemu/sysemu.h"
+#include "system/runstate.h"
+#include "system/system.h"
 #include "hw/core/cpu.h"
 #include "hw/nvram/fw_cfg.h"
 #include "qemu/cutils.h"
diff --git a/hw/isa/piix.c b/hw/isa/piix.c
index 8ec9c63b8a0..fee4d8804c1 100644
--- a/hw/isa/piix.c
+++ b/hw/isa/piix.c
@@ -34,7 +34,7 @@
 #include "hw/ide/piix.h"
 #include "hw/intc/i8259.h"
 #include "hw/isa/isa.h"
-#include "sysemu/runstate.h"
+#include "system/runstate.h"
 #include "migration/vmstate.h"
 #include "hw/acpi/acpi_aml_interface.h"
 
diff --git a/hw/loongarch/acpi-build.c b/hw/loongarch/acpi-build.c
index 50709bda0f9..d538946bc3d 100644
--- a/hw/loongarch/acpi-build.c
+++ b/hw/loongarch/acpi-build.c
@@ -18,7 +18,7 @@
 #include "hw/acpi/bios-linker-loader.h"
 #include "migration/vmstate.h"
 #include "hw/mem/memory-device.h"
-#include "sysemu/reset.h"
+#include "system/reset.h"
 
 /* Supported chipsets: */
 #include "hw/pci-host/ls7a.h"
@@ -31,8 +31,8 @@
 
 #include "hw/acpi/generic_event_device.h"
 #include "hw/pci-host/gpex.h"
-#include "sysemu/sysemu.h"
-#include "sysemu/tpm.h"
+#include "system/system.h"
+#include "system/tpm.h"
 #include "hw/platform-bus.h"
 #include "hw/acpi/aml-build.h"
 #include "hw/acpi/hmat.h"
diff --git a/hw/loongarch/boot.c b/hw/loongarch/boot.c
index f258eefe9ac..48154cdce6f 100644
--- a/hw/loongarch/boot.c
+++ b/hw/loongarch/boot.c
@@ -12,8 +12,8 @@
 #include "hw/loader.h"
 #include "elf.h"
 #include "qemu/error-report.h"
-#include "sysemu/reset.h"
-#include "sysemu/qtest.h"
+#include "system/reset.h"
+#include "system/qtest.h"
 
 struct memmap_entry *memmap_table;
 unsigned memmap_entries;
diff --git a/hw/loongarch/fw_cfg.c b/hw/loongarch/fw_cfg.c
index 35aeb2decbd..493563669e5 100644
--- a/hw/loongarch/fw_cfg.c
+++ b/hw/loongarch/fw_cfg.c
@@ -9,7 +9,7 @@
 #include "hw/loongarch/fw_cfg.h"
 #include "hw/loongarch/virt.h"
 #include "hw/nvram/fw_cfg.h"
-#include "sysemu/sysemu.h"
+#include "system/system.h"
 
 static void fw_cfg_boot_set(void *opaque, const char *boot_device,
                             Error **errp)
diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index 9a635d1d3d3..824e082a208 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -10,13 +10,13 @@
 #include "qapi/error.h"
 #include "hw/boards.h"
 #include "hw/char/serial-mm.h"
-#include "sysemu/kvm.h"
-#include "sysemu/tcg.h"
-#include "sysemu/sysemu.h"
-#include "sysemu/qtest.h"
-#include "sysemu/runstate.h"
-#include "sysemu/reset.h"
-#include "sysemu/rtc.h"
+#include "system/kvm.h"
+#include "system/tcg.h"
+#include "system/system.h"
+#include "system/qtest.h"
+#include "system/runstate.h"
+#include "system/reset.h"
+#include "system/rtc.h"
 #include "hw/loongarch/virt.h"
 #include "exec/address-spaces.h"
 #include "hw/irq.h"
@@ -37,14 +37,14 @@
 #include "qapi/qapi-visit-common.h"
 #include "hw/acpi/generic_event_device.h"
 #include "hw/mem/nvdimm.h"
-#include "sysemu/device_tree.h"
+#include "system/device_tree.h"
 #include <libfdt.h>
 #include "hw/core/sysbus-fdt.h"
 #include "hw/platform-bus.h"
 #include "hw/display/ramfb.h"
 #include "hw/mem/pc-dimm.h"
-#include "sysemu/tpm.h"
-#include "sysemu/block-backend.h"
+#include "system/tpm.h"
+#include "system/block-backend.h"
 #include "hw/block/flash.h"
 #include "hw/virtio/virtio-iommu.h"
 #include "qemu/error-report.h"
diff --git a/hw/m68k/an5206.c b/hw/m68k/an5206.c
index 1e8e64f8bd0..7b8210475ec 100644
--- a/hw/m68k/an5206.c
+++ b/hw/m68k/an5206.c
@@ -14,7 +14,7 @@
 #include "hw/loader.h"
 #include "elf.h"
 #include "qemu/error-report.h"
-#include "sysemu/qtest.h"
+#include "system/qtest.h"
 
 #define KERNEL_LOAD_ADDR 0x10000
 #define AN5206_MBAR_ADDR 0x10000000
diff --git a/hw/m68k/mcf5206.c b/hw/m68k/mcf5206.c
index 45e5f746009..427b2ba0953 100644
--- a/hw/m68k/mcf5206.c
+++ b/hw/m68k/mcf5206.c
@@ -16,7 +16,7 @@
 #include "hw/m68k/mcf.h"
 #include "qemu/timer.h"
 #include "hw/ptimer.h"
-#include "sysemu/sysemu.h"
+#include "system/system.h"
 #include "hw/sysbus.h"
 
 /* General purpose timer module.  */
diff --git a/hw/m68k/mcf5208.c b/hw/m68k/mcf5208.c
index e37cd50d189..f290ccc7392 100644
--- a/hw/m68k/mcf5208.c
+++ b/hw/m68k/mcf5208.c
@@ -26,8 +26,8 @@
 #include "hw/m68k/mcf_fec.h"
 #include "qemu/timer.h"
 #include "hw/ptimer.h"
-#include "sysemu/sysemu.h"
-#include "sysemu/qtest.h"
+#include "system/system.h"
+#include "system/qtest.h"
 #include "net/net.h"
 #include "hw/boards.h"
 #include "hw/loader.h"
diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index a37ce008740..ec0794adba2 100644
--- a/hw/m68k/next-cube.c
+++ b/hw/m68k/next-cube.c
@@ -11,8 +11,8 @@
 
 #include "qemu/osdep.h"
 #include "exec/hwaddr.h"
-#include "sysemu/sysemu.h"
-#include "sysemu/qtest.h"
+#include "system/system.h"
+#include "system/qtest.h"
 #include "hw/irq.h"
 #include "hw/m68k/next-cube.h"
 #include "hw/boards.h"
diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
index 556604e1dcf..ca3adb9a8ae 100644
--- a/hw/m68k/q800.c
+++ b/hw/m68k/q800.c
@@ -24,7 +24,7 @@
 #include "qemu/units.h"
 #include "qemu/datadir.h"
 #include "qemu/guest-random.h"
-#include "sysemu/sysemu.h"
+#include "system/system.h"
 #include "cpu.h"
 #include "hw/boards.h"
 #include "hw/or-irq.h"
@@ -51,9 +51,9 @@
 #include "net/util.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
-#include "sysemu/qtest.h"
-#include "sysemu/runstate.h"
-#include "sysemu/reset.h"
+#include "system/qtest.h"
+#include "system/runstate.h"
+#include "system/reset.h"
 #include "migration/vmstate.h"
 
 #define MACROM_ADDR     0x40800000
diff --git a/hw/m68k/virt.c b/hw/m68k/virt.c
index d0a7a6bfe24..87ec39eeae1 100644
--- a/hw/m68k/virt.c
+++ b/hw/m68k/virt.c
@@ -10,7 +10,7 @@
 #include "qemu/osdep.h"
 #include "qemu/units.h"
 #include "qemu/guest-random.h"
-#include "sysemu/sysemu.h"
+#include "system/system.h"
 #include "cpu.h"
 #include "hw/boards.h"
 #include "hw/qdev-properties.h"
@@ -24,9 +24,9 @@
 #include "net/net.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
-#include "sysemu/qtest.h"
-#include "sysemu/runstate.h"
-#include "sysemu/reset.h"
+#include "system/qtest.h"
+#include "system/runstate.h"
+#include "system/reset.h"
 
 #include "hw/intc/m68k_irqc.h"
 #include "hw/misc/virt_ctrl.h"
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 12205c4d320..dcaf4017641 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -25,8 +25,8 @@
 #include "qemu/range.h"
 #include "qemu/rcu.h"
 #include "qemu/guest-random.h"
-#include "sysemu/hostmem.h"
-#include "sysemu/numa.h"
+#include "system/hostmem.h"
+#include "system/numa.h"
 #include "hw/cxl/cxl.h"
 #include "hw/pci/msix.h"
 
diff --git a/hw/mem/memory-device.c b/hw/mem/memory-device.c
index a5f279adcc1..1de8dfec7dc 100644
--- a/hw/mem/memory-device.c
+++ b/hw/mem/memory-device.c
@@ -16,7 +16,7 @@
 #include "hw/boards.h"
 #include "qemu/range.h"
 #include "hw/virtio/vhost.h"
-#include "sysemu/kvm.h"
+#include "system/kvm.h"
 #include "exec/address-spaces.h"
 #include "trace.h"
 
diff --git a/hw/mem/nvdimm.c b/hw/mem/nvdimm.c
index 10506d52e4c..9786319f27d 100644
--- a/hw/mem/nvdimm.c
+++ b/hw/mem/nvdimm.c
@@ -30,7 +30,7 @@
 #include "hw/mem/nvdimm.h"
 #include "hw/qdev-properties.h"
 #include "hw/mem/memory-device.h"
-#include "sysemu/hostmem.h"
+#include "system/hostmem.h"
 
 static void nvdimm_get_label_size(Object *obj, Visitor *v, const char *name,
                                   void *opaque, Error **errp)
diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
index 49c5f9fd44a..d2783523a8e 100644
--- a/hw/mem/pc-dimm.c
+++ b/hw/mem/pc-dimm.c
@@ -28,8 +28,8 @@
 #include "qapi/error.h"
 #include "qapi/visitor.h"
 #include "qemu/module.h"
-#include "sysemu/hostmem.h"
-#include "sysemu/numa.h"
+#include "system/hostmem.h"
+#include "system/numa.h"
 #include "trace.h"
 
 static int pc_dimm_get_free_slot(const int *hint, int max_slots, Error **errp);
diff --git a/hw/mem/sparse-mem.c b/hw/mem/sparse-mem.c
index 8d681adfc0b..1f647f80965 100644
--- a/hw/mem/sparse-mem.c
+++ b/hw/mem/sparse-mem.c
@@ -17,7 +17,7 @@
 #include "hw/sysbus.h"
 #include "qapi/error.h"
 #include "qemu/units.h"
-#include "sysemu/qtest.h"
+#include "system/qtest.h"
 #include "hw/mem/sparse-mem.h"
 
 #define SPARSE_MEM(obj) OBJECT_CHECK(SparseMemState, (obj), TYPE_SPARSE_MEM)
diff --git a/hw/microblaze/boot.c b/hw/microblaze/boot.c
index ed61e483ee8..966fb2cb2a3 100644
--- a/hw/microblaze/boot.c
+++ b/hw/microblaze/boot.c
@@ -31,8 +31,8 @@
 #include "qemu/config-file.h"
 #include "qemu/error-report.h"
 #include "qemu/guest-random.h"
-#include "sysemu/device_tree.h"
-#include "sysemu/reset.h"
+#include "system/device_tree.h"
+#include "system/reset.h"
 #include "hw/boards.h"
 #include "hw/loader.h"
 #include "elf.h"
diff --git a/hw/microblaze/petalogix_ml605_mmu.c b/hw/microblaze/petalogix_ml605_mmu.c
index 61e47d83988..deab275495d 100644
--- a/hw/microblaze/petalogix_ml605_mmu.c
+++ b/hw/microblaze/petalogix_ml605_mmu.c
@@ -32,7 +32,7 @@
 #include "hw/sysbus.h"
 #include "net/net.h"
 #include "hw/block/flash.h"
-#include "sysemu/sysemu.h"
+#include "system/system.h"
 #include "hw/boards.h"
 #include "hw/char/serial-mm.h"
 #include "hw/qdev-properties.h"
diff --git a/hw/microblaze/petalogix_s3adsp1800_mmu.c b/hw/microblaze/petalogix_s3adsp1800_mmu.c
index 6c0f5c6c651..4a969af1a01 100644
--- a/hw/microblaze/petalogix_s3adsp1800_mmu.c
+++ b/hw/microblaze/petalogix_s3adsp1800_mmu.c
@@ -30,7 +30,7 @@
 #include "hw/sysbus.h"
 #include "net/net.h"
 #include "hw/block/flash.h"
-#include "sysemu/sysemu.h"
+#include "system/system.h"
 #include "hw/boards.h"
 #include "hw/misc/unimp.h"
 #include "exec/address-spaces.h"
diff --git a/hw/mips/boston.c b/hw/mips/boston.c
index 1ced1e337aa..67044af962a 100644
--- a/hw/mips/boston.c
+++ b/hw/mips/boston.c
@@ -37,11 +37,11 @@
 #include "qemu/guest-random.h"
 #include "qemu/log.h"
 #include "chardev/char.h"
-#include "sysemu/device_tree.h"
-#include "sysemu/sysemu.h"
-#include "sysemu/qtest.h"
-#include "sysemu/runstate.h"
-#include "sysemu/reset.h"
+#include "system/device_tree.h"
+#include "system/system.h"
+#include "system/qtest.h"
+#include "system/runstate.h"
+#include "system/reset.h"
 
 #include <libfdt.h>
 #include "qom/object.h"
diff --git a/hw/mips/cps.c b/hw/mips/cps.c
index 1a2208666cc..2d442fe113a 100644
--- a/hw/mips/cps.c
+++ b/hw/mips/cps.c
@@ -24,8 +24,8 @@
 #include "hw/mips/mips.h"
 #include "hw/qdev-clock.h"
 #include "hw/qdev-properties.h"
-#include "sysemu/kvm.h"
-#include "sysemu/reset.h"
+#include "system/kvm.h"
+#include "system/reset.h"
 
 qemu_irq get_cps_irq(MIPSCPSState *s, int pin_number)
 {
diff --git a/hw/mips/fuloong2e.c b/hw/mips/fuloong2e.c
index 904c10b90e3..16b6a5129e7 100644
--- a/hw/mips/fuloong2e.c
+++ b/hw/mips/fuloong2e.c
@@ -36,9 +36,9 @@
 #include "hw/qdev-properties.h"
 #include "elf.h"
 #include "hw/isa/vt82c686.h"
-#include "sysemu/qtest.h"
-#include "sysemu/reset.h"
-#include "sysemu/sysemu.h"
+#include "system/qtest.h"
+#include "system/reset.h"
+#include "system/system.h"
 #include "qemu/error-report.h"
 #include "exec/tswap.h"
 
diff --git a/hw/mips/jazz.c b/hw/mips/jazz.c
index 0e43c9f0bac..c89610639a9 100644
--- a/hw/mips/jazz.c
+++ b/hw/mips/jazz.c
@@ -32,7 +32,7 @@
 #include "hw/char/parallel.h"
 #include "hw/isa/isa.h"
 #include "hw/block/fdc.h"
-#include "sysemu/sysemu.h"
+#include "system/system.h"
 #include "hw/boards.h"
 #include "net/net.h"
 #include "hw/scsi/esp.h"
@@ -44,8 +44,8 @@
 #include "hw/audio/pcspk.h"
 #include "hw/input/i8042.h"
 #include "hw/sysbus.h"
-#include "sysemu/qtest.h"
-#include "sysemu/reset.h"
+#include "system/qtest.h"
+#include "system/reset.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "qemu/help_option.h"
diff --git a/hw/mips/loongson3_virt.c b/hw/mips/loongson3_virt.c
index f3b6326cc59..f12f8c3d3cc 100644
--- a/hw/mips/loongson3_virt.c
+++ b/hw/mips/loongson3_virt.c
@@ -45,10 +45,10 @@
 #include "hw/pci-host/gpex.h"
 #include "hw/usb.h"
 #include "net/net.h"
-#include "sysemu/kvm.h"
-#include "sysemu/qtest.h"
-#include "sysemu/reset.h"
-#include "sysemu/runstate.h"
+#include "system/kvm.h"
+#include "system/qtest.h"
+#include "system/reset.h"
+#include "system/runstate.h"
 #include "qemu/error-report.h"
 
 #define PM_CNTL_MODE          0x10
diff --git a/hw/mips/malta.c b/hw/mips/malta.c
index 834636dae59..4e9cccaa347 100644
--- a/hw/mips/malta.c
+++ b/hw/mips/malta.c
@@ -49,12 +49,12 @@
 #include "qom/object.h"
 #include "hw/sysbus.h"             /* SysBusDevice */
 #include "qemu/host-utils.h"
-#include "sysemu/qtest.h"
-#include "sysemu/reset.h"
-#include "sysemu/runstate.h"
+#include "system/qtest.h"
+#include "system/reset.h"
+#include "system/runstate.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
-#include "sysemu/kvm.h"
+#include "system/kvm.h"
 #include "semihosting/semihost.h"
 #include "hw/mips/cps.h"
 #include "hw/qdev-clock.h"
diff --git a/hw/mips/mips_int.c b/hw/mips/mips_int.c
index eef2fd2cd11..26fdb934f50 100644
--- a/hw/mips/mips_int.c
+++ b/hw/mips/mips_int.c
@@ -23,7 +23,7 @@
 #include "qemu/osdep.h"
 #include "qemu/main-loop.h"
 #include "hw/irq.h"
-#include "sysemu/kvm.h"
+#include "system/kvm.h"
 #include "kvm_mips.h"
 
 static void cpu_mips_irq_request(void *opaque, int irq, int level)
diff --git a/hw/mips/mipssim.c b/hw/mips/mipssim.c
index 5f4835a38de..a294779a82b 100644
--- a/hw/mips/mipssim.c
+++ b/hw/mips/mipssim.c
@@ -33,15 +33,15 @@
 #include "hw/mips/mips.h"
 #include "hw/char/serial-mm.h"
 #include "net/net.h"
-#include "sysemu/sysemu.h"
+#include "system/system.h"
 #include "hw/boards.h"
 #include "hw/loader.h"
 #include "elf.h"
 #include "hw/sysbus.h"
 #include "hw/qdev-properties.h"
 #include "qemu/error-report.h"
-#include "sysemu/qtest.h"
-#include "sysemu/reset.h"
+#include "system/qtest.h"
+#include "system/reset.h"
 #include "cpu.h"
 
 #define BIOS_SIZE (4 * MiB)
diff --git a/hw/misc/arm_sysctl.c b/hw/misc/arm_sysctl.c
index 69e379fa107..d13a070204c 100644
--- a/hw/misc/arm_sysctl.c
+++ b/hw/misc/arm_sysctl.c
@@ -11,7 +11,7 @@
 #include "hw/irq.h"
 #include "hw/qdev-properties.h"
 #include "qemu/timer.h"
-#include "sysemu/runstate.h"
+#include "system/runstate.h"
 #include "qemu/bitops.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
diff --git a/hw/misc/bcm2835_powermgt.c b/hw/misc/bcm2835_powermgt.c
index d88689a0a5a..e4e9bae3745 100644
--- a/hw/misc/bcm2835_powermgt.c
+++ b/hw/misc/bcm2835_powermgt.c
@@ -13,7 +13,7 @@
 #include "qemu/module.h"
 #include "hw/misc/bcm2835_powermgt.h"
 #include "migration/vmstate.h"
-#include "sysemu/runstate.h"
+#include "system/runstate.h"
 
 #define PASSWORD 0x5a000000
 #define PASSWORD_MASK 0xff000000
diff --git a/hw/misc/bcm2835_property.c b/hw/misc/bcm2835_property.c
index 09a6f2c6e3e..ffba747f8ca 100644
--- a/hw/misc/bcm2835_property.c
+++ b/hw/misc/bcm2835_property.c
@@ -13,7 +13,7 @@
 #include "hw/irq.h"
 #include "hw/misc/bcm2835_mbox_defs.h"
 #include "hw/arm/raspberrypi-fw-defs.h"
-#include "sysemu/dma.h"
+#include "system/dma.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "trace.h"
diff --git a/hw/misc/debugexit.c b/hw/misc/debugexit.c
index 639a8cc3e3e..8bd4563ae9e 100644
--- a/hw/misc/debugexit.c
+++ b/hw/misc/debugexit.c
@@ -12,7 +12,7 @@
 #include "hw/qdev-properties.h"
 #include "qemu/module.h"
 #include "qom/object.h"
-#include "sysemu/runstate.h"
+#include "system/runstate.h"
 
 #define TYPE_ISA_DEBUG_EXIT_DEVICE "isa-debug-exit"
 OBJECT_DECLARE_SIMPLE_TYPE(ISADebugExitState, ISA_DEBUG_EXIT_DEVICE)
diff --git a/hw/misc/exynos4210_pmu.c b/hw/misc/exynos4210_pmu.c
index 9d3c2e817d2..d44aac3af5c 100644
--- a/hw/misc/exynos4210_pmu.c
+++ b/hw/misc/exynos4210_pmu.c
@@ -28,7 +28,7 @@
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
 #include "qemu/module.h"
-#include "sysemu/runstate.h"
+#include "system/runstate.h"
 #include "qom/object.h"
 
 #ifndef DEBUG_PMU
diff --git a/hw/misc/imx7_snvs.c b/hw/misc/imx7_snvs.c
index 070d55339e3..c8a096bc137 100644
--- a/hw/misc/imx7_snvs.c
+++ b/hw/misc/imx7_snvs.c
@@ -19,9 +19,9 @@
 #include "hw/misc/imx7_snvs.h"
 #include "qemu/cutils.h"
 #include "qemu/module.h"
-#include "sysemu/sysemu.h"
-#include "sysemu/rtc.h"
-#include "sysemu/runstate.h"
+#include "system/system.h"
+#include "system/rtc.h"
+#include "system/runstate.h"
 #include "trace.h"
 
 #define RTC_FREQ    32768ULL
diff --git a/hw/misc/iotkit-sysctl.c b/hw/misc/iotkit-sysctl.c
index 23b49d7dff3..93db754ce04 100644
--- a/hw/misc/iotkit-sysctl.c
+++ b/hw/misc/iotkit-sysctl.c
@@ -20,7 +20,7 @@
 #include "qemu/bitops.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
-#include "sysemu/runstate.h"
+#include "system/runstate.h"
 #include "trace.h"
 #include "qapi/error.h"
 #include "hw/sysbus.h"
diff --git a/hw/misc/ivshmem.c b/hw/misc/ivshmem.c
index 6d735ec29fe..e7c1d23570a 100644
--- a/hw/misc/ivshmem.c
+++ b/hw/misc/ivshmem.c
@@ -26,7 +26,7 @@
 #include "hw/qdev-properties-system.h"
 #include "hw/pci/msi.h"
 #include "hw/pci/msix.h"
-#include "sysemu/kvm.h"
+#include "system/kvm.h"
 #include "migration/blocker.h"
 #include "migration/vmstate.h"
 #include "qemu/error-report.h"
@@ -34,7 +34,7 @@
 #include "qemu/module.h"
 #include "qom/object_interfaces.h"
 #include "chardev/char-fe.h"
-#include "sysemu/hostmem.h"
+#include "system/hostmem.h"
 #include "qapi/visitor.h"
 
 #include "hw/misc/ivshmem.h"
diff --git a/hw/misc/lasi.c b/hw/misc/lasi.c
index 5dc209cf8d6..24d20ffcb8d 100644
--- a/hw/misc/lasi.c
+++ b/hw/misc/lasi.c
@@ -15,8 +15,8 @@
 #include "qapi/error.h"
 #include "trace.h"
 #include "hw/irq.h"
-#include "sysemu/sysemu.h"
-#include "sysemu/runstate.h"
+#include "system/system.h"
+#include "system/runstate.h"
 #include "migration/vmstate.h"
 #include "qom/object.h"
 #include "hw/misc/lasi.h"
diff --git a/hw/misc/mac_via.c b/hw/misc/mac_via.c
index a376a2b8a02..ed767cde60a 100644
--- a/hw/misc/mac_via.c
+++ b/hw/misc/mac_via.c
@@ -24,13 +24,13 @@
 #include "hw/misc/mac_via.h"
 #include "hw/misc/mos6522.h"
 #include "hw/input/adb.h"
-#include "sysemu/runstate.h"
+#include "system/runstate.h"
 #include "qapi/error.h"
 #include "qemu/cutils.h"
 #include "hw/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
-#include "sysemu/block-backend.h"
-#include "sysemu/rtc.h"
+#include "system/block-backend.h"
+#include "system/rtc.h"
 #include "trace.h"
 #include "qemu/log.h"
 
diff --git a/hw/misc/macio/cuda.c b/hw/misc/macio/cuda.c
index cfc8afd1dc2..8130421d5d5 100644
--- a/hw/misc/macio/cuda.c
+++ b/hw/misc/macio/cuda.c
@@ -29,8 +29,8 @@
 #include "migration/vmstate.h"
 #include "hw/misc/macio/cuda.h"
 #include "qemu/timer.h"
-#include "sysemu/runstate.h"
-#include "sysemu/rtc.h"
+#include "system/runstate.h"
+#include "system/rtc.h"
 #include "qapi/error.h"
 #include "qemu/cutils.h"
 #include "qemu/log.h"
diff --git a/hw/misc/macio/mac_dbdma.c b/hw/misc/macio/mac_dbdma.c
index 74c2cb3462f..de0f934f7d0 100644
--- a/hw/misc/macio/mac_dbdma.c
+++ b/hw/misc/macio/mac_dbdma.c
@@ -44,7 +44,7 @@
 #include "qemu/main-loop.h"
 #include "qemu/module.h"
 #include "qemu/log.h"
-#include "sysemu/dma.h"
+#include "system/dma.h"
 
 /* debug DBDMA */
 #define DEBUG_DBDMA 0
diff --git a/hw/misc/macio/pmu.c b/hw/misc/macio/pmu.c
index 64bf44f67f6..2dd8af1ae61 100644
--- a/hw/misc/macio/pmu.c
+++ b/hw/misc/macio/pmu.c
@@ -34,8 +34,8 @@
 #include "hw/irq.h"
 #include "hw/misc/macio/pmu.h"
 #include "qemu/timer.h"
-#include "sysemu/runstate.h"
-#include "sysemu/rtc.h"
+#include "system/runstate.h"
+#include "system/rtc.h"
 #include "qapi/error.h"
 #include "qemu/cutils.h"
 #include "qemu/log.h"
diff --git a/hw/misc/npcm7xx_clk.c b/hw/misc/npcm7xx_clk.c
index 2098c85ee01..46f907b61c2 100644
--- a/hw/misc/npcm7xx_clk.c
+++ b/hw/misc/npcm7xx_clk.c
@@ -26,7 +26,7 @@
 #include "qemu/timer.h"
 #include "qemu/units.h"
 #include "trace.h"
-#include "sysemu/watchdog.h"
+#include "system/watchdog.h"
 
 /*
  * The reference clock hz, and the SECCNT and CNTR25M registers in this module,
diff --git a/hw/misc/pci-testdev.c b/hw/misc/pci-testdev.c
index 7927397a23a..6268f5c048f 100644
--- a/hw/misc/pci-testdev.c
+++ b/hw/misc/pci-testdev.c
@@ -23,7 +23,7 @@
 #include "hw/qdev-properties.h"
 #include "qemu/event_notifier.h"
 #include "qemu/module.h"
-#include "sysemu/kvm.h"
+#include "system/kvm.h"
 #include "qom/object.h"
 
 typedef struct PCITestDevHdr {
diff --git a/hw/misc/pvpanic-isa.c b/hw/misc/pvpanic-isa.c
index 824a2e4528c..89ccd8b5753 100644
--- a/hw/misc/pvpanic-isa.c
+++ b/hw/misc/pvpanic-isa.c
@@ -14,7 +14,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/module.h"
-#include "sysemu/runstate.h"
+#include "system/runstate.h"
 
 #include "hw/nvram/fw_cfg.h"
 #include "hw/qdev-properties.h"
diff --git a/hw/misc/pvpanic-pci.c b/hw/misc/pvpanic-pci.c
index 1c3eafc1377..590b9d39ff1 100644
--- a/hw/misc/pvpanic-pci.c
+++ b/hw/misc/pvpanic-pci.c
@@ -13,7 +13,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/module.h"
-#include "sysemu/runstate.h"
+#include "system/runstate.h"
 
 #include "hw/nvram/fw_cfg.h"
 #include "hw/qdev-properties.h"
diff --git a/hw/misc/pvpanic.c b/hw/misc/pvpanic.c
index 3b893340c05..c83247c4087 100644
--- a/hw/misc/pvpanic.c
+++ b/hw/misc/pvpanic.c
@@ -15,7 +15,7 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
-#include "sysemu/runstate.h"
+#include "system/runstate.h"
 
 #include "hw/nvram/fw_cfg.h"
 #include "hw/qdev-properties.h"
diff --git a/hw/misc/sbsa_ec.c b/hw/misc/sbsa_ec.c
index 86b23a5372f..a1e813691e4 100644
--- a/hw/misc/sbsa_ec.c
+++ b/hw/misc/sbsa_ec.c
@@ -13,7 +13,7 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "hw/sysbus.h"
-#include "sysemu/runstate.h"
+#include "system/runstate.h"
 
 typedef struct SECUREECState {
     SysBusDevice parent_obj;
diff --git a/hw/misc/sifive_e_aon.c b/hw/misc/sifive_e_aon.c
index c48429b1315..b3595d04605 100644
--- a/hw/misc/sifive_e_aon.c
+++ b/hw/misc/sifive_e_aon.c
@@ -24,7 +24,7 @@
 #include "hw/misc/sifive_e_aon.h"
 #include "qapi/visitor.h"
 #include "qapi/error.h"
-#include "sysemu/watchdog.h"
+#include "system/watchdog.h"
 #include "hw/qdev-properties.h"
 
 REG32(AON_WDT_WDOGCFG, 0x0)
diff --git a/hw/misc/sifive_test.c b/hw/misc/sifive_test.c
index ad688079c41..b94bb2d29db 100644
--- a/hw/misc/sifive_test.c
+++ b/hw/misc/sifive_test.c
@@ -23,9 +23,9 @@
 #include "qapi/error.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
-#include "sysemu/runstate.h"
+#include "system/runstate.h"
 #include "hw/misc/sifive_test.h"
-#include "sysemu/sysemu.h"
+#include "system/system.h"
 
 static uint64_t sifive_test_read(void *opaque, hwaddr addr, unsigned int size)
 {
diff --git a/hw/misc/sifive_u_otp.c b/hw/misc/sifive_u_otp.c
index 32cd8e8dfbd..2ac41f0e78f 100644
--- a/hw/misc/sifive_u_otp.c
+++ b/hw/misc/sifive_u_otp.c
@@ -27,8 +27,8 @@
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "hw/misc/sifive_u_otp.h"
-#include "sysemu/blockdev.h"
-#include "sysemu/block-backend.h"
+#include "system/blockdev.h"
+#include "system/block-backend.h"
 
 #define WRITTEN_BIT_ON 0x1
 
diff --git a/hw/misc/slavio_misc.c b/hw/misc/slavio_misc.c
index c7905942fb3..dace6d28ccb 100644
--- a/hw/misc/slavio_misc.c
+++ b/hw/misc/slavio_misc.c
@@ -27,7 +27,7 @@
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
 #include "qemu/module.h"
-#include "sysemu/runstate.h"
+#include "system/runstate.h"
 #include "trace.h"
 #include "qom/object.h"
 
diff --git a/hw/misc/virt_ctrl.c b/hw/misc/virt_ctrl.c
index aa00d6c574f..a210a5924c9 100644
--- a/hw/misc/virt_ctrl.c
+++ b/hw/misc/virt_ctrl.c
@@ -10,7 +10,7 @@
 #include "migration/vmstate.h"
 #include "qemu/log.h"
 #include "trace.h"
-#include "sysemu/runstate.h"
+#include "system/runstate.h"
 #include "hw/misc/virt_ctrl.h"
 
 enum {
diff --git a/hw/misc/vmcoreinfo.c b/hw/misc/vmcoreinfo.c
index 833773ade52..0910c64866f 100644
--- a/hw/misc/vmcoreinfo.c
+++ b/hw/misc/vmcoreinfo.c
@@ -13,7 +13,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
-#include "sysemu/reset.h"
+#include "system/reset.h"
 #include "hw/nvram/fw_cfg.h"
 #include "migration/vmstate.h"
 #include "hw/misc/vmcoreinfo.h"
diff --git a/hw/misc/zynq_slcr.c b/hw/misc/zynq_slcr.c
index ffa14ecb84f..d01ba87e11c 100644
--- a/hw/misc/zynq_slcr.c
+++ b/hw/misc/zynq_slcr.c
@@ -16,7 +16,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/timer.h"
-#include "sysemu/runstate.h"
+#include "system/runstate.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
 #include "qemu/log.h"
diff --git a/hw/net/allwinner-sun8i-emac.c b/hw/net/allwinner-sun8i-emac.c
index 3f03060bf57..8cbcceca463 100644
--- a/hw/net/allwinner-sun8i-emac.c
+++ b/hw/net/allwinner-sun8i-emac.c
@@ -30,7 +30,7 @@
 #include "net/checksum.h"
 #include "qemu/module.h"
 #include "exec/cpu-common.h"
-#include "sysemu/dma.h"
+#include "system/dma.h"
 #include "hw/net/allwinner-sun8i-emac.h"
 
 /* EMAC register offsets */
diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
index 3fce01315fe..1c9681cabc3 100644
--- a/hw/net/cadence_gem.c
+++ b/hw/net/cadence_gem.c
@@ -33,7 +33,7 @@
 #include "qapi/error.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
-#include "sysemu/dma.h"
+#include "system/dma.h"
 #include "net/checksum.h"
 #include "net/eth.h"
 
diff --git a/hw/net/e1000.c b/hw/net/e1000.c
index ef0af31751a..9fc71fd1c77 100644
--- a/hw/net/e1000.c
+++ b/hw/net/e1000.c
@@ -33,8 +33,8 @@
 #include "net/eth.h"
 #include "net/net.h"
 #include "net/checksum.h"
-#include "sysemu/sysemu.h"
-#include "sysemu/dma.h"
+#include "system/system.h"
+#include "system/dma.h"
 #include "qemu/iov.h"
 #include "qemu/module.h"
 #include "qemu/range.h"
diff --git a/hw/net/e1000e.c b/hw/net/e1000e.c
index e2b7576f678..8c7a2cddfcb 100644
--- a/hw/net/e1000e.c
+++ b/hw/net/e1000e.c
@@ -40,7 +40,7 @@
 #include "net/tap.h"
 #include "qemu/module.h"
 #include "qemu/range.h"
-#include "sysemu/sysemu.h"
+#include "system/system.h"
 #include "hw/hw.h"
 #include "hw/net/mii.h"
 #include "hw/pci/msi.h"
diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
index 2e4c50ddbaf..24138587905 100644
--- a/hw/net/e1000e_core.c
+++ b/hw/net/e1000e_core.c
@@ -40,7 +40,7 @@
 #include "hw/net/mii.h"
 #include "hw/pci/msi.h"
 #include "hw/pci/msix.h"
-#include "sysemu/runstate.h"
+#include "system/runstate.h"
 
 #include "net_tx_pkt.h"
 #include "net_rx_pkt.h"
diff --git a/hw/net/eepro100.c b/hw/net/eepro100.c
index b8cb8d5cf10..50c287e3bb2 100644
--- a/hw/net/eepro100.c
+++ b/hw/net/eepro100.c
@@ -50,9 +50,9 @@
 #include "net/net.h"
 #include "net/eth.h"
 #include "hw/nvram/eeprom93xx.h"
-#include "sysemu/sysemu.h"
-#include "sysemu/dma.h"
-#include "sysemu/reset.h"
+#include "system/system.h"
+#include "system/dma.h"
+#include "system/reset.h"
 #include "qemu/bitops.h"
 #include "qemu/module.h"
 #include "qapi/error.h"
diff --git a/hw/net/ftgmac100.c b/hw/net/ftgmac100.c
index 4adc7fb10c4..d3f84b22054 100644
--- a/hw/net/ftgmac100.c
+++ b/hw/net/ftgmac100.c
@@ -14,7 +14,7 @@
 #include "qemu/osdep.h"
 #include "hw/irq.h"
 #include "hw/net/ftgmac100.h"
-#include "sysemu/dma.h"
+#include "system/dma.h"
 #include "qapi/error.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
diff --git a/hw/net/igb.c b/hw/net/igb.c
index ad0f748d822..bea4d446bfc 100644
--- a/hw/net/igb.c
+++ b/hw/net/igb.c
@@ -44,7 +44,7 @@
 #include "net/tap.h"
 #include "qemu/module.h"
 #include "qemu/range.h"
-#include "sysemu/sysemu.h"
+#include "system/system.h"
 #include "hw/hw.h"
 #include "hw/net/mii.h"
 #include "hw/pci/pci.h"
diff --git a/hw/net/igb_core.c b/hw/net/igb_core.c
index 5dffa12c64b..39e3ce1c8fe 100644
--- a/hw/net/igb_core.c
+++ b/hw/net/igb_core.c
@@ -44,7 +44,7 @@
 #include "hw/net/mii.h"
 #include "hw/pci/msi.h"
 #include "hw/pci/msix.h"
-#include "sysemu/runstate.h"
+#include "system/runstate.h"
 
 #include "net_tx_pkt.h"
 #include "net_rx_pkt.h"
diff --git a/hw/net/imx_fec.c b/hw/net/imx_fec.c
index 9b649684772..eb405f2d460 100644
--- a/hw/net/imx_fec.c
+++ b/hw/net/imx_fec.c
@@ -26,7 +26,7 @@
 #include "hw/net/imx_fec.h"
 #include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
-#include "sysemu/dma.h"
+#include "system/dma.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "net/checksum.h"
diff --git a/hw/net/lance.c b/hw/net/lance.c
index 9ed9c94cff6..a5d72d4fe46 100644
--- a/hw/net/lance.c
+++ b/hw/net/lance.c
@@ -43,7 +43,7 @@
 #include "hw/net/lance.h"
 #include "hw/qdev-properties.h"
 #include "trace.h"
-#include "sysemu/sysemu.h"
+#include "system/system.h"
 
 
 static void parent_lance_reset(void *opaque, int irq, int level)
diff --git a/hw/net/lasi_i82596.c b/hw/net/lasi_i82596.c
index 248e3841dba..e5076d55e1a 100644
--- a/hw/net/lasi_i82596.c
+++ b/hw/net/lasi_i82596.c
@@ -14,7 +14,7 @@
 #include "qapi/error.h"
 #include "qemu/timer.h"
 #include "hw/sysbus.h"
-#include "sysemu/sysemu.h"
+#include "system/system.h"
 #include "net/eth.h"
 #include "hw/net/lasi_82596.h"
 #include "hw/net/i82596.h"
diff --git a/hw/net/mv88w8618_eth.c b/hw/net/mv88w8618_eth.c
index ccb11512dba..b8abffdfa26 100644
--- a/hw/net/mv88w8618_eth.c
+++ b/hw/net/mv88w8618_eth.c
@@ -12,7 +12,7 @@
 #include "hw/irq.h"
 #include "hw/net/mv88w8618_eth.h"
 #include "migration/vmstate.h"
-#include "sysemu/dma.h"
+#include "system/dma.h"
 #include "net/net.h"
 
 #define MP_ETH_SIZE             0x00001000
diff --git a/hw/net/ne2000-isa.c b/hw/net/ne2000-isa.c
index 1cd070d4199..98d5b93a3f1 100644
--- a/hw/net/ne2000-isa.c
+++ b/hw/net/ne2000-isa.c
@@ -27,7 +27,7 @@
 #include "hw/net/ne2000-isa.h"
 #include "migration/vmstate.h"
 #include "ne2000.h"
-#include "sysemu/sysemu.h"
+#include "system/system.h"
 #include "qapi/error.h"
 #include "qapi/visitor.h"
 #include "qemu/module.h"
diff --git a/hw/net/ne2000-pci.c b/hw/net/ne2000-pci.c
index 12fa579d228..b2b0eacd060 100644
--- a/hw/net/ne2000-pci.c
+++ b/hw/net/ne2000-pci.c
@@ -28,7 +28,7 @@
 #include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "ne2000.h"
-#include "sysemu/sysemu.h"
+#include "system/system.h"
 
 typedef struct PCINE2000State {
     PCIDevice dev;
diff --git a/hw/net/npcm7xx_emc.c b/hw/net/npcm7xx_emc.c
index f06e908d044..5173364b649 100644
--- a/hw/net/npcm7xx_emc.c
+++ b/hw/net/npcm7xx_emc.c
@@ -42,7 +42,7 @@
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "qemu/units.h"
-#include "sysemu/dma.h"
+#include "system/dma.h"
 #include "trace.h"
 
 #define CRC_LENGTH 4
diff --git a/hw/net/npcm_gmac.c b/hw/net/npcm_gmac.c
index 1db29307d7a..98465024f38 100644
--- a/hw/net/npcm_gmac.c
+++ b/hw/net/npcm_gmac.c
@@ -33,7 +33,7 @@
 #include "qemu/cutils.h"
 #include "qemu/log.h"
 #include "qemu/units.h"
-#include "sysemu/dma.h"
+#include "system/dma.h"
 #include "trace.h"
 
 REG32(NPCM_DMA_BUS_MODE, 0x1000)
diff --git a/hw/net/pcnet-pci.c b/hw/net/pcnet-pci.c
index 83ba8cd9493..1a6f60e4b4e 100644
--- a/hw/net/pcnet-pci.c
+++ b/hw/net/pcnet-pci.c
@@ -35,8 +35,8 @@
 #include "net/net.h"
 #include "qemu/module.h"
 #include "qemu/timer.h"
-#include "sysemu/dma.h"
-#include "sysemu/sysemu.h"
+#include "system/dma.h"
+#include "system/system.h"
 #include "trace.h"
 
 #include "pcnet.h"
diff --git a/hw/net/rtl8139.c b/hw/net/rtl8139.c
index 064a73b6b49..e6b13054f94 100644
--- a/hw/net/rtl8139.c
+++ b/hw/net/rtl8139.c
@@ -54,12 +54,12 @@
 #include "hw/pci/pci_device.h"
 #include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
-#include "sysemu/dma.h"
+#include "system/dma.h"
 #include "qemu/module.h"
 #include "qemu/timer.h"
 #include "net/net.h"
 #include "net/eth.h"
-#include "sysemu/sysemu.h"
+#include "system/system.h"
 #include "qom/object.h"
 
 /* debug RTL8139 card */
diff --git a/hw/net/spapr_llan.c b/hw/net/spapr_llan.c
index d381c041db3..5ce29bd9aaa 100644
--- a/hw/net/spapr_llan.c
+++ b/hw/net/spapr_llan.c
@@ -33,7 +33,7 @@
 #include "hw/ppc/spapr.h"
 #include "hw/ppc/spapr_vio.h"
 #include "hw/qdev-properties.h"
-#include "sysemu/sysemu.h"
+#include "system/system.h"
 #include "trace.h"
 
 #include <libfdt.h>
diff --git a/hw/net/sungem.c b/hw/net/sungem.c
index bcc7a18382c..af0ff0a3db8 100644
--- a/hw/net/sungem.c
+++ b/hw/net/sungem.c
@@ -17,7 +17,7 @@
 #include "net/eth.h"
 #include "net/checksum.h"
 #include "hw/net/mii.h"
-#include "sysemu/sysemu.h"
+#include "system/system.h"
 #include "trace.h"
 #include "qom/object.h"
 
diff --git a/hw/net/sunhme.c b/hw/net/sunhme.c
index 86f472fcbe7..9961901bad7 100644
--- a/hw/net/sunhme.c
+++ b/hw/net/sunhme.c
@@ -31,7 +31,7 @@
 #include "qemu/module.h"
 #include "net/checksum.h"
 #include "net/eth.h"
-#include "sysemu/sysemu.h"
+#include "system/system.h"
 #include "trace.h"
 #include "qom/object.h"
 
diff --git a/hw/net/tulip.c b/hw/net/tulip.c
index f35b58a88c2..9adbfa7bb1c 100644
--- a/hw/net/tulip.c
+++ b/hw/net/tulip.c
@@ -13,7 +13,7 @@
 #include "hw/qdev-properties.h"
 #include "hw/nvram/eeprom93xx.h"
 #include "migration/vmstate.h"
-#include "sysemu/sysemu.h"
+#include "system/system.h"
 #include "tulip.h"
 #include "trace.h"
 #include "net/eth.h"
diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 4fd1f9accab..250fe1c0ff9 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -39,15 +39,15 @@
 #include "hw/virtio/virtio-access.h"
 #include "migration/misc.h"
 #include "standard-headers/linux/ethtool.h"
-#include "sysemu/sysemu.h"
-#include "sysemu/replay.h"
+#include "system/system.h"
+#include "system/replay.h"
 #include "trace.h"
 #include "monitor/qdev.h"
 #include "monitor/monitor.h"
 #include "hw/pci/pci_device.h"
 #include "net_rx_pkt.h"
 #include "hw/virtio/vhost.h"
-#include "sysemu/qtest.h"
+#include "system/qtest.h"
 
 #define VIRTIO_NET_VM_VERSION    11
 
diff --git a/hw/net/vmxnet3.c b/hw/net/vmxnet3.c
index f69547cad5e..5ede2a38c98 100644
--- a/hw/net/vmxnet3.c
+++ b/hw/net/vmxnet3.c
@@ -21,7 +21,7 @@
 #include "hw/qdev-properties.h"
 #include "net/tap.h"
 #include "net/checksum.h"
-#include "sysemu/sysemu.h"
+#include "system/system.h"
 #include "qemu/bswap.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 33a3062466e..fe10c8e0766 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -201,12 +201,12 @@
 #include "qemu/range.h"
 #include "qapi/error.h"
 #include "qapi/visitor.h"
-#include "sysemu/sysemu.h"
-#include "sysemu/block-backend.h"
-#include "sysemu/hostmem.h"
+#include "system/system.h"
+#include "system/block-backend.h"
+#include "system/hostmem.h"
 #include "hw/pci/msix.h"
 #include "hw/pci/pcie_sriov.h"
-#include "sysemu/spdm-socket.h"
+#include "system/spdm-socket.h"
 #include "migration/vmstate.h"
 
 #include "nvme.h"
diff --git a/hw/nvme/dif.c b/hw/nvme/dif.c
index 28051284984..4e7874f3223 100644
--- a/hw/nvme/dif.c
+++ b/hw/nvme/dif.c
@@ -10,7 +10,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "sysemu/block-backend.h"
+#include "system/block-backend.h"
 
 #include "nvme.h"
 #include "dif.h"
diff --git a/hw/nvme/ns.c b/hw/nvme/ns.c
index 192b80f18db..76d185d9481 100644
--- a/hw/nvme/ns.c
+++ b/hw/nvme/ns.c
@@ -18,8 +18,8 @@
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "qemu/bitops.h"
-#include "sysemu/sysemu.h"
-#include "sysemu/block-backend.h"
+#include "system/system.h"
+#include "system/block-backend.h"
 
 #include "nvme.h"
 #include "trace.h"
diff --git a/hw/nvram/chrp_nvram.c b/hw/nvram/chrp_nvram.c
index d4d10a7c03c..0b204e36c62 100644
--- a/hw/nvram/chrp_nvram.c
+++ b/hw/nvram/chrp_nvram.c
@@ -23,7 +23,7 @@
 #include "qemu/cutils.h"
 #include "qemu/error-report.h"
 #include "hw/nvram/chrp_nvram.h"
-#include "sysemu/sysemu.h"
+#include "system/system.h"
 
 static int chrp_nvram_set_var(uint8_t *nvram, int addr, const char *str,
                               int max_len)
diff --git a/hw/nvram/eeprom_at24c.c b/hw/nvram/eeprom_at24c.c
index 669920b2b92..32069881f57 100644
--- a/hw/nvram/eeprom_at24c.c
+++ b/hw/nvram/eeprom_at24c.c
@@ -15,7 +15,7 @@
 #include "hw/nvram/eeprom_at24c.h"
 #include "hw/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
-#include "sysemu/block-backend.h"
+#include "system/block-backend.h"
 #include "qom/object.h"
 
 /* #define DEBUG_AT24C */
diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index 7461d99ff2e..a2db79bf6f7 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -24,9 +24,9 @@
 
 #include "qemu/osdep.h"
 #include "qemu/datadir.h"
-#include "sysemu/sysemu.h"
-#include "sysemu/dma.h"
-#include "sysemu/reset.h"
+#include "system/system.h"
+#include "system/dma.h"
+#include "system/reset.h"
 #include "exec/address-spaces.h"
 #include "hw/boards.h"
 #include "hw/nvram/fw_cfg.h"
diff --git a/hw/nvram/mac_nvram.c b/hw/nvram/mac_nvram.c
index d62ad719c84..d18575a3ee2 100644
--- a/hw/nvram/mac_nvram.c
+++ b/hw/nvram/mac_nvram.c
@@ -29,7 +29,7 @@
 #include "hw/nvram/mac_nvram.h"
 #include "hw/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
-#include "sysemu/block-backend.h"
+#include "system/block-backend.h"
 #include "migration/vmstate.h"
 #include "qemu/cutils.h"
 #include "qemu/module.h"
diff --git a/hw/nvram/spapr_nvram.c b/hw/nvram/spapr_nvram.c
index 2251ff2f4c8..fa884e9bbb4 100644
--- a/hw/nvram/spapr_nvram.c
+++ b/hw/nvram/spapr_nvram.c
@@ -28,10 +28,10 @@
 #include "qapi/error.h"
 #include <libfdt.h>
 
-#include "sysemu/block-backend.h"
-#include "sysemu/device_tree.h"
-#include "sysemu/sysemu.h"
-#include "sysemu/runstate.h"
+#include "system/block-backend.h"
+#include "system/device_tree.h"
+#include "system/system.h"
+#include "system/runstate.h"
 #include "migration/vmstate.h"
 #include "hw/nvram/chrp_nvram.h"
 #include "hw/ppc/spapr.h"
diff --git a/hw/nvram/xlnx-bbram.c b/hw/nvram/xlnx-bbram.c
index 4fa528f0480..d5a6930e8c5 100644
--- a/hw/nvram/xlnx-bbram.c
+++ b/hw/nvram/xlnx-bbram.c
@@ -29,7 +29,7 @@
 #include "qemu/error-report.h"
 #include "qemu/log.h"
 #include "qapi/error.h"
-#include "sysemu/blockdev.h"
+#include "system/blockdev.h"
 #include "migration/vmstate.h"
 #include "hw/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
diff --git a/hw/nvram/xlnx-efuse.c b/hw/nvram/xlnx-efuse.c
index 5dae9e8e9a0..7cd3d401ce1 100644
--- a/hw/nvram/xlnx-efuse.c
+++ b/hw/nvram/xlnx-efuse.c
@@ -30,7 +30,7 @@
 #include "qemu/error-report.h"
 #include "qemu/log.h"
 #include "qapi/error.h"
-#include "sysemu/blockdev.h"
+#include "system/blockdev.h"
 #include "hw/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
 
diff --git a/hw/openrisc/boot.c b/hw/openrisc/boot.c
index 55475aa6d60..83c1fc6705e 100644
--- a/hw/openrisc/boot.c
+++ b/hw/openrisc/boot.c
@@ -12,9 +12,9 @@
 #include "elf.h"
 #include "hw/loader.h"
 #include "hw/openrisc/boot.h"
-#include "sysemu/device_tree.h"
-#include "sysemu/qtest.h"
-#include "sysemu/reset.h"
+#include "system/device_tree.h"
+#include "system/qtest.h"
+#include "system/reset.h"
 #include "qemu/error-report.h"
 
 #include <libfdt.h>
diff --git a/hw/openrisc/cputimer.c b/hw/openrisc/cputimer.c
index 87aa3533237..6331997d56b 100644
--- a/hw/openrisc/cputimer.c
+++ b/hw/openrisc/cputimer.c
@@ -22,7 +22,7 @@
 #include "cpu.h"
 #include "migration/vmstate.h"
 #include "qemu/timer.h"
-#include "sysemu/reset.h"
+#include "system/reset.h"
 
 #define TIMER_PERIOD 50 /* 50 ns period for 20 MHz timer */
 
diff --git a/hw/openrisc/openrisc_sim.c b/hw/openrisc/openrisc_sim.c
index 42f002985bf..87f9cbc3001 100644
--- a/hw/openrisc/openrisc_sim.c
+++ b/hw/openrisc/openrisc_sim.c
@@ -29,11 +29,11 @@
 #include "hw/openrisc/boot.h"
 #include "hw/qdev-properties.h"
 #include "exec/address-spaces.h"
-#include "sysemu/device_tree.h"
-#include "sysemu/sysemu.h"
+#include "system/device_tree.h"
+#include "system/system.h"
 #include "hw/sysbus.h"
-#include "sysemu/qtest.h"
-#include "sysemu/reset.h"
+#include "system/qtest.h"
+#include "system/reset.h"
 #include "hw/core/split-irq.h"
 
 #include <libfdt.h>
diff --git a/hw/openrisc/virt.c b/hw/openrisc/virt.c
index 47d2c9bd3c7..0d83e33f9ea 100644
--- a/hw/openrisc/virt.c
+++ b/hw/openrisc/virt.c
@@ -24,10 +24,10 @@
 #include "hw/rtc/goldfish_rtc.h"
 #include "hw/sysbus.h"
 #include "hw/virtio/virtio-mmio.h"
-#include "sysemu/device_tree.h"
-#include "sysemu/sysemu.h"
-#include "sysemu/qtest.h"
-#include "sysemu/reset.h"
+#include "system/device_tree.h"
+#include "system/system.h"
+#include "system/qtest.h"
+#include "system/reset.h"
 
 #include <libfdt.h>
 
diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_expander_bridge.c
index 01997c1ab3b..7e8f4ae5ea6 100644
--- a/hw/pci-bridge/pci_expander_bridge.c
+++ b/hw/pci-bridge/pci_expander_bridge.c
@@ -23,7 +23,7 @@
 #include "qemu/range.h"
 #include "qemu/error-report.h"
 #include "qemu/module.h"
-#include "sysemu/numa.h"
+#include "system/numa.h"
 #include "hw/boards.h"
 #include "qom/object.h"
 
diff --git a/hw/pci-host/bonito.c b/hw/pci-host/bonito.c
index 1516d0074dd..49669148923 100644
--- a/hw/pci-host/bonito.c
+++ b/hw/pci-host/bonito.c
@@ -48,7 +48,7 @@
 #include "hw/pci-host/bonito.h"
 #include "hw/pci/pci_host.h"
 #include "migration/vmstate.h"
-#include "sysemu/runstate.h"
+#include "system/runstate.h"
 #include "hw/misc/unimp.h"
 #include "hw/registerfields.h"
 #include "qom/object.h"
diff --git a/hw/pci-host/pnv_phb.c b/hw/pci-host/pnv_phb.c
index 888f0786a07..350c04e69d7 100644
--- a/hw/pci-host/pnv_phb.c
+++ b/hw/pci-host/pnv_phb.c
@@ -17,7 +17,7 @@
 #include "hw/ppc/pnv.h"
 #include "hw/qdev-properties.h"
 #include "qom/object.h"
-#include "sysemu/sysemu.h"
+#include "system/system.h"
 
 
 /*
diff --git a/hw/pci-host/pnv_phb3.c b/hw/pci-host/pnv_phb3.c
index 529b33b5a2a..dbd26a68a80 100644
--- a/hw/pci-host/pnv_phb3.c
+++ b/hw/pci-host/pnv_phb3.c
@@ -20,7 +20,7 @@
 #include "hw/irq.h"
 #include "hw/qdev-properties.h"
 #include "qom/object.h"
-#include "sysemu/sysemu.h"
+#include "system/system.h"
 
 #define phb3_error(phb, fmt, ...)                                       \
     qemu_log_mask(LOG_GUEST_ERROR, "phb3[%d:%d]: " fmt "\n",            \
diff --git a/hw/pci-host/pnv_phb3_msi.c b/hw/pci-host/pnv_phb3_msi.c
index 77d673da540..81986644b14 100644
--- a/hw/pci-host/pnv_phb3_msi.c
+++ b/hw/pci-host/pnv_phb3_msi.c
@@ -15,7 +15,7 @@
 #include "hw/pci/msi.h"
 #include "hw/irq.h"
 #include "hw/qdev-properties.h"
-#include "sysemu/reset.h"
+#include "system/reset.h"
 
 static uint64_t phb3_msi_ive_addr(PnvPHB3 *phb, int srcno)
 {
diff --git a/hw/pci-host/pnv_phb4_pec.c b/hw/pci-host/pnv_phb4_pec.c
index f8975403d33..28c35b40c89 100644
--- a/hw/pci-host/pnv_phb4_pec.c
+++ b/hw/pci-host/pnv_phb4_pec.c
@@ -19,7 +19,7 @@
 #include "hw/ppc/pnv.h"
 #include "hw/ppc/pnv_chip.h"
 #include "hw/qdev-properties.h"
-#include "sysemu/sysemu.h"
+#include "system/system.h"
 
 #include <libfdt.h>
 
diff --git a/hw/pci-host/ppc4xx_pci.c b/hw/pci-host/ppc4xx_pci.c
index b6c6c8993c4..292cb308ba9 100644
--- a/hw/pci-host/ppc4xx_pci.c
+++ b/hw/pci-host/ppc4xx_pci.c
@@ -27,7 +27,7 @@
 #include "hw/pci-host/ppc4xx.h"
 #include "migration/vmstate.h"
 #include "qemu/module.h"
-#include "sysemu/reset.h"
+#include "system/reset.h"
 #include "hw/pci/pci_device.h"
 #include "hw/pci/pci_host.h"
 #include "trace.h"
diff --git a/hw/pci-host/sabre.c b/hw/pci-host/sabre.c
index 623afed6447..d3e6943136c 100644
--- a/hw/pci-host/sabre.c
+++ b/hw/pci-host/sabre.c
@@ -37,7 +37,7 @@
 #include "qapi/error.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
-#include "sysemu/runstate.h"
+#include "system/runstate.h"
 #include "trace.h"
 
 /*
diff --git a/hw/pci/msi.c b/hw/pci/msi.c
index 8104ac1d91a..b9f5b45920b 100644
--- a/hw/pci/msi.c
+++ b/hw/pci/msi.c
@@ -23,7 +23,7 @@
 #include "hw/xen/xen.h"
 #include "qemu/range.h"
 #include "qapi/error.h"
-#include "sysemu/xen.h"
+#include "system/xen.h"
 
 #include "hw/i386/kvm/xen_evtchn.h"
 
diff --git a/hw/pci/msix.c b/hw/pci/msix.c
index 487e49834ee..d8a55a64741 100644
--- a/hw/pci/msix.c
+++ b/hw/pci/msix.c
@@ -19,7 +19,7 @@
 #include "hw/pci/msix.h"
 #include "hw/pci/pci.h"
 #include "hw/xen/xen.h"
-#include "sysemu/xen.h"
+#include "system/xen.h"
 #include "migration/qemu-file-types.h"
 #include "migration/vmstate.h"
 #include "qemu/range.h"
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 90248481b18..c7f898cbf65 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -35,9 +35,9 @@
 #include "migration/qemu-file-types.h"
 #include "migration/vmstate.h"
 #include "net/net.h"
-#include "sysemu/numa.h"
-#include "sysemu/runstate.h"
-#include "sysemu/sysemu.h"
+#include "system/numa.h"
+#include "system/runstate.h"
+#include "system/system.h"
 #include "hw/loader.h"
 #include "qemu/error-report.h"
 #include "qemu/range.h"
diff --git a/hw/ppc/amigaone.c b/hw/ppc/amigaone.c
index 900f93c15e1..b02792221cc 100644
--- a/hw/ppc/amigaone.c
+++ b/hw/ppc/amigaone.c
@@ -21,8 +21,8 @@
 #include "hw/ide/pci.h"
 #include "hw/i2c/smbus_eeprom.h"
 #include "hw/ppc/ppc.h"
-#include "sysemu/qtest.h"
-#include "sysemu/reset.h"
+#include "system/qtest.h"
+#include "system/reset.h"
 #include "kvm_ppc.h"
 
 #define BUS_FREQ_HZ 100000000
diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index 46261223f3c..4551157c011 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -26,13 +26,13 @@
 #include "hw/block/flash.h"
 #include "hw/char/serial-mm.h"
 #include "hw/pci/pci.h"
-#include "sysemu/block-backend-io.h"
-#include "sysemu/sysemu.h"
-#include "sysemu/kvm.h"
-#include "sysemu/reset.h"
-#include "sysemu/runstate.h"
+#include "system/block-backend-io.h"
+#include "system/system.h"
+#include "system/kvm.h"
+#include "system/reset.h"
+#include "system/runstate.h"
 #include "kvm_ppc.h"
-#include "sysemu/device_tree.h"
+#include "system/device_tree.h"
 #include "hw/ppc/openpic.h"
 #include "hw/ppc/openpic_kvm.h"
 #include "hw/ppc/ppc.h"
diff --git a/hw/ppc/e500plat.c b/hw/ppc/e500plat.c
index 7aa2f2107a7..70a80333733 100644
--- a/hw/ppc/e500plat.c
+++ b/hw/ppc/e500plat.c
@@ -13,8 +13,8 @@
 #include "qemu/units.h"
 #include "e500.h"
 #include "hw/net/fsl_etsec/etsec.h"
-#include "sysemu/device_tree.h"
-#include "sysemu/kvm.h"
+#include "system/device_tree.h"
+#include "system/kvm.h"
 #include "hw/sysbus.h"
 #include "hw/pci/pci.h"
 #include "hw/ppc/openpic.h"
diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
index 9d249a506cf..6369961f78a 100644
--- a/hw/ppc/mac_newworld.c
+++ b/hw/ppc/mac_newworld.c
@@ -59,7 +59,7 @@
 #include "hw/ppc/mac_dbdma.h"
 #include "hw/pci/pci.h"
 #include "net/net.h"
-#include "sysemu/sysemu.h"
+#include "system/system.h"
 #include "hw/nvram/fw_cfg.h"
 #include "hw/char/escc.h"
 #include "hw/misc/macio/macio.h"
@@ -68,8 +68,8 @@
 #include "hw/fw-path-provider.h"
 #include "elf.h"
 #include "qemu/error-report.h"
-#include "sysemu/kvm.h"
-#include "sysemu/reset.h"
+#include "system/kvm.h"
+#include "system/reset.h"
 #include "kvm_ppc.h"
 #include "hw/usb.h"
 #include "hw/sysbus.h"
diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
index eef32610029..59653e174b8 100644
--- a/hw/ppc/mac_oldworld.c
+++ b/hw/ppc/mac_oldworld.c
@@ -32,7 +32,7 @@
 #include "hw/qdev-properties.h"
 #include "hw/boards.h"
 #include "hw/input/adb.h"
-#include "sysemu/sysemu.h"
+#include "system/system.h"
 #include "net/net.h"
 #include "hw/isa/isa.h"
 #include "hw/pci/pci.h"
@@ -45,8 +45,8 @@
 #include "hw/fw-path-provider.h"
 #include "elf.h"
 #include "qemu/error-report.h"
-#include "sysemu/kvm.h"
-#include "sysemu/reset.h"
+#include "system/kvm.h"
+#include "system/reset.h"
 #include "kvm_ppc.h"
 
 #define MAX_IDE_BUS 2
diff --git a/hw/ppc/mpc8544_guts.c b/hw/ppc/mpc8544_guts.c
index e3c51458e69..a25041e8367 100644
--- a/hw/ppc/mpc8544_guts.c
+++ b/hw/ppc/mpc8544_guts.c
@@ -19,7 +19,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/log.h"
-#include "sysemu/runstate.h"
+#include "system/runstate.h"
 #include "cpu.h"
 #include "hw/sysbus.h"
 #include "qom/object.h"
diff --git a/hw/ppc/mpc8544ds.c b/hw/ppc/mpc8544ds.c
index b7130903d66..d74af766eed 100644
--- a/hw/ppc/mpc8544ds.c
+++ b/hw/ppc/mpc8544ds.c
@@ -11,7 +11,7 @@
 
 #include "qemu/osdep.h"
 #include "e500.h"
-#include "sysemu/device_tree.h"
+#include "system/device_tree.h"
 #include "hw/ppc/openpic.h"
 #include "qemu/error-report.h"
 #include "qemu/units.h"
diff --git a/hw/ppc/pef.c b/hw/ppc/pef.c
index 47553348b1e..cffda44602e 100644
--- a/hw/ppc/pef.c
+++ b/hw/ppc/pef.c
@@ -12,7 +12,7 @@
 
 #include "qapi/error.h"
 #include "qom/object_interfaces.h"
-#include "sysemu/kvm.h"
+#include "system/kvm.h"
 #include "migration/blocker.h"
 #include "exec/confidential-guest-support.h"
 
diff --git a/hw/ppc/pegasos2.c b/hw/ppc/pegasos2.c
index 16abeaac824..b3c21bdc57c 100644
--- a/hw/ppc/pegasos2.c
+++ b/hw/ppc/pegasos2.c
@@ -20,23 +20,23 @@
 #include "hw/ide/pci.h"
 #include "hw/i2c/smbus_eeprom.h"
 #include "hw/qdev-properties.h"
-#include "sysemu/reset.h"
-#include "sysemu/runstate.h"
-#include "sysemu/qtest.h"
+#include "system/reset.h"
+#include "system/runstate.h"
+#include "system/qtest.h"
 #include "hw/boards.h"
 #include "hw/loader.h"
 #include "hw/fw-path-provider.h"
 #include "elf.h"
 #include "qemu/log.h"
 #include "qemu/error-report.h"
-#include "sysemu/kvm.h"
+#include "system/kvm.h"
 #include "kvm_ppc.h"
 #include "exec/address-spaces.h"
 #include "qom/qom-qobject.h"
 #include "qapi/qmp/qdict.h"
 #include "trace.h"
 #include "qemu/datadir.h"
-#include "sysemu/device_tree.h"
+#include "system/device_tree.h"
 #include "hw/ppc/vof.h"
 
 #include <libfdt.h>
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index b90a052ce0d..d2be6502d2a 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -22,14 +22,14 @@
 #include "qemu/units.h"
 #include "qemu/cutils.h"
 #include "qapi/error.h"
-#include "sysemu/qtest.h"
-#include "sysemu/sysemu.h"
-#include "sysemu/numa.h"
-#include "sysemu/reset.h"
-#include "sysemu/runstate.h"
-#include "sysemu/cpus.h"
-#include "sysemu/device_tree.h"
-#include "sysemu/hw_accel.h"
+#include "system/qtest.h"
+#include "system/system.h"
+#include "system/numa.h"
+#include "system/reset.h"
+#include "system/runstate.h"
+#include "system/cpus.h"
+#include "system/device_tree.h"
+#include "system/hw_accel.h"
 #include "target/ppc/cpu.h"
 #include "hw/ppc/fdt.h"
 #include "hw/ppc/ppc.h"
diff --git a/hw/ppc/pnv_chiptod.c b/hw/ppc/pnv_chiptod.c
index 840ef23128d..9f2eb994ca9 100644
--- a/hw/ppc/pnv_chiptod.c
+++ b/hw/ppc/pnv_chiptod.c
@@ -23,7 +23,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "sysemu/reset.h"
+#include "system/reset.h"
 #include "target/ppc/cpu.h"
 #include "qapi/error.h"
 #include "qemu/log.h"
diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
index 22864c92f38..3b7cf38f5ff 100644
--- a/hw/ppc/pnv_core.c
+++ b/hw/ppc/pnv_core.c
@@ -18,7 +18,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "sysemu/reset.h"
+#include "system/reset.h"
 #include "qapi/error.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
diff --git a/hw/ppc/pnv_homer.c b/hw/ppc/pnv_homer.c
index b1f83e2cf27..0f0b42bbeb2 100644
--- a/hw/ppc/pnv_homer.c
+++ b/hw/ppc/pnv_homer.c
@@ -21,7 +21,7 @@
 #include "qapi/error.h"
 #include "exec/hwaddr.h"
 #include "exec/memory.h"
-#include "sysemu/cpus.h"
+#include "system/cpus.h"
 #include "hw/qdev-core.h"
 #include "hw/qdev-properties.h"
 #include "hw/ppc/pnv.h"
diff --git a/hw/ppc/pnv_i2c.c b/hw/ppc/pnv_i2c.c
index 4bd61abeed9..b56582899fa 100644
--- a/hw/ppc/pnv_i2c.c
+++ b/hw/ppc/pnv_i2c.c
@@ -9,7 +9,7 @@
 #include "qemu/osdep.h"
 #include "qemu/module.h"
 #include "qemu/log.h"
-#include "sysemu/reset.h"
+#include "system/reset.h"
 
 #include "hw/irq.h"
 #include "hw/qdev-properties.h"
diff --git a/hw/ppc/pnv_pnor.c b/hw/ppc/pnv_pnor.c
index eed6d326505..07e5fcbdb60 100644
--- a/hw/ppc/pnv_pnor.c
+++ b/hw/ppc/pnv_pnor.c
@@ -11,8 +11,8 @@
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "qemu/units.h"
-#include "sysemu/block-backend.h"
-#include "sysemu/blockdev.h"
+#include "system/block-backend.h"
+#include "system/blockdev.h"
 #include "hw/loader.h"
 #include "hw/ppc/pnv_pnor.h"
 #include "hw/qdev-properties.h"
diff --git a/hw/ppc/pnv_psi.c b/hw/ppc/pnv_psi.c
index e7d6ceee99e..e953e4990e7 100644
--- a/hw/ppc/pnv_psi.c
+++ b/hw/ppc/pnv_psi.c
@@ -23,7 +23,7 @@
 #include "target/ppc/cpu.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
-#include "sysemu/reset.h"
+#include "system/reset.h"
 #include "qapi/error.h"
 
 
diff --git a/hw/ppc/pnv_xscom.c b/hw/ppc/pnv_xscom.c
index d192bbe2c20..fbfec829d5b 100644
--- a/hw/ppc/pnv_xscom.c
+++ b/hw/ppc/pnv_xscom.c
@@ -20,7 +20,7 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
-#include "sysemu/hw_accel.h"
+#include "system/hw_accel.h"
 #include "target/ppc/cpu.h"
 #include "hw/sysbus.h"
 
diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
index b86b5847de6..90e3db5cfeb 100644
--- a/hw/ppc/ppc.c
+++ b/hw/ppc/ppc.c
@@ -27,13 +27,13 @@
 #include "hw/ppc/ppc.h"
 #include "hw/ppc/ppc_e500.h"
 #include "qemu/timer.h"
-#include "sysemu/cpus.h"
+#include "system/cpus.h"
 #include "qemu/log.h"
 #include "qemu/main-loop.h"
 #include "qemu/error-report.h"
-#include "sysemu/kvm.h"
-#include "sysemu/replay.h"
-#include "sysemu/runstate.h"
+#include "system/kvm.h"
+#include "system/replay.h"
+#include "system/runstate.h"
 #include "kvm_ppc.h"
 #include "migration/vmstate.h"
 #include "trace.h"
diff --git a/hw/ppc/ppc405_boards.c b/hw/ppc/ppc405_boards.c
index 347428e6330..e9f65fab70d 100644
--- a/hw/ppc/ppc405_boards.c
+++ b/hw/ppc/ppc405_boards.c
@@ -33,9 +33,9 @@
 #include "ppc405.h"
 #include "hw/rtc/m48t59.h"
 #include "hw/block/flash.h"
-#include "sysemu/qtest.h"
-#include "sysemu/reset.h"
-#include "sysemu/block-backend.h"
+#include "system/qtest.h"
+#include "system/reset.h"
+#include "system/block-backend.h"
 #include "hw/boards.h"
 #include "qemu/error-report.h"
 #include "hw/loader.h"
diff --git a/hw/ppc/ppc405_uc.c b/hw/ppc/ppc405_uc.c
index 801f97811f5..b5cff8d3c55 100644
--- a/hw/ppc/ppc405_uc.c
+++ b/hw/ppc/ppc405_uc.c
@@ -34,8 +34,8 @@
 #include "ppc405.h"
 #include "hw/char/serial-mm.h"
 #include "qemu/timer.h"
-#include "sysemu/reset.h"
-#include "sysemu/sysemu.h"
+#include "system/reset.h"
+#include "system/system.h"
 #include "exec/address-spaces.h"
 #include "hw/intc/ppc-uic.h"
 #include "trace.h"
diff --git a/hw/ppc/ppc440_bamboo.c b/hw/ppc/ppc440_bamboo.c
index a55f108434f..45c5b8678d9 100644
--- a/hw/ppc/ppc440_bamboo.c
+++ b/hw/ppc/ppc440_bamboo.c
@@ -19,15 +19,15 @@
 #include "net/net.h"
 #include "hw/pci/pci.h"
 #include "hw/boards.h"
-#include "sysemu/kvm.h"
-#include "sysemu/device_tree.h"
+#include "system/kvm.h"
+#include "system/device_tree.h"
 #include "hw/loader.h"
 #include "elf.h"
 #include "hw/char/serial-mm.h"
 #include "hw/ppc/ppc.h"
 #include "hw/pci-host/ppc4xx.h"
-#include "sysemu/sysemu.h"
-#include "sysemu/reset.h"
+#include "system/system.h"
+#include "system/reset.h"
 #include "hw/sysbus.h"
 #include "hw/intc/ppc-uic.h"
 #include "hw/qdev-properties.h"
diff --git a/hw/ppc/ppc440_uc.c b/hw/ppc/ppc440_uc.c
index 05a5ef6f773..a1b0145c30c 100644
--- a/hw/ppc/ppc440_uc.c
+++ b/hw/ppc/ppc440_uc.c
@@ -17,7 +17,7 @@
 #include "hw/pci-host/ppc4xx.h"
 #include "hw/qdev-properties.h"
 #include "hw/pci/pci.h"
-#include "sysemu/reset.h"
+#include "system/reset.h"
 #include "cpu.h"
 #include "ppc440.h"
 
diff --git a/hw/ppc/ppc_booke.c b/hw/ppc/ppc_booke.c
index c8849e66ff3..925e670ba0a 100644
--- a/hw/ppc/ppc_booke.c
+++ b/hw/ppc/ppc_booke.c
@@ -26,8 +26,8 @@
 #include "cpu.h"
 #include "hw/ppc/ppc.h"
 #include "qemu/timer.h"
-#include "sysemu/reset.h"
-#include "sysemu/runstate.h"
+#include "system/reset.h"
+#include "system/runstate.h"
 #include "hw/loader.h"
 #include "kvm_ppc.h"
 
diff --git a/hw/ppc/ppce500_spin.c b/hw/ppc/ppce500_spin.c
index 93b16320d41..baab74c4ed0 100644
--- a/hw/ppc/ppce500_spin.c
+++ b/hw/ppc/ppce500_spin.c
@@ -32,7 +32,7 @@
 #include "qemu/units.h"
 #include "hw/hw.h"
 #include "hw/sysbus.h"
-#include "sysemu/hw_accel.h"
+#include "system/hw_accel.h"
 #include "hw/ppc/ppc.h"
 #include "e500.h"
 #include "qom/object.h"
diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
index fb58c312acc..3e68d8e6e20 100644
--- a/hw/ppc/prep.c
+++ b/hw/ppc/prep.c
@@ -39,8 +39,8 @@
 #include "hw/rtc/mc146818rtc.h"
 #include "hw/isa/pc87312.h"
 #include "hw/qdev-properties.h"
-#include "sysemu/kvm.h"
-#include "sysemu/reset.h"
+#include "system/kvm.h"
+#include "system/reset.h"
 #include "trace.h"
 #include "elf.h"
 #include "qemu/units.h"
diff --git a/hw/ppc/prep_systemio.c b/hw/ppc/prep_systemio.c
index ca475c69f45..b5380eaee4d 100644
--- a/hw/ppc/prep_systemio.c
+++ b/hw/ppc/prep_systemio.c
@@ -32,7 +32,7 @@
 #include "qom/object.h"
 #include "qemu/error-report.h" /* for error_report() */
 #include "qemu/module.h"
-#include "sysemu/runstate.h"
+#include "system/runstate.h"
 #include "cpu.h"
 #include "trace.h"
 
diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
index 78e2a46e753..e74642a3b71 100644
--- a/hw/ppc/sam460ex.c
+++ b/hw/ppc/sam460ex.c
@@ -17,10 +17,10 @@
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "hw/boards.h"
-#include "sysemu/kvm.h"
+#include "system/kvm.h"
 #include "kvm_ppc.h"
-#include "sysemu/device_tree.h"
-#include "sysemu/block-backend.h"
+#include "system/device_tree.h"
+#include "system/block-backend.h"
 #include "exec/page-protection.h"
 #include "hw/loader.h"
 #include "elf.h"
@@ -28,8 +28,8 @@
 #include "ppc440.h"
 #include "hw/pci-host/ppc4xx.h"
 #include "hw/block/flash.h"
-#include "sysemu/sysemu.h"
-#include "sysemu/reset.h"
+#include "system/system.h"
+#include "system/reset.h"
 #include "hw/sysbus.h"
 #include "hw/char/serial-mm.h"
 #include "hw/i2c/ppc4xx_i2c.h"
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 3b022e8da9e..ad21018b5aa 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -32,20 +32,20 @@
 #include "qapi/qapi-events-machine.h"
 #include "qapi/qapi-events-qdev.h"
 #include "qapi/visitor.h"
-#include "sysemu/sysemu.h"
-#include "sysemu/hostmem.h"
-#include "sysemu/numa.h"
-#include "sysemu/tcg.h"
-#include "sysemu/qtest.h"
-#include "sysemu/reset.h"
-#include "sysemu/runstate.h"
+#include "system/system.h"
+#include "system/hostmem.h"
+#include "system/numa.h"
+#include "system/tcg.h"
+#include "system/qtest.h"
+#include "system/reset.h"
+#include "system/runstate.h"
 #include "qemu/log.h"
 #include "hw/fw-path-provider.h"
 #include "elf.h"
 #include "net/net.h"
-#include "sysemu/device_tree.h"
-#include "sysemu/cpus.h"
-#include "sysemu/hw_accel.h"
+#include "system/device_tree.h"
+#include "system/cpus.h"
+#include "system/hw_accel.h"
 #include "kvm_ppc.h"
 #include "migration/misc.h"
 #include "migration/qemu-file-types.h"
diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
index 2f74923560d..7edd1383601 100644
--- a/hw/ppc/spapr_caps.c
+++ b/hw/ppc/spapr_caps.c
@@ -26,14 +26,14 @@
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "qapi/visitor.h"
-#include "sysemu/hw_accel.h"
+#include "system/hw_accel.h"
 #include "exec/ram_addr.h"
 #include "target/ppc/cpu.h"
 #include "target/ppc/mmu-hash64.h"
 #include "cpu-models.h"
 #include "kvm_ppc.h"
 #include "migration/vmstate.h"
-#include "sysemu/tcg.h"
+#include "system/tcg.h"
 
 #include "hw/ppc/spapr.h"
 
diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index 88d743a3c3f..d725dd05ca5 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -15,15 +15,15 @@
 #include "target/ppc/cpu.h"
 #include "hw/ppc/spapr.h"
 #include "qapi/error.h"
-#include "sysemu/cpus.h"
-#include "sysemu/kvm.h"
+#include "system/cpus.h"
+#include "system/kvm.h"
 #include "target/ppc/kvm_ppc.h"
 #include "hw/ppc/ppc.h"
 #include "target/ppc/mmu-hash64.h"
 #include "target/ppc/power8-pmu.h"
-#include "sysemu/numa.h"
-#include "sysemu/reset.h"
-#include "sysemu/hw_accel.h"
+#include "system/numa.h"
+#include "system/reset.h"
+#include "system/hw_accel.h"
 #include "qemu/error-report.h"
 
 static void spapr_reset_vcpu(PowerPCCPU *cpu)
diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
index 7868048bb9d..2435397e948 100644
--- a/hw/ppc/spapr_drc.c
+++ b/hw/ppc/spapr_drc.c
@@ -23,8 +23,8 @@
 #include "hw/ppc/spapr.h" /* for RTAS return codes */
 #include "hw/pci-host/spapr.h" /* spapr_phb_remove_pci_device_cb callback */
 #include "hw/ppc/spapr_nvdimm.h"
-#include "sysemu/device_tree.h"
-#include "sysemu/reset.h"
+#include "system/device_tree.h"
+#include "system/reset.h"
 #include "trace.h"
 
 #define DRC_CONTAINER_PATH "dr-connector"
diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
index 4dbf8e2e2ef..832b0212f31 100644
--- a/hw/ppc/spapr_events.c
+++ b/hw/ppc/spapr_events.c
@@ -27,8 +27,8 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "sysemu/device_tree.h"
-#include "sysemu/runstate.h"
+#include "system/device_tree.h"
+#include "system/runstate.h"
 
 #include "hw/ppc/fdt.h"
 #include "hw/ppc/spapr.h"
diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 5e1d020e3df..f8ab7670630 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -1,9 +1,9 @@
 #include "qemu/osdep.h"
 #include "qemu/cutils.h"
 #include "qapi/error.h"
-#include "sysemu/hw_accel.h"
-#include "sysemu/runstate.h"
-#include "sysemu/tcg.h"
+#include "system/hw_accel.h"
+#include "system/runstate.h"
+#include "system/tcg.h"
 #include "qemu/log.h"
 #include "qemu/main-loop.h"
 #include "qemu/module.h"
diff --git a/hw/ppc/spapr_iommu.c b/hw/ppc/spapr_iommu.c
index 7836dc71fc2..db3a14c1dfd 100644
--- a/hw/ppc/spapr_iommu.c
+++ b/hw/ppc/spapr_iommu.c
@@ -21,10 +21,10 @@
 #include "qemu/error-report.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
-#include "sysemu/kvm.h"
+#include "system/kvm.h"
 #include "kvm_ppc.h"
 #include "migration/vmstate.h"
-#include "sysemu/dma.h"
+#include "system/dma.h"
 #include "trace.h"
 
 #include "hw/ppc/spapr.h"
diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index aebd7eaabbf..d6d368dd08c 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -19,7 +19,7 @@
 #include "hw/ppc/xics_spapr.h"
 #include "hw/qdev-properties.h"
 #include "cpu-models.h"
-#include "sysemu/kvm.h"
+#include "system/kvm.h"
 
 #include "trace.h"
 
diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 3edff528ca1..42eef8c5010 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -45,10 +45,10 @@
 #include "hw/pci/pci_ids.h"
 #include "hw/ppc/spapr_drc.h"
 #include "hw/qdev-properties.h"
-#include "sysemu/device_tree.h"
-#include "sysemu/kvm.h"
-#include "sysemu/hostmem.h"
-#include "sysemu/numa.h"
+#include "system/device_tree.h"
+#include "system/kvm.h"
+#include "system/hostmem.h"
+#include "system/numa.h"
 #include "hw/ppc/spapr_numa.h"
 #include "qemu/log.h"
 
diff --git a/hw/ppc/spapr_rng.c b/hw/ppc/spapr_rng.c
index 51c3a54d45d..8cfd61b7db6 100644
--- a/hw/ppc/spapr_rng.c
+++ b/hw/ppc/spapr_rng.c
@@ -22,8 +22,8 @@
 #include "qemu/error-report.h"
 #include "qemu/main-loop.h"
 #include "qemu/module.h"
-#include "sysemu/device_tree.h"
-#include "sysemu/rng.h"
+#include "system/device_tree.h"
+#include "system/rng.h"
 #include "hw/ppc/spapr.h"
 #include "hw/qdev-properties.h"
 #include "kvm_ppc.h"
diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
index f329693c554..df2e837632a 100644
--- a/hw/ppc/spapr_rtas.c
+++ b/hw/ppc/spapr_rtas.c
@@ -28,12 +28,12 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "qemu/error-report.h"
-#include "sysemu/sysemu.h"
-#include "sysemu/device_tree.h"
-#include "sysemu/cpus.h"
-#include "sysemu/hw_accel.h"
-#include "sysemu/runstate.h"
-#include "sysemu/qtest.h"
+#include "system/system.h"
+#include "system/device_tree.h"
+#include "system/cpus.h"
+#include "system/hw_accel.h"
+#include "system/runstate.h"
+#include "system/qtest.h"
 #include "kvm_ppc.h"
 
 #include "hw/ppc/spapr.h"
diff --git a/hw/ppc/spapr_rtc.c b/hw/ppc/spapr_rtc.c
index deb3ea4e495..46fbc789001 100644
--- a/hw/ppc/spapr_rtc.c
+++ b/hw/ppc/spapr_rtc.c
@@ -27,8 +27,8 @@
 
 #include "qemu/osdep.h"
 #include "qemu/timer.h"
-#include "sysemu/sysemu.h"
-#include "sysemu/rtc.h"
+#include "system/system.h"
+#include "system/rtc.h"
 #include "hw/ppc/spapr.h"
 #include "migration/vmstate.h"
 #include "qapi/error.h"
diff --git a/hw/ppc/spapr_tpm_proxy.c b/hw/ppc/spapr_tpm_proxy.c
index 37521b88cbb..dc0d09eca3e 100644
--- a/hw/ppc/spapr_tpm_proxy.c
+++ b/hw/ppc/spapr_tpm_proxy.c
@@ -13,7 +13,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
-#include "sysemu/reset.h"
+#include "system/reset.h"
 #include "hw/ppc/spapr.h"
 #include "hw/qdev-properties.h"
 #include "trace.h"
diff --git a/hw/ppc/spapr_vio.c b/hw/ppc/spapr_vio.c
index 6a5a7f57c7d..09243c183bb 100644
--- a/hw/ppc/spapr_vio.c
+++ b/hw/ppc/spapr_vio.c
@@ -27,8 +27,8 @@
 #include "hw/loader.h"
 #include "elf.h"
 #include "hw/sysbus.h"
-#include "sysemu/kvm.h"
-#include "sysemu/device_tree.h"
+#include "system/kvm.h"
+#include "system/device_tree.h"
 #include "kvm_ppc.h"
 #include "migration/vmstate.h"
 
diff --git a/hw/ppc/spapr_vof.c b/hw/ppc/spapr_vof.c
index c02eaacfed0..46d78756e63 100644
--- a/hw/ppc/spapr_vof.c
+++ b/hw/ppc/spapr_vof.c
@@ -10,7 +10,7 @@
 #include "hw/ppc/spapr_cpu_core.h"
 #include "hw/ppc/fdt.h"
 #include "hw/ppc/vof.h"
-#include "sysemu/sysemu.h"
+#include "system/system.h"
 #include "qom/qom-qobject.h"
 #include "trace.h"
 
diff --git a/hw/ppc/virtex_ml507.c b/hw/ppc/virtex_ml507.c
index f378e5c4a90..ea7ab8a5694 100644
--- a/hw/ppc/virtex_ml507.c
+++ b/hw/ppc/virtex_ml507.c
@@ -30,10 +30,10 @@
 #include "hw/sysbus.h"
 #include "hw/char/serial-mm.h"
 #include "hw/block/flash.h"
-#include "sysemu/sysemu.h"
-#include "sysemu/reset.h"
+#include "system/system.h"
+#include "system/reset.h"
 #include "hw/boards.h"
-#include "sysemu/device_tree.h"
+#include "system/device_tree.h"
 #include "hw/loader.h"
 #include "elf.h"
 #include "qapi/error.h"
diff --git a/hw/ppc/vof.c b/hw/ppc/vof.c
index b5b6514d79f..09cb77de939 100644
--- a/hw/ppc/vof.c
+++ b/hw/ppc/vof.c
@@ -18,7 +18,7 @@
 #include "exec/address-spaces.h"
 #include "hw/ppc/vof.h"
 #include "hw/ppc/fdt.h"
-#include "sysemu/runstate.h"
+#include "system/runstate.h"
 #include "qom/qom-qobject.h"
 #include "trace.h"
 
diff --git a/hw/remote/message.c b/hw/remote/message.c
index 38ae6c75b4e..273f1e0323c 100644
--- a/hw/remote/message.c
+++ b/hw/remote/message.c
@@ -13,12 +13,12 @@
 #include "io/channel.h"
 #include "hw/remote/mpqemu-link.h"
 #include "qapi/error.h"
-#include "sysemu/runstate.h"
+#include "system/runstate.h"
 #include "hw/pci/pci.h"
 #include "exec/memattrs.h"
 #include "hw/remote/memory.h"
 #include "hw/remote/iohub.h"
-#include "sysemu/reset.h"
+#include "system/reset.h"
 
 static void process_config_write(QIOChannel *ioc, PCIDevice *dev,
                                  MPQemuMsg *msg, Error **errp);
diff --git a/hw/remote/mpqemu-link.c b/hw/remote/mpqemu-link.c
index 4394dc4d821..e25f97680d2 100644
--- a/hw/remote/mpqemu-link.c
+++ b/hw/remote/mpqemu-link.c
@@ -17,7 +17,7 @@
 #include "qemu/error-report.h"
 #include "qemu/main-loop.h"
 #include "io/channel.h"
-#include "sysemu/iothread.h"
+#include "system/iothread.h"
 #include "trace.h"
 
 /*
diff --git a/hw/remote/proxy.c b/hw/remote/proxy.c
index 6f84fdd3faf..3c08291c611 100644
--- a/hw/remote/proxy.c
+++ b/hw/remote/proxy.c
@@ -21,7 +21,7 @@
 #include "hw/remote/proxy-memory-listener.h"
 #include "qom/object.h"
 #include "qemu/event_notifier.h"
-#include "sysemu/kvm.h"
+#include "system/kvm.h"
 
 static void probe_pci_info(PCIDevice *dev, Error **errp);
 static void proxy_device_reset(DeviceState *dev);
diff --git a/hw/remote/remote-obj.c b/hw/remote/remote-obj.c
index dc27cc8da1f..2f25f92dcd0 100644
--- a/hw/remote/remote-obj.c
+++ b/hw/remote/remote-obj.c
@@ -17,7 +17,7 @@
 #include "hw/remote/machine.h"
 #include "io/channel-util.h"
 #include "qapi/error.h"
-#include "sysemu/sysemu.h"
+#include "system/system.h"
 #include "hw/pci/pci.h"
 #include "qemu/sockets.h"
 #include "monitor/monitor.h"
diff --git a/hw/remote/vfio-user-obj.c b/hw/remote/vfio-user-obj.c
index 8dbafafb9e7..9e5ff6d87a9 100644
--- a/hw/remote/vfio-user-obj.c
+++ b/hw/remote/vfio-user-obj.c
@@ -43,7 +43,7 @@
 #include "qom/object_interfaces.h"
 #include "qemu/error-report.h"
 #include "trace.h"
-#include "sysemu/runstate.h"
+#include "system/runstate.h"
 #include "hw/boards.h"
 #include "hw/remote/machine.h"
 #include "qapi/error.h"
@@ -52,7 +52,7 @@
 #include "qemu/notify.h"
 #include "qemu/thread.h"
 #include "qemu/main-loop.h"
-#include "sysemu/sysemu.h"
+#include "system/system.h"
 #include "libvfio-user.h"
 #include "hw/qdev-core.h"
 #include "hw/pci/pci.h"
diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
index 2e319168db8..7731b88f8a5 100644
--- a/hw/riscv/boot.c
+++ b/hw/riscv/boot.c
@@ -27,10 +27,10 @@
 #include "hw/riscv/boot.h"
 #include "hw/riscv/boot_opensbi.h"
 #include "elf.h"
-#include "sysemu/device_tree.h"
-#include "sysemu/qtest.h"
-#include "sysemu/kvm.h"
-#include "sysemu/reset.h"
+#include "system/device_tree.h"
+#include "system/qtest.h"
+#include "system/kvm.h"
+#include "system/reset.h"
 
 #include <libfdt.h>
 
diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
index f9a3b43d2e7..1208d684a4b 100644
--- a/hw/riscv/microchip_pfsoc.c
+++ b/hw/riscv/microchip_pfsoc.c
@@ -51,8 +51,8 @@
 #include "hw/riscv/microchip_pfsoc.h"
 #include "hw/intc/riscv_aclint.h"
 #include "hw/intc/sifive_plic.h"
-#include "sysemu/device_tree.h"
-#include "sysemu/sysemu.h"
+#include "system/device_tree.h"
+#include "system/system.h"
 
 /*
  * The BIOS image used by this machine is called Hart Software Services (HSS).
diff --git a/hw/riscv/numa.c b/hw/riscv/numa.c
index cf686f4ff1e..7a7b0120077 100644
--- a/hw/riscv/numa.c
+++ b/hw/riscv/numa.c
@@ -23,7 +23,7 @@
 #include "hw/boards.h"
 #include "hw/qdev-properties.h"
 #include "hw/riscv/numa.h"
-#include "sysemu/device_tree.h"
+#include "system/device_tree.h"
 
 static bool numa_enabled(const MachineState *ms)
 {
diff --git a/hw/riscv/opentitan.c b/hw/riscv/opentitan.c
index 8ce85ea9f73..e4f643cb52c 100644
--- a/hw/riscv/opentitan.c
+++ b/hw/riscv/opentitan.c
@@ -27,7 +27,7 @@
 #include "hw/misc/unimp.h"
 #include "hw/riscv/boot.h"
 #include "qemu/units.h"
-#include "sysemu/sysemu.h"
+#include "system/system.h"
 
 /*
  * This version of the OpenTitan machine currently supports
diff --git a/hw/riscv/riscv_hart.c b/hw/riscv/riscv_hart.c
index 0df454772fa..e73479a9432 100644
--- a/hw/riscv/riscv_hart.c
+++ b/hw/riscv/riscv_hart.c
@@ -21,7 +21,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
-#include "sysemu/reset.h"
+#include "system/reset.h"
 #include "hw/sysbus.h"
 #include "target/riscv/cpu.h"
 #include "hw/qdev-properties.h"
diff --git a/hw/riscv/shakti_c.c b/hw/riscv/shakti_c.c
index 2dccc1eff27..e2242b97d0c 100644
--- a/hw/riscv/shakti_c.c
+++ b/hw/riscv/shakti_c.c
@@ -23,7 +23,7 @@
 #include "qemu/error-report.h"
 #include "hw/intc/sifive_plic.h"
 #include "hw/intc/riscv_aclint.h"
-#include "sysemu/sysemu.h"
+#include "system/system.h"
 #include "hw/qdev-properties.h"
 #include "exec/address-spaces.h"
 #include "hw/riscv/boot.h"
diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
index 5a1959f2a9e..407bf51ff15 100644
--- a/hw/riscv/sifive_e.c
+++ b/hw/riscv/sifive_e.c
@@ -46,7 +46,7 @@
 #include "hw/misc/sifive_e_prci.h"
 #include "hw/misc/sifive_e_aon.h"
 #include "chardev/char.h"
-#include "sysemu/sysemu.h"
+#include "system/system.h"
 
 static const MemMapEntry sifive_e_memmap[] = {
     [SIFIVE_E_DEV_DEBUG] =    {        0x0,     0x1000 },
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 124ffd48424..506779db7cd 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -56,9 +56,9 @@
 #include "hw/intc/sifive_plic.h"
 #include "chardev/char.h"
 #include "net/eth.h"
-#include "sysemu/device_tree.h"
-#include "sysemu/runstate.h"
-#include "sysemu/sysemu.h"
+#include "system/device_tree.h"
+#include "system/runstate.h"
+#include "system/system.h"
 
 #include <libfdt.h>
 
diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
index fceb91d946a..586168b6ef2 100644
--- a/hw/riscv/spike.c
+++ b/hw/riscv/spike.c
@@ -36,8 +36,8 @@
 #include "hw/char/riscv_htif.h"
 #include "hw/intc/riscv_aclint.h"
 #include "chardev/char.h"
-#include "sysemu/device_tree.h"
-#include "sysemu/sysemu.h"
+#include "system/device_tree.h"
+#include "system/system.h"
 
 #include <libfdt.h>
 
diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
index 36d6a3a412f..825bd321ea5 100644
--- a/hw/riscv/virt-acpi-build.c
+++ b/hw/riscv/virt-acpi-build.c
@@ -38,7 +38,7 @@
 #include "migration/vmstate.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
-#include "sysemu/reset.h"
+#include "system/reset.h"
 
 #define ACPI_BUILD_TABLE_SIZE             0x20000
 #define ACPI_BUILD_INTC_ID(socket, index) ((socket << 24) | (index))
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 2feb851f159..80eda67f394 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -44,12 +44,12 @@
 #include "hw/misc/sifive_test.h"
 #include "hw/platform-bus.h"
 #include "chardev/char.h"
-#include "sysemu/device_tree.h"
-#include "sysemu/sysemu.h"
-#include "sysemu/tcg.h"
-#include "sysemu/kvm.h"
-#include "sysemu/tpm.h"
-#include "sysemu/qtest.h"
+#include "system/device_tree.h"
+#include "system/system.h"
+#include "system/tcg.h"
+#include "system/kvm.h"
+#include "system/tpm.h"
+#include "system/qtest.h"
 #include "hw/pci/pci.h"
 #include "hw/pci-host/gpex.h"
 #include "hw/display/ramfb.h"
diff --git a/hw/rtc/allwinner-rtc.c b/hw/rtc/allwinner-rtc.c
index 838db721362..be591f77ab5 100644
--- a/hw/rtc/allwinner-rtc.c
+++ b/hw/rtc/allwinner-rtc.c
@@ -25,7 +25,7 @@
 #include "qemu/module.h"
 #include "hw/qdev-properties.h"
 #include "hw/rtc/allwinner-rtc.h"
-#include "sysemu/rtc.h"
+#include "system/rtc.h"
 #include "trace.h"
 
 /* RTC registers */
diff --git a/hw/rtc/aspeed_rtc.c b/hw/rtc/aspeed_rtc.c
index 3cddf43eeab..fbdeb0781f3 100644
--- a/hw/rtc/aspeed_rtc.c
+++ b/hw/rtc/aspeed_rtc.c
@@ -11,7 +11,7 @@
 #include "migration/vmstate.h"
 #include "qemu/log.h"
 #include "qemu/timer.h"
-#include "sysemu/rtc.h"
+#include "system/rtc.h"
 
 #include "trace.h"
 
diff --git a/hw/rtc/ds1338.c b/hw/rtc/ds1338.c
index c993182ae48..8dd17fdc07c 100644
--- a/hw/rtc/ds1338.c
+++ b/hw/rtc/ds1338.c
@@ -15,7 +15,7 @@
 #include "migration/vmstate.h"
 #include "qemu/bcd.h"
 #include "qom/object.h"
-#include "sysemu/rtc.h"
+#include "system/rtc.h"
 #include "trace.h"
 
 /* Size of NVRAM including both the user-accessible area and the
diff --git a/hw/rtc/exynos4210_rtc.c b/hw/rtc/exynos4210_rtc.c
index ca28a456729..aa1b3cd1151 100644
--- a/hw/rtc/exynos4210_rtc.c
+++ b/hw/rtc/exynos4210_rtc.c
@@ -38,7 +38,7 @@
 
 #include "hw/arm/exynos4210.h"
 #include "qom/object.h"
-#include "sysemu/rtc.h"
+#include "system/rtc.h"
 
 #define DEBUG_RTC 0
 
diff --git a/hw/rtc/goldfish_rtc.c b/hw/rtc/goldfish_rtc.c
index 389f192efa4..425c8ba0c2b 100644
--- a/hw/rtc/goldfish_rtc.c
+++ b/hw/rtc/goldfish_rtc.c
@@ -27,8 +27,8 @@
 #include "hw/sysbus.h"
 #include "qemu/bitops.h"
 #include "qemu/timer.h"
-#include "sysemu/sysemu.h"
-#include "sysemu/rtc.h"
+#include "system/system.h"
+#include "system/rtc.h"
 #include "qemu/cutils.h"
 #include "qemu/log.h"
 
diff --git a/hw/rtc/ls7a_rtc.c b/hw/rtc/ls7a_rtc.c
index c9c3cd84da7..fce23a3dbe8 100644
--- a/hw/rtc/ls7a_rtc.c
+++ b/hw/rtc/ls7a_rtc.c
@@ -10,12 +10,12 @@
 #include "hw/irq.h"
 #include "hw/register.h"
 #include "qemu/timer.h"
-#include "sysemu/sysemu.h"
+#include "system/system.h"
 #include "qemu/cutils.h"
 #include "qemu/log.h"
 #include "migration/vmstate.h"
 #include "hw/misc/unimp.h"
-#include "sysemu/rtc.h"
+#include "system/rtc.h"
 #include "hw/registerfields.h"
 
 #define SYS_TOYTRIM        0x20
diff --git a/hw/rtc/m41t80.c b/hw/rtc/m41t80.c
index e045c864bb4..96006956798 100644
--- a/hw/rtc/m41t80.c
+++ b/hw/rtc/m41t80.c
@@ -14,7 +14,7 @@
 #include "qemu/bcd.h"
 #include "hw/i2c/i2c.h"
 #include "qom/object.h"
-#include "sysemu/rtc.h"
+#include "system/rtc.h"
 
 #define TYPE_M41T80 "m41t80"
 OBJECT_DECLARE_SIMPLE_TYPE(M41t80State, M41T80)
diff --git a/hw/rtc/m48t59.c b/hw/rtc/m48t59.c
index 5a2c7b4abdd..4c578e7c54e 100644
--- a/hw/rtc/m48t59.c
+++ b/hw/rtc/m48t59.c
@@ -28,15 +28,15 @@
 #include "hw/qdev-properties.h"
 #include "hw/rtc/m48t59.h"
 #include "qemu/timer.h"
-#include "sysemu/runstate.h"
-#include "sysemu/rtc.h"
-#include "sysemu/sysemu.h"
+#include "system/runstate.h"
+#include "system/rtc.h"
+#include "system/system.h"
 #include "hw/sysbus.h"
 #include "qapi/error.h"
 #include "qemu/bcd.h"
 #include "qemu/module.h"
 #include "trace.h"
-#include "sysemu/watchdog.h"
+#include "system/watchdog.h"
 
 #include "m48t59-internal.h"
 #include "migration/vmstate.h"
diff --git a/hw/rtc/mc146818rtc.c b/hw/rtc/mc146818rtc.c
index 973ed9914d0..2103f774e9f 100644
--- a/hw/rtc/mc146818rtc.c
+++ b/hw/rtc/mc146818rtc.c
@@ -32,11 +32,11 @@
 #include "hw/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
 #include "qemu/timer.h"
-#include "sysemu/sysemu.h"
-#include "sysemu/replay.h"
-#include "sysemu/reset.h"
-#include "sysemu/runstate.h"
-#include "sysemu/rtc.h"
+#include "system/system.h"
+#include "system/replay.h"
+#include "system/reset.h"
+#include "system/runstate.h"
+#include "system/rtc.h"
 #include "hw/rtc/mc146818rtc.h"
 #include "hw/rtc/mc146818rtc_regs.h"
 #include "migration/vmstate.h"
diff --git a/hw/rtc/pl031.c b/hw/rtc/pl031.c
index 1dc8e6e00ff..a037bdbf428 100644
--- a/hw/rtc/pl031.c
+++ b/hw/rtc/pl031.c
@@ -18,8 +18,8 @@
 #include "hw/qdev-properties.h"
 #include "hw/sysbus.h"
 #include "qemu/timer.h"
-#include "sysemu/sysemu.h"
-#include "sysemu/rtc.h"
+#include "system/system.h"
+#include "system/rtc.h"
 #include "qemu/cutils.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
diff --git a/hw/rtc/xlnx-zynqmp-rtc.c b/hw/rtc/xlnx-zynqmp-rtc.c
index f37df09cfb9..b596b608c5b 100644
--- a/hw/rtc/xlnx-zynqmp-rtc.c
+++ b/hw/rtc/xlnx-zynqmp-rtc.c
@@ -32,8 +32,8 @@
 #include "qemu/module.h"
 #include "hw/irq.h"
 #include "qemu/cutils.h"
-#include "sysemu/sysemu.h"
-#include "sysemu/rtc.h"
+#include "system/system.h"
+#include "system/rtc.h"
 #include "trace.h"
 #include "hw/rtc/xlnx-zynqmp-rtc.h"
 #include "migration/vmstate.h"
diff --git a/hw/rx/rx-gdbsim.c b/hw/rx/rx-gdbsim.c
index bb4746c5569..02fdbdf824b 100644
--- a/hw/rx/rx-gdbsim.c
+++ b/hw/rx/rx-gdbsim.c
@@ -24,9 +24,9 @@
 #include "qapi/error.h"
 #include "hw/loader.h"
 #include "hw/rx/rx62n.h"
-#include "sysemu/qtest.h"
-#include "sysemu/device_tree.h"
-#include "sysemu/reset.h"
+#include "system/qtest.h"
+#include "system/device_tree.h"
+#include "system/reset.h"
 #include "hw/boards.h"
 #include "qom/object.h"
 
diff --git a/hw/rx/rx62n.c b/hw/rx/rx62n.c
index dfa27bc94ef..f421de4e6f9 100644
--- a/hw/rx/rx62n.c
+++ b/hw/rx/rx62n.c
@@ -28,7 +28,7 @@
 #include "hw/loader.h"
 #include "hw/sysbus.h"
 #include "hw/qdev-properties.h"
-#include "sysemu/sysemu.h"
+#include "system/system.h"
 #include "qapi/qmp/qlist.h"
 #include "qom/object.h"
 
diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index 88a97f00854..f0275bf34c8 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -15,9 +15,9 @@
 #include "qemu/osdep.h"
 #include "qemu/datadir.h"
 #include "qapi/error.h"
-#include "sysemu/reset.h"
-#include "sysemu/runstate.h"
-#include "sysemu/tcg.h"
+#include "system/reset.h"
+#include "system/runstate.h"
+#include "system/tcg.h"
 #include "elf.h"
 #include "hw/loader.h"
 #include "hw/qdev-properties.h"
diff --git a/hw/s390x/s390-ccw.c b/hw/s390x/s390-ccw.c
index 3c097505508..909475f0481 100644
--- a/hw/s390x/s390-ccw.c
+++ b/hw/s390x/s390-ccw.c
@@ -18,7 +18,7 @@
 #include "hw/s390x/css.h"
 #include "hw/s390x/css-bridge.h"
 #include "hw/s390x/s390-ccw.h"
-#include "sysemu/sysemu.h"
+#include "system/system.h"
 
 IOInstEnding s390_ccw_cmd_request(SubchDev *sch)
 {
diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 22e6be67aff..1a507ea4728 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -24,8 +24,8 @@
 #include "hw/pci/msi.h"
 #include "qemu/error-report.h"
 #include "qemu/module.h"
-#include "sysemu/reset.h"
-#include "sysemu/runstate.h"
+#include "system/reset.h"
+#include "system/runstate.h"
 
 #include "trace.h"
 
diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
index 41655082dac..e386d75d58c 100644
--- a/hw/s390x/s390-pci-inst.c
+++ b/hw/s390x/s390-pci-inst.c
@@ -15,7 +15,7 @@
 #include "exec/memop.h"
 #include "exec/memory.h"
 #include "qemu/error-report.h"
-#include "sysemu/hw_accel.h"
+#include "system/hw_accel.h"
 #include "hw/pci/pci_device.h"
 #include "hw/s390x/s390-pci-inst.h"
 #include "hw/s390x/s390-pci-bus.h"
diff --git a/hw/s390x/s390-skeys-kvm.c b/hw/s390x/s390-skeys-kvm.c
index 3ff9d94b802..0215e94388e 100644
--- a/hw/s390x/s390-skeys-kvm.c
+++ b/hw/s390x/s390-skeys-kvm.c
@@ -11,7 +11,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/s390x/storage-keys.h"
-#include "sysemu/kvm.h"
+#include "system/kvm.h"
 #include "qemu/error-report.h"
 #include "qemu/module.h"
 
diff --git a/hw/s390x/s390-skeys.c b/hw/s390x/s390-skeys.c
index 6d0a47ed731..c6a4db5f7ef 100644
--- a/hw/s390x/s390-skeys.c
+++ b/hw/s390x/s390-skeys.c
@@ -18,9 +18,9 @@
 #include "qapi/qapi-commands-misc-target.h"
 #include "qapi/qmp/qdict.h"
 #include "qemu/error-report.h"
-#include "sysemu/memory_mapping.h"
+#include "system/memory_mapping.h"
 #include "exec/address-spaces.h"
-#include "sysemu/kvm.h"
+#include "system/kvm.h"
 #include "migration/qemu-file-types.h"
 #include "migration/register.h"
 #include "trace.h"
diff --git a/hw/s390x/s390-stattrib-kvm.c b/hw/s390x/s390-stattrib-kvm.c
index eeaa8110981..508fd558e82 100644
--- a/hw/s390x/s390-stattrib-kvm.c
+++ b/hw/s390x/s390-stattrib-kvm.c
@@ -14,7 +14,7 @@
 #include "migration/qemu-file.h"
 #include "hw/s390x/storage-attributes.h"
 #include "qemu/error-report.h"
-#include "sysemu/kvm.h"
+#include "system/kvm.h"
 #include "exec/ram_addr.h"
 #include "kvm/kvm_s390x.h"
 #include "qapi/error.h"
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 67ae34aead9..f4d64d64f94 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -29,7 +29,7 @@
 #include "qemu/qemu-print.h"
 #include "qemu/units.h"
 #include "hw/s390x/s390-pci-bus.h"
-#include "sysemu/reset.h"
+#include "system/reset.h"
 #include "hw/s390x/storage-keys.h"
 #include "hw/s390x/storage-attributes.h"
 #include "hw/s390x/event-facility.h"
@@ -42,8 +42,8 @@
 #include "hw/nmi.h"
 #include "hw/qdev-properties.h"
 #include "hw/s390x/tod.h"
-#include "sysemu/sysemu.h"
-#include "sysemu/cpus.h"
+#include "system/system.h"
+#include "system/cpus.h"
 #include "target/s390x/kvm/pv.h"
 #include "migration/blocker.h"
 #include "qapi/visitor.h"
diff --git a/hw/s390x/sclpcpu.c b/hw/s390x/sclpcpu.c
index fa79891f5a4..a178a9dd4c8 100644
--- a/hw/s390x/sclpcpu.c
+++ b/hw/s390x/sclpcpu.c
@@ -17,7 +17,7 @@
 #include "hw/s390x/sclp.h"
 #include "qemu/module.h"
 #include "hw/s390x/event-facility.h"
-#include "sysemu/cpus.h"
+#include "system/cpus.h"
 
 typedef struct ConfigMgtData {
     EventBufferHeader ebh;
diff --git a/hw/s390x/sclpquiesce.c b/hw/s390x/sclpquiesce.c
index a32d6a91f58..7bb5aad5208 100644
--- a/hw/s390x/sclpquiesce.c
+++ b/hw/s390x/sclpquiesce.c
@@ -16,7 +16,7 @@
 #include "hw/s390x/sclp.h"
 #include "migration/vmstate.h"
 #include "qemu/module.h"
-#include "sysemu/runstate.h"
+#include "system/runstate.h"
 #include "hw/s390x/event-facility.h"
 
 typedef struct SignalQuiesce {
diff --git a/hw/s390x/tod-kvm.c b/hw/s390x/tod-kvm.c
index 9588b90f2b9..5da9037e0cb 100644
--- a/hw/s390x/tod-kvm.c
+++ b/hw/s390x/tod-kvm.c
@@ -11,7 +11,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
-#include "sysemu/runstate.h"
+#include "system/runstate.h"
 #include "hw/s390x/tod.h"
 #include "target/s390x/kvm/pv.h"
 #include "kvm/kvm_s390x.h"
diff --git a/hw/s390x/tod-tcg.c b/hw/s390x/tod-tcg.c
index 2d540dba65a..3b3ef8843ed 100644
--- a/hw/s390x/tod-tcg.c
+++ b/hw/s390x/tod-tcg.c
@@ -16,7 +16,7 @@
 #include "qemu/module.h"
 #include "cpu.h"
 #include "tcg/tcg_s390x.h"
-#include "sysemu/rtc.h"
+#include "system/rtc.h"
 
 static void qemu_s390_tod_get(const S390TODState *td, S390TOD *tod,
                               Error **errp)
diff --git a/hw/s390x/tod.c b/hw/s390x/tod.c
index c81b1c03383..6afbb23fc7e 100644
--- a/hw/s390x/tod.c
+++ b/hw/s390x/tod.c
@@ -13,9 +13,9 @@
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "qemu/module.h"
-#include "sysemu/kvm.h"
-#include "sysemu/tcg.h"
-#include "sysemu/qtest.h"
+#include "system/kvm.h"
+#include "system/tcg.h"
+#include "system/qtest.h"
 #include "migration/qemu-file-types.h"
 #include "migration/register.h"
 
diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
index 96747318d2a..7cbce4766aa 100644
--- a/hw/s390x/virtio-ccw.c
+++ b/hw/s390x/virtio-ccw.c
@@ -13,7 +13,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "exec/address-spaces.h"
-#include "sysemu/kvm.h"
+#include "system/kvm.h"
 #include "net/net.h"
 #include "hw/virtio/virtio.h"
 #include "migration/qemu-file-types.h"
@@ -32,7 +32,7 @@
 #include "trace.h"
 #include "hw/s390x/css-bridge.h"
 #include "hw/s390x/s390-virtio-ccw.h"
-#include "sysemu/replay.h"
+#include "system/replay.h"
 
 #define NR_CLASSIC_INDICATOR_BITS 64
 
diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
index 1f728416e2a..d85e384ad63 100644
--- a/hw/scsi/lsi53c895a.c
+++ b/hw/scsi/lsi53c895a.c
@@ -19,7 +19,7 @@
 #include "hw/pci/pci_device.h"
 #include "hw/scsi/scsi.h"
 #include "migration/vmstate.h"
-#include "sysemu/dma.h"
+#include "system/dma.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "trace.h"
diff --git a/hw/scsi/megasas.c b/hw/scsi/megasas.c
index 8323cd18e3a..70d444e0934 100644
--- a/hw/scsi/megasas.c
+++ b/hw/scsi/megasas.c
@@ -21,9 +21,9 @@
 #include "qemu/osdep.h"
 #include "hw/pci/pci.h"
 #include "hw/qdev-properties.h"
-#include "sysemu/dma.h"
-#include "sysemu/block-backend.h"
-#include "sysemu/rtc.h"
+#include "system/dma.h"
+#include "system/block-backend.h"
+#include "system/rtc.h"
 #include "hw/pci/msi.h"
 #include "hw/pci/msix.h"
 #include "qemu/iov.h"
diff --git a/hw/scsi/mptendian.c b/hw/scsi/mptendian.c
index 0d5abb4b6cc..6cba92f3761 100644
--- a/hw/scsi/mptendian.c
+++ b/hw/scsi/mptendian.c
@@ -22,7 +22,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/pci/pci.h"
-#include "sysemu/dma.h"
+#include "system/dma.h"
 #include "hw/pci/msi.h"
 #include "qemu/iov.h"
 #include "hw/scsi/scsi.h"
diff --git a/hw/scsi/mptsas.c b/hw/scsi/mptsas.c
index a06113d9083..8397c93bf2d 100644
--- a/hw/scsi/mptsas.c
+++ b/hw/scsi/mptsas.c
@@ -25,7 +25,7 @@
 #include "qemu/osdep.h"
 #include "hw/pci/pci.h"
 #include "hw/qdev-properties.h"
-#include "sysemu/dma.h"
+#include "system/dma.h"
 #include "hw/pci/msi.h"
 #include "qemu/iov.h"
 #include "qemu/main-loop.h"
diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
index 2f1678d51e7..5bfdcfca45a 100644
--- a/hw/scsi/scsi-bus.c
+++ b/hw/scsi/scsi-bus.c
@@ -9,12 +9,12 @@
 #include "migration/qemu-file-types.h"
 #include "migration/vmstate.h"
 #include "scsi/constants.h"
-#include "sysemu/block-backend.h"
-#include "sysemu/blockdev.h"
-#include "sysemu/sysemu.h"
-#include "sysemu/runstate.h"
+#include "system/block-backend.h"
+#include "system/blockdev.h"
+#include "system/system.h"
+#include "system/runstate.h"
 #include "trace.h"
-#include "sysemu/dma.h"
+#include "system/dma.h"
 #include "qemu/cutils.h"
 
 static char *scsibus_get_dev_path(DeviceState *dev);
diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index a47b80907f1..33c169b0134 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -32,14 +32,14 @@
 #include "migration/vmstate.h"
 #include "hw/scsi/emulation.h"
 #include "scsi/constants.h"
-#include "sysemu/arch_init.h"
-#include "sysemu/block-backend.h"
-#include "sysemu/blockdev.h"
+#include "system/arch_init.h"
+#include "system/block-backend.h"
+#include "system/blockdev.h"
 #include "hw/block/block.h"
 #include "hw/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
-#include "sysemu/dma.h"
-#include "sysemu/sysemu.h"
+#include "system/dma.h"
+#include "system/system.h"
 #include "qemu/cutils.h"
 #include "trace.h"
 #include "qom/object.h"
diff --git a/hw/scsi/scsi-generic.c b/hw/scsi/scsi-generic.c
index d7ae7549d06..5748060a9a2 100644
--- a/hw/scsi/scsi-generic.c
+++ b/hw/scsi/scsi-generic.c
@@ -21,7 +21,7 @@
 #include "hw/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
 #include "hw/scsi/emulation.h"
-#include "sysemu/block-backend.h"
+#include "system/block-backend.h"
 #include "trace.h"
 
 #ifdef __linux__
diff --git a/hw/scsi/vhost-scsi.c b/hw/scsi/vhost-scsi.c
index effb8dab1f0..4bd6d2d7a89 100644
--- a/hw/scsi/vhost-scsi.c
+++ b/hw/scsi/vhost-scsi.c
@@ -29,7 +29,7 @@
 #include "hw/fw-path-provider.h"
 #include "hw/qdev-properties.h"
 #include "qemu/cutils.h"
-#include "sysemu/sysemu.h"
+#include "system/system.h"
 
 /* Features supported by host kernel. */
 static const int kernel_feature_bits[] = {
diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
index d5265c57bce..8b84f9508e7 100644
--- a/hw/scsi/vhost-user-scsi.c
+++ b/hw/scsi/vhost-user-scsi.c
@@ -27,7 +27,7 @@
 #include "hw/virtio/vhost-user-scsi.h"
 #include "hw/virtio/virtio.h"
 #include "chardev/char-fe.h"
-#include "sysemu/sysemu.h"
+#include "system/system.h"
 
 /* Features supported by the host application */
 static const int user_feature_bits[] = {
diff --git a/hw/scsi/virtio-scsi-dataplane.c b/hw/scsi/virtio-scsi-dataplane.c
index 2806a121b24..f49ab98eccf 100644
--- a/hw/scsi/virtio-scsi-dataplane.c
+++ b/hw/scsi/virtio-scsi-dataplane.c
@@ -15,7 +15,7 @@
 #include "qapi/error.h"
 #include "hw/virtio/virtio-scsi.h"
 #include "qemu/error-report.h"
-#include "sysemu/block-backend.h"
+#include "system/block-backend.h"
 #include "hw/scsi/scsi.h"
 #include "scsi/constants.h"
 #include "hw/virtio/virtio-bus.h"
diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
index c0a4f1a6208..e4d01e4adb2 100644
--- a/hw/scsi/virtio-scsi.c
+++ b/hw/scsi/virtio-scsi.c
@@ -22,8 +22,8 @@
 #include "qemu/error-report.h"
 #include "qemu/iov.h"
 #include "qemu/module.h"
-#include "sysemu/block-backend.h"
-#include "sysemu/dma.h"
+#include "system/block-backend.h"
+#include "system/dma.h"
 #include "hw/qdev-properties.h"
 #include "hw/scsi/scsi.h"
 #include "scsi/constants.h"
diff --git a/hw/sd/allwinner-sdhost.c b/hw/sd/allwinner-sdhost.c
index be39ec2e71a..f46213dfc7a 100644
--- a/hw/sd/allwinner-sdhost.c
+++ b/hw/sd/allwinner-sdhost.c
@@ -22,8 +22,8 @@
 #include "qemu/module.h"
 #include "qemu/units.h"
 #include "qapi/error.h"
-#include "sysemu/blockdev.h"
-#include "sysemu/dma.h"
+#include "system/blockdev.h"
+#include "system/dma.h"
 #include "hw/qdev-properties.h"
 #include "hw/irq.h"
 #include "hw/sd/allwinner-sdhost.h"
diff --git a/hw/sd/bcm2835_sdhost.c b/hw/sd/bcm2835_sdhost.c
index 4e411ff7986..0724949d0cf 100644
--- a/hw/sd/bcm2835_sdhost.c
+++ b/hw/sd/bcm2835_sdhost.c
@@ -14,7 +14,7 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
-#include "sysemu/blockdev.h"
+#include "system/blockdev.h"
 #include "hw/irq.h"
 #include "hw/sd/bcm2835_sdhost.h"
 #include "migration/vmstate.h"
diff --git a/hw/sd/pl181.c b/hw/sd/pl181.c
index 51b10cadca3..03d2ae7d21f 100644
--- a/hw/sd/pl181.c
+++ b/hw/sd/pl181.c
@@ -8,7 +8,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "sysemu/blockdev.h"
+#include "system/blockdev.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
 #include "hw/irq.h"
diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index b994ef581e6..5b7b07194a1 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -37,7 +37,7 @@
 #include "qemu/cutils.h"
 #include "hw/irq.h"
 #include "hw/registerfields.h"
-#include "sysemu/block-backend.h"
+#include "system/block-backend.h"
 #include "hw/sd/sd.h"
 #include "hw/sd/sdcard_legacy.h"
 #include "migration/vmstate.h"
diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index e697ee05b38..11a298f4b8f 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -30,7 +30,7 @@
 #include "qapi/error.h"
 #include "hw/irq.h"
 #include "hw/qdev-properties.h"
-#include "sysemu/dma.h"
+#include "system/dma.h"
 #include "qemu/timer.h"
 #include "qemu/bitops.h"
 #include "hw/sd/sdhci.h"
diff --git a/hw/sd/ssi-sd.c b/hw/sd/ssi-sd.c
index 15940515ab9..c4a58da0abc 100644
--- a/hw/sd/ssi-sd.c
+++ b/hw/sd/ssi-sd.c
@@ -16,7 +16,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "sysemu/blockdev.h"
+#include "system/blockdev.h"
 #include "hw/ssi/ssi.h"
 #include "migration/vmstate.h"
 #include "hw/qdev-properties.h"
diff --git a/hw/sh4/r2d.c b/hw/sh4/r2d.c
index e6cc156c238..2fa439819e3 100644
--- a/hw/sh4/r2d.c
+++ b/hw/sh4/r2d.c
@@ -30,9 +30,9 @@
 #include "cpu.h"
 #include "hw/sysbus.h"
 #include "hw/sh4/sh.h"
-#include "sysemu/reset.h"
-#include "sysemu/runstate.h"
-#include "sysemu/sysemu.h"
+#include "system/reset.h"
+#include "system/runstate.h"
+#include "system/system.h"
 #include "hw/boards.h"
 #include "hw/pci/pci.h"
 #include "hw/qdev-properties.h"
diff --git a/hw/sh4/sh7750.c b/hw/sh4/sh7750.c
index 8041b3b651b..8892eaddcbc 100644
--- a/hw/sh4/sh7750.c
+++ b/hw/sh4/sh7750.c
@@ -28,7 +28,7 @@
 #include "hw/sysbus.h"
 #include "hw/irq.h"
 #include "hw/sh4/sh.h"
-#include "sysemu/sysemu.h"
+#include "system/system.h"
 #include "hw/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
 #include "sh7750_regs.h"
diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
index a394514264c..02a09eb9cd0 100644
--- a/hw/smbios/smbios.c
+++ b/hw/smbios/smbios.c
@@ -21,7 +21,7 @@
 #include "qemu/config-file.h"
 #include "qemu/module.h"
 #include "qemu/option.h"
-#include "sysemu/sysemu.h"
+#include "system/system.h"
 #include "qemu/uuid.h"
 #include "hw/firmware/smbios.h"
 #include "hw/loader.h"
diff --git a/hw/smbios/smbios_legacy.c b/hw/smbios/smbios_legacy.c
index c37a8ee821f..14319d4897f 100644
--- a/hw/smbios/smbios_legacy.c
+++ b/hw/smbios/smbios_legacy.c
@@ -18,7 +18,7 @@
 #include "qemu/osdep.h"
 #include "qemu/bswap.h"
 #include "hw/firmware/smbios.h"
-#include "sysemu/sysemu.h"
+#include "system/system.h"
 #include "qapi/error.h"
 
 struct smbios_header {
diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
index 6aaa04cb191..84381254ad0 100644
--- a/hw/sparc/leon3.c
+++ b/hw/sparc/leon3.c
@@ -34,9 +34,9 @@
 #include "qemu/timer.h"
 #include "hw/ptimer.h"
 #include "hw/qdev-properties.h"
-#include "sysemu/sysemu.h"
-#include "sysemu/qtest.h"
-#include "sysemu/reset.h"
+#include "system/system.h"
+#include "system/qtest.h"
+#include "system/reset.h"
 #include "hw/boards.h"
 #include "hw/loader.h"
 #include "elf.h"
diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
index d52e6a7213f..470b6877cd4 100644
--- a/hw/sparc/sun4m.c
+++ b/hw/sparc/sun4m.c
@@ -35,9 +35,9 @@
 #include "migration/vmstate.h"
 #include "hw/sparc/sparc32_dma.h"
 #include "hw/block/fdc.h"
-#include "sysemu/reset.h"
-#include "sysemu/runstate.h"
-#include "sysemu/sysemu.h"
+#include "system/reset.h"
+#include "system/runstate.h"
+#include "system/system.h"
 #include "net/net.h"
 #include "hw/boards.h"
 #include "hw/scsi/esp.h"
diff --git a/hw/sparc64/niagara.c b/hw/sparc64/niagara.c
index 67ec403e1d4..805ba6b1e3d 100644
--- a/hw/sparc64/niagara.c
+++ b/hw/sparc64/niagara.c
@@ -32,10 +32,10 @@
 #include "hw/loader.h"
 #include "hw/sparc/sparc64.h"
 #include "hw/rtc/sun4v-rtc.h"
-#include "sysemu/block-backend.h"
+#include "system/block-backend.h"
 #include "qemu/error-report.h"
-#include "sysemu/qtest.h"
-#include "sysemu/sysemu.h"
+#include "system/qtest.h"
+#include "system/system.h"
 #include "qapi/error.h"
 
 typedef struct NiagaraBoardState {
diff --git a/hw/sparc64/sparc64.c b/hw/sparc64/sparc64.c
index 3091cde5862..9cffc92aa3b 100644
--- a/hw/sparc64/sparc64.c
+++ b/hw/sparc64/sparc64.c
@@ -29,7 +29,7 @@
 #include "hw/boards.h"
 #include "hw/sparc/sparc64.h"
 #include "qemu/timer.h"
-#include "sysemu/reset.h"
+#include "system/reset.h"
 #include "trace.h"
 
 
diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index 7088ac273ea..8546b30266e 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -43,8 +43,8 @@
 #include "hw/block/fdc.h"
 #include "net/net.h"
 #include "qemu/timer.h"
-#include "sysemu/runstate.h"
-#include "sysemu/sysemu.h"
+#include "system/runstate.h"
+#include "system/system.h"
 #include "hw/boards.h"
 #include "hw/nvram/sun_nvram.h"
 #include "hw/nvram/chrp_nvram.h"
diff --git a/hw/ssi/xilinx_spips.c b/hw/ssi/xilinx_spips.c
index f72cb3cbc87..0acac4ef703 100644
--- a/hw/ssi/xilinx_spips.c
+++ b/hw/ssi/xilinx_spips.c
@@ -33,7 +33,7 @@
 #include "hw/ssi/xilinx_spips.h"
 #include "qapi/error.h"
 #include "hw/register.h"
-#include "sysemu/dma.h"
+#include "system/dma.h"
 #include "migration/blocker.h"
 #include "migration/vmstate.h"
 
diff --git a/hw/timer/a9gtimer.c b/hw/timer/a9gtimer.c
index c0a91bab0c8..0c226d6ea69 100644
--- a/hw/timer/a9gtimer.c
+++ b/hw/timer/a9gtimer.c
@@ -32,7 +32,7 @@
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "hw/core/cpu.h"
-#include "sysemu/qtest.h"
+#include "system/qtest.h"
 
 #ifndef A9_GTIMER_ERR_DEBUG
 #define A9_GTIMER_ERR_DEBUG 0
diff --git a/hw/timer/pxa2xx_timer.c b/hw/timer/pxa2xx_timer.c
index 345145bfa80..6328ad6ab76 100644
--- a/hw/timer/pxa2xx_timer.c
+++ b/hw/timer/pxa2xx_timer.c
@@ -11,13 +11,13 @@
 #include "hw/irq.h"
 #include "hw/qdev-properties.h"
 #include "qemu/timer.h"
-#include "sysemu/runstate.h"
+#include "system/runstate.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "qom/object.h"
-#include "sysemu/watchdog.h"
+#include "system/watchdog.h"
 
 #define OSMR0	0x00
 #define OSMR1	0x04
diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
index 2bf6e7ffe96..a9f7aba3035 100644
--- a/hw/tpm/tpm_crb.c
+++ b/hw/tpm/tpm_crb.c
@@ -23,10 +23,10 @@
 #include "hw/pci/pci_ids.h"
 #include "hw/acpi/tpm.h"
 #include "migration/vmstate.h"
-#include "sysemu/tpm_backend.h"
-#include "sysemu/tpm_util.h"
-#include "sysemu/reset.h"
-#include "sysemu/xen.h"
+#include "system/tpm_backend.h"
+#include "system/tpm_util.h"
+#include "system/reset.h"
+#include "system/xen.h"
 #include "tpm_prop.h"
 #include "tpm_ppi.h"
 #include "trace.h"
diff --git a/hw/tpm/tpm_ppi.c b/hw/tpm/tpm_ppi.c
index f27ed6c35ed..984d3d10808 100644
--- a/hw/tpm/tpm_ppi.c
+++ b/hw/tpm/tpm_ppi.c
@@ -14,7 +14,7 @@
 #include "qemu/osdep.h"
 #include "qemu/memalign.h"
 #include "qapi/error.h"
-#include "sysemu/memory_mapping.h"
+#include "system/memory_mapping.h"
 #include "migration/vmstate.h"
 #include "hw/qdev-core.h"
 #include "hw/acpi/tpm.h"
diff --git a/hw/tpm/tpm_spapr.c b/hw/tpm/tpm_spapr.c
index e15b67dd45e..645079f2e59 100644
--- a/hw/tpm/tpm_spapr.c
+++ b/hw/tpm/tpm_spapr.c
@@ -19,8 +19,8 @@
 #include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
 
-#include "sysemu/tpm_backend.h"
-#include "sysemu/tpm_util.h"
+#include "system/tpm_backend.h"
+#include "system/tpm_util.h"
 #include "tpm_prop.h"
 
 #include "hw/ppc/spapr.h"
diff --git a/hw/tpm/tpm_tis_common.c b/hw/tpm/tpm_tis_common.c
index 1bfa28bfd95..cdd0df11374 100644
--- a/hw/tpm/tpm_tis_common.c
+++ b/hw/tpm/tpm_tis_common.c
@@ -34,8 +34,8 @@
 #include "hw/pci/pci_ids.h"
 #include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
-#include "sysemu/tpm_backend.h"
-#include "sysemu/tpm_util.h"
+#include "system/tpm_backend.h"
+#include "system/tpm_util.h"
 #include "tpm_ppi.h"
 #include "trace.h"
 
diff --git a/hw/ufs/lu.c b/hw/ufs/lu.c
index 74ff52ad096..34e4bd89367 100644
--- a/hw/ufs/lu.c
+++ b/hw/ufs/lu.c
@@ -14,7 +14,7 @@
 #include "qemu/memalign.h"
 #include "hw/scsi/scsi.h"
 #include "scsi/constants.h"
-#include "sysemu/block-backend.h"
+#include "system/block-backend.h"
 #include "qemu/cutils.h"
 #include "trace.h"
 #include "ufs.h"
diff --git a/hw/usb/bus-stub.c b/hw/usb/bus-stub.c
index fcabe8429e6..cd0c317b718 100644
--- a/hw/usb/bus-stub.c
+++ b/hw/usb/bus-stub.c
@@ -10,7 +10,7 @@
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-machine.h"
-#include "sysemu/sysemu.h"
+#include "system/system.h"
 #include "monitor/monitor.h"
 #include "hw/usb.h"
 
diff --git a/hw/usb/bus.c b/hw/usb/bus.c
index 80e6a928202..8277efb98d0 100644
--- a/hw/usb/bus.c
+++ b/hw/usb/bus.c
@@ -6,7 +6,7 @@
 #include "qapi/type-helpers.h"
 #include "qemu/error-report.h"
 #include "qemu/module.h"
-#include "sysemu/sysemu.h"
+#include "system/system.h"
 #include "migration/vmstate.h"
 #include "monitor/monitor.h"
 #include "trace.h"
diff --git a/hw/usb/dev-network.c b/hw/usb/dev-network.c
index 6c4f5776d48..39e8905f0ea 100644
--- a/hw/usb/dev-network.c
+++ b/hw/usb/dev-network.c
@@ -33,7 +33,7 @@
 #include "qemu/error-report.h"
 #include "qemu/queue.h"
 #include "qemu/config-file.h"
-#include "sysemu/sysemu.h"
+#include "system/system.h"
 #include "qemu/iov.h"
 #include "qemu/module.h"
 #include "qemu/cutils.h"
diff --git a/hw/usb/dev-storage-classic.c b/hw/usb/dev-storage-classic.c
index ca037ba96f9..9e54006c60c 100644
--- a/hw/usb/dev-storage-classic.c
+++ b/hw/usb/dev-storage-classic.c
@@ -13,8 +13,8 @@
 #include "hw/usb.h"
 #include "hw/usb/desc.h"
 #include "hw/usb/msd.h"
-#include "sysemu/sysemu.h"
-#include "sysemu/block-backend.h"
+#include "system/system.h"
+#include "system/block-backend.h"
 
 static const struct SCSIBusInfo usb_msd_scsi_info_storage = {
     .tcq = false,
diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c
index 01864d46499..6c4c14c8959 100644
--- a/hw/usb/hcd-ehci.c
+++ b/hw/usb/hcd-ehci.c
@@ -35,7 +35,7 @@
 #include "trace.h"
 #include "qemu/error-report.h"
 #include "qemu/main-loop.h"
-#include "sysemu/runstate.h"
+#include "system/runstate.h"
 
 #define FRAME_TIMER_FREQ 1000
 #define FRAME_TIMER_NS   (NANOSECONDS_PER_SECOND / FRAME_TIMER_FREQ)
diff --git a/hw/usb/hcd-uhci.c b/hw/usb/hcd-uhci.c
index 245352c2317..b6e6316a659 100644
--- a/hw/usb/hcd-uhci.c
+++ b/hw/usb/hcd-uhci.c
@@ -36,7 +36,7 @@
 #include "qapi/error.h"
 #include "qemu/timer.h"
 #include "qemu/iov.h"
-#include "sysemu/dma.h"
+#include "system/dma.h"
 #include "trace.h"
 #include "qemu/main-loop.h"
 #include "qemu/module.h"
diff --git a/hw/usb/host-libusb.c b/hw/usb/host-libusb.c
index 85d33b51bab..7d716ef0bc3 100644
--- a/hw/usb/host-libusb.c
+++ b/hw/usb/host-libusb.c
@@ -51,8 +51,8 @@
 #include "qemu/error-report.h"
 #include "qemu/main-loop.h"
 #include "qemu/module.h"
-#include "sysemu/runstate.h"
-#include "sysemu/sysemu.h"
+#include "system/runstate.h"
+#include "system/system.h"
 #include "trace.h"
 
 #include "hw/qdev-properties.h"
diff --git a/hw/usb/libhw.c b/hw/usb/libhw.c
index f350eae443d..4f03ef4ba9a 100644
--- a/hw/usb/libhw.c
+++ b/hw/usb/libhw.c
@@ -21,7 +21,7 @@
  */
 #include "qemu/osdep.h"
 #include "hw/usb.h"
-#include "sysemu/dma.h"
+#include "system/dma.h"
 
 int usb_packet_map(USBPacket *p, QEMUSGList *sgl)
 {
diff --git a/hw/usb/redirect.c b/hw/usb/redirect.c
index f72a612d5a2..39000740e61 100644
--- a/hw/usb/redirect.c
+++ b/hw/usb/redirect.c
@@ -30,8 +30,8 @@
 #include "qemu/units.h"
 #include "qapi/error.h"
 #include "qemu/timer.h"
-#include "sysemu/runstate.h"
-#include "sysemu/sysemu.h"
+#include "system/runstate.h"
+#include "system/system.h"
 #include "qapi/qmp/qerror.h"
 #include "qemu/error-report.h"
 #include "qemu/iov.h"
diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
index 2e6ea2dd931..6dff88e6309 100644
--- a/hw/vfio/ap.c
+++ b/hw/vfio/ap.c
@@ -16,7 +16,7 @@
 #include <sys/ioctl.h>
 #include "qapi/error.h"
 #include "hw/vfio/vfio-common.h"
-#include "sysemu/iommufd.h"
+#include "system/iommufd.h"
 #include "hw/s390x/ap-device.h"
 #include "qemu/error-report.h"
 #include "qemu/event_notifier.h"
diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
index b96ab27e129..87b58d8f669 100644
--- a/hw/vfio/ccw.c
+++ b/hw/vfio/ccw.c
@@ -22,7 +22,7 @@
 
 #include "qapi/error.h"
 #include "hw/vfio/vfio-common.h"
-#include "sysemu/iommufd.h"
+#include "system/iommufd.h"
 #include "hw/s390x/s390-ccw.h"
 #include "hw/s390x/vfio-ccw.h"
 #include "hw/qdev-properties.h"
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index dcef44fe55b..598272f4dd2 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -34,15 +34,15 @@
 #include "qemu/error-report.h"
 #include "qemu/main-loop.h"
 #include "qemu/range.h"
-#include "sysemu/kvm.h"
-#include "sysemu/reset.h"
-#include "sysemu/runstate.h"
+#include "system/kvm.h"
+#include "system/reset.h"
+#include "system/runstate.h"
 #include "trace.h"
 #include "qapi/error.h"
 #include "migration/misc.h"
 #include "migration/blocker.h"
 #include "migration/qemu-file.h"
-#include "sysemu/tpm.h"
+#include "system/tpm.h"
 
 VFIODeviceList vfio_device_list =
     QLIST_HEAD_INITIALIZER(vfio_device_list);
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 9ccdb639ac8..78a3c2d55fc 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -28,7 +28,7 @@
 #include "exec/ram_addr.h"
 #include "qemu/error-report.h"
 #include "qemu/range.h"
-#include "sysemu/reset.h"
+#include "system/reset.h"
 #include "trace.h"
 #include "qapi/error.h"
 #include "pci.h"
diff --git a/hw/vfio/cpr.c b/hw/vfio/cpr.c
index 87e51fcee17..3d1c8d290a5 100644
--- a/hw/vfio/cpr.c
+++ b/hw/vfio/cpr.c
@@ -9,7 +9,7 @@
 #include "hw/vfio/vfio-common.h"
 #include "migration/misc.h"
 #include "qapi/error.h"
-#include "sysemu/runstate.h"
+#include "system/runstate.h"
 
 static int vfio_cpr_reboot_notifier(NotifierWithReturn *notifier,
                                     MigrationEvent *e, Error **errp)
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index e7bece4ea10..3490a8f1eb8 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -19,9 +19,9 @@
 #include "qemu/error-report.h"
 #include "trace.h"
 #include "qapi/error.h"
-#include "sysemu/iommufd.h"
+#include "system/iommufd.h"
 #include "hw/qdev-core.h"
-#include "sysemu/reset.h"
+#include "system/reset.h"
 #include "qemu/cutils.h"
 #include "qemu/chardev_open.h"
 #include "pci.h"
diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 01aa11013e4..adfa752db52 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -15,7 +15,7 @@
 #include <linux/vfio.h>
 #include <sys/ioctl.h>
 
-#include "sysemu/runstate.h"
+#include "system/runstate.h"
 #include "hw/vfio/vfio-common.h"
 #include "migration/misc.h"
 #include "migration/savevm.h"
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 93aca850e31..bd8565c50ea 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -36,14 +36,14 @@
 #include "qemu/module.h"
 #include "qemu/range.h"
 #include "qemu/units.h"
-#include "sysemu/kvm.h"
-#include "sysemu/runstate.h"
+#include "system/kvm.h"
+#include "system/runstate.h"
 #include "pci.h"
 #include "trace.h"
 #include "qapi/error.h"
 #include "migration/blocker.h"
 #include "migration/qemu-file.h"
-#include "sysemu/iommufd.h"
+#include "system/iommufd.h"
 
 #define TYPE_VFIO_PCI_NOHOTPLUG "vfio-pci-nohotplug"
 
diff --git a/hw/vfio/platform.c b/hw/vfio/platform.c
index 766e8a86efd..2e17fb96b2c 100644
--- a/hw/vfio/platform.c
+++ b/hw/vfio/platform.c
@@ -21,7 +21,7 @@
 #include <linux/vfio.h>
 
 #include "hw/vfio/vfio-platform.h"
-#include "sysemu/iommufd.h"
+#include "system/iommufd.h"
 #include "migration/vmstate.h"
 #include "qemu/error-report.h"
 #include "qemu/lockable.h"
@@ -36,7 +36,7 @@
 #include "hw/irq.h"
 #include "hw/platform-bus.h"
 #include "hw/qdev-properties.h"
-#include "sysemu/kvm.h"
+#include "system/kvm.h"
 
 /*
  * Functions used whatever the injection method
diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
index 018bd204819..ad4c499eafe 100644
--- a/hw/vfio/spapr.c
+++ b/hw/vfio/spapr.c
@@ -14,7 +14,7 @@
 #ifdef CONFIG_KVM
 #include <linux/kvm.h>
 #endif
-#include "sysemu/kvm.h"
+#include "system/kvm.h"
 #include "exec/address-spaces.h"
 
 #include "hw/vfio/vfio-common.h"
diff --git a/hw/virtio/vdpa-dev.c b/hw/virtio/vdpa-dev.c
index 61849b3b0e1..78f8feed2b0 100644
--- a/hw/virtio/vdpa-dev.c
+++ b/hw/virtio/vdpa-dev.c
@@ -26,8 +26,8 @@
 #include "hw/virtio/virtio.h"
 #include "hw/virtio/virtio-bus.h"
 #include "hw/virtio/vdpa-dev.h"
-#include "sysemu/sysemu.h"
-#include "sysemu/runstate.h"
+#include "system/system.h"
+#include "system/runstate.h"
 
 static void
 vhost_vdpa_device_dummy_handle_output(VirtIODevice *vdev, VirtQueue *vq)
diff --git a/hw/virtio/vhost-user-fs.c b/hw/virtio/vhost-user-fs.c
index c0462329a58..83201ad2329 100644
--- a/hw/virtio/vhost-user-fs.c
+++ b/hw/virtio/vhost-user-fs.c
@@ -23,7 +23,7 @@
 #include "hw/virtio/vhost.h"
 #include "hw/virtio/vhost-user-fs.h"
 #include "monitor/monitor.h"
-#include "sysemu/sysemu.h"
+#include "system/system.h"
 
 static const int user_feature_bits[] = {
     VIRTIO_F_VERSION_1,
diff --git a/hw/virtio/vhost-user-scsi-pci.c b/hw/virtio/vhost-user-scsi-pci.c
index b2f6451f483..510981b39ba 100644
--- a/hw/virtio/vhost-user-scsi-pci.c
+++ b/hw/virtio/vhost-user-scsi-pci.c
@@ -29,7 +29,7 @@
 #include "hw/pci/msi.h"
 #include "hw/pci/msix.h"
 #include "hw/loader.h"
-#include "sysemu/kvm.h"
+#include "system/kvm.h"
 #include "hw/virtio/virtio-pci.h"
 #include "qom/object.h"
 
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index f170f0b25b7..267b612587a 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -19,13 +19,13 @@
 #include "hw/virtio/virtio-net.h"
 #include "chardev/char-fe.h"
 #include "io/channel-socket.h"
-#include "sysemu/kvm.h"
+#include "system/kvm.h"
 #include "qemu/error-report.h"
 #include "qemu/main-loop.h"
 #include "qemu/uuid.h"
 #include "qemu/sockets.h"
-#include "sysemu/runstate.h"
-#include "sysemu/cryptodev.h"
+#include "system/runstate.h"
+#include "system/cryptodev.h"
 #include "migration/postcopy-ram.h"
 #include "trace.h"
 #include "exec/ramblock.h"
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index c40f48ac4d3..6aa72fd434a 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -26,7 +26,7 @@
 #include "hw/mem/memory-device.h"
 #include "migration/blocker.h"
 #include "migration/qemu-file-types.h"
-#include "sysemu/dma.h"
+#include "system/dma.h"
 #include "trace.h"
 
 /* enabled until disconnected backend stabilizes */
diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index ab2ee304756..e2ce18c2585 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -22,7 +22,7 @@
 #include "hw/mem/pc-dimm.h"
 #include "hw/qdev-properties.h"
 #include "hw/boards.h"
-#include "sysemu/balloon.h"
+#include "system/balloon.h"
 #include "hw/virtio/virtio-balloon.h"
 #include "exec/address-spaces.h"
 #include "qapi/error.h"
diff --git a/hw/virtio/virtio-crypto.c b/hw/virtio/virtio-crypto.c
index 9ae0b02598b..74669145d2f 100644
--- a/hw/virtio/virtio-crypto.c
+++ b/hw/virtio/virtio-crypto.c
@@ -22,7 +22,7 @@
 #include "hw/virtio/virtio-crypto.h"
 #include "hw/qdev-properties.h"
 #include "standard-headers/linux/virtio_ids.h"
-#include "sysemu/cryptodev-vhost.h"
+#include "system/cryptodev-vhost.h"
 
 #define VIRTIO_CRYPTO_VM_VERSION 1
 
diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index 576ad8383f8..3d645a53392 100644
--- a/hw/virtio/virtio-iommu.c
+++ b/hw/virtio/virtio-iommu.c
@@ -25,9 +25,9 @@
 #include "exec/target_page.h"
 #include "hw/qdev-properties.h"
 #include "hw/virtio/virtio.h"
-#include "sysemu/kvm.h"
-#include "sysemu/reset.h"
-#include "sysemu/sysemu.h"
+#include "system/kvm.h"
+#include "system/reset.h"
+#include "system/system.h"
 #include "qemu/reserved-region.h"
 #include "qemu/units.h"
 #include "qapi/error.h"
diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
index 3f6f46fad77..80362a39f34 100644
--- a/hw/virtio/virtio-mem.c
+++ b/hw/virtio/virtio-mem.c
@@ -15,10 +15,10 @@
 #include "qemu/cutils.h"
 #include "qemu/error-report.h"
 #include "qemu/units.h"
-#include "sysemu/numa.h"
-#include "sysemu/sysemu.h"
-#include "sysemu/reset.h"
-#include "sysemu/runstate.h"
+#include "system/numa.h"
+#include "system/system.h"
+#include "system/reset.h"
+#include "system/runstate.h"
 #include "hw/virtio/virtio.h"
 #include "hw/virtio/virtio-bus.h"
 #include "hw/virtio/virtio-mem.h"
diff --git a/hw/virtio/virtio-mmio.c b/hw/virtio/virtio-mmio.c
index 49d9fe8f302..0bcb9a6fafc 100644
--- a/hw/virtio/virtio-mmio.c
+++ b/hw/virtio/virtio-mmio.c
@@ -28,8 +28,8 @@
 #include "migration/qemu-file-types.h"
 #include "qemu/host-utils.h"
 #include "qemu/module.h"
-#include "sysemu/kvm.h"
-#include "sysemu/replay.h"
+#include "system/kvm.h"
+#include "system/replay.h"
 #include "hw/virtio/virtio-mmio.h"
 #include "qemu/error-report.h"
 #include "qemu/log.h"
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index de41cb5ef22..ce2927e99bb 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -33,12 +33,12 @@
 #include "hw/pci/msi.h"
 #include "hw/pci/msix.h"
 #include "hw/loader.h"
-#include "sysemu/kvm.h"
+#include "system/kvm.h"
 #include "hw/virtio/virtio-pci.h"
 #include "qemu/range.h"
 #include "hw/virtio/virtio-bus.h"
 #include "qapi/visitor.h"
-#include "sysemu/replay.h"
+#include "system/replay.h"
 #include "trace.h"
 
 #define VIRTIO_PCI_REGION_SIZE(dev)     VIRTIO_PCI_CONFIG_OFF(msix_present(dev))
diff --git a/hw/virtio/virtio-pmem.c b/hw/virtio/virtio-pmem.c
index f6f3b5ddaf5..4583e3ffe3d 100644
--- a/hw/virtio/virtio-pmem.c
+++ b/hw/virtio/virtio-pmem.c
@@ -21,7 +21,7 @@
 #include "hw/virtio/virtio-access.h"
 #include "standard-headers/linux/virtio_ids.h"
 #include "standard-headers/linux/virtio_pmem.h"
-#include "sysemu/hostmem.h"
+#include "system/hostmem.h"
 #include "block/aio.h"
 #include "block/thread-pool.h"
 #include "trace.h"
diff --git a/hw/virtio/virtio-rng.c b/hw/virtio/virtio-rng.c
index 13a1a0b236a..a551c4c3a37 100644
--- a/hw/virtio/virtio-rng.c
+++ b/hw/virtio/virtio-rng.c
@@ -17,8 +17,8 @@
 #include "hw/virtio/virtio.h"
 #include "hw/qdev-properties.h"
 #include "hw/virtio/virtio-rng.h"
-#include "sysemu/rng.h"
-#include "sysemu/runstate.h"
+#include "system/rng.h"
+#include "system/runstate.h"
 #include "qom/object_interfaces.h"
 #include "trace.h"
 
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 7fcdb55ba49..f290c8ce7bb 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -30,8 +30,8 @@
 #include "hw/virtio/virtio-bus.h"
 #include "hw/qdev-properties.h"
 #include "hw/virtio/virtio-access.h"
-#include "sysemu/dma.h"
-#include "sysemu/runstate.h"
+#include "system/dma.h"
+#include "system/runstate.h"
 #include "virtio-qmp.h"
 
 #include "standard-headers/linux/virtio_ids.h"
diff --git a/hw/watchdog/allwinner-wdt.c b/hw/watchdog/allwinner-wdt.c
index d35711c7c5b..1bfec41ff8b 100644
--- a/hw/watchdog/allwinner-wdt.c
+++ b/hw/watchdog/allwinner-wdt.c
@@ -28,7 +28,7 @@
 #include "hw/sysbus.h"
 #include "hw/registerfields.h"
 #include "hw/watchdog/allwinner-wdt.h"
-#include "sysemu/watchdog.h"
+#include "system/watchdog.h"
 #include "migration/vmstate.h"
 
 /* WDT registers */
diff --git a/hw/watchdog/cmsdk-apb-watchdog.c b/hw/watchdog/cmsdk-apb-watchdog.c
index ed5ff4257c1..a52121dc44f 100644
--- a/hw/watchdog/cmsdk-apb-watchdog.c
+++ b/hw/watchdog/cmsdk-apb-watchdog.c
@@ -25,7 +25,7 @@
 #include "trace.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
-#include "sysemu/watchdog.h"
+#include "system/watchdog.h"
 #include "hw/sysbus.h"
 #include "hw/irq.h"
 #include "hw/qdev-properties.h"
diff --git a/hw/watchdog/sbsa_gwdt.c b/hw/watchdog/sbsa_gwdt.c
index 2e25d4b4e9a..dd7e2a4708c 100644
--- a/hw/watchdog/sbsa_gwdt.c
+++ b/hw/watchdog/sbsa_gwdt.c
@@ -16,8 +16,8 @@
  */
 
 #include "qemu/osdep.h"
-#include "sysemu/reset.h"
-#include "sysemu/watchdog.h"
+#include "system/reset.h"
+#include "system/watchdog.h"
 #include "hw/qdev-properties.h"
 #include "hw/watchdog/sbsa_gwdt.h"
 #include "qemu/timer.h"
diff --git a/hw/watchdog/watchdog.c b/hw/watchdog/watchdog.c
index d0ce3c4ac55..07213739488 100644
--- a/hw/watchdog/watchdog.c
+++ b/hw/watchdog/watchdog.c
@@ -26,8 +26,8 @@
 #include "qapi/error.h"
 #include "qapi/qapi-commands-run-state.h"
 #include "qapi/qapi-events-run-state.h"
-#include "sysemu/runstate.h"
-#include "sysemu/watchdog.h"
+#include "system/runstate.h"
+#include "system/watchdog.h"
 #include "hw/nmi.h"
 #include "qemu/help_option.h"
 #include "trace.h"
diff --git a/hw/watchdog/wdt_aspeed.c b/hw/watchdog/wdt_aspeed.c
index c95877e5c73..9b86772cc14 100644
--- a/hw/watchdog/wdt_aspeed.c
+++ b/hw/watchdog/wdt_aspeed.c
@@ -13,7 +13,7 @@
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "qemu/timer.h"
-#include "sysemu/watchdog.h"
+#include "system/watchdog.h"
 #include "hw/qdev-properties.h"
 #include "hw/sysbus.h"
 #include "hw/watchdog/wdt_aspeed.h"
diff --git a/hw/watchdog/wdt_diag288.c b/hw/watchdog/wdt_diag288.c
index 040d20fde76..39f2894f216 100644
--- a/hw/watchdog/wdt_diag288.c
+++ b/hw/watchdog/wdt_diag288.c
@@ -12,8 +12,8 @@
  */
 
 #include "qemu/osdep.h"
-#include "sysemu/reset.h"
-#include "sysemu/watchdog.h"
+#include "system/reset.h"
+#include "system/watchdog.h"
 #include "qemu/timer.h"
 #include "hw/watchdog/wdt_diag288.h"
 #include "migration/vmstate.h"
diff --git a/hw/watchdog/wdt_i6300esb.c b/hw/watchdog/wdt_i6300esb.c
index 9427abfb49e..aa1d0866c89 100644
--- a/hw/watchdog/wdt_i6300esb.c
+++ b/hw/watchdog/wdt_i6300esb.c
@@ -23,7 +23,7 @@
 
 #include "qemu/module.h"
 #include "qemu/timer.h"
-#include "sysemu/watchdog.h"
+#include "system/watchdog.h"
 #include "hw/pci/pci_device.h"
 #include "migration/vmstate.h"
 #include "qom/object.h"
diff --git a/hw/watchdog/wdt_ib700.c b/hw/watchdog/wdt_ib700.c
index 17c82897bf3..23519e058e3 100644
--- a/hw/watchdog/wdt_ib700.c
+++ b/hw/watchdog/wdt_ib700.c
@@ -22,7 +22,7 @@
 #include "qemu/osdep.h"
 #include "qemu/module.h"
 #include "qemu/timer.h"
-#include "sysemu/watchdog.h"
+#include "system/watchdog.h"
 #include "hw/isa/isa.h"
 #include "migration/vmstate.h"
 #include "qom/object.h"
diff --git a/hw/watchdog/wdt_imx2.c b/hw/watchdog/wdt_imx2.c
index 61fbd91ee4f..3a4c15d1a43 100644
--- a/hw/watchdog/wdt_imx2.c
+++ b/hw/watchdog/wdt_imx2.c
@@ -12,7 +12,7 @@
 #include "qemu/osdep.h"
 #include "qemu/bitops.h"
 #include "qemu/module.h"
-#include "sysemu/watchdog.h"
+#include "system/watchdog.h"
 #include "migration/vmstate.h"
 #include "hw/qdev-properties.h"
 
diff --git a/hw/xen/xen-bus.c b/hw/xen/xen-bus.c
index 0d7defb8cd3..7919f8ef796 100644
--- a/hw/xen/xen-bus.c
+++ b/hw/xen/xen-bus.c
@@ -19,7 +19,7 @@
 #include "monitor/monitor.h"
 #include "qapi/error.h"
 #include "qapi/qmp/qdict.h"
-#include "sysemu/sysemu.h"
+#include "system/system.h"
 #include "net/net.h"
 #include "trace.h"
 
diff --git a/hw/xen/xen-mapcache.c b/hw/xen/xen-mapcache.c
index 18ba7b1d8f5..00bfbcc6fb0 100644
--- a/hw/xen/xen-mapcache.c
+++ b/hw/xen/xen-mapcache.c
@@ -18,8 +18,8 @@
 #include "hw/xen/xen_native.h"
 #include "qemu/bitmap.h"
 
-#include "sysemu/runstate.h"
-#include "sysemu/xen-mapcache.h"
+#include "system/runstate.h"
+#include "system/xen-mapcache.h"
 #include "trace.h"
 
 #include <xenevtchn.h>
diff --git a/hw/xen/xen-pvh-common.c b/hw/xen/xen-pvh-common.c
index 218ac851cf7..a10c44cc758 100644
--- a/hw/xen/xen-pvh-common.c
+++ b/hw/xen/xen-pvh-common.c
@@ -13,9 +13,9 @@
 #include "hw/boards.h"
 #include "hw/irq.h"
 #include "hw/sysbus.h"
-#include "sysemu/sysemu.h"
-#include "sysemu/tpm.h"
-#include "sysemu/tpm_backend.h"
+#include "system/system.h"
+#include "system/tpm.h"
+#include "system/tpm_backend.h"
 #include "hw/xen/xen-pvh-common.h"
 #include "trace.h"
 
diff --git a/hw/xen/xen_devconfig.c b/hw/xen/xen_devconfig.c
index 45ae134b846..5698cc7c0eb 100644
--- a/hw/xen/xen_devconfig.c
+++ b/hw/xen/xen_devconfig.c
@@ -1,8 +1,8 @@
 #include "qemu/osdep.h"
 #include "hw/xen/xen-legacy-backend.h"
 #include "qemu/option.h"
-#include "sysemu/blockdev.h"
-#include "sysemu/sysemu.h"
+#include "system/blockdev.h"
+#include "system/system.h"
 
 /* ------------------------------------------------------------- */
 
diff --git a/hw/xenpv/xen_machine_pv.c b/hw/xenpv/xen_machine_pv.c
index 24395f42cbb..99c02492ef9 100644
--- a/hw/xenpv/xen_machine_pv.c
+++ b/hw/xenpv/xen_machine_pv.c
@@ -27,8 +27,8 @@
 #include "hw/boards.h"
 #include "hw/xen/xen-legacy-backend.h"
 #include "hw/xen/xen-bus.h"
-#include "sysemu/block-backend.h"
-#include "sysemu/sysemu.h"
+#include "system/block-backend.h"
+#include "system/system.h"
 
 static void xen_init_pv(MachineState *machine)
 {
diff --git a/hw/xtensa/sim.c b/hw/xtensa/sim.c
index 2160e619645..0a1fd900376 100644
--- a/hw/xtensa/sim.c
+++ b/hw/xtensa/sim.c
@@ -27,8 +27,8 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "sysemu/reset.h"
-#include "sysemu/sysemu.h"
+#include "system/reset.h"
+#include "system/system.h"
 #include "hw/boards.h"
 #include "hw/loader.h"
 #include "elf.h"
diff --git a/hw/xtensa/virt.c b/hw/xtensa/virt.c
index 5310a888613..98622ae86dc 100644
--- a/hw/xtensa/virt.c
+++ b/hw/xtensa/virt.c
@@ -27,7 +27,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "sysemu/reset.h"
+#include "system/reset.h"
 #include "hw/boards.h"
 #include "hw/loader.h"
 #include "hw/pci-host/gpex.h"
diff --git a/hw/xtensa/xtfpga.c b/hw/xtensa/xtfpga.c
index 2e264c61988..9efe91933f9 100644
--- a/hw/xtensa/xtfpga.c
+++ b/hw/xtensa/xtfpga.c
@@ -29,7 +29,7 @@
 #include "qemu/units.h"
 #include "qapi/error.h"
 #include "cpu.h"
-#include "sysemu/sysemu.h"
+#include "system/system.h"
 #include "hw/boards.h"
 #include "hw/loader.h"
 #include "hw/qdev-properties.h"
@@ -41,9 +41,9 @@
 #include "hw/sysbus.h"
 #include "hw/block/flash.h"
 #include "chardev/char.h"
-#include "sysemu/device_tree.h"
-#include "sysemu/reset.h"
-#include "sysemu/runstate.h"
+#include "system/device_tree.h"
+#include "system/reset.h"
+#include "system/runstate.h"
 #include "qemu/error-report.h"
 #include "qemu/option.h"
 #include "bootparam.h"
diff --git a/iothread.c b/iothread.c
index e1e9e047365..589bcd35523 100644
--- a/iothread.c
+++ b/iothread.c
@@ -17,8 +17,8 @@
 #include "qemu/module.h"
 #include "block/aio.h"
 #include "block/block.h"
-#include "sysemu/event-loop-base.h"
-#include "sysemu/iothread.h"
+#include "system/event-loop-base.h"
+#include "system/iothread.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-misc.h"
 #include "qemu/error-report.h"
diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
index a7d55048c23..f2c352d4a71 100644
--- a/migration/block-dirty-bitmap.c
+++ b/migration/block-dirty-bitmap.c
@@ -62,8 +62,8 @@
 #include "block/block.h"
 #include "block/block_int.h"
 #include "block/dirty-bitmap.h"
-#include "sysemu/block-backend.h"
-#include "sysemu/runstate.h"
+#include "system/block-backend.h"
+#include "system/runstate.h"
 #include "qemu/main-loop.h"
 #include "qemu/error-report.h"
 #include "migration/misc.h"
diff --git a/migration/colo.c b/migration/colo.c
index 9590f281d0f..afc98690200 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -11,7 +11,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "sysemu/sysemu.h"
+#include "system/system.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-migration.h"
 #include "migration.h"
@@ -30,8 +30,8 @@
 #include "net/colo.h"
 #include "block/block.h"
 #include "qapi/qapi-events-migration.h"
-#include "sysemu/cpus.h"
-#include "sysemu/runstate.h"
+#include "system/cpus.h"
+#include "system/runstate.h"
 #include "net/filter.h"
 #include "options.h"
 
diff --git a/migration/cpu-throttle.c b/migration/cpu-throttle.c
index 5179019e33b..0642e6bdeaf 100644
--- a/migration/cpu-throttle.c
+++ b/migration/cpu-throttle.c
@@ -26,8 +26,8 @@
 #include "qemu/thread.h"
 #include "hw/core/cpu.h"
 #include "qemu/main-loop.h"
-#include "sysemu/cpus.h"
-#include "sysemu/cpu-throttle.h"
+#include "system/cpus.h"
+#include "system/cpu-throttle.h"
 #include "migration.h"
 #include "migration-stats.h"
 #include "trace.h"
diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
index f7e86686fc7..7c955894e47 100644
--- a/migration/dirtyrate.c
+++ b/migration/dirtyrate.c
@@ -25,8 +25,8 @@
 #include "monitor/hmp.h"
 #include "monitor/monitor.h"
 #include "qapi/qmp/qdict.h"
-#include "sysemu/kvm.h"
-#include "sysemu/runstate.h"
+#include "system/kvm.h"
+#include "system/runstate.h"
 #include "exec/memory.h"
 #include "qemu/xxhash.h"
 #include "migration.h"
diff --git a/migration/global_state.c b/migration/global_state.c
index 3a9796cae28..c1f90fce0f9 100644
--- a/migration/global_state.c
+++ b/migration/global_state.c
@@ -13,7 +13,7 @@
 #include "qemu/osdep.h"
 #include "qemu/cutils.h"
 #include "qemu/error-report.h"
-#include "sysemu/runstate.h"
+#include "system/runstate.h"
 #include "qapi/error.h"
 #include "migration.h"
 #include "migration/global_state.h"
diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index 20d1a6e2194..e8527bef801 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -27,9 +27,9 @@
 #include "qemu/cutils.h"
 #include "qemu/error-report.h"
 #include "qemu/sockets.h"
-#include "sysemu/runstate.h"
+#include "system/runstate.h"
 #include "ui/qemu-spice.h"
-#include "sysemu/sysemu.h"
+#include "system/system.h"
 #include "options.h"
 #include "migration.h"
 
diff --git a/migration/migration.c b/migration/migration.c
index 8c5bd0a75c8..b3e51566439 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -22,9 +22,9 @@
 #include "fd.h"
 #include "file.h"
 #include "socket.h"
-#include "sysemu/runstate.h"
-#include "sysemu/sysemu.h"
-#include "sysemu/cpu-throttle.h"
+#include "system/runstate.h"
+#include "system/system.h"
+#include "system/cpu-throttle.h"
 #include "rdma.h"
 #include "ram.h"
 #include "migration/global_state.h"
@@ -59,13 +59,13 @@
 #include "multifd.h"
 #include "threadinfo.h"
 #include "qemu/yank.h"
-#include "sysemu/cpus.h"
+#include "system/cpus.h"
 #include "yank_functions.h"
-#include "sysemu/qtest.h"
+#include "system/qtest.h"
 #include "options.h"
-#include "sysemu/dirtylimit.h"
+#include "system/dirtylimit.h"
 #include "qemu/sockets.h"
-#include "sysemu/kvm.h"
+#include "system/kvm.h"
 
 #define NOTIFIER_ELEM_INIT(array, elem)    \
     [elem] = NOTIFIER_WITH_RETURN_LIST_INITIALIZER((array)[elem])
diff --git a/migration/multifd.c b/migration/multifd.c
index 498e71fd102..4f973d70e0c 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -14,7 +14,7 @@
 #include "qemu/cutils.h"
 #include "qemu/rcu.h"
 #include "exec/target_page.h"
-#include "sysemu/sysemu.h"
+#include "system/system.h"
 #include "exec/ramblock.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
diff --git a/migration/options.c b/migration/options.c
index ad8d6989a80..daac3c45140 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -20,7 +20,7 @@
 #include "qapi/qapi-visit-migration.h"
 #include "qapi/qmp/qerror.h"
 #include "qapi/qmp/qnull.h"
-#include "sysemu/runstate.h"
+#include "system/runstate.h"
 #include "migration/colo.h"
 #include "migration/misc.h"
 #include "migration.h"
@@ -28,7 +28,7 @@
 #include "qemu-file.h"
 #include "ram.h"
 #include "options.h"
-#include "sysemu/kvm.h"
+#include "system/kvm.h"
 
 /* Maximum migrate downtime set to 2000 seconds */
 #define MAX_MIGRATE_DOWNTIME_SECONDS 2000
diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index a535fd2e30c..6a6da6ba7f3 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -27,7 +27,7 @@
 #include "qapi/error.h"
 #include "qemu/notify.h"
 #include "qemu/rcu.h"
-#include "sysemu/sysemu.h"
+#include "system/system.h"
 #include "qemu/error-report.h"
 #include "trace.h"
 #include "hw/boards.h"
diff --git a/migration/ram.c b/migration/ram.c
index 05ff9eb3287..a60666d3f6e 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -52,15 +52,15 @@
 #include "exec/target_page.h"
 #include "qemu/rcu_queue.h"
 #include "migration/colo.h"
-#include "sysemu/cpu-throttle.h"
+#include "system/cpu-throttle.h"
 #include "savevm.h"
 #include "qemu/iov.h"
 #include "multifd.h"
-#include "sysemu/runstate.h"
+#include "system/runstate.h"
 #include "rdma.h"
 #include "options.h"
-#include "sysemu/dirtylimit.h"
-#include "sysemu/kvm.h"
+#include "system/dirtylimit.h"
+#include "system/kvm.h"
 
 #include "hw/boards.h" /* for machine_dump_guest_core() */
 
diff --git a/migration/savevm.c b/migration/savevm.c
index 98821c81207..927b1146c0d 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -46,7 +46,7 @@
 #include "qapi/clone-visitor.h"
 #include "qapi/qapi-builtin-visit.h"
 #include "qemu/error-report.h"
-#include "sysemu/cpus.h"
+#include "system/cpus.h"
 #include "exec/memory.h"
 #include "exec/target_page.h"
 #include "trace.h"
@@ -57,16 +57,16 @@
 #include "qemu/cutils.h"
 #include "io/channel-buffer.h"
 #include "io/channel-file.h"
-#include "sysemu/replay.h"
-#include "sysemu/runstate.h"
-#include "sysemu/sysemu.h"
-#include "sysemu/xen.h"
+#include "system/replay.h"
+#include "system/runstate.h"
+#include "system/system.h"
+#include "system/xen.h"
 #include "migration/colo.h"
 #include "qemu/bitmap.h"
 #include "net/announce.h"
 #include "qemu/yank.h"
 #include "yank_functions.h"
-#include "sysemu/qtest.h"
+#include "system/qtest.h"
 #include "options.h"
 
 const unsigned int postcopy_ram_discard_version;
diff --git a/monitor/fds.c b/monitor/fds.c
index b5416b5b5dc..cc35d2ec334 100644
--- a/monitor/fds.c
+++ b/monitor/fds.c
@@ -29,7 +29,7 @@
 #include "qapi/qmp/qerror.h"
 #include "qemu/ctype.h"
 #include "qemu/cutils.h"
-#include "sysemu/runstate.h"
+#include "system/runstate.h"
 
 /* file descriptors passed via SCM_RIGHTS */
 typedef struct mon_fd_t mon_fd_t;
diff --git a/monitor/hmp-cmds-target.c b/monitor/hmp-cmds-target.c
index ff01cf9d8db..0300faa8a28 100644
--- a/monitor/hmp-cmds-target.c
+++ b/monitor/hmp-cmds-target.c
@@ -30,7 +30,7 @@
 #include "monitor/monitor-internal.h"
 #include "qapi/error.h"
 #include "qapi/qmp/qdict.h"
-#include "sysemu/hw_accel.h"
+#include "system/hw_accel.h"
 
 /* Set the current CPU defined by the user. Callers must hold BQL. */
 int monitor_set_cpu(Monitor *mon, int cpu_index)
diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index f601d06ab89..80b2e5ff9fd 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -28,7 +28,7 @@
 #include "qapi/qmp/qdict.h"
 #include "qemu/cutils.h"
 #include "qemu/log.h"
-#include "sysemu/sysemu.h"
+#include "system/system.h"
 
 bool hmp_handle_error(Monitor *mon, Error *err)
 {
diff --git a/monitor/hmp-target.c b/monitor/hmp-target.c
index 1eb72ac1bf5..37dfd7fd4c6 100644
--- a/monitor/hmp-target.c
+++ b/monitor/hmp-target.c
@@ -26,7 +26,7 @@
 #include "monitor-internal.h"
 #include "monitor/qdev.h"
 #include "net/slirp.h"
-#include "sysemu/device_tree.h"
+#include "system/device_tree.h"
 #include "monitor/hmp-target.h"
 #include "monitor/hmp.h"
 #include "block/block-hmp-cmds.h"
diff --git a/monitor/hmp.c b/monitor/hmp.c
index 460e8832f69..db903605534 100644
--- a/monitor/hmp.c
+++ b/monitor/hmp.c
@@ -35,7 +35,7 @@
 #include "qemu/log.h"
 #include "qemu/option.h"
 #include "qemu/units.h"
-#include "sysemu/block-backend.h"
+#include "system/block-backend.h"
 #include "trace.h"
 
 static void monitor_command_cb(void *opaque, const char *cmdline,
diff --git a/monitor/monitor.c b/monitor/monitor.c
index 56786c0ccc7..9fad61f9df5 100644
--- a/monitor/monitor.c
+++ b/monitor/monitor.c
@@ -31,7 +31,7 @@
 #include "qapi/qmp/qdict.h"
 #include "qemu/error-report.h"
 #include "qemu/option.h"
-#include "sysemu/qtest.h"
+#include "system/qtest.h"
 #include "trace.h"
 
 /*
diff --git a/monitor/qmp-cmds-control.c b/monitor/qmp-cmds-control.c
index f21506efa58..150ca9f5cb6 100644
--- a/monitor/qmp-cmds-control.c
+++ b/monitor/qmp-cmds-control.c
@@ -1,5 +1,5 @@
 /*
- * QMP commands related to the monitor (common to sysemu and tools)
+ * QMP commands related to the monitor (common to system and tools)
  *
  * Copyright (c) 2003-2004 Fabrice Bellard
  *
diff --git a/monitor/qmp-cmds.c b/monitor/qmp-cmds.c
index f84a0dc523f..34f215097cc 100644
--- a/monitor/qmp-cmds.c
+++ b/monitor/qmp-cmds.c
@@ -18,11 +18,11 @@
 #include "monitor-internal.h"
 #include "monitor/qdev.h"
 #include "monitor/qmp-helpers.h"
-#include "sysemu/sysemu.h"
-#include "sysemu/kvm.h"
-#include "sysemu/runstate.h"
-#include "sysemu/runstate-action.h"
-#include "sysemu/block-backend.h"
+#include "system/system.h"
+#include "system/kvm.h"
+#include "system/runstate.h"
+#include "system/runstate-action.h"
+#include "system/block-backend.h"
 #include "qapi/error.h"
 #include "qapi/qapi-init-commands.h"
 #include "qapi/qapi-commands-control.h"
diff --git a/net/colo-compare.c b/net/colo-compare.c
index 39f90c40652..165610bfe24 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -25,7 +25,7 @@
 #include "chardev/char-fe.h"
 #include "qemu/sockets.h"
 #include "colo.h"
-#include "sysemu/iothread.h"
+#include "system/iothread.h"
 #include "net/colo-compare.h"
 #include "migration/colo.h"
 #include "util.h"
diff --git a/net/dump.c b/net/dump.c
index 956e34a123c..d7dd2ce461d 100644
--- a/net/dump.c
+++ b/net/dump.c
@@ -32,7 +32,7 @@
 #include "qapi/visitor.h"
 #include "net/filter.h"
 #include "qom/object.h"
-#include "sysemu/rtc.h"
+#include "system/rtc.h"
 
 typedef struct DumpState {
     int64_t start_ts;
diff --git a/net/filter-replay.c b/net/filter-replay.c
index 54690676ef0..81b71afe357 100644
--- a/net/filter-replay.c
+++ b/net/filter-replay.c
@@ -17,7 +17,7 @@
 #include "qemu/timer.h"
 #include "qapi/visitor.h"
 #include "net/filter.h"
-#include "sysemu/replay.h"
+#include "system/replay.h"
 #include "qom/object.h"
 
 #define TYPE_FILTER_REPLAY "filter-replay"
diff --git a/net/hub.c b/net/hub.c
index 496a3d3b4be..cba20ebd874 100644
--- a/net/hub.c
+++ b/net/hub.c
@@ -20,7 +20,7 @@
 #include "hub.h"
 #include "qemu/iov.h"
 #include "qemu/error-report.h"
-#include "sysemu/qtest.h"
+#include "system/qtest.h"
 
 /*
  * A hub broadcasts incoming packets to all its ports except the source port.
diff --git a/net/net.c b/net/net.c
index 7ef6885876f..c1bb19a5237 100644
--- a/net/net.c
+++ b/net/net.c
@@ -51,7 +51,7 @@
 #include "qemu/keyval.h"
 #include "qapi/error.h"
 #include "qapi/opts-visitor.h"
-#include "sysemu/runstate.h"
+#include "system/runstate.h"
 #include "net/colo-compare.h"
 #include "net/filter.h"
 #include "qapi/string-output-visitor.h"
diff --git a/net/slirp.c b/net/slirp.c
index eb9a456ed49..49dc62f7767 100644
--- a/net/slirp.c
+++ b/net/slirp.c
@@ -40,7 +40,7 @@
 #include "qemu/sockets.h"
 #include <libslirp.h>
 #include "chardev/char-fe.h"
-#include "sysemu/sysemu.h"
+#include "system/system.h"
 #include "qemu/cutils.h"
 #include "qapi/error.h"
 #include "qapi/qmp/qdict.h"
diff --git a/net/tap.c b/net/tap.c
index 3f90022c0b2..ae1c7e39832 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -36,7 +36,7 @@
 #include "net/net.h"
 #include "clients.h"
 #include "monitor/monitor.h"
-#include "sysemu/sysemu.h"
+#include "system/system.h"
 #include "qapi/error.h"
 #include "qemu/cutils.h"
 #include "qemu/error-report.h"
diff --git a/os-posix.c b/os-posix.c
index 43f9a43f3fe..9cce55ff2f7 100644
--- a/os-posix.c
+++ b/os-posix.c
@@ -32,7 +32,7 @@
 
 #include "qemu/error-report.h"
 #include "qemu/log.h"
-#include "sysemu/runstate.h"
+#include "system/runstate.h"
 #include "qemu/cutils.h"
 
 #ifdef CONFIG_LINUX
diff --git a/os-win32.c b/os-win32.c
index 725ad652e8b..c1bff808b4b 100644
--- a/os-win32.c
+++ b/os-win32.c
@@ -26,7 +26,7 @@
 #include "qemu/osdep.h"
 #include <windows.h>
 #include <mmsystem.h>
-#include "sysemu/runstate.h"
+#include "system/runstate.h"
 
 static BOOL WINAPI qemu_ctrl_handler(DWORD type)
 {
diff --git a/qemu-img.c b/qemu-img.c
index 7668f86769f..2f2fac90e80 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -45,7 +45,7 @@
 #include "qemu/units.h"
 #include "qemu/memalign.h"
 #include "qom/object_interfaces.h"
-#include "sysemu/block-backend.h"
+#include "system/block-backend.h"
 #include "block/block_int.h"
 #include "block/blockjob.h"
 #include "block/dirty-bitmap.h"
diff --git a/qemu-io-cmds.c b/qemu-io-cmds.c
index e2fab571831..bf08dcb8f55 100644
--- a/qemu-io-cmds.c
+++ b/qemu-io-cmds.c
@@ -12,7 +12,7 @@
 #include "qapi/error.h"
 #include "qapi/qmp/qdict.h"
 #include "qemu-io.h"
-#include "sysemu/block-backend.h"
+#include "system/block-backend.h"
 #include "block/block.h"
 #include "block/block_int.h" /* for info_f() */
 #include "block/qapi.h"
diff --git a/qemu-io.c b/qemu-io.c
index 6cb1e00385e..fa04695d1d8 100644
--- a/qemu-io.c
+++ b/qemu-io.c
@@ -30,7 +30,7 @@
 #include "qapi/qmp/qstring.h"
 #include "qapi/qmp/qdict.h"
 #include "qom/object_interfaces.h"
-#include "sysemu/block-backend.h"
+#include "system/block-backend.h"
 #include "block/block_int.h"
 #include "trace/control.h"
 #include "crypto/init.h"
diff --git a/qemu-nbd.c b/qemu-nbd.c
index a186d2e1190..e7a961a5562 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -24,8 +24,8 @@
 #include "qemu/help-texts.h"
 #include "qapi/error.h"
 #include "qemu/cutils.h"
-#include "sysemu/block-backend.h"
-#include "sysemu/runstate.h" /* for qemu_system_killed() prototype */
+#include "system/block-backend.h"
+#include "system/runstate.h" /* for qemu_system_killed() prototype */
 #include "block/block_int.h"
 #include "block/nbd.h"
 #include "qemu/main-loop.h"
diff --git a/replay/replay-audio.c b/replay/replay-audio.c
index 91854f02ea0..ed2ba2164ba 100644
--- a/replay/replay-audio.c
+++ b/replay/replay-audio.c
@@ -11,7 +11,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
-#include "sysemu/replay.h"
+#include "system/replay.h"
 #include "replay-internal.h"
 #include "audio/audio.h"
 
diff --git a/replay/replay-char.c b/replay/replay-char.c
index 72b1f832dde..81dc416e988 100644
--- a/replay/replay-char.c
+++ b/replay/replay-char.c
@@ -11,7 +11,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
-#include "sysemu/replay.h"
+#include "system/replay.h"
 #include "replay-internal.h"
 #include "chardev/char.h"
 
diff --git a/replay/replay-debugging.c b/replay/replay-debugging.c
index 82c66fff262..b672ec3e3f2 100644
--- a/replay/replay-debugging.c
+++ b/replay/replay-debugging.c
@@ -11,8 +11,8 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "sysemu/replay.h"
-#include "sysemu/runstate.h"
+#include "system/replay.h"
+#include "system/runstate.h"
 #include "replay-internal.h"
 #include "monitor/hmp.h"
 #include "monitor/monitor.h"
diff --git a/replay/replay-events.c b/replay/replay-events.c
index 2e46eda6bf8..8959da9f1fa 100644
--- a/replay/replay-events.c
+++ b/replay/replay-events.c
@@ -11,7 +11,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
-#include "sysemu/replay.h"
+#include "system/replay.h"
 #include "replay-internal.h"
 #include "block/aio.h"
 #include "ui/input.h"
diff --git a/replay/replay-input.c b/replay/replay-input.c
index bee3dbe5283..562bbf37175 100644
--- a/replay/replay-input.c
+++ b/replay/replay-input.c
@@ -10,7 +10,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "sysemu/replay.h"
+#include "system/replay.h"
 #include "replay-internal.h"
 #include "qemu/notify.h"
 #include "ui/input.h"
diff --git a/replay/replay-internal.c b/replay/replay-internal.c
index 13fcbdd8f42..c2a7200339f 100644
--- a/replay/replay-internal.c
+++ b/replay/replay-internal.c
@@ -10,8 +10,8 @@
  */
 
 #include "qemu/osdep.h"
-#include "sysemu/replay.h"
-#include "sysemu/runstate.h"
+#include "system/replay.h"
+#include "system/runstate.h"
 #include "replay-internal.h"
 #include "qemu/error-report.h"
 #include "qemu/main-loop.h"
diff --git a/replay/replay-net.c b/replay/replay-net.c
index 3b70f71cf12..d4b197e91e3 100644
--- a/replay/replay-net.c
+++ b/replay/replay-net.c
@@ -11,7 +11,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
-#include "sysemu/replay.h"
+#include "system/replay.h"
 #include "replay-internal.h"
 #include "net/net.h"
 #include "net/filter.h"
diff --git a/replay/replay-random.c b/replay/replay-random.c
index afc7a0fccca..7f4c46f74d9 100644
--- a/replay/replay-random.c
+++ b/replay/replay-random.c
@@ -11,7 +11,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
-#include "sysemu/replay.h"
+#include "system/replay.h"
 #include "replay-internal.h"
 
 void replay_save_random(int ret, void *buf, size_t len)
diff --git a/replay/replay-snapshot.c b/replay/replay-snapshot.c
index ccb4d89dda7..7b7b3269256 100644
--- a/replay/replay-snapshot.c
+++ b/replay/replay-snapshot.c
@@ -11,7 +11,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "sysemu/replay.h"
+#include "system/replay.h"
 #include "replay-internal.h"
 #include "monitor/monitor.h"
 #include "qapi/qmp/qstring.h"
diff --git a/replay/replay-time.c b/replay/replay-time.c
index ee0ebfcf09f..f3d62e11393 100644
--- a/replay/replay-time.c
+++ b/replay/replay-time.c
@@ -10,7 +10,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "sysemu/replay.h"
+#include "system/replay.h"
 #include "replay-internal.h"
 #include "qemu/error-report.h"
 
diff --git a/replay/replay.c b/replay/replay.c
index 895fa6b67a0..3adc387b3d2 100644
--- a/replay/replay.c
+++ b/replay/replay.c
@@ -11,13 +11,13 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "sysemu/cpu-timers.h"
-#include "sysemu/replay.h"
-#include "sysemu/runstate.h"
+#include "system/cpu-timers.h"
+#include "system/replay.h"
+#include "system/runstate.h"
 #include "replay-internal.h"
 #include "qemu/main-loop.h"
 #include "qemu/option.h"
-#include "sysemu/cpus.h"
+#include "system/cpus.h"
 #include "qemu/error-report.h"
 
 /* Current version of the replay mechanism.
diff --git a/replay/stubs-system.c b/replay/stubs-system.c
index 50cefdb2d69..8f2b2d326e7 100644
--- a/replay/stubs-system.c
+++ b/replay/stubs-system.c
@@ -1,5 +1,5 @@
 #include "qemu/osdep.h"
-#include "sysemu/replay.h"
+#include "system/replay.h"
 #include "ui/input.h"
 
 void replay_input_event(QemuConsole *src, InputEvent *evt)
diff --git a/stats/stats-qmp-cmds.c b/stats/stats-qmp-cmds.c
index e214b964fda..884674ee323 100644
--- a/stats/stats-qmp-cmds.c
+++ b/stats/stats-qmp-cmds.c
@@ -6,7 +6,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "sysemu/stats.h"
+#include "system/stats.h"
 #include "qapi/qapi-commands-stats.h"
 #include "qemu/queue.h"
 #include "qapi/error.h"
diff --git a/storage-daemon/qemu-storage-daemon.c b/storage-daemon/qemu-storage-daemon.c
index 0e9354faa65..325966eb9e0 100644
--- a/storage-daemon/qemu-storage-daemon.c
+++ b/storage-daemon/qemu-storage-daemon.c
@@ -58,7 +58,7 @@
 #include "storage-daemon/qapi/qapi-commands.h"
 #include "storage-daemon/qapi/qapi-init-commands.h"
 
-#include "sysemu/runstate.h"
+#include "system/runstate.h"
 #include "trace/control.h"
 
 static const char *pid_file;
diff --git a/stubs/blk-commit-all.c b/stubs/blk-commit-all.c
index e156c57f8d7..76b08275a5c 100644
--- a/stubs/blk-commit-all.c
+++ b/stubs/blk-commit-all.c
@@ -1,5 +1,5 @@
 #include "qemu/osdep.h"
-#include "sysemu/block-backend.h"
+#include "system/block-backend.h"
 
 int blk_commit_all(void)
 {
diff --git a/stubs/change-state-handler.c b/stubs/change-state-handler.c
index d1ed46bfb0f..002d248abf2 100644
--- a/stubs/change-state-handler.c
+++ b/stubs/change-state-handler.c
@@ -1,5 +1,5 @@
 #include "qemu/osdep.h"
-#include "sysemu/runstate.h"
+#include "system/runstate.h"
 
 VMChangeStateEntry *qemu_add_vm_change_state_handler(VMChangeStateHandler *cb,
                                                      void *opaque)
diff --git a/stubs/cpu-get-clock.c b/stubs/cpu-get-clock.c
index 9e924048169..53b9c83d768 100644
--- a/stubs/cpu-get-clock.c
+++ b/stubs/cpu-get-clock.c
@@ -1,5 +1,5 @@
 #include "qemu/osdep.h"
-#include "sysemu/cpu-timers.h"
+#include "system/cpu-timers.h"
 #include "qemu/main-loop.h"
 
 int64_t cpu_get_clock(void)
diff --git a/stubs/cpu-synchronize-state.c b/stubs/cpu-synchronize-state.c
index d9211da66ce..2ed09ff3ed6 100644
--- a/stubs/cpu-synchronize-state.c
+++ b/stubs/cpu-synchronize-state.c
@@ -1,5 +1,5 @@
 #include "qemu/osdep.h"
-#include "sysemu/hw_accel.h"
+#include "system/hw_accel.h"
 
 void cpu_synchronize_state(CPUState *cpu)
 {
diff --git a/stubs/cpus-virtual-clock.c b/stubs/cpus-virtual-clock.c
index af7c1a1d403..0b83a925334 100644
--- a/stubs/cpus-virtual-clock.c
+++ b/stubs/cpus-virtual-clock.c
@@ -1,5 +1,5 @@
 #include "qemu/osdep.h"
-#include "sysemu/cpu-timers.h"
+#include "system/cpu-timers.h"
 #include "qemu/main-loop.h"
 
 int64_t cpus_get_virtual_clock(void)
diff --git a/stubs/dump.c b/stubs/dump.c
index 1f28ec2be3f..df7897b72b1 100644
--- a/stubs/dump.c
+++ b/stubs/dump.c
@@ -12,7 +12,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "sysemu/dump-arch.h"
+#include "system/dump-arch.h"
 
 int cpu_get_dump_info(ArchDumpInfo *info,
                       const struct GuestPhysBlockList *guest_phys_blocks)
diff --git a/stubs/get-vm-name.c b/stubs/get-vm-name.c
index 0906303f730..4cfac484e53 100644
--- a/stubs/get-vm-name.c
+++ b/stubs/get-vm-name.c
@@ -1,5 +1,5 @@
 #include "qemu/osdep.h"
-#include "sysemu/sysemu.h"
+#include "system/system.h"
 
 const char *qemu_get_vm_name(void)
 {
diff --git a/stubs/icount.c b/stubs/icount.c
index 9f9a59f55b9..edbf60cbfa3 100644
--- a/stubs/icount.c
+++ b/stubs/icount.c
@@ -1,6 +1,6 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "sysemu/cpu-timers.h"
+#include "system/cpu-timers.h"
 
 /* icount - Instruction Counter API */
 
diff --git a/stubs/qemu-timer-notify-cb.c b/stubs/qemu-timer-notify-cb.c
index 845e46f8e03..b57b983c6f4 100644
--- a/stubs/qemu-timer-notify-cb.c
+++ b/stubs/qemu-timer-notify-cb.c
@@ -1,5 +1,5 @@
 #include "qemu/osdep.h"
-#include "sysemu/cpu-timers.h"
+#include "system/cpu-timers.h"
 #include "qemu/main-loop.h"
 
 void qemu_timer_notify_cb(void *opaque, QEMUClockType type)
diff --git a/stubs/qtest.c b/stubs/qtest.c
index 39e376eb67d..6c397259274 100644
--- a/stubs/qtest.c
+++ b/stubs/qtest.c
@@ -9,7 +9,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "sysemu/qtest.h"
+#include "system/qtest.h"
 
 /* Needed for qtest_allowed() */
 bool qtest_allowed;
diff --git a/stubs/replay-mode.c b/stubs/replay-mode.c
index 264be9d96c9..439d97e4a87 100644
--- a/stubs/replay-mode.c
+++ b/stubs/replay-mode.c
@@ -1,4 +1,4 @@
 #include "qemu/osdep.h"
-#include "sysemu/replay.h"
+#include "system/replay.h"
 
 ReplayMode replay_mode;
diff --git a/stubs/replay-tools.c b/stubs/replay-tools.c
index 3e8ca3212d9..c537485f401 100644
--- a/stubs/replay-tools.c
+++ b/stubs/replay-tools.c
@@ -1,5 +1,5 @@
 #include "qemu/osdep.h"
-#include "sysemu/replay.h"
+#include "system/replay.h"
 #include "block/aio.h"
 
 bool replay_events_enabled(void)
diff --git a/stubs/runstate-check.c b/stubs/runstate-check.c
index 2ccda2b70fa..c47abdf84b7 100644
--- a/stubs/runstate-check.c
+++ b/stubs/runstate-check.c
@@ -1,6 +1,6 @@
 #include "qemu/osdep.h"
 
-#include "sysemu/runstate.h"
+#include "system/runstate.h"
 bool runstate_check(RunState state)
 {
     return state == RUN_STATE_PRELAUNCH;
diff --git a/stubs/vm-stop.c b/stubs/vm-stop.c
index 7f8a9da8a59..e139aabf7be 100644
--- a/stubs/vm-stop.c
+++ b/stubs/vm-stop.c
@@ -1,6 +1,6 @@
 #include "qemu/osdep.h"
 
-#include "sysemu/runstate.h"
+#include "system/runstate.h"
 void qemu_system_vmstop_request_prepare(void)
 {
     abort();
diff --git a/system/arch_init.c b/system/arch_init.c
index 79716f959ba..d2c32f84887 100644
--- a/system/arch_init.c
+++ b/system/arch_init.c
@@ -23,7 +23,7 @@
  */
 #include "qemu/osdep.h"
 #include "qemu/module.h"
-#include "sysemu/arch_init.h"
+#include "system/arch_init.h"
 
 #ifdef TARGET_SPARC
 int graphic_width = 1024;
diff --git a/system/balloon.c b/system/balloon.c
index fda7af832e4..311fa5058b9 100644
--- a/system/balloon.c
+++ b/system/balloon.c
@@ -26,8 +26,8 @@
 
 #include "qemu/osdep.h"
 #include "qemu/atomic.h"
-#include "sysemu/kvm.h"
-#include "sysemu/balloon.h"
+#include "system/kvm.h"
+#include "system/balloon.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-machine.h"
 #include "qapi/qmp/qerror.h"
diff --git a/system/bootdevice.c b/system/bootdevice.c
index 2579b26dc8b..1845be4507e 100644
--- a/system/bootdevice.c
+++ b/system/bootdevice.c
@@ -24,10 +24,10 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "sysemu/sysemu.h"
+#include "system/system.h"
 #include "qapi/visitor.h"
 #include "qemu/error-report.h"
-#include "sysemu/reset.h"
+#include "system/reset.h"
 #include "hw/qdev-core.h"
 #include "hw/boards.h"
 
diff --git a/system/cpu-timers.c b/system/cpu-timers.c
index 856e502e348..23dd82b465f 100644
--- a/system/cpu-timers.c
+++ b/system/cpu-timers.c
@@ -27,15 +27,15 @@
 #include "migration/vmstate.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
-#include "sysemu/cpus.h"
+#include "system/cpus.h"
 #include "qemu/main-loop.h"
 #include "qemu/option.h"
 #include "qemu/seqlock.h"
-#include "sysemu/replay.h"
-#include "sysemu/runstate.h"
+#include "system/replay.h"
+#include "system/runstate.h"
 #include "hw/core/cpu.h"
-#include "sysemu/cpu-timers.h"
-#include "sysemu/cpu-timers-internal.h"
+#include "system/cpu-timers.h"
+#include "system/cpu-timers-internal.h"
 
 /* clock and ticks */
 
diff --git a/system/cpus.c b/system/cpus.c
index ba633c7688b..3460a804823 100644
--- a/system/cpus.c
+++ b/system/cpus.c
@@ -31,18 +31,18 @@
 #include "qapi/qapi-events-run-state.h"
 #include "qapi/qmp/qerror.h"
 #include "exec/gdbstub.h"
-#include "sysemu/hw_accel.h"
+#include "system/hw_accel.h"
 #include "exec/cpu-common.h"
 #include "qemu/thread.h"
 #include "qemu/main-loop.h"
 #include "qemu/plugin.h"
-#include "sysemu/cpus.h"
+#include "system/cpus.h"
 #include "qemu/guest-random.h"
 #include "hw/nmi.h"
-#include "sysemu/replay.h"
-#include "sysemu/runstate.h"
-#include "sysemu/cpu-timers.h"
-#include "sysemu/whpx.h"
+#include "system/replay.h"
+#include "system/runstate.h"
+#include "system/cpu-timers.h"
+#include "system/whpx.h"
 #include "hw/boards.h"
 #include "hw/hw.h"
 #include "trace.h"
diff --git a/system/device_tree.c b/system/device_tree.c
index 2e38259d34f..11f3178095c 100644
--- a/system/device_tree.c
+++ b/system/device_tree.c
@@ -23,7 +23,7 @@
 #include "qemu/bswap.h"
 #include "qemu/cutils.h"
 #include "qemu/guest-random.h"
-#include "sysemu/device_tree.h"
+#include "system/device_tree.h"
 #include "hw/loader.h"
 #include "hw/boards.h"
 #include "qemu/config-file.h"
diff --git a/system/dirtylimit.c b/system/dirtylimit.c
index ab20da34bb9..d94b994bd81 100644
--- a/system/dirtylimit.c
+++ b/system/dirtylimit.c
@@ -15,14 +15,14 @@
 #include "qapi/qapi-commands-migration.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/error.h"
-#include "sysemu/dirtyrate.h"
-#include "sysemu/dirtylimit.h"
+#include "system/dirtyrate.h"
+#include "system/dirtylimit.h"
 #include "monitor/hmp.h"
 #include "monitor/monitor.h"
 #include "exec/memory.h"
 #include "exec/target_page.h"
 #include "hw/boards.h"
-#include "sysemu/kvm.h"
+#include "system/kvm.h"
 #include "trace.h"
 #include "migration/misc.h"
 
diff --git a/system/dma-helpers.c b/system/dma-helpers.c
index cbcd89dfaaa..f6403242f5f 100644
--- a/system/dma-helpers.c
+++ b/system/dma-helpers.c
@@ -8,12 +8,12 @@
  */
 
 #include "qemu/osdep.h"
-#include "sysemu/block-backend.h"
-#include "sysemu/dma.h"
+#include "system/block-backend.h"
+#include "system/dma.h"
 #include "trace.h"
 #include "qemu/thread.h"
 #include "qemu/main-loop.h"
-#include "sysemu/cpu-timers.h"
+#include "system/cpu-timers.h"
 #include "qemu/range.h"
 
 /* #define DEBUG_IOMMU */
diff --git a/system/globals.c b/system/globals.c
index 84ce943ac96..4867c93ca6b 100644
--- a/system/globals.c
+++ b/system/globals.c
@@ -28,8 +28,8 @@
 #include "hw/loader.h"
 #include "hw/xen/xen.h"
 #include "net/net.h"
-#include "sysemu/cpus.h"
-#include "sysemu/sysemu.h"
+#include "system/cpus.h"
+#include "system/system.h"
 
 enum vga_retrace_method vga_retrace_method = VGA_RETRACE_DUMB;
 int display_opengl;
diff --git a/system/main.c b/system/main.c
index 9b91d21ea8c..4923520741c 100644
--- a/system/main.c
+++ b/system/main.c
@@ -24,7 +24,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu-main.h"
-#include "sysemu/sysemu.h"
+#include "system/system.h"
 
 #ifdef CONFIG_SDL
 #include <SDL.h>
diff --git a/system/memory.c b/system/memory.c
index a789064fbfa..78e17e0efa8 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -27,9 +27,9 @@
 
 #include "exec/memory-internal.h"
 #include "exec/ram_addr.h"
-#include "sysemu/kvm.h"
-#include "sysemu/runstate.h"
-#include "sysemu/tcg.h"
+#include "system/kvm.h"
+#include "system/runstate.h"
+#include "system/tcg.h"
 #include "qemu/accel.h"
 #include "hw/boards.h"
 #include "migration/vmstate.h"
diff --git a/system/memory_mapping.c b/system/memory_mapping.c
index ca2390eb804..37d3325f77b 100644
--- a/system/memory_mapping.c
+++ b/system/memory_mapping.c
@@ -15,7 +15,7 @@
 #include "qemu/range.h"
 #include "qapi/error.h"
 
-#include "sysemu/memory_mapping.h"
+#include "system/memory_mapping.h"
 #include "exec/memory.h"
 #include "exec/address-spaces.h"
 #include "hw/core/cpu.h"
diff --git a/system/physmem.c b/system/physmem.c
index 4bc0228a504..c0e95e6f7cd 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -37,10 +37,10 @@
 #include "hw/qdev-core.h"
 #include "hw/qdev-properties.h"
 #include "hw/boards.h"
-#include "sysemu/xen.h"
-#include "sysemu/kvm.h"
-#include "sysemu/tcg.h"
-#include "sysemu/qtest.h"
+#include "system/xen.h"
+#include "system/kvm.h"
+#include "system/tcg.h"
+#include "system/qtest.h"
 #include "qemu/timer.h"
 #include "qemu/config-file.h"
 #include "qemu/error-report.h"
@@ -49,10 +49,10 @@
 #include "qemu/memalign.h"
 #include "exec/memory.h"
 #include "exec/ioport.h"
-#include "sysemu/dma.h"
-#include "sysemu/hostmem.h"
-#include "sysemu/hw_accel.h"
-#include "sysemu/xen-mapcache.h"
+#include "system/dma.h"
+#include "system/hostmem.h"
+#include "system/hw_accel.h"
+#include "system/xen-mapcache.h"
 #include "trace.h"
 
 #ifdef CONFIG_FALLOCATE_PUNCH_HOLE
@@ -62,7 +62,7 @@
 #include "qemu/rcu_queue.h"
 #include "qemu/main-loop.h"
 #include "exec/translate-all.h"
-#include "sysemu/replay.h"
+#include "system/replay.h"
 
 #include "exec/memory-internal.h"
 #include "exec/ram_addr.h"
diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
index 03ae6106497..efa284750ea 100644
--- a/system/qdev-monitor.c
+++ b/system/qdev-monitor.c
@@ -22,8 +22,8 @@
 #include "monitor/hmp.h"
 #include "monitor/monitor.h"
 #include "monitor/qdev.h"
-#include "sysemu/arch_init.h"
-#include "sysemu/runstate.h"
+#include "system/arch_init.h"
+#include "system/runstate.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-qdev.h"
 #include "qapi/qmp/dispatch.h"
@@ -37,7 +37,7 @@
 #include "qemu/option.h"
 #include "qemu/qemu-print.h"
 #include "qemu/option_int.h"
-#include "sysemu/block-backend.h"
+#include "system/block-backend.h"
 #include "migration/misc.h"
 #include "qemu/cutils.h"
 #include "hw/qdev-properties.h"
diff --git a/system/qemu-seccomp.c b/system/qemu-seccomp.c
index 71ac4448026..f8e1238b914 100644
--- a/system/qemu-seccomp.c
+++ b/system/qemu-seccomp.c
@@ -20,7 +20,7 @@
 #include "qemu/module.h"
 #include <sys/prctl.h>
 #include <seccomp.h>
-#include "sysemu/seccomp.h"
+#include "system/seccomp.h"
 #include <linux/seccomp.h>
 
 /* For some architectures (notably ARM) cacheflush is not supported until
diff --git a/system/qtest.c b/system/qtest.c
index 12703a20455..99ef2042f6e 100644
--- a/system/qtest.c
+++ b/system/qtest.c
@@ -13,8 +13,8 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "sysemu/qtest.h"
-#include "sysemu/runstate.h"
+#include "system/qtest.h"
+#include "system/runstate.h"
 #include "chardev/char-fe.h"
 #include "exec/ioport.h"
 #include "exec/memory.h"
@@ -23,7 +23,7 @@
 #include "hw/irq.h"
 #include "hw/core/cpu.h"
 #include "qemu/accel.h"
-#include "sysemu/cpu-timers.h"
+#include "system/cpu-timers.h"
 #include "qemu/config-file.h"
 #include "qemu/option.h"
 #include "qemu/error-report.h"
diff --git a/system/rtc.c b/system/rtc.c
index 216d2aee3ae..56951288c40 100644
--- a/system/rtc.c
+++ b/system/rtc.c
@@ -29,9 +29,9 @@
 #include "qemu/option.h"
 #include "qemu/timer.h"
 #include "qom/object.h"
-#include "sysemu/replay.h"
-#include "sysemu/sysemu.h"
-#include "sysemu/rtc.h"
+#include "system/replay.h"
+#include "system/system.h"
+#include "system/rtc.h"
 #include "hw/rtc/mc146818rtc.h"
 
 static enum {
diff --git a/system/runstate-action.c b/system/runstate-action.c
index ae0761a9c3a..f912bc837f2 100644
--- a/system/runstate-action.c
+++ b/system/runstate-action.c
@@ -7,8 +7,8 @@
  */
 
 #include "qemu/osdep.h"
-#include "sysemu/runstate-action.h"
-#include "sysemu/watchdog.h"
+#include "system/runstate-action.h"
+#include "system/watchdog.h"
 #include "qemu/config-file.h"
 #include "qapi/error.h"
 #include "qemu/option_int.h"
diff --git a/system/runstate.c b/system/runstate.c
index c2c9afa905a..3a8fe866bc7 100644
--- a/system/runstate.c
+++ b/system/runstate.c
@@ -51,14 +51,14 @@
 #include "qemu/thread.h"
 #include "qom/object.h"
 #include "qom/object_interfaces.h"
-#include "sysemu/cpus.h"
-#include "sysemu/qtest.h"
-#include "sysemu/replay.h"
-#include "sysemu/reset.h"
-#include "sysemu/runstate.h"
-#include "sysemu/runstate-action.h"
-#include "sysemu/sysemu.h"
-#include "sysemu/tpm.h"
+#include "system/cpus.h"
+#include "system/qtest.h"
+#include "system/replay.h"
+#include "system/reset.h"
+#include "system/runstate.h"
+#include "system/runstate-action.h"
+#include "system/system.h"
+#include "system/tpm.h"
 #include "trace.h"
 
 static NotifierList exit_notifiers =
diff --git a/system/tpm.c b/system/tpm.c
index 7164ea7ff19..8df0f6e72b3 100644
--- a/system/tpm.c
+++ b/system/tpm.c
@@ -17,8 +17,8 @@
 #include "qapi/error.h"
 #include "qapi/qapi-commands-tpm.h"
 #include "qapi/qmp/qerror.h"
-#include "sysemu/tpm_backend.h"
-#include "sysemu/tpm.h"
+#include "system/tpm_backend.h"
+#include "system/tpm.h"
 #include "qemu/config-file.h"
 #include "qemu/error-report.h"
 
diff --git a/system/vl.c b/system/vl.c
index 85fcc8f96e6..91d6d4f7f7e 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -39,12 +39,12 @@
 #include "qemu/help_option.h"
 #include "qemu/hw-version.h"
 #include "qemu/uuid.h"
-#include "sysemu/reset.h"
-#include "sysemu/runstate.h"
-#include "sysemu/runstate-action.h"
-#include "sysemu/seccomp.h"
-#include "sysemu/tcg.h"
-#include "sysemu/xen.h"
+#include "system/reset.h"
+#include "system/runstate.h"
+#include "system/runstate-action.h"
+#include "system/seccomp.h"
+#include "system/tcg.h"
+#include "system/xen.h"
 
 #include "qemu/error-report.h"
 #include "qemu/sockets.h"
@@ -64,30 +64,30 @@
 #include "monitor/monitor.h"
 #include "ui/console.h"
 #include "ui/input.h"
-#include "sysemu/sysemu.h"
-#include "sysemu/numa.h"
-#include "sysemu/hostmem.h"
+#include "system/system.h"
+#include "system/numa.h"
+#include "system/hostmem.h"
 #include "exec/gdbstub.h"
 #include "gdbstub/enums.h"
 #include "qemu/timer.h"
 #include "chardev/char.h"
 #include "qemu/bitmap.h"
 #include "qemu/log.h"
-#include "sysemu/blockdev.h"
+#include "system/blockdev.h"
 #include "hw/block/block.h"
 #include "hw/i386/x86.h"
 #include "hw/i386/pc.h"
 #include "migration/misc.h"
 #include "migration/snapshot.h"
-#include "sysemu/tpm.h"
-#include "sysemu/dma.h"
+#include "system/tpm.h"
+#include "system/dma.h"
 #include "hw/audio/soundhw.h"
 #include "audio/audio.h"
-#include "sysemu/cpus.h"
-#include "sysemu/cpu-timers.h"
+#include "system/cpus.h"
+#include "system/cpu-timers.h"
 #include "migration/colo.h"
 #include "migration/postcopy-ram.h"
-#include "sysemu/kvm.h"
+#include "system/kvm.h"
 #include "qapi/qobject-input-visitor.h"
 #include "qemu/option.h"
 #include "qemu/config-file.h"
@@ -95,7 +95,7 @@
 #ifdef CONFIG_VIRTFS
 #include "fsdev/qemu-fsdev.h"
 #endif
-#include "sysemu/qtest.h"
+#include "system/qtest.h"
 #ifdef CONFIG_TCG
 #include "tcg/perf.h"
 #endif
@@ -106,7 +106,7 @@
 #include "trace/control.h"
 #include "qemu/plugin.h"
 #include "qemu/queue.h"
-#include "sysemu/arch_init.h"
+#include "system/arch_init.h"
 #include "exec/confidential-guest-support.h"
 
 #include "ui/qemu-spice.h"
@@ -116,7 +116,7 @@
 #include "qom/object_interfaces.h"
 #include "semihosting/semihost.h"
 #include "crypto/init.h"
-#include "sysemu/replay.h"
+#include "system/replay.h"
 #include "qapi/qapi-events-run-state.h"
 #include "qapi/qapi-types-audio.h"
 #include "qapi/qapi-visit-audio.h"
@@ -131,7 +131,7 @@
 #include "qapi/qapi-commands-ui.h"
 #include "block/qdict.h"
 #include "qapi/qmp/qerror.h"
-#include "sysemu/iothread.h"
+#include "system/iothread.h"
 #include "qemu/guest-random.h"
 #include "qemu/keyval.h"
 
diff --git a/target/alpha/sys_helper.c b/target/alpha/sys_helper.c
index 768116ef32b..54ee93f34cc 100644
--- a/target/alpha/sys_helper.c
+++ b/target/alpha/sys_helper.c
@@ -22,8 +22,8 @@
 #include "exec/exec-all.h"
 #include "exec/tb-flush.h"
 #include "exec/helper-proto.h"
-#include "sysemu/runstate.h"
-#include "sysemu/sysemu.h"
+#include "system/runstate.h"
+#include "system/system.h"
 #include "qemu/timer.h"
 
 
diff --git a/target/alpha/translate.c b/target/alpha/translate.c
index fb6cac4b538..660788d5c3c 100644
--- a/target/alpha/translate.c
+++ b/target/alpha/translate.c
@@ -19,7 +19,7 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "sysemu/cpus.h"
+#include "system/cpus.h"
 #include "qemu/host-utils.h"
 #include "exec/exec-all.h"
 #include "tcg/tcg-op.h"
diff --git a/target/arm/arch_dump.c b/target/arm/arch_dump.c
index 06cdf4ba281..5c943dc27b5 100644
--- a/target/arm/arch_dump.c
+++ b/target/arm/arch_dump.c
@@ -21,7 +21,7 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "elf.h"
-#include "sysemu/dump.h"
+#include "system/dump.h"
 #include "cpu-features.h"
 
 /* struct user_pt_regs from arch/arm64/include/uapi/asm/ptrace.h */
diff --git a/target/arm/arm-powerctl.c b/target/arm/arm-powerctl.c
index 2b2055c6acc..20c70c7d6bb 100644
--- a/target/arm/arm-powerctl.c
+++ b/target/arm/arm-powerctl.c
@@ -15,7 +15,7 @@
 #include "arm-powerctl.h"
 #include "qemu/log.h"
 #include "qemu/main-loop.h"
-#include "sysemu/tcg.h"
+#include "system/tcg.h"
 #include "target/arm/multiprocessing.h"
 
 #ifndef DEBUG_ARM_POWERCTL
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 1afa07511e3..b085c068ad1 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -41,9 +41,9 @@
 #include "hw/intc/armv7m_nvic.h"
 #endif /* CONFIG_TCG */
 #endif /* !CONFIG_USER_ONLY */
-#include "sysemu/tcg.h"
-#include "sysemu/qtest.h"
-#include "sysemu/hw_accel.h"
+#include "system/tcg.h"
+#include "system/qtest.h"
+#include "system/hw_accel.h"
 #include "kvm_arm.h"
 #include "disas/capstone.h"
 #include "fpu/softfloat.h"
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index ec77c5b34ad..dca83e45181 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -24,10 +24,10 @@
 #include "cpregs.h"
 #include "qemu/module.h"
 #include "qemu/units.h"
-#include "sysemu/kvm.h"
-#include "sysemu/hvf.h"
-#include "sysemu/qtest.h"
-#include "sysemu/tcg.h"
+#include "system/kvm.h"
+#include "system/hvf.h"
+#include "system/qtest.h"
+#include "system/tcg.h"
 #include "kvm_arm.h"
 #include "hvf_arm.h"
 #include "qapi/visitor.h"
diff --git a/target/arm/debug_helper.c b/target/arm/debug_helper.c
index 7d856acddf2..2212ef4a3b9 100644
--- a/target/arm/debug_helper.c
+++ b/target/arm/debug_helper.c
@@ -13,7 +13,7 @@
 #include "cpregs.h"
 #include "exec/exec-all.h"
 #include "exec/helper-proto.h"
-#include "sysemu/tcg.h"
+#include "system/tcg.h"
 
 #ifdef CONFIG_TCG
 /* Return the Exception Level targeted by debug exceptions. */
diff --git a/target/arm/gdbstub.c b/target/arm/gdbstub.c
index 554b8736bbf..30068c22627 100644
--- a/target/arm/gdbstub.c
+++ b/target/arm/gdbstub.c
@@ -22,7 +22,7 @@
 #include "exec/gdbstub.h"
 #include "gdbstub/helpers.h"
 #include "gdbstub/commands.h"
-#include "sysemu/tcg.h"
+#include "system/tcg.h"
 #include "internals.h"
 #include "cpu-features.h"
 #include "cpregs.h"
diff --git a/target/arm/helper.c b/target/arm/helper.c
index c2a70f8c053..146ddf06c5b 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -21,9 +21,9 @@
 #include "exec/exec-all.h"
 #include <zlib.h> /* for crc32 */
 #include "hw/irq.h"
-#include "sysemu/cpu-timers.h"
-#include "sysemu/kvm.h"
-#include "sysemu/tcg.h"
+#include "system/cpu-timers.h"
+#include "system/kvm.h"
+#include "system/tcg.h"
 #include "qapi/error.h"
 #include "qemu/guest-random.h"
 #ifdef CONFIG_TCG
diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index d75e504dcda..0afd96018e0 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -13,10 +13,10 @@
 #include "qemu/error-report.h"
 #include "qemu/log.h"
 
-#include "sysemu/runstate.h"
-#include "sysemu/hvf.h"
-#include "sysemu/hvf_int.h"
-#include "sysemu/hw_accel.h"
+#include "system/runstate.h"
+#include "system/hvf.h"
+#include "system/hvf_int.h"
+#include "system/hw_accel.h"
 #include "hvf_arm.h"
 #include "cpregs.h"
 
@@ -26,7 +26,7 @@
 #include "hw/boards.h"
 #include "hw/irq.h"
 #include "qemu/main-loop.h"
-#include "sysemu/cpus.h"
+#include "system/cpus.h"
 #include "arm-powerctl.h"
 #include "target/arm/cpu.h"
 #include "target/arm/internals.h"
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 7b6812c0de2..a9444a2c7a8 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -20,10 +20,10 @@
 #include "qemu/main-loop.h"
 #include "qom/object.h"
 #include "qapi/error.h"
-#include "sysemu/sysemu.h"
-#include "sysemu/runstate.h"
-#include "sysemu/kvm.h"
-#include "sysemu/kvm_int.h"
+#include "system/system.h"
+#include "system/runstate.h"
+#include "system/kvm.h"
+#include "system/kvm_int.h"
 #include "kvm_arm.h"
 #include "cpu.h"
 #include "trace.h"
diff --git a/target/arm/machine.c b/target/arm/machine.c
index a3c1e05e65d..978249fb71b 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -1,8 +1,8 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "qemu/error-report.h"
-#include "sysemu/kvm.h"
-#include "sysemu/tcg.h"
+#include "system/kvm.h"
+#include "system/tcg.h"
 #include "kvm_arm.h"
 #include "internals.h"
 #include "cpu-features.h"
diff --git a/target/arm/tcg/psci.c b/target/arm/tcg/psci.c
index 51d2ca3d30d..cabed43e8a8 100644
--- a/target/arm/tcg/psci.c
+++ b/target/arm/tcg/psci.c
@@ -21,7 +21,7 @@
 #include "exec/helper-proto.h"
 #include "kvm-consts.h"
 #include "qemu/main-loop.h"
-#include "sysemu/runstate.h"
+#include "system/runstate.h"
 #include "internals.h"
 #include "arm-powerctl.h"
 #include "target/arm/multiprocessing.h"
diff --git a/target/hppa/sys_helper.c b/target/hppa/sys_helper.c
index 9b43b556fd9..da5b569de81 100644
--- a/target/hppa/sys_helper.c
+++ b/target/hppa/sys_helper.c
@@ -23,8 +23,8 @@
 #include "exec/exec-all.h"
 #include "exec/helper-proto.h"
 #include "qemu/timer.h"
-#include "sysemu/runstate.h"
-#include "sysemu/sysemu.h"
+#include "system/runstate.h"
+#include "system/system.h"
 #include "chardev/char-fe.h"
 
 void HELPER(write_interval_timer)(CPUHPPAState *env, target_ulong val)
diff --git a/target/i386/arch_dump.c b/target/i386/arch_dump.c
index c290910a04b..16e47c4747d 100644
--- a/target/i386/arch_dump.c
+++ b/target/i386/arch_dump.c
@@ -13,9 +13,9 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "sysemu/dump.h"
+#include "system/dump.h"
 #include "elf.h"
-#include "sysemu/memory_mapping.h"
+#include "system/memory_mapping.h"
 
 #define ELF_NOTE_SIZE(hdr_size, name_size, desc_size)   \
     ((DIV_ROUND_UP((hdr_size), 4)                       \
diff --git a/target/i386/arch_memory_mapping.c b/target/i386/arch_memory_mapping.c
index d1ff659128e..ced199862dd 100644
--- a/target/i386/arch_memory_mapping.c
+++ b/target/i386/arch_memory_mapping.c
@@ -13,7 +13,7 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "sysemu/memory_mapping.h"
+#include "system/memory_mapping.h"
 
 /* PAE Paging or IA-32e Paging */
 static void walk_pte(MemoryMappingList *list, AddressSpace *as,
diff --git a/target/i386/cpu-apic.c b/target/i386/cpu-apic.c
index d397ec94dc1..dc844cae8b5 100644
--- a/target/i386/cpu-apic.c
+++ b/target/i386/cpu-apic.c
@@ -11,9 +11,9 @@
 #include "qapi/error.h"
 #include "monitor/monitor.h"
 #include "monitor/hmp-target.h"
-#include "sysemu/hw_accel.h"
-#include "sysemu/kvm.h"
-#include "sysemu/xen.h"
+#include "system/hw_accel.h"
+#include "system/kvm.h"
+#include "system/xen.h"
 #include "exec/address-spaces.h"
 #include "hw/qdev-properties.h"
 #include "hw/i386/apic_internal.h"
diff --git a/target/i386/cpu-sysemu.c b/target/i386/cpu-system.c
similarity index 99%
rename from target/i386/cpu-sysemu.c
rename to target/i386/cpu-system.c
index 227ac021f62..9d007afdab5 100644
--- a/target/i386/cpu-sysemu.c
+++ b/target/i386/cpu-system.c
@@ -1,5 +1,5 @@
 /*
- *  i386 CPUID, CPU class, definitions, models: sysemu-only code
+ *  i386 CPUID, CPU class, definitions, models: system-only code
  *
  *  Copyright (c) 2003 Fabrice Bellard
  *
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 52533994592..96a2608e995 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -24,7 +24,7 @@
 #include "qemu/hw-version.h"
 #include "cpu.h"
 #include "tcg/helper-tcg.h"
-#include "sysemu/hvf.h"
+#include "system/hvf.h"
 #include "hvf/hvf-i386.h"
 #include "kvm/kvm_i386.h"
 #include "sev.h"
@@ -35,7 +35,7 @@
 #include "hw/qdev-properties.h"
 #include "hw/i386/topology.h"
 #ifndef CONFIG_USER_ONLY
-#include "sysemu/reset.h"
+#include "system/reset.h"
 #include "qapi/qapi-commands-machine-target.h"
 #include "exec/address-spaces.h"
 #include "hw/boards.h"
diff --git a/target/i386/helper.c b/target/i386/helper.c
index 01a268a30bb..a78d06c95ba 100644
--- a/target/i386/helper.c
+++ b/target/i386/helper.c
@@ -21,9 +21,9 @@
 #include "qapi/qapi-events-run-state.h"
 #include "cpu.h"
 #include "exec/exec-all.h"
-#include "sysemu/runstate.h"
+#include "system/runstate.h"
 #ifndef CONFIG_USER_ONLY
-#include "sysemu/hw_accel.h"
+#include "system/hw_accel.h"
 #include "monitor/monitor.h"
 #include "kvm/kvm_i386.h"
 #endif
diff --git a/target/i386/host-cpu.c b/target/i386/host-cpu.c
index 03b9d1b169a..3e4e85e729c 100644
--- a/target/i386/host-cpu.c
+++ b/target/i386/host-cpu.c
@@ -12,7 +12,7 @@
 #include "host-cpu.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
-#include "sysemu/sysemu.h"
+#include "system/system.h"
 
 /* Note: Only safe for use on x86(-64) hosts */
 static uint32_t host_cpu_phys_bits(void)
diff --git a/target/i386/hvf/hvf-cpu.c b/target/i386/hvf/hvf-cpu.c
index ac617f17e73..560b5a05940 100644
--- a/target/i386/hvf/hvf-cpu.c
+++ b/target/i386/hvf/hvf-cpu.c
@@ -11,9 +11,9 @@
 #include "cpu.h"
 #include "host-cpu.h"
 #include "qapi/error.h"
-#include "sysemu/sysemu.h"
+#include "system/system.h"
 #include "hw/boards.h"
-#include "sysemu/hvf.h"
+#include "system/hvf.h"
 #include "hw/core/accel-cpu.h"
 #include "hvf-i386.h"
 
diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index c5d025d5576..ca08f0753f0 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -52,10 +52,10 @@
 #include "qapi/error.h"
 #include "migration/blocker.h"
 
-#include "sysemu/hvf.h"
-#include "sysemu/hvf_int.h"
-#include "sysemu/runstate.h"
-#include "sysemu/cpus.h"
+#include "system/hvf.h"
+#include "system/hvf_int.h"
+#include "system/runstate.h"
+#include "system/cpus.h"
 #include "hvf-i386.h"
 #include "vmcs.h"
 #include "vmx.h"
diff --git a/target/i386/hvf/x86_cpuid.c b/target/i386/hvf/x86_cpuid.c
index af9ee17a111..ae836f65cc9 100644
--- a/target/i386/hvf/x86_cpuid.c
+++ b/target/i386/hvf/x86_cpuid.c
@@ -26,7 +26,7 @@
 #include "cpu.h"
 #include "x86.h"
 #include "vmx.h"
-#include "sysemu/hvf.h"
+#include "system/hvf.h"
 #include "hvf-i386.h"
 
 static bool cached_xcr0;
diff --git a/target/i386/hvf/x86_task.c b/target/i386/hvf/x86_task.c
index cdea2ea69d9..bcd844cff60 100644
--- a/target/i386/hvf/x86_task.c
+++ b/target/i386/hvf/x86_task.c
@@ -10,7 +10,7 @@
 #include "panic.h"
 #include "qemu/error-report.h"
 
-#include "sysemu/hvf.h"
+#include "system/hvf.h"
 #include "hvf-i386.h"
 #include "vmcs.h"
 #include "vmx.h"
diff --git a/target/i386/hvf/x86hvf.c b/target/i386/hvf/x86hvf.c
index 1569f860eb1..531a340b37c 100644
--- a/target/i386/hvf/x86hvf.c
+++ b/target/i386/hvf/x86hvf.c
@@ -25,7 +25,7 @@
 #include "cpu.h"
 #include "x86_descr.h"
 #include "x86_decode.h"
-#include "sysemu/hw_accel.h"
+#include "system/hw_accel.h"
 
 #include "hw/i386/apic_internal.h"
 
diff --git a/target/i386/kvm/kvm-cpu.c b/target/i386/kvm/kvm-cpu.c
index 99d1941cf51..1bda403f88b 100644
--- a/target/i386/kvm/kvm-cpu.c
+++ b/target/i386/kvm/kvm-cpu.c
@@ -11,7 +11,7 @@
 #include "cpu.h"
 #include "host-cpu.h"
 #include "qapi/error.h"
-#include "sysemu/sysemu.h"
+#include "system/system.h"
 #include "hw/boards.h"
 
 #include "kvm_i386.h"
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 8e17942c3ba..80fa3bac11c 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -31,10 +31,10 @@
 #include "cpu.h"
 #include "host-cpu.h"
 #include "vmsr_energy.h"
-#include "sysemu/sysemu.h"
-#include "sysemu/hw_accel.h"
-#include "sysemu/kvm_int.h"
-#include "sysemu/runstate.h"
+#include "system/system.h"
+#include "system/hw_accel.h"
+#include "system/kvm_int.h"
+#include "system/runstate.h"
 #include "kvm_i386.h"
 #include "../confidential-guest.h"
 #include "sev.h"
diff --git a/target/i386/kvm/xen-emu.c b/target/i386/kvm/xen-emu.c
index 2f89dc628ef..e81a2458812 100644
--- a/target/i386/kvm/xen-emu.c
+++ b/target/i386/kvm/xen-emu.c
@@ -14,13 +14,13 @@
 #include "qemu/main-loop.h"
 #include "qemu/error-report.h"
 #include "hw/xen/xen.h"
-#include "sysemu/kvm_int.h"
-#include "sysemu/kvm_xen.h"
+#include "system/kvm_int.h"
+#include "system/kvm_xen.h"
 #include "kvm/kvm_i386.h"
 #include "exec/address-spaces.h"
 #include "xen-emu.h"
 #include "trace.h"
-#include "sysemu/runstate.h"
+#include "system/runstate.h"
 
 #include "hw/pci/msi.h"
 #include "hw/i386/apic-msidef.h"
diff --git a/target/i386/machine.c b/target/i386/machine.c
index b4610325aad..d9d4f25d1a2 100644
--- a/target/i386/machine.c
+++ b/target/i386/machine.c
@@ -8,9 +8,9 @@
 #include "kvm/kvm_i386.h"
 #include "hw/xen/xen.h"
 
-#include "sysemu/kvm.h"
-#include "sysemu/kvm_xen.h"
-#include "sysemu/tcg.h"
+#include "system/kvm.h"
+#include "system/kvm_xen.h"
+#include "system/tcg.h"
 
 #include "qemu/error-report.h"
 
diff --git a/target/i386/nvmm/nvmm-accel-ops.c b/target/i386/nvmm/nvmm-accel-ops.c
index 0ba31201e29..e7b56662fee 100644
--- a/target/i386/nvmm/nvmm-accel-ops.c
+++ b/target/i386/nvmm/nvmm-accel-ops.c
@@ -8,12 +8,12 @@
  */
 
 #include "qemu/osdep.h"
-#include "sysemu/kvm_int.h"
+#include "system/kvm_int.h"
 #include "qemu/main-loop.h"
-#include "sysemu/cpus.h"
+#include "system/cpus.h"
 #include "qemu/guest-random.h"
 
-#include "sysemu/nvmm.h"
+#include "system/nvmm.h"
 #include "nvmm-accel-ops.h"
 
 static void *qemu_nvmm_cpu_thread_fn(void *arg)
diff --git a/target/i386/nvmm/nvmm-all.c b/target/i386/nvmm/nvmm-all.c
index 65768aca037..04e5f7e6371 100644
--- a/target/i386/nvmm/nvmm-all.c
+++ b/target/i386/nvmm/nvmm-all.c
@@ -12,9 +12,9 @@
 #include "exec/address-spaces.h"
 #include "exec/ioport.h"
 #include "qemu/accel.h"
-#include "sysemu/nvmm.h"
-#include "sysemu/cpus.h"
-#include "sysemu/runstate.h"
+#include "system/nvmm.h"
+#include "system/cpus.h"
+#include "system/runstate.h"
 #include "qemu/main-loop.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
diff --git a/target/i386/sev-sysemu-stub.c b/target/i386/sev-system-stub.c
similarity index 100%
rename from target/i386/sev-sysemu-stub.c
rename to target/i386/sev-system-stub.c
diff --git a/target/i386/sev.c b/target/i386/sev.c
index 1a4eb1ada62..0e1dbb6959e 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -26,11 +26,11 @@
 #include "qemu/uuid.h"
 #include "qemu/error-report.h"
 #include "crypto/hash.h"
-#include "sysemu/kvm.h"
+#include "system/kvm.h"
 #include "kvm/kvm_i386.h"
 #include "sev.h"
-#include "sysemu/sysemu.h"
-#include "sysemu/runstate.h"
+#include "system/system.h"
+#include "system/runstate.h"
 #include "trace.h"
 #include "migration/blocker.h"
 #include "qom/object.h"
diff --git a/target/i386/tcg/excp_helper.c b/target/i386/tcg/excp_helper.c
index 72387aac24f..de71e68f986 100644
--- a/target/i386/tcg/excp_helper.c
+++ b/target/i386/tcg/excp_helper.c
@@ -21,7 +21,7 @@
 #include "cpu.h"
 #include "exec/exec-all.h"
 #include "qemu/log.h"
-#include "sysemu/runstate.h"
+#include "system/runstate.h"
 #include "exec/helper-proto.h"
 #include "helper-tcg.h"
 
diff --git a/target/i386/tcg/sysemu/bpt_helper.c b/target/i386/tcg/system/bpt_helper.c
similarity index 99%
rename from target/i386/tcg/sysemu/bpt_helper.c
rename to target/i386/tcg/system/bpt_helper.c
index b29acf41c38..be232c1ca9e 100644
--- a/target/i386/tcg/sysemu/bpt_helper.c
+++ b/target/i386/tcg/system/bpt_helper.c
@@ -1,5 +1,5 @@
 /*
- *  i386 breakpoint helpers - sysemu code
+ *  i386 breakpoint helpers - system code
  *
  *  Copyright (c) 2003 Fabrice Bellard
  *
diff --git a/target/i386/tcg/sysemu/excp_helper.c b/target/i386/tcg/system/excp_helper.c
similarity index 99%
rename from target/i386/tcg/sysemu/excp_helper.c
rename to target/i386/tcg/system/excp_helper.c
index b1f40040f89..864e3140e3d 100644
--- a/target/i386/tcg/sysemu/excp_helper.c
+++ b/target/i386/tcg/system/excp_helper.c
@@ -1,5 +1,5 @@
 /*
- *  x86 exception helpers - sysemu code
+ *  x86 exception helpers - system code
  *
  *  Copyright (c) 2003 Fabrice Bellard
  *
diff --git a/target/i386/tcg/sysemu/fpu_helper.c b/target/i386/tcg/system/fpu_helper.c
similarity index 99%
rename from target/i386/tcg/sysemu/fpu_helper.c
rename to target/i386/tcg/system/fpu_helper.c
index e0305ba2345..0b4fa187dfb 100644
--- a/target/i386/tcg/sysemu/fpu_helper.c
+++ b/target/i386/tcg/system/fpu_helper.c
@@ -1,5 +1,5 @@
 /*
- *  x86 FPU, MMX/3DNow!/SSE/SSE2/SSE3/SSSE3/SSE4/PNI helpers (sysemu code)
+ *  x86 FPU, MMX/3DNow!/SSE/SSE2/SSE3/SSSE3/SSE4/PNI helpers (system code)
  *
  *  Copyright (c) 2003 Fabrice Bellard
  *
diff --git a/target/i386/tcg/sysemu/misc_helper.c b/target/i386/tcg/system/misc_helper.c
similarity index 99%
rename from target/i386/tcg/sysemu/misc_helper.c
rename to target/i386/tcg/system/misc_helper.c
index 094aa56a20d..ffed8a3215e 100644
--- a/target/i386/tcg/sysemu/misc_helper.c
+++ b/target/i386/tcg/system/misc_helper.c
@@ -1,5 +1,5 @@
 /*
- *  x86 misc helpers - sysemu code
+ *  x86 misc helpers - system code
  *
  *  Copyright (c) 2003 Fabrice Bellard
  *
diff --git a/target/i386/tcg/sysemu/seg_helper.c b/target/i386/tcg/system/seg_helper.c
similarity index 99%
rename from target/i386/tcg/sysemu/seg_helper.c
rename to target/i386/tcg/system/seg_helper.c
index 05174a79e73..b07cc9f9b12 100644
--- a/target/i386/tcg/sysemu/seg_helper.c
+++ b/target/i386/tcg/system/seg_helper.c
@@ -1,5 +1,5 @@
 /*
- *  x86 segmentation related helpers: (sysemu-only code)
+ *  x86 segmentation related helpers: (system-only code)
  *  TSS, interrupts, system calls, jumps and call/task gates, descriptors
  *
  *  Copyright (c) 2003 Fabrice Bellard
diff --git a/target/i386/tcg/sysemu/smm_helper.c b/target/i386/tcg/system/smm_helper.c
similarity index 99%
rename from target/i386/tcg/sysemu/smm_helper.c
rename to target/i386/tcg/system/smm_helper.c
index a45b5651c36..251eb7856ce 100644
--- a/target/i386/tcg/sysemu/smm_helper.c
+++ b/target/i386/tcg/system/smm_helper.c
@@ -1,5 +1,5 @@
 /*
- *  x86 SMM helpers (sysemu-only)
+ *  x86 SMM helpers (system-only)
  *
  *  Copyright (c) 2003 Fabrice Bellard
  *
diff --git a/target/i386/tcg/sysemu/svm_helper.c b/target/i386/tcg/system/svm_helper.c
similarity index 99%
rename from target/i386/tcg/sysemu/svm_helper.c
rename to target/i386/tcg/system/svm_helper.c
index 9db8ad62a01..5f95b5227b7 100644
--- a/target/i386/tcg/sysemu/svm_helper.c
+++ b/target/i386/tcg/system/svm_helper.c
@@ -1,5 +1,5 @@
 /*
- *  x86 SVM helpers (sysemu only)
+ *  x86 SVM helpers (system only)
  *
  *  Copyright (c) 2003 Fabrice Bellard
  *
diff --git a/target/i386/tcg/sysemu/tcg-cpu.c b/target/i386/tcg/system/tcg-cpu.c
similarity index 96%
rename from target/i386/tcg/sysemu/tcg-cpu.c
rename to target/i386/tcg/system/tcg-cpu.c
index c223c0fe9bc..13a3507863c 100644
--- a/target/i386/tcg/sysemu/tcg-cpu.c
+++ b/target/i386/tcg/system/tcg-cpu.c
@@ -1,5 +1,5 @@
 /*
- * i386 TCG cpu class initialization functions specific to sysemu
+ * i386 TCG cpu class initialization functions specific to system emulation
  *
  *  Copyright (c) 2003 Fabrice Bellard
  *
@@ -21,7 +21,7 @@
 #include "cpu.h"
 #include "tcg/helper-tcg.h"
 
-#include "sysemu/sysemu.h"
+#include "system/system.h"
 #include "qemu/units.h"
 #include "exec/address-spaces.h"
 
diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 5d729e68c98..ea7995106fb 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -228,7 +228,7 @@ typedef struct DisasContext {
 #endif
 
 /*
- * Many sysemu-only helpers are not reachable for user-only.
+ * Many system-only helpers are not reachable for user-only.
  * Define stub generators here, so that we need not either sprinkle
  * ifdefs through the translator, nor provide the helper function.
  */
diff --git a/target/i386/whpx/whpx-accel-ops.c b/target/i386/whpx/whpx-accel-ops.c
index 1a2b4e1c43d..ab2e014c9ea 100644
--- a/target/i386/whpx/whpx-accel-ops.c
+++ b/target/i386/whpx/whpx-accel-ops.c
@@ -9,12 +9,12 @@
  */
 
 #include "qemu/osdep.h"
-#include "sysemu/kvm_int.h"
+#include "system/kvm_int.h"
 #include "qemu/main-loop.h"
-#include "sysemu/cpus.h"
+#include "system/cpus.h"
 #include "qemu/guest-random.h"
 
-#include "sysemu/whpx.h"
+#include "system/whpx.h"
 #include "whpx-internal.h"
 #include "whpx-accel-ops.h"
 
diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index a6674a826d6..41fb8c5a4e5 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -14,9 +14,9 @@
 #include "exec/ioport.h"
 #include "gdbstub/helpers.h"
 #include "qemu/accel.h"
-#include "sysemu/whpx.h"
-#include "sysemu/cpus.h"
-#include "sysemu/runstate.h"
+#include "system/whpx.h"
+#include "system/cpus.h"
+#include "system/runstate.h"
 #include "qemu/main-loop.h"
 #include "hw/boards.h"
 #include "hw/intc/ioapic.h"
diff --git a/target/i386/whpx/whpx-apic.c b/target/i386/whpx/whpx-apic.c
index 7e14ded9788..4245ab68a27 100644
--- a/target/i386/whpx/whpx-apic.c
+++ b/target/i386/whpx/whpx-apic.c
@@ -16,8 +16,8 @@
 #include "hw/i386/apic_internal.h"
 #include "hw/i386/apic-msidef.h"
 #include "hw/pci/msi.h"
-#include "sysemu/hw_accel.h"
-#include "sysemu/whpx.h"
+#include "system/hw_accel.h"
+#include "system/whpx.h"
 #include "whpx-internal.h"
 
 struct whpx_lapic_state {
diff --git a/target/loongarch/arch_dump.c b/target/loongarch/arch_dump.c
index d9e1120333c..2b0955a2091 100644
--- a/target/loongarch/arch_dump.c
+++ b/target/loongarch/arch_dump.c
@@ -20,7 +20,7 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "elf.h"
-#include "sysemu/dump.h"
+#include "system/dump.h"
 #include "internals.h"
 
 /* struct user_pt_regs from arch/loongarch/include/uapi/asm/ptrace.h */
diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index 57cc4f314bf..078766feafc 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -10,9 +10,9 @@
 #include "qemu/qemu-print.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
-#include "sysemu/qtest.h"
-#include "sysemu/tcg.h"
-#include "sysemu/kvm.h"
+#include "system/qtest.h"
+#include "system/tcg.h"
+#include "system/kvm.h"
 #include "kvm/kvm_loongarch.h"
 #include "exec/exec-all.h"
 #include "cpu.h"
@@ -20,7 +20,7 @@
 #include "fpu/softfloat-helpers.h"
 #include "cpu-csr.h"
 #ifndef CONFIG_USER_ONLY
-#include "sysemu/reset.h"
+#include "system/reset.h"
 #endif
 #include "vec.h"
 #ifdef CONFIG_KVM
diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
index ff81806ca35..3c86f5ffb9b 100644
--- a/target/loongarch/kvm/kvm.c
+++ b/target/loongarch/kvm/kvm.c
@@ -13,9 +13,9 @@
 #include "qemu/timer.h"
 #include "qemu/error-report.h"
 #include "qemu/main-loop.h"
-#include "sysemu/sysemu.h"
-#include "sysemu/kvm.h"
-#include "sysemu/kvm_int.h"
+#include "system/system.h"
+#include "system/kvm.h"
+#include "system/kvm_int.h"
 #include "hw/pci/pci.h"
 #include "exec/memattrs.h"
 #include "exec/address-spaces.h"
@@ -23,7 +23,7 @@
 #include "hw/irq.h"
 #include "qemu/log.h"
 #include "hw/loader.h"
-#include "sysemu/runstate.h"
+#include "system/runstate.h"
 #include "cpu-csr.h"
 #include "kvm_loongarch.h"
 #include "trace.h"
diff --git a/target/loongarch/machine.c b/target/loongarch/machine.c
index efb20e2fbe8..4e70f5c8798 100644
--- a/target/loongarch/machine.c
+++ b/target/loongarch/machine.c
@@ -8,7 +8,7 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "migration/cpu.h"
-#include "sysemu/tcg.h"
+#include "system/tcg.h"
 #include "vec.h"
 
 static const VMStateDescription vmstate_fpu_reg = {
diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index 02c0e1b0f9b..441067060fd 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -27,8 +27,8 @@
 #include "internal.h"
 #include "kvm_mips.h"
 #include "qemu/module.h"
-#include "sysemu/kvm.h"
-#include "sysemu/qtest.h"
+#include "system/kvm.h"
+#include "system/qtest.h"
 #include "exec/exec-all.h"
 #include "hw/qdev-properties.h"
 #include "hw/qdev-clock.h"
diff --git a/target/mips/kvm.c b/target/mips/kvm.c
index a98798c6691..d67b7c1a8ec 100644
--- a/target/mips/kvm.c
+++ b/target/mips/kvm.c
@@ -18,9 +18,9 @@
 #include "internal.h"
 #include "qemu/error-report.h"
 #include "qemu/main-loop.h"
-#include "sysemu/kvm.h"
-#include "sysemu/kvm_int.h"
-#include "sysemu/runstate.h"
+#include "system/kvm.h"
+#include "system/kvm_int.h"
+#include "system/runstate.h"
 #include "kvm_mips.h"
 #include "hw/boards.h"
 #include "fpu_helper.h"
diff --git a/target/mips/sysemu/addr.c b/target/mips/system/addr.c
similarity index 100%
rename from target/mips/sysemu/addr.c
rename to target/mips/system/addr.c
diff --git a/target/mips/sysemu/cp0.c b/target/mips/system/cp0.c
similarity index 100%
rename from target/mips/sysemu/cp0.c
rename to target/mips/system/cp0.c
diff --git a/target/mips/sysemu/cp0_timer.c b/target/mips/system/cp0_timer.c
similarity index 99%
rename from target/mips/sysemu/cp0_timer.c
rename to target/mips/system/cp0_timer.c
index 62de502caa5..ca16945cee1 100644
--- a/target/mips/sysemu/cp0_timer.c
+++ b/target/mips/system/cp0_timer.c
@@ -23,7 +23,7 @@
 #include "qemu/osdep.h"
 #include "hw/irq.h"
 #include "qemu/timer.h"
-#include "sysemu/kvm.h"
+#include "system/kvm.h"
 #include "internal.h"
 
 /* MIPS R4K timer */
diff --git a/target/mips/sysemu/machine.c b/target/mips/system/machine.c
similarity index 100%
rename from target/mips/sysemu/machine.c
rename to target/mips/system/machine.c
diff --git a/target/mips/sysemu/mips-qmp-cmds.c b/target/mips/system/mips-qmp-cmds.c
similarity index 100%
rename from target/mips/sysemu/mips-qmp-cmds.c
rename to target/mips/system/mips-qmp-cmds.c
diff --git a/target/mips/sysemu/physaddr.c b/target/mips/system/physaddr.c
similarity index 100%
rename from target/mips/sysemu/physaddr.c
rename to target/mips/system/physaddr.c
diff --git a/target/mips/tcg/sysemu/cp0_helper.c b/target/mips/tcg/system/cp0_helper.c
similarity index 100%
rename from target/mips/tcg/sysemu/cp0_helper.c
rename to target/mips/tcg/system/cp0_helper.c
diff --git a/target/mips/tcg/sysemu/lcsr_helper.c b/target/mips/tcg/system/lcsr_helper.c
similarity index 100%
rename from target/mips/tcg/sysemu/lcsr_helper.c
rename to target/mips/tcg/system/lcsr_helper.c
diff --git a/target/mips/tcg/sysemu/mips-semi.c b/target/mips/tcg/system/mips-semi.c
similarity index 100%
rename from target/mips/tcg/sysemu/mips-semi.c
rename to target/mips/tcg/system/mips-semi.c
diff --git a/target/mips/tcg/sysemu/semihosting-stub.c b/target/mips/tcg/system/semihosting-stub.c
similarity index 100%
rename from target/mips/tcg/sysemu/semihosting-stub.c
rename to target/mips/tcg/system/semihosting-stub.c
diff --git a/target/mips/tcg/sysemu/special_helper.c b/target/mips/tcg/system/special_helper.c
similarity index 100%
rename from target/mips/tcg/sysemu/special_helper.c
rename to target/mips/tcg/system/special_helper.c
diff --git a/target/mips/tcg/sysemu/tlb_helper.c b/target/mips/tcg/system/tlb_helper.c
similarity index 100%
rename from target/mips/tcg/sysemu/tlb_helper.c
rename to target/mips/tcg/system/tlb_helper.c
diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
index de7045874dd..bd1ef4e1fca 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -37,7 +37,7 @@
 
 
 /*
- * Many sysemu-only helpers are not reachable for user-only.
+ * Many system-only helpers are not reachable for user-only.
  * Define stub generators here, so that we need not either sprinkle
  * ifdefs through the translator, nor provide the helper function.
  */
diff --git a/target/ppc/arch_dump.c b/target/ppc/arch_dump.c
index f45474133a7..80ac6c3e320 100644
--- a/target/ppc/arch_dump.c
+++ b/target/ppc/arch_dump.c
@@ -15,8 +15,8 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "elf.h"
-#include "sysemu/dump.h"
-#include "sysemu/kvm.h"
+#include "system/dump.h"
+#include "system/kvm.h"
 
 #ifdef TARGET_PPC64
 #define ELFCLASS ELFCLASS64
diff --git a/target/ppc/compat.c b/target/ppc/compat.c
index 0cec1bde917..55de3bd5d5d 100644
--- a/target/ppc/compat.c
+++ b/target/ppc/compat.c
@@ -18,10 +18,10 @@
  */
 
 #include "qemu/osdep.h"
-#include "sysemu/hw_accel.h"
-#include "sysemu/kvm.h"
+#include "system/hw_accel.h"
+#include "system/kvm.h"
 #include "kvm_ppc.h"
-#include "sysemu/cpus.h"
+#include "system/cpus.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "qapi/visitor.h"
diff --git a/target/ppc/cpu.c b/target/ppc/cpu.c
index e3ad8e0c27f..d148cd76b47 100644
--- a/target/ppc/cpu.c
+++ b/target/ppc/cpu.c
@@ -25,7 +25,7 @@
 #include "fpu/softfloat-helpers.h"
 #include "mmu-hash64.h"
 #include "helper_regs.h"
-#include "sysemu/tcg.h"
+#include "system/tcg.h"
 
 target_ulong cpu_read_xer(const CPUPPCState *env)
 {
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 1253dbf622c..c04ecafef9d 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -22,9 +22,9 @@
 #include "qemu/osdep.h"
 #include "disas/dis-asm.h"
 #include "gdbstub/helpers.h"
-#include "sysemu/cpus.h"
-#include "sysemu/hw_accel.h"
-#include "sysemu/tcg.h"
+#include "system/cpus.h"
+#include "system/hw_accel.h"
+#include "system/tcg.h"
 #include "cpu-models.h"
 #include "mmu-hash32.h"
 #include "mmu-hash64.h"
diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 9f811af0a41..fde9912230e 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -19,8 +19,8 @@
 #include "qemu/osdep.h"
 #include "qemu/main-loop.h"
 #include "qemu/log.h"
-#include "sysemu/sysemu.h"
-#include "sysemu/runstate.h"
+#include "system/system.h"
+#include "system/runstate.h"
 #include "cpu.h"
 #include "exec/exec-all.h"
 #include "internal.h"
@@ -30,7 +30,7 @@
 #include "trace.h"
 
 #ifdef CONFIG_TCG
-#include "sysemu/tcg.h"
+#include "system/tcg.h"
 #include "exec/helper-proto.h"
 #include "exec/cpu_ldst.h"
 #endif
diff --git a/target/ppc/helper_regs.c b/target/ppc/helper_regs.c
index 42c681ca4a5..3ad4273c164 100644
--- a/target/ppc/helper_regs.c
+++ b/target/ppc/helper_regs.c
@@ -21,8 +21,8 @@
 #include "cpu.h"
 #include "qemu/main-loop.h"
 #include "exec/exec-all.h"
-#include "sysemu/kvm.h"
-#include "sysemu/tcg.h"
+#include "system/kvm.h"
+#include "system/tcg.h"
 #include "helper_regs.h"
 #include "power8-pmu.h"
 #include "cpu-models.h"
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 0d464824dbc..966c2c65723 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -26,10 +26,10 @@
 #include "cpu.h"
 #include "cpu-models.h"
 #include "qemu/timer.h"
-#include "sysemu/hw_accel.h"
+#include "system/hw_accel.h"
 #include "kvm_ppc.h"
-#include "sysemu/cpus.h"
-#include "sysemu/device_tree.h"
+#include "system/cpus.h"
+#include "system/device_tree.h"
 #include "mmu-hash64.h"
 
 #include "hw/ppc/spapr.h"
@@ -37,18 +37,18 @@
 #include "hw/hw.h"
 #include "hw/ppc/ppc.h"
 #include "migration/qemu-file-types.h"
-#include "sysemu/watchdog.h"
+#include "system/watchdog.h"
 #include "trace.h"
 #include "gdbstub/enums.h"
 #include "exec/memattrs.h"
 #include "exec/ram_addr.h"
-#include "sysemu/hostmem.h"
+#include "system/hostmem.h"
 #include "qemu/cutils.h"
 #include "qemu/main-loop.h"
 #include "qemu/mmap-alloc.h"
 #include "elf.h"
-#include "sysemu/kvm_int.h"
-#include "sysemu/kvm.h"
+#include "system/kvm_int.h"
+#include "system/kvm.h"
 #include "hw/core/accel-cpu.h"
 
 #include CONFIG_DEVICES
diff --git a/target/ppc/machine.c b/target/ppc/machine.c
index 717bf93e881..0bd7ae6c0ca 100644
--- a/target/ppc/machine.c
+++ b/target/ppc/machine.c
@@ -1,15 +1,15 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "exec/exec-all.h"
-#include "sysemu/kvm.h"
-#include "sysemu/tcg.h"
+#include "system/kvm.h"
+#include "system/tcg.h"
 #include "helper_regs.h"
 #include "mmu-hash64.h"
 #include "migration/cpu.h"
 #include "qapi/error.h"
 #include "kvm_ppc.h"
 #include "power8-pmu.h"
-#include "sysemu/replay.h"
+#include "system/replay.h"
 
 static void post_load_update_msr(CPUPPCState *env)
 {
diff --git a/target/ppc/mmu-hash32.c b/target/ppc/mmu-hash32.c
index 44b16142ab8..1f791a7f2f7 100644
--- a/target/ppc/mmu-hash32.c
+++ b/target/ppc/mmu-hash32.c
@@ -22,7 +22,7 @@
 #include "cpu.h"
 #include "exec/exec-all.h"
 #include "exec/page-protection.h"
-#include "sysemu/kvm.h"
+#include "system/kvm.h"
 #include "kvm_ppc.h"
 #include "internal.h"
 #include "mmu-hash32.h"
diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
index c8c2f8910a7..5ca4faee2ab 100644
--- a/target/ppc/mmu-hash64.c
+++ b/target/ppc/mmu-hash64.c
@@ -24,7 +24,7 @@
 #include "exec/page-protection.h"
 #include "qemu/error-report.h"
 #include "qemu/qemu-print.h"
-#include "sysemu/hw_accel.h"
+#include "system/hw_accel.h"
 #include "kvm_ppc.h"
 #include "mmu-hash64.h"
 #include "exec/log.h"
diff --git a/target/ppc/mmu-radix64.c b/target/ppc/mmu-radix64.c
index be7a45f2549..1d3d9e1be77 100644
--- a/target/ppc/mmu-radix64.c
+++ b/target/ppc/mmu-radix64.c
@@ -22,7 +22,7 @@
 #include "exec/exec-all.h"
 #include "exec/page-protection.h"
 #include "qemu/error-report.h"
-#include "sysemu/kvm.h"
+#include "system/kvm.h"
 #include "kvm_ppc.h"
 #include "exec/log.h"
 #include "internal.h"
diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
index 60f87362104..fb62b947f1d 100644
--- a/target/ppc/mmu_common.c
+++ b/target/ppc/mmu_common.c
@@ -20,7 +20,7 @@
 #include "qemu/osdep.h"
 #include "qemu/units.h"
 #include "cpu.h"
-#include "sysemu/kvm.h"
+#include "system/kvm.h"
 #include "kvm_ppc.h"
 #include "mmu-hash64.h"
 #include "mmu-hash32.h"
diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c
index b167b37e0ab..a802bc9c62b 100644
--- a/target/ppc/mmu_helper.c
+++ b/target/ppc/mmu_helper.c
@@ -20,7 +20,7 @@
 #include "qemu/osdep.h"
 #include "qemu/units.h"
 #include "cpu.h"
-#include "sysemu/kvm.h"
+#include "system/kvm.h"
 #include "kvm_ppc.h"
 #include "mmu-hash64.h"
 #include "mmu-hash32.h"
diff --git a/target/riscv/arch_dump.c b/target/riscv/arch_dump.c
index 434c8a3dbb7..12b68799070 100644
--- a/target/riscv/arch_dump.c
+++ b/target/riscv/arch_dump.c
@@ -19,7 +19,7 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "elf.h"
-#include "sysemu/dump.h"
+#include "system/dump.h"
 
 /* struct user_regs_struct from arch/riscv/include/uapi/asm/ptrace.h */
 struct riscv64_user_regs {
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 4329015076d..3b316184fd7 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -32,9 +32,9 @@
 #include "hw/core/qdev-prop-internal.h"
 #include "migration/vmstate.h"
 #include "fpu/softfloat-helpers.h"
-#include "sysemu/device_tree.h"
-#include "sysemu/kvm.h"
-#include "sysemu/tcg.h"
+#include "system/device_tree.h"
+#include "system/kvm.h"
+#include "system/tcg.h"
 #include "kvm/kvm_riscv.h"
 #include "tcg/tcg-cpu.h"
 #include "tcg/tcg.h"
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 45806f5ab0f..39e1dd76a5c 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -29,7 +29,7 @@
 #include "tcg/tcg-op.h"
 #include "trace.h"
 #include "semihosting/common-semi.h"
-#include "sysemu/cpu-timers.h"
+#include "system/cpu-timers.h"
 #include "cpu_bits.h"
 #include "debug.h"
 #include "tcg/oversized-guest.h"
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 9846770820f..7f8c76e2296 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -26,7 +26,7 @@
 #include "time_helper.h"
 #include "exec/exec-all.h"
 #include "exec/tb-flush.h"
-#include "sysemu/cpu-timers.h"
+#include "system/cpu-timers.h"
 #include "qemu/guest-random.h"
 #include "qapi/error.h"
 
diff --git a/target/riscv/debug.c b/target/riscv/debug.c
index c79b51af307..f6241a80be8 100644
--- a/target/riscv/debug.c
+++ b/target/riscv/debug.c
@@ -30,7 +30,7 @@
 #include "trace.h"
 #include "exec/exec-all.h"
 #include "exec/helper-proto.h"
-#include "sysemu/cpu-timers.h"
+#include "system/cpu-timers.h"
 
 /*
  * The following M-mode trigger CSRs are implemented:
diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index c53ca1f76bf..189e460ee28 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -27,9 +27,9 @@
 #include "qemu/error-report.h"
 #include "qemu/main-loop.h"
 #include "qapi/visitor.h"
-#include "sysemu/sysemu.h"
-#include "sysemu/kvm.h"
-#include "sysemu/kvm_int.h"
+#include "system/system.h"
+#include "system/kvm.h"
+#include "system/kvm_int.h"
 #include "cpu.h"
 #include "trace.h"
 #include "hw/core/accel-cpu.h"
@@ -45,7 +45,7 @@
 #include "sbi_ecall_interface.h"
 #include "chardev/char-fe.h"
 #include "migration/misc.h"
-#include "sysemu/runstate.h"
+#include "system/runstate.h"
 #include "hw/riscv/numa.h"
 
 #define PR_RISCV_V_SET_CONTROL            69
diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index 99f0af50771..b2e1f2503cd 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -19,9 +19,9 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "qemu/error-report.h"
-#include "sysemu/kvm.h"
+#include "system/kvm.h"
 #include "migration/cpu.h"
-#include "sysemu/cpu-timers.h"
+#include "system/cpu-timers.h"
 #include "debug.h"
 
 static bool pmp_needed(void *opaque)
diff --git a/target/riscv/pmu.c b/target/riscv/pmu.c
index e05ab067d2f..cf713663ee5 100644
--- a/target/riscv/pmu.c
+++ b/target/riscv/pmu.c
@@ -22,8 +22,8 @@
 #include "qemu/timer.h"
 #include "cpu.h"
 #include "pmu.h"
-#include "sysemu/cpu-timers.h"
-#include "sysemu/device_tree.h"
+#include "system/cpu-timers.h"
+#include "system/device_tree.h"
 
 #define RISCV_TIMEBASE_FREQ 1000000000 /* 1Ghz */
 
diff --git a/target/riscv/riscv-qmp-cmds.c b/target/riscv/riscv-qmp-cmds.c
index d363dc318d9..e945b3eb02b 100644
--- a/target/riscv/riscv-qmp-cmds.c
+++ b/target/riscv/riscv-qmp-cmds.c
@@ -31,8 +31,8 @@
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/visitor.h"
 #include "qom/qom-qobject.h"
-#include "sysemu/kvm.h"
-#include "sysemu/tcg.h"
+#include "system/kvm.h"
+#include "system/tcg.h"
 #include "cpu-qom.h"
 #include "cpu.h"
 
diff --git a/target/s390x/arch_dump.c b/target/s390x/arch_dump.c
index 029d91d93a2..2c26e992959 100644
--- a/target/s390x/arch_dump.c
+++ b/target/s390x/arch_dump.c
@@ -16,7 +16,7 @@
 #include "cpu.h"
 #include "s390x-internal.h"
 #include "elf.h"
-#include "sysemu/dump.h"
+#include "system/dump.h"
 #include "kvm/kvm_s390x.h"
 #include "target/s390x/kvm/pv.h"
 
diff --git a/target/s390x/cpu-dump.c b/target/s390x/cpu-dump.c
index 69cc9f77464..869d3a4ad54 100644
--- a/target/s390x/cpu-dump.c
+++ b/target/s390x/cpu-dump.c
@@ -23,7 +23,7 @@
 #include "cpu.h"
 #include "s390x-internal.h"
 #include "qemu/qemu-print.h"
-#include "sysemu/tcg.h"
+#include "system/tcg.h"
 
 void s390_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 {
diff --git a/target/s390x/cpu-sysemu.c b/target/s390x/cpu-system.c
similarity index 96%
rename from target/s390x/cpu-sysemu.c
rename to target/s390x/cpu-system.c
index 1cd30c1d84f..2ba2598ae0f 100644
--- a/target/s390x/cpu-sysemu.c
+++ b/target/s390x/cpu-system.c
@@ -1,5 +1,5 @@
 /*
- * QEMU S/390 CPU - System Emulation-only code
+ * QEMU S/390 CPU - System-only code
  *
  * Copyright (c) 2009 Ulrich Hecht
  * Copyright (c) 2011 Alexander Graf
@@ -26,17 +26,17 @@
 #include "cpu.h"
 #include "s390x-internal.h"
 #include "kvm/kvm_s390x.h"
-#include "sysemu/kvm.h"
-#include "sysemu/reset.h"
+#include "system/kvm.h"
+#include "system/reset.h"
 #include "qemu/timer.h"
 #include "trace.h"
 #include "qapi/qapi-visit-run-state.h"
-#include "sysemu/hw_accel.h"
+#include "system/hw_accel.h"
 
 #include "target/s390x/kvm/pv.h"
 #include "hw/boards.h"
-#include "sysemu/sysemu.h"
-#include "sysemu/tcg.h"
+#include "system/system.h"
+#include "system/tcg.h"
 #include "hw/core/sysemu-cpu-ops.h"
 
 /* S390CPUClass::load_normal() */
@@ -107,7 +107,7 @@ static void s390_cpu_get_crash_info_qom(Object *obj, Visitor *v,
     qapi_free_GuestPanicInformation(panic_info);
 }
 
-void s390_cpu_init_sysemu(Object *obj)
+void s390_cpu_system_init(Object *obj)
 {
     CPUState *cs = CPU(obj);
     S390CPU *cpu = S390_CPU(obj);
@@ -122,7 +122,7 @@ void s390_cpu_init_sysemu(Object *obj)
     s390_cpu_set_state(S390_CPU_STATE_STOPPED, cpu);
 }
 
-bool s390_cpu_realize_sysemu(DeviceState *dev, Error **errp)
+bool s390_cpu_system_realize(DeviceState *dev, Error **errp)
 {
     S390CPU *cpu = S390_CPU(dev);
     MachineState *ms = MACHINE(qdev_get_machine());
@@ -164,7 +164,7 @@ static const struct SysemuCPUOps s390_sysemu_ops = {
     .legacy_vmsd = &vmstate_s390_cpu,
 };
 
-void s390_cpu_class_init_sysemu(CPUClass *cc)
+void s390_cpu_system_class_init(CPUClass *cc)
 {
     S390CPUClass *scc = S390_CPU_CLASS(cc);
 
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 4702761ca30..a149dbd848e 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -25,19 +25,19 @@
 #include "cpu.h"
 #include "s390x-internal.h"
 #include "kvm/kvm_s390x.h"
-#include "sysemu/kvm.h"
+#include "system/kvm.h"
 #include "qemu/module.h"
 #include "trace.h"
 #include "qapi/qapi-types-machine.h"
-#include "sysemu/hw_accel.h"
+#include "system/hw_accel.h"
 #include "hw/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
 #include "hw/resettable.h"
 #include "fpu/softfloat-helpers.h"
 #include "disas/capstone.h"
-#include "sysemu/tcg.h"
+#include "system/tcg.h"
 #ifndef CONFIG_USER_ONLY
-#include "sysemu/reset.h"
+#include "system/reset.h"
 #endif
 #include "hw/s390x/cpu-topology.h"
 
@@ -260,7 +260,7 @@ static void s390_cpu_realizefn(DeviceState *dev, Error **errp)
     }
 
 #if !defined(CONFIG_USER_ONLY)
-    if (!s390_cpu_realize_sysemu(dev, &err)) {
+    if (!s390_cpu_system_realize(dev, &err)) {
         goto out;
     }
 #endif
@@ -300,7 +300,7 @@ static void s390_cpu_initfn(Object *obj)
     cs->exception_index = EXCP_HLT;
 
 #if !defined(CONFIG_USER_ONLY)
-    s390_cpu_init_sysemu(obj);
+    s390_cpu_system_init(obj);
 #endif
 }
 
@@ -404,7 +404,7 @@ static void s390_cpu_class_init(ObjectClass *oc, void *data)
     cc->gdb_read_register = s390_cpu_gdb_read_register;
     cc->gdb_write_register = s390_cpu_gdb_write_register;
 #ifndef CONFIG_USER_ONLY
-    s390_cpu_class_init_sysemu(cc);
+    s390_cpu_system_class_init(cc);
 #endif
     cc->disas_set_info = s390_cpu_disas_set_info;
     cc->gdb_core_xml_file = "s390x-core64.xml";
diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index beb50b53008..93a05e43d79 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -14,8 +14,8 @@
 #include "cpu.h"
 #include "s390x-internal.h"
 #include "kvm/kvm_s390x.h"
-#include "sysemu/kvm.h"
-#include "sysemu/tcg.h"
+#include "system/kvm.h"
+#include "system/tcg.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "qapi/visitor.h"
@@ -23,7 +23,7 @@
 #include "qemu/hw-version.h"
 #include "qemu/qemu-print.h"
 #ifndef CONFIG_USER_ONLY
-#include "sysemu/sysemu.h"
+#include "system/system.h"
 #include "target/s390x/kvm/pv.h"
 #include CONFIG_DEVICES
 #endif
diff --git a/target/s390x/cpu_models_sysemu.c b/target/s390x/cpu_models_system.c
similarity index 99%
rename from target/s390x/cpu_models_sysemu.c
rename to target/s390x/cpu_models_system.c
index f6df691b665..6b65fa22765 100644
--- a/target/s390x/cpu_models_sysemu.c
+++ b/target/s390x/cpu_models_system.c
@@ -1,5 +1,5 @@
 /*
- * CPU models for s390x - System Emulation-only
+ * CPU models for s390x - System-only
  *
  * Copyright 2016 IBM Corp.
  *
@@ -14,7 +14,7 @@
 #include "cpu.h"
 #include "s390x-internal.h"
 #include "kvm/kvm_s390x.h"
-#include "sysemu/kvm.h"
+#include "system/kvm.h"
 #include "qapi/error.h"
 #include "qapi/visitor.h"
 #include "qapi/qobject-input-visitor.h"
diff --git a/target/s390x/diag.c b/target/s390x/diag.c
index a1fd54ddac0..da44b0133ed 100644
--- a/target/s390x/diag.c
+++ b/target/s390x/diag.c
@@ -16,10 +16,10 @@
 #include "cpu.h"
 #include "s390x-internal.h"
 #include "hw/watchdog/wdt_diag288.h"
-#include "sysemu/cpus.h"
+#include "system/cpus.h"
 #include "hw/s390x/ipl.h"
 #include "hw/s390x/s390-virtio-ccw.h"
-#include "sysemu/kvm.h"
+#include "system/kvm.h"
 #include "kvm/kvm_s390x.h"
 #include "target/s390x/kvm/pv.h"
 #include "qemu/error-report.h"
diff --git a/target/s390x/gdbstub.c b/target/s390x/gdbstub.c
index 63373f02cef..6879430adc2 100644
--- a/target/s390x/gdbstub.c
+++ b/target/s390x/gdbstub.c
@@ -25,8 +25,8 @@
 #include "exec/gdbstub.h"
 #include "gdbstub/helpers.h"
 #include "qemu/bitops.h"
-#include "sysemu/hw_accel.h"
-#include "sysemu/tcg.h"
+#include "system/hw_accel.h"
+#include "system/tcg.h"
 
 int s390_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 {
diff --git a/target/s390x/helper.c b/target/s390x/helper.c
index 00d5d403f31..c689e11b46c 100644
--- a/target/s390x/helper.c
+++ b/target/s390x/helper.c
@@ -1,5 +1,5 @@
 /*
- *  S/390 helpers - sysemu only
+ *  S/390 helpers - system only
  *
  *  Copyright (c) 2009 Ulrich Hecht
  *  Copyright (c) 2011 Alexander Graf
@@ -25,8 +25,8 @@
 #include "qemu/timer.h"
 #include "hw/s390x/ioinst.h"
 #include "target/s390x/kvm/pv.h"
-#include "sysemu/hw_accel.h"
-#include "sysemu/runstate.h"
+#include "system/hw_accel.h"
+#include "system/runstate.h"
 
 void s390x_tod_timer(void *opaque)
 {
diff --git a/target/s390x/interrupt.c b/target/s390x/interrupt.c
index 5195f060ecb..d68d8955b1a 100644
--- a/target/s390x/interrupt.c
+++ b/target/s390x/interrupt.c
@@ -12,8 +12,8 @@
 #include "kvm/kvm_s390x.h"
 #include "s390x-internal.h"
 #include "exec/exec-all.h"
-#include "sysemu/kvm.h"
-#include "sysemu/tcg.h"
+#include "system/kvm.h"
+#include "system/tcg.h"
 #include "hw/s390x/ioinst.h"
 #include "tcg/tcg_s390x.h"
 #if !defined(CONFIG_USER_ONLY)
diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
index dd0322c43aa..d4ba83eff9f 100644
--- a/target/s390x/kvm/kvm.c
+++ b/target/s390x/kvm/kvm.c
@@ -27,7 +27,7 @@
 #include "cpu.h"
 #include "s390x-internal.h"
 #include "kvm_s390x.h"
-#include "sysemu/kvm_int.h"
+#include "system/kvm_int.h"
 #include "qemu/cutils.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
@@ -36,10 +36,10 @@
 #include "qemu/main-loop.h"
 #include "qemu/mmap-alloc.h"
 #include "qemu/log.h"
-#include "sysemu/sysemu.h"
-#include "sysemu/hw_accel.h"
-#include "sysemu/runstate.h"
-#include "sysemu/device_tree.h"
+#include "system/system.h"
+#include "system/hw_accel.h"
+#include "system/runstate.h"
+#include "system/device_tree.h"
 #include "gdbstub/enums.h"
 #include "exec/ram_addr.h"
 #include "trace.h"
diff --git a/target/s390x/kvm/pv.c b/target/s390x/kvm/pv.c
index dde836d21ae..e4b0d17a48a 100644
--- a/target/s390x/kvm/pv.c
+++ b/target/s390x/kvm/pv.c
@@ -16,8 +16,8 @@
 #include "qemu/units.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
-#include "sysemu/kvm.h"
-#include "sysemu/cpus.h"
+#include "system/kvm.h"
+#include "system/cpus.h"
 #include "qom/object_interfaces.h"
 #include "exec/confidential-guest-support.h"
 #include "hw/s390x/ipl.h"
diff --git a/target/s390x/machine.c b/target/s390x/machine.c
index a125ebcc2fa..3bea6103ffb 100644
--- a/target/s390x/machine.c
+++ b/target/s390x/machine.c
@@ -20,8 +20,8 @@
 #include "kvm/kvm_s390x.h"
 #include "migration/vmstate.h"
 #include "tcg/tcg_s390x.h"
-#include "sysemu/kvm.h"
-#include "sysemu/tcg.h"
+#include "system/kvm.h"
+#include "system/tcg.h"
 
 static int cpu_post_load(void *opaque, int version_id)
 {
diff --git a/target/s390x/mmu_helper.c b/target/s390x/mmu_helper.c
index 6c59d0d216e..d8f483898d0 100644
--- a/target/s390x/mmu_helper.c
+++ b/target/s390x/mmu_helper.c
@@ -21,8 +21,8 @@
 #include "cpu.h"
 #include "s390x-internal.h"
 #include "kvm/kvm_s390x.h"
-#include "sysemu/kvm.h"
-#include "sysemu/tcg.h"
+#include "system/kvm.h"
+#include "system/tcg.h"
 #include "exec/exec-all.h"
 #include "exec/page-protection.h"
 #include "hw/hw.h"
diff --git a/target/s390x/sigp.c b/target/s390x/sigp.c
index 08aaecf12bc..cf53b232918 100644
--- a/target/s390x/sigp.c
+++ b/target/s390x/sigp.c
@@ -12,11 +12,11 @@
 #include "cpu.h"
 #include "s390x-internal.h"
 #include "hw/boards.h"
-#include "sysemu/hw_accel.h"
-#include "sysemu/runstate.h"
+#include "system/hw_accel.h"
+#include "system/runstate.h"
 #include "exec/address-spaces.h"
 #include "exec/exec-all.h"
-#include "sysemu/tcg.h"
+#include "system/tcg.h"
 #include "trace.h"
 #include "qapi/qapi-types-machine.h"
 
diff --git a/target/s390x/tcg/misc_helper.c b/target/s390x/tcg/misc_helper.c
index 303f86d363a..ea25197d730 100644
--- a/target/s390x/tcg/misc_helper.c
+++ b/target/s390x/tcg/misc_helper.c
@@ -33,8 +33,8 @@
 #include "s390-tod.h"
 
 #if !defined(CONFIG_USER_ONLY)
-#include "sysemu/cpus.h"
-#include "sysemu/sysemu.h"
+#include "system/cpus.h"
+#include "system/system.h"
 #include "hw/s390x/ebcdic.h"
 #include "hw/s390x/s390-virtio-hcall.h"
 #include "hw/s390x/sclp.h"
diff --git a/target/sh4/helper.c b/target/sh4/helper.c
index 9659c695504..b8774e046e4 100644
--- a/target/sh4/helper.c
+++ b/target/sh4/helper.c
@@ -26,7 +26,7 @@
 
 #if !defined(CONFIG_USER_ONLY)
 #include "hw/sh4/sh_intc.h"
-#include "sysemu/runstate.h"
+#include "system/runstate.h"
 #endif
 
 #define MMU_OK                   0
diff --git a/target/sparc/int32_helper.c b/target/sparc/int32_helper.c
index f2dd8bcb2e3..f0266061023 100644
--- a/target/sparc/int32_helper.c
+++ b/target/sparc/int32_helper.c
@@ -23,7 +23,7 @@
 #include "trace.h"
 #include "exec/cpu_ldst.h"
 #include "exec/log.h"
-#include "sysemu/runstate.h"
+#include "system/runstate.h"
 
 static const char * const excp_names[0x80] = {
     [TT_TFAULT] = "Instruction Access Fault",
diff --git a/tests/qtest/fuzz/fuzz.c b/tests/qtest/fuzz/fuzz.c
index 9b9c9f9c36e..8274000bd55 100644
--- a/tests/qtest/fuzz/fuzz.c
+++ b/tests/qtest/fuzz/fuzz.c
@@ -17,9 +17,9 @@
 
 #include "qemu/cutils.h"
 #include "qemu/datadir.h"
-#include "sysemu/sysemu.h"
-#include "sysemu/qtest.h"
-#include "sysemu/runstate.h"
+#include "system/system.h"
+#include "system/qtest.h"
+#include "system/runstate.h"
 #include "qemu/main-loop.h"
 #include "qemu/rcu.h"
 #include "tests/qtest/libqtest.h"
diff --git a/tests/qtest/vhost-user-test.c b/tests/qtest/vhost-user-test.c
index 8948fb81ef7..76d142a1584 100644
--- a/tests/qtest/vhost-user-test.c
+++ b/tests/qtest/vhost-user-test.c
@@ -20,7 +20,7 @@
 #include "chardev/char-fe.h"
 #include "qemu/memfd.h"
 #include "qemu/module.h"
-#include "sysemu/sysemu.h"
+#include "system/system.h"
 #include "libqos/libqos.h"
 #include "libqos/pci-pc.h"
 #include "libqos/virtio-pci.h"
diff --git a/tests/unit/test-bdrv-drain.c b/tests/unit/test-bdrv-drain.c
index c112d5b1893..7410e6f3528 100644
--- a/tests/unit/test-bdrv-drain.c
+++ b/tests/unit/test-bdrv-drain.c
@@ -25,7 +25,7 @@
 #include "qemu/osdep.h"
 #include "block/block_int.h"
 #include "block/blockjob_int.h"
-#include "sysemu/block-backend.h"
+#include "system/block-backend.h"
 #include "qapi/error.h"
 #include "qemu/main-loop.h"
 #include "iothread.h"
diff --git a/tests/unit/test-bdrv-graph-mod.c b/tests/unit/test-bdrv-graph-mod.c
index cafc023db42..d743abb4bbf 100644
--- a/tests/unit/test-bdrv-graph-mod.c
+++ b/tests/unit/test-bdrv-graph-mod.c
@@ -22,7 +22,7 @@
 #include "qapi/error.h"
 #include "qemu/main-loop.h"
 #include "block/block_int.h"
-#include "sysemu/block-backend.h"
+#include "system/block-backend.h"
 
 static BlockDriver bdrv_pass_through = {
     .format_name = "pass-through",
diff --git a/tests/unit/test-block-backend.c b/tests/unit/test-block-backend.c
index 2fb1a444bd4..4257b3f8153 100644
--- a/tests/unit/test-block-backend.c
+++ b/tests/unit/test-block-backend.c
@@ -24,7 +24,7 @@
 
 #include "qemu/osdep.h"
 #include "block/block.h"
-#include "sysemu/block-backend.h"
+#include "system/block-backend.h"
 #include "qapi/error.h"
 #include "qemu/main-loop.h"
 
diff --git a/tests/unit/test-block-iothread.c b/tests/unit/test-block-iothread.c
index 20ed54f5701..26a6c051758 100644
--- a/tests/unit/test-block-iothread.c
+++ b/tests/unit/test-block-iothread.c
@@ -26,7 +26,7 @@
 #include "block/block.h"
 #include "block/block_int-global-state.h"
 #include "block/blockjob_int.h"
-#include "sysemu/block-backend.h"
+#include "system/block-backend.h"
 #include "qapi/error.h"
 #include "qapi/qmp/qdict.h"
 #include "qemu/main-loop.h"
diff --git a/tests/unit/test-blockjob-txn.c b/tests/unit/test-blockjob-txn.c
index d3b0bb24bec..c7b4e55483c 100644
--- a/tests/unit/test-blockjob-txn.c
+++ b/tests/unit/test-blockjob-txn.c
@@ -14,7 +14,7 @@
 #include "qapi/error.h"
 #include "qemu/main-loop.h"
 #include "block/blockjob_int.h"
-#include "sysemu/block-backend.h"
+#include "system/block-backend.h"
 #include "qapi/qmp/qdict.h"
 
 typedef struct {
diff --git a/tests/unit/test-blockjob.c b/tests/unit/test-blockjob.c
index fe3e0d2d38c..1df5739b13f 100644
--- a/tests/unit/test-blockjob.c
+++ b/tests/unit/test-blockjob.c
@@ -14,7 +14,7 @@
 #include "qapi/error.h"
 #include "qemu/main-loop.h"
 #include "block/blockjob_int.h"
-#include "sysemu/block-backend.h"
+#include "system/block-backend.h"
 #include "qapi/qmp/qdict.h"
 #include "iothread.h"
 
diff --git a/tests/unit/test-char.c b/tests/unit/test-char.c
index a6e8753e1c8..98a60d86b14 100644
--- a/tests/unit/test-char.c
+++ b/tests/unit/test-char.c
@@ -7,7 +7,7 @@
 #include "qemu/option.h"
 #include "qemu/sockets.h"
 #include "chardev/char-fe.h"
-#include "sysemu/sysemu.h"
+#include "system/system.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-char.h"
 #include "qapi/qmp/qdict.h"
diff --git a/tests/unit/test-image-locking.c b/tests/unit/test-image-locking.c
index 2624cec6a04..7ccf9567f11 100644
--- a/tests/unit/test-image-locking.c
+++ b/tests/unit/test-image-locking.c
@@ -26,7 +26,7 @@
 
 #include "qemu/osdep.h"
 #include "block/block.h"
-#include "sysemu/block-backend.h"
+#include "system/block-backend.h"
 #include "qapi/error.h"
 #include "qapi/qmp/qdict.h"
 #include "qemu/main-loop.h"
diff --git a/tests/unit/test-replication.c b/tests/unit/test-replication.c
index 5d2003b8ced..2a60f78e0ac 100644
--- a/tests/unit/test-replication.c
+++ b/tests/unit/test-replication.c
@@ -17,7 +17,7 @@
 #include "block/replication.h"
 #include "block/block_int.h"
 #include "block/qdict.h"
-#include "sysemu/block-backend.h"
+#include "system/block-backend.h"
 
 #define IMG_SIZE (64 * 1024 * 1024)
 
diff --git a/tests/unit/test-seccomp.c b/tests/unit/test-seccomp.c
index bab93fd6dab..71d40834391 100644
--- a/tests/unit/test-seccomp.c
+++ b/tests/unit/test-seccomp.c
@@ -21,7 +21,7 @@
 #include "qemu/osdep.h"
 #include "qemu/config-file.h"
 #include "qemu/option.h"
-#include "sysemu/seccomp.h"
+#include "system/seccomp.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
 
diff --git a/tests/unit/test-throttle.c b/tests/unit/test-throttle.c
index 24032a02667..dfa61c75ea4 100644
--- a/tests/unit/test-throttle.c
+++ b/tests/unit/test-throttle.c
@@ -21,7 +21,7 @@
 #include "qemu/main-loop.h"
 #include "qemu/module.h"
 #include "block/throttle-groups.h"
-#include "sysemu/block-backend.h"
+#include "system/block-backend.h"
 
 static AioContext     *ctx;
 static LeakyBucket    bkt;
diff --git a/tests/unit/test-timed-average.c b/tests/unit/test-timed-average.c
index 82c92500df8..747ed1ee60e 100644
--- a/tests/unit/test-timed-average.c
+++ b/tests/unit/test-timed-average.c
@@ -11,7 +11,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "sysemu/cpu-timers.h"
+#include "system/cpu-timers.h"
 #include "qemu/timed-average.h"
 
 /* This is the clock for QEMU_CLOCK_VIRTUAL */
diff --git a/tests/unit/test-yank.c b/tests/unit/test-yank.c
index e6c036a64d9..4acfb2f3f62 100644
--- a/tests/unit/test-yank.c
+++ b/tests/unit/test-yank.c
@@ -14,7 +14,7 @@
 #include "qemu/module.h"
 #include "qemu/option.h"
 #include "chardev/char-fe.h"
-#include "sysemu/sysemu.h"
+#include "system/system.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-char.h"
 #include "qapi/qapi-types-char.h"
diff --git a/ui/curses.c b/ui/curses.c
index 4d0be9b37d4..a39aee87623 100644
--- a/ui/curses.c
+++ b/ui/curses.c
@@ -36,7 +36,7 @@
 #include "qemu/module.h"
 #include "ui/console.h"
 #include "ui/input.h"
-#include "sysemu/sysemu.h"
+#include "system/system.h"
 
 #ifdef __APPLE__
 #define _XOPEN_SOURCE_EXTENDED 1
diff --git a/ui/dbus-clipboard.c b/ui/dbus-clipboard.c
index fbb043abca2..6787a776687 100644
--- a/ui/dbus-clipboard.c
+++ b/ui/dbus-clipboard.c
@@ -26,7 +26,7 @@
 #include "qemu/error-report.h"
 #include "qemu/main-loop.h"
 #include "qom/object_interfaces.h"
-#include "sysemu/sysemu.h"
+#include "system/system.h"
 #include "qapi/error.h"
 #include "trace.h"
 
diff --git a/ui/dbus-listener.c b/ui/dbus-listener.c
index 99738e769bc..51244c92404 100644
--- a/ui/dbus-listener.c
+++ b/ui/dbus-listener.c
@@ -24,7 +24,7 @@
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
-#include "sysemu/sysemu.h"
+#include "system/system.h"
 #include "dbus.h"
 #include "glib.h"
 #ifdef G_OS_UNIX
diff --git a/ui/dbus.c b/ui/dbus.c
index d60b59cc546..7b258c68230 100644
--- a/ui/dbus.c
+++ b/ui/dbus.c
@@ -28,7 +28,7 @@
 #include "qemu/main-loop.h"
 #include "qemu/option.h"
 #include "qom/object_interfaces.h"
-#include "sysemu/sysemu.h"
+#include "system/system.h"
 #include "ui/dbus-module.h"
 #ifdef CONFIG_OPENGL
 #include "ui/egl-helpers.h"
diff --git a/ui/egl-helpers.c b/ui/egl-helpers.c
index 81a57fa9758..d5911594808 100644
--- a/ui/egl-helpers.c
+++ b/ui/egl-helpers.c
@@ -20,7 +20,7 @@
 #include "qemu/error-report.h"
 #include "ui/console.h"
 #include "ui/egl-helpers.h"
-#include "sysemu/sysemu.h"
+#include "system/system.h"
 #include "qapi/error.h"
 #include "trace.h"
 
diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c
index 9831c10e1bd..f7a428c86a8 100644
--- a/ui/gtk-egl.c
+++ b/ui/gtk-egl.c
@@ -22,7 +22,7 @@
 #include "ui/egl-helpers.h"
 #include "ui/shader.h"
 
-#include "sysemu/sysemu.h"
+#include "system/system.h"
 
 static void gtk_egl_set_scanout_mode(VirtualConsole *vc, bool scanout)
 {
diff --git a/ui/gtk-gl-area.c b/ui/gtk-gl-area.c
index b628b354510..2c9a0db4257 100644
--- a/ui/gtk-gl-area.c
+++ b/ui/gtk-gl-area.c
@@ -16,7 +16,7 @@
 #include "ui/gtk.h"
 #include "ui/egl-helpers.h"
 
-#include "sysemu/sysemu.h"
+#include "system/system.h"
 
 static void gtk_gl_area_set_scanout_mode(VirtualConsole *vc, bool scanout)
 {
diff --git a/ui/gtk.c b/ui/gtk.c
index f9a53ea78ed..0d38c070e40 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -55,8 +55,8 @@
 
 #include "trace.h"
 #include "ui/input.h"
-#include "sysemu/runstate.h"
-#include "sysemu/sysemu.h"
+#include "system/runstate.h"
+#include "system/system.h"
 #include "keymaps.h"
 #include "chardev/char.h"
 #include "qom/object.h"
diff --git a/ui/input-barrier.c b/ui/input-barrier.c
index 2d57ca70791..c86e5d67eb3 100644
--- a/ui/input-barrier.c
+++ b/ui/input-barrier.c
@@ -11,7 +11,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "sysemu/sysemu.h"
+#include "system/system.h"
 #include "qemu/main-loop.h"
 #include "qemu/sockets.h"
 #include "qapi/error.h"
diff --git a/ui/input-linux.c b/ui/input-linux.c
index e572a2e905b..381148ea994 100644
--- a/ui/input-linux.c
+++ b/ui/input-linux.c
@@ -12,7 +12,7 @@
 #include "qemu/sockets.h"
 #include "ui/input.h"
 #include "qom/object_interfaces.h"
-#include "sysemu/iothread.h"
+#include "system/iothread.h"
 #include "block/aio.h"
 
 #include <sys/ioctl.h>
diff --git a/ui/input.c b/ui/input.c
index 7ddefebc439..147e69c1c3c 100644
--- a/ui/input.c
+++ b/ui/input.c
@@ -1,12 +1,12 @@
 #include "qemu/osdep.h"
-#include "sysemu/sysemu.h"
+#include "system/system.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-ui.h"
 #include "trace.h"
 #include "ui/input.h"
 #include "ui/console.h"
-#include "sysemu/replay.h"
-#include "sysemu/runstate.h"
+#include "system/replay.h"
+#include "system/runstate.h"
 
 struct QemuInputHandlerState {
     DeviceState       *dev;
diff --git a/ui/sdl2.c b/ui/sdl2.c
index bd4f5a9da14..1fb72f67a6f 100644
--- a/ui/sdl2.c
+++ b/ui/sdl2.c
@@ -29,9 +29,9 @@
 #include "ui/console.h"
 #include "ui/input.h"
 #include "ui/sdl2.h"
-#include "sysemu/runstate.h"
-#include "sysemu/runstate-action.h"
-#include "sysemu/sysemu.h"
+#include "system/runstate.h"
+#include "system/runstate-action.h"
+#include "system/system.h"
 #include "ui/win32-kbd-hook.h"
 #include "qemu/log.h"
 
diff --git a/ui/spice-app.c b/ui/spice-app.c
index 2a93ae59184..91e258a621d 100644
--- a/ui/spice-app.c
+++ b/ui/spice-app.c
@@ -36,7 +36,7 @@
 #include "qapi/error.h"
 #include "io/channel-command.h"
 #include "chardev/spice.h"
-#include "sysemu/sysemu.h"
+#include "system/system.h"
 #include "qom/object.h"
 
 static const char *tmp_dir;
diff --git a/ui/spice-core.c b/ui/spice-core.c
index bd9dbe03f17..0326c63becd 100644
--- a/ui/spice-core.c
+++ b/ui/spice-core.c
@@ -18,8 +18,8 @@
 #include "qemu/osdep.h"
 #include <spice.h>
 
-#include "sysemu/sysemu.h"
-#include "sysemu/runstate.h"
+#include "system/system.h"
+#include "system/runstate.h"
 #include "ui/qemu-spice.h"
 #include "qemu/error-report.h"
 #include "qemu/main-loop.h"
diff --git a/ui/vnc.c b/ui/vnc.c
index 5fcb35bf256..9241caaad96 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -29,8 +29,8 @@
 #include "vnc-jobs.h"
 #include "trace.h"
 #include "hw/qdev-core.h"
-#include "sysemu/sysemu.h"
-#include "sysemu/runstate.h"
+#include "system/system.h"
+#include "system/runstate.h"
 #include "qemu/error-report.h"
 #include "qemu/main-loop.h"
 #include "qemu/module.h"
diff --git a/ui/win32-kbd-hook.c b/ui/win32-kbd-hook.c
index 1ac237db9e9..f448247b19d 100644
--- a/ui/win32-kbd-hook.c
+++ b/ui/win32-kbd-hook.c
@@ -7,7 +7,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "sysemu/sysemu.h"
+#include "system/system.h"
 #include "ui/win32-kbd-hook.h"
 
 static Notifier win32_unhook_notifier;
diff --git a/util/async.c b/util/async.c
index 99db28389f6..0fe29436090 100644
--- a/util/async.c
+++ b/util/async.c
@@ -35,7 +35,7 @@
 #include "block/raw-aio.h"
 #include "qemu/coroutine_int.h"
 #include "qemu/coroutine-tls.h"
-#include "sysemu/cpu-timers.h"
+#include "system/cpu-timers.h"
 #include "trace.h"
 
 /***********************************************************/
diff --git a/util/main-loop.c b/util/main-loop.c
index a0386cfeb60..acad8c2e6cd 100644
--- a/util/main-loop.c
+++ b/util/main-loop.c
@@ -26,8 +26,8 @@
 #include "qapi/error.h"
 #include "qemu/cutils.h"
 #include "qemu/timer.h"
-#include "sysemu/cpu-timers.h"
-#include "sysemu/replay.h"
+#include "system/cpu-timers.h"
+#include "system/replay.h"
 #include "qemu/main-loop.h"
 #include "block/aio.h"
 #include "block/thread-pool.h"
diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index 11b35e48fb8..7a542cb50b5 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -31,7 +31,7 @@
 
 #include <glib/gprintf.h>
 
-#include "sysemu/sysemu.h"
+#include "system/system.h"
 #include "trace.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
diff --git a/util/qemu-timer.c b/util/qemu-timer.c
index ffe9a3c5c1e..16f847ff983 100644
--- a/util/qemu-timer.c
+++ b/util/qemu-timer.c
@@ -26,9 +26,9 @@
 #include "qemu/main-loop.h"
 #include "qemu/timer.h"
 #include "qemu/lockable.h"
-#include "sysemu/cpu-timers.h"
-#include "sysemu/replay.h"
-#include "sysemu/cpus.h"
+#include "system/cpu-timers.h"
+#include "system/replay.h"
+#include "system/cpus.h"
 
 #ifdef CONFIG_POSIX
 #include <pthread.h>
diff --git a/crypto/akcipher-gcrypt.c.inc b/crypto/akcipher-gcrypt.c.inc
index 5a880f66387..bcf030fdec4 100644
--- a/crypto/akcipher-gcrypt.c.inc
+++ b/crypto/akcipher-gcrypt.c.inc
@@ -26,7 +26,7 @@
 #include "crypto/akcipher.h"
 #include "crypto/random.h"
 #include "qapi/error.h"
-#include "sysemu/cryptodev.h"
+#include "system/cryptodev.h"
 #include "rsakey.h"
 
 typedef struct QCryptoGcryptRSA {
diff --git a/crypto/akcipher-nettle.c.inc b/crypto/akcipher-nettle.c.inc
index 1720f84362a..1d4bd6960e0 100644
--- a/crypto/akcipher-nettle.c.inc
+++ b/crypto/akcipher-nettle.c.inc
@@ -26,7 +26,7 @@
 #include "crypto/akcipher.h"
 #include "crypto/random.h"
 #include "qapi/error.h"
-#include "sysemu/cryptodev.h"
+#include "system/cryptodev.h"
 #include "rsakey.h"
 
 typedef struct QCryptoNettleRSA {
diff --git a/block/meson.build b/block/meson.build
index f1262ec2ba8..34b1b2a3063 100644
--- a/block/meson.build
+++ b/block/meson.build
@@ -154,8 +154,8 @@ block_gen_c = custom_target('block-gen.c',
                                       '../include/block/dirty-bitmap.h',
                                       '../include/block/block_int-io.h',
                                       '../include/block/block-global-state.h',
-                                      '../include/sysemu/block-backend-global-state.h',
-                                      '../include/sysemu/block-backend-io.h',
+                                      '../include/system/block-backend-global-state.h',
+                                      '../include/system/block-backend-io.h',
                                       'coroutines.h'
                                       ),
                             command: [wrapper_py, '@OUTPUT@', '@INPUT@'])
@@ -163,7 +163,7 @@ block_ss.add(block_gen_c)
 
 block_ss.add(files('stream.c'))
 
-system_ss.add(files('qapi-sysemu.c'))
+system_ss.add(files('qapi-system.c'))
 
 subdir('export')
 subdir('monitor')
diff --git a/hw/core/meson.build b/hw/core/meson.build
index 9fd0b5aaa5e..ce9dfa3f4bf 100644
--- a/hw/core/meson.build
+++ b/hw/core/meson.build
@@ -27,7 +27,7 @@ system_ss.add(when: 'CONFIG_PLATFORM_BUS', if_true: files('sysbus-fdt.c'))
 system_ss.add(when: 'CONFIG_EIF', if_true: [files('eif.c'), zlib, libcbor, gnutls])
 
 system_ss.add(files(
-  'cpu-sysemu.c',
+  'cpu-system.c',
   'fw-path-provider.c',
   'gpio.c',
   'hotplug.c',
diff --git a/net/vmnet-common.m b/net/vmnet-common.m
index 30c4e53c136..dba5b5bab13 100644
--- a/net/vmnet-common.m
+++ b/net/vmnet-common.m
@@ -17,7 +17,7 @@
 #include "clients.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
-#include "sysemu/runstate.h"
+#include "system/runstate.h"
 
 #include <vmnet/vmnet.h>
 #include <dispatch/dispatch.h>
diff --git a/scripts/clean-includes b/scripts/clean-includes
index bdbf4040240..25dbf16c021 100755
--- a/scripts/clean-includes
+++ b/scripts/clean-includes
@@ -130,8 +130,8 @@ for f in "$@"; do
     *include/qemu/compiler.h | \
     *include/qemu/qemu-plugin.h | \
     *include/glib-compat.h | \
-    *include/sysemu/os-posix.h | \
-    *include/sysemu/os-win32.h | \
+    *include/system/os-posix.h | \
+    *include/system/os-win32.h | \
     *include/standard-headers/ )
       # Removing include lines from osdep.h itself would be counterproductive.
       echo "SKIPPING $f (special case header)"
@@ -174,7 +174,7 @@ for f in "$@"; do
            <limits.h> <unistd.h> <time.h> <ctype.h> <errno.h> <fcntl.h>
            <sys/stat.h> <sys/time.h> <assert.h> <signal.h> <glib.h>
            <sys/stat.h> <sys/time.h> <assert.h> <signal.h> <glib.h> <sys/mman.h>
-           "sysemu/os-posix.h, sysemu/os-win32.h "glib-compat.h"
+           "system/os-posix.h, system/os-win32.h "glib-compat.h"
            "qemu/typedefs.h"
             ))' "$f"
 
diff --git a/scripts/codeconverter/codeconverter/test_regexps.py b/scripts/codeconverter/codeconverter/test_regexps.py
index a445634d88a..72113927960 100644
--- a/scripts/codeconverter/codeconverter/test_regexps.py
+++ b/scripts/codeconverter/codeconverter/test_regexps.py
@@ -269,7 +269,7 @@ def test_initial_includes():
 #include "hw/pci/pci.h"
 #include "migration/vmstate.h"
 #include "qemu/module.h"
-#include "sysemu/dma.h"
+#include "system/dma.h"
 
 /* Missing stuff:
    SCTRL_P[12](END|ST)INC
@@ -278,5 +278,5 @@ def test_initial_includes():
     m = InitialIncludes.domatch(c)
     assert m
     print(repr(m.group(0)))
-    assert m.group(0).endswith('#include "sysemu/dma.h"\n')
+    assert m.group(0).endswith('#include "system/dma.h"\n')
 
diff --git a/scripts/coverity-scan/COMPONENTS.md b/scripts/coverity-scan/COMPONENTS.md
index a58e7414c7f..72995903ff9 100644
--- a/scripts/coverity-scan/COMPONENTS.md
+++ b/scripts/coverity-scan/COMPONENTS.md
@@ -76,7 +76,7 @@ chardev
   ~ .*/qemu((/include)?/chardev/.*)
 
 crypto
-  ~ .*/qemu((/include)?/crypto/.*|/hw/.*/.*crypto.*|(/include/sysemu|/backends)/cryptodev.*|/host/include/.*/host/crypto/.*)
+  ~ .*/qemu((/include)?/crypto/.*|/hw/.*/.*crypto.*|(/include/system|/backends)/cryptodev.*|/host/include/.*/host/crypto/.*)
 
 disas
   ~ .*/qemu((/include)?/disas.*)
@@ -144,7 +144,7 @@ kvm
 tcg
   ~ .*/qemu(/accel/tcg|/replay|/tcg)/.*
 
-sysemu
+system
   ~ .*/qemu(/system/.*|/accel/.*)
 
 (headers)
diff --git a/target/i386/meson.build b/target/i386/meson.build
index 075117989b9..2e9c472f49d 100644
--- a/target/i386/meson.build
+++ b/target/i386/meson.build
@@ -19,9 +19,10 @@ i386_system_ss.add(files(
   'machine.c',
   'monitor.c',
   'cpu-apic.c',
-  'cpu-sysemu.c',
+  'cpu-system.c',
 ))
-i386_system_ss.add(when: 'CONFIG_SEV', if_true: files('sev.c'), if_false: files('sev-sysemu-stub.c'))
+i386_system_ss.add(when: 'CONFIG_SEV', if_true: files('sev.c'),
+                                       if_false: files('sev-system-stub.c'))
 
 i386_user_ss = ss.source_set()
 
diff --git a/target/i386/tcg/meson.build b/target/i386/tcg/meson.build
index 1105b35d921..c57e661752e 100644
--- a/target/i386/tcg/meson.build
+++ b/target/i386/tcg/meson.build
@@ -12,5 +12,5 @@ i386_ss.add(when: 'CONFIG_TCG', if_true: files(
   'tcg-cpu.c',
   'translate.c'), if_false: files('tcg-stub.c'))
 
-subdir('sysemu')
+subdir('system')
 subdir('user')
diff --git a/target/i386/tcg/sysemu/meson.build b/target/i386/tcg/system/meson.build
similarity index 100%
rename from target/i386/tcg/sysemu/meson.build
rename to target/i386/tcg/system/meson.build
diff --git a/target/mips/meson.build b/target/mips/meson.build
index a26d1e1f792..247979a2cfc 100644
--- a/target/mips/meson.build
+++ b/target/mips/meson.build
@@ -9,7 +9,7 @@ mips_ss.add(files(
 ))
 
 if have_system
-  subdir('sysemu')
+  subdir('system')
 endif
 
 if 'CONFIG_TCG' in config_all_accel
diff --git a/target/mips/sysemu/meson.build b/target/mips/system/meson.build
similarity index 100%
rename from target/mips/sysemu/meson.build
rename to target/mips/system/meson.build
diff --git a/target/mips/tcg/meson.build b/target/mips/tcg/meson.build
index 7b18e6c4c8b..fff9cd6c7f5 100644
--- a/target/mips/tcg/meson.build
+++ b/target/mips/tcg/meson.build
@@ -36,5 +36,5 @@ mips_ss.add(when: 'TARGET_MIPS64', if_true: files(
 ))
 
 if have_system
-  subdir('sysemu')
+  subdir('system')
 endif
diff --git a/target/mips/tcg/sysemu/meson.build b/target/mips/tcg/system/meson.build
similarity index 100%
rename from target/mips/tcg/sysemu/meson.build
rename to target/mips/tcg/system/meson.build
diff --git a/target/s390x/meson.build b/target/s390x/meson.build
index 02ca43d9f00..3b34ae034cb 100644
--- a/target/s390x/meson.build
+++ b/target/s390x/meson.build
@@ -27,8 +27,8 @@ s390x_system_ss.add(files(
   'machine.c',
   'mmu_helper.c',
   'sigp.c',
-  'cpu-sysemu.c',
-  'cpu_models_sysemu.c',
+  'cpu-system.c',
+  'cpu_models_system.c',
 ))
 
 s390x_user_ss = ss.source_set()
diff --git a/target/s390x/trace-events b/target/s390x/trace-events
index d371ef71b9a..ef3120d3b16 100644
--- a/target/s390x/trace-events
+++ b/target/s390x/trace-events
@@ -6,7 +6,7 @@ ioinst_sch_id(const char *insn, int cssid, int ssid, int schid) "IOINST: %s (%x.
 ioinst_chp_id(const char *insn, int cssid, int chpid) "IOINST: %s (%x.%02x)"
 ioinst_chsc_cmd(uint16_t cmd, uint16_t len) "IOINST: chsc command 0x%04x, len 0x%04x"
 
-# cpu-sysemu.c
+# cpu-system.c
 cpu_set_state(int cpu_index, uint8_t state) "setting cpu %d state to %" PRIu8
 cpu_halt(int cpu_index) "halting cpu %d"
 cpu_unhalt(int cpu_index) "unhalting cpu %d"
diff --git a/ui/cocoa.m b/ui/cocoa.m
index dd88115dc6f..3a88535374d 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -34,15 +34,15 @@
 #include "ui/console.h"
 #include "ui/input.h"
 #include "ui/kbd-state.h"
-#include "sysemu/sysemu.h"
-#include "sysemu/runstate.h"
-#include "sysemu/runstate-action.h"
-#include "sysemu/cpu-throttle.h"
+#include "system/system.h"
+#include "system/runstate.h"
+#include "system/runstate-action.h"
+#include "system/cpu-throttle.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-block.h"
 #include "qapi/qapi-commands-machine.h"
 #include "qapi/qapi-commands-misc.h"
-#include "sysemu/blockdev.h"
+#include "system/blockdev.h"
 #include "qemu-version.h"
 #include "qemu/cutils.h"
 #include "qemu/main-loop.h"
-- 
2.47.1


