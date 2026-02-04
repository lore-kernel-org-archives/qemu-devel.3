Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D021FE9537B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 11:23:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnayf-0001fb-Fb; Wed, 04 Feb 2026 06:23:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1vnaye-0001fB-K9
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 06:23:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1vnayc-0007kR-2S
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 06:23:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770204196;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ob8gambAOJM93ER8kjMG5uukEQFZfFPqjHzsI96KoIw=;
 b=LM8JOl1NQRKtYEq4IHZ99I0klFGUW7BzBni9mee4GAGY3ilkosgYpsmYHtUFulGghGIE1w
 UuGPTs2IoYPJqgml2GpOZUy6MhSVgjbjSS50tWciMHUI2JnVTOLq12GX0+34ZGD2UA9Kmd
 zoAh45gNb2drzZlJT48oSec88X8WdYA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-530-RhzYu6GPOMKTL1luERknAA-1; Wed, 04 Feb 2026 06:23:14 -0500
X-MC-Unique: RhzYu6GPOMKTL1luERknAA-1
X-Mimecast-MFC-AGG-ID: RhzYu6GPOMKTL1luERknAA_1770204193
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-43065ad16a8so4820166f8f.1
 for <qemu-devel@nongnu.org>; Wed, 04 Feb 2026 03:23:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770204193; x=1770808993; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ob8gambAOJM93ER8kjMG5uukEQFZfFPqjHzsI96KoIw=;
 b=Y/SOGfiGbzZhQFuTR/O5xxK0DHbwcbmFlGeaESoKA4gepVQ5sE6FfsSoo42DBlHV0J
 Mra10W6s7UcgvGb8gat90x6HiL+lH+3lr06N6m7DQddL8kXETgcPX/hEDc8cI6UPXsWI
 OkRKih05Ywqd0mfW1el68J1pm9kCnYzpQHaUac2pAD4sRR65veEP/6VRya2xuIeqINFi
 rCE/9Np4102JIj5qVmTxd8wM7tAJITIQ27vibHSOrQN5bGL7E4DVkEbcCWfREv1SrYg4
 di6DcQ16DjnXdZYCnC1gZFwCLnNo3eRQC7ny2Hup42SwYK5fxuL56QaCZTqEVilF6wTb
 DIvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770204193; x=1770808993;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ob8gambAOJM93ER8kjMG5uukEQFZfFPqjHzsI96KoIw=;
 b=rMQfkjAp8UxvKKLNcnfbyu/CwyZ88EbvlhVWQbXCWDDSdTFMGr61LBXjYDayGad3TU
 P8cpxZhfDZw8iLprp9ALGpwvydxx2YXj64JQHiqpBDaLjTHgGSvkN4oZNlWnQyXL4BGD
 wBHpyyRJ78p0n9t1dGD8mSWGQmCQC9lFrq9pul3aZdCLJglqIBHAVMxivFB22Auwk0sb
 tdxyQeZddv0ExxoiTVEAxMfFBpXq9tJMlEfAZfFhErVy8ZbJufdvYamVccxgMAE7LrUI
 mRc889gbhxnn0TlgRTRYW3z/hUM2Y9FG0rEpTyPD7uwBzSQ02eU03T8x7f7Xj1mDxAU3
 F4NQ==
X-Gm-Message-State: AOJu0YwUt79/7wXs0wrFn43xmD7BATP7PAF3C19eL6zSjLR/oAlE0F0k
 nNG7RhRKBQsuNuMVCQkr4kHXhcO90BnakTC3BtbDNJ5zeAXexyZ4k/4B3/8ZfbIzKW5tzSXHy+U
 OYZ5Nfk0n2ngzFfcl1WpdiyKlWBw1kFZVnOl/g5iybOaDBicUPRHZm5NC
