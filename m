Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 676E9D25931
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 09:39:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkfXm-0000fs-B3; Tue, 27 Jan 2026 04:39:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vkfXZ-0000cu-F2
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 04:39:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vkfXU-0008Sv-I2
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 04:39:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769506751;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ZBackyN1MOwJFrQB3LsDv03Ihk1d3s/jsyAigKeSZ8o=;
 b=YOI8IFfqk+RVUD7R/7epgjNWZFZuUc7k26Daf46KpsHJNY/lXuD7VjjcVn3p/YWcqWZDti
 z/63DRkawcKsEXvC8uEoL3ezm61YGMidq/STTduqX8vEdL9ArziB+aNH7BcspAjQzh7VKo
 Xp3Gc9UFRUEUbyRSv67kSZ4GtDEcCb4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-CP4g0q-EMYSKP67PmcGtVA-1; Tue, 27 Jan 2026 04:39:10 -0500
X-MC-Unique: CP4g0q-EMYSKP67PmcGtVA-1
X-Mimecast-MFC-AGG-ID: CP4g0q-EMYSKP67PmcGtVA_1769506749
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-47ee7346f8bso39365265e9.2
 for <qemu-devel@nongnu.org>; Tue, 27 Jan 2026 01:39:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769506748; x=1770111548; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=ZBackyN1MOwJFrQB3LsDv03Ihk1d3s/jsyAigKeSZ8o=;
 b=Rr+uLOY0E8EfxjobfF7OvOPUdHch6+fkngQ0GMhS3eqbgQ/03AduddW70M8LKp86K4
 SIsuCFqzP5j9pZZfWhOC6ysb/o0c22YYK+hRJ8C8hZxh4JDP0o3w9/ga3HfbM+TjuaPE
 FxuaKGtwd2mWmYrcBYPNLbnObCiiGn5OlFqKEnAYvv+S2zOweRw71mW2/Buhw1q6/3kH
 Y5f37cH63+YbwytHgI4jMhwVlVrcAUgPbxuiJ/AK7Cowez0KeHzUgGhay18tOrpzPaKe
 PUbhu1Np1Pqw0cdC1ibIssaBRtojS370M0HTKAeqZAPoMTfWG4SRCw8K/PIDuFJPRHhK
 6tjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769506748; x=1770111548;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZBackyN1MOwJFrQB3LsDv03Ihk1d3s/jsyAigKeSZ8o=;
 b=FCXYNRB2+AKKJz44pwAds2C99E2JXOPycyAbpTLspB1esqVvoHfQe2waOKOFT4JGfk
 LgYzojIo0zg8EgcKPSShPW6KFWmRztLF6AvEdb+bVL6F7V3kg0YNyhUmCSQEKq63Ep/a
 QmWCINtncZ1m7JczsEs/xMruj+DhVtMxBAthwypq07jttfrQGGlXAMFh37ZTMZnJjuDM
 9zIvprjA4pDoqM5oTTzgzDzA686n/7odN1/U02A4jR+QuenZvNKodvXAftn5YAinXD+p
 IWIC968gdNXmFo/2i0RqBcKsDKm4VbdcsQUfQhm6J4lOHo0FozqNMlFqiDxq03JZGHti
 sVPQ==
X-Gm-Message-State: AOJu0Yy4/ug8609yp1aZeq1e/QRdM3CDZNIGSQ822HX6woshhRxgm+Xi
 /y30iLHS52c40xxHpttKd0uRIh3A6NeVJvcWjLM8F7rSM8BBBlAe88XPiAiy3cqlTdTGx0fOjZ0
 ovqpQaaDq6tW1Em0AAOgWCfRIdDgtjMkjYbvNVyq2b+gvs185RRyOzSps2xGToDQVLbH1Xqj3ZI
 eMlR87mfXBr/mqffHZvasck43GxDmH2OXDWP96OwWC
