Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADE2BCAC5BC
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 15:52:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3G8u-0000tn-LF; Mon, 29 Sep 2025 11:50:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v3G8d-0000lb-5U
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 11:50:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v3G8N-0000Jv-E1
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 11:50:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759160987;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=bB3ETipJ99LL4ETjcgIieiwbUW59t6EdehJVc92k5SU=;
 b=TSrSVhmQYqHKw72+SsyeMeiS9POxC7c2Q77J82DdgqEBxFMIJtXv87U8u3bE4ziH6nQQAp
 yGXUhVwmlOs5bvy3fqFRucO0BywGL9xaKQZGvOh5qvzOAclJp/Vw/HMKiTlNGTSg3BIJ7k
 sxxxDi5PJ3PRlBPdJNq6apfHO3TYHx0=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-324-KWpJmmB6NMuFZeOMWoqK1A-1; Mon, 29 Sep 2025 11:49:43 -0400
X-MC-Unique: KWpJmmB6NMuFZeOMWoqK1A-1
X-Mimecast-MFC-AGG-ID: KWpJmmB6NMuFZeOMWoqK1A_1759160982
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-634c2fc71c9so3960164a12.3
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 08:49:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759160981; x=1759765781;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bB3ETipJ99LL4ETjcgIieiwbUW59t6EdehJVc92k5SU=;
 b=vf7t8dFHN7M1u1LyFTSh+MSKj1HkQQ+WVbnUVD73YNJ4O339hGVNA5oJ8BGVUJWy/C
 NDfaRc2VHI+v2ereXJs4ngpyKgkD3nyQHFRMlMt0py4oKPbcdIv9KVwaVbqMzuqIOj3F
 QZwu95bOMYeKGlgmTC+TjX0iu0SHDtbVqpkD/CMIpnqaq8PKCvmXf60ajGkDlrh7MaRN
 UteRGs2+FjQBJCZPo0GM4PagaQo76soNlHllUq5rUzXEStGOtOq8st8rSkeRceTcDl74
 72AvF/pzOuR7LwaXL1h1jiTgbvyvQqgI3W8TQugV1FURDnHufcb6mwHLnb3qffZbrqXn
 YGPA==
X-Gm-Message-State: AOJu0YyK8uDf2SbPt1XolNg2cIieVGwh6QFVUf2wH1C/m6ILymenJ1zG
 FETxB86NQ0cvPRUlWsMX4aqTPD7XaI3U9l3oKIdRAV08xTVMQi3VXtAQ+tK8YJ6m31ViFyJO0d+
 eqqw6VwycaH91Xg7bPE+HyScl+exDldszXcAgXBuzoAMbC7GZPG+qMqfDQYqtVGY+WNDBeUmjEw
 FNuaaoz2nnNb54n1i10RPsZs1DHHXU6MLMLp8atk3r
X-Gm-Gg: ASbGncu2j6HAgWPt/78U1AlYuD+Jz9ueaTApc1aY1JYi2iSyPr8SClw7hhIOzATrCRo
 htHpbZxBSw8JWGFTbhIOiKm1en+dzl9iCaMHhOwu6T0vFQTbJQ3BLEdApKk4d9zp8SBVEoNsC52
 ogC+BN3nXR+/xTlBXut8sTLlzJIpTIOoJOKab+wVVMJwVpdzxiMpYsiqG1iuV/j/C0IbHwO25A5
 PWah2KZy39O2L62pPXXTO8Oi7tcXlXouDDYCk1Yz74ycBYlEb/0VkNEIKs5Pc2YYjY9lq0pdBmt
 SlklYSHTCK0z8141PNktP4oCtMfUDavXeirT2H3f3UObKQp7PO8RKYwDzYo6IFvxRllnyjUhKYp
 T2Lk6kUgZ8g7JCBSNFEMKw/7I7Lq9GmXWWT+eUyF0Bt1Rpg==
X-Received: by 2002:aa7:c88f:0:b0:631:b058:bef0 with SMTP id
 4fb4d7f45d1cf-6349faa0ceamr11279726a12.32.1759160980846; 
 Mon, 29 Sep 2025 08:49:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXgsOHFcd6JSZV6Wo6JxAKLpLGxS4etIUT99AJBFdRUizQ2bqY53dKfIwB3sq6zTvkOZDAcg==
X-Received: by 2002:aa7:c88f:0:b0:631:b058:bef0 with SMTP id
 4fb4d7f45d1cf-6349faa0ceamr11279698a12.32.1759160980366; 
 Mon, 29 Sep 2025 08:49:40 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.127.188])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-634a3629878sm8072891a12.5.2025.09.29.08.49.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Sep 2025 08:49:39 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Tanish Desai <tanishdesai37@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Mads Ynddal <mads@ynddal.dk>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, qemu-rust@nongnu.org
Subject: [PATCH v2 00/16] tracetool: add Rust support
Date: Mon, 29 Sep 2025 17:49:22 +0200
Message-ID: <20250929154938.594389-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.513,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This is almost the same as v1, other than:
- more dead code removal in patches 2 and 8
- renaming a function in patch 8, and consequent change to test vectors

It adds Rust support to tracetool and tracepoint support for the pl011
device.  All the backends are supported except dtrace and ust.

Patches 1-5 are cleanups.

