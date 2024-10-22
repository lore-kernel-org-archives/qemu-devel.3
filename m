Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16A95D2C55E
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 14:29:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3Fsq-0000v5-Ot; Tue, 22 Oct 2024 10:29:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t3Fsp-0000ut-0G
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 10:29:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t3Fsm-0006v1-MA
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 10:29:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729607350;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A9h5FlJXK1PZMKGTI1dS7xnKw7RMFo8clhpGhwmwODA=;
 b=Ny9muN0Agk1iVwn6K/TNhAzUUqYufQAwpnGMpbaDeDsZZpEQu1YKXsJVdisr75CKEGDcqF
 MsN//E3edA68RzAGmpW3JSxkjbcSVUqf52AN/cW0MlooJiiRI7Yb0KRkfm6C6vz5TQG9KK
 r8OH2Btl5UIYbjJbtjRyFwAAS0fCDfA=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-437-17UNro8WOAaeR_KMn6kLxA-1; Tue, 22 Oct 2024 10:29:09 -0400
X-MC-Unique: 17UNro8WOAaeR_KMn6kLxA-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6cc10cd78e4so90628506d6.3
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2024 07:29:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729607349; x=1730212149;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=A9h5FlJXK1PZMKGTI1dS7xnKw7RMFo8clhpGhwmwODA=;
 b=PtnWeDt+y55CYJ+54SVNcCqvMCUZZWxJJeVLMVMKpqh3zv0J6c6DOHJH8Q3acozjXx
 Pw0ADYXdxySUSk1hQas44UEWHGRw4dQmYjcj5Hc0wyYZzn0cGKbnFFEQ0mkDdoUPjCt7
 +RlFm1Q/fm2KH8AGNYEQYOxLZY/QbAuybLsBzpKFaiwrMDM35HK7/SJyoJgBe7Osygbi
 fv4wUUlibatOdlE3N1N/Py2Nz3JrmL936fwP5XCSbXxREZzS7XW9SE4mP2oPwt/L0i+4
 st0wZ6HncLqX33tP7IScUtrnJ/114h12hkS9/K01QYeHYvHLVMD4v3JSsJpEcx88TtMP
 U8IA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVOXZ8U8wWGj7qXJSDe/tyYmlgT5yt2kM5+E8lFtyOOs5mF60Cuwjo7+5iSkoUbVb2oFxrNM+M6k6tR@nongnu.org
X-Gm-Message-State: AOJu0Yyvkg/PF1aq9YsnCic8PiEqcvd+X4j/RkDyAIvvlNeL+n2YU3uR
 n2uIEFqKG+E6q98TxEiK/AHjBe9cFTr5eqXBBJDuJczY3+9XKOb3IpjpBSNX36T0MKi+SJtWnqq
 gjk2WnY5SbuJCbRNOfex60cC/H1S7u+dhNf+VPz+E0bhaSuLLfoUa
X-Received: by 2002:a05:6214:4b04:b0:6cb:eea5:69e0 with SMTP id
 6a1803df08f44-6cde1540c7dmr236016206d6.27.1729607348899; 
 Tue, 22 Oct 2024 07:29:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF2w4uDJyfAqHmjX0xT5Xf3VmXAgO1RYcz/vkoT5ev6ywdNpPq3f2QVBBThWtBO+t+LDhWfBA==
X-Received: by 2002:a05:6214:4b04:b0:6cb:eea5:69e0 with SMTP id
 6a1803df08f44-6cde1540c7dmr236015776d6.27.1729607348512; 
 Tue, 22 Oct 2024 07:29:08 -0700 (PDT)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6ce009e26cdsm29371316d6.122.2024.10.22.07.29.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2024 07:29:07 -0700 (PDT)
Date: Tue, 22 Oct 2024 10:29:05 -0400
From: Peter Xu <peterx@redhat.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Cc: Avihai Horon <avihaih@nvidia.com>, qemu-devel@nongnu.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH 2/3] vfio/migration: Refactor
 vfio_vmstate_change/_prepare() error reporting
Message-ID: <Zxe2sZLyIa3XbVeZ@x1n>
References: <20241020130108.27148-1-avihaih@nvidia.com>
 <20241020130108.27148-3-avihaih@nvidia.com>
 <cfca06dd-cfd3-4a36-a80f-b8e2ddecbf88@redhat.com>
 <ZxZ4Y5KSNPcuN8-X@x1n>
 <68d60abe-32b6-49b3-bc60-6c92909252f0@redhat.com>
 <ZxaHPo7GRPuby5ky@x1n>
 <3e0d59e7-699e-47b2-a6dc-204d64e07895@nvidia.com>
 <d172a1b8-9e6f-42ef-a78c-decb5c9a2944@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d172a1b8-9e6f-42ef-a78c-decb5c9a2944@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.519,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.697,
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

