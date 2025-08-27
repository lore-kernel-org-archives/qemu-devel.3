Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1C05CA0FF6
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 10:43:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urDby-00040t-9X; Wed, 27 Aug 2025 06:42:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1urDbw-0003zP-JZ
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 06:42:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1urDbs-0002zZ-Cr
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 06:42:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756291351;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Yis1+3I1eI5V2+RGPR1Visnh840oFWxlG3qreZ9Q9Tg=;
 b=QF+61bcb4ib4/OLAi+31pGjn5/WLfPqj6XtSBKFGbq2782d78qo8fAnETeIa9a21I/1auK
 qNhihvuZ+wN3XYc/gnMh6TBrRocLTpEOfDmzUz4RfRZewbdSZVZpc1wCwJt1/o5I0Bgum6
 ZX9E5kQ/SKVXU2bwgpuVI9NltdLa1xg=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-106-tAAZ3kZSN3CJ5ybKyZj-7g-1; Wed,
 27 Aug 2025 06:42:26 -0400
X-MC-Unique: tAAZ3kZSN3CJ5ybKyZj-7g-1
X-Mimecast-MFC-AGG-ID: tAAZ3kZSN3CJ5ybKyZj-7g_1756291345
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2616B1956087; Wed, 27 Aug 2025 10:42:25 +0000 (UTC)
Received: from localhost (unknown [10.45.242.16])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 475181955F24; Wed, 27 Aug 2025 10:42:22 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 pbonzini@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH 04/22] rust: make build.rs generic over various ./rust/projects
Date: Wed, 27 Aug 2025 14:41:26 +0400
Message-ID: <20250827104147.717203-5-marcandre.lureau@redhat.com>
In-Reply-To: <20250827104147.717203-1-marcandre.lureau@redhat.com>
References: <20250827104147.717203-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Guess the name of the subdir from the manifest directory, instead of
hard-coding it. In the following commits, other crates can then link to
this file, instead of maintaining their own copy.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 rust/qemu-api/build.rs | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/rust/qemu-api/build.rs b/rust/qemu-api/build.rs
index 29d0945625..92237183ec 100644
--- a/rust/qemu-api/build.rs
+++ b/rust/qemu-api/build.rs
@@ -9,12 +9,14 @@
 use std::{env, fs::remove_file, io::Result, path::Path};
 
 fn main() -> Result<()> {
+    let manifest_dir = env!("CARGO_MANIFEST_DIR");
     let file = if let Ok(root) = env::var("MESON_BUILD_ROOT") {
-        format!("{root}/rust/qemu-api/bindings.inc.rs")
+        let sub = get_rust_subdir(manifest_dir).unwrap();
+        format!("{root}/{sub}/bindings.inc.rs")
     } else {
         // Placing bindings.inc.rs in the source directory is supported
         // but not documented or encouraged.
-        format!("{}/src/bindings.inc.rs", env!("CARGO_MANIFEST_DIR"))
+        format!("{}/src/bindings.inc.rs", manifest_dir)
     };
 
     let file = Path::new(&file);
@@ -41,3 +43,7 @@ fn main() -> Result<()> {
     println!("cargo:rerun-if-changed=build.rs");
     Ok(())
 }
+
+fn get_rust_subdir(path: &str) -> Option<&str> {
+    path.find("/rust").map(|index| &path[index + 1..])
+}
-- 
2.50.1


