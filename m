Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4708AFB3CE4
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 09:13:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w78gk-0000pv-RE; Mon, 30 Mar 2026 05:13:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhaoguohan@kylinos.cn>)
 id 1w78gd-0000pj-6C
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 05:13:31 -0400
Received: from mailgw.kylinos.cn ([124.126.103.232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhaoguohan@kylinos.cn>)
 id 1w78ga-0000ZF-AI
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 05:13:30 -0400
X-UUID: add6b3fe2c1811f1aa26b74ffac11d73-20260330
X-CTIC-Tags: HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME,
 HR_CHARSET
 HR_CHARSET_NUM, HR_CTE_8B, HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD
 HR_DATE_ZONE, HR_FROM_NAME, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER
 HR_SJ_NOR_SYM, HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_CHARSET
 HR_TO_CHARSET_NUM, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NAME, IP_UNTRUSTED
 SRC_UNTRUSTED, IP_UNFAMILIAR, SRC_UNFAMILIAR, DN_TRUSTED, SRC_TRUSTED
 SA_UNTRUSTED, SA_UNFAMILIAR, SN_UNTRUSTED, SN_UNFAMILIAR, SPF_NOPASS
 DKIM_NOPASS, DMARC_NOPASS, CIE_BAD, CIE_GOOD_SPF, CIE_UNKNOWN
 GTI_FG_BS, GTI_RG_INFO, GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:ca25847d-d120-4f72-adb3-28f6318e4311, IP:20,
 URL:0,TC:0,Content:0,EDM:25,RT:0,SF:-30,FILE:0,BULK:0,RULE:Release_Ham,ACT
 ION:release,TS:15
X-CID-INFO: VERSION:1.3.12, REQID:ca25847d-d120-4f72-adb3-28f6318e4311, IP:20,
 UR
 L:0,TC:0,Content:0,EDM:25,RT:0,SF:-30,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
 N:release,TS:15
X-CID-META: VersionHash:e7bac3a, CLOUDID:00b8241301bc45c5596a823cd13bd3ed,
 BulkI
 D:260330171315FTVQK6K5,BulkQuantity:0,Recheck:0,SF:10|66|78|102|127|898,TC
 :nil,Content:0|15|50,EDM:5,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC
 :nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: add6b3fe2c1811f1aa26b74ffac11d73-20260330
X-User: zhaoguohan@kylinos.cn
Received: from zgh-vmware-virtual-platform.localdomain [(120.228.139.31)] by
 mailgw.kylinos.cn (envelope-from <zhaoguohan@kylinos.cn>)
 (Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
 with ESMTP id 1730295258; Mon, 30 Mar 2026 17:13:13 +0800
From: GuoHan Zhao <zhaoguohan@kylinos.cn>
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org,
	GuoHan Zhao <zhaoguohan@kylinos.cn>
Subject: [PATCH] ui/dbus: tear down clipboard callbacks on display finalize
Date: Mon, 30 Mar 2026 17:13:10 +0800
Message-ID: <20260330091310.42868-1-zhaoguohan@kylinos.cn>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=124.126.103.232;
 envelope-from=zhaoguohan@kylinos.cn; helo=mailgw.kylinos.cn
X-Spam_score_int: 1
X-Spam_score: 0.1
X-Spam_bar: /
X-Spam_report: (0.1 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=no autolearn_force=no
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

The clipboard D-Bus teardown path currently runs when the peer
disappears, but not when DBusDisplay itself is finalized.

That leaves pending clipboard requests and signal handlers associated
with the clipboard proxy active past display teardown.

Add an explicit clipboard fini hook and invoke it from
dbus_display_finalize() so the clipboard teardown also runs during
display destruction.

Fixes: ff1a5810f61f ("ui/dbus: add clipboard interface")
Signed-off-by: GuoHan Zhao <zhaoguohan@kylinos.cn>
---
 ui/dbus-clipboard.c | 14 ++++++++++++++
 ui/dbus.c           |  1 +
 ui/dbus.h           |  1 +
 3 files changed, 16 insertions(+)

diff --git a/ui/dbus-clipboard.c b/ui/dbus-clipboard.c
index 6787a7766877..4a01901e291b 100644
--- a/ui/dbus-clipboard.c
+++ b/ui/dbus-clipboard.c
@@ -191,6 +191,7 @@ static void
 dbus_clipboard_unregister_proxy(DBusDisplay *dpy)
 {
     const char *name = NULL;
+    GDBusConnection *connection = NULL;
     int i;
 
     for (i = 0; i < G_N_ELEMENTS(dpy->clipboard_request); ++i) {
@@ -201,6 +202,13 @@ dbus_clipboard_unregister_proxy(DBusDisplay *dpy)
         return;
     }
 
+    connection = g_dbus_proxy_get_connection(
+        G_DBUS_PROXY(dpy->clipboard_proxy));
+    if (connection) {
+        g_signal_handlers_disconnect_by_data(connection, dpy);
+    }
+    g_signal_handlers_disconnect_by_data(dpy->clipboard_proxy, dpy);
+
     name = g_dbus_proxy_get_name(G_DBUS_PROXY(dpy->clipboard_proxy));
     trace_dbus_clipboard_unregister(name);
     g_clear_object(&dpy->clipboard_proxy);
@@ -425,6 +433,12 @@ dbus_clipboard_request(
     return DBUS_METHOD_INVOCATION_HANDLED;
 }
 
+void
+dbus_clipboard_fini(DBusDisplay *dpy)
+{
+    dbus_clipboard_unregister_proxy(dpy);
+}
+
 void
 dbus_clipboard_init(DBusDisplay *dpy)
 {
diff --git a/ui/dbus.c b/ui/dbus.c
index 4f24215555a4..be291f220ecd 100644
--- a/ui/dbus.c
+++ b/ui/dbus.c
@@ -145,6 +145,7 @@ dbus_display_finalize(Object *o)
         dbus_display_notifier_remove(&dd->notifier);
     }
 
+    dbus_clipboard_fini(dd);
     qemu_clipboard_peer_unregister(&dd->clipboard_peer);
     g_clear_object(&dd->clipboard);
 
diff --git a/ui/dbus.h b/ui/dbus.h
index 1e8c24a48e32..986d77746017 100644
--- a/ui/dbus.h
+++ b/ui/dbus.h
@@ -150,5 +150,6 @@ void dbus_display_notify(DBusDisplayEvent *event);
 void dbus_chardev_init(DBusDisplay *dpy);
 
 void dbus_clipboard_init(DBusDisplay *dpy);
+void dbus_clipboard_fini(DBusDisplay *dpy);
 
 #endif /* UI_DBUS_H */
-- 
2.43.0


