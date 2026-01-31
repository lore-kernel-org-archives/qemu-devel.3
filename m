Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A13FD46C1D
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Jan 2026 02:28:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vm0hm-0005OE-L1; Fri, 30 Jan 2026 21:27:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sbrivio@redhat.com>)
 id 1vm0hk-0005DI-GC
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 21:27:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sbrivio@redhat.com>)
 id 1vm0hh-0005Hb-NG
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 21:27:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769826435;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0HDeT9j+uHE+6rmVLJgKPItKpbBLZ+et0WprIDsO/e0=;
 b=RBhbM323ujOo+BA16QBiVaYb1m1aDfLNfkJZD1ozmawOPGomuFSPu4d3DwU14iv+95nqT5
 /Yo1YbkxJV+sWiGjBjSuuAne7sUPYhNzwnweyCgNlCJonTXssxCnvyBZHAuoMdFqcAIOCQ
 aJB7sfSEhTN1Q+19CyfXdXQeDABDs7M=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-15-81H-68eqP4-vrrtyJ6Ba9w-1; Fri, 30 Jan 2026 21:27:14 -0500
X-MC-Unique: 81H-68eqP4-vrrtyJ6Ba9w-1
X-Mimecast-MFC-AGG-ID: 81H-68eqP4-vrrtyJ6Ba9w_1769826433
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-4325b182e3cso1807716f8f.2
 for <qemu-devel@nongnu.org>; Fri, 30 Jan 2026 18:27:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769826429; x=1770431229; darn=nongnu.org;
 h=date:content-transfer-encoding:mime-version:organization:references
 :in-reply-to:message-id:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0HDeT9j+uHE+6rmVLJgKPItKpbBLZ+et0WprIDsO/e0=;
 b=Z2R6EjWb2sfM2yNsyR6s6sRu6lsmd0kEarnABh7kYUzs2fL0R3PbY0GOkTV05+7u0X
 3x7uPypj6NWjPiVvqr0lacQ75q5dio/0/ZMo7/Af/BYJouToKFLFwBEP5QjluaEBxCr4
 mQwDWW1xr/KxsAfuYNpzE1aqE/vb9HnEu8VU9Pn+WORGNTbY/kO5dkAGcU802sbSI677
 T01OJ/qch8eM1CVaBIzwPARbru9afoliXDwgmbPRRgW5QwYI9ASdEcLq7bzZE1OlORAD
 ye7PdUznBP2Hf7lXDZoKZFIZtJO2GRgtg719hSdlC/ZLEWyu7mh6gDr6u9cayl4DigOt
 7iOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769826429; x=1770431229;
 h=date:content-transfer-encoding:mime-version:organization:references
 :in-reply-to:message-id:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0HDeT9j+uHE+6rmVLJgKPItKpbBLZ+et0WprIDsO/e0=;
 b=ktkRBJ2YGhDpy1o9TB2WaXoK1pR7iLjraSNhl14YPXuEs785xagbSqgxUTGflWDBxp
 8yx1KrLft7c9paaP4ULtT8SHUAfBRAB7J/UC5/e1zCkUuUVzc7xhfNWnmgDlk/A3Bcxi
 qciIHxwzlMUDHwfSKCHpWQqoROtc3HP0YLie9nMG4u0anH9eaf2Vf3uztTxv/ZUBmjWF
 pk3YrbiY1IVxQB9MitFO+Rqy8l0F1IusMvxQk/JfFbLzmhx90rq0lkKtJaPNQSFo8cv4
 uHAfsHGoIXgZ58Kadj1olyWTyWSLO3mCCufolBRWA6chB7coKoJhVEeFMll2Ebdakdqx
 6BFQ==
X-Gm-Message-State: AOJu0Yx2aSMbL0bGZwDPa0poukh2hFglQdRB8XZLUhJsGSsMorl0lJog
 tTE6H1ecwq3jzfWRg4Mv5/l7YG4IJYyhk6LOrab6TFUdgpH3BkXOdBHAPF44bikF/3MI7xpVzHl
 ILGlWbptTw9yCyPQcWdHgNSrtq2gHFjiKZJRdFOnr9eBO6Xe2PRZ13EVs
