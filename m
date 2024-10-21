Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D144AD15DB4
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 15:51:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2ugq-0003cB-D1; Mon, 21 Oct 2024 11:51:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t2ugn-0003bm-Rj
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 11:51:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t2ugj-0000SC-Oh
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 11:51:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729525864;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UdG9fQBX5PHZQWPcOAe4MXXswo4R3WVcBcYZSai5+Jg=;
 b=P3APTMSJKbrjZT3SugSGscQR+clVRthkdOKSn0NqXTSYxR9koBseb/Rjj78N24/rVKRtRE
 vplB4WVn95kflNbrs5SpWW0lmurzCD090BxRUdzCNAKZx9cd/tyALG5IykilDoWs4ul+dy
 g0GeRbQgbuCHKfCArFOnjt3dbehVfuI=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-520-GOspS7BzMn-CNBaJ0cK3WQ-1; Mon, 21 Oct 2024 11:51:03 -0400
X-MC-Unique: GOspS7BzMn-CNBaJ0cK3WQ-1
Received: by mail-oi1-f199.google.com with SMTP id
 5614622812f47-3e05074e733so3436257b6e.2
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 08:51:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729525862; x=1730130662;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UdG9fQBX5PHZQWPcOAe4MXXswo4R3WVcBcYZSai5+Jg=;
 b=VASE05zKjdgudrH6JQVRAka3Wcs75joVga9e/ql4XE/f93C7hdOIeEqEhf64oPC70s
 n5og7o6v/q+jrQ5uzyOB4hgQNEaZ7PdpztY5XGaKJUS/1wjFmUjQbUbxWHlt/bF5+WwM
 jnDxO4iB5sZFJY9haSf2SGwwaDYLjR2UM9GRWTTCByIBWC2Y2IFjAILTlSrCWL3pCrLJ
 kfBhfpJfuEZwCTTRZjGHCAkLWVvxESBTakrdFxVXnpaU/jg6l3LbFfdNcT98zSVqaxgn
 rG2FOgVDRWzRxaB6a6aQ9VNEcaIh072Uh/gictgU+y0FW9riHx36x5k4p037OJocyJ61
 M8WQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUbJxjoyOVaJoorJFrlurqmNgBGhhgoyIO2hlqb81nnsrp5BwrfQjA7SpWSK5OjqFfvtj4v9VvZwAbT@nongnu.org
X-Gm-Message-State: AOJu0YxWLaEQ1Y1sTZPzvnS1K5RDmCSx68GdbLfJR7u0jWm2/i0+Oc/p
 +AvDpATVmtPOFoBKmHbBCmm5o92SB6k4C0mNL52ybwBH2/bw3j3yeP8iPGwf94k/RLmK7P0sLis
 70GBYl/RE61VdpamnQMlsi/miRi6tBftVbEuWabu2O9+67cZbSJHX
X-Received: by 2002:a05:6808:2e49:b0:3e5:fd66:c16b with SMTP id
 5614622812f47-3e602da08aamr10316530b6e.33.1729525862478; 
 Mon, 21 Oct 2024 08:51:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZK0b1PLZ3XWAiPejF6udFO8/tXlScuaFsBjf8iDyTYoUx5M4iQQh2wDloZhFvqTEbm/N8sw==
X-Received: by 2002:a05:6808:2e49:b0:3e5:fd66:c16b with SMTP id
 5614622812f47-3e602da08aamr10316511b6e.33.1729525862087; 
 Mon, 21 Oct 2024 08:51:02 -0700 (PDT)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-460d3d69448sm18806861cf.65.2024.10.21.08.51.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Oct 2024 08:51:01 -0700 (PDT)
Date: Mon, 21 Oct 2024 11:50:59 -0400
From: Peter Xu <peterx@redhat.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Cc: Avihai Horon <avihaih@nvidia.com>, qemu-devel@nongnu.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH 2/3] vfio/migration: Refactor
 vfio_vmstate_change/_prepare() error reporting
Message-ID: <ZxZ4Y5KSNPcuN8-X@x1n>
References: <20241020130108.27148-1-avihaih@nvidia.com>
 <20241020130108.27148-3-avihaih@nvidia.com>
 <cfca06dd-cfd3-4a36-a80f-b8e2ddecbf88@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cfca06dd-cfd3-4a36-a80f-b8e2ddecbf88@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.421,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Oct 21, 2024 at 05:14:11PM +0200, Cédric Le Goater wrote:
> Hello Avihai,
> 
> On 10/20/24 15:01, Avihai Horon wrote:
> > When the VM is shut down vfio_vmstate_change/_prepare() are called to
> > transition the VFIO device state to STOP. They are called after
> > migration_shutdown() and thus, by this time, the migration object is
> > already freed (more specifically, MigrationState->qemu_file_lock is
> > already destroyed).
> > 
> > In this case, if there is an error in vfio_vmstate_change/_prepare(), it
> > calls migration_file_set_error() which tries to lock the already
> > destroyed MigrationState->qemu_file_lock, leading to the following
> > assert:
> > 
> >    qemu-system-x86_64: ../util/qemu-thread-posix.c:92: qemu_mutex_lock_impl: Assertion `mutex->initialized' failed.
> > 
> > Fix this by not setting migration file error in the shut down flow.
> > 
> > Fixes: 20c64c8a51a4 ("migration: migration_file_set_error")
> > Signed-off-by: Avihai Horon <avihaih@nvidia.com>
> > ---
> >   hw/vfio/migration.c | 31 +++++++++++++++++++++----------
> >   1 file changed, 21 insertions(+), 10 deletions(-)
> > 
> > diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> > index 992dc3b102..1c44b036ea 100644
> > --- a/hw/vfio/migration.c
> > +++ b/hw/vfio/migration.c
> > @@ -783,6 +783,25 @@ static const SaveVMHandlers savevm_vfio_handlers = {
> >   /* ---------------------------------------------------------------------- */
> > +static void vfio_vmstate_change_error_report(int ret, Error *err,
> > +                                             RunState state)
> > +{
> > +    if (state == RUN_STATE_SHUTDOWN) {
> > +        /*
> > +         * If VM is being shut down, migration object might have already been
> > +         * freed, so just report the error.
> > +         */
> > +        error_report_err(err);
> > +        return;
> > +    }
> > +
> > +    /*
> > +     * Migration should be aborted in this case, but vm_state_notify()
> > +     * currently does not support reporting failures.
> > +     */
> > +    migration_file_set_error(ret, err);
> > +}
> 
> This seems correct, but testing the machine's runtime state to
> work around the fact that 'current_migration' is not safe to
> use reveals a flaw.
> 
> In vfio, migration_is_setup_or_active() is unsafe. So are the
> calls to vfio_set_migration_error().
> 
> 
> This comment seems in contradiction with the migration code :
> 
> /* When we add fault tolerance, we could have several
>    migrations at once.  For now we don't need to add
>    dynamic creation of migration */
> 
> Why is 'current_migration' allocated and destroyed today ?
> 
> Could we replace it with a singleton and switch the state to
> MIGRATION_STATUS_NONE instead of destroying it ?
> 
> If not, should 'current_migration' be set to NULL in
> migration_shutdown() and its value tested before accessing
> to any of its fields, in a thread safe manner if necessary.

IIUC the migration thread should always see valid migration object, as it
takes one refcount at the entrance of migration_thread():

    object_ref(OBJECT(s));

So it's not yet clear to me on why the mutex was destroyed, if the main
object should still be there; logically it was only destroyed in the
finalize phase (migration_instance_finalize), but that should be after
migration thread quits and releases the refcount..

-- 
Peter Xu


