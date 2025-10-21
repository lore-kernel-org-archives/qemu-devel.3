Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E37A0CCD1A7
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 13:58:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBCsi-0000b5-Tn; Tue, 21 Oct 2025 09:58:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vBCsf-0000W8-1f
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 09:58:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vBCsa-0007zZ-Pl
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 09:58:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761055101;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cXpcost0SeoDXjVWuuZ2RUAR5mmmaYchsv4OvkP0tmc=;
 b=PEXyj//u2c5DwBhGvnquqZBFeTHbzyWLNbFCvrxWMuXJB+Izfsjm3xaktEiC0GZ1nKpo6+
 rPG3daTidx2XB5sfGV2YrFVLvQe/1SUfVOEw1qYLOBa5krgRSncmzNH4/7byLkbUMS53wI
 l1qHrjugfZlaU9nrUzfkvIQGG9AamZY=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-352-9SqdaElOOSaxxcLL6mADfw-1; Tue, 21 Oct 2025 09:58:19 -0400
X-MC-Unique: 9SqdaElOOSaxxcLL6mADfw-1
X-Mimecast-MFC-AGG-ID: 9SqdaElOOSaxxcLL6mADfw_1761055099
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-88f81cf8244so3369662085a.0
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 06:58:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761055099; x=1761659899;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cXpcost0SeoDXjVWuuZ2RUAR5mmmaYchsv4OvkP0tmc=;
 b=tnvwS2n7My1vJzLPqOK3mPHwJkp6j1lqg9lgDt1ndvRdyob0haTncM8UT59Fi++v8n
 rvi0njThXvoMMOneSYVQhAN8DJDlvXaQX2KebYc4/xEcytF0OYmjZ1jTuRy/gsczr0Wi
 xGihDhnlCTgHCSh9KeH1s1KCm0+1Z9hCb8g7hw9m+WgmTeoeHcMTwf9bf1kiWsA7zrvJ
 p8YR/l/Ok3jWnBwuy1pq111Aikn66N8sq2zMUiEPt9G8XoDVcrGhBbZQh1YgXoj1zFhi
 OGk8n9kQSyQQcJu+1CD0bYqFFYxjeA5PeR1HPRo20fNdyZw7akTOEWuoGnYS2AO+RC09
 jNBw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW374f7gTRju/C7FgyDY55qicGgFcqLcF1X5Wo4iCdAM7CVwLOOvnatJx8cG6E8nCTWBAEFa/QRckLa@nongnu.org
X-Gm-Message-State: AOJu0YzIU2xGCej1PaSo5nvgZ7mUX+FT5f/+qQAUVrlb/+aQTzEtw3cM
 dPC9vYunt9U0YvQ04fcGZUNFiyEtMMr3xfXAab81UDEGXb3DRvnFTS2WMGl5Y1HzAaO8QZpmT85
 +m3pkvYS9cJPVmPWHlHnk4RsH+UJAZA6B9prrZGMgq28Zsja6D/d0XBNB
X-Gm-Gg: ASbGncvHcwHJBtWClN6bOr8tsvFgqb/VC/o2GJqueaXdxcKxeCnSuPJ9JaUdKJzcO0S
 EErx2i6HhdBJYVC2R77cbSu1owAFIr2ciFhgd0/qUtUZvJb1LOXl47ZgC98fHUlCo38uEoKp4C2
 GCuD/JYEf/JZPoWnMuI2J1flQpXU6Yn7inMGxuRpQprx1JYRzY6PfmBza5/34ckqM+HY682e1h8
 6vWx11Cg7fPfS93B8gh17Yo20Ehp4l+xWzrW9YKp0bKvCzeO7G2CDDHaFf8fmZBL2zQmOd8p/Lx
 9wb0ekuBuWNJrFVN7vA3wNJAaPpXWXusSlmmpSzkzwHsUEdqN2WUhnrldz+4Ol7qClY=
