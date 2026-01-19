Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A1A7D2ECF6
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 22:34:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhxoY-0000ET-OM; Mon, 19 Jan 2026 17:33:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vhxoX-0000Dg-8g
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 17:33:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vhxoU-0000sj-FK
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 17:33:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768862012;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ieSkrBAwGEnGc7B2Y+QqEEl/2IH1biF9PPbJ3s/8Y2U=;
 b=hzau3Qd2BywfsSMzV32C+WUYm7ngM+z6O1J39rSrYpYil4q0CKvJpqJxge8ztqVLmUGrEO
 qRERpyKRkntNNzp7+8T2HsnNyuya1A31sDryVbmC8ABnlzHCyaV3Vgb9FzPJ7hQifFIBIN
 ohSmzvnedJrRc2eX9aGKwEgghzDeOXE=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-146-g5vTVujzN3uRxZ5dUYWkrA-1; Mon, 19 Jan 2026 17:33:28 -0500
X-MC-Unique: g5vTVujzN3uRxZ5dUYWkrA-1
X-Mimecast-MFC-AGG-ID: g5vTVujzN3uRxZ5dUYWkrA_1768862008
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-8c6a4c50fe5so41194185a.3
 for <qemu-devel@nongnu.org>; Mon, 19 Jan 2026 14:33:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768862008; x=1769466808; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ieSkrBAwGEnGc7B2Y+QqEEl/2IH1biF9PPbJ3s/8Y2U=;
 b=gIgowbMT4yCYj3PvLUkowcO55i3JYbUrdwSbxww4j5qiEAJVeDhHSx11jG8O1XabMp
 +uzeMJhSNMyA6Llgu+gttHxWkiAeA91DTUw8x7ZK7uVluA2QEK2rdD7/s3USnmCgrDzk
 8zD6KjExTNBdG0MOYH/2Pp8GhMjpvooAaPWpY6K+kWAKBQgZ8LSKyKhuUu33dsiDohxK
 bXAYq9VIezax+yImcx2w08oNMMkaUWnyGEGUVf+99p5fKkJ82mj+buulX8lvXRF22mV6
 UI5vulISF4+QG6yk7sMs4ztYWXFw8LRDMI01ypMX4yE0dQ/OeI6mHTSae662ukPFVCrH
 nkag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768862008; x=1769466808;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ieSkrBAwGEnGc7B2Y+QqEEl/2IH1biF9PPbJ3s/8Y2U=;
 b=Owv6jnqFC/JXMPWJEWulS9XCNB2h1KKo2BfK40qTyRQf/zEQoroWEwIaMkk0PQl1Fi
 hA96DljNWbCmNMeJ9z4WNGQEukHgeieQLhQK4rbqfkxxbjY02bcb+ZoijKinxLvHzNiJ
 16tDrcAzsRIMjhmebr/w+qrPsb2Wj3qZb8hXmyU4mw+Ci+mSKLXywSeckQrWKH0KswAp
 /Ulh/CKNNXDbYBx+SnLyWHQK1GvBs4AqnTaC3ScFuUu05AHJcCNQqO5NdDsGI5Vzcb0q
 LslYVsg1GTDHp0vfVOAr9OvKKRDcMLkqf0EAqS5BCjUhKNDG5cD6//TaEf41Yj5IEw8u
 eQaw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXhb9pmVU31MqzTB0wHP+xNB8l45piUdMO/yEiuJKrFlSbonL3Cr+Vdbg/68M5jLkkQ6iIRKuSSc5Oi@nongnu.org
X-Gm-Message-State: AOJu0YzVJUIl6X8pZd0hiMcwg1FPII2XypsNwG6JkwVVDnjDMFRer+qt
 vCgAWmvegomcXdlJ8dG1FU3RqmmXVc/8OnvlPeRC6n9JqopI1CIUrJjra1fBAqfVFSGuER5C32P
 pwm7iylZjEJ0CxjU5CXvoIUJvd6eo2RaG1BDw2svWqHyAjrV0OeA0tka+
X-Gm-Gg: AY/fxX7lpOB4LnV/AzqpVtddkLkJ+wdHkwys7d46Y8qWsXuzlsYbqcXirls2TYDHK1h
 U+dS0Q0/2x8UpV/UsbKfrXkCinY0/LN1pVs/nCaFR1EsLN+gwXYuyqafevot3ikemLdiBW0AfFu
 KgckNzttGQMNDooH6aVdCFLmU2gN5apuVz/PPDeQMMtohDDITlOeoo7iGyb+leQPCFdNiqTj6jQ
 yScR6AxCtgJMDrb0L+Rh6FKbSWexI9y8uVlfgX0TdbNERvr026Psze5fgdoAoGHKSoekdWdmDRn
 TWenMhFd7s1RHMqdWvU/uSEFwi/edvpy3rQi1GnkDMB8fEujcuC+L/mm/oEJRPkkVeym+P63gZB
 dpQg=
