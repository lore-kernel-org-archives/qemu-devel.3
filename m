Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C40BCE7BD88
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 10:31:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrvrs-0005xU-4l; Mon, 16 Feb 2026 05:30:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1vrvrj-0005wQ-Rp
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 05:30:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1vrvrf-0006hB-Rh
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 05:30:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771237802;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hQ5tRuWYImee0j/eSuZeoovu/KfdCpgO6d8EXV9epJA=;
 b=bYxmzcVleyqEtyQ9Izoc8fxlmJrOaW4bOmwHmYTMmOHrk7+T4YinL2FK66/amUU/4ojeRN
 XSpPGtpdLMLR4wnQ8kNq3C7CxjO/wMKWP5YgJ+ieAUS6cUKnp7yk3SeqvM+3ppVbJoyF37
 dnndSRLxirMBD7P6hOOmalCfKfO2MBE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-426-2KfgfwZ5Mt2p6a2K1rirQQ-1; Mon,
 16 Feb 2026 05:29:58 -0500
X-MC-Unique: 2KfgfwZ5Mt2p6a2K1rirQQ-1
X-Mimecast-MFC-AGG-ID: 2KfgfwZ5Mt2p6a2K1rirQQ_1771237797
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 465F518004AD; Mon, 16 Feb 2026 10:29:57 +0000 (UTC)
Received: from srv1.redhat.com (unknown [10.44.32.156])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F2DFC1800669; Mon, 16 Feb 2026 10:29:55 +0000 (UTC)
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 1/5] qga/vss-win32: Fix ConvertStringToBSTR redefinition with
 newer MinGW
Date: Mon, 16 Feb 2026 12:29:47 +0200
Message-ID: <20260216102951.150381-2-kkostiuk@redhat.com>
In-Reply-To: <20260216102951.150381-1-kkostiuk@redhat.com>
References: <20260216102951.150381-1-kkostiuk@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Nguyen Dinh Phi <phind.uet@gmail.com>

Newer versions of MinGW-w64 provide ConvertStringToBSTR() in the
_com_util namespace via <comutil.h>. This causes a redefinition
error when building qemu-ga on Windows with these toolchains.

Add a meson check to detect whether ConvertStringToBSTR is already
available, and conditionally compile our fallback implementation
only when the system does not provide one.

Signed-off-by: Nguyen Dinh Phi <phind.uet@gmail.com>
Suggested-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20251218085446.462827-2-phind.uet@gmail.com
Signed-off-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
---
 meson.build               | 12 ++++++++++++
 qga/vss-win32/install.cpp |  2 ++
 2 files changed, 14 insertions(+)

diff --git a/meson.build b/meson.build
index 8ad37c992b..47e46c1d9f 100644
--- a/meson.build
+++ b/meson.build
@@ -3299,6 +3299,18 @@ endif
 # Detect host pointer size for the target configuration loop.
 host_long_bits = cc.sizeof('void *') * 8
 
+# Detect if ConvertStringToBSTR has been defined in _com_util namespace
+if host_os == 'windows'
+  has_convert_string_to_bstr = cxx.links('''
+    #include <comutil.h>
+    int main() {
+        BSTR b = _com_util::ConvertStringToBSTR("test");
+        return b ? 0 : 1;
+    }
+  ''')
+  config_host_data.set('CONFIG_CONVERT_STRING_TO_BSTR', has_convert_string_to_bstr)
+endif
+
 ########################
 # Target configuration #
 ########################
diff --git a/qga/vss-win32/install.cpp b/qga/vss-win32/install.cpp
index 7b25d9098b..5b7a8e9bc5 100644
--- a/qga/vss-win32/install.cpp
+++ b/qga/vss-win32/install.cpp
@@ -549,6 +549,7 @@ STDAPI DllUnregisterServer(void)
 
 
 /* Support function to convert ASCII string into BSTR (used in _bstr_t) */
+#ifndef CONFIG_CONVERT_STRING_TO_BSTR
 namespace _com_util
 {
     BSTR WINAPI ConvertStringToBSTR(const char *ascii) {
@@ -566,6 +567,7 @@ namespace _com_util
         return bstr;
     }
 }
+#endif
 
 /* Stop QGA VSS provider service using Winsvc API  */
 STDAPI StopService(void)
-- 
2.52.0


