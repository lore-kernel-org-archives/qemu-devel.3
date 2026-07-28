Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3AC7C54F54
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 19:26:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wonQz-0002Yu-UC; Tue, 28 Jul 2026 15:25:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wonQq-0002Y1-P9
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 15:25:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wonQo-00010h-6b
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 15:25:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785266736;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MgnvVgQ59WuAcShyldQDiu/+/bA41fRDqZ1Mh8ptMuQ=;
 b=Db4LSS8Grsx6DucfO6KLU1J+yuSBvIGECFhFZyqkNNpp1g/iX7iEI7XydurzYDoCboRZUc
 75QHD2+PJ4M9fS9inQ3VUgTq7TsepRI8C42qaEx0SteEGr81nn9S0R7cdL8hzfcyLjnD65
 WzeAjJAMC8Rs4fOGxRfaYS8wN2rogjs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-OjsFixALPcmecA-kk7cFPQ-1; Tue, 28 Jul 2026 15:25:34 -0400
X-MC-Unique: OjsFixALPcmecA-kk7cFPQ-1
X-Mimecast-MFC-AGG-ID: OjsFixALPcmecA-kk7cFPQ_1785266733
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-47f4bff865cso180514f8f.0
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 12:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785266733; x=1785871533; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=MgnvVgQ59WuAcShyldQDiu/+/bA41fRDqZ1Mh8ptMuQ=;
 b=THua+aVoDTSUqqCiHTuS/Yb5MM3LwMO/ZA8iuiuCiH6qg1GBewUrdJE5bplcwZZVs/
 S+ZUUmTykxH/fqrNEKFQOAI6Vn7gHo9qr1VvIu788BcY9bk3MZM2BN82e9pDfi578eYJ
 g7IzlkxUMlUPkJAsDWlYEvHKDjGys7GeytYlvtETTm/4e4k9qV9pKqC0kMkkFbOrow/j
 PwSSYeyyPa5B4SV2T6gRLuOi4MykuoogS+qunb3yNGSVWusbBo1XFs0kCUJXeEjk7Ddk
 Spzh6Xi28X3uRNFFpQELfjNg4AlogvQjQUj9J/hxrepIDxNOIyZLDY+DVEqgalwIh2+k
 ZKhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785266733; x=1785871533;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MgnvVgQ59WuAcShyldQDiu/+/bA41fRDqZ1Mh8ptMuQ=;
 b=JQsZBZ+WtoYchy1V81A36s6M5zeBth1Jsq9WQ32Yha7MmcqjgUfcTgPYBdVIgDUegv
 rLpxGTrn3NcmGxqan67C7lSEmHOQ56CdQsncz3r1dbUvkSAOt9K04BfoJGK6ZWgVXlDB
 chmtsifQoDvWop5TXr54VRGLg7GiCIEs1iTyiLcvIU2lOwEx76k4re+ymO/d49S22HJh
 PKfOOFTLk/pFufzR49P03Juc/f7fpXIhOqJoTs5UWwvkTvf4HNHuWt46HicRs45eIcQG
 +EKzyUz7FIB27UrC8/SyJTbalyVx+MyiWYsDyLQIIKdHPhTgMzV4wLCVzSsWsmP8TGwA
 a3qg==
X-Gm-Message-State: AOJu0YyGodepqKsUX3ubHgHWnMFA9RjTx89SBkpnkOSdzY7EuETHC1TM
 8NuhGG7zphtzNkZKCYV4LKHBU5STvE55GWTXoN/n0JJ4OkrayR2myxwKcMq8ElDWXNHddrbPwKf
 HYUiQqkRysFGQQmalYq1pGi5/FDzIQuuciz0E5PTrxXci9annAFyUMW+9
X-Gm-Gg: AR+sD12Q1G3NCRgvhJmLQ2bGbuF4QRFrUIOTW9ozSM3pbtMLUGxyOpVRjcZtvvCpKjo
 9bWX7TPy+Ndy0MlufJ7ql5zqv5BuLszrdW9QCvC7IvmGOaIniDlL4GYnHlUqDTjv/wGw4Sdibkl
 RXp3ReDK8GRXIG83kXJoVved/ju98xHrAeyPfvTnysmKgfY/d/aFagxqKNjy1eGpH1hnMI46H4b
 kToTNpEu+4Yu2hiZIjJx0bqSFaNpYgD/1vd4aH/dABKyj1Ic8D+OAPGD0qTmde5FvsCJgtUJczw
 I0YKi9qe9/2xwMCoNdEOLYzTwG9xNw3SpBZ4Yt86/Htd2MSU1wudhpZoRVnvnYpDIy48Qm+krNy
 Z2M8LH2cYFyxwRxyJzxkAX1c=
X-Received: by 2002:a05:6000:2284:b0:47f:9404:5185 with SMTP id
 ffacd0b85a97d-47fb1ee2a71mr4529779f8f.24.1785266733399; 
 Tue, 28 Jul 2026 12:25:33 -0700 (PDT)
