Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 016FED1CDD0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 10:10:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3Bq9-0004qn-Ss; Tue, 22 Oct 2024 06:10:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t3Bq7-0004px-C6
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 06:10:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t3Bq3-0004KM-8Y
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 06:10:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729591804;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=tbvXfRrFBOsk5giDSgfqNdSIEAUGb9q/RRGU64sx1+8=;
 b=CTBW8Ktqvm6YUOvoNpLUnjMo6/gYzP6ppd7QPW7DReDJWgOe+Y8UXwQ3uuwxlhGRfd7z62
 Yq2ItbzbKh0cGs4WLh1CHhbCCwsP7886AO5Rqxhw29/4deQ5Jivhm+3EJv5M+GgVT675ED
 MixsqXDqMCOqizwfGyAEHaS8M7PIRp8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-1-hfbGvD8iNXC7xazB7U9vVQ-1; Tue, 22 Oct 2024 06:10:02 -0400
X-MC-Unique: hfbGvD8iNXC7xazB7U9vVQ-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-37d5116f0a6so2638628f8f.0
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2024 03:10:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729591799; x=1730196599;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tbvXfRrFBOsk5giDSgfqNdSIEAUGb9q/RRGU64sx1+8=;
 b=wn1yCQLNKv4TQQdWMPixjE5LaPVABtns9IzV9KQsGq9anQVc7fH3zOSs+jBn5NHLzc
 mXUu3D3UJ8lagu8oCm51VerVvy38USUXqwsMj+kVYkKdD9J4KmfOIfU9lA6zF0pzMKk9
 fdYbDjxkoCdQHm/LE8VBzddw7SEtNJhnvf28ZY1X2DciWzXpZyICtKVtj0bugwH6YlHP
 qlNC9P/+Vs8zk8S8Vy19pUJ16D6y3AXZY/o8OZ2umD17JrC4+XTDM0i/68FeZuhp5WAO
 Zchs2jR0HQv+Hcv2DWoDViz7xjnCi7Bf74ufaHA83P8ZSZ9Il6N5Gy+eH4lWufkR7fiN
 eZxw==
X-Gm-Message-State: AOJu0YzM89Eyd90I8LzY00VddVWIwxmbc0/2wxtpOl5JuZ6kthk2ZwTk
 EOTHCuCTw/BTZaNCrzreHuUZ+cYum81IoS8Tize/+OfJd8oTrFATZCn2CRqdkg9RxwfmKtz4TaS
 pjb2AMNwoc/fRIbv3rFiHyOR7O8EmrSmT5RaSUJkLW6jmIy3W0KPzD75yXkdEHex/LHOA0kgBAs
 9TwUAMSnWfMbbkfUFfqCKo4MtxVsgESkodVL2DyLo=
X-Received: by 2002:a5d:5266:0:b0:37d:509e:8742 with SMTP id
 ffacd0b85a97d-37ea2140fe2mr8649067f8f.1.1729591799433; 
 Tue, 22 Oct 2024 03:09:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+z8jHGDB1rp1c/5b7xSLnfMWGqpXU1YvY4wZ6yWcK9A/pC31BB3okWvd1B2Jr9T0rK5wEJQ==
X-Received: by 2002:a5d:5266:0:b0:37d:509e:8742 with SMTP id
 ffacd0b85a97d-37ea2140fe2mr8649048f8f.1.1729591799025; 
 Tue, 22 Oct 2024 03:09:59 -0700 (PDT)
Received: from avogadro.local ([151.95.144.54])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37ee0a488edsm6277685f8f.31.2024.10.22.03.09.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2024 03:09:58 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, kwolf@redhat.com, junjie.mao@hotmail.com,
 manos.pitsidianakis@linaro.org
Subject: [PATCH v2 00/14] rust: allow older versions of rustc and bindgen
Date: Tue, 22 Oct 2024 12:09:41 +0200
Message-ID: <20241022100956.196657-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.421,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.699,
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

This is the second of three series needed to enable Rust for all CI
jobs (the third is due to differences in the functionality between
C and Rust implementations of PL011, for which I have sent the RFC
a little earlier).

