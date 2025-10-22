Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8E0CCCD1BB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 11:02:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBWaM-0001Y3-II; Wed, 22 Oct 2025 07:00:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1vBWaI-0001WO-8f
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 07:00:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1vBWaA-0005d2-Cv
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 07:00:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761130840;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/bvTOU0HYOLSAJaQ2Au/rTDDGroYRoRbK9NjFAix4UU=;
 b=IpIO48n4XZuHizGcuDTdIRy0U2FJvykvvYYMZqq8e0b29H7cmAI2VVheYygtkQCPwws8nA
 dvyefwU3daEzU2q+lxqeK8rDXrWTBrCZ4AKZzQ7YFKczDBehBOKXtyo4x+XLvve/5ch41d
 Q6xLmcXKhVLJN2B6X6993AAqv6eGUDM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-112-YhbvZUUOOl6vF_HyeKMIfw-1; Wed,
 22 Oct 2025 07:00:37 -0400
X-MC-Unique: YhbvZUUOOl6vF_HyeKMIfw-1
X-Mimecast-MFC-AGG-ID: YhbvZUUOOl6vF_HyeKMIfw_1761130835
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5275F19560B4; Wed, 22 Oct 2025 11:00:35 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.32.27])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 27601180057E; Wed, 22 Oct 2025 11:00:34 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 2A30018003AA; Wed, 22 Oct 2025 13:00:28 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Eric Blake <eblake@redhat.com>,
 Yanan Wang <wangyanan55@huawei.com>, Eduardo Habkost <eduardo@habkost.net>,
 Fabiano Rosas <farosas@suse.de>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Laurent Vivier <lvivier@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PULL 2/3] hw/uefi: add 'info firmware-log' hmp monitor command.
Date: Wed, 22 Oct 2025 13:00:26 +0200
Message-ID: <20251022110027.441780-3-kraxel@redhat.com>
In-Reply-To: <20251022110027.441780-1-kraxel@redhat.com>
References: <20251022110027.441780-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

This adds the hmp variant of the query-firmware-log qmp command.

Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20251017115006.2696991-3-kraxel@redhat.com>
---
 include/monitor/hmp.h |  1 +
 hw/uefi/ovmf-log.c    | 27 +++++++++++++++++++++++++++
 hmp-commands-info.hx  | 13 +++++++++++++
 3 files changed, 41 insertions(+)

diff --git a/include/monitor/hmp.h b/include/monitor/hmp.h
index 897dfaa2b6d9..83721b5ffc6d 100644
--- a/include/monitor/hmp.h
+++ b/include/monitor/hmp.h
@@ -179,5 +179,6 @@ void hmp_boot_set(Monitor *mon, const QDict *qdict);
 void hmp_info_mtree(Monitor *mon, const QDict *qdict);
 void hmp_info_cryptodev(Monitor *mon, const QDict *qdict);
 void hmp_dumpdtb(Monitor *mon, const QDict *qdict);
+void hmp_info_firmware_log(Monitor *mon, const QDict *qdict);
 
 #endif
diff --git a/hw/uefi/ovmf-log.c b/hw/uefi/ovmf-log.c
index 0d4bd503a06a..fe8acbd19236 100644
--- a/hw/uefi/ovmf-log.c
+++ b/hw/uefi/ovmf-log.c
@@ -231,3 +231,30 @@ FirmwareLog *qmp_query_firmware_log(Error **errp)
     ret->log = g_base64_encode((const guchar *)log->str, log->len);
     return ret;
 }
+
+void hmp_info_firmware_log(Monitor *mon, const QDict *qdict)
+{
+    g_autofree gchar *log_esc = NULL;
+    g_autofree guchar *log_out = NULL;
+    Error *err = NULL;
+    FirmwareLog *log;
+    gsize log_len;
+
+    log = qmp_query_firmware_log(&err);
+    if (err)  {
+        hmp_handle_error(mon, err);
+        return;
+    }
+
+    g_assert(log != NULL);
+    g_assert(log->log != NULL);
+
+    if (log->version) {
+        g_autofree gchar *esc = g_strescape(log->version, NULL);
+        monitor_printf(mon, "[ firmware version: %s ]\n", esc);
+    }
+
+    log_out = g_base64_decode(log->log, &log_len);
+    log_esc = g_strescape((gchar *)log_out, "\r\n");
+    monitor_printf(mon, "%s\n", log_esc);
+}
diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index 25b4aed51f56..33cf740bbc1b 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -995,3 +995,16 @@ SRST
   ``info cryptodev``
     Show the crypto devices.
 ERST
+
+    {
+        .name       = "firmware-log",
+        .args_type  = "",
+        .params     = "",
+        .help       = "show the firmware (ovmf) debug log",
+        .cmd        = hmp_info_firmware_log,
+    },
+
+SRST
+  ``info firmware-log``
+    Show the firmware (ovmf) debug log.
+ERST
-- 
2.51.0


