Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59DC3C5DF7D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 15:30:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwLlM-0003dI-PQ; Tue, 18 Aug 2026 11:30:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1wwLlL-0003cw-47
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 11:30:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1wwLlJ-0008Pr-5B
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 11:30:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787067000;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ohl5mwrLwmz8AtWq6Be7Ifp7GGKk42xdd1yobhwZwJw=;
 b=hArw3kvdfPtHhCHOJrkoANi9RlCWXVa2Qd1bwMgPNW+n5+IV+fQf7L+L4m7KtuOjCmHjVw
 uoTW7zpbP7slcFKXecx8lNnRqlK+i3Z7Cx91bqba+zW5IXXNhWKB46HApQ0pttvjFma0G5
 qRbj/NC3w1ILhXSMqISeVKSK0K6Cxdk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-363-gsqBWU3nODmmRSYiu7WZAA-1; Tue, 18 Aug 2026 11:29:46 -0400
X-MC-Unique: gsqBWU3nODmmRSYiu7WZAA-1
X-Mimecast-MFC-AGG-ID: gsqBWU3nODmmRSYiu7WZAA_1787066985
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-499574e98a1so31472275e9.3
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 08:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787066985; x=1787671785; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ohl5mwrLwmz8AtWq6Be7Ifp7GGKk42xdd1yobhwZwJw=;
 b=cGgm6ugrFGEn3SJr+iINgDiIqiAdH7SVYlbx28xv/9KyHp6mh7O9SfD0+Xd8pTtS45
 6F2/f+FUdZiDhiosH5oyMjzPgIOeK2zrdMfRglFZvMMS6OH8dKfqjsGa3KY4ImxP9zk2
 1SJOM/vSiCf3yVDXAvVEhD2FddgbKsjEZVI+GUxFuz0V5Afcj0VBlgzqDmpvLrbdQwQT
 4PHncsx0pfgK2m2Vazt3rJ1h7uvAn5wib7Mmuy+CVq3JkgIRox24p9rwn+hDF1WmQxz+
 w0VQvItYjAbDg4kFRRUZrl6W5S3KQx0lxD4kvydcz5V9/yDzmFAkEs6wSb969K9gli1r
 2Ojw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787066985; x=1787671785;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ohl5mwrLwmz8AtWq6Be7Ifp7GGKk42xdd1yobhwZwJw=;
 b=r0wkqn5DaVLemZ4W76OdvjV8E+wby6m/5U0lliwq7UnuVL4XrCNY08o0EK79v6ALbe
 MUz1H2+MxYM24Y1LtQVtCCzgACgVQNQJEcRfF69xlC7CBTz9lSXINPLoC/L+BigfOYSp
 3sTJcgYwVbJ37KlE1QXh0QPGb5ikmSAzV9t2lQg9ByGzebdst6aFHfQvpPi6q5CuyikI
 fdZqTXLZIU78qLNLeT/Jtuoh2mZW5Zza4eqGqvz+2wDAJLgX2jmDYvW24HE9coQ5R5VD
 U0yEofoFjNB9qTGcN+cGCllLaNSbeq9fyMzkdYSz85hHraNMwSNcfSpXCNWhJBXLrtqX
 Y/cA==
X-Gm-Message-State: AOJu0Yx/HNfYdblqozxTT+6evQEQP4o4LExbIqxIyUShrnwhCaXu5FxL
 QsRo60tIu+PgYA/LrK04qTTSaIrhiXRPCw5rxv9Y1mtW+jgVJ/UdtQ3UHSaDCDI9z8LPAnncOr6
 /ij+EkX2MiY0akpId3BppaBTUV0TQHVlUmQ4tas0keDOYfs0kdmCuM0Fk
X-Gm-Gg: AR+sD13tRTNVRmpJ11zGuzQfMWvYfGmhYP6HAPa64KVWnCNjBXVyKr7vyU2nkGN7Jc1
 lvJv2y2hI4xT5kL9/VZDA7d2s+n812vmoPiHRpUXWe1SSlfVHafFT0df2PsVDAOa0UHfvgVeme4
 /G6pNn8BZHgU62GEYnOOyKwR1tWMAZegXIwZoEVlKHBnPnjKm16Egiv4HBvnb1G2mn6GJl9PXgx
 ItCNMqCskr2XGxYIDTSg7AvZhxrm+e+WLmec1wERjrHL+z8c4U6htUd2/WAJuHiBOgxifwGv1Tv
 bNcj+gmT8OSgxDMgFjPT5MCNbYz0awBmUCGf6+K7AAi7DBciNpvwZipioHXxPtmgab3VzBtJ8NP
 EK3a+wO27mO000jy6Y81i1DRJJ1sZC1vnyC4QPqak4D792sbg7CsO
X-Received: by 2002:a05:600c:870c:b0:497:fecd:5b00 with SMTP id
 5b1f17b1804b1-4999fb3be85mr174021635e9.9.1787066985039; 
 Tue, 18 Aug 2026 08:29:45 -0700 (PDT)
X-Received: by 2002:a05:600c:870c:b0:497:fecd:5b00 with SMTP id
 5b1f17b1804b1-4999fb3be85mr174019775e9.9.1787066984469; 
 Tue, 18 Aug 2026 08:29:44 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-154.retail.telecomitalia.it.
 [82.53.135.154]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4999d0fb85csm185367865e9.11.2026.08.18.08.29.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 08:29:41 -0700 (PDT)
