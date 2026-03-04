Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56E45EDEC16
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 07:04:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxgH3-00009f-P4; Wed, 04 Mar 2026 02:04:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vxgGz-00009B-BM
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 02:03:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vxgGw-0005jy-6Q
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 02:03:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772607827;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w4CsBTqooUaMjaVu/nv60O8xO69i6AJzn6d8UPDA4Pg=;
 b=M/czqoFePwKiHwvXDmmIO0gmd4yGLhLJAM3RBzBmyl2M/jNZd/Uyy3N1zjJBdh75d7Sw5o
 4QLN0I7frfErNXkOOUDSWOjDvvY3nVrLqYh8z0qk8ab4WC+SwnWzJhcbdmdJ2iWuNTXZAW
 2HcSknoeGdemo/7uZi9ERIv0e/MjAVU=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-480-V3D8GE9POEe3n3V9CSfK8A-1; Wed, 04 Mar 2026 02:03:45 -0500
X-MC-Unique: V3D8GE9POEe3n3V9CSfK8A-1
X-Mimecast-MFC-AGG-ID: V3D8GE9POEe3n3V9CSfK8A_1772607825
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-358df8fbd1cso5867589a91.0
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 23:03:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772607825; cv=none;
 d=google.com; s=arc-20240605;
 b=CaiOi9mGeoBJk/hVefUn0ANIYXyTwlNMuLL9GBFHB/uox/GTt48x+mHQIEKikmzlEq
 5RVDc0rZUdib1HwLIjV6Y+fzihd/MZ12Y++ZWXhZjzwT7OD32vRp5Lew+LhirSRfHHcH
 ZQDp17veSSr2e0GONNBo/NiWEgY55xGKcu2MuS2H6vCe3TM4f7z4wj0XqfKYgEnTKhDp
 pBQoH1w4G3wPea7P2Ri7HR3pKgN5xkAyU/g2RHGU0lAL0DiJYcOrZ1WdZQ1BYgiIm/FB
 ZbJgbJmhGTjJDNy2gFyea3iv6Dys8Kho7QvUzfMxO9F4HDYJjYsx34Ud77gy/uMHgiNg
 YdsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=w4CsBTqooUaMjaVu/nv60O8xO69i6AJzn6d8UPDA4Pg=;
 fh=vyqavHnp8MGsLU4bOFuBEiT6sWxNRhxfZVIKF7djZqw=;
 b=X5b0Nz1oUMhIM/ZolWNvNn6wOyMz9gIBY5oMN20gKdXgX2G86FF/pUzbMjcPXiH8xy
 xD+UH9Emc3xtSpZkbD7Y772guo5imH/QW23Cjs8s5zeCpcMZAqsjhFz96pVVrjvYU2qu
 qAlx7OPuH6HsfR21Kdaf8rDPtYbnxbNZ9Zka4USUcOt6B/e/hqUUe6fktak3aXwTnwSc
 RU83k+hP8trz0NS7UrK/QKYHeqsdnSRf5U5zUKD6NsVK2si/woj7nIKXyfuB+vQEKTOK
 D6RVZJ4Dx3RhZbpHhKgh3iu5ljRYqgEmSQUvyVsGHEp2xoX7K9C21w171NLjyGg23ry1
 M86g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772607825; x=1773212625; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w4CsBTqooUaMjaVu/nv60O8xO69i6AJzn6d8UPDA4Pg=;
 b=HGRqZPJdFdJbMV+I/J0GAzesyUqmf+eAWYKyEeeX0yHOUtnccyw962IUSSq6nvxwy/
 4/+sYL8j8a50MaTS942SEWpjpfi4KtjpYRgPv+UrAPrtXXt0XFJRIsol6V6rofVtNriV
 DG7EAfdK261tlcFnufuEXjdUX5iZjmQ2+z4awup+e8RhaIsUeavPSYSSvqoY3MxYtIld
 CfjYIgY3rjytwLwpWzyCMHie4dS7STNAxeMK5EXixuDxfvbMNshIbQOG6jomimZGNxhK
 KH7bD9zOmTkNzkLfAlwGYYwuju5rGMO3jPC6cWjF1cLsRliUEzRKHj94NrV+lPE+EKwu
 QbOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772607825; x=1773212625;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=w4CsBTqooUaMjaVu/nv60O8xO69i6AJzn6d8UPDA4Pg=;
 b=nU/qufsJZ9Rs8LovWc+EqUmMlQtlkKl/MWSAbFFpYlRFiaWGvDEbN11Oo6Qg8r6Dqz
 C9Nk461G3aG3yzfYhA73XDQutWLdBrd25/Aikntf5uGqidzt6gCXZzv0UHdCR6Mpqd6L
 EXSLSvCyvbRW47oMRlrXaK6GVCl2XzADt+3f0vmMBaE126/WH2hca4bkn7Nq9Rn5hBOQ
 LYrUYNKYG0gz4GlvHEnBdbYlVpMorQxmHOSHCQpDGaNlV3TdUsf2jXF0/4eZ/5ot98U0
 qOgj6CUgdjKuErb7eY3SY6ajSBpkwm98CArp9HKyO4DUyO+DA6KCv1yX07l2ONWRW+LQ
 MFSQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVSy/KIxiTKDxi94btSCxmqzAdRfeYgv+QwzTRIWXJh67PHmN0HKMLjLCgOVHl1AiySvzoxdo1IEvW+@nongnu.org
