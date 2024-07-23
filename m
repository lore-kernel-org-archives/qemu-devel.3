Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79EB1C3DA63
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 07:07:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sW9YO-0005R8-5b; Tue, 23 Jul 2024 03:03:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1sW9YM-0005Jd-0F
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 03:03:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1sW9YJ-0000lT-Jc
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 03:03:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721718193;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fsFctriPjulis0ViEAAWZ3KaE88OpbmJCQXuzFRclJA=;
 b=OsqWxVRw3SxMLOvAksApANGYcYJs5qPIhJr6EtYt3ct9Qyv6jtW9IgQX1W0R3IEB/2VRwV
 Jst9YpI35sltyr6jLOGEPIAU9O34VGDLDYZa5zOYlHl99emxJ4KdKMw+jo8x/6Nub+fZqS
 UJNHqWat0+P4gl8iZbCIjul5FdE5r3Q=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-126-S9vnoBxyNzulbX74_h2eyA-1; Tue,
 23 Jul 2024 03:03:11 -0400
X-MC-Unique: S9vnoBxyNzulbX74_h2eyA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EF3EC1955D42; Tue, 23 Jul 2024 07:03:10 +0000 (UTC)
Received: from srv1.redhat.com (unknown [10.45.224.211])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8FC883000194; Tue, 23 Jul 2024 07:03:09 +0000 (UTC)
From: Konstantin Kostiuk <kkostiuk@redhat.com>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL v2 07/25] qga: move CONFIG_FSFREEZE/TRIM to be meson defined
 options
Date: Tue, 23 Jul 2024 10:02:33 +0300
Message-ID: <20240723070251.25575-8-kkostiuk@redhat.com>
In-Reply-To: <20240723070251.25575-1-kkostiuk@redhat.com>
References: <20240723070251.25575-1-kkostiuk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Daniel P. Berrangé <berrange@redhat.com>

Defining these at the meson level allows them to be used a conditional
tests in the QAPI schemas.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Konstantin Kostiuk <kkostiuk@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240712132459.3974109-8-berrange@redhat.com>
Signed-off-by: Konstantin Kostiuk <kkostiuk@redhat.com>
---
 meson.build           | 15 +++++++++++++++
 qga/commands-common.h |  9 ---------
 2 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/meson.build b/meson.build
index a1e51277b0..83f9728524 100644
--- a/meson.build
+++ b/meson.build
@@ -2187,6 +2187,19 @@ have_virtfs_proxy_helper = get_option('virtfs_proxy_helper') \
     .require(libcap_ng.found(), error_message: 'the virtfs proxy helper requires libcap-ng') \
     .allowed()
 
+qga_fsfreeze = false
+qga_fstrim = false
+if host_os == 'linux'
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
@@ -2423,6 +2436,8 @@ config_host_data.set('CONFIG_DEBUG_TCG', get_option('debug_tcg'))
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
2.45.2


