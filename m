Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F65CF8D761
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 18:07:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDR7I-0005yO-Fn; Thu, 16 Apr 2026 14:07:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wDR7G-0005yA-Ic
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 14:07:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wDR7D-0002QS-Hi
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 14:07:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776362818;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wuy06UwPjfNOSCYfDjIvejbNXvtdNyLWV2cR2ScV7XY=;
 b=Z6C+IHs13O81T9LeBP4HuLA8Rmdu3c6HczbocRJ7yuZWahKaFnXECnTOYcRSE9fy/43mPO
 6TKjj/1YbbeUq7DSZHJLj+jZcvsWvFhoHkNAGY6mAQdRRCppc5Eh4SPCCIWO5fySPBaPHI
 zPFbKH8S2B/il7HeRGme5bOTTp7TjVI=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677--5nDmRfiM72UXMNv6uVbNg-1; Thu, 16 Apr 2026 14:06:55 -0400
X-MC-Unique: -5nDmRfiM72UXMNv6uVbNg-1
X-Mimecast-MFC-AGG-ID: -5nDmRfiM72UXMNv6uVbNg_1776362815
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8ae6aa148a7so32476826d6.0
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 11:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776362814; x=1776967614; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=wuy06UwPjfNOSCYfDjIvejbNXvtdNyLWV2cR2ScV7XY=;
 b=WUPowVHQZGqiIxg2v8E9im/DSL0uvTFgQ5y6B1oGIVKT5d0+NswfVVqv3iWKkT+6NP
 817zOTtHy2O6TQxmlhEere+8D9ZyhGjlMZDlDUPd91oJJ9a0OowJffd3/x+vQArMSuTO
 1wSWY43eu/WKgVC4ESBV3ki/cmXxfV2Xq3vBERxnWhrluk0th0kEpxY97Pb6iZkDHX1J
 GImtbnuTd9v26rdkDLDyNsewgtDlW8AhF9B9vL56W637mY2Yw5ySohbmFzaRTfihCdPL
 6I0Ooo4HJ+MDfXW6EWQ/xH+M6xOMIXlwQ+hwC+obCyGdPZhJV3o71puI8pM+1LKuCPrS
 xYkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776362814; x=1776967614;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wuy06UwPjfNOSCYfDjIvejbNXvtdNyLWV2cR2ScV7XY=;
 b=XWugtDIwL/3HFa8B/L/eMAIyBpHjiB58iHccY+eunvGMu+uDDfOnWx+tmxho5iqvlZ
 jhOAA4czbPV0ZLhd7pYGua8SWoMVC48SMvTjA+5Essit2fWRYGSOLsiwJBAtxAzuClOs
 UsUAr+E8tlvGnafRQCa8oIL8MMPEPuEBgTcwyyfJ0J7eO53TZvLTBcWusWTU78RBLdTZ
 YdZhoCRjzjZSi4OYN8XSr3xj41dwZXJYo+8lF/SVffTAOWo6aorTHmn4pCIYoiDLQ+UB
 JdY2jDjHf8U0/U91Eja9MiGvH68knq0henRwsxSc4Ziyd4zXPs06PsQtetBl8QzAWPVL
 ambw==
X-Gm-Message-State: AOJu0Yx788kO97qW4/4rIGJkN2NuaVAck9woynv3PL7PLUx3RkuCfjag
 25GLO3xEXotzHe/Ec/uQe75cj3nqBDjSDbV2+H/cb+a/+E7WrljLjKqLzuEun4y/HU7togC6Mw8
 Gi4esIw4seNtfQI3xifZ/ZeCgWHI3unnTqfSVvN3prPUDxLx9MUYZCreu
