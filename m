Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C820C5DF81
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 18:54:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwlQO-0005Bs-SY; Wed, 19 Aug 2026 14:54:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wwlQN-0005B2-Rp
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 14:54:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wwlQL-0007M3-Rj
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 14:54:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787165645;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ssBty+LKd3e/m5gwO+2BUBq1xgdaYvPqCvsI8h3OFmY=;
 b=TgDOyPDXKpF4nRK6VQTeSoJuDKqQLNshCFN+x1L7PO+UGax9ptxhsbsdgv8/Xl1t+qIGjJ
 KOrweyW8eKJRs7A+uDbQ0bjLBiUQ60yIgit3DgWtPdldkPh2aB8xHoIOxMfgUe+Rbo+VcC
 v62QgujPRguNdYdcLgfZ1mWvQOC1sn8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-57-X0CTbz75OhigUrvawHhW6g-1; Wed, 19 Aug 2026 14:53:58 -0400
X-MC-Unique: X0CTbz75OhigUrvawHhW6g-1
X-Mimecast-MFC-AGG-ID: X0CTbz75OhigUrvawHhW6g_1787165637
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-496bbcf7d1eso10870515e9.0
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 11:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787165637; x=1787770437; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ssBty+LKd3e/m5gwO+2BUBq1xgdaYvPqCvsI8h3OFmY=;
 b=S1qdg7IWs/zDaCZZREMJ3tyMcTOJC8hQ2uv95lGV4/FSsk8lpblPaAooOo4zXYQ8Zu
 D3OaPoCCrIlkcv8YWGJcU7K5uT9CoDmzhFsu66ZEpFK9rHxdgSUL20qzGAsvZZpTt1/s
 AcTXbzUPaaaBcAor2UmygCSzLj/AhQAxQRQBwL+9RLwW8qyj+Ccr6XpRSY+hzGxZV67b
 g7Bm7uDypLk+6W+LRVv/dGSvw50ldxvqrW0rNygigXju8o07FKfpqu6RJ5YF/3Q2N9UO
 qWDOFj8+UZkkfvia7YvPYvtnyWwDJW7s/cy0Gi3PDhf9HCRfJm7sm2Ue19gWG6v6r74t
 W0lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787165637; x=1787770437;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ssBty+LKd3e/m5gwO+2BUBq1xgdaYvPqCvsI8h3OFmY=;
 b=GjP31/5BOAoJAsP/Y8BOwmPBfJwqazavbDYsVm+qxBgTsa891VAujevM2oO/iFvXhy
 tDtdE9BESBo9/5bDBaXbtL5PMJp1/VJ3OGeSGFAn2uzyMtWJolZrBjfGU+ipR6HYRbra
 rudF1lfixRz00s7TBTckmtpSgkhq7SxxbzNpG9FZYj7le5tF5jN1c229mUuJP0yclOYn
 56s+ZdhhiluOrMzZ7N9tUmDf3KM0NUTWI2n2ZOlwKhs/ErEy9DkSLL733BADlSh0kLKq
 3RwTkyFREc0ZKwXuVb8wGQOiLvKMlO7kDg1MIhrJ2SCt5cRxwkftNgbbWR/yIE6erptC
 eTyQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqUf3b8gtpLZ/3nReS/pPP88NBg6GVazvv4hruqBRNvlcBglYw1KyQqA1NzuNTbjGBnR7LWcAd4aNUf@nongnu.org
X-Gm-Message-State: AOJu0YzZ8LsXfxvmdi/QmEMuZaOPhZh6Mj55rZC/F2NS46HhN+bpBCh0
 M3LG4BHAD1t4YVQvaQ6Gzo3P1JFjnQ0yEySAfSDB+w2Tjml8ui+h4KgAL2Tq9y3asJ9O2PJO382
 jkR6Alq0OdHEtbizT+Lwg0dv47++QiQfoYvSXo7fKIfUlYUEJmJ+jAYmv
