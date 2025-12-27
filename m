Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93310E8FDD5
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Dec 2025 09:19:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZQQR-00037n-Nd; Sat, 27 Dec 2025 04:17:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQQQ-0002z3-Km
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:17:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQQO-0002jf-VU
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:17:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766827044;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d7SYOw4sQQDax6EO5Hl/iUoTI2G92OOQPR76b24ZCis=;
 b=dEWG63tPw2QwJj/HrFLsGT+bV9UPvarGhcrP7uglH+tuQF/6c0j77xNzqm9AgZLnevN/32
 WHs1tcS5D9FmKb8aYjThGcUWnCe/MInBvExLrJEzbHZOGF26uGr7xafCdNZVtYaXABMsDI
 5a5XAJJlXf05ymz/qYRXL28Dp1/c32o=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-148-13oPvDatOwqraIgi9pOwfg-1; Sat, 27 Dec 2025 04:17:22 -0500
X-MC-Unique: 13oPvDatOwqraIgi9pOwfg-1
X-Mimecast-MFC-AGG-ID: 13oPvDatOwqraIgi9pOwfg_1766827041
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-47d4029340aso23149445e9.3
 for <qemu-devel@nongnu.org>; Sat, 27 Dec 2025 01:17:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766827040; x=1767431840; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d7SYOw4sQQDax6EO5Hl/iUoTI2G92OOQPR76b24ZCis=;
 b=UAE/OMgqZxoQt77VqV9/4nMxef5vcYGekiKimmdEuRPpMjdZaonwvbrBQ1m3AVkz7g
 OD2VuYx8ot7u/PAwXYVek3MavHfZ/LQSn4V82e4fsSB6US3X4GE3xm+WXUP63qP1HygC
 EwkZhSpBjQgvy5tSRjpVRoOjenFx5JKb5TFKPhro+6JapLHEiM38guiTlETqi0lvo+o/
 AjPTTFlVjtnZdalZ8oRAh+NSrPgS34q1/omfhLSS82zoHa2dXuG8glsrUVLZ19+DQo4v
 Ypug2+FwBBhN31pX4fttt6TE39KpdYLF1KhypmQcEYLls9erwectnTS2+mh8aVFOMaSx
 hAcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766827040; x=1767431840;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=d7SYOw4sQQDax6EO5Hl/iUoTI2G92OOQPR76b24ZCis=;
 b=kVne/6HMCcWBo6HLY8P07Z2xK7QggUn3Y8pZPPH1b2rm+U3rVq1/nUB7Tr/Kj47I34
 cRvwph2uoOR7c1V6WcOZSWQaPYLQhv+rxM+wiJO86y+oZ52WbQfCDoC8j58BWwmSWTYX
 QCqOpTK1yfuezDHNvkGkMWhYb5dxJ2wlGzkS9jZ2XfkPlyomC2MOUWZCNPX9ffq/dyGG
 uZv6Ml/wNT8aac0YOLB80yHfa56FM6QbLDSuget2gG9W8z+VwFYMpkuR5ldbpzlVKSdi
 oi67F1pXiVwnZG6gYub1+lUDH28+XZKXO+pXK5Tl1SQgwbl7puHXkJ9apcEZcf3xClcS
 yKZA==
X-Gm-Message-State: AOJu0YyHtsZB4NerBDN6knrrFcCJXlD2o9DxLQuV/h6YmrD3wktFLeG+
 eNjU9C2tAcfLk4PW0pOTzmJYRDLprLP9Yy5JZPjBnJ9D8Nuzfxf5GvJ/zR33scUCe56xaRn5gAq
 Oq4yQOZa41AdbKppI7Z+CiySFp+fOmbrTsWYmIxWo/oBs17yKtCTWeuh5wUiC8pb8P1YrlMhF30
 cPsGi2oRqNv2HaBbpkwKlU5otFGoGIlYl7q+g4nGGn
