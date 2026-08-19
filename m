Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74322C5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 15:12:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwhxE-0001Sv-1Y; Wed, 19 Aug 2026 11:11:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wwhxB-0001SM-My
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 11:11:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wwhx9-00033x-PP
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 11:11:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787152301;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AQ4CVT/kSomTudkQ9V6/HoQoeU1RaSdLgLninz4795w=;
 b=VzkdoQNIsVXEa+P5Ju9A0PczQOuv26f3UwCf+fwUAjfKkcdxAwxPRKibMJd+VZpAUgvvCo
 mwFbmFTXDNCi5CuDg7rScUpMMdqK6ieDP8jOwOywo84FxMRLqU7sOTXbeSuomzHd+Ljgu+
 ssKPjyeGEkgaeLRqP3+72jLOCVbbl3s=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-567-NQ6xaJXmO5GbAxrV1GoUmA-1; Wed, 19 Aug 2026 11:11:40 -0400
X-MC-Unique: NQ6xaJXmO5GbAxrV1GoUmA-1
X-Mimecast-MFC-AGG-ID: NQ6xaJXmO5GbAxrV1GoUmA_1787152299
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-47f835ac1aeso744430f8f.3
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 08:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787152299; x=1787757099; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=AQ4CVT/kSomTudkQ9V6/HoQoeU1RaSdLgLninz4795w=;
 b=DksfVckMbo+eZkJyVmgFfVygL/lwP+OKZteICoXw5RO9ZUXh6P3fJl1XFZvE62UaP5
 jFNKafRudSm/oGwfOscSy3YnBfkYHrMZE8kElEjbfC87eFIkniTUFRciUCHG+6zln22e
 Rz4jxsA54GAxWmx24DpKx5Z0fq4We5Qku37kWKtC5MBNwd28X5Erdijr23tetNa3T54Q
 5/Vi+oHnAmYPpcdDjr+rOloOSN0D7ZO7kJD0aWt4zwtuD9/1KAI74DS6BYPdVMrMRNP6
 /erOgUHQkljzdZnM+Z4/w692zibt4TXIMzv6dE+bY9AkvwgsjD4J75QCeoSIFY8QQGEW
 YuJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787152299; x=1787757099;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=AQ4CVT/kSomTudkQ9V6/HoQoeU1RaSdLgLninz4795w=;
 b=IcpQVGsmVABMca82mXSItcd4MTx+GrOHKBC6bmDnAwbVpZiLyYojUUcfnYnb44MhVr
 BYxIgUXTixpjHZ/47NZtcAyRdDc3kq64kT3BPWQPcS13Ab/tfQSpxgw3rB8zgBadrDsN
 +wXUGRJaEDAsXvZA66F4GqF/X3yv3dBXhoFGfeBexzOB3JVk4veTET8o1afMplBVES/T
 p7Dy6IfIY65IneHLGbRr6lR2b5jcvdkx6YscGJXCwwOwSCfSN2vC3aUnSCuahj7d2ctv
 d/Yn6HsruIRV53uvoQI5pgV+bxhXj8XYJB8RRBThIian4O8YXssU28koixAoFa9qmP3K
 AsIQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoRPqq4MfNj3Rerz88jNQedr6om5F+B6doAt5hl0TKddjtKZ19c4MbXjIUDLjLFYUIfO8HBMCAJedMY@nongnu.org
X-Gm-Message-State: AFuF++lAUsuWs4n8WkdrBYn9kJHefkAdz47P4ahrShTGYXbCm15S46AV
 3Op2xBiDe+Vbfabw1IAlnKesA8KCYIqghF9YhuneG+SNDjmPkNGIvpsbtd/rsIvdEa1q+P64jQ1
 4s49tOwqN7yUzzFJXD6Yg+OEDgro0Em2YMnUNA6dKjh1uIZB1wCGCQNC9
X-Gm-Gg: AR+sD12WGFxBC55yIx4sssdvksNXq6DnMPeAgyOGRGjO2/lNiaCcOtP4UinV7K92IWx
 CG5GX4NMF0vB15L5BQSHtE5ucEwZO+avnT9K/9fKl3W4Bs3x9cG9Z06dkwb7L36hI5m5R/2yrpw
 I4eck11M7//TfyXQ5qEHfdY1J229ffGLhFF9QkJf6puFjUkgMBfhdCexZH6HBVM7fEYtMsTwb7f
 rOGEd7m6zZcs7Ezgu0mi3CplQwVQSLKKLMvKHXPFEhYy2bAefpPBDjwiiavgwBvvyvCDu7hxJvl
 BbJLy2zOjWuLCORtKap5dRaVN1darZ/svmrNhOLbpJLMJenaL7M7zWqwf7t67aa4OHeUibnXbkA
 c1LZy+meJJN6ycfTCuwy64iyV
