Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C899BC25B7E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 06:48:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sENuA-0001tT-8X; Tue, 04 Jun 2024 02:44:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sENu8-0001tE-Dw
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 02:44:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sENu6-0007DE-Ce
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 02:44:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717483457;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:  content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=5tfVh19Jz3v9eHuHwUJ7uxqcc0LIdrHQjN+tlfZic74=;
 b=BWyocOEkFaKiyaEO7vEWhCkRbvd/+69FVl4DE9IqhSWB+idVQN3z4rs7qcMNwz1wDpfxWf
 fdkAlJcUnt215RoKJzn8yUMDEFWkI7V9oZzIbCdfVfnFx7HcZIzItLbUZfG4fwqiScH2GY
 BtOBPLaT3ZiWLED8dAtmB8Wb7kFbIFI=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-29-z7GRM_-SNwK5lmnLWHGaFA-1; Tue, 04 Jun 2024 02:44:15 -0400
X-MC-Unique: z7GRM_-SNwK5lmnLWHGaFA-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-57a22ad0d04so935534a12.3
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 23:44:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717483453; x=1718088253;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5tfVh19Jz3v9eHuHwUJ7uxqcc0LIdrHQjN+tlfZic74=;
 b=volxz6fxApL84R96oO2Yq3M2ATG1fAwo/vNKPUbghX70505AfC7Bx9h35qatLOtntQ
 47Bi4FaGuVrdWfmRNJai4cxkFKWzWgL5tC/PC0gwWDn1kMrUj0CGdZnnfCCuu/0rUK6Q
 c5NiROCY31wSfEQdmmxvQZVyajd+FoYxpe0I3izrRRuNxKUVNrNEEHfTZLbxPFj9uLkq
 8K+GVdyO0AujCKQhjWXeek6gMjqh2MszJqT3GjorY3O9GnCeiokQbgFoPIQR1X/y6R4I
 cPsr5QeopDsbwB0NIwkzLhJZvrQg80pNDVO1PCMdAFL5ia2NlA5fOjhX7F7OPAlvdaQm
 /KOQ==
X-Gm-Message-State: AOJu0Ywj68RPQqP805vulJ4VKWakn2RxMuVt/EgxxrEZuoNfituqDJ4R
 uzvQ45iAvuRav2kZgAEIflCpOH5ZhBNdohKcuA9i8GbqNPHceA2qGv9Y5JbIq84/bjWWEWt8Kq/
 u9NnVcQsYtFHDtUfi3Trob87wCbuzovF6niHLTH10DWud3yk6QKICQ1zn8883eSfBWun8yzqXzR
 qnxfgxlLfYotrwW8sOwSBY5CVv4YotK4WKiYrt
X-Received: by 2002:a50:d756:0:b0:57a:6eb4:101a with SMTP id
 4fb4d7f45d1cf-57a6eb41079mr2230150a12.39.1717483453218; 
 Mon, 03 Jun 2024 23:44:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IECbXUT/WrwkW1vU3oOmCctUVjTEnHyiN7Lv6Lm7l2HRfUQVotXiLegdYxXfEV+BxgApe6ObQ==
X-Received: by 2002:a50:d756:0:b0:57a:6eb4:101a with SMTP id
 4fb4d7f45d1cf-57a6eb41079mr2230139a12.39.1717483452624; 
 Mon, 03 Jun 2024 23:44:12 -0700 (PDT)
Received: from avogadro.local ([151.81.115.112])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57a31bb83f0sm6688651a12.35.2024.06.03.23.44.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jun 2024 23:44:12 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/45] mostly i386 patches for 2024-06-04
Date: Tue,  4 Jun 2024 08:43:24 +0200
Message-ID: <20240604064409.957105-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The following changes since commit 3b2fe44bb7f605f179e5e7feb2c13c2eb3abbb80:

  Merge tag 'pull-request-2024-05-29' of https://gitlab.com/thuth/qemu into staging (2024-05-29 08:38:20 -0700)

are available in the Git repository at:

  https://gitlab.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to ba849076b6fc2290275ce7491547f6ae831cd2aa:

  hw/i386: Add support for loading BIOS using guest_memfd (2024-06-04 08:40:46 +0200)

----------------------------------------------------------------
* virtio-blk: remove SCSI passthrough functionality
* require x86-64-v2 baseline ISA
* SEV-SNP host support
* fix xsave.flat with TCG
* fixes for CPUID checks done by TCG

----------------------------------------------------------------
Brijesh Singh (6):
      i386/sev: Introduce 'sev-snp-guest' object
      i386/sev: Add the SNP launch start context
      i386/sev: Add handling to encrypt/finalize guest launch data
      hw/i386/sev: Add function to get SEV metadata from OVMF header
      i386/sev: Add support for populating OVMF metadata pages
      hw/i386/sev: Add support to encrypt BIOS when SEV-SNP is enabled

Dov Murik (3):
      i386/sev: Extract build_kernel_loader_hashes
      i386/sev: Reorder struct declarations
      i386/sev: Allow measured direct kernel boot on SNP

