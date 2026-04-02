Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F046CD3943A
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 15:17:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8Jme-0003nm-RZ; Thu, 02 Apr 2026 11:16:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w8JmZ-0003nM-UI
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 11:16:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w8JmX-0000B3-Qc
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 11:16:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775142986;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hMBGHKIFiniqSo5nT+tzjaRmdj78Rydu6AOboLD2ORo=;
 b=IH3xB5ElGlXFQknKd/b6WbOPocJnT2ZrzlsgOJ3Bz1OaDnGIS+0kdTwy891jJeLnTJOjjo
 8PJp3+dBOjduhij1zzcL8dm5+EUefk4n1gXDMSYEMnqvEFxmdA/TzB4iSkjYVfPK1OWFj/
 Ei3KxiptWH04YzsP5YvQnWY1q5Rw7J4=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-1bG9PhlpNgOK2oF1Y27WFA-1; Thu, 02 Apr 2026 11:16:25 -0400
X-MC-Unique: 1bG9PhlpNgOK2oF1Y27WFA-1
X-Mimecast-MFC-AGG-ID: 1bG9PhlpNgOK2oF1Y27WFA_1775142985
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-8cd7ea0bb20so266374785a.3
 for <qemu-devel@nongnu.org>; Thu, 02 Apr 2026 08:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1775142985; x=1775747785; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=hMBGHKIFiniqSo5nT+tzjaRmdj78Rydu6AOboLD2ORo=;
 b=ixrgbznBPpZyBAd72XvU73CLUpH86R4mrtvTiJEpumnvzKQlvYSan6LhJitUs5h+QB
 ut5gu4KbG8GKxwX7dadZLEQkUmLDSSfuKSo1Y1urKo/xvKjHwPn7h6dIauuBtLQQ0dW9
 6RexRWHZGIGv9NOWr2DJQxHrhqWtUJlINDebhZn9YLPk4Yf59WEU3o5syjT2TsKq7I6d
 7q3KlFsZO9b/HVAR8rQM21mQvi0GJHdNoAcUnISQQKEoPDI89TR+43qwYXxLUYmiSGlG
 1e6uD1al6ljqzwCLIdsLeRHzhY01jBI29afAIe0jx2j0xAnQgohU9VJWwZY0DeYuMHTr
 dMow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775142985; x=1775747785;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hMBGHKIFiniqSo5nT+tzjaRmdj78Rydu6AOboLD2ORo=;
 b=XSltC6AtS9YUGycVONPnqjMkXhRFMqxGQdN1Nl7CR4DHSmW6kWPuHeV+M8xnoUb1j2
 C7l5B9bery8W/mwRPbEVbhzjslSY904FEocsf+DTQH5TinIstAQ8Bjc++AiHy+fWVqfN
 +G8YtrqCYF1krKxIiMLOlsZnBnT09W8caoJyfQ+m4HlYzYtwiWZJAKd3OMXBibtwwcD3
 mdNCyb74X16a+Rcvb80B+rvQh0ST2jMz74AvXBi7rq3LHLWbDJQHI4kfrdQ6RzJnW+JM
 IZcRa+mAp9YZU1E8yqlSD9cJjmKV/RzcQpNduX3b5u5lqi+74mPdkc5VLt+BpsumRsQj
 EQ/w==
X-Gm-Message-State: AOJu0YxDBrYIlGyDKVRk0pG7Jd8sXKTQNTr4ttTUtoZv3uxCopsWx4U+
 aUIjYTfTrw1LQozIu9rBxiZ0tBdBMNg5CymsD2ukv3FrfMM5hCV2zbXIm9F89O8W0FYfk/easRi
 L8Xco3pDtEhEk82w9L9MZXiABLLl3Th8ne5dRpUkFZ8KBKRRS7nYO7USw
