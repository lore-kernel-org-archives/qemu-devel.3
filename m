Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DA57CCD1A2
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 02:33:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vB2Aw-0001if-G5; Mon, 20 Oct 2025 22:32:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1vB2At-0001hy-Sx
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 22:32:36 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1vB2Aq-0007y7-K9
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 22:32:35 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-63c1006fdcfso9937342a12.2
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 19:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761013948; x=1761618748; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MVIyQ0cytmkmUacvAZdhTRX6s7NWtXiYwmYFynMlLgU=;
 b=RY6p/cFzB74YzD8vWsgK6kSVBHqQcI6QI1q+FW3YwAmlhlc+Isc4A89b2fsdO3KaK3
 5h/TFmchJ1ZNSaY1OkoXQhsrdod9FVgSTAu26eyLSFIbU8+SAsYI1pRvtfKZrWglq3+U
 lpkA4da+W/OA0uRzw76zVhRNIDypfFGgb940AlFggN/wgHR4W2oZqyJOtoxei1d3PgbN
 85Vvo8zBzo/oT/TWb7wCcCHmamMdfARzz0cm2Rjwri00ha1ZOuVjBk7srTa7vRkkCeKT
 dGPmvaIx+z9GsA1o7xsGfFmX80JE0bqtgxFdVqyOYnYpqy7VbTsHRFDXhVy/gWpcvip2
 49mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761013948; x=1761618748;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MVIyQ0cytmkmUacvAZdhTRX6s7NWtXiYwmYFynMlLgU=;
 b=dV7XZbm5hbhLGe+Hc7enzZa9PhDxohjRRzf3Jlo/77Jd3ycaaT01kU/OKwp8ApuUWM
 uXLzzIflsGK/9ETqPjj//Apw3uhDIW6WeKlEe5zyrsKeD2tXydVVSE4rjzdW5512vJAg
 ve1HhxSIAm2yrhuqi8Tk/HNTlZ09TKJymhJ+zrBxohjnscijT4unIdIJOwd54sBB4Kiw
 yVX9sEVtDby1RaINA7tq/2ICHAUi2NckYiHrIPeyDU5ptt9nG1nnSMu0H/PszIwADFqA
 x4XhqmgleQPxeWE5ybBpx9pPEVpTj3BzPWfM8Bm5y/aSL4NJ8lpgm1MtZbKBzrjzjqWC
 X9Ig==
X-Forwarded-Encrypted: i=1;
 AJvYcCWqERDttq7Vd7Vkg7QLJguwb2kzh1N7+8lcf+d0FYDj27Ue7G/zvI63y7flNWizCd62VYiAJM59j32Y@nongnu.org
X-Gm-Message-State: AOJu0Yy6XpHj3wSmAfMEn+vTC+2mDEPqPfjJEwxoSgCqMheFhWcZaxhg
 U4twTLIqJVQ9OtIlBh83I6ewyPa6EwD5qPv1eT1fG6AI5DkeWJSNVSnuXGWi2oSIHYS83MPy2wE
 Qrv9yugR5VIgc+qw/LfbkpMX0ruA60io=
X-Gm-Gg: ASbGnctCvTI7eBBbOMcqHbPktwyq+uMyZ/HwVu9qSEGOEZ061po+nMEr1SY7Nn0ZG30
 +ndNjgjBupjNmZsX2HjX0xa+y4H8kbB9oPBtCiYas2BNfhC8+xDQWpsJjJ3oYXfRUXzZg8CQMkQ
 kRgqNJQobD4nkHtabqx/srhCEnXg6kg8PUt2uYYn9WI1Bh1r6SlDyNw1k+S7ibBS6qeIvhqOqgG
 jTVcX0aZtXBU4Iw7p1d5DRH+rhfJ6qRUnDD1Gag3LVpJyZQBl/djgwThKuuB9VcFpCzwN23
