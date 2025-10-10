Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED02ECCA476
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 15:11:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7ElJ-0008Go-H1; Fri, 10 Oct 2025 11:10:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v7ElH-0008Fk-8V
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 11:10:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v7El7-000429-H5
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 11:10:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760109010;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=80OsYP00CTMBcfR/17Cxs+Xuu/BvDfU4GSy9OiK9oPs=;
 b=VGME7yyG5OfEbWQgp4Ui0dyLBCp7Z08Dh/fpub2/Vb/YYujS/LMXFQC8gF8QvOsYfDimUQ
 AGnHqMGFp+5KPIO1/cWHC7Vf0t2X0+IEKfADQ/IlQaBQmDLiwFGKzxC09g9MAqB6awOR/A
 KzQy8nlYSv3MJHeHAeaXCrGi/LLCmlA=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-ugFTnQN-MBqPrhtypYIDAg-1; Fri, 10 Oct 2025 11:10:09 -0400
X-MC-Unique: ugFTnQN-MBqPrhtypYIDAg-1
X-Mimecast-MFC-AGG-ID: ugFTnQN-MBqPrhtypYIDAg_1760109008
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-afcb72a8816so179505466b.0
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 08:10:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760109008; x=1760713808;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=80OsYP00CTMBcfR/17Cxs+Xuu/BvDfU4GSy9OiK9oPs=;
 b=NlQncwa8vYtInhFnIkmfRFec1NjjLzyUd0iXAqCrRnqivoUdMbIDQOc92ksZdM3W99
 AykFFyz4RapIdJK8K8zBTXGhBvHbGT1rkyy2e+NDZ9PnviwkQZDsNEpTdwCGV87WF8PY
 1rqaZgizKcyr7mjKfXg5+V2i70ck79er4X26ivCmVIZC9ljDjCaUAbbfMGLIJCOZp3kW
 cgV7CqSSth/sHX2v7ABi9Ix03CHu5zvYw78wvV7Qp5Jlh0xBPvawNeM7RumzkLHc/hFM
 aWT5yGjKftqmWx4dr/Q7i+Om6NEmAFew7TM05exhvzfBreM3imxIWOdDQtdmpFBxg/U2
 F76g==
X-Gm-Message-State: AOJu0YyFJcljHzQwf3PxuNx2zC1gj9ru4WAtHulaxxUF52OvMYkKg21s
 7kkqJ0MowGmc7uRaBp7wLBreORFDF1Gbwrufk2i7rYMZPQXYuKrl1f2aNaNbk9eaypQKyUitq5e
 3q8sp0K7KJCnvOKB2H2nkHEhA6SKEicuQUfdlpkE05skPkO9ozZSAtQCs+JF+bG8innsNv5+sD3
 xtNN+04YOuwej9L1n0UFJjgutblucID6yyGhRktXx0
X-Gm-Gg: ASbGnctxdjmoJ2m2u7gE/nHXw8OcFvho8JrpPsPw69efoGrOr/dvvkHu5DyFt3dLWTi
 aFA5UgmWXhDwF9qUJtv9cF+WTztcRGIi+qKvgsIqckhsJ1NBXvSNreFo6yFr5zJVBW+38uU+rfp
 MWbonpI8HJSZom6/quHBLN1GQmImT96XvcIh/2Q+nM0QNrDLxokCvYG5RsFc4vDUKnC9I9S1I9V
 z7kaAyDtUmIfKeBKthhndXYRQaz8DQpzRBLGEe/7XujnXf4gweyEp1zXB8arDN+n7C5e8vTIsu8
 CqkOh5k7N3st77pH5vjGrv5Rp2MwPnk5f25fY9DK2Ro/DXbq4VCPuAFAm3emnInfTNHhQ9HrYaM
 ozF6MQLnM9pp9JlLWuxPG5f21O33XEBHz3qWY/tG6As9q
X-Received: by 2002:a17:906:4789:b0:b3e:f028:2d57 with SMTP id
 a640c23a62f3a-b50acc3132amr1426694766b.57.1760109008025; 
 Fri, 10 Oct 2025 08:10:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFAuWZVQbffh2NRJQjq1kjw773APTWKBaf9fGH8YH3Dl3PwX2HjsNpBzFItKHPWhL/mfyfmIQ==
X-Received: by 2002:a17:906:4789:b0:b3e:f028:2d57 with SMTP id
 a640c23a62f3a-b50acc3132amr1426691266b.57.1760109007572; 
 Fri, 10 Oct 2025 08:10:07 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.231.162])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b55d65d002esm248884866b.26.2025.10.10.08.10.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Oct 2025 08:10:07 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com,
	marcandre.lureau@redhat.com,
	qemu-rust@nongnu.org