X-Gm-Gg: AeBDietnlTX7s950Ilbt2sIuETkp/gwqw+QneD774KeyjALXoHcoMC0zwkPnWgzwcmn
 shRn0jSIQQuuijpR8JA7FK0x/ywU5QO1aoNX7j4FS9uu2joHTA3+zYhJmh6jbLUJTBYQ4htON7J
 7njWTK5lzD6d+P86z8AHNXH78kCfnl9lKFyC2SVuRBwp0Dx1nwbpoa8wh1N2T3gA3QiML3nT36p
 +KfKkANYb1taAL85t5uLEGqwNoMUlVylQ8j2UPqHojydNEIlXRGSFbP3ivIPFkW8mhAJY7rF94a
 dZshV9/ej+/RwHvYDqH0zP6iZN/R0fkMyFRcAeZ7aQmHzn0E2u4Ln7rw51bm5WH14WC2HPB3g4T
 mMzVoLuQYkb9X9EdNkJ3W9DY78UdHQDkrwBPhM3u4iJc++Aia9IQW3OA/OA==
X-Received: by 2002:a05:6214:8011:b0:89c:6692:1d83 with SMTP id
 6a1803df08f44-8b025d3ee6cmr4004806d6.3.1776362814510; 
 Thu, 16 Apr 2026 11:06:54 -0700 (PDT)
X-Received: by 2002:a05:6214:8011:b0:89c:6692:1d83 with SMTP id
 6a1803df08f44-8b025d3ee6cmr4004126d6.3.1776362813833; 
 Thu, 16 Apr 2026 11:06:53 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ae6ceb40a5sm41469196d6.42.2026.04.16.11.06.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 11:06:53 -0700 (PDT)
Date: Thu, 16 Apr 2026 14:06:51 -0400
From: Peter Xu <peterx@redhat.com>
To: Juraj Marcin <jmarcin@redhat.com>
Cc: qemu-devel@nongnu.org, "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Zhiyi Guo <zhguo@redhat.com>, Prasad Pandit <ppandit@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Kirti Wankhede <kwankhede@nvidia.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Joao Martins <joao.m.martins@oracle.com>,
 Markus Armbruster <armbru@redhat.com>, Alex Williamson <alex@shazbot.org>
Subject: Re: [PATCH 08/14] migration: Make qemu_savevm_query_pending()
 available anytime
Message-ID: <aeElO8Wkkbqh439l@x1.local>
References: <20260408165559.157108-1-peterx@redhat.com>
 <20260408165559.157108-9-peterx@redhat.com>
 <adfegWEjLcGmDTPi@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <adfegWEjLcGmDTPi@fedora>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Apr 09, 2026 at 07:15:28PM +0200, Juraj Marcin wrote:
