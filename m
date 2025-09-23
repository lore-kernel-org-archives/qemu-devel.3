Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 265FBCAC5A7
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 14:59:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v14TY-0003WB-CJ; Tue, 23 Sep 2025 10:58:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1v14TT-0003VV-B4
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 10:58:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1v14TR-0006bE-43
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 10:58:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758639509;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cuwDbWSXJQ5pnu8+5CxSdtkCrctqgIwX0DK224VleuI=;
 b=S3YS9/ypfwyUQ9HcHNQLbc3l/lEPLKmS8SYYGn1jmhUM3EwJnAvGj4NreQeipOJiLEp7aP
 JNvTU0TfHnGaBN9pF1H1OFrzObkqyy4sTIvj5a5XBiLMfYWorYA0Vm5K0ECCOy9ACwgwK6
 QZ/DAbQ7AillYYvZNq9jhCBiEx+crC4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-482-wtgioqEoPT-SudFTjO-rEA-1; Tue, 23 Sep 2025 10:58:20 -0400
X-MC-Unique: wtgioqEoPT-SudFTjO-rEA-1
X-Mimecast-MFC-AGG-ID: wtgioqEoPT-SudFTjO-rEA_1758639499
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-46dfd711001so15350675e9.0
 for <qemu-devel@nongnu.org>; Tue, 23 Sep 2025 07:58:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758639499; x=1759244299;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cuwDbWSXJQ5pnu8+5CxSdtkCrctqgIwX0DK224VleuI=;
 b=OQhR9wU0FI0qEFDb/8dYVpBMoDeoeleI/jlZ3Lh9+gQp0ogy0k9cWcigf2RdLko7+P
 31g8K+rUAIhRtT45JUo3bOp/vUKBM19LPQX7UUunVPh514vWZLgK6lK82w+lJzbRqiGV
 uNnmvqCHwCw2+3pTu+00RJspMtr3695LfbnogGI0TiUW5bwCxJmWa4929VGX1iU0H1iI
 iQfS6OJ9XYVZCdKrLlxCwlYZ+U9bHv3ml+AXp+XmNS0ipTyetTCt+vu7q7b4RFHCKzKe
 xsmbCGm8yQs9BoiY7jHaos974NBCtx4Y9EqWhIy6drlm9JewR7GhMJKzOG01V3WD5IMZ
 PD+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUf1X1et1n4qr+L86DE7LTXST7O4LJ4Gzmutuy3hgy1UKmRNf/d3PYaPYpAyMl6sfU6RuuuxcxJeCxJ@nongnu.org
X-Gm-Message-State: AOJu0YzJuTTpv20wjbZcIeMRr+Pc8T3vwVRYUZNSizrouITaMdYAtYIw
 Km/7X6tdC1o68gLKcOGnqO7ZDd1kDjT1PzwxTBHxHokxUv/7IgdaI8ukWB6wOm0Qp6ER9XP8s8k
 C+dg4vEd3hKI94YyiyGIGSUokaFbN0UYpHk7SU0nlEJek/VHSNpxo5N5i
X-Gm-Gg: ASbGncsXaXUizVlyE3mNIXfhE4e90AbZzglUjM7BlaJ3wMZRF8X5bt6ChQjDzBpwyzV
 FXrmQAg9e4cMd0WcPtVHXZTkScBSBgvNuwab+hPRcOfUq5TuHLxIhm3U6WUMLWQ+FbfmYviAwba
 WOUo4WcvR/VFE9sKN2eRuVTijx9Wv/zpr2Otlg3IawnRd8bnehr61R+WU5p/qfMx9xo49yAdVDs
 1+nnJ28QUbJbqq7F+5TBCgL23dJ7kAKAWKUpj9ngA+hkmiT0FTyK9EF/TeU2yWKqPfv7ZY4z+jO
 nMt6NZ5FVeKnLKF0Wcjw351uzL7aag==
X-Received: by 2002:a05:600c:4f88:b0:46e:1e31:8d1e with SMTP id
 5b1f17b1804b1-46e1e318d8dmr30187125e9.18.1758639498858; 
 Tue, 23 Sep 2025 07:58:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFFXySvyT5C1I8CyaYq0knpC3KCbOCFpIzuFa1MwRHCVyt6Q2qwoJdU5IatLXRhTT7lY15A+w==
X-Received: by 2002:a05:600c:4f88:b0:46e:1e31:8d1e with SMTP id
 5b1f17b1804b1-46e1e318d8dmr30186885e9.18.1758639498355; 
 Tue, 23 Sep 2025 07:58:18 -0700 (PDT)
