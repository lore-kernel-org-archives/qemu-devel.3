Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51104E7718D
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Dec 2024 17:27:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tPmCS-0004B9-Sp; Mon, 23 Dec 2024 12:26:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tPmCL-00049o-Ug
 for qemu-devel@nongnu.org; Mon, 23 Dec 2024 12:26:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tPmCK-00030R-Is
 for qemu-devel@nongnu.org; Mon, 23 Dec 2024 12:26:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734974787;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NeQlxWi9rSdiycatWgQqnaitLBDTcph01EghNbwzrmw=;
 b=i4iucmn9KPicCafy6eIKuhzXMT/RU2N69G5qGUrZR2k0CPhVcaBQRG3XLSDTA1nm1kmD94
 kGd89jKCXq89r7NkKDhB/xXrz5uKVMkvQMVuJRwiM8u8Hqvk9z+G0XUoWpH347beC9BqGC
 HB9FO7zC+L+P9+oefSOI792FLh7M/IU=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-325-ZSU-n_kOOWWDJs68NsEHBQ-1; Mon, 23 Dec 2024 12:26:20 -0500
X-MC-Unique: ZSU-n_kOOWWDJs68NsEHBQ-1
X-Mimecast-MFC-AGG-ID: ZSU-n_kOOWWDJs68NsEHBQ
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7b6f2515eb3so406401385a.0
 for <qemu-devel@nongnu.org>; Mon, 23 Dec 2024 09:26:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734974779; x=1735579579;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NeQlxWi9rSdiycatWgQqnaitLBDTcph01EghNbwzrmw=;
 b=vuMTupjbfH0mLEAqgno6lPkWVdlG7+KPGkwOOWt0MSXpi81IO6PpjIN36iwdTELyEl
 0TXeQ/pc6qD87vszu6eduUM5Tuy1WrZuYvAVA6PldKo8onBB3Pjvr8KjnwOzMxW5Es8i
 mP41JHdj8IAQJuh40/QjkUBLxRrt+jwgGSlGKPCevwGmzB3rqjLIEwOfpsxDyqviMi40
 1RTq6QdCXmdu4wQ1k964FIOdLooMM5c6mdlhYpi9UjfNkH//2PnOAOujmzjtcHrDRi1x
 ivdoxODKlNqpW6m7N8hXIiQbzlWK/+MaFKpmMppe5n46ZzuE+sMK2BlQKAIp8HcTCVSp
 lw9g==
X-Gm-Message-State: AOJu0YzxrGgjI3Icvr6wklHhMzwqUQt1hcwwDwtRJc5lub8l59t/alpL
 PG/9eihBJYuIPT6vgG47AfCDSYYNabX3tjH3bJs+9sUtuQ4lnPVIwZp80sXFRaeIJH0W0FYYG2g
 E7oQs2wEjxhmWkfBJqJKwmRfzOUVZyTc1UjXh9FeJg3PUWknjZe4h
X-Gm-Gg: ASbGncuQqCiTAxipU84GzfXOK76n1G4xRco7u9Q5Q6HgSFo2YCVVWnveWGtq+eAXtFz
 F7I5keyqic+kGyggybKvHDY9s9scniSGh8d8D/sH24xAqJVuTTvsTt59toEWoJaGmMsMAgS9Lxb
 FClgZgW3sPJ/Q1FG/nd6Rlvn7ol18o9vn/0z8fkxhqecZC7/W6WEzuJ+4MPoksArMycDbiriO1f
 W/i3gwGoNlBsKuFu+Oc4FoGQ4czBBMgThmcM+ypRKV563+5bIQlA2NuYWLuI9bs+HVm5vwGsGer
 GitW7DfThc7RM5U4Dg==
X-Received: by 2002:a05:620a:2697:b0:7b7:28c:dcd9 with SMTP id
 af79cd13be357-7b9ba79b4f5mr1995843485a.29.1734974779442; 
 Mon, 23 Dec 2024 09:26:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGUjBR5bRHatyOGbqV5Oo5/pboLGWlqzWYBcdyJxaApqqSw2A8JmemeJRHBZF5fyFORrwn5LA==
X-Received: by 2002:a05:620a:2697:b0:7b7:28c:dcd9 with SMTP id
 af79cd13be357-7b9ba79b4f5mr1995839085a.29.1734974779160; 
 Mon, 23 Dec 2024 09:26:19 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b9ac4be439sm399690285a.106.2024.12.23.09.26.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Dec 2024 09:26:18 -0800 (PST)
Date: Mon, 23 Dec 2024 12:26:14 -0500
From: Peter Xu <peterx@redhat.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <fam@euphon.net>,
 Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 John Snow <jsnow@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Fabiano Rosas <farosas@suse.de>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Subject: Re: [PATCH 01/17] replay: Fix migration use of clock for statistics
Message-ID: <Z2mdNtwd9UzAUVBB@x1n>
References: <20241220104220.2007786-1-npiggin@gmail.com>
 <20241220104220.2007786-2-npiggin@gmail.com> <Z2Wb7T8oH0xbk576@x1n>
 <D6H1LG4QEYL3.3B6MWT5ZTMAQG@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <D6H1LG4QEYL3.3B6MWT5ZTMAQG@gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Sat, Dec 21, 2024 at 01:02:01PM +1000, Nicholas Piggin wrote:
> On Sat Dec 21, 2024 at 2:31 AM AEST, Peter Xu wrote:
> > On Fri, Dec 20, 2024 at 08:42:03PM +1000, Nicholas Piggin wrote:
> > > Migration reads CLOCK_HOST when not holding the replay_mutex, which
> > > asserts when recording a trace. These are not guest visible so should
> > > be CLOCK_REALTIME like other statistics in MigrationState, which do
> > > not require the replay_mutex.
> >
> > Irrelevant of the change, should we document such lock implications in
> > timer.h?
> 
> I guess the intention was to try to avoid caller caring too much
> about replay internals, so I'm not sure if that will help or
> hinder understanding :(

CLOCK_HOST should be the wall clock in QEMU, IIUC.  If any QEMU caller
tries to read host wall clock requires some mutex to be held.. then I don't
see how we can avoid mentioning it.  It's indeed weird if we need to take a
feature specific mutex just to read the wallclock.. But maybe I misread the
context somewhere..

> 
> I think the big rule is something like "if it affects guest state,
> then you must use HOST or VIRTUAL*, if it does not affect guest state

HOST clock logically shouldn't be relevant to guest-state?

> then you must use REALTIME". record-replay code then takes care of
> replay mutex locking.
> 
> Does get a little fuzzy around edges in code that is somewhat
> aware of record-replay though, like migration/snapshots.

Said that, I agree with the change itself - any measurement may not want to
involve NTP at all... which HOST / gtod will, but REALTIME won't.  However
this patch doesn't seem to be for that purpose..  So I'd like to double
check.

Thanks,

-- 
Peter Xu


