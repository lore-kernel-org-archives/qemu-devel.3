Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BA4BC79FA0
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 07:40:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3qRR-0005d3-JM; Tue, 08 Sep 2026 03:40:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x3qRQ-0005cs-5d
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 03:40:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x3qRN-0000k4-8z
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 03:40:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788853223;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=C5UDaAeLcRvUKgALiDteW2rW6IuR4/zx3UC3Seipl5s=;
 b=I4uh6LeB8nDF9zfUAksUQJdZiVkL5gzYBadqXIwmDSCbVha5cTVSB95I359ecmz/Klm4rJ
 WX/1SUjGx0gH/+mVudhdSyhp7zXQ0V0P6JWogmuGZzeztBTF2foJIO20ToF5xZV++oJGAq
 1KjX07zKZ0TVUMWTVytpXtUFr/kezGY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-92-At8jyVNuOAWHzXU0UU5m2Q-1; Tue,
 08 Sep 2026 03:40:20 -0400
X-MC-Unique: At8jyVNuOAWHzXU0UU5m2Q-1
X-Mimecast-MFC-AGG-ID: At8jyVNuOAWHzXU0UU5m2Q_1788853219
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1413D182A100; Tue,  8 Sep 2026 07:40:19 +0000 (UTC)
Received: from berrange.fritz.box (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B38145B1; Tue,  8 Sep 2026 07:40:17 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH] meson: refresh build options script
Date: Tue,  8 Sep 2026 08:40:16 +0100
Message-ID: <20260908074016.2143292-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Recent changes added more meson options, but missed refreshing of
the meson-buildoptions.sh file, causing it to frequently appear
dirty when doing builds.

Fixes: 7e1d54da6faf (tests/tcg/meson.build: implement ./configure -cross-cc-* options)
Fixes: 522b299ca431 (tests/tcg/meson.build: implement ./configure containers options)
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 scripts/meson-buildoptions.sh | 138 ++++++++++++++++++++++++++++++++++
 1 file changed, 138 insertions(+)

diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index 5a67e59a16..eb15551286 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -10,7 +10,10 @@ meson_options_help() {
   printf "%s\n" '  --block-drv-rw-whitelist=VALUE'
   printf "%s\n" '                           set block driver read-write whitelist (by default'
   printf "%s\n" '                           affects only QEMU, not tools like qemu-img)'
+  printf "%s\n" '  --container-command=VALUE'
+  printf "%s\n" '                           command to build/run containers'
   printf "%s\n" '  --datadir=VALUE          Data file directory [share]'
+  printf "%s\n" '  --disable-containers     use containers to cross compile tcg tests'
   printf "%s\n" '  --disable-coroutine-pool coroutine freelist (better performance)'
   printf "%s\n" '  --disable-debug-info     Enable debug symbols and other information'
   printf "%s\n" '  --disable-hexagon-idef-parser'
@@ -77,6 +80,94 @@ meson_options_help() {
   printf "%s\n" '  --rtsig-map=VALUE        default value of QEMU_RTSIG_MAP [NULL]'
   printf "%s\n" '  --smbd=VALUE             Path to smbd for slirp networking'
   printf "%s\n" '  --sysconfdir=VALUE       Sysconf data directory [etc]'
+  printf "%s\n" '  --tcg-tests-cross-cc-aarch64=VALUE'
+  printf "%s\n" '                           cc for aarch64 tcg tests'
+  printf "%s\n" '  --tcg-tests-cross-cc-aarch64-be=VALUE'
+  printf "%s\n" '                           cc for aarch64_be tcg tests'
+  printf "%s\n" '  --tcg-tests-cross-cc-alpha=VALUE'
+  printf "%s\n" '                           cc for alpha tcg tests'
+  printf "%s\n" '  --tcg-tests-cross-cc-arm=VALUE'
+  printf "%s\n" '                           cc for arm tcg tests'
+  printf "%s\n" '  --tcg-tests-cross-cc-hexagon=VALUE'
+  printf "%s\n" '                           cc for hexagon tcg tests'
+  printf "%s\n" '  --tcg-tests-cross-cc-hppa=VALUE'
+  printf "%s\n" '                           cc for hppa tcg tests'
+  printf "%s\n" '  --tcg-tests-cross-cc-i386=VALUE'
+  printf "%s\n" '                           cc for i386 tcg tests'
+  printf "%s\n" '  --tcg-tests-cross-cc-loongarch64=VALUE'
+  printf "%s\n" '                           cc for loongarch64 tcg tests'
+  printf "%s\n" '  --tcg-tests-cross-cc-m68k=VALUE'
+  printf "%s\n" '                           cc for m68k tcg tests'
+  printf "%s\n" '  --tcg-tests-cross-cc-mips=VALUE'
+  printf "%s\n" '                           cc for mips tcg tests'
+  printf "%s\n" '  --tcg-tests-cross-cc-mips64=VALUE'
+  printf "%s\n" '                           cc for mips64 tcg tests'
+  printf "%s\n" '  --tcg-tests-cross-cc-mips64el=VALUE'
+  printf "%s\n" '                           cc for mips64el tcg tests'
+  printf "%s\n" '  --tcg-tests-cross-cc-or1k=VALUE'
+  printf "%s\n" '                           cc for or1k tcg tests'
+  printf "%s\n" '  --tcg-tests-cross-cc-ppc64=VALUE'
+  printf "%s\n" '                           cc for ppc64 tcg tests'
+  printf "%s\n" '  --tcg-tests-cross-cc-ppc64le=VALUE'
+  printf "%s\n" '                           cc for ppc64le tcg tests'
+  printf "%s\n" '  --tcg-tests-cross-cc-riscv64=VALUE'
+  printf "%s\n" '                           cc for riscv64 tcg tests'
+  printf "%s\n" '  --tcg-tests-cross-cc-s390x=VALUE'
+  printf "%s\n" '                           cc for s390x tcg tests'
+  printf "%s\n" '  --tcg-tests-cross-cc-sh4=VALUE'
+  printf "%s\n" '                           cc for sh4 tcg tests'
+  printf "%s\n" '  --tcg-tests-cross-cc-tricore=VALUE'
+  printf "%s\n" '                           cc for tricore tcg tests'
+  printf "%s\n" '  --tcg-tests-cross-cc-x86-64=VALUE'
+  printf "%s\n" '                           cc for x86_64 tcg tests'
+  printf "%s\n" '  --tcg-tests-cross-cc-xtensa=VALUE'
+  printf "%s\n" '                           cc for xtensa tcg tests'
+  printf "%s\n" '  --tcg-tests-cross-cc-xtensaeb=VALUE'
+  printf "%s\n" '                           cc for xtensaeb tcg tests'
+  printf "%s\n" '  --tcg-tests-cross-cflags-aarch64=VALUE'
+  printf "%s\n" '                           cflags for aarch64 tcg tests'
+  printf "%s\n" '  --tcg-tests-cross-cflags-aarch64-be=VALUE'
+  printf "%s\n" '                           cflags for aarch64_be tcg tests'
+  printf "%s\n" '  --tcg-tests-cross-cflags-alpha=VALUE'
+  printf "%s\n" '                           cflags for alpha tcg tests'
+  printf "%s\n" '  --tcg-tests-cross-cflags-arm=VALUE'
+  printf "%s\n" '                           cflags for arm tcg tests'
+  printf "%s\n" '  --tcg-tests-cross-cflags-hexagon=VALUE'
+  printf "%s\n" '                           cflags for hexagon tcg tests'
+  printf "%s\n" '  --tcg-tests-cross-cflags-hppa=VALUE'
+  printf "%s\n" '                           cflags for hppa tcg tests'
+  printf "%s\n" '  --tcg-tests-cross-cflags-i386=VALUE'
+  printf "%s\n" '                           cflags for i386 tcg tests'
+  printf "%s\n" '  --tcg-tests-cross-cflags-loongarch64=VALUE'
+  printf "%s\n" '                           cflags for loongarch64 tcg tests'
+  printf "%s\n" '  --tcg-tests-cross-cflags-m68k=VALUE'
+  printf "%s\n" '                           cflags for m68k tcg tests'
+  printf "%s\n" '  --tcg-tests-cross-cflags-mips=VALUE'
+  printf "%s\n" '                           cflags for mips tcg tests'
+  printf "%s\n" '  --tcg-tests-cross-cflags-mips64=VALUE'
+  printf "%s\n" '                           cflags for mips64 tcg tests'
+  printf "%s\n" '  --tcg-tests-cross-cflags-mips64el=VALUE'
+  printf "%s\n" '                           cflags for mips64el tcg tests'
+  printf "%s\n" '  --tcg-tests-cross-cflags-or1k=VALUE'
+  printf "%s\n" '                           cflags for or1k tcg tests'
+  printf "%s\n" '  --tcg-tests-cross-cflags-ppc64=VALUE'
+  printf "%s\n" '                           cflags for ppc64 tcg tests'
+  printf "%s\n" '  --tcg-tests-cross-cflags-ppc64le=VALUE'
+  printf "%s\n" '                           cflags for ppc64le tcg tests'
+  printf "%s\n" '  --tcg-tests-cross-cflags-riscv64=VALUE'
+  printf "%s\n" '                           cflags for riscv64 tcg tests'
+  printf "%s\n" '  --tcg-tests-cross-cflags-s390x=VALUE'
+  printf "%s\n" '                           cflags for s390x tcg tests'
+  printf "%s\n" '  --tcg-tests-cross-cflags-sh4=VALUE'
+  printf "%s\n" '                           cflags for sh4 tcg tests'
+  printf "%s\n" '  --tcg-tests-cross-cflags-tricore=VALUE'
+  printf "%s\n" '                           cflags for tricore tcg tests'
+  printf "%s\n" '  --tcg-tests-cross-cflags-x86-64=VALUE'
+  printf "%s\n" '                           cflags for x86_64 tcg tests'
+  printf "%s\n" '  --tcg-tests-cross-cflags-xtensa=VALUE'
+  printf "%s\n" '                           cflags for xtensa tcg tests'
+  printf "%s\n" '  --tcg-tests-cross-cflags-xtensaeb=VALUE'
+  printf "%s\n" '                           cflags for xtensaeb tcg tests'
   printf "%s\n" '  --tls-priority=VALUE     Default TLS protocol/cipher priority string'
   printf "%s\n" '                           [NORMAL]'
   printf "%s\n" '  --with-coroutine=CHOICE  coroutine backend to use (choices:'
@@ -281,6 +372,9 @@ _meson_option_parse() {
     --disable-cocoa) printf "%s" -Dcocoa=disabled ;;
     --enable-colo-proxy) printf "%s" -Dcolo_proxy=enabled ;;
     --disable-colo-proxy) printf "%s" -Dcolo_proxy=disabled ;;