X-Gm-Message-State: AOJu0Yy1V5LwmVu7U57egGjXaead2ZiQX2ZMN42suEtImzIvayer0eLa
 pmzq7lLZ7MVwCiciNfLEiAvFYXxOmk/SFTo7eqqsRW3chKLadoiC2D0fBCgsdfiS8e7IeY8KU0x
 QrZORoAomW8xSjCh1gZsrOVIgPhPGduHmzwXgZIgTSdATtLRU2OfxOTCPwTINwNMndsOSERlcni
 /5+MXVZjZ9nG5aE2OM1n6AWZK3AbI2A3g=
X-Gm-Gg: ATEYQzwpKAhpM2Ofj6IhgAU7WdizH5gAq5vwUvkWAoGNGHtTk+aeaKrWI45dO/m23X5
 jnT6B8MBjwd94QS8mFAWkr+Jn8UOQyil5NLCx1mpZiht2rVimKlLVEKytbrYTaq+GmlzST5Dz7w
 x0Ytsiy4KjILLPHZOB6KzOCsAUNYHwqyeVbuHaCaWrXQyBrao36MEf1QumyCshMKBP9v/ZYCS1v
 4ske1A=
X-Received: by 2002:a17:90b:4c4c:b0:358:dc04:a595 with SMTP id
 98e67ed59e1d1-359a6a3d240mr1148065a91.21.1772607824515; 
 Tue, 03 Mar 2026 23:03:44 -0800 (PST)
X-Received: by 2002:a17:90b:4c4c:b0:358:dc04:a595 with SMTP id
 98e67ed59e1d1-359a6a3d240mr1148048a91.21.1772607824005; Tue, 03 Mar 2026
 23:03:44 -0800 (PST)
MIME-Version: 1.0
References: <20260207134728.1495932-1-lulu@redhat.com>
 <20260207134728.1495932-2-lulu@redhat.com>
 <CAK3tnvKxsumtqbF6z6_3v5jWWwAeUg4sdYsXNY9Jha9tXYR6ag@mail.gmail.com>
 <CACLfguV53qhomyXffUQU2PACs3+EwYnPXCgnQcNdsFbgYnooTA@mail.gmail.com>
In-Reply-To: <CACLfguV53qhomyXffUQU2PACs3+EwYnPXCgnQcNdsFbgYnooTA@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 4 Mar 2026 15:03:31 +0800
X-Gm-Features: AaiRm52nB1JmSTCMzdigHATEaUl-5M5PIZhufPmJGSEI20rsIehUF0-dNCZds_g
Message-ID: <CACGkMEvVsOBT9O5-=GtVtCFKSTnGJKJNb77RhdMnge1kWhVO0g@mail.gmail.com>
Subject: Re: [PATCH 02/12] net/filter-mirror: add enable_when_stopped option
 for filter-redirector
To: Cindy Lu <lulu@redhat.com>
Cc: Zhang Chen <zhangckid@gmail.com>, mst@redhat.com, lizhijian@fujitsu.com, 
 qemu-devel@nongnu.org, Juraj Marcin <jmarcin@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Wed, Feb 25, 2026 at 2:19=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
>
> On Sat, Feb 14, 2026 at 10:46=E2=80=AFAM Zhang Chen <zhangckid@gmail.com>=
 wrote:
