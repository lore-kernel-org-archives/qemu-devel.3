Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0251DCC6B27
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 08:51:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGuhT-0003C3-V5; Wed, 14 Oct 2026 04:51:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1xGuhR-0003BV-MZ
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 04:51:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1xGuhP-0004xk-VK
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 04:51:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791967859;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EJIA3IT7xY7oKcwuics0xcQiUIz03MxxhhsnxtgHAVY=;
 b=OrP1+7hcVuW0ObU5RMb1E8p8HVGXjxIvwAGiZC2HYP4L5tHAVdTgG+69Qyfydk/9TUslSW
 WgYQsyoLKxDM9ngkKvDOj0zEURKWMVnQBaGJaybX9ezeznhIXDTJ/1RfL3pMHA2eMTDhpe
 UHrJy9bGFjNGAy8BdB7FCVW00Dh4R1M=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-511-xcB4JaNLOFia31c5J02NdA-1; Wed, 14 Oct 2026 08:50:57 +0000
X-MC-Unique: xcB4JaNLOFia31c5J02NdA-1
X-Mimecast-MFC-AGG-ID: xcB4JaNLOFia31c5J02NdA_1791967856
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4a0761224e1so6490025e9.0
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 01:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1791967856; x=1792572656; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=EJIA3IT7xY7oKcwuics0xcQiUIz03MxxhhsnxtgHAVY=;
 b=rm9Y9ANy+cILarZ1KAAIFZFyR4FsV+MCp5wqNgpKYU/tIlokyZQU8PBWwS7jQYZ6NE
 fBiGIG7+JMltq7CVCJTT+znrYTyFWfg8Ld1ac9om+35lsI4BVI6OpzIo3UrfEPJFEawD
 t0TTFl81Zh5A3TENR4Y1Ho8yFcaF5JiSborrQ2hGSALYiUApFHbRMaCLvsfykX69yPng
 gfxdUUUfGuuqM6EtU6HFyL3sOrEOUqQ00tErwzQlQClGD24xcI+gnsY7eE+BwPF35MWd
 8AQF2yvSSD2R/ZxPL/siwbiWYx+ImFDnyqas5NcH8uMn+DT8grRE/F8EBP/Tg8TgnSyF
 AOZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791967856; x=1792572656;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EJIA3IT7xY7oKcwuics0xcQiUIz03MxxhhsnxtgHAVY=;
 b=Pjfh9Ytd2mGdigKRb1mwtRJMhQhn/psIE7C/02sVmpM+jMth3R0WkTISiid+/JoY37
 9hj8WQGKqbvxq20wRJ636B3bCcdzGOpVKAT3vlmFx7vmruBiaEnPzaQlrCIUZYQYqT1F
 qNv227yOvMj3u+gXJ0BS1zrIeANV9J0tNbci41iSu4KjAwXZlCz0jZ4wCtqXjmUCISUq
 ej1YX/uD7VSgp3OL/agfW1rK4t9bBABpo0JLy3zc6l/UH7NsRAPI0/jA9agK/GQ8MZrw
 bfmwNOUP7/VjKypPiM0q8/FfCKk4jsvPNX9hr+FcbyAilz8/wK//8FHaXuC6gd9XuP8I
 /kRQ==
X-Gm-Message-State: AFq9FYIE4KVrxCPaOJbMGrrjfNwOiu52XfY2dZ1cl1g1Kk712l3iTdav
 u58+XgKUPfOf5d3VH1GUjQP5+e+sDJEmQtmMcyLpHmvuRnkP9wrpAqC0yfQJs0nvWbpahwlj3yx
 chhASBXPsPczR3YnDtyaD2BNxhwV6HsgQG59Z6rzDzZu3/aV9QewTHCZ9
