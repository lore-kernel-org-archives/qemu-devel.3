Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAA41C44501
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2026 15:31:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wk1Zc-0000pb-Mj; Wed, 15 Jul 2026 11:31:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wk1Zb-0000pP-35
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 11:30:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wk1ZX-00024K-U4
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 11:30:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784129454;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=caav3EErdY9PA7Qjs73BrJQkLRJcOnQA8KV0ZfHll9M=;
 b=f7wBHD4SlyD9qo7Jrc7+fCk6m+YpZLlBY2UJg3hGkJbAGeTXasDl1mNJzUlSynLwuuYvMT
 ReTmjP8CcRvk1G8hqjpRHtbtzFA/6txtJYR4mVnk75HLeI1/YTVWwNrlH3KaxiEm+VPTME
 SwVKdLCPRY0+05gNW6C8q+lcLA7obIs=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-284-knTYC7b7MSu5h4Ttky5QXg-1; Wed, 15 Jul 2026 11:30:51 -0400
X-MC-Unique: knTYC7b7MSu5h4Ttky5QXg-1
X-Mimecast-MFC-AGG-ID: knTYC7b7MSu5h4Ttky5QXg_1784129451
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-c15ceb17a28so223900666b.3
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2026 08:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784129451; x=1784734251; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=caav3EErdY9PA7Qjs73BrJQkLRJcOnQA8KV0ZfHll9M=;
 b=tdBj16g6NAnWM/cXw0LV4XAINkV0zuCjbsLlVcaeIX7vLVJHfDnZ+rF5sZISsiTsLO
 OAaX0DHCuiyt2Z7MQtMTmCHhxEC3HSmHYNNuVYoTK8R4dr3ne8qRPjWUwOY5yWtWDCWs
 wlzTL9VSojQ5OjMktoCuS8ktcPSkhNnscrqHgObVgPxKzB54TXjBxHrdKYO2Zwmghiyf
 cZXLRSWUef0wIYxDjvrrh4SyjeDHSE5NNLYTynakL3KfppAjFF6v17toJ0FJdfgEEjFj
 rAklgFFnma0yx9zplkwounGMzUsbPeuJKL0sGRgI6ysIXJART3z6Jix9tthtqYYJnFP4
 RtPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784129451; x=1784734251;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=caav3EErdY9PA7Qjs73BrJQkLRJcOnQA8KV0ZfHll9M=;
 b=QqbyZg3Jb+FpqPbz3Y9I56IxrLvd1vtw5j0PJlYzPH513CgWEZmD/ITOBAV/DdPQwQ
 H6yzzoMuQs8GTF/jd55vmzn4XYb5FBXcRjPMwLdHgikZon0ekrBVMP4nCYzVJuA3ALyS
 CU8U21RthvLaHLCK3U8+bdrPiP9aXiFrmQSjeXJrgBDDk9JL8Hc8Uww7NFE9Xsqkw9rz
 lDR2avRkjd0VHm2zwQlG3nnjlalgpkNSW7hg4L1ZRRYWudNTn3aNPCVYsEzJOSCndWlp
 oSj3yxfDWOmSZAmwfoQNjlxhuG1PkhdOWyRHWWP7N3bZLMA6QeXplU45BMLMHH1MOhxv
 6QxQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rris9xsPwUL68uzexLJ3HIhJ194XJ3OCAI1Z77mxpTOjcc4exxLgEwFrFn76WQSvrq45qd+xN4dJEJV@nongnu.org
X-Gm-Message-State: AOJu0YyJ3j/ymGzlzJKCleq7mU4KTmF19ITXVcHKoVNhL9Uq3Xw6bxlV
 6Zv7zr4UIrfSKztDbR4y0UCW+KCCyfX/Ewr2W1IhuRpB8fljyN3ZQHoIZJzeVgVhk2oIbxlhzLg
 +ZzTcb+vj6XUUZRgnTGu0M92ec7tRx7WRtxS+XQnfYJr/lFCVVzaMO0Df
X-Gm-Gg: AfdE7cnetfC0zV0LNZ4dG0WPVwLNneovv34r+9amW+WFDLVFCid/yJKKyqC54cjst8C
 VA8uPr/H1g+hMSVp1abK9Bc5PXMb4CefeqZZf4jgdOQ66YH6/8ahS0PiRKfD3ibfgquNDKU0Uk0
 ynLL3EH+1X7dlPlXAUM+LKzduwNompq2bHgB0rBbY/IgeHT77oLvfbu5ONNDHdruY3bzZOabuU0
 IoUYZOtKw3eshW0NtXs1M9CDOynfiBAeDp2lBxrSmP1BeFMAPHv2fQ3U3yKHYtRsfdIZcQ5Kn4Z
 cicvqXq36vbspysQ2+Ht04wmWKhYXKb0mXNIOaQq1I/V1llHLbSEjfdDzQMYObFhpAX3pNnaH5R
 pFJk=
