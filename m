Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEDD0CD5BB1
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 17:57:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRw12-0001u0-WD; Tue, 26 May 2026 13:56:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wRw0z-0001ss-MU
 for qemu-devel@nongnu.org; Tue, 26 May 2026 13:56:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wRw0w-0007r9-R3
 for qemu-devel@nongnu.org; Tue, 26 May 2026 13:56:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779818185;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=HvKVa4IBD5m0mm2Fk+BGzDf6GqaCK/Ssk78WO/x5q4Q=;
 b=aEbBsRK7rYZKMGDDOgqX0n7AC/yG+nsrf1ZJIqL6AMPIRrjbu+2yYDFnV3V+kIszywddkF
 iQn6Axsaqnud+dKfWuS70xs3HPn1oNod6fhr2jgFgQAygBKYOKSEJoyicHciIWBYZZNYLk
 bjm8pOvPKLVsQ6XAsVhwBCBsv9IxB1M=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-484-IuovcpNmMzmorrPz8wUAPQ-1; Tue, 26 May 2026 13:56:22 -0400
X-MC-Unique: IuovcpNmMzmorrPz8wUAPQ-1
X-Mimecast-MFC-AGG-ID: IuovcpNmMzmorrPz8wUAPQ_1779818181
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-44696b11265so13359500f8f.0
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 10:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779818181; x=1780422981; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=HvKVa4IBD5m0mm2Fk+BGzDf6GqaCK/Ssk78WO/x5q4Q=;
 b=N+KxhomhVsFTc7hiCpDOZ39Fwhoxqh8cFUH3V/j4fSzqv7Pl0d3EVqLwGn2YGKJPJm
 DAAHA8pFyH1bAxm7DpNYUk8uFvA6Fe9s0/fOGerc/lnHor8dvDcEaHfAjD+4FezV/32z
 /9a3fg7RexHar9cUzgChlPVuif1PX9EWnZiMwuH3mdk5BNLZFYPYcIHEQrgOUzugw+Y1
 vILeXKuKnmfekSfoGYfjAGa86zYxzqn7AhK2cD5HxR0o3L6r++KAG3nyrXWD2eQ4irHZ
 qjdJpEVt+Fg0nFhZYNhDaJgzFAHvZhLJWl+3sDWmewesdmgIbHzd8JJUo1ar7CYPPFr9
 T/Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779818181; x=1780422981;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HvKVa4IBD5m0mm2Fk+BGzDf6GqaCK/Ssk78WO/x5q4Q=;
 b=qtz+iFUlT3SKmLcOODr+vXE7vuIQH3vO7hBq6zJO9D/B5DSEpLzBP/CDqeuiWJpVi9
 vcRbZYDVznQs5DihvE5/b0Ulne78UZnt0L+zWq02zxbcWirbA5O83yyCm0IzYkrS+e5B
 h3UhOsOBOhCEH/xUlK3vM3dYmo1K1wnW3fnBLfJetOb8GDnbIk74+LMEUpvLOT+jTkH+
 LoMVdQhh92s3YY3ELrVrxUJaoJxTYdoEq2zArCvYU2x5LlNDQUrqA0B6kvAPojCkLHq6
 Oldii05/6bDDAOIF7++kG661Q7+l8pU9ByC+BghoEr4Hm08YZf3eP5T9IlPALFHylf/A
 UAxA==
X-Gm-Message-State: AOJu0YzMP0SQAemTffjHVkGPK5sEcMh4+hcBzBoYBqIB1LYHOSEnOEtX
 oujh1bhntz6Y3Z790HqHvq3gANGMyxiHxS1apvnesZ9VYdI7JvRW7OO/s3cIRz95VVhFZdD1Yhl
 A7sveCKY8tJqEmpsZaUQjLjKaqYWKdBHO7rI08eV+2N//fhFLfYR+xyphT1X084wDv2iGxDyesp
 UCpUpjl6jLT1nJ0Pqs6QqgU17JKNvJ4yieDV6+0hB2
X-Gm-Gg: Acq92OEXUmJBYQv2Bwa1+BGfoeom4t8sHNMDPjoNrigb743A4p7cFRWdeu1mTzm1VWy
 7c+dOhbHfzIkC/VXMGwBUQBgR+7bii+1jmLPdpKlATaxahQQq9/2IPWZA32p3c+IWR4jx4srMub
 cszS8F0HgEHvuPcse+SJMXZVL4c4/s6aFuUAZ0AED5Q5YKunmmCIPGF0zIJJUgTtnLdn52OKaCE
 +fKgIVVV19X/vHdRVrkPSQKEjky96dP7JCM128z/Mg3omG2eLCo8DauwW5hcKgu3+rkt5+zRqjM
 GXFiduJI2161tBIea3ANbuB29/HtXqi63r02xl2b1ZCUL7RMfkgNhRfQ+rjdmCAV5RG//3gdqAY
 roIvsea4DVNIpWNpE4LmEhGI77X4szFBXSDV2jWqG5crcWzGZDtPVxIXYuDSOMne43x1MwpKGn9
 ZQec92nHud7FRxmCfrYXVuyV3Um7uMibQzXTOE2Q==
