Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C89DD25B4C
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Jan 2026 12:24:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vl4aI-0003KM-4Y; Wed, 28 Jan 2026 07:23:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1vl4aB-0003HH-Sh
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 07:23:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1vl4a8-00071s-SB
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 07:23:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769603015;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cLWx/9f0WAsk9TFlirxpWdj05gCveQcgY8wvrJ84pzk=;
 b=ObiVLNAV5hhh9hZCx1QPRQhtxYLiU7ZOdv/odHsr6g1EBsvM5q/Si/aq0FgL7DcqREPFVf
 RiCsTpK8BMwtS/P4Ov1FAnbNOXXRDiFhDfSxuDXcIwcS64f4HCR7Tyh1YXDRG4cbpVbbfg
 do0zsx2qTdMLnz9aHOnaEEeO7Giq13k=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-17-7mAEgHVuPo-lK_1VEU75Tw-1; Wed, 28 Jan 2026 07:23:32 -0500
X-MC-Unique: 7mAEgHVuPo-lK_1VEU75Tw-1
X-Mimecast-MFC-AGG-ID: 7mAEgHVuPo-lK_1VEU75Tw_1769603011
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-47ee056e5cfso52342865e9.1
 for <qemu-devel@nongnu.org>; Wed, 28 Jan 2026 04:23:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769603011; x=1770207811; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=cLWx/9f0WAsk9TFlirxpWdj05gCveQcgY8wvrJ84pzk=;
 b=GKbMUtJyqfssUBMnwtJVn3qrd2/Kf3kj9ozWVNb+U1tHmJhFRZqL5SPrQ+sdkpuvNt
 eZabd++DhL+iOI+dzOjq3iqwZpXFbGv/6sRilLeymQSYgOBXPAuimaGgX1u2SbCuWRmY
 VS2wFKJuaTvnXF2FaZXAxkue3shHd+G6fxjGq6dMNtCu5LKkDtDpCsak94IPcd0mk4hr
 1ZdR2GcG3IeV94D4n74yqNEkjTT1RNg5mb6K3UQfLPZFtPJtb24T/sXo5CLYiR98Ob7+
 Ri8LQpuf/qkvtGOcgHb2LnXiBcXiBxbksPZGNdpv7Mxe+c7VlDjJXvu5n8NAADXC8NxN
 eg4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769603011; x=1770207811;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cLWx/9f0WAsk9TFlirxpWdj05gCveQcgY8wvrJ84pzk=;
 b=K0eRDxpJgMA3/vRNUGmI1q8e3LVgxLGk7RzEY30USQkZfv22jalp0kbCRRVM2NKPEc
 zQvLTgXMR7ktw0r55jax1zbAcAOu6dTRx4haat0QMIw8UaoDQD/drTi5OxumZVdgRxm+
 pCBDRy1GZd4Juw55KKs3lTUx3Aln0FG7yvSndiqu4SN7QZCNWuZTTTDXCoPTPT10SM0O
 xj5KXZS5hRt9rgzKzkoFEANQ//SzSBoE0i4bP9aW/L70AiHrG4X2Psw1CVqOkFNOHNJ5
 6cQ3Dq04uXXqMNcbQeo7shsrrngg6dxS3JrQgkWcCEK9zkUK08ElRjcgZhd7BzC4Btji
 YIow==
X-Gm-Message-State: AOJu0YzfgJghdyYVCDrYxt6VfqGPP7fyRrOwCYpAOwdOGfKtlujXJ+6+
 AtxgdVMr3nauKiD648m/lXjSqYL3BNca0il+U0P+rNl0enRI7AQWWf5KbMDSe8Thh0DYi13tUy7
 8aAm3+BNxFSy4rPZ9VejR6xiqS2m5rzhVemP3D18ZysUnnvy6pHq26Ltj
X-Gm-Gg: AZuq6aITyhB/ICtAg03R36AINGrNeb6xGhOY1RFZp2uM8C4BCKxWKco4wRszHvJJN0b
 0rWN30ht2T7/qkgOfn/a550JcBu1p1ZqFdwtgV7BsDP8lBMsLzmBxXE0+y3lWC8tZ4bKyvd/C0v
 hzyHRydnXhbboI/rcDMFjJ2GCTTrj6TfycMy1QYxhg9zFMLxWd57f1k079p5JnifzM9EbyJfJOk
 w6nmuNqXvKDmFMQZ5o0R+W0PlpEnmjY/vxXn4wc7rkDB5u0JgZoTPQLI3TD7BELSZbD0y+xd+MK
 UcT7FIHAkaSS+WUTKhdfgl2kmXbtu7p9Vga5L3xBCbx1Xf8oIRrbco4KV37LI/KkJg==