X-Gm-Gg: AZuq6aLNaMguvt5k9JEzDua7gIxQokch2XWcoyDF2kqYsUPtynS7vxHNnTDhWnYCE6S
 h9ZT7x6mDGiXKiQQLqYQnJvM1VmAaZFq+c9SbvxBbMIKQT578Vz+sj8oB7F/pUx52Rau1IOtxb0
 zg4Kz5xWZmMRQOAtKppWmQY/23D+TUUHZoPjpkrrFt+Ie6bv0g9BFxCQxO6dmoeJDnOQduTbz3c
 QmcJeVhDhqe/1c5vEAwM/9vi1YZrSqxJvN5ITKUsXM386WX0cftlqjdKuoEoE12D7f98V8dOV5d
 RfvGj3zqqugAj03gWfQPnfb9aVbob5Pxk01E8mtPEdxQ4sjTOdX2TpSPZoLTT/bekv3reDVNqUW
 JBl58PbSXWqnfj70jVQ4JnhQqrPaantw=
X-Received: by 2002:a05:6000:2c0e:b0:435:a370:2d71 with SMTP id
 ffacd0b85a97d-4361805290amr3629913f8f.33.1770204193019; 
 Wed, 04 Feb 2026 03:23:13 -0800 (PST)
X-Received: by 2002:a05:6000:2c0e:b0:435:a370:2d71 with SMTP id
 ffacd0b85a97d-4361805290amr3629859f8f.33.1770204192404; 
 Wed, 04 Feb 2026 03:23:12 -0800 (PST)
Received: from fedora (78-80-81-157.customers.tmcz.cz. [78.80.81.157])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-436180588bfsm5944684f8f.26.2026.02.04.03.23.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Feb 2026 03:23:11 -0800 (PST)
Date: Wed, 4 Feb 2026 12:23:09 +0100
From: Juraj Marcin <jmarcin@redhat.com>
To: Stefano Brivio <sbrivio@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Peter Xu <peterx@redhat.com>,
 Jason Wang <jasowang@redhat.com>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Laurent Vivier <laurent@vivier.eu>, 
 David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 0/4] migration: Pass network packets received during
 switchover to dest VM
Message-ID: <f7q5yx5wapbohas2icw4es3mqhdjmv5fsn72awajr5p2lcv2kd@26zwqnq52zz7>
References: <20260127140316.4187221-1-jmarcin@redhat.com>
 <20260127192108.216495da@elisabeth>
 <4uwcjd7ov7ib6q5pelqle3bdouoctyoqteec5f222cjatwkqxf@3p2n5hgjuwzk>
 <20260128182739.64f60eba@elisabeth>
 <66tveywu7fta7q3zswe3zksuadmmqjnn365ulv5tsb2k3m6i5b@mb6sjuzuukdb>
 <20260131032700.12f27487@elisabeth>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260131032700.12f27487@elisabeth>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jmarcin@redhat.com;
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

Hi Stefano,