> >
> > On Sat, Feb 7, 2026 at 9:47=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote=
:
> > >
> > > From: Jason Wang <jasowang@redhat.com>
> > >
> > > Add a QAPI option 'enable_when_stopped' for filter-redirector that
> > > allows it to continue receiving data from netdev when VM is stopped.
> > >
> > > When enabled, a VM state change handler activates the netdev's
> > > read_poll() when VM stops, allowing the netdev to continue reading
> > > data and passing it through filter-redirector to the chardev output.
> > >
> > > This is useful for scenarios where filter-redirector needs to
> > > process network traffic even when the VM is paused.
> > >
> > > Usage:
> > >   -object filter-redirector,id=3Df0,netdev=3Dnet0,queue=3Dtx,\
> > >           outdev=3Dchardev0,enable_when_stopped=3Dtrue
> > >
> >
> > It seems this series is trying to address previous VM migration network
> > related issues that Juraj Marcin mentioned.
> > Add CC to him.
> >
> > I've taken a quick look, and this series lacks support for
> > filter-reply and filter-rewriter.
> > Could there be a reason for this?
> >
> > Thanks
> > Chen
> >
> Hi Chen
> For this RFC, filter-reply and filter-rewriter is not need, I will add
> support for them later.

Right, I think the reason is that we don't see a use case for them.

Thanks

