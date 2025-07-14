Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1147C83F1B
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 11:07:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubH1s-0002Hb-Ty; Mon, 14 Jul 2025 07:07:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ubGz0-0000aK-2v
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:04:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ubGys-0001Uo-NH
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:04:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752491056;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NDRZLxJKWA6sImNVSmtEek9dip1W5KzkCgPQbaRO+uY=;
 b=OJW54LZNomVu+1IPH3lOn1ydEBtIR6aAlyr3tt9gfT903zry3CmhspLbNkyNTGODnbfOpD
 /Nq264XQB3EOaHlHys8v5tBdT3Tm0onwjJxg8kg2oiVs9Cq2/X9g8nW3odEwG3wVTmsn6j
 giA/z6XgEoi/+FLF2GGHgYPONRDklzw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-369-cfLsmY0QOpueJ8lP3r0I2A-1; Mon, 14 Jul 2025 07:04:12 -0400
X-MC-Unique: cfLsmY0QOpueJ8lP3r0I2A-1
X-Mimecast-MFC-AGG-ID: cfLsmY0QOpueJ8lP3r0I2A_1752491051
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4561dbbcc7eso2087955e9.2
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 04:04:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752491050; x=1753095850;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NDRZLxJKWA6sImNVSmtEek9dip1W5KzkCgPQbaRO+uY=;
 b=k5uZUJW3NrgaV39Fp/di/nO0VIEzXdkOTbHuZv2G2zZsBaCejNMdLTxfev7xhiohVq
 L5jK/nCc2if2rahybWkNkwFTMV+C6mMQQg0wAaytIAc9YP3EIhrOUi9ex44lUGP/8yak
 ygc5Ik9N+8Fma9a6pnBybKKCDRWiYBVnGuBSkyF/gp8ZeYUQbwMjSIolzKZ+IZA2Qv8U
 mLs28n64IvsUOAhH87Em60loloL5hHzvX62BY+x8FbPwNafaXWeMg2NScYvavTmJFRii
 rrQjBewE9TcFzi7DVFnAztAUMW0lr8MVsgwifcbPsuQXy747Vf5VA1E4Crlx8ccYef65
 TiWA==
X-Gm-Message-State: AOJu0YzhWyLWSU16UNW1cx9QdYbFnWV5BBa6FA5tRfRAuWSBWU/4y4By
 rX0U4Kwuml04EQXNwVGvnkxrvuBvrDL/6lE3NigNJnBRiNtMET2ygeXl0WdrXi8UUjt7HLBdzC2
 vkIq73TZ2NHTEcl3m2cwh2uf2YqRnvhHzAJfeYotHA3ziYk2SiRnsL8SfeFW1/SQ/asYdw6Lmsr
 uo3hACqgsDSlB1MsSPwTEtshW79d8EQ2pjSEJln+XX
X-Gm-Gg: ASbGncv8xdTUvZsOYI+hN/soOMnE3AXvbvZCljsTGf2mWqe9FFjXIWWW7W9ucuQpLQG
 p/PP2ZWs72uGGf3DZMJtD17Se8uxKxR7TuckUfzoE8OCSXQADwosjnDS/FXuEuBqeXNJsgBZoA2
 2AyEyplhn1hCH0+U3JPZtz15HQkpkpKnmTX4pp4cVCKitWe707UnUXkb4Io9yyuP6isDIajvYQo
 tWZSrv4l/Z7Io3yb7jBDoUub672QlbE0+gNjfA22PACVnRakp/hTDOjDvF9oXKFQ2ePVhVjTd1h
 ovr5+tndfp+QSaCBgtuyK4f2L9ybqhuPcnFi8i0xOh4=
X-Received: by 2002:a05:600d:15a:20b0:456:214f:f78d with SMTP id
 5b1f17b1804b1-456214ffcbbmr6523185e9.22.1752491050210; 
 Mon, 14 Jul 2025 04:04:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWchi52AiVGkBDaZkhBzcfZp5vhRB5DdlQA6+9FdupEHkHxjP9CPKav7n8s/76Y2W1UB3MKQ==
X-Received: by 2002:a05:600d:15a:20b0:456:214f:f78d with SMTP id
 5b1f17b1804b1-456214ffcbbmr6523005e9.22.1752491049726; 
 Mon, 14 Jul 2025 04:04:09 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.73.155])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4561a052729sm32466735e9.33.2025.07.14.04.04.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 04:04:09 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 01/77] rust/qemu-api: Fix binding path in source directory
Date: Mon, 14 Jul 2025 13:02:50 +0200
Message-ID: <20250714110406.117772-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250714110406.117772-1-pbonzini@redhat.com>
References: <20250714110406.117772-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Zhao Liu <zhao1.liu@intel.com>

The build.rs had supported placing bindings.inc.rs in rust/qemu-api/src,
but this "not encouraged" feature is broken.

Considering that manually copying bindings.inc.rs to the development
directory is also useful, fix the bindings.inc.rs path generation to
give this feature another chance.

Fixes: commit 1ae4ca0463d7 ("rust: move rust.bindgen to qemu-api crate")
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250623073436.1833357-1-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api/build.rs | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/rust/qemu-api/build.rs b/rust/qemu-api/build.rs
index 7849486c1ba..29d09456257 100644
--- a/rust/qemu-api/build.rs
+++ b/rust/qemu-api/build.rs
@@ -9,12 +9,14 @@
 use std::{env, fs::remove_file, io::Result, path::Path};
 
 fn main() -> Result<()> {
-    // Placing bindings.inc.rs in the source directory is supported
-    // but not documented or encouraged.
-    let path = env::var("MESON_BUILD_ROOT")
-        .unwrap_or_else(|_| format!("{}/src", env!("CARGO_MANIFEST_DIR")));
+    let file = if let Ok(root) = env::var("MESON_BUILD_ROOT") {
+        format!("{root}/rust/qemu-api/bindings.inc.rs")
+    } else {
+        // Placing bindings.inc.rs in the source directory is supported
+        // but not documented or encouraged.
+        format!("{}/src/bindings.inc.rs", env!("CARGO_MANIFEST_DIR"))
+    };
 
-    let file = format!("{path}/rust/qemu-api/bindings.inc.rs");
     let file = Path::new(&file);
     if !Path::new(&file).exists() {
         panic!(concat!(
-- 
2.50.0


