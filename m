Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5273ACCF9E3
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 20:34:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEZJR-0000ix-On; Thu, 30 Oct 2025 16:32:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vEZJD-0000fQ-Dh
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 16:31:48 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vEZIu-0005vk-PP
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 16:31:43 -0400
Received: from mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:94a9:0:640:a3fa:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 6541780A94;
 Thu, 30 Oct 2025 23:31:25 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:861::1:2b])
 by mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id HVmKdN0F6Cg0-aWeEbpK8; Thu, 30 Oct 2025 23:31:24 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1761856285;
 bh=mQwvhGHiZqI2TjGcnxQJGUhpsykI0z4S9z0cd6haisY=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=wI+q22YMMHYojSfkMqitHVDMBsNRAHfzoPzouefoaTzOcUh+8OJ37G2vgWw4eoTht
 o3rW0mAMW3GqrgAKxnQcmHp2C776WPDVhdDo3rxGOt2ggyS5TrHPmTl1aojvH8mx/Q
 i6YdOSNxDTkZ6E44dabgD6d5WUvM+DVc3QRXUeZI=
Authentication-Results: mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: mst@redhat.com,
	jasowang@redhat.com
Cc: pbonzini@redhat.com, berrange@redhat.com, eduardo@habkost.net,
 peterx@redhat.com, farosas@suse.de, eblake@redhat.com, armbru@redhat.com,
 thuth@redhat.com, philmd@linaro.org, zhao1.liu@intel.com,
 qemu-devel@nongnu.org, leiyang@redhat.com, davydov-max@yandex-team.ru,
 yc-core@yandex-team.ru, vsementsov@yandex-team.ru,
 raphael.s.norwitz@gmail.com
Subject: [PATCH v9 6/8] net/tap: support backend-transfer migration
Date: Thu, 30 Oct 2025 23:31:13 +0300
Message-ID: <20251030203116.870742-7-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251030203116.870742-1-vsementsov@yandex-team.ru>
References: <20251030203116.870742-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Support transferring of TAP state (including open fd) through
migration stream.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 net/tap.c | 46 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 45 insertions(+), 1 deletion(-)

diff --git a/net/tap.c b/net/tap.c
index ad1d458521..4a752006de 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -413,6 +413,49 @@ static VHostNetState *tap_get_vhost_net(NetClientState *nc)
     return s->vhost_net;
 }
 
+static int tap_pre_load(void *opaque)
+{
+    TAPState *s = opaque;
+
+    if (s->fd != -1) {
+        error_report(
+            "TAP is already initialized and cannot receive incoming fd");
+        return -EINVAL;
+    }
+
+    return 0;
+}
+
+static int tap_post_load(void *opaque, int version_id)
+{
+    TAPState *s = opaque;
+    Error *local_err = NULL;
+
+    if (!net_tap_setup(s, -1, -1, &local_err)) {
+        error_report_err(local_err);
+        qemu_del_net_client(&s->nc);
+        return -EINVAL;
+    }
+
+    return 0;
+}
+
+static const VMStateDescription vmstate_tap = {
+    .name = "net-tap",
+    .pre_load = tap_pre_load,
+    .post_load = tap_post_load,
+    .fields = (const VMStateField[]) {
+        VMSTATE_FD(fd, TAPState),
+        VMSTATE_BOOL(using_vnet_hdr, TAPState),
+        VMSTATE_BOOL(has_ufo, TAPState),
+        VMSTATE_BOOL(has_uso, TAPState),
+        VMSTATE_BOOL(has_tunnel, TAPState),
+        VMSTATE_BOOL(enabled, TAPState),
+        VMSTATE_UINT32(host_vnet_hdr_len, TAPState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 /* fd support */
 
 static NetClientInfo net_tap_info = {
@@ -434,6 +477,7 @@ static NetClientInfo net_tap_info = {
     .set_steering_ebpf = tap_set_steering_ebpf,
     .get_vhost_net = tap_get_vhost_net,
     .backend_connect = tap_backend_connect,
+    .backend_vmsd = &vmstate_tap,
 };
 
 static TAPState *net_tap_new(NetClientState *peer, const char *model,
@@ -800,7 +844,7 @@ static void net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
 
 static bool net_tap_setup(TAPState *s, int fd, int vnet_hdr, Error **errp)
 {
-    if (!net_tap_set_fd(s, fd, vnet_hdr, errp)) {
+    if (fd != -1 && !net_tap_set_fd(s, fd, vnet_hdr, errp)) {
         return false;
     }
 
-- 
2.48.1