X-Gm-Gg: AZuq6aIDEodcDMrdf06Ub6ebhW65/Qs6vfnWhz86beaBadyX10/QdG20j7oaXqqqM8z
 umo5AdI0vhNkpyxlvy5QLqS7ZDJvT+yWVqH0SwahZX5y1C2vTJWhSLYAZaFD6WHuHtWPoLZO1lD
 dDVB5FJ5qnuJlF4X6MVEFuZsuNAkmoxmG3CUfJqz7T9zH7q904TX4cOf4KkGTsjVcau8dAoaJHF
 0PeP6SQ6/uCpToepSST7FL5NRuH2dcUfOaJ5BiYvEk2isAy2SbsqHrSWyoeu0BF+4+waSkC3abn
 5Lh3nGWjbZRn4c6GyChetQO9ssxqedhhcvuCYpnSOTrLUj9Z9WU/Wu7onsHog4Pv2vPFAuP8SpJ
 3EVB3LeBgJBnoOtDZ0F+N
X-Received: by 2002:a05:6000:2304:b0:430:fd84:3175 with SMTP id
 ffacd0b85a97d-435f3aaa3fcmr7616295f8f.38.1769826428830; 
 Fri, 30 Jan 2026 18:27:08 -0800 (PST)
X-Received: by 2002:a05:6000:2304:b0:430:fd84:3175 with SMTP id
 ffacd0b85a97d-435f3aaa3fcmr7616287f8f.38.1769826428306; 
 Fri, 30 Jan 2026 18:27:08 -0800 (PST)
Received: from maya.myfinge.rs (ifcgrfdd.trafficplex.cloud.
 [2a10:fc81:a806:d6a9::1]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e1323034sm26637489f8f.35.2026.01.30.18.27.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jan 2026 18:27:07 -0800 (PST)
From: Stefano Brivio <sbrivio@redhat.com>
To: Juraj Marcin <jmarcin@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>, "Michael S.
 Tsirkin" <mst@redhat.com>, Peter Xu <peterx@redhat.com>, Jason Wang
 <jasowang@redhat.com>, Vladimir Sementsov-Ogievskiy
 <vsementsov@yandex-team.ru>, Laurent Vivier <laurent@vivier.eu>, David
 Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 0/4] migration: Pass network packets received during
 switchover to dest VM
Message-ID: <20260131032700.12f27487@elisabeth>
In-Reply-To: <66tveywu7fta7q3zswe3zksuadmmqjnn365ulv5tsb2k3m6i5b@mb6sjuzuukdb>
References: <20260127140316.4187221-1-jmarcin@redhat.com>
 <20260127192108.216495da@elisabeth>
 <4uwcjd7ov7ib6q5pelqle3bdouoctyoqteec5f222cjatwkqxf@3p2n5hgjuwzk>
 <20260128182739.64f60eba@elisabeth>
 <66tveywu7fta7q3zswe3zksuadmmqjnn365ulv5tsb2k3m6i5b@mb6sjuzuukdb>
Organization: Red Hat
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.49; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date: Sat, 31 Jan 2026 03:27:07 +0100 (CET)
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sbrivio@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 PDS_OTHER_BAD_TLD=1.999, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Fri, 30 Jan 2026 15:40:01 +0100
Juraj Marcin <jmarcin@redhat.com> wrote:

