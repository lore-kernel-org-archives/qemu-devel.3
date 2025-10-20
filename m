Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95D76CCD19F
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 21:42:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAxdU-00027W-MK; Mon, 20 Oct 2025 17:41:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vAxdR-00025b-2d
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 17:41:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vAxdJ-0003GQ-MB
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 17:41:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760996495;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PxHC3QnWvbwXPfESkmPkMTwiHEY2wH1rzZ6PTLjmNfc=;
 b=RBoGKf80T+vO4o9CiTW6+IJ18ummPxQIBrlz2eI3armJWjJmhfDb9p9wwhZqJQWi3M68UP
 K3oaUZQA00C3UxBDfFseMh2Zz1luhitle50CjJWjLyrMoxjCZgxesTnO6X+77mNOeQiu+N
 96OjtQiFksZtDpi6eWLmtaeGW3PrO5k=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-58-oWE60cfxPQef-KS4dSiUkw-1; Mon, 20 Oct 2025 17:41:34 -0400
X-MC-Unique: oWE60cfxPQef-KS4dSiUkw-1
X-Mimecast-MFC-AGG-ID: oWE60cfxPQef-KS4dSiUkw_1760996493
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-87c247591ddso144851926d6.1
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 14:41:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760996493; x=1761601293;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PxHC3QnWvbwXPfESkmPkMTwiHEY2wH1rzZ6PTLjmNfc=;
 b=R9lkHHZNPxr30vHXAKn8iXz7PDSVSkf+OaFwoes5/1n7bbhnfE2qjxiOIvIVyBqCEb
 uRLvi8kKpD0NErwka7gpHiCuuyzp8QkgDhIU2pl7/U+gqAwetDvq2TyH8OsQgyjBsGaO
 T6OTBXPQI9BzmY9qo0AoUTM3KfWE+NcFiR4wuBIblrdOOjz4gewP9NB/GOA/1TNKq7Lg
 59m+pNdP9FKZml0GSzU2tCWNu/yWGUSGAtqytYslvbDnO51EaQChMyOWksDhX3vNSs9F
 RKPrX3e1jDYYbwdWp2f/l9ChbQj381aWR+eZjX3tsLHWqxas+8htygBzt6tNkEHoqKIb
 WSrQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWH61+SQdzVp/Rlk1vrYa/t8uZM/PgXZ3FRRMigoLC5JUAjZ56eA230a9ES0486wbPzJLc3sn8cDwtX@nongnu.org
X-Gm-Message-State: AOJu0Ywqa5LNgcWYZLb6cdbdnI2P32CgeF+Nj1ySewW6HRS4Sygn8xID
 ZYVCQwncSHziEAQ33o7SMlQQ7GZ1/UiNrQ8uazwYlEjvJIf7QpQdWGudbSeLtjqo+dSaELiR085
 eonL7FRiMlszxVNVGTdKiD1a3SczuSEDaO3yC7/ImiFsJREv0mqyzTCmZ
X-Gm-Gg: ASbGncvcrJey7FdlRBwqCMOxKL461AUboHkl4Kjtp9CLDfW/AilJuabJYhsbKNQELMr
 6fqj24ONrqwJCB+LgY3+lho667acPLH+yQpCILJUdpt9Dn6c3YPelJR7JkLABZmNwZ0OBt0qpDR
 ID9zvDHXSAVZYJ+gNxaN3HSX0drbZ7WmExCZZlQutS7x6bbhBcbZIefJcN0i2YuyR0SLzRsXdKt
 EY91jZ5CHseW1aU357UNYNa0qIg7WG6qecQQfb6qOCCKS44Ko0CnhcxvDLpMNQ3wL23Ug8aQb3j
 ikLMffhKAgg7bEVn30EWUmhu7Yg4lx8TBha1HDFcFpwBybi2bd+URXvG8x5YuURMdLQ=
X-Received: by 2002:a05:6214:5196:b0:87c:1fd9:da4a with SMTP id
 6a1803df08f44-87c2055e680mr243961116d6.2.1760996493335; 
 Mon, 20 Oct 2025 14:41:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG4RUmA/saiJc7LdhVEqVsDXIYYRpBEWiWdtdQmTw1Fwg4mMdBgbi/lxr10KSHrCV+MEqGNQw==