Subject: [PATCH 00/19] rust: QObject and QAPI bindings
Date: Fri, 10 Oct 2025 17:09:45 +0200
Message-ID: <20251010151006.791038-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.441,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

As an example of how this would be used, the marshaling functions for
QMP commands would look like this:

fn qmp_marshal_query_stats(args: *mut QDict,
    retp: *mut *mut QObject, errp: *mut *mut Error)
{
    let qobj = unsafe { QObject::cloned_from_raw(args.cast()) };

    let result = from_qobject::<StatsFilter>(qobj)
         .map_err(anyhow::Error::from)
         .and_then(qmp_query_stats)
         .and_then(|ret| to_qobject::<Vec<StatsResult>>(ret).map_err(anyhow::Error::from));

    match qmp_marshal_query_stats_rs(qobj) {
        Ok(ret) => unsafe { *retp = ret.into_raw(); },
        Err(e) => unsafe { crate::Error::from(e).propagate(errp) },
    }
}

As a small extra, patches 1 and 2 rework a bit the error implementation
so that it is possible to convert any Rust error into a QEMU one.  This
is because we noticed that we had to add several From<> implementations
to convert e.g. NulError or serde errors into util::Error.

The price is that it's a bit harder to convert *strings* into errors;
therefore, the first patch adds a macro wrapper for
"if !cond { return Err(...) }", where the dots build an error from a
formatted string.

Paolo

Marc-André Lureau (8):
  rust/qobject: add Display/Debug
  scripts/qapi: add QAPISchemaIfCond.rsgen()
  scripts/qapi: generate high-level Rust bindings
  scripts/qapi: add serde attributes
  scripts/qapi: strip trailing whitespaces
  scripts/rustc_args: add --no-strict-cfg
  rust/util: build QAPI types
  rust/tests: QAPI integration tests

Paolo Bonzini (11):
  util: add ensure macro
  rust/util: use anyhow's native chaining capabilities
  rust: do not add qemuutil to Rust crates
  rust/qobject: add basic bindings
  subprojects: add serde
  rust/qobject: add Serialize implementation
  rust/qobject: add Serializer (to_qobject) implementation
  rust/qobject: add Deserialize implementation
  rust/qobject: add Deserializer (from_qobject) implementation
  rust/util: replace Error::err_or_unit/err_or_else with
    Error::with_errp
  rust/qobject: add from/to JSON bindings for QObject

 docs/devel/rust.rst                           |   1 +
 meson.build                                   |   4 +-
 rust/util/wrapper.h                           |   8 +
 qapi/meson.build                              |   6 +
 rust/Cargo.lock                               |   2 +
 rust/Cargo.toml                               |   2 +
 rust/chardev/meson.build                      |   2 +-
 rust/hw/timer/hpet/src/device.rs              |  21 +-
 rust/hw/timer/hpet/src/fw_cfg.rs              |   7 +-
 rust/meson.build                              |   4 +
 rust/tests/meson.build                        |  25 +-
 rust/tests/tests/integration.rs               |   2 +
 rust/tests/tests/qapi.rs                      | 444 +++++++++++++
 rust/util/Cargo.toml                          |   2 +
 rust/util/meson.build                         |  31 +-
 rust/util/src/error.rs                        | 222 +++----
 rust/util/src/lib.rs                          |   2 +
 rust/util/src/qobject/deserialize.rs          | 134 ++++
 rust/util/src/qobject/deserializer.rs         | 371 +++++++++++
 rust/util/src/qobject/error.rs                |  58 ++
 rust/util/src/qobject/mod.rs                  | 369 +++++++++++
 rust/util/src/qobject/serialize.rs            |  59 ++
 rust/util/src/qobject/serializer.rs           | 585 ++++++++++++++++++
 scripts/archive-source.sh                     |   3 +
 scripts/make-release                          |   2 +-
 scripts/qapi/backend.py                       |  27 +-
 scripts/qapi/common.py                        |  16 +
 scripts/qapi/gen.py                           |   6 +-
 scripts/qapi/main.py                          |   4 +-
 scripts/qapi/rs.py                            | 181 ++++++
 scripts/qapi/rs_types.py                      | 387 ++++++++++++
 scripts/qapi/schema.py                        |   4 +
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
 43 files changed, 3042 insertions(+), 139 deletions(-)
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

-- 
2.51.0


