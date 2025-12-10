Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39923D2CE17
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Dec 2025 06:53:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTE3f-0005VW-KZ; Wed, 10 Dec 2025 01:52:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vTE3Y-0005VB-IC
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 01:52:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vTE3X-0002hv-11
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 01:52:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765349528;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3vi+PuyHtCBUSmKOHpvJ22/aldxLdNehpn97rCyAH1s=;
 b=fvYgB4lYb4x7A1pIxd5latfy2cMCw5az+XcbS/vvVk6Rmtt0vdvoz6TLL025SBkXwOPaCd
 /ovSzrHkF20GhTAaOH5LqnQSDZe6JgArEv4dHHb56FpDGyWC6baTeFvEEPBH7ddQkaip/5
 X7bzsbj/uIc+/pMVI4GZFW5ORdkk3sY=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-362-bDxJJDyzMY6pQAhOR1O-2A-1; Wed, 10 Dec 2025 01:52:05 -0500
X-MC-Unique: bDxJJDyzMY6pQAhOR1O-2A-1
X-Mimecast-MFC-AGG-ID: bDxJJDyzMY6pQAhOR1O-2A_1765349524
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2956a694b47so45172435ad.1
 for <qemu-devel@nongnu.org>; Tue, 09 Dec 2025 22:52:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765349524; x=1765954324; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3vi+PuyHtCBUSmKOHpvJ22/aldxLdNehpn97rCyAH1s=;
 b=SxeYEyeNMOf9OSUYYGErW4w+mFYCKE6gUNddPWAbl9gPWfxfTqZHnXe0Mo876rthXo
 BrueGuexLxPX3PbvZY0umm0RyVN56mm5R6ugVkACpirKQaze/0Ij/nKnMmfO77FTjAt9
 zMMJC7SlGif3M2F3l/J1n49pay51Hof/ye4BzNxQab2oWjWsPt0xCFGH/a1lpDzqJkrq
 TCovly7KVhHYhNhI56Wpupn9viORZvHlEUJAW+f6U3ZRgIj1QS3qhtOMctDMfYC6isO+
 2EKfBx2GZKD4w3Re57QMujHMwSWPRznfyzo+lfbQmRl8AkP2jWh6ihkvCadlic10a5tH
 MqOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765349524; x=1765954324;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3vi+PuyHtCBUSmKOHpvJ22/aldxLdNehpn97rCyAH1s=;
 b=wBSbOjZYdW7uqDrCPgDtPYRqFJTNrK+REc0XNJOnbKDe9ICrtQWbjOznuy0LReTjDj
 ek/abgbtiab0e9k3vtD5qKhBUeAvUday7QpQd2aqKIdkMW4ebPdUVl1mL8Y4bjNQJj+j
 njIdFLYMlLYP8sd15F2elJIahjSLWHGzWnGMCJJQd7RloFkPsesI/fTIImhGmLrjEOOh
 D4MsGkDyBM8gDfYPVwU7MeSbNVPiZC49+pMlYAR+Yj1Vtd/6TAFXGYcooBb9q1HjSTMT
 aKra1SqG4nPDjRKqkKckCneVPbnPQx5wpkwdW45JnxH8vCClytdsWetqrhFh8mdan6Yf
 s7uA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWeGftUwzgtV3HPsRqG/tOUjOTyDjoYgMvSwt/54Ngx9PI5Acr8q0oO/QNGs9YhKvkcsg5Z4Va5ya+i@nongnu.org
X-Gm-Message-State: AOJu0YwpdM9ulDLd6dcSqXPf8hdGi+ySbdRsGqdj/OhNL3Wn6D7Gg81F
 O38lvHHRVe2cgOT4fERKwql0sxQ+UpY2KPa0xBilrt16x1HWXtGJ1vTHCGUUBjS1LUX22UeH5bj
 NZpvupQLnuC0bagkFG+RyhE7HS3QXaLVp2Ok+2jZjx4QAJp3KDvLMLPiTU260qmxny5YAItC66U
 bCrxsl7sFCqqlC1dq6tdRZIi8xpfrzYOo=
X-Gm-Gg: AY/fxX7USF7GGRTgir94TCXuflaGMOwR0oHfAedeGtW7GjPcwhu5c7yr4oA2LYaYtOK
 8HvzDzV0UrkS/ooLjlOJVkVat2PyR9OQ1xrBXp4K0MtwvTLP/lmWJddQbYOJ2pmieLc8HV1ymdF
 +UEG0jC4t1EnSh6x5u7YjfrIDGiVqIq3p/9r8tyLAMBQ8Iu7PsMgweUvMFke+NXKoRaeE=
X-Received: by 2002:a17:903:2308:b0:246:e1b6:f9b0 with SMTP id
 d9443c01a7336-29ec22e5a9fmr13856955ad.18.1765349523968; 
 Tue, 09 Dec 2025 22:52:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGQ8HlCE8FSWITrn1Ct+1rvDDHPS/8Rlue8qjtqMksGQiA+oFJBX2jj2TJc0ERFAXsvBKfBZmgSToX+K7PEPzE=
X-Received: by 2002:a17:903:2308:b0:246:e1b6:f9b0 with SMTP id
 d9443c01a7336-29ec22e5a9fmr13856695ad.18.1765349523494; Tue, 09 Dec 2025
 22:52:03 -0800 (PST)
