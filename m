Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE156C88E53
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 09:10:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4xBW-000059-M2; Fri, 11 Sep 2026 05:04:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4xBG-0007WG-3h
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 05:04:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4xBE-0008Ux-IS
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 05:04:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789117459;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zoVg9FbJe5Igrwha4XGcOTDxhYoC4yK3OmKWb/Idxgg=;
 b=O1aZWVb5r8WlJbyI1icSm2rdHZ/w6VXOK2xYlYZkMHdFVUgpnvF/EOZqcaEegSiJuYfcj+
 hsoILe2Dk28KhTq3+BZhRJmVxq2xnisJOl6F/RcD9l1ICnhP3MqXKz/9dkDH+jhF5swjQf
 D0OPeRvXiNi1PQL6mVggbU7XEYHD9g8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-501-u1GYSw7NNvC9iqSrfb7xnw-1; Fri, 11 Sep 2026 05:04:18 -0400
X-MC-Unique: u1GYSw7NNvC9iqSrfb7xnw-1
X-Mimecast-MFC-AGG-ID: u1GYSw7NNvC9iqSrfb7xnw_1789117457
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-49cd55ee2f7so6062745e9.0
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 02:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789117457; x=1789722257; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=zoVg9FbJe5Igrwha4XGcOTDxhYoC4yK3OmKWb/Idxgg=;
 b=WyGnRMnEYJN1ue3aGGikSyOkMuaDdiziMrilZNM1iQw3vxl0RxTSxatcHpxCg1/6UJ
 YGwqNcCG6ozH57+T05haXjjHsy98K3pSNL8eIlSUHnkdtxCrj8BS79EuzTfQENKZCEOI
 JNMlKzGiKaXGjM/NSaweiYfy7mtk1AIoVfDP1q9bWZ1F0nZ8A/st86Pd8/BHKE5SZrPR
 Y/o86frrTVJLYTugtiDsZt9vCGvU+bPlcwNHxWZ4mHq6Y1u6UpHFD5JmfKhIVQwgy1Jq
 W/0/91TtYKf93EuVfFwEH8y4SARkye6Y3NOPsG9HJwxRCEe+CpBPMGidL6L4GgTNmMyH
 diIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789117457; x=1789722257;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zoVg9FbJe5Igrwha4XGcOTDxhYoC4yK3OmKWb/Idxgg=;
 b=Zk2+oGaM48HfBZHHlPa560zobqmf4+GHsUGG0yqRQ9M2NnLeuEYGIZWJa6CeulPolb
 S2m3M6qTUMEmstXWmQD4hXMLOe/7Im/7pBfhtRsYL5gcV84aNeLeA6agpKSm761EJeaG
 KlekwJeDQwcHNic3EoBV77pRnUHCUXJXFV1guSKUYazV6qq+L1HLgf6NIE/VMV6fjfNa
 atQvCeUDBvxFG6uw9byRmCM0VnQKiaKj+M4aJYG9XM2GvbnWtdBpsbqN+Txy1tMsiWoW
 EYEMccOQ3iTb4DOHnuKw8NCSC3uW8smPHUpCnSl2N2bwHnUWXo3ENIwL2KeBqtGW94e5
 PA2w==
X-Gm-Message-State: AFuF++k8g8oj0e+R4wP+i/BVjogojRe257ZN9G43XVP5hj9dyMgzzACW
 2fTTuZBe4WNPAWIb2ty4+g9TBpK8+PR5wUt6mqrztrz6XWNaVdFCQ/stGwmD93vGRC1ugiyIqs5
 6dM2rY9X53aMwiNh/sIGL8lQuLQ5phcsMHCyV5sMtayMBQmS5b4FYBQ6WaY4Xh96qWDSlFhDjRl
 3vNynXLpgZPTUpkNgM0lqxFWSZnBF34p3M0A==
X-Gm-Gg: AYBFou2knF93UmHjncEIOCknAlSXG3/3FxYocSSFvnm/gJ9TUovWPugbYK8vdUqgOOR
 13v57Pt1wYRRs6AazYq1nj/KT5UwUIhk4+urHYhAPkKECjUOx8WY5/GfA7Zl3PLqYqaAFeEHPey
 7gzHKj9pW97mGO/vO8+OLFBr7CSUkap7Ci1ZxUqI9ULc8F9t1fBAEtFBSA+WYq6IsD1aATv79I5
 sEqYTdbPZU0jdcMqU8XcGaQnI6HOp3mHtrUGOiUBj7Dw/ruPbXAlq5VY/HPv4dNlCyZX6D1J/eG
 Yctv8l/2DBy/lMUb/g0Eu7foqtWU2kQ/W8OfbxQav+90BwHhHtU+vW0noDwJV8lM9RdkAJ5Max6
 sghyXp8/mMKjDDZWpXvyfL7E=
