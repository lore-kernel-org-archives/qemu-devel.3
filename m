Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC2A3CA0FE7
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Aug 2025 14:46:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uquum-00022X-Ge; Tue, 26 Aug 2025 10:44:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uquuc-0001yf-8d
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 10:44:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uquuR-0006kv-VD
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 10:44:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756219452;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=sD1lWKtRI6BfjYxwbDQNJgnpBwVJVgbqemBEwti6CPI=;
 b=D9K45uW0XcQ/muM3U8jysMz/LZBMUUw270o4e7kpIpnMuZQFUVZrnykldhr38tJolPTTzE
 zdPORO78oun0TUK2k7j42LoJDmQz/F6YIZu6H7BrOcWW0DUnY1BZUo1ZBwRv6AcQ1SwC4w
 a+gw1snpTSK2GL+YAxybrklgnU7WZN0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-60-_f1zMwxGN0GUiP-0vadx4A-1; Tue, 26 Aug 2025 10:44:07 -0400
X-MC-Unique: _f1zMwxGN0GUiP-0vadx4A-1
X-Mimecast-MFC-AGG-ID: _f1zMwxGN0GUiP-0vadx4A_1756219446
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3cbd6cd78efso371842f8f.1
 for <qemu-devel@nongnu.org>; Tue, 26 Aug 2025 07:44:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756219446; x=1756824246;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sD1lWKtRI6BfjYxwbDQNJgnpBwVJVgbqemBEwti6CPI=;
 b=t9Mt/s4I9bjv/yuN/ZfAvQ3YmjH/Z53UedR0l4zFFFCjIiE/NpTilexlaJU2BZI+TM
 QQksskEkFS/aEHweIMi4CO7zfbKvm/1LiyhjyyYOiRGd3X6v+6eIfmGTJXt5B7u12dq1
 kD4YjuTxO0a1Y192f2QEcqk6N/xusXuSoXkyZR60cuZbUtcF+0nlMvCcGu4VSRB5EJtF
 HXcePVXHeBqiQUXImbbtUpmco63GV6RghMhIGpM9er2xB9MlPZSi7oXG5YYdJp+ViJAQ
 qdRx+aU7SF2GZ4Sj3y3J7+23iqfj31eeTIxlAUx/PXXT7ZlRRmW9lVtpX45fERCNsHcf
 D9Cw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXNDP1soZGsXZUiJjbVWvRSf8FDDrF8FLDSyiFUFT99vrCoxltP0bWzIzItgTqBb2y8pE1xLl/WRyNu@nongnu.org
X-Gm-Message-State: AOJu0Yw7v7y4jXap8xbMfSfDE0KYvFdZq8hbAhLMD6bSj5AG/ZJNHP9c
 UM9Xle93IRTF+emUZrPcyl4bSVupapmJii/zH0Mh0Z19ExsWliQ249T5U5gbdkNCBvW0Dz8Dyr8
 xVJgEE0hXq7E0rWazN4Hnfhriea8fQyO2jR0a7lUWRpvE7MhYNTMdP4TD
X-Gm-Gg: ASbGnctiNx3xqXdmzmGjXGPg760gKz7LwDj2H6hir4NW/GJetvhKdgBTZh0sPxzpYjf
 xwlWLhW5mW9V+ISOm8CSOIv026wiqTBltSFu8lGGmcuTDcnfsT4TwCnwBhBCESpfLzUEGh0Yiaj
 mq1bMCvDuxywhg34gjyuHRqZDLmYJiJKYXssnEkl0zNsnoZl8yxKSOZT6Ig1kfu6Bpjzs7oDuPp
 ZG/Rokg8erZDbngLkT1fj+nevIi9Y5ZH8R9a2jK3TDnGWoH4OyNQsqmGVq/rM0zOCiJlxTj/Fn/
 mdGZfbZlCEu9F/dPR9PYMa153jEORyuj9GHRzYwouWqNh64zAehVMj2KXQhbFOL1lRH5TMjjyL4
 tjJOpP7xGuI5N5EtbVrQeTSiG
X-Received: by 2002:a05:6000:438a:b0:3c9:aa54:d119 with SMTP id
 ffacd0b85a97d-3c9aa54de3dmr5794327f8f.57.1756219445960; 
 Tue, 26 Aug 2025 07:44:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHuylGEo7R+xZfV7dFO4Y6RyceQmNoUKaPGrYjxc73gZoY/7WyjH59KZaMz6NCqM2TBX/C6eQ==
X-Received: by 2002:a05:6000:438a:b0:3c9:aa54:d119 with SMTP id
 ffacd0b85a97d-3c9aa54de3dmr5794291f8f.57.1756219445386; 
 Tue, 26 Aug 2025 07:44:05 -0700 (PDT)