Date: Tue, 18 Aug 2026 17:29:39 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, farosas@suse.de, 
 peterx@redhat.com, dongli.zhang@oracle.com, maciej.szmigiero@oracle.com, 
 bchaney@akamai.com, mark.kanda@oracle.com, den@openvz.org
Subject: Re: [PATCH v3 5/7] vhost: factor out vhost_dev_init_backend()
Message-ID: <aoRz2pDHkWCCr1hq@sgarzare-redhat>
References: <20260626164643.2526-1-andrey.drobyshev@virtuozzo.com>
 <20260626164643.2526-6-andrey.drobyshev@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260626164643.2526-6-andrey.drobyshev@virtuozzo.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.343,
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

On Fri, Jun 26, 2026 at 07:46:41PM +0300, Andrey Drobyshev wrote:
>Split the first part of vhost_dev_init(): selecting the backend, calling
>its .vhost_init() and reading the supported features - into a new
>vhost_dev_init_backend() helper, and call it from vhost_dev_init().
>
>This is in preparation for CPR restore of vhost-vsock, which needs to learn
>the backend's features at realize time to negotiate them when loading the
>incoming virtio state, but also must defer taking ownership of the device
>to post_load.  vhost_dev_init_backend() does exactly the pre-ownership part.
>
>As a result VHOST_SET_OWNER now follows the feature query rather than
>precedes it.  This should be safe, as no backend requires ownership before
>VHOST_GET_FEATURES - the kernel and vdpa backends do not check ownership
>for it, and vhost-user already does query features from its .vhost_init()
>before set_owner().
>
>Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>---
> hw/virtio/vhost.c         | 33 +++++++++++++++++++++++----------
> include/hw/virtio/vhost.h | 19 +++++++++++++++++++
> 2 files changed, 42 insertions(+), 10 deletions(-)
>
>diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
>index af41841b529..f11588cc51a 100644
>--- a/hw/virtio/vhost.c
>+++ b/hw/virtio/vhost.c
>@@ -1667,6 +1667,28 @@ static int vhost_dev_init_features(struct vhost_dev *hdev)
>     return r;
> }
>
>+int vhost_dev_init_backend(struct vhost_dev *hdev, void *opaque,
>+                           VhostBackendType backend_type, Error **errp)
>+{
>+    int r;
>+
>+    r = vhost_set_backend_type(hdev, backend_type);
>+    assert(r >= 0);
>+
>+    r = hdev->vhost_ops->vhost_init(hdev, opaque, errp);
>+    if (r < 0) {
>+        return r;
>+    }
>+
>+    r = vhost_dev_init_features(hdev);
>+    if (r < 0) {
>+        error_setg_errno(errp, -r, "vhost_init_features failed");
>+        return r;
>+    }
>+
>+    return 0;
>+}
>+
> int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
>                    VhostBackendType backend_type, uint32_t busyloop_timeout,
>                    Error **errp)
>@@ -1679,10 +1701,7 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
>     hdev->vdev = NULL;
>     hdev->migration_blocker = NULL;
>
>-    r = vhost_set_backend_type(hdev, backend_type);
>-    assert(r >= 0);
>-
>-    r = hdev->vhost_ops->vhost_init(hdev, opaque, errp);
>+    r = vhost_dev_init_backend(hdev, opaque, backend_type, errp);
>     if (r < 0) {
>         goto fail;
>     }
>@@ -1693,12 +1712,6 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
>         goto fail;
>     }
>
>-    r = vhost_dev_init_features(hdev);
>-    if (r < 0) {
>-        error_setg_errno(errp, -r, "vhost_init_features failed");
>-        goto fail;
>-    }
>-
>     limit = hdev->vhost_ops->vhost_memslots_limit(hdev);
>     if (limit < MEMORY_DEVICES_SAFE_MAX_MEMSLOTS &&
>         memory_devices_memslot_auto_decision_active()) {
>diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
>index 684bafcaadd..bc81e09663e 100644
>--- a/include/hw/virtio/vhost.h
>+++ b/include/hw/virtio/vhost.h
>@@ -156,6 +156,25 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
>                    VhostBackendType backend_type,
>                    uint32_t busyloop_timeout, Error **errp);
>
>+/**
>+ * vhost_dev_init_backend() - set up the backend and query its features
>+ * @hdev: the common vhost_dev structure
>+ * @opaque: opaque ptr passed to backend (vhost/vhost-user/vdpa)
>+ * @backend_type: type of backend
>+ * @errp: error handle
>+ *
>+ * Select the backend, initialise the backend instance and read its supported
>+ * features into @hdev, without issuing VHOST_SET_OWNER, setting up the
>+ * virtqueues or registering the memory listener.  This is the part of
>+ * vhost_dev_init() that precedes taking ownership; it can be used on its own
>+ * so feature negotiation can happen before ownership is acquired (e.g. by CPR
>+ * restore).

Should we mention that on error `vhost_dev_cleanup()` must be called, or 
maybe should we call it in the new function if vhost_dev_init_features() 
fails?

Thanks,
Stefano

>+ *
>+ * Return: 0 on success, non-zero on error while setting errp.
>+ */
>+int vhost_dev_init_backend(struct vhost_dev *hdev, void *opaque,
>+                           VhostBackendType backend_type, Error **errp);
>+
> /**
>  * vhost_dev_cleanup() - tear down and cleanup vhost interface
>  * @hdev: the common vhost_dev structure
>-- 
>2.47.1
>


