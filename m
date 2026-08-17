Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A036CC5DF66
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 13:46:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvxev-0003LD-B3; Mon, 17 Aug 2026 09:45:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wvxer-0003KJ-Fw
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 09:45:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wvxep-0001x4-O1
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 09:45:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786974343;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=GevxyuWn8FuBdYTpxPvpYbIo5BMMWCibwO+Cr6MbZNc=;
 b=ShPeqk/baIPW6MJ4zHTQQYmA6iiHzwm2UXPttwSad78AHu4yyKFBF0fo7BUwb6ZPFPXP/C
 Vokgeyj79mXvp2nETzG/HSbD4ObxEsywXucHOuY8fQg0HgQaS6iqgIw4qQqJfsQ/LElFdk
 cVRHkbyHwHMN5W+ro0DHNVgqt00QLU0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-482-o-N55jdhNoeeBCRO0MK1iQ-1; Mon, 17 Aug 2026 09:45:41 -0400
X-MC-Unique: o-N55jdhNoeeBCRO0MK1iQ-1
X-Mimecast-MFC-AGG-ID: o-N55jdhNoeeBCRO0MK1iQ_1786974340
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-499900c9d99so16242835e9.0
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 06:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1786974340; x=1787579140; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=GevxyuWn8FuBdYTpxPvpYbIo5BMMWCibwO+Cr6MbZNc=;
 b=lTZcFwG46eTU9kpOWTirIVUKcvuvRMGT4i91HHbWwaDo5ySfrvntU0Lo/AFuuAa9Ad
 gvNB9ThEW2KwPMJKRdCua9/IMggMlHygQL1l7+M+vlJR67KkQm6KKD/QtaGsl1g1E4ch
 SYlbM+7Na4wvhP+xZnFpxyXmzqhBZedOUComkluTABSVZQ5GPOBp0NLAPsbuDDGbY2Us
 IqYCnZj8nTg6KZI21wPMBLTVGIVl4nNB5Q2Tdbdq4UNkmFgxyYcJQNJRc0btxkMmSq95
 lNc0MAZ13rBKr2z4Lp4xAPyem9ZhIL+NNA3jAcJVBIED4JCQmYNjN7KTFP9NFs0Mcv8z
 1rGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786974340; x=1787579140;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GevxyuWn8FuBdYTpxPvpYbIo5BMMWCibwO+Cr6MbZNc=;
 b=Eguhh3QbxN3gKl62vHKyfZkeIzCEX9eJmnkZNwu05CagL2Oa0mzTNJOg7HaQkaI0Ur
 GOJXc0aA/fa/iv032Aw5aOAakWgCZopmZg1of/2WvDgXKNUgv0zJv1/ixXzKt3sgq/+Z
 T2iq53iOqQFnSMLNlk/ptpiwnZoTH3HzRG9nt9bA7bRHf5L5OH/hwbAPOV6BmKfh3xgR
 JNYD1Lrlr2+PRmZ/sg3qHPy7Z3hDDBAq5PDNsv/lpZGRn8ic1MBtADEo7tPc7MZuQ7rW
 vGBOh+rkehWU9BSewauOVogrG2inT9eBvMAzG7g0lXigqNT767cmoi4K/5Nn+eZXS3X4
 VW7Q==
X-Gm-Message-State: AOJu0Yy0PZxtWH3QT83sRajMZ+PLmTQGdN3u+GGh9+GHxRqmByKVlQ9S
 a37rzW0FI1dslTSHRUWCG2mrrgKPxUTJ56WRgmyC6ocCbSfA+E+5b7QDQZFC3e9DQnBLYMZqny5
 XZJ0CUw1bsjFCwUSuslGkJ1Rhwlz8mr9WXGoo3wQ9iWMjuKV6Ja4AzDwm1HjR3qdUocZNl6BtLW
 aDfX9iGuO+2vtfYyqA2BPHuKPHoUGb4vc8bQWSDRJc
X-Gm-Gg: AR+sD10K9bU4eXzgrPQSHVDJJXhVRFBvevhth2dfruKLU9Vv9Uyj7bb2hE5w+YuzYPD
 OtAAb6TYXhdvBzkzjmh5esr6SZyC0SKe5RH1gt4hX+cUneQzMRiEy9IANenMleSFmBbKsC5FEt2
 9Xl4s0GCS8JMdOwDWRoVApe6Heic9ZGohHP9tisZenupr6s+LqmGTQ3gFss5bJWiSrZLQUFUPB+
 JJKoUa7ZdkfrVzQ07g1QO+N7K4CNuQsvoq7OsF2wqBN0/IiTT6hW+OchhXRxyBFUiwh1Eo1dzav
 AbiXYu8T5B1eNiyuctCUsWkGXoqGL99UaqWfLVUl6jFGdASHHDAXoKBxny6jrfwgrstppqWv5ji
 rMvv1crarC1lFSbcLeOpcYCDwMlkL50UxXZmscAlEert2cMUTEC5z7FnlmlJjMWWvYfalyh3Fg1
 SMQXw=