X-Gm-Gg: AYBFou0Xxz05QHPL/sATgZ0yJwpNXfjgP9r6wZQmNcIL1tkXiuAkOYwvp2Nozd3pG/t
 QbwB8DqGxMF2k8xTD9sfYLN4pd2/Kn/Np8ZK7MWT3ETR7kfFguA5oKCirnri3ZUSxcbH0G1o9sw
 xzqnt19i5ovSokr+ztCD6E1CSF+Kr3dqYNk8/9YwPQjFM6yLzg/UW7XI0lT/oexAd+p2QGd/G2g
 KGd3W85ardeW7bkFXHZspybryWW+HG+Cu8BIkXG1oP+8oRIvK53YQJcQkHUCu+6WNBwZPk3+uY2
 wOPsQmwYKdkljk+yQ9wRLX289vsZXTWDl4twfr7iAQCPavBwmeWMrTNKgXPBhBtZG1wt9PKBE3j
 qC84Z0A==
X-Received: by 2002:a05:600c:8b09:b0:4a1:6f78:842f with SMTP id
 5b1f17b1804b1-4a18e4987b8mr313236755e9.11.1791967855766; 
 Wed, 14 Oct 2026 01:50:55 -0700 (PDT)
X-Received: by 2002:a05:600c:8b09:b0:4a1:6f78:842f with SMTP id
 5b1f17b1804b1-4a18e4987b8mr313236425e9.11.1791967855329; 
 Wed, 14 Oct 2026 01:50:55 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.168.237])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18be964dfsm422020365e9.7.2026.10.14.01.50.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 01:50:54 -0700 (PDT)
Date: Wed, 14 Oct 2026 10:50:49 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: qemu-devel@nongnu.org, odaki@rsg.ci.i.u-tokyo.ac.jp, 
 bchaney@akamai.com, mst@redhat.com, maciej.szmigiero@oracle.com, 
 mark.kanda@oracle.com, vsementsov@yandex-team.ru, clg@redhat.com,
 den@openvz.org, 
 dongli.zhang@oracle.com, farosas@suse.de, peterx@redhat.com,
 dwmw2@infradead.org, philmd@oss.qualcomm.com
Subject: Re: [PATCH v16 15/22] vhost: release ownership in vhost_dev_cleanup()
Message-ID: <as9BSKwxUUS8psaV@sgarzare-redhat>
References: <20261012-up-vsock-vhost-v5-v16-0-36c38bd15ffc@virtuozzo.com>
 <20261012-up-vsock-vhost-v5-v16-15-36c38bd15ffc@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20261012-up-vsock-vhost-v5-v16-15-36c38bd15ffc@virtuozzo.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

