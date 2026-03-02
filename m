Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 202A2D58E7A
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 08:46:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwysi-0001Qq-0s; Mon, 02 Mar 2026 03:44:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwysX-0001Om-Sl
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:43:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwysU-0001TX-3H
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:43:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772441024;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=GXBgExkdFGYrUGCLaUnjJpAmnCAIqatyXNZW7b3tA/o=;
 b=UanjkUZ9CQZo6myRgIegusX+d7LybFuXpsS/lVKsqWKfz8KaYmWHJ3Yk8Qwh7IVHLTGJRi
 oWFx5vI2MPX9kXewdT8GeP3KuGKXIyy+8bEo9qfbpbQILCliU9a5w5MATWs0LG34+J2Axm
 321SJl1GRpHrxTMO7p2xSe0LNha6JxQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-25-sA-EjicNOHqFNs75Ty2VLA-1; Mon, 02 Mar 2026 03:43:42 -0500
X-MC-Unique: sA-EjicNOHqFNs75Ty2VLA-1
X-Mimecast-MFC-AGG-ID: sA-EjicNOHqFNs75Ty2VLA_1772441021
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4837b9913c9so29855655e9.0
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 00:43:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772441021; x=1773045821; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=GXBgExkdFGYrUGCLaUnjJpAmnCAIqatyXNZW7b3tA/o=;
 b=jtxsM3G9t+jTyHLviJbSxPSPlBWDQQQf61TdZD+/KOkMWarLAGYzIlcGG2HBVmguz9
 ZIyDMuEiE43w8AUYBNLK/6p18cshhxr43uBh2+WLCc3S48Az570RVkF9em7UMj1HsJUx
 gNfejjRvfCP6LbdgwQ3NTF7p3LSGQm3fQKgYTt0tDvQ4vvhgsfPNunBfqUFyWFeaKNAY
 0vHC8r4Idv+6uGx1VQWZ50PQFdEQYUCoqMO/tgm/WDPlRKqRDAeSL9x/GWpQosxnnKyA
 sDlqDCZ4SIGneOKkosEYqRUsMSgi29z9ToWeS6kU1tZj7AP611pRyOx2NFGrEmzuMhVf
 kvyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772441021; x=1773045821;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GXBgExkdFGYrUGCLaUnjJpAmnCAIqatyXNZW7b3tA/o=;
 b=jfB9RbDb/DlE21rV7cgY7EiAuZo9ShJ6wfJdlGWJV9lMfr+snn3QjJyWkEBq4Rw3il
 uCeZNodJucjOrlf3Q5mxgmCBJ0B4dZhfLU0uHOG32A99GhS56HCdNyXUUW6eGzY5IVb/
 8oWYfK8luu0TugmwkPrWy7TH4g5CSrVfiRLVrGN3yZmGn0BUXTXpJM5FbInPGSsSw33+
 KWKU/HrkwggZhoOJwg/JMOSEYOXchqIe3MHsx9eidNx6lxDjcNe74GYBVdgjW6qZ+xUF
 H8kozZ1t7PNKml4GoqLuRsbRWn+izKvN5bPX/xg6wO1+tACWyhkb2H2l8t5m1+zNddbR
 +Bog==
X-Gm-Message-State: AOJu0YwaaOtlNfjNqONOIkXgc3SYuzlVLMZm0lGiCYSXjgegL+8tJYR7
 kVLcapDTb7/h6ybhVL/0/u5kAWLQdL913we8qT9pZqKjQ9dSQflPQhr/FY/Rz8JT2aLb+8ISCLa
 2TxOVHljPR2qu2czYijqeIm29aJim1zAokHaddLFpm7vCRKYJxC8pkAyq/ojDR42Y8QmBTvYoDW
 o4dQn1AVDvJmI7pfHpvHsMEAfFvnUfsKJnbKxfhLDB
