Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3D37D5B84C
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 16:12:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVBBR-00042E-HT; Mon, 15 Dec 2025 11:12:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vVBBO-00041X-QB
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 11:12:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vVBBN-0004SL-09
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 11:12:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765815139;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zuP2AlwgFLWSgCtjAnCdHCvFA8tVYqyy8jLOPwnaRSo=;
 b=d4Xp4s5603Epxm6d8JqpBMYKESM5wqYD9tkC+QBFiZejQLwXfaVVWJgZaAXA/bVxMOMj2g
 0mXJSQI7+9afVhlL6T7YXlcr3c4JGVHKoZbymwq5G523SXLa1+ddT5tvQ25gH1T3MIV/nD
 K/FfObNQ/Mairtmz7D33RqAxvHYv98s=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-CXHV5qMkM9CSGW25hatosw-1; Mon, 15 Dec 2025 11:12:18 -0500
X-MC-Unique: CXHV5qMkM9CSGW25hatosw-1
X-Mimecast-MFC-AGG-ID: CXHV5qMkM9CSGW25hatosw_1765815138
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-88a2e9e09e6so53683636d6.2
 for <qemu-devel@nongnu.org>; Mon, 15 Dec 2025 08:12:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765815138; x=1766419938; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=zuP2AlwgFLWSgCtjAnCdHCvFA8tVYqyy8jLOPwnaRSo=;
 b=SS8QYBmbuiCgs2xOXQc9hDpZhIuiLnT/3Ag5IYk+yrsXhIenrkB0J/tHgHjQ3ZKk1R
 h1dRITHhc3Vf6uMpzpUm5qeXlqwqNpzxIorjEgut5evJfwLcgu/YTws2rupEhe0e0Dga
 SCpKFL3WDDI/oISvWUgyeVIcSBcptje5vX+tY+jbGzvmW5OYDcY8RbIK8hmk7bm1MZ/t
 w2ouoXh1L2i2Uk394FcBtGTjP8pHNU0c7bxh1x5l3KD+p02u6L7K9U6WXUWyulHLBRje
 7VgOHWrUOkknuHTe0FRAkqzPuk7ZNwSWgZM/0EeMmJWanybLyRvZOz2ESaynTRUqzAC1
 soAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765815138; x=1766419938;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zuP2AlwgFLWSgCtjAnCdHCvFA8tVYqyy8jLOPwnaRSo=;
 b=nhHl99PsF9iPdMLSBfugc4fSJnkSq70UHKQfK4wkZxmongfGwlTO+5t0PKENH90XJ+
 WFJAadr27bLAEwc60GWO+EMHKav+c4glvde41LJagrM6ZYidrVOHYdyI6IwBJjpOuXFs
 u1M+8qt/4Cm7J74ADioXU2yu7l2scNbaFg8ynCfhLRI29eocJovoV/ErT8fclE0L5IKo
 YHjassWRwYDzOj9nIiDvO/hP8qbA9RHdTzhHoOu9+z23Fs8EmLr3i8e4avPmSusP/Ams
 AHaZzAHtQL3hMaJ5VWZF1X8fPjoaUPpFMhWNNKTSF/LfshA/mOCE+fo2OwwxWaxnaj0M
 YHIg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4Khhk6bojuVuz9fmzWP2eEKljPfuCT+GRqEnHjVxy+LlwCjiDhrZHQcdjQ7gEc6RYOPcC12LKi94n@nongnu.org
X-Gm-Message-State: AOJu0YzSt4wcRUK+0DX8YFaC/EUvc9ElMvrYmGpQA1OzONOG4QUaAAOX
 FfJwjdDFPzEYeEw6AeKd6M7exrwAKQDJhEqcU8ZhhyD1MyiUUqj6Sh0tD+onZubGd1ykDZZZmoI
 IiTfgVC0eKsBhPpDUtxT5/TAYrUPWuq+jcpYRacde6Kl54xoF3MXA0OQ1