X-Received: by 2002:a17:907:f497:b0:c15:e07a:eb4b with SMTP id
 a640c23a62f3a-c161e958ae5mr792888266b.3.1784129450420; 
 Wed, 15 Jul 2026 08:30:50 -0700 (PDT)
X-Received: by 2002:a17:907:f497:b0:c15:e07a:eb4b with SMTP id
 a640c23a62f3a-c161e958ae5mr792886366b.3.1784129449823; 
 Wed, 15 Jul 2026 08:30:49 -0700 (PDT)
Received: from x1.local ([174.91.117.74]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c16874a6148sm53055266b.62.2026.07.15.08.30.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 08:30:46 -0700 (PDT)
Date: Wed, 15 Jul 2026 11:30:33 -0400
From: Peter Xu <peterx@redhat.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Fabiano Rosas <farosas@suse.de>, Alex Williamson <alex@shazbot.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH 2/2] vfio/migration: Parallelize device state transitions
Message-ID: <alenmdWqD-x3bYll@x1.local>
References: <871peqtm5t.fsf@suse.de> <ah3eheRXN1QJAGj_@x1.local>
 <ac677bf9-1372-4905-a0b8-874a74be07be@maciej.szmigiero.name>
 <ah86Z0r5sMnxwgo-@x1.local>
 <c739f4fe-1f43-45c4-b98f-109366526405@maciej.szmigiero.name>
 <e79a3746-9c7e-46a5-ad81-537b9d3affdb@maciej.szmigiero.name>
 <akvWlciUvxjDbBBZ@x1.local>
 <e602d0cd-dfc2-441d-a017-067e55418dad@maciej.szmigiero.name>
 <alZssI9OmGJyD-rc@x1.local>
 <19b76c19-4c7b-4a48-8c77-7db8746ff570@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <19b76c19-4c7b-4a48-8c77-7db8746ff570@maciej.szmigiero.name>
Received-SPF: permerror client-ip=170.10.133.124;
 envelope-from=peterx@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

On Tue, Jul 14, 2026 at 10:23:05PM +0200, Maciej S. Szmigiero wrote:
> The VFIO devices in {PRE_COPY,RUNNING}_P2P states can {still,already} accept
> DMA so in the master branch by the time prepare_cb() handlers exit and
> cb() ones start running the VFIO devices are {still,already} capable of
> accepting incoming DMA.
> 
> On the other hand, if you meant the state transition into STOP_COPY on the
> migration source currently initiated from cb() handler then there can be an
> ordering issue in principle.
> 
> It looks like the current master branch mostly avoids this by registering
> vhost-net vm_state_change handler from VirtIODevice and not from its parent
> PCI device, so with the usual PCI topology vhost-net cb() handler will run
> before the VFIO PCI device one (and so still hit DMA-capable VFIO device)
> due to the vhost-net VirtIODevice being one level deeper in the qdev tree.
> It could theoretically be problem with more complex PCI topology though.

That's an interesting observation, but neither do I think it's intentional,
nor do I think it guarantees the depth ordering. Consider when a VFIO
device is put under a few layers of PCIe switches, or PCI bridges.  In that
case the VFIO device notifier can have larger depth value v.s. the virtio
device when the virtio device is attached to the root complex.

> 
> > It is also an issue then even before P2P_DMA state introduced, because
> > before that all cb()s can be run at random orders.
> 
> Technically, the order is based on the device qdev tree depth and within
> the same qdev tree depth level it looks like the handler calling order will
> be dependent on the order the registering devices were instantiated.
> 
> This means that even before these P2P states were introduced
> VM configurations that instantiated VFIO/virtio devices in the certain
> "right" order or topology weren't affected.
> 
> So maybe adding these P2P states mostly fixed this issue too?

I still think they're two different issues, and I still think with/without
P2P the issue is the same, now I tend to agree this issue exists,
especially if virtio-blk have similar behavior like virtio-net.

For one example of virtio-blk DMA to VFIO MMIO regions:

https://lore.kernel.org/r/20260616052552.389021-1-gshan@redhat.com

Said that, I don't know it's 100% triggerable in this case with notifiers,
but sounds relevant.  For virtio-net and others, I have less idea.

In all cases, I still think there are two issues to fix, and I think we
don't need to fix this problem in one shot. I still don't think they're
directly relevant, at least on the goals.

So with what I suggested previously relying on prepare_cb() I believe we
can still do the concurrency issue you're looking for, making sure when
reaching VFIO's cb() it's still at least accepting DMAs (P2P is fine).

For the other issue you reported, even if existed, I am not yet sure VFIO
is the only special case that got affected.  I think it's possible some
other emulated devices suffer the same even if it has no direct hardware
attached.  Say, there can be device backends got stopped in cb() when VM
stopped, further DMA to it may cause assertions, then it's the same issue
that needs solving, where essentially we may require all such devices to
provide similar P2P states like VFIO to make sure they initiate DMAs and
flush them in a prepare_cb(), then if all devices' prepare_cb() will make
sure no DMA to be initiated anymore, cb()s will have no ordering constraint
on DMAs.

Thanks,

-- 
Peter Xu


