Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D3FCD15DB8
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 16:35:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2vNl-0005oq-Gz; Mon, 21 Oct 2024 12:35:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t2vNk-0005oX-3x
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 12:35:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t2vNi-0006Gb-9S
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 12:35:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729528545;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Kbdc3VAT1D+/OEu8Uip5bPDqhFZpDVahPI/CobBCyqc=;
 b=iQaBzae3RKaqe04BE0TO+Dz9msdqVn5bGXHyFVG8XahJoOX7xtfnuSLBONm/7rtHPwynQO
 0azl7IOkZHyzCGA+Mx4HRMf/pRUoGAHp19I4oohOkfP2rLxj+W+x2qVRVQOKA0444h4c6d
 RRa0/MlRwB6KZP2FRNPWWd6V18P9yss=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-294--BLqOEvBNVCaecBsZhQm1w-1; Mon, 21 Oct 2024 12:35:44 -0400
X-MC-Unique: -BLqOEvBNVCaecBsZhQm1w-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-37d537292d7so3311673f8f.2
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 09:35:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729528542; x=1730133342;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Kbdc3VAT1D+/OEu8Uip5bPDqhFZpDVahPI/CobBCyqc=;
 b=H8a+Wmiou1VrnxdPedEUdiu4zB7Z4yKRWRwQbEXogYKNiRcjFZqQvqIHhkIfJIR9Vd
 PFIM0JTW1VFhiqamB5K/NU0AWcinzRQVX20l8hTL4MEcQcVQOqEYnxgI65O4vQvXhWZ1
 4EC6dGVKzeLMiM+9RokKbCLXy3IorrI6NoLpxgWEfLuB/n0buNS+dHopVKHDoFNIHlSt
 M2HPbi2BPSHsSXF51tfB4T8Ur/yebnxHsrDA/Breb6yZoQ5+/lHZjmrGviLQj33WzqUH
 f0YKUdfSE1tS1/MjuZdiZ9K7s4p4IJi+OfI+URFiLUJTUcOfyH23rnkUxGtV1N+slB9z
 oVDw==
X-Gm-Message-State: AOJu0YxVPRGlFTln2c55HfCfpv9Tshc/XE4vankqLd6Pv9nwdeNEf27D
 glKLUtot2eBLj9eZKcXC7NbUEl4nA0yIFZ9BLVKKE+kF9z0U2Xx1olHYcbHU7s7yI3y80Z88hXu
 QNEPtRlzhM5EImwZKIVnQKjvg14iENQlIMjSbWeC0dthRVathbSCJo/s0FlWBo+Gqhs5irh3K19
 YO50X5Nwg/Qv6Vy8C7ofzcuKCEswoGzACn1/1BpZE=
X-Received: by 2002:a5d:4f84:0:b0:37d:46fa:d1d7 with SMTP id
 ffacd0b85a97d-37eb486acc3mr10531836f8f.57.1729528542115; 
 Mon, 21 Oct 2024 09:35:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEMp2v75OSX3cbl+BBrzQbMrpDmuXcwAQ6CkhDnLZGOzT8WfogPkPT+nWo8JjXqBlMayIJ2BQ==
X-Received: by 2002:a5d:4f84:0:b0:37d:46fa:d1d7 with SMTP id
 ffacd0b85a97d-37eb486acc3mr10531808f8f.57.1729528541637; 
 Mon, 21 Oct 2024 09:35:41 -0700 (PDT)
Received: from avogadro.local ([151.95.144.54])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37ee0b9bcc8sm4680282f8f.107.2024.10.21.09.35.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Oct 2024 09:35:40 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>
Subject: [PATCH v2 00/13] rust: miscellaneous cleanups + QOM integration tests
Date: Mon, 21 Oct 2024 18:35:25 +0200
Message-ID: <20241021163538.136941-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.421,
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

This series integrates some of the observations from the MSRV patches at
https://lore.kernel.org/qemu-devel/20241015131735.518771-1-pbonzini@redhat.com/.

The main changes here are two: first, build an integration test that
actually tries to create a QOM object that is defined by Rust code;
second, make the properties array immutable so that declare_properties!
is enforced to use only const-friendly constructs.  These are patches
6-11; the others consist of small cleanups.

Hidden in here is actually a C patch (#10) which makes the
bindgen-generated prototypes use "*const" instead of "*mut".

Tested with Rust nightly and (together with more patches from the
RFC), with Rust 1.63.0.

Unlike the MSRV patches, this should be ready for inclusion; the
changes should be mostly uncontroversial.

Paolo

Based-on: <20241021163449.136804-1-pbonzini@redhat.com>


v1->v2:
- add comment justifying -D unsafe_op_in_unsafe_fn
- use module_init! macro from #[derive(Object)]
- use test() instead of rust.test() for integration test
- pass rustfmt and clippy


Paolo Bonzini (13):
  meson: import rust module into a global variable
  meson: remove repeated search for rust_root_crate.sh
  meson: pass rustc_args when building all crates
  rust: do not use --no-size_t-is-usize
  rust: remove uses of #[no_mangle]
  rust: modernize link_section usage for ELF platforms
  rust: build integration test for the qemu_api crate
  rust: cleanup module_init!, use it from #[derive(Object)]
  rust: clean up define_property macro
  qdev: make properties array "const"
  rust: make properties array immutable
  rust: provide safe wrapper for MaybeUninit::zeroed()
  rust: do not use TYPE_CHARDEV unnecessarily

 meson.build                            | 33 +++++++---
 include/hw/qdev-core.h                 |  4 +-
 include/hw/qdev-properties.h           |  4 +-
 hw/core/qdev-properties.c              | 26 ++++----
 system/qdev-monitor.c                  |  2 +-
 rust/hw/char/pl011/src/device.rs       |  7 +--
 rust/hw/char/pl011/src/device_class.rs | 10 ++--
 rust/hw/char/pl011/src/memory_ops.rs   | 13 ++--
 rust/qemu-api-macros/meson.build       |  2 +-
 rust/qemu-api-macros/src/lib.rs        | 30 ++--------
 rust/qemu-api/meson.build              | 29 +++++++--
 rust/qemu-api/src/definitions.rs       | 67 ++++++++++-----------
 rust/qemu-api/src/device_class.rs      | 83 +++++++-------------------
 rust/qemu-api/src/lib.rs               |  4 +-
 rust/qemu-api/src/tests.rs             | 49 ---------------
 rust/qemu-api/src/zeroable.rs          | 23 +++++++
 rust/qemu-api/tests/tests.rs           | 78 ++++++++++++++++++++++++
 17 files changed, 240 insertions(+), 224 deletions(-)
 delete mode 100644 rust/qemu-api/src/tests.rs
 create mode 100644 rust/qemu-api/src/zeroable.rs
 create mode 100644 rust/qemu-api/tests/tests.rs

-- 
2.46.2