X-Gm-Gg: AY/fxX6uKEB9//6CtWPjG9kejtFbX+RumRhU8gNiwks6drH1ghGEo6OllN8pV3mStcv
 urfL81WBgAZIwOpnaCQLXMndx1JjSH4GQ1UBHE8Pgb2VkF6/Lzdx+0mXQAqosC1m+Pq6Dy+ALSm
 t4TsbQDMwEXSXd8205sQVOnhaYwnXm8cJ5xaem6fV+C/a50MpjG+noAh+VqyAe2LRjwwyOYs3dE
 GEIbx9AT37GA7Lp/myPS/bO2B5DvREvhtLdBkcO88NBKPwS2xQ7kzA+X80sjwFU3szoiP83qmoM
 oo1Dw79tOW0T85LpcZVryy+Sjs6orlstkA6Ft8THvshRmsoPIGlSCL31kVw1l4PD39YWx+yeHoR
 jMz4=
X-Received: by 2002:a05:622a:59c4:b0:4ed:b82b:1984 with SMTP id
 d75a77b69052e-4f1d04c53b2mr163308541cf.30.1765815137417; 
 Mon, 15 Dec 2025 08:12:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG9yGKuC7enuQOdgMjU6i6wLGQHKEWIgZthCp1PeufGOD3HZGj1hAvg88/HqFjq2v0M1UG7TQ==
X-Received: by 2002:a05:622a:59c4:b0:4ed:b82b:1984 with SMTP id
 d75a77b69052e-4f1d04c53b2mr163307551cf.30.1765815136765; 
 Mon, 15 Dec 2025 08:12:16 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4f1bd70a4adsm94336821cf.32.2025.12.15.08.12.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Dec 2025 08:12:16 -0800 (PST)
Date: Mon, 15 Dec 2025 11:12:15 -0500
From: Peter Xu <peterx@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH] migration: Fix a possible crash when halting a guest
 during migration
Message-ID: <aUAzXwM5iQnscHcc@x1.local>
References: <20251208135101.271417-1-thuth@redhat.com>
 <20251208144525.GA1341938@fedora> <87jyyxkna0.fsf@suse.de>
 <5b510f3b-796a-45fb-a63f-e87b02dace61@redhat.com>
 <87jyyrv1br.fsf@suse.de> <aUAQNaA_sW8hxW2Y@redhat.com>
 <e62e8105-7add-45ed-afc2-9d6b1403b135@redhat.com>
 <aUApJ23dL8JuAayW@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aUApJ23dL8JuAayW@redhat.com>
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