X-Gm-Gg: ATEYQzzMUOa/DuVJm18ZOGp8w3K6mlG4NzE+Ihms6Fn7GCXPzH+vjkX2XCgXR4cmqDz
 leXaPWrPPnad71QCO7hCZwyoaFVr77BU6doBMYYDG8wals7qxVZbKLNnt6yQ+UYhAWNZIA1hjvw
 3tYSKXZokbFSuNk6x7AQbcg3VYBvBV1vkH/4RoVrrcyVxMZ/FvjZI/sPrjmi0cQcHUW8kj61nJb
 F450NZoukCTWzm85fSIXwnjg4ykGvblqXhxnPuzaT1fmfNGiGEd541GbEhmxtq40dlSoL6Bs16W
 5xrxYWS8CzfnHs3Aa4BLyA8AOqJso4URJDQRe4slx1/sb1Vqw2GziD+tnQXnioMC4g4Fcrow02P
 NsMS06qvtCDt1EKxRueN44J8MtzJIdQPatE05YaS/Wx1NYQ==
X-Received: by 2002:a05:620a:4114:b0:8cd:94da:433f with SMTP id
 af79cd13be357-8d1b5bb189emr1154049485a.48.1775142984427; 
 Thu, 02 Apr 2026 08:16:24 -0700 (PDT)
X-Received: by 2002:a05:620a:4114:b0:8cd:94da:433f with SMTP id
 af79cd13be357-8d1b5bb189emr1154040185a.48.1775142983534; 
 Thu, 02 Apr 2026 08:16:23 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8d2a8c22d0esm262802185a.41.2026.04.02.08.16.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Apr 2026 08:16:23 -0700 (PDT)
Date: Thu, 2 Apr 2026 11:16:21 -0400
From: Peter Xu <peterx@redhat.com>
To: Juraj Marcin <jmarcin@redhat.com>
Cc: qemu-devel@nongnu.org, Kirti Wankhede <kwankhede@nvidia.com>,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>,
 Alex Williamson <alex@shazbot.org>,
 Yishai Hadas <yishaih@nvidia.com>, Fabiano Rosas <farosas@suse.de>,
 Pranav Tyagi <prtyagi@redhat.com>, Zhiyi Guo <zhguo@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Avihai Horon <avihaih@nvidia.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Subject: Re: [PATCH RFC 07/12] migration: Introduce stopcopy_bytes in
 save_query_pending()
Message-ID: <ac6IRfYH7UCluuIt@x1.local>
References: <20260319231302.123135-1-peterx@redhat.com>
 <20260319231302.123135-8-peterx@redhat.com>
 <acavsDOsAz0hmfvi@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <acavsDOsAz0hmfvi@fedora>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.542,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Fri, Mar 27, 2026 at 05:43:24PM +0100, Juraj Marcin wrote:
