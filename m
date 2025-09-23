Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4231ACAC5B0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 10:02:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0zqb-00036g-L1; Tue, 23 Sep 2025 06:02:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v0zq3-0002ln-Lc
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 06:01:35 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v0zpo-0000ta-FM
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 06:01:35 -0400
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:cf2d:0:640:140f:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 982448092A;
 Tue, 23 Sep 2025 13:01:17 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:b38::1:12])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id C1Ug0C0Fha60-zOD1wE8b; Tue, 23 Sep 2025 13:01:17 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1758621677;
 bh=jwgfCyxnkeS08WSpdIGIVrRghpy+hEGHPwdSeT5sp+k=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=uk0Clw0FF3xirjmVsJlwHgaJ7q6wSDJDMTDs3ZqzlwT5wzfxqgZcc4sV82lKvMcRB
 FgIFUto1kxFnzJBQ3248OMYZ87x49ubqgCCmTu+qHAQret5evxGO3Jj+xo4tXdxo22
 KJgdg7fEoFHz0odHTjNFbKdPSCAi+/uXPPfsgQgw=
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
Subject: [PATCH v6 08/19] net/tap: tap_set_sndbuf(): add return value
Date: Tue, 23 Sep 2025 13:00:59 +0300
Message-ID: <20250923100110.70862-9-vsementsov@yandex-team.ru>
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

Follow common recommendations in include/qapi/error.h of having
a return value together with errp. This allows to avoid error propagation.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 net/tap-bsd.c     | 3 ++-
 net/tap-linux.c   | 5 ++++-
 net/tap-solaris.c | 3 ++-
 net/tap-stub.c    | 3 ++-
 net/tap.c         | 5 +----
 net/tap_int.h     | 2 +-
 6 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/net/tap-bsd.c b/net/tap-bsd.c
index 3f98d0ea82..501bf9d3eb 100644
--- a/net/tap-bsd.c
+++ b/net/tap-bsd.c
@@ -206,8 +206,9 @@ error:
 }
 #endif /* __FreeBSD__ */
 
-void tap_set_sndbuf(int fd, const NetdevTapOptions *tap, Error **errp)
+bool tap_set_sndbuf(int fd, const NetdevTapOptions *tap, Error **errp)
 {
+    return true;
 }
 
 int tap_probe_vnet_hdr(int fd, Error **errp)
diff --git a/net/tap-linux.c b/net/tap-linux.c
index e832810665..8cb9dc0787 100644
--- a/net/tap-linux.c
+++ b/net/tap-linux.c
@@ -145,7 +145,7 @@ int tap_open(char *ifname, int ifname_size, int *vnet_hdr,
  */
 #define TAP_DEFAULT_SNDBUF 0
 
-void tap_set_sndbuf(int fd, const NetdevTapOptions *tap, Error **errp)
+bool tap_set_sndbuf(int fd, const NetdevTapOptions *tap, Error **errp)
 {
     int sndbuf;
 
@@ -159,7 +159,10 @@ void tap_set_sndbuf(int fd, const NetdevTapOptions *tap, Error **errp)
 
     if (ioctl(fd, TUNSETSNDBUF, &sndbuf) == -1 && tap->has_sndbuf) {
         error_setg_errno(errp, errno, "TUNSETSNDBUF ioctl failed");
+        return false;
     }
+
+    return true;
 }
 
 int tap_probe_vnet_hdr(int fd, Error **errp)
diff --git a/net/tap-solaris.c b/net/tap-solaris.c
index af2ebb16f5..496c1323fc 100644
--- a/net/tap-solaris.c
+++ b/net/tap-solaris.c
@@ -207,8 +207,9 @@ int tap_open(char *ifname, int ifname_size, int *vnet_hdr,
     return fd;
 }
 
-void tap_set_sndbuf(int fd, const NetdevTapOptions *tap, Error **errp)
+bool tap_set_sndbuf(int fd, const NetdevTapOptions *tap, Error **errp)
 {
+    return true;
 }
 
 int tap_probe_vnet_hdr(int fd, Error **errp)
diff --git a/net/tap-stub.c b/net/tap-stub.c
index 38673434cb..8e328c679f 100644
--- a/net/tap-stub.c
+++ b/net/tap-stub.c
@@ -33,8 +33,9 @@ int tap_open(char *ifname, int ifname_size, int *vnet_hdr,
     return -1;
 }
 
-void tap_set_sndbuf(int fd, const NetdevTapOptions *tap, Error **errp)
+bool tap_set_sndbuf(int fd, const NetdevTapOptions *tap, Error **errp)
 {
+    return true;
 }
 
 int tap_probe_vnet_hdr(int fd, Error **errp)
diff --git a/net/tap.c b/net/tap.c
index 048d130247..95cbd75fe4 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -688,15 +688,12 @@ static void net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
                              const char *downscript, const char *vhostfdname,
                              int vnet_hdr, int fd, Error **errp)
 {
-    Error *err = NULL;
     TAPState *s = net_tap_new(peer, model, name);
     int vhostfd;
 
     net_tap_set_fd(s, fd, vnet_hdr);
 
-    tap_set_sndbuf(s->fd, tap, &err);
-    if (err) {
-        error_propagate(errp, err);
+    if (!tap_set_sndbuf(s->fd, tap, errp)) {
         goto failed;
     }
 
diff --git a/net/tap_int.h b/net/tap_int.h
index 8857ff299d..08c40094b8 100644
--- a/net/tap_int.h
+++ b/net/tap_int.h
@@ -33,7 +33,7 @@ int tap_open(char *ifname, int ifname_size, int *vnet_hdr,
 
 ssize_t tap_read_packet(int tapfd, uint8_t *buf, int maxlen);
 
-void tap_set_sndbuf(int fd, const NetdevTapOptions *tap, Error **errp);
+bool tap_set_sndbuf(int fd, const NetdevTapOptions *tap, Error **errp);
 int tap_probe_vnet_hdr(int fd, Error **errp);
 int tap_probe_has_ufo(int fd);
 int tap_probe_has_uso(int fd);
-- 
2.48.1


