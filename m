Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F00E8E77180
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 16:56:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLmTc-0003Ba-Np; Thu, 12 Dec 2024 11:55:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tLmTN-00037S-Q6
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 11:55:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tLmTD-0008D3-5G
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 11:55:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734022518;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9OSnPdqQQiGocOcaTw8XIyAWYSLxfeU2NUs2FWkyVUA=;
 b=A/EpKy/6feE/so1YRLaFFBwTwER1idfVnziMbKD1zXCL9TxTgEp5EvRzl/I0vpM3sRuOcf
 lDKsVWsjTAnOmYubhWwy1TcBPyr/8pjb2G1w4TBI32r/au2MR6qd582YpdWliPfR3WV7jo
 HqvJNOYJlLz/pRNY10cjCmssIIY61Sw=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-114-0HF6oc1KOJe62sg8XQWGDg-1; Thu, 12 Dec 2024 11:55:16 -0500
X-MC-Unique: 0HF6oc1KOJe62sg8XQWGDg-1
X-Mimecast-MFC-AGG-ID: 0HF6oc1KOJe62sg8XQWGDg
Received: by mail-io1-f72.google.com with SMTP id
 ca18e2360f4ac-844c173a6bcso122415639f.3
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 08:55:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734022516; x=1734627316;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9OSnPdqQQiGocOcaTw8XIyAWYSLxfeU2NUs2FWkyVUA=;
 b=Kn9hEXc5qs0XVy5QqmoyGhdRIV9PI4hKFMvepYEOxRAIR+kp50WA0Q3H1ZeX2fFQIL
 1LkmuW+QO8XhVWikN1hLqFrs74bHoNhGw+mbs6gbvjCbK44jJ/eK142hbB03nx57F5bV
 6a7MoW5R/F1+AblhjmcPRM+K1PCr3HfgFhksRbK9p+7w6Ztn8S4ZAWO4O1ffbmjTegGA
 10Cz6g+Lyo/QPRmIDtCHCIw+Chm60ZDgVeZPD/NcTItgI3cowHBsqaTciB4d0Y4kVdZ4
 8Xt8dXHR+2F3UBCHM4ZtCwVAL+BKc6LkY1fTIqwhX/f59MvWYZQZ7h7PXXyjUHyc2yg9
 02jA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWMYEBEMhmeFtozJU0Lv+2q/hmN38okfd1dRviFEVcrZ95onOjehsTpffxpDUQ30oVyvq3Ke2fTi39H@nongnu.org
X-Gm-Message-State: AOJu0YzckpjGrnSnzH7fK+lP/RbxNk3uoyWheBhNnJTfJyXpVVQp9u/a
 2ppsPFKVhF89wTWBPMhxsNlVvPstT5oQT+apjtOI6IJceOY5A7/dOILSZzjrkCP/RTL59UwHZz+
 e4a+em+CqOWP04khcbYUChNICu9aRHHlYgOFN0jdSBFXAGyVyKHC0
X-Gm-Gg: ASbGncuk5QEmy36XqSg//Z7Vr52IrCwK05PhORToJXfCo4qry0mooW8Ytn/X7IDwbmm
 o//eEyeUrMiV3+57SpcDH8QCu3qnF4Ge8ODpzdKL4uJu4fHI426s609KL9PcUijDXsodcVWKIkN
 XcrMkMmEvczRcMxvpTqzjWyjxRECmIU2mLoplK8RxTF8IbTCOMXHkO7t2LsBzGNBhv84/JPXnYz
 XZupnNuDZzbQmruRuiP1f0hAi2+JWeAeWjvOT0dzyLVU+9BJmpjAf2WeUHWw0DaKXMBlPM5Fvj2
 vXjqQGEZD2S52tBZCA==
X-Received: by 2002:a05:6602:3f95:b0:83a:db84:41a8 with SMTP id
 ca18e2360f4ac-844e56ac920mr122371539f.10.1734022516012; 
 Thu, 12 Dec 2024 08:55:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEtV4/+Jktp3iwc48ZmOVG/A6FhCsdkqhQdrJyhZJAF+Jc+/WYr6UWzPQHbFaqLPLE32/FiQA==
X-Received: by 2002:a05:6602:3f95:b0:83a:db84:41a8 with SMTP id
 ca18e2360f4ac-844e56ac920mr122368939f.10.1734022515671; 
 Thu, 12 Dec 2024 08:55:15 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-844c3ef9d87sm123542039f.13.2024.12.12.08.55.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Dec 2024 08:55:14 -0800 (PST)
Date: Thu, 12 Dec 2024 11:55:12 -0500
From: Peter Xu <peterx@redhat.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Avihai Horon <avihaih@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v3 08/24] migration: Add thread pool of optional load
 threads
Message-ID: <Z1sVcJRamoUFshwk@x1n>
References: <cover.1731773021.git.maciej.szmigiero@oracle.com>
 <877b7108c9cb9064615606d4c731cb12c549b7f9.1731773021.git.maciej.szmigiero@oracle.com>
 <198ca4a4-01fd-42b4-9e1a-d2860277be9e@nvidia.com>
 <ceff9e17-b23e-472b-9f29-bf4c3c895c55@maciej.szmigiero.name>
 <Z1DbH5fwBaxtgrvH@x1n>
 <7e6373ca-b344-409f-a9ad-bce72779c10f@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7e6373ca-b344-409f-a9ad-bce72779c10f@maciej.szmigiero.name>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.496,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Wed, Dec 11, 2024 at 12:05:03AM +0100, Maciej S. Szmigiero wrote:
