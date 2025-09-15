Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A4EFCAC597
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 20:08:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyFTJ-0002Fj-SJ; Mon, 15 Sep 2025 16:06:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uyFTE-0002En-U6
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 16:06:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uyFSt-0006Md-Cv
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 16:06:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757966769;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ezBCrpSrBKZAj7K3nO6wbNjMJg/5GEYD4AnMHmv1tiI=;
 b=ifZ8MiQmVIG1/H3a6ifcSM4Agj9/yvKPe0TUZWVGc9pm39M2sLX9Qt8O6oHoe04CTxYPMe
 X4bWHd45f8ss0dBUgVSgP8cmmdNARcVoM5iLJYGqf5n2EAc5KiJABOOXqunwetOjJI1Woj
 0G4o2z0p44GRrursaYg64SBoQi0dAYA=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-567-tLWsZuKYMyOxUprBHWmWew-1; Mon, 15 Sep 2025 16:06:05 -0400
X-MC-Unique: tLWsZuKYMyOxUprBHWmWew-1
X-Mimecast-MFC-AGG-ID: tLWsZuKYMyOxUprBHWmWew_1757966765
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-829080582b4so354731385a.0
 for <qemu-devel@nongnu.org>; Mon, 15 Sep 2025 13:06:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757966765; x=1758571565;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ezBCrpSrBKZAj7K3nO6wbNjMJg/5GEYD4AnMHmv1tiI=;
 b=lJbRCEJKivWVOotFqbDUnkSpEcQ7hFwGeK6EYQkLSiKyu2PFfoeaNBltaHN6xRJ9W9
 pweH/X5iJDH+nUDPERVUmXlKSr03Hj0RbDrEJg7zKjTe77zfMeEZO7Q6Cg/32YPSxY2n
 maG8K8rQjrqtm9RsfeohsbhKa8DZpfqUju7Jgj0rLwk7mBV8za7FZYrZ3WFOTkL33s8i
 8MdS1+xmgVBYhoN6dojAQ5Xum0TV8FOZ7vmMlfjC4YKZVPgBOR5aF9j/7tbzVSaKDFvr
 WLxURyKfubGocfO5xcZZisTU4lmjPfXaulcs7j2tmzXcxP/cajX9hvRRqkjVZQ7J8CkD
 j5tw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQC8JEBRm0HDC5b6K5zLZKhEs4+rZ5ERYgfMTqGEt/vC7/T03LDsFAfGsQEScxsPRPClHzu1cM3ieo@nongnu.org
X-Gm-Message-State: AOJu0YwQca2KsuVXDrxMO1PER/RWZb5rUcXAgGYzDru339prBtd4npDD
 E9cZppZZ38fFS3qlJ2jNdeNM0qBUmbOEaZ//xjU0qHrFCvmfnnk6e3iOJRgSnlmOXKbQrOLOung
 1YQ9NhgbMm+lsLAPbILUGU1K/i4QkoqmqUosn+utlOlPL8fl3mN6UyTeh
X-Gm-Gg: ASbGncv/KiHO7PM9aVuxg9J7odQGnaL5fLHXbuhOrNhrqESrwYFQDHI4kzQyQ82Wztn
 rDlvHYmZrBv0PrvWeIc/qsLUEpluvR12E5nAO4N0DdSBdwAPiQ7JhswXegKZTKaQIkzFqNb0Jdv
 YC0QOfHZTAryhBQI+Ha75u1dtHWo1o2j3CmEq4vwLfkmaxIBXiwWSTBUWFb71dC44/AesSuKhof
 30BA6tUB1Jzl+JlERl23JSpvTfx1Ma9BleqCrTwB6OtrpyT7wJj6EJt1aELpWcHHzlLOWMY2nM+
 XDo0eM5b4RQaFMGLCXic4Bq7O4OU3BM1
X-Received: by 2002:a05:620a:25d4:b0:80a:436f:18e6 with SMTP id
 af79cd13be357-82400ffa501mr1560005285a.70.1757966765201; 
 Mon, 15 Sep 2025 13:06:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0QyII3D/Jp0M0tnhxnfsa0mzr+mOwivZXBqcEVMHCYeEcJgZOgJAYiE4ET+lv8UMxzlBDDA==
X-Received: by 2002:a05:620a:25d4:b0:80a:436f:18e6 with SMTP id
 af79cd13be357-82400ffa501mr1559999485a.70.1757966764494; 
 Mon, 15 Sep 2025 13:06:04 -0700 (PDT)
Received: from x1.local ([174.89.135.121]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-820ce19df73sm818855885a.51.2025.09.15.13.06.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Sep 2025 13:06:03 -0700 (PDT)
Date: Mon, 15 Sep 2025 16:05:52 -0400
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Juraj Marcin <jmarcin@redhat.com>, qemu-devel@nongnu.org,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH] migration: Apply migration specific keep-alive defaults
 to inet socket
