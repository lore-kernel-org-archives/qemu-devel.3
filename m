Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 843A3CD8CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 10:59:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXGcn-00021S-At; Wed, 10 Jun 2026 06:57:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wXGcm-00021K-2j
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 06:57:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wXGck-0003ae-EY
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 06:57:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781089049;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UxZUNvwWAjxJnqiWTST9BHMgAOWqnx0QfSP91jc8058=;
 b=MHcU97rcyBxiInBYg9KSx6nuI8kwFDfZUvKGO68s7aLq6hN0tgQm/fQZpDMSDdqhOEcR70
 PqB9D/fOdSNcZM9rhaq4YklsGDn5FEltZqvwOnMtZxK7jYwebz7QlWzLwrxirOzq6vdP+N
 MoyowVcufxNLfVn/TE0BuxIs8BMfnr8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-523-2aaLgp07NvaqgovLCOqCqg-1; Wed,
 10 Jun 2026 06:57:28 -0400
X-MC-Unique: 2aaLgp07NvaqgovLCOqCqg-1
X-Mimecast-MFC-AGG-ID: 2aaLgp07NvaqgovLCOqCqg_1781089046
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0D9471800615; Wed, 10 Jun 2026 10:57:26 +0000 (UTC)
Received: from localhost (unknown [10.44.24.21])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B44641954B09; Wed, 10 Jun 2026 10:57:24 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 10 Jun 2026 14:56:44 +0400
Subject: [PATCH v2 02/22] ui/hmp: move index_from_key() where it is used
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260610-ui-input-v2-2-f68452dd6a22@redhat.com>
References: <20260610-ui-input-v2-0-f68452dd6a22@redhat.com>
In-Reply-To: <20260610-ui-input-v2-0-f68452dd6a22@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Jan Kiszka <jan.kiszka@web.de>, Peter Maydell <peter.maydell@linaro.org>, 
 qemu-arm@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 qemu-ppc@nongnu.org, Thomas Huth <th.huth+qemu@posteo.eu>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2281;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=wXfw72vTSr4KKaDWsW73dCO4+hZUkFWNWVCR09czORY=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqKUL+r7bLGC8nlmk5+iHMRbDPKnZx9n+IOth13
 XObG2sDyYGJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCailC/gAKCRDa6OEJdZac
 5coNEACvRaIo6JlG9lVvi/nHWYCXYfnK0BEXPawz7LeV1JYZ48lFcTgPphRj2Iue4xYOFKm85p7
 BSMiJYUi7DCRsLASIy3ZX/F8ggdUa0os4GUwWQYqTj2KhF1thcVWYlGfrCkeOxOtN3SuNq9Jnuh
 LMB9RC9ZlbBQSRCzDJGFO53wjdyB9h5f58Culvt/5p3yjXVlxNxVYgVplzTL2j6YQKSy/gCPDGE
 0DQu9EcNxOSJ5+0kYCBBx64epIqTBW9HuIORwu26OX9/E5RsxIz1j02g/lYc329f+sN0kYDYWmd
 0FiMGyoKZ56Sz6gC16IdVAK3nGl4Mww2WxmNYOskBIe9tq0AY/eGc3mG4n84cHbx/CGfGqVM4Bn
 vNbhm1CX2SWZUG1V54QddoClbGdXuhfTwI+SYUlL9VHPCmb4TzJ6N0Q5vGB5PTk4TpW06dPCtm8
 JEbNg6BOmhd4muD3aP23G9ahzY1rf2FVGpfzn4+u291sVV4WlSy1+Se7tFx5bi7DgYgg43TVBuO
 ttAx9ON0EzI058ACPOdHPzkTT/DB51MF7VkBc+BCxpZrdp9NED7PX+pRnPqfkd4H+XF8AVKM/nH
 0DEdvw83ELNZmprQquaDfLkZM6n6aM4oYUDw53qhvvZtTlK/8cQGxwneDRBHW7NPjeDgF3D/YIX
 PfX0BONnCxCmW9g==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/ui/console.h |  3 ---
 ui/input-legacy.c    | 15 ---------------
 ui/ui-hmp-cmds.c     | 15 +++++++++++++++
 3 files changed, 15 insertions(+), 18 deletions(-)

diff --git a/include/ui/console.h b/include/ui/console.h
index a31c5a4995c..3cb78989cd2 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -450,9 +450,6 @@ bool vnc_display_reload_certs(const char *id,  Error **errp);
 bool vnc_display_update(DisplayUpdateOptionsVNC *arg, Error **errp);
 void vnc_cleanup(void);
 
-/* input.c */
-int index_from_key(const char *key, size_t key_length);
-
 #ifdef CONFIG_LINUX
 /* udmabuf.c */
 int udmabuf_fd(void);
diff --git a/ui/input-legacy.c b/ui/input-legacy.c
index 193c9ae2ef9..71b17a3cfc7 100644
--- a/ui/input-legacy.c
+++ b/ui/input-legacy.c
@@ -56,21 +56,6 @@ struct QEMUPutLEDEntry {
 static QTAILQ_HEAD(, QEMUPutLEDEntry) led_handlers =
     QTAILQ_HEAD_INITIALIZER(led_handlers);
 
-int index_from_key(const char *key, size_t key_length)
-{
-    int i;
-
-    for (i = 0; i < Q_KEY_CODE__MAX; i++) {
-        if (!strncmp(key, QKeyCode_str(i), key_length) &&
-            !QKeyCode_str(i)[key_length]) {
-            break;
-        }
-    }
-
-    /* Return Q_KEY_CODE__MAX if the key is invalid */
-    return i;
-}
-
 void qmp_send_key(KeyValueList *keys, bool has_hold_time, int64_t hold_time,
                   Error **errp)
 {
diff --git a/ui/ui-hmp-cmds.c b/ui/ui-hmp-cmds.c
index 1e9bc77bd80..76f5181de43 100644
--- a/ui/ui-hmp-cmds.c
+++ b/ui/ui-hmp-cmds.c
@@ -350,6 +350,21 @@ void hmp_change_vnc(Monitor *mon, const char *device, const char *target,
 }
 #endif
 
+static int index_from_key(const char *key, size_t key_length)
+{
+    int i;
+
+    for (i = 0; i < Q_KEY_CODE__MAX; i++) {
+        if (!strncmp(key, QKeyCode_str(i), key_length) &&
+            !QKeyCode_str(i)[key_length]) {
+            break;
+        }
+    }
+
+    /* Return Q_KEY_CODE__MAX if the key is invalid */
+    return i;
+}
+
 void hmp_sendkey(Monitor *mon, const QDict *qdict)
 {
     const char *keys = qdict_get_str(qdict, "keys");

-- 
2.54.0


