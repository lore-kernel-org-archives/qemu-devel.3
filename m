Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56AC2CCD1AA
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 20:36:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBJ5g-0000O9-Rm; Tue, 21 Oct 2025 16:36:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vBJ5e-0000NY-Hj
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 16:36:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vBJ5b-0007Vt-Vh
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 16:36:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761078972;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5PAMXU3IKlyVOifuBhowDqfiS0KnQc0VPFEzbI5yQM8=;
 b=DyyX4FKbEq4JOWpvZZd8fkeUqgk6DwQ0/kd5/6U6/kJa186cTMki495CJOgCUTn59DWfTC
 jhz5FPmQgR4kWp0Q818AbqMqbvK4x+f/GfzrqKLFBUIqI4Lz1XKSLffeuUvqto/rdBmdif
 QvYm8TJC7sSkV0Sk2MpnZcDY2WXbFJc=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-446-frBtS97KMpK7_bwDYWBi7Q-1; Tue, 21 Oct 2025 16:36:07 -0400
X-MC-Unique: frBtS97KMpK7_bwDYWBi7Q-1
X-Mimecast-MFC-AGG-ID: frBtS97KMpK7_bwDYWBi7Q_1761078967
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-4e8bb155690so5302611cf.0
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 13:36:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761078966; x=1761683766;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5PAMXU3IKlyVOifuBhowDqfiS0KnQc0VPFEzbI5yQM8=;
 b=KFfxgfIFx94fbU9h/w5Zd6pTsTYq1sO5zCq15pdTMxST0U9FIMi4M2SmIAwhDwZ71e
 0fcEnQ2fh5c+L7jQURZecQ0spGN910YLptV9Cygo5Bio1d9vBipr3qGZN0NuCh5X5IdB
 ry96ZRYaKFWYPBVzvxqr9LAg7QBezO6wkbFcYL7Rm6kzvet5CC9r62rmD+LTBiY1FISi
 KVtv85Vm/wK1Zk8Wz6WZTbezQy5ZVRcvdckQB7JgvUGJHV8mXdicgejpRd2MRh/15ci2
 5HnewMrLFFto4To218iqbpARYLM9AjTYohPUjO95UM7J7xfam3irkzbwLWilMsnXmkJ+
 qg8g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUdXeZDXgmt5xVvecYPa28FBugSPCqxNEYaaB1IPKWOv2QyH+TzwcoTNhCwiMpMuWOkmkpE7uVVLtGO@nongnu.org
X-Gm-Message-State: AOJu0YzsffWtOCyckkQEINaDrRd5hjhb/Jiz6mFC5tv1VRBPCFMckoBt
 imiLGtDi32+L4RKR576ioe1KfLAUF/ljx+daTCU0N+mMIeKxL0gbweFi90i7I2ChrC9GEc1689Y
 +SR6oH/I8ZSKYQL8YX5H/Om5OG9O5+OEBLzedK6VoJ6thADcJjUHVH/7I
X-Gm-Gg: ASbGncv1Ddx7c5OstGBokq4RDzboKwp0BDTExCfWwwJJki6wJPuX+BH52NWIOyuMiEL
 M4Sb7I8BlPUgX4uKsi2r2F67XS/0chkJUUwJquRRhaKeePx33gagAoi0+0r0SRO/JPF/aQoFNjv
 2GT3iyKC3BSAVkoTSo+J05E8n8GQqIDCJ399QLiOHufeHqQYloOif6OfZkUgWdUX/kacL+YVvaG
 OJ0R48K7cCdZlFcjKQNi+uta9DoP4eByAeLjZVjzui3frrA4J+zGHXI7JVtIP/o1u6P5qrdE2rh
 OmREspTW6isBWp8rbdcfoumcccQ6V37uy/83ep8m3R3/Ff7vsaJc4wCyerrM6YTE3ig=
X-Received: by 2002:ac8:584d:0:b0:4e8:a850:e7db with SMTP id
 d75a77b69052e-4e8a850fa96mr187626081cf.71.1761078966378; 
 Tue, 21 Oct 2025 13:36:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFc3wPR1/gjTRk/xcqwHxpOiX3lnez33z3yl+fSUK2Kk4zZSqQEbWzZifbW02bnElcyFVehg==
