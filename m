Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99EDECA5FC1
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 09:13:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBqMz-0006Qs-PQ; Wed, 30 Sep 2026 05:12:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1xBqMy-0006Qj-6d
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 05:12:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1xBqMw-0004Rk-OR
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 05:12:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790759573;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BIxg+i1W+mpkA48z4+hpEIQwRCaxXK/vFw5WyU9SesU=;
 b=TD3sgxmUze4Mbn7gWZ9hoY3CVoX/wMMrwsupPgRF23N/cSPdA71q26z6yp8vk/LpxvpOQp
 hM6cpWtutr7L2ImMWKaav6u9Cx/pM329fLYZqRe0GC6Mk9fjPQWzzrZGsOjqfv+gSVdgf8
 gUmQs3O1ogJJFMegc+8PLVDtKiscWaU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-07ChYBebP2y_GUg9rfHq6A-1; Wed, 30 Sep 2026 05:12:51 -0400
X-MC-Unique: 07ChYBebP2y_GUg9rfHq6A-1
X-Mimecast-MFC-AGG-ID: 07ChYBebP2y_GUg9rfHq6A_1790759570
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4a019d53f46so3563815e9.3
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 02:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790759570; x=1791364370; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=BIxg+i1W+mpkA48z4+hpEIQwRCaxXK/vFw5WyU9SesU=;
 b=avXaBU3eT0PteQK0R77wyT8ullsPHoiEmwbjiaECOXmxLKG8mW5OzEySMhZQcuId7S
 ZLb8fQDeEAc4lN7zoMUptc7dTPWVnmWgjLYE6aO35rjTUdM0JDpqP+b5++b/bBawZxdN
 hmVwpenR5Zx6c9hhQWvoowrp6ZKHdP47dqvdkoFpNJSNOAYZnHg1UG0PZICMIt14i4iB
 4eatGwW/9ULxT22l1mBLrJCaHn8e/GxRHqbdehEKP44q0fn3eURm8Fw1tnLPfcH9DnRa
 i2xRu/PHLb5dGNfTKWI+2uxRubh8zDFYDdeAnHmGzIyg1havlUIkhmRFa71JS4lNXhgZ
 S5Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790759570; x=1791364370;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=BIxg+i1W+mpkA48z4+hpEIQwRCaxXK/vFw5WyU9SesU=;
 b=QXhl0XRRun5rRJxKG3EecKiWAywn51EaHs04zsh7Uhdm0Pb8Rnn/llTmwSk3elo2A3
 CuNU0AFFIvJhoOSjyGwlYf3NVKlXUfm9zGMDieyQ0KFOYYnhS5I01YC+M+ceVXxRaIhQ
 T7kbariMjVhsyliS+2g6R5Eb0gSbEUznj56UneM6a7PoxD9RfDihzq6tUs8F5I/WRXHe
 KSw0R9fWdjC+vSygTm7VPgukUlbVZ1jNcADpL37R2YT9OK2QenNrB+/IdcSTlcThsg7j
 Hvi/RR5QhDD7A1Xgr6v104UXCCbKtzBrwy29b1VATbIotsyUxrXYZRQ6VzVn2xJcc1UG
 RbsA==
X-Gm-Message-State: AFuF++m3L6eHB4mSbz6PmuY5nOo0S059inSYBcRvNmCN0iP3OIR70ih3
 kGGxOSrPO7eiaFyZHxYv1kws6INAv4ymigM6YdQQ7codR+Cvb4TBCf9BdUGAdXO9pgjtgAAbCEt
 FsITyH2xz9Tk2f4EEYkX+AXZtSkx5TmtrQF1raee9wYzsdKwhyEXDI4L/t8Tsunyp
X-Gm-Gg: AYBFou0c2YDcPow2sLKcT/DkWhNjT8V4ykL8RDvGu+SvzSWHtvbKAne+rcbuhR0Jp8F
 feSJwnzyhufMGZlZ1bZKJb1JJVrZRI/Suh1ZZoDxV0zHPxSjGh6a+Cjnl8kdGwOyxH4YpOyrXbi
 vyxsEwLTScDt2/fBjVcC7CGT3yuVEvvHDga8Z9e1SBP42sau+tcTPefg2spXyT9bGGkrtLp6vAe
 mGUl73RYF156evC5+rO03FhCRBbPjzl3LjJns9BERKUB/12wuisGRTuY/e1NpgHD1UgTukZJvus
 Z/XtuXD5WW2feGZ9V3Y6IedrA8Y0S0zdQPHCi0JjkQR3T7JXK8YJ9TT8D8G//zAOaD5Z1+vU4m4
 wSA==
