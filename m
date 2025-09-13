Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EEEDCAC587
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Sep 2025 08:13:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uxLMn-00014x-Ov; Sat, 13 Sep 2025 04:12:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uxLMg-0000tY-Pd
 for qemu-devel@nongnu.org; Sat, 13 Sep 2025 04:12:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uxLMe-0005DU-LT
 for qemu-devel@nongnu.org; Sat, 13 Sep 2025 04:12:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757751127;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Jx4FRgYXrzfcXSSTrQ/VLTarSEauEA8p1hugUE6tdyk=;
 b=gYOBrsqftVlIp4MsYzqRXovATCT8/EmV9jXwQdERcYD67eP/fd5/wSMWunfFhA9bwGaLRW
 B1ffQ0ynhkzqukrYeCGJsv6qGv+o3G93m3QIJoim8fgKu9LfDfmY1TlzQO3w19ujgkHYny
 es6jRspi1C7GW5ziXPalYrLtd1QnRTo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-228-krCdiLB4OCa1XmG0YdDK_w-1; Sat, 13 Sep 2025 04:12:06 -0400
X-MC-Unique: krCdiLB4OCa1XmG0YdDK_w-1
X-Mimecast-MFC-AGG-ID: krCdiLB4OCa1XmG0YdDK_w_1757751125
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3e8c4aa37bbso114875f8f.3
 for <qemu-devel@nongnu.org>; Sat, 13 Sep 2025 01:12:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757751124; x=1758355924;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Jx4FRgYXrzfcXSSTrQ/VLTarSEauEA8p1hugUE6tdyk=;
 b=tSy/gGJ83SH4DUX5b4BWJjrLOGz603/oGB3mqnphtbzVLWyPm/uqjl0c7Cz/jmn9/i
 SlnBdbwE1/b7A5S46uB2McJNj/T7GwZgefGjBsxFeSYdA7cqdeZ9bqkFg6P1l/XmTz1n
 P32+VrczsjDV02nVdJEirwATwH0E5IeJSsgrWwTQC3McFZE9xWqvmUhu9U6hUy4JyfFm
 Aob7lC8dGlKZz+h6mMLE9p+cQDsFaj9z08iECHhLWBtwKevBdOoloifXc+KpTrGDTX78
 QmOFFHejxV8UrgSuLtnMP7yfUJMV2b595GSEvz3z/90RUCDYg9d/syZQS0dzafzuZW6x
 0rbw==
X-Gm-Message-State: AOJu0YxEBajFOpPzrKlCafxg4TAmK5HTVVG2Ui2TQkqgG0lOyokB/3Cu
 x81HWyd0Hkf32VxFG1zFstLUt1eKe1B+/eCFlTBSjxvqoR3jBuUBN6LCUc0hqciLOszZmR5iBtm
 HSRMEmN3rGOedv9Hr2qU0UPdYycRR4SWRJN8JomIbMey4DO84RmLwSseg7WpgG+kWFLeToSyQLv
 6lw1Vrobg2AbvfmY/pwec7Cp1Cfmf92pcL11TgS1Fk
X-Gm-Gg: ASbGncuxPvDqHfHMW2WMNffLsGngOnRdU40lB5M3zuyVg1LvowmJ0/ehP7pV63hMf48
 5iwEGqQi7838XD4ht8/yQWNn4LBoY+/xdNPNAxcnh1ghEyV+IZo16es70y5ayXDWL61oo0L8lWE
 XMWbRECFoRvwaIoVPYv97wn+2Tb5QRuWZqN0V/5/FcCl4ROZcEmS44fxt0Y/JdFxP2DH6qPl3bV
 vUSknxDY951IHdi/Cxf4lZV8wIOLGdE/6/tdtCc17WNZPqgbIYfarYiZIvgHlJmWyFMdydUVLoz
 0zE3iKs27khoswQO3UOjjdXEp82M67K/XGcBN+gkdTTstZbgTb569Txk/ho1MEIkkjvUEkNqPUZ
 aUgE6MD0mmcJgZe1JtD6HJ/icSqjqqcRA+FqBVzpG9iU=
X-Received: by 2002:a05:6000:2385:b0:3e0:2a95:dc9e with SMTP id
 ffacd0b85a97d-3e765a35a71mr4770809f8f.57.1757751124275; 
 Sat, 13 Sep 2025 01:12:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFDZ0ijofsbsNp+2PLEDrik0wT5SBg7PLTvhwVKoXg6sQ2B72Ipovraoj1kJGOYycRpzx9nwQ==
X-Received: by 2002:a05:6000:2385:b0:3e0:2a95:dc9e with SMTP id
 ffacd0b85a97d-3e765a35a71mr4770781f8f.57.1757751123705; 
 Sat, 13 Sep 2025 01:12:03 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3e84de17f9bsm2226008f8f.49.2025.09.13.01.12.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 13 Sep 2025 01:12:02 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 50/61] docs: update rust.rst
Date: Sat, 13 Sep 2025 10:09:31 +0200
Message-ID: <20250913080943.11710-51-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250913080943.11710-1-pbonzini@redhat.com>
References: <20250913080943.11710-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
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