X-Received: by 2002:ac8:584d:0:b0:4e8:a850:e7db with SMTP id
 d75a77b69052e-4e8a850fa96mr187625641cf.71.1761078965910; 
 Tue, 21 Oct 2025 13:36:05 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4e8aaf34386sm80683531cf.4.2025.10.21.13.36.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Oct 2025 13:36:04 -0700 (PDT)
Date: Tue, 21 Oct 2025 16:36:03 -0400
From: Peter Xu <peterx@redhat.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: "Dr . David Alan Gilbert" <dave@treblig.org>,
 Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Yury Kotov <yury-kotov@yandex-team.ru>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Prasad Pandit <ppandit@redhat.com>, Zhang Chen <zhangckid@gmail.com>,
 Li Zhijian <lizhijian@fujitsu.com>, Juraj Marcin <jmarcin@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH RFC 1/9] migration/vfio: Remove BQL implication in
 vfio_multifd_switchover_start()
Message-ID: <aPfusyKXQcqPSOxp@x1.local>
References: <20250827205949.364606-1-peterx@redhat.com>
 <20250827205949.364606-2-peterx@redhat.com>
 <f5cfa404-c541-4448-88e0-efffa9c05902@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f5cfa404-c541-4448-88e0-efffa9c05902@maciej.szmigiero.name>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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

On Thu, Aug 28, 2025 at 08:05:46PM +0200, Maciej S. Szmigiero wrote:
> On 27.08.2025 22:59, Peter Xu wrote:
> > We may switch to a BQL-free loadvm model.  Be prepared with it.
> > 
> > Cc: Cédric Le Goater <clg@redhat.com>
> > Cc: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >   hw/vfio/migration-multifd.c | 9 +++++++--
> >   1 file changed, 7 insertions(+), 2 deletions(-)
> > 
> > diff --git a/hw/vfio/migration-multifd.c b/hw/vfio/migration-multifd.c
> > index e4785031a7..8dc8444f0d 100644
> > --- a/hw/vfio/migration-multifd.c
> > +++ b/hw/vfio/migration-multifd.c
> > @@ -763,16 +763,21 @@ int vfio_multifd_switchover_start(VFIODevice *vbasedev)
> >   {
> >       VFIOMigration *migration = vbasedev->migration;
> >       VFIOMultifd *multifd = migration->multifd;
> > +    bool bql_is_locked = bql_locked();
> >       assert(multifd);
> >       /* The lock order is load_bufs_mutex -> BQL so unlock BQL here first */
> > -    bql_unlock();
> > +    if (bql_is_locked) {
> > +        bql_unlock();
> > +    }
> >       WITH_QEMU_LOCK_GUARD(&multifd->load_bufs_mutex) {
> >           assert(!multifd->load_bufs_thread_running);
> >           multifd->load_bufs_thread_running = true;
> >       }
> > -    bql_lock();
> > +    if (bql_is_locked) {
> > +        bql_lock();
> > +    }
> >       qemu_loadvm_start_load_thread(vfio_load_bufs_thread, vbasedev);
> 
> This patch makes sense to me - I don't see anything obviously wrong here.
> 
> In general, thank you for your series Peter.
> 
> I am actually looking at a similar subject - how to make
> vfio_pci_load_config() and its sub-calls use more fine grained locking
> than BQL so device configuration loading for multiple VFIO devices
> can happen in parallel instead of being serialized by BQL.
> 
> Don't have an ETA for this yet, but it's good that other people also
> working on improving live migration scalability.

Thanks for the early quick comment on this, Maciej.  Not sure if what
you're working on is about memory transactions, if so it sounds challenging
to completely get rid of BQL.  Maybe BQL sections can be shrinked, though.

Replying here just for a quick update on this patch for when I'd repost: I
plan to drop this patch, because after switching to a thread model then
this function will constantly run without BQL. It means what I added here
above will be dead code that always have bql_is_locked==false.

Hence I decided to do it the other way round to add one vfio patch at the
end removing the BQL dependency completely.

Thanks,

-- 
Peter Xu


