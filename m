Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B488C3ABAC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 13:06:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCHzQ-0007ms-Na; Tue, 06 May 2025 09:05:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uCHzJ-0007ej-TF
 for qemu-devel@nongnu.org; Tue, 06 May 2025 09:05:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uCHzH-0004om-Ow
 for qemu-devel@nongnu.org; Tue, 06 May 2025 09:05:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746536728;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zxOnKzHLmYYhA8DcAimrLzUe6gfrXcJAOBC3Ik8cpwE=;
 b=IQYgKP+BynLaYzGiPoss43mGyYz5DrXq37+j0mvCFX25foIrTQiZpF+jSCu5uIIUBcEljt
 D9VPSh5Q177Sap0MET7BiHOpYEGO6dNrHQygaAYE5PEMDoXNSo1Z2pxlhtpGhGXOzEd9Nd
 L1vq8mXGkvAmSFLny/slf2N3pNWGUm0=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-QoTmx8tqOnKqu5YKb9QC-A-1; Tue, 06 May 2025 09:05:27 -0400
X-MC-Unique: QoTmx8tqOnKqu5YKb9QC-A-1
X-Mimecast-MFC-AGG-ID: QoTmx8tqOnKqu5YKb9QC-A_1746536726
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7c955be751aso961327285a.2
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 06:05:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746536726; x=1747141526;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zxOnKzHLmYYhA8DcAimrLzUe6gfrXcJAOBC3Ik8cpwE=;
 b=enie/grqTh06ae5yI6HDjFEH/Apl3TUiUaemFrxeVnN1+pC0GMkSQNgvkCXdwN11pZ
 bn6MTk3EJbNFVPeXM0jxaSZt5/N69/UeqMADzaq0neIX6pget7BkERxZl79FubxjXZXi
 fbwHNuKVaHinZxgAOMxGL1D38tDUsksjxhn0g3WMQ1JpQcQ5pqt+1x45FoLO7VJ1pfzD
 qW1SSebeR9EXRwDQQrysK5R9T1NXpDshWrEOQH5d3hwUQsDNi6OXcmMV6r72DnB2CiV1
 RzYKAm/co5DSvLR5X9T/VwQoXBPpswebVxpyGXroOv+z5RZPJm0eaz6iw3cPMtLYcva8
 Z5qg==
X-Gm-Message-State: AOJu0Yz9PFaTiyL5ksZn84+SZdig6k/LRYtztQ6mWxGiOq8j6Ee07W5+
 7pE0FhRdvdkxb4p7MSPljQuK7Xs9Vwj7ykV/EbHMnYkvBKKJMXYgaINydLYTG0UE4RmbkFoyU7n
 34Z8pIMHRXucvdN8cmc80hA5IxKWfMr12ooGPhRgc2wewAZEtjD1n
X-Gm-Gg: ASbGncs3gPH0q2c8bWTBtqxQcnrppaj2bFwGY/aHDsTKlKp99wt5SceObw7fvKBo0QL
 v8b33FWhAa4N4H11l0VbEOMY2cuuvlAXf4wO+qBZUzbP3YSZEmFOZHyvDO4JDOhRx6z31XY3AYq
 TAFxJ/Dnv8RX9WX3afD6uXo5l/F2kU+j4jFIsvBPHi//IokedJR2mbm/xW0WhJ/aGs4FQUsxttY
 pLezmlwaRoLP2h6Jg2HWtotvWToaG8SGBKIJk1CgcaiIO9rPw6HlXdMyNDdcrjdfY5UO0ydSt/C
 rzg=
X-Received: by 2002:a05:620a:17a6:b0:7ca:c584:7beb with SMTP id
 af79cd13be357-7cad5b37e17mr2211138285a.16.1746536726341; 
 Tue, 06 May 2025 06:05:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHHvpNIpP2a/qOqaPsVc7eyVNF2x3mxpgY8njUOtg7FVF3lngE1MUvQKAP+SoJz+x4edQWwJA==
X-Received: by 2002:a05:620a:17a6:b0:7ca:c584:7beb with SMTP id
 af79cd13be357-7cad5b37e17mr2211135185a.16.1746536725958; 
 Tue, 06 May 2025 06:05:25 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7cad23b530bsm714585985a.6.2025.05.06.06.05.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 May 2025 06:05:25 -0700 (PDT)
Date: Tue, 6 May 2025 09:05:22 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 1/2] migration/multifd: Fix received packets tracepoint
Message-ID: <aBoJEgjkXtPExq_h@x1.local>
References: <20250416134356.29879-1-farosas@suse.de>
 <20250416134356.29879-2-farosas@suse.de>
 <aBknIwPX0IXdcAkL@x1.local> <87selig1z5.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87selig1z5.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, May 05, 2025 at 06:51:58PM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Wed, Apr 16, 2025 at 10:43:55AM -0300, Fabiano Rosas wrote:
> >> When qatomic_fetch_inc() started being used to count the number of
> >> packets sent, the printing of the number of packets received stopped
> >> matching the number of packets sent.
> >> 
> >> Fix by moving the increment of the number of packets on the recv side
> >> to multifd_recv_unfill_packet().
> >> 
> >> Also change the tracepoint text because "packet num" is ambiguous for
> >> the sync since the packet number of the actual sync packet will be one
> >> less than the total number of packets seen so far.
> >
> > Would this be a hint that the recv side may not really need a global
> > packet_num counter, at all?
> >
> > On source, it needs to be there if we want to have an unified unique ID for
> > each multifd packet, so that when allcating a packet we need them to be
> > assigned properly.
> >
> > On dest, it almost only receives packets, it's still unclear to me how the
> > recv packet_num global var could help us considering we have the per-packet
> > trace in trace_multifd_recv_unfill() dumping the unique ID for each..
> >
> > So.. would it be of any use?  Would it be better if we remove it instead?
> >
> 
> It's good for debugging. The p->packet_num on the recv side will at some
> point contain the total number of packets sent, but it's hard to answer
> how many packets have arrived at any given moment just by looking at
> trace_multifd_recv_unfill(). Packets could arrive out of order.

IMHO it can also be confusing at the same time..

E.g., before this patch the value doesn't mean all the packets smaller than
that have landed.. but only the max of whatever recv side got.

While after this patch, IIUC it will increase each time, but it can be
confusing in another way when e.g. the packets arrives in different order
and this value can imply something weird.  Consider below seq:

  Packets arrival: 1,2,3,5

Then this var will be 4 even after 5 received, but without getting 4..

But yeah maybe it's still helpful when we only want to sanity check the
total amount matches on src.  I'm OK we keep it like the new definition if
that helps in any way.

> 
> I'm inclined to say that p->packet_num is the one that's useless. After
> this patch, it's only there to hold an endianness swap. We can reach the
> BE value via p->packet->packet_num already.

Yep, I think the tracepoint is more important than the value cached,
especially when cached twice..

-- 
Peter Xu


