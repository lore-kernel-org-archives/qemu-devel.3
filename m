Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C558AC87FCB
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Aug 2025 17:05:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujhZh-0003RI-Tr; Wed, 06 Aug 2025 13:05:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1ujgR1-0003JI-Uy
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 11:52:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1ujgR0-0003EB-2O
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 11:52:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754495527;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oeRoLziABdp8UyojfXFyKy01tmnu0/cdkrdzNSIePiI=;
 b=gtXhwZM+9OuCYGs2KRueJq3DTMaSw3dlaPmZ2waKpM2Higi5NNbzALwc2rE1tL/4o+FpD/
 WU2h4fSp22cJgS+8rQMPypnuRW6syAh9THYQ8s/DfrnHK27CaM6emHf83ViDk4X0j8Gq09
 ehLkrCs/j9agkWMMVxP7DTxYvyzc+Kw=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-332-NAntp79dPSKtC4WoXcicFQ-1; Wed, 06 Aug 2025 11:52:05 -0400
X-MC-Unique: NAntp79dPSKtC4WoXcicFQ-1
X-Mimecast-MFC-AGG-ID: NAntp79dPSKtC4WoXcicFQ_1754495525
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-478f78ff9beso1283921cf.1
 for <qemu-devel@nongnu.org>; Wed, 06 Aug 2025 08:52:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754495525; x=1755100325;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oeRoLziABdp8UyojfXFyKy01tmnu0/cdkrdzNSIePiI=;
 b=BgCaTf3OUYnr+wr9EQjqjMQZiBc6b29bkQIekcCDJKmgm/A/4wUlR/7cqZUrhJWvtG
 GWGUmzAbKQiAVYZTJaeuAW3svkPtwAmwRaBV/hpxDvThwuCtvgup0WdxJKRMmZ899H16
 oq2D5szZAUVPH2QfZBdqeXIv+DN4Vduf7hbtETIeR9irJva0t0XIJdSGraSXkooS8HcV
 gTZnqLysBC4R4eQZx3aSLv2eAjHWJE12yOemiRMR+wxzpLfarcEZPlSsweURD63i2E2R
 wzHpUx3gcXViBvruffdFnEYqC/yGO0FKanwsI/HqsF7y0IUVgZvWlmFlUrVQ9B5rNnqz
 r2tw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8hqLLLA6OKzlj9VeBmHT/CFKDIho9L5S8AcXeoLBFs/zAVPPfBqss62OxNMsBgmjrC7zA8B6/4c+K@nongnu.org
X-Gm-Message-State: AOJu0YwxPDvcwuJ+oMjXe0wyTVQl+qm+dsaeO458KcAwhQn4pCAtdqu2
 x/eoCbGcUH2QXIROn/z5CzTAmtDY2slEZvoT+v5ONIwtn0JpHEogz6cQMSenPLCzsECiqiNvKWa
 4aavjWqrW0cys2ovrADUPh1RbWM9E8+5AQbtW9M5NK01Gc59+99kgiSsK
X-Gm-Gg: ASbGncvw9wh0jdypN9VRvUHPTa6tyjEcGTgqGWH7n4DtK0aAo2ZCOJevTujD9lJbiJp
 YAYMrFD1cSWoB/jy0SbJDCin0h185paHxo/07X9T6w2w+GFHLMWO74Rj3THHV4NqMiaEYsERyEP
 NKrL7uuvNtZeK5/RZDf3TmMM0g4j1HtHC4Bk2bkfIcHJ8Mw0iUNXh/K4sNT0tLIdodaVHBJzg6p
 J/yItAqzbH5SDb8Nl00nkocfkIIwE0M8pokp+UBmFrfNMvunxu7/xXTAHd+ZrsgRxQFN9AbY3Bi
 ZoYWISJBwkAPf1kkgCQbXNLSpYjRpI7z
