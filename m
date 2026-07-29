Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AFD4C54F51
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2026 09:38:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wp0k4-0000Vt-Cn; Wed, 29 Jul 2026 05:38:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wp0k2-0000VQ-8s
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 05:38:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wp0k0-00005M-QY
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 05:38:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785317900;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8Os2dKUA6dgVnL1MT+Rig3IQBmbVntu1NaYMrgHRmc0=;
 b=aHAUancYLXjcc9thgu7rxGduJ6t+adP0B6VXuxdGFS1qZk+aGvVPtmdtyvTM50pApUfoYh
 QIfkN+RpV+9JrzTOM5d/xqiy6T34LykGmtTvCuMMBV2fwiowdcEnK87iNHbXN9nqvD56B6
 9P7v2g+0b8OjyqucQAUQFsEPd+UpWdA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-297-oaB5u29RO1ek-pFCL8n3-Q-1; Wed, 29 Jul 2026 05:38:17 -0400
X-MC-Unique: oaB5u29RO1ek-pFCL8n3-Q-1
X-Mimecast-MFC-AGG-ID: oaB5u29RO1ek-pFCL8n3-Q_1785317896
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4954fd771baso12008985e9.0
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2026 02:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785317896; x=1785922696; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=8Os2dKUA6dgVnL1MT+Rig3IQBmbVntu1NaYMrgHRmc0=;
 b=BWQuYI3IF1k5s4vUUO2+5pa1H+sNyvc5sOET9URr1ovSCNwJhfwMSqT+LAykJXnwSb
 xXyE7nhpo6YjY2iUIfzNLCri56igkG5q6AinOVmIYWZuCTQwkK8M6Cdjyu/KQNjib8tr
 FMOsyET/tbKio5IsX3jgQQVL7UT9YbuEmlbU4pJU9KI8sLNRiAhzgrVf8yaQRl9zWWPW
 aDV087cK2FQ6ckT1Ayz5knPDuMVYrALpQJfn1Pf/eu70VjLEB6K6WYbvbELXaPL5dTyI
 rue2tkaIAct/2LK2V2bzktmU+jL7u9D6jmhTz9VJT2Z9XDXTXwL3rJpUlno72DQcgGkO
 ZvGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785317896; x=1785922696;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=8Os2dKUA6dgVnL1MT+Rig3IQBmbVntu1NaYMrgHRmc0=;
 b=AkKufEIZh7KuxStZZnsjGbGoC6lw02XZfMqZcdxnIdCStY5kiZRyuziYODm5cjtuWB
 Gwcd2atA9NG6RYGmgUb82f3GyJzUt4o092m5eOmncDLWWl2nZvPK5XA64sDYq/V+1Il4
 I3Jb3Nx/9nvmTo/H6M3bC6uCuinnn/aFGxQoA6BoN7qIL3RcOHaLAxitqS6WgdrqqB6B
 YdS+QYncbw8E3BhDKHhJmxMBej5zdLXllICP1JrNkg6FmQsPWTQ4Mq+JxB91xUdPH665
 dOKgpvznl4qZgJp3DEnOm/5g4/i05syo6KBpoEt7QzTU9QxGs9b2Wq0aZxm462OIkeE/
 hdhQ==
X-Gm-Message-State: AOJu0YyQTuEHGX5BHApKa9YbHVXYP0SUlNzoTUOhuqALchcW0j/Hid5S
 SAMrrjq5tDZ6sp0YBbgcvRUp+OoRt9qmAwstZ6OvkI4oFDnDGgZYNbqBWrrufGxtNpZbjUMakJ6
 97Ijr9qdJzdy3v46Q+KBb+NTMn7QrQf6Bgi5/XBCezrfX76U3sBstoa7G
X-Gm-Gg: AR+sD10tSXQrwWNTfNINT0kiSCnwe0AzyZI7w4uN70/2kfSshXnteU2GhqD/x94/6oy
 Ici7r2tQbj8VIVDrjQDF5mAYB7qq1HFq3cKYCDM3cDCiiTlYs3lF5cwnfSNyjzTQ3u6f3jty2Hp
 Ph6bCUL1pNaWENoGqlq13mrD7F1Ft32mMgmg/0NIXAUho+eHbuw8Rjz02/qwlTfIBO3/DPmRQc6
 QSOfgcH3p7pK8lQADQJzpxZ57p5NsV/h9h9Rsl3oNov7J6MSnzirCywZungCBMw740VHeHCZKH8
 vkW4Rb+bhKV6KhpdnKgVRjQl68hITIA22y6Gws19WeKuU9tH8Z3Gqi8NlJc0xGxxYHuo3xp67NC
 U7dBocsSmvv8s63olld8IRuU=
