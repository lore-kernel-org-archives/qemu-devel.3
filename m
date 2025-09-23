Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87EC2CAC5B0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 10:06:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0zq3-0002ll-Oo; Tue, 23 Sep 2025 06:01:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v0zpx-0002hc-15
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 06:01:29 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v0zpo-0000tA-3m
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 06:01:27 -0400
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:cf2d:0:640:140f:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 0BD71804E6;
 Tue, 23 Sep 2025 13:01:16 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:b38::1:12])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id C1Ug0C0Fha60-BoofPur5; Tue, 23 Sep 2025 13:01:15 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1758621675;
 bh=J+j4+PwNItZRsNYaJicaECJgV/GseY0I8xoBomuNEiM=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=K36wfHG0809HVU1qMdDxfNFTMjt+pPwMtpelArzq2hmsaT+xxwXczHlyhVd7qwhgY
 RSqCtpFcwJqllCDvaDwb0hPOvlvZLPfgKre/bz6bbr0qgfUbgh7j91rW2uCcp17FO8
 PT4V2HEIEM2hcloDIIkFaMmVb9X7LEsx/WENJHIM=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: mst@redhat.com
Cc: qemu-devel@nongnu.org, philmd@linaro.org, thuth@redhat.com,
 eblake@redhat.com, michael.roth@amd.com, armbru@redhat.com,
 farosas@suse.de, peterx@redhat.com, berrange@redhat.com,
 jasowang@redhat.com, steven.sistare@oracle.com, leiyang@redhat.com,
 davydov-max@yandex-team.ru, yc-core@yandex-team.ru,
 vsementsov@yandex-team.ru
Subject: [PATCH v6 05/19] net/tap: rework scripts handling
Date: Tue, 23 Sep 2025 13:00:56 +0300
Message-ID: <20250923100110.70862-6-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250923100110.70862-1-vsementsov@yandex-team.ru>
References: <20250923100110.70862-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
---
 net/tap.c | 45 +++++++++++++++++++++++++--------------------
 1 file changed, 25 insertions(+), 20 deletions(-)

diff --git a/net/tap.c b/net/tap.c
index e42c7ca044..084ee4f649 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -88,6 +88,21 @@ static void launch_script(const char *setup_script, const char *ifname,
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
@@ -655,9 +670,7 @@ static int net_tap_open(int *vnet_hdr, bool vnet_hdr_required,
         return -1;
     }
 
-    if (setup_script &&
-        setup_script[0] != '\0' &&
-        strcmp(setup_script, "no") != 0) {
+    if (setup_script) {
         launch_script(setup_script, ifname, fd, &err);
         if (err) {
             error_propagate(errp, err);
@@ -693,9 +706,9 @@ static void net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
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
@@ -950,10 +963,10 @@ free_fail:
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
+            tap_parse_script(tap->script, DEFAULT_NETWORK_DOWN_SCRIPT);
         bool vnet_hdr_required = tap->has_vnet_hdr && tap->vnet_hdr;
 
         if (tap->vhostfds) {
@@ -961,14 +974,6 @@ free_fail:
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
@@ -978,7 +983,7 @@ free_fail:
         for (i = 0; i < queues; i++) {
             vnet_hdr = tap->has_vnet_hdr ? tap->vnet_hdr : 1;
             fd = net_tap_open(&vnet_hdr, vnet_hdr_required,
-                              i >= 1 ? "no" : script,
+                              i >= 1 ? NULL : script,
                               ifname, sizeof ifname, queues > 1, errp);
             if (fd == -1) {
                 return -1;
@@ -993,8 +998,8 @@ free_fail:
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


