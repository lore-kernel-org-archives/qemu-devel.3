Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58F91CE7AB9
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 07:02:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smSw3-0004ja-PA; Fri, 06 Sep 2024 02:59:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1smSvl-0001tC-2N; Fri, 06 Sep 2024 02:58:55 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1smSvi-0003lD-W2; Fri, 06 Sep 2024 02:58:52 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id B976C8C264;
 Fri,  6 Sep 2024 09:53:14 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 82D1113341C;
 Fri,  6 Sep 2024 09:54:32 +0300 (MSK)
Received: (nullmailer pid 43691 invoked by uid 1000);
 Fri, 06 Sep 2024 06:54:31 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Alyssa Ross <hi@alyssa.is>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.7 47/53] target/hexagon: don't look for static glib
Date: Fri,  6 Sep 2024 09:54:17 +0300
Message-Id: <20240906065429.42415-47-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.2.7-20240906080902@cover.tls.msk.ru>
References: <qemu-stable-8.2.7-20240906080902@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Alyssa Ross <hi@alyssa.is>

When cross compiling QEMU configured with --static, I've been getting
configure errors like the following:

    Build-time dependency glib-2.0 found: NO

    ../target/hexagon/meson.build:303:15: ERROR: Dependency lookup for glib-2.0 with method 'pkgconfig' failed: Could not generate libs for glib-2.0:
    Package libpcre2-8 was not found in the pkg-config search path.
    Perhaps you should add the directory containing `libpcre2-8.pc'
    to the PKG_CONFIG_PATH environment variable
    Package 'libpcre2-8', required by 'glib-2.0', not found

This happens because --static sets the prefer_static Meson option, but
my build machine doesn't have a static libpcre2.  I don't think it
makes sense to insist that native dependencies are static, just
because I want the non-native QEMU binaries to be static.

Signed-off-by: Alyssa Ross <hi@alyssa.is>
Link: https://lore.kernel.org/r/20240805104921.4035256-1-hi@alyssa.is
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit fe68cc0923ebfa0c12e4176f61ec9b363a07a73a)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/hexagon/meson.build b/target/hexagon/meson.build
index da8e608d00..436217f25a 100644
--- a/target/hexagon/meson.build
+++ b/target/hexagon/meson.build
@@ -188,7 +188,7 @@ if idef_parser_enabled and 'hexagon-linux-user' in target_dirs
         arguments: ['@INPUT@', '--defines=@OUTPUT1@', '--output=@OUTPUT0@']
     )
 
-    glib_dep = dependency('glib-2.0', native: true)
+    glib_dep = dependency('glib-2.0', native: true, static: false)
 
     idef_parser = executable(
         'idef-parser',
-- 
2.39.2


