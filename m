Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DA47C5DF81
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 18:03:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwkcT-0004Fo-8a; Wed, 19 Aug 2026 14:02:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wwkcR-0004F0-2c
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 14:02:31 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wwkcO-0007Mq-U5
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 14:02:30 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:3530:0:640:eca4:0])
 by forwardcorp1a.mail.yandex.net (postfix) with ESMTPS id 0FD4CC050A;
 Wed, 19 Aug 2026 21:02:25 +0300 (MSK)
Received: from i115954770.yandex-team.ru (unknown [2a02:6bf:8080:c60::1:5])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id M2bUThDaVKo0-Fb0KcTNd; Wed, 19 Aug 2026 21:02:24 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1787162544;
 bh=lmYi8DtpYsJTeHd6tqjdBZ55BO04Rgs7XTcDuNkcnIc=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=iCBEFoYMXiP5UPty7ZsMW0cPVsT/CnjuRPK1jW7tk+c4TG7rx3feUzcNwvtmi7Dj5
 1tXowvXSMgQBx5I5k8hrG6mYPnBLHGcHYDrzNEzeaJMx/1qZRXxl1OFKilUDczSuLd
 X15JuELGTO5QIdMf93KtkjXf3IjFaA4+2uy/N9HM=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: jasowang@redhat.com,
	mst@redhat.com
Cc: armbru@redhat.com, peterx@redhat.com, farosas@suse.de,
 raphael.s.norwitz@gmail.com, bchaney@akamai.com, vsementsov@yandex-team.ru,
 qemu-devel@nongnu.org, berrange@redhat.com, pbonzini@redhat.com,
 yc-core@yandex-team.ru, mark.caveayland@nutanix.com,
 Jason Wang <jasowangio@gmail.com>
Subject: [PATCH v21 01/16] net/tap: rework tap_parse_script
Date: Wed, 19 Aug 2026 21:01:44 +0300
Message-ID: <20260819180201.1970193-2-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260819180201.1970193-1-vsementsov@yandex-team.ru>
References: <20260819180201.1970193-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
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

Avoid extra copying by simpler code flow: first check for
NULL / empty / "no" cases, then get default or do copying
respectively.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Ben Chaney <bchaney@akamai.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
---
 net/tap.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/net/tap.c b/net/tap.c
index 57ffb09885c..2076f5b7802 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -92,19 +92,35 @@ static void launch_script(const char *setup_script, const char *ifname,
 static void tap_send(void *opaque);
 static void tap_writable(void *opaque);
 
-static char *tap_parse_script(const char *script_arg, const char *default_path)
+static bool tap_is_explicit_no_script(const char *script_arg_value)
 {
-    g_autofree char *res = g_strdup(script_arg);
+    if (!script_arg_value) {
+        return false;
+    }
+
+    if (script_arg_value[0] == '\0') {
+        return true;
+    }
 
-    if (!res) {
-        res = get_relocated_path(default_path);
+    if (strcmp(script_arg_value, "no") == 0) {
+        return true;
     }
 
-    if (res[0] == '\0' || strcmp(res, "no") == 0) {
+    return false;
+}
+
+static char *tap_parse_script(const char *script_arg_value,
+                              const char *default_path)
+{
+    if (tap_is_explicit_no_script(script_arg_value)) {
         return NULL;
     }
 
-    return g_steal_pointer(&res);
+    if (!script_arg_value) {
+        return get_relocated_path(default_path);
+    }
+
+    return g_strdup(script_arg_value);
 }
 
 static void tap_update_fd_handler(TAPState *s)
-- 
2.43.0


