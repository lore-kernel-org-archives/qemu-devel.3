Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5C0ECCD18E
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 12:08:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v90Hp-0008S0-Ec; Wed, 15 Oct 2025 08:07:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1v90HZ-0008PU-RR
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 08:07:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1v90HL-0000pt-Qt
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 08:06:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760530009;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LgbFaW8vLPi3zPYE6NLuMJI4frlYsZtoPPMGkbeG+W4=;
 b=ifMmKeQgWFE5lAI8aEztCardw718I/cpNZD31bnXjpU/4t/vdrotfyynedrP1iP8D4AGGi
 q0kQg1QGN+AMfeq95wJ63vs7uu9EyB/COl6Ni5NxoSUTulLkDzlRdsBsuSAIAlzepB+lDO
 2WpJM5iS+lahJgfwO1C/qmmK6ZrdY00=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-605-hr3EUWCmMN2RSssN9c-EGw-1; Wed,
 15 Oct 2025 08:06:46 -0400
X-MC-Unique: hr3EUWCmMN2RSssN9c-EGw-1
X-Mimecast-MFC-AGG-ID: hr3EUWCmMN2RSssN9c-EGw_1760530005
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B75DD1956094; Wed, 15 Oct 2025 12:06:44 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.32.27])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CC38419560AD; Wed, 15 Oct 2025 12:06:43 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id D0281180099A; Wed, 15 Oct 2025 14:06:37 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Yanan Wang <wangyanan55@huawei.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH v5 2/3] hw/uefi: add 'info firmware-log' hmp monitor command.
Date: Wed, 15 Oct 2025 14:06:36 +0200
Message-ID: <20251015120637.1736402-3-kraxel@redhat.com>
In-Reply-To: <20251015120637.1736402-1-kraxel@redhat.com>
References: <20251015120637.1736402-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/uefi/ovmf-log.c   | 27 +++++++++++++++++++++++++++
 hmp-commands-info.hx | 13 +++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/hw/uefi/ovmf-log.c b/hw/uefi/ovmf-log.c
index 85dda15ab6ad..e281a980a101 100644
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
index eaaa880c1b30..f0aef419923c 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -990,3 +990,16 @@ SRST
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


