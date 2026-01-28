Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13325D46BE0
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Jan 2026 17:28:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vl9Ke-00060G-0f; Wed, 28 Jan 2026 12:27:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sbrivio@redhat.com>)
 id 1vl9Kb-0005zF-KM
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 12:27:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sbrivio@redhat.com>)
 id 1vl9KZ-0004EQ-DN
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 12:27:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769621269;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LNeS6UTQF4oyrQQKSNHmPws9hKd+S9g4/N/4QB1BlGI=;
 b=aPm9DWeybzMpiNgy+5+zRgWO6OmHoGyadZELpiS27gNda5gtdbM7hyqVkX8PM2vcs3cmXq
 XyJ7aGv8cmRbU+I0nDSTbU3z+oGig/OkwjqRMSmfdfSwvxTssW42mBEbi4yUpOjkJxqFm1
 nZ+dobFdCXnnHFeIAIvehUIzMEViNMk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-350-8htZRVlvNNeVWIThSPaAUA-1; Wed, 28 Jan 2026 12:27:47 -0500
X-MC-Unique: 8htZRVlvNNeVWIThSPaAUA-1
X-Mimecast-MFC-AGG-ID: 8htZRVlvNNeVWIThSPaAUA_1769621266
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-480717a8ef9so527255e9.1
 for <qemu-devel@nongnu.org>; Wed, 28 Jan 2026 09:27:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769621263; x=1770226063; darn=nongnu.org;
 h=date:content-transfer-encoding:mime-version:organization:references
 :in-reply-to:message-id:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LNeS6UTQF4oyrQQKSNHmPws9hKd+S9g4/N/4QB1BlGI=;
 b=ltHtzD1NbS7WIQzFKl0Btb2EC2khkPx5VQdqNTdrrtOg1JiNdl0C4P9KCS+RgfyFcw
 NZ6LznDr5x90sizJdN123W3B5+2+jYHqaOFNzpGSsDbxK4GGQYFwxDL9tDKX7+UgyyI4
 zBxYE8klSAFAyjY5Bp7Tf3m4ZBZ2VeHKMa6anuNNsZRQHG8ZVClyMmellVVunhk3twKc
 7OwsiFJVblZYbrH7rTL6ONC9D4bYct2RfihFawBLu9/o52a5c4Wo6KZMJbKD5+bFEMT4
 V9toMt2vnHDnSs+EVjkNxqbpZxd7qPXNsM5SVN2oQfQcNSBebrN48Qu2NrnxNZ2jiwKJ
 M9xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769621263; x=1770226063;
 h=date:content-transfer-encoding:mime-version:organization:references
 :in-reply-to:message-id:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LNeS6UTQF4oyrQQKSNHmPws9hKd+S9g4/N/4QB1BlGI=;
 b=iqCP+5xy6YQByp5S1BlZdYZUGOe+TeVdF/s6ySZbobXFt2rDEHpoTA0pK7fQPrbJeS
 /Q2S30ZknAicIo0+0Xss0JUWNtDEqSuOdwuXLttyk8d71t1iTxbe2aGVrqOPq5Q/VwXW
 e1fTCS6PsVVjRkkn8eNHXlFLv3cYbJyyBzoZzQInMctzA6URsYjqQt0VJzwO30tX730S
 l+07k9NGBkCw15yyy/PK+GtOeRAXZO5ivNv1dthrJ9gKWPW2ePjFpM5PlWPONxG1dT3o
 pA50KqyGhC1N5YTt85jsktLkeNbVyRkUEikhDpvBPsOFTYvgkfVTcrTdpv23V2qKC26y
 BADQ==
X-Gm-Message-State: AOJu0YwRyALiABctZzccvx97+F4djOyBE/PywhixuP3JU2HtNz8AZADH
 ijBwciy/nQYxKbkJ3OQ3nr/L8/3TmP3LxFBwn485tdvrxt3rh2fz/ZdIDu6jVZz5jeiPsMi1osJ
 /CCHBewihJuUIbaNpwtLuua+s0d07ZLe88ZemEaTgWt+dQU6s6FvahGg7