X-Gm-Gg: AZuq6aJhPsGJuDovQJbHFtRgEWYeQaW8gQSNKyXzlrRPKhSUvoIaD9ybQh3PBuUatoi
 +/jYeBZjKk6tNWqSvjNGedjIiimSIuQCRsQG/WnBBciN9WxJijRoKT1qYiHaJMgMCs8uK1dFI46
 YQ/MSeepm0yGDoRYge25GQgSNKYpvCOYL5NSWEoVYSx0PtYEh8DHvRyMtT2tNReZd30XU/0SMbK
 JD6X3idi8q7AXiHC5+P2pzOI6nvpNt0EjIQaoz7pGuCvrbUIoAIeREwyU2QJuqV732CJppVqIgc
 MxRDNCYf/YUp9MX2HH5yEs5WWOHZfJ1ra6L2GLefFmmALs+tcnoBuohiY++6jyM7zylEG1voDMi
 DF/8fKzYFpJxJgaritXJGlFZJBJrxN+G2EHaWQ1+F+IjIfHBphKEr/5Kqg77lE3acK3gk9pohdm
 PSXlfVIIj+WpC5MA==
X-Received: by 2002:a05:600c:a08c:b0:477:63db:c718 with SMTP id
 5b1f17b1804b1-48069c43e80mr14610495e9.16.1769506748191; 
 Tue, 27 Jan 2026 01:39:08 -0800 (PST)
X-Received: by 2002:a05:600c:a08c:b0:477:63db:c718 with SMTP id
 5b1f17b1804b1-48069c43e80mr14610175e9.16.1769506747647; 
 Tue, 27 Jan 2026 01:39:07 -0800 (PST)
Received: from [192.168.10.48] ([151.61.26.160])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4804d3ac45bsm128202205e9.0.2026.01.27.01.39.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 01:39:06 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/13] Rust, i386 changes for 2026-01-27
Date: Tue, 27 Jan 2026 10:38:53 +0100
Message-ID: <20260127093906.353741-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
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

The following changes since commit f26976b9d30496d28bd4fd045f4300706e567a29:

  Merge tag 'pull-vfio-20260126' of https://github.com/legoater/qemu into staging (2026-01-27 07:14:11 +1100)

are available in the Git repository at:

  https://gitlab.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to df8dfc3b6080713c2dbd7ef37c2c85a78e502cd6:

  rust/hpet: remove stale TODO comment (2026-01-27 10:37:11 +0100)

----------------------------------------------------------------
* rust: move binding generation to bindings/
* rust: fixes for Windows
* target/i386/tcg: fix a few instructions that do not support VEX.L=1
* target/i386/tcg: various cleanups

----------------------------------------------------------------
Marc-André Lureau (1):
      rust: move binding generation to bindings/

Mohd Kashif Khan (1):
      rust/hpet: remove stale TODO comment