Message-ID: <aMhxoEQqckG_p9Tq@x1.local>
References: <20250909150127.1494626-1-jmarcin@redhat.com>
 <aMBDIwKDxTVrBJBQ@redhat.com> <aMCjGVUiM3MY-RM3@x1.local>
 <aMEkY3N9ITwH_Y8Z@redhat.com> <aMGpHBGth05JY2hl@x1.local>
 <aMPz0WFmstNmKBQc@redhat.com> <aMQ19NmgFkLs8jkA@x1.local>
 <aMhZn-fbq67WQX8u@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aMhZn-fbq67WQX8u@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

On Mon, Sep 15, 2025 at 07:23:27PM +0100, Daniel P. Berrangé wrote:
> On Fri, Sep 12, 2025 at 11:02:12AM -0400, Peter Xu wrote:
> > On Fri, Sep 12, 2025 at 11:20:01AM +0100, Daniel P. Berrangé wrote:
> > > On Wed, Sep 10, 2025 at 12:36:44PM -0400, Peter Xu wrote:
> > > > On Wed, Sep 10, 2025 at 08:10:57AM +0100, Daniel P. Berrangé wrote:
> > > > > On Tue, Sep 09, 2025 at 05:58:49PM -0400, Peter Xu wrote:
> > > > > > On Tue, Sep 09, 2025 at 04:09:23PM +0100, Daniel P. Berrangé wrote:
> > > > > > > On Tue, Sep 09, 2025 at 05:01:24PM +0200, Juraj Marcin wrote:
> > > > > > > > From: Juraj Marcin <jmarcin@redhat.com>
> > > > > > > > 
> > > > > > > > Usual system defaults for TCP keep-alive options are too long for
> > > > > > > > migration workload. On Linux, a TCP connection waits idle for 2 hours
> > > > > > > > before it starts checking if the connection is not broken.
> > > > > > > > 
> > > > > > > > Now when InetSocketAddress supports keep-alive options [1], this patch
> > > > > > > > applies migration specific defaults if they are not supplied by the user
> > > > > > > > or the management software. With these defaults, a migration TCP stream
> > > > > > > > waits idle for 1 minute and then sends 5 TCP keep-alive packets in 30
> > > > > > > > second interval before considering the connection as broken.
> > > > > > > > 
> > > > > > > > System defaults can be still used by explicitly setting these parameters
> > > > > > > > to 0.
> > > > > > > 
> > > > > > > IMHO this is not a good idea. This is a very short default, which
> > > > > > > may be fine for the scenario where your network conn is permanently
> > > > > > > dead, but it is going to cause undesirable failures when the network
> > > > > > > conn is only temporarily dead.
> > > > > > > 
> > > > > > > Optimizing defaults for temporary outages is much more preferrable
> > > > > > > as that maximises reliability of migration. In the case of permanent
> > > > > > > outages, it is already possible to tear down the connection without
> > > > > > > waiting for a keep-alive timeout, and liveliness checks can also be
> > > > > > > perform by the mgmt app at a higher level too. The TCP keepalives
> > > > > > > are just an eventual failsafe, and having those work on a long
> > > > > > > timeframe is OK.
> > > > > > 
> > > > > > For precopy it looks fine indeed, because migrate_cancel should always work
> > > > > > on src if src socket hanged, and even if dest QEMU socket hanged, it can
> > > > > > simply be killed if src QEMU can be gracefully cancelled and rolled back to
> > > > > > RUNNING, disregarding the socket status on dest QEMU.
> > > > > > 
> > > > > > For postcopy, we could still use migrate_pause to enforce src shutdown().
> > > > > > Initially I thought we have no way of doing that for dest QEMU, but I just
> > > > > > noticed two years ago I added that to dest QEMU for migrate_paused when
> > > > > > working on commit f8c543e808f20b..  So looks like that part is covered too,
> > > > > > so that if dest QEMU socket hanged we can also kick it out.
> > > > > > 
> > > > > > I'm not 100% sure though, on whether shutdown() would always be able to
> > > > > > successfully kick out the hanged socket while the keepalive is ticking.  Is
> > > > > > it guaranteed?
> > > > > 
> > > > > I don't know about shutdown(), but close() certainly works. If shutdown()
> > > > > is not sufficient, then IMHO the migration code would need the ability to
> > > > > use close() to deal with this situation.
> > > > > 
> > > > > 
> > > > > > I also am not sure if that happens, whether libvirt would automatically do
> > > > > > that, or provide some way so the user can trigger that.  The goal IIUC here
> > > > > > is we shouldn't put user into a situation where the migration hanged but
> > > > > > without any way to either cancel or recover.  With the default values Juraj
> > > > > > provided here, it makes sure the hang won't happen more than a few minutes,
> > > > > > which sounds like a sane timeout value.
> > > > > 
> > > > > Sufficient migration QMP commands should exist to ensure migration can
> > > > > always be cancelled. Short keepalive timeouts should not be considered
> > > > > a solution to any gaps in that respect.
> > > > > 
> > > > > Also there is yank, but IMHO apps shouldn't have to rely on yank - I see
> > > > > yank as a safety net for apps to workaround limitations in QEMU.
> > > > 
> > > > The QMP facility looks to be all present, which is migrate-cancel and
> > > > migrate-pause mentioned above.
> > > > 
> > > > For migrate_cancel (of precopy), is that Ctrl-C of "virsh migrate"?
> > > > 
> > > > Does libvirt exposes migrate_pause via any virsh command?  IIUC that's the
> > > > only official way of pausing a postcopy VM on either side.  I also agree we
> > > > shouldn't make yank the official tool to use.
> > > 
> > > virsh will call virDomainAbortJob when Ctrl-C is done to a 'migrate'
> > > command.
> > > 
> > > virDomainAbortJob will call migrate-cancel for pre-copy, or
> > > 'migrate-pause' for post-copy.
> > 
> > Would it call "migrate-pause" on both sides?
> 
> Not 100% sure, but with virDomainAbortJob I think libvirt only calls
> migrate-pause on the source host.
> 
> > I believe the problem we hit was, when during postcopy and the NIC was
> > misfunctioning, src fell into postcopy-paused successfully but dest didn't,
> > stuck in postcopy-active.
> 
> If something has interrupted src<->dst host comms for QEMU it may well
> impact libvirt <-> libvirt comms too, unless migration was being done
> over a separate NIC than the mgmt LAN.  IOW, it may be impossible for

