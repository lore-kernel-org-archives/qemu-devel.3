Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94EB4D37E3A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 13:50:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vg1Fp-0008UT-EO; Wed, 14 Jan 2026 08:49:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vg1Fk-0008QR-Mf
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 08:49:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vg1Fe-0002Hb-TG
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 08:49:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768398574;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ua86xVccI9vBO0ZWfjlJa2cPpOPXnAAypCa5BSAjDoE=;
 b=ZaAq/lbwkWG+/+jawTrDWvjEHjgGNFtzuO6nLQXdW/wEqubtLcDwjH9Nbs+M5Rr3URe1QQ
 Ncglo64FX7VBPxAuVCBR7b/F8Kq86cSk3FH4KWsB/wKDllJ3LRmy5dHQLv8Z/bkyMJRTfB
 k9a33HSl6X1nu+YHRgf+hDtwBk1Pm38=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-Uv7fXeZEMZOayD8WR0L-bg-1; Wed, 14 Jan 2026 08:49:32 -0500
X-MC-Unique: Uv7fXeZEMZOayD8WR0L-bg-1
X-Mimecast-MFC-AGG-ID: Uv7fXeZEMZOayD8WR0L-bg_1768398571
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-43284edbbc8so5876238f8f.0
 for <qemu-devel@nongnu.org>; Wed, 14 Jan 2026 05:49:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768398569; x=1769003369; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ua86xVccI9vBO0ZWfjlJa2cPpOPXnAAypCa5BSAjDoE=;
 b=qHBbplmV8UJo6O9drSe2P0GaBcVJ4TmKbqK22Ig0uVb1jNhJDITvfwq38jJeS8DQ1y
 TSKsbwchJzo5j6/zIOfcSWNblPOfMZj6GM7ykYIWBIQcdWrjY6Jn+E1pZqEcwTlpDfKo
 lLwQJAcEyn899YPduOhIKJSB08EnNgIwLAvlX+qdlDMm7LgXjk0qeK/vlJ1kpYTmz01e
 XmlUc7TxUYUvJOfcHOOnpQare0VqqqCHWKAzlzHHN6kQYLHXCAtJbOCHPeNc4h2xt9Jr
 Iv9NtAntkTthUj6XBM4dWyruT7UczO2fQyd5jwLGuhvb8Hev+Jjtu+cqeXmadQgwBKxT
 fJOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768398570; x=1769003370;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ua86xVccI9vBO0ZWfjlJa2cPpOPXnAAypCa5BSAjDoE=;
 b=WocLMrK2dxZo0TGAkBDJ0hTs37XhzZNV/Fr9hZi0IxPC+pdNWUXdCuvnMJMoKZhRDB
 iKUViE+8WlcdinFr+XpiFOR4bX5vEQQBK6JU0eXpnJ7Zdldz7tbyfd/oMWYXBjvxSuTB
 S2EgqljdBGB4aZIMzePL+8QmhodvWhRwpqeM3CFW8Rs8QJ1X1q29CL9RHn65mOTIuqBH
 YJNAF/TxDDgPfOqTRwY6+ezfWAspPZuWXXt7TNhdWeNlJ4nS0TofV2/xSZL7+1Euhvx9
 Xg1YV3MD261o+35IuBeBX2FwLRK827QdlAVhiKH4bM8KUn4icV4vvIkIu+876YERRHYS
 IeUA==
X-Gm-Message-State: AOJu0YyIn++n4ziW5+Gm+FgoSyfPu0SBpsaeqGEwHO7unaOPZqeM8S5H
 DsU7zgV+/g7lyBFR9YpqNPFGVXXqqtU50SsSnUoL7AX8KJaNvguet9UJxJhTzwhSxD72K7NRtgz
 RM6bVWfRJe8OTFm96KMswDwjLWDmg1rGg3+E6xCRkBCoiB7dCzHPDEdYpTSOarWGOr+Xe0LteS0
 RbTcNspZcdkfqM1sVC4PiySUFknxHUeG9vMXAmCeGY
X-Gm-Gg: AY/fxX6DNA/+HKor4JS+3VXnv3ZXTSmYIToxNcbjIMwdHqvGftCLO9eZYhLZZYhQavS
 CO3lLEPuCISey/bDXZNRMqCOyWX8Oh8wk9R6/4cuMR6E+g2ZG9qWpML9tT/ikLipl5o946fM4HN
 bdBZUWKzSHfr/TkpC02G4Iok16tE80o9UpJUW/0HDE0GFQFLcR/SwIFZICWB9sg1ztNxvSNemfO
 ub2U6h7dRiC5wqUteZCGJ/gKj8TV/uufYbXKXKivMTZ2Q5vDePkGD0HKjLzSO7hMMIgbD29wbPM
 +5BhZ8jyuwVEHOfDpEg6qMQNpAwxIn1IJIL84it7fw+hdq3nsnUjF3nlcJJBvDHcIH3KiivO8im
 dsO4m8LrDQNDkD/rwWkbVvHKSsr+ClIL6CF0+gcOjcY1Xu6VyvphuwJeGcpOLMjC3ZNyIN4SgAv
 +R4bEX5Xwx7TFIjQ==
X-Received: by 2002:a05:600c:4e11:b0:477:9fcf:3fe3 with SMTP id
 5b1f17b1804b1-47ee306aef4mr43363825e9.0.1768398567953; 
 Wed, 14 Jan 2026 05:49:27 -0800 (PST)
X-Received: by 2002:a05:600c:4e11:b0:477:9fcf:3fe3 with SMTP id
 5b1f17b1804b1-47ee306aef4mr43362335e9.0.1768398566181; 
 Wed, 14 Jan 2026 05:49:26 -0800 (PST)
Received: from [192.168.10.48] ([151.61.26.160])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd5ff319sm51047607f8f.43.2026.01.14.05.49.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jan 2026 05:49:24 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com,
	qemu-rust@nongnu.org,
	marcandre.lureau@redhat.com
Subject: [PATCH 2/3] rust: move binding generation to bindings/
Date: Wed, 14 Jan 2026 14:49:18 +0100
Message-ID: <20260114134919.1476518-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260114134919.1476518-1-pbonzini@redhat.com>
References: <20260114134919.1476518-1-pbonzini@redhat.com>
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
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Move raw FFI bindings generation to separate crates.  This makes it
possible to reuse bindgen declarations for a header file in its
dependencies (this was not the case before this change), while keeping
multiple -sys crates to avoid rebuilding all the code whenever
something changes.

Because the -sys crates are generated in dependency order, this also
enforces that the crates are organized in something that resembles
the dependencies between C headers.

The meson.build for rust-safe crates becomes simpler, and it should be
possible in the future to let Meson's cargo support handle most of it.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
[General cleanup and Python script. - Paolo]
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
        This is a large commit; it's merged from several separate
        parts in Marc-André's work due to me introducing the
        Python script (which needs to be done at once, because it
        relies on the order of the crates to build --allowlist-file
	and --blocklist-file options).  I can split it again if it
        is preferrable.

 docs/devel/rust.rst                           |  57 ++++++
 meson.build                                   |   3 +-
 rust/bindings/chardev-sys/wrapper.h           |  12 ++
 rust/bindings/hwcore-sys/wrapper.h            |  30 ++++
 rust/bindings/migration-sys/wrapper.h         |  10 ++
 rust/bindings/qom-sys/wrapper.h               |  17 ++
 rust/bindings/system-sys/wrapper.h            |  21 +++
 rust/bindings/util-sys/wrapper.h              |  39 +++++
 rust/bql/wrapper.h                            |  27 ---
 rust/chardev/wrapper.h                        |  28 ---
 rust/hw/core/wrapper.h                        |  32 ----
 rust/migration/wrapper.h                      |  51 ------
 rust/qom/wrapper.h                            |  27 ---
 rust/system/wrapper.h                         |  29 ----
 rust/util/wrapper.h                           |  32 ----
 rust/Cargo.lock                               |  68 ++++++++
 rust/{util => bindings}/build.rs              |  30 ++--
 rust/bindings/chardev-sys/Cargo.toml          |  28 +++
 rust/bindings/chardev-sys/build.rs            |   1 +
 .../chardev-sys/lib.rs}                       |   7 +-
 rust/bindings/chardev-sys/meson.build         |  12 ++
 rust/bindings/generate_bindgen_args.py        | 163 ++++++++++++++++++
 rust/bindings/hwcore-sys/Cargo.toml           |  32 ++++
 rust/bindings/hwcore-sys/build.rs             |   1 +
 .../hwcore-sys/lib.rs}                        |  17 +-
 rust/bindings/hwcore-sys/meson.build          |  12 ++
 rust/bindings/meson.build                     |  37 ++++
 rust/bindings/migration-sys/Cargo.toml        |  28 +++
 rust/bindings/migration-sys/build.rs          |   1 +
 rust/bindings/migration-sys/lib.rs            | 125 ++++++++++++++
 rust/bindings/migration-sys/meson.build       |  12 ++
 rust/bindings/qom-sys/Cargo.toml              |  25 +++
 rust/bindings/qom-sys/build.rs                |   1 +
 .../bindings.rs => bindings/qom-sys/lib.rs}   |   4 +
 rust/bindings/qom-sys/meson.build             |  12 ++
 rust/bindings/system-sys/Cargo.toml           |  30 ++++
 rust/bindings/system-sys/build.rs             |   1 +
 .../system-sys/lib.rs}                        |   4 +-
 rust/bindings/system-sys/meson.build          |  12 ++
 rust/bindings/util-sys/Cargo.toml             |  25 +++
 rust/bindings/util-sys/build.rs               |   1 +
 .../bindings.rs => bindings/util-sys/lib.rs}  |   2 +-
 rust/bindings/util-sys/meson.build            |  12 ++
 rust/bql/Cargo.toml                           |   1 +
 rust/bql/build.rs                             |   1 -
 rust/bql/meson.build                          |  30 +---
 rust/bql/src/bindings.rs                      |  27 ---
 rust/bql/src/lib.rs                           |   3 +-
 rust/chardev/Cargo.toml                       |   1 +
 rust/chardev/build.rs                         |   1 -
 rust/chardev/meson.build                      |  37 +---
 rust/chardev/src/lib.rs                       |   2 +-
 rust/hw/char/pl011/build.rs                   |   2 +-
 rust/hw/char/pl011/meson.build                |  21 +--
 rust/hw/char/pl011/src/bindings.rs            |   7 +-
 rust/hw/core/Cargo.toml                       |   1 +
 rust/hw/core/build.rs                         |   1 -
 rust/hw/core/meson.build                      |  60 +------
 rust/hw/core/src/lib.rs                       |   3 +-
 rust/hw/core/src/qdev.rs                      |   6 +-
 rust/hw/core/src/sysbus.rs                    |  21 ++-
 rust/meson.build                              |   1 +
 rust/migration/Cargo.toml                     |   1 +
 rust/migration/build.rs                       |   1 -
 rust/migration/meson.build                    |  40 +----
 rust/migration/src/bindings.rs                |  49 ------
 rust/migration/src/lib.rs                     |   3 +-
 rust/migration/src/vmstate.rs                 |  73 --------
 rust/qom/Cargo.toml                           |   1 +
 rust/qom/build.rs                             |   1 -
 rust/qom/meson.build                          |  29 +---
 rust/qom/src/lib.rs                           |   3 +-
 rust/system/Cargo.toml                        |   3 +
 rust/system/build.rs                          |   1 -
 rust/system/meson.build                       |  37 +---
 rust/system/src/lib.rs                        |   2 +-
 rust/system/src/memory.rs                     |   2 +-
 rust/util/Cargo.toml                          |   1 +
 rust/util/meson.build                         |  42 +----
 rust/util/src/lib.rs                          |   3 +-
 80 files changed, 917 insertions(+), 719 deletions(-)
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

diff --git a/docs/devel/rust.rst b/docs/devel/rust.rst
index 79c26d9d165..1d7588645cb 100644
--- a/docs/devel/rust.rst
+++ b/docs/devel/rust.rst
@@ -339,6 +339,63 @@ Here are some things to keep in mind when working on the QEMU Rust crate.
   or a macro) where it can be documented and tested.  If needed, include
   toy versions of the code in the documentation.
 