X-Gm-Gg: AR+sD11tIbSf1tl30XCUiTluQXZh8vyjZhtk4P6icccIqIm9KQOgsch2vVJrZope7qP
 +lfp/se6wCrcEy2BFjSMduKi1u2M3zv7Ioav0uokl2yw5vN1orfERcw7V4irdT/rwTcL1X5vn0O
 YVF2tBHLO63IRCPfgftv6S0Ly49N4m7Rm+NPsfiasLh8WsonrH9ZNoyanigQTvfq1r05orm4z5v
 HSMTClCXgLx1SvdnSifhHjNY+SJA2E+Fl1CMm7K9hieVNTvfjD9MGXkSKTkIQ0pM2toHe5mO+m3
 AAsfbMNbaKzWO+iTYm6bB/TmjSLugM0U7Lza9z0HvEFgRfUbrml51Hp/k1pA4SKyMkB6VDswJAI
 kICkRN14LDYl1XSdiqePa1Rm7
X-Received: by 2002:a05:600c:4e94:b0:499:78b3:7b36 with SMTP id
 5b1f17b1804b1-499aa1b549cmr124008085e9.11.1787165637358; 
 Wed, 19 Aug 2026 11:53:57 -0700 (PDT)
X-Received: by 2002:a05:600c:4e94:b0:499:78b3:7b36 with SMTP id
 5b1f17b1804b1-499aa1b549cmr124007395e9.11.1787165636766; 
 Wed, 19 Aug 2026 11:53:56 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-47-107.inter.net.il. [80.230.47.107])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482b14b7d23sm7633008f8f.22.2026.08.19.11.53.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 11:53:55 -0700 (PDT)
Date: Wed, 19 Aug 2026 14:53:52 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>, qemu-devel@nongnu.org,
 farosas@suse.de, peterx@redhat.com, dongli.zhang@oracle.com,
 maciej.szmigiero@oracle.com, bchaney@akamai.com,
 mark.kanda@oracle.com, den@openvz.org
Subject: Re: [PATCH v3 4/7] vhost-vsock: preserve vhost FD during CPR
Message-ID: <20260819145140-mutt-send-email-mst@kernel.org>
References: <20260626164643.2526-1-andrey.drobyshev@virtuozzo.com>
 <20260626164643.2526-5-andrey.drobyshev@virtuozzo.com>
 <aoRyAqduT4FRj9NV@sgarzare-redhat>
 <bc812e7c-a30b-43f4-9803-26259bb3a65b@virtuozzo.com>
 <20260819111110-mutt-send-email-mst@kernel.org>
 <dc56f46b-08c0-4a51-b5e9-5d17c3bdab17@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc56f46b-08c0-4a51-b5e9-5d17c3bdab17@virtuozzo.com>
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

On Wed, Aug 19, 2026 at 06:22:47PM +0300, Andrey Drobyshev wrote:
> On 8/19/26 6:11 PM, Michael S. Tsirkin wrote:
> > On Wed, Aug 19, 2026 at 05:38:46PM +0300, Andrey Drobyshev wrote:
> >> On 8/18/26 6:29 PM, Stefano Garzarella wrote:
> >>> On Fri, Jun 26, 2026 at 07:46:40PM +0300, Andrey Drobyshev wrote:
> >>>> During CPR (checkpoint-restore) migration the guest keeps running on the
> >>>> same host, so instead of reopening /dev/vhost-vsock on the destination,
> >>>> we should reuse the FD from the source.  The FD is saved in the CPR
> >>>> namespace (hash table) with cpr_save_fd() and then reclaimed on the
> >>>> target via cpr_find_fd().
> >>>>
> >>>> Since the key in CPR hash table is device ID, CPR needs a unique ID.
> >>>> Rather than make it mandatory for every vhost-vsock device, we add CPR
> >>>> migration blocker which only fires once we attempt CPR with ID-less
> >>>> vhost-vsock.
> >>>>
> >>>> vhost_dev_init() (and thus VHOST_SET_OWNER) still runs in realize() here.
> >>>> Deferring the ownership handoff to pre_save/post_load is done in a
> >>>> following patch.
> >>>
> >>> So will this patch be bisectabale?
> >>>
> >>> Thanks,
> >>> Stefano
> >>>
> >>
> >> The issue is that cpr-exec already is broken on the current master
> >> branch (i.e. before the series is applied).  The only difference is
> >> which exact error we fail with: -EBUSY or -EADDRINUSE.
> >>
> >> In this case I don't think it's feasible to make each and every commit
> >> bisectable - it only becomes fully working after the last one applied.
> > 
> > Surely just bypassing cpr things until the last commit
> > is feasible?
> >
> 
> Sure, that's what I meant suggesting the migration blocker.  Currently
> we add the blocker only on 'if (!proxy->id)' condition.  I suggest
> adding an unconditional blocker for CPR_TRANSFER|CPR_EXEC before the
> series (new patch 1), and then only make it conditional in the last
> patch.  That way each patch of the series would fail early on that
> blocker instead of crashing QEMU.


