Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37B15CA1013
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 11:02:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvZTR-0006vx-TA; Mon, 08 Sep 2025 06:51:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uvZTO-0006v2-CC
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 06:51:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uvZTC-0006Ck-6r
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 06:51:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757328685;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dRZsNqZGE9NUqObfCVEOQEig8iVf+LmigSCKKBVNNnk=;
 b=IcGH/wBUbL5pPzDmMGawgjcW0jhySrDGHZS5Dtz2939Zv4pUzkp4gR24yoFx7HMoEouN09
 EXqSzo1OoybeDCogsBva+1fGP2Fz2rhpa4xy9FepfuKDTKvnMaMCfwATsZbMzLArFg2/t/
 EBvih2rxGj0UYwmAo5s96eIFkC2G6p4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-475-r9RVE5g1OWC_fWuZz_XbeQ-1; Mon, 08 Sep 2025 06:51:24 -0400
X-MC-Unique: r9RVE5g1OWC_fWuZz_XbeQ-1
X-Mimecast-MFC-AGG-ID: r9RVE5g1OWC_fWuZz_XbeQ_1757328683
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-45b990eb77cso30344875e9.0
 for <qemu-devel@nongnu.org>; Mon, 08 Sep 2025 03:51:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757328682; x=1757933482;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dRZsNqZGE9NUqObfCVEOQEig8iVf+LmigSCKKBVNNnk=;
 b=r1lJuQwlnS10QzubDTs80FytyFehED0PO9EWzFyfnUO/mrVg7TB9dZpNznojk6CzXo
 5WOdvLFqwxeBCEo1RNv75b2Gx6foOxNCQyLZ6pbOXLMeY1IEsprCsY1hqpIlkUgGTSiF
 ZFdYki0sezqzG2dEcP+KMb7Gx4r9ilSvXtsHECFTi+W/yc3JT0oKvBWKxtpn6oy12OV0
 TBEjn5g6L6TXodBVENxlZZGpTYYks87dpYia+lixNz98lUAJP0SyfCcFxkRrXn0uwPJq
 BoL/le8NH0w9UPFNu558PDJme+R3vmrjKNialWO3LOeWhAjkv9CwRhVooXKPbGnf1fgu
 DXQw==
X-Gm-Message-State: AOJu0YyEy9ugRO+1qxBF+xkfNfInPGOziKxRGQgdU4lzuYKsYGsrg6lV
 ejEQQDm/ABbDYXI2fM1ZtM6UlH7D8aRxRXeazUTmjCQiI1ADeIf2bxTo3nm7B3LYSOef335CJ+Z
 b+36aNagjT5VaNHca7Mkt8HOMLUmmKO1Dlr3gFrxS8EwPFBKFldLVo89BjKvn026H6KjKbKwjC3
 oIVvTWCOY8V0w3yoNtogKRSmVUAMYLRiOpdtbbwKh1
X-Gm-Gg: ASbGncvZvR9UrhMxxHHVytk0maR3AI3f1nvTGZc20KI869OsFv6cTxHhHQJXYZF7ihk
 GoOIBOY5LaRE9R9D9jfx733iiHTQpcmivNEr98VfiNdExxGK87Ie7I+HCrnZ0Zn0UB60BridD9b
 NtqWpBfD+0gUWSmp8SjTpOqw2o9+1DTgELhc41DwXappfZkq7E/OxeTwYNjG0r8kbq4xiIe2Guu
 ugJ+iv0Tbwtyx56J1YIdbfy1H4T3h5db5GOWEAs6bffWh1GYpqlIVjPK9rcfE86l5rLDUXYYXuD
 BbsgB29PG4hqJdVsBf+4dwOLz1zPWY2ivsW9SGuNcAiTEermZMaeaJPY//jgJ9y03dYQHTczOcd
 na0vGR3REARis7Rfa2tOraErwAhHrjiECma/s5zcRjtM=
X-Received: by 2002:a05:600c:840f:b0:45d:dc10:a5ee with SMTP id
 5b1f17b1804b1-45dde20ee09mr64948365e9.15.1757328681914; 
 Mon, 08 Sep 2025 03:51:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHetaieeG5CZaDHSFgwU1vOxMvqsxKVOuJ8m75aT7R1cp//0OGrJnhVciz6CrkFhilhQaAckw==
X-Received: by 2002:a05:600c:840f:b0:45d:dc10:a5ee with SMTP id
 5b1f17b1804b1-45dde20ee09mr64948025e9.15.1757328681363; 
 Mon, 08 Sep 2025 03:51:21 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b9a6ecfafsm286494065e9.21.2025.09.08.03.51.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Sep 2025 03:51:19 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 31/33] docs: update rust.rst
Date: Mon,  8 Sep 2025 12:50:03 +0200
Message-ID: <20250908105005.2119297-32-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250908105005.2119297-1-pbonzini@redhat.com>
References: <20250908105005.2119297-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Link: https://lore.kernel.org/r/20250827104147.717203-23-marcandre.lureau@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/devel/rust.rst | 61 ++++++++++++++++++++++++---------------------
 1 file changed, 32 insertions(+), 29 deletions(-)