On Mon, Dec 15, 2025 at 04:28:39PM +0100, Kevin Wolf wrote:
> Am 15.12.2025 um 16:11 hat Thomas Huth geschrieben:
> > On 15/12/2025 14.42, Kevin Wolf wrote:
> > > Am 12.12.2025 um 22:26 hat Fabiano Rosas geschrieben:
> > > > Thomas Huth <thuth@redhat.com> writes:
> > > > 
> > > > > On 08/12/2025 16.26, Fabiano Rosas wrote:
> > > > > > Stefan Hajnoczi <stefanha@redhat.com> writes:
> > > > > > 
> > > > > > > On Mon, Dec 08, 2025 at 02:51:01PM +0100, Thomas Huth wrote:
> > > > > > > > From: Thomas Huth <thuth@redhat.com>
> > > > > > > > 
> > > > > > > > When shutting down a guest that is currently in progress of being
> > > > > > > > migrated, there is a chance that QEMU might crash during bdrv_delete().
> > > > > > > > The backtrace looks like this:
> > > > > > > > 
> > > > > > > >    Thread 74 "mig/src/main" received signal SIGSEGV, Segmentation fault.
> > > > > > > > 
> > > > > > > >    [Switching to Thread 0x3f7de7fc8c0 (LWP 2161436)]
> > > > > > > >    0x000002aa00664012 in bdrv_delete (bs=0x2aa00f875c0) at ../../devel/qemu/block.c:5560
> > > > > > > >    5560	        QTAILQ_REMOVE(&graph_bdrv_states, bs, node_list);
> > > > > > > >    (gdb) bt
> > > > > > > >    #0  0x000002aa00664012 in bdrv_delete (bs=0x2aa00f875c0) at ../../devel/qemu/block.c:5560
> > > > > > > >    #1  bdrv_unref (bs=0x2aa00f875c0) at ../../devel/qemu/block.c:7170
> > > > > > > >    Backtrace stopped: Cannot access memory at address 0x3f7de7f83e0
> > > > > > > > 
> > > > > > 
> > > > > > How does the migration thread reaches here? Is this from
> > > > > > migration_block_inactivate()?
> > > > > 
> > > > > Unfortunately, gdb was not very helpful here (claiming that it cannot access
> > > > > the memory and stack anymore), so I had to do some printf debugging. This is
> > > > > what seems to happen:
> > > > > 
> > > > > Main thread: qemu_cleanup() calls  migration_shutdown() -->
> > > > > migration_cancel() which signals the migration thread to cancel the migration.
> > > > > 
> > > > > Migration thread: migration_thread() got kicked out the loop and calls
> > > > > migration_iteration_finish(), which tries to get the BQL via bql_lock() but
> > > > > that is currently held by another thread, so the migration thread is blocked
> > > > > here.
> > > > > 
> > > > > Main thread: qemu_cleanup() advances to bdrv_close_all() that uses
> > > > > blockdev_close_all_bdrv_states() to unref all BDS. The BDS with the name
> > > > > 'libvirt-1-storage' gets deleted via bdrv_delete() that way.
> > > > > 
> > > > 
> > > > Has qmp_blockdev_del() ever been called to remove the BDS from the
> > > > monitor_bdrv_states list? Otherwise your debugging seems to indicate
> > > > blockdev_close_all_bdrv_states() is dropping the last reference to bs,
> > > > but it's still accessible from bdrv_next() via
> > > > bdrv_next_monitor_owned().
> > > 
> > > The reference that blockdev_close_all_bdrv_states() drops is the monitor
> > > reference. So is this the right fix (completely untested, but matches
> > > what qmp_blockdev_del() does)?
> > > 
> > > Kevin
> > > 
> > > diff --git a/blockdev.c b/blockdev.c
> > > index dbd1d4d3e80..6e86c6262f9 100644
> > > --- a/blockdev.c
> > > +++ b/blockdev.c
> > > @@ -686,6 +686,7 @@ void blockdev_close_all_bdrv_states(void)
> > > 
> > >       GLOBAL_STATE_CODE();
> > >       QTAILQ_FOREACH_SAFE(bs, &monitor_bdrv_states, monitor_list, next_bs) {
> > > +        QTAILQ_REMOVE(&monitor_bdrv_states, bs, monitor_list);
> > >           bdrv_unref(bs);
> > >       }
> > >   }
> > 
> > Thanks a lot, Kevin! This looks like the right fix for me - I gave it
> > a try and it fixes the crash indeed!
> 
> Good. I think something like your patch would still be good for 11.0.
> Having undefined order in shutdown is just asking for trouble. So it
> would be good if we could be sure that migration is out of the way when
> migration_shutdown() returns.
> 
> I sent the above as a proper patch to fix the immediate problem for
> 10.2.

Thanks all!

Does that completely fix the problem?  If so, IMHO we don't need the
migration change anymore until later.  As replied in the other email, it
was at least intentional a few years ago (when introducing
migration_shutdown()) to not join() the migration thread here.

If we need to persue that we need to justify it, and if the other fix can
completely fix this problem, we'll need some other justification (meanwhile
we'll need to re-evaluate the possible hang QEMU in other use cases).

Thanks,

-- 
Peter Xu


