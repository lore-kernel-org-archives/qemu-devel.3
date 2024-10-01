Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E2E0CEACC5
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2024 14:07:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svdWA-0002B1-Gq; Tue, 01 Oct 2024 10:06:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1svdVl-00022v-KO
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 10:05:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1svdVC-0000ot-0l
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 10:05:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727791518;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+3m7OVNpznujsu7qOxVL/uQtm7Rs8kTly7ode/QB05g=;
 b=UULYP7BbLDY0yuz+GvPbq/4+RAaLZyZltrDvheW92EqD07GRosQ8u/bYhRR2t7ntikSgay
 oO+K6YBUzDurQCJGr3tKjcXlBuXe9PAto5I1EcTTsG490+zwTNYM1vWQrIsHkzE6i46jdD
 FuODG7StZzUy+uvh+Kv05W9HG5nnP0s=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-33-oqw6LrByOBOxFrdfP8f6tA-1; Tue, 01 Oct 2024 07:53:05 -0400
X-MC-Unique: oqw6LrByOBOxFrdfP8f6tA-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7a9a85e4a85so1252325685a.0
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2024 04:53:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727783585; x=1728388385;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+3m7OVNpznujsu7qOxVL/uQtm7Rs8kTly7ode/QB05g=;
 b=eyRDuWBMvfTJ+SCKCL+yskntvyZGYIzQhLvxkGgKvYtt5kQFQibzYB5ZncyJVAIa2g
 S2rcYsw2BeKHqUltdJfywWFxhNE2H27PYdf41zGhM1tYMNSvaOqFQox+dxkaUtW3j/Zk
 ov5Tnm/NkDowdIP7GVCm/a5ybk83FPBrlRD3Y3CfkZtneL6auVqMfzFrDyogFFdwc6Xw
 BHPDxTIhi4PSpqFXZG6v47oQoDC3Wkr0fAhyHUINK1Kdi/6RmZ89KHmTHiE0MlyToaDW
 W4KCS7Yt5pOT4dO73Vb7W9mulExyKtwrNx67LNmcmhGo73kHPgHsg1CgoaqvXKdbV7Pj
 kW6Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCV4Tvr6G34NF5M+z6FiUfRcjYjVgmkmzRbjgQmu/qlGRJaN2wrKFnu5jbNDF0RbqdJLKgOfD1Yity@nongnu.org
X-Gm-Message-State: AOJu0YyptqT9K5AFnQlCzuVE+XttGMKpKVDa0YgFoteSeoE6bUK5kB7m
 GlIg4qepCzbPbx+EUwJoOq4OIHvw6xFCerkxxBtvtQObEghaeh0Ryro+kxF7C7Ag6/dl7ZXfmwJ
 OOgphV+/RWoek2LlObryBSjkRnpqiSdDLYvF5IvVkjoTyx29dvyrA0kXAABQ56XU=
X-Received: by 2002:a05:620a:408e:b0:7a9:c964:b32d with SMTP id
 af79cd13be357-7ae378dbcfbmr2447471785a.54.1727783585033; 
 Tue, 01 Oct 2024 04:53:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF43tzPuuDvAtWFQKjlBLhrSQo+sftQCCqO+G2BY2jqCQk/vAHXwKrdyhO5Y2282Uo5YSHfbw==
X-Received: by 2002:a05:620a:408e:b0:7a9:c964:b32d with SMTP id
 af79cd13be357-7ae378dbcfbmr2447468385a.54.1727783584529; 
 Tue, 01 Oct 2024 04:53:04 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-231.retail.telecomitalia.it.
 [79.46.200.231]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cb3b67f5efsm48992496d6.110.2024.10.01.04.53.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Oct 2024 04:53:03 -0700 (PDT)
