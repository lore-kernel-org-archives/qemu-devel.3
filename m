Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 162E0C88E41
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 00:09:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4ooE-0008NL-IE; Thu, 10 Sep 2026 20:08:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4lSK-0005VF-2l
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:33:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4lS9-0002Z5-Hz
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:33:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789072269;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zoVg9FbJe5Igrwha4XGcOTDxhYoC4yK3OmKWb/Idxgg=;
 b=S/b3QfwzZTSSub4ENHinRNZ40ez10r+iuRXWw9SAFsmh2p+x9nVihqmwuQefMMpFfO7lwh
 ZQ9816P8aoeyrfE4r+52aHuDEicuWQ2chcnkuyTffm/iSQynpr8Cw3IgXjPoOtKslEHXrB
 UmlF7q9ZO/AnBYHoLNXhQJHgBk4F6cE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-150-hb40dHQDNMGga25vpvvo1A-1; Thu, 10 Sep 2026 16:15:50 -0400
X-MC-Unique: hb40dHQDNMGga25vpvvo1A-1
X-Mimecast-MFC-AGG-ID: hb40dHQDNMGga25vpvvo1A_1789071350
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-490a767b782so1594955e9.2
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 13:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789071350; x=1789676150; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=zoVg9FbJe5Igrwha4XGcOTDxhYoC4yK3OmKWb/Idxgg=;
 b=c/8Z1D8YPcd2HnO5gC8iki0ItQN9gaDbV3ughoSsRWufMYin4GU0JTjyBs7C/s4k4u
 FY2VWTXH0iUXpcCi3D2GIxVVelUZTuZuGuv68TrvcfnBmpqgT0zbjhY1yZsEzUkOr/Tf
 LT+Ig3y6ZbygTnBKxVrZ5iwaKCwwLugu5KBIddEXWzlLtIiLiXKWOVAu4yUFBgomOtjK
 rtrKeuECbzeGpJEXuz6LjWs9AhiD+8umozZsBNqVxj7+/XdZf/zquIePx1uY4MLTGAom
 5oZKi0o0LY4yEK5enpGitadOJrtOdvoVTxhO32rHtpHL6DKibDV47aP7Tn1yWR2d2CjQ
 atfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789071350; x=1789676150;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zoVg9FbJe5Igrwha4XGcOTDxhYoC4yK3OmKWb/Idxgg=;
 b=SoDD3inl4deFNaSYL3KSkJNcIAgPHbRvZozp9ANcnrLfqxU+g1GvKUZt8nMIeltoOd
 83M0umz8GjnXvOAANRmhBkdVXhX7DsGKd2qdmRTP8h6EZFvsMxukXzq6RlPRB5dyNNPL
 +4ZJLG04BFoRYi11igq0I53pYL6OWIvBf/E2jeyc+3FaImyLtEEySeCnrwC3boLw4sW4
 McxnQa1flJJ/sS6xANpSONvpJMh6OwkIww8IzxIewfIw7ulFYRV9fquNQ2iRbiCutvLK
 GIW09HI+HzO2Q7+Wo/YrXTk0V4G33YFIUnKYo1xZ1fYwHs27Iw9jWQW1zpz72/d+9vxi
 yu9Q==
X-Gm-Message-State: AFuF++nJyDY82TjdKKJ/jvE8Y9W/hLlrrf+UL6JuxZk8NtYIQjdMOJFb
 YhEXUS5cW6CnitX+i8fV7goDwt1ZWCHcsRNfpyq24SXehIg+ZvQKsELsFJ1l16g6DR/aN/Bk+ZN
 W1TCP4shM96YaKzA80qowxvKc+ny4gWu1LzqYbZb3ZgckhwkUZFc/rnL5kWCjxl887nvb+Zjy+V
 IEbQweCh3F0uN0fBd5y96SPeHY4uC8wc5pDw==
X-Gm-Gg: AYBFou02bn4tghxVUSTA3wSzRoAriveTweeP40nIKEd+Bhn66y54HymNjUoa2K1G76L
 2JOifDv1sLPM6xHupy/synvLnFchfLKQacZWWCBCwK8uEF+ss2vJwfoodqgYPtjs3lSXL2h4t9s
 7guVVVpnt3TZ2/ivZEWeSS4q0guzs7gYWY68CUYDG2e3tVpuOq2DQdGGoIIDwDyHx1OwcaNu1Iu
 b3ZTrvc6dGWv01DkHmZ8Q+7WMJmeArGd1Q9MSzzTyysLF/ns8vAEPlg7yI1milwdfUpJnxNZOn1
 Sf1XV769+iV6IclvNNCzNfCUJ01vhNGl8RZp6odifHSsFvxc9PVNdFO1ikxw5MkBRnNs1DkT8qG
 XrznmtZhzQBdok7WzBuOKW24=
X-Received: by 2002:a05:600c:8b41:b0:49d:15b9:2a2a with SMTP id
 5b1f17b1804b1-49e6198c0e6mr10037635e9.10.1789071349607; 
 Thu, 10 Sep 2026 13:15:49 -0700 (PDT)
X-Received: by 2002:a05:600c:8b41:b0:49d:15b9:2a2a with SMTP id
 5b1f17b1804b1-49e6198c0e6mr10036995e9.10.1789071349179; 
 Thu, 10 Sep 2026 13:15:49 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e60946249sm21378645e9.0.2026.09.10.13.15.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 13:15:47 -0700 (PDT)
Date: Thu, 10 Sep 2026 16:15:46 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alexandr Moshkov <dtalexundeer@yandex-team.ru>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Raphael Norwitz <rnorwitz@nvidia.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org
Subject: [PULL 87/90] vhost-user-blk: make inflight-migration prop mutable on
 running vm
Message-ID: <82511c320b6b03c91d578a033a9c1cd59b6b85a8.1789071043.git.mst@redhat.com>
References: <cover.1789071042.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1789071042.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