> On 2026-04-08 12:55, Peter Xu wrote:
> > After qemu_savevm_query_pending() be exposed to more code paths, it can be
> > used at very early stage when migration started and this may expose some
> > race conditions that we don't use to have.  This patch make it prepared
> > for such use cases so this API is fine to be used almost anytime.
> > 
> > What matters here is, querying pending for each module normally depends on
> > save_setup() being run first, otherwise modules may not be ready for the
> > query request.
> > 
> > Consider an early cancellation of migration after SETUP status but before
> > invocations of save_setup() hooks, source QEMU may fall into CANCELLING
> > stage directly from SETUP (not ACTIVE, which is the normal use case), in
> > which case save_setup() may not have been invoked and modules are not
> > ready.  However qemu_savevm_query_pending() may still be used in QMP
> > commands like query-migrate and causing crashes.
> > 
> > Guard such use case by introducing a boolean reflecting the availability of
> > vmstate save handlers on correct completions of save_setup()s.  So far,
> > only protect qemu_savevm_query_pending() with it.  Logically other hooks
> > face similar concern, but most of them shouldn't be reachable from random
> > code path except migration thread so it should be fine.
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  migration/migration.h |  8 ++++++++
> >  migration/savevm.h    |  2 +-
> >  migration/migration.c |  2 +-
> >  migration/savevm.c    | 37 +++++++++++++++++++++++++++++++++----
> >  4 files changed, 43 insertions(+), 6 deletions(-)
> > 
> > diff --git a/migration/migration.h b/migration/migration.h
> > index b6888daced..e504df6915 100644
> > --- a/migration/migration.h
> > +++ b/migration/migration.h
> > @@ -522,6 +522,14 @@ struct MigrationState {
> >       * anything as input.
> >       */
> >      bool has_block_bitmap_mapping;
> > +
> > +    /*
> > +     * This boolean reflects if the vmstate handlers have been properly
> > +     * setup on source side.  It is set after vmstate save_setup() hooks
> > +     * are successfully invoked, and cleared after save_cleanup()s.  It
> > +     * reflects a general availability of vmstate hooks on the source side.
> > +     */
> > +    bool save_setup_ready;
> >  };
> >  
> >  void migrate_set_state(MigrationStatus *state, MigrationStatus old_state,
> > diff --git a/migration/savevm.h b/migration/savevm.h
> > index 96fdf96d4e..04ed09cec2 100644
> > --- a/migration/savevm.h
> > +++ b/migration/savevm.h
> > @@ -42,7 +42,7 @@ int qemu_savevm_state_resume_prepare(MigrationState *s);
> >  void qemu_savevm_send_header(QEMUFile *f);
> >  void qemu_savevm_state_header(QEMUFile *f);
> >  int qemu_savevm_state_iterate(QEMUFile *f, bool postcopy);
> > -void qemu_savevm_state_cleanup(void);
> > +void qemu_savevm_state_cleanup(MigrationState *s);
> >  void qemu_savevm_state_complete_postcopy(QEMUFile *f);
> >  int qemu_savevm_state_complete_precopy(MigrationState *s);
> >  void qemu_savevm_query_pending(MigPendingData *pending, bool exact);
> > diff --git a/migration/migration.c b/migration/migration.c
> > index bb17bd0e68..a9ee3360e1 100644
> > --- a/migration/migration.c
> > +++ b/migration/migration.c
> > @@ -1283,7 +1283,7 @@ static void migration_cleanup(MigrationState *s)
> >      g_free(s->hostname);
> >      s->hostname = NULL;
> >  
> > -    qemu_savevm_state_cleanup();
> > +    qemu_savevm_state_cleanup(s);
> >      cpr_state_close();
> >      cpr_transfer_source_destroy(s);
> >  
> > diff --git a/migration/savevm.c b/migration/savevm.c
> > index b75c311a95..1d3fce45b9 100644
> > --- a/migration/savevm.c
> > +++ b/migration/savevm.c
> > @@ -1387,7 +1387,8 @@ int qemu_savevm_state_non_iterable_early(QEMUFile *f,
> >      return 0;
> >  }
> >  
> > -static int qemu_savevm_state_setup(QEMUFile *f, Error **errp)
> > +static int qemu_savevm_state_setup(MigrationState *s, QEMUFile *f,
> > +                                   Error **errp)
> >  {
> >      SaveStateEntry *se;
> >      int ret;
> > @@ -1409,6 +1410,13 @@ static int qemu_savevm_state_setup(QEMUFile *f, Error **errp)
> >          }
> >      }
> >  
> > +    /*
> > +     * Logically, it should be paired with any hook being used who needs to
> > +     * load_acquire() the flag first.  So far, only save_query_pending()
> > +     * uses it.
> > +     */
> > +    qatomic_store_release(&s->save_setup_ready, true);
> 
> What other savevm functions would benefit from this? Would it make sense
> to include them in this patch/series?

I don't yet know any other hook would need this.

AFAIU, the rational is most of the hooks should only be invoked in
migration_thread(), where it's always guaranteed that save_setup() is
always done before hand.

Here, when we make save_query_pending() to be more flexible to be able to
get invoked in QMP handlers, then it opens the races and only that hook is
special.

We actually have another option, which is to keep another cached variable
for global remaining data, then only update it in migration_thread().  Then
it will keep the rational as before.

But then that var will only be used for this purpose, and I thought it
might also be confusing: remember that we have per-module counter caches
already for querying the remaining data fields, like what RAM and VFIO do.

So I chose the current approach.  Let me know what you think.

Thanks,

-- 
Peter Xu


