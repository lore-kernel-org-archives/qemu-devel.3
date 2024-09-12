Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 634F8EED608
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 13:45:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sok8e-0003mg-3n; Thu, 12 Sep 2024 09:45:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sok8Z-0003R4-GW
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 09:45:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sok8X-0000pS-Pl
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 09:45:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726148728;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w9WQvflbyUC8w3YTQ7r9eekgu8c20UfWWRZN/fv6IRg=;
 b=I6aOKO+2bL9erhWeGljuegX8xsPLe7O5NN4QKN2emJBOoLbP7wPCCZYtONBocP3LUeYDt+
 g47nTIB2tNH1Wok/5VILR8n3Otb3gMOgyOg0u9u/ebnvPZoH5A8X4mWpDPxenjKEoAVY71
 4FbSvxR0scU28ERoChuyrJMve1ykIMc=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-133-W7LDBZLmNwuII5-jJtj8gA-1; Thu, 12 Sep 2024 09:45:23 -0400
X-MC-Unique: W7LDBZLmNwuII5-jJtj8gA-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7a9cfe4442cso152495985a.3
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2024 06:45:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726148723; x=1726753523;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=w9WQvflbyUC8w3YTQ7r9eekgu8c20UfWWRZN/fv6IRg=;
 b=OPqGcufmfqXrxSvYvyaRGTXWsPHJDGgRDJWuzNl6XCI+ygKQXyQ+3Y9c6CoE80bf8V
 KboXKdIWBNBQJNePTUxNVRK9PYQwo2mKVryDegX9NuC40dLV9AWi2sOajsiPhfefIwKl
 eAF+i2rHYfQj+l65BIbp13Z3jdvMCbKOTmkuSULsBiB7fBrk2/epVdHcsKXUgekW9kHW
 Fw8VVJF0QyGg7tw+KqYohUr8hXXVNUez/CLcTolxgyC1LLiioCO7rGHeo6qtOEbF1+7O
 +GtqJLdusTLeX5deRadLOYk/2uSJnpoY2oIxU62hdAyL5NHbBoQJeStJmFcPnDP9LnXS
 GcKw==
X-Gm-Message-State: AOJu0YwF4xZ2mogzxUF4tH7dyRI+RQIGwL9+tjcAzFXhN6PnJM8Y7UAo
 Uyxv8Ik+fkiAhqtvwGuSaaxb78NlpEl9eyKB94OPDI698uhDa7jqKo3EASp+GNF7WGz+eE+H0we
 q12ZHcye/VQTKsRu+7uiO4cGt1qREpw2HeIjo/QUmGMWEtfvefEjt
X-Received: by 2002:a05:620a:4110:b0:7a6:4a8b:46f1 with SMTP id
 af79cd13be357-7a9e5f79719mr454820985a.48.1726148722567; 
 Thu, 12 Sep 2024 06:45:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHnNIKEbgxeNRy4iU3Br+eKKRfxHp5fvZOKFQSJj5H8G/wnBgO8v/5V5jt9ZKpzh6O2M0EieA==
X-Received: by 2002:a05:620a:4110:b0:7a6:4a8b:46f1 with SMTP id
 af79cd13be357-7a9e5f79719mr454816885a.48.1726148722093; 
 Thu, 12 Sep 2024 06:45:22 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a9a7a0465csm542132985a.89.2024.09.12.06.45.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Sep 2024 06:45:21 -0700 (PDT)
Date: Thu, 12 Sep 2024 09:45:18 -0400
From: Peter Xu <peterx@redhat.com>
To: Avihai Horon <avihaih@nvidia.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Yishai Hadas <yishaih@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Maor Gottlieb <maorg@nvidia.com>, Kirti Wankhede <kwankhede@nvidia.com>,
 Tarun Gupta <targupta@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>,
 Fabiano Rosas <farosas@suse.de>, Zhiyi Guo <zhguo@redhat.com>
Subject: Re: [PATCH v11 08/11] vfio/migration: Implement VFIO migration
 protocol v2
Message-ID: <ZuLwbvntanLW6m9n@x1n>
References: <ZtiHzQHJ4PgWc21e@x1n>
 <b8807171-567b-4e21-af83-bc2f6dbbf606@nvidia.com>
 <ZtnLhW-2eo8hA7bQ@x1n>
 <812e89c4-35d8-4fc0-ac10-ec36d57f215c@nvidia.com>
 <ZtnbD69EeXhR6FFc@x1n>
 <22f013dc-6c47-4902-9b28-08e916c3cf54@nvidia.com>
 <Ztn5CcxhzYR-SFfE@x1n>
 <c4eebbbd-00aa-4893-90f8-e6faeb08db90@nvidia.com>
 <Zt8QKPZiw6BXgh-5@x1n>
 <bc31b6c4-89c8-4e04-b74d-e84422eb9901@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bc31b6c4-89c8-4e04-b74d-e84422eb9901@nvidia.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Sep 12, 2024 at 11:09:12AM +0300, Avihai Horon wrote:
