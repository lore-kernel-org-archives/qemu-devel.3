Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF0DCCCA471
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 21:58:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4nn3-0004y9-IZ; Fri, 03 Oct 2025 17:58:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <csomani@redhat.com>)
 id 1v4nn1-0004xj-2R
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 17:58:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <csomani@redhat.com>)
 id 1v4nmy-0000ct-97
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 17:58:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759528686;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0Lf/HLvvsTKzB8cP17v4JxvKpd66wOvJpcXScfEkdcE=;
 b=TVuTkjFUcQA85y2z896lWhZCTXS0GaCBlxduNmMRzQvPkAzyUZmkH2MpLv4VeEMOhFYDCG
 JOfgefpx5chrdIDLhD9dV7LFly+j9bJ0eCu/YJPCCC8R/XsDhh//cM46YUhBL5n4x8W50l
 QlZhnTJWyZJoVPraL8E3eVpDFjt8asA=
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-459-vOIc55GjPZWi2hiJY_s-Uw-1; Fri, 03 Oct 2025 17:58:04 -0400
X-MC-Unique: vOIc55GjPZWi2hiJY_s-Uw-1
X-Mimecast-MFC-AGG-ID: vOIc55GjPZWi2hiJY_s-Uw_1759528683
Received: by mail-vk1-f199.google.com with SMTP id
 71dfb90a1353d-54a86a758a9so3790845e0c.0
 for <qemu-devel@nongnu.org>; Fri, 03 Oct 2025 14:58:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759528683; x=1760133483;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0Lf/HLvvsTKzB8cP17v4JxvKpd66wOvJpcXScfEkdcE=;
 b=BohM3V4gbb9nFLkHKAN60DyJp8vA6b3a5mk7752cy6B6fyInonZrWDXAwDSmk8SrQD
 0A15Ck3cfn4GIuOi/ESEGlsxutXn3YFl0f7CJOq050akiWwwpcYHdbrmW4AHAG2dYLN4
 XuPlLdffmByRVpRKJWWHb0uZrWBu1OjKbsdShHMPO3ZExGPDPyB93lJ3/8Kv5NBaiX9M
 TyFwkrtoeamUm4UofGRBQrj5ZQlRBCbmb2abuUiYLpcLn13C5xqh0BWSKKXBMe7MOhoI
 I9IZGvquqILwzvJcq1EOFArCg0aC9MRaCEvv163ht7jblIto7lbQjAVf+gonky3fY5f+
 eDtQ==
X-Gm-Message-State: AOJu0YxEd2i9mjMc2RRyL9KAzD5gp4rEW2nhsxldqXttr9rdek1ZCyF5
 Pwft+pBRAHH9KCcYA5yyiBaNacKFIfGzE2Ax78J33UNZvEyZn11K+kmgG3KkT5NOQZER5OjsXiR
 vzOJw/q6S9Hh00GayJPqtfp09XVXmr9cyE3RE6J8MYPb1krZ8jWZLNNj+xb9DLQFi6+TEhqgVQ7
 pcFQjQKYKj0ponZ5ELEZGdQbzM0PWTu40=
X-Gm-Gg: ASbGnctQi7iu3uw+fRpqwlNur9xHQlUuQcv2SU1qxgK0XZm1aPlvp+viuP4EikMWr1g
 hQgQ3ytveZX4IUIF0WMEQT+akkjWWkRLlpj8GCio09IdPLC/CPy3wTY29mzE0SVmU1yi56KqHEy
 RBU5hWdJbMtLOX5sFt0aHBMBYXDck=
X-Received: by 2002:a05:6122:250a:b0:54a:8690:7193 with SMTP id
 71dfb90a1353d-5524d8af72dmr2145999e0c.4.1759528683501; 
 Fri, 03 Oct 2025 14:58:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEaZ06xF8gZRnQabtYrhOi92lqjwIOy4Nh20Ivl2F4+ITvldvi/RxUFJ0jF5eo4sX5nO8IdmclAQPebBSHxIkY=