+FFI Binding Generation
+''''''''''''''''''''''
+
+QEMU's Rust integration uses multiple ``*-sys`` crates that contain raw FFI
+bindings to different QEMU subsystems. These crates mirror the dependency
+structure that meson.build uses for C code, and which is reflected in
+``static_library()`` declarations. For example:
+
+* util-sys: Basic utilities (no dependencies)
+* qom-sys: QEMU Object Model (depends on util-sys)
+* chardev-sys: Character devices (depends on qom-sys, util-sys)
+* hwcore-sys: Hardware core (depends on qom-sys, util-sys)
+* migration-sys: Migration (depends on util-sys)
+* system-sys: System-level APIs (depends on all others)
+
+Having multiple crates avoids massive rebuilds of all Rust code when C headers
+are changed. On the other hand, bindgen is not aware of how headers are split
+across crates, and therefore it would generate declarations for dependencies
+again. These duplicate declarations are not only large, they create distinct
+types and therefore they are incompatible with each other.
+
+Bindgen Configuration
+~~~~~~~~~~~~~~~~~~~~~
+
+Bindgen options such as symbol blocklists or how to configure enums can be
+defined in each crate's ``Cargo.toml`` via a ``[package.metadata.bindgen]`` section.
+For example::
+
+    [package.metadata.bindgen]
+    header = "wrapper.h"                    # Main header file for this crate
+    rustified-enum = ["QEMUClockType"]      # Enums to generate as Rust enums
+    bitfield-enum = ["VMStateFlags"]        # Enums to treat as bitfields
+    blocklist-function = [                  # Functions to exclude
+        "vmstate_register_ram",
+        "vmstate_unregister_ram"
+    ]
+    additional-files = [                    # Extra files to allowlist
+        "include/system/memory_ldst.*"
+    ]
+
+All bindgen options are supported in the metadata section. The complete list
+can be found in ``rust/bindings/generate_bindgen_args.py``.
+
+Dependency Management
+~~~~~~~~~~~~~~~~~~~~~
+
+By examining the dependency chain before bindgen creates the code for
+the ``*-sys`` crates, the build system ensures that header files included in
+one crate are blocked from appearing in dependent crates, thus avoiding
+duplicate definitions. Dependent crates can import the definition via
+"use" statements.
+
+This dependency-aware binding generation is handled automatically by
+``rust/bindings/generate_bindgen_args.py``, which processes the Cargo.toml
+files in dependency order and generates appropriate ``--allowlist-file`` and
+``--blocklist-file`` arguments for bindgen.
+
 Writing procedural macros
 '''''''''''''''''''''''''
 
diff --git a/meson.build b/meson.build
index c58007291a8..0134698561e 100644
--- a/meson.build
+++ b/meson.build
@@ -4229,9 +4229,8 @@ if have_rust
     '--with-derive-default',
     '--no-layout-tests',
     '--no-prepend-enum-name',
-    '--allowlist-file', meson.project_source_root() + '/include/.*',
-    '--allowlist-file', meson.project_build_root() + '/.*',
     '--blocklist-file', glib_pc.get_variable('includedir') + '/glib-2.0/.*',
+    '--blocklist-file', meson.project_source_root() + '/include/qemu/typedefs.h',
     '--blocklist-type', '.*_([a-z]*autoptr)$',
     ]
   if not rustfmt.found()
diff --git a/rust/bindings/chardev-sys/wrapper.h b/rust/bindings/chardev-sys/wrapper.h
new file mode 100644
index 00000000000..b8ddc361f76
--- /dev/null
+++ b/rust/bindings/chardev-sys/wrapper.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+/*
+ * This header file is meant to be used as input to the `bindgen` application
+ * in order to generate C FFI compatible Rust bindings.
+ */
+
+#include "qemu/osdep.h"
+
+#include "chardev/char.h"
+#include "chardev/char-fe.h"
+#include "chardev/char-serial.h"
diff --git a/rust/bindings/hwcore-sys/wrapper.h b/rust/bindings/hwcore-sys/wrapper.h
new file mode 100644
index 00000000000..7c7c3c35f6d
--- /dev/null
+++ b/rust/bindings/hwcore-sys/wrapper.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+/*
+ * This header file is meant to be used as input to the `bindgen` application
+ * in order to generate C FFI compatible Rust bindings.
+ */
+
+/*
+ * We block include/qemu/typedefs.h from bindgen, add here symbols
+ * that are needed as opaque types by other functions.
+ */
+typedef struct Clock Clock;
+typedef struct DeviceState DeviceState;
+typedef struct IRQState *qemu_irq;
+typedef void (*qemu_irq_handler)(void *opaque, int n, int level);
+
+/* Once bindings exist, these could move to a different *-sys crate.  */
+typedef struct BlockBackend BlockBackend;
+typedef struct Monitor Monitor;
+typedef struct NetClientState NetClientState;
+
+#include "qemu/osdep.h"
+
+#include "hw/core/clock.h"
+#include "hw/core/irq.h"
+#include "hw/core/qdev-clock.h"
+#include "hw/core/qdev.h"
+#include "hw/core/qdev-properties-system.h"
+#include "hw/core/qdev-properties.h"
+#include "hw/core/resettable.h"
diff --git a/rust/bindings/migration-sys/wrapper.h b/rust/bindings/migration-sys/wrapper.h
new file mode 100644
index 00000000000..076ad79a21f
--- /dev/null
+++ b/rust/bindings/migration-sys/wrapper.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+/*
+ * This header file is meant to be used as input to the `bindgen` application
+ * in order to generate C FFI compatible Rust bindings.
+ */
+
+#include "qemu/osdep.h"
+
+#include "migration/vmstate.h"
diff --git a/rust/bindings/qom-sys/wrapper.h b/rust/bindings/qom-sys/wrapper.h
new file mode 100644
index 00000000000..18a5ea6d25f
--- /dev/null
+++ b/rust/bindings/qom-sys/wrapper.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+/*
+ * This header file is meant to be used as input to the `bindgen` application
+ * in order to generate C FFI compatible Rust bindings.
+ */
+
+/*
+ * We block include/qemu/typedefs.h from bindgen, add here symbols
+ * that are needed as opaque types by other functions.
+ */
+typedef struct Object Object;
+typedef struct ObjectClass ObjectClass;
+
+#include "qemu/osdep.h"
+
+#include "qom/object.h"
diff --git a/rust/bindings/system-sys/wrapper.h b/rust/bindings/system-sys/wrapper.h
new file mode 100644
index 00000000000..0a8bf06a1f3
--- /dev/null
+++ b/rust/bindings/system-sys/wrapper.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+/*
+ * This header file is meant to be used as input to the `bindgen` application
+ * in order to generate C FFI compatible Rust bindings.
+ */
+
+/*
+ * We block include/qemu/typedefs.h from bindgen, add here symbols
+ * that are needed as opaque types by other functions.
+ */
+typedef struct DirtyBitmapSnapshot DirtyBitmapSnapshot;
+typedef struct MemoryRegion MemoryRegion;
+typedef struct RAMBlock RAMBlock;
+
+#include "qemu/osdep.h"
+
+#include "exec/hwaddr.h"
+#include "system/address-spaces.h"
+#include "system/memory.h"
+#include "hw/core/sysbus.h"
diff --git a/rust/bindings/util-sys/wrapper.h b/rust/bindings/util-sys/wrapper.h
new file mode 100644
index 00000000000..e9c433e7dc1
--- /dev/null
+++ b/rust/bindings/util-sys/wrapper.h
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+/*
+ * This header file is meant to be used as input to the `bindgen` application
+ * in order to generate C FFI compatible Rust bindings.
+ */
+
+/*
+ * We block include/qemu/typedefs.h from bindgen, add here symbols
+ * that are needed as opaque types by other functions.
+ */
+typedef struct QEMUBH QEMUBH;
+typedef struct QEMUFile QEMUFile;
+typedef struct QemuOpts QemuOpts;
+typedef struct JSONWriter JSONWriter;
+typedef struct Visitor Visitor;
+
+#include "qemu/osdep.h"
+
+#include "qapi/error.h"
+#include "qapi/error-internal.h"
+#include "qemu/event_notifier.h"
+#include "qemu/main-loop.h"
+#include "qemu/aio.h"
+#include "qemu/log-for-trace.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "qemu/option.h"
+#include "qemu/timer.h"
+#include "qapi/visitor.h"
+#include "qobject/qbool.h"
+#include "qobject/qdict.h"
+#include "qobject/qjson.h"
+#include "qobject/qlist.h"
+#include "qobject/qnull.h"
+#include "qobject/qnum.h"
+#include "qobject/qobject.h"
+#include "qobject/qstring.h"
+#include "qobject/json-writer.h"
diff --git a/rust/bql/wrapper.h b/rust/bql/wrapper.h
deleted file mode 100644
index 2ef9a96e1d3..00000000000
--- a/rust/bql/wrapper.h
+++ /dev/null
@@ -1,27 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-
-/*
- * This header file is meant to be used as input to the `bindgen` application
- * in order to generate C FFI compatible Rust bindings.
- */
-
-#ifndef __CLANG_STDATOMIC_H
-#define __CLANG_STDATOMIC_H
-/*
- * Fix potential missing stdatomic.h error in case bindgen does not insert the
- * correct libclang header paths on its own. We do not use stdatomic.h symbols
- * in QEMU code, so it's fine to declare dummy types instead.
- */
-typedef enum memory_order {
-  memory_order_relaxed,
-  memory_order_consume,
-  memory_order_acquire,
-  memory_order_release,
-  memory_order_acq_rel,
-  memory_order_seq_cst,
-} memory_order;
-#endif /* __CLANG_STDATOMIC_H */
-
-#include "qemu/osdep.h"
-
-#include "qemu/main-loop.h"
diff --git a/rust/chardev/wrapper.h b/rust/chardev/wrapper.h
deleted file mode 100644
index 65ede6ea6d7..00000000000
--- a/rust/chardev/wrapper.h
+++ /dev/null
@@ -1,28 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-
-/*
- * This header file is meant to be used as input to the `bindgen` application
- * in order to generate C FFI compatible Rust bindings.
- */
-
-#ifndef __CLANG_STDATOMIC_H
-#define __CLANG_STDATOMIC_H
-/*
- * Fix potential missing stdatomic.h error in case bindgen does not insert the
- * correct libclang header paths on its own. We do not use stdatomic.h symbols
- * in QEMU code, so it's fine to declare dummy types instead.
- */
-typedef enum memory_order {
-  memory_order_relaxed,
-  memory_order_consume,
-  memory_order_acquire,
-  memory_order_release,
-  memory_order_acq_rel,
-  memory_order_seq_cst,
-} memory_order;
-#endif /* __CLANG_STDATOMIC_H */
-
-#include "qemu/osdep.h"
-
-#include "chardev/char-fe.h"
-#include "chardev/char-serial.h"
diff --git a/rust/hw/core/wrapper.h b/rust/hw/core/wrapper.h
deleted file mode 100644
index 8278738f3d8..00000000000
--- a/rust/hw/core/wrapper.h
+++ /dev/null
@@ -1,32 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-
-/*
- * This header file is meant to be used as input to the `bindgen` application
- * in order to generate C FFI compatible Rust bindings.
- */
-
-#ifndef __CLANG_STDATOMIC_H
-#define __CLANG_STDATOMIC_H
-/*
- * Fix potential missing stdatomic.h error in case bindgen does not insert the
- * correct libclang header paths on its own. We do not use stdatomic.h symbols
- * in QEMU code, so it's fine to declare dummy types instead.
- */
-typedef enum memory_order {
-  memory_order_relaxed,
-  memory_order_consume,
-  memory_order_acquire,
-  memory_order_release,
-  memory_order_acq_rel,
-  memory_order_seq_cst,
-} memory_order;
-#endif /* __CLANG_STDATOMIC_H */
-
-#include "qemu/osdep.h"
-
-#include "hw/core/sysbus.h"
-#include "hw/core/clock.h"
-#include "hw/core/qdev-clock.h"
-#include "hw/core/qdev-properties.h"
-#include "hw/core/qdev-properties-system.h"
-#include "hw/core/irq.h"
diff --git a/rust/migration/wrapper.h b/rust/migration/wrapper.h
deleted file mode 100644
index daf316aed41..00000000000
--- a/rust/migration/wrapper.h
+++ /dev/null
@@ -1,51 +0,0 @@
-/*
- * QEMU System Emulator
- *
- * Copyright (c) 2024 Linaro Ltd.
- *
- * Authors: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
- *
- * Permission is hereby granted, free of charge, to any person obtaining a copy
- * of this software and associated documentation files (the "Software"), to deal
- * in the Software without restriction, including without limitation the rights
- * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
- * copies of the Software, and to permit persons to whom the Software is
- * furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice shall be included in
- * all copies or substantial portions of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
- * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
- * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
- * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
- * THE SOFTWARE.
- */
-
-
-/*
- * This header file is meant to be used as input to the `bindgen` application
- * in order to generate C FFI compatible Rust bindings.
- */
-
-#ifndef __CLANG_STDATOMIC_H
-#define __CLANG_STDATOMIC_H
-/*
- * Fix potential missing stdatomic.h error in case bindgen does not insert the
- * correct libclang header paths on its own. We do not use stdatomic.h symbols
- * in QEMU code, so it's fine to declare dummy types instead.
- */
-typedef enum memory_order {
-  memory_order_relaxed,
-  memory_order_consume,
-  memory_order_acquire,
-  memory_order_release,
-  memory_order_acq_rel,
-  memory_order_seq_cst,
-} memory_order;
-#endif /* __CLANG_STDATOMIC_H */
-
-#include "qemu/osdep.h"
-#include "migration/vmstate.h"
diff --git a/rust/qom/wrapper.h b/rust/qom/wrapper.h
deleted file mode 100644
index 3b71bcd3f5b..00000000000
--- a/rust/qom/wrapper.h
+++ /dev/null
@@ -1,27 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-
-/*
- * This header file is meant to be used as input to the `bindgen` application
- * in order to generate C FFI compatible Rust bindings.
- */
-
-#ifndef __CLANG_STDATOMIC_H
-#define __CLANG_STDATOMIC_H
-/*
- * Fix potential missing stdatomic.h error in case bindgen does not insert the
- * correct libclang header paths on its own. We do not use stdatomic.h symbols
- * in QEMU code, so it's fine to declare dummy types instead.
- */
-typedef enum memory_order {
-  memory_order_relaxed,
-  memory_order_consume,
-  memory_order_acquire,
-  memory_order_release,
-  memory_order_acq_rel,
-  memory_order_seq_cst,
-} memory_order;
-#endif /* __CLANG_STDATOMIC_H */
-
-#include "qemu/osdep.h"
-
-#include "qom/object.h"
diff --git a/rust/system/wrapper.h b/rust/system/wrapper.h
deleted file mode 100644
index 48abde85052..00000000000
--- a/rust/system/wrapper.h
+++ /dev/null
@@ -1,29 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-
-/*
- * This header file is meant to be used as input to the `bindgen` application
- * in order to generate C FFI compatible Rust bindings.
- */
-
-#ifndef __CLANG_STDATOMIC_H
-#define __CLANG_STDATOMIC_H
-/*
- * Fix potential missing stdatomic.h error in case bindgen does not insert the
- * correct libclang header paths on its own. We do not use stdatomic.h symbols
- * in QEMU code, so it's fine to declare dummy types instead.
- */
-typedef enum memory_order {
-  memory_order_relaxed,
-  memory_order_consume,
-  memory_order_acquire,
-  memory_order_release,
-  memory_order_acq_rel,
-  memory_order_seq_cst,
-} memory_order;
-#endif /* __CLANG_STDATOMIC_H */
-
-#include "qemu/osdep.h"
-
-#include "system/system.h"
-#include "system/memory.h"
-#include "system/address-spaces.h"
diff --git a/rust/util/wrapper.h b/rust/util/wrapper.h
deleted file mode 100644
index b9ed68a01d8..00000000000
--- a/rust/util/wrapper.h
+++ /dev/null
@@ -1,32 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-
-/*
- * This header file is meant to be used as input to the `bindgen` application
- * in order to generate C FFI compatible Rust bindings.
- */
-
-#ifndef __CLANG_STDATOMIC_H
-#define __CLANG_STDATOMIC_H
-/*
- * Fix potential missing stdatomic.h error in case bindgen does not insert the
- * correct libclang header paths on its own. We do not use stdatomic.h symbols
- * in QEMU code, so it's fine to declare dummy types instead.
- */
-typedef enum memory_order {
-  memory_order_relaxed,
-  memory_order_consume,
-  memory_order_acquire,
-  memory_order_release,
-  memory_order_acq_rel,
-  memory_order_seq_cst,
-} memory_order;
-#endif /* __CLANG_STDATOMIC_H */
-
-#include "qemu/osdep.h"
-
-#include "qapi/error.h"
-#include "qapi/error-internal.h"
-#include "qemu/log-for-trace.h"
-#include "qemu/log.h"
-#include "qemu/module.h"
-#include "qemu/timer.h"
diff --git a/rust/Cargo.lock b/rust/Cargo.lock
index 78452c3db9b..801ac5f4f51 100644
--- a/rust/Cargo.lock
+++ b/rust/Cargo.lock
@@ -59,6 +59,7 @@ name = "bql"
 version = "0.1.0"
 dependencies = [
  "glib-sys",
+ "util-sys",
 ]
 
 [[package]]
@@ -76,6 +77,7 @@ name = "chardev"
 version = "0.1.0"
 dependencies = [
  "bql",
+ "chardev-sys",
  "common",
  "glib-sys",
  "migration",
@@ -83,6 +85,16 @@ dependencies = [
  "util",
 ]
 
+[[package]]
+name = "chardev-sys"
+version = "0.1.0"
+dependencies = [
+ "common",
+ "glib-sys",
+ "qom-sys",
+ "util-sys",
+]
+
 [[package]]
 name = "common"
 version = "0.1.0"
@@ -156,6 +168,7 @@ dependencies = [
  "chardev",
  "common",
  "glib-sys",
+ "hwcore-sys",
  "migration",
  "qemu_macros",
  "qom",
@@ -163,6 +176,19 @@ dependencies = [
  "util",
 ]
 
+[[package]]
+name = "hwcore-sys"
+version = "0.1.0"
+dependencies = [
+ "chardev-sys",
+ "common",
+ "glib-sys",
+ "migration-sys",
+ "qom-sys",
+ "system-sys",
+ "util-sys",
+]
+
 [[package]]
 name = "indexmap"
 version = "2.11.4"
@@ -201,10 +227,20 @@ dependencies = [
  "bql",
  "common",
  "glib-sys",
+ "migration-sys",
  "qemu_macros",
  "util",
 ]
 
+[[package]]
+name = "migration-sys"
+version = "0.1.0"
+dependencies = [
+ "common",
+ "glib-sys",
+ "util-sys",
+]
+
 [[package]]
 name = "pkg-config"
 version = "0.3.32"
@@ -287,9 +323,18 @@ dependencies = [
  "glib-sys",
  "migration",
  "qemu_macros",
+ "qom-sys",
  "util",
 ]
 
+[[package]]
+name = "qom-sys"
+version = "0.1.0"
+dependencies = [
+ "glib-sys",
+ "util-sys",
+]
+
 [[package]]
 name = "quote"
 version = "1.0.36"
@@ -306,6 +351,7 @@ source = "registry+https://github.com/rust-lang/crates.io-index"
 checksum = "0dca6411025b24b60bfa7ec1fe1f8e710ac09782dca409ee8237ba74b51295fd"
 dependencies = [
  "serde_core",
+ "serde_derive",
 ]
 
 [[package]]
@@ -358,9 +404,12 @@ dependencies = [
 name = "system"
 version = "0.1.0"
 dependencies = [
+ "bql",
  "common",
  "glib-sys",
+ "migration",
  "qom",
+ "system-sys",
  "util",
 ]
 
@@ -377,6 +426,17 @@ dependencies = [
  "version-compare",
 ]
 
+[[package]]
+name = "system-sys"
+version = "0.1.0"
+dependencies = [
+ "common",
+ "glib-sys",
+ "migration-sys",
+ "qom-sys",
+ "util-sys",
+]
+
 [[package]]
 name = "target-lexicon"
 version = "0.13.2"
@@ -454,6 +514,14 @@ dependencies = [
  "foreign",
  "glib-sys",
  "libc",
+ "util-sys",
+]
+
+[[package]]
+name = "util-sys"
+version = "0.1.0"
+dependencies = [
+ "glib-sys",
 ]
 
 [[package]]
diff --git a/rust/util/build.rs b/rust/bindings/build.rs
similarity index 55%
rename from rust/util/build.rs
rename to rust/bindings/build.rs
index 5654d1d5624..a466958d713 100644
--- a/rust/util/build.rs
+++ b/rust/bindings/build.rs
@@ -10,25 +10,25 @@
 
 fn main() -> Result<()> {
     let manifest_dir = env!("CARGO_MANIFEST_DIR");
-    let file = if let Ok(root) = env::var("MESON_BUILD_ROOT") {
-        let sub = get_rust_subdir(manifest_dir).unwrap();
-        format!("{root}/{sub}/bindings.inc.rs")
-    } else {
-        // Placing bindings.inc.rs in the source directory is supported
-        // but not documented or encouraged.
-        format!("{manifest_dir}/src/bindings.inc.rs")
-    };
+    let root = env::var("MESON_BUILD_ROOT").expect(concat!(
+        "\n",
+        "    MESON_BUILD_ROOT not found.  Maybe you wanted one of\n",
+        "    `make clippy`, `make rustfmt`, `make rustdoc`?\n",
+        "\n",
+        "    For other uses of `cargo`, start a subshell with\n",
+        "    `pyvenv/bin/meson devenv`, or point MESON_BUILD_ROOT to\n",
+        "    the top of the build tree."
+    ));
 
+    let sub = get_rust_subdir(manifest_dir).unwrap();
+    let file = format!("{root}/{sub}/bindings.inc.rs");
     let file = Path::new(&file);
-    if !Path::new(&file).exists() {
+
+    if !file.exists() {
         panic!(concat!(
             "\n",
-            "    No generated C bindings found! Maybe you wanted one of\n",
-            "    `make clippy`, `make rustfmt`, `make rustdoc`?\n",
-            "\n",
-            "    For other uses of `cargo`, start a subshell with\n",
-            "    `pyvenv/bin/meson devenv`, or point MESON_BUILD_ROOT to\n",
-            "    the top of the build tree."
+            "    No generated C bindings found! Run `make` first; or maybe you\n",
+            "    wanted one of `make clippy`, `make rustfmt`, `make rustdoc`?\n",
         ));
     }
 
diff --git a/rust/bindings/chardev-sys/Cargo.toml b/rust/bindings/chardev-sys/Cargo.toml
new file mode 100644
index 00000000000..6aa0025ca6f
--- /dev/null
+++ b/rust/bindings/chardev-sys/Cargo.toml
@@ -0,0 +1,28 @@
+[package]
+name = "chardev-sys"
+version = "0.1.0"
+description = "Rust sys bindings for QEMU/chardev"
+publish = false
+
+authors.workspace = true
+edition.workspace = true
+homepage.workspace = true
+license.workspace = true
+repository.workspace = true
+rust-version.workspace = true
+
+[lib]
+path = "lib.rs"
+
+[dependencies]
+glib-sys = { workspace = true }
+common = { path = "../../common" }
+qom-sys = { path = "../qom-sys" }
+util-sys = { path = "../util-sys" }
+
+[lints]
+workspace = true
+
+[package.metadata.bindgen]
+header = "wrapper.h"
+rustified-enum = ["QEMUChrEvent"]
diff --git a/rust/bindings/chardev-sys/build.rs b/rust/bindings/chardev-sys/build.rs
new file mode 120000
index 00000000000..10238032f5f
--- /dev/null
+++ b/rust/bindings/chardev-sys/build.rs
@@ -0,0 +1 @@
+../build.rs
\ No newline at end of file
diff --git a/rust/chardev/src/bindings.rs b/rust/bindings/chardev-sys/lib.rs
similarity index 84%
rename from rust/chardev/src/bindings.rs
rename to rust/bindings/chardev-sys/lib.rs
index 360b30d6a34..903f6fc492a 100644
--- a/rust/chardev/src/bindings.rs
+++ b/rust/bindings/chardev-sys/lib.rs
@@ -19,10 +19,9 @@
 )]
 
 use common::Zeroable;
-use glib_sys::{
-    gboolean, guint, GArray, GHashTable, GHashTableIter, GIOCondition, GMainContext, GPollFD,
-    GPtrArray, GSList, GSource, GSourceFunc,
-};
+use glib_sys::{gboolean, guint, GIOCondition, GMainContext, GSource, GSourceFunc};
+use qom_sys::{Object, ObjectClass};
+use util_sys::{Error, IOCanReadHandler, IOReadHandler, QemuOpts};
 
 #[cfg(MESON)]
 include!("bindings.inc.rs");
diff --git a/rust/bindings/chardev-sys/meson.build b/rust/bindings/chardev-sys/meson.build
new file mode 100644
index 00000000000..458075b8060
--- /dev/null
+++ b/rust/bindings/chardev-sys/meson.build
@@ -0,0 +1,12 @@
+_bindgen_chardev_rs = rust.bindgen(
+  args: bindgen_args_common + bindgen_args_data['chardev-sys'].split(),
+  kwargs: bindgen_kwargs)
+_chardev_sys_rs = static_library(
+  'chardev_sys',
+  structured_sources(['lib.rs', _bindgen_chardev_rs]),
+  override_options: ['rust_std=2021', 'build.rust_std=2021'],
+  rust_abi: 'rust',
+  dependencies: [glib_sys_rs, common_rs, qom_sys_rs, util_sys_rs],
+)
+
+chardev_sys_rs = declare_dependency(link_with: [_chardev_sys_rs])
diff --git a/rust/bindings/generate_bindgen_args.py b/rust/bindings/generate_bindgen_args.py
new file mode 100644
index 00000000000..3128c9f2880
--- /dev/null
+++ b/rust/bindings/generate_bindgen_args.py
@@ -0,0 +1,163 @@
+#!/usr/bin/env python3
+"""
+Generate bindgen arguments from Cargo.toml metadata for QEMU's Rust FFI bindings.
+
+Author: Paolo Bonzini <pbonzini@redhat.com>
+
+Copyright (C) 2025 Red Hat, Inc.
+
+This script processes Cargo.toml file for QEMU's bindings crates (util-sys,
+chardev-sys, qom-sys, etc.); it generates bindgen command lines that allow
+easy customization and that export the right headers in each bindings crate.
+
+For detailed information, see docs/devel/rust.rst.
+"""
+
+import os
+import re
+import sys
+import argparse
+import shlex
+from pathlib import Path
+from dataclasses import dataclass
+from typing import Iterable, List, Dict, Any
+
+try:
+    import tomllib
+except ImportError:
+    import tomli as tomllib  # type: ignore
+
+INCLUDE_RE = re.compile(r'^#include\s+"([^"]+)"')
+OPTIONS = [
+    "bitfield-enum",
+    "newtype-enum",
+    "newtype-global-enum",
+    "rustified-enum",
+    "rustified-non-exhaustive-enum",
+    "constified-enum",
+    "constified-enum-module",
+    "normal-alias",
+    "new-type-alias",
+    "new-type-alias-deref",
+    "bindgen-wrapper-union",
+    "manually-drop-union",
+    "blocklist-type",
+    "blocklist-function",
+    "blocklist-item",
+    "blocklist-file",
+    "blocklist-var",
+    "opaque-type",
+    "no-partialeq",
+    "no-copy",
+    "no-debug",
+    "no-default",
+    "no-hash",
+    "must-use-type",
+    "with-derive-custom",
+    "with-derive-custom-struct",
+    "with-derive-custom-enum",
+    "with-derive-custom-union",
+    "with-attribute-custom",
+    "with-attribute-custom-struct",
+    "with-attribute-custom-enum",
+    "with-attribute-custom-union",
+]
+
+
+@dataclass
+class BindgenInfo:
+    cmd_args: List[str]
+    inputs: List[str]
+
+
+def extract_includes(lines: Iterable[str]) -> List[str]:
+    """Extract #include directives from a file."""
+    includes: List[str] = []
+    for line in lines:
+        match = INCLUDE_RE.match(line.strip())
+        if match:
+            includes.append(match.group(1))
+    return includes
+
+
+def build_bindgen_args(metadata: Dict[str, Any]) -> List[str]:
+    """Build command line arguments from [package.metadata.bindgen]."""
+    args: List[str] = []
+    for key, values in metadata.items():
+        if key in OPTIONS:
+            flag = f"--{key}"
+            assert isinstance(values, list)
+            for value in values:
+                args.append(flag)
+                args.append(value)
+
+    return args
+
+
+def main() -> int:
+    parser = argparse.ArgumentParser(
+        description="Generate bindgen arguments from Cargo.toml metadata"
+    )
+    parser.add_argument(
+        "directories", nargs="+", help="Directories containing Cargo.toml files"
+    )
+    parser.add_argument(
+        "-I",
+        "--include-root",
+        default=None,
+        help="Base path for --allowlist-file/--blocklist-file",
+    )
+    parser.add_argument("--source-dir", default=os.getcwd(), help="Source directory")
+    parser.add_argument("-o", "--output", required=True, help="Output file")
+    parser.add_argument("--dep-file", help="Dependency file to write")
+    args = parser.parse_args()
+
+    prev_allowlist_files: Dict[str, object] = {}
+    bindgen_infos: Dict[str, BindgenInfo] = {}
+
+    os.chdir(args.source_dir)
+    include_root = args.include_root or args.source_dir
+    for directory in args.directories:
+        cargo_path = Path(directory) / "Cargo.toml"
+        inputs = [str(Path(args.source_dir) / cargo_path)]
+
+        with open(cargo_path, "rb") as f:
+            cargo_toml = tomllib.load(f)
+
+        metadata = cargo_toml.get("package", {}).get("metadata", {}).get("bindgen", {})
+        input_file = Path(directory) / metadata["header"]
+        inputs.append(str(Path(args.source_dir) / input_file))
+
+        cmd_args = build_bindgen_args(metadata)
+
+        # Each include file is allowed for this file and blocked in the
+        # next ones
+        for blocklist_path in prev_allowlist_files.keys():
+            cmd_args.extend(["--blocklist-file", blocklist_path])
+        with open(input_file, "r", encoding="utf-8", errors="ignore") as f:
+            includes = extract_includes(f)
+        for allowlist_file in includes + metadata.get("additional-files", []):
+            allowlist_path = Path(include_root) / allowlist_file
+            cmd_args.extend(["--allowlist-file", str(allowlist_path)])
+            prev_allowlist_files.setdefault(str(allowlist_path), True)
+
+        bindgen_infos[directory] = BindgenInfo(cmd_args=cmd_args, inputs=inputs)
+
+    # now write the output
+    with open(args.output, "w") as f:
+        for directory, info in bindgen_infos.items():
+            args_sh = " ".join(info.cmd_args)
+            f.write(f"{directory}={args_sh}\n")
+
+    if args.dep_file:
+        with open(args.dep_file, "w") as f:
+            deps: List[str] = []
+            for info in bindgen_infos.values():
+                deps += info.inputs
+            f.write(f"{os.path.basename(args.output)}: {' '.join(deps)}\n")
+
+    return 0
+
+
+if __name__ == "__main__":
+    sys.exit(main())
diff --git a/rust/bindings/hwcore-sys/Cargo.toml b/rust/bindings/hwcore-sys/Cargo.toml
new file mode 100644
index 00000000000..c20024e921a
--- /dev/null
+++ b/rust/bindings/hwcore-sys/Cargo.toml
@@ -0,0 +1,32 @@
+[package]
+name = "hwcore-sys"
+version = "0.1.0"
+description = "Rust sys bindings for QEMU/hwcore"
+publish = false
+
+authors.workspace = true
+edition.workspace = true
+homepage.workspace = true
+license.workspace = true
+repository.workspace = true
+rust-version.workspace = true
+
+[lib]
+path = "lib.rs"
+
+[dependencies]
+glib-sys = { workspace = true }
+common = { path = "../../common" }
+chardev-sys = { path = "../chardev-sys" }
+qom-sys = { path = "../qom-sys" }
+migration-sys = { path = "../migration-sys" }
+util-sys = { path = "../util-sys" }
+system-sys = { path = "../system-sys" }
+
+[lints]
+workspace = true
+
+[package.metadata.bindgen]
+header = "wrapper.h"
+rustified-enum = ["DeviceCategory", "GpioPolarity", "MachineInitPhase", "ResetType"]
+bitfield-enum = ["ClockEvent"]
diff --git a/rust/bindings/hwcore-sys/build.rs b/rust/bindings/hwcore-sys/build.rs
new file mode 120000
index 00000000000..10238032f5f
--- /dev/null
+++ b/rust/bindings/hwcore-sys/build.rs
@@ -0,0 +1 @@
+../build.rs
\ No newline at end of file
diff --git a/rust/hw/core/src/bindings.rs b/rust/bindings/hwcore-sys/lib.rs
similarity index 71%
rename from rust/hw/core/src/bindings.rs
rename to rust/bindings/hwcore-sys/lib.rs
index db872d38bc7..8cef4a79619 100644
--- a/rust/hw/core/src/bindings.rs
+++ b/rust/bindings/hwcore-sys/lib.rs
@@ -18,13 +18,15 @@
     clippy::too_many_arguments
 )]
 
-use chardev::bindings::Chardev;
+use chardev_sys::Chardev;
 use common::Zeroable;
-use glib_sys::{GHashTable, GHashTableIter, GList, GPtrArray, GSList};
-use migration::bindings::VMStateDescription;
-use qom::bindings::ObjectClass;
-use system::bindings::MemoryRegion;
-use util::bindings::Error;
+use glib_sys::GSList;
+use migration_sys::VMStateDescription;
+use qom_sys::{
+    InterfaceClass, Object, ObjectClass, ObjectProperty, ObjectPropertyAccessor,
+    ObjectPropertyRelease,
+};
+use util_sys::{Error, QDict, QList};
 
 #[cfg(MESON)]
 include!("bindings.inc.rs");
@@ -35,8 +37,5 @@
 unsafe impl Send for Property {}
 unsafe impl Sync for Property {}
 
-unsafe impl Send for TypeInfo {}
-unsafe impl Sync for TypeInfo {}
-
 unsafe impl Zeroable for Property__bindgen_ty_1 {}
 unsafe impl Zeroable for Property {}
diff --git a/rust/bindings/hwcore-sys/meson.build b/rust/bindings/hwcore-sys/meson.build
new file mode 100644
index 00000000000..3d51947b4a4
--- /dev/null
+++ b/rust/bindings/hwcore-sys/meson.build
@@ -0,0 +1,12 @@
+_bindgen_hwcore_rs = rust.bindgen(
+  args: bindgen_args_common + bindgen_args_data['hwcore-sys'].split(),
+  kwargs: bindgen_kwargs)
+_hwcore_sys_rs = static_library(
+  'hwcore_sys',
+  structured_sources(['lib.rs', _bindgen_hwcore_rs]),
+  override_options: ['rust_std=2021', 'build.rust_std=2021'],
+  rust_abi: 'rust',
+  dependencies: [common_rs, glib_sys_rs, qom_sys_rs, util_sys_rs, migration_sys_rs, chardev_sys_rs],
+)
+
+hwcore_sys_rs = declare_dependency(link_with: [_hwcore_sys_rs])
diff --git a/rust/bindings/meson.build b/rust/bindings/meson.build
new file mode 100644
index 00000000000..c2798731a14
--- /dev/null
+++ b/rust/bindings/meson.build
@@ -0,0 +1,37 @@
+# Generate bindgen arguments from Cargo.toml metadata
+# Sort these in dependency order, same as the subdir()
+# invocations below.
+bindgen_dirs = [
+  'util-sys',
+  'migration-sys',
+  'qom-sys',
+  'chardev-sys',
+  'hwcore-sys',
+  'system-sys',
+]
+bindgen_args_file = configure_file(
+  command: [files('generate_bindgen_args.py'),
+            '-I', meson.project_source_root() / 'include',
+            '--source-dir', meson.current_source_dir(),
+            '-o', '@OUTPUT@', '--dep-file', '@DEPFILE@'] + bindgen_dirs,
+  output: 'bindgen_args.mak',
+  depfile: 'bindgen_args.d'
+)
+
+# now generate all bindgen files
+bindgen_args_data = keyval.load(bindgen_args_file)
+bindgen_kwargs = {
+  'input': 'wrapper.h',
+  'dependencies': common_ss.all_dependencies(),
+  'output': 'bindings.inc.rs',
+  'include_directories': bindings_incdir,
+  'bindgen_version': ['>=0.60.0'],
+  'c_args': bindgen_c_args,
+}
+
+subdir('util-sys')
+subdir('migration-sys')
+subdir('qom-sys')
+subdir('chardev-sys')
+subdir('hwcore-sys')
+subdir('system-sys')
diff --git a/rust/bindings/migration-sys/Cargo.toml b/rust/bindings/migration-sys/Cargo.toml
new file mode 100644
index 00000000000..88d7742e6ac
--- /dev/null
+++ b/rust/bindings/migration-sys/Cargo.toml
@@ -0,0 +1,28 @@
+[package]
+name = "migration-sys"
+version = "0.1.0"
+description = "Rust sys bindings for QEMU/migration"
+publish = false
+
+authors.workspace = true
+edition.workspace = true
+homepage.workspace = true
+license.workspace = true
+repository.workspace = true
+rust-version.workspace = true
+
+[lib]
+path = "lib.rs"
+
+[dependencies]
+glib-sys = { workspace = true }
+common = { path = "../../common" }
+util-sys = { path = "../util-sys" }
+
+[lints]
+workspace = true
+
+[package.metadata.bindgen]
+header = "wrapper.h"
+bitfield-enum = ["MigrationPolicy", "MigrationPriority", "VMStateFlags"]
+blocklist-function = ["vmstate_register_ram", "vmstate_register_ram_global", "vmstate_unregister_ram"]
diff --git a/rust/bindings/migration-sys/build.rs b/rust/bindings/migration-sys/build.rs
new file mode 120000
index 00000000000..10238032f5f
--- /dev/null
+++ b/rust/bindings/migration-sys/build.rs
@@ -0,0 +1 @@
+../build.rs
\ No newline at end of file
diff --git a/rust/bindings/migration-sys/lib.rs b/rust/bindings/migration-sys/lib.rs
new file mode 100644
index 00000000000..7ee30a3f7d5
--- /dev/null
+++ b/rust/bindings/migration-sys/lib.rs
@@ -0,0 +1,125 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+#![allow(
+    dead_code,
+    improper_ctypes_definitions,
+    improper_ctypes,
+    non_camel_case_types,
+    non_snake_case,
+    non_upper_case_globals,
+    unnecessary_transmutes,
+    unsafe_op_in_unsafe_fn,
+    clippy::pedantic,
+    clippy::restriction,
+    clippy::style,
+    clippy::missing_const_for_fn,
+    clippy::ptr_offset_with_cast,
+    clippy::useless_transmute,
+    clippy::missing_safety_doc,
+    clippy::too_many_arguments
+)]
+
+use common::Zeroable;
+use util_sys::{Error, JSONWriter, QEMUFile};
+
+#[cfg(MESON)]
+include!("bindings.inc.rs");
+
+#[cfg(not(MESON))]
+include!(concat!(env!("OUT_DIR"), "/bindings.inc.rs"));
+
+unsafe impl Send for VMStateDescription {}
+unsafe impl Sync for VMStateDescription {}
+
+unsafe impl Send for VMStateField {}
+unsafe impl Sync for VMStateField {}
+
+unsafe impl Send for VMStateInfo {}
+unsafe impl Sync for VMStateInfo {}
+
+// bindgen does not derive Default here
+#[allow(clippy::derivable_impls)]
+impl Default for VMStateFlags {
+    fn default() -> Self {
+        Self(0)
+    }
+}
+
+unsafe impl Zeroable for VMStateFlags {}
+unsafe impl Zeroable for VMStateField {}
+unsafe impl Zeroable for VMStateDescription {}
+
+// The following higher-level helpers could be in "migration"
+// crate when Rust has const trait impl.
+
+pub trait VMStateFlagsExt {
+    const VMS_VARRAY_FLAGS: VMStateFlags;
+}
+
+impl VMStateFlagsExt for VMStateFlags {
+    const VMS_VARRAY_FLAGS: VMStateFlags = VMStateFlags(
+        VMStateFlags::VMS_VARRAY_INT32.0
+            | VMStateFlags::VMS_VARRAY_UINT8.0
+            | VMStateFlags::VMS_VARRAY_UINT16.0
+            | VMStateFlags::VMS_VARRAY_UINT32.0,
+    );
+}
+
+// Add a couple builder-style methods to VMStateField, allowing
+// easy derivation of VMStateField constants from other types.
+impl VMStateField {
+    #[must_use]
+    pub const fn with_version_id(mut self, version_id: i32) -> Self {
+        assert!(version_id >= 0);
+        self.version_id = version_id;
+        self
+    }
+
+    #[must_use]
+    pub const fn with_array_flag(mut self, num: usize) -> Self {
+        assert!(num <= 0x7FFF_FFFFusize);
+        assert!((self.flags.0 & VMStateFlags::VMS_ARRAY.0) == 0);
+        assert!((self.flags.0 & VMStateFlags::VMS_VARRAY_FLAGS.0) == 0);
+        if (self.flags.0 & VMStateFlags::VMS_POINTER.0) != 0 {
+            self.flags = VMStateFlags(self.flags.0 & !VMStateFlags::VMS_POINTER.0);
+            self.flags = VMStateFlags(self.flags.0 | VMStateFlags::VMS_ARRAY_OF_POINTER.0);
+            // VMS_ARRAY_OF_POINTER flag stores the size of pointer.
+            // FIXME: *const, *mut, NonNull and Box<> have the same size as usize.
+            //        Resize if more smart pointers are supported.
+            self.size = std::mem::size_of::<usize>();
+        }
+        self.flags = VMStateFlags(self.flags.0 & !VMStateFlags::VMS_SINGLE.0);
+        self.flags = VMStateFlags(self.flags.0 | VMStateFlags::VMS_ARRAY.0);
+        self.num = num as i32;
+        self
+    }
+
+    #[must_use]
+    pub const fn with_pointer_flag(mut self) -> Self {
+        assert!((self.flags.0 & VMStateFlags::VMS_POINTER.0) == 0);
+        self.flags = VMStateFlags(self.flags.0 | VMStateFlags::VMS_POINTER.0);
+        self
+    }
+
+    #[must_use]
+    pub const fn with_varray_flag_unchecked(mut self, flag: VMStateFlags) -> Self {
+        self.flags = VMStateFlags(self.flags.0 & !VMStateFlags::VMS_ARRAY.0);
+        self.flags = VMStateFlags(self.flags.0 | flag.0);
+        self.num = 0; // varray uses num_offset instead of num.
+        self
+    }
+
+    #[must_use]
+    #[allow(unused_mut)]
+    pub const fn with_varray_flag(mut self, flag: VMStateFlags) -> Self {
+        assert!((self.flags.0 & VMStateFlags::VMS_ARRAY.0) != 0);
+        self.with_varray_flag_unchecked(flag)
+    }
+
+    #[must_use]
+    pub const fn with_varray_multiply(mut self, num: u32) -> Self {
+        assert!(num <= 0x7FFF_FFFFu32);
+        self.flags = VMStateFlags(self.flags.0 | VMStateFlags::VMS_MULTIPLY_ELEMENTS.0);
+        self.num = num as i32;
+        self
+    }
+}
diff --git a/rust/bindings/migration-sys/meson.build b/rust/bindings/migration-sys/meson.build
new file mode 100644
index 00000000000..9243acba300
--- /dev/null
+++ b/rust/bindings/migration-sys/meson.build
@@ -0,0 +1,12 @@
+_bindgen_migration_rs = rust.bindgen(
+  args: bindgen_args_common + bindgen_args_data['migration-sys'].split(),
+  kwargs: bindgen_kwargs)
+_migration_sys_rs = static_library(
+  'migration_sys',
+  structured_sources(['lib.rs', _bindgen_migration_rs]),
+  override_options: ['rust_std=2021', 'build.rust_std=2021'],
+  rust_abi: 'rust',
+  dependencies: [glib_sys_rs, common_rs, util_sys_rs],
+)
+
+migration_sys_rs = declare_dependency(link_with: [_migration_sys_rs])
diff --git a/rust/bindings/qom-sys/Cargo.toml b/rust/bindings/qom-sys/Cargo.toml
new file mode 100644
index 00000000000..621bd468e69
--- /dev/null
+++ b/rust/bindings/qom-sys/Cargo.toml
@@ -0,0 +1,25 @@
+[package]
+name = "qom-sys"
+version = "0.1.0"
+description = "Rust sys bindings for QEMU/qom"
+publish = false
+
+authors.workspace = true
+edition.workspace = true
+homepage.workspace = true
+license.workspace = true
+repository.workspace = true
+rust-version.workspace = true
+
+[lib]
+path = "lib.rs"
+
+[dependencies]
+glib-sys = { workspace = true }
+util-sys = { path = "../util-sys" }
+
+[lints]
+workspace = true
+
+[package.metadata.bindgen]
+header = "wrapper.h"
diff --git a/rust/bindings/qom-sys/build.rs b/rust/bindings/qom-sys/build.rs
new file mode 120000
index 00000000000..10238032f5f
--- /dev/null
+++ b/rust/bindings/qom-sys/build.rs
@@ -0,0 +1 @@
+../build.rs
\ No newline at end of file
diff --git a/rust/qom/src/bindings.rs b/rust/bindings/qom-sys/lib.rs
similarity index 85%
rename from rust/qom/src/bindings.rs
rename to rust/bindings/qom-sys/lib.rs
index e61259ec2ef..464b9290344 100644
--- a/rust/qom/src/bindings.rs
+++ b/rust/bindings/qom-sys/lib.rs
@@ -19,9 +19,13 @@
 )]
 
 use glib_sys::{GHashTable, GHashTableIter, GPtrArray, GSList};
+use util_sys::{Error, QDict, QObject, Visitor};
 
 #[cfg(MESON)]
 include!("bindings.inc.rs");
 
 #[cfg(not(MESON))]
 include!(concat!(env!("OUT_DIR"), "/bindings.inc.rs"));
+
+unsafe impl Send for TypeInfo {}
+unsafe impl Sync for TypeInfo {}
diff --git a/rust/bindings/qom-sys/meson.build b/rust/bindings/qom-sys/meson.build
new file mode 100644
index 00000000000..8f8ae7d1bc8
--- /dev/null
+++ b/rust/bindings/qom-sys/meson.build
@@ -0,0 +1,12 @@
+_bindgen_qom_rs = rust.bindgen(
+  args: bindgen_args_common + bindgen_args_data['qom-sys'].split(),
+  kwargs: bindgen_kwargs)
+_qom_sys_rs = static_library(
+  'qom_sys',
+  structured_sources(['lib.rs', _bindgen_qom_rs]),
+  override_options: ['rust_std=2021', 'build.rust_std=2021'],
+  rust_abi: 'rust',
+  dependencies: [glib_sys_rs, util_sys_rs],
+)
+
+qom_sys_rs = declare_dependency(link_with: [_qom_sys_rs])
diff --git a/rust/bindings/system-sys/Cargo.toml b/rust/bindings/system-sys/Cargo.toml
new file mode 100644
index 00000000000..7e527130ff5
--- /dev/null
+++ b/rust/bindings/system-sys/Cargo.toml
@@ -0,0 +1,30 @@
+[package]
+name = "system-sys"
+version = "0.1.0"
+description = "Rust sys bindings for QEMU/system"
+publish = false
+
+authors.workspace = true
+edition.workspace = true
+homepage.workspace = true
+license.workspace = true
+repository.workspace = true
+rust-version.workspace = true
+
+[lib]
+path = "lib.rs"
+
+[dependencies]
+glib-sys = { workspace = true }
+common = { path = "../../common" }
+migration-sys = { path = "../migration-sys" }
+util-sys = { path = "../util-sys" }
+qom-sys = { path = "../qom-sys" }
+
+[lints]
+workspace = true
+
+[package.metadata.bindgen]
+header = "wrapper.h"
+rustified-enum = ["device_endian"]
+additional-files = ["system/memory.*"]
diff --git a/rust/bindings/system-sys/build.rs b/rust/bindings/system-sys/build.rs
new file mode 120000
index 00000000000..10238032f5f
--- /dev/null
+++ b/rust/bindings/system-sys/build.rs
@@ -0,0 +1 @@
+../build.rs
\ No newline at end of file
diff --git a/rust/system/src/bindings.rs b/rust/bindings/system-sys/lib.rs
similarity index 88%
rename from rust/system/src/bindings.rs
rename to rust/bindings/system-sys/lib.rs
index 7164c5219a5..022fe65dd83 100644
--- a/rust/system/src/bindings.rs
+++ b/rust/bindings/system-sys/lib.rs
@@ -19,7 +19,9 @@
 )]
 
 use common::Zeroable;
-use glib_sys::{guint, GHashTable, GHashTableIter, GList, GPollFD, GPtrArray, GSList};
+use hwcore_sys::{qemu_irq, DeviceClass, DeviceState};
+use qom_sys::{InterfaceClass, Object, ObjectClass};
+use util_sys::{Error, EventNotifier, QEMUBH};
 
 #[cfg(MESON)]
 include!("bindings.inc.rs");
diff --git a/rust/bindings/system-sys/meson.build b/rust/bindings/system-sys/meson.build
new file mode 100644
index 00000000000..aa5e8801149
--- /dev/null
+++ b/rust/bindings/system-sys/meson.build
@@ -0,0 +1,12 @@
+_bindgen_system_rs = rust.bindgen(
+  args: bindgen_args_common + bindgen_args_data['system-sys'].split(),
+  kwargs: bindgen_kwargs)
+_system_sys_rs = static_library(
+  'system_sys',
+  structured_sources(['lib.rs', _bindgen_system_rs]),
+  override_options: ['rust_std=2021', 'build.rust_std=2021'],
+  rust_abi: 'rust',
+  dependencies: [common_rs, glib_sys_rs, hwcore_sys_rs, migration_sys_rs, qom_sys_rs, util_sys_rs],
+)
+
+system_sys_rs = declare_dependency(link_with: [_system_sys_rs])
diff --git a/rust/bindings/util-sys/Cargo.toml b/rust/bindings/util-sys/Cargo.toml
new file mode 100644
index 00000000000..929a08ac4ea
--- /dev/null
+++ b/rust/bindings/util-sys/Cargo.toml
@@ -0,0 +1,25 @@
+[package]
+name = "util-sys"
+version = "0.1.0"
+description = "Rust sys bindings for QEMU/util"
+publish = false
+
+authors.workspace = true
+edition.workspace = true
+homepage.workspace = true
+license.workspace = true
+repository.workspace = true
+rust-version.workspace = true
+
+[lib]
+path = "lib.rs"
+
+[dependencies]
+glib-sys = { workspace = true }
+
+[lints]
+workspace = true
+
+[package.metadata.bindgen]
+header = "wrapper.h"
+rustified-enum = ["module_init_type", "QEMUClockType"]
diff --git a/rust/bindings/util-sys/build.rs b/rust/bindings/util-sys/build.rs
new file mode 120000
index 00000000000..10238032f5f
--- /dev/null
+++ b/rust/bindings/util-sys/build.rs
@@ -0,0 +1 @@
+../build.rs
\ No newline at end of file
diff --git a/rust/util/src/bindings.rs b/rust/bindings/util-sys/lib.rs
similarity index 88%
rename from rust/util/src/bindings.rs
rename to rust/bindings/util-sys/lib.rs
index 3514a66f5fa..0212e941843 100644
--- a/rust/util/src/bindings.rs
+++ b/rust/bindings/util-sys/lib.rs
@@ -18,7 +18,7 @@
     clippy::too_many_arguments
 )]
 
-use glib_sys::{guint, GPollFD, GString};
+use glib_sys::{guint, GArray, GHashTable, GPollFD, GSList, GSource, GString};
 
 #[cfg(MESON)]
 include!("bindings.inc.rs");
diff --git a/rust/bindings/util-sys/meson.build b/rust/bindings/util-sys/meson.build
new file mode 100644
index 00000000000..c37f50a94bd
--- /dev/null
+++ b/rust/bindings/util-sys/meson.build
@@ -0,0 +1,12 @@
+_bindgen_util_rs = rust.bindgen(
+  args: bindgen_args_common + bindgen_args_data['util-sys'].split(),
+  kwargs: bindgen_kwargs)
+_util_sys_rs = static_library(
+  'util_sys',
+  structured_sources(['lib.rs', _bindgen_util_rs]),
+  override_options: ['rust_std=2021', 'build.rust_std=2021'],
+  rust_abi: 'rust',
+  dependencies: [glib_sys_rs],
+)
+
+util_sys_rs = declare_dependency(link_with: [_util_sys_rs])
diff --git a/rust/bql/Cargo.toml b/rust/bql/Cargo.toml
index 8fd81311028..a27099e0587 100644
--- a/rust/bql/Cargo.toml
+++ b/rust/bql/Cargo.toml
@@ -14,6 +14,7 @@ rust-version.workspace = true
 
 [dependencies]
 glib-sys.workspace = true
+util-sys = { path = "../bindings/util-sys" }
 
 [features]
 default = ["debug_cell"]
diff --git a/rust/bql/build.rs b/rust/bql/build.rs
deleted file mode 120000
index 71a3167885c..00000000000
--- a/rust/bql/build.rs
+++ /dev/null
@@ -1 +0,0 @@
-../util/build.rs
\ No newline at end of file
diff --git a/rust/bql/meson.build b/rust/bql/meson.build
index 728c9e4dacf..de295d2983e 100644
--- a/rust/bql/meson.build
+++ b/rust/bql/meson.build
@@ -6,37 +6,11 @@ if get_option('debug_mutex')
   _bql_cfg += ['--cfg', 'feature="debug_cell"']
 endif
 
-#
-# TODO: Remove this comment when the clang/libclang mismatch issue is solved.
-#
-# Rust bindings generation with `bindgen` might fail in some cases where the
-# detected `libclang` does not match the expected `clang` version/target. In
-# this case you must pass the path to `clang` and `libclang` to your build
-# command invocation using the environment variables CLANG_PATH and
-# LIBCLANG_PATH
-_bql_bindings_inc_rs = rust.bindgen(
-  input: 'wrapper.h',
-  dependencies: common_ss.all_dependencies(),
-  output: 'bindings.inc.rs',
-  include_directories: bindings_incdir,
-  bindgen_version: ['>=0.60.0'],
-  args: bindgen_args_common,
-  c_args: bindgen_c_args,
-)
-
 _bql_rs = static_library(
   'bql',
-  structured_sources(
-    [
-      'src/lib.rs',
-      'src/bindings.rs',
-      'src/cell.rs',
-      'src/prelude.rs',
-    ],
-    {'.': _bql_bindings_inc_rs}
-  ),
+  'src/lib.rs',
   rust_args: _bql_cfg,
-  dependencies: [glib_sys_rs],
+  dependencies: [glib_sys_rs, util_sys_rs],
 )
 
 bql_rs = declare_dependency(link_with: [_bql_rs],
diff --git a/rust/bql/src/bindings.rs b/rust/bql/src/bindings.rs
deleted file mode 100644
index c656cf18845..00000000000
--- a/rust/bql/src/bindings.rs
+++ /dev/null
@@ -1,27 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-#![allow(
-    dead_code,
-    improper_ctypes_definitions,
-    improper_ctypes,
-    non_camel_case_types,
-    non_snake_case,
-    non_upper_case_globals,
-    unnecessary_transmutes,
-    unsafe_op_in_unsafe_fn,
-    clippy::pedantic,
-    clippy::restriction,
-    clippy::style,
-    clippy::missing_const_for_fn,
-    clippy::ptr_offset_with_cast,
-    clippy::useless_transmute,
-    clippy::missing_safety_doc,
-    clippy::too_many_arguments
-)]
-
-use glib_sys::{guint, GArray, GHashTable, GHashTableIter, GPollFD, GPtrArray, GSList, GSource};
-
-#[cfg(MESON)]
-include!("bindings.inc.rs");
-
-#[cfg(not(MESON))]
-include!(concat!(env!("OUT_DIR"), "/bindings.inc.rs"));
diff --git a/rust/bql/src/lib.rs b/rust/bql/src/lib.rs
index d2fea5db1ac..3aa3d46d76c 100644
--- a/rust/bql/src/lib.rs
+++ b/rust/bql/src/lib.rs
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 
-mod bindings;
-use bindings::{bql_block_unlock, bql_locked, rust_bql_mock_lock};
+use util_sys::{bql_block_unlock, bql_locked, rust_bql_mock_lock};
 
 mod cell;
 pub use cell::*;
diff --git a/rust/chardev/Cargo.toml b/rust/chardev/Cargo.toml
index f105189dccb..208d44d0cdf 100644
--- a/rust/chardev/Cargo.toml
+++ b/rust/chardev/Cargo.toml
@@ -14,6 +14,7 @@ rust-version.workspace = true
 
 [dependencies]
 glib-sys = { workspace = true }
+chardev-sys = { path = "../bindings/chardev-sys" }
 common = { path = "../common" }
 bql = { path = "../bql" }
 migration = { path = "../migration" }
diff --git a/rust/chardev/build.rs b/rust/chardev/build.rs
deleted file mode 120000
index 71a3167885c..00000000000
--- a/rust/chardev/build.rs
+++ /dev/null
@@ -1 +0,0 @@
-../util/build.rs
\ No newline at end of file
diff --git a/rust/chardev/meson.build b/rust/chardev/meson.build
index 2e4f4670bd8..7b267fd23ae 100644
--- a/rust/chardev/meson.build
+++ b/rust/chardev/meson.build
@@ -1,41 +1,8 @@
-c_enums = [
-  'QEMUChrEvent',
-]
-_chardev_bindgen_args = []
-foreach enum : c_enums
-  _chardev_bindgen_args += ['--rustified-enum', enum]
-endforeach
-
-# TODO: Remove this comment when the clang/libclang mismatch issue is solved.
-#
-# Rust bindings generation with `bindgen` might fail in some cases where the
-# detected `libclang` does not match the expected `clang` version/target. In
-# this case you must pass the path to `clang` and `libclang` to your build
-# command invocation using the environment variables CLANG_PATH and
-# LIBCLANG_PATH
-_chardev_bindings_inc_rs = rust.bindgen(
-  input: 'wrapper.h',
-  dependencies: common_ss.all_dependencies(),
-  output: 'bindings.inc.rs',
-  include_directories: bindings_incdir,
-  bindgen_version: ['>=0.60.0'],
-  args: bindgen_args_common + _chardev_bindgen_args,
-  c_args: bindgen_c_args,
-)
-
 _chardev_rs = static_library(
   'chardev',
-  structured_sources(
-    [
-      'src/lib.rs',
-      'src/bindings.rs',
-      'src/chardev.rs',
-      'src/prelude.rs',
-    ],
-    {'.': _chardev_bindings_inc_rs}
-  ),
+  'src/lib.rs',
   link_with: [_bql_rs, _migration_rs, _qom_rs, _util_rs],
-  dependencies: [glib_sys_rs, common_rs, qemu_macros],
+  dependencies: [glib_sys_rs, common_rs, qemu_macros, chardev_sys_rs],
 )
 
 chardev_rs = declare_dependency(link_with: [_chardev_rs], dependencies: [chardev, qemuutil])
diff --git a/rust/chardev/src/lib.rs b/rust/chardev/src/lib.rs
index 93a28725932..9f1a3a9c1c5 100644
--- a/rust/chardev/src/lib.rs
+++ b/rust/chardev/src/lib.rs
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 
-pub mod bindings;
+pub use chardev_sys as bindings;
 
 mod chardev;
 pub use chardev::*;
diff --git a/rust/hw/char/pl011/build.rs b/rust/hw/char/pl011/build.rs
index 5f5060db356..e3262426852 120000
--- a/rust/hw/char/pl011/build.rs
+++ b/rust/hw/char/pl011/build.rs
@@ -1 +1 @@
-../../../util/build.rs
\ No newline at end of file
+../../../bindings/build.rs
\ No newline at end of file
diff --git a/rust/hw/char/pl011/meson.build b/rust/hw/char/pl011/meson.build
index 9c0e8290e9a..1a1a09e5083 100644
--- a/rust/hw/char/pl011/meson.build
+++ b/rust/hw/char/pl011/meson.build
@@ -1,18 +1,11 @@
-# TODO: Remove this comment when the clang/libclang mismatch issue is solved.
-#
-# Rust bindings generation with `bindgen` might fail in some cases where the
-# detected `libclang` does not match the expected `clang` version/target. In
-# this case you must pass the path to `clang` and `libclang` to your build
-# command invocation using the environment variables CLANG_PATH and
-# LIBCLANG_PATH
 _libpl011_bindings_inc_rs = rust.bindgen(
-  input: 'wrapper.h',
-  dependencies: common_ss.all_dependencies(),
-  output: 'bindings.inc.rs',
-  include_directories: bindings_incdir,
-  bindgen_version: ['>=0.60.0'],
-  args: bindgen_args_common,
-  c_args: bindgen_c_args,
+  args: bindgen_args_common + [
+    '--allowlist-file', meson.project_source_root() / 'include/hw/char/pl011.h',
+    '--blocklist-file',
+      meson.project_source_root() /
+      'include/(block\|chardev/|exec/|hw/core/|qemu/|qom/|system/).*',
+  ],
+  kwargs: bindgen_kwargs,
 )
 
 _libpl011_rs = static_library(
diff --git a/rust/hw/char/pl011/src/bindings.rs b/rust/hw/char/pl011/src/bindings.rs
index 68b9b22bbc3..8e2f8863b18 100644
--- a/rust/hw/char/pl011/src/bindings.rs
+++ b/rust/hw/char/pl011/src/bindings.rs
@@ -20,10 +20,9 @@
 
 //! `bindgen`-generated declarations.
 
-use glib_sys::{
-    gboolean, guint, GArray, GHashTable, GHashTableIter, GIOCondition, GList, GMainContext,
-    GPollFD, GPtrArray, GSList, GSource, GSourceFunc,
-};
+use chardev::bindings::{CharFrontend, Chardev};
+use hwcore::bindings::{qemu_irq, Clock, DeviceState};
+use system::bindings::{hwaddr, MemoryRegion, SysBusDevice};
 
 #[cfg(MESON)]
 include!("bindings.inc.rs");
diff --git a/rust/hw/core/Cargo.toml b/rust/hw/core/Cargo.toml
index ecfb5647184..8cc514da202 100644
--- a/rust/hw/core/Cargo.toml
+++ b/rust/hw/core/Cargo.toml
@@ -14,6 +14,7 @@ rust-version.workspace = true
 
 [dependencies]
 glib-sys.workspace = true
+hwcore-sys = { path = "../../bindings/hwcore-sys" }
 qemu_macros = { path = "../../qemu-macros" }
 common = { path = "../../common" }
 bql = { path = "../../bql" }
diff --git a/rust/hw/core/build.rs b/rust/hw/core/build.rs
deleted file mode 120000
index 2a79ee31b8c..00000000000
--- a/rust/hw/core/build.rs
+++ /dev/null
@@ -1 +0,0 @@
-../../util/build.rs
\ No newline at end of file
diff --git a/rust/hw/core/meson.build b/rust/hw/core/meson.build
index 942ee9cdacf..28ea00cdb4f 100644
--- a/rust/hw/core/meson.build
+++ b/rust/hw/core/meson.build
@@ -1,66 +1,10 @@
-_hwcore_bindgen_args = []
-c_enums = [
-  'DeviceCategory',
-  'GpioPolarity',
-  'MachineInitPhase',
-  'ResetType',
-]
-foreach enum : c_enums
-  _hwcore_bindgen_args += ['--rustified-enum', enum]
-endforeach
-
-blocked_type = [
-  'Chardev',
-  'Error',
-  'ObjectClass',
-  'MemoryRegion',
-  'VMStateDescription',
-]
-foreach type: blocked_type
-  _hwcore_bindgen_args += ['--blocklist-type', type]
-endforeach
-
-c_bitfields = [
-  'ClockEvent',
-]
-foreach enum : c_bitfields
-  _hwcore_bindgen_args += ['--bitfield-enum', enum]
-endforeach
-
-# TODO: Remove this comment when the clang/libclang mismatch issue is solved.
-#
-# Rust bindings generation with `bindgen` might fail in some cases where the
-# detected `libclang` does not match the expected `clang` version/target. In
-# this case you must pass the path to `clang` and `libclang` to your build
-# command invocation using the environment variables CLANG_PATH and
-# LIBCLANG_PATH
-_hwcore_bindings_inc_rs = rust.bindgen(
-  input: 'wrapper.h',
-  dependencies: common_ss.all_dependencies(),
-  output: 'bindings.inc.rs',
-  include_directories: bindings_incdir,
-  bindgen_version: ['>=0.60.0'],
-  args: bindgen_args_common + _hwcore_bindgen_args,
-  c_args: bindgen_c_args,
-)
-
 _hwcore_rs = static_library(
   'hwcore',
-  structured_sources(
-    [
-      'src/lib.rs',
-      'src/bindings.rs',
-      'src/irq.rs',
-      'src/prelude.rs',
-      'src/qdev.rs',
-      'src/sysbus.rs',
-    ],
-    {'.': _hwcore_bindings_inc_rs}
-  ),
+  'src/lib.rs',
   override_options: ['rust_std=2021', 'build.rust_std=2021'],
   rust_abi: 'rust',
   link_with: [_bql_rs, _chardev_rs, _migration_rs, _qom_rs, _system_rs, _util_rs],
-  dependencies: [glib_sys_rs, qemu_macros, common_rs],
+  dependencies: [glib_sys_rs, qemu_macros, common_rs, hwcore_sys_rs],
 )
 
 hwcore_rs = declare_dependency(link_with: [_hwcore_rs],
diff --git a/rust/hw/core/src/lib.rs b/rust/hw/core/src/lib.rs
index 491743d2b9d..76689fe7db1 100644
--- a/rust/hw/core/src/lib.rs
+++ b/rust/hw/core/src/lib.rs
@@ -1,10 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 
+pub use hwcore_sys as bindings;
 pub use qemu_macros::Device;
 pub use qom;
 
-pub mod bindings;
-
 mod irq;
 pub use irq::*;
 
diff --git a/rust/hw/core/src/qdev.rs b/rust/hw/core/src/qdev.rs
index f6037fbdcae..145e20a984f 100644
--- a/rust/hw/core/src/qdev.rs
+++ b/rust/hw/core/src/qdev.rs
@@ -66,7 +66,7 @@ pub trait ResettablePhasesImpl {
 /// can be downcasted to type `T`. We also expect the device is
 /// readable/writeable from one thread at any time.
 unsafe extern "C" fn rust_resettable_enter_fn<T: ResettablePhasesImpl>(
-    obj: *mut bindings::Object,
+    obj: *mut qom::bindings::Object,
     typ: ResetType,
 ) {
     let state = NonNull::new(obj).unwrap().cast::<T>();
@@ -79,7 +79,7 @@ pub trait ResettablePhasesImpl {
 /// can be downcasted to type `T`. We also expect the device is
 /// readable/writeable from one thread at any time.
 unsafe extern "C" fn rust_resettable_hold_fn<T: ResettablePhasesImpl>(
-    obj: *mut bindings::Object,
+    obj: *mut qom::bindings::Object,
     typ: ResetType,
 ) {
     let state = NonNull::new(obj).unwrap().cast::<T>();
@@ -92,7 +92,7 @@ pub trait ResettablePhasesImpl {
 /// can be downcasted to type `T`. We also expect the device is
 /// readable/writeable from one thread at any time.
 unsafe extern "C" fn rust_resettable_exit_fn<T: ResettablePhasesImpl>(
-    obj: *mut bindings::Object,
+    obj: *mut qom::bindings::Object,
     typ: ResetType,
 ) {
     let state = NonNull::new(obj).unwrap().cast::<T>();
diff --git a/rust/hw/core/src/sysbus.rs b/rust/hw/core/src/sysbus.rs
index 81fab3f1910..7db09a82c63 100644
--- a/rust/hw/core/src/sysbus.rs
+++ b/rust/hw/core/src/sysbus.rs
@@ -6,22 +6,21 @@
 
 use std::ffi::CStr;
 
-pub use bindings::SysBusDeviceClass;
 use common::Opaque;
 use qom::prelude::*;
 use system::MemoryRegion;
+pub use system_sys::SysBusDeviceClass;
 use util::{Error, Result};
 
 use crate::{
-    bindings,
     irq::{IRQState, InterruptSource},
     qdev::{DeviceClassExt, DeviceImpl, DeviceState},
 };
 
-/// A safe wrapper around [`bindings::SysBusDevice`].
+/// A safe wrapper around [`system_sys::SysBusDevice`].
 #[repr(transparent)]
 #[derive(Debug, common::Wrapper)]
-pub struct SysBusDevice(Opaque<bindings::SysBusDevice>);
+pub struct SysBusDevice(Opaque<system_sys::SysBusDevice>);
 
 unsafe impl Send for SysBusDevice {}
 unsafe impl Sync for SysBusDevice {}
@@ -29,7 +28,7 @@ unsafe impl Sync for SysBusDevice {}
 unsafe impl ObjectType for SysBusDevice {
     type Class = SysBusDeviceClass;
     const TYPE_NAME: &'static CStr =
-        unsafe { CStr::from_bytes_with_nul_unchecked(bindings::TYPE_SYS_BUS_DEVICE) };
+        unsafe { CStr::from_bytes_with_nul_unchecked(system_sys::TYPE_SYS_BUS_DEVICE) };
 }
 
 qom_isa!(SysBusDevice: DeviceState, Object);
@@ -62,7 +61,7 @@ pub trait SysBusDeviceMethods: ObjectDeref
     fn init_mmio(&self, iomem: &MemoryRegion) {
         assert!(bql::is_locked());
         unsafe {
-            bindings::sysbus_init_mmio(self.upcast().as_mut_ptr(), iomem.as_mut_ptr());
+            system_sys::sysbus_init_mmio(self.upcast().as_mut_ptr(), iomem.as_mut_ptr());
         }
     }
 
@@ -73,7 +72,7 @@ fn init_mmio(&self, iomem: &MemoryRegion) {
     fn init_irq(&self, irq: &InterruptSource) {
         assert!(bql::is_locked());
         unsafe {
-            bindings::sysbus_init_irq(self.upcast().as_mut_ptr(), irq.as_ptr());
+            system_sys::sysbus_init_irq(self.upcast().as_mut_ptr(), irq.as_ptr());
         }
     }
 
@@ -82,7 +81,7 @@ fn mmio_addr(&self, id: u32) -> Option<u64> {
         assert!(bql::is_locked());
         // SAFETY: the BQL ensures that no one else writes to sbd.mmio[], and
         // the SysBusDevice must be initialized to get an IsA<SysBusDevice>.
-        let sbd = unsafe { &*self.upcast().as_ptr() };
+        let sbd = unsafe { &*self.upcast().as_mut_ptr() };
         let id: usize = id.try_into().unwrap();
         if sbd.mmio[id].memory.is_null() {
             None
@@ -96,7 +95,7 @@ fn mmio_map(&self, id: u32, addr: u64) {
         assert!(bql::is_locked());
         let id: i32 = id.try_into().unwrap();
         unsafe {
-            bindings::sysbus_mmio_map(self.upcast().as_mut_ptr(), id, addr);
+            system_sys::sysbus_mmio_map(self.upcast().as_mut_ptr(), id, addr);
         }
     }
 
@@ -108,7 +107,7 @@ fn connect_irq(&self, id: u32, irq: &Owned<IRQState>) {
         let id: i32 = id.try_into().unwrap();
         let irq: &IRQState = irq;
         unsafe {
-            bindings::sysbus_connect_irq(self.upcast().as_mut_ptr(), id, irq.as_mut_ptr());
+            system_sys::sysbus_connect_irq(self.upcast().as_mut_ptr(), id, irq.as_mut_ptr());
         }
     }
 
@@ -116,7 +115,7 @@ fn sysbus_realize(&self) -> Result<()> {
         assert!(bql::is_locked());
         unsafe {
             Error::with_errp(|errp| {
-                bindings::sysbus_realize(self.upcast().as_mut_ptr(), errp);
+                system_sys::sysbus_realize(self.upcast().as_mut_ptr(), errp);
             })
         }
     }
diff --git a/rust/meson.build b/rust/meson.build
index bacb7879102..3a3e10d7b97 100644
--- a/rust/meson.build
+++ b/rust/meson.build
@@ -35,6 +35,7 @@ genrs = []
 subdir('qemu-macros')
 
 subdir('common')
+subdir('bindings')
 subdir('bits')
 
 subdir('util')
diff --git a/rust/migration/Cargo.toml b/rust/migration/Cargo.toml
index 415457496d6..cf10601b44a 100644
--- a/rust/migration/Cargo.toml
+++ b/rust/migration/Cargo.toml
@@ -17,6 +17,7 @@ bql = { path = "../bql" }
 common = { path = "../common" }
 qemu_macros = { path = "../qemu-macros" }
 util = { path = "../util" }
+migration-sys = { path = "../bindings/migration-sys" }
 glib-sys.workspace = true
 
 [lints]
diff --git a/rust/migration/build.rs b/rust/migration/build.rs
deleted file mode 120000
index 71a3167885c..00000000000
--- a/rust/migration/build.rs
+++ /dev/null
@@ -1 +0,0 @@
-../util/build.rs
\ No newline at end of file
diff --git a/rust/migration/meson.build b/rust/migration/meson.build
index 76d86b0ac0f..96266897770 100644
--- a/rust/migration/meson.build
+++ b/rust/migration/meson.build
@@ -1,44 +1,8 @@
-_migration_bindgen_args = []
-c_bitfields = [
-  'MigrationPolicy',
-  'MigrationPriority',
-  'VMStateFlags',
-]
-foreach enum : c_bitfields
-  _migration_bindgen_args += ['--bitfield-enum', enum]
-endforeach
-#
-# TODO: Remove this comment when the clang/libclang mismatch issue is solved.
-#
-# Rust bindings generation with `bindgen` might fail in some cases where the
-# detected `libclang` does not match the expected `clang` version/target. In
-# this case you must pass the path to `clang` and `libclang` to your build
-# command invocation using the environment variables CLANG_PATH and
-# LIBCLANG_PATH
-_migration_bindings_inc_rs = rust.bindgen(
-  input: 'wrapper.h',
-  dependencies: common_ss.all_dependencies(),
-  output: 'bindings.inc.rs',
-  include_directories: bindings_incdir,
-  bindgen_version: ['>=0.60.0'],
-  args: bindgen_args_common + _migration_bindgen_args,
-  c_args: bindgen_c_args,
-)
-
 _migration_rs = static_library(
   'migration',
-  structured_sources(
-    [
-      'src/lib.rs',
-      'src/bindings.rs',
-      'src/migratable.rs',
-      'src/prelude.rs',
-      'src/vmstate.rs',
-    ],
-    {'.' : _migration_bindings_inc_rs},
-  ),
+  'src/lib.rs',
   link_with: [_util_rs, _bql_rs],
-  dependencies: [common_rs, glib_sys_rs, qemu_macros],
+  dependencies: [common_rs, glib_sys_rs, qemu_macros, migration_sys_rs],
 )
 
 migration_rs = declare_dependency(link_with: [_migration_rs],
diff --git a/rust/migration/src/bindings.rs b/rust/migration/src/bindings.rs
deleted file mode 100644
index e9c058386c2..00000000000
--- a/rust/migration/src/bindings.rs
+++ /dev/null
@@ -1,49 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-#![allow(
-    dead_code,
-    improper_ctypes_definitions,
-    improper_ctypes,
-    non_camel_case_types,
-    non_snake_case,
-    non_upper_case_globals,
-    unnecessary_transmutes,
-    unsafe_op_in_unsafe_fn,
-    clippy::pedantic,
-    clippy::restriction,
-    clippy::style,
-    clippy::missing_const_for_fn,
-    clippy::ptr_offset_with_cast,
-    clippy::useless_transmute,
-    clippy::missing_safety_doc,
-    clippy::too_many_arguments
-)]
-
-use common::Zeroable;
-use glib_sys::{GHashTable, GHashTableIter, GPtrArray, GSList};
-
-#[cfg(MESON)]
-include!("bindings.inc.rs");
-
-#[cfg(not(MESON))]
-include!(concat!(env!("OUT_DIR"), "/bindings.inc.rs"));
-
-unsafe impl Send for VMStateDescription {}
-unsafe impl Sync for VMStateDescription {}
-
-unsafe impl Send for VMStateField {}
-unsafe impl Sync for VMStateField {}
-
-unsafe impl Send for VMStateInfo {}
-unsafe impl Sync for VMStateInfo {}
-
-// bindgen does not derive Default here
-#[allow(clippy::derivable_impls)]
-impl Default for VMStateFlags {
-    fn default() -> Self {
-        Self(0)
-    }
-}
-
-unsafe impl Zeroable for VMStateFlags {}
-unsafe impl Zeroable for VMStateField {}
-unsafe impl Zeroable for VMStateDescription {}
diff --git a/rust/migration/src/lib.rs b/rust/migration/src/lib.rs
index 32e182e716a..6d819cc1554 100644
--- a/rust/migration/src/lib.rs
+++ b/rust/migration/src/lib.rs
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 
-pub mod bindings;
-
+pub use migration_sys as bindings;
 pub use qemu_macros::ToMigrationState;
 
 pub mod migratable;
diff --git a/rust/migration/src/vmstate.rs b/rust/migration/src/vmstate.rs
index 595e7e9cd75..edc7c702656 100644
--- a/rust/migration/src/vmstate.rs
+++ b/rust/migration/src/vmstate.rs
@@ -165,79 +165,6 @@ macro_rules! vmstate_of {
     };
 }
 
-pub trait VMStateFlagsExt {
-    const VMS_VARRAY_FLAGS: VMStateFlags;
-}
-
-impl VMStateFlagsExt for VMStateFlags {
-    const VMS_VARRAY_FLAGS: VMStateFlags = VMStateFlags(
-        VMStateFlags::VMS_VARRAY_INT32.0
-            | VMStateFlags::VMS_VARRAY_UINT8.0
-            | VMStateFlags::VMS_VARRAY_UINT16.0
-            | VMStateFlags::VMS_VARRAY_UINT32.0,
-    );
-}
-
-// Add a couple builder-style methods to VMStateField, allowing
-// easy derivation of VMStateField constants from other types.
-impl VMStateField {
-    #[must_use]
-    pub const fn with_version_id(mut self, version_id: i32) -> Self {
-        assert!(version_id >= 0);
-        self.version_id = version_id;
-        self
-    }
-
-    #[must_use]
-    pub const fn with_array_flag(mut self, num: usize) -> Self {
-        assert!(num <= 0x7FFF_FFFFusize);
-        assert!((self.flags.0 & VMStateFlags::VMS_ARRAY.0) == 0);
-        assert!((self.flags.0 & VMStateFlags::VMS_VARRAY_FLAGS.0) == 0);
-        if (self.flags.0 & VMStateFlags::VMS_POINTER.0) != 0 {
-            self.flags = VMStateFlags(self.flags.0 & !VMStateFlags::VMS_POINTER.0);
-            self.flags = VMStateFlags(self.flags.0 | VMStateFlags::VMS_ARRAY_OF_POINTER.0);
-            // VMS_ARRAY_OF_POINTER flag stores the size of pointer.
-            // FIXME: *const, *mut, NonNull and Box<> have the same size as usize.
-            //        Resize if more smart pointers are supported.
-            self.size = std::mem::size_of::<usize>();
-        }
-        self.flags = VMStateFlags(self.flags.0 & !VMStateFlags::VMS_SINGLE.0);
-        self.flags = VMStateFlags(self.flags.0 | VMStateFlags::VMS_ARRAY.0);
-        self.num = num as i32;
-        self
-    }
-
-    #[must_use]
-    pub const fn with_pointer_flag(mut self) -> Self {
-        assert!((self.flags.0 & VMStateFlags::VMS_POINTER.0) == 0);
-        self.flags = VMStateFlags(self.flags.0 | VMStateFlags::VMS_POINTER.0);
-        self
-    }
-
-    #[must_use]
-    pub const fn with_varray_flag_unchecked(mut self, flag: VMStateFlags) -> Self {
-        self.flags = VMStateFlags(self.flags.0 & !VMStateFlags::VMS_ARRAY.0);
-        self.flags = VMStateFlags(self.flags.0 | flag.0);
-        self.num = 0; // varray uses num_offset instead of num.
-        self
-    }
-
-    #[must_use]
-    #[allow(unused_mut)]
-    pub const fn with_varray_flag(mut self, flag: VMStateFlags) -> Self {
-        assert!((self.flags.0 & VMStateFlags::VMS_ARRAY.0) != 0);
-        self.with_varray_flag_unchecked(flag)
-    }
-
-    #[must_use]
-    pub const fn with_varray_multiply(mut self, num: u32) -> Self {
-        assert!(num <= 0x7FFF_FFFFu32);
-        self.flags = VMStateFlags(self.flags.0 | VMStateFlags::VMS_MULTIPLY_ELEMENTS.0);
-        self.num = num as i32;
-        self
-    }
-}
-
 /// This macro can be used (by just passing it a type) to forward the `VMState`
 /// trait to the first field of a tuple.  This is a workaround for lack of
 /// support of nested [`offset_of`](core::mem::offset_of) until Rust 1.82.0.
diff --git a/rust/qom/Cargo.toml b/rust/qom/Cargo.toml
index 4be3c2541b6..aed8af5474a 100644
--- a/rust/qom/Cargo.toml
+++ b/rust/qom/Cargo.toml
@@ -18,6 +18,7 @@ bql = { path = "../bql" }
 migration = { path = "../migration" }
 qemu_macros = { path = "../qemu-macros" }
 util = { path = "../util" }
+qom-sys = { path = "../bindings/qom-sys" }
 glib-sys.workspace = true
 
 [lints]
diff --git a/rust/qom/build.rs b/rust/qom/build.rs
deleted file mode 120000
index 71a3167885c..00000000000
--- a/rust/qom/build.rs
+++ /dev/null
@@ -1 +0,0 @@
-../util/build.rs
\ No newline at end of file
diff --git a/rust/qom/meson.build b/rust/qom/meson.build
index dda26c3f981..9865da280cf 100644
--- a/rust/qom/meson.build
+++ b/rust/qom/meson.build
@@ -1,33 +1,8 @@
-# TODO: Remove this comment when the clang/libclang mismatch issue is solved.
-#
-# Rust bindings generation with `bindgen` might fail in some cases where the
-# detected `libclang` does not match the expected `clang` version/target. In
-# this case you must pass the path to `clang` and `libclang` to your build
-# command invocation using the environment variables CLANG_PATH and
-# LIBCLANG_PATH
-_qom_bindings_inc_rs = rust.bindgen(
-  input: 'wrapper.h',
-  dependencies: common_ss.all_dependencies(),
-  output: 'bindings.inc.rs',
-  include_directories: bindings_incdir,
-  bindgen_version: ['>=0.60.0'],
-  args: bindgen_args_common,
-  c_args: bindgen_c_args,
-)
-
 _qom_rs = static_library(
   'qom',
-  structured_sources(
-    [
-      'src/lib.rs',
-      'src/bindings.rs',
-      'src/prelude.rs',
-      'src/qom.rs',
-    ],
-    {'.': _qom_bindings_inc_rs}
-  ),
+  'src/lib.rs',
   link_with: [_bql_rs, _migration_rs],
-  dependencies: [common_rs, glib_sys_rs, qemu_macros],
+  dependencies: [common_rs, glib_sys_rs, qemu_macros, qom_sys_rs],
 )
 
 qom_rs = declare_dependency(link_with: [_qom_rs], dependencies: [qemu_macros, qom, qemuutil])
diff --git a/rust/qom/src/lib.rs b/rust/qom/src/lib.rs
index 24c44fc2afb..1bed1cfe233 100644
--- a/rust/qom/src/lib.rs
+++ b/rust/qom/src/lib.rs
@@ -1,8 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 
 pub use qemu_macros::Object;
-
-pub mod bindings;
+pub use qom_sys as bindings;
 
 // preserve one-item-per-"use" syntax, it is clearer
 // for prelude-like modules
diff --git a/rust/system/Cargo.toml b/rust/system/Cargo.toml
index 186ea00bfff..f7fde9782ea 100644
--- a/rust/system/Cargo.toml
+++ b/rust/system/Cargo.toml
@@ -14,6 +14,9 @@ rust-version.workspace = true
 
 [dependencies]
 common = { path = "../common" }
+system-sys = { path = "../bindings/system-sys" }
+bql = { path = "../bql" }
+migration = { path = "../migration" }
 qom = { path = "../qom" }
 util = { path = "../util" }
 glib-sys.workspace = true
diff --git a/rust/system/build.rs b/rust/system/build.rs
deleted file mode 120000
index 71a3167885c..00000000000
--- a/rust/system/build.rs
+++ /dev/null
@@ -1 +0,0 @@
-../util/build.rs
\ No newline at end of file
diff --git a/rust/system/meson.build b/rust/system/meson.build
index e9f36ed8554..4cbd63cbbd7 100644
--- a/rust/system/meson.build
+++ b/rust/system/meson.build
@@ -1,41 +1,8 @@
-c_enums = [
-  'device_endian',
-]
-_system_bindgen_args = []
-foreach enum : c_enums
-  _system_bindgen_args += ['--rustified-enum', enum]
-endforeach
-
-# TODO: Remove this comment when the clang/libclang mismatch issue is solved.
-#
-# Rust bindings generation with `bindgen` might fail in some cases where the
-# detected `libclang` does not match the expected `clang` version/target. In
-# this case you must pass the path to `clang` and `libclang` to your build
-# command invocation using the environment variables CLANG_PATH and
-# LIBCLANG_PATH
-_system_bindings_inc_rs = rust.bindgen(
-  input: 'wrapper.h',
-  dependencies: common_ss.all_dependencies(),
-  output: 'bindings.inc.rs',
-  include_directories: bindings_incdir,
-  bindgen_version: ['>=0.60.0'],
-  args: bindgen_args_common + _system_bindgen_args,
-  c_args: bindgen_c_args,
-)
-
 _system_rs = static_library(
   'system',
-  structured_sources(
-    [
-      'src/lib.rs',
-      'src/bindings.rs',
-      'src/memory.rs',
-      'src/prelude.rs',
-    ],
-    {'.': _system_bindings_inc_rs}
-  ),
+  'src/lib.rs',
   link_with: [_bql_rs, _migration_rs, _qom_rs, _util_rs],
-  dependencies: [glib_sys_rs, common_rs, qemu_macros],
+  dependencies: [glib_sys_rs, common_rs, qemu_macros, system_sys_rs],
 )
 
 system_rs = declare_dependency(link_with: [_system_rs],
diff --git a/rust/system/src/lib.rs b/rust/system/src/lib.rs
index 5fb83b65d8d..10741e0ee0a 100644
--- a/rust/system/src/lib.rs
+++ b/rust/system/src/lib.rs
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 
-pub mod bindings;
+pub use system_sys as bindings;
 
 mod memory;
 pub use memory::*;
diff --git a/rust/system/src/memory.rs b/rust/system/src/memory.rs
index 4e06c16a0b5..4c258201bad 100644
--- a/rust/system/src/memory.rs
+++ b/rust/system/src/memory.rs
@@ -132,7 +132,7 @@ unsafe impl Sync for MemoryRegion {}
 impl MemoryRegion {
     unsafe fn do_init_io(
         slot: *mut bindings::MemoryRegion,
-        owner: *mut bindings::Object,
+        owner: *mut qom::bindings::Object,
         ops: &'static bindings::MemoryRegionOps,
         name: &'static str,
         size: u64,
diff --git a/rust/util/Cargo.toml b/rust/util/Cargo.toml
index 85f91436545..2ad5940daca 100644
--- a/rust/util/Cargo.toml
+++ b/rust/util/Cargo.toml
@@ -18,6 +18,7 @@ foreign = { workspace = true }
 glib-sys = { workspace = true }
 libc = { workspace = true }
 common = { path = "../common" }
+util-sys = { path = "../bindings/util-sys" }
 
 [lints]
 workspace = true
diff --git a/rust/util/meson.build b/rust/util/meson.build
index 98629394afb..6d175ae0b0f 100644
--- a/rust/util/meson.build
+++ b/rust/util/meson.build
@@ -1,45 +1,7 @@
-_util_bindgen_args = []
-c_enums = [
-  'module_init_type',
-  'QEMUClockType',
-]
-foreach enum : c_enums
-  _util_bindgen_args += ['--rustified-enum', enum]
-endforeach
-
-#
-# TODO: Remove this comment when the clang/libclang mismatch issue is solved.
-#
-# Rust bindings generation with `bindgen` might fail in some cases where the
-# detected `libclang` does not match the expected `clang` version/target. In
-# this case you must pass the path to `clang` and `libclang` to your build
-# command invocation using the environment variables CLANG_PATH and
-# LIBCLANG_PATH
-_util_bindings_inc_rs = rust.bindgen(
-  input: 'wrapper.h',
-  dependencies: common_ss.all_dependencies(),
-  output: 'bindings.inc.rs',
-  include_directories: bindings_incdir,
-  bindgen_version: ['>=0.60.0'],
-  args: bindgen_args_common + _util_bindgen_args,
-  c_args: bindgen_c_args,
-)
-
 _util_rs = static_library(
   'util',
-  structured_sources(
-    [
-      'src/lib.rs',
-      'src/bindings.rs',
-      'src/error.rs',
-      'src/log.rs',
-      'src/module.rs',
-      'src/prelude.rs',
-      'src/timer.rs',
-    ],
-    {'.': _util_bindings_inc_rs}
-  ),
-  dependencies: [anyhow_rs, libc_rs, foreign_rs, glib_sys_rs, common_rs],
+  'src/lib.rs',
+  dependencies: [anyhow_rs, libc_rs, foreign_rs, glib_sys_rs, common_rs, util_sys_rs],
 )
 
 util_rs = declare_dependency(link_with: [_util_rs], dependencies: [qemuutil, qom])
diff --git a/rust/util/src/lib.rs b/rust/util/src/lib.rs
index 7d2de3ed811..436c67e139e 100644
--- a/rust/util/src/lib.rs
+++ b/rust/util/src/lib.rs
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 
-pub mod bindings;
+pub use util_sys as bindings;
+
 pub mod error;
 pub mod log;
 pub mod module;
-- 
2.52.0