X-Received: by 2002:a05:6000:4b0e:b0:47f:86af:8fdd with SMTP id
 ffacd0b85a97d-482b1e86146mr10542740f8f.3.1787152299030; 
 Wed, 19 Aug 2026 08:11:39 -0700 (PDT)
X-Received: by 2002:a05:6000:4b0e:b0:47f:86af:8fdd with SMTP id
 ffacd0b85a97d-482b1e86146mr10542588f8f.3.1787152298458; 
 Wed, 19 Aug 2026 08:11:38 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-47-107.inter.net.il. [80.230.47.107])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482b14c46f2sm7482364f8f.29.2026.08.19.08.11.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 08:11:37 -0700 (PDT)
Date: Wed, 19 Aug 2026 11:11:34 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>, qemu-devel@nongnu.org,
 farosas@suse.de, peterx@redhat.com, dongli.zhang@oracle.com,
 maciej.szmigiero@oracle.com, bchaney@akamai.com,
 mark.kanda@oracle.com, den@openvz.org
Subject: Re: [PATCH v3 4/7] vhost-vsock: preserve vhost FD during CPR
Message-ID: <20260819111110-mutt-send-email-mst@kernel.org>
References: <20260626164643.2526-1-andrey.drobyshev@virtuozzo.com>
 <20260626164643.2526-5-andrey.drobyshev@virtuozzo.com>
 <aoRyAqduT4FRj9NV@sgarzare-redhat>
 <bc812e7c-a30b-43f4-9803-26259bb3a65b@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc812e7c-a30b-43f4-9803-26259bb3a65b@virtuozzo.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
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

On Wed, Aug 19, 2026 at 05:38:46PM +0300, Andrey Drobyshev wrote:
> On 8/18/26 6:29 PM, Stefano Garzarella wrote:
> > On Fri, Jun 26, 2026 at 07:46:40PM +0300, Andrey Drobyshev wrote:
> >> During CPR (checkpoint-restore) migration the guest keeps running on the
> >> same host, so instead of reopening /dev/vhost-vsock on the destination,
> >> we should reuse the FD from the source.  The FD is saved in the CPR
> >> namespace (hash table) with cpr_save_fd() and then reclaimed on the
> >> target via cpr_find_fd().
> >>
> >> Since the key in CPR hash table is device ID, CPR needs a unique ID.
> >> Rather than make it mandatory for every vhost-vsock device, we add CPR
> >> migration blocker which only fires once we attempt CPR with ID-less
> >> vhost-vsock.
> >>
> >> vhost_dev_init() (and thus VHOST_SET_OWNER) still runs in realize() here.
> >> Deferring the ownership handoff to pre_save/post_load is done in a
> >> following patch.
> > 
> > So will this patch be bisectabale?
> > 
> > Thanks,
> > Stefano
> > 
> 
> The issue is that cpr-exec already is broken on the current master
> branch (i.e. before the series is applied).  The only difference is
> which exact error we fail with: -EBUSY or -EADDRINUSE.
> 
> In this case I don't think it's feasible to make each and every commit
> bisectable - it only becomes fully working after the last one applied.

Surely just bypassing cpr things until the last commit
is feasible?

