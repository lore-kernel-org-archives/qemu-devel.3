Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02380CCA476
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 13:48:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v681T-0006mB-UN; Tue, 07 Oct 2025 09:46:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1v681L-0006ll-BX
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 09:46:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1v6819-0007HZ-Ki
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 09:46:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759844766;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=6MFlMmOdcHUaHBRUIVBEaj+CoVm9tQ/Wh3ynjBKbV1I=;
 b=MC1BMDk4Dtuj8zDPexgrrLAogb1+OZAx/tcTePzxljWpuaB0xItQDNEjhpqXq6XxD8hJhp
 Fj5mfEtNVi+eJuux2h21PdlvPzdEX7c215mWGXh6OLKcMZXm1rvCxUIfndhq+RjJOXmmlW
 vP8BwSrlS5Ta6817RWynkEuCS+6SZMw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-669-D5cKFj1QO46ePIC2U3ZhBQ-1; Tue,
 07 Oct 2025 09:46:05 -0400
X-MC-Unique: D5cKFj1QO46ePIC2U3ZhBQ-1
X-Mimecast-MFC-AGG-ID: D5cKFj1QO46ePIC2U3ZhBQ_1759844764
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 08C8B1955F44; Tue,  7 Oct 2025 13:46:04 +0000 (UTC)
Received: from localhost (unknown [10.44.22.31])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 88D721800447; Tue,  7 Oct 2025 13:46:01 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, rth7680@gmail.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH] build-sys: default to host vendor for rust target triple
Date: Tue,  7 Oct 2025 17:45:58 +0400
Message-ID: <20251007134558.251670-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.422,
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

This fixes docker-test@alpine, which uses "alpine" vendor.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 configure | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/configure b/configure
index 78445cbb4b..a467f3a2e0 100755
--- a/configure
+++ b/configure
@@ -1216,8 +1216,9 @@ fi
 if test "$rust" != disabled && test -z "$rust_target_triple"; then
   # arch and os generally matches between meson and rust
   rust_arch=$host_arch
+  # default to host vendor
+  rust_vendor=$(echo "$rust_host_triple" | cut -d'-' -f2)
   rust_os=$host_os
-  rust_machine=unknown
   rust_osvariant=
 
   # tweak rust_os if needed; also, machine and variant depend on the OS
@@ -1225,7 +1226,7 @@ if test "$rust" != disabled && test -z "$rust_target_triple"; then
   case "$host_os" in
   darwin)
     # e.g. aarch64-apple-darwin
-    rust_machine=apple
+    rust_vendor=apple
     ;;
 
   linux)
@@ -1273,13 +1274,13 @@ EOF
     ;;
 
   sunos)
-    rust_machine=pc
+    rust_vendor=pc
     rust_os=solaris
     ;;
 
   windows)
     # e.g. aarch64-pc-windows-gnullvm, x86_64-pc-windows-gnu (MSVC not supported)
-    rust_machine=pc
+    rust_vendor=pc
     if test "$host_arch" = aarch64; then
       rust_osvariant=gnullvm
     else
@@ -1310,7 +1311,7 @@ EOF
   sparc64)
     if test "$rust_os" = solaris; then
       rust_arch=sparcv9
-      rust_machine=sun
+      rust_vendor=sun
     fi
     ;;
 
@@ -1324,7 +1325,7 @@ EOF
     # e.g. aarch64-linux-android
     rust_target_triple=$rust_arch-$rust_os-$rust_osvariant
   else
-    rust_target_triple=$rust_arch-$rust_machine-$rust_os${rust_osvariant:+-$rust_osvariant}
+    rust_target_triple=$rust_arch-$rust_vendor-$rust_os${rust_osvariant:+-$rust_osvariant}
   fi
 fi
 
-- 
2.51.0