X-Received: by 2002:a05:620a:2a0d:b0:890:686b:a109 with SMTP id
 af79cd13be357-8906e6b7489mr1991702785a.25.1761055098977; 
 Tue, 21 Oct 2025 06:58:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENclV5VRzTEloyumyj0VfhEJLKCeaoPhgcqAs7N46HLuPO9frUo/bkT0hwGbfBwQpSb2vRQw==
X-Received: by 2002:a05:620a:2a0d:b0:890:686b:a109 with SMTP id
 af79cd13be357-8906e6b7489mr1991698585a.25.1761055098303; 
 Tue, 21 Oct 2025 06:58:18 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-891cfb57f1dsm765026085a.62.2025.10.21.06.58.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Oct 2025 06:58:17 -0700 (PDT)
Date: Tue, 21 Oct 2025 09:58:00 -0400
From: Peter Xu <peterx@redhat.com>
To: Zhang Chen <zhangckid@gmail.com>
Cc: Lukas Straub <lukasstraub2@web.de>,
 Hailiang Zhang <zhanghailiang@xfusion.com>, qemu-devel@nongnu.org,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Yury Kotov <yury-kotov@yandex-team.ru>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Prasad Pandit <ppandit@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH RFC 0/9] migration: Threadify loadvm process
Message-ID: <aPeRaOv3BkRYohqA@x1.local>
References: <20250827205949.364606-1-peterx@redhat.com>
 <CAK3tnvKa=C-9qkOuyB+sZB8+o6YU0V+qaYheK-h9KBEumpyfBw@mail.gmail.com>
 <aObW9WrmWzTWs4N0@x1.local> <aPasigsOmIKvoqqm@x1.local>
 <20251021000854.5cd97864@penguin>
 <CAK3tnv+dREd=iNsZdK-Th9rrF1wRvxZrR=Pc+yE21V=2Bc=s+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK3tnv+dREd=iNsZdK-Th9rrF1wRvxZrR=Pc+yE21V=2Bc=s+g@mail.gmail.com>
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