X-Gm-Gg: AY/fxX51HqG+bU1irqS/AbvF/x+a+3krGQSyYs/wOKHDax9Y9VJimdGoDZw+hNa7dpC
 Mcqma3AfY8aCmwCGSVIZERHfE0RJcSuWafXnq12xQJDPsHXx6ZwcrLWLcAGDvVLW6gj55S6b3Yh
 MVW32JyCT4tbGN2usxcUgpVlYdz4F+3s0AWAseEm1/SGnL6/qwybA6uagYoQULVQa5ibmXxmKDi
 XLJPOXeRxqdSKnPCrKtGCvrsI7cfAjLUODUQEdXgs6IvyqukE31rK1BeF9BpEgkQ18/QrZOtLNH
 xx12KwtHDiTBt/yMu1NRgnrsAcsi98hmg9xnXYbNXQ4i5SCx1xEwSzDA/j2AO1TURHN4CoMELcI
 HLfxPHOi6d4zfred8soJkIoThVgsoY6uJuQ6limxKFDnClR262kU+KAbllYxnzH6oOVccjz4rit
 nfhzCodb5UTpMilGo=
X-Received: by 2002:a05:600c:314f:b0:47d:4fbe:e6cc with SMTP id
 5b1f17b1804b1-47d4fbee749mr18018425e9.13.1766827040349; 
 Sat, 27 Dec 2025 01:17:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGA4TTzFVoVBxsMgBe2zMFziu9DEzsmavLgTtSYCv2qtvHGYCCsvtdVLRfg4LxH4Z5MzzxsVQ==
X-Received: by 2002:a05:600c:314f:b0:47d:4fbe:e6cc with SMTP id
 5b1f17b1804b1-47d4fbee749mr18018095e9.13.1766827039807; 
 Sat, 27 Dec 2025 01:17:19 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d192e88f5sm427166925e9.0.2025.12.27.01.17.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Dec 2025 01:17:19 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 030/153] rust: remove leftover bindings/
Date: Sat, 27 Dec 2025 10:14:17 +0100
Message-ID: <20251227091622.20725-31-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251227091622.20725-1-pbonzini@redhat.com>
References: <20251227091622.20725-1-pbonzini@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 rust/bindings/src/lib.rs | 64 ----------------------------------------
 1 file changed, 64 deletions(-)
 delete mode 100644 rust/bindings/src/lib.rs

diff --git a/rust/bindings/src/lib.rs b/rust/bindings/src/lib.rs
deleted file mode 100644
index 4c9bb794f79..00000000000
--- a/rust/bindings/src/lib.rs
+++ /dev/null
@@ -1,64 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-#![allow(
-    dead_code,
-    improper_ctypes_definitions,
-    improper_ctypes,
-    non_camel_case_types,
-    non_snake_case,
-    non_upper_case_globals,
-    unsafe_op_in_unsafe_fn,
-    clippy::pedantic,
-    clippy::restriction,
-    clippy::style,
-    clippy::missing_const_for_fn,
-    clippy::ptr_offset_with_cast,
-    clippy::useless_transmute,
-    clippy::missing_safety_doc
-)]
-
-//! `bindgen`-generated declarations.
-
-#[cfg(MESON)]
-include!("bindings.inc.rs");
-
-#[cfg(not(MESON))]
-include!(concat!(env!("OUT_DIR"), "/bindings.inc.rs"));
-
-// SAFETY: these are implemented in C; the bindings need to assert that the
-// BQL is taken, either directly or via `BqlCell` and `BqlRefCell`.
-// When bindings for character devices are introduced, this can be
-// moved to the Opaque<> wrapper in src/chardev.rs.
-unsafe impl Send for CharFrontend {}
-unsafe impl Sync for CharFrontend {}
-
-// SAFETY: this is a pure data struct
-unsafe impl Send for CoalescedMemoryRange {}
-unsafe impl Sync for CoalescedMemoryRange {}
-
-// SAFETY: these are constants and vtables; the Send and Sync requirements
-// are deferred to the unsafe callbacks that they contain
-unsafe impl Send for MemoryRegionOps {}
-unsafe impl Sync for MemoryRegionOps {}
-
-unsafe impl Send for Property {}
-unsafe impl Sync for Property {}
-
-unsafe impl Send for TypeInfo {}
-unsafe impl Sync for TypeInfo {}
-
-unsafe impl Send for VMStateDescription {}
-unsafe impl Sync for VMStateDescription {}
-
-unsafe impl Send for VMStateField {}
-unsafe impl Sync for VMStateField {}
-
-unsafe impl Send for VMStateInfo {}
-unsafe impl Sync for VMStateInfo {}
-
-// bindgen does not derive Default here
-#[allow(clippy::derivable_impls)]
-impl Default for VMStateFlags {
-    fn default() -> Self {
-        Self(0)
-    }
-}
-- 
2.52.0