> Thanks
> cindy
> > .
> >
> >
> >
> >
> > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > > ---
> > >  net/filter-mirror.c                  |  38 ++++++++++
> > >  qapi/qom.json                        |   7 +-
> > >  tests/qtest/test-filter-redirector.c | 106 +++++++++++++++++++++++++=
++
> > >  3 files changed, 150 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/net/filter-mirror.c b/net/filter-mirror.c
> > > index aa2ab452fd..e1a0650abd 100644
> > > --- a/net/filter-mirror.c
> > > +++ b/net/filter-mirror.c
> > > @@ -21,6 +21,7 @@
> > >  #include "qemu/iov.h"
> > >  #include "qemu/sockets.h"
> > >  #include "block/aio-wait.h"
> > > +#include "system/runstate.h"
> > >
> > >  #define TYPE_FILTER_MIRROR "filter-mirror"
> > >  typedef struct MirrorState MirrorState;
> > > @@ -41,6 +42,8 @@ struct MirrorState {
> > >      CharFrontend chr_out;
> > >      SocketReadState rs;
> > >      bool vnet_hdr;
> > > +    bool enable_when_stopped;
> > > +    VMChangeStateEntry *vmsentry;
> > >  };
> > >
> > >  typedef struct FilterSendCo {
> > > @@ -251,6 +254,7 @@ static void filter_redirector_cleanup(NetFilterSt=
ate *nf)
> > >
> > >      qemu_chr_fe_deinit(&s->chr_in, false);
> > >      qemu_chr_fe_deinit(&s->chr_out, false);
> > > +    qemu_del_vm_change_state_handler(s->vmsentry);
> > >  }
> > >
> > >  static void filter_mirror_setup(NetFilterState *nf, Error **errp)
> > > @@ -282,6 +286,18 @@ static void redirector_rs_finalize(SocketReadSta=
te *rs)
> > >      redirector_to_filter(nf, rs->buf, rs->packet_len);
> > >  }
> > >
> > > +static void filter_redirector_vm_state_change(void *opaque, bool run=
ning,
> > > +                                              RunState state)
> > > +{
> > > +    NetFilterState *nf =3D opaque;
> > > +    MirrorState *s =3D FILTER_REDIRECTOR(nf);
> > > +    NetClientState *nc =3D nf->netdev;
> > > +
> > > +    if (!running && s->enable_when_stopped && nc->info->read_poll) {
> > > +        nc->info->read_poll(nc, true);
> > > +    }
> > > +}
> > > +
> > >  static void filter_redirector_setup(NetFilterState *nf, Error **errp=
)
> > >  {
> > >      MirrorState *s =3D FILTER_REDIRECTOR(nf);
> > > @@ -331,6 +347,9 @@ static void filter_redirector_setup(NetFilterStat=
e *nf, Error **errp)
> > >              return;
> > >          }
> > >      }
> > > +
> > > +    s->vmsentry =3D qemu_add_vm_change_state_handler(
> > > +        filter_redirector_vm_state_change, nf);
> > >  }
> > >
> > >  static void filter_redirector_status_changed(NetFilterState *nf, Err=
or **errp)
> > > @@ -437,6 +456,22 @@ static void filter_redirector_set_vnet_hdr(Objec=
t *obj,
> > >      s->vnet_hdr =3D value;
> > >  }
> > >
> > > +static bool filter_redirector_get_enable_when_stopped(Object *obj, E=
rror **errp)
> > > +{
> > > +    MirrorState *s =3D FILTER_REDIRECTOR(obj);
> > > +
> > > +    return s->enable_when_stopped;
> > > +}
> > > +
> > > +static void filter_redirector_set_enable_when_stopped(Object *obj,
> > > +                                                      bool value,
> > > +                                                      Error **errp)
> > > +{
> > > +    MirrorState *s =3D FILTER_REDIRECTOR(obj);
> > > +
> > > +    s->enable_when_stopped =3D value;
> > > +}
> > > +
> > >  static void filter_mirror_class_init(ObjectClass *oc, const void *da=
ta)
> > >  {
> > >      NetFilterClass *nfc =3D NETFILTER_CLASS(oc);
> > > @@ -463,6 +498,9 @@ static void filter_redirector_class_init(ObjectCl=
ass *oc, const void *data)
> > >      object_class_property_add_bool(oc, "vnet_hdr_support",
> > >                                     filter_redirector_get_vnet_hdr,
> > >                                     filter_redirector_set_vnet_hdr);
> > > +    object_class_property_add_bool(oc, "enable_when_stopped",
> > > +                                   filter_redirector_get_enable_when=
_stopped,
> > > +                                   filter_redirector_set_enable_when=
_stopped);
> > >
> > >      nfc->setup =3D filter_redirector_setup;
> > >      nfc->cleanup =3D filter_redirector_cleanup;
> > > diff --git a/qapi/qom.json b/qapi/qom.json
> > > index 6f5c9de0f0..b1fe55944c 100644
> > > --- a/qapi/qom.json
> > > +++ b/qapi/qom.json
> > > @@ -488,13 +488,18 @@
> > >  # @vnet_hdr_support: if true, vnet header support is enabled
> > >  #     (default: false)
> > >  #
> > > +# @enable_when_stopped: if true, activate netdev's read poll when VM
> > > +#     stops to allow filter-redirector to continue receiving data
> > > +#     (default: false)
> > > +#
> > >  # Since: 2.6
> > >  ##
> > >  { 'struct': 'FilterRedirectorProperties',
> > >    'base': 'NetfilterProperties',
> > >    'data': { '*indev': 'str',
> > >              '*outdev': 'str',
> > > -            '*vnet_hdr_support': 'bool' } }
> > > +            '*vnet_hdr_support': 'bool',
> > > +            '*enable_when_stopped': 'bool' } }
> > >
> > >  ##
> > >  # @FilterRewriterProperties:
> > > diff --git a/tests/qtest/test-filter-redirector.c b/tests/qtest/test-=
filter-redirector.c
> > > index 5540c232c0..fa958bb0a5 100644
> > > --- a/tests/qtest/test-filter-redirector.c
> > > +++ b/tests/qtest/test-filter-redirector.c
> > > @@ -385,6 +385,110 @@ static void test_redirector_init_status_off(voi=
d)
> > >      qtest_quit(qts);
> > >  }
> > >
> > > +/*
> > > + * Test filter-redirector works when VM is stopped (TX direction).
> > > + *
> > > + * This test verifies that when VM is stopped, the filter-redirector
> > > + * can still receive data from the netdev because the VM state chang=
e
> > > + * handler activates the netdev's read_poll(). Data flows from netde=
v
> > > + * to filter-redirector and out through the chardev.
> > > + *
> > > + * Data flow: backend_sock -> netdev (read_poll) -> filter-redirecto=
r -> chardev
> > > + */
> > > +static void test_redirector_with_vm_stop(void)
> > > +{
> > > +    int backend_sock[2], recv_sock;
> > > +    uint32_t ret =3D 0, len =3D 0;
> > > +    char send_buf[] =3D "Hello!!";
> > > +    char sock_path0[] =3D "filter-redirector0.XXXXXX";
> > > +    char *recv_buf;
> > > +    uint32_t size =3D sizeof(send_buf);
> > > +    size =3D htonl(size);
> > > +    QTestState *qts;
> > > +    struct timeval tv;
> > > +    fd_set rfds;
> > > +
> > > +    ret =3D socketpair(PF_UNIX, SOCK_STREAM, 0, backend_sock);
> > > +    g_assert_cmpint(ret, !=3D, -1);
> > > +
> > > +    ret =3D mkstemp(sock_path0);
> > > +    g_assert_cmpint(ret, !=3D, -1);
> > > +
> > > +    /*
> > > +     * Setup TX path: netdev -> filter-redirector -> chardev
> > > +     * Data sent to backend_sock[0] will be read by the netdev,
> > > +     * passed through filter-redirector, and output to sock_path0.
> > > +     * Enable enable_when_stopped to activate read_poll when VM stop=
s.
> > > +     */
> > > +    qts =3D qtest_initf(
> > > +        "-nic socket,id=3Dqtest-bn0,fd=3D%d "
> > > +        "-chardev socket,id=3Dredirector0,path=3D%s,server=3Don,wait=
=3Doff "
> > > +        "-object filter-redirector,id=3Dqtest-f0,netdev=3Dqtest-bn0,=
"
> > > +        "queue=3Dtx,outdev=3Dredirector0,enable_when_stopped=3Dtrue =
",
> > > +        backend_sock[1], sock_path0);
> > > +
> > > +    recv_sock =3D unix_connect(sock_path0, NULL);
> > > +    g_assert_cmpint(recv_sock, !=3D, -1);
> > > +
> > > +    /* Ensure connection is established */
> > > +    qtest_qmp_assert_success(qts, "{ 'execute' : 'query-status'}");
> > > +
> > > +    struct iovec iov[] =3D {
> > > +        {
> > > +            .iov_base =3D &size,
> > > +            .iov_len =3D sizeof(size),
> > > +        }, {
> > > +            .iov_base =3D send_buf,
> > > +            .iov_len =3D sizeof(send_buf),
> > > +        },
> > > +    };
> > > +
> > > +    /*
> > > +     * Stop the VM - this triggers our vm_state_change handler
> > > +     * which should activate the netdev's read_poll()
> > > +     */
> > > +    qtest_qmp_assert_success(qts, "{ 'execute' : 'stop'}");
> > > +
> > > +    /* Wait for VM to actually stop */
> > > +    qtest_qmp_eventwait(qts, "STOP");
> > > +
> > > +    /*
> > > +     * Send data to backend socket while VM is stopped.
> > > +     * The netdev should still read the data (because read_poll is
> > > +     * activated by our vm_state_change handler), pass it through
> > > +     * filter-redirector, and output to the chardev.
> > > +     */
> > > +    ret =3D iov_send(backend_sock[0], iov, 2, 0, sizeof(size) + size=
of(send_buf));
> > > +    g_assert_cmpint(ret, =3D=3D, sizeof(send_buf) + sizeof(size));
> > > +
> > > +    /*
> > > +     * Data should arrive at recv_sock even with VM stopped,
> > > +     * because read_poll is activated.
> > > +     */
> > > +    FD_ZERO(&rfds);
> > > +    FD_SET(recv_sock, &rfds);
> > > +    tv.tv_sec =3D 5;
> > > +    tv.tv_usec =3D 0;
> > > +    ret =3D select(recv_sock + 1, &rfds, NULL, NULL, &tv);
> > > +    g_assert_cmpint(ret, =3D=3D, 1);  /* Data should arrive */
> > > +
> > > +    ret =3D recv(recv_sock, &len, sizeof(len), 0);
> > > +    g_assert_cmpint(ret, =3D=3D, sizeof(len));
> > > +    len =3D ntohl(len);
> > > +
> > > +    g_assert_cmpint(len, =3D=3D, sizeof(send_buf));
> > > +    recv_buf =3D g_malloc(len);
> > > +    ret =3D recv(recv_sock, recv_buf, len, 0);
> > > +    g_assert_cmpint(ret, =3D=3D, len);
> > > +    g_assert_cmpstr(recv_buf, =3D=3D, send_buf);
> > > +
> > > +    g_free(recv_buf);
> > > +    close(recv_sock);
> > > +    close(backend_sock[0]);
> > > +    unlink(sock_path0);
> > > +    qtest_quit(qts);
> > > +}
> > > +
> > >  static void test_redirector_rx_event_opened(void)
> > >  {
> > >      int backend_sock[2], send_sock;
> > > @@ -489,5 +593,7 @@ int main(int argc, char **argv)
> > >                     test_redirector_init_status_off);
> > >      qtest_add_func("/netfilter/redirector_rx_event_opened",
> > >                     test_redirector_rx_event_opened);
> > > +    qtest_add_func("/netfilter/redirector_with_vm_stop",
> > > +                   test_redirector_with_vm_stop);
> > >      return g_test_run();
> > >  }
> > > --
> > > 2.52.0
> > >
> >
>