X-Received: by 2002:a05:600c:154c:b0:475:de12:d3b5 with SMTP id
 5b1f17b1804b1-48069c6136fmr54579185e9.34.1769603010770; 
 Wed, 28 Jan 2026 04:23:30 -0800 (PST)
X-Received: by 2002:a05:600c:154c:b0:475:de12:d3b5 with SMTP id
 5b1f17b1804b1-48069c6136fmr54578785e9.34.1769603010295; 
 Wed, 28 Jan 2026 04:23:30 -0800 (PST)
Received: from fedora ([213.175.37.14]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48066bfb59asm119169585e9.7.2026.01.28.04.23.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jan 2026 04:23:29 -0800 (PST)
Date: Wed, 28 Jan 2026 13:23:27 +0100
From: Juraj Marcin <jmarcin@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Peter Xu <peterx@redhat.com>,
 Jason Wang <jasowang@redhat.com>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: Re: [PATCH 4/4] migration: Pass network packets received during
 switchover to dest VM
Message-ID: <g4ojj5bjy6rleaerjjz6xyolcpyarta3hm7qwza5knz64xsy64@xdpxpy7f5yck>
References: <20260127140316.4187221-1-jmarcin@redhat.com>
 <20260127140316.4187221-5-jmarcin@redhat.com>
 <aXjK01KuENw23xtV@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aXjK01KuENw23xtV@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jmarcin@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Hi Daniel,

On 2026-01-27 14:25, Daniel P. Berrangé wrote:
> On Tue, Jan 27, 2026 at 03:03:10PM +0100, Juraj Marcin wrote:
> > From: Juraj Marcin <jmarcin@redhat.com>
> > 
> > During migration switchover both the source and the destination machines
> > are paused (compute downtime). During this period network still routes
> > network packets to the source machine, as this is the last place where
> > the recipient MAC address has been seen. Once the destination side
> > starts and sends network announcement, all subsequent frames are routed
> > correctly. However, frames delivered to the source machine are never
> > processed and lost. This causes also a network downtime with roughly the
> > same duration as compute downtime.
> > 
> > This can cause problems not only for protocols that cannot handle packet
> > loss, but can also introduce delays in protocols that can handle them.
> > 
> > To resolve this, this feature instantiates a network filter for each
> > network backend present during migration setup on both migration sides.
> > On the source side, this filter caches all packets received from the
> > backend during switchover. Once the destination machine starts, all
> > cached packets are sent through the migration channel and the respective
> > filter object on the destination side injects them to the NIC attached
> > to the backend.
> 
> If the dest QEMU has started, I presume this means that the ARP
> announcement has been sent ?   IOW, the packets being forwarded
> over the migration stream are guaranteed to be delivered "out
> of order" wrt the sender.  Should be safe for TCP, but may have
> an impact on other protocols. Though apps should be aware of
> that risk in general, they may not frequently encounter it, and
> it could still cause service disruption

Yes, after ARP announcement from dest. Forwarded packets could get
delivered out-of-order, although it would depend on the traffic rate, in
my testing I encountered out-of-order packets only a couple of times. As
is, this feature allows choosing between risk of packet loss or out of
order delivery, both of which could also happen outside the migration
scope.

I could also update it and defer the delivery of new packets on the
destination until packets from the source side are processed as Michael
suggested, that should prevent out of order delivery.

> 
> > diff --git a/qapi/migration.json b/qapi/migration.json
> > index f925e5541b..d637b22c80 100644
> > --- a/qapi/migration.json
> > +++ b/qapi/migration.json
> > @@ -520,6 +520,11 @@
> >  #     each RAM page.  Requires a migration URI that supports seeking,
> >  #     such as a file.  (since 9.0)
> >  #
> > +# @netpass: Collect packets received by network backedns after source
> > +#     VM is paused and send them to the destination once it resumes.
> > +#     This (almost) completely eliminates packet loss caused by
> > +#     switchover.  (since 11.0)
> 
> Should mention they will be deliver "out of order" 
> 
> > +#
> >  # Features:
> >  #
> >  # @unstable: Members @x-colo and @x-ignore-shared are experimental.
> > @@ -536,7 +541,7 @@
> >             { 'name': 'x-ignore-shared', 'features': [ 'unstable' ] },
> >             'validate-uuid', 'background-snapshot',
> >             'zero-copy-send', 'postcopy-preempt', 'switchover-ack',
> > -           'dirty-limit', 'mapped-ram'] }
> > +           'dirty-limit', 'mapped-ram', 'netpass'] }
> >  
> >  ##
> >  # @MigrationCapabilityStatus:
> > -- 
> > 2.52.0
> > 
> > 
> 
> With regards,
> Daniel
> -- 
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
> 


