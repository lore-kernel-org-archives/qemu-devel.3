Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBEC3CCD192
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 13:36:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8fC5-0003sW-9X; Tue, 14 Oct 2025 09:36:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v8fC3-0003pl-Jj
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 09:35:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v8fBy-0000nl-3t
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 09:35:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760448946;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=6Qt/vCjEqCy30H1lfCCIXNIVV4QJ2glzD6OL+2x419E=;
 b=UoqUd15JJcHXDJvSH8tjzSPUF6+5ZVBoxK84AV8rBA8M2Zfwn4cAP582B5n9MM5vmR2JUH
 eJT4qR9aEbWQuGw7AtwztNqlOawEIxr1kHAv4aONoAZjapdjyc7xUE1szATjZ+nOYkZNhm
 mIn60tXnj0kJRUC7lpMSVh1QiFmPuWs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-400-ac8wFLfyN9GW7ZSMALq2LQ-1; Tue, 14 Oct 2025 09:35:44 -0400
X-MC-Unique: ac8wFLfyN9GW7ZSMALq2LQ-1
X-Mimecast-MFC-AGG-ID: ac8wFLfyN9GW7ZSMALq2LQ_1760448943
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-401dbafbcfaso4310100f8f.1
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 06:35:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760448943; x=1761053743;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6Qt/vCjEqCy30H1lfCCIXNIVV4QJ2glzD6OL+2x419E=;
 b=Q/DlQqutfq9jscsI/j4oQWyjCR0uhZfW0V+xw6MNN0HN/rq41aooONuaHVsXa3Uv87
 s/OCji0aQdIQVak0hfyBnESMm8dGNp1gFVWsDau16PB9wfL0Yrop3YtXVO+p7H40AIZz
 VOjGucPdM+9FHRJ0pmGwaQXAFy+lXra6eECLvuXOxR5AOG3zO5uEQYIRjaPGBa1qRS/m
 5F8zRt4M1wDZpkLwgMAMpxbNBI69+wev95SFv4rUIC8EuamqnEbRxo3TVbOWGFSzvHSw
 sZVbKfK7CPHh2zbZBFuz8ljTWMhU4zNmwI2lo+VZLm7egAteaN211lGBlaUap86bcp+D
 RGOQ==
X-Gm-Message-State: AOJu0YxAbl+6Pvj6ixS8LxJhMfH+igswL5KYFHKXk/JsiTYGBisTd442
 liY1RrutKuzGr7yxDLHXgh9GgIx19BiyvsGZYZiWIK/MDsxpC6drTN7X/c2lJYoHyrf5GkSLxrr
 2Y4PVLXq60e9m3tMrVFDCuWY+CF+PA+N//lRH9GaQRUVQaoYmry8gdSrEHrDbTlU09HIewhLVTT
 8+Mxs34wYu6fwvOjMKNIDvHIEkz7KuxYkCb3ygxH8g
X-Gm-Gg: ASbGncu/5ziFNtGzBDIbBnjvvdjGK1MeEZNObg32QxUonk/GfPEZh5XhbE1xSCXbN/9
 3q4djNJMk9QnHxL8nT/hWec+28q0aTSuoYPS2mQbJOdY3PE1KqRqEeqiDtrbothSdp3V1Mh93E5
 WPuLuJSDpLSFGWUdXsuGX9WGlwXalJgRPKoKaL00x79h/bdVjmpTdlKf3BFVKzLmViO46Q/jz5C
 ARP9ZxorqgMxPJ575bBgUIy9b/HTmlAPmP0oMy7n8DBx0/ryT0dDmEa+vwi6D2YQhbEfLNseTzF
 IApjVk76HLd3DChcdkPoZ5o6nTWhmAScXlRbG+m7gHQI5zJyF0ZPnBEW7uZYnCG5Kr8L94YyDNH
 QGqG4AXiXhcDKlQKn7Dd2CwyGvk92DtRpODgjK0vd+4Y=
X-Received: by 2002:a05:600d:8108:b0:46e:4580:c6c5 with SMTP id
 5b1f17b1804b1-46fa9b175a6mr175697795e9.35.1760448942673; 
 Tue, 14 Oct 2025 06:35:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFwJXReU6sgs47zoxZnfAiLnnJ+AigEUGwbITz5Xg3Lp/qcr3b69CTW0EhS4naGszLp7X9BXw==
X-Received: by 2002:a05:600d:8108:b0:46e:4580:c6c5 with SMTP id
 5b1f17b1804b1-46fa9b175a6mr175697485e9.35.1760448942142; 
 Tue, 14 Oct 2025 06:35:42 -0700 (PDT)
Received: from [192.168.10.48] ([151.61.22.175])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce5cfe74sm23437902f8f.35.2025.10.14.06.35.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Oct 2025 06:35:41 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/28] Rust, i386, accelerator changes for 2025-10-14
Date: Tue, 14 Oct 2025 15:35:12 +0200
Message-ID: <20251014133540.1103268-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The following changes since commit 94474a7733a57365d5a27efc28c05462e90e8944:

  Merge tag 'pull-loongarch-20251009' of https://github.com/gaosong715/qemu into staging (2025-10-09 07:59:29 -0700)