On Tue, Oct 21, 2025 at 10:31:50AM +0800, Zhang Chen wrote:
> On Tue, Oct 21, 2025 at 6:09 AM Lukas Straub <lukasstraub2@web.de> wrote:
> >
> > On Mon, 20 Oct 2025 17:41:30 -0400
> > Peter Xu <peterx@redhat.com> wrote:
> >
> > > On Wed, Oct 08, 2025 at 05:26:13PM -0400, Peter Xu wrote:
> > > > On Thu, Sep 04, 2025 at 04:27:39PM +0800, Zhang Chen wrote:
> > > > > > I confess I didn't test anything on COLO but only from code observations
> > > > > > and analysis.  COLO maintainers: could you add some unit tests to QEMU's
> > > > > > qtests?
> > > > >
> > > > > For the COLO part, I think remove the coroutines related code is OK for me.
> > > > > Because the original coroutine still need to call the
> > > > > "colo_process_incoming_thread".
> > > >
> > > > Chen, thanks for the comment.  It's still reassuring.
> > > >
> > > > >
> > > > > Hi Hailiang, any comments for this part?
> > > >
> > > > Any further comment on this series would always be helpful.
> > > >
> > > > It'll be also great if anyone can come up with a selftest for COLO.  Now
> > > > any new migration features needs both unit test and doc to get merged.
> > > > COLO was merged earlier so it doesn't need to, however these will be
> > > > helpful for sure to make sure COLO won't be easily broken.
> > >
> > > Chen/Hailiang:
> > >
> > > I may use some help from COLO side.
> > >
> > > Just now, I did give it a shot with the current docs/COLO-FT.txt and it
> > > didn't really work for me.
> > >
> > > The cmdlines I used almost followed the doc, however I changed a few
> > > things.  For example, on secondary VM I added "file.locking=off" for drive
> > > "parent0" because otherwise the "nbd-server-add" command will fail taking
> > > the lock and it won't ever boot.  Meanwhile I switched to socket netdev
> > > from tap, in my case I only plan to run the COLO main routine, I hope
> > > that's harmless too but let me know if it is a problem.
> > >
> > > So below are the final cmdlines I used..
> > >
> > > For primary:
> > >
> > > bin=~/git/qemu/bin/qemu-system-x86_64
> > > $bin -enable-kvm -cpu qemu64,kvmclock=on \
> > >      -m 512 -smp 1 -qmp stdio \
> > >      -device piix3-usb-uhci -device usb-tablet -name primary \
> > >      -netdev socket,id=hn0,listen=127.0.0.1:10000 \
> > >      -device rtl8139,id=e0,netdev=hn0 \
> > >      -chardev socket,id=mirror0,host=0.0.0.0,port=9003,server=on,wait=off \
> > >      -chardev socket,id=compare1,host=0.0.0.0,port=9004,server=on,wait=on \
> > >      -chardev socket,id=compare0,host=127.0.0.1,port=9001,server=on,wait=off \
> > >      -chardev socket,id=compare0-0,host=127.0.0.1,port=9001 \
> > >      -chardev socket,id=compare_out,host=127.0.0.1,port=9005,server=on,wait=off \
> > >      -chardev socket,id=compare_out0,host=127.0.0.1,port=9005 \
> > >      -object filter-mirror,id=m0,netdev=hn0,queue=tx,outdev=mirror0 \
> > >      -object filter-redirector,netdev=hn0,id=redire0,queue=rx,indev=compare_out \
> > >      -object filter-redirector,netdev=hn0,id=redire1,queue=rx,outdev=compare0 \
> > >      -object iothread,id=iothread1 \
> > >      -object colo-compare,id=comp0,primary_in=compare0-0,secondary_in=compare1,outdev=compare_out0,iothread=iothread1 \
> > >      -drive if=ide,id=colo-disk0,driver=quorum,read-pattern=fifo,vote-threshold=1,children.0.file.filename=./primary.qcow2,children.0.driver=qcow2
> > >
> > > For secondary (testing locally, hence using 127.0.0.1 as primary_ip):
> > >
> > > bin=~/git/qemu/bin/qemu-system-x86_64
> > > primary_ip=127.0.0.1
> > > $bin -enable-kvm -cpu qemu64,kvmclock=on -m 512 -smp 1 -qmp stdio \
> > >      -device piix3-usb-uhci -device usb-tablet -name secondary \
> > >      -netdev socket,id=hn0,connect=127.0.0.1:10000 \
> > >      -device rtl8139,id=e0,netdev=hn0 \
> > >      -chardev socket,id=red0,host=$primary_ip,port=9003,reconnect-ms=1000 \
> > >      -chardev socket,id=red1,host=$primary_ip,port=9004,reconnect-ms=1000 \
> > >      -object filter-redirector,id=f1,netdev=hn0,queue=tx,indev=red0 \
> > >      -object filter-redirector,id=f2,netdev=hn0,queue=rx,outdev=red1 \
> > >      -object filter-rewriter,id=rew0,netdev=hn0,queue=all \
> > >      -drive if=none,id=parent0,file.filename=primary.qcow2,driver=qcow2,file.locking=off \
> > >      -drive if=none,id=childs0,driver=replication,mode=secondary,file.driver=qcow2,top-id=colo-disk0,file.file.filename=secondary-active.qcow2,file.backing.driver=qcow2,file.backing.file.filename=secondary-hidden.qcow2,file.backing.backing=parent0 \
> > >      -drive if=ide,id=colo-disk0,driver=quorum,read-pattern=fifo,vote-threshold=1,children.0=childs0 \
> > >      -incoming tcp:0.0.0.0:9998
> > >
> >
> > Hi Peter,
> > You have to use -incoming defer and enable x-colo on the
> > secondary side before starting migration.
> >
> > And primary.qcow2 should be a separate image (with same content) for
> > each qemu instance.
> 
> Yes, Lukas is right. Qemu can't allow 2 VM touch 1 image.
> So, you can try to "cp primary.qcow2 secondary.qcow2",
> then change the secondary side to " -drive
> if=none,id=parent0,file.filename=secondary.qcow2,driver=qcow2,file.locking=off
> \"