Received: from [192.168.178.61] ([151.36.40.144])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-3cc4b102889sm62435f8f.51.2025.08.26.07.44.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Aug 2025 07:44:04 -0700 (PDT)
Message-ID: <e58ea933-f941-44d8-8477-c8298663cc24@redhat.com>
Date: Tue, 26 Aug 2025 16:44:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 00/18] rust: split qemu-api
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-rust@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
References: <20250826140449.4190022-1-marcandre.lureau@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20250826140449.4190022-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 8/26/25 16:04, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Hi,
> 
> qemu-api is providing bindings for various internal libraries. Instead, the
> bindings requirements should match the various libraries and use the minimal set
> of dependencies.
> 
> An initial Rust-only "common" crate is introduced, then "util" (for libqemuutil,
> without bql), "migration" (so it doesn't depend on bql), "bql", "qom" (arguably,
> bql shouldn't be required?), and "chardev", "system", "hwcore". Finally the
> qemu-api crates are renamed and repurposed.
> 
> This involves a lot of code churn, so hopefully it can be reviewed and merged
> early and iterated upon :)

The one comment that I would like to handle before merging, is that I'd 
prefer to keep the preludes and, in fact, even add more exports to them 
since they can now be chosen per-crate.  Ideally, many of the crates 
you've crated would be accessed through many "use xyz::prelude::*" 
statements.

Also, if I understood correctly the split util/errno.rs can move to 
common/.  While it has a dependency on libc, it doesn't need bindgen.

There's a bunch of code duplication for the various bindings.rs and 
build.rs files, which is not ideal but shouldn't grow much more than 
this.  I wonder if, later, common code across build.rs could be written 
just once by adding a new crate (e.g. "qemu_meson") to the workspace, 
that can be used as a build-dependency.

Paolo