> If you want, I can prepend the series with a migration blocker which
> would fail early and gracefully instead of crashing, and lift it after
> it's working.
> 
> Andrey
> 
> >>
> >> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> >> ---
> >> hw/virtio/vhost-vsock.c         | 50 ++++++++++++++++++++++++++++++---
> >> include/hw/virtio/vhost-vsock.h |  1 +
> >> 2 files changed, 47 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/hw/virtio/vhost-vsock.c b/hw/virtio/vhost-vsock.c
> >> index fd7ffa88990..7eacb608d07 100644
> >> --- a/hw/virtio/vhost-vsock.c
> >> +++ b/hw/virtio/vhost-vsock.c
> >> @@ -21,6 +21,8 @@
> >> #include "hw/virtio/vhost-vsock.h"
> >> #include "monitor/monitor.h"
> >> #include "migration/cpr.h"
> >> +#include "migration/blocker.h"
> >> +#include "migration/misc.h"
> >>
> >> static void vhost_vsock_get_config(VirtIODevice *vdev, uint8_t *config)
> >> {
> >> @@ -141,6 +143,7 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
> >>     VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(dev);
> >>     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
> >>     VHostVSock *vsock = VHOST_VSOCK(dev);
> >> +    DeviceState *proxy = qdev_get_parent_bus(DEVICE(vsock))->parent;
> >>     int vhostfd;
> >>     int ret;
> >>
> >> @@ -155,23 +158,49 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
> >>         return;
> >>     }
> >>
> >> -    if (vsock->conf.vhostfd) {
> >> +    /*
> >> +     * Having a unique ID is mandatory for FD preservation during CPR
> >> +     * migration, thus we add migration blockers for CPR modes.
> >> +     */
> >> +    if (!proxy->id) {
> >> +        error_setg(&vsock->migration_blocker,
> >> +                   "vhost-vsock: device ID is required for CPR migration");
> >> +        if (migrate_add_blocker_modes(&vsock->migration_blocker,
> >> +                                      BIT(MIG_MODE_CPR_TRANSFER) |
> >> +                                      BIT(MIG_MODE_CPR_EXEC), errp) < 0) {
> >> +            return;
> >> +        }
> >> +    }
> >> +
> >> +    if (cpr_is_incoming()) {
> >> +        /* Reuse the fd handed over from the source QEMU. */
> >> +        if (!proxy->id) {
> >> +            error_setg(errp, "vhost-vsock: device ID is required for "
> >> +                       "CPR migration");
> >> +            goto err_blocker;
> >> +        }
> >> +        vhostfd = cpr_find_fd(proxy->id, 0);
> >> +        if (vhostfd < 0) {
> >> +            error_setg(errp, "vhost-vsock: could not find restored vhost FD");
> >> +            goto err_blocker;
> >> +        }
> >> +    } else if (vsock->conf.vhostfd) {
> >>         vhostfd = monitor_fd_param(monitor_cur(), vsock->conf.vhostfd, errp);
> >>         if (vhostfd == -1) {
> >>             error_prepend(errp, "vhost-vsock: unable to parse vhostfd: ");
> >> -            return;
> >> +            goto err_blocker;
> >>         }
> >>     } else {
> >>         vhostfd = open("/dev/vhost-vsock", O_RDWR);
> >>         if (vhostfd < 0) {
> >>             error_setg_file_open(errp, errno, "/dev/vhost-vsock");
> >> -            return;
> >> +            goto err_blocker;
> >>         }
> >>     }
> >>
> >>     if (!qemu_set_blocking(vhostfd, false, errp)) {
> >>         close(vhostfd);
> >> -        return;
> >> +        goto err_blocker;
> >>     }
> >>
> >>     vhost_vsock_common_realize(vdev);
> >> @@ -192,6 +221,11 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
> >>         goto err_vhost_dev;
> >>     }
> >>
> >> +    /* Register the fd for a future CPR after a fully successful realize */
> >> +    if (proxy->id) {
> >> +        cpr_save_fd(proxy->id, 0, vhostfd);
> >> +    }
> >> +
> >>     return;
> >>
> >> err_vhost_dev:
> >> @@ -199,16 +233,24 @@ err_vhost_dev:
> >>     vhost_dev_cleanup(&vvc->vhost_dev);
> >> err_virtio:
> >>     vhost_vsock_common_unrealize(vdev);
> >> +err_blocker:
> >> +    migrate_del_blocker(&vsock->migration_blocker);
> >> }
> >>
> >> static void vhost_vsock_device_unrealize(DeviceState *dev)
> >> {
> >>     VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(dev);
> >>     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
> >> +    VHostVSock *vsock = VHOST_VSOCK(dev);
> >> +    DeviceState *proxy = qdev_get_parent_bus(dev)->parent;
> >>
> >>     /* This will stop vhost backend if appropriate. */
> >>     vhost_vsock_set_status(vdev, 0);
> >>
> >> +    if (proxy->id) {
> >> +        cpr_delete_fd(proxy->id, 0);
> >> +    }
> >> +    migrate_del_blocker(&vsock->migration_blocker);
> >>     vhost_dev_cleanup(&vvc->vhost_dev);
> >>     vhost_vsock_common_unrealize(vdev);
> >> }
> >> diff --git a/include/hw/virtio/vhost-vsock.h b/include/hw/virtio/vhost-vsock.h
> >> index 84f4e727c70..5ebc63afc5a 100644
> >> --- a/include/hw/virtio/vhost-vsock.h
> >> +++ b/include/hw/virtio/vhost-vsock.h
> >> @@ -29,6 +29,7 @@ struct VHostVSock {
> >>     /*< private >*/
> >>     VHostVSockCommon parent;
> >>     VHostVSockConf conf;
> >> +    Error *migration_blocker;   /* set when the device has no ID */
> >>
> >>     /*< public >*/
> >> };
> >> -- 
> >> 2.47.1
> >>
> > 


