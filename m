Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5089ACA0EE4
	for <qemu-devel@archiver.kernel.org>; Sat, 23 Aug 2025 16:06:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upqio-0005Rk-4O; Sat, 23 Aug 2025 12:04:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1upqiP-0005Ky-MN
 for qemu-devel@nongnu.org; Sat, 23 Aug 2025 12:03:42 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1upqiL-0000Hj-0c
 for qemu-devel@nongnu.org; Sat, 23 Aug 2025 12:03:37 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c23:36c1:0:640:5f85:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id DEA6B80636;
 Sat, 23 Aug 2025 19:03:28 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:c91::1:b])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id Q3YUrj0Gl8c0-FG1CDEro; Sat, 23 Aug 2025 19:03:28 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1755965008;
 bh=kmfQHM8TLUvJTk/2iH8NlzJJp/mIQx68htlSJAODbrY=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=IVX30jzSnOOZ1wg0Z6fwK+O8gcFWe8O5bN7iiDgX9rYtSXcXyWHrb+pPlmMvnDZJ5
 3ZHK2gqYfFvsOE+Stc+XbRvH50eveV8Bbb7CzuoYPExVV3eFyjsXTRHPu3iWA54tJ9
 hK7AC0oa4jMWjffWinEtddhLqoKhz3vyq9ZTZkfc=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: jasowang@redhat.com
Cc: qemu-devel@nongnu.org, vsementsov@yandex-team.ru, leiyang@redhat.com,
 steven.sistare@oracle.com
Subject: [PATCH v2 03/20] net/tap: tap_set_sndbuf(): add return value
Date: Sat, 23 Aug 2025 19:03:06 +0300
Message-ID: <20250823160323.20811-4-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250823160323.20811-1-vsementsov@yandex-team.ru>
References: <20250823160323.20811-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Follow common recommendations to avoid error propagation.

Probably, it would also be good to use bool as a return type
(switching to true/false as success/failure instead of 0/-1). But
seems almost all functions (including a lot of them with errp
argument) have 0/-1 semantics in net/, so making exclusions doesn't
seem good. If we want such a switch, we should update the whole
net/ directory.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 net/tap-linux.c | 5 ++++-
 net/tap.c       | 4 +---
 net/tap_int.h   | 2 +-
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/net/tap-linux.c b/net/tap-linux.c
index 22ec2f45d2..3625379c58 100644
--- a/net/tap-linux.c
+++ b/net/tap-linux.c
@@ -140,7 +140,7 @@ int tap_open(char *ifname, int ifname_size, int *vnet_hdr,
  */
 #define TAP_DEFAULT_SNDBUF 0
 
-void tap_set_sndbuf(int fd, const NetdevTapOptions *tap, Error **errp)
+int tap_set_sndbuf(int fd, const NetdevTapOptions *tap, Error **errp)
 {
     int sndbuf;
 
@@ -154,7 +154,10 @@ void tap_set_sndbuf(int fd, const NetdevTapOptions *tap, Error **errp)
 
     if (ioctl(fd, TUNSETSNDBUF, &sndbuf) == -1 && tap->has_sndbuf) {
         error_setg_errno(errp, errno, "TUNSETSNDBUF ioctl failed");
+        return -1;
     }
+
+    return 0;
 }
 
 int tap_probe_vnet_hdr(int fd, Error **errp)
diff --git a/net/tap.c b/net/tap.c
index ba2731ee8a..0258ac8574 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -702,9 +702,7 @@ static int net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
     TAPState *s = net_tap_fd_init(peer, model, name, fd, vnet_hdr);
     int vhostfd;
 
-    tap_set_sndbuf(s->fd, tap, &err);
-    if (err) {
-        error_propagate(errp, err);
+    if (tap_set_sndbuf(s->fd, tap, errp) < 0) {
         goto failed;
     }
 
diff --git a/net/tap_int.h b/net/tap_int.h
index 8857ff299d..d21acf8486 100644
--- a/net/tap_int.h
+++ b/net/tap_int.h
@@ -33,7 +33,7 @@ int tap_open(char *ifname, int ifname_size, int *vnet_hdr,
 
 ssize_t tap_read_packet(int tapfd, uint8_t *buf, int maxlen);
 
-void tap_set_sndbuf(int fd, const NetdevTapOptions *tap, Error **errp);
+int tap_set_sndbuf(int fd, const NetdevTapOptions *tap, Error **errp);
 int tap_probe_vnet_hdr(int fd, Error **errp);
 int tap_probe_has_ufo(int fd);
 int tap_probe_has_uso(int fd);
-- 
2.48.1