> 
> On 09/09/2024 18:11, Peter Xu wrote:
> > External email: Use caution opening links or attachments
> > 
> > 
> > On Mon, Sep 09, 2024 at 03:52:39PM +0300, Avihai Horon wrote:
> > > On 05/09/2024 21:31, Peter Xu wrote:
> > > > External email: Use caution opening links or attachments
> > > > 
> > > > 
> > > > On Thu, Sep 05, 2024 at 07:45:43PM +0300, Avihai Horon wrote:
> > > > > > Does it also mean then that the currently reported stop-size - precopy-size
> > > > > > will be very close to the constant non-iterable data size?
> > > > > It's not constant, while the VM is running it can change.
> > > > I wonder how heavy is VFIO_DEVICE_FEATURE_MIG_DATA_SIZE ioctl.
> > > > 
> > > > I just gave it a quick shot with a busy VM migrating and estimate() is
> > > > invoked only every ~100ms.
> > > > 
> > > > VFIO might be different, but I wonder whether we can fetch stop-size in
> > > > estimate() somehow, so it's still a pretty fast estimate() meanwhile we
> > > > avoid the rest of exact() calls (which are destined to be useless without
> > > > VFIO).
> > > > 
> > > > IIUC so far the estimate()/exact() was because ram sync is heavy when
> > > > exact().  When idle it's 80+ms now for 32G VM with current master (which
> > > > has a bug and I'm fixing it up [1]..), even if after the fix it's 3ms (I
> > > > think both numbers contain dirty bitmap sync for both vfio and kvm).  So in
> > > > that case maybe we can still try fetching stop-size only for both
> > > > estimate() and exact(), but only sync bitmap in exact().
> > > IIUC, the end goal is to prevent migration thread spinning uselessly in
> > > pre-copy in such scenarios, right?
> > > If eventually we do call get stop-copy-size in estimate(), we will move the
> > > spinning from "exact() -> estimate() -> exact() -> estimate() ..." to
> > > "estimate() -> estimate() -> ...".
> > > If so, what benefit would we get from this? We only move the useless work to
> > > other place.
> > We can avoid exact() calls invoked for other vmstate handlers, e.g. RAM,
> > which can be much heavier and can require BQL during the slow process,
> > which can further block more vcpu operations during migration.
> > 
> > And as mentioned previously, VFIO is, AFAIK, the only handler that provide
> > different definitions of estimate() and exact(), which can be confusing,
> > and it's against the "estimate() is the fast-path" logic.
> > 
> > But I agree it's not fundamentally changing much..
> > 
> > > Shouldn't we directly go for the non precopy-able vs precopy-able report
> > > that you suggested?
> > Yep, I just thought the previous one would be much easier to achieve.
> 
> Yes, though I prefer not to add the get stop-copy-size ioctl in the
> estimate() flow because: a) it's guaranteed to be called (possibly many
> times) in every migration (either well configured which is the probable case
> or misconfigured which spins), and b) because how "heavy" get stop-copy-size
> is may differ from VFIO device to the other.
> 
> Maybe I am being a bit overcautious here, but let's explore other options
> first :)

Nop; that's totally ok.

> 
> > And
> > as you said, VFIO is still pretty special that the user will need manual
> > involvements anyway to specify e.g. very large downtimes, so this condition
> > shouldn't be a major case to happen.  Said that, if you have a solid idea
> > on this please feel free to go ahead directly with a complete solution.
> 
> I think it's possible to do it with what we currently have (VFIO uAPI-wise),
> I will try to think of one.
> 
> BTW, I checked again and I think we should drop this line from
> vfio_state_pending_exact():
>     *must_precopy += migration->precopy_init_size +
> migration->precopy_dirty_size;
> 
> I can send a patch for that.

Yes please.

I also wonder whether it'll be good to update the uAPI header too in Linux,
for vfio_device_feature_mig_data_size or VFIO_DEVICE_FEATURE_MIG_DATA_SIZE.
Currently it reads a bit ambiguous to me, while it could make a huge
difference iiuc when precopy size is non-trivial.

/*
 * Upon VFIO_DEVICE_FEATURE_GET read back the estimated data length that will
 * be required to complete stop copy.
 *
 * Note: Can be called on each device state.
 */

Maybe that'll also be helpful when other drivers will implement this, then
just to make sure both side (user / kernel) are crystal clear on the
definition.

-- 
Peter Xu