X-Received: by 2002:a05:6122:250a:b0:54a:8690:7193 with SMTP id
 71dfb90a1353d-5524d8af72dmr2145994e0c.4.1759528683101; Fri, 03 Oct 2025
 14:58:03 -0700 (PDT)
MIME-Version: 1.0
References: <20250929235244.686567-1-csomani@redhat.com>
 <aNvJGWApjqZTJFpV@redhat.com>
In-Reply-To: <aNvJGWApjqZTJFpV@redhat.com>
From: Chandan Somani <csomani@redhat.com>
Date: Fri, 3 Oct 2025 14:57:52 -0700
X-Gm-Features: AS18NWDpsHm2fribGfLYmwYC0OJ11cX3JklKloDoNahXpSsWeDnStfMWHrz-Ej8
Message-ID: <CAHEFcAR0VPRaUzDUdzG3=6kNQSP56GEDJFvR9BcDTofuASsZsA@mail.gmail.com>
Subject: Re: [PATCH] block: enable stats-intervals for virtio-blk devs with
 -blockdev
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>
Content-Type: multipart/alternative; boundary="00000000000020fb34064048326a"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=csomani@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.467,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--00000000000020fb34064048326a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 30, 2025 at 5:12=E2=80=AFAM Kevin Wolf <kwolf@redhat.com> wrote=
:

