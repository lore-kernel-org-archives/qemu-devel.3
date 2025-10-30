Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CEF4CCF9FE
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 16:43:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEVhs-0008PV-G1; Thu, 30 Oct 2025 12:41:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vEVhj-00087d-5b
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 12:40:52 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vEVhS-0003GX-2N
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 12:40:49 -0400
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:65a0:0:640:e1de:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 4F04180B33;
 Thu, 30 Oct 2025 19:40:28 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:861::1:2b])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id OeiSuH0Fn4Y0-gYhFg3Cr; Thu, 30 Oct 2025 19:40:27 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1761842427;
 bh=TCjKToxw4+lOF11qKeuTQAB3HUw2mNv+VqvMxrCYR10=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=dpGFL/1el1cskG+FODj/IcHUKDYJpojZlqW8wFwiTf2hXO1GsAcw9joWCWhyeP91w
 4/yYOwtcONhEyJoP8ag/HPnW1HwBOzgrAZCrRDpWqV2jHwJ//7l7H1qdkaB4uN+TMu
 UT4KfSdOCGAxSaOfEaZCUEMOM9A8qeDgFPTiVdHQ=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: jasowang@redhat.com
Cc: qemu-devel@nongnu.org, vsementsov@yandex-team.ru, leiyang@redhat.com,
 davydov-max@yandex-team.ru, yc-core@yandex-team.ru
Subject: [PATCH v9 4/7] net/tap: rework scripts handling
Date: Thu, 30 Oct 2025 19:40:20 +0300
Message-ID: <20251030164023.710048-5-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251030164023.710048-1-vsementsov@yandex-team.ru>
References: <20251030164023.710048-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

Simplify handling scripts: parse all these "no" and '\0' once, and
then keep simpler logic for net_tap_open() and net_init_tap_one(): NULL
means no script to run, otherwise run script.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Maksim Davydov <davydov-max@yandex-team.ru>
---
 net/tap.c | 46 ++++++++++++++++++++++++++--------------------
 1 file changed, 26 insertions(+), 20 deletions(-)

diff --git a/net/tap.c b/net/tap.c
index 5c6b9399e0..017c184933 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -91,6 +91,21 @@ static void launch_script(const char *setup_script, const char *ifname,
 static void tap_send(void *opaque);
 static void tap_writable(void *opaque);
 
+static char *tap_parse_script(const char *script_arg, const char *default_path)
+{
+    g_autofree char *res = g_strdup(script_arg);
+
+    if (!res) {
+        res = get_relocated_path(default_path);
+    }
+
+    if (res[0] == '\0' || strcmp(res, "no") == 0) {
+        return NULL;
+    }
+
+    return g_steal_pointer(&res);
+}
+
 static void tap_update_fd_handler(TAPState *s)
 {
     qemu_set_fd_handler(s->fd,
@@ -676,9 +691,7 @@ static int net_tap_init(const NetdevTapOptions *tap, int *vnet_hdr,
         return -1;
     }
 
-    if (setup_script &&
-        setup_script[0] != '\0' &&
-        strcmp(setup_script, "no") != 0) {
+    if (setup_script) {
         launch_script(setup_script, ifname, fd, &err);
         if (err) {
             error_propagate(errp, err);
@@ -714,9 +727,9 @@ static void net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
         qemu_set_info_str(&s->nc, "helper=%s", tap->helper);
     } else {
         qemu_set_info_str(&s->nc, "ifname=%s,script=%s,downscript=%s", ifname,
-                          script, downscript);
+                          script ?: "no", downscript ?: "no");
 
-        if (strcmp(downscript, "no") != 0) {
+        if (downscript) {
             snprintf(s->down_script, sizeof(s->down_script), "%s", downscript);
             snprintf(s->down_script_arg, sizeof(s->down_script_arg),
                      "%s", ifname);
@@ -971,23 +984,16 @@ free_fail:
             return -1;
         }
     } else {
-        const char *script = tap->script;
-        const char *downscript = tap->downscript;
-        g_autofree char *default_script = NULL;
-        g_autofree char *default_downscript = NULL;
+        g_autofree char *script =
+            tap_parse_script(tap->script, DEFAULT_NETWORK_SCRIPT);
+        g_autofree char *downscript =
+            tap_parse_script(tap->downscript, DEFAULT_NETWORK_DOWN_SCRIPT);
+
         if (tap->vhostfds) {
             error_setg(errp, "vhostfds= is invalid if fds= wasn't specified");
             return -1;
         }
 
-        if (!script) {
-            script = default_script = get_relocated_path(DEFAULT_NETWORK_SCRIPT);
-        }
-        if (!downscript) {
-            downscript = default_downscript =
-                                 get_relocated_path(DEFAULT_NETWORK_DOWN_SCRIPT);
-        }
-
         if (tap->ifname) {
             pstrcpy(ifname, sizeof ifname, tap->ifname);
         } else {
@@ -995,7 +1001,7 @@ free_fail:
         }
 
         for (i = 0; i < queues; i++) {
-            fd = net_tap_init(tap, &vnet_hdr, i >= 1 ? "no" : script,
+            fd = net_tap_init(tap, &vnet_hdr, i >= 1 ? NULL : script,
                               ifname, sizeof ifname, queues > 1, errp);
             if (fd == -1) {
                 return -1;
@@ -1010,8 +1016,8 @@ free_fail:
             }
 
             net_init_tap_one(tap, peer, "tap", name, ifname,
-                             i >= 1 ? "no" : script,
-                             i >= 1 ? "no" : downscript,
+                             i >= 1 ? NULL : script,
+                             i >= 1 ? NULL : downscript,
                              vhostfdname, vnet_hdr, fd, &err);
             if (err) {
                 error_propagate(errp, err);
-- 
2.48.1