X-Received: by 2002:a05:600d:82c1:b0:4a0:1723:2d8c with SMTP id
 5b1f17b1804b1-4a01ad8f18amr14791075e9.1.1790759570368; 
 Wed, 30 Sep 2026 02:12:50 -0700 (PDT)
X-Received: by 2002:a05:600d:82c1:b0:4a0:1723:2d8c with SMTP id
 5b1f17b1804b1-4a01ad8f18amr14790565e9.1.1790759569884; 
 Wed, 30 Sep 2026 02:12:49 -0700 (PDT)
Received: from sgarzare-redhat ([37.32.85.185])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a0174fb304sm35564965e9.11.2026.09.30.02.12.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 02:12:49 -0700 (PDT)
Date: Wed, 30 Sep 2026 11:12:43 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
Cc: qemu-devel@nongnu.org, 
 =?utf-8?Q?Cl=C3=A9ment?= Chigot <chigot@adacore.com>,
 "yc-core @ yandex-team . ru" <yc-core@yandex-team.ru>, 
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2] vhost: move skip-drain feature check to vhost-user
Message-ID: <arzRdh9uCzikGffU@sgarzare-redhat>
References: <20260929122223.2164612-1-dtalexundeer@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260929122223.2164612-1-dtalexundeer@yandex-team.ru>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
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

On Tue, Sep 29, 2026 at 05:22:23PM +0500, Alexandr Moshkov wrote:
>Currently, do_vhost_virtqueue_stop() calls
>vhost_user_has_protocol_feature(), causing a link failure with
>--disable-vhost-user when other vhost backends are enabled.
>
>Move the assertion to vhost_user_get_vring_base_skip_drain(), keeping
>the protocol feature check in the vhost-user backend and removing
>the dependency from the common vhost code.
>
>Reported-by: Clément Chigot <chigot@adacore.com>
>Fixes: 5eb2347867 ("vhost-user: add skip_drain param to do_vhost_virtqueue_stop")
>Signed-off-by: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
>---
>
>v1 -> v2:
> - Move the protocol feature assertion from do_vhost_virtqueue_stop()
>   to vhost_user_get_vring_base_skip_drain().
> - Drop the stub added in v1 and remove the unused vhost-user.h
>   include.
>
> hw/virtio/vhost-user.c | 4 +---
> hw/virtio/vhost.c      | 5 -----
> 2 files changed, 1 insertion(+), 8 deletions(-)
>
>diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
>index 65889b0776..84918c7265 100644
>--- a/hw/virtio/vhost-user.c
>+++ b/hw/virtio/vhost-user.c
>@@ -1463,9 +1463,7 @@ static int vhost_user_get_vring_base_skip_drain(struct vhost_dev *dev,
>     bool skip_drain_supported = vhost_user_has_protocol_feature(dev,
>                                VHOST_USER_PROTOCOL_F_GET_VRING_BASE_SKIP_DRAIN);
>
>-    if (!skip_drain_supported) {
>-        return 0;
>-    }
>+    assert(skip_drain_supported);

I'm still not sure if an assert is the right approach here, rather than 
returning -1 and letting the caller handle the error.

That said, the behavior remains the same as before, so:

Acked-by: Stefano Garzarella <sgarzare@redhat.com>

>
>     return get_vring_base(dev, ring, true);
> }
>diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
>index 68a8e40481..db8f246137 100644
>--- a/hw/virtio/vhost.c
>+++ b/hw/virtio/vhost.c
>@@ -23,7 +23,6 @@
> #include "qemu/log.h"
> #include "standard-headers/linux/vhost_types.h"
> #include "hw/virtio/virtio-bus.h"
>-#include "hw/virtio/vhost-user.h"
> #include "hw/mem/memory-device.h"
> #include "migration/blocker.h"
> #include "migration/qemu-file-types.h"
>@@ -1503,10 +1502,6 @@ static int do_vhost_virtqueue_stop(struct vhost_dev *dev,
>                                    unsigned idx, bool force,
>                                    bool skip_drain)
> {
>-    if (skip_drain) {
>-        assert(vhost_user_has_protocol_feature(dev,
>-               VHOST_USER_PROTOCOL_F_GET_VRING_BASE_SKIP_DRAIN));
>-    }
>     int vhost_vq_index = dev->vhost_ops->vhost_get_vq_index(dev, idx);
>     struct vhost_vring_state state = {
>         .index = vhost_vq_index,
>-- 
>2.34.1
>