> Am 30.09.2025 um 01:52 hat Chandan geschrieben:
> > This patch allows the stats-intervals.* flag to be used with
> > -blockdev. Stats collection is initialized for virtio-blk devices
> > at their time of creation. However, it is limited to just virtio-blk
> > devices for now.
> >
> > Signed-off-by: Chandan <csomani@redhat.com>
>
> Is it intentional that this  (and the From: header) says only "Chandan"
> and not "Chandan Somani"?
>
> One fundamental question I have with this patch is if statistics should
> be collected on the BlockBackend level (which is what we're doing today)
> or on the node level. This patch can't seem to decide, so you configure
> things on the node level, but then the actual collection happens on the
> BlockBackend level and setting on the node are ignored if it isn't
> directly used by a device.
>
> If we keep things on the BlockBackend level, then intervals shouldn't be
> defined with -blockdev (which configures block nodes), but with -device
> (which configures the device that owns the BlockBackend). And
> conversely, if we think that things should be done on the node level,
> then we need to make sure that accounting actually works on the node
> level and is mostly done by the functions in block/io.c instead of the
> devices.
>
Problem I ran into was that the BlockBackends for the storage devices are
hidden from block.c,
which is why I had to collect the stats in virtio_blk_device_realize()
rather than bdrv_open_inherit().

I think it makes sense to keep it in the BlockBackend level because
the storage devices are what we really want to collect stats for, so in v2,
I add stats-intervals for storage devices with the -device option.

>
> > ---
> >  block.c                          | 50 ++++++++++++++++++++++++++++++++
> >  hw/block/virtio-blk.c            |  6 ++++
> >  include/block/block_int-common.h |  4 +++
> >  qapi/block-core.json             |  6 +++-
> >  4 files changed, 65 insertions(+), 1 deletion(-)
> >
> > diff --git a/block.c b/block.c
> > index 8848e9a7ed..e455d04e97 100644
> > --- a/block.c
> > +++ b/block.c
> > @@ -38,7 +38,9 @@
> >  #include "qapi/error.h"
> >  #include "qobject/qdict.h"
> >  #include "qobject/qjson.h"
> > +#include "qobject/qlist.h"
> >  #include "qobject/qnull.h"
> > +#include "qobject/qnum.h"
> >  #include "qobject/qstring.h"
> >  #include "qapi/qobject-output-visitor.h"
> >  #include "qapi/qapi-visit-block-core.h"
> > @@ -3956,6 +3958,35 @@ out:
> >      return bs_snapshot;
> >  }
> >
> > +static bool bdrv_parse_stats_intervals(BlockDriverState *bs, QList
> *intervals,
> > +                                  Error **errp)
> > +{
> > +    unsigned i =3D 0;
> > +    const QListEntry *entry;
> > +    bs->num_stats_intervals =3D qlist_size(intervals);
> > +
> > +    if (bs->num_stats_intervals > 0) {
> > +        bs->stats_intervals =3D g_new(uint64_t, bs->num_stats_interval=
s);
> > +    }
> > +
> > +    for (entry =3D qlist_first(intervals); entry; entry =3D
> qlist_next(entry)) {
> > +        if (qobject_type(entry->value) =3D=3D QTYPE_QNUM) {
> > +            uint64_t length =3D qnum_get_int(qobject_to(QNum,
> entry->value));
> > +
> > +            if (length > 0 && length <=3D UINT_MAX) {
> > +                bs->stats_intervals[i++] =3D length;
> > +            } else {
> > +                error_setg(errp, "Invalid interval length: %" PRId64,
> length);
> > +                return false;
> > +            }
> > +        } else {
> > +            error_setg(errp, "The specification of stats-intervals is
> invalid");
> > +            return false;
> > +        }
> > +    }
> > +    return true;
> > +}
>
> This is essentially a duplication of parse_stats_intervals() in
> blockdev.c. Can't we just call the existing function? Or in fact move it
> here and remove the existing call from blockdev_init() because -drive
> should be able to just use the per-node option that you're introducing
> here, too?
>
> >  /*
> >   * Opens a disk image (raw, qcow2, vmdk, ...)
> >   *
> > @@ -3987,6 +4018,8 @@ bdrv_open_inherit(const char *filename, const cha=
r
> *reference, QDict *options,
> >      Error *local_err =3D NULL;
> >      QDict *snapshot_options =3D NULL;
> >      int snapshot_flags =3D 0;
> > +    QDict *interval_dict =3D NULL;
> > +    QList *interval_list =3D NULL;
> >
> >      assert(!child_class || !flags);
> >      assert(!child_class =3D=3D !parent);
> > @@ -4205,6 +4238,19 @@ bdrv_open_inherit(const char *filename, const
> char *reference, QDict *options,
> >          g_free(child_key_dot);
> >      }
> >
> > +    qdict_extract_subqdict(options, &interval_dict, "stats-intervals."=
);
> > +    qdict_array_split(interval_dict, &interval_list);
> > +
> > +    if (qdict_size(interval_dict) !=3D 0) {
> > +        error_setg(errp, "Invalid option stats-intervals.%s",
> > +                   qdict_first(interval_dict)->key);
> > +        goto close_and_fail;
> > +    }
>
> I think I would move the above lines into bdrv_parse_stats_intervals().
>
> > +    if (!bdrv_parse_stats_intervals(bs, interval_list, errp)) {
> > +        goto close_and_fail;
> > +    }
> > +
> >      /* Check if any unknown options were used */
> >      if (qdict_size(options) !=3D 0) {
> >          const QDictEntry *entry =3D qdict_first(options);
> > @@ -4261,6 +4307,8 @@ close_and_fail:
> >      bdrv_unref(bs);
> >      qobject_unref(snapshot_options);
> >      qobject_unref(options);
> > +    qobject_unref(interval_dict);
> > +    qobject_unref(interval_list);
> >      error_propagate(errp, local_err);
> >      return NULL;
> >  }
> > @@ -5190,6 +5238,8 @@ static void GRAPH_UNLOCKED
> bdrv_close(BlockDriverState *bs)
> >      bs->full_open_options =3D NULL;
> >      g_free(bs->block_status_cache);
> >      bs->block_status_cache =3D NULL;
> > +    g_free(bs->stats_intervals);
> > +    bs->stats_intervals =3D NULL;
>
> Does this fix a preexisting memory leak for -drive?
>
> >      bdrv_release_named_dirty_bitmaps(bs);
> >      assert(QLIST_EMPTY(&bs->dirty_bitmaps));
> > diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
> > index 9bab2716c1..b730c67940 100644
> > --- a/hw/block/virtio-blk.c
> > +++ b/hw/block/virtio-blk.c
> > @@ -1814,6 +1814,12 @@ static void virtio_blk_device_realize(DeviceStat=
e
> *dev, Error **errp)
> >                           conf->conf.lcyls,
> >                           conf->conf.lheads,
> >                           conf->conf.lsecs);
> > +
> > +    if (bs->stats_intervals) {
> > +        for (i =3D 0; i < bs->num_stats_intervals; i++) {
> > +            block_acct_add_interval(blk_get_stats(s->blk),
> bs->stats_intervals[i]);
> > +        }
> > +    }
> >  }
>
> This could be part of block_acct_setup(), which is called by
> blkconf_apply_backend_options(). Then it would be available for more
> devices than just virtio-blk.
>
Updated in v2 to do this.