X-Received: by 2002:a05:6214:5196:b0:87c:1fd9:da4a with SMTP id
 6a1803df08f44-87c2055e680mr243960656d6.2.1760996492755; 
 Mon, 20 Oct 2025 14:41:32 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-87d02895c5bsm57943296d6.30.2025.10.20.14.41.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Oct 2025 14:41:32 -0700 (PDT)
Date: Mon, 20 Oct 2025 17:41:30 -0400
From: Peter Xu <peterx@redhat.com>
To: Zhang Chen <zhangckid@gmail.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>
Cc: Hailiang Zhang <zhanghailiang@xfusion.com>, qemu-devel@nongnu.org,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Yury Kotov <yury-kotov@yandex-team.ru>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Prasad Pandit <ppandit@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH RFC 0/9] migration: Threadify loadvm process
Message-ID: <aPasigsOmIKvoqqm@x1.local>
References: <20250827205949.364606-1-peterx@redhat.com>
 <CAK3tnvKa=C-9qkOuyB+sZB8+o6YU0V+qaYheK-h9KBEumpyfBw@mail.gmail.com>
 <aObW9WrmWzTWs4N0@x1.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aObW9WrmWzTWs4N0@x1.local>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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

On Wed, Oct 08, 2025 at 05:26:13PM -0400, Peter Xu wrote:
> On Thu, Sep 04, 2025 at 04:27:39PM +0800, Zhang Chen wrote:
> > > I confess I didn't test anything on COLO but only from code observations
> > > and analysis.  COLO maintainers: could you add some unit tests to QEMU's
> > > qtests?
> > 
> > For the COLO part, I think remove the coroutines related code is OK for me.
> > Because the original coroutine still need to call the
> > "colo_process_incoming_thread".
> 
> Chen, thanks for the comment.  It's still reassuring.
> 
> > 
> > Hi Hailiang, any comments for this part?
> 
> Any further comment on this series would always be helpful.
> 
> It'll be also great if anyone can come up with a selftest for COLO.  Now
> any new migration features needs both unit test and doc to get merged.
> COLO was merged earlier so it doesn't need to, however these will be
> helpful for sure to make sure COLO won't be easily broken.

Chen/Hailiang:

I may use some help from COLO side.

Just now, I did give it a shot with the current docs/COLO-FT.txt and it
didn't really work for me.

The cmdlines I used almost followed the doc, however I changed a few
things.  For example, on secondary VM I added "file.locking=off" for drive
"parent0" because otherwise the "nbd-server-add" command will fail taking
the lock and it won't ever boot.  Meanwhile I switched to socket netdev
from tap, in my case I only plan to run the COLO main routine, I hope
that's harmless too but let me know if it is a problem.

So below are the final cmdlines I used..

For primary:

bin=~/git/qemu/bin/qemu-system-x86_64
$bin -enable-kvm -cpu qemu64,kvmclock=on \
     -m 512 -smp 1 -qmp stdio \
     -device piix3-usb-uhci -device usb-tablet -name primary \
     -netdev socket,id=hn0,listen=127.0.0.1:10000 \
     -device rtl8139,id=e0,netdev=hn0 \
     -chardev socket,id=mirror0,host=0.0.0.0,port=9003,server=on,wait=off \
     -chardev socket,id=compare1,host=0.0.0.0,port=9004,server=on,wait=on \
     -chardev socket,id=compare0,host=127.0.0.1,port=9001,server=on,wait=off \
     -chardev socket,id=compare0-0,host=127.0.0.1,port=9001 \
     -chardev socket,id=compare_out,host=127.0.0.1,port=9005,server=on,wait=off \
     -chardev socket,id=compare_out0,host=127.0.0.1,port=9005 \
     -object filter-mirror,id=m0,netdev=hn0,queue=tx,outdev=mirror0 \
     -object filter-redirector,netdev=hn0,id=redire0,queue=rx,indev=compare_out \
     -object filter-redirector,netdev=hn0,id=redire1,queue=rx,outdev=compare0 \
     -object iothread,id=iothread1 \
     -object colo-compare,id=comp0,primary_in=compare0-0,secondary_in=compare1,outdev=compare_out0,iothread=iothread1 \
     -drive if=ide,id=colo-disk0,driver=quorum,read-pattern=fifo,vote-threshold=1,children.0.file.filename=./primary.qcow2,children.0.driver=qcow2