X-Google-Smtp-Source: AGHT+IFBy08DV2QPQJeJYM1mjEjEJFToAw28oPbRsoUERhd+0YYFcv9ebPNUSNDAj8FsUp2WwE0/zlR6NmLoxQubAuM=
X-Received: by 2002:a05:6402:2706:b0:63c:3efe:d986 with SMTP id
 4fb4d7f45d1cf-63c3efeedb0mr11912154a12.35.1761013947377; Mon, 20 Oct 2025
 19:32:27 -0700 (PDT)
MIME-Version: 1.0
References: <20250827205949.364606-1-peterx@redhat.com>
 <CAK3tnvKa=C-9qkOuyB+sZB8+o6YU0V+qaYheK-h9KBEumpyfBw@mail.gmail.com>
 <aObW9WrmWzTWs4N0@x1.local> <aPasigsOmIKvoqqm@x1.local>
 <20251021000854.5cd97864@penguin>
In-Reply-To: <20251021000854.5cd97864@penguin>
From: Zhang Chen <zhangckid@gmail.com>
Date: Tue, 21 Oct 2025 10:31:50 +0800
X-Gm-Features: AS18NWB9bp8280FtaD1fIBjxlCpE54xU_tZ7XWDjn8sfCXMZ7dB-dKz7VcEnX6M
Message-ID: <CAK3tnv+dREd=iNsZdK-Th9rrF1wRvxZrR=Pc+yE21V=2Bc=s+g@mail.gmail.com>
Subject: Re: [PATCH RFC 0/9] migration: Threadify loadvm process
To: Lukas Straub <lukasstraub2@web.de>
Cc: Peter Xu <peterx@redhat.com>, Hailiang Zhang <zhanghailiang@xfusion.com>,
 qemu-devel@nongnu.org, 
 "Dr . David Alan Gilbert" <dave@treblig.org>, Kevin Wolf <kwolf@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Yury Kotov <yury-kotov@yandex-team.ru>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Prasad Pandit <ppandit@redhat.com>, 
 Li Zhijian <lizhijian@fujitsu.com>, Juraj Marcin <jmarcin@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=zhangckid@gmail.com; helo=mail-ed1-x52b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Oct 21, 2025 at 6:09=E2=80=AFAM Lukas Straub <lukasstraub2@web.de> =
wrote:
>
> On Mon, 20 Oct 2025 17:41:30 -0400
> Peter Xu <peterx@redhat.com> wrote:
>
> > On Wed, Oct 08, 2025 at 05:26:13PM -0400, Peter Xu wrote:
> > > On Thu, Sep 04, 2025 at 04:27:39PM +0800, Zhang Chen wrote:
> > > > > I confess I didn't test anything on COLO but only from code obser=
vations
> > > > > and analysis.  COLO maintainers: could you add some unit tests to=
 QEMU's
> > > > > qtests?
> > > >
> > > > For the COLO part, I think remove the coroutines related code is OK=
 for me.