> On 2026-03-19 19:12, Peter Xu wrote:
> > Allow modules to report data that can only be migrated after VM is stopped.
> > 
> > When this concept is introduced, we will need to account stopcopy size to
> > be part of pending_size as before.
> > 
> > One thing to mention is, when there can be stopcopy size, it means the old
> > "pending_size" may not always be able to reach low enough to kickoff an
> > slow version of query sync.  While it used to be almost guaranteed to
> > happen because if we keep iterating, normally pending_size can go to zero
> > for precopy-only because we assume everything reported can be migrated in
> > precopy phase.
> > 
> > So we need to make sure QEMU will kickoff a synchronized version of query
> > pending when all precopy data is migrated too.  This might be important to
> > VFIO to keep making progress even if the downtime cannot yet be satisfied.
> > 
> > So far, this patch should introduce no functional change, as no module yet
> > report stopcopy size.
> > 
> > This will pave way for VFIO to properly report its pending data sizes,
> > which was actually buggy today.  Will be done in follow up patches.
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  include/migration/register.h | 12 +++++++++
> >  migration/migration.c        | 52 ++++++++++++++++++++++++++++++------
> >  migration/savevm.c           |  7 +++--
> >  migration/trace-events       |  2 +-
> >  4 files changed, 62 insertions(+), 11 deletions(-)
> > 
> > diff --git a/include/migration/register.h b/include/migration/register.h
> > index 2320c3a981..3824958ba5 100644
> > --- a/include/migration/register.h
> > +++ b/include/migration/register.h
> > @@ -17,12 +17,24 @@
> >  #include "hw/core/vmstate-if.h"
> >  
> >  typedef struct MigPendingData {
> > +    /*
> > +     * Modules can only update these fields in a query request via its
> > +     * save_query_pending() API.
> > +     */
> >      /* How many bytes are pending for precopy / stopcopy? */
> >      uint64_t precopy_bytes;
> 
> The comment suggests precopy_bytes should include iterable precopy and
> also non-iterable precopy (stopcopy) bytes, however, all 3 are then
> summed up for total_bytes.

Yes the current way to categorize dirty info isn't as clear, but it's the
easiest so far based on the previous definition of must_precopy.  With
that, it's natural to define must-stopcopy, which is separately accounted
from "data that can be copied during stop, but also iterable / precopy-able".

> 
> >      /* How many bytes are pending that can be transferred in postcopy? */
> >      uint64_t postcopy_bytes;
> > +    /* How many bytes that can only be transferred when VM stopped? */
> > +    uint64_t stopcopy_bytes;
> 
> I was also wondering if having precopy_iterable_bytes,
> precopy_non_iterable_bytes, and postcopy_bytes would be clearer, but
> given that stopcopy is already a term for this in VFIO it is probably
> fine.

Yes, your naming is better in some way.  However it can also be slightly
confusing on precopy_non_iterable_bytes to represent stopcopy-only bytes.

IMHO we can leave the "hard problems" (naming..) for later as cleanups and
fix the problem first.

> 
> > +
> > +    /*
> > +     * Modules should never update these fields.
> > +     */
> 
> Maybe splitting input and output parameters, or things which modules
> should touch and output of the overall API into different
> structures/simple parameters could be better instead of the comment.

One thing I can immediately do is making both "exact" and "total_bytes" to
be consts, then force cast them only once when setting it.  Would that be
slightly better?  Or any suggestions?

It's always an option to fix the problem first then think about how to make
it prettier, rather than doing it in one shot.

So far, the immediate goal is to allow reporting VFIO remaining data and/or
expected downtime in query-migrate.

> 
> >      /* Is this a fastpath query (which can be inaccurate)? */
> >      bool fastpath;
> > +    /* Total pending data */
> > +    uint64_t total_bytes;
> >  } MigPendingData ;
> >  
> >  /**
> > diff --git a/migration/migration.c b/migration/migration.c
> > index 99c4d09000..42facb16d1 100644
> > --- a/migration/migration.c
> > +++ b/migration/migration.c
> > @@ -3198,6 +3198,44 @@ typedef enum {
> >      MIG_ITERATE_BREAK,          /* Break the loop */
> >  } MigIterateState;
> >  
> > +/* Are we ready to move to the next iteration phase? */
> > +static bool migration_iteration_next_ready(MigrationState *s,
> > +                                           MigPendingData *pending)
> > +{
> > +    /*
> > +     * If the estimated values already suggest us to switchover, mark this
> > +     * iteration finished, time to do a slow sync.
> > +     */
> > +    if (pending->total_bytes <= s->threshold_size) {
> > +        return true;
> > +    }
> > +
> > +    /*
> > +     * Since we may have modules reporting stop-only data, we also want to
> > +     * re-query with slow mode if all precopy data is moved over.  This
> > +     * will also mark the current iteration done.
> > +     *
> > +     * This could happen when e.g. a module (like, VFIO) reports stopcopy
> > +     * size too large so it will never yet satisfy the downtime with the
> > +     * current setup (above check).  Here, slow version of re-query helps
> > +     * because we keep trying the best to move whatever we have.
> > +     */
> > +    if (pending->precopy_bytes == 0) {
> > +        return true;
> > +    }
> > +
> > +    return false;
> > +}
> > +
> > +static void migration_iteration_go_next(MigPendingData *pending)
> > +{
> > +    /*
> > +     * Do a slow sync will achieve this.  TODO: move RAM iteration code
> > +     * into the core layer.
> > +     */
> > +    qemu_savevm_query_pending(pending, false);
> > +}
> 
> I agree with Avihai regarding the iteration terminology. I slightly
> prefer migration_dirty_sync_ready/migration_dirty_sync, but using pass
> instead of iteration is also fine.

Replied in the other email, let's see if we can reach a consensus.

Thanks,

-- 
Peter Xu


