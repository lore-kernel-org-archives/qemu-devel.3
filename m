Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCD80C02183
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2025 16:30:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXNKA-0007S6-C1; Mon, 13 Jan 2025 11:29:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tXNK7-0007L1-6D
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 11:29:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tXNK5-0003nI-KH
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 11:29:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736785791;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xjlYvkcRZyAlvewrpdlAZ1wrDvLOLiZ07Cp5ONCqP8k=;
 b=iUenu+AY4MZIcx9ueLPeyTN92VH5yqTr6CgWIHtljkzaDGX3nMqxiIqCaVuD6JuMiWGvxW
 ONGWSpIy26Bqgbe/Dc6W31fJzTSLgZ+C4cBW7O/lDfAONDWwYHd8c4aB6yKxbDKP13msAu
 w1WcBgVRJ68ohxI5m0X1+5NfznuZowo=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-40EOzY3cMue6Qzuf6vCA3A-1; Mon, 13 Jan 2025 11:29:50 -0500
X-MC-Unique: 40EOzY3cMue6Qzuf6vCA3A-1
X-Mimecast-MFC-AGG-ID: 40EOzY3cMue6Qzuf6vCA3A
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-46799aa9755so112970421cf.0
 for <qemu-devel@nongnu.org>; Mon, 13 Jan 2025 08:29:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736785790; x=1737390590;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xjlYvkcRZyAlvewrpdlAZ1wrDvLOLiZ07Cp5ONCqP8k=;
 b=s9/2uEfEgcJ993B9CyO/PFrY2GJvZPRAmLGhHNIh75PsB1W/fTTT+DwuawahRGTja5
 Z4Q43M0PB4yXVUS0sPAiHh0JETtAEF5UAtTBu6yxUq5OqATW0PRa1SqGoS/hey49LZH5
 t98LieG00MCOxsmlqCwVE4mQZdTaSiKQabbx7PmqiaOEUzECojw0Vp8nlB5gexQACxks
 PDaplImLI+Bz70aW5iVUE82cwb/Q3cdkfsvYpMrtOaRTTx2Tkra88bFw4JNoKjzckhtK
 FDhCeLWm8BoDP7kiH9/wOHl0F6FkGuq5xtpo9YVkBEAYfwG0Ip3K5sFMahw5Q5yriAT/
 MhiA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV51F5HKlaAuhEerY9RiZuX++ZjClR2HTdMLbMDK75jhKRvJFiRDwwUdCeaar3dhgQz+yGPTRULf3ue@nongnu.org
X-Gm-Message-State: AOJu0YxBq94SefHBJ90B4Gnngss0wuhRQM7ikN7M2TzNgFdiD3F8/Bfv
 23mletuY6B2nWUTR/CanJQ/MRPg0qPjfT6gqHAEo4sg7BsZ52ctfJfrlK/tmkv6XVicDsrOesqn
 I+fxtH4GM/QXAKrp2pHLBlgeTMQHTUh+lSGqryMWRp8d0uMcJeI0o
X-Gm-Gg: ASbGncvuJ/DFTFyUSTq7hH8TGRMLKXRIs7J4m28QAMX+iYToEBLWQ/lZo9cjh7IzZB6
 YqS1vVqGjbro3n/sKQ5UG1uiznI49B/5RnBreAvreXmq9D5/tQ+0G+v1dqW3VF6lO69s8v8Q1bU
 KTaN9a1TmLKblivIx5+bfZ5DK4uLjjhACa/g5xzTFMnljreYKuh/bBPdegFNu/rIoPswje+b5T5
 /SWLVrVcmXxYbxy6K+tjkV6o85ICn8s7w9+FEoB50HWH3ykesbub4jCViAa9mQ3PmvrhTLQv7Ih
 A3T0KkoOuMSzqJvsjA==
X-Received: by 2002:ac8:574a:0:b0:466:957c:ab22 with SMTP id
 d75a77b69052e-46c71081973mr375009631cf.43.1736785790072; 
 Mon, 13 Jan 2025 08:29:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHWPavhxYLLacbpC+4VVER5Hv8CwT7VARAtos+QGtGdohgWu2fqBnTGD2nE+frq/GzXo2qSaw==
X-Received: by 2002:ac8:574a:0:b0:466:957c:ab22 with SMTP id
 d75a77b69052e-46c71081973mr375009181cf.43.1736785789617; 
 Mon, 13 Jan 2025 08:29:49 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dfad85f6a7sm43302526d6.23.2025.01.13.08.29.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jan 2025 08:29:48 -0800 (PST)