X-Received: by 2002:ac8:7c49:0:b0:4b0:6cfd:bbf2 with SMTP id
 d75a77b69052e-4b0912cb826mr50021951cf.11.1754495524719; 
 Wed, 06 Aug 2025 08:52:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH6hVO/ynlTR6J6ukpO8ktBngaVHggbbDgd36wBKIqlUcFfbHrMjvszLjLgmpHABek/OrQSxQ==
X-Received: by 2002:ac8:7c49:0:b0:4b0:6cfd:bbf2 with SMTP id
 d75a77b69052e-4b0912cb826mr50021491cf.11.1754495524297; 
 Wed, 06 Aug 2025 08:52:04 -0700 (PDT)
Received: from x1.local ([174.89.135.171]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4af1bc47cd9sm52400181cf.13.2025.08.06.08.52.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Aug 2025 08:52:03 -0700 (PDT)
Date: Wed, 6 Aug 2025 11:51:51 -0400
From: Peter Xu <peterx@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Hamza Khan <hamza.khan@nutanix.com>
Subject: Re: [RFC V2 0/8] Live update: tap and vhost
Message-ID: <aJN6F29tcWu-Gr8y@x1.local>
References: <1752777568-236368-1-git-send-email-steven.sistare@oracle.com>
 <87cy993mdi.fsf@suse.de>
 <a01be1bc-8604-4ed1-9c22-9fe4b45de595@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a01be1bc-8604-4ed1-9c22-9fe4b45de595@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Tue, Aug 05, 2025 at 03:53:09PM -0400, Steven Sistare wrote:
> On 8/5/2025 9:54 AM, Fabiano Rosas wrote:
> > Steve Sistare <steven.sistare@oracle.com> writes:
> > 
> > > Tap and vhost devices can be preserved during cpr-transfer using
> > > traditional live migration methods, wherein the management layer
> > > creates new interfaces for the target and fiddles with 'ip link'
> > > to deactivate the old interface and activate the new.
> > > 
> > > However, CPR can simply send the file descriptors to new QEMU,
> > > with no special management actions required.  The user enables
> > > this behavior by specifing '-netdev tap,cpr=on'.  The default
> > > is cpr=off.
> > > 
> > > Steve Sistare (8):
> > >    migration: stop vm earlier for cpr
> > >    migration: cpr setup notifier
> > >    vhost: reset vhost devices for cpr
> > >    cpr: delete all fds
> > >    Revert "vhost-backend: remove vhost_kernel_reset_device()"
> > >    tap: common return label
> > >    tap: cpr support
> > >    tap: postload fix for cpr
> > > 
> > >   qapi/net.json             |   5 +-
> > >   include/hw/virtio/vhost.h |   1 +
> > >   include/migration/cpr.h   |   3 +-
> > >   include/net/tap.h         |   1 +
> > >   hw/net/virtio-net.c       |  20 +++++++
> > >   hw/vfio/device.c          |   2 +-
> > >   hw/virtio/vhost-backend.c |   6 ++
> > >   hw/virtio/vhost.c         |  32 +++++++++++
> > >   migration/cpr.c           |  24 ++++++--
> > >   migration/migration.c     |  38 ++++++++-----
> > >   net/tap-win32.c           |   5 ++
> > >   net/tap.c                 | 141 +++++++++++++++++++++++++++++++++++-----------
> > >   12 files changed, 223 insertions(+), 55 deletions(-)
> > 
> > Hi Steve,
> > 
> > Patches 1-2 seem to potentially interact with your arm pending
> > interrupts fix. Do we want them together?
> 
> Good observation, thanks!.  I may need patches 1-2 to completely close
> the dropped interrupt race.  I will do more testing to verify that.

Sorry to respond late.. Could I request (for each of the patches 1 & 2)
in-code comments explaining the order of events?

For example, patch 1 moved stop_vm even earlier for CPR.  It used to be
early because it wants to avoid dirty tracking: this is something I didn't
realize but remembered after re-read the doc..  Now it further needs to
avoid the notifiers.  A comment above stop_vm for cpr explaining all these
order of events would be really helpful (including any necessary doc update).

-- 
Peter Xu