X-Received: by 2002:a05:6000:2f89:b0:43f:e99a:ff91 with SMTP id
 ffacd0b85a97d-45eb369ce86mr30129432f8f.4.1779818180752; 
 Tue, 26 May 2026 10:56:20 -0700 (PDT)
X-Received: by 2002:a05:6000:2f89:b0:43f:e99a:ff91 with SMTP id
 ffacd0b85a97d-45eb369ce86mr30129369f8f.4.1779818180143; 
 Tue, 26 May 2026 10:56:20 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.251.208])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6d71688sm39500886f8f.33.2026.05.26.10.56.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 10:56:19 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org,
	armbru@redhat.com,
	marcandre.lureau@redhat.com
Subject: [PATCH v3 00/19] rust: QObject and QAPI bindings
Date: Tue, 26 May 2026 19:55:59 +0200
Message-ID: <20260526175618.227743-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This adds two related parts of the Rust bindings:

- QAPI code generator that creates Rust structs from the JSON
  description.  The structs are *not* ABI compatible with the
  C ones, instead they use native Rust data types.

- QObject bindings and (de)serialization support, which can be used to
  convert QObjects to and from QAPI structs.

Unfortunately Rust code is not able to use visitors, other than by
creating an intermediate QObject.  This is because of the different
architecture of serde vs. QAPI visitors, and because visitor's
dual-purpose functions, where the same function is used by both input and
output visitors, rely heavily on the structs using the same representation
as the visitor arguments (for example NUL-terminated strings).

The serde format implementation was co-authored by me and Marc-André.
Marc-André did all the bug fixing and integration testing.

The main change from v2 is the introduction of two patches to
restrict a bit the QAPI language and embed some things that Rust's
type system enforces.  I think both of them are sensible
restrictions in general:

- new patch "scripts/qapi: reject empty enums", because empty enums
  cannot have any plausible meaning.  Note that if all items are
  conditional the enum is still allowed;

- new patch "scripts/qapi: enum with conditional first item must
  be optional", to avoid giving different meanings to an all zero
  struct; and also happening to catch the "all items are conditional"
  case of the previous patch, ensuring that structs containing that
  enum can be created.

Everything else is mostly cosmetic.

Paolo

v2->v3:
- QObject bindgen already done by rust/bindings/util-sys
- meson build rules are simpler due to util-sys vs util split
- comment adjustments for qobject/mod.rs
- preserve error from CStr::to_str() and CString::new()
- add de::Error implementation for qobject::error::Error
- new patch "scripts/qapi: reject empty enums"
- new patch "scripts/qapi: enum with conditional first item must be optional"
- add comment to commit message on why camer_to_upper()'s callers use
  lstrip('_') for C
- new patch "allow passing multiple segments to mcgen" to improve
  code formatting (fewer empty lines)
- add comment to commit message on why Rust for now is a separate backend
- rewrite to_camel_case(), changing 'foo-0123-bar' to 'Foo0123Bar' instead
  of 'Foo_0123Bar'
- use blurb argument for QAPIGenRs constructor


Marc-André Lureau (6):
  rust/qobject: add Display/Debug
  scripts/qapi: add QAPISchemaIfCond.rsgen()
  scripts/qapi: generate high-level Rust bindings
  scripts/rustc_args: add --no-strict-cfg
  rust/util: build QAPI types
  rust/tests: QAPI integration tests

