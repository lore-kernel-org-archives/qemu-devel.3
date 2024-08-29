Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1456FC83F2E
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2024 15:06:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjgiI-0004NR-Ec; Thu, 29 Aug 2024 11:05:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sjgiH-0004Mr-Mi
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 11:05:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sjgiF-0005j2-Ic
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 11:05:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724943925;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NhRYA+jZKPAtfeD1zY4r3Me8U3VwUGxSzuNhFc65Bh0=;
 b=YuBlpRKnmJMVvL8nDPx+496bF9aCpFpzN4lFEg9FY/aM29ZIohTvx2ew8jj9w1mDroMdMC
 pJUJqVaxAPt027qQE0gWm6+cAhxZ/r1jMFdfXtsOLOhpAzdX/LJtg8kpmD1j0AGoOIX5iO
 2899SC6dlj6sngDC0xtGPqsRbEj5gD0=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-6WVvmJTiOzm6y3DR1JtAVw-1; Thu, 29 Aug 2024 11:05:23 -0400
X-MC-Unique: 6WVvmJTiOzm6y3DR1JtAVw-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a86a784b1easo84105266b.2
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2024 08:05:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724943922; x=1725548722;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NhRYA+jZKPAtfeD1zY4r3Me8U3VwUGxSzuNhFc65Bh0=;
 b=cNKpZ0B7uHGRMTdGW7dPL2rRu6iYFLpNUT/alC36Rge8+RtQclOgDQaeUfvPzuTSeO
 AW0i4Qv6gDqwcXH21y6bZvCZqoEPCNCTet5XDlwFgjGVdr23nrBeCAisKwr+JylzUFtg
 F+CmMQrixlcx9Je3hf6SoNN1LJWn5I+V68iHVP/TQwekXCB1ypXnAerH7wsjwVUMJ+Lz
 zbZj17AXj9nTmCsQIotuJzQtKlUhdub6/zKK0eSD1pHpDhE3p2e8CkglLk8GbVp4txF/
 wp+GJrX/cEbZUsRbz/6hfXT+/BgxiQwllK9P0+aQlyWl5W9xrUfvoTCKsNs8XsF9E7DQ
 zHyw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+Gbhf0XF2sG6lmKD7KneSWb9080YH82Y1HX+0QKOawSiC9h+Y/PmLGJUJUW0xJKO0ZdvPPkLzfwS0@nongnu.org
X-Gm-Message-State: AOJu0Yz7AEKU3cgkGwdPLs7awfV5aFKNl8Wnkj9zbt4GdKSksuhwplIn
 mwAIveevYoCDzU3yvrHwQsYZqXd53w2JdPSkoSW6w2lFGnV9Jo4J4O1uFgOkDJ2F45cc4wsRDki
 LBY1FT7q8KN9dStqaKjp8qqscqfQTXXKUBFi3yNnaJtAKbZb/XP8G
X-Received: by 2002:a17:907:94d1:b0:a7d:e84c:a9e7 with SMTP id
 a640c23a62f3a-a897fa6b5b4mr217623466b.53.1724943921999; 
 Thu, 29 Aug 2024 08:05:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFto1NzXm0SzOerOLtoN/Nh49wei/HRJnXJivfwJJPYzAm9MgH7xvHpNMoWgrwQoDeEf51mrQ==
X-Received: by 2002:a17:907:94d1:b0:a7d:e84c:a9e7 with SMTP id
 a640c23a62f3a-a897fa6b5b4mr217613566b.53.1724943921017; 
 Thu, 29 Aug 2024 08:05:21 -0700 (PDT)
Received: from redhat.com ([2a02:14f:17c:f3dd:4b1c:bb80:a038:2df3])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8989221c3esm87825566b.190.2024.08.29.08.05.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Aug 2024 08:05:20 -0700 (PDT)
Date: Thu, 29 Aug 2024 11:05:15 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Prasad Pandit <ppandit@redhat.com>, qemu-devel@nongnu.org,
 farosas@suse.de, jasowang@redhat.com, mcoqueli@redhat.com,
 Prasad Pandit <pjp@fedoraproject.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH v2 2/2] vhost-user: add a request-reply lock
Message-ID: <20240829104323-mutt-send-email-mst@kernel.org>
References: <20240828100914.105728-1-ppandit@redhat.com>
 <20240828100914.105728-3-ppandit@redhat.com>
 <20240829033717-mutt-send-email-mst@kernel.org>
 <CAE8KmOzC__Z6wgSv9sGcAPrbbZBOQg7tD=6An-=XZVouPCA2Bg@mail.gmail.com>
 <ZtCFxLfFKvojRD2u@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZtCFxLfFKvojRD2u@x1n>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, Aug 29, 2024 at 10:29:24AM -0400, Peter Xu wrote:
> On Thu, Aug 29, 2024 at 02:45:45PM +0530, Prasad Pandit wrote:
> > Hello Michael,
> > 
> > On Thu, 29 Aug 2024 at 13:12, Michael S. Tsirkin <mst@redhat.com> wrote:
> > > Weird.  Seems to indicate some kind of deadlock?
> > 
> > * Such a deadlock should occur across all environments I guess, not
> > sure why it happens selectively. It is strange.
> > 
> > > So maybe vhost_user_postcopy_end should take the BQL?
> > ===
> > diff --git a/migration/savevm.c b/migration/savevm.c
> > index e7c1215671..31acda3818 100644
> > --- a/migration/savevm.c
> > +++ b/migration/savevm.c
> > @@ -2050,7 +2050,9 @@ static void *postcopy_ram_listen_thread(void *opaque)
> >           */
> >          qemu_event_wait(&mis->main_thread_load_event);
> >      }
> > +    bql_lock();
> >      postcopy_ram_incoming_cleanup(mis);
> > +    bql_unlock();
> > 
> >      if (load_res < 0) {
> >          /*
> > ===
> > 
> > * Actually a BQL patch above was tested and it worked fine. But not
> > sure if it is an acceptable solution. Another contention was taking
> > BQL could make things more complicated, so a local vhost-user specific
> > lock should be better.
> > 
> > ...wdyt?
> 
> I think Michael was suggesting taking bql in vhost_user_postcopy_end(), not
> in postcopy code directly.

maybe that's better, ok.

>  I'm recently looking at how to make precopy
> load even take less bql and even make it a separate thread. Above is
> definitely going backwards, per we discussed already internally.


At the same time a small bugfix is better, can be backported.


> I cherish postcopy doesn't need to take bql on its own in most paths, and
> we shouldn't add unnecessary bql requirement even if vhost-user isn't used.
> 
> Personally I still prefer we look into why a separate mutex won't work and
> why that timed out; that could be part of whoever is going to investigate
> the whole issue (including the hang later on). Otherwise I'm ok from
> migration pov that we take bql in the vhost-user hook, but not in savevm.c.
> 
> Thanks,

ok

> -- 
> Peter Xu