Michael Roth (11):
      i386/sev: Introduce "sev-common" type to encapsulate common SEV state
      i386/sev: Add a sev_snp_enabled() helper
      i386/cpu: Set SEV-SNP CPUID bit when SNP enabled
      i386/sev: Don't return launch measurements for SEV-SNP guests
      i386/sev: Update query-sev QAPI format to handle SEV-SNP
      i386/sev: Set CPU state to protected once SNP guest payload is finalized
      i386/sev: Add support for SNP CPUID validation
      i386/kvm: Add KVM_EXIT_HYPERCALL handling for KVM_HC_MAP_GPA_RANGE
      i386/sev: Enable KVM_HC_MAP_GPA_RANGE hcall for SNP guests
      hw/i386/sev: Use guest_memfd for legacy ROMs
      hw/i386: Add support for loading BIOS using guest_memfd

Pankaj Gupta (7):
      linux-headers: Update to current kvm/next
      i386/sev: Replace error_report with error_setg
      i386/sev: Move sev_launch_update to separate class method
      i386/sev: Move sev_launch_finish to separate class method
      i386/sev: Add sev_kvm_init() override for SEV class
      i386/sev: Add snp_kvm_init() override for SNP class
      i386/sev: Invoke launch_updata_data() for SNP class

Paolo Bonzini (14):
      virtio-blk: remove SCSI passthrough functionality
      host/i386: nothing looks at CPUINFO_SSE4
      meson: assume x86-64-v2 baseline ISA
      host/i386: assume presence of CMOV
      host/i386: assume presence of SSE2
      host/i386: assume presence of SSSE3
      host/i386: assume presence of POPCNT
      target/i386: fix xsave.flat from kvm-unit-tests
      update-linux-headers: fix forwarding to asm-generic headers
      update-linux-headers: move pvpanic.h to correct directory
      update-linux-headers: import linux/kvm_para.h header
      machine: allow early use of machine_require_guest_memfd
      i386/sev: Add a class method to determine KVM VM type for SNP guests
      i386/sev: Invoke launch_updata_data() for SEV class

Xiaoyao Li (1):
      memory: Introduce memory_region_init_ram_guest_memfd()

Xinyu Li (2):
      target/i386: fix SSE and SSE2 feature check
      target/i386: fix memory opsize for Mov to/from Seg

Zhao Liu (1):
      target/i386/tcg: Fix RDPID feature check

 docs/about/deprecated.rst                          |   10 -
 docs/about/removed-features.rst                    |    8 +
 docs/system/i386/amd-memory-encryption.rst         |   70 +-
 meson.build                                        |   10 +-
 qapi/misc-target.json                              |   72 +-
 qapi/qom.json                                      |   98 +-
 host/include/i386/host/cpuinfo.h                   |    4 -
 include/exec/confidential-guest-support.h          |    5 +
 include/exec/memory.h                              |    6 +
 include/hw/boards.h                                |    1 -
 include/hw/i386/pc.h                               |   28 +
 include/hw/i386/x86.h                              |    2 +-
 include/standard-headers/linux/kvm_para.h          |   38 +
 include/standard-headers/{linux => misc}/pvpanic.h |    0
 linux-headers/asm-loongarch/kvm.h                  |    4 +
 linux-headers/asm-riscv/kvm.h                      |    1 +
 linux-headers/asm-x86/kvm.h                        |   52 +-
 linux-headers/asm-x86/kvm_para.h                   |    1 +
 linux-headers/linux/kvm_para.h                     |    2 +
 linux-headers/linux/vhost.h                        |   15 +-
 target/i386/kvm/kvm_i386.h                         |    1 +
 target/i386/sev.h                                  |   13 +-
 target/i386/tcg/decode-new.h                       |    3 +
 tcg/i386/tcg-target.h                              |    5 +-
 hw/block/virtio-blk.c                              |  166 +-
 hw/core/machine.c                                  |    4 +-
 hw/i386/pc.c                                       |   14 +-
 hw/i386/pc_sysfw.c                                 |   35 +-
 hw/i386/x86-common.c                               |   19 +-
 hw/misc/pvpanic-isa.c                              |    2 +-
 hw/misc/pvpanic-pci.c                              |    2 +-
 hw/misc/pvpanic.c                                  |    2 +-
 system/memory.c                                    |   24 +
 target/i386/cpu.c                                  |    1 +
 target/i386/kvm/kvm.c                              |   56 +
 target/i386/sev-sysemu-stub.c                      |    6 +-
 target/i386/sev.c                                  | 1581 +++++++++++++++-----
 target/i386/tcg/fpu_helper.c                       |    5 +
 target/i386/tcg/translate.c                        |    2 +-
 util/bufferiszero.c                                |    4 +-
 util/cpuinfo-i386.c                                |    8 +-
 target/i386/tcg/decode-new.c.inc                   |   17 +-
 tcg/i386/tcg-target.c.inc                          |   15 +-
 scripts/update-linux-headers.sh                    |   37 +-
 target/i386/kvm/trace-events                       |    1 +
 target/i386/trace-events                           |    3 +
 46 files changed, 1844 insertions(+), 609 deletions(-)
 create mode 100644 include/standard-headers/linux/kvm_para.h
 rename include/standard-headers/{linux => misc}/pvpanic.h (100%)
 create mode 100644 linux-headers/asm-x86/kvm_para.h
 create mode 100644 linux-headers/linux/kvm_para.h
-- 
2.45.1


