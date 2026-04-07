Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6D89FF5134
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2026 19:28:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wABUN-0006ER-TA; Tue, 07 Apr 2026 14:49:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wABSL-0002am-4q
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 14:47:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wA8c6-0000Ua-QR
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 11:45:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775576713;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ktoTseyRC8KHuhtiLZiQENiQ8FxtaoP9jLcNA3t+pk8=;
 b=jHSUtBloly2FbLIo7OkRF/sFOL1KLbLl4hO6W17xA1LXuTGS/YuU4kNnJ6737sJI4QQilz
 FvDInwzrmFI2hjIQHEQQ21qX9OmYDwZoaFRB6hFTbkn5kFZluO1p2Sxkem9QoPYdbXSdYp
 QFaZyenWTKoKBx8uiwgWA8xyVfb3Sy4=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-508-VNGoLp6iMc2mWPiyTsv23w-1; Tue, 07 Apr 2026 11:45:10 -0400
X-MC-Unique: VNGoLp6iMc2mWPiyTsv23w-1
X-Mimecast-MFC-AGG-ID: VNGoLp6iMc2mWPiyTsv23w_1775576710
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-50d5d1c2289so119383321cf.2
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2026 08:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1775576710; x=1776181510; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ktoTseyRC8KHuhtiLZiQENiQ8FxtaoP9jLcNA3t+pk8=;
 b=tgYIx4MGzS1H+5AS+kkICMwDaRFxb7fCw+HrA4jayMbu2/bkcRyastgBwYvpQF+0MY
 vAPdXbNMfjl5c3kOz43LjipAdYH3Xi+RHJ+PTbmeIndzo4UUrWz1k9N2O/1ntzwG0InN
 G7ZpkdNyoN+zxTiqzwRRg8A8+Z/EqHZl6kyYjJdXxgnc9vuv+PDZyV5eBe1fwyJ5KMP3
 gCz02aM48OhgKzY0xUC7jp5tXBrDs9JMG4AHySk2iwMmEqx+WbAjSPNG6Ryufu227nVx
 3Yjxsdewe5X3mYI4hnfLB3NCejSLeEfHhuyNpVDNAw2MvyglWa57EaKJdktIIlDu54Dw
 ALXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775576710; x=1776181510;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ktoTseyRC8KHuhtiLZiQENiQ8FxtaoP9jLcNA3t+pk8=;
 b=c/gtysdq0zVBZOAraDfWfO+Ye9MiUd4cXxXSasx5d2kSdzvyBKV28Mzh3N9YmKrMui
 54MUTv5JY+oxF9ya+lQ0tP6qKTZoS1PNjcu7eODhrP6y9nUHehvesO4o4FOFG70kXqBI
 4Hvy2DR89E6Y9ZPymE6qnE3u7D7zzdY3rG5Sn6appi/mi+4b5AGqeyPM0aI7E5jlMqHY
 Bk6+C1lQnCNjwtNQXN7j2Pv/wp5GppQ0nsnvNUq/L542XqO6apZ6Oc4+asm3U/Q3J186
 WvUKacuY4v7a2mF6QVa+LcBdEyZ8DrMKQ1OF+0qmy2MjPruAkaUuNNDqd1fPUiTS0xo2
 zgJg==
X-Gm-Message-State: AOJu0Yyf4papumFPWthwGo2hqYacRM2YvoEejECooMaSPAk1Lkgz5DZJ
 rvDU5t2R7bLJPwGpxewWkNP4geXBkBhSa1mvv6mjW8QO/dCidblOjhLG/2xl5p8GloXki0Bx7sb
 YPGgW2sssrQVcFiqKYP+v06JyQWbUrZdU6uOjlsbpW/8qN4iUuubDGyjN
X-Gm-Gg: AeBDietamJt28TU7YePt0kkQJ4yyzj6m8vd4x3Q3tL48DKoYGB6a6rcmierL4Y2iCac
 Ve7p5xdwBt1nNdCza7TkInNsL/TeZNqa0YJg0iiE7K+G8qk/tvT37RDkVwg4w6Yu261a9rDBPjH
 ghe/q+EhAGET0KEgjuh2tvBq83I+/lGUnRs/gCYmFwZx08vehZ+IgRallvvoKZlhiAtTpiljl8L
 qQJmWBLCn5S4H3boWx8uzCAHfvGLVdXDtxybveukm6nQtzvGMQQFy9qehYzvvr+vcfzxln72T+I
 Eqpdz7xp4lIq7BLbRL/W7gVLaW+ZFl6f56tXfHcF1wmCHcP0ptvOJvKNO0of+w7pR6YnuF2UI2x
 UrhAu6f2QHnJ9N8pdIMf8LqQSPs91vpffDNYv9d5eqorAqvU=