>
> >  static void virtio_blk_device_unrealize(DeviceState *dev)
> > diff --git a/include/block/block_int-common.h
> b/include/block/block_int-common.h
> > index 034c0634c8..1b4b7c636d 100644
> > --- a/include/block/block_int-common.h
> > +++ b/include/block/block_int-common.h
> > @@ -1277,6 +1277,10 @@ struct BlockDriverState {
> >
> >      /* array of write pointers' location of each zone in the zoned
> device. */
> >      BlockZoneWps *wps;
> > +
> > +    /* Array of intervals for collecting IO stats */
> > +    uint64_t *stats_intervals;
> > +    unsigned int num_stats_intervals;
> >  };
> >
> >  struct BlockBackendRootState {
> > diff --git a/qapi/block-core.json b/qapi/block-core.json
> > index dc6eb4ae23..dbb53296b1 100644
> > --- a/qapi/block-core.json
> > +++ b/qapi/block-core.json
> > @@ -4771,6 +4771,9 @@
> >  # @force-share: force share all permission on added nodes.  Requires
> >  #     read-only=3Dtrue.  (Since 2.10)
> >  #
> > +# @stats-intervals: #optional list of intervals for collecting I/O
> > +#                   statistics, in seconds (default: none)
>
> #optional is not a marker that is used anywhere else.
>
> Can we document why there are multiple intervals and what effect they
> have on the statistics that you can query later?
>
> We also need a '(Since 10.2)' note.
>
> > +#
> >  # Since: 2.9
> >  ##
> >  { 'union': 'BlockdevOptions',
> > @@ -4782,7 +4785,8 @@
> >              '*read-only': 'bool',
> >              '*auto-read-only': 'bool',
> >              '*force-share': 'bool',
> > -            '*detect-zeroes': 'BlockdevDetectZeroesOptions' },
> > +            '*detect-zeroes': 'BlockdevDetectZeroesOptions',
> > +            '*stats-intervals': ['int'] },
> >    'discriminator': 'driver',
> >    'data': {
> >        'blkdebug':   'BlockdevOptionsBlkdebug',
>
> Kevin
>
>

--00000000000020fb34064048326a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Sep 30,=
 2025 at 5:12=E2=80=AFAM Kevin Wolf &lt;<a href=3D"mailto:kwolf@redhat.com"=
>kwolf@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex">Am 30.09.2025 um 01:52 hat Chandan geschrieben:<br>
&gt; This patch allows the stats-intervals.* flag to be used with<br>
&gt; -blockdev. Stats collection is initialized for virtio-blk devices<br>
&gt; at their time of creation. However, it is limited to just virtio-blk<b=
r>
&gt; devices for now.<br>
&gt; <br>
&gt; Signed-off-by: Chandan &lt;<a href=3D"mailto:csomani@redhat.com" targe=
t=3D"_blank">csomani@redhat.com</a>&gt;<br>
<br>
Is it intentional that this=C2=A0 (and the From: header) says only &quot;Ch=
andan&quot;<br>
and not &quot;Chandan Somani&quot;?<br>
<br>
One fundamental question I have with this patch is if statistics should<br>
be collected on the BlockBackend level (which is what we&#39;re doing today=
)<br>
or on the node level. This patch can&#39;t seem to decide, so you configure=
<br>
things on the node level, but then the actual collection happens on the<br>
BlockBackend level and setting on the node are ignored if it isn&#39;t<br>
directly used by a device.<br>
<br>
If we keep things on the BlockBackend level, then intervals shouldn&#39;t b=
e<br>
defined with -blockdev (which configures block nodes), but with -device<br>
(which configures the device that owns the BlockBackend). And<br>
conversely, if we think that things should be done on the node level,<br>
then we need to make sure that accounting actually works on the node<br>
level and is mostly done by the functions in block/io.c instead of the<br>
devices.<br></blockquote><div>Problem I ran into was that the BlockBackends=
 for the storage devices are hidden from block.c,=C2=A0</div><div>which is =
why I had to collect the stats in=C2=A0virtio_blk_device_realize() rather t=
han=C2=A0bdrv_open_inherit().</div><div><br></div><div>I think it makes sen=
se to keep it in the BlockBackend level because</div><div>the storage devic=
es are what we really want to collect stats for, so in v2,</div><div>I add =
stats-intervals for storage devices with the -device option.</div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; ---<br>
&gt;=C2=A0 block.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 50 ++++++++++++++++++++++++++++++++<br=
>
&gt;=C2=A0 hw/block/virtio-blk.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 6 ++++<br>
&gt;=C2=A0 include/block/block_int-common.h |=C2=A0 4 +++<br>
&gt;=C2=A0 qapi/block-core.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0|=C2=A0 6 +++-<br>
&gt;=C2=A0 4 files changed, 65 insertions(+), 1 deletion(-)<br>
&gt; <br>
&gt; diff --git a/block.c b/block.c<br>
&gt; index 8848e9a7ed..e455d04e97 100644<br>
&gt; --- a/block.c<br>
&gt; +++ b/block.c<br>
&gt; @@ -38,7 +38,9 @@<br>
&gt;=C2=A0 #include &quot;qapi/error.h&quot;<br>
&gt;=C2=A0 #include &quot;qobject/qdict.h&quot;<br>
&gt;=C2=A0 #include &quot;qobject/qjson.h&quot;<br>
&gt; +#include &quot;qobject/qlist.h&quot;<br>
&gt;=C2=A0 #include &quot;qobject/qnull.h&quot;<br>
&gt; +#include &quot;qobject/qnum.h&quot;<br>
&gt;=C2=A0 #include &quot;qobject/qstring.h&quot;<br>
&gt;=C2=A0 #include &quot;qapi/qobject-output-visitor.h&quot;<br>
&gt;=C2=A0 #include &quot;qapi/qapi-visit-block-core.h&quot;<br>
&gt; @@ -3956,6 +3958,35 @@ out:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 return bs_snapshot;<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; +static bool bdrv_parse_stats_intervals(BlockDriverState *bs, QList *i=
ntervals,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Error **errp)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 unsigned i =3D 0;<br>
&gt; +=C2=A0 =C2=A0 const QListEntry *entry;<br>
&gt; +=C2=A0 =C2=A0 bs-&gt;num_stats_intervals =3D qlist_size(intervals);<b=
r>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (bs-&gt;num_stats_intervals &gt; 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 bs-&gt;stats_intervals =3D g_new(uint64_t=
, bs-&gt;num_stats_intervals);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 for (entry =3D qlist_first(intervals); entry; entry =3D=
 qlist_next(entry)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (qobject_type(entry-&gt;value) =3D=3D =
QTYPE_QNUM) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint64_t length =3D qnum_ge=
t_int(qobject_to(QNum, entry-&gt;value));<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (length &gt; 0 &amp;&amp=
; length &lt;=3D UINT_MAX) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bs-&gt;stats_=
intervals[i++] =3D length;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(er=
rp, &quot;Invalid interval length: %&quot; PRId64, length);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;The =
specification of stats-intervals is invalid&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 return true;<br>
&gt; +}<br>
<br>
This is essentially a duplication of parse_stats_intervals() in<br>
blockdev.c. Can&#39;t we just call the existing function? Or in fact move i=
t<br>
here and remove the existing call from blockdev_init() because -drive<br>
should be able to just use the per-node option that you&#39;re introducing<=
br>
here, too?<br>
<br>
&gt;=C2=A0 /*<br>
&gt;=C2=A0 =C2=A0* Opens a disk image (raw, qcow2, vmdk, ...)<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; @@ -3987,6 +4018,8 @@ bdrv_open_inherit(const char *filename, const ch=
ar *reference, QDict *options,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 Error *local_err =3D NULL;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 QDict *snapshot_options =3D NULL;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 int snapshot_flags =3D 0;<br>
&gt; +=C2=A0 =C2=A0 QDict *interval_dict =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 QList *interval_list =3D NULL;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 assert(!child_class || !flags);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 assert(!child_class =3D=3D !parent);<br>
&gt; @@ -4205,6 +4238,19 @@ bdrv_open_inherit(const char *filename, const c=
har *reference, QDict *options,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_free(child_key_dot);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; +=C2=A0 =C2=A0 qdict_extract_subqdict(options, &amp;interval_dict, &qu=
ot;stats-intervals.&quot;);<br>
&gt; +=C2=A0 =C2=A0 qdict_array_split(interval_dict, &amp;interval_list);<b=
r>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (qdict_size(interval_dict) !=3D 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;Invalid option sta=
ts-intervals.%s&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
qdict_first(interval_dict)-&gt;key);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto close_and_fail;<br>
&gt; +=C2=A0 =C2=A0 }<br>
<br>
I think I would move the above lines into bdrv_parse_stats_intervals().<br>
<br>
&gt; +=C2=A0 =C2=A0 if (!bdrv_parse_stats_intervals(bs, interval_list, errp=
)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto close_and_fail;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 /* Check if any unknown options were used */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (qdict_size(options) !=3D 0) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const QDictEntry *entry =3D qdict_fi=
rst(options);<br>
&gt; @@ -4261,6 +4307,8 @@ close_and_fail:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 bdrv_unref(bs);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 qobject_unref(snapshot_options);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 qobject_unref(options);<br>
&gt; +=C2=A0 =C2=A0 qobject_unref(interval_dict);<br>
&gt; +=C2=A0 =C2=A0 qobject_unref(interval_list);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 error_propagate(errp, local_err);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 return NULL;<br>
&gt;=C2=A0 }<br>
&gt; @@ -5190,6 +5238,8 @@ static void GRAPH_UNLOCKED bdrv_close(BlockDrive=
rState *bs)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 bs-&gt;full_open_options =3D NULL;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 g_free(bs-&gt;block_status_cache);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 bs-&gt;block_status_cache =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 g_free(bs-&gt;stats_intervals);<br>
&gt; +=C2=A0 =C2=A0 bs-&gt;stats_intervals =3D NULL;<br>
<br>
Does this fix a preexisting memory leak for -drive?<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 bdrv_release_named_dirty_bitmaps(bs);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 assert(QLIST_EMPTY(&amp;bs-&gt;dirty_bitmaps));<br=
>
&gt; diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c<br>
&gt; index 9bab2716c1..b730c67940 100644<br>
&gt; --- a/hw/block/virtio-blk.c<br>
&gt; +++ b/hw/block/virtio-blk.c<br>
&gt; @@ -1814,6 +1814,12 @@ static void virtio_blk_device_realize(DeviceSta=
te *dev, Error **errp)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0conf-&gt;conf.lcyls,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0conf-&gt;conf.lheads,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0conf-&gt;conf.lsecs);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (bs-&gt;stats_intervals) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i &lt; bs-&gt;num_stats_int=
ervals; i++) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 block_acct_add_interval(blk=
_get_stats(s-&gt;blk), bs-&gt;stats_intervals[i]);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt;=C2=A0 }<br>
<br>
This could be part of block_acct_setup(), which is called by<br>
blkconf_apply_backend_options(). Then it would be available for more<br>
devices than just virtio-blk.<br></blockquote><div>Updated in v2 to do this=
.</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;=
border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt;=C2=A0 static void virtio_blk_device_unrealize(DeviceState *dev)<br>
&gt; diff --git a/include/block/block_int-common.h b/include/block/block_in=
t-common.h<br>
&gt; index 034c0634c8..1b4b7c636d 100644<br>
&gt; --- a/include/block/block_int-common.h<br>
&gt; +++ b/include/block/block_int-common.h<br>
&gt; @@ -1277,6 +1277,10 @@ struct BlockDriverState {<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 /* array of write pointers&#39; location of each z=
one in the zoned device. */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 BlockZoneWps *wps;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* Array of intervals for collecting IO stats */<br>
&gt; +=C2=A0 =C2=A0 uint64_t *stats_intervals;<br>
&gt; +=C2=A0 =C2=A0 unsigned int num_stats_intervals;<br>
&gt;=C2=A0 };<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 struct BlockBackendRootState {<br>
&gt; diff --git a/qapi/block-core.json b/qapi/block-core.json<br>
&gt; index dc6eb4ae23..dbb53296b1 100644<br>
&gt; --- a/qapi/block-core.json<br>
&gt; +++ b/qapi/block-core.json<br>
&gt; @@ -4771,6 +4771,9 @@<br>
&gt;=C2=A0 # @force-share: force share all permission on added nodes.=C2=A0=
 Requires<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0read-only=3Dtrue.=C2=A0 (Since 2.10)<br>
&gt;=C2=A0 #<br>
&gt; +# @stats-intervals: #optional list of intervals for collecting I/O<br=
>
&gt; +#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0statistics, in seconds (default: none)<br>
<br>
#optional is not a marker that is used anywhere else.<br>
<br>
Can we document why there are multiple intervals and what effect they<br>
have on the statistics that you can query later?<br>
<br>
We also need a &#39;(Since 10.2)&#39; note.<br>
<br>
&gt; +#<br>
&gt;=C2=A0 # Since: 2.9<br>
&gt;=C2=A0 ##<br>
&gt;=C2=A0 { &#39;union&#39;: &#39;BlockdevOptions&#39;,<br>
&gt; @@ -4782,7 +4785,8 @@<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;*read-only&#39;: =
&#39;bool&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;*auto-read-only&#=
39;: &#39;bool&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;*force-share&#39;=
: &#39;bool&#39;,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;*detect-zeroes&#39;: &=
#39;BlockdevDetectZeroesOptions&#39; },<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;*detect-zeroes&#39;: &=
#39;BlockdevDetectZeroesOptions&#39;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;*stats-intervals&#39;:=
 [&#39;int&#39;] },<br>
&gt;=C2=A0 =C2=A0 &#39;discriminator&#39;: &#39;driver&#39;,<br>
&gt;=C2=A0 =C2=A0 &#39;data&#39;: {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;blkdebug&#39;:=C2=A0 =C2=A0&#39;Blockd=
evOptionsBlkdebug&#39;,<br>
<br>
Kevin<br>
<br>
</blockquote></div></div>

--00000000000020fb34064048326a--