X-Gm-Gg: AZuq6aJabEMGkLAlp9SVEb3KMZrVY8xdRtFNgCbixSes3K9vuYBoQ08geyPon7a1Y5B
 qAg1yO0xtxrS2qHgSZANFJGeBtPOAy8BsNfQsKYdD4yMlBEMYqspDRCbCkkIb3JpoMDKhJPXbsA
 7wVv21EjYwBKu9RlrMUBiVTljuP0/rLHFRmPKAsxNYS9E5M60DyvG8vzXchwavUN3QNKijpQhTv
 ClLzTZDkgtTg75nduxSjFwP/2eLhz8w/yCAA0EVwgEHAEpXiLudA3WUnsU9m2EogYBFeGrG/HL5
 9lY5e865DI9BswBr48862EUqLeMc1DNVBQnmWpLF1C3yWAL+ZuPwToZfuDUfV6Qcp4FIwwyQbq5
 WVQj2kU7ziTzto7FxqPnM5NdW/i7whGYJelMHbA==
X-Received: by 2002:a05:600c:1d1d:b0:477:9e0c:f59 with SMTP id
 5b1f17b1804b1-48082891d58mr2820975e9.2.1769621262862; 
 Wed, 28 Jan 2026 09:27:42 -0800 (PST)
X-Received: by 2002:a05:600c:1d1d:b0:477:9e0c:f59 with SMTP id
 5b1f17b1804b1-48082891d58mr2820625e9.2.1769621262329; 
 Wed, 28 Jan 2026 09:27:42 -0800 (PST)
Received: from maya.myfinge.rs (ifcgrfdd.trafficplex.cloud. [176.103.220.4])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4806e2ea2b5sm4132465e9.19.2026.01.28.09.27.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jan 2026 09:27:41 -0800 (PST)
From: Stefano Brivio <sbrivio@redhat.com>
To: Juraj Marcin <jmarcin@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>, "Michael S.
 Tsirkin" <mst@redhat.com>, Peter Xu <peterx@redhat.com>, Jason Wang
 <jasowang@redhat.com>, Vladimir Sementsov-Ogievskiy
 <vsementsov@yandex-team.ru>, Laurent Vivier <laurent@vivier.eu>, David
 Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 0/4] migration: Pass network packets received during
 switchover to dest VM
Message-ID: <20260128182739.64f60eba@elisabeth>
In-Reply-To: <4uwcjd7ov7ib6q5pelqle3bdouoctyoqteec5f222cjatwkqxf@3p2n5hgjuwzk>
References: <20260127140316.4187221-1-jmarcin@redhat.com>
 <20260127192108.216495da@elisabeth>
 <4uwcjd7ov7ib6q5pelqle3bdouoctyoqteec5f222cjatwkqxf@3p2n5hgjuwzk>
Organization: Red Hat
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.49; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date: Wed, 28 Jan 2026 18:27:41 +0100 (CET)
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sbrivio@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 PDS_OTHER_BAD_TLD=1.999, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Wed, 28 Jan 2026 14:06:11 +0100
Juraj Marcin <jmarcin@redhat.com> wrote:

> Hi Stefano,
> 
> On 2026-01-27 19:21, Stefano Brivio wrote:
> > [Cc'ing Laurent and David]
> > 
> > On Tue, 27 Jan 2026 15:03:06 +0100
> > Juraj Marcin <jmarcin@redhat.com> wrote:
> >   
> > > During switchover there is a period during which both source and
> > > destination side VMs are paused. During this period, all network packets
> > > are still routed to the source side, but it will never process them.
> > > Once the destination resumes, it is not aware of these packets and they
> > > are lost. This can cause packet loss in unreliable protocols and
> > > extended delays due to retransmission in reliable protocols.
> > > 
> > > This series resolves this problem by caching packets received once the
> > > source VM pauses and then passing and injecting them on the destination
> > > side. This feature is implemented in the last patch. The caching and
> > > injecting is implemented using network filter interface and should work
> > > with any backend with vhost=off, but only TAP network backend was
> > > explicitly tested.  
> > 
> > I haven't had a chance to try this change with passt(1) yet (the
> > backend can be enabled using "-net passt" or by starting it
> > separately).
> > 
> > Given that passt implements migration on its own (in deeper detail in
> > some sense, as TCP connections are preserved if IP addresses match), I
> > wonder if it this might affect or break it somehow.
> > 
> > Did you perhaps have some thoughts about that already?  
> 
> I'm aware of passt migrating its state and passt-repair, but I also
> haven't tested it as I couldn't get passt-repair to work.

