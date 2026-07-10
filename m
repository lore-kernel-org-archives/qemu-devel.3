Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74D33C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 19:18:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiGjw-0000fA-EW; Fri, 10 Jul 2026 15:18:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wiGju-0000ea-D0
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 15:18:22 -0400
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wiGjr-00054M-VC
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 15:18:22 -0400
Received: from mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:94a9:0:640:a3fa:0])
 by forwardcorp1d.mail.yandex.net (postfix) with ESMTPS id F027280898;
 Fri, 10 Jul 2026 22:18:16 +0300 (MSK)
Received: from i115954770.yandex-team.ru (unknown [2a02:6bf:8080:c7d::1:20])
 by mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id AIRXsO0a8eA0-75QvDYpY; Fri, 10 Jul 2026 22:18:16 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1783711096;
 bh=mJdkRWSOhzq8wvcrtU+0pBu22CGS5GmslG9eOtXQXn4=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=fmOnku1yfkLX7RvNNxAvslUm7qZPdWKkzJEQ8Cm+sv35Deiy5I7WfL6crXFIZNtNq
 uLniD0PmmoDd72kZZGKXOs1HVSx7NXV7aEaElQ/L6VyuvNX1u6N7Vm9xRAjdIiftA+
 BwoQN/kCxWW4M3QH/zF3mMPfFAGLCKgTw7U834s4=
Authentication-Results: mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: jasowang@redhat.com,
	mst@redhat.com
Cc: armbru@redhat.com, peterx@redhat.com, farosas@suse.de,
 raphael.s.norwitz@gmail.com, bchaney@akamai.com, vsementsov@yandex-team.ru,
 qemu-devel@nongnu.org, berrange@redhat.com, pbonzini@redhat.com,
 yc-core@yandex-team.ru, mark.caveayland@nutanix.com,
 Jason Wang <jasowangio@gmail.com>
Subject: [PATCH v18 01/14] net/tap: rework tap_parse_script
Date: Fri, 10 Jul 2026 22:17:50 +0300
Message-ID: <20260710191809.721154-2-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260710191809.721154-1-vsementsov@yandex-team.ru>
References: <20260710191809.721154-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c41:1300:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

Factor out tap_is_explicit_no_script() helper, to simplify
further changes.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 net/tap.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/net/tap.c b/net/tap.c
index 57ffb09885c..fedd48c48d2 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -92,19 +92,34 @@ static void launch_script(const char *setup_script, const char *ifname,
 static void tap_send(void *opaque);
 static void tap_writable(void *opaque);
 
-static char *tap_parse_script(const char *script_arg, const char *default_path)
+static bool tap_is_explicit_no_script(const char *script_arg)
 {
-    g_autofree char *res = g_strdup(script_arg);
+    if (!script_arg) {
+        return false;
+    }
 
-    if (!res) {
-        res = get_relocated_path(default_path);
+    if (script_arg[0] == '\0') {
+        return true;
+    }
+
+    if (strcmp(script_arg, "no") == 0) {
+        return true;
     }
 
-    if (res[0] == '\0' || strcmp(res, "no") == 0) {
+    return false;
+}
+
+static char *tap_parse_script(const char *script_arg, const char *default_path)
+{
+    if (tap_is_explicit_no_script(script_arg)) {
         return NULL;
     }
 
-    return g_steal_pointer(&res);
+    if (!script_arg) {
+        return get_relocated_path(default_path);
+    }
+
+    return g_strdup(script_arg);
 }
 
 static void tap_update_fd_handler(TAPState *s)
-- 
2.43.0


