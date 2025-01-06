Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C246E77198
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2025 11:39:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tUlRI-0008RP-BJ; Mon, 06 Jan 2025 06:38:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1tUlRG-0008Qj-1K
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 06:38:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1tUlRD-0004An-Hz
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 06:38:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736163506;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y/8FGt2b8NTyWtHS7Xmn4hSoTFXKsJOG7DIbzFlLOFg=;
 b=Rk+t8vU9NWHiBzeukp0fiiO+miXM0bWoc8S7hSa5UB/o2pn1VIcv8o3nFQ2rUhKLFOvj9v
 tW018LBE/vxVYx2vLausSd0jhlE6Y9o6zzatM3x+cFUet2HpsuiZgVo5r8KVdHq12vK37/
 g24xhzb4IPDJdESh/Z8DIpnniLnJbtQ=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-136-Su8pW4w3NJeuMH90DZKvkQ-1; Mon,
 06 Jan 2025 06:38:22 -0500
X-MC-Unique: Su8pW4w3NJeuMH90DZKvkQ-1
X-Mimecast-MFC-AGG-ID: Su8pW4w3NJeuMH90DZKvkQ
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8AFEA19560AD; Mon,  6 Jan 2025 11:38:21 +0000 (UTC)
Received: from srv1.redhat.com (unknown [10.45.224.221])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3B2803000197; Mon,  6 Jan 2025 11:38:19 +0000 (UTC)
From: Konstantin Kostiuk <kkostiuk@redhat.com>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 1/2] qga: implement a 'guest-get-load' command
Date: Mon,  6 Jan 2025 13:38:13 +0200
Message-ID: <20250106113814.35459-2-kkostiuk@redhat.com>
In-Reply-To: <20250106113814.35459-1-kkostiuk@redhat.com>
References: <20250106113814.35459-1-kkostiuk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.446,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Reviewed-by: Konstantin Kostiuk <kkostiuk@redhat.com>
Message-ID: <20241202121927.864335-1-berrange@redhat.com>
Signed-off-by: Konstantin Kostiuk <kkostiuk@redhat.com>
---
 meson.build          |  1 +
 qga/commands-posix.c | 20 ++++++++++++++++++++
 qga/qapi-schema.json | 37 +++++++++++++++++++++++++++++++++++++
 3 files changed, 58 insertions(+)

diff --git a/meson.build b/meson.build
index e62251c7ca..d06f59095c 100644
--- a/meson.build
+++ b/meson.build
@@ -2646,6 +2646,7 @@ config_host_data.set('CONFIG_SETNS', cc.has_function('setns') and cc.has_functio
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
2.47.1