X-Received: by 2002:a05:600d:8499:10b0:495:58fe:88e5 with SMTP id
 5b1f17b1804b1-497fd2d9f86mr13793835e9.2.1785317895641; 
 Wed, 29 Jul 2026 02:38:15 -0700 (PDT)
X-Received: by 2002:a05:600d:8499:10b0:495:58fe:88e5 with SMTP id
 5b1f17b1804b1-497fd2d9f86mr13793495e9.2.1785317895138; 
 Wed, 29 Jul 2026 02:38:15 -0700 (PDT)
Received: from redhat.com (ppp-94-66-118-61.home.otenet.gr. [94.66.118.61])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fb647a8d4sm6515183f8f.0.2026.07.29.02.38.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 02:38:14 -0700 (PDT)
Date: Wed, 29 Jul 2026 05:38:11 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Yonggang Luo <luoyonggang@gmail.com>, Miku Hatsune <anznu1l@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@mailo.com>,
 Zhao Liu <zhao1.liu@intel.com>, QEMU Stable <qemu-stable@nongnu.org>
Subject: Re: [PULL v2 09/30] virtio-mmio: fix QUEUE_NUM_MAX
Message-ID: <20260729053423-mutt-send-email-mst@kernel.org>
References: <cover.1785179875.git.mst@redhat.com>
 <a5cff318f06cd06b37224e15ee74d64d1df8b12b.1785179875.git.mst@redhat.com>
 <65990a19-6a7e-4c1c-9354-0fffa13cbba9@tls.msk.ru>
 <20260728154328-mutt-send-email-mst@kernel.org>
 <75f2277a-8508-4e6e-adfe-92bed9fc1bf6@tls.msk.ru>
 <20260728192047-mutt-send-email-mst@kernel.org>
 <af6d5296-9860-4c5d-a72e-f2eacac3e2e9@tls.msk.ru>
 <23cbb4e8-1467-4a0f-9af7-67e3c64cba7e@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <23cbb4e8-1467-4a0f-9af7-67e3c64cba7e@tls.msk.ru>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, Jul 29, 2026 at 12:25:30PM +0300, Michael Tokarev wrote:
> On 7/29/26 08:12, Michael Tokarev wrote:
> > On 7/29/26 02:22, Michael S. Tsirkin wrote:
> > > On Tue, Jul 28, 2026 at 11:17:34PM +0300, Michael Tokarev wrote:
> > ..
> > > > So this whole change, for older versions, becomes just:
> > > > 
> > > > --- a/hw/virtio/virtio.c
> > > > +++ b/hw/virtio/virtio.c
> > > > @@ -2572,6 +2572,8 @@ VirtQueue *virtio_add_queue(VirtIODevice *vdev, int queue_size,
> > > >       if (i == VIRTIO_QUEUE_MAX || queue_size > VIRTQUEUE_MAX_SIZE)
> > > >           abort();
> > > > 
> > > > +    queue_size = VIRTQUEUE_MAX_SIZE; /* fixed properly in 11.1. */
> > > > +
> > > 
> > > Or you can stick to upstream and add the compat entry for 11.0.
> > 
> > Compat entry for 11.0 which will never be used?
> > With a non-obvious logic which boils down to this single line?
> > 
> > Or what do you mean?
> > 
> > BTW, can't this logic be implemented without a compat property in
> > the first place?  This x-override-queue-size seems like a hack.
> > or a.. twisted way to compare a machine version.
> > 
> > Can't this very place become
> > 
> >     if (machine_version < 11.1) {
> >        queue_size = VIRTQUEUE_MAX_SIZE;
> >     }
> > 
> > instead of using this indirect property?
> 
> Michael, I still don't understand what we're doing here and - now -
> why do we need to distinguish between old and new machine types at all.
> 
> Behavior before the fixes:
> 
>  qemu always reported queue size to be the maximum allowed one (1024),
>    even if actual queue size requested and allocated was smaller
>  qemu accepted requests to elements past the allocated size, which
>    allowed to read/write past the allocated buffer - which can't be
>    considered part of ABI, obviously :)
> 
> Behavior after the fixes, for new machine types:
> 
>  qemu reports actually requested and allocated queue size
>  qemu properly disallows access past the allocated queue size
> 
> What would break if we switch to the new behavior unconditionally,
> regardless of the machine types?

It's guest visible. You will get two reads from same register
suddenly returning different values.


> I don't understand why do you suggest to implement the same logic for
> older/stable qemu versions if it will always evaluate to allocating
> the max size for the queue regardless of the requested size.
> 
> Thanks,
> 
> /mjt

My preference, normally, is to just stick to upstream as much as
possibly. I just do not want slightly different code bases when we can
trivially have one.  If nothing else, less of a chance a follow up patch
will cause conflicts, and then it snowballs from there.


-- 
MST


