Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C76BDC79FBB
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 22:13:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4moi-00081d-2C; Thu, 10 Sep 2026 18:01:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4lWk-0006al-1t
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:38:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4lWQ-0004he-97
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:37:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789072563;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wZrDckEuRqXcdJQtcRSJZ7IayS+V6IuygbIlsWDcXKU=;
 b=WDa3FiQFxTA5tlYUA/gKsmQYqQ7jzp1URPjiX6zqKcYjA6JOzSBuRnwSm9yUbg/QPabCUI
 c4bW0pD2YlkMTXBWJDbempuhy5GfaBR2IIeKtkJOitWPTuGm9mu/yTIU1TYNBCbCWANNlR
 Bo21tiKf/PU6WFRFWYyr+34m39jnm6A=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-204-lF8ZaUVZPk68mUIj_gV0HQ-1; Thu, 10 Sep 2026 16:11:55 -0400
X-MC-Unique: lF8ZaUVZPk68mUIj_gV0HQ-1
X-Mimecast-MFC-AGG-ID: lF8ZaUVZPk68mUIj_gV0HQ_1789071114
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-49d28ac5735so2319675e9.0
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 13:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789071114; x=1789675914; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=wZrDckEuRqXcdJQtcRSJZ7IayS+V6IuygbIlsWDcXKU=;
 b=EateLUatgA7aO1trNMQmEnfNpdL5mjBWg2f+NpExbWyooko7bBdpAkUDp/OXeLHtYt
 csOoENjlP++pGHkpUN7/8FXX6fUUc7qYHI8dIy7DJJPO1jsA4d+iRV31zMeOcnFqy+6E
 n+iLfxreNa4LxWW1U2LXRyqPgSRo91G6cXhi9PhE++0UV7e0M0rwmMpuQGkiuLMymXVm
 bfzfeQl+XwfmFkOHKYVQToIezoTYMpGbyPo84eZmPjHYzbVFvc4ybzmsY7bLFh+cGVYf
 ig4b2qmuw0oMlL/kzHMiKamhTjKrT/0Gl4QDa6sryWLF17tyoxqrAgvltxbEKAGNcDCW
 rd6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789071114; x=1789675914;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wZrDckEuRqXcdJQtcRSJZ7IayS+V6IuygbIlsWDcXKU=;
 b=b1v+Vw9XTT+iCe5R2ItyOa+Rims5jf6s7MOcC7rMbKyKPggCTtUqyQ91wtszzTf1O5
 UWifpxh9PlJkqL8PZW37y3KMw4lQ8wLntJNoyAA9YSbaArW1ZCZGFb2fEFRc0a3J8J9v
 z3lJNRk6wbOz1Y0fqlqqxYiFxpr1ZF/JNKXmn9vSCRyo+fr+0wohiyUioY1to5I3Jbg/
 oHFnTI6qI7iUzuwfArW/ADBXMThiv0DaQpzJtOFhc9yDPSIIa5NY+sJfz8vGlRHG9/ZK
 A1GoX5xaeCHsN2XpPYA47D6oNVvUOSlLeLEfVA7HkiwCFrhFNOmtiBMmhC1dBpzm2G+Y
 xL1A==
X-Gm-Message-State: AFuF++nMY8j6R2A58B8iKAHx7ELQwN5DqpO+Gs7rlqxs6/qsSOQdDp+V
 rR+qPqpZHBAk+Az9XfcZoymyWjYBGFec/kIEcXr5Z/0efbyboLq25BV6cBHcWiRT1fl5VFs2uTR
 Aao+mkjqHngWp54Vv/TbHcwuszuJfSDt2VD2GKMR1eS6evnjRuG62Ixl05lhcgaEs7G74Trb9b1
 82Oz4wnGH6PpTdS8UMIXrwd5dVtU8lbyxPBQ==