Thanks both.

I think the doc says otherwise.. do you mean the doc is wrong and needs
fixing at least?

I created the secondary.qcow2, and switched to that, still it hit the same
error.

Step 1: start primary QEMU

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

Step 2: start secondary QEMU

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
     -drive if=none,id=parent0,file.filename=secondary.qcow2,driver=qcow2,file.locking=off \
     -drive if=none,id=childs0,driver=replication,mode=secondary,file.driver=qcow2,top-id=colo-disk0,file.file.filename=secondary-active.qcow2,file.backing.driver=qcow2,file.backing.file.filename=secondary-hidden.qcow2,file.backing.backing=parent0 \
     -drive if=ide,id=colo-disk0,driver=quorum,read-pattern=fifo,vote-threshold=1,children.0=childs0 \
     -incoming tcp:0.0.0.0:9998

Step 3: Run these commands on secondary QEMU

{"execute":"qmp_capabilities"}
{"execute": "migrate-set-capabilities", "arguments": {"capabilities": [ {"capability": "x-colo", "state": true } ] } }
{"execute": "nbd-server-start", "arguments": {"addr": {"type": "inet", "data": {"host": "0.0.0.0", "port": "9999"} } } }
{"execute": "nbd-server-add", "arguments": {"device": "parent0", "writable": true } }

Step 4: Run these commands on primary QEMU

{"execute":"qmp_capabilities"}
{"execute": "human-monitor-command", "arguments": {"command-line": "drive_add -n buddy driver=replication,mode=primary,file.driver=nbd,file.host=127.0.0.2,file.port=9999,file.export=parent0,node-name=replication0"}}
{"execute": "x-blockdev-change", "arguments":{"parent": "colo-disk0", "node": "replication0" } }
{"execute": "migrate-set-capabilities", "arguments": {"capabilities": [ {"capability": "x-colo", "state": true } ] } }
{"execute": "migrate", "arguments": {"uri": "tcp:127.0.0.2:9998" } }

What I got:

Primary QEMU output:

qemu-system-x86_64: -chardev socket,id=compare1,host=0.0.0.0,port=9004,server=on,wait=on: info: QEMU waiting for connection on: disconnected:tcp:0.0.0.0:9004,server=on
{"QMP": {"version": {"qemu": {"micro": 50, "minor": 1, "major": 10}, "package": "v10.1.0-1513-g94586867df"}, "capabilities": ["oob"]}}
VNC server running on ::1:5901
{"error": {"class": "GenericError", "desc": "JSON parse error, stray '\f'"}}
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
{"timestamp": {"seconds": 1761054720, "microseconds": 515770}, "event": "STOP"}

Secondary QEMU output:

{"QMP": {"version": {"qemu": {"micro": 50, "minor": 1, "major": 10}, "package": "v10.1.0-1513-g94586867df"}, "capabilities": ["oob"]}}
VNC server running on ::1:5900
{"execute":"qmp_capabilities"}
{"return": {}}
{"execute": "migrate-set-capabilities", "arguments": {"capabilities": [ {"capability": "x-colo", "state": true } ] } }
{"return": {}}
{"execute": "nbd-server-start", "arguments": {"addr": {"type": "inet", "data": {"host": "0.0.0.0", "port": "9999"} } } }
{"return": {}}
{"execute": "nbd-server-add", "arguments": {"device": "parent0", "writable": true } }
{"return": {}}
{"timestamp": {"seconds": 1761054721, "microseconds": 188336}, "event": "RESUME"}
qemu-system-x86_64: Can't receive COLO message: Input/output error
{"timestamp": {"seconds": 1761054721, "microseconds": 188883}, "event": "COLO_EXIT", "data": {"mode": "secondary", "reason": "error"}}

Thanks,

-- 
Peter Xu