X-Received: by 2002:a05:6000:2284:b0:47f:9404:5185 with SMTP id
 ffacd0b85a97d-47fb1ee2a71mr4529753f8f.24.1785266732912; 
 Tue, 28 Jul 2026 12:25:32 -0700 (PDT)
Received: from redhat.com (ppp-94-66-118-61.home.otenet.gr. [94.66.118.61])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fb6ad01b6sm1617900f8f.16.2026.07.28.12.25.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 12:25:32 -0700 (PDT)
Date: Tue, 28 Jul 2026 15:25:29 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] virtio: stop migrating num_default, validate vring.num
 on load
Message-ID: <20260728152255-mutt-send-email-mst@kernel.org>
References: <3e6a7c403f93acc37af6a6332fdc65049ae218fb.1784894327.git.mst@redhat.com>
 <e27b1577-1dc4-4af7-8be7-079c4e86e4fa@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e27b1577-1dc4-4af7-8be7-079c4e86e4fa@tls.msk.ru>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
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

On Tue, Jul 28, 2026 at 11:55:41AM +0300, Michael Tokarev wrote:
> On 7/24/26 14:58, Michael S. Tsirkin wrote:
> > num_default tracks the allocation size of used_elems, set by
> > virtio_add_queue(). Migrating it via the ringsize subsection is
> > wrong: a migration stream (malicious or simply from a different
> > configuration) can inflate num_default so that
> > virtio_queue_set_num() accepts oversized values, leading to OOB
> > access on the used_elems array.
> > 
> > It is not even migrated consistently: a configuration with a
> > smaller num_default could thinkably migrate and work but in the
> > common case of num == num_default the value is not actually sent.
> > 
> > Stop migrating num_default: make virtio_ringsize_needed() return
> > false so the subsection is never sent, and use VMSTATE_UNUSED to
> > consume the field from old streams without applying it. The
> > destination keeps its local num_default from virtio_add_queue(),
> > which matches the actual allocation.
> 
> What happens here with an attempt to migrate to an earlier
> version of qemu, without this patch applied, but with non-
> default values of vring.num?


It just works.

> Maybe we should send the values still, but always validate
> them on load?
>
> Also, what should we do here on older (stable) releases?
> It raises the same question, how about migrating back to
> a version without this change?
> 
> Thanks,
> 
> /mjt

We should never have sent them. Skipping the value works fine.

> > Also validate vring.num against num_default when loading the core
> > virtio state, rejecting streams that supply a queue size larger
> > than the locally allocated maximum.
> > 
> > Fixes: 46c5d0823d ("virtio: ring sizes vs. reset")
> > Fixes: 50e5ae4dc3 ("migration/virtio: Remove simple .get/.put use")
> > Cc: Cornelia Huck <cohuck@redhat.com>
> > Cc: Peter Maydell <peter.maydell@linaro.org>
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >   hw/virtio/virtio.c | 16 +++++++---------
> >   1 file changed, 7 insertions(+), 9 deletions(-)
> > 
> > diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> > index 94ddbfd09f..437c001a04 100644
> > --- a/hw/virtio/virtio.c
> > +++ b/hw/virtio/virtio.c
> > @@ -2817,14 +2817,6 @@ static bool virtio_packed_virtqueue_needed(void *opaque)
> >   static bool virtio_ringsize_needed(void *opaque)
> >   {
> > -    VirtIODevice *vdev = opaque;
> > -    int i;
> > -
> > -    for (i = 0; i < VIRTIO_QUEUE_MAX; i++) {
> > -        if (vdev->vq[i].vring.num != vdev->vq[i].vring.num_default) {
> > -            return true;
> > -        }
> > -    }
> >       return false;
> >   }
> > @@ -2913,7 +2905,7 @@ static const VMStateDescription vmstate_ringsize = {
> >       .version_id = 1,
> >       .minimum_version_id = 1,
> >       .fields = (const VMStateField[]) {
> > -        VMSTATE_UINT32(vring.num_default, struct VirtQueue),
> > +        VMSTATE_UNUSED(sizeof(uint32_t)),
> >           VMSTATE_END_OF_LIST()
> >       }
> >   };
> > @@ -3593,6 +3585,12 @@ virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
> >       for (i = 0; i < num; i++) {
> >           vdev->vq[i].vring.num = qemu_get_be32(f);
> > +        if (vdev->vq[i].vring.num > vdev->vq[i].vring.num_default) {
> > +            error_report("VQ %d vring.num %u exceeds allocated max %u",
> > +                         i, vdev->vq[i].vring.num,
> > +                         vdev->vq[i].vring.num_default);
> > +            return -1;
> > +        }
> >           if (k->has_variable_vring_alignment) {
> >               vdev->vq[i].vring.align = qemu_get_be32(f);
> >           }