On 2026-01-31 03:27, Stefano Brivio wrote:
> On Fri, 30 Jan 2026 15:40:01 +0100
> Juraj Marcin <jmarcin@redhat.com> wrote:
> 
> > Hi Stefano,
> > 
> > thanks for the answer!
> > 
> > On 2026-01-28 18:27, Stefano Brivio wrote:
> > > On Wed, 28 Jan 2026 14:06:11 +0100
> > > Juraj Marcin <jmarcin@redhat.com> wrote:
> > >   
> > > > Hi Stefano,
> > > > 
> > > > On 2026-01-27 19:21, Stefano Brivio wrote:  
> > > > > [Cc'ing Laurent and David]
> > > > > 
> > > > > On Tue, 27 Jan 2026 15:03:06 +0100
> > > > > Juraj Marcin <jmarcin@redhat.com> wrote:
> > > > >     
> > > > > > During switchover there is a period during which both source and
> > > > > > destination side VMs are paused. During this period, all network packets
> > > > > > are still routed to the source side, but it will never process them.
> > > > > > Once the destination resumes, it is not aware of these packets and they
> > > > > > are lost. This can cause packet loss in unreliable protocols and
> > > > > > extended delays due to retransmission in reliable protocols.
> > > > > > 
> > > > > > This series resolves this problem by caching packets received once the
> > > > > > source VM pauses and then passing and injecting them on the destination
> > > > > > side. This feature is implemented in the last patch. The caching and
> > > > > > injecting is implemented using network filter interface and should work
> > > > > > with any backend with vhost=off, but only TAP network backend was
> > > > > > explicitly tested.    
> > > > > 
> > > > > I haven't had a chance to try this change with passt(1) yet (the
> > > > > backend can be enabled using "-net passt" or by starting it
> > > > > separately).
> > > > > 
> > > > > Given that passt implements migration on its own (in deeper detail in
> > > > > some sense, as TCP connections are preserved if IP addresses match), I
> > > > > wonder if it this might affect or break it somehow.
> > > > > 
> > > > > Did you perhaps have some thoughts about that already?    
> > > > 
> > > > I'm aware of passt migrating its state and passt-repair, but I also
> > > > haven't tested it as I couldn't get passt-repair to work.  
> > > 
> > > Oops. Let me know if you're hitting any specific error I could look
> > > into.  
> > 
> > I tried it using this documentation [1] I found earlier, however, it
> > wouldn't work when migrating on the same host as I expected from it. The
> > destination passt process fails to get the port the outside TCP server
> > is communicating with and I see the connection still as established with
> > the source passt process. This is the specific error message from the
> > destination passt process:
> > 
> >     Flow 0 (TCP connection): Failed to connect migrated socket: Cannot assign requested address
> > 
> > [1]: https://www.qemu.org/docs/master/system/devices/net.html#example-of-migration-of-a-guest-on-the-same-host
> 
> Ouch, I see.
> 
> Laurent wrote this part of documentation showing the QEMU-related bits
> of the migration workflow, but we should have updated it with an
> example with real TCP flows, because in that case you can't have the
> two instances of QEMU and passt running in the same namespace of the
> same machine: ports and addresses will conflict.
> 
> There are two alternatives to test migration of actual flows.
> 
> 1. two namespaces, same machine, with one instance of passt and one
>    instance of QEMU in each.
> 
>    Testing a connection from guest to host can be done with a simple
>    client/server pair, whereas, the other way around, you need some
>    form of proxying (see the 'bidirectional' example below).
> 
>    This is what we do in passt's upstream tests (for a sample run, see
>    https://passt.top/#continuous-integration, skip to 'migrate/basic'
>    using the links on the bottom). The setup function is here:
> 
>      https://passt.top/passt/tree/test/lib/setup?id=e3f70c05bad90368a1a89bf31a9015125232b9ae#n308
> 
>    and these are the test directives themselves:
> 
>      https://passt.top/passt/tree/test/migrate/basic
>      https://passt.top/passt/tree/test/migrate/bidirectional
> 
>    ...if you want to try and run these tests, see
>    https://passt.top/passt/tree/test/README.md. The test suite has quite
>    a few dependencies and it might take a bit of effort to run the
>    whole thing, but if you 'make assets' under test/ and then select
>    one single test instead, with './run migrate/basic', it should be
>    practical.
> 
>    I can write up "stand-alone" instructions based on that if needed.
> 
> 2. two virtual machines, bridged (no need for root if you detach a
>    network namespace on the host), migrating nested guests. Assuming
>    three terminals (host, source, target), and a libvirt domain named
>    "alpine" *inside* L1 guests (no need for libvirt, it just makes the
>    write-up a bit more terse):
> 
> ---
>    [host]
>    $ unshare -rUn
>    # echo $$	# let's call this TARGET_PID
>    # ip link set dev lo up
> 
> 
>    [source]
>    $ nsenter --preserve-credentials -U -n -t $TARGET_PID
>    # qemu-system-x86_64 -machine accel=kvm -cpu host ... -nographic -serial mon:stdio -nodefaults -m 4G -netdev tap,id=n,script=no -device virtio-net,netdev=n
> 
>    ...in the guest, once it starts:
> 
>    # service NetworkManager stop	# if you have it
>    # ip link set dev eth0 up
>    # ip addr add dev eth0 10.0.0.1/24
>    # ip route add default dev eth0
>    # ip link set dev eth0 addr 52:54:00:12:34:57
> 
> 
>    [target]
>    $ nsenter --preserve-credentials -U -n -t $TARGET_PID
>    # qemu-system-x86_64 -machine accel=kvm -cpu host ... -nographic -serial mon:stdio -nodefaults -m 4G -netdev tap,id=n,script=no -device virtio-net,netdev=n
> 
>    ...in the guest, once it starts:
> 
>    # service NetworkManager stop	# if you have it
>    # ip link set dev eth0 up
>    # ip addr add dev eth0 10.0.0.2/24
>    # ip route add default dev eth0
> 
> 
>    [host]
>    # ip link set dev tap0 up
>    # ip link set dev tap1 up
>    # ip link add dev br0 type bridge
>    # ip link set dev tap0 master br0
>    # ip link set dev tap1 master br0
>    # ip addr add dev br0 10.0.0.3/24
> 
>    check that we can reach the target
>    # ping 10.0.0.2
> 
>    start the test server
>    # ip addr add dev br0 172.16.0.3/24
>    # nc -l -p 8080
> 
> 
>    [*both* source and target]
>    # ip addr add dev eth0 172.16.0.1/25 # make sure passt picks this address for the guests, as it's more specific than a 10.0.0.0/24, it's /25
>    # ip route add default via 172.16.0.100 # and add a default route just so that the guest has one, but we don't need this
> 
> 
>    [source (use another terminal, or run passt-repair in background)]
>    # mkdir /run/user/1001/libvirt/qemu/run/passt/
>    # passt-repair /run/user/1001/libvirt/qemu/run/passt/
> 
> 
>    [source]
>    $ virsh start --console alpine
> 
>    ...in the guest, once it starts:
> 
>    $ nc 172.16.0.3 8080
>    start typing, before migration
> 
> 
>    [source (use another terminal, or escape console while keeping nc running)]
>    $ virsh migrate --verbose --p2p --live --unsafe alpine --tunneled qemu+ssh://10.0.0.2/session
> ---
> 
>    if you reverse the direction of the connection, you'll need two
>    bridges, one for migration data and one for the test connection
>    itself.
> 
>    Otherwise, the kernel on the source L1 guest will manage to send a
>    RST to your client (on L0) as soon as the connection continues on
>    the target, because ACK segments from the target will reach the
>    source (they're bridged), but the source has no open socket at this
>    point.
> 
>    With two bridges, you can "unplug" the source target (test
>    connection / tap interface only) before migrating. As an alternative,
>    you could drop RST segments using nftables.
> 
>    I can clean up my notes for these additional steps if anybody is
>    interested. Eventually, I guess, it should all become part of QEMU's
>    documentation.
> 

thank you very much, I will try that.

> > > I plan anyway to try out your changes but I might need a couple of days
> > > before I find the time.
> > >   
> > > > Does it also handle other protocols, or just preserves TCP connections?  
> > > 
> > > Layer-4-wise, we have an internal representation of UDP "flows"
> > > (observed flows of packets for which we preserve the same source port
> > > mapping, with timeouts) and we had a vague idea of migrating those as
> > > well, but it's debatable where there's any benefit from it.
> > > 
> > > At Layer 2 and 3, we migrate IP and MAC addresses we observed from the
> > > guest:
> > > 
> > >   https://passt.top/passt/tree/migrate.c?id=e3f70c05bad90368a1a89bf31a9015125232b9ae#n31
> > > 
> > > so that we have ARP and NDP resolution, as well as any NAT
> > > mapping working right away as needed.
> > > 
> > > For completeness, this is the TCP context we migrate instead:
> > > 
> > >   https://passt.top/passt/tree/tcp_conn.h?id=e3f70c05bad90368a1a89bf31a9015125232b9ae#n108
> > >   https://passt.top/passt/tree/tcp_conn.h?id=e3f70c05bad90368a1a89bf31a9015125232b9ae#n154
> > >   
> > > > The main focus of this feature are protocols that cannot handle packet
> > > > loss on their own in environments where IP address is preserved (and
> > > > thus also TCP connections).  
> > > 
> > > Well, strictly speaking, TCP handles packet loss, that's actually the
> > > main reason behind it. I guess this is to improve throughput and avoid
> > > latency spikes or retransmissions that could be avoided?  
> > 
> > Sorry, I actually meant that all connections are preserved. The main
> > goal is to prevent losses with protocols other than TCP when possible,
> > which was requested by our Solution Architects. Possible improved TCP
> > throughput due to avoided retransmissions is just a side effect of that.
> 
> Interesting... you mean UDP? Or non-IP protocols?
> 
> For some typical UDP applications (realtime audio/video streams) I
> generally expect delayed datagrams (more of them) to be worse than some
> lost datagrams (fewer of them). This is part of the reason why I didn't
> particularly care about that in passt. Well, as long as there's a way
> to disable this mechanism, one could tune the configuration to their
> needs.

The original request from Solution Architects was demonstrated
using ICMP Echo Requests, but it should work for any protocol. While, yes,
it will add certain delay to the packets, depending on the user's use
case it might be better than loosing them altogether. User can decide
and configure to their needs.

However, in case of strict realtime workloads, migration might off the
table altogether as the switchover during which all CPUs are paused is
unavoidable.

> 
> > > > So, mainly tap/bridge, with the idea that
> > > > other network backends could also benefit from it. However, if it causes
> > > > problems with other backends, I could limit it just to tap.  
> > > 
> > > I couldn't quite figure out yet if it's beneficial, useless, or
> > > harmless for passt. With passt, what happens without your
> > > implementation is:
> > > 
> > > 1. guest pauses
> > > 
> > > 2. the source instance of passt starts migrating, meaning that sockets
> > >    are frozen one by one, their receiving and sending queues dumped
> > > 
> > > 3. pending queues are sent to the target instance of passt, which opens
> > >    sockets as refills queues as needed
> > > 
> > > 4. target guest resumes and will get any traffic that was received by
> > >    the source instance of passt between 1. and 2.
> > > 
> > > Right now there's still a Linux kernel issue we observed (see also
> > > https://pad.passt.top/p/TcpRepairTodo, that's line 4 there) which might
> > > cause segments to be received (and acknowledged!) on sockets of the
> > > source instance of passt for a small time period *after* we freeze them
> > > with TCP_REPAIR (that is, TCP_REPAIR doesn't really freeze the queue).
> > > 
> > > I'm currently working on a proper fix for that. Until then, point 2.
> > > above isn't entirely accurate (but it only happens if you hammer it
> > > with traffic generators, it's not really visible otherwise).
> > > 
> > > With your implementation, I guess:
> > > 
> > > 1. guest pauses
> > > 
> > > 2. the source instance of passt starts migrating, meaning that sockets
> > >    are frozen one by one, their receiving and sending queues dumped
> > > 
> > > 2a. any data received by QEMU after 1. will be stored and forwarded to
> > >     the target later. But passt at this point prevents the guest from
> > >     getting any data, so there should be no data involved
> > > 
> > > 3. pending queues are sent to the target instance of passt, which opens
> > >    sockets as refills queues as needed
> > > 
> > > 3a. the target guest gets the data from 2a. As long as there's no data
> > >     (as I'm assuming), there should be no change. If there's data coming
> > >     in at this point, we risk that sequences don't match anymore? I'm not
> > >     sure
> > > 
> > > 4. target guest resumes and will *also* get any traffic that was received
> > >    by the source instance of passt between 1. and 2.
> > > 
> > > So if my assumption from 2a. above holds, it should be useless, but
> > > harmless.
> > > 
> > > Would your implementation help with the kernel glitch we're currently
> > > observing? I don't think so, because your implementation would only play
> > > a role between passt and QEMU, and we don't have issues there.
> > > 
> > > Well, it would be good to try things out. Other than that, unless I'm
> > > missing something, your implementation should probably be skipped for
> > > passt for simplicity, and also to avoid negatively affecting downtime.  
> > 
> > I agree with skipping passt in such case, although, I haven't perceived
> > any effect on downtime. Cached network packets are sent after the
> > destination resumes, so that the network knows about new location of the
> > VM and the source shouldn't receive any more packets intended for it.
> > 
> > > Note that you can also use passt without "-net passt" (that's actually
> > > quite recent) but with a tap back-end. Migration is only supported with
> > > vhost-user enabled though, and as far as I understand your implementation
> > > is disabled in that case?  
> > 
> > As of now it is disabled in that case as network filters don't support
> > vhost.
> 
> Is that something you plan to fix / change in the future, though? In
> that case, I would try to check how this works with passt in a bit more
> detail (now or later).

Yes, we are planning to implement such feature also with vhost.

> 
> -- 
> Stefano
> 