> > > > Because the original coroutine still need to call the
> > > > "colo_process_incoming_thread".
> > >
> > > Chen, thanks for the comment.  It's still reassuring.
> > >
> > > >
> > > > Hi Hailiang, any comments for this part?
> > >
> > > Any further comment on this series would always be helpful.
> > >
> > > It'll be also great if anyone can come up with a selftest for COLO.  =
Now
> > > any new migration features needs both unit test and doc to get merged=
.
> > > COLO was merged earlier so it doesn't need to, however these will be
> > > helpful for sure to make sure COLO won't be easily broken.
> >
> > Chen/Hailiang:
> >
> > I may use some help from COLO side.
> >
> > Just now, I did give it a shot with the current docs/COLO-FT.txt and it
> > didn't really work for me.
> >
> > The cmdlines I used almost followed the doc, however I changed a few
> > things.  For example, on secondary VM I added "file.locking=3Doff" for =
drive
> > "parent0" because otherwise the "nbd-server-add" command will fail taki=
ng
> > the lock and it won't ever boot.  Meanwhile I switched to socket netdev
> > from tap, in my case I only plan to run the COLO main routine, I hope
> > that's harmless too but let me know if it is a problem.
> >
> > So below are the final cmdlines I used..
> >
> > For primary:
> >
> > bin=3D~/git/qemu/bin/qemu-system-x86_64
> > $bin -enable-kvm -cpu qemu64,kvmclock=3Don \
> >      -m 512 -smp 1 -qmp stdio \
> >      -device piix3-usb-uhci -device usb-tablet -name primary \
> >      -netdev socket,id=3Dhn0,listen=3D127.0.0.1:10000 \
> >      -device rtl8139,id=3De0,netdev=3Dhn0 \
> >      -chardev socket,id=3Dmirror0,host=3D0.0.0.0,port=3D9003,server=3Do=
n,wait=3Doff \
> >      -chardev socket,id=3Dcompare1,host=3D0.0.0.0,port=3D9004,server=3D=
on,wait=3Don \
> >      -chardev socket,id=3Dcompare0,host=3D127.0.0.1,port=3D9001,server=
=3Don,wait=3Doff \
> >      -chardev socket,id=3Dcompare0-0,host=3D127.0.0.1,port=3D9001 \
> >      -chardev socket,id=3Dcompare_out,host=3D127.0.0.1,port=3D9005,serv=
er=3Don,wait=3Doff \
> >      -chardev socket,id=3Dcompare_out0,host=3D127.0.0.1,port=3D9005 \
> >      -object filter-mirror,id=3Dm0,netdev=3Dhn0,queue=3Dtx,outdev=3Dmir=
ror0 \
> >      -object filter-redirector,netdev=3Dhn0,id=3Dredire0,queue=3Drx,ind=
ev=3Dcompare_out \
> >      -object filter-redirector,netdev=3Dhn0,id=3Dredire1,queue=3Drx,out=
dev=3Dcompare0 \
> >      -object iothread,id=3Diothread1 \
> >      -object colo-compare,id=3Dcomp0,primary_in=3Dcompare0-0,secondary_=
in=3Dcompare1,outdev=3Dcompare_out0,iothread=3Diothread1 \
> >      -drive if=3Dide,id=3Dcolo-disk0,driver=3Dquorum,read-pattern=3Dfif=
o,vote-threshold=3D1,children.0.file.filename=3D./primary.qcow2,children.0.=
driver=3Dqcow2
> >
> > For secondary (testing locally, hence using 127.0.0.1 as primary_ip):
> >
> > bin=3D~/git/qemu/bin/qemu-system-x86_64
> > primary_ip=3D127.0.0.1
> > $bin -enable-kvm -cpu qemu64,kvmclock=3Don -m 512 -smp 1 -qmp stdio \
> >      -device piix3-usb-uhci -device usb-tablet -name secondary \
> >      -netdev socket,id=3Dhn0,connect=3D127.0.0.1:10000 \
> >      -device rtl8139,id=3De0,netdev=3Dhn0 \
> >      -chardev socket,id=3Dred0,host=3D$primary_ip,port=3D9003,reconnect=
-ms=3D1000 \
> >      -chardev socket,id=3Dred1,host=3D$primary_ip,port=3D9004,reconnect=
-ms=3D1000 \
> >      -object filter-redirector,id=3Df1,netdev=3Dhn0,queue=3Dtx,indev=3D=
red0 \
> >      -object filter-redirector,id=3Df2,netdev=3Dhn0,queue=3Drx,outdev=
=3Dred1 \
> >      -object filter-rewriter,id=3Drew0,netdev=3Dhn0,queue=3Dall \
> >      -drive if=3Dnone,id=3Dparent0,file.filename=3Dprimary.qcow2,driver=
=3Dqcow2,file.locking=3Doff \
> >      -drive if=3Dnone,id=3Dchilds0,driver=3Dreplication,mode=3Dsecondar=
y,file.driver=3Dqcow2,top-id=3Dcolo-disk0,file.file.filename=3Dsecondary-ac=
tive.qcow2,file.backing.driver=3Dqcow2,file.backing.file.filename=3Dseconda=
ry-hidden.qcow2,file.backing.backing=3Dparent0 \
> >      -drive if=3Dide,id=3Dcolo-disk0,driver=3Dquorum,read-pattern=3Dfif=
o,vote-threshold=3D1,children.0=3Dchilds0 \
> >      -incoming tcp:0.0.0.0:9998
> >
>
> Hi Peter,
> You have to use -incoming defer and enable x-colo on the
> secondary side before starting migration.
>
> And primary.qcow2 should be a separate image (with same content) for
> each qemu instance.

