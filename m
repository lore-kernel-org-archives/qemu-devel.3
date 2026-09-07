Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3D58C79FA0
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 14:55:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3akX-0001Zm-2L; Mon, 07 Sep 2026 10:55:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1x3akV-0001Z9-EH
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 10:55:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1x3akT-0001ai-UM
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 10:55:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788792905;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=G+9rv+9xOrdLYquYQIEns/8oMZu3LYjSqVONcKO73Is=;
 b=Be8YhUHzTsN4/rOZungESY167g3cbFNBch7TjSGW7UNWrZPHtPTxoI5qfgf1PEzynN31Eo
 AuZfNi2Kf/bCeU5isV4gXYb1vCbKVWEOpGwVs6QyzBig00l4lpdR/cXKnTT6YZOTP9hxVm
 ff5uuMlHVlIPuJVEQeVW8sWKCyf54cE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-510-LqInhqOJMEqxoRKZnYHj5A-1; Mon, 07 Sep 2026 10:55:03 -0400
X-MC-Unique: LqInhqOJMEqxoRKZnYHj5A-1
X-Mimecast-MFC-AGG-ID: LqInhqOJMEqxoRKZnYHj5A_1788792903
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-484362cb000so2488488f8f.0
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2026 07:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788792902; x=1789397702; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=G+9rv+9xOrdLYquYQIEns/8oMZu3LYjSqVONcKO73Is=;
 b=CStMHVs/JIaGXx3b/qhLe8s08ZII3qtaDVu8KyTMLP3sf3HtCckuvgpaztc+m++2MF
 US06gBz9gkBt4BRMJyFV8bfhEh7HuqhnBGtvBH2h5yZhzNrFeEjTKRYLpQ8AFq3P5KJx
 c9cUX3URjFW+DqHcPkqHzRzJs2RpxS8XxtBTJ96uiHFR7h9GdVlgQ7VKfx+LPtWJPmZ9
 Xj4ohbYSnns2JuXlCamsx0RedFAT+YHCmcDcedayI2zn7T/HlvO8J03XasB5ssp5sFND
 mHR8p+JEbBz6ncWDZZmtCHwJ4Z/tyWzLTjhci97CJfafNsYQROajh+VVDJ6QM6gwEzVj
 HLnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788792902; x=1789397702;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=G+9rv+9xOrdLYquYQIEns/8oMZu3LYjSqVONcKO73Is=;
 b=BLcWdUOU+F83iURyFPnXeIpBT18+tnGwJTcaQvDUAd86RePsTFyYh831DQvaT1MGsM
 G1Kq9B1E4kkBcTITohrW39EavtLVzh0vsfc3astUECFy89pXGYAr7meoZMn0v0rhYo+w
 4L3oD9Otke8ID0r7t70a8xrCeYWav8aIL1yGoCG3F4PwcX/tia0a0D0N3aA3Sd2V+EUI
 TyAHXZOO13WOYJ/M3wyGXOYDIAGm3ZK0Gs/wt8A+nuYPhd7WCnlzEgVqe6FXVx8vxGiH
 Zuqppbkt1VNrk6xQ4f0jsgRgKDOQAjPjJanb3R0bkAzhbdEwviBR5O3vmqL9v5GXyhbo
 RdLg==
X-Gm-Message-State: AFuF++n1erUU2ENdMQU13+7j7vDjh/nK4G0X49FbMZX/dfX0+/JXPm/O
 fHJB4e8238uSnf5nCVV/atuROTi8GcMT9BSScBnGf0vwe1Cc3n5bEBJsha6Qw5qVse0ms9s/hLO
 r1zaEbwXqHqxHuPU/bo7iKps8pkt9t1x5NNV3KYxM5vJ3FeHIg0dGTkQD