X-Gm-Gg: ATEYQzzqis+FxVopc7G8rOepAiAVYTh4d8zCtCo3sbwhDjimKul6eTfkTUXDdiOwJZl
 SPiVAjKFah+BfNPm/mIEpTMWcAw8Qx4MnB+DKbfmg/knoSqNJmpADDbaGeDhC0hCi1ViyY+b/+L
 bbnc50IyP6+egU47HBztarO5Vf+rlRrghSWCr4u7tI00azfxqleyrNTQZRzjhe4X82uKysUw8bZ
 +zkcbsDEl+oewB85tJ5XFU/Us4ndpnj4370iEp8Zhwxq+0CJMP3SrTa/b3yWSpiXc6Je4/HLS9m
 4fMj64VbSYoYyW8sxJ/tiC8dcekvK+QK3hZ0uCUDLOKp7YZKFeJrnJZbUEX/IpP1FJ+wXm3HFd3
 cD7f+GIqlmL3HbE7K0c/YTYQ/B6lqdEA25sQpgXH5Vt0QdZ6VgTqqqfX7bJNCOCHuhyAskwO7ag
 +ok13k+RXnaEZkgUTgFYVBc6RLg+M=
X-Received: by 2002:a05:600c:3b02:b0:480:3a71:92b2 with SMTP id
 5b1f17b1804b1-483c9bedac6mr189844005e9.26.1772441020861; 
 Mon, 02 Mar 2026 00:43:40 -0800 (PST)
X-Received: by 2002:a05:600c:3b02:b0:480:3a71:92b2 with SMTP id
 5b1f17b1804b1-483c9bedac6mr189843375e9.26.1772441020160; 
 Mon, 02 Mar 2026 00:43:40 -0800 (PST)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bd70e6c9sm344449455e9.8.2026.03.02.00.43.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 00:43:39 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 000/102] Mostly i386 patches for QEMU 11.0 soft freeze
Date: Mon,  2 Mar 2026 09:41:55 +0100
Message-ID: <20260302084338.473368-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012, RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The following changes since commit d8a9d97317d03190b34498741f98f22e2a9afe3e:

  Merge tag 'pull-target-arm-20260226' of https://gitlab.com/pm215/qemu into staging (2026-02-26 16:00:07 +0000)

are available in the Git repository at:

  https://gitlab.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to 5a0f9481b0cf344c4437515b596e4ecf57ccc30f:

  target/i386: emulate: fix scas (2026-03-01 16:02:54 +0100)

----------------------------------------------------------------
* target/alpha: Fix for record/replay issue
* accel/nitro: New Nitro Enclaves accelerator
* generic + kvm: add support for rebuilding VMs on reset
* audio requirements cleanup
* vmmouse: Fix hypercall clobbers
* rust: use checked_div to make clippy happy
* kvm: Don't clear pending #SMI in kvm_get_vcpu_events
* target/i386/emulate: rework MMU code, many fixes
* target/i386/whpx: replace winhvemulation with target/i386/emulate
* target/i386/whpx: x2apic support
* target/i386/whpx: vapic support
* kvm: support for the "ignore guest PAT" quirk
* target/i386: add ITS_NO bit for the arch-capabilities MSR
* target/i386: add MBEC bit for nested VMX

----------------------------------------------------------------
Akihiko Odaki (2):
      target/alpha: Reset CPU
      Reapply "rcu: Unify force quiescent state"

Alexander Graf (11):
      scripts/update-linux-headers: Add Nitro Enclaves header
      linux-headers: Add nitro_enclaves.h
      hw/nitro: Add Nitro Vsock Bus
      accel: Add Nitro Enclaves accelerator
      hw/nitro/nitro-serial-vsock: Nitro Enclaves vsock console
      hw/nitro: Introduce Nitro Enclave Heartbeat device
      target/arm/cpu64: Allow -host for nitro
      hw/nitro: Add nitro machine
      hw/core/eif: Move definitions to header
      hw/nitro: Enable direct kernel boot
      docs: Add Nitro Enclaves documentation

