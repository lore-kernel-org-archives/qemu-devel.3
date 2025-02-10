Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E5A1C0219D
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 10:25:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thQwZ-0002Ku-0h; Mon, 10 Feb 2025 05:23:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1thQwW-0002KZ-O0
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 05:23:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1thQwU-0000LE-Q7
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 05:23:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739182984;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=KGrGQWrc/XBWIVPBq+pKce/ewAvpfnSpwLJSLkkvHAM=;
 b=FwjRTBhL1CfIpOj1tjLkaLQjJbchNhDVWVVibLI9YsJVLA5GtmV0tRXWxhFc0DpeeYpYND
 8hNJ3cbo2NYudPOHaukV9+9p2WPFqERuSc4yljtJstKcnNc7zplbQjoKw6bX/DmZFrmpeh
 OqesEl/FVK3IPvZ7t6nTrtSegVjbnJ8=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-529-RWRZknJ9NjWokhkXJIEf1w-1; Mon, 10 Feb 2025 05:22:59 -0500
X-MC-Unique: RWRZknJ9NjWokhkXJIEf1w-1
X-Mimecast-MFC-AGG-ID: RWRZknJ9NjWokhkXJIEf1w
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-ab7b97db8baso74361166b.2
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 02:22:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739182978; x=1739787778;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KGrGQWrc/XBWIVPBq+pKce/ewAvpfnSpwLJSLkkvHAM=;
 b=T/hOTeD12XDcvhvDceEqp6UpOmsQpJ4iJ/bl5chNyTPAgdSv5bbA4Aug3bKkImjQib
 Y1boGzBgYbMTcOarh/r+IVFVPzKpx3EX2PLYX4n/VR/RrQXeNeSEE3szaSo9yJj2y0XE
 zvfOIJHH/BG18q1rlSv8aut6Gfm5udmXdJ/rJyx2SsVHm9qoYbdwIUxZZ3uS/zbXHm7S
 BtJXeGQgCxwTLSs8jbvFnljwkNyqqyhNaRTmhoE9f3NFUC6/fste3KqKOLKtHqIFSg7V
 UOXTq1sAEiTTuC6S/4HB7roHcQ2q1VtEtzg7la2lQGp3Hcs0EHm7fhuEMLeGPssGssXG
 Ucow==
X-Gm-Message-State: AOJu0YxQTUAs9R9w08cwonKsQUjr/NGiddi38HaWobzGo4qq1HQ5gS61
 HyVhr+YWJEBUNCDGgMaH0dIILxAby/xCUTb3xK4y/4qhzyq6IEZ7rMfAmjdxCHhZYR/gshRiBln
 vg3L0jG52Lcm+6EGlMqPrg5PjDv0XD34nCx1HKiEAADfPFDdNtyHymp6qHz0r1O8bTQPZodKCj+
 hv7bnn2VAMVzVFTYScGN860ggXYApS2dEx2p9/5Ho=
X-Gm-Gg: ASbGncu5DoZmBy1QkYqE2GS0BK4uARyGNtEX2ePU90fGE0bioGACejNw3XbCOP5KGp2
 ZvkCeuHUv1QnnDahS4uiigLKnJPI+fRN+GTChoJS0+/b81zxGPbqW251cKnctvQZcLM2nG4i/RQ
 xl4gLLewcQAdBXDmzlTpY8r0xqVvXImNv+mXKnwd6oYgQYeJwcC/oqFx8DzQKRZKyQ9QzLU9Wwc
 rqAeNnFWgWiKmScrzncBUDrOrk0HoOtgrJS1aAePHL+CrBZgYfOA8J2kWzHzJ/r6qe25cHE57m/
 xUXVaw==
X-Received: by 2002:a05:6402:3788:b0:5d9:f5c4:a227 with SMTP id
 4fb4d7f45d1cf-5de45089d9amr13416814a12.20.1739182978227; 
 Mon, 10 Feb 2025 02:22:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHvJixaPrsF62OJu0UknHHa+XI08LIZB7d9u/doxPYkQOQmUD+gre9Kscf22rUnTr6MkRu+Ew==
X-Received: by 2002:a05:6402:3788:b0:5d9:f5c4:a227 with SMTP id
 4fb4d7f45d1cf-5de45089d9amr13416798a12.20.1739182977736; 
 Mon, 10 Feb 2025 02:22:57 -0800 (PST)
Received: from [192.168.10.3] ([151.62.97.55])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5de5941e014sm5083115a12.50.2025.02.10.02.22.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2025 02:22:57 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 0/9] Rust, TCG, x86 patches for 2025-02-07
Date: Mon, 10 Feb 2025 11:22:45 +0100
Message-ID: <20250210102255.2555097-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.405,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

The following changes since commit 131c58469f6fb68c89b38fee6aba8bbb20c7f4bf:

  rust: add --rust-target option for bindgen (2025-02-06 13:51:46 -0500)

are available in the Git repository at:

  https://gitlab.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to 476d6e4c9c4965734d6f47ee299ac9f84440a9b3:

  rust: restrict missing_const_for_fn to qemu_api crate (2025-02-10 11:18:32 +0100)

----------------------------------------------------------------
* tcg/optimize: optimize TSTNE using smask and zmask
* target/i386: fix exceptions for 0 * Inf + QNaN
* rust: cleanups to the configuration and the warnings
* rust: add developer docs
----------------------------------------------------------------
v1->v2: add fix for check-rust-tools-nightly failure
        remove stray lcitool update
        some touchups to the Rust docs

Paolo Bonzini (7):
      rust: remove unnecessary Cargo.toml metadata
      rust: include rust_version in Cargo.toml
      rust: add docs
      rust: add clippy configuration file
      tcg/optimize: optimize TSTNE using smask and zmask
      rust: pl011: use default set of lints
      rust: restrict missing_const_for_fn to qemu_api crate

Peter Maydell (2):
      target/i386: Do not raise Invalid for 0 * Inf + QNaN
      tests/tcg/x86_64/fma: Test some x86 fused-multiply-add cases

 docs/devel/index-process.rst           |   1 +
 docs/devel/rust.rst                    | 430 +++++++++++++++++++++++++++++++++
 include/fpu/softfloat-types.h          |  16 +-
 target/i386/tcg/fpu_helper.c           |   5 +-
 tcg/optimize.c                         |  13 +-
 tests/tcg/x86_64/fma.c                 | 109 +++++++++
 fpu/softfloat-parts.c.inc              |   5 +-
 rust/Cargo.toml                        |   1 -
 rust/clippy.toml                       |   2 +
 rust/hw/char/pl011/Cargo.toml          |   4 +-
 rust/hw/char/pl011/README.md           |  31 ---
 rust/hw/char/pl011/src/device_class.rs |   1 -
 rust/hw/char/pl011/src/lib.rs          |  23 +-
 rust/qemu-api-macros/Cargo.toml        |   4 +-
 rust/qemu-api-macros/README.md         |   1 -
 rust/qemu-api/Cargo.toml               |   1 +
 rust/qemu-api/src/lib.rs               |   1 +
 tests/tcg/x86_64/Makefile.target       |   1 +
 18 files changed, 581 insertions(+), 68 deletions(-)
 create mode 100644 docs/devel/rust.rst
 create mode 100644 tests/tcg/x86_64/fma.c
 create mode 100644 rust/clippy.toml
 delete mode 100644 rust/hw/char/pl011/README.md
 delete mode 100644 rust/qemu-api-macros/README.md
-- 
2.48.1