Paolo Bonzini (13):
  rust/qobject: add basic bindings
  subprojects: add serde
  rust/qobject: add Serialize implementation
  rust/qobject: add Serializer (to_qobject) implementation
  rust/qobject: add Deserialize implementation
  rust/qobject: add Deserializer (from_qobject) implementation
  rust/qobject: add from/to JSON bindings for QObject
  scripts/qapi: reject empty enums
  scripts/qapi: enum with conditional first item must be optional
  scripts/qapi: add QAPISchemaType.is_predefined
  scripts/qapi: pull c_name and lstrip from camel_to_upper to caller
  scripts/qapi: allow passing multiple segments to mcgen
  scripts/qapi: add serde attributes

 docs/devel/rust.rst                           |   1 +
 meson.build                                   |   4 +-
 include/qobject/qobject.h                     |   5 +-
 qapi/meson.build                              |   9 +
 rust/Cargo.lock                               |   2 +
 rust/Cargo.toml                               |   2 +
 rust/meson.build                              |   4 +
 rust/tests/meson.build                        |  21 +-
 rust/tests/tests/integration.rs               |   2 +
 rust/tests/tests/qapi.rs                      | 444 +++++++++++++
 rust/util/Cargo.toml                          |   2 +
 rust/util/meson.build                         |  19 +-
 rust/util/src/lib.rs                          |   4 +
 rust/util/src/qobject/deserialize.rs          | 134 ++++
 rust/util/src/qobject/deserializer.rs         | 371 +++++++++++
 rust/util/src/qobject/error.rs                |  58 ++
 rust/util/src/qobject/mod.rs                  | 385 ++++++++++++
 rust/util/src/qobject/serialize.rs            |  57 ++
 rust/util/src/qobject/serializer.rs           | 585 ++++++++++++++++++
 scripts/archive-source.sh                     |   3 +
 scripts/make-release                          |   2 +-
 scripts/qapi/backend.py                       |  25 +
 scripts/qapi/common.py                        |  94 ++-
 scripts/qapi/rs.py                            |  50 ++
 scripts/qapi/rs_types.py                      | 393 ++++++++++++
 scripts/qapi/schema.py                        |  86 ++-
 scripts/rust/rustc_args.py                    |  16 +-
 subprojects/.gitignore                        |   3 +
 .../packagefiles/serde-1-rs/meson.build       |  36 ++
 .../packagefiles/serde-1.0.226-include.patch  |  16 +
 .../packagefiles/serde_core-1-rs/meson.build  |  25 +
 .../serde_core-1.0.226-include.patch          |  15 +
 .../serde_derive-1-rs/meson.build             |  35 ++
 .../serde_derive-1.0.226-include.patch        |  11 +
 subprojects/serde-1-rs.wrap                   |  11 +
 subprojects/serde_core-1-rs.wrap              |  11 +
 subprojects/serde_derive-1-rs.wrap            |  11 +
 tests/qapi-schema/doc-good.json               |  16 +-
 tests/qapi-schema/doc-good.out                |  12 +-
 tests/qapi-schema/doc-good.txt                |   8 +-
 tests/qapi-schema/enum-empty.err              |   2 +
 tests/qapi-schema/enum-empty.json             |   2 +
 tests/qapi-schema/enum-empty.out              |   0
 tests/qapi-schema/enum-if-first-required.err  |   2 +
 tests/qapi-schema/enum-if-first-required.json |   6 +
 tests/qapi-schema/enum-if-first-required.out  |   0
 tests/qapi-schema/meson.build                 |   2 +
 tests/qapi-schema/qapi-schema-test.json       |   3 -
 tests/qapi-schema/qapi-schema-test.out        |   1 -
 tests/qapi-schema/union-empty.err             |   4 +-
 50 files changed, 2951 insertions(+), 59 deletions(-)
 create mode 100644 rust/tests/tests/integration.rs
 create mode 100644 rust/tests/tests/qapi.rs
 create mode 100644 rust/util/src/qobject/deserialize.rs
 create mode 100644 rust/util/src/qobject/deserializer.rs
 create mode 100644 rust/util/src/qobject/error.rs
 create mode 100644 rust/util/src/qobject/mod.rs
 create mode 100644 rust/util/src/qobject/serialize.rs
 create mode 100644 rust/util/src/qobject/serializer.rs
 create mode 100644 scripts/qapi/rs.py
 create mode 100644 scripts/qapi/rs_types.py
 create mode 100644 subprojects/packagefiles/serde-1-rs/meson.build
 create mode 100644 subprojects/packagefiles/serde-1.0.226-include.patch
 create mode 100644 subprojects/packagefiles/serde_core-1-rs/meson.build
 create mode 100644 subprojects/packagefiles/serde_core-1.0.226-include.patch
 create mode 100644 subprojects/packagefiles/serde_derive-1-rs/meson.build
 create mode 100644 subprojects/packagefiles/serde_derive-1.0.226-include.patch
 create mode 100644 subprojects/serde-1-rs.wrap
 create mode 100644 subprojects/serde_core-1-rs.wrap
 create mode 100644 subprojects/serde_derive-1-rs.wrap
 create mode 100644 tests/qapi-schema/enum-empty.err
 create mode 100644 tests/qapi-schema/enum-empty.json
 create mode 100644 tests/qapi-schema/enum-empty.out
 create mode 100644 tests/qapi-schema/enum-if-first-required.err
 create mode 100644 tests/qapi-schema/enum-if-first-required.json
 create mode 100644 tests/qapi-schema/enum-if-first-required.out

-- 
2.54.0