Oops. Let me know if you're hitting any specific error I could look
into.

I plan anyway to try out your changes but I might need a couple of days
before I find the time.

> Does it also handle other protocols, or just preserves TCP connections?

Layer-4-wise, we have an internal representation of UDP "flows"
(observed flows of packets for which we preserve the same source port
mapping, with timeouts) and we had a vague idea of migrating those as
well, but it's debatable where there's any benefit from it.

At Layer 2 and 3, we migrate IP and MAC addresses we observed from the
guest:

  https://passt.top/passt/tree/migrate.c?id=e3f70c05bad90368a1a89bf31a9015125232b9ae#n31

so that we have ARP and NDP resolution, as well as any NAT
mapping working right away as needed.

For completeness, this is the TCP context we migrate instead:

  https://passt.top/passt/tree/tcp_conn.h?id=e3f70c05bad90368a1a89bf31a9015125232b9ae#n108
  https://passt.top/passt/tree/tcp_conn.h?id=e3f70c05bad90368a1a89bf31a9015125232b9ae#n154

> The main focus of this feature are protocols that cannot handle packet
> loss on their own in environments where IP address is preserved (and
> thus also TCP connections).

Well, strictly speaking, TCP handles packet loss, that's actually the
main reason behind it. I guess this is to improve throughput and avoid
latency spikes or retransmissions that could be avoided?

> So, mainly tap/bridge, with the idea that
> other network backends could also benefit from it. However, if it causes
> problems with other backends, I could limit it just to tap.

I couldn't quite figure out yet if it's beneficial, useless, or
harmless for passt. With passt, what happens without your
implementation is:

1. guest pauses

2. the source instance of passt starts migrating, meaning that sockets
   are frozen one by one, their receiving and sending queues dumped

3. pending queues are sent to the target instance of passt, which opens
   sockets as refills queues as needed

4. target guest resumes and will get any traffic that was received by
   the source instance of passt between 1. and 2.

Right now there's still a Linux kernel issue we observed (see also
https://pad.passt.top/p/TcpRepairTodo, that's line 4 there) which might
cause segments to be received (and acknowledged!) on sockets of the
source instance of passt for a small time period *after* we freeze them
with TCP_REPAIR (that is, TCP_REPAIR doesn't really freeze the queue).

I'm currently working on a proper fix for that. Until then, point 2.
above isn't entirely accurate (but it only happens if you hammer it
with traffic generators, it's not really visible otherwise).

With your implementation, I guess:

1. guest pauses

2. the source instance of passt starts migrating, meaning that sockets
   are frozen one by one, their receiving and sending queues dumped

2a. any data received by QEMU after 1. will be stored and forwarded to
    the target later. But passt at this point prevents the guest from
    getting any data, so there should be no data involved

3. pending queues are sent to the target instance of passt, which opens
   sockets as refills queues as needed

3a. the target guest gets the data from 2a. As long as there's no data
    (as I'm assuming), there should be no change. If there's data coming
    in at this point, we risk that sequences don't match anymore? I'm not
    sure

4. target guest resumes and will *also* get any traffic that was received
   by the source instance of passt between 1. and 2.

So if my assumption from 2a. above holds, it should be useless, but
harmless.

Would your implementation help with the kernel glitch we're currently
observing? I don't think so, because your implementation would only play
a role between passt and QEMU, and we don't have issues there.

Well, it would be good to try things out. Other than that, unless I'm
missing something, your implementation should probably be skipped for
passt for simplicity, and also to avoid negatively affecting downtime.

Note that you can also use passt without "-net passt" (that's actually
quite recent) but with a tap back-end. Migration is only supported with
vhost-user enabled though, and as far as I understand your implementation
is disabled in that case?

-- 
Stefano


