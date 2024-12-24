Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 107A1E77188
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2024 15:20:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQ6hf-0007PN-35; Tue, 24 Dec 2024 10:20:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tQ6ha-00077U-73
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 10:20:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tQ6hY-0004Kc-Cr
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 10:20:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1735053601;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Hn7yu/BVBdWyu2ZDvEn6R3F57DF6oyoeS4fA9JFJVSI=;
 b=KL86VeZATQ1JzzpESMEEFup39310Ptu06FUFyWDlufTCsszjywcxAkCNOlt3M5dbmTF+fA
 LaQJYoiveVxwi1en6E6b99+Be7SYWjsW7B6Fn9s/+cEfu/lHer+NkDJz0p3bwE8tQoh+pY
 CJjiMozaT7/eVNbQmuCikopP0MISTiM=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-184-UbuZPQSlMNaBJOHQwx2uJQ-1; Tue, 24 Dec 2024 10:19:56 -0500
X-MC-Unique: UbuZPQSlMNaBJOHQwx2uJQ-1
X-Mimecast-MFC-AGG-ID: UbuZPQSlMNaBJOHQwx2uJQ
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-467c08e67easo112339381cf.1
 for <qemu-devel@nongnu.org>; Tue, 24 Dec 2024 07:19:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735053595; x=1735658395;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hn7yu/BVBdWyu2ZDvEn6R3F57DF6oyoeS4fA9JFJVSI=;
 b=qR3FwGhbM10FVPvU0Eph66VIaPAgl6SaOBdw78MjxljPfSbWG0DkLmRqpHn9YcBxNS
 a8pw+l3f4h4qR6LOYSRFd/OHox/3m03wxBPGMoNMXZOeenqCY5ZiRYSvR5vTV1xfjM+s
 qrJuZG3g6ByumUd3mHnEgHkoMd4k6AN3KRsrvnD8xAEpCDzZwWIALk1+OXi0WI8RluaA
 Olrfl3p7yGyiHA4HJQvXgZ133kmmerC937fANLq11jPg5kko0fG4OnpuFsRT4REVmL1+
 lxPUXU7xFCJIp9Lc3VXFToB/98I4Z6fJrhUKOWWEDkCav4HCodGelp4xs9VtJq5NEqVL
 LYuA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXT6DpE83zBoUxWmH4D8OVjWMZNb6Cg9zNmUQbrVvHd4kHP2slmJYFAyac3A4/U6EAejKgfYaHTY3fB@nongnu.org
X-Gm-Message-State: AOJu0YwgdAFWPxKB6NFxGGCIUR6RU4p1mJpWmza4CEw9rKH1Y6v9dU57
 Wd1A7DRi0/g0E0M3LErQP7HNO5xT0tZDH0JMhJ1AOype25dKfHo8grjmsy6k2bvQo2bQ097YGZo
 59o+i8K4sgjdb4xrQLzaocv9rE1xCOLG7eY71LJn82i9Z5XWbkZsm
X-Gm-Gg: ASbGncuULt0wu/SyanAVetBOqpiAX/qGwMGoeoBm4BnXZmLJFi2gXXCKCVTdBVqxHoo
 M+c1x4y51FezCt+MbBL8z0Be0aWXNsiD88dRuLwwuPSyngoZ3nbUBMMJNsE20A1Z4th236X+fQx
 gwSmpRqtb3nZ8FOTl9IlhYT9rvsACJutqr37TWPWuq/a1KLgU2rGk20Rzl7WPmZLaD7EfKBIxCd
 DrQwFfIDGCXFHQlg9fIME6NuWMciXiZJz/TkRnAE7HTjXY9kwcbrD6vTHcqwnbXwAJvUl1cMhtu
 ox+UatJIwAoKWFHPNg==