> Hi Stefano,
> 
> thanks for the answer!
> 
> On 2026-01-28 18:27, Stefano Brivio wrote:
> > On Wed, 28 Jan 2026 14:06:11 +0100
> > Juraj Marcin <jmarcin@redhat.com> wrote:
> >   
> > > Hi Stefano,
> > > 
> > > On 2026-01-27 19:21, Stefano Brivio wrote:  
> > > > [Cc'ing Laurent and David]
> > > > 
> > > > On Tue, 27 Jan 2026 15:03:06 +0100
> > > > Juraj Marcin <jmarcin@redhat.com> wrote:
> > > >     
> > > > > During switchover there is a period during which both source and
> > > > > destination side VMs are paused. During this period, all network packets
> > > > > are still routed to the source side, but it will never process them.
> > > > > Once the destination resumes, it is not aware of these packets and they
> > > > > are lost. This can cause packet loss in unreliable protocols and
> > > > > extended delays due to retransmission in reliable protocols.
> > > > > 
> > > > > This series resolves this problem by caching packets received once the
> > > > > source VM pauses and then passing and injecting them on the destination
> > > > > side. This feature is implemented in the last patch. The caching and
> > > > > injecting is implemented using network filter interface and should work
> > > > > with any backend with vhost=off, but only TAP network backend was
> > > > > explicitly tested.    
> > > > 
> > > > I haven't had a chance to try this change with passt(1) yet (the
> > > > backend can be enabled using "-net passt" or by starting it
> > > > separately).
> > > > 
> > > > Given that passt implements migration on its own (in deeper detail in
> > > > some sense, as TCP connections are preserved if IP addresses match), I
> > > > wonder if it this might affect or break it somehow.
> > > > 
> > > > Did you perhaps have some thoughts about that already?    
> > > 
> > > I'm aware of passt migrating its state and passt-repair, but I also
> > > haven't tested it as I couldn't get passt-repair to work.  
> > 
> > Oops. Let me know if you're hitting any specific error I could look
> > into.  
> 
> I tried it using this documentation [1] I found earlier, however, it
> wouldn't work when migrating on the same host as I expected from it. The
> destination passt process fails to get the port the outside TCP server
> is communicating with and I see the connection still as established with
> the source passt process. This is the specific error message from the
> destination passt process:
> 
>     Flow 0 (TCP connection): Failed to connect migrated socket: Cannot assign requested address
> 
> [1]: https://www.qemu.org/docs/master/system/devices/net.html#example-of-migration-of-a-guest-on-the-same-host

Ouch, I see.

Laurent wrote this part of documentation showing the QEMU-related bits
of the migration workflow, but we should have updated it with an
example with real TCP flows, because in that case you can't have the
two instances of QEMU and passt running in the same namespace of the
same machine: ports and addresses will conflict.

There are two alternatives to test migration of actual flows.

1. two namespaces, same machine, with one instance of passt and one
   instance of QEMU in each.

   Testing a connection from guest to host can be done with a simple
   client/server pair, whereas, the other way around, you need some
   form of proxying (see the 'bidirectional' example below).

   This is what we do in passt's upstream tests (for a sample run, see
   https://passt.top/#continuous-integration, skip to 'migrate/basic'
   using the links on the bottom). The setup function is here:

     https://passt.top/passt/tree/test/lib/setup?id=e3f70c05bad90368a1a89bf31a9015125232b9ae#n308

   and these are the test directives themselves:

     https://passt.top/passt/tree/test/migrate/basic
     https://passt.top/passt/tree/test/migrate/bidirectional

   ...if you want to try and run these tests, see
   https://passt.top/passt/tree/test/README.md. The test suite has quite
   a few dependencies and it might take a bit of effort to run the
   whole thing, but if you 'make assets' under test/ and then select
   one single test instead, with './run migrate/basic', it should be
   practical.

   I can write up "stand-alone" instructions based on that if needed.

2. two virtual machines, bridged (no need for root if you detach a
   network namespace on the host), migrating nested guests. Assuming
   three terminals (host, source, target), and a libvirt domain named
   "alpine" *inside* L1 guests (no need for libvirt, it just makes the
   write-up a bit more terse):

