Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C517CA5FB1
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 11:59:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBsxw-0006ce-8f; Wed, 30 Sep 2026 07:59:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1xBsxu-0006cU-UQ
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 07:59:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1xBsxt-0007Hq-01
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 07:59:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790769550;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=07ciruVm5OX/hN+ZhripZSF8CFH5ZWsjjNRw8gS04A8=;
 b=Q4Zv/GkspnWIwNFMwUACQcuoQ8DPUJxskE7ZklU4zbvZt2qlvI50X/t/chbm9g7fAYmAe2
 mBxe4N5TShgQacXU0NgTKtk/kH+MibNWurqdA6q6iqm2qWLlzdOxvxeYbZ1yjEzXv2+4wA
 vYRpfOU11OctJgnCRjx5ncakbT6vzIY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-99-u99Z6SEpOrOlntzqSFekxQ-1; Wed, 30 Sep 2026 07:59:09 -0400
X-MC-Unique: u99Z6SEpOrOlntzqSFekxQ-1
X-Mimecast-MFC-AGG-ID: u99Z6SEpOrOlntzqSFekxQ_1790769548
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-48afe000b94so945901f8f.3
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 04:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790769548; x=1791374348; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=07ciruVm5OX/hN+ZhripZSF8CFH5ZWsjjNRw8gS04A8=;
 b=KtKsAYG9BuD5sJXY/iTFpxCjRNPYtJGk+DsIj5X/uu6pALg4fxE6yOIf33wNYqWPdO
 0y0xyUGUOCbdEwFRsJfvmwTR/L63dh0HpuOeTdbvIEHukd3tRVYH8nGRXB+NRR+crvc9
 M2SpU5c/gGupNK8MPZbU6Zr4pI40TvtwyfHqY5Bn2XZu+3R/M4/v4LGUGZm8ip/ZqKQO
 ENK07E7TSqU4XwMPm+0pk9+e+fa9ZeJg52r1YDMOD/caAtV5u75xznzwZtj4aY7F0ivo
 8keVPb1eyyG8xSWG/VHOU2wxJdTcCJrv9hwAc8RxNHk3vgwdR3J0xYZC313vwE9qcdpv
 k9hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790769548; x=1791374348;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=07ciruVm5OX/hN+ZhripZSF8CFH5ZWsjjNRw8gS04A8=;
 b=VI+a39/29VksalhsTr7cmLwn6XRWigUc1fPlLjPZIpBGizjrzJIKHHhlTZOjTJUFpw
 QjElOhE1/Qsv7dc/wRSlBnIEYFvRUCWzqg+8lbQW88yBTdRx2No3bx6AaCwzKcRTXQ4q
 El5TcN6s5IsRvGS6sH5GAywXr0h4wzBpxEbC5LTdNjMq4HhQEpZ3K2gq3p2wEILym2qB
 XHgjo4kxVfz6BFe78G9KkQFDA4kri+cvSe+MQXJw8yYx6WJBE2vGPz6AwaR38+MD9fN9
 8sOQmWRWxgNxCk+67Gjd81T6HKpPEyuv5pP66sB+qv98toKEIsOWGsbPjNvGpKZQZ5tp
 MAiQ==
X-Gm-Message-State: AFq9FYI94vwZ/Vcx27Doyctv/nP+KLNwUmglGZXKriaKcieBi1jnL0iS
 aKnMcffrx4obPurrc3GBLXHObeUlkTlks3Lwc4KmvJgSbdT8vT+UzIMg6Eh23IKXGIzYueFVyeX
 StKL2kZF+qJ8HI1YoWZ4N/sQ+yVrxXU3VCKnWAPQTsZqrXhE6Dj0KoQHZ
X-Gm-Gg: AYBFou0FCUcpBcUii1DA2I95K7u+AXkqEqLeCHeaCe9wOkrC7xS39a+h08Ky/4bdw8B
 NscNTKKymdihZReOI/FT+ds2ZaXAIWEwvfVVcOrGiTgXkIk8Xdu9Oy+DIVXrwHfVLRnKCrGM8aV
 Io+vbkpHVoMosbncZkjFcJYEoNA921iE4ZXgW8i/zUSQNXwOg6dlhhQOhLlHzMTKQf3p/m7ZOsV
 13vwMsLdbD7aEszDOR4SBsZAWgYXn5pnJWNv+NWvrdFx10drEai039WLKQ5jnwgNmK8oOYEYrK+
 3Ga2hgtkOjRF6X4GXKUM/g+DhRr9x16TnkmIcG9TMtydX1sbqh4fd96QZBeCNc4Awao7Y56BJXp
 ZWQ==