Ani Sinha (34):
      i386/kvm: avoid installing duplicate msr entries in msr_handlers
      accel/kvm: add confidential class member to indicate guest rebuild capability
      hw/accel: add a per-accelerator callback to change VM accelerator handle
      system/physmem: add helper to reattach existing memory after KVM VM fd change
      accel/kvm: add changes required to support KVM VM file descriptor change
      accel/kvm: mark guest state as unprotected after vm file descriptor change
      accel/kvm: add a notifier to indicate KVM VM file descriptor has changed
      accel/kvm: notify when KVM VM file fd is about to be changed
      i386/kvm: unregister smram listeners prior to vm file descriptor change
      kvm/i386: implement architecture support for kvm file descriptor change
      i386/kvm: refactor xen init into a new function
      hw/i386: refactor x86_bios_rom_init for reuse in confidential guest reset
      hw/i386: export a new function x86_bios_rom_reload
      kvm/i386: reload firmware for confidential guest reset
      accel/kvm: rebind current VCPUs to the new KVM VM file descriptor upon reset
      i386/tdx: refactor TDX firmware memory initialization code into a new function
      i386/tdx: finalize TDX guest state upon reset
      i386/tdx: add a pre-vmfd change notifier to reset tdx state
      i386/sev: add migration blockers only once
      i386/sev: add notifiers only once
      i386/sev: free existing launch update data and kernel hashes data on init
      i386/sev: add support for confidential guest reset
      hw/vfio: generate new file fd for pseudo device and rebind existing descriptors
      kvm/i8254: refactor pit initialization into a helper
      kvm/i8254: add support for confidential guest reset
      kvm/hyperv: add synic feature to CPU only if its not enabled
      hw/hyperv/vmbus: add support for confidential guest reset
      kvm/xen-emu: re-initialize capabilities during confidential guest reset
      ppc/openpic: create a new openpic device and reattach mem region on coco reset
      kvm/vcpu: add notifiers to inform vcpu file descriptor change
      kvm/clock: add support for confidential guest reset
      hw/machine: introduce machine specific option 'x-change-vmfd-on-reset'
      tests/functional/x86_64: add functional test to exercise vm fd change on reset
      qom: add 'confidential-guest-reset' property for x86 confidential vms

Bernhard Beschow (3):
      target/i386/emulate/x86_decode: Fix compiler warning
      target/i386/hvf/x86_mmu: Fix compiler warning
      target/i386/emulate/x86_decode: Actually use stream in decode_instruction_stream()

John Snow (1):
      rust: use checked_div to make clippy happy

Jon Kohler (6):
      target/i386: Add VMX_SECONDARY_EXEC_MODE_BASED_EPT_EXEC
      target/i386: Add MSR_IA32_ARCH_CAPABILITIES ITS_NO
      target/i386: introduce SapphireRapids-v6 to expose ITS_NO
      target/i386: introduce GraniteRapids-v5 to expose ITS_NO
      target/i386: introduce SierraForest-v5 to expose ITS_NO
      target/i386: introduce ClearwaterForest-v3 to expose ITS_NO

Josh Poimboeuf (1):
      hw/i386/vmmouse: Fix hypercall clobbers

Marc-André Lureau (6):
      audio: fix nominal volume channel (cosmetic)
      python/wheel: remove meson-1.9.0
      scripts/vendor.py: add pycotap
      audio: require pulse >= 0.9.13
      audio: require spice >= 0.15
      ui: drop spice-protocol < 0.14.3 support

Maxim Levitsky (1):
      accel/kvm: Don't clear pending #SMI in kvm_get_vcpu_events

Mohamed Mediouni (36):
      target/i386/emulate: rework string_rep emulation
      target/i386: emulate, hvf: move x86_mmu to common code
      whpx: i386: re-enable guest debug support
      whpx: preparatory changes before switching over from winhvemulation
      whpx: refactor whpx_destroy_vcpu to arch-specific function
      whpx: move whpx_get_reg/whpx_set_reg to generic code
      whpx: i386: switch over from winhvemulation to target/i386/emulate
      whpx: i386: flags conversion for target/i386/emulate internal state
      whpx: i386: remove remaining winhvemulation support code
      whpx: i386: remove messages
      whpx: i386: remove CPUID trapping
      whpx: common, i386, arm: rework state levels
      whpx: i386: saving/restoring less state for WHPX_LEVEL_FAST_RUNTIME_STATE
      target/i386: mshv, emulate: move the generic x86 helpers to target/i386/emulate
      target/i386: emulate: 5-level paging for the page table walker
      target/i386: emulate, hvf, mshv: rework MMU code
      hvf: i386: save/restore CR0/2/3
      target/i386: emulate: get rid of write_val_to_mem() helper
      target/i386: emulate: raise an exception on translation fault
      target/i386: emulate: remove fetch_instruction helper too
      target/i386: emulate: propagate memory errors on most reads/writes
      whpx: i386: inject exceptions
      whpx: i386: bump to x2apic
      whpx: i386: ignore send_msi to interrupt vector 0
      target/i386: emulate: propagate errors all the way and stop early
      whpx: x86: remove inaccurate comment
      whpx: x86: kick out of HLT manually when using the kernel-irqchip
      hw: i386: vapic: enable on WHPX with user-mode irqchip
      whpx: i386: move whpx_vcpu_kick_out_of_hlt() invocation to interrupt raise time
      whpx: i386: enable all supported host features
      whpx: i386: enable synthetic processor features
      whpx: i386: warn on unsupported MSR access instead of failing silently
      target/i386: emulate: more 64-bit register handling
      whpx: i386: enable PMU
      whpx: i386: expose HV_X64_MSR_APIC_FREQUENCY when kernel-irqchip=off
      target/i386: emulate: fix scas