---
   [host]
   $ unshare -rUn
   # echo $$	# let's call this TARGET_PID
   # ip link set dev lo up


   [source]
   $ nsenter --preserve-credentials -U -n -t $TARGET_PID
   # qemu-system-x86_64 -machine accel=kvm -cpu host ... -nographic -serial mon:stdio -nodefaults -m 4G -netdev tap,id=n,script=no -device virtio-net,netdev=n

   ...in the guest, once it starts:

   # service NetworkManager stop	# if you have it
   # ip link set dev eth0 up
   # ip addr add dev eth0 10.0.0.1/24
   # ip route add default dev eth0
   # ip link set dev eth0 addr 52:54:00:12:34:57


   [target]
   $ nsenter --preserve-credentials -U -n -t $TARGET_PID
   # qemu-system-x86_64 -machine accel=kvm -cpu host ... -nographic -serial mon:stdio -nodefaults -m 4G -netdev tap,id=n,script=no -device virtio-net,netdev=n

   ...in the guest, once it starts:

   # service NetworkManager stop	# if you have it
   # ip link set dev eth0 up
   # ip addr add dev eth0 10.0.0.2/24
   # ip route add default dev eth0


   [host]
   # ip link set dev tap0 up
   # ip link set dev tap1 up
   # ip link add dev br0 type bridge
   # ip link set dev tap0 master br0
   # ip link set dev tap1 master br0
   # ip addr add dev br0 10.0.0.3/24

   check that we can reach the target
   # ping 10.0.0.2

   start the test server
   # ip addr add dev br0 172.16.0.3/24
   # nc -l -p 8080


   [*both* source and target]
   # ip addr add dev eth0 172.16.0.1/25 # make sure passt picks this address for the guests, as it's more specific than a 10.0.0.0/24, it's /25
   # ip route add default via 172.16.0.100 # and add a default route just so that the guest has one, but we don't need this


   [source (use another terminal, or run passt-repair in background)]
   # mkdir /run/user/1001/libvirt/qemu/run/passt/
   # passt-repair /run/user/1001/libvirt/qemu/run/passt/


   [source]
   $ virsh start --console alpine

   ...in the guest, once it starts:

   $ nc 172.16.0.3 8080
   start typing, before migration


   [source (use another terminal, or escape console while keeping nc running)]
   $ virsh migrate --verbose --p2p --live --unsafe alpine --tunneled qemu+ssh://10.0.0.2/session
