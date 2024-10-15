Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97645D2169C
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 13:19:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0hQx-00022G-BX; Tue, 15 Oct 2024 09:17:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t0hQv-00021g-Ib
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 09:17:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t0hQq-0001D6-GI
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 09:17:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728998267;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=oAn+Ba1dDRR3H13ir8fJK4AAlm1xGe4h5u0jRCUFUZM=;
 b=Te30DFvYg+TeYUUicWjOUnEiiLFO6RY0dO6e3H5KXxW3Wn000gCDadNdNIoXW8NdLpnUIx
 u/asNwVKGld1KyKfDjQ9nvNF3GimCFTpXA36o6eaCZMTvFJdwo7Ectw06NMT/6PFMX3Wig
 HDscNpT+J7KjQ69KeBp31R+rDlwIppE=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-LWw2QIRYPRS-jnXphmwPiw-1; Tue, 15 Oct 2024 09:17:42 -0400
X-MC-Unique: LWw2QIRYPRS-jnXphmwPiw-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-539e91e12bbso2429284e87.2
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2024 06:17:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728998260; x=1729603060;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oAn+Ba1dDRR3H13ir8fJK4AAlm1xGe4h5u0jRCUFUZM=;
 b=nNlwZxIp6lbvWumDpKoP/gm5tJfWFWcgJkNFiS7BA4fsCor4649DfB5DQf4Qx9S9Ay
 hR6urdcGJhc/4UHRN556EyD29ChrFo4lUCTphE7dQNe+JQ8Mha3WLo9SaDPe+CDg0QfD
 hTaEc4xEMIGbATMQVo0CYWoXycqFFObLplZkwDbXywkaeclBtyljSp6KvYaYKZDPSOv4
 Gmu/OznDyHVesNvoYuqeyBZrA58BY21Ppdina0x+tGZDVE8EGSPD3p3qR1ymY4sfoHF3
 pPyhTB3RgYOmRhzi91oryThSqvZo7yKewvxoFTZmoVffW0jB6Ehc1EqVsUDxtOseFcu4
 LU6A==
X-Gm-Message-State: AOJu0Yw2evN0Fi1xzhjyI21AkFhuQxoc3XgPI41A4S4sajvJkPsoxXQ7
 Qz6MswjNnp6ermZR0ryi228YblqTuWbRBP3jn85b4VF+044Y4s+xrfZQbM5TzCI9NcvHvQyjCIh
 3MtHQMtgmcZxJTk9MLQGI05hV/gI09qi0uD0mQTnPE0TZr+0+ctPUvoXKl3Af1GVWmr/FDrPUGp
 kosqL5MwK6V4IHYequqqXSAkCc/eODwDlYPbTxk9k=
X-Received: by 2002:a05:6512:280c:b0:539:a039:9bb6 with SMTP id
 2adb3069b0e04-539e57282bcmr5773102e87.56.1728998259999; 
 Tue, 15 Oct 2024 06:17:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3f+w8wOEpUAZFi1vIdA0bpO1jqYZt1kbXX/W2IvyEn+fvMySYvgu6D/vh36dyjxmqEh9pGA==
X-Received: by 2002:a05:6512:280c:b0:539:a039:9bb6 with SMTP id
 2adb3069b0e04-539e57282bcmr5773073e87.56.1728998259208; 
 Tue, 15 Oct 2024 06:17:39 -0700 (PDT)
Received: from avogadro.local ([151.95.144.54])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4313f55e0b2sm17950515e9.4.2024.10.15.06.17.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2024 06:17:38 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 00/16] rust: allow older versions of rustc and bindgen
Date: Tue, 15 Oct 2024 15:17:18 +0200
Message-ID: <20241015131735.518771-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This includes a few fixes to the Rust build system machinery, and
removes constructs that were added or stabilized after version 1.63.0:

- "let else" (by patching bilge-impl, patch 4; stable in 1.65.0)

