Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C37DBE7717D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2024 12:39:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKd1P-0003wU-MX; Mon, 09 Dec 2024 07:37:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tKd1D-0003pF-1K
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 07:37:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tKd14-0007P9-Pa
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 07:37:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733747853;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OshVopfsDLXhXQaf0FN9QUClgxDd1xn/z3ig2ZaD5Nc=;
 b=Nb4sq82fOIiXHRVvS8H9y0NAeucUJlX9eXXVqH1aBKieVqW0LJ6ztvPFcZs2EQR8rbvHqg
 rclXKkQlW0xQkHpJz1KxQbWlJ8ih8ranQ5qM3gCUdpL29W20WgxfiHE0V/zi7Xt4GYpz5F
 TUjddMLNuIaAKKisOQW8lZddZGRRSV0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-59-RM2fGMT2OO62Mclv16jX4g-1; Mon, 09 Dec 2024 07:37:31 -0500
X-MC-Unique: RM2fGMT2OO62Mclv16jX4g-1
X-Mimecast-MFC-AGG-ID: RM2fGMT2OO62Mclv16jX4g
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-434f387f346so10668025e9.1
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2024 04:37:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733747849; x=1734352649;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OshVopfsDLXhXQaf0FN9QUClgxDd1xn/z3ig2ZaD5Nc=;
 b=Jbhw4TbJSJQgMJe6pdx3WGabpDNGp2DwZBfFVZdAKG9raI1Qct3lMoGQmZ/a+aDpqg
 AazKlQrscNLZXcWKdL+Db+3NQ0hM/rFZqtlSLq1BigV3srIgWEOaZqVli+Rt5Y2ATkoo
 CnHKtEExmzCsAyeJQ2SjOD0BV5FmcCgm/r1uYEECT9YZIFByP29jNOcYdH7X09Y9wAAB
 P52RQmzjDvlhO9WrLc3RahIK53QnsLJZ8vJPUhjK7XSxwZhL7/3yjObg4UE+MheI/X6B
 J/D3Z98ba6wKYyUklcavbPzdjbFeXrBN+Hwr0VdEKbT1GhRVGdkfvw207QILJ6IeVRBc
 F9Ag==
X-Gm-Message-State: AOJu0Yymr0ffC14QXKpp7T+oehTV0OVkukrTk3BHVT2V426VKkjUWcAd
 rgMOpSQZxjyL9mSvIAp5tEY63SyuHfczt48a2pvBrOB8w1aWzM+o7P260UCY76pfbLwJB+Ori96
 ma14gkomEjIL7kubE7e5zoiCw9HJ9sbWT0D1VHp7WfH/r+6QMRAOplhdxb8r7dwoGLgZeGH36Wt
 gp6zrLV157/MzfsUEg3UITFs8lgSRDe21g7IuI
X-Gm-Gg: ASbGnctG9GZzW4hhHxlZN610pLHo+Mx4fSHPBH3/emLaZjyqAYxZWMJoFKLfw5INnG/
 cIw09lsp/Z82C9ifAYa2B1lZE2Z3VYeW4YtLAVrvPvCAGfnWS5UOYr98w2Y3oYdUaufZc5OXt7f
 SBLVJzLh4lpgntOUd40O2rv3cV8wsYcRrF6nuJtIxo9Ew09/FMtsfoReUB3Ju9x3nh4BTTzyjW4
 y2uW7GPFQk2EI4L/2aco/aTIpprYZ0lz5uhFrjO2zDb3g5+vfD6zg==
X-Received: by 2002:a05:600c:218b:b0:434:e8cf:6390 with SMTP id
 5b1f17b1804b1-434e8cf6549mr58800695e9.6.1733747849204; 
 Mon, 09 Dec 2024 04:37:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFHlEgkoznpcJBVMGo3GWGVCxSEwTQXhhE5t4h73rLaMp1i9fY4c8mflKhLCQexfBFrkVKgTQ==
X-Received: by 2002:a05:600c:218b:b0:434:e8cf:6390 with SMTP id
 5b1f17b1804b1-434e8cf6549mr58800475e9.6.1733747848846; 
 Mon, 09 Dec 2024 04:37:28 -0800 (PST)
Received: from [192.168.10.47] ([151.81.118.45])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434ea285b57sm82152305e9.37.2024.12.09.04.37.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Dec 2024 04:37:28 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Junjie Mao <junjie.mao@hotmail.com>
Subject: [PATCH 04/26] rust: define prelude
Date: Mon,  9 Dec 2024 13:36:55 +0100
Message-ID: <20241209123717.99077-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241209123717.99077-1-pbonzini@redhat.com>
References: <20241209123717.99077-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.489,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

Add a module that will contain frequently used traits and
occasionally structs.  They can be included quickly with
"use qemu_api::prelude::*".

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api/meson.build    | 1 +
 rust/qemu-api/src/lib.rs     | 5 +++++
 rust/qemu-api/src/prelude.rs | 6 ++++++
 3 files changed, 12 insertions(+)
 create mode 100644 rust/qemu-api/src/prelude.rs

diff --git a/rust/qemu-api/meson.build b/rust/qemu-api/meson.build
index cacb112c5c3..f8b4cd39a26 100644
--- a/rust/qemu-api/meson.build
+++ b/rust/qemu-api/meson.build
@@ -21,6 +21,7 @@ _qemu_api_rs = static_library(
       'src/definitions.rs',
       'src/device_class.rs',
       'src/offset_of.rs',
+      'src/prelude.rs',
       'src/vmstate.rs',
       'src/zeroable.rs',
     ],
diff --git a/rust/qemu-api/src/lib.rs b/rust/qemu-api/src/lib.rs
index b04d110b3f5..e5956cd5eb6 100644
--- a/rust/qemu-api/src/lib.rs
+++ b/rust/qemu-api/src/lib.rs
@@ -7,6 +7,11 @@
 #[rustfmt::skip]
 pub mod bindings;
 
+// preserve one-item-per-"use" syntax, it is clearer
+// for prelude-like modules
+#[rustfmt::skip]
+pub mod prelude;
+
 pub mod c_str;
 pub mod cell;
 pub mod definitions;
diff --git a/rust/qemu-api/src/prelude.rs b/rust/qemu-api/src/prelude.rs
new file mode 100644
index 00000000000..dfaddbd062a
--- /dev/null
+++ b/rust/qemu-api/src/prelude.rs
@@ -0,0 +1,6 @@
+// Copyright 2024 Red Hat, Inc.
+// Author(s): Paolo Bonzini <pbonzini@redhat.com>
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+pub use crate::cell::BqlCell;
+pub use crate::cell::BqlRefCell;
-- 
2.47.1