X-Gm-Gg: AYBFou2NmjPP9r/PG8i1Tf1KyAw8CJeo88oEuCwpSrmApiO3N1+Z03IOi/OyCVfHGe/
 n7vi+AaClPpVktgqjYtsN+BfK9oxFgATzg6ZuEyMmRDG1Gt/JX5hJJgCxdWazZLABov5C961/ZO
 6GrsKn3lOnaYr4LVkCYjQWf+2sdkEbiiVYSkzlqoF3AxuPaasPsWEZToh6/QOgo6+mI9iAuuyrI
 588TBgCYzxL7ndRtBM1V1TW78KcKSNHicmDYxZ8OCXtHfYzB98XV/BG5GgMX4l5Gesp+J6DmWrX
 AkVhAKe3+X3yisYat4kruqm2Fj2LkUU7izVKpEWKIbgZEwbeETPcVk73rLfAsQkkwN3EC9GQlUE
 FgQFj69MR+Oi4xs33YyUZsV8=
X-Received: by 2002:a05:600c:3b27:b0:49d:10d6:fd55 with SMTP id
 5b1f17b1804b1-49e619805dbmr7481885e9.1.1789071114105; 
 Thu, 10 Sep 2026 13:11:54 -0700 (PDT)
X-Received: by 2002:a05:600c:3b27:b0:49d:10d6:fd55 with SMTP id
 5b1f17b1804b1-49e619805dbmr7481445e9.1.1789071113520; 
 Thu, 10 Sep 2026 13:11:53 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eaccaa1asm1180583f8f.0.2026.09.10.13.11.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 13:11:53 -0700 (PDT)
Date: Thu, 10 Sep 2026 16:11:51 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PULL 13/90] vhost: add vhost_dev_is_initialized() helper
Message-ID: <66d0d51d79266778f2ac0cf8801fc18ad1aa9e32.1789071042.git.mst@redhat.com>
References: <cover.1789071042.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1789071042.git.mst@redhat.com>
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

From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>

The upcoming CPR support for vhost-vsock defers the full vhost_dev_init()
to .post_load(). On an incoming CPR .realize() only sets up the backend,
so we need a way to tell a fully initialized vhost device from a partially
initialized one.

Add an explicit 'bool initialized' field, set once vhost_dev_init()
succeeds, and cleared only in vhost_dev_cleanup() (by memset(0)). Also add
a public vhost_dev_is_initialized() helper.

Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260820113955.509478-10-andrey.drobyshev@virtuozzo.com>
---
 include/hw/virtio/vhost.h | 14 ++++++++++++++
 hw/virtio/vhost.c         |  2 ++
 2 files changed, 16 insertions(+)

diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
index 44e65968d9..7c4f032996 100644
--- a/include/hw/virtio/vhost.h
+++ b/include/hw/virtio/vhost.h
@@ -109,6 +109,8 @@ struct vhost_dev {
     uint64_t backend_cap;
     /* @started: is the vhost device started? */
     bool started;
+    /* @initialized: has the full vhost_dev_init() completed? */
+    bool initialized;
     bool log_enabled;
     uint64_t log_size;
     Error *migration_blocker;
@@ -236,6 +238,18 @@ static inline bool vhost_dev_is_started(struct vhost_dev *hdev)
     return hdev->started;
 }
 
+/**
+ * vhost_dev_is_initialized() - report init status of vhost device
+ * @hdev: common vhost_dev structure
+ *
+ * Return true if the full vhost_dev_init() has completed successfully
+ * (and vhost_dev_cleanup() has not run since).
+ */
+static inline bool vhost_dev_is_initialized(struct vhost_dev *hdev)
+{
+    return hdev->initialized;
+}
+
 static inline int vhost_dev_set_vring_enable(struct vhost_dev *hdev, int enable)
 {
     if (!hdev->vhost_ops->vhost_set_vring_enable) {
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index ea17bf0108..a81cd94f90 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1821,6 +1821,8 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
         goto fail;
     }
 
+    hdev->initialized = true;
+
     trace_vhost_dev_init_out(hdev);
 
     return 0;
-- 
MST