Received: from fedora ([85.93.96.130]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-464f0aac271sm244348215e9.3.2025.09.23.07.58.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Sep 2025 07:58:17 -0700 (PDT)
Date: Tue, 23 Sep 2025 16:58:15 +0200
From: Juraj Marcin <jmarcin@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org, 
 Jiri Denemark <jdenemar@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: Re: [PATCH 3/4] migration: Refactor incoming cleanup into
 migration_incoming_finish()
Message-ID: <jwyopauf2bjzkyrda7pgahmrbpkeb2te6przhuvtj5ue7odq55@nzgxjbl75mk6>
References: <20250915115918.3520735-1-jmarcin@redhat.com>
 <20250915115918.3520735-4-jmarcin@redhat.com>
 <87plbmtmox.fsf@suse.de>
 <luoiumyvzjxtro6bd4vqn5mq6icf2zfic3n6shivb2e3ngkmcl@bz7vzg7xwdiq>
 <aNFwdic2-d_Crctc@x1.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aNFwdic2-d_Crctc@x1.local>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jmarcin@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 2025-09-22 11:51, Peter Xu wrote:
> On Mon, Sep 22, 2025 at 02:58:38PM +0200, Juraj Marcin wrote:
> > Hi Fabiano,
> > 
> > On 2025-09-19 13:46, Fabiano Rosas wrote:
> > > Juraj Marcin <jmarcin@redhat.com> writes:
> > > 
> > > Hi Juraj,
> > > 
> > > Good patch, nice use of migrate_has_failed()
> > 
> > Thanks!
> > 
> > > 
> > > > From: Juraj Marcin <jmarcin@redhat.com>
> > > >
> > > > Currently, there are two functions that are responsible for cleanup of
> > > > the incoming migration state. With successful precopy, it's the main
> > > > thread and with successful postcopy it's the listen thread. However, if
> > > > postcopy fails during in the device load, both functions will try to do
> > > > the cleanup. Moreover, when exit-on-error parameter was added, it was
> > > > applied only to precopy.
> > > >
> > > 
> > > Someone could be relying in postcopy always exiting on error while
> > > explicitly setting exit-on-error=false for precopy and this patch would
> > > change the behavior incompatibly. Is this an issue? I'm willing to
> > > ignore it, but you guys know more about postcopy.
> > 
> > Good question. When going through older patches where postcopy listen
> > thread and then where exit-on-error were implemented, it seemed more
> > like an overlook than intentional omission. However, it might be better
> > to not break any potential users of this, we could add another option,
> > "exit-on-postcopy-error" that would allow such handling if postscopy
> > failed unrecoverably. I've already talked about such option with
> > @jdenemar and he agreed with it.
> 
> The idea for postcopy ram is, it should never fail.. as failing should
> never be better than a pause.  Block dirty bitmap might be different,
> though, when enabled separately.
> 
> For postcopy-ram, qemu_loadvm_state_main() will in reality only receive RAM
> updates. It'll almost always trigger the postcopy_pause_incoming() path
> when anything fails.
> 
> For pure block-dirty-bitmap-only styled postcopy: for this exit-on-error, I
> also don't think we should really "exit on errors", even if the flag is
> set.  IIUC, it's not fatal to the VM if that failed, as described in:

I agree, however, this patch doesn't add any new cases in which the
destination QEMU would exit. If there is an error in block dirty bitmaps
it is only reported to the console, and then it continues to waiting for
main_thread_load_event, marks the migration as COMPLETED and does the
cleanup, same as before. [1] I can add a comment similar to "prevent
further exit" as there was before.

However, if there is other error, in which the postcopy cannot pause
(for example there was a failure in the main thread loading the device
state before the machine started), the migration status changes to
FAILED and jumps right to cleanup which then checks exit-on-error and
optionally exits the QEMU, before it would always exit in such case [2]:

[1]: https://gitlab.com/qemu-project/qemu/-/blob/ab8008b231e758e03c87c1c483c03afdd9c02e19/migration/savevm.c#L2120
[2]: https://gitlab.com/qemu-project/qemu/-/blob/ab8008b231e758e03c87c1c483c03afdd9c02e19/migration/savevm.c#L2150

> 
> commit ee64722514fabcad2430982ade86180208f5be4f
> Author: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Date:   Mon Jul 27 22:42:32 2020 +0300
> 
>     migration/savevm: don't worry if bitmap migration postcopy failed
> 
>     ...
> 
>     And anyway, bitmaps postcopy is not prepared to be somehow recovered.
>     The original idea instead is that if bitmaps postcopy failed, we just
>     lose some bitmaps, which is not critical. So, on failure we just need
>     to remove unfinished bitmaps and guest should continue execution on
>     destination.
> 
> Hence, exit here might be an overkill.. need block developers to double
> check, though..
> 

/* snip */

> > > > diff --git a/migration/savevm.c b/migration/savevm.c
> > > > index fabbeb296a..d7eb416d48 100644
> > > > --- a/migration/savevm.c
> > > > +++ b/migration/savevm.c
> > > > @@ -2069,6 +2069,11 @@ static int loadvm_postcopy_ram_handle_discard(MigrationIncomingState *mis,
> > > >      return 0;
> > > >  }
> > > >  
> > > > +static void postcopy_ram_listen_thread_bh(void *opaque)
> > > > +{
> > > > +    migration_incoming_finish();
> > > > +}
> > > > +
> > > >  /*
> > > >   * Triggered by a postcopy_listen command; this thread takes over reading
> > > >   * the input stream, leaving the main thread free to carry on loading the rest
> > > > @@ -2122,52 +2127,31 @@ static void *postcopy_ram_listen_thread(void *opaque)
> > > >                           "bitmaps may be lost, and present migrated dirty "
> > > >                           "bitmaps are correctly migrated and valid.",
> > > >                           __func__, load_res);
> > > > -            load_res = 0; /* prevent further exit() */
> > > >          } else {
> > > >              error_report("%s: loadvm failed: %d", __func__, load_res);
> > > >              migrate_set_state(&mis->state, MIGRATION_STATUS_POSTCOPY_ACTIVE,
> > > >                                             MIGRATION_STATUS_FAILED);
> > > > +            goto out;
> > > >          }
> > > >      }
> > > > -    if (load_res >= 0) {
> > > > -        /*
> > > > -         * This looks good, but it's possible that the device loading in the
> > > > -         * main thread hasn't finished yet, and so we might not be in 'RUN'
> > > > -         * state yet; wait for the end of the main thread.
> > > > -         */
> > > > -        qemu_event_wait(&mis->main_thread_load_event);
> > > > -    }
> > > > -    postcopy_ram_incoming_cleanup(mis);
> > > > -
> > > > -    if (load_res < 0) {
> > > > -        /*
> > > > -         * If something went wrong then we have a bad state so exit;
> > > > -         * depending how far we got it might be possible at this point
> > > > -         * to leave the guest running and fire MCEs for pages that never
> > > > -         * arrived as a desperate recovery step.
> > > > -         */
> > > > -        rcu_unregister_thread();
> > > > -        exit(EXIT_FAILURE);
> > > > -    }
> > > > +    /*
> > > > +     * This looks good, but it's possible that the device loading in the
> > > > +     * main thread hasn't finished yet, and so we might not be in 'RUN'
> > > > +     * state yet; wait for the end of the main thread.
> > > > +     */
> > > > +    qemu_event_wait(&mis->main_thread_load_event);
> 
> PS: I didn't notice this change, looks like this may be better to be a
> separate patch when moving out of the if.  Meanwhile, I don't think we set
> it right either, in qemu_loadvm_state():
> 
>     qemu_event_set(&mis->main_thread_load_event);
> 
> The problem is e.g. load_snapshot / qmp_xen_load_devices_state also set
> that event, even if there'll be no one to consume it.. not a huge deal, but
> maybe while moving it out of the if, we can also cleanup the set() side
> too, by moving the set() upper into process_incoming_migration_co().