On Tue, Oct 22, 2024 at 03:24:56PM +0200, Cédric Le Goater wrote:
> On 10/22/24 11:38, Avihai Horon wrote:
> > 
> > On 21/10/2024 19:54, Peter Xu wrote:
> > > External email: Use caution opening links or attachments
> > > 
> > > 
> > > On Mon, Oct 21, 2024 at 06:43:13PM +0200, Cédric Le Goater wrote:
> > > > Hello,
> > > > 
> > > > > IIUC the migration thread should always see valid migration object, as it
> > > > > takes one refcount at the entrance of migration_thread():
> > > > > 
> > > > >       object_ref(OBJECT(s));
> > > > Could the migration have failed before ? in migrate_fd_connect()
> > > I just noticed it's a vm state change notifier..
> > 
> > Yep.
> > I stumbled upon this bug by accident when running on a buggy machine.
> > Migration wasn't involved, I just started the VM, shut it down and got the assert (as my VFIO device was faulty and errored on RUNNING->STOP state change).
> > 
> > You can repro it by forcefully triggering an error on *->STOP transition:
> > 
> > diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> > index 17199b73ae..d41cb7c634 100644
> > --- a/hw/vfio/migration.c
> > +++ b/hw/vfio/migration.c
> > @@ -831,7 +831,9 @@ static void vfio_vmstate_change(void *opaque, bool running, RunState state)
> >       }
> > 
> >       ret = vfio_migration_set_state_or_reset(vbasedev, new_state, &local_err);
> > -    if (ret) {
> > +    if (ret || new_state == VFIO_DEVICE_STATE_STOP) {
> > +        ret = -1;
> > +        error_setg(&local_err, "%s: forced error", vbasedev->name);
> >           /*
> >            * Migration should be aborted in this case, but vm_state_notify()
> >            * currently does not support reporting failures.
> > 
> > > 
> > > If so, maybe VFIO could refer to its internal states showing that it's
> > > during a migration first (so as to guarantee the migration object is valid;
> > > e.g., only after save_setup() but before save_cleanup() hooks are invoked).
> > 
> > It's an option, but I think it's a bit awkward as we'd need to check
> > that VFIOMigration->data_buffer is set
> 
> That's what I was looking at too. It works. It feels a bit awkward
> indeed. We could hide the details in an helper routine though.
> 
> > or add a new flag.
> 
> yes that's another solution.
> 
> Peter,
> 
> I wonder if we could grab a ref on current_migration in save_setup(),
> store it under VFIOMigration and drop it save_cleanup() ?

VFIO can definitely do that, but I am not sure how that would help.. as I
think the migration object can never go away anyway during setup->cleanup,
so taking that extra refcount shouldn't change anything.

IOW, AFAICT this bug is triggered only when without migration at all.

> 
> 
> > Besides that, as Cedric pointed out, VFIO code calls migration_is_setup_or_active() which can also be unsafe, as it might be invoked after migration object has been freed.
> > 
> > Maybe a simpler solution would be to extend the the migration object lifetime?
> > Looking at commit history, you can see that commit 1f8956041ad3 ("migration: finalize current_migration object") added migration object finalization at the very end of qemu cleanup.
> > Then came commit 892ae715b6bc ("migration: Cleanup during exit") and moved the migration object finalization to the beginning of qemu cleanup (before stopping the VM etc.).
> > 
> > If so, the fix could be something like the below?
> > 
> > -------------8<-------------
> > diff --git a/include/migration/misc.h b/include/migration/misc.h
> > index bfadc5613b..5eb099349a 100644
> > --- a/include/migration/misc.h
> > +++ b/include/migration/misc.h
> > @@ -52,6 +52,7 @@ void dump_vmstate_json_to_file(FILE *out_fp);
> > 
> >   /* migration/migration.c */
> >   void migration_object_init(void);
> > +void migration_object_finalize(void);
> >   void migration_shutdown(void);
> >   bool migration_is_idle(void);
> >   bool migration_is_active(void);
> > diff --git a/migration/migration.c b/migration/migration.c
> > index 021faee2f3..9eaa7947bc 100644
> > --- a/migration/migration.c
> > +++ b/migration/migration.c
> > @@ -265,6 +265,11 @@ void migration_object_init(void)
> >       dirty_bitmap_mig_init();
> >   }
> > 
> > +void migration_object_finalize(void)
> > +{
> > +    object_unref(OBJECT(current_migration));
> > +}
> > +
> >   typedef struct {
> >       QEMUBH *bh;
> >       QEMUBHFunc *cb;
> > @@ -330,7 +335,6 @@ void migration_shutdown(void)
> >        * stop the migration using this structure
> >        */
> >       migration_cancel(NULL);
> > -    object_unref(OBJECT(current_migration));
> > 
> >       /*
> >        * Cancel outgoing migration of dirty bitmaps. It should
> > diff --git a/system/runstate.c b/system/runstate.c
> > index c2c9afa905..fa823f5e72 100644
> > --- a/system/runstate.c
> > +++ b/system/runstate.c
> > @@ -930,5 +930,6 @@ void qemu_cleanup(int status)
> >       monitor_cleanup();
> >       qemu_chr_cleanup();
> >       user_creatable_cleanup();
> > +    migration_object_finalize();
> >       /* TODO: unref root container, check all devices are ok */
> >   }
> > -------------8<-------------
> 
> 892ae715b6bc was trying to fix potential use-after-free issues.
> 
> I think it is safer to introduce an helper routine checking
> (in some ways) if a migration is in progress than partially
> revert 892ae715b6bc.

Right, Dave also mentioned something in 892ae715b6bc about moving it
earlier:

    We do this a bit earlier; so hopefully migration gets out of the way
    before all the devices etc are freed.

But I don't know the relationship on device free() v.s. the migration
object.  We might at least want to figure that out if we want to move it
again.

I notice that vdpa also started using migration_is_setup_or_active(), so if
it's used in more places, maybe indeed we can consider making them safe to
be called at any phase of QEMU.

Logically it is safe in vm state change hook always because it has the BQL
and the object can only be freed when with BQL.

So let me send a small patch later to hopefully make all these exported
functions (including migration_file_set_error() in this case, logically
anything in migration/misc.h) safe to be called without migration.

-- 
Peter Xu