> On 4.12.2024 23:43, Peter Xu wrote:
> > On Thu, Nov 28, 2024 at 01:11:53PM +0100, Maciej S. Szmigiero wrote:
> > > > > +static int qemu_loadvm_load_thread(void *thread_opaque)
> > > > > +{
> > > > > +    struct LoadThreadData *data = thread_opaque;
> > > > > +    int ret;
> > > > > +
> > > > > +    ret = data->function(&load_threads_abort, data->opaque);
> > > > > +    if (ret && !qatomic_read(&load_threads_ret)) {
> > > > > +        /*
> > > > > +         * Racy with the above read but that's okay - which thread error
> > > > > +         * return we report is purely arbitrary anyway.
> > > > > +         */
> > > > > +        qatomic_set(&load_threads_ret, ret);
> > > > > +    }
> > > > 
> > > > Can we use cmpxchg instead? E.g.:
> > > > 
> > > > if (ret) {
> > > >       qatomic_cmpxchg(&load_threads_ret, 0, ret);
> > > > }
> > > 
> > > cmpxchg always forces sequentially consistent ordering
> > > while qatomic_read() and qatomic_set() have relaxed ordering.
> > > 
> > > As the comment above describes, there's no need for sequential
> > > consistency since which thread error is returned is arbitrary
> > > anyway.
> > 
> > IMHO this is not a hot path, so mem ordering isn't an issue.  If we could
> > avoid any data race we still should try to.
> > 
> > I do feel uneasy on the current design where everybody shares the "whether
> > to quit" via one bool, and any thread can set it... meanwhile we can't
> > stablize the first error to report later.
> > 
> > E.g., ideally we want to capture the first error no matter where it came
> > from, then keep it with migrate_set_error() so that "query-migrate" on dest
> > later can tell us what was wrong.  I think libvirt generally uses that.
> > 
> > So as to support a string error, at least we'll need to allow Error** in
> > the thread fn:
> > 
> > typedef bool (*MigrationLoadThread)(void *opaque, bool *should_quit,
> >                                      Error **errp);
> > 
> > I also changed retval to bool, as I mentioned elsewhere QEMU tries to stick
> > with "bool SOME_FUNCTION(..., Error **errp)" kind of error reporting.
> > 
> > Then any thread should only report error to qemu_loadvm_load_thread(), and
> > the report should always be a local Error**, then it further reports to the
> > global error.  Something like:
> > 
> > static int qemu_loadvm_load_thread(void *thread_opaque)
> > {
> >      MigrationIncomingState *mis = migration_incoming_get_current();
> >      struct LoadThreadData *data = thread_opaque;
> >      Error *error = NULL;
> > 
> >      if (!data->function(data->opaque, &mis->should_quit, &error)) {
> >         migrate_set_error(migrate_get_current(), error);
> >      }
> > 
> >      return 0;
> > }
> > 
> > migrate_set_error() is thread-safe, and it'll only record the 1st error.
> > 
> > Then the thread should only read &should_quit, and only set &error.  If we
> > want, migrate_set_error() can set &should_quit.
> > 
> > PS: I wished we have an unified place to tell whether we should quit
> > incoming migration - we already have multifd_recv_state->exiting, we could
> > have had a global flag like that then we can already use.  But I know I'm
> > asking too much.. However would you think it make sense to still have at
> > least Error** report the error and record it?
> > 
> 
> This could work with the following changes/caveats:
> * Needs g_autoptr(Error) otherwise these Error objects will leak.

True.. or just error_free() it after set.

> 
> * "1st error" here is as arbitrary as with my current code since which
> thread first acquires the mutex in migrate_set_error() is unspecified.

Yes that's still a step forward on being verbose of errors, which is almost
always more helpful than a bool..

Not exactly the 1st error in time sequence is ok - we don't strongly ask
for that, e.g. if two threads error at merely the same time it's ok we only
record one of them no matter which one is first.  That's unusual to start
with.

OTOH it matters on that we fail other threads only _after_ we set_error()
for the first error.  If so it's mostly always the case the captured error
will be valid and the real 1st error.

> 
> * We still need to test this new error flag (now as migrate_has_error())
> in qemu_loadvm_state() to see whether we proceed forward with the
> migration.

Yes, or just to work like what this patch does: set mis->should_quit within
the 1st setup of migrate_set_error().  For the longer term, maybe we need
to do more to put together all error setup/detection for migration.. but
for now we can at least do that for this series to set should_quit=true
there only.  It should work like your series, only that the boolean won't
be writable to data->function() but read-only there, for the sake of
capturing the Error string.

> 
> -------------------------------------------------------------------
> 
> Also, I am not in favor of replacing load_threads_abort with something
> else since we still want to ask threads to quit for other reasons, like
> earlier (non-load threads related) failure in the migration process.
> 
> That's why we set this flag unconditionally in qemu_loadvm_state() -
> see also my answer about that flag in the next message.

I'm not against having a boolean to say quit, maybe we should have that for
!vfio use case too, and I'm ok we introduce one.  But I hope two things can
work out:

  - Capture Error* and persist it in query-migrate (aka, use
    migrate_set_error).

  - Avoid setting load_threads_abort explicitly in vmstate load path.  It
    should really be part of destroy(), IMHO, as I mentioned in the other
    email, to recycle load threads in a failure case.

Thanks,

-- 
Peter Xu