Do you know what's the common setup?  Do they normally share the network or
not?

> libvirt to call migrate-pause on both sides, at least not until the
> NIC problem has been resolved.
> 
> > We'll want to make sure both sides to be kicked into paused stage to
> > recover.  Otherwise dest can hang in the stage for hours until the watchdog
> > timeout triggers.
> 
> Once the network problem has been resolved, then it ought to be possible
> to get libvirt to issue 'migrate-pause' on both hosts, and thus be able
> to recover.
> 
> Possibly the act of starting migration recovery in libvirt should attempt
> to issue 'migrate-pause' to cleanup the previously running migration if
> it is still in the stuck state.

Yes we can do that.  But normally libvirt will need to monitor the
migration process, migration-pause won't be initiated until it thinks the
migration is interrupted.  We'll need to check whether it only relies on
src QEMU status, or both sides.

If we do that, libvirt will need to monitor migration status on both sides,
no matter which side fell into a postcopy-paused, libvirt should kick out
the other side.  That sounds OK.

Said that, maybe we should still provide an explicit way to pause migration
on both sides.  For example, I'm not sure whether the timeout could happen
on both sides at the same time without being kicked out, so that both sides
are postcopy-active but in reality the network is already unplugged.  In
that case we'd want to have libvirt be able to provide a "virsh" command to
pause both sides at least when the mgmt network is still working, and when
the user knows it's stuck (instead of waiting for hours)?

> 
> > 
> > > 
> > > 
> > > > OTOH, the default timeouts work without changing libvirt, making sure the
> > > > customers will not be stuck in a likely-failing network for hours without
> > > > providing a way to properly detach and recover when it's wanted.
> > > 
> > > "timeouts work" has the implicit assumpton that the only reason a
> > > timeout will fire is due to a unrecoverable situation. IMHO that
> > > assumption is not valid.
> > 
> > I agree adjusting timeout is not the best.
> > 
> > If we can have solid way to kick two sides out, I think indeed we don't
> > need to change the timeout.
> > 
> > If not, we may still need to provide a way to allow user to try continue
> > when the user found that the network is behaving abnormal.
> > 
> > Here adjusting timeout is slightly better than any adhoc socket timeout
> > that we'll adjust: it's the migration timeout, and we only have two cases:
> > (1) precopy, which is ok to fail and retried, (2) postcopy, which is also
> > ok to fail and recovered.
> 
> Fail & retry/recover is not without cost / risk though. Users can have
> successful migrations that are many hours long when dealing with big
> VMs. IOW, returning to the start of pre-copy could be a non-trivial
> time delay.
> 
> Consider if the reason for the migration is to evacuate workloads off
> a host that is suffering technical problems. It could well be that
> periodic unexpected network outages are what is triggering the need
> to evacuate workloads. If we timeout a migration with keepalives they
> may never be able to get through a migration op quickly enough, or
> they can be delayed such that the host has a fatal error loosing the
> workload before the retried migration is complete.
> 
> IMHO, once a migration has been started we should not proactively
> interrupt that with things like keepalives, unless the admin made a
> concious decision they wanted that behaviour enabled.

For postcopy, we don't have such cost.  Postcopy pause will keep both QEMUs
persist their data sent / received, then when recover it'll handshake once
more to synchronize the states between two sides.  They'll continue the
migration from the previous state, not completely retransfer but only diff.

In this case, normally it's the dest QEMU that has less data, IOW, it's
possible something "sent" from the src QEMU didn't get "received" on
destination but lost on the wire.  Hence what we do is synchronizing the
received bitmap from dest to src so src QEMU knows what to re-transmit.

Thanks,

-- 
Peter Xu


