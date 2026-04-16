Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16B9CF8D762
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 18:16:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDRFV-0007w6-3n; Thu, 16 Apr 2026 14:15:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wDRFT-0007vt-Iv
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 14:15:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wDRFR-0008Ur-A8
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 14:15:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776363326;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Aq/S0MebFgjU792o/q35DiVbEF+cp7GafhuA3o5DMb8=;
 b=aIfe5zGLoaX/gT8RORd8ukk0KUZ1PUx3TrRunpJkZndP69iGn1Shz+KhlWhI0JgDZ1H8bh
 lAhWXY29HgEoU1SFPTm7BXDYeefpbd1tu+ve1rgb3vZf87uIRxAr9AHfOlKDK0djaw5aO0
 kXIMJuaZ8QPujLS6enzSO7tW+/3Dhos=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-449-uPDxUEuBNXi5A-gK5pjoFw-1; Thu, 16 Apr 2026 14:15:21 -0400
X-MC-Unique: uPDxUEuBNXi5A-gK5pjoFw-1
X-Mimecast-MFC-AGG-ID: uPDxUEuBNXi5A-gK5pjoFw_1776363321
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-794d80fea59so176075467b3.1
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 11:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776363321; x=1776968121; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Aq/S0MebFgjU792o/q35DiVbEF+cp7GafhuA3o5DMb8=;
 b=osD6oY6fWPtzoLznMdYhgI4fKwrAlTi+yRyYeW5fMxI3fAywLiuA7Jr0sri574tONg
 MJlzz08ATe7bIrk9AWwM7/5zh2l+FF3jd3Vuz8TLRRLPH5AYiwklhcMVbjBCL06W+KxA
 Fj+VJz3RgETgrp+poJsJxsAQ6ntY/FwBBDtyjdXwKjUA5bIwL1F82gdMW9oYPAQ+Am3l
 +EvjyxD+6EGQd/H+oX4kJ/U9ZAv//bRscxOxQlMMzv0tRfclInxzg3cibnX6afYCLCNj
 Y+DnVQZatqjUWY/mStcvX96XZe/DJcuqy39+PhLopFvo9x9c1n92vpEZVeG2tTfAeoZd
 yrOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776363321; x=1776968121;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Aq/S0MebFgjU792o/q35DiVbEF+cp7GafhuA3o5DMb8=;
 b=Pol1c+n+l94GWN+hQ4/4C+Fb+kZWIz3/F9HcT1Iw0NOFunau7WAKKiWDysg6yVVapM
 T8P0D2qG6/8MPtRB5bFgLSM6B6tgZ7C66403xsMhdowtCpfl12yz0Xk6QptJcldrFk6Q
 6QznTny8+FBnOoBuOrzTWhcA7R33oiACo6dBZ7ENGWDe6zrg2MDZgcW+exZ74SR27vIl
 9Vr6gIijN5pyMJUCBBUZzfgg6hVbBQ0ww0XGUgfbB8MK6ocwiI65mH1oJ+gUI1Rn9KNr
 tui/5rDTkeoLx1JkG22d3Gfc64dYfOn9/iHBrt3rEoqVtGJvsAnA+cw662nGsOqOqiZp
 4jbA==
X-Gm-Message-State: AOJu0Yxo7hNxLiMumAsqSb7U0ATmz9mdtQdKuf4MuC5CUo7bx5tYecwH
 dO/tK82Aw5D0+D/L+1H9pShVdbu5B4bGK4su2Lm6g79rqMg1lh9VDa3o+m+WCXllFXnC4YpyqhV
 8CTxMb6j185MrP8Tuydojoz2UkcE+x5VcOHNeMwHBaelFLs+wCE5gE0YL
X-Gm-Gg: AeBDieuSp/ytF3y1Ute0MQOPDePfIOcqM7F9KgsfhisCYzK5FTvRMdVjrGCRNYr+2oA
 08Dh2hXOqidTJnnGYfGdxAXMfF0KPfmF4DXuoBonf1Ebr6aYjypRdT1Z7hoeUh9Ue0VZ9nnRCTK
 t90iAE6PTjY9qr6ktxON91dSRqF+IXaUPW58INe94BvTVPYgJybm8bjiOsUmTH+XC/MDF3lxjIz
 mBUO8TlqK+rnfmZd3T7yx3dbdQj7bGCRncu/s5iVgkllQp5mms6IYvwW3jvPcMzTyV1pMq1gpK1
 3ws5uldgmHeP0I0hOVxd0F+6GNFPEvry2+2XNyQtv1LxOD1idm1KWEkqbSEichfH2B7vLqfdAyb
 4+6UBGaUSV2ZTKF72tqHC+hK3qKeq5vuBXC6Bx0Ux6+FL1SBRmlTyZSaeQQ==
X-Received: by 2002:a05:690c:6503:b0:7b2:1bf1:801b with SMTP id
 00721157ae682-7b9e16fe6b2mr1824797b3.5.1776363320755; 
 Thu, 16 Apr 2026 11:15:20 -0700 (PDT)
X-Received: by 2002:a05:690c:6503:b0:7b2:1bf1:801b with SMTP id
 00721157ae682-7b9e16fe6b2mr1824267b3.5.1776363320076; 
 Thu, 16 Apr 2026 11:15:20 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-7b7667f8de7sm27708707b3.19.2026.04.16.11.15.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 11:15:19 -0700 (PDT)
Date: Thu, 16 Apr 2026 14:15:17 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Zhiyi Guo <zhguo@redhat.com>, Juraj Marcin <jmarcin@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>, Avihai Horon <avihaih@nvidia.com>,
 Kirti Wankhede <kwankhede@nvidia.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>,
 Markus Armbruster <armbru@redhat.com>, Alex Williamson <alex@shazbot.org>,
 Hyman Huang <yong.huang@smartx.com>, Prasad Pandit <pjp@fedoraproject.org>
Subject: Re: [PATCH 09/14] migration: Move iteration counter out of RAM
Message-ID: <aeEnNQO_c6LzM2FD@x1.local>
References: <20260408165559.157108-1-peterx@redhat.com>
 <20260408165559.157108-10-peterx@redhat.com>
 <8734136atk.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8734136atk.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Thu, Apr 09, 2026 at 07:14:15PM -0300, Fabiano Rosas wrote:
> > diff --git a/migration/ram.c b/migration/ram.c
> > index e5b7217bf5..686162643d 100644
> > --- a/migration/ram.c
> > +++ b/migration/ram.c
> > @@ -1136,8 +1136,6 @@ static void migration_bitmap_sync(RAMState *rs, bool last_stage)
> >      RAMBlock *block;
> >      int64_t end_time;
> >  
> > -    qatomic_add(&mig_stats.dirty_sync_count, 1);
> > -
> >      if (!rs->time_last_bitmap_sync) {
> >          rs->time_last_bitmap_sync = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
> 
> Tangent: aren't these updates to time_last_bitmap_sync racy with the
> sync from the throttle code?

It looks fine to me.  This variable (along with log sync) should require
BQL, so I expect normal form of race condition won't happen.

But maybe you meant when migration_bitmap_sync() can be invoked by the
timer kick-offed in cpu_throttle_dirty_sync_timer_tick()?

Indeed that could happen together with the migration thread trying to sync
by other reasons, but so far I see no issues: time_last_bitmap_sync might
get updated sooner, but it should always reflect the time that whoever
synced the last, and when both want to do it they contend on BQL, which
looks ok.

So the expectation is that timer just makes sure sync happens slightly more
frequently, where QEMU src might used to sync toooo less times on huge VMs
(because each iteration took tooo long).

-- 
Peter Xu