Patches 6-7 are tracetool patches that have been posted before, now
rebased on top of the "make check-tracetool" series.  Their purpose
is to simplify .h code generation for tracetool backends, and these
simplifications translate directly to the new .rs code generation.

Patches 8-9 add the minimal support for adding tracepoint functions
in Rust, albeit with no content and thus no actual tracing.

Patches 10-11 add back tracepoints to the Rust pl011 device model.

Patches 12-16 finally add Rust code generation to the supported
tracing backends.

Paolo

Paolo Bonzini (8):
  tracetool: fix usage of try_import()
  tracetool: remove dead code
  treewide: remove unnessary "coding" header
  tracetool: add SPDX headers
  trace/ftrace: move snprintf+write from tracepoints to ftrace.c
  rust: qdev: add minimal clock bindings
  rust: pl011: add tracepoints
  log: change qemu_loglevel to unsigned

Tanish Desai (8):
  tracetool: add CHECK_TRACE_EVENT_GET_STATE
  tracetool/backend: remove redundant trace event checks
  tracetool: Add Rust format support
  rust: add trace crate
  tracetool/simple: add Rust support
  tracetool/log: add Rust support
  tracetool/ftrace: add Rust support
  tracetool/syslog: add Rust support

 docs/conf.py                                  |   2 -
 docs/sphinx-static/theme_overrides.css        |   3 +-
 include/qemu/log-for-trace.h                  |   4 +-
 include/qemu/log.h                            |  44 ++--
 tests/tracetool/ftrace.h                      |  28 +--
 tests/tracetool/log.h                         |  16 +-
 trace/ftrace.h                                |   1 +
 trace/ftrace.c                                |  15 ++
 util/log.c                                    |   2 +-
 hw/char/trace-events                          |  14 +-
 rust/Cargo.lock                               |   8 +
 rust/Cargo.toml                               |   1 +
 rust/hw/char/pl011/Cargo.toml                 |   1 +
 rust/hw/char/pl011/meson.build                |   1 +
 rust/hw/char/pl011/src/device.rs              |  57 +++--
 rust/hw/core/src/qdev.rs                      |  33 +++
 rust/meson.build                              |   2 +-
 rust/trace/Cargo.toml                         |  19 ++
 rust/trace/meson.build                        |  19 ++
 rust/trace/src/lib.rs                         |  39 ++++
 rust/util/src/log.rs                          |   2 +-
 scripts/analyse-locks-simpletrace.py          |   1 -
 scripts/modinfo-collect.py                    |   1 -
 scripts/modinfo-generate.py                   |   1 -
 scripts/oss-fuzz/minimize_qtest_trace.py      |   1 -
 scripts/oss-fuzz/output_reproducer.py         |   1 -
 .../oss-fuzz/reorder_fuzzer_qtest_trace.py    |   1 -
 scripts/probe-gdb-support.py                  |   1 -
 scripts/qapi/error.py                         |   2 -
 scripts/qapi/expr.py                          |   2 -
 scripts/qapi/gen.py                           |   2 -
 scripts/qapi/parser.py                        |   2 -
 scripts/qapi/schema.py                        |   2 -
 scripts/qemu-plugin-symbols.py                |   1 -
 scripts/qemugdb/tcg.py                        |   2 -
 scripts/qemugdb/timers.py                     |   1 -
 scripts/replay-dump.py                        |   1 -
 scripts/tracetool.py                          |   1 -
 scripts/tracetool/__init__.py                 | 202 ++++++++++++++----
 scripts/tracetool/backend/__init__.py         |  43 ++--
 scripts/tracetool/backend/dtrace.py           |   2 +-
 scripts/tracetool/backend/ftrace.py           |  26 +--
 scripts/tracetool/backend/log.py              |  22 +-
 scripts/tracetool/backend/simple.py           |  17 +-
 scripts/tracetool/backend/syslog.py           |  17 +-
 scripts/tracetool/backend/ust.py              |   2 +-
 scripts/tracetool/format/__init__.py          |   4 +-
 scripts/tracetool/format/c.py                 |   2 +-
 scripts/tracetool/format/d.py                 |   2 +-
 scripts/tracetool/format/h.py                 |  18 +-
 scripts/tracetool/format/log_stap.py          |   4 +-
 scripts/tracetool/format/rs.py                |  64 ++++++
 scripts/tracetool/format/simpletrace_stap.py  |   4 +-
 scripts/tracetool/format/stap.py              |   2 +-
 scripts/tracetool/format/ust_events_c.py      |   2 +-
 scripts/tracetool/format/ust_events_h.py      |   2 +-
 tests/tracetool/ftrace.rs                     |  40 ++++
 tests/tracetool/log.rs                        |  44 ++++
 tests/tracetool/simple.rs                     |  40 ++++
 tests/tracetool/syslog.rs                     |  40 ++++
 tests/tracetool/tracetool-test.py             |   2 +
 trace/meson.build                             |   8 +-
 62 files changed, 720 insertions(+), 223 deletions(-)
 create mode 100644 rust/trace/Cargo.toml
 create mode 100644 rust/trace/meson.build
 create mode 100644 rust/trace/src/lib.rs
 create mode 100644 scripts/tracetool/format/rs.py
 create mode 100644 tests/tracetool/ftrace.rs
 create mode 100644 tests/tracetool/log.rs
 create mode 100644 tests/tracetool/simple.rs
 create mode 100644 tests/tracetool/syslog.rs

-- 
2.51.0