Paolo Bonzini (11):
      rust: trace: libc does not have syslog on windows
      rust: hwcore: add chardev symbols to integration tests
      rust: move class_init to an extension trait
      rust: move hwcore::sysbus to system crate
      qdev: add hw/core/gpio.c to libhwcore
      target/i386/tcg: fix a few instructions that do not support VEX.L=1
      target/i386/tcg: fix typo in dpps/dppd instructions
      target/i386/tcg: remove dead constants
      target/i386/tcg: merge decode_modrm and decode_modrm_address split
      target/i386/tcg: replace havesib variable with the SIB byte itself
      target/i386/tcg: cleanup #ifdef TARGET_X86_64

 docs/devel/rust.rst                                |  57 +++++++
 meson.build                                        |   3 +-
 rust/bindings/chardev-sys/wrapper.h                |  12 ++
 rust/bindings/hwcore-sys/wrapper.h                 |  30 ++++
 rust/bindings/migration-sys/wrapper.h              |  10 ++
 rust/bindings/qom-sys/wrapper.h                    |  17 +++
 rust/bindings/system-sys/wrapper.h                 |  21 +++
 rust/bindings/util-sys/wrapper.h                   |  39 +++++
 rust/bql/wrapper.h                                 |  27 ----
 rust/chardev/wrapper.h                             |  28 ----
 rust/hw/core/wrapper.h                             |  32 ----
 rust/migration/wrapper.h                           |  51 -------
 rust/qom/wrapper.h                                 |  27 ----
 rust/system/wrapper.h                              |  29 ----
 rust/util/wrapper.h                                |  32 ----
 target/i386/tcg/translate.c                        |  35 +----
 target/i386/tcg/decode-new.c.inc                   |  85 +++++------
 target/i386/tcg/emit.c.inc                         |  22 ++-
 hw/core/meson.build                                |   2 +-
 rust/Cargo.lock                                    |  68 +++++++++
 rust/{util => bindings}/build.rs                   |  30 ++--
 rust/bindings/chardev-sys/Cargo.toml               |  28 ++++
 rust/bindings/chardev-sys/build.rs                 |   1 +
 .../bindings.rs => bindings/chardev-sys/lib.rs}    |   7 +-
 rust/bindings/chardev-sys/meson.build              |  12 ++
 rust/bindings/generate_bindgen_args.py             | 164 +++++++++++++++++++++
 rust/bindings/hwcore-sys/Cargo.toml                |  32 ++++
 rust/bindings/hwcore-sys/build.rs                  |   1 +
 .../src/bindings.rs => bindings/hwcore-sys/lib.rs} |  17 +--
 rust/bindings/hwcore-sys/meson.build               |  12 ++
 rust/bindings/meson.build                          |  37 +++++
 rust/bindings/migration-sys/Cargo.toml             |  28 ++++
 rust/bindings/migration-sys/build.rs               |   1 +
 rust/bindings/migration-sys/lib.rs                 | 125 ++++++++++++++++
 rust/bindings/migration-sys/meson.build            |  12 ++
 rust/bindings/qom-sys/Cargo.toml                   |  25 ++++
 rust/bindings/qom-sys/build.rs                     |   1 +
 .../src/bindings.rs => bindings/qom-sys/lib.rs}    |   4 +
 rust/bindings/qom-sys/meson.build                  |  12 ++
 rust/bindings/system-sys/Cargo.toml                |  30 ++++
 rust/bindings/system-sys/build.rs                  |   1 +
 .../src/bindings.rs => bindings/system-sys/lib.rs} |   4 +-
 rust/bindings/system-sys/meson.build               |  12 ++
 rust/bindings/util-sys/Cargo.toml                  |  25 ++++
 rust/bindings/util-sys/build.rs                    |   1 +
 .../src/bindings.rs => bindings/util-sys/lib.rs}   |   2 +-
 rust/bindings/util-sys/meson.build                 |  12 ++
 rust/bql/Cargo.toml                                |   1 +
 rust/bql/build.rs                                  |   1 -
 rust/bql/meson.build                               |  30 +---
 rust/bql/src/bindings.rs                           |  27 ----
 rust/bql/src/lib.rs                                |   3 +-
 rust/chardev/Cargo.toml                            |   1 +
 rust/chardev/build.rs                              |   1 -
 rust/chardev/meson.build                           |  37 +----
 rust/chardev/src/lib.rs                            |   2 +-
 rust/hw/char/pl011/build.rs                        |   2 +-
 rust/hw/char/pl011/meson.build                     |  21 +--
 rust/hw/char/pl011/src/bindings.rs                 |   7 +-
 rust/hw/core/Cargo.toml                            |   2 +-
 rust/hw/core/build.rs                              |   1 -
 rust/hw/core/meson.build                           |  64 +-------
 rust/hw/core/src/irq.rs                            |   8 +-
 rust/hw/core/src/lib.rs                            |   6 +-
 rust/hw/core/src/prelude.rs                        |   6 +-
 rust/hw/core/src/qdev.rs                           |  31 ++--
 rust/hw/core/tests/tests.rs                        |   4 +-
 rust/hw/timer/hpet/src/device.rs                   |   1 -
 rust/meson.build                                   |   3 +-
 rust/migration/Cargo.toml                          |   1 +
 rust/migration/build.rs                            |   1 -
 rust/migration/meson.build                         |  40 +----
 rust/migration/src/bindings.rs                     |  49 ------
 rust/migration/src/lib.rs                          |   3 +-
 rust/migration/src/vmstate.rs                      |  73 ---------
 rust/qom/Cargo.toml                                |   1 +
 rust/qom/build.rs                                  |   1 -
 rust/qom/meson.build                               |  29 +---
 rust/qom/src/lib.rs                                |   3 +-
 rust/qom/src/prelude.rs                            |   1 +
 rust/qom/src/qom.rs                                |   8 +-
 rust/system/Cargo.toml                             |   4 +
 rust/system/build.rs                               |   1 -
 rust/system/meson.build                            |  39 +----
 rust/system/src/lib.rs                             |   5 +-
 rust/system/src/memory.rs                          |   2 +-
 rust/system/src/prelude.rs                         |   5 +
 rust/{hw/core => system}/src/sysbus.rs             |  36 ++---
 rust/trace/src/lib.rs                              |   1 +
 rust/util/Cargo.toml                               |   1 +
 rust/util/meson.build                              |  42 +-----
 rust/util/src/lib.rs                               |   3 +-
 92 files changed, 1025 insertions(+), 846 deletions(-)
 create mode 100644 rust/bindings/chardev-sys/wrapper.h
 create mode 100644 rust/bindings/hwcore-sys/wrapper.h
 create mode 100644 rust/bindings/migration-sys/wrapper.h
 create mode 100644 rust/bindings/qom-sys/wrapper.h
 create mode 100644 rust/bindings/system-sys/wrapper.h
 create mode 100644 rust/bindings/util-sys/wrapper.h
 delete mode 100644 rust/bql/wrapper.h
 delete mode 100644 rust/chardev/wrapper.h
 delete mode 100644 rust/hw/core/wrapper.h
 delete mode 100644 rust/migration/wrapper.h
 delete mode 100644 rust/qom/wrapper.h
 delete mode 100644 rust/system/wrapper.h
 delete mode 100644 rust/util/wrapper.h
 rename rust/{util => bindings}/build.rs (55%)
 create mode 100644 rust/bindings/chardev-sys/Cargo.toml
 create mode 120000 rust/bindings/chardev-sys/build.rs
 rename rust/{chardev/src/bindings.rs => bindings/chardev-sys/lib.rs} (84%)
 create mode 100644 rust/bindings/chardev-sys/meson.build
 create mode 100644 rust/bindings/generate_bindgen_args.py
 create mode 100644 rust/bindings/hwcore-sys/Cargo.toml
 create mode 120000 rust/bindings/hwcore-sys/build.rs
 rename rust/{hw/core/src/bindings.rs => bindings/hwcore-sys/lib.rs} (71%)
 create mode 100644 rust/bindings/hwcore-sys/meson.build
 create mode 100644 rust/bindings/meson.build
 create mode 100644 rust/bindings/migration-sys/Cargo.toml
 create mode 120000 rust/bindings/migration-sys/build.rs
 create mode 100644 rust/bindings/migration-sys/lib.rs
 create mode 100644 rust/bindings/migration-sys/meson.build
 create mode 100644 rust/bindings/qom-sys/Cargo.toml
 create mode 120000 rust/bindings/qom-sys/build.rs
 rename rust/{qom/src/bindings.rs => bindings/qom-sys/lib.rs} (85%)
 create mode 100644 rust/bindings/qom-sys/meson.build
 create mode 100644 rust/bindings/system-sys/Cargo.toml
 create mode 120000 rust/bindings/system-sys/build.rs
 rename rust/{system/src/bindings.rs => bindings/system-sys/lib.rs} (88%)
 create mode 100644 rust/bindings/system-sys/meson.build
 create mode 100644 rust/bindings/util-sys/Cargo.toml
 create mode 120000 rust/bindings/util-sys/build.rs
 rename rust/{util/src/bindings.rs => bindings/util-sys/lib.rs} (88%)
 create mode 100644 rust/bindings/util-sys/meson.build
 delete mode 120000 rust/bql/build.rs
 delete mode 100644 rust/bql/src/bindings.rs
 delete mode 120000 rust/chardev/build.rs
 delete mode 120000 rust/hw/core/build.rs
 delete mode 120000 rust/migration/build.rs
 delete mode 100644 rust/migration/src/bindings.rs
 delete mode 120000 rust/qom/build.rs
 delete mode 120000 rust/system/build.rs
 rename rust/{hw/core => system}/src/sysbus.rs (76%)
-- 
2.52.0