My overall patch queue can be found at branch rust-next of my git
repository https://gitlab.com/bonzini/qemu.git.

Note that this requires "meson subprojects update --reset" in order to do
an incremental build if you have already downloaded the Rust subprojects.
While I have a solution for that (modeled after scripts/git-submodule.sh),
I first need to check with the Meson folks whether my script is using only
stable interfaces.

Paolo

Based-on: <20241021163538.136941-1-pbonzini@redhat.com>

CI:
- Debian: https://gitlab.com/bonzini/qemu/-/jobs/8149518712
- Fedora: https://gitlab.com/bonzini/qemu/-/jobs/8149518714
- Fedora + nightly Rust: https://gitlab.com/bonzini/qemu/-/jobs/8149518716
- Ubuntu: https://gitlab.com/bonzini/qemu/-/jobs/8149518709


Junjie Mao (1):
  rust: introduce alternative implementation of offset_of!

Paolo Bonzini (13):
  rust: patch bilge-impl to allow compilation with 1.63.0
  rust: fix cfgs of proc-macro2 for 1.63.0
  rust: use std::os::raw instead of core::ffi
  rust: introduce a c_str macro
  rust: silence unknown warnings for the sake of old compilers
  rust: synchronize dependencies between subprojects and Cargo.lock
  rust: do not use MaybeUninit::zeroed()
  rust: clean up detection of the language
  rust: allow version 1.63.0 of rustc
  rust: do not use --generate-cstr
  rust: allow older version of bindgen
  rust: make rustfmt optional
  dockerfiles: install bindgen from cargo on Ubuntu 22.04

 docs/about/build-platforms.rst                |   8 +
 meson.build                                   | 102 +++++++----
 .gitattributes                                |   2 +
 .gitlab-ci.d/buildtest.yml                    |   2 +-
 meson_options.txt                             |   2 +
 rust/hw/char/pl011/Cargo.lock                 |   6 +-
 rust/hw/char/pl011/src/device.rs              |  28 +--
 rust/hw/char/pl011/src/device_class.rs        |   5 +-
 rust/hw/char/pl011/src/lib.rs                 |   4 +-
 rust/hw/char/pl011/src/memory_ops.rs          |  10 +-
 rust/qemu-api-macros/Cargo.lock               |  11 +-
 rust/qemu-api-macros/Cargo.toml               |   5 +-
 rust/qemu-api-macros/src/lib.rs               |  29 +++-
 rust/qemu-api/Cargo.lock                      |  56 +++++-
 rust/qemu-api/Cargo.toml                      |   7 +-
 rust/qemu-api/build.rs                        |   8 +
 rust/qemu-api/meson.build                     |  16 +-
 rust/qemu-api/src/c_str.rs                    |  53 ++++++
 rust/qemu-api/src/definitions.rs              |   2 +-
 rust/qemu-api/src/device_class.rs             |  26 ++-
 rust/qemu-api/src/lib.rs                      |  16 +-
 rust/qemu-api/src/offset_of.rs                | 161 ++++++++++++++++++
 rust/qemu-api/src/zeroable.rs                 |  91 ++++++++--
 rust/qemu-api/tests/tests.rs                  |  22 +--
 scripts/meson-buildoptions.sh                 |   4 +
 subprojects/bilge-impl-0.2-rs.wrap            |   1 +
 subprojects/packagefiles/.gitattributes       |   1 +
 .../packagefiles/bilge-impl-1.63.0.patch      |  45 +++++
 .../packagefiles/proc-macro2-1-rs/meson.build |   4 +-
 subprojects/packagefiles/syn-2-rs/meson.build |   1 +
 tests/docker/dockerfiles/ubuntu2204.docker    |   5 +
 tests/lcitool/mappings.yml                    |   4 +
 tests/lcitool/refresh                         |  11 +-
 33 files changed, 644 insertions(+), 104 deletions(-)
 create mode 100644 rust/qemu-api/src/c_str.rs
 create mode 100644 rust/qemu-api/src/offset_of.rs
 create mode 100644 subprojects/packagefiles/.gitattributes
 create mode 100644 subprojects/packagefiles/bilge-impl-1.63.0.patch

--=20
2.46.2