X-Received: by 2002:a05:600c:6309:b0:49c:ff3c:973f with SMTP id
 5b1f17b1804b1-49e619c45f9mr31554085e9.24.1789117457092; 
 Fri, 11 Sep 2026 02:04:17 -0700 (PDT)
X-Received: by 2002:a05:600c:6309:b0:49c:ff3c:973f with SMTP id
 5b1f17b1804b1-49e619c45f9mr31553495e9.24.1789117456531; 
 Fri, 11 Sep 2026 02:04:16 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e62225628sm33347155e9.3.2026.09.11.02.04.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 02:04:16 -0700 (PDT)
Date: Fri, 11 Sep 2026 05:04:14 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alexandr Moshkov <dtalexundeer@yandex-team.ru>,
 Raphael Norwitz <rnorwitz@nvidia.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org
Subject: [PULL v2 72/75] vhost-user-blk: make inflight-migration prop mutable
 on running vm
Message-ID: <dac9beb861fe178a42508f535e59d0f3eccd0ccb.1789117222.git.mst@redhat.com>
References: <cover.1789117222.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1789117222.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Alexandr Moshkov <dtalexundeer@yandex-team.ru>

The inflight-migration property currently can only be set before the
device is realized. This makes it impossible to disable inflight
migration at runtime without restarting the VM.

Make the property mutable, but only while the VM is running. Blocking
changes when the VM is not running ensures that the value at stop time
reliably reflects the intent set on a live VM, which allows
vhost_user_blk_stop() to use skip_drain unconditionally based on the
property value without inspecting migration runstate.

Signed-off-by: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260803072853.2920007-5-dtalexundeer@yandex-team.ru>
---
 hw/block/vhost-user-blk.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
index c3e3c37f8c..501de30796 100644
--- a/hw/block/vhost-user-blk.c
+++ b/hw/block/vhost-user-blk.c
@@ -629,6 +629,8 @@ static const VMStateDescription vmstate_vhost_user_blk = {
     }
 };
 
+static PropertyInfo vhost_user_blk_inflight_migration_prop;
+
 static const Property vhost_user_blk_properties[] = {
     DEFINE_PROP_CHR("chardev", VHostUserBlk, chardev),
     DEFINE_PROP_UINT16("num-queues", VHostUserBlk, num_queues,
@@ -644,8 +646,9 @@ static const Property vhost_user_blk_properties[] = {
                       VIRTIO_BLK_F_WRITE_ZEROES, true),
     DEFINE_PROP_BOOL("skip-get-vring-base-on-force-shutdown", VHostUserBlk,
                      skip_get_vring_base_on_force_shutdown, false),
-    DEFINE_PROP_BOOL("inflight-migration", VHostUserBlk,
-                     inflight_migration, false),
+    DEFINE_PROP("inflight-migration", VHostUserBlk, inflight_migration,
+                vhost_user_blk_inflight_migration_prop, bool,
+                .set_default = true, .defval.u = false),
 };
 
 static void vhost_user_blk_class_init(ObjectClass *klass, const void *data)
@@ -675,8 +678,29 @@ static const TypeInfo vhost_user_blk_info = {
     .class_init = vhost_user_blk_class_init,
 };
 
+static void vhost_user_blk_set_inflight_migration(Object *obj, Visitor *v,
+                                                  const char *name,
+                                                  void *opaque, Error **errp)
+{
+    DeviceState *dev = DEVICE(obj);
+
+    if (dev->realized && !runstate_is_running()) {
+        error_setg(errp, "Property '%s' cannot be changed "
+                         "while VM is not running", name);
+        return;
+    }
+
+    qdev_prop_bool.set(obj, v, name, opaque, errp);
+}
+
+
 static void virtio_register_types(void)
 {
+    vhost_user_blk_inflight_migration_prop = qdev_prop_bool;
+    vhost_user_blk_inflight_migration_prop.realized_set_allowed = true;
+    vhost_user_blk_inflight_migration_prop.set =
+        vhost_user_blk_set_inflight_migration;
+
     type_register_static(&vhost_user_blk_info);
 }
 
-- 
MST