I am not sure what is proposed, but I think that if
- any existing functionality is not broken during bisect
- any new functionality fails but does not crash

then we are good.


> >> If you want, I can prepend the series with a migration blocker which
> >> would fail early and gracefully instead of crashing, and lift it after
> >> it's working.
> >>
> >> Andrey
> >>
> >>>>
> >>>> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> >>>> ---
> >>>> hw/virtio/vhost-vsock.c         | 50 ++++++++++++++++++++++++++++++---
> >>>> include/hw/virtio/vhost-vsock.h |  1 +
> >>>> 2 files changed, 47 insertions(+), 4 deletions(-)
> >>>>
> >>>> diff --git a/hw/virtio/vhost-vsock.c b/hw/virtio/vhost-vsock.c
> >>>> index fd7ffa88990..7eacb608d07 100644
> >>>> --- a/hw/virtio/vhost-vsock.c
> >>>> +++ b/hw/virtio/vhost-vsock.c
> >>>> @@ -21,6 +21,8 @@
> >>>> #include "hw/virtio/vhost-vsock.h"
> >>>> #include "monitor/monitor.h"
> >>>> #include "migration/cpr.h"
> >>>> +#include "migration/blocker.h"
> >>>> +#include "migration/misc.h"
> >>>>
> >>>> static void vhost_vsock_get_config(VirtIODevice *vdev, uint8_t *config)
> >>>> {
> >>>> @@ -141,6 +143,7 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
> >>>>     VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(dev);
> >>>>     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
> >>>>     VHostVSock *vsock = VHOST_VSOCK(dev);
> >>>> +    DeviceState *proxy = qdev_get_parent_bus(DEVICE(vsock))->parent;
> >>>>     int vhostfd;
> >>>>     int ret;
> >>>>
> >>>> @@ -155,23 +158,49 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
> >>>>         return;
> >>>>     }
> >>>>
> >>>> -    if (vsock->conf.vhostfd) {
> >>>> +    /*
> >>>> +     * Having a unique ID is mandatory for FD preservation during CPR
> >>>> +     * migration, thus we add migration blockers for CPR modes.
> >>>> +     */
> >>>> +    if (!proxy->id) {
> >>>> +        error_setg(&vsock->migration_blocker,
> >>>> +                   "vhost-vsock: device ID is required for CPR migration");
> >>>> +        if (migrate_add_blocker_modes(&vsock->migration_blocker,
> >>>> +                                      BIT(MIG_MODE_CPR_TRANSFER) |
> >>>> +                                      BIT(MIG_MODE_CPR_EXEC), errp) < 0) {
> >>>> +            return;
> >>>> +        }
> >>>> +    }
> >>>> +
> >>>> +    if (cpr_is_incoming()) {
> >>>> +        /* Reuse the fd handed over from the source QEMU. */
> >>>> +        if (!proxy->id) {
> >>>> +            error_setg(errp, "vhost-vsock: device ID is required for "
> >>>> +                       "CPR migration");
> >>>> +            goto err_blocker;
> >>>> +        }
> >>>> +        vhostfd = cpr_find_fd(proxy->id, 0);
> >>>> +        if (vhostfd < 0) {
> >>>> +            error_setg(errp, "vhost-vsock: could not find restored vhost FD");
> >>>> +            goto err_blocker;
> >>>> +        }
> >>>> +    } else if (vsock->conf.vhostfd) {
> >>>>         vhostfd = monitor_fd_param(monitor_cur(), vsock->conf.vhostfd, errp);
> >>>>         if (vhostfd == -1) {
> >>>>             error_prepend(errp, "vhost-vsock: unable to parse vhostfd: ");
> >>>> -            return;
> >>>> +            goto err_blocker;
> >>>>         }
> >>>>     } else {
> >>>>         vhostfd = open("/dev/vhost-vsock", O_RDWR);
> >>>>         if (vhostfd < 0) {
> >>>>             error_setg_file_open(errp, errno, "/dev/vhost-vsock");
> >>>> -            return;
> >>>> +            goto err_blocker;
> >>>>         }
> >>>>     }
> >>>>
> >>>>     if (!qemu_set_blocking(vhostfd, false, errp)) {
> >>>>         close(vhostfd);
> >>>> -        return;
> >>>> +        goto err_blocker;
> >>>>     }
> >>>>
> >>>>     vhost_vsock_common_realize(vdev);
> >>>> @@ -192,6 +221,11 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
> >>>>         goto err_vhost_dev;
> >>>>     }
> >>>>
> >>>> +    /* Register the fd for a future CPR after a fully successful realize */
> >>>> +    if (proxy->id) {
> >>>> +        cpr_save_fd(proxy->id, 0, vhostfd);
> >>>> +    }
> >>>> +
> >>>>     return;
> >>>>
> >>>> err_vhost_dev:
> >>>> @@ -199,16 +233,24 @@ err_vhost_dev:
> >>>>     vhost_dev_cleanup(&vvc->vhost_dev);
> >>>> err_virtio:
> >>>>     vhost_vsock_common_unrealize(vdev);
> >>>> +err_blocker:
> >>>> +    migrate_del_blocker(&vsock->migration_blocker);
> >>>> }
> >>>>
> >>>> static void vhost_vsock_device_unrealize(DeviceState *dev)
> >>>> {
> >>>>     VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(dev);
> >>>>     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
> >>>> +    VHostVSock *vsock = VHOST_VSOCK(dev);
> >>>> +    DeviceState *proxy = qdev_get_parent_bus(dev)->parent;
> >>>>
> >>>>     /* This will stop vhost backend if appropriate. */
> >>>>     vhost_vsock_set_status(vdev, 0);
> >>>>
> >>>> +    if (proxy->id) {
> >>>> +        cpr_delete_fd(proxy->id, 0);
> >>>> +    }
> >>>> +    migrate_del_blocker(&vsock->migration_blocker);
> >>>>     vhost_dev_cleanup(&vvc->vhost_dev);
> >>>>     vhost_vsock_common_unrealize(vdev);
> >>>> }
> >>>> diff --git a/include/hw/virtio/vhost-vsock.h b/include/hw/virtio/vhost-vsock.h
> >>>> index 84f4e727c70..5ebc63afc5a 100644
> >>>> --- a/include/hw/virtio/vhost-vsock.h
> >>>> +++ b/include/hw/virtio/vhost-vsock.h
> >>>> @@ -29,6 +29,7 @@ struct VHostVSock {
> >>>>     /*< private >*/
> >>>>     VHostVSockCommon parent;
> >>>>     VHostVSockConf conf;
> >>>> +    Error *migration_blocker;   /* set when the device has no ID */
> >>>>
> >>>>     /*< public >*/
> >>>> };
> >>>> -- 
> >>>> 2.47.1
> >>>>
> >>>
> > 


