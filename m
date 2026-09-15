Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61870C88E75
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 16:25:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6Vxh-0004Ri-6Z; Tue, 15 Sep 2026 12:24:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zorin@swemel.ru>) id 1x6Vxc-0004RQ-Sx
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 12:24:45 -0400
Received: from mx.swemel.ru ([95.143.211.150])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zorin@swemel.ru>) id 1x6Vxa-0001xX-QI
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 12:24:44 -0400
Message-ID: <500d4850-f7d7-45fb-91e5-74d32d35fde2@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
 t=1789489479;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=qGNJ7A5rYjk14XWdBhCha6GZVKDCLU0PUZU66dD8slQ=;
 b=LHOVlhJp8PCwsRSKfFMWXvOF3N7KVorBhM471ZLOES1dJtX64XNOYcMBzKelGd9Z3SyYuL
 UTw6pjhmuO+T1B353HoDUfaeZX9Uto+bW9A4U2M6X6013zEr+r2z9ht2Yg1H/0pQJ/xrWe
 h4/5+03xLuMjeLL//yVOgzzV2EhuisQ=
Date: Tue, 15 Sep 2026 19:24:39 +0300
MIME-Version: 1.0
Content-Language: en-US, ru-RU
To: qemu-devel@nongnu.org
Cc: jasowang@redhat.com, mst@redhat.com, armbru@redhat.com
From: =?UTF-8?B?0J3QuNC60L7Qu9Cw0Lkg0JfQvtGA0LjQvQ==?= <zorin@swemel.ru>
Subject: [PATCH] util/error, hw/net/virtio-net: fix NULL pointer dereference
 in error_vprepend
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=95.143.211.150; envelope-from=zorin@swemel.ru;
 helo=mx.swemel.ru
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

SWSA#b0709cee-9722-4603-a30c-dc857dc87961

The `error_vprepend()` function modifies the error message inside an
existing Error object. However, it only validated if the `errp` pointer
itself was non-NULL, missing a check for whether the underlying Error
object `*errp` is `NULL`.

Calling `error_reportf_err(local_error, ...)` when `local_error` is `NULL`
invokes `error_vprepend(&local_error, ...)`, which subsequently crashes
via a `NULL` pointer dereference during `(*errp)->msg` access.

Fix `util/error.c` by adding a defensive `!*errp` check inside 
`error_vprepend()`.

Additionally, fix the invalid error reporting patterns in 
`hw/net/virtio-net.c`:
- In `vhost_user_net_save_state()` and `vhost_user_net_load_state()`, when
   `vhdev == NULL`, calling `error_reportf_err()` with an unallocated/NULL
   `local_error` is incorrect and unsafe. Replace it with a straightforward
   `error_report()` call.
- Fix a cosmetic double-space typo in "Error loading  back-end state".


Signed-off-by: Nikolay N Zorin <zorin@swemel.ru>
---
  hw/net/virtio-net.c | 14 +++++++-------
  util/error.c        |  2 +-
  2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 4362e866..d505fb86 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -3406,9 +3406,9 @@ static int vhost_user_net_save_state(QEMUFile *f, 
void *pv, size_t size,

      vhdev = virtio_net_get_vhost(vdev);
      if (vhdev == NULL) {
-        error_reportf_err(local_error,
-                          "Error getting vhost back-end of %s device %s: ",
-                          vdev->name, vdev->parent_obj.canonical_path);
+        error_report("Error getting vhost back-end of %s device %s: "
+                     "device is not using vhost\n",
+                     vdev->name, vdev->parent_obj.canonical_path);
          return -1;
      }

@@ -3434,16 +3434,16 @@ static int vhost_user_net_load_state(QEMUFile 
*f, void *pv, size_t size,

      vhdev = virtio_net_get_vhost(vdev);
      if (vhdev == NULL) {
-        error_reportf_err(local_error,
-                          "Error getting vhost back-end of %s device %s: ",
-                          vdev->name, vdev->parent_obj.canonical_path);
+        error_report("Error getting vhost back-end of %s device %s: "
+                     "device is not using vhost\n",
+                     vdev->name, vdev->parent_obj.canonical_path);
          return -1;
      }

      ret = vhost_load_backend_state(vhdev, f, &local_error);
      if (ret < 0) {
          error_reportf_err(local_error,
-                          "Error loading  back-end state of %s device 
%s: ",
+                          "Error loading back-end state of %s device %s: ",
                            vdev->name, vdev->parent_obj.canonical_path);
          return ret;
      }
diff --git a/util/error.c b/util/error.c
index 673011b8..db8b5e43 100644
--- a/util/error.c
+++ b/util/error.c
@@ -133,7 +133,7 @@ void error_vprepend(Error *const *errp, const char 
*fmt, va_list ap)
  {
      GString *newmsg;

-    if (!errp) {
+    if (!errp || !*errp) {
          return;
      }

-- 
2.43.0


