Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CB90CEE35A
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 22:06:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLTpJ-0007SQ-08; Tue, 18 Nov 2025 17:05:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vLTpG-0007Rr-VV
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 17:05:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vLTpF-0000r9-47
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 17:05:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763503523;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=49RfTMsLlMEMDWHlfCjaUfNXzLjZsaiaxju/E8bGiuo=;
 b=ZLt2ft3x2Vh57+p49O+X7Qw80h1+KB0/CZ7GAKZsdvABsqy7Sb4jStjkT3ykfiGDZieXl6
 XVuBAX5W0fVgS45vBiRSTdjsYJTSlopt15AdnNSycj3b2sp0fBKDWZfzLEYEhPFtPTvP/p
 Q1s7p2SUnxdh3wzhbfoWg5Pe3y8nIQg=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-wAATCTgbNUO1WF8rwnjnag-1; Tue, 18 Nov 2025 17:05:21 -0500
X-MC-Unique: wAATCTgbNUO1WF8rwnjnag-1
X-Mimecast-MFC-AGG-ID: wAATCTgbNUO1WF8rwnjnag_1763503521
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-8b23a64f334so729617485a.2
 for <qemu-devel@nongnu.org>; Tue, 18 Nov 2025 14:05:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763503521; x=1764108321; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=49RfTMsLlMEMDWHlfCjaUfNXzLjZsaiaxju/E8bGiuo=;
 b=a1uQNlCZhmfY9jN/s1N+Ih5Mndey0bmW7PDRuI/io7XxrZZDgNCCJ6cev8wcXFpH1e
 1YaQbuDoHjY5wHUyIJpvRp/Plxrq9itHG588KsDvKRlmG2zFnhDP4YX8Euez7u1ZF1UF
 U18gvVexahU78BaG/J8/3IzD2RTmxl6srOV1gXiHd3HqYOlocdWu3ENaCZYCgbgl0Si3
 Ak51CcOd8qi1whV/BLO/6tHAXtbDB4ay/gTX8dkfQ72mNq49hb7c34C0RL3MhOP/sGxJ
 rI8Oj7Kk0O4D29Su4AHizAP8tJzTvss7PyStaXL/y9V7/j+ssNpRdyV49tMhxX3Lz+ZV
 sWIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763503521; x=1764108321;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=49RfTMsLlMEMDWHlfCjaUfNXzLjZsaiaxju/E8bGiuo=;
 b=X2UpEohCVLpR7h5saCZAzCFQycKnKGN+8eruSREEQwmx9KdvLJ//BSGsHxNAVx8ZR/
 wl1096QaqQUiRpG7cX7MsaGT08LO12fKPreiHNepzvXvR5Xbs7nnMio59OiwcnrC2w03
 +zG927v3dOJOt68VrnTbPPMBK6h9rjtVS+g5ni8CYDp8wF95NVMLN++onXJsXL3Bm2BE
 TNvn5oR1dmvVVbpgTmGl22cLOHnV9o2ahryhV0P8aW3ya3YA+uL+iLtmj0IybbgzT/iD
 JC5B9oqbCQy1EOZXLCUgr4B4mf5iI9uyrRF7N03ZmQ9bZaoKyPKotT9p/vJQztk6C4nj
 NdwA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVFHUdPIO58UCtpGjWUIEinQD4ngJmAcqH70axX/LSgMmuuF1Rj2nbJ3EkjaeuiXn1r2XVNqNRqzIQp@nongnu.org
X-Gm-Message-State: AOJu0YzbaHaXujh2O8+5AUEfqwwyctPr0JDfRzDHICWcbpplROjgDeQM
 2juqLpMFpryoVqOpNN42/7CGgFZAfRihSlHYuQO01oDXtjIDo5tlE+xGg2ucwVNwqx2UDiVytrd
 7KyyRMVoJSjCLn7Do1Oh2Zt3S1lYv46HjWD2nilfsN4XqMm8a2I1Yotnl
X-Gm-Gg: ASbGncvzPi9gLZxZftZq4kP8Z0IQnVl0u5Of1Ed/slN/L39JnUzdsOEaxJddCarOIPx
 kydxVtKGKgHnH/ivsaTkEvMZjFA5el2tt5kjzM6gkrS4a7Niv2hruhMBtMNdAMqk/ct69bUNFwC
 9k/T2aNEX7VAOF/0X8+UyvTs5CUQI6Suj1+As+hwTRTQoSoP+dNYldwEGcOq6dFIdlStOWTDyrK
 Xvp7G+0AW4ehQ5u13DhAOnJp5pHRB57BwRq1xj9XjIl3EOJvn22mfrhyuCyuTdS6oKguKiCkln8
 pb90JvQgIsVFwNtWPYSYUc2dDUQBgzj2cbYfTUDsbfvSaM7d1mJ6CIXrCFXfLXmhA3wkaWapxNp
 ahA==