MIME-Version: 1.0
References: <20251208120952.37563-1-xuchuangxclwt@bytedance.com>
 <20251208120952.37563-2-xuchuangxclwt@bytedance.com>
 <aTiK5opcOOrsFem9@x1.local>
In-Reply-To: <aTiK5opcOOrsFem9@x1.local>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 10 Dec 2025 14:51:52 +0800
X-Gm-Features: AQt7F2o3lbaP6l85AwV5mctjAu-C5-sT9rw0PJuiI_JD39tjiVNIadgzQKPyG8Y
Message-ID: <CACGkMEvKyxBry25+bz4Pzk4bWZS38jWxQDSnq49qKg0Fv3LC-w@mail.gmail.com>
Subject: Re: [RFC v1 1/2] vhost: eliminate duplicate dirty_bitmap sync when
 log shared by multiple devices
To: Peter Xu <peterx@redhat.com>
Cc: Chuang Xu <xuchuangxclwt@bytedance.com>, qemu-devel@nongnu.org,
 mst@redhat.com, 
 sgarzare@redhat.com, richard.henderson@linaro.org, pbonzini@redhat.com, 
 david@kernel.org, philmd@linaro.org, farosas@suse.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Dec 10, 2025 at 4:47=E2=80=AFAM Peter Xu <peterx@redhat.com> wrote:
>
> On Mon, Dec 08, 2025 at 08:09:51PM +0800, Chuang Xu wrote:
> > From: xuchuangxclwt <xuchuangxclwt@bytedance.com>
> >
> > Although logs can now be shared among multiple vhost devices,
> > live migration still performs repeated vhost_log_sync for each
> > vhost device during bitmap_sync, which increases the time required
> > for bitmap_sync and makes it more difficult for dirty pages to converge=
.

Please show us how you do the benchmark.

> >
> > Attempt to eliminate these duplicate sync.

I think this is suspicious, more below.

> >
> > Signed-off-by: Chuang Xu <xuchuangxclwt@bytedance.com>
>
> It looks reasonable from migration POV, but I don't know the details.
>
> Please remember to copy Jason (I added for this email) when repost.

Thanks for copying me Peter.

>
> Thanks,
>
> > ---
> >  hw/virtio/vhost.c         | 30 ++++++++++++++++++++++--------
> >  include/hw/virtio/vhost.h |  1 +
> >  2 files changed, 23 insertions(+), 8 deletions(-)
> >
> > diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> > index 266a11514a..d397ca327f 100644
> > --- a/hw/virtio/vhost.c
> > +++ b/hw/virtio/vhost.c
> > @@ -268,14 +268,6 @@ static int vhost_sync_dirty_bitmap(struct vhost_de=
v *dev,
> >      return 0;
> >  }
> >
> > -static void vhost_log_sync(MemoryListener *listener,
> > -                          MemoryRegionSection *section)
> > -{
> > -    struct vhost_dev *dev =3D container_of(listener, struct vhost_dev,
> > -                                         memory_listener);
> > -    vhost_sync_dirty_bitmap(dev, section, 0x0, ~0x0ULL);
> > -}
> > -
> >  static void vhost_log_sync_range(struct vhost_dev *dev,
> >                                   hwaddr first, hwaddr last)
> >  {
> > @@ -287,6 +279,27 @@ static void vhost_log_sync_range(struct vhost_dev =
*dev,
> >      }
> >  }
> >
> > +static void vhost_log_sync(MemoryListener *listener,
> > +                          MemoryRegionSection *section)
> > +{
> > +    struct vhost_dev *dev =3D container_of(listener, struct vhost_dev,
> > +                                         memory_listener);
> > +    struct vhost_log *log =3D dev->log;
> > +
> > +    if (log && log->refcnt > 1) {
> > +        /*
> > +         * When multiple devices use same log, we implement the logic =
of
> > +         * vhost_log_sync just like what we do in vhost_log_put.
> > +         */

We should have already avoided the duplicated syncing with
vhost_dev_should_log()? Or anything I miss here?

> > +        log->sync_cnt =3D (log->sync_cnt + 1) % log->refcnt;
> > +        if (!log->sync_cnt) {
> > +            vhost_log_sync_range(dev, 0, dev->log_size * VHOST_LOG_CHU=
NK - 1);

This will lose some syncs when the device is not the logger device
(see vhost_dev_should_log())?

> > +        }
> > +    } else {
> > +        vhost_sync_dirty_bitmap(dev, section, 0x0, ~0x0ULL);
> > +    }
> > +}
> > +
> >  static uint64_t vhost_get_log_size(struct vhost_dev *dev)
> >  {
> >      uint64_t log_size =3D 0;
> > @@ -383,6 +396,7 @@ static struct vhost_log *vhost_log_get(VhostBackend=
Type backend_type,
> >          ++log->refcnt;
> >      }
> >
> > +    log->sync_cnt =3D 0;
> >      return log;
> >  }
> >
> > diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
> > index 08bbb4dfe9..43bf1c2150 100644
> > --- a/include/hw/virtio/vhost.h
> > +++ b/include/hw/virtio/vhost.h
> > @@ -50,6 +50,7 @@ typedef unsigned long vhost_log_chunk_t;
> >  struct vhost_log {
> >      unsigned long long size;
> >      int refcnt;
> > +    int sync_cnt;
> >      int fd;
> >      vhost_log_chunk_t *log;
> >  };
> > --
> > 2.20.1
> >
>
> --
> Peter Xu
>

Thanks