- std::sync::OnceLock (patch 6; stable in 1.70.0)

- core::ffi (patch 7; stable in 1.64.0)

- c"" literals (patch 9; stable in 1.77.0)

- offset_of! (patch 10; stable in 1.77.0)

- MaybeUninit::zeroed() (patch 11; stable in 1.75.0 in const context)

It also replicates the configuration checks normally done by
proc-macro2's build.rs into our Meson-based build rules, so that
the crate can be made to work with an older version of rustc.

As a small bonus, patch 11 removes some uses of unsafe, so that patch
probably won't just be simply reverted even once we can assume version
1.75.0 of the language.  And as another small bonus this series introduces
the first use of Rust unit tests.

On top of this, the required version of bindgen is still too new
for Debian 12 and Ubuntu 22.04.  This is fixed by the last four patches.

This is an RFC for two reasons.  First, because it would be a valid
decision to delay enabling of Rust until at least some of these
features are available in all supported distros.  Another possibility
could be to accept Rust 1.64.0 but require installing a newer bindgen
(0.66.x for example) on those two distros with an older release.  Second,
because the series is missing the CI updates to actually ensure that
these minimum versions keep working.

The main purpose is to show the kind of hacks that would be needed
to support older toolchains.  The fixes (for example patches
1/2/3/6/8/11/13/14) can be easily extracted independent of the outcome
of the discussion, and/or while the CI updates are made.

Thanks,

Paolo

Paolo Bonzini (16):
  meson: import rust module into a global variable
  meson: remove repeated search for rust_root_crate.sh
  rust: pass rustc_args when building all crates
  rust: patch bilge-impl to allow compilation with 1.63.0
  rust: fix cfgs of proc-macro2 for 1.63.0
  rust: do not use OnceLock for properties
  rust: use std::os::raw instead of core::ffi
  rust: build tests for the qemu_api crate
  rust: introduce a c_str macro
  rust: introduce alternative implementation of offset_of!
  rust: do not use MaybeUninit::zeroed()
  rust: allow version 1.63.0 of rustc
  rust: do not use TYPE_CHARDEV unnecessarily
  rust: do not use --no-size_t-is-usize
  rust: do not use --generate-cstr
  rust: allow older version of bindgen

 meson.build                                   |  42 ++++---
 .gitattributes                                |   2 +
 rust/hw/char/pl011/src/device.rs              | 117 ++++++++++--------
 rust/hw/char/pl011/src/device_class.rs        |  13 +-
 rust/hw/char/pl011/src/lib.rs                 |   4 +-
 rust/hw/char/pl011/src/memory_ops.rs          |  21 ++--
 rust/qemu-api-macros/meson.build              |   2 +-
 rust/qemu-api/meson.build                     |  17 ++-
 rust/qemu-api/src/c_str.rs                    |  52 ++++++++
 rust/qemu-api/src/definitions.rs              |  10 +-
 rust/qemu-api/src/device_class.rs             |  49 +++++---
 rust/qemu-api/src/lib.rs                      |  14 ++-
 rust/qemu-api/src/offset_of.rs                | 106 ++++++++++++++++
 rust/qemu-api/src/tests.rs                    |  21 ++--
 rust/qemu-api/src/zeroable.rs                 |  75 +++++++++++
 subprojects/bilge-impl-0.2-rs.wrap            |   1 +
 .../packagefiles/bilge-impl-1.63.0.patch      |  45 +++++++
 .../packagefiles/proc-macro2-1-rs/meson.build |   4 +-
 18 files changed, 469 insertions(+), 126 deletions(-)
 create mode 100644 rust/qemu-api/src/c_str.rs
 create mode 100644 rust/qemu-api/src/offset_of.rs
 create mode 100644 rust/qemu-api/src/zeroable.rs
 create mode 100644 subprojects/packagefiles/bilge-impl-1.63.0.patch

--=20
2.46.2