are available in the Git repository at:

  https://gitlab.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to 7ee5875d423598ac55a0b55881d9a1ee5c3c7daf:

  rust: migration: implement ToMigrationState as part of impl_vmstate_bitsized (2025-10-14 14:43:54 +0200)

----------------------------------------------------------------
* rust: fix nightly warnings
* target/i386: a smattering of fixes
* monitor: add "info accelerators"
* kvm: cleanups to kvm_cpu_synchronize_put()
* target/i386: Add TSA attack variants and verw-clear feature flag
* async: tsan bottom half fixes
* rust: migration state wrappers with support for BQL-free devices

----------------------------------------------------------------
Babu Moger (2):
      target/i386: Add TSA attack variants TSA-SQ and TSA-L1
      target/i386: Add TSA feature flag verw-clear

Jon Kohler (1):
      i386/kvm: Expose ARCH_CAP_FB_CLEAR when invulnerable to MDS

Mathias Krause (1):
      target/i386: Fix CR2 handling for non-canonical addresses

Paolo Bonzini (20):
      rust: pl011: fix warning with new clippy
      rust: bits: disable double_parens check
      rust: migration: hide more warnings from call_func_with_field!
      rust: hpet: fix fw_cfg handling
      i386/cpu: Prevent delivering SIPI during SMM in TCG mode
      target/i386: fix access to the T bit of the TSS
      async: access bottom half flags with qatomic_read
      target/i386: user: do not set up a valid LDT on reset
      monitor: clarify "info accel" help message
      monitor: generalize query-mshv/"info mshv" to query-accelerators/"info accelerators"
      rust: bql: add BqlRefCell::get_mut()
      rust: migration: do not pass raw pointer to VMStateDescription::fields
      rust: migration: do not store raw pointers into VMStateSubsectionsWrapper
      rust: migration: validate termination of subsection arrays
      rust: migration: extract vmstate_fields_ref
      rust: move VMState from bql to migration
      rust: migration: add high-level migration wrappers
      rust: qemu-macros: add ToMigrationState derive macro
      timer: constify some functions
      rust: migration: implement ToMigrationState as part of impl_vmstate_bitsized

Philippe Mathieu-Daudé (2):
      accel/kvm: Introduce KvmPutState enum
      accel/kvm: Factor kvm_cpu_synchronize_put() out

Thomas Ogrisegg (1):
      target/i386: fix x86_64 pushw op

YiFei Zhu (1):
      i386/tcg/smm_helper: Properly apply DR values on SMM entry / exit

 docs/devel/rust.rst                     |   1 +
 qapi/accelerator.json                   |  47 +++-
 include/monitor/hmp.h                   |   2 +-
 include/qemu/timer.h                    |   6 +-
 include/system/kvm.h                    |  16 +-
 target/i386/cpu.h                       |   8 +
 accel/kvm/kvm-all.c                     |  47 ++--
 hw/core/machine-hmp-cmds.c              |  21 +-
 hw/core/machine-qmp-cmds.c              |  20 +-
 hw/intc/apic.c                          |   2 -
 target/arm/kvm.c                        |   2 +-
 target/i386/cpu.c                       |  23 +-
 target/i386/helper.c                    |   4 +
 target/i386/kvm/kvm.c                   |  23 +-
 target/i386/tcg/seg_helper.c            |   2 +-
 target/i386/tcg/system/excp_helper.c    |   3 +-
 target/i386/tcg/system/seg_helper.c     |   1 +
 target/i386/tcg/system/smm_helper.c     |  10 +-
 target/loongarch/kvm/kvm.c              |   4 +-
 target/mips/kvm.c                       |   6 +-
 target/ppc/kvm.c                        |   2 +-
 target/riscv/kvm/kvm-cpu.c              |   2 +-
 target/s390x/kvm/kvm.c                  |   2 +-
 util/async.c                            |  11 +-
 util/qemu-timer.c                       |   8 +-
 target/i386/tcg/decode-new.c.inc        |   2 +-
 hmp-commands-info.hx                    |  19 +-
 rust/Cargo.lock                         |   3 +-
 rust/bql/Cargo.toml                     |   1 -
 rust/bql/meson.build                    |   1 -
 rust/bql/src/cell.rs                    |  23 +-
 rust/hw/char/pl011/src/registers.rs     |   1 +
 rust/hw/timer/hpet/src/fw_cfg.rs        |   4 +-
 rust/meson.build                        |   2 +-
 rust/migration/Cargo.toml               |   2 +
 rust/migration/meson.build              |   7 +-
 rust/migration/src/lib.rs               |   5 +
 rust/migration/src/migratable.rs        | 442 ++++++++++++++++++++++++++++++++
 rust/migration/src/vmstate.rs           |  86 ++++---
 rust/qemu-macros/src/lib.rs             |  97 ++++++-
 rust/qemu-macros/src/migration_state.rs | 298 +++++++++++++++++++++
 rust/qemu-macros/src/tests.rs           | 113 +++++++-
 42 files changed, 1230 insertions(+), 149 deletions(-)
 create mode 100644 rust/migration/src/migratable.rs
 create mode 100644 rust/qemu-macros/src/migration_state.rs
-- 
2.51.0