X-Received: by 2002:a05:6000:2201:b0:488:8da2:4b16 with SMTP id
 ffacd0b85a97d-48b024283fdmr2510539f8f.8.1790769547741; 
 Wed, 30 Sep 2026 04:59:07 -0700 (PDT)
X-Received: by 2002:a05:6000:2201:b0:488:8da2:4b16 with SMTP id
 ffacd0b85a97d-48b024283fdmr2510496f8f.8.1790769547272; 
 Wed, 30 Sep 2026 04:59:07 -0700 (PDT)
Received: from sgarzare-redhat ([37.32.85.185])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b029e213bsm3122958f8f.19.2026.09.30.04.59.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 04:59:05 -0700 (PDT)
Date: Wed, 30 Sep 2026 13:58:59 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: qemu-devel@nongnu.org, clg@redhat.com, mst@redhat.com, 
 maciej.szmigiero@oracle.com, dongli.zhang@oracle.com, bchaney@akamai.com, 
 philmd@oss.qualcomm.com, odaki@rsg.ci.i.u-tokyo.ac.jp, farosas@suse.de, 
 mark.kanda@oracle.com, dwmw2@infradead.org, peterx@redhat.com, 
 vsementsov@yandex-team.ru, den@openvz.org
Subject: Re: [PATCH v9 15/18] vhost: release ownership if vhost_dev_init()
 fails after SET_OWNER
Message-ID: <arziIHF39t15dVoc@sgarzare-redhat>
References: <20260930-up-vsock-vhost-v5-v9-0-e9096f629770@virtuozzo.com>
 <20260930-up-vsock-vhost-v5-v9-15-e9096f629770@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260930-up-vsock-vhost-v5-v9-15-e9096f629770@virtuozzo.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
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

On Wed, Sep 30, 2026 at 01:13:14PM +0300, Andrey Drobyshev wrote:
>vhost_dev_init() takes the device ownership with VHOST_SET_OWNER and
>then may still fail, e.g. on virtqueue init.  Its cleanup only closes
>the backend fd, which doesn't release the ownership if the same file
>is open elsewhere.  That's the case on a CPR target: the source keeps
>the fd, and once it's resumed after the failed migration it can't take
>the device back, SET_OWNER fails with EBUSY.
>
>Release the ownership explicitly on the failure paths past SET_OWNER.
>
>Reported-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>---
> hw/virtio/vhost.c | 10 ++++++----
> 1 file changed, 6 insertions(+), 4 deletions(-)

If you have to send another version, maybe better to move the 
introduction of vhost_dev_reset_owner() in this patch since IIUC this is 
the first place where we use it. (not a strong opinion)

That said, what happen if the caller of vhost_dev_init() fails after 
calling it? Who will call vhost_dev_reset_owner()?

E.g. in vhost_vsock_post_load(), if vhost_vsock_set_guest_cid() fails, 
should we call vhost_dev_reset_owner()?

Since IIUC all error paths call vhost_dev_cleanup(), might it make sense 
to call vhost_dev_reset_owner() there?

Thanks,
Stefano

>
>diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
>index c01ccc800cb..3ff54879068 100644
>--- a/hw/virtio/vhost.c
>+++ b/hw/virtio/vhost.c
>@@ -1754,7 +1754,7 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
>         error_append_hint(errp, "Try plugging this vhost backend before"
>             " plugging such memory devices.\n");
>         r = -EINVAL;
>-        goto fail;
>+        goto fail_owner;
>     }
>
>     for (i = 0; i < hdev->nvqs; ++i, ++n_initialized_vqs) {
>@@ -1762,7 +1762,7 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
>                                  busyloop_timeout);
>         if (r < 0) {
>             error_setg_errno(errp, -r, "Failed to initialize virtqueue %d", i);
>-            goto fail;
>+            goto fail_owner;
>         }
>     }
>
>@@ -1799,7 +1799,7 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
>     if (hdev->migration_blocker != NULL) {
>         r = migrate_add_blocker_normal(&hdev->migration_blocker, errp);
>         if (r < 0) {
>-            goto fail;
>+            goto fail_owner;
>         }
>     }
>
>@@ -1831,7 +1831,7 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
>                    " than current number of used (%d) and reserved (%d)"
>                    " memory slots for memory devices.", limit, used, reserved);
>         r = -EINVAL;
>-        goto fail;
>+        goto fail_owner;
>     }
>
>     hdev->initialized = true;
>@@ -1840,6 +1840,8 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
>
>     return 0;
>
>+fail_owner:
>+    vhost_dev_reset_owner(hdev);
> fail:
>     hdev->nvqs = n_initialized_vqs;
>     vhost_dev_cleanup(hdev);
>
>-- 
>2.47.1
>