Date: Tue, 1 Oct 2024 13:53:00 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: dave@treblig.org
Cc: mst@redhat.com, qemu-devel@nongnu.org
Subject: Re: [PATCH] vhost: Remove unused vhost_dev_{load|save}_inflight
Message-ID: <xyxixpzdemv6xrg7orqdz56mw7z4sphuuxv63igjnm5qdgblzh@v56b2we4ll3y>
References: <20240918121034.16417-1-dave@treblig.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240918121034.16417-1-dave@treblig.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Wed, Sep 18, 2024 at 01:10:34PM GMT, dave@treblig.org wrote:
>From: "Dr. David Alan Gilbert" <dave@treblig.org>
>
>vhost_dev_load_inflight and vhost_dev_save_inflight have been
>unused since they were added in 2019 by:
>
>5ad204bf2a ("vhost-user: Support transferring inflight buffer between qemu and backend")
>
>Remove them, and their helper vhost_dev_resize_inflight.
>
>Signed-off-by: Dr. David Alan Gilbert <dave@treblig.org>
>---
> hw/virtio/vhost.c         | 56 ---------------------------------------
> include/hw/virtio/vhost.h |  2 --
> 2 files changed, 58 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
>index 7c5ef81b55..76f9b2aaad 100644
>--- a/hw/virtio/vhost.c
>+++ b/hw/virtio/vhost.c
>@@ -1930,62 +1930,6 @@ void vhost_dev_free_inflight(struct vhost_inflight *inflight)
>     }
> }
>
>-static int vhost_dev_resize_inflight(struct vhost_inflight *inflight,
>-                                     uint64_t new_size)
>-{
>-    Error *err = NULL;
>-    int fd = -1;
>-    void *addr = qemu_memfd_alloc("vhost-inflight", new_size,
>-                                  F_SEAL_GROW | F_SEAL_SHRINK | F_SEAL_SEAL,
>-                                  &fd, &err);
>-
>-    if (err) {
>-        error_report_err(err);
>-        return -ENOMEM;
>-    }
>-
>-    vhost_dev_free_inflight(inflight);
>-    inflight->offset = 0;
>-    inflight->addr = addr;
>-    inflight->fd = fd;
>-    inflight->size = new_size;
>-
>-    return 0;
>-}
>-
>-void vhost_dev_save_inflight(struct vhost_inflight *inflight, QEMUFile *f)
>-{
>-    if (inflight->addr) {
>-        qemu_put_be64(f, inflight->size);
>-        qemu_put_be16(f, inflight->queue_size);
>-        qemu_put_buffer(f, inflight->addr, inflight->size);
>-    } else {
>-        qemu_put_be64(f, 0);
>-    }
>-}
>-
>-int vhost_dev_load_inflight(struct vhost_inflight *inflight, QEMUFile *f)
>-{
>-    uint64_t size;
>-
>-    size = qemu_get_be64(f);
>-    if (!size) {
>-        return 0;
>-    }
>-
>-    if (inflight->size != size) {
>-        int ret = vhost_dev_resize_inflight(inflight, size);
>-        if (ret < 0) {
>-            return ret;
>-        }
>-    }
>-    inflight->queue_size = qemu_get_be16(f);
>-
>-    qemu_get_buffer(f, inflight->addr, size);
>-
>-    return 0;
>-}
>-
> int vhost_dev_prepare_inflight(struct vhost_dev *hdev, VirtIODevice *vdev)
> {
>     int r;
>diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
>index c75be46c06..461c168c37 100644
>--- a/include/hw/virtio/vhost.h
>+++ b/include/hw/virtio/vhost.h
>@@ -338,8 +338,6 @@ void vhost_virtqueue_stop(struct vhost_dev *dev, struct VirtIODevice *vdev,
>
> void vhost_dev_reset_inflight(struct vhost_inflight *inflight);
> void vhost_dev_free_inflight(struct vhost_inflight *inflight);
>-void vhost_dev_save_inflight(struct vhost_inflight *inflight, QEMUFile *f);
>-int vhost_dev_load_inflight(struct vhost_inflight *inflight, QEMUFile *f);
> int vhost_dev_prepare_inflight(struct vhost_dev *hdev, VirtIODevice *vdev);
> int vhost_dev_set_inflight(struct vhost_dev *dev,
>                            struct vhost_inflight *inflight);
>-- 
>2.46.0
>
>