X-Received: by 2002:a05:620a:4624:b0:89f:27dc:6536 with SMTP id
 af79cd13be357-8b2c31b472fmr2236550285a.54.1763503520966; 
 Tue, 18 Nov 2025 14:05:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEOf+ZB+poHBElU692aAVs/MF2PX+ahhvaOJUtSgM8FGol3PCYFOgvUMygxYAdBN5shqOQYrg==
X-Received: by 2002:a05:620a:4624:b0:89f:27dc:6536 with SMTP id
 af79cd13be357-8b2c31b472fmr2236542985a.54.1763503520419; 
 Tue, 18 Nov 2025 14:05:20 -0800 (PST)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8b2aef2f98dsm1297911685a.35.2025.11.18.14.05.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Nov 2025 14:05:19 -0800 (PST)
Date: Tue, 18 Nov 2025 17:05:17 -0500
From: Peter Xu <peterx@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: Alexandr Moshkov <dtalexundeer@yandex-team.ru>, qemu-devel@nongnu.org,
 Raphael Norwitz <raphael@enfabrica.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Subject: Re: [PATCH v3 0/3] vhost-user-blk: support inflight migration
Message-ID: <aRztnfZFl-OcbVYI@x1.local>
References: <20251110103937.1944486-1-dtalexundeer@yandex-team.ru>
 <cf0f69b9-4b2b-4c09-a32b-ad86bbe04f6d@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cf0f69b9-4b2b-4c09-a32b-ad86bbe04f6d@yandex-team.ru>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Nov 18, 2025 at 11:24:12PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> Add Daniel
> 
> On 10.11.25 13:39, Alexandr Moshkov wrote:
> > v3:
> > - use pre_load_errp instead of pre_load in vhost.c
> > - change vhost-user-blk property to
> >    "skip-get-vring-base-inflight-migration"
> > - refactor vhost-user-blk.c, by moving vhost_user_blk_inflight_needed() higher
> > 
> > v2:
> > - rewrite migration using VMSD instead of qemufile API
> > - add vhost-user-blk parameter instead of migration capability
> > 
> > I don't know if VMSD was used cleanly in migration implementation, so
> > feel free for comments.
> > 
> > Based on Vladimir's work:
> > [PATCH v2 00/25] vhost-user-blk: live-backend local migration
> >    which was based on:
> >      - [PATCH v4 0/7] chardev: postpone connect
> >        (which in turn is based on [PATCH 0/2] remove deprecated 'reconnect' options)
> >      - [PATCH v3 00/23] vhost refactoring and fixes
> >      - [PATCH v8 14/19] migration: introduce .pre_incoming() vmsd handler
> > 
> 
> Hi!
> 
> On my series about backend-transfer migration, the final consensus (or at least,
> I hope that it's a consensus:) is that using device properties to control migration
> channel content is wrong. And we should instead use migration parameters.
> 
> (discussion here: https://lore.kernel.org/qemu-devel/29aa1d66-9fa7-4e44-b0e3-2ca26e77accf@yandex-team.ru/ )
> 
> So the API for backend-transfer features is a migration parameter
> 
>     backend-transfer = [ list of QOM paths of devices, for which we want to enable backend-transfer ]
> 
> and user don't have to change device properties in runtime to setup the following migration.
> 
> So I assume, similar practice should be applied here: don't use device
> properties to control migration.
> 
> So, should it be a parameter like
> 
>     migrate-inflight-region = [ list of QOM paths of vhost-user devices ]
> 
> ?

I have concern that if we start doing this more, migration qapi/ will be
completely messed up.

Imagine a world where there'll be tons of lists like:

  migrate-dev1-some-feature-1 = [list of devices (almost only dev1 typed)]
  migrate-dev2-some-feature-2 = [list of devices (almost only dev2 typed)]
  migrate-dev3-some-feature-3 = [list of devices (almost only dev3 typed)]
  ...

That doesn't look reasonable at all.  If some feature is likely only
supported in one device, that should not appear in migration.json but only
in the specific device.

I don't think I'm fully convinced we can't enable some form of machine type
properties (with QDEV or not) on backends we should stick with something
like that.  I can have some closer look this week, but.. even if not, I
still think migration shouldn't care about some specific behavior of a
specific device.

If we really want to have some way to probe device features, maybe we
should also think about a generic interface (rather than "one new list
every time").  We also have some recent discussions on a proper interface
to query TAP backend features like USO*.  Maybe they share some of the
goals here.

Thanks,

-- 
Peter Xu