While I have moved it out of the condition, it is still only waited in
the success path, if there is an error that would previously cause the
condition to be false, the execution now jumps directly to the cleanup
section (out label), skipping this wait and setting migration state to
COMPLETED (it's set to FAILED before the jump). But I can still look
into moving the set() up.

> 
> > > >  
> > > >      migrate_set_state(&mis->state, MIGRATION_STATUS_POSTCOPY_ACTIVE,
> > > >                                     MIGRATION_STATUS_COMPLETED);
> > > > -    /*
> > > > -     * If everything has worked fine, then the main thread has waited
> > > > -     * for us to start, and we're the last use of the mis.
> > > > -     * (If something broke then qemu will have to exit anyway since it's
> > > > -     * got a bad migration state).
> > > > -     */
> > > > -    bql_lock();
> > > > -    migration_incoming_state_destroy();
> > > > -    bql_unlock();
> > > >  
> > > > +out:
> > > >      rcu_unregister_thread();
> > > > -    mis->have_listen_thread = false;
> > > >      postcopy_state_set(POSTCOPY_INCOMING_END);
> > > >  
> > > >      object_unref(OBJECT(migr));
> > > >  
> > > > +    migration_bh_schedule(postcopy_ram_listen_thread_bh, NULL);
> > > 
> > > Better to schedule before the object_unref to ensure there's always
> > > someone holding a reference?
> > 
> > True, I'll move it.
> 
> Good point.  Though I'm not sure moving it upper would help, because it'll
> be the BH that references the MigrationState*..  So maybe we could unref at
> the end of postcopy_ram_listen_thread_bh().  If so, we should add a comment
> on ref() / unref() saying how they're paired.
> 
> > 
> > > 
> > > > +
> > > >      return NULL;
> > > >  }
> > > >  
> > > > @@ -2217,7 +2201,7 @@ static int loadvm_postcopy_handle_listen(MigrationIncomingState *mis)
> > > >      mis->have_listen_thread = true;
> > > >      postcopy_thread_create(mis, &mis->listen_thread,
> > > >                             MIGRATION_THREAD_DST_LISTEN,
> > > > -                           postcopy_ram_listen_thread, QEMU_THREAD_DETACHED);
> > > > +                           postcopy_ram_listen_thread, QEMU_THREAD_JOINABLE);
> > > >      trace_loadvm_postcopy_handle_listen("return");
> > > >  
> > > >      return 0;
> > > 
> > 
> 
> -- 
> Peter Xu
> 


