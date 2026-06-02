Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2E00CD5BD1
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2026 17:42:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUT7d-0002Fr-RZ; Tue, 02 Jun 2026 13:41:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wUT7O-0002Ew-SM
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 13:41:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wUT7L-0007aG-Q6
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 13:41:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780422090;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=A0yBOtRkuu8lFMddZo5WLWDann/UhpsV7hN5k3sCzVM=;
 b=FXo/Y59LMzomgul7Lrzkt6P/2QCW7oltV5exCWKvsB3tH7TqsFzKLzPLYpmA+rLpRp8eVw
 OF3UM0jfkGi8bCqdm2QaurTzlUBKyD6/74aLxxCN/mLdR+z4YmViBZyDJh7JCrEoNIbef6
 FQw7+tz7DEd6HF6Dnzh9pns3IrwvrXw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-176-b4mtA5t8Olq3N5B8SKmSJA-1; Tue,
 02 Jun 2026 13:41:29 -0400
X-MC-Unique: b4mtA5t8Olq3N5B8SKmSJA-1
X-Mimecast-MFC-AGG-ID: b4mtA5t8Olq3N5B8SKmSJA_1780422088
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A6ADA1956062; Tue,  2 Jun 2026 17:41:27 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D5B9B1800240; Tue,  2 Jun 2026 17:41:26 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8439B21E6A01; Tue, 02 Jun 2026 19:41:24 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Zhang Chen <zhangckid@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,  "Dr . David Alan Gilbert"
 <dave@treblig.org>,  Eric Blake <eblake@redhat.com>,  "Michael S .
 Tsirkin" <mst@redhat.com>,  Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH V8 15/15] iothread: simplify API by merging
 iothread_get_aio_context variants
In-Reply-To: <20260529213321.96271-16-zhangckid@gmail.com> (Zhang Chen's
 message of "Sat, 30 May 2026 05:33:21 +0800")
References: <20260529213321.96271-1-zhangckid@gmail.com>
 <20260529213321.96271-16-zhangckid@gmail.com>
Date: Tue, 02 Jun 2026 19:41:24 +0200
Message-ID: <87eciorgaj.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Zhang Chen <zhangckid@gmail.com> writes:

