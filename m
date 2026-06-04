Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10ED2CD6E4A
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 11:54:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wV6e8-0002Ch-Pw; Thu, 04 Jun 2026 07:54:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wV6e6-0002CK-WD
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 07:53:59 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wV6e4-0000FM-QT
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 07:53:58 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-bed2195323cso88176166b.1
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2026 04:53:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780574035; cv=none;
 d=google.com; s=arc-20240605;
 b=RMlC/YjMmlbQdIaGAFXWA4h2qCXyTpl9rWKtojapux5GE1BRGBDT6Bph0kfy1qYeew
 kVFDVHs63vi4Q8gxxJD3SEabchvWFrwXauPAMYYDQ2Vja76G7eD1R4wKWSNaZSaIcAJ2
 55lybQ5h0UOrSkvABAiFfJsool5AEd4wwjSj0eGIDlfJAYjvBIGc4UodqPLeUu3xdd2j
 UWCwWK5RozKkylkv3vi2SW9vwrfK3j71JPUXny5IlG+LKqWoELVRcuRXAMrQ7S4LzOPJ
 Yi5P1rO5JgG9mvflmPLQbrN1HLxKPisTG4XM3k6H8+Hc1i4Nz2HVJBdCqRUefRebjto3
 UvHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=sV9jw1BEUpd6lu7HkscWcMxs6w2o2feLCZfmASY/CBE=;
 fh=2vCTedxg5r0JPg5LnC8s7len6poc60rIFIIE/ngH4cY=;
 b=I6s8oZ78Y1mJEUZfz8XnSj89rDyQoOQH3GbdRjXNvl7UZOSPOLeCCA7MPyJvoIpjpt
 IU78FuzzwErKnxcExfwyhbnxgLtf0K1zgHYNQuQxW0WNmJTCtqMjVgJth9v2LmjvSpZf
 PzPrGuCub3VXjUT0slnoGhQJIjspBTe20ortSHAegEwtqSz341byrM3gYXU6h5xICieb
 BFF8edfJ3dyCfoFhDHMkPsIp8yd8gBSO95b6lzmO8jADZ9KZwcN2Q/wkO3xWSUojK/9a
 +o3r0YDG75kXHmUxjP7Z6rORhyK1m4XZCrKnWXkR6kAq64GX4+jB/fOSwVEeiDJyl6NK
 z3OA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780574035; x=1781178835; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sV9jw1BEUpd6lu7HkscWcMxs6w2o2feLCZfmASY/CBE=;
 b=cCRlfenbLODgIkg/JmkJunoJUm8wOmns2wu6KWrHI/I3H6Im8UfrwVG4YeuI7K9VvU
 aoO28QZ5DRngd4f5osfILqMqKBWnr8oxPcBVlaqMHKjAceeq7NL8slUJaPx4C9uMKP/G
 i8I2+VxiC6T3nOaa8ZqrXC5lsodGYJ5+MjVzj9lufpwScFadDUV5YQDtDJgMO2ubNWyu
 kKxbX0Gtr8SCQ8F6lTL3FGPwTBXEs2BEIjnHvbzv9SH4a4yduFIqm0oLj90c7IFWzxl5
 3+xHUsB4HwRJMCXX2+z5FhPL+rTUoxGjx9SJ2N2qKyofM4ze5xR2RmEt3+yWVyYS7ObQ
 hS+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780574035; x=1781178835;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sV9jw1BEUpd6lu7HkscWcMxs6w2o2feLCZfmASY/CBE=;
 b=pLgTt6NWfq3GDfCqc/+AMqzsK7r3//h18iM8ywYgwJ83zUR7AFQ9jb3Uz4bByLfpk+
 6RRMxjkE+nndWZA7rqUx7Em0vxePg2cRTkfuGhPr/kli9w+m11ipy5JHIcCiXgUFCS5d
 UykLsjkFQZ2VgCzyzYRJi/3hggOv8sJZZVOc2qwhag1X3CB5W9yGHrOHQwIqxdFz/84W
 0gZ3XAF/aUcHQ77GrmS38nYe5OAuHOQYPhj1e5uUx6j+4E+5OYyk3vWTbrpawhntU55P
 yN8aCawLStWdiJv+niu3DLrSRTQT/X2yCfr34AyU4FNmwy4HqapAH8/SyuKfwGK+z8nX
 l7Ng==
X-Gm-Message-State: AOJu0YzPKpndLGLOD6Y8zY9/rnW5JywqIQMK7AHIKnvP4b5ytY8ueOY8
 dWDVLLeSs+dWXwUpjvRA/yExoFc3+QHfc75YRgdr3xREBA99Sb9QLKY2uwpJ2hyBgbr2p6yTIwp
 3lwD1kDthVc+RWRSP1FQZfhqMYg8Cbss=