For secondary (testing locally, hence using 127.0.0.1 as primary_ip):

bin=~/git/qemu/bin/qemu-system-x86_64 
primary_ip=127.0.0.1
$bin -enable-kvm -cpu qemu64,kvmclock=on -m 512 -smp 1 -qmp stdio \
     -device piix3-usb-uhci -device usb-tablet -name secondary \
     -netdev socket,id=hn0,connect=127.0.0.1:10000 \
     -device rtl8139,id=e0,netdev=hn0 \
     -chardev socket,id=red0,host=$primary_ip,port=9003,reconnect-ms=1000 \
     -chardev socket,id=red1,host=$primary_ip,port=9004,reconnect-ms=1000 \
     -object filter-redirector,id=f1,netdev=hn0,queue=tx,indev=red0 \
     -object filter-redirector,id=f2,netdev=hn0,queue=rx,outdev=red1 \
     -object filter-rewriter,id=rew0,netdev=hn0,queue=all \
     -drive if=none,id=parent0,file.filename=primary.qcow2,driver=qcow2,file.locking=off \
     -drive if=none,id=childs0,driver=replication,mode=secondary,file.driver=qcow2,top-id=colo-disk0,file.file.filename=secondary-active.qcow2,file.backing.driver=qcow2,file.backing.file.filename=secondary-hidden.qcow2,file.backing.backing=parent0 \
     -drive if=ide,id=colo-disk0,driver=quorum,read-pattern=fifo,vote-threshold=1,children.0=childs0 \
     -incoming tcp:0.0.0.0:9998

I started secondary, then primary, run the suggested QMP commands on
secondary first, then the bunch of QMP commands on primary.  I got below
error:

x1:colo $ ./primary.sh 
qemu-system-x86_64: -chardev socket,id=compare1,host=0.0.0.0,port=9004,server=on,wait=on: info: QEMU waiting for connection on: disconnected:tcp:0.0.0.0:9004,server=on
{"QMP": {"version": {"qemu": {"micro": 50, "minor": 1, "major": 10}, "package": "v10.1.0-1513-g94586867df"}, "capabilities": ["oob"]}}
VNC server running on ::1:5900
{"execute":"qmp_capabilities"}
{"return": {}}
{"execute": "human-monitor-command", "arguments": {"command-line": "drive_add -n buddy driver=replication,mode=primary,file.driver=nbd,file.host=127.0.0.2,file.port=9999,file.export=parent0,node-name=replication0"}}
{"return": ""}
{"execute": "x-blockdev-change", "arguments":{"parent": "colo-disk0", "node": "replication0" } }
{"return": {}}
{"execute": "migrate-set-capabilities", "arguments": {"capabilities": [ {"capability": "x-colo", "state": true } ] } }
{"return": {}}
{"execute": "migrate", "arguments": {"uri": "tcp:127.0.0.2:9998" } }
{"return": {}}
{"timestamp": {"seconds": 1760996025, "microseconds": 483349}, "event": "STOP"}

x1:colo $ ./secondary.sh 
{"QMP": {"version": {"qemu": {"micro": 50, "minor": 1, "major": 10}, "package": "v10.1.0-1513-g94586867df"}, "capabilities": ["oob"]}}
VNC server running on ::1:5901
{"execute":"qmp_capabilities"}
{"return": {}}
{"execute": "migrate-set-capabilities", "arguments": {"capabilities": [ {"capability": "x-colo", "state": true } ] } }
{"return": {}}
{"execute": "nbd-server-start", "arguments": {"addr": {"type": "inet", "data": {"host": "0.0.0.0", "port": "9999"} } } }
{"return": {}}
{"execute": "nbd-server-add", "arguments": {"device": "parent0", "writable": true } }
{"return": {}}
{"timestamp": {"seconds": 1760996025, "microseconds": 695059}, "event": "RESUME"}
qemu-system-x86_64: Can't receive COLO message: Input/output error
{"timestamp": {"seconds": 1760996025, "microseconds": 695369}, "event": "COLO_EXIT", "data": {"mode": "secondary", "reason": "error"}}

Do you know what I missed?  Or does it mean that COLO is broken?

Meanwhile, do you know if COLO still being used by anyone?  I'm pretty sure
both Fabiano and myself are not looking after it..  I remember Dave used to
try it, but it might be a long time ago too.

Thanks,

-- 
Peter Xu