On Mon, Oct 12, 2026 at 01:28:23PM +0300, Andrey Drobyshev wrote:
>vhost_dev_cleanup() closes the backend FD, but that doesn't release the
>device ownership taken with VHOST_SET_OWNER if the same file is open
>elsewhere.  That's the case on a CPR target: the source keeps the FD,
>so if the target fails after SET_OWNER, either inside vhost_dev_init()
>or later in its caller, the ownership stays with the target.  Once the
>source is resumed it can't take the device back, SET_OWNER fails with
>EBUSY.
>
>Track the ownership with a new 'owner' flag in struct vhost_dev, set and
>cleared by vhost_dev_set_owner() and vhost_dev_reset_owner(), and issue
>VHOST_RESET_OWNER in vhost_dev_cleanup() as the common teardown for all
>those paths.  Only do it if the ownership was handed over to us by
>another process, which is marked by the device with a new bool flag
>'owner_handed_over'.  Upon ownership release failure, we have nothing to
>unwind at this point (CPR target teardown), so we just report the failure.
>
>Reported-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>---
> hw/virtio/vhost.c         | 40 ++++++++++++++++++++++++++++++++++++++--
> include/hw/virtio/vhost.h | 11 +++++++++++
> 2 files changed, 49 insertions(+), 2 deletions(-)
>
>diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
>index c01ccc800cb..085e2ef6f16 100644
>--- a/hw/virtio/vhost.c
>+++ b/hw/virtio/vhost.c
>@@ -53,6 +53,25 @@ static QLIST_HEAD(, vhost_dev) vhost_log_devs[VHOST_BACKEND_TYPE_MAX];
> static QLIST_HEAD(, vhost_dev) vhost_devices =
>     QLIST_HEAD_INITIALIZER(vhost_devices);
>
>+/*
>+ * Release the device ownership if it was handed over to us by another
>+ * process, e.g. the CPR source.
>+ */
>+static void vhost_dev_try_release_owner(struct vhost_dev *hdev,
>+                                        const char *when)
>+{
>+    int r;
>+
>+    if (!hdev->owner || !hdev->owner_handed_over) {
>+        return;
>+    }
>+    r = vhost_dev_reset_owner(hdev);
>+    if (r < 0) {
>+        error_report("vhost: cannot release device ownership on %s: %s",
>+                     when, strerror(-r));
>+    }
>+}
>+
> unsigned int vhost_get_max_memslots(void)
> {
>     unsigned int max = UINT_MAX;
>@@ -1705,20 +1724,32 @@ int vhost_dev_init_backend(struct vhost_dev *hdev, void *opaque,
>
> int vhost_dev_set_owner(struct vhost_dev *hdev)
> {
>+    int r;
>+
>     assert(hdev->vhost_ops);
>     if (!hdev->vhost_ops->vhost_set_owner) {
>         return -ENOSYS;
>     }
>-    return hdev->vhost_ops->vhost_set_owner(hdev);
>+    r = hdev->vhost_ops->vhost_set_owner(hdev);
>+    if (!r) {
>+        hdev->owner = true;
>+    }
>+    return r;
> }
>
> int vhost_dev_reset_owner(struct vhost_dev *hdev)
> {
>+    int r;
>+
>     assert(hdev->vhost_ops);
>     if (!hdev->vhost_ops->vhost_reset_owner) {
>         return -ENOSYS;
>     }
>-    return hdev->vhost_ops->vhost_reset_owner(hdev);
>+    r = hdev->vhost_ops->vhost_reset_owner(hdev);
>+    if (!r) {
>+        hdev->owner = false;
>+    }
>+    return r;
> }
>
> int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
>@@ -1864,6 +1895,11 @@ void vhost_dev_cleanup(struct vhost_dev *hdev)
>     g_free(hdev->mem);
>     g_free(hdev->mem_sections);
>     if (hdev->vhost_ops) {
>+        /*
>+         * Release the device ownership if we hold it.  Needed e.g. for
>+         * failing CPR target, so the source can re-acquire it.
>+         */
>+        vhost_dev_try_release_owner(hdev, "cleanup");
>         hdev->vhost_ops->vhost_cleanup(hdev);
>     }
>     assert(!hdev->log);
>diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
>index 73ea130d7ee..efe1eed2606 100644
>--- a/include/hw/virtio/vhost.h
>+++ b/include/hw/virtio/vhost.h
>@@ -111,6 +111,17 @@ struct vhost_dev {
>     bool started;
>     /* @initialized: has the full vhost_dev_init() completed? */
>     bool initialized;
>+    /*
>+     * @owner: has this vhost_dev acquired the device ownership?
>+     * Updated only by vhost_dev_set_owner()/vhost_dev_reset_owner()
>+     */
>+    bool owner;
>+    /*
>+     * @owner_handed_over: CPR target side.  The ownership was handed over
>+     * to us by another process (the CPR source) and must be given back
>+     * when this vhost_dev goes away.  Set by the device.
>+     */
>+    bool owner_handed_over;

I find the name a bit hard to get, but I don't have better suggestions.

Anyway:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>     bool log_enabled;
>     uint64_t log_size;
>     Error *migration_blocker;
>
>-- 
>2.47.1
>