+    --container-command=*) quote_sh "-Dcontainer_command=$2" ;;
+    --enable-containers) printf "%s" -Dcontainers=true ;;
+    --disable-containers) printf "%s" -Dcontainers=false ;;
     --enable-coreaudio) printf "%s" -Dcoreaudio=enabled ;;
     --disable-coreaudio) printf "%s" -Dcoreaudio=disabled ;;
     --with-coroutine=*) quote_sh "-Dcoroutine_backend=$2" ;;
@@ -517,6 +611,50 @@ _meson_option_parse() {
     --disable-tcg) printf "%s" -Dtcg=disabled ;;
     --enable-tcg-interpreter) printf "%s" -Dtcg_interpreter=true ;;
     --disable-tcg-interpreter) printf "%s" -Dtcg_interpreter=false ;;
+    --tcg-tests-cross-cc-aarch64=*) quote_sh "-Dtcg_tests_cross_cc_aarch64=$2" ;;
+    --tcg-tests-cross-cc-aarch64-be=*) quote_sh "-Dtcg_tests_cross_cc_aarch64_be=$2" ;;
+    --tcg-tests-cross-cc-alpha=*) quote_sh "-Dtcg_tests_cross_cc_alpha=$2" ;;
+    --tcg-tests-cross-cc-arm=*) quote_sh "-Dtcg_tests_cross_cc_arm=$2" ;;
+    --tcg-tests-cross-cc-hexagon=*) quote_sh "-Dtcg_tests_cross_cc_hexagon=$2" ;;
+    --tcg-tests-cross-cc-hppa=*) quote_sh "-Dtcg_tests_cross_cc_hppa=$2" ;;
+    --tcg-tests-cross-cc-i386=*) quote_sh "-Dtcg_tests_cross_cc_i386=$2" ;;
+    --tcg-tests-cross-cc-loongarch64=*) quote_sh "-Dtcg_tests_cross_cc_loongarch64=$2" ;;
+    --tcg-tests-cross-cc-m68k=*) quote_sh "-Dtcg_tests_cross_cc_m68k=$2" ;;
+    --tcg-tests-cross-cc-mips=*) quote_sh "-Dtcg_tests_cross_cc_mips=$2" ;;
+    --tcg-tests-cross-cc-mips64=*) quote_sh "-Dtcg_tests_cross_cc_mips64=$2" ;;
+    --tcg-tests-cross-cc-mips64el=*) quote_sh "-Dtcg_tests_cross_cc_mips64el=$2" ;;
+    --tcg-tests-cross-cc-or1k=*) quote_sh "-Dtcg_tests_cross_cc_or1k=$2" ;;
+    --tcg-tests-cross-cc-ppc64=*) quote_sh "-Dtcg_tests_cross_cc_ppc64=$2" ;;
+    --tcg-tests-cross-cc-ppc64le=*) quote_sh "-Dtcg_tests_cross_cc_ppc64le=$2" ;;
+    --tcg-tests-cross-cc-riscv64=*) quote_sh "-Dtcg_tests_cross_cc_riscv64=$2" ;;
+    --tcg-tests-cross-cc-s390x=*) quote_sh "-Dtcg_tests_cross_cc_s390x=$2" ;;
+    --tcg-tests-cross-cc-sh4=*) quote_sh "-Dtcg_tests_cross_cc_sh4=$2" ;;
+    --tcg-tests-cross-cc-tricore=*) quote_sh "-Dtcg_tests_cross_cc_tricore=$2" ;;
+    --tcg-tests-cross-cc-x86-64=*) quote_sh "-Dtcg_tests_cross_cc_x86_64=$2" ;;
+    --tcg-tests-cross-cc-xtensa=*) quote_sh "-Dtcg_tests_cross_cc_xtensa=$2" ;;
+    --tcg-tests-cross-cc-xtensaeb=*) quote_sh "-Dtcg_tests_cross_cc_xtensaeb=$2" ;;
+    --tcg-tests-cross-cflags-aarch64=*) quote_sh "-Dtcg_tests_cross_cflags_aarch64=$2" ;;
+    --tcg-tests-cross-cflags-aarch64-be=*) quote_sh "-Dtcg_tests_cross_cflags_aarch64_be=$2" ;;
+    --tcg-tests-cross-cflags-alpha=*) quote_sh "-Dtcg_tests_cross_cflags_alpha=$2" ;;
+    --tcg-tests-cross-cflags-arm=*) quote_sh "-Dtcg_tests_cross_cflags_arm=$2" ;;
+    --tcg-tests-cross-cflags-hexagon=*) quote_sh "-Dtcg_tests_cross_cflags_hexagon=$2" ;;
+    --tcg-tests-cross-cflags-hppa=*) quote_sh "-Dtcg_tests_cross_cflags_hppa=$2" ;;
+    --tcg-tests-cross-cflags-i386=*) quote_sh "-Dtcg_tests_cross_cflags_i386=$2" ;;
+    --tcg-tests-cross-cflags-loongarch64=*) quote_sh "-Dtcg_tests_cross_cflags_loongarch64=$2" ;;
+    --tcg-tests-cross-cflags-m68k=*) quote_sh "-Dtcg_tests_cross_cflags_m68k=$2" ;;
+    --tcg-tests-cross-cflags-mips=*) quote_sh "-Dtcg_tests_cross_cflags_mips=$2" ;;
+    --tcg-tests-cross-cflags-mips64=*) quote_sh "-Dtcg_tests_cross_cflags_mips64=$2" ;;
+    --tcg-tests-cross-cflags-mips64el=*) quote_sh "-Dtcg_tests_cross_cflags_mips64el=$2" ;;
+    --tcg-tests-cross-cflags-or1k=*) quote_sh "-Dtcg_tests_cross_cflags_or1k=$2" ;;
+    --tcg-tests-cross-cflags-ppc64=*) quote_sh "-Dtcg_tests_cross_cflags_ppc64=$2" ;;
+    --tcg-tests-cross-cflags-ppc64le=*) quote_sh "-Dtcg_tests_cross_cflags_ppc64le=$2" ;;
+    --tcg-tests-cross-cflags-riscv64=*) quote_sh "-Dtcg_tests_cross_cflags_riscv64=$2" ;;
+    --tcg-tests-cross-cflags-s390x=*) quote_sh "-Dtcg_tests_cross_cflags_s390x=$2" ;;
+    --tcg-tests-cross-cflags-sh4=*) quote_sh "-Dtcg_tests_cross_cflags_sh4=$2" ;;
+    --tcg-tests-cross-cflags-tricore=*) quote_sh "-Dtcg_tests_cross_cflags_tricore=$2" ;;
+    --tcg-tests-cross-cflags-x86-64=*) quote_sh "-Dtcg_tests_cross_cflags_x86_64=$2" ;;
+    --tcg-tests-cross-cflags-xtensa=*) quote_sh "-Dtcg_tests_cross_cflags_xtensa=$2" ;;
+    --tcg-tests-cross-cflags-xtensaeb=*) quote_sh "-Dtcg_tests_cross_cflags_xtensaeb=$2" ;;
     --tls-priority=*) quote_sh "-Dtls_priority=$2" ;;
     --enable-tools) printf "%s" -Dtools=enabled ;;
     --disable-tools) printf "%s" -Dtools=disabled ;;
-- 
2.55.0


