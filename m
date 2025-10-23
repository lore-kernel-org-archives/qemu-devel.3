Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFAF9CCF9E3
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 19:25:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vC0v4-0001kw-Jc; Thu, 23 Oct 2025 15:24:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vC0v0-0001kX-UM
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 15:24:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vC0uy-0005so-FD
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 15:24:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761247450;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Mca+WciIXNqATJ5LIF/Gsby4fBeKyaipAM9szpEo0Ws=;
 b=YoXOglCXh/9hgG3JX+vJ5qrzlMW9Sdr+dgezauyW21tbOTOhMn1pt+dm07kMUJT7B6RJxW
 RLgZBAk9YMq/qWeVHPZ92jtLRau0vPpiqKUcH/fwKvMisptrEJBta5smtRq3uCkEtGVEv9
 SzZgN7lF1pEBOhd7equpNTooDkpi5nA=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-84-Tqjxw2WMOp2Z_pPE-gtyfQ-1; Thu, 23 Oct 2025 15:24:08 -0400
X-MC-Unique: Tqjxw2WMOp2Z_pPE-gtyfQ-1
X-Mimecast-MFC-AGG-ID: Tqjxw2WMOp2Z_pPE-gtyfQ_1761247448
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-88fec61f826so367703185a.1
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 12:24:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761247448; x=1761852248;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mca+WciIXNqATJ5LIF/Gsby4fBeKyaipAM9szpEo0Ws=;
 b=jg1y6mjZoPNBJTaiUikg1dvCa9TgtCHDJhoJVhAzUPDW3QscLv6lJW6RliI77iVY81
 4pk494+FEkC1hInJHA4k8ICMumz/Gl17DxoT/KF9Eg9swa40uzMnQBWsePT+PjAzuk9V
 ekOjhYkHWjdOns+SiLTukOH4C73QINrLcwHBV02olW8GLwvvJmPNwxU8r6+r/7Lmic4Q
 90+JT9wnJ2iwABhqC6nsAAEdleEbBBRgvboLDU6x6fUmut6lUZ6jcR3HRmmWoZdfkY0w
 FZlMcukJlHBzOXx3c46zttZ27nsfcJQakx5WB0NPbQcepkCgAadaVXl5mUVJK6WCEQWy
 fWXw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWctHzK5muTTlzuHOMYtyMbY28BAL1OsaEPaPvtPLXi9toNdxnrmSPSnD+RKPh/I1Hnu69C7uFQinjV@nongnu.org
X-Gm-Message-State: AOJu0Ywpzj6LYKM+9c3Ty2CFf2v2MpkGHmVfWZC97QYdQg5ZoA4WvOK4
 gJJz/w6/790EecZwnxf6zYJ1q2rkvdciAp5mb1GM1VT1/g8ZWSTtunq5zq05jmHoyizQSnEuUIc
 9kQC1/pAZCi9oQL+SF1xhmlxqlQ9Oj2mYha7Xp0Jxbnus4Mi+PYlgYOnL
X-Gm-Gg: ASbGnctEARVOPzJe4jhltjZo2YpwTGPlBUAL0s0IdD0PNaEbI7GlwKhMhk2tYw9Niz7
 00Eknoq+4WL1pJEcGAW4gX4u0hj8IWayE3ALFXtU6RN3hq5Q4HznO3mrSeE8kO+jKOabMaJRr1v
 9y/60Py2EBQ0ANpWr7KDxvJsFMRCzsss982+6DGXECV2jjpwZJjQzhifv2zCDBp9vz8gtjlxHEB
 0ndU+iTqDLbLyYz+7Ezi9FzcWmPYeCQ2Vkgufp+nqXU/m++bsE64Fg8arb+tXgGAX5LbCPvzEhv
 QfZDDlHXpzNWAK4sAEUEPWbTN1qOXSzlfv+yT4zv74C3HBBppfRmwgj8BpWPxifov2A=
X-Received: by 2002:a05:620a:480c:b0:809:7ac4:e5d with SMTP id
 af79cd13be357-8906eb94274mr3159208785a.38.1761247447912; 
 Thu, 23 Oct 2025 12:24:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFrRJgKPATmNqA/wmCbcots8Yqy0eTC68Ad/v0qSeN/AUiscZt7/jyolnWnUrtGXC1gFfH7kg==
X-Received: by 2002:a05:620a:480c:b0:809:7ac4:e5d with SMTP id
 af79cd13be357-8906eb94274mr3159202885a.38.1761247447314; 
 Thu, 23 Oct 2025 12:24:07 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-89c0dbc9850sm221390485a.6.2025.10.23.12.24.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Oct 2025 12:24:06 -0700 (PDT)
Date: Thu, 23 Oct 2025 15:24:04 -0400
From: Peter Xu <peterx@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Alexandr Moshkov <dtalexundeer@yandex-team.ru>, qemu-devel@nongnu.org,
 Raphael Norwitz <raphael@enfabrica.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH 2/2] vhost-user-blk: support inflight migration
Message-ID: <aPqA1H1NwRqH3Hlb@x1.local>
References: <20251020054413.2614932-1-dtalexundeer@yandex-team.ru>
 <20251020054413.2614932-3-dtalexundeer@yandex-team.ru>
 <878qh599tc.fsf@pond.sub.org>
 <d6cf9c5e-52da-49b8-ba39-2909a00f28eb@yandex-team.ru>
 <87frbd6bi7.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87frbd6bi7.fsf@pond.sub.org>
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

On Mon, Oct 20, 2025 at 01:47:12PM +0200, Markus Armbruster wrote:
> Alexandr Moshkov <dtalexundeer@yandex-team.ru> writes:
> 
> > Thanks for review!
> >
> > On 10/20/25 14:55, Markus Armbruster wrote:
> >> Alexandr Moshkov<dtalexundeer@yandex-team.ru> writes:
> >>
> >>> In vhost_user_blk_stop() on incoming migration make force_stop = true,
> >>> so GET_VRING_BASE will not be executed.
> >>>
> >>> Signed-off-by: Alexandr Moshkov<dtalexundeer@yandex-team.ru>
> >> Your cover letter explains why this is useful.  Please work it into your
> >> commit message.
> >
> > Ok
> >
> >> [...]
> >>
> >>> diff --git a/qapi/migration.json b/qapi/migration.json
> >>> index be0f3fcc12..c9fea59515 100644
> >>> --- a/qapi/migration.json
> >>> +++ b/qapi/migration.json
> >>> @@ -517,9 +517,13 @@
> >>>  #     each RAM page.  Requires a migration URI that supports seeking,
> >>>  #     such as a file.  (since 9.0)
> >>>  #
> >>> +# @inflight-vhost-user-blk: If enabled, QEMU will migrate inflight
> >>> +#    region for vhost-user-blk.  (since 10.2)
> >>> +#
> >> Any guidance why and when users would want to enable it?
> >>
> >> Is it a good idea to have device-specific capabilities?
> >
> > Hmm, maybe it's better way to make a parameter for the vhost-user-blk instead of migration capability?
> >
> > What do you think?
> 
> I think this is a question for the migration maintainers :)

Oops, I missed this email previously..

We discussed similar things with Vladimir on virtio-net.  Unless extremely
necessary, we should avoid adding any cap into migration that is relevant
to a specific device.  Yes, per-device is better..

Thanks,

-- 
Peter Xu


