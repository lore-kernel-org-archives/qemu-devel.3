Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AC37C0219B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 21:46:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thy4X-0000E4-KN; Tue, 11 Feb 2025 16:45:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1thy3N-0007xl-4J
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 16:44:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1thy3K-0005CK-5Q
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 16:44:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739310260;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XSzSFAT3rgdThuIc6FzbUhbBWhXyBUS0hMTEzRpzB2k=;
 b=NEGuWR2FPbOpfxFvBmFeujzMsCRRRZlkgVEmMBcSHSjp6wNSykj3CVa47N68xTKldrZfib
 7xRHRUqmQweZhOk9S3Q4Cymj9JOhJQqQNX/ExZ+1pTS+p1FgvAr6z4iabPIZ/VPDkgULVz
 t2ECGN0MdwWculZMSUXX1ljMNq3kmyo=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-590-e6x9UmKPO-qPmCxSyi2fmg-1; Tue,
 11 Feb 2025 16:44:16 -0500
X-MC-Unique: e6x9UmKPO-qPmCxSyi2fmg-1
X-Mimecast-MFC-AGG-ID: e6x9UmKPO-qPmCxSyi2fmg
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 236EA1955DD0; Tue, 11 Feb 2025 21:44:15 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.44.32.210])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E87B0195608D; Tue, 11 Feb 2025 21:44:11 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, pbonzini@redhat.com,
 manos.pitsidianakis@linaro.org, qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: [PATCH 03/11] rust: Add some block layer bindings
Date: Tue, 11 Feb 2025 22:43:20 +0100
Message-ID: <20250211214328.640374-4-kwolf@redhat.com>
In-Reply-To: <20250211214328.640374-1-kwolf@redhat.com>
References: <20250211214328.640374-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 rust/wrapper.h                | 4 ++++
 meson.build                   | 1 +
 rust/qemu-api/src/zeroable.rs | 5 +++--
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/rust/wrapper.h b/rust/wrapper.h
index 41be87adcf..c3e1e6f9cf 100644
--- a/rust/wrapper.h
+++ b/rust/wrapper.h
@@ -53,3 +53,7 @@ typedef enum memory_order {
 #include "chardev/char-fe.h"
 #include "qapi/error.h"
 #include "chardev/char-serial.h"
+#include "block/block.h"
+#include "block/block_int.h"
+#include "block/qdict.h"
+#include "qapi/qapi-visit-block-core.h"
diff --git a/meson.build b/meson.build
index 30aae6b3c3..154195bc80 100644
--- a/meson.build
+++ b/meson.build
@@ -4045,6 +4045,7 @@ if have_rust
     '--with-derive-default',
     '--no-layout-tests',
     '--no-prepend-enum-name',
+    '--allowlist-item', 'EINVAL|EIO',
     '--allowlist-file', meson.project_source_root() + '/include/.*',
     '--allowlist-file', meson.project_source_root() + '/.*',
     '--allowlist-file', meson.project_build_root() + '/.*'
diff --git a/rust/qemu-api/src/zeroable.rs b/rust/qemu-api/src/zeroable.rs
index b454e9e05e..60af681293 100644
--- a/rust/qemu-api/src/zeroable.rs
+++ b/rust/qemu-api/src/zeroable.rs
@@ -56,7 +56,6 @@ pub unsafe trait Zeroable: Default {
 /// ## Differences with `core::mem::zeroed`
 ///
 /// `const_zero` zeroes padding bits, while `core::mem::zeroed` doesn't
-#[allow(unused)]
 macro_rules! const_zero {
     // This macro to produce a type-generic zero constant is taken from the
     // const_zero crate (v0.1.1):
@@ -78,7 +77,6 @@ union TypeAsBytes {
 }
 
 /// A wrapper to implement the `Zeroable` trait through the `const_zero` macro.
-#[allow(unused)]
 macro_rules! impl_zeroable {
     ($type:ty) => {
         unsafe impl Zeroable for $type {
@@ -110,3 +108,6 @@ fn default() -> Self {
 impl_zeroable!(crate::bindings::MemoryRegionOps__bindgen_ty_1);
 #[cfg(feature = "system")]
 impl_zeroable!(crate::bindings::MemoryRegionOps__bindgen_ty_2);
+
+impl_zeroable!(crate::bindings::BlockDriver);
+impl_zeroable!(crate::bindings::BlockDriver__bindgen_ty_1);
-- 
2.48.1