X-Received: by 2002:a05:620a:1031:b0:8c2:462e:cb05 with SMTP id
 af79cd13be357-8c6a6963248mr1516448585a.85.1768862008077; 
 Mon, 19 Jan 2026 14:33:28 -0800 (PST)
X-Received: by 2002:a05:620a:1031:b0:8c2:462e:cb05 with SMTP id
 af79cd13be357-8c6a6963248mr1516446185a.85.1768862007485; 
 Mon, 19 Jan 2026 14:33:27 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8c6a72642fdsm863431985a.46.2026.01.19.14.33.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Jan 2026 14:33:26 -0800 (PST)
Date: Mon, 19 Jan 2026 17:33:25 -0500
From: Peter Xu <peterx@redhat.com>
To: Lukas Straub <lukasstraub2@web.de>
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>, qemu-devel@nongnu.org,
 Juraj Marcin <jmarcin@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Markus Armbruster <armbru@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 =?utf-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>,
 Juan Quintela <quintela@trasno.org>,
 Zhang Chen <zhangckid@gmail.com>, zhanghailiang@xfusion.com,
 Li Zhijian <lizhijian@fujitsu.com>, Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 1/3] migration/colo: Deprecate COLO migration framework
Message-ID: <aW6xNcsz3RIqHeE5@x1.local>
References: <20260114195659.2543649-1-peterx@redhat.com>
 <20260114195659.2543649-2-peterx@redhat.com>
 <aWf4i7EOXtpAljGX@x1.local> <20260115224929.616aab85@penguin>
 <aWlso1w39cQnEh2t@x1.local> <aWlxY9TWGT1aaMJz@gallifrey>
 <aWl6ixQpHaMJhV_E@x1.local> <20260117204913.584e1829@penguin>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260117204913.584e1829@penguin>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.016,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Sat, Jan 17, 2026 at 08:49:13PM +0100, Lukas Straub wrote:
> On Thu, 15 Jan 2026 18:38:51 -0500
> Peter Xu <peterx@redhat.com> wrote:
> 
> > On Thu, Jan 15, 2026 at 10:59:47PM +0000, Dr. David Alan Gilbert wrote:
> > > * Peter Xu (peterx@redhat.com) wrote:  
> > > > On Thu, Jan 15, 2026 at 10:49:29PM +0100, Lukas Straub wrote:  
> > > > > Nack.
> > > > > 
> > > > > This code has users, as explained in my other email:
> > > > > https://lore.kernel.org/qemu-devel/20260115224516.7f0309ba@penguin/T/#mc99839451d6841366619c4ec0d5af5264e2f6464  
> > > > 
> > > > Please then rework that series and consider include the following (I
> > > > believe I pointed out a long time ago somewhere..):
> > > >   
> > >   
> > > > - Some form of justification of why multifd needs to be enabled for COLO.
> > > >   For example, in your cluster deployment, using multifd can improve XXX
> > > >   by YYY.  Please describe the use case and improvements.  
> > > 
> > > That one is pretty easy; since COLO is regularly taking snapshots, the faster
> > > the snapshoting the less overhead there is.  
> > 
> > Thanks for chiming in, Dave.  I can explain why I want to request for some
> > numbers.
> > 
> > Firstly, numbers normally proves it's used in a real system.  It's at least
> > being used and seriously tested.
> > 
> > Secondly, per my very limited understanding to COLO... the two VMs in most
> > cases should be in-sync state already when both sides generate the same
> > network packets.
> > 
> > Another sync (where multifd can start to take effect) is only needed when
> > there're packets misalignments, but IIUC it should be rare.  I don't know
> > how rare it is, it would be good if Lukas could introduce some of those
> > numbers in his deployment to help us understand COLO better if we'll need
> > to keep it.
> 
> It really depends on the workload and if you want to tune for
> throughput or latency.

Thanks for all the answers from all of you.

If we decide to keep COLO, looks like I'll have no choice but understand it
better, as long as it still has anything to do with migration..  I'll leave
some more questions / comments at the end.

> 
> You need to do a checkpoint eventually and the more time passes between
> checkpoints the more dirty memory you have to transfer during the
> checkpoint.
> 
> Also keep in mind that the guest is stopped during checkpoints. Because
> even if we continue running the guest, we can not release the mismatched
> packets since that would expose a state of the guest to the outside
> world that is not yet replicated to the secondary.

Yes this makes sense.  However it is also the very confusing part of COLO.

When I said "I was expecting migration to not be the hot path", one reason
is I believe COLO checkpoint (or say, when migration happens) will
introduce a larger downtime than normal migration, because this process
transfers RAM with both VMs stopped.