X-Gm-Gg: AYBFou2RIQFN2OOdojIa3UjRzoJdvQmQQXCUsbILHslmiX+5ASK6tk8xps08fjl4o1Y
 tDapUfUZtKde6V+njeSYZ9Bj83Xn2Jcp/XgT8JZ2BH3ubCA9EaNA7RZ+5/dTAmYYbX8Tkf2t1l9
 OEccY8dlDef3yil/RcQK9M4nRgX6oPGzFbK6oDdD7p61OJ5CsD/04wgTBc97Lch4/cs4Tc3g56l
 bj39B9VhqMBxBpqwQMY7ep9Jqzp0wjZ6znX0ahXqASHwdQYBQYmsAWoJYGoNxiFKbI72i6abdou
 dMDTX3oyUjZ0PpzDA3H6Cfq3Rgz3gDW6SXhuAXr6DdVRyrZJSQ2PGURZ4fJN3CRpuIyCIyqgK2/
 lds4ltGYPzP9jKABB53UqOEEk2vgjd84HP6ObO70bJMHjmg==
X-Received: by 2002:a5d:5e88:0:b0:485:97ca:376 with SMTP id
 ffacd0b85a97d-48597ca0632mr10068414f8f.2.1788792902582; 
 Mon, 07 Sep 2026 07:55:02 -0700 (PDT)
X-Received: by 2002:a5d:5e88:0:b0:485:97ca:376 with SMTP id
 ffacd0b85a97d-48597ca0632mr10068376f8f.2.1788792902173; 
 Mon, 07 Sep 2026 07:55:02 -0700 (PDT)
Received: from sgarzare-redhat (host-79-53-30-11.retail.telecomitalia.it.
 [79.53.30.11]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4858d312ca0sm29134460f8f.4.2026.09.07.07.55.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 07:55:01 -0700 (PDT)
Date: Mon, 7 Sep 2026 16:54:59 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, farosas@suse.de, 
 peterx@redhat.com, dongli.zhang@oracle.com, maciej.szmigiero@oracle.com, 
 bchaney@akamai.com, mark.kanda@oracle.com, den@openvz.org
Subject: Re: [PATCH v4 04/10] vhost-vsock: fix FD leak in realize()
Message-ID: <ap7Eg7mTIcI97y-z@sgarzare-redhat>
References: <20260820113955.509478-1-andrey.drobyshev@virtuozzo.com>
 <20260820113955.509478-5-andrey.drobyshev@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260820113955.509478-5-andrey.drobyshev@virtuozzo.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
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

On Thu, Aug 20, 2026 at 02:39:49PM +0300, Andrey Drobyshev wrote:
>In vhost_vsock_device_realize(), after unsuccessful call to
>qemu_set_blocking(vhostfd, false), vhostfd gets leaked.  Let's close it
>explicitly in this case.  CPR-saved FDs don't get automatically closed,
>thus it is safe both for vhostfd obtained from cpr_find_fd() and from
>open(/dev/vhost-vsock).
>

Fixes tag?

>Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>---
> hw/virtio/vhost-vsock.c | 11 ++++-------
> 1 file changed, 4 insertions(+), 7 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/hw/virtio/vhost-vsock.c b/hw/virtio/vhost-vsock.c
>index c582ac9fcc8..3ec20d87606 100644
>--- a/hw/virtio/vhost-vsock.c
>+++ b/hw/virtio/vhost-vsock.c
>@@ -176,20 +176,17 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
>             error_prepend(errp, "vhost-vsock: unable to parse vhostfd: ");
>             goto err_blocker;
>         }
>-
>-        if (!qemu_set_blocking(vhostfd, false, errp)) {
>-            goto err_blocker;
>-        }
>     } else {
>         vhostfd = open("/dev/vhost-vsock", O_RDWR);
>         if (vhostfd < 0) {
>             error_setg_file_open(errp, errno, "/dev/vhost-vsock");
>             goto err_blocker;
>         }
>+    }
>
>-        if (!qemu_set_blocking(vhostfd, false, errp)) {
>-            goto err_blocker;
>-        }
>+    if (!qemu_set_blocking(vhostfd, false, errp)) {
>+        close(vhostfd);
>+        goto err_blocker;
>     }
>
>     vhost_vsock_common_realize(vdev);
>-- 
>2.47.1
>