---

   if you reverse the direction of the connection, you'll need two
   bridges, one for migration data and one for the test connection
   itself.

   Otherwise, the kernel on the source L1 guest will manage to send a
   RST to your client (on L0) as soon as the connection continues on
   the target, because ACK segments from the target will reach the
   source (they're bridged), but the source has no open socket at this
   point.

   With two bridges, you can "unplug" the source target (test
   connection / tap interface only) before migrating. As an alternative,
   you could drop RST segments using nftables.

   I can clean up my notes for these additional steps if anybody is
   interested. Eventually, I guess, it should all become part of QEMU's
   documentation.

> > I plan anyway to try out your changes but I might need a couple of days
> > before I find the time.
> >   
> > > Does it also handle other protocols, or just preserves TCP connections?  
> > 
> > Layer-4-wise, we have an internal representation of UDP "flows"
> > (observed flows of packets for which we preserve the same source port
> > mapping, with timeouts) and we had a vague idea of migrating those as
> > well, but it's debatable where there's any benefit from it.
> > 
> > At Layer 2 and 3, we migrate IP and MAC addresses we observed from the
> > guest:
> > 
> >   https://passt.top/passt/tree/migrate.c?id=e3f70c05bad90368a1a89bf31a9015125232b9ae#n31
> > 
> > so that we have ARP and NDP resolution, as well as any NAT
> > mapping working right away as needed.
> > 
> > For completeness, this is the TCP context we migrate instead:
> > 
> >   https://passt.top/passt/tree/tcp_conn.h?id=e3f70c05bad90368a1a89bf31a9015125232b9ae#n108
> >   https://passt.top/passt/tree/tcp_conn.h?id=e3f70c05bad90368a1a89bf31a9015125232b9ae#n154
> >   
> > > The main focus of this feature are protocols that cannot handle packet
> > > loss on their own in environments where IP address is preserved (and
> > > thus also TCP connections).  
> > 
> > Well, strictly speaking, TCP handles packet loss, that's actually the
> > main reason behind it. I guess this is to improve throughput and avoid
> > latency spikes or retransmissions that could be avoided?  
> 
> Sorry, I actually meant that all connections are preserved. The main
> goal is to prevent losses with protocols other than TCP when possible,
> which was requested by our Solution Architects. Possible improved TCP
> throughput due to avoided retransmissions is just a side effect of that.

Interesting... you mean UDP? Or non-IP protocols?

For some typical UDP applications (realtime audio/video streams) I
generally expect delayed datagrams (more of them) to be worse than some
lost datagrams (fewer of them). This is part of the reason why I didn't
particularly care about that in passt. Well, as long as there's a way
to disable this mechanism, one could tune the configuration to their
needs.

> > > So, mainly tap/bridge, with the idea that
> > > other network backends could also benefit from it. However, if it causes
> > > problems with other backends, I could limit it just to tap.  
> > 
> > I couldn't quite figure out yet if it's beneficial, useless, or
> > harmless for passt. With passt, what happens without your
> > implementation is:
> > 
> > 1. guest pauses
> > 
> > 2. the source instance of passt starts migrating, meaning that sockets
> >    are frozen one by one, their receiving and sending queues dumped
> > 
> > 3. pending queues are sent to the target instance of passt, which opens
> >    sockets as refills queues as needed
> > 
> > 4. target guest resumes and will get any traffic that was received by
> >    the source instance of passt between 1. and 2.
> > 
> > Right now there's still a Linux kernel issue we observed (see also
> > https://pad.passt.top/p/TcpRepairTodo, that's line 4 there) which might
> > cause segments to be received (and acknowledged!) on sockets of the
> > source instance of passt for a small time period *after* we freeze them
> > with TCP_REPAIR (that is, TCP_REPAIR doesn't really freeze the queue).
> > 
> > I'm currently working on a proper fix for that. Until then, point 2.
> > above isn't entirely accurate (but it only happens if you hammer it
> > with traffic generators, it's not really visible otherwise).
> > 
> > With your implementation, I guess:
> > 
> > 1. guest pauses
> > 
> > 2. the source instance of passt starts migrating, meaning that sockets
> >    are frozen one by one, their receiving and sending queues dumped
> > 
> > 2a. any data received by QEMU after 1. will be stored and forwarded to
> >     the target later. But passt at this point prevents the guest from
> >     getting any data, so there should be no data involved
> > 
> > 3. pending queues are sent to the target instance of passt, which opens
> >    sockets as refills queues as needed
> > 
> > 3a. the target guest gets the data from 2a. As long as there's no data
> >     (as I'm assuming), there should be no change. If there's data coming
> >     in at this point, we risk that sequences don't match anymore? I'm not
> >     sure
> > 
> > 4. target guest resumes and will *also* get any traffic that was received
> >    by the source instance of passt between 1. and 2.
> > 
> > So if my assumption from 2a. above holds, it should be useless, but
> > harmless.
> > 
> > Would your implementation help with the kernel glitch we're currently
> > observing? I don't think so, because your implementation would only play
> > a role between passt and QEMU, and we don't have issues there.
> > 
> > Well, it would be good to try things out. Other than that, unless I'm
> > missing something, your implementation should probably be skipped for
> > passt for simplicity, and also to avoid negatively affecting downtime.  
> 
> I agree with skipping passt in such case, although, I haven't perceived
> any effect on downtime. Cached network packets are sent after the
> destination resumes, so that the network knows about new location of the
> VM and the source shouldn't receive any more packets intended for it.
> 
> > Note that you can also use passt without "-net passt" (that's actually
> > quite recent) but with a tap back-end. Migration is only supported with
> > vhost-user enabled though, and as far as I understand your implementation
> > is disabled in that case?  
> 
> As of now it is disabled in that case as network filters don't support
> vhost.

Is that something you plan to fix / change in the future, though? In
that case, I would try to check how this works with passt in a bit more
detail (now or later).

-- 
Stefano