X-Received: by 2002:a05:6214:20eb:b0:6d8:a4fd:d247 with SMTP id
 6a1803df08f44-6dd23306875mr273840926d6.7.1735053595406; 
 Tue, 24 Dec 2024 07:19:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEBlT6u9zDI14ChRtAcsVX+0ic5ezS2vyxjMTb3yZMK0eULrfSLIvF9K9bdWfpd7nvknG6yKA==
X-Received: by 2002:a05:6214:20eb:b0:6d8:a4fd:d247 with SMTP id
 6a1803df08f44-6dd23306875mr273840536d6.7.1735053595082; 
 Tue, 24 Dec 2024 07:19:55 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dd18137419sm53605736d6.69.2024.12.24.07.19.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Dec 2024 07:19:54 -0800 (PST)
Date: Tue, 24 Dec 2024 10:19:52 -0500
From: Peter Xu <peterx@redhat.com>
To: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org,
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
Message-ID: <Z2rRGK09N1ujK5NV@x1n>
References: <20241220104220.2007786-1-npiggin@gmail.com>
 <20241220104220.2007786-2-npiggin@gmail.com> <Z2Wb7T8oH0xbk576@x1n>
 <D6H1LG4QEYL3.3B6MWT5ZTMAQG@gmail.com> <Z2mdNtwd9UzAUVBB@x1n>
 <51af6ae2-db61-44f5-bde0-bf2eb98923eb@ispras.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <51af6ae2-db61-44f5-bde0-bf2eb98923eb@ispras.ru>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
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

On Tue, Dec 24, 2024 at 10:24:51AM +0300, Pavel Dovgalyuk wrote:
> On 23.12.2024 20:26, Peter Xu wrote:
> > On Sat, Dec 21, 2024 at 01:02:01PM +1000, Nicholas Piggin wrote:
> > > On Sat Dec 21, 2024 at 2:31 AM AEST, Peter Xu wrote:
> > > > On Fri, Dec 20, 2024 at 08:42:03PM +1000, Nicholas Piggin wrote:
> > > > > Migration reads CLOCK_HOST when not holding the replay_mutex, which
> > > > > asserts when recording a trace. These are not guest visible so should
> > > > > be CLOCK_REALTIME like other statistics in MigrationState, which do
> > > > > not require the replay_mutex.
> > > > 
> > > > Irrelevant of the change, should we document such lock implications in
> > > > timer.h?
> > > 
> > > I guess the intention was to try to avoid caller caring too much
> > > about replay internals, so I'm not sure if that will help or
> > > hinder understanding :(
> > 
> > CLOCK_HOST should be the wall clock in QEMU, IIUC.  If any QEMU caller
> > tries to read host wall clock requires some mutex to be held.. then I don't
> > see how we can avoid mentioning it.  It's indeed weird if we need to take a
> > feature specific mutex just to read the wallclock.. But maybe I misread the
> > context somewhere..
> > 
> > > 
> > > I think the big rule is something like "if it affects guest state,
> > > then you must use HOST or VIRTUAL*, if it does not affect guest state
> > 
> > HOST clock logically shouldn't be relevant to guest-state?
> 
> CLOCK_HOST is used for rtc by default. As the rtc affects the guest state,
> therefore CLOCK_HOST affects guest state too.

It's not obvious to me that HOST should only be used for rtc, and it's part
of guest state.  If that's a must, I'd still suggest we add that into doc.
But then it means we lose one way to fetch host wallclock in the time API;
I still see some other users use it, I'm guessing in the way to fetch host
wall clock.

> 
> Migration is not related to guest state change, therefore it should either
> use realtime clock, or set some flag to make host clock reads not tracked by
> record/replay.

In migration's case, realtime clock suites more.  But maybe we still need
another clock indeed just to fetch host wall clock without any lock
implications.  So maybe the better way is making the tracked one to be
CLOCK_GUEST_RTC, put rich documentatation to avoid abuse, then keep HOST
the simple definition.

Thanks,

-- 
Peter Xu