Yes, Lukas is right. Qemu can't allow 2 VM touch 1 image.
So, you can try to "cp primary.qcow2 secondary.qcow2",
then change the secondary side to " -drive
if=3Dnone,id=3Dparent0,file.filename=3Dsecondary.qcow2,driver=3Dqcow2,file.=
locking=3Doff
\"

Thanks
Chen

>
> Regards,
> Lukas
>
>
> > I started secondary, then primary, run the suggested QMP commands on
> > secondary first, then the bunch of QMP commands on primary.  I got belo=
w
> > error:
> >
> > x1:colo $ ./primary.sh
> > qemu-system-x86_64: -chardev socket,id=3Dcompare1,host=3D0.0.0.0,port=
=3D9004,server=3Don,wait=3Don: info: QEMU waiting for connection on: discon=
nected:tcp:0.0.0.0:9004,server=3Don
> > {"QMP": {"version": {"qemu": {"micro": 50, "minor": 1, "major": 10}, "p=
ackage": "v10.1.0-1513-g94586867df"}, "capabilities": ["oob"]}}
> > VNC server running on ::1:5900
> > {"execute":"qmp_capabilities"}
> > {"return": {}}
> > {"execute": "human-monitor-command", "arguments": {"command-line": "dri=
ve_add -n buddy driver=3Dreplication,mode=3Dprimary,file.driver=3Dnbd,file.=
host=3D127.0.0.2,file.port=3D9999,file.export=3Dparent0,node-name=3Dreplica=
tion0"}}
> > {"return": ""}
> > {"execute": "x-blockdev-change", "arguments":{"parent": "colo-disk0", "=
node": "replication0" } }
> > {"return": {}}
> > {"execute": "migrate-set-capabilities", "arguments": {"capabilities": [=
 {"capability": "x-colo", "state": true } ] } }
> > {"return": {}}
> > {"execute": "migrate", "arguments": {"uri": "tcp:127.0.0.2:9998" } }
> > {"return": {}}
> > {"timestamp": {"seconds": 1760996025, "microseconds": 483349}, "event":=
 "STOP"}
> >
> > x1:colo $ ./secondary.sh
> > {"QMP": {"version": {"qemu": {"micro": 50, "minor": 1, "major": 10}, "p=
ackage": "v10.1.0-1513-g94586867df"}, "capabilities": ["oob"]}}
> > VNC server running on ::1:5901
> > {"execute":"qmp_capabilities"}
> > {"return": {}}
> > {"execute": "migrate-set-capabilities", "arguments": {"capabilities": [=
 {"capability": "x-colo", "state": true } ] } }
> > {"return": {}}
> > {"execute": "nbd-server-start", "arguments": {"addr": {"type": "inet", =
"data": {"host": "0.0.0.0", "port": "9999"} } } }
> > {"return": {}}
> > {"execute": "nbd-server-add", "arguments": {"device": "parent0", "writa=
ble": true } }
> > {"return": {}}
> > {"timestamp": {"seconds": 1760996025, "microseconds": 695059}, "event":=
 "RESUME"}
> > qemu-system-x86_64: Can't receive COLO message: Input/output error
> > {"timestamp": {"seconds": 1760996025, "microseconds": 695369}, "event":=
 "COLO_EXIT", "data": {"mode": "secondary", "reason": "error"}}
> >
> > Do you know what I missed?  Or does it mean that COLO is broken?
> >
> > Meanwhile, do you know if COLO still being used by anyone?  I'm pretty =
sure
> > both Fabiano and myself are not looking after it..  I remember Dave use=
d to
> > try it, but it might be a long time ago too.
> >
> > Thanks,
> >
>