> Simplify the interface by merging iothread_ref_and_get_aio_context()
> into iothread_get_aio_context(). The updated function now requires a
> 'holder' parameter, ensuring that every retrieval of an AioContext for
> long-term use is automatically registered in the IOThread's holder list.
>
> Update all callers across block, virtio, scsi, net, and monitor
> subsystems to match the new signature. This cleanup reduces code
> redundancy and improves the reliability of IOThread introspection.
>
> Signed-off-by: Zhang Chen <zhangckid@gmail.com>
> ---
>  block/export/export.c           | 5 ++---
>  hw/block/dataplane/xen-block.c  | 4 ++--
>  hw/block/virtio-blk.c           | 4 ++--
>  hw/scsi/virtio-scsi-dataplane.c | 4 ++--
>  hw/vfio-user/proxy.c            | 3 +--
>  hw/virtio/iothread-vq-mapping.c | 3 +--
>  hw/virtio/virtio-balloon.c      | 2 +-
>  include/system/iothread.h       | 6 +++---
>  iothread.c                      | 9 ++-------
>  monitor/monitor.c               | 2 +-
>  net/colo-compare.c              | 2 +-
>  11 files changed, 18 insertions(+), 26 deletions(-)
>
> diff --git a/block/export/export.c b/block/export/export.c
> index b6c07f69b5..acd061e86e 100644
> --- a/block/export/export.c
> +++ b/block/export/export.c
> @@ -146,7 +146,7 @@ BlockExport *blk_exp_add(BlockExportOptions *export, Error **errp)
>              .u.block_node.node_name = (char *)holder_name,
>          };
>  
> -        new_ctx = iothread_ref_and_get_aio_context(iothread, &holder);
> +        new_ctx = iothread_get_aio_context(iothread, &holder);
>          multithread_count = 1;
>          local_iothreads = g_new0(IOThread *, 1);
>          local_iothreads[0] = iothread;
> @@ -190,8 +190,7 @@ BlockExport *blk_exp_add(BlockExportOptions *export, Error **errp)
>                  goto fail;
>              }
>              local_iothreads[i] = iothread;
> -            multithread_ctxs[i++] = iothread_ref_and_get_aio_context(iothread,
> -                                                                     &holder);
> +            multithread_ctxs[i++] = iothread_get_aio_context(iothread, &holder);
>          }
>          assert(i == multithread_count);
>      }
> diff --git a/hw/block/dataplane/xen-block.c b/hw/block/dataplane/xen-block.c
> index b5bf8d359f..46bfd62f5a 100644
> --- a/hw/block/dataplane/xen-block.c
> +++ b/hw/block/dataplane/xen-block.c
> @@ -628,8 +628,8 @@ XenBlockDataPlane *xen_block_dataplane_create(XenDevice *xendev,
>          };
>  
>          dataplane->iothread = iothread;
> -        dataplane->ctx = iothread_ref_and_get_aio_context(dataplane->iothread,
> -                                                          &io_holder);
> +        dataplane->ctx = iothread_get_aio_context(dataplane->iothread,
> +                                                  &io_holder);
>      } else {
>          dataplane->ctx = qemu_get_aio_context();
>      }
> diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
> index d8dc1dd136..d1d2bd7025 100644
> --- a/hw/block/virtio-blk.c
> +++ b/hw/block/virtio-blk.c
> @@ -1502,8 +1502,8 @@ static bool virtio_blk_vq_aio_context_init(VirtIOBlock *s, Error **errp)
>              .type = IO_THREAD_HOLDER_KIND_QOM_OBJECT,
>              .u.qom_object.qom_path = (char *)path,
>          };
> -        AioContext *ctx = iothread_ref_and_get_aio_context(conf->iothread,
> -                                                           &io_holder);
> +        AioContext *ctx = iothread_get_aio_context(conf->iothread,
> +                                                   &io_holder);
>          for (unsigned i = 0; i < conf->num_queues; i++) {
>              s->vq_aio_context[i] = ctx;
>          }
> diff --git a/hw/scsi/virtio-scsi-dataplane.c b/hw/scsi/virtio-scsi-dataplane.c
> index c71f33b41e..76ab22610f 100644
> --- a/hw/scsi/virtio-scsi-dataplane.c
> +++ b/hw/scsi/virtio-scsi-dataplane.c
> @@ -78,8 +78,8 @@ void virtio_scsi_dataplane_setup(VirtIOSCSI *s, Error **errp)
>              .type = IO_THREAD_HOLDER_KIND_QOM_OBJECT,
>              .u.qom_object.qom_path = (char *)path,
>          };
> -        AioContext *ctx = iothread_ref_and_get_aio_context(vs->conf.iothread,
> -                                                           &io_holder);
> +        AioContext *ctx = iothread_get_aio_context(vs->conf.iothread,
> +                                                   &io_holder);
>          for (uint16_t i = 0; i < vs->conf.num_queues; i++) {
>              s->vq_aio_context[VIRTIO_SCSI_VQ_NUM_FIXED + i] = ctx;
>          }
> diff --git a/hw/vfio-user/proxy.c b/hw/vfio-user/proxy.c
> index 756f368849..24af3c791b 100644
> --- a/hw/vfio-user/proxy.c
> +++ b/hw/vfio-user/proxy.c
> @@ -942,8 +942,7 @@ VFIOUserProxy *vfio_user_connect_dev(SocketAddress *addr, Error **errp)
>          vfio_user_iothread = iothread_create("VFIO user", errp);
>      }
>  
> -    proxy->ctx = iothread_ref_and_get_aio_context(vfio_user_iothread,
> -                                                  &io_holder);
> +    proxy->ctx = iothread_get_aio_context(vfio_user_iothread, &io_holder);
>      proxy->req_bh = qemu_bh_new(vfio_user_request, proxy);
>  
>      QTAILQ_INIT(&proxy->outgoing);
> diff --git a/hw/virtio/iothread-vq-mapping.c b/hw/virtio/iothread-vq-mapping.c
> index 2cb48dd387..727358a483 100644
> --- a/hw/virtio/iothread-vq-mapping.c
> +++ b/hw/virtio/iothread-vq-mapping.c
> @@ -99,8 +99,7 @@ bool iothread_vq_mapping_apply(
>              .u.qom_object.qom_path = (char *)holder,
>          };
>  
> -        AioContext *ctx = iothread_ref_and_get_aio_context(iothread,
> -                                                           &io_holder);
> +        AioContext *ctx = iothread_get_aio_context(iothread, &io_holder);
>  
>          if (node->value->vqs) {
>              uint16List *vq;
> diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
> index e9d023b4ec..4405a87ed0 100644
> --- a/hw/virtio/virtio-balloon.c
> +++ b/hw/virtio/virtio-balloon.c
> @@ -903,7 +903,7 @@ static void virtio_balloon_device_realize(DeviceState *dev, Error **errp)
>          precopy_add_notifier(&s->free_page_hint_notify);
>  
>          s->free_page_bh = aio_bh_new_guarded(
> -                      iothread_ref_and_get_aio_context(s->iothread, &io_holder),
> +                      iothread_get_aio_context(s->iothread, &io_holder),
>                        virtio_ballloon_get_free_page_hints, s,
>                        &dev->mem_reentrancy_guard);
>      }
> diff --git a/include/system/iothread.h b/include/system/iothread.h
> index 064c05e78d..e5db215954 100644
> --- a/include/system/iothread.h
> +++ b/include/system/iothread.h
> @@ -70,15 +70,15 @@ DECLARE_INSTANCE_CHECKER(IOThread, IOTHREAD,
>  
>  char *iothread_get_id(IOThread *iothread);
>  IOThread *iothread_by_id(const char *id);
> -AioContext *iothread_get_aio_context(IOThread *iothread);
> +
>  /*
>   * The iothread_unsafe_get_aio_context() is a low-level unsafe way of getting
>   * the AioContext, recommend migrating to the new API with IOThreadHolder
>   * as much as possible.
>   */
>  AioContext *iothread_unsafe_get_aio_context(IOThread *iothread);
> -AioContext *iothread_ref_and_get_aio_context(IOThread *iothread,
> -                                             const IOThreadHolder *holder);
> +AioContext *iothread_get_aio_context(IOThread *iothread,
> +                                     const IOThreadHolder *holder);
>  void iothread_put_aio_context(IOThread *iothread, const IOThreadHolder *holder);
>  GMainContext *iothread_get_g_main_context(IOThread *iothread);
>  
> diff --git a/iothread.c b/iothread.c
> index 5949785b32..9bc8e359c1 100644
> --- a/iothread.c
> +++ b/iothread.c
> @@ -469,13 +469,8 @@ char *iothread_get_id(IOThread *iothread)
>      return g_strdup(object_get_canonical_path_component(OBJECT(iothread)));
>  }
>  
> -AioContext *iothread_get_aio_context(IOThread *iothread)
> -{
> -    return iothread->ctx;
> -}
> -
> -AioContext *iothread_ref_and_get_aio_context(IOThread *iothread,
> -                                             const IOThreadHolder *holder)
> +AioContext *iothread_get_aio_context(IOThread *iothread,
> +                                     const IOThreadHolder *holder)
>  {
>      /* Add IOThreadHolder to the list */
>      iothread_ref(iothread, holder);
> diff --git a/monitor/monitor.c b/monitor/monitor.c
> index 7eec6f967d..4d00cf499c 100644
> --- a/monitor/monitor.c
> +++ b/monitor/monitor.c
> @@ -617,7 +617,7 @@ void monitor_data_init(Monitor *mon, bool is_qmp, bool skip_flush,
>              .type = IO_THREAD_HOLDER_KIND_MONITOR_NAME,
>              .u.monitor_name.monitor_name = (char *)mon->id,
>          };
> -        mon->ctx = iothread_ref_and_get_aio_context(mon_iothread, &holder);
> +        mon->ctx = iothread_get_aio_context(mon_iothread, &holder);
>      }
>      qemu_mutex_init(&mon->mon_lock);
>      mon->is_qmp = is_qmp;
> diff --git a/net/colo-compare.c b/net/colo-compare.c
> index 4f180936e3..820ea4d824 100644
> --- a/net/colo-compare.c
> +++ b/net/colo-compare.c
> @@ -973,7 +973,7 @@ static void colo_compare_iothread(CompareState *s)
>          .u.qom_object.qom_path = (char *)path,
>      };
>  
> -    AioContext *ctx = iothread_ref_and_get_aio_context(s->iothread, &io_holder);
> +    AioContext *ctx = iothread_get_aio_context(s->iothread, &io_holder);
>  
>      s->iothread_ctx = ctx;
>      s->worker_context = iothread_get_g_main_context(s->iothread);


The patch appears to delete unused iothread_get_aio_context() from
iothread.[cg] and to rename iothread_ref_and_get_aio_context() to
iothread_get_aio_context().  It leaves iothread_get_aio_context() in
tests/unit/iothread.[ch] alone.  The result is confusing: test's
iothread_get_aio_context() takes now one parameter less than the regular
one.

Should you change both versions?