X-Received: by 2002:a05:600c:5307:b0:499:8c68:a3aa with SMTP id
 5b1f17b1804b1-4998c68a830mr386440955e9.13.1786974339864; 
 Mon, 17 Aug 2026 06:45:39 -0700 (PDT)
X-Received: by 2002:a05:600c:5307:b0:499:8c68:a3aa with SMTP id
 5b1f17b1804b1-4998c68a830mr386439905e9.13.1786974339402; 
 Mon, 17 Aug 2026 06:45:39 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.34.92])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4999d06167csm43831385e9.3.2026.08.17.06.45.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 06:45:38 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org
Subject: [PATCH 0/9] First batch of Rust changes for QEMU 11.2
Date: Mon, 17 Aug 2026 15:45:28 +0200
Message-ID: <20260817134538.924615-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.343,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This finally brings in a version of Meson where Cargo subprojects are
powerful enough to remove large parts of QEMU's handwritten build rules
of scripts/rust/rustc_args.py.  In particular this includes the following
Meson features

- usage of a single Cargo.lock to resolve crate versions (1.10.0)

- support for Cargo workspaces (also 1.10.0)

- parsing of Cargo.toml files from QEMU to resolve features (1.11.0
  and patch 3)...

- ... and to simplify build rules (also 1.11.0, and patch 4)

- build-machine subprojects for cross-compilation scenarios (1.12.0)

In other words, this finally realizes the plan from 2024 of using Cargo
subprojects to build dependent crates, aka the reason why QEMU isn't
invoking Cargo like many other projects do (such as libblkio).

The introduction of Cargo subprojects would also allow in principle
to build libigvm and as part of QEMU itself.  To this end Meson
1.12.0 also simplifies the invocation of cbindgen, which libigvm
uses as part of its build process.

Paolo

Based-on: <20260817134313.922754-1-pbonzini@redhat.com>