Date: Mon, 13 Jan 2025 11:29:46 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Shivam Kumar <shivam.kumar1@nutanix.com>, qemu-devel@nongnu.org
Subject: Re: [RFC PATCH] Fix race in live migration failure path
Message-ID: <Z4U_emPVDfTb1VmF@x1n>
References: <20250110100707.4805-1-shivam.kumar1@nutanix.com>
 <87frlqerxp.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87frlqerxp.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.019,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.787,
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

On Fri, Jan 10, 2025 at 10:09:38AM -0300, Fabiano Rosas wrote:
> Shivam Kumar <shivam.kumar1@nutanix.com> writes:
> 
> > Even if a live migration fails due to some reason, migration status
> > should not be set to MIGRATION_STATUS_FAILED until migrate fd cleanup
> > is done, else the client can trigger another instance of migration
> > before the cleanup is complete (as it would assume no migration is
> > active) or reset migration capabilities affecting old migration's
> > cleanup. Hence, set the status to 'failing' when a migration failure
> > happens and once the cleanup is complete, set the migration status to
> > MIGRATION_STATUS_FAILED.
> >
> > Signed-off-by: Shivam Kumar <shivam.kumar1@nutanix.com>
> > ---
> >  migration/migration.c | 49 +++++++++++++++++++++----------------------
> >  migration/migration.h |  9 ++++++++
> >  migration/multifd.c   |  6 ++----
> >  migration/savevm.c    |  7 +++----
> >  4 files changed, 38 insertions(+), 33 deletions(-)
> >
> > diff --git a/migration/migration.c b/migration/migration.c
> > index df61ca4e93..f084f54f6b 100644
> > --- a/migration/migration.c
> > +++ b/migration/migration.c
> > @@ -1143,8 +1143,9 @@ static bool migration_is_active(void)
> 
> migration_is_running() is the one that gates qmp_migrate() and
> qmp_migrate_set_capabilities().
> 
> >  {
> >      MigrationState *s = current_migration;
> >  
> > -    return (s->state == MIGRATION_STATUS_ACTIVE ||
> > -            s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE);
> > +    return ((s->state == MIGRATION_STATUS_ACTIVE ||
> > +            s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE) &&
> > +            !qatomic_read(&s->failing));
> >  }
> >  
> >  static bool migrate_show_downtime(MigrationState *s)
> > @@ -1439,6 +1440,11 @@ static void migrate_fd_cleanup(MigrationState *s)
> >                            MIGRATION_STATUS_CANCELLED);
> >      }
> >  
> > +    if (qatomic_xchg(&s->failing, 0)) {
> > +        migrate_set_state(&s->state, s->state,
> > +                          MIGRATION_STATUS_FAILED);
> > +    }
> 
> I hope you've verified that sure every place that used to set FAILED
> will also reach migrate_fd_cleanup() eventually.
> 
> Also, we probably still need the FAILING state. Otherwise, this will
> trip code that expects a state change on failure. Anything that does:
> 
> if (state != MIGRATION_STATUS_FOO) {
>    ...
> }
> 
> So I think the change overall should be
> 
> -migrate_set_state(&s->state, s->state, MIGRATION_STATUS_FAILED);
> +migrate_set_state(&s->state, s->state, MIGRATION_STATUS_FAILING);
> 
>  void migrate_set_state(MigrationStatus *state, MigrationStatus old_state,
>                         MigrationStatus new_state)
>  {
>      assert(new_state < MIGRATION_STATUS__MAX);
>      if (qatomic_cmpxchg(state, old_state, new_state) == old_state) {
>          trace_migrate_set_state(MigrationStatus_str(new_state));
> 
> +        if (new_state == MIGRATION_STATUS_FAILING) {
> +            qatomic_set(&s->failing, 1);
> +        }
>          migrate_generate_event(new_state);
>      }
>  }
> 
> And we should proably do the same for CANCELLING actually, but there the
> (preexisting) issue is actual concurrency, while here it's just
> inconsistency in the state.

Yes something like FAILING sounds reasonable.  Though since we have
s->error, I wonder whether that's a better place to represent a migration
as "failing" in one place, because otherwise we need to set two places
(both FAILING state, and the s->error) - whenever something fails, we'd
better always update s->error so as to remember what failed, then reported
via query-migrate.

From that POV, s->failing is probably never gonna be needed (due to
s->error being present anyway)?  So far, such Error* looks like the best
single point to say that the migration is failing - it also enforces the
Error to be provided whoever wants to set it to failing state.

-- 
Peter Xu