X-Gm-Gg: Acq92OGSbbtbwr/gyErm5zJvuSlCc7w8r695dxcXuY7wUFIw2D1ln87galXF7QqsybX
 Po1rXGXSO5kI2HtNd0JPlUy+IKOqsHow2fsIjdPfxsAChXvJN2z2Z9a6g3ScRfgrKjDAHo1WTdC
 Z6TmooSLq1/HbjlEtdFhsnBOy3MHWxk7oOMwUJQds4EaRgKeaSgvQy+BNknyDnsrt7Rm+pBQYMC
 aOFvvFmPE/vO/MWVjnMqwvWXZ+H/dZIPwuKP8XWfa4l/vvE/3ZFXer5/Afelp2NoJu4hOZJqBb7
 L3HDpxXDByIbo5aiVvg=
X-Received: by 2002:a17:907:d109:b0:bed:6ba7:6b03 with SMTP id
 a640c23a62f3a-bf0acf1687emr428644266b.15.1780574034655; Thu, 04 Jun 2026
 04:53:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260529213321.96271-1-zhangckid@gmail.com>
 <20260529213321.96271-16-zhangckid@gmail.com>
 <87eciorgaj.fsf@pond.sub.org>
In-Reply-To: <87eciorgaj.fsf@pond.sub.org>
From: Zhang Chen <zhangckid@gmail.com>
Date: Thu, 4 Jun 2026 19:53:18 +0800
X-Gm-Features: AVHnY4JzgKSt1_E55kdnKRQxn92YIP9lp_yMn1UDwq3KxSUBVV0AUZOXqpO9PwA
Message-ID: <CAK3tnvJauCiFZNW84JP39KoXD5NieVV5b+GR_F0yeixYbw3Biw@mail.gmail.com>
Subject: Re: [PATCH V8 15/15] iothread: simplify API by merging
 iothread_get_aio_context variants
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>, 
 Eric Blake <eblake@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=zhangckid@gmail.com; helo=mail-ej1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Wed, Jun 3, 2026 at 1:41=E2=80=AFAM Markus Armbruster <armbru@redhat.com=
> wrote:
>
> Zhang Chen <zhangckid@gmail.com> writes:
>
> > Simplify the interface by merging iothread_ref_and_get_aio_context()
> > into iothread_get_aio_context(). The updated function now requires a
> > 'holder' parameter, ensuring that every retrieval of an AioContext for
> > long-term use is automatically registered in the IOThread's holder list=
.
> >
> > Update all callers across block, virtio, scsi, net, and monitor
> > subsystems to match the new signature. This cleanup reduces code
> > redundancy and improves the reliability of IOThread introspection.
> >
> > Signed-off-by: Zhang Chen <zhangckid@gmail.com>
> > ---
> >  block/export/export.c           | 5 ++---
> >  hw/block/dataplane/xen-block.c  | 4 ++--
> >  hw/block/virtio-blk.c           | 4 ++--
> >  hw/scsi/virtio-scsi-dataplane.c | 4 ++--
> >  hw/vfio-user/proxy.c            | 3 +--
> >  hw/virtio/iothread-vq-mapping.c | 3 +--
> >  hw/virtio/virtio-balloon.c      | 2 +-
> >  include/system/iothread.h       | 6 +++---
> >  iothread.c                      | 9 ++-------
> >  monitor/monitor.c               | 2 +-
> >  net/colo-compare.c              | 2 +-
> >  11 files changed, 18 insertions(+), 26 deletions(-)
> >
> > diff --git a/block/export/export.c b/block/export/export.c
> > index b6c07f69b5..acd061e86e 100644
> > --- a/block/export/export.c
> > +++ b/block/export/export.c
> > @@ -146,7 +146,7 @@ BlockExport *blk_exp_add(BlockExportOptions *export=
, Error **errp)
> >              .u.block_node.node_name =3D (char *)holder_name,
> >          };
> >
> > -        new_ctx =3D iothread_ref_and_get_aio_context(iothread, &holder=
);
> > +        new_ctx =3D iothread_get_aio_context(iothread, &holder);
> >          multithread_count =3D 1;
> >          local_iothreads =3D g_new0(IOThread *, 1);
> >          local_iothreads[0] =3D iothread;
> > @@ -190,8 +190,7 @@ BlockExport *blk_exp_add(BlockExportOptions *export=
, Error **errp)
> >                  goto fail;
> >              }
> >              local_iothreads[i] =3D iothread;
> > -            multithread_ctxs[i++] =3D iothread_ref_and_get_aio_context=
(iothread,
> > -                                                                     &=
holder);
> > +            multithread_ctxs[i++] =3D iothread_get_aio_context(iothrea=
d, &holder);
> >          }
> >          assert(i =3D=3D multithread_count);
> >      }
> > diff --git a/hw/block/dataplane/xen-block.c b/hw/block/dataplane/xen-bl=
ock.c
> > index b5bf8d359f..46bfd62f5a 100644
> > --- a/hw/block/dataplane/xen-block.c
> > +++ b/hw/block/dataplane/xen-block.c
> > @@ -628,8 +628,8 @@ XenBlockDataPlane *xen_block_dataplane_create(XenDe=
vice *xendev,
> >          };
> >
> >          dataplane->iothread =3D iothread;
> > -        dataplane->ctx =3D iothread_ref_and_get_aio_context(dataplane-=
>iothread,
> > -                                                          &io_holder);
> > +        dataplane->ctx =3D iothread_get_aio_context(dataplane->iothrea=
d,
> > +                                                  &io_holder);
> >      } else {
> >          dataplane->ctx =3D qemu_get_aio_context();
> >      }
> > diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
> > index d8dc1dd136..d1d2bd7025 100644
> > --- a/hw/block/virtio-blk.c
> > +++ b/hw/block/virtio-blk.c
> > @@ -1502,8 +1502,8 @@ static bool virtio_blk_vq_aio_context_init(VirtIO=
Block *s, Error **errp)
> >              .type =3D IO_THREAD_HOLDER_KIND_QOM_OBJECT,
> >              .u.qom_object.qom_path =3D (char *)path,
> >          };
> > -        AioContext *ctx =3D iothread_ref_and_get_aio_context(conf->iot=
hread,
> > -                                                           &io_holder)=
;
> > +        AioContext *ctx =3D iothread_get_aio_context(conf->iothread,
> > +                                                   &io_holder);
> >          for (unsigned i =3D 0; i < conf->num_queues; i++) {
> >              s->vq_aio_context[i] =3D ctx;
> >          }
> > diff --git a/hw/scsi/virtio-scsi-dataplane.c b/hw/scsi/virtio-scsi-data=
plane.c
> > index c71f33b41e..76ab22610f 100644
> > --- a/hw/scsi/virtio-scsi-dataplane.c
> > +++ b/hw/scsi/virtio-scsi-dataplane.c
> > @@ -78,8 +78,8 @@ void virtio_scsi_dataplane_setup(VirtIOSCSI *s, Error=
 **errp)
