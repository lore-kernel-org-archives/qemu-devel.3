Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE8B4C5DF74
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 23:32:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ww6o6-0001WL-Rf; Mon, 17 Aug 2026 19:31:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <connorkite@gmail.com>)
 id 1ww6o5-0001W8-54
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 19:31:53 -0400
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <connorkite@gmail.com>)
 id 1ww6o3-0003mn-Ib
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 19:31:52 -0400
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7ee4399c423so2721178a34.0
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 16:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787009510; x=1787614310; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=BisHvC69fGe2+msznL33bh/ZmNUCoaqX7TvKF27QcOk=;
 b=mBCYN5dqVuoGXhwY52tmW4ZwYqT2nviPsef/z7SJLx5ZxrDs4oniyHOXFRYbs1lPC+
 lssZpr2GkzP0+B9CNPw0QYnw+E70BuhJDA9raUX58vc3pGGz9TAgl5KHczKsYI9iuHRp
 8c5Ki3qYRym6v5ns6gDU9L+Q86z/GzAaZFuFvRTChADNkd9DPw5YEnDjJzNB0hG0Gdr3
 PPgSxGYvg8af2HEICj0VfnIrkwADQmBxrJhez1btF8w3pGhhFRW0w8ppH6Hgl1q4uSvV
 2UT+YnuTTvM7bzp9tL6sVuPJozqgnMQk2VG/isMvx7mXfkQ2yeV/rqSdfOTsm96oDDY3
 5gLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787009510; x=1787614310;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BisHvC69fGe2+msznL33bh/ZmNUCoaqX7TvKF27QcOk=;
 b=HSl81T3qjddAc4+gVj+u36/vRNrR00LNFih1+mJPvDn5ApxY7pHc5AuABgIcah45fR
 JNszFPSva+/276uCI9/m/+DU0mX6vKKVkJzpC/FnaeiUN3aoVfhf1lhvARLagNI93UIH
 UtYQN6eD8OlWtD2zhcf2WQkjem1gmhJemSWdiX72a7wvRKx0uR+BQcBIaoIvggh8TFa7
 B4FO3m6oN1eHHM4JwInOr0kzI4up/DHYfv9NTn5yOTREv1GS0yHAfsKtgXJ+OfWKhfQj
 6Otx/eCii25KM9N5kFg2cToQ40pzMyAsmEvWSR5hfRKjG8vRMEHvwacizm4XKWa2/PGv
 B7iw==
X-Gm-Message-State: AOJu0YyFrNfzWgmzkh7fk6LfwjfxkCxFRxm4FVbEVslqx9mpHGJGzZpN
 sx1sKqGuEZjbIixrGD4ewFFEzubOtJnfRFXl21ge82qBaCmcCxNY/0IL+s4m0T3D
X-Gm-Gg: AR+sD12LpHLkKSr6+4xf0aQcPNIgojp/UM/p9EVfs1ZWRTvj/72Mw838H7TxUSj3YiQ
 1lbUAECDd1T+96fVjHCuuG78mY8UywUkDksyDQGQs2e7PlhzuUk5eeoSpPnYw4WhmlnK/DuN6y/
 JRas+zFtKU9pm7Axjd3DZ16Uh6RTqKpdPQC+g84C267zKJqvPtWdrEpoxCTzmQiu/YJh3Y+l4FA
 aogOuRahMs2S2tPbC/v5QxJVFcwOiH1ph0jdWr53/mtaB8+TkuCfuaBZAbGOWCE7L3f8Tm0AHjt
 NFeY7Usw6s3EGzsLQywc42Id5yqMbmJexyAQe1eVb/zH0vvmew+CeveAZleQzrdlFieYzjjNghR
 A/QV75wGFjytQgwk/q9aMgDXmWmY0oCBDq+Wh7nZNsKsU1As1WcOxeVJ9h1g/WdciYnUIyE7tnW
 IcZh17sOQA2bVveiHKt44plHBhPmQfsrOVRVnzdR7iZdMmFXNBUPxzgw72yPZb4B30LGa64b0Ql
 1NR
X-Received: by 2002:a05:6820:2915:b0:6b0:52b9:cb with SMTP id
 006d021491bc7-6b0d690c2cdmr26880466eaf.31.1787009510094; 
 Mon, 17 Aug 2026 16:31:50 -0700 (PDT)
Received: from MacLin.attlocal.net ([2600:1700:e140:14d0:258e:a86c:e3dd:105a])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6b1165f44d5sm3041547eaf.8.2026.08.17.16.31.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 16:31:49 -0700 (PDT)
From: Connor Kite <connorkite@gmail.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Hanna Czenczek <hreitz@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Connor Kite <connorkite@gmail.com>
Subject: [PATCH v2] hw/virtio/vhost-shadow-virtqueue: range boundary in
 translation
Date: Mon, 17 Aug 2026 16:31:47 -0700
Message-ID: <20260817233147.2867623-1-connorkite@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::333;
 envelope-from=connorkite@gmail.com; helo=mail-ot1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

iova-tree expects inclusive range sizing when maps are allocated or searched.
Currently, svqs use exclusive sizing when searching their
vhost-iova-tree for a match to the region to be translated.  This could
lead to errors if the region to be translated is at the edge of an iova
region.

Fix this by reducing `needle.size` by 1 in
vhost_svq_translate_addr to bring it in line with DMAMap and iova-tree
convention.

The only current user of svq->iova_tree is hw/virtio/vhost-vdpa.c, which
also treats size as inclusive when using the tree API.  In progress work
on vhost-user isolation mode in hw/virtio.vhost-vdpa.c also uses
inclusive sizing when interacting with the tree.

This patch is an updated version of one from the patch series "vhost-user:
isolated memory".  The patch has been isolated from the series as it
is not tightly coupled with the rest of the series.

Signed-off-by: Connor Kite <connorkite@gmail.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
V2 Differences:
- Context added about users of svq->iova_tree and their adoption of
  inclusive sizing

 hw/virtio/vhost-shadow-virtqueue.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-shadow-virtqueue.c
index bcb7f2ffc7..c8831d52be 100644
--- a/hw/virtio/vhost-shadow-virtqueue.c
+++ b/hw/virtio/vhost-shadow-virtqueue.c
@@ -99,19 +99,25 @@ static bool vhost_svq_translate_addr(const VhostShadowVirtqueue *svq,
         const DMAMap *map;
         DMAMap needle;
 
+        if (unlikely(iovec[i].iov_len == 0)) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "Zero-sized buffer made available by guest");
+            return false;
+        }
+
         /* Check if the descriptor is backed by guest memory  */
         if (gpas) {
             /* Search the GPA->IOVA tree */
             needle = (DMAMap) {
                 .translated_addr = gpas[i],
-                .size = iovec[i].iov_len,
+                .size = iovec[i].iov_len - 1,  /* Inclusive */
             };
             map = vhost_iova_tree_find_gpa(svq->iova_tree, &needle);
         } else {
             /* Search the IOVA->HVA tree */
             needle = (DMAMap) {
                 .translated_addr = (hwaddr)(uintptr_t)iovec[i].iov_base,
-                .size = iovec[i].iov_len,
+                .size = iovec[i].iov_len - 1, /* Inclusive */
             };
             map = vhost_iova_tree_find_iova(svq->iova_tree, &needle);
         }
-- 
2.43.0