diff --git a/docs/devel/rust.rst b/docs/devel/rust.rst
index 29eb48af35b..13a20e86a16 100644
--- a/docs/devel/rust.rst
+++ b/docs/devel/rust.rst
@@ -103,15 +103,18 @@ anymore.
 Writing Rust code in QEMU
 -------------------------
 
-QEMU includes four crates:
+QEMU includes several crates:
 
-* ``qemu_api`` for bindings to C code and useful functionality
+* ``common`` provides Rust-only utilities
 
-* ``qemu_api_macros`` defines several procedural macros that are useful when
+* ``bql``, ``chardev``, ``hw/core``, ``migration``, ``qom``, ``system``,
+  ``util`` for bindings to respective QEMU C library APIs
+
+* ``qemu_macros`` defines several procedural macros that are useful when
   writing C code
 
 * ``pl011`` (under ``rust/hw/char/pl011``) and ``hpet`` (under ``rust/hw/timer/hpet``)
-  are sample devices that demonstrate ``qemu_api`` and ``qemu_api_macros``, and are
+  are sample devices that demonstrate Rust binding usage and ``qemu_macros``, and are
   used to further develop them.  These two crates are functional\ [#issues]_ replacements
   for the ``hw/char/pl011.c`` and ``hw/timer/hpet.c`` files.
 
@@ -124,7 +127,7 @@ This section explains how to work with them.
 Status
 ''''''
 
-Modules of ``qemu_api`` can be defined as:
+The stability of the modules can be defined as:
 
 - *complete*: ready for use in new devices; if applicable, the API supports the
   full functionality available in C
@@ -140,26 +143,26 @@ Modules of ``qemu_api`` can be defined as:
 
 The status of the modules is as follows:
 
-================ ======================
-module           status
-================ ======================
-``assertions``   stable
-``bitops``       complete
-``callbacks``    complete
-``cell``         stable
-``errno``        complete
-``error``        stable
-``irq``          complete
-``log``          proof of concept
-``memory``       stable
-``module``       complete
-``qdev``         stable
-``qom``          stable
-``sysbus``       stable
-``timer``        stable
-``vmstate``      stable
-``zeroable``     stable
-================ ======================
+========================== ======================
+module                     status
+========================== ======================
+``bql::cell``              stable
+``common::assertions``     stable
+``common::bitops``         complete
+``common::callbacks``      complete
+``common::errno``          complete
+``common::zeroable``       stable
+``hwcore::irq``            complete
+``hwcore::qdev``           stable
+``hwcore::sysbus``         stable
+``migration::vmstate``     stable
+``qom``                    stable
+``system::memory``         stable
+``util::error``            stable
+``util::log``              proof of concept
+``util::module``           complete
+``util::timer``            stable
+========================== ======================
 
 .. note::
   API stability is not a promise, if anything because the C APIs are not a stable
@@ -260,7 +263,7 @@ to go from a shared reference to a ``&mut``.
 
 Whenever C code provides you with an opaque ``void *``, avoid converting it
 to a Rust mutable reference, and use a shared reference instead.  The
-``qemu_api::cell`` module provides wrappers that can be used to tell the
+``bql::cell`` module provides wrappers that can be used to tell the
 Rust compiler about interior mutability, and optionally to enforce locking
 rules for the "Big QEMU Lock".  In the future, similar cell types might
 also be provided for ``AioContext``-based locking as well.
@@ -292,7 +295,7 @@ the wrapper to be declared thread-safe::
 Writing bindings to C code
 ''''''''''''''''''''''''''
 
-Here are some things to keep in mind when working on the ``qemu_api`` crate.
+Here are some things to keep in mind when working on the QEMU Rust crate.
 
 **Look at existing code**
   Very often, similar idioms in C code correspond to similar tricks in
@@ -355,7 +358,7 @@ from the type after ``as`` in the invocation of ``parse_macro_input!``::
             .into()
     }
 
-The ``qemu_api_macros`` crate has utility functions to examine a
+The ``qemu_macros`` crate has utility functions to examine a
 ``DeriveInput`` and perform common checks (e.g. looking for a struct
 with named fields).  These functions return ``Result<..., syn::Error>``
 and can be used easily in the procedural macro function::
@@ -396,7 +399,7 @@ Right now, only the nightly version of ``rustfmt`` is supported.  This
 might change in the future.  While CI checks for correct formatting via
 ``cargo fmt --check``, maintainers can fix this for you when applying patches.
 
-It is expected that ``qemu_api`` provides full ``rustdoc`` documentation for
+It is expected that QEMU Rust crates provides full ``rustdoc`` documentation for
 bindings that are in their final shape or close.
 
 Adding dependencies
-- 
2.51.0


