Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B351C27C50
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 13:50:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEUY6-00063p-3L; Tue, 04 Jun 2024 09:50:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sEUY3-0005ya-Sw
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 09:50:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sEUY1-0002mt-4o
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 09:49:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717508996;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VTs1CazDuYQYyqNg17yZkKnnH71hmdmUVDNxDCO95G8=;
 b=Jok0UYgwWMXc4YZaJ6KqH/6+ggs7IISSO6E29amsx139wtBNrS72fhw3g68QErAETCqizs
 EjgAEIiAJDyX01OAPAlkzM8lcXXu3elD8NGkt/9C98VbFoMoyV5oij5xHtmhQxWyyD31pg
 XbP+reCbmWvKOXYASuPZ5RJtDwPaSgY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-5-xtDvPf1jOh2icgWwWTMlXQ-1; Tue, 04 Jun 2024 09:49:52 -0400
X-MC-Unique: xtDvPf1jOh2icgWwWTMlXQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 90A8F101A521;
 Tue,  4 Jun 2024 13:49:52 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.39.194.137])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DF9C6C15C46;
 Tue,  4 Jun 2024 13:49:50 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Konstantin Kostiuk <kkostiuk@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 07/20] qga: move CONFIG_FSFREEZE/TRIM to be meson defined
 options
Date: Tue,  4 Jun 2024 14:49:20 +0100
Message-ID: <20240604134933.220112-8-berrange@redhat.com>
In-Reply-To: <20240604134933.220112-1-berrange@redhat.com>
References: <20240604134933.220112-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Defining these at the meson level allows them to be used a conditional
tests in the QAPI schemas.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 meson.build           | 18 ++++++++++++++++++
 qga/commands-common.h |  9 ---------
 2 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/meson.build b/meson.build
index 6386607144..356b2a4817 100644
--- a/meson.build
+++ b/meson.build
@@ -2141,6 +2141,22 @@ have_virtfs_proxy_helper = get_option('virtfs_proxy_helper') \
     .require(libcap_ng.found(), error_message: 'the virtfs proxy helper requires libcap-ng') \
     .allowed()
 
+qga_fsfreeze = false
+qga_fstrim = false
+if host_os == 'windows'
+    qga_fsfreeze = true
+    qga_fstrim = true
+elif host_os == 'linux'
+    if cc.has_header_symbol('linux/fs.h', 'FIFREEZE')
+        qga_fsfreeze = true
+    endif
+    if cc.has_header_symbol('linux/fs.h', 'FITRIM')
+        qga_fstrim = true
+    endif
+elif host_os == 'freebsd' and cc.has_header_symbol('ufs/ffs/fs.h', 'UFSSUSPEND')
+    qga_fsfreeze = true
+endif
+
 if get_option('block_drv_ro_whitelist') == ''
   config_host_data.set('CONFIG_BDRV_RO_WHITELIST', '')
 else
@@ -2375,6 +2391,8 @@ config_host_data.set('CONFIG_DEBUG_TCG', get_option('debug_tcg'))
 config_host_data.set('CONFIG_DEBUG_REMAP', get_option('debug_remap'))
 config_host_data.set('CONFIG_QOM_CAST_DEBUG', get_option('qom_cast_debug'))
 config_host_data.set('CONFIG_REPLICATION', get_option('replication').allowed())
+config_host_data.set('CONFIG_FSFREEZE', qga_fsfreeze)
+config_host_data.set('CONFIG_FSTRIM', qga_fstrim)
 
 # has_header
 config_host_data.set('CONFIG_EPOLL', cc.has_header('sys/epoll.h'))
diff --git a/qga/commands-common.h b/qga/commands-common.h
index 8c1c56aac9..263e7c0525 100644
--- a/qga/commands-common.h
+++ b/qga/commands-common.h
@@ -15,19 +15,10 @@
 
 #if defined(__linux__)
 #include <linux/fs.h>
-#ifdef FIFREEZE
-#define CONFIG_FSFREEZE
-#endif
-#ifdef FITRIM
-#define CONFIG_FSTRIM
-#endif
 #endif /* __linux__ */
 
 #ifdef __FreeBSD__
 #include <ufs/ffs/fs.h>
-#ifdef UFSSUSPEND
-#define CONFIG_FSFREEZE
-#endif
 #endif /* __FreeBSD__ */
 
 #if defined(CONFIG_FSFREEZE) || defined(CONFIG_FSTRIM)
-- 
2.45.1