X-Received: by 2002:a05:622a:5988:b0:50d:a898:a14d with SMTP id
 d75a77b69052e-50da898aa3bmr28778411cf.25.1775576709468; 
 Tue, 07 Apr 2026 08:45:09 -0700 (PDT)
X-Received: by 2002:a05:622a:5988:b0:50d:a898:a14d with SMTP id
 d75a77b69052e-50da898aa3bmr28777491cf.25.1775576708954; 
 Tue, 07 Apr 2026 08:45:08 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50dacd66633sm6388281cf.12.2026.04.07.08.45.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 08:45:07 -0700 (PDT)
Date: Tue, 7 Apr 2026 11:45:06 -0400
From: Peter Xu <peterx@redhat.com>
To: Avihai Horon <avihaih@nvidia.com>
Cc: qemu-devel@nongnu.org, Juraj Marcin <jmarcin@redhat.com>,
 Kirti Wankhede <kwankhede@nvidia.com>,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>,
 Alex Williamson <alex@shazbot.org>,
 Yishai Hadas <yishaih@nvidia.com>, Fabiano Rosas <farosas@suse.de>,
 Pranav Tyagi <prtyagi@redhat.com>, Zhiyi Guo <zhguo@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Subject: Re: [PATCH RFC 08/12] vfio/migration: Fix incorrect reporting for
 VFIO pending data
Message-ID: <adUmgqqU39K2WKEF@x1.local>
References: <20260319231302.123135-1-peterx@redhat.com>
 <20260319231302.123135-9-peterx@redhat.com>
 <e6a9aaf2-e2ab-4b25-a01d-b6093922668e@nvidia.com>
 <ac6LCWmVHl8fq81J@x1.local> <ac6RbaA3V_jpfwJX@x1.local>
 <b1a8f7d9-306b-4a13-8916-828e61ed0f41@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b1a8f7d9-306b-4a13-8916-828e61ed0f41@nvidia.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Mon, Apr 06, 2026 at 03:34:20PM +0300, Avihai Horon wrote:
> 
> On 4/2/2026 6:55 PM, Peter Xu wrote:
> > External email: Use caution opening links or attachments
> > 
> > 
> > On Thu, Apr 02, 2026 at 11:28:09AM -0400, Peter Xu wrote:
> > > > Now that migration->stopcopy_size holds only the stopcopy size (and not
> > > > stopcopy+precopy), we should remove these lines from
> > > > vfio_update_estimated_pending_data():
> > > > 
> > > >      /* The total size remaining requires separate accounting */
> > > >      migration->stopcopy_size -= data_size;
> > > Good point, I missed this part when changing the definition, I'll fix.
> > Instead of changing the definition, I found that it might be cleaner to
> > keep the definition of stopcopy cache variable for VFIO (considering the
> > other invokation during save setup), then just do one more step for math.
> > 
> > The new version should look like this:
> 
> Yes, that's better. Just small comment below.
> 
> > 
> > ===8<===
> > 
> > diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> > index 655ff7712a..5aff8de844 100644
> > --- a/hw/vfio/migration.c
> > +++ b/hw/vfio/migration.c
> > @@ -585,19 +585,27 @@ static void vfio_state_pending(void *opaque, MigPendingData *pending)
> >   {
> >       VFIODevice *vbasedev = opaque;
> >       VFIOMigration *migration = vbasedev->migration;
> > -    uint64_t remain;
> > +    uint64_t precopy_size, stopcopy_size;
> > 
> >       if (pending->exact) {
> >           vfio_state_pending_sync(vbasedev);
> > -        remain = migration->stopcopy_size;
> >       } else {
> >           if (!vfio_device_state_is_precopy(vbasedev)) {
> >               return;
> 
> Now in the estimate path we shouldn't bail early if not in precopy state, so
> estimate/exact reports are consistent also for VFIO devices that don't
> support precopy.

Will do.

-- 
Peter Xu