You helped explain why that large downtime is needed, thanks.  However then
it means either (1) packet misalignment, or (2) periodical timer kickoff,
either of them will kickoff checkpoint..

I don't know if COLO services care about such relatively large downtime,
especially it is not happening once, but periodically for every tens of
seconds at least (assuming when periodically then packet misalignment is
rare).

> 
> So the migration performance is actually the most important part in
> COLO to keep the checkpoints as short as possible.

IIUC when a heartbeat will be lost on PVM _during_ sync checkpoints, then
SVM can only rollback to the last time checkpoint.  Would this be good
enough in reality?  It means if there's a TCP transaction then it may broke
anyway.  x-checkpoint-delay / periodic checkpoints definitely make this
more possible to happen.

> 
> I have quite a few more performance and cleanup patches on my hands,
> for example to transfer dirty memory between checkpoints.
> 
> > 
> > IIUC, the critical path of COLO shouldn't be migration on its own?  It
> > should be when heartbeat gets lost; that normally should happen when two
> > VMs are in sync.  In this path, I don't see how multifd helps..  because
> > there's no migration happening, only the src recording what has changed.
> > Hence I think some number with description of the measurements may help us
> > understand how important multifd is to COLO.
> > 
> > Supporting multifd will cause new COLO functions to inject into core
> > migration code paths (even if not much..). I want to make sure such (new)
> > complexity is justified. I also want to avoid introducing a feature only
> > because "we have XXX, then let's support XXX in COLO too, maybe some day
> > it'll be useful".
> 
> What COLO needs from migration at the low level:
> 
> Primary/Outgoing side:
> 
> Not much actually, we just need a way to incrementally send the
> dirtied memory and the full device state.
> Also, we ensure that migration never actually finishes since we will
> never do a switchover. For example we never set
> RAMState::last_stage with COLO.
> 
> Secondary/Incoming side:
> 
> colo cache:
> Since the secondary always needs to be ready to take over (even during
> checkpointing), we can not write the received ram pages directly to
> the guest ram to prevent having half of the old and half of the new
> contents.
> So we redirect the received ram pages to the colo cache. This is
> basically a mirror of the primary side ram.
> It also simplifies the primary side since from it's point of view it's
> just a normal migration target. So primary side doesn't have to care
> about dirtied pages on the secondary for example.
> 
> Dirty Bitmap:
> With COLO we also need a dirty bitmap on the incoming side to track
> 1. pages dirtied by the secondary guest
> 2. pages dirtied by the primary guest (incoming ram pages)
> In the last step during the checkpointing, this bitmap is then used
> to overwrite the guest ram with the colo cache so the secondary guest
> is in sync with the primary guest.
> 
> All this individually is very little code as you can see from my
> multifd patch. Just something to keep in mind I guess.
> 
> 
> At the high level we have the COLO framework outgoing and incoming
> threads which just tell the migration code to:
> Send all ram pages (qemu_savevm_live_state()) on the outgoing side
> paired with a qemu_loadvm_state_main on the incoming side.
> Send the device state (qemu_save_device_state()) paired with writing
> that stream to a buffer on the incoming side.
> And finally flusing the colo cache and loading the device state on the
> incoming side.
> 
> And of course we coordinate with the colo block replication and
> colo-compare.

Thank you.  Maybe you should generalize some of the explanations and put it
into docs/devel/migration/ somewhere.  I think many of them are not
mentioned in the doc on how COLO works internally.

Let me ask some more questions while I'm reading COLO today:

- For each of the checkpoint (colo_do_checkpoint_transaction()), COLO will
  do the following:

    bql_lock()
    vm_stop_force_state(RUN_STATE_COLO)     # stop vm
    bql_unlock()

    ...
  
    bql_lock()
    qemu_save_device_state()                # into a temp buffer fb
    bql_unlock()

    ...

    qemu_savevm_state_complete_precopy()    # send RAM, directly to the wire
    qemu_put_buffer(fb)                     # push temp buffer fb to wire

    ...

    bql_lock()
    vm_start()                              # start vm
    bql_unlock()

  A few questions that I didn't ask previously:

  - If VM is stopped anyway, why putting the device states into a temp
    buffer, instead of using what we already have for precopy phase, or
    just push everything directly to the wire?

  - Above operation frequently releases BQL, why is it needed?  What
    happens if (within the window where BQL released) someone invoked QMP
    command "cont" and causing VM to start? Would COLO be broken with it?
    Should we take BQL for the whole process to avoid it?

- Does colo_cache has an limitation, or should we expect SVM to double
  consume the guest RAM size?  As I didn't see where colo_cache will be
  released during each sync (e.g. after colo_flush_ram_cache).  I am
  expecting over time SVM will have most of the pages touched, then the
  colo_cache can consume the same as guest mem on SVM.

Thanks,

-- 
Peter Xu


