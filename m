Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E243FD78312
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 12:20:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI5Ov-0004Tm-QI; Mon, 02 Dec 2024 07:19:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tI5Or-0004Tb-Qa
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 07:19:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tI5Oq-0001mC-1x
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 07:19:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733141975;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=tk5hRxc9y7ix0gYJc0Qtij9zWZgNXGg8QdC5QTtS2GU=;
 b=JqrnHB7QCFh5/vhqQOD4AK+hWUI6hdQBrS0/66A6irq5aK2aYNs6DiyXpxcj2xl397i8Kz
 XRBb4LzyF+M55tAk5K1Dd6SW3B3328V5C23rFrg4Ov/KvGcoiGRDzPhJVtncGdnMYfthzW
 h/9l43eAUilG/HhMAnOt+upxuguMiak=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-86-4kmEShFjPwaMyl1RG64WeA-1; Mon,
 02 Dec 2024 07:19:34 -0500
X-MC-Unique: 4kmEShFjPwaMyl1RG64WeA-1
X-Mimecast-MFC-AGG-ID: 4kmEShFjPwaMyl1RG64WeA
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 007271954213; Mon,  2 Dec 2024 12:19:33 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.143])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C2CA019560A3; Mon,  2 Dec 2024 12:19:28 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Jo=C3=A3o=20Vila=C3=A7a?= <jvilaca@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH] qga: implement a 'guest-get-load' command
Date: Mon,  2 Dec 2024 12:19:27 +0000
Message-ID: <20241202121927.864335-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Provide a way to report the process load average, via a new
'guest-get-load' command.

This is only implemented for POSIX platforms providing 'getloadavg'.

Example illustrated with qmp-shell:

(QEMU) guest-get-load
{
    "return": {
        "load15m": 1.546875,
        "load1m": 1.669921875,
        "load5m": 1.9306640625
    }
}

Windows has no native equivalent API, but it would be possible to
simulate it as illustrated here (BSD-3-Clause):

  https://github.com/giampaolo/psutil/pull/1485

This is left as an exercise for future contributors.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 meson.build          |  1 +
 qga/commands-posix.c | 20 ++++++++++++++++++++
 qga/qapi-schema.json | 37 +++++++++++++++++++++++++++++++++++++
 3 files changed, 58 insertions(+)

diff --git a/meson.build b/meson.build
index a290dbfa33..9c65e56fff 100644
--- a/meson.build
+++ b/meson.build
@@ -2619,6 +2619,7 @@ config_host_data.set('CONFIG_SETNS', cc.has_function('setns') and cc.has_functio
 config_host_data.set('CONFIG_SYNCFS', cc.has_function('syncfs'))
 config_host_data.set('CONFIG_SYNC_FILE_RANGE', cc.has_function('sync_file_range'))
 config_host_data.set('CONFIG_TIMERFD', cc.has_function('timerfd_create'))
+config_host_data.set('CONFIG_GETLOADAVG', cc.has_function('getloadavg'))
 config_host_data.set('HAVE_COPY_FILE_RANGE', cc.has_function('copy_file_range'))
 config_host_data.set('HAVE_GETIFADDRS', cc.has_function('getifaddrs'))
 config_host_data.set('HAVE_GLIB_WITH_SLICE_ALLOCATOR', glib_has_gslice)
diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index 636307bedf..6e3c15f539 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -1368,3 +1368,23 @@ char *qga_get_host_name(Error **errp)
 
     return g_steal_pointer(&hostname);
 }
+
+#ifdef CONFIG_GETLOADAVG
+GuestLoadAverage *qmp_guest_get_load(Error **errp)
+{
+    double loadavg[3];
+    GuestLoadAverage *ret = NULL;
+
+    if (getloadavg(loadavg, G_N_ELEMENTS(loadavg)) < 0) {
+        error_setg_errno(errp, errno,
+                         "cannot query load average");
+        return NULL;
+    }
+
+    ret = g_new0(GuestLoadAverage, 1);
+    ret->load1m = loadavg[0];
+    ret->load5m = loadavg[1];
+    ret->load15m = loadavg[2];
+    return ret;
+}
+#endif
diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index 0537bb7886..995594aaf4 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -1843,6 +1843,43 @@
   'if': 'CONFIG_LINUX'
 }
 
+
+##
+# @GuestLoadAverage:
+#
+# Statistics about process load information
+#
+# @load1m: 1-minute load avage
+#
+# @load5m: 5-minute load avage
+#
+# @load15m: 15-minute load avage
+#
+# Since: 10.0
+##
+{ 'struct': 'GuestLoadAverage',
+  'data': {
+      'load1m': 'number',
+      'load5m': 'number',
+      'load15m': 'number'
+  },
+  'if': 'CONFIG_GETLOADAVG'
+}
+
+##
+# @guest-get-load:
+#
+# Retrieve CPU process load information
+#
+# Returns: load information
+#
+# Since: 10.0
+##
+{ 'command': 'guest-get-load',
+  'returns': 'GuestLoadAverage',
+  'if': 'CONFIG_GETLOADAVG'
+}
+
 ##
 # @GuestNetworkRoute:
 #
-- 
2.46.0