> Marc-André Lureau (18):
>    rust: remove unused global qemu "allocator"
>    rust: add workspace authors
>    rust: split Rust-only "common" crate
>    rust: split "util" crate
>    rust: move vmstate_clock!() to qdev module
>    rust: move VMState handling to QOM module
>    rust: move Cell vmstate impl
>    rust: split "migration" crate
>    rust: split "bql" crate
>    rust: split "qom" crate
>    rust: split "chardev" crate
>    rust: split "system" crate
>    rust: split "hwcore" crate
>    rust: rename qemu_api_macros -> qemu_macros
>    rust/hpet: drop now unneeded qemu_api dep
>    rust/pl011: drop dependency on qemu_api
>    rust: repurpose qemu_api -> tests
>    docs: update rust.rst
> 
>   MAINTAINERS                                   |  12 +-
>   docs/devel/rust.rst                           |  51 +--
>   meson.build                                   |   4 -
>   rust/bql/wrapper.h                            |  27 ++
>   rust/chardev/wrapper.h                        |  28 ++
>   rust/hw/char/pl011/wrapper.h                  |  51 +++
>   rust/hw/core/wrapper.h                        |  32 ++
>   rust/{qemu-api => migration}/wrapper.h        |  20 --
>   rust/qom/wrapper.h                            |  27 ++
>   rust/system/wrapper.h                         |  29 ++
>   rust/util/wrapper.h                           |  32 ++
>   rust/Cargo.lock                               | 127 ++++++-
>   rust/Cargo.toml                               |  16 +-
>   rust/bits/Cargo.toml                          |   2 +-
>   rust/bits/meson.build                         |   2 +-
>   rust/bits/src/lib.rs                          |   4 +-
>   rust/{qemu-api => bql}/Cargo.toml             |  13 +-
>   rust/{qemu-api => bql}/build.rs               |   2 +-
>   rust/bql/meson.build                          |  52 +++
>   rust/bql/src/bindings.rs                      |  25 ++
>   rust/{qemu-api => bql}/src/cell.rs            | 333 +++---------------
>   rust/bql/src/lib.rs                           |  29 ++
>   rust/chardev/Cargo.toml                       |  24 ++
>   rust/chardev/build.rs                         |  43 +++
>   rust/chardev/meson.build                      |  54 +++
>   rust/chardev/src/bindings.rs                  |  36 ++
>   rust/{qemu-api => chardev}/src/chardev.rs     |  35 +-
>   rust/chardev/src/lib.rs                       |   4 +
>   rust/common/Cargo.toml                        |  16 +
>   rust/common/meson.build                       |  32 ++
>   rust/{qemu-api => common}/src/assertions.rs   |  16 +-
>   rust/{qemu-api => common}/src/bitops.rs       |   1 -
>   rust/{qemu-api => common}/src/callbacks.rs    |  12 +-
>   rust/common/src/lib.rs                        |  17 +
>   rust/common/src/opaque.rs                     | 240 +++++++++++++
>   rust/{qemu-api => common}/src/uninit.rs       |   2 +-
>   rust/common/src/zeroable.rs                   |  18 +
>   rust/hw/char/pl011/Cargo.toml                 |  11 +-
>   rust/hw/char/pl011/build.rs                   |  43 +++
>   rust/hw/char/pl011/meson.build                |  39 +-
>   rust/hw/char/pl011/src/bindings.rs            |  27 ++
>   rust/hw/char/pl011/src/device.rs              |  49 +--
>   rust/hw/char/pl011/src/lib.rs                 |   1 +
>   rust/hw/char/pl011/src/registers.rs           |   4 +-
>   rust/hw/core/Cargo.toml                       |  26 ++
>   rust/hw/core/build.rs                         |  43 +++
>   rust/{qemu-api => hw/core}/meson.build        |  86 ++---
>   rust/hw/core/src/bindings.rs                  |  41 +++
>   rust/{qemu-api => hw/core}/src/irq.rs         |  18 +-
>   rust/hw/core/src/lib.rs                       |  12 +
>   rust/{qemu-api => hw/core}/src/qdev.rs        |  81 +++--
>   rust/{qemu-api => hw/core}/src/sysbus.rs      |  28 +-
>   rust/{qemu-api => hw/core}/tests/tests.rs     |  29 +-
>   rust/hw/timer/hpet/Cargo.toml                 |  10 +-
>   rust/hw/timer/hpet/meson.build                |  12 +-
>   rust/hw/timer/hpet/src/device.rs              |  56 ++-
>   rust/hw/timer/hpet/src/fw_cfg.rs              |   6 +-
>   rust/meson.build                              |  12 +-
>   rust/migration/Cargo.toml                     |  21 ++
>   rust/migration/build.rs                       |  43 +++
>   rust/migration/meson.build                    |  57 +++
>   rust/migration/src/bindings.rs                |  48 +++
>   rust/migration/src/lib.rs                     |   4 +
>   rust/{qemu-api => migration}/src/vmstate.rs   | 166 ++++-----
>   rust/qemu-api/.gitignore                      |   2 -
>   rust/qemu-api/README.md                       |  19 -
>   rust/qemu-api/src/lib.rs                      | 170 ---------
>   rust/qemu-api/src/prelude.rs                  |  31 --
>   rust/qemu-api/src/zeroable.rs                 |  37 --
>   .../Cargo.toml                                |   2 +-
>   .../meson.build                               |  10 +-
>   .../src/bits.rs                               |   0
>   .../src/lib.rs                                |  20 +-
>   .../src/tests.rs                              |   8 +-
>   rust/qom/Cargo.toml                           |  23 ++
>   rust/qom/build.rs                             |  43 +++
>   rust/qom/meson.build                          |  61 ++++
>   rust/qom/src/bindings.rs                      |  25 ++
>   rust/qom/src/lib.rs                           |   4 +
>   rust/{qemu-api => qom}/src/qom.rs             |  27 +-
>   rust/qom/tests/tests.rs                       |  47 +++
>   rust/system/Cargo.toml                        |  22 ++
>   rust/system/build.rs                          |  43 +++
>   rust/system/meson.build                       |  57 +++
>   rust/{qemu-api => system}/src/bindings.rs     |  33 +-
>   rust/system/src/lib.rs                        |   4 +
>   rust/{qemu-api => system}/src/memory.rs       |  20 +-
>   rust/tests/Cargo.toml                         |  30 ++
>   rust/tests/meson.build                        |  14 +
>   .../tests/vmstate_tests.rs                    |  18 +-
>   rust/util/Cargo.toml                          |  23 ++
>   rust/util/build.rs                            |  43 +++
>   rust/util/meson.build                         |  61 ++++
>   rust/util/src/bindings.rs                     |  25 ++
>   rust/{qemu-api => util}/src/errno.rs          |  11 +-
>   rust/{qemu-api => util}/src/error.rs          |   6 +-
>   rust/util/src/lib.rs                          |  10 +
>   rust/{qemu-api => util}/src/log.rs            |  12 +-
>   rust/{qemu-api => util}/src/module.rs         |   2 +-
>   rust/{qemu-api => util}/src/timer.rs          |  12 +-
>   100 files changed, 2372 insertions(+), 1044 deletions(-)
>   create mode 100644 rust/bql/wrapper.h
>   create mode 100644 rust/chardev/wrapper.h
>   create mode 100644 rust/hw/char/pl011/wrapper.h
>   create mode 100644 rust/hw/core/wrapper.h
>   rename rust/{qemu-api => migration}/wrapper.h (77%)
>   create mode 100644 rust/qom/wrapper.h
>   create mode 100644 rust/system/wrapper.h
>   create mode 100644 rust/util/wrapper.h
>   rename rust/{qemu-api => bql}/Cargo.toml (52%)
>   rename rust/{qemu-api => bql}/build.rs (96%)
>   create mode 100644 rust/bql/meson.build
>   create mode 100644 rust/bql/src/bindings.rs
>   rename rust/{qemu-api => bql}/src/cell.rs (70%)
>   create mode 100644 rust/bql/src/lib.rs
>   create mode 100644 rust/chardev/Cargo.toml
>   create mode 100644 rust/chardev/build.rs
>   create mode 100644 rust/chardev/meson.build
>   create mode 100644 rust/chardev/src/bindings.rs
>   rename rust/{qemu-api => chardev}/src/chardev.rs (91%)
>   create mode 100644 rust/chardev/src/lib.rs
>   create mode 100644 rust/common/Cargo.toml
>   create mode 100644 rust/common/meson.build
>   rename rust/{qemu-api => common}/src/assertions.rs (92%)
>   rename rust/{qemu-api => common}/src/bitops.rs (98%)
>   rename rust/{qemu-api => common}/src/callbacks.rs (97%)
>   create mode 100644 rust/common/src/lib.rs
>   create mode 100644 rust/common/src/opaque.rs
>   rename rust/{qemu-api => common}/src/uninit.rs (98%)
>   create mode 100644 rust/common/src/zeroable.rs
>   create mode 100644 rust/hw/char/pl011/build.rs
>   create mode 100644 rust/hw/char/pl011/src/bindings.rs
>   create mode 100644 rust/hw/core/Cargo.toml
>   create mode 100644 rust/hw/core/build.rs
>   rename rust/{qemu-api => hw/core}/meson.build (52%)
>   create mode 100644 rust/hw/core/src/bindings.rs
>   rename rust/{qemu-api => hw/core}/src/irq.rs (92%)
>   create mode 100644 rust/hw/core/src/lib.rs
>   rename rust/{qemu-api => hw/core}/src/qdev.rs (86%)
>   rename rust/{qemu-api => hw/core}/src/sysbus.rs (87%)
>   rename rust/{qemu-api => hw/core}/tests/tests.rs (88%)
>   create mode 100644 rust/migration/Cargo.toml
>   create mode 100644 rust/migration/build.rs
>   create mode 100644 rust/migration/meson.build
>   create mode 100644 rust/migration/src/bindings.rs
>   create mode 100644 rust/migration/src/lib.rs
>   rename rust/{qemu-api => migration}/src/vmstate.rs (80%)
>   delete mode 100644 rust/qemu-api/.gitignore
>   delete mode 100644 rust/qemu-api/README.md
>   delete mode 100644 rust/qemu-api/src/lib.rs
>   delete mode 100644 rust/qemu-api/src/prelude.rs
>   delete mode 100644 rust/qemu-api/src/zeroable.rs
>   rename rust/{qemu-api-macros => qemu-macros}/Cargo.toml (94%)
>   rename rust/{qemu-api-macros => qemu-macros}/meson.build (63%)
>   rename rust/{qemu-api-macros => qemu-macros}/src/bits.rs (100%)
>   rename rust/{qemu-api-macros => qemu-macros}/src/lib.rs (91%)
>   rename rust/{qemu-api-macros => qemu-macros}/src/tests.rs (93%)
>   create mode 100644 rust/qom/Cargo.toml
>   create mode 100644 rust/qom/build.rs
>   create mode 100644 rust/qom/meson.build
>   create mode 100644 rust/qom/src/bindings.rs
>   create mode 100644 rust/qom/src/lib.rs
>   rename rust/{qemu-api => qom}/src/qom.rs (98%)
>   create mode 100644 rust/qom/tests/tests.rs
>   create mode 100644 rust/system/Cargo.toml
>   create mode 100644 rust/system/build.rs
>   create mode 100644 rust/system/meson.build
>   rename rust/{qemu-api => system}/src/bindings.rs (56%)
>   create mode 100644 rust/system/src/lib.rs
>   rename rust/{qemu-api => system}/src/memory.rs (95%)
>   create mode 100644 rust/tests/Cargo.toml
>   create mode 100644 rust/tests/meson.build
>   rename rust/{qemu-api => tests}/tests/vmstate_tests.rs (96%)
>   create mode 100644 rust/util/Cargo.toml
>   create mode 100644 rust/util/build.rs
>   create mode 100644 rust/util/meson.build
>   create mode 100644 rust/util/src/bindings.rs
>   rename rust/{qemu-api => util}/src/errno.rs (98%)
>   rename rust/{qemu-api => util}/src/error.rs (98%)
>   create mode 100644 rust/util/src/lib.rs
>   rename rust/{qemu-api => util}/src/log.rs (93%)
>   rename rust/{qemu-api => util}/src/module.rs (97%)
>   rename rust/{qemu-api => util}/src/timer.rs (93%)
> 


