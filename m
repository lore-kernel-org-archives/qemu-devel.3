Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 523DBE77173
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 15:36:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJaNc-00038u-EJ; Fri, 06 Dec 2024 10:36:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tJaNY-00038a-WD
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 10:36:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tJaNW-0001kS-Sl
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 10:36:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733499385;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mQUVjFu3N08TUFoWBP7OMT7WQvGteCFpgVUBraVg18s=;
 b=L9ZGnD6cBB0Jnsse7sUi0yX2vQzY1oyznub5E2M+lunuJrlhCmcOr++mXIxFITWiIHnEux
 aLcMnfy1iiQ7Bml5lnVdJdCCHCexLsWUtEKU50VkZMT5aldjFcJwzRgobgWvvHLoo2TIRQ
 zl5Tf9Dm/YbM0qlm3URXMuXptgfJh8I=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-20-7YA6D_NmMi6pRuQ-0J56-g-1; Fri, 06 Dec 2024 10:36:22 -0500
X-MC-Unique: 7YA6D_NmMi6pRuQ-0J56-g-1
X-Mimecast-MFC-AGG-ID: 7YA6D_NmMi6pRuQ-0J56-g
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-4668d3833a4so80780121cf.1
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2024 07:36:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733499382; x=1734104182;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mQUVjFu3N08TUFoWBP7OMT7WQvGteCFpgVUBraVg18s=;
 b=YrsumQbh5KUn+akbBxLeoVGl7cbhsHVS3oe37Pi1FRimqAj1LAOVoRuz5UXBS+ubDd
 s+5AAK474Rh2FSBqbwHG20esOPj14lGZxQKramuBfrmVnEXVZZTJy+9jnA4ydLM1h/Xn
 vR9Jvzt3TVkuicVdfUa4XyLc+DY8n111DEvhKMrmmaYEqgAZU/zXUqzLzK1VLjDl0gGK
 I7R0NGntcnc8hPNrz+BAEd9ZZuWkmJnaa+t++0/Q01Srh4R4sjSfCuRH9ZbeD0+qQrxf
 cwZNTzcsdmbrwZK4f1KNbJOocdcDumOi9X8ayFHFaTjpJfpXrlFCMXrcLO79kHLzxBWz
 iyuw==
X-Gm-Message-State: AOJu0YzJLOekQ08Fs7jE9yLLa6PZwyUDrI8gv/7BiXMi9ANxMoXWjw6F
 kvn5eDocwi1CsD1ZUMXYVHrUi+JKg2Koi/TUGryT391rEvnz53u5uBy3ZNBcIt4Ozah+kDdvJwz
 2vYxaLrPSDZq3GNRB4pfIF3HrHsWTzAWRztzzyO6ianOMFTU6ggcZ
X-Gm-Gg: ASbGnctdMRXHi+sntKqH18OMEYBRTfI3/STf4Z4kiZaAmvIzYE98n+i/ELzyFP2DrSJ
 Bu9Xgw/R1IXJSv+tRzmnBkzy/CxNEfZpEBb3IaF2a2rr2N/BArv39LS5PMhwHL49J9+HujqlC9d
 HqnJ2to18wLQ+S2IiOczwovvLwxr1w7EQW/bXsxlgtuTPcrUVVS7JoOxdacvG70LHPsXOcxbA2Q
 /rXPq0zFYRtoFpzKkEs5OlemrXCV+cvf3JtAZawq+2IdoDputPwdLbRUDomvX3Mhx4JjyrOeoAR
 2PbV+yywaZM=
X-Received: by 2002:ac8:7c4d:0:b0:466:a674:96bc with SMTP id
 d75a77b69052e-46734cedf6bmr51547901cf.27.1733499381741; 
 Fri, 06 Dec 2024 07:36:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGanCCHkVtR8nUULdwBbeB6JfIsQNtCtXkQB4OWznddy2olBq4DH0w5hDfKUFZvt4EVYEE8Cg==
X-Received: by 2002:ac8:7c4d:0:b0:466:a674:96bc with SMTP id
 d75a77b69052e-46734cedf6bmr51547541cf.27.1733499381353; 
 Fri, 06 Dec 2024 07:36:21 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-467297c23b7sm21977581cf.74.2024.12.06.07.36.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Dec 2024 07:36:20 -0800 (PST)
Date: Fri, 6 Dec 2024 10:36:18 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>
Subject: Re: [PATCH v2 7/7] migration/multifd: Document the reason to sync
 for save_setup()
Message-ID: <Z1MZ8hwPUQBLMLcb@x1n>
References: <20241206005834.1050905-1-peterx@redhat.com>
 <20241206005834.1050905-8-peterx@redhat.com>
 <87r06kc1t0.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87r06kc1t0.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Dec 06, 2024 at 11:40:27AM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > It's not straightforward to see why src QEMU needs to sync multifd during
