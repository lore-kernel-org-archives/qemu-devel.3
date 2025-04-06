Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1683AC3600C
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Apr 2025 07:03:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u1K2I-0002s3-AM; Sun, 06 Apr 2025 03:03:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u1K27-0002rW-BO
 for qemu-devel@nongnu.org; Sun, 06 Apr 2025 03:03:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u1K25-0001yg-D2
 for qemu-devel@nongnu.org; Sun, 06 Apr 2025 03:03:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743922982;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=0vfGbmZUC9TMIWT2As6iMms8A46klCahIjdQmjXBp8M=;
 b=fRt8KcjhUtWZmGEHo/hl8Ix+Poqa1ZT1iuoaRRdXCjytkBiH104yrfCFG8iCCpVlomedVh
 o/O+z9ooJTm9MO+uBQhdCzwfX+3mVQZ409hhrOnILe9MOLoAB+w5ONdtQIVYFQDH809suT
 v1etvdifGyqABB/s8InrrSW8U2apBPs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-445-wK8xuyOdO2-q5ep2fUGDrQ-1; Sun, 06 Apr 2025 03:03:00 -0400
X-MC-Unique: wK8xuyOdO2-q5ep2fUGDrQ-1
X-Mimecast-MFC-AGG-ID: wK8xuyOdO2-q5ep2fUGDrQ_1743922979
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43cf5196c25so18748505e9.0
 for <qemu-devel@nongnu.org>; Sun, 06 Apr 2025 00:03:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743922978; x=1744527778;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0vfGbmZUC9TMIWT2As6iMms8A46klCahIjdQmjXBp8M=;
 b=Qd9y9dT+UpCy751B7853q9I5otM2IJwlJST+tqxypVpNw2LyBrhVWUHYvgyf8tlxbL
 LqY+v0JWdXmOcjIiqcmUcLGwdZ4rjRC3fe4dm7sGqc5RdiUNnqc8Ndd2Xa5w88joHhle
 4sA3XAxwFt7pNgvzRA9FqnC0j1UWNrEQl/NYVrVtu3SG/MnM84FY6ZobcIrF7BQrSEXV
 VioS91QHgrBPdebL/uPgq+CCscv446n0DeaJ8Fk7EquMdQNMBa+UhFpaK4bu5l45QtMi
 DPC++bgCFvB8lxn2M579B6O0qPXlFibDnwztRvtXf7sa79xwW/EqXibwUzlqJq+m0Oed
 M1oA==
X-Gm-Message-State: AOJu0YyIz173/i3E5ul/9u7i7RNRP3kutw+3lb6VzzOX5FrFoZLCqsLy
 DiWhBi1To18TjOeB+ImdMx7qQ3csag8EhoQePePmadgJrAxudR7ifVX5n1ZAYQHLj4b7zQmso9t
 z4++nwXabUls3hKv3ekUtlgecczOagwJ56BBQ6Lq+fKVylOs9bZqgsvnjcYglN+m8kYCW65XkgP
 grhkd4d0UGaj4b1A8zZIxIUj9DV5SrrV5j9N9M
X-Gm-Gg: ASbGncsTgWGatm5GLarWmyeeQQlnCb9H1kTV8rxdcOxjZIVhzJRneGY5UsOClPDohrU
 Ug2Yr6ObG4t8ODVxrfJZfGwQj+6R6LwnD4r+MXUEWgBHF5x7cq+zLvGdfpD+IZwiyRwphmCuzeD
 2FAGbOmILbjPgz5VDx9B0r70NDdsOgCL4Bl/qjKDmfQMxPgW/OpvCqoy9eChjn8NfHjI70wj3Wl
 q1OknsE9Hnsoy3k35W4yobPcf8fo/rJMlCa4zaBF3i9rqUDiz0Z9VD3wCoUvxoIR1pw4jzWRka6
 ELXq+W2bnwbHfauHrQ==
X-Received: by 2002:a05:600c:3494:b0:43c:f8fc:f697 with SMTP id
 5b1f17b1804b1-43ed0bc8d96mr79818275e9.9.1743922977730; 
 Sun, 06 Apr 2025 00:02:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFCXbYxSW1R5+2hjnRVWB5wxtm42+ASXUJGJ4lRIRa7Ox8VsQ5ziiziu85nCTcFRDHzH0o9eg==