myrslint (1):
      KVM: i386: Default disable ignore guest PAT quirk

 MAINTAINERS                                       |  20 +
 docs/system/confidential-guest-support.rst        |   1 +
 docs/system/index.rst                             |   1 +
 docs/system/nitro.rst                             | 133 ++++
 meson.build                                       |  20 +-
 qapi/qom.json                                     |  16 +-
 accel/nitro/trace.h                               |   2 +
 hw/core/eif.h                                     |  41 ++
 hw/nitro/trace.h                                  |   4 +
 include/accel/accel-ops.h                         |   2 +
 include/hw/core/boards.h                          |   6 +
 include/hw/i386/x86.h                             |   1 +
 include/hw/nitro/heartbeat.h                      |  24 +
 include/hw/nitro/machine.h                        |  20 +
 include/hw/nitro/nitro-vsock-bus.h                |  71 +++
 include/hw/nitro/serial-vsock.h                   |  24 +
 include/standard-headers/linux/nitro_enclaves.h   | 359 +++++++++++
 include/system/confidential-guest-support.h       |  20 +
 include/system/hw_accel.h                         |   1 +
 include/system/kvm.h                              |  43 ++
 include/system/kvm_int.h                          |   1 +
 include/system/nitro-accel.h                      |  25 +
 include/system/physmem.h                          |   1 +
 include/system/whpx-accel-ops.h                   |  16 +-
 include/system/whpx-all.h                         |  11 +-
 include/system/whpx-common.h                      |   6 +-
 include/system/whpx-internal.h                    |  16 -
 target/i386/cpu.h                                 |   4 +-
 target/i386/emulate/x86.h                         |   1 +
 target/i386/emulate/x86_emu.h                     |  24 +-
 target/i386/emulate/x86_flags.h                   |  20 +
 target/i386/{hvf => emulate}/x86_mmu.h            |  31 +-
 target/i386/kvm/tdx.h                             |   1 +
 accel/kvm/kvm-all.c                               | 372 +++++++++--
 accel/nitro/nitro-accel.c                         | 284 +++++++++
 accel/stubs/kvm-stub.c                            |  18 +
 accel/stubs/nitro-stub.c                          |  11 +
 accel/whpx/whpx-accel-ops.c                       |   8 +
 accel/whpx/whpx-common.c                          |  68 +-
 audio/audio-mixeng-be.c                           |   2 +-
 audio/paaudio.c                                   |  28 +-
 audio/spiceaudio.c                                |  30 -
 hw/core/eif.c                                     |  38 --
 hw/core/machine.c                                 |  22 +
 hw/hyperv/vmbus.c                                 |  37 ++
 hw/i386/kvm/clock.c                               |  59 ++
 hw/i386/kvm/i8254.c                               |  91 ++-
 hw/i386/vapic.c                                   |  24 +-
 hw/i386/vmmouse.c                                 |  10 +-
 hw/i386/x86-common.c                              |  71 ++-
 hw/intc/openpic_kvm.c                             | 112 +++-
 hw/nitro/heartbeat.c                              | 115 ++++
 hw/nitro/machine.c                                | 277 ++++++++
 hw/nitro/nitro-vsock-bus.c                        |  98 +++
 hw/nitro/serial-vsock.c                           | 123 ++++
 hw/vfio/helpers.c                                 |  91 +++
 stubs/kvm.c                                       |  22 +
 system/physmem.c                                  |  28 +
 system/runstate.c                                 |  44 +-
 target/alpha/cpu.c                                |   1 +
 target/arm/cpu64.c                                |   8 +
 target/arm/whpx/whpx-all.c                        |  43 +-
 target/i386/cpu.c                                 |  41 +-
 target/i386/emulate/x86_decode.c                  |  12 +-
 target/i386/emulate/x86_emu.c                     | 391 ++++++++----
 target/i386/emulate/x86_flags.c                   |  47 ++
 target/i386/{mshv/x86.c => emulate/x86_helpers.c} |  13 +-
 target/i386/emulate/x86_mmu.c                     | 354 ++++++++++
 target/i386/hvf/hvf.c                             |  40 +-
 target/i386/hvf/x86.c                             |  13 +-
 target/i386/hvf/x86_mmu.c                         | 277 --------
 target/i386/hvf/x86_task.c                        |  10 +-
 target/i386/kvm/kvm.c                             | 190 ++++--
 target/i386/kvm/tdx.c                             | 141 ++--
 target/i386/kvm/xen-emu.c                         |  38 +-
 target/i386/mshv/mshv-cpu.c                       |  71 ---
 target/i386/sev.c                                 | 127 +++-
 target/i386/whpx/whpx-all.c                       | 745 +++++++++++-----------
 target/i386/whpx/whpx-apic.c                      |   5 +
 tests/qtest/libqtest.c                            |   1 +
 ui/vdagent.c                                      |  18 -
 util/rcu.c                                        |  81 ++-
 accel/Kconfig                                     |   3 +
 accel/kvm/trace-events                            |   2 +
 accel/meson.build                                 |   1 +
 accel/nitro/meson.build                           |   3 +
 accel/nitro/trace-events                          |   6 +
 accel/stubs/meson.build                           |   1 +
 hw/Kconfig                                        |   1 +
 hw/hyperv/trace-events                            |   1 +
 hw/i386/kvm/trace-events                          |   1 +
 hw/meson.build                                    |   1 +
 hw/nitro/Kconfig                                  |  18 +
 hw/nitro/meson.build                              |   4 +
 hw/nitro/trace-events                             |   8 +
 meson_options.txt                                 |   2 +
 python/scripts/vendor.py                          |   2 +
 python/wheels/meson-1.9.0-py3-none-any.whl        | Bin 1029634 -> 0 bytes
 qemu-options.hx                                   |   8 +-
 rust/Cargo.toml                                   |   1 +
 rust/hw/core/src/qdev.rs                          |  14 +-
 scripts/meson-buildoptions.sh                     |   3 +
 scripts/update-linux-headers.sh                   |   1 +
 stubs/meson.build                                 |   1 +
 target/i386/emulate/meson.build                   |   9 +
 target/i386/hvf/meson.build                       |   1 -
 target/i386/kvm/trace-events                      |   4 +
 target/i386/mshv/meson.build                      |   2 +-
 target/i386/trace-events                          |   1 +
 tests/functional/x86_64/meson.build               |   1 +
 tests/functional/x86_64/test_rebuild_vmfd.py      | 136 ++++
 111 files changed, 4590 insertions(+), 1362 deletions(-)
 create mode 100644 docs/system/nitro.rst
 create mode 100644 accel/nitro/trace.h
 create mode 100644 hw/nitro/trace.h
 create mode 100644 include/hw/nitro/heartbeat.h
 create mode 100644 include/hw/nitro/machine.h
 create mode 100644 include/hw/nitro/nitro-vsock-bus.h
 create mode 100644 include/hw/nitro/serial-vsock.h
 create mode 100644 include/standard-headers/linux/nitro_enclaves.h
 create mode 100644 include/system/nitro-accel.h
 rename target/i386/{hvf => emulate}/x86_mmu.h (51%)
 create mode 100644 accel/nitro/nitro-accel.c
 create mode 100644 accel/stubs/nitro-stub.c
 create mode 100644 hw/nitro/heartbeat.c
 create mode 100644 hw/nitro/machine.c
 create mode 100644 hw/nitro/nitro-vsock-bus.c
 create mode 100644 hw/nitro/serial-vsock.c
 create mode 100644 stubs/kvm.c
 rename target/i386/{mshv/x86.c => emulate/x86_helpers.c} (95%)
 create mode 100644 target/i386/emulate/x86_mmu.c
 delete mode 100644 target/i386/hvf/x86_mmu.c
 create mode 100644 accel/nitro/meson.build
 create mode 100644 accel/nitro/trace-events
 create mode 100644 hw/nitro/Kconfig
 create mode 100644 hw/nitro/meson.build
 create mode 100644 hw/nitro/trace-events
 delete mode 100644 python/wheels/meson-1.9.0-py3-none-any.whl
 create mode 100755 tests/functional/x86_64/test_rebuild_vmfd.py
-- 
2.53.0