> > setup() phase.  After all, there's no page queued at that point.
> >
> > For old QEMUs, there's a solid reason: EOS requires it to work.  While it's
> > clueless on the new QEMUs which do not take EOS message as sync requests.
> >
> > One will figure that out only when this is conditionally removed.  In fact,
> > the author did try it out.  Logically we could still avoid doing this on
> > new machine types, however that needs a separate compat field and that can
> > be an overkill in some trivial overhead in setup() phase.
> >
> > Let's instead document it completely, to avoid someone else tries this
> > again and do the debug one more time, or anyone confused on why this ever
> > existed.
> >
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  migration/ram.c | 27 +++++++++++++++++++++++++++
> >  1 file changed, 27 insertions(+)
> >
> > diff --git a/migration/ram.c b/migration/ram.c
> > index 5d4bdefe69..ddee703585 100644
> > --- a/migration/ram.c
> > +++ b/migration/ram.c
> > @@ -3036,6 +3036,33 @@ static int ram_save_setup(QEMUFile *f, void *opaque, Error **errp)
> >          migration_ops->ram_save_target_page = ram_save_target_page_legacy;
> >      }
> >  
> > +    /*
> > +     * This operation is unfortunate..
> > +     *
> > +     * For legacy QEMUs using per-section sync
> > +     * =======================================
> > +     *
> > +     * This must exist because the EOS below requires the SYNC messages
> > +     * per-channel to work.
> > +     *
> > +     * For modern QEMUs using per-round sync
> > +     * =====================================
> > +     *
> > +     * Logically this sync is not needed (because we know there's nothing
> > +     * in the multifd queue yet!).
> 
> This is a bit misleading because even today we could split the
> multifd_ram_flush_and_sync() into _flush and _sync (haven't I seen a
> patch doing this somewhere? Maybe from Maciej...) and call just the
> _sync here, which is unrelated to any multifd queue.

Yeah you have a point, maybe at least I shouldn't mention the queues, they
can be irrelevant.

> 
> I think we shouldn't tie "sync" with "wait for multifd threads to finish
> sending their data (a kind of flush)" as this implies. The sync is as
> much making sure the threads are ready to receive as it is making sure
> the data is received in order with relation to ram scanning rounds.
> 
> IOW, the local sync is what ensures multifd send threads are flushed
> while this code deals with the sync of src&dst threads, which is "just"
> a synchronization point between the two QEMUs.

This is a remote sync, not a local sync.  But yes, it can be the
synchronization point.

As I mentioned below, such sync point has nothing to do with src, so it can
be implemented in dest alone without such sync message.  It works, though.

> 
> > However as a side effect, this makes
> > +     * sure the dest side won't receive any data before it properly reaches
> > +     * ram_load_precopy().
> 
> I'm not sure it's a side-effect. It seems deliberate to me, seeing that
> multifd usually does its own synchronization. For instance, on the send
> side we also need some sync to make sure ram.c doesn't send data to
> multifd send threads that are not ready yet (i.e. the wait on
> channels_ready at the start of multifd_send()).

Yes, and that's exactly what I wanted to express.  If dest has that
"channels_ready" thing, I'm pretty sure we don't need this remote sync.
We're using a heavier sync to service the purpose for "local sync for
dest".  It's ok, but it's very unclear on what it really does.

> 
> > +     *
> > +     * Without this sync, src QEMU can send data too soon so that dest may
> > +     * not have been ready to receive it (e.g., rb->receivedmap may be
> > +     * uninitialized, for example).
> > +     *
> > +     * Logically "wait for recv setup ready" shouldn't need to involve src
> > +     * QEMU at all, however to be compatible with old QEMUs, let's stick
> 
> I don't understand this statement, you're saying that QEMU src could
> just start dumping data on the channel without a remote end? Certainly
> for file migrations, but socket as well?

Yes.

When reaching here on sender side, all multifd channels are already there:
multifd_send_setup() guaranteed it.  We can start dump things, AFAICT,
irrelevant of what dest is doing.

Maybe the recv threads are not even created, but that isn't relevant, IMO,
as long as they'll be there at some point and start collecting socket
buffers.

> 
> > +     * with this.  Fortunately the overhead is low to sync during setup
> > +     * because the VM is running, so at least it's not accounted as part of
> > +     * downtime.
> > +     */
> >      bql_unlock();
> >      ret = multifd_ram_flush_and_sync(f);
> >      bql_lock();
> 

I removed ambiguous wordings on "queue is empty", and simplified it a bit.
How's this one look?

    /*
     * This operation is unfortunate..
     *
     * For legacy QEMUs using per-section sync
     * =======================================
     *
     * This must exist because the EOS below requires the SYNC messages
     * per-channel to work.
     *
     * For modern QEMUs using per-round sync
     * =====================================
     *
     * Logically such sync is not needed, and recv threads should not run
     * until setup ready (using things like channels_ready on src).  Then
     * we should be all fine.
     *
     * However even if we add channels_ready to recv side in new QEMUs, old
     * QEMU won't have them so this sync will still be needed to make sure
     * multifd recv threads won't start processing guest pages early before
     * ram_load_setup() is properly done.
     *
     * Let's stick with this.  Fortunately the overhead is low to sync
     * during setup because the VM is running, so at least it's not
     * accounted as part of downtime.
     */

-- 
Peter Xu