X-Received: by 2002:a05:600c:3494:b0:43c:f8fc:f697 with SMTP id
 5b1f17b1804b1-43ed0bc8d96mr79818015e9.9.1743922977369; 
 Sun, 06 Apr 2025 00:02:57 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.96.77])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec1663060sm96291055e9.14.2025.04.06.00.02.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Apr 2025 00:02:56 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com
Subject: [PATCH 10.1 v3 00/27] target/riscv: SATP mode and CPU definition
 overhaul
Date: Sun,  6 Apr 2025 09:02:27 +0200
Message-ID: <20250406070254.274797-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.359,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This is the combination of the previously posted series to store max SATP
mode in RISCVCPUConfig as a single integer, and convert CPU definitions
to a small extension of RISCVCPUConfig called RISCVCPUDef.  I put them
together because the first part (patches 1-6) is already acked/reviewed.

As mentioned in the earlier submissions, the main reason for me to do this
is to remove .instance_post_init, which RISC-V is using in a slightly different
way than everyone else.  Whereas other uses (including x86, which is
currently buggy, and Rust) would prefer to call .instance_post_init
from root to leaf, RISC-V needs it to be called from leaf (CPU model)
to parent (DeviceState).  The fix is to move the logic of the former
.instance_post_init callback for the leaf at the end of the leaf's
.instance_init, as done in this series.

Paolo

Supersedes: <20250228102747.867770-1-pbonzini@redhat.com>

Paolo Bonzini (27):
  hw/riscv: acpi: only create RHCT MMU entry for supported types
  target/riscv: assert argument to set_satp_mode_max_supported is valid
  target/riscv: cpu: store max SATP mode as a single integer
  target/riscv: update max_satp_mode based on QOM properties
  target/riscv: remove supported from RISCVSATPMap
  target/riscv: move satp_mode.{map,init} out of CPUConfig
  target/riscv: introduce RISCVCPUDef
  target/riscv: store RISCVCPUDef struct directly in the class
  target/riscv: merge riscv_cpu_class_init with the class_base function
  target/riscv: move RISCVCPUConfig fields to a header file
  target/riscv: include default value in cpu_cfg_fields.h.inc
  target/riscv: do not make RISCVCPUConfig fields conditional
  target/riscv: add more RISCVCPUDef fields
  target/riscv: convert abstract CPU classes to RISCVCPUDef
  target/riscv: convert profile CPU models to RISCVCPUDef
  target/riscv: convert bare CPU models to RISCVCPUDef
  target/riscv: convert dynamic CPU models to RISCVCPUDef
  target/riscv: convert SiFive E CPU models to RISCVCPUDef
  target/riscv: convert ibex CPU models to RISCVCPUDef
  target/riscv: convert SiFive U models to RISCVCPUDef
  target/riscv: th: make CSR insertion test a bit more intuitive
  target/riscv: generalize custom CSR functionality
  target/riscv: convert TT C906 to RISCVCPUDef
  target/riscv: convert TT Ascalon to RISCVCPUDef
  target/riscv: convert Ventana V1 to RISCVCPUDef
  target/riscv: convert Xiangshan Nanhu to RISCVCPUDef
  target/riscv: remove .instance_post_init

 target/riscv/cpu-qom.h            |    2 +
 target/riscv/cpu.h                |   42 +-
 target/riscv/cpu_cfg.h            |  180 +----
 target/riscv/cpu_cfg_fields.h.inc |  170 +++++
 hw/riscv/boot.c                   |    2 +-
 hw/riscv/virt-acpi-build.c        |   15 +-
 hw/riscv/virt.c                   |    5 +-
 target/riscv/cpu.c                | 1014 +++++++++++++----------------
 target/riscv/csr.c                |   11 +-
 target/riscv/gdbstub.c            |    6 +-
 target/riscv/kvm/kvm-cpu.c        |   27 +-
 target/riscv/machine.c            |    2 +-
 target/riscv/tcg/tcg-cpu.c        |   13 +-
 target/riscv/th_csr.c             |   30 +-
 target/riscv/translate.c          |    2 +-
 15 files changed, 729 insertions(+), 792 deletions(-)
 create mode 100644 target/riscv/cpu_cfg_fields.h.inc

-- 
2.49.0


