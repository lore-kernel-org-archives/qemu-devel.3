Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2295CD98E4
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 15:56:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZW9B-00027G-Rr; Tue, 16 Jun 2026 11:56:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wZW9A-00026Y-5l
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 11:56:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wZW98-0003mU-JQ
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 11:56:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781625373;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k27/eUmDM815VUaa7ufhF5v1wTbU/Zq3allr9yBd0J8=;
 b=EjQQMtV/2rcQI+sV8jhwwvVx4TUG4cAJraa92WmjdaCfnX5S78xU6p8x96Ojt64Pn6jsNl
 xlxfIkBJRPsAO6yJ1AprpulkOV7wiOQc/xXBKeQ78Em3mbCCEqvAnfeDtmZ8fNat4OKNcu
 3gEXcQYTj0KgHb7U89o+wO20z8p2+TQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-459-x2ua3dkXOAWShivtgQ12Jw-1; Tue,
 16 Jun 2026 11:56:10 -0400
X-MC-Unique: x2ua3dkXOAWShivtgQ12Jw-1
X-Mimecast-MFC-AGG-ID: x2ua3dkXOAWShivtgQ12Jw_1781625369
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 32FD518005BD; Tue, 16 Jun 2026 15:56:08 +0000 (UTC)
Received: from berrange.com (unknown [10.44.49.111])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B014E195419F; Tue, 16 Jun 2026 15:56:02 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [RFC 1/7] meson: add --enable-deprecations configure flag
Date: Tue, 16 Jun 2026 16:55:48 +0100
Message-ID: <20260616155554.264412-2-berrange@redhat.com>
In-Reply-To: <20260616155554.264412-1-berrange@redhat.com>
References: <20260616155554.264412-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

A challenge with QEMU is that internal APIs get obsoleted but chasing
down use of old APIs is not as simple as it should be. Introduce a
--enable-deprecations configure flag which expands the macro
"QEMU_DEPRECATIONS" into "G_GNUC_DEPRECATED". This will trigger a
compiler warning for any use of the deprecated APIs.

It would generally be a good idea to disable -Werror when turning on
deprecations otherwise the build will quickly abort.


XXX: possibly add  -Wno-error=deprecated-declarations, so we have
show deprecations by default despite -Werror being on by default.
This would trigger very many warnings but might be worth it if we
want to strongly nudge maintainers to convert existing code. Our
historical approach of "hope" has never worked to eliminate old
code patterns.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 include/qemu/osdep.h          | 19 +++++++++++++++++++
 meson.build                   |  1 +
 meson_options.txt             |  2 ++
 scripts/meson-buildoptions.sh |  3 +++
 4 files changed, 25 insertions(+)

diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index 2f0e61ad6b..99b8f9cbb7 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -447,6 +447,25 @@ void QEMU_ERROR("code path is reachable")
         ((void)0))
 #endif
 
+/*
+ * Tag an internal APIs which should no longer be used
+ * to emit a warning during build if --enable-deprecations
+ * is used with configure. Use of -Werror will trigger
+ * immediate build failure if this is used.
+ */
+#ifdef CONFIG_DEPRECATIONS
+# define QEMU_DEPRECATED G_GNUC_DEPRECATED
+# define QEMU_DEPRECATIONS_OFF \
+    _Pragma("GCC diagnostic push") \
+    _Pragma("GCC diagnostic ignored \"-Wdeprecated-declarations\"")
+# define QEMU_DEPRECATIONS_ON \
+    _Pragma("GCC diagnostic pop")
+#else
+# define QEMU_DEPRECATED
+# define QEMU_DEPRECATIONS_OFF
+# define QEMU_DEPRECATIONS_ON
+#endif
+
 /*
  * Minimum function that returns zero only if both values are zero.
  * Intended for use with unsigned values only.
diff --git a/meson.build b/meson.build
index 19e123423b..9e863aa897 100644
--- a/meson.build
+++ b/meson.build
@@ -2567,6 +2567,7 @@ config_host_data.set('CONFIG_DEBUG_STACK_USAGE', get_option('debug_stack_usage')
 config_host_data.set('CONFIG_DEBUG_TCG', get_option('debug_tcg'))
 config_host_data.set('CONFIG_DEBUG_REMAP', get_option('debug_remap'))
 config_host_data.set('CONFIG_QOM_CAST_DEBUG', get_option('qom_cast_debug'))
+config_host_data.set('CONFIG_DEPRECATIONS', get_option('deprecations'))
 config_host_data.set('CONFIG_REPLICATION', get_option('replication').allowed())
 config_host_data.set('CONFIG_FSFREEZE', qga_fsfreeze)
 config_host_data.set('CONFIG_FSTRIM', qga_fstrim)
diff --git a/meson_options.txt b/meson_options.txt
index a07cb47d35..8f5924422d 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -367,6 +367,8 @@ option('qom_cast_debug', type: 'boolean', value: true,
        description: 'cast debugging support')
 option('slirp_smbd', type : 'feature', value : 'auto',
        description: 'use smbd (at path --smbd=*) in slirp networking')
+option('deprecations', type: 'boolean', value: true,
+       description: 'enable internal API deprecation warnings')
 
 option('qemu_ga_manufacturer', type: 'string', value: 'QEMU',
        description: '"manufacturer" name for qemu-ga registry entries')
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index c003985047..fb57f0610d 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -13,6 +13,7 @@ meson_options_help() {
   printf "%s\n" '  --datadir=VALUE          Data file directory [share]'
   printf "%s\n" '  --disable-coroutine-pool coroutine freelist (better performance)'
   printf "%s\n" '  --disable-debug-info     Enable debug symbols and other information'
+  printf "%s\n" '  --disable-deprecations   enable internal API deprecation warnings'
   printf "%s\n" '  --disable-hexagon-idef-parser'
   printf "%s\n" '                           use idef-parser to automatically generate TCG'
   printf "%s\n" '                           code for the Hexagon frontend'
@@ -306,6 +307,8 @@ _meson_option_parse() {
     --disable-debug-stack-usage) printf "%s" -Ddebug_stack_usage=false ;;
     --enable-debug-tcg) printf "%s" -Ddebug_tcg=true ;;
     --disable-debug-tcg) printf "%s" -Ddebug_tcg=false ;;
+    --enable-deprecations) printf "%s" -Ddeprecations=true ;;
+    --disable-deprecations) printf "%s" -Ddeprecations=false ;;
     --enable-dmg) printf "%s" -Ddmg=enabled ;;
     --disable-dmg) printf "%s" -Ddmg=disabled ;;
     --docdir=*) quote_sh "-Ddocdir=$2" ;;
-- 
2.54.0