Paolo Bonzini (9):
  python, meson: update meson required for Rust to 1.12.0
  rust: update Cargo.lock
  rust: switch to cargo subprojects
  rust: switch to autogenerated meson rules
  meson: use compiler_target() to get rustc target
  rust: use meson automatic parsing of Cargo.toml
  docs: rust: update for new-style build rules
  scripts: remove now dead parts of rustc_args.py
  rust: update Cargo dependencies

 docs/devel/rust.rst                           |  85 ++++++-----------
 configure                                     |   7 +-
 meson.build                                   |  16 ++--
 .gitlab-ci.d/static_checks.yml                |   4 +-
 rust/Cargo.lock => Cargo.lock                 |  87 ++++++++----------
 rust/Cargo.toml => Cargo.toml                 |   6 +-
 python/scripts/vendor.py                      |   4 +-
 python/wheels/meson-1.11.1-py3-none-any.whl   | Bin 1078534 -> 0 bytes
 python/wheels/meson-1.12.0-py3-none-any.whl   | Bin 0 -> 1106208 bytes
 pythondeps.toml                               |   4 +-
 rust/bindings/chardev-sys/meson.build         |  11 +--
 rust/bindings/hwcore-sys/meson.build          |  11 +--
 rust/bindings/migration-sys/meson.build       |  11 +--
 rust/bindings/qom-sys/meson.build             |  11 +--
 rust/bindings/system-sys/meson.build          |  11 +--
 rust/bindings/util-sys/meson.build            |  11 +--
 rust/bits/meson.build                         |   7 +-
 rust/bql/meson.build                          |  13 +--
 rust/chardev/meson.build                      |   8 +-
 rust/common/meson.build                       |  10 +-
 rust/hw/char/pl011/meson.build                |  22 +----
 rust/hw/core/meson.build                      |  10 +-
 rust/hw/timer/hpet/meson.build                |  17 +---
 rust/meson.build                              |  26 +-----
 rust/migration/meson.build                    |   8 +-
 rust/qemu-macros/meson.build                  |  12 +--
 rust/qom/meson.build                          |   8 +-
 rust/system/meson.build                       |   8 +-
 rust/trace/meson.build                        |   9 +-
 rust/util/meson.build                         |   7 +-
 scripts/get-wraps-from-cargo-registry.py      |   6 --
 scripts/rust/rustc_args.py                    |  80 +---------------
 subprojects/anyhow-1-rs.wrap                  |   5 +-
 subprojects/arbitrary-int-1-rs.wrap           |   3 +-
 subprojects/attrs-0.2-rs.wrap                 |   3 +-
 subprojects/bilge-0.2-rs.wrap                 |   3 +-
 subprojects/bilge-impl-0.2-rs.wrap            |   3 +-
 subprojects/either-1-rs.wrap                  |   3 +-
 subprojects/foreign-0.3-rs.wrap               |   3 +-
 subprojects/glib-sys-0.21-rs.wrap             |   3 +-
 subprojects/itertools-0.11-rs.wrap            |   3 +-
 subprojects/libc-0.2-rs.wrap                  |   5 +-
 .../packagefiles/anyhow-1-rs/meson.build      |  33 -------
 .../anyhow-1-rs/meson/meson.build             |   9 ++
 .../arbitrary-int-1-rs/meson.build            |  21 -----
 .../packagefiles/attrs-0.2-rs/meson.build     |  33 -------
 .../packagefiles/bilge-0.2-rs/meson.build     |  31 -------
 .../bilge-impl-0.2-rs/meson.build             |  44 ---------
 .../packagefiles/either-1-rs/meson.build      |  26 ------
 .../packagefiles/foreign-0.3-rs/meson.build   |  26 ------
 .../packagefiles/glib-sys-0.21-rs/meson.build |  33 -------
 .../itertools-0.11-rs/meson.build             |  32 -------
 .../packagefiles/libc-0.2-rs/meson.build      |  37 --------
 .../libc-0.2-rs/meson/meson.build             |  16 ++++
 .../packagefiles/probe-0.5-rs/meson.build     |  22 -----
 .../proc-macro-error-1-rs/meson.build         |  41 ---------
 .../proc-macro-error-1-rs/meson/meson.build   |   3 +
 .../proc-macro-error-attr-1-rs/meson.build    |  31 -------
 .../packagefiles/proc-macro2-1-rs/meson.build |  35 -------
 .../proc-macro2-1-rs/meson/meson.build        |   6 ++
 .../packagefiles/quote-1-rs/meson.build       |  31 -------
 subprojects/packagefiles/syn-2-rs/meson.build |  43 ---------
 .../unicode-ident-1-rs/meson.build            |  22 -----
 subprojects/probe-0.5-rs.wrap                 |   3 +-
 subprojects/proc-macro-error-1-rs.wrap        |   4 +-
 subprojects/proc-macro-error-attr-1-rs.wrap   |   3 +-
 subprojects/proc-macro2-1-rs.wrap             |   4 +-
 subprojects/quote-1-rs.wrap                   |   3 +-
 subprojects/syn-2-rs.wrap                     |   3 +-
 subprojects/unicode-ident-1-rs.wrap           |   3 +-
 70 files changed, 194 insertions(+), 968 deletions(-)
 rename rust/Cargo.lock => Cargo.lock (85%)
 rename rust/Cargo.toml => Cargo.toml (97%)
 delete mode 100644 python/wheels/meson-1.11.1-py3-none-any.whl
 create mode 100644 python/wheels/meson-1.12.0-py3-none-any.whl
 delete mode 100644 subprojects/packagefiles/anyhow-1-rs/meson.build
 create mode 100644 subprojects/packagefiles/anyhow-1-rs/meson/meson.build
 delete mode 100644 subprojects/packagefiles/arbitrary-int-1-rs/meson.build
 delete mode 100644 subprojects/packagefiles/attrs-0.2-rs/meson.build
 delete mode 100644 subprojects/packagefiles/bilge-0.2-rs/meson.build
 delete mode 100644 subprojects/packagefiles/bilge-impl-0.2-rs/meson.build
 delete mode 100644 subprojects/packagefiles/either-1-rs/meson.build
 delete mode 100644 subprojects/packagefiles/foreign-0.3-rs/meson.build
 delete mode 100644 subprojects/packagefiles/glib-sys-0.21-rs/meson.build
 delete mode 100644 subprojects/packagefiles/itertools-0.11-rs/meson.build
 delete mode 100644 subprojects/packagefiles/libc-0.2-rs/meson.build
 create mode 100644 subprojects/packagefiles/libc-0.2-rs/meson/meson.build
 delete mode 100644 subprojects/packagefiles/probe-0.5-rs/meson.build
 delete mode 100644 subprojects/packagefiles/proc-macro-error-1-rs/meson.build
 create mode 100644 subprojects/packagefiles/proc-macro-error-1-rs/meson/meson.build
 delete mode 100644 subprojects/packagefiles/proc-macro-error-attr-1-rs/meson.build
 delete mode 100644 subprojects/packagefiles/proc-macro2-1-rs/meson.build
 create mode 100644 subprojects/packagefiles/proc-macro2-1-rs/meson/meson.build
 delete mode 100644 subprojects/packagefiles/quote-1-rs/meson.build
 delete mode 100644 subprojects/packagefiles/syn-2-rs/meson.build
 delete mode 100644 subprojects/packagefiles/unicode-ident-1-rs/meson.build

-- 
2.55.0