> >              .type =3D IO_THREAD_HOLDER_KIND_QOM_OBJECT,
> >              .u.qom_object.qom_path =3D (char *)path,
> >          };
> > -        AioContext *ctx =3D iothread_ref_and_get_aio_context(vs->conf.=
iothread,
> > -                                                           &io_holder)=
;
> > +        AioContext *ctx =3D iothread_get_aio_context(vs->conf.iothread=
,
> > +                                                   &io_holder);
> >          for (uint16_t i =3D 0; i < vs->conf.num_queues; i++) {
> >              s->vq_aio_context[VIRTIO_SCSI_VQ_NUM_FIXED + i] =3D ctx;
> >          }
> > diff --git a/hw/vfio-user/proxy.c b/hw/vfio-user/proxy.c
> > index 756f368849..24af3c791b 100644
> > --- a/hw/vfio-user/proxy.c
> > +++ b/hw/vfio-user/proxy.c
> > @@ -942,8 +942,7 @@ VFIOUserProxy *vfio_user_connect_dev(SocketAddress =
*addr, Error **errp)
> >          vfio_user_iothread =3D iothread_create("VFIO user", errp);
> >      }
> >
> > -    proxy->ctx =3D iothread_ref_and_get_aio_context(vfio_user_iothread=
,
> > -                                                  &io_holder);
> > +    proxy->ctx =3D iothread_get_aio_context(vfio_user_iothread, &io_ho=
lder);
> >      proxy->req_bh =3D qemu_bh_new(vfio_user_request, proxy);
> >
> >      QTAILQ_INIT(&proxy->outgoing);
> > diff --git a/hw/virtio/iothread-vq-mapping.c b/hw/virtio/iothread-vq-ma=
pping.c
> > index 2cb48dd387..727358a483 100644
> > --- a/hw/virtio/iothread-vq-mapping.c
> > +++ b/hw/virtio/iothread-vq-mapping.c
> > @@ -99,8 +99,7 @@ bool iothread_vq_mapping_apply(
> >              .u.qom_object.qom_path =3D (char *)holder,
> >          };
> >
> > -        AioContext *ctx =3D iothread_ref_and_get_aio_context(iothread,
> > -                                                           &io_holder)=
;
> > +        AioContext *ctx =3D iothread_get_aio_context(iothread, &io_hol=
der);
> >
> >          if (node->value->vqs) {
> >              uint16List *vq;
> > diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
> > index e9d023b4ec..4405a87ed0 100644
> > --- a/hw/virtio/virtio-balloon.c
> > +++ b/hw/virtio/virtio-balloon.c
> > @@ -903,7 +903,7 @@ static void virtio_balloon_device_realize(DeviceSta=
te *dev, Error **errp)
> >          precopy_add_notifier(&s->free_page_hint_notify);
> >
> >          s->free_page_bh =3D aio_bh_new_guarded(
> > -                      iothread_ref_and_get_aio_context(s->iothread, &i=
o_holder),
> > +                      iothread_get_aio_context(s->iothread, &io_holder=
),
> >                        virtio_ballloon_get_free_page_hints, s,
> >                        &dev->mem_reentrancy_guard);
> >      }
> > diff --git a/include/system/iothread.h b/include/system/iothread.h
> > index 064c05e78d..e5db215954 100644
> > --- a/include/system/iothread.h
> > +++ b/include/system/iothread.h
> > @@ -70,15 +70,15 @@ DECLARE_INSTANCE_CHECKER(IOThread, IOTHREAD,
> >
> >  char *iothread_get_id(IOThread *iothread);
> >  IOThread *iothread_by_id(const char *id);
> > -AioContext *iothread_get_aio_context(IOThread *iothread);
> > +
> >  /*
> >   * The iothread_unsafe_get_aio_context() is a low-level unsafe way of =
getting
> >   * the AioContext, recommend migrating to the new API with IOThreadHol=
der
> >   * as much as possible.
> >   */
> >  AioContext *iothread_unsafe_get_aio_context(IOThread *iothread);
> > -AioContext *iothread_ref_and_get_aio_context(IOThread *iothread,
> > -                                             const IOThreadHolder *hol=
der);
> > +AioContext *iothread_get_aio_context(IOThread *iothread,
> > +                                     const IOThreadHolder *holder);
> >  void iothread_put_aio_context(IOThread *iothread, const IOThreadHolder=
 *holder);
> >  GMainContext *iothread_get_g_main_context(IOThread *iothread);
> >
> > diff --git a/iothread.c b/iothread.c
> > index 5949785b32..9bc8e359c1 100644
> > --- a/iothread.c
> > +++ b/iothread.c
> > @@ -469,13 +469,8 @@ char *iothread_get_id(IOThread *iothread)
> >      return g_strdup(object_get_canonical_path_component(OBJECT(iothrea=
d)));
> >  }
> >
> > -AioContext *iothread_get_aio_context(IOThread *iothread)
> > -{
> > -    return iothread->ctx;
> > -}
> > -
> > -AioContext *iothread_ref_and_get_aio_context(IOThread *iothread,
> > -                                             const IOThreadHolder *hol=
der)
> > +AioContext *iothread_get_aio_context(IOThread *iothread,
> > +                                     const IOThreadHolder *holder)
> >  {
> >      /* Add IOThreadHolder to the list */
> >      iothread_ref(iothread, holder);
> > diff --git a/monitor/monitor.c b/monitor/monitor.c
> > index 7eec6f967d..4d00cf499c 100644
> > --- a/monitor/monitor.c
> > +++ b/monitor/monitor.c
> > @@ -617,7 +617,7 @@ void monitor_data_init(Monitor *mon, bool is_qmp, b=
ool skip_flush,
> >              .type =3D IO_THREAD_HOLDER_KIND_MONITOR_NAME,
> >              .u.monitor_name.monitor_name =3D (char *)mon->id,
> >          };
> > -        mon->ctx =3D iothread_ref_and_get_aio_context(mon_iothread, &h=
older);
> > +        mon->ctx =3D iothread_get_aio_context(mon_iothread, &holder);
> >      }
> >      qemu_mutex_init(&mon->mon_lock);
> >      mon->is_qmp =3D is_qmp;
> > diff --git a/net/colo-compare.c b/net/colo-compare.c
> > index 4f180936e3..820ea4d824 100644
> > --- a/net/colo-compare.c
> > +++ b/net/colo-compare.c
> > @@ -973,7 +973,7 @@ static void colo_compare_iothread(CompareState *s)
> >          .u.qom_object.qom_path =3D (char *)path,
> >      };
> >
> > -    AioContext *ctx =3D iothread_ref_and_get_aio_context(s->iothread, =
&io_holder);
> > +    AioContext *ctx =3D iothread_get_aio_context(s->iothread, &io_hold=
er);
> >
> >      s->iothread_ctx =3D ctx;
> >      s->worker_context =3D iothread_get_g_main_context(s->iothread);
>
>
> The patch appears to delete unused iothread_get_aio_context() from
> iothread.[cg] and to rename iothread_ref_and_get_aio_context() to
> iothread_get_aio_context().  It leaves iothread_get_aio_context() in
> tests/unit/iothread.[ch] alone.  The result is confusing: test's
> iothread_get_aio_context() takes now one parameter less than the regular
> one.
>
> Should you change both versions?
>

Yes, I already noticed the iothread test, we can change it after
merging this series.

Thanks
Chen

