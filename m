Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63290CAC582
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Sep 2025 19:28:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uw40b-0006fE-Hz; Tue, 09 Sep 2025 15:28:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uw40a-0006ek-07
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 15:28:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uw40Q-0005Ce-Q7
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 15:28:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757446071;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vARidZmodf2YAIC9/kKg1LPimeyNZoB9AHK53ZlGlWY=;
 b=SND9b1PVK/ch3Qpl/xmA2FDerPG78FL347nS/xWNYqFpyHHTn9/g0gDNKbDG3seeDrrXEZ
 U3qMKZIfoNbnOZ953jDXDXXy3KBwO2PMvzsvLmYjMSCf3sG6oO5Y2ot0fx8SRJjn1QfZLB
 oG7W5rQd9SDBhTM1ilrdDvtNPZrT7Ao=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-392-OMh-56DyM7qnBL4c_jtkyw-1; Tue, 09 Sep 2025 15:27:50 -0400
X-MC-Unique: OMh-56DyM7qnBL4c_jtkyw-1
X-Mimecast-MFC-AGG-ID: OMh-56DyM7qnBL4c_jtkyw_1757446070
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-80acebb7cb7so1558547085a.3
 for <qemu-devel@nongnu.org>; Tue, 09 Sep 2025 12:27:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757446069; x=1758050869;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vARidZmodf2YAIC9/kKg1LPimeyNZoB9AHK53ZlGlWY=;
 b=ASA4xpyGno1GgvLJ6dzRzsua+55LIO46BM/ptYbRt5fjNSDgqpR9tEQ/HmYJjX5OV/
 Qp6cnbvlItkCNHMe4kaoFqbrgVLeuQoA6HDd70t/rbu/aF8UbBl07zDcZG3Ye71O57UG
 OBiqYANrydY9orCz97joDI4SH9EAFxDtSqkGGwTK0ZkRfuBwkU+eWRMtjKie9l6kjSN6
 6CiobddJ5ViY3IvIp+SWlAK9WsxyqWgS6PsTLPkLK4nSMLXO6INHPEaYrETdWShWrIAc
 W7E2NvKVp3G8tiX66MXPWEanWc+51eINWzmyOW93bujU/8Ov0zHoMZFkZqr3/vK+ihEa
 dygg==
X-Gm-Message-State: AOJu0YzSBXwfjmWa1dtSYNVAanx0pi+9YyLDnE6CDapoSzr3bUI3qe6M
 Yrq7VPE03gVL/0Z3Ea1P8gijW1PqmT9aOjYeMIbOrqCFrqQUzH26IEWycbK7luc0mNuhGZxC+KS
 nyvj7anQxBkFig7mSCT8w2wzbdm0DJP748z94wQmBqXvtJXHTSfIvvkMFmasZAm9q
X-Gm-Gg: ASbGnctaGD7v1HIc5Eh1jud/0cWL2s9iucAHesQi+N3plz7JJDF8cp7kkdrTaCdZeAj
 5sz2mdOobDGNmyEjP/5XAqqqC5E8d075XaGW70Zp6n9QA8eq2SWFVIsfuFQnb3TV9qHv9fXgfp4
 sIdhS1HdpLMvbcPFEQsjZ7u+Qx/ILvTEuLObkQul27aptpdVSqNda/9CU8kpSw5o2hjOzA46SyF
 NSYeUeNqbfB7SAMOnfcEQrhgCbon+pw3bBD/Tc1E2Udy/CBxgwk+ZyzmGqinQMV2r+e5Ti7OAlf
 s71TvjbrfITYDfHJTkJJeS08AKyBHz9WBwmpTe1nR3iy5y6uxLCRSvAIhy5YUHx3Mn75kFmNw5B
 /RKPd6xiu0EhiOq7eUGmwHg==
X-Received: by 2002:a05:620a:17a7:b0:817:90e0:abc8 with SMTP id
 af79cd13be357-81790e0afadmr998626385a.24.1757446069135; 
 Tue, 09 Sep 2025 12:27:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGu7u8D30SmriRDOGqQ9rldBxWVZ7eCKIilJOZK4v6WFfgBTpoc7Fe9aOXmP1oRl8wXnzqDMA==
X-Received: by 2002:a05:620a:17a7:b0:817:90e0:abc8 with SMTP id
 af79cd13be357-81790e0afadmr998621685a.24.1757446068339; 
 Tue, 09 Sep 2025 12:27:48 -0700 (PDT)
Received: from x1.local
 (bras-base-aurron9134w-grc-11-174-89-135-121.dsl.bell.ca. [174.89.135.121])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-81b58c54d9asm166429585a.1.2025.09.09.12.27.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Sep 2025 12:27:47 -0700 (PDT)
Date: Tue, 9 Sep 2025 15:27:46 -0400
From: Peter Xu <peterx@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: Re: [PATCH V3 7/9] migration: cpr-exec mode
Message-ID: <aMB_stJSkPgHzug0@x1.local>
References: <1755191843-283480-1-git-send-email-steven.sistare@oracle.com>
 <1755191843-283480-8-git-send-email-steven.sistare@oracle.com>
 <aMBWjBGPnmz3rtwh@x1.local>
 <60f44830-d306-4dec-8f0d-65d3b32b3a2e@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <60f44830-d306-4dec-8f0d-65d3b32b3a2e@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Tue, Sep 09, 2025 at 02:10:14PM -0400, Steven Sistare wrote:
> On 9/9/2025 12:32 PM, Peter Xu wrote:
> > On Thu, Aug 14, 2025 at 10:17:21AM -0700, Steve Sistare wrote:
> > > Add the cpr-exec migration mode.  Usage:
> > >    qemu-system-$arch -machine aux-ram-share=on ...
> > >    migrate_set_parameter mode cpr-exec
> > >    migrate_set_parameter cpr-exec-command \
> > >      <arg1> <arg2> ... -incoming <uri-1> \
> > >    migrate -d <uri-1>
> > > 
> > > The migrate command stops the VM, saves state to uri-1,
> > > directly exec's a new version of QEMU on the same host,
> > > replacing the original process while retaining its PID, and
> > > loads state from uri-1.  Guest RAM is preserved in place,
> > > albeit with new virtual addresses.
> > > 
> > > The new QEMU process is started by exec'ing the command
> > > specified by the @cpr-exec-command parameter.  The first word of
> > > the command is the binary, and the remaining words are its
> > > arguments.  The command may be a direct invocation of new QEMU,
> > > or may be a non-QEMU command that exec's the new QEMU binary.
> > > 
> > > This mode creates a second migration channel that is not visible
> > > to the user.  At the start of migration, old QEMU saves CPR state
> > > to the second channel, and at the end of migration, it tells the
> > > main loop to call cpr_exec.  New QEMU loads CPR state early, before
> > > objects are created.
> > > 
> > > Because old QEMU terminates when new QEMU starts, one cannot
> > > stream data between the two, so uri-1 must be a type,
> > > such as a file, that accepts all data before old QEMU exits.
> > > Otherwise, old QEMU may quietly block writing to the channel.
> > > 
> > > Memory-backend objects must have the share=on attribute, but
> > > memory-backend-epc is not supported.  The VM must be started with
> > > the '-machine aux-ram-share=on' option, which allows anonymous
> > > memory to be transferred in place to the new process.  The memfds
> > > are kept open across exec by clearing the close-on-exec flag, their
> > > values are saved in CPR state, and they are mmap'd in new QEMU.
> > 
> > Some generic questions around exec..
> > 
> > How do we know we can already safely kill all threads?
> > 
> > IIUC vcpu threads must be all stopped.  I wonder if we want to assert that
> > in the exec helper below.
> > 
> > What about rest threads?  RCU threads should be for freeing resources,
> > looks ok if to be ignored.  But others?
> 
> These threads are dormant, just as they are in the post migration state.
> There is no difference.  They can be safely killed, just as they can be
> post migration.
> 
> > Or would process states still matter in some cases? e.g. when QEMU is
> > talking to another vhost-user, or vfio-user, or virtio-fs, or ... whatever
> > other process, then suddenly the other process doesn't recognize this QEMU
> > anymore?
> 
> These cases need more development to work with cpr.  The external process
> can be used by new qemu if the socket connection (fd) is preserved in new QEMU.
> 
> > What about file locks or similiar shared locks that can be running in an
> > iothread?  Is it possible that old QEMU took some shared locks, suddenly
> > qemu exec(), then the lock is never released?
> 
> Same as the post-migrate state.

IIUC the difference is "migrate" for cpr-transfer triggers migration only;
another "quit" required to gracefully stop the src QEMU instance from mgmt.
But for cpr-exec, it's attached to migration cleanup -> exec in a roll.

I'm not sure if things can be missing within the period.  For example,
libvirt may have logic making sure "quit" runs only after dest QEMU evicts
some event.  But I confess I don't have an explicit example of what would
cause issues, so it's a pure question.

> > > Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> > > ---
> > >   qapi/migration.json       | 25 +++++++++++++++-
> > >   include/migration/cpr.h   |  1 +
> > >   migration/cpr-exec.c      | 74 +++++++++++++++++++++++++++++++++++++++++++++++
> > >   migration/cpr.c           | 26 ++++++++++++++++-
> > >   migration/migration.c     | 10 ++++++-
> > >   migration/ram.c           |  1 +
> > >   migration/vmstate-types.c |  8 +++++
> > >   migration/trace-events    |  1 +
> > >   8 files changed, 143 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/qapi/migration.json b/qapi/migration.json
> > > index ea410fd..cbc90e8 100644
> > > --- a/qapi/migration.json
> > > +++ b/qapi/migration.json
> > > @@ -694,9 +694,32 @@
> > >   #     until you issue the `migrate-incoming` command.
> > >   #
> > >   #     (since 10.0)
> > > +#
> > > +# @cpr-exec: The migrate command stops the VM, saves state to the
> > > +#     migration channel, directly exec's a new version of QEMU on the
> > > +#     same host, replacing the original process while retaining its
> > > +#     PID, and loads state from the channel.  Guest RAM is preserved
> > > +#     in place.  Devices and their pinned pages are also preserved for
> > > +#     VFIO and IOMMUFD.
> > > +#
> > > +#     Old QEMU starts new QEMU by exec'ing the command specified by
> > > +#     the @cpr-exec-command parameter.  The command may be a direct
> > > +#     invocation of new QEMU, or may be a non-QEMU command that exec's
> > > +#     the new QEMU binary.
> > > +#
> > > +#     Because old QEMU terminates when new QEMU starts, one cannot
> > > +#     stream data between the two, so the channel must be a type,
> > > +#     such as a file, that accepts all data before old QEMU exits.
> > > +#     Otherwise, old QEMU may quietly block writing to the channel.
> > 
> > The CPR channel (in case of exec mode) is persisted via env var.  Why not
> > do that too for the main migration stream?
> > 
> > Does it has something to do with the size of the binary chunk to store all
> > device states (and some private mem)?  Or other concerns?
> 
> It was not necessary to add code for a new way to move migration data for
> the main stream when the existing code and interface works just fine.  One
> of the design principles pushed on me was to make cpr look as much like live
> migration as possible, and cpr-exec does that.  It has no issues juggling
> 2 streams, and no delayed start of the monitor. cpr-transfer is actually the
> oddball.
>  > It just feels like it would look cleaner for cpr-exec to not need -incoming
> > XXX at all, e.g. if the series already used envvar anyway, we can use that
> > too so new QEMU would know it's cpr-exec incoming migration, without
> > -incoming parameter at all.
> > >> +#
> > > +#     Memory-backend objects must have the share=on attribute, but
> > > +#     memory-backend-epc is not supported.  The VM must be started
> > > +#     with the '-machine aux-ram-share=on' option.
> > > +#
> > > +#     (since 10.2)
> > >   ##
> > >   { 'enum': 'MigMode',
> > > -  'data': [ 'normal', 'cpr-reboot', 'cpr-transfer' ] }
> > > +  'data': [ 'normal', 'cpr-reboot', 'cpr-transfer', 'cpr-exec' ] }
> > >   ##
> > >   # @ZeroPageDetection:
> > > diff --git a/include/migration/cpr.h b/include/migration/cpr.h
> > > index aaeec02..e99e48e 100644
> > > --- a/include/migration/cpr.h
> > > +++ b/include/migration/cpr.h
> > > @@ -54,6 +54,7 @@ int cpr_get_fd_param(const char *name, const char *fdname, int index, bool cpr,
> > >   QEMUFile *cpr_transfer_output(MigrationChannel *channel, Error **errp);
> > >   QEMUFile *cpr_transfer_input(MigrationChannel *channel, Error **errp);
> > > +void cpr_exec_init(void);
> > >   QEMUFile *cpr_exec_output(Error **errp);
> > >   QEMUFile *cpr_exec_input(Error **errp);
> > >   void cpr_exec_persist_state(QEMUFile *f);
> > > diff --git a/migration/cpr-exec.c b/migration/cpr-exec.c
> > > index 2c32e9c..7d0429f 100644
> > > --- a/migration/cpr-exec.c
> > > +++ b/migration/cpr-exec.c
> > > @@ -6,15 +6,20 @@
> > >   #include "qemu/osdep.h"
> > >   #include "qemu/cutils.h"
> > > +#include "qemu/error-report.h"
> > >   #include "qemu/memfd.h"
> > >   #include "qapi/error.h"
> > >   #include "io/channel-file.h"
> > >   #include "io/channel-socket.h"
> > > +#include "block/block-global-state.h"
> > > +#include "qemu/main-loop.h"
> > >   #include "migration/cpr.h"
> > >   #include "migration/qemu-file.h"
> > > +#include "migration/migration.h"
> > >   #include "migration/misc.h"
> > >   #include "migration/vmstate.h"
> > >   #include "system/runstate.h"
> > > +#include "trace.h"
> > >   #define CPR_EXEC_STATE_NAME "QEMU_CPR_EXEC_STATE"
> > > @@ -92,3 +97,72 @@ QEMUFile *cpr_exec_input(Error **errp)
> > >       lseek(mfd, 0, SEEK_SET);
> > >       return qemu_file_new_fd_input(mfd, CPR_EXEC_STATE_NAME);
> > >   }
> > > +
> > > +static bool preserve_fd(int fd)
> > > +{
> > > +    qemu_clear_cloexec(fd);
> > > +    return true;
> > > +}
> > > +
> > > +static bool unpreserve_fd(int fd)
> > > +{
> > > +    qemu_set_cloexec(fd);
> > > +    return true;
> > > +}
> > > +
> > > +static void cpr_exec(char **argv)
> > > +{
> > > +    MigrationState *s = migrate_get_current();
> > > +    Error *err = NULL;
> > > +
> > > +    /*
> > > +     * Clear the close-on-exec flag for all preserved fd's.  We cannot do so
> > > +     * earlier because they should not persist across miscellaneous fork and
> > > +     * exec calls that are performed during normal operation.
> > > +     */
> > > +    cpr_walk_fd(preserve_fd);
> > > +
> > > +    trace_cpr_exec();
> > > +    execvp(argv[0], argv);
> > > +
> > > +    cpr_walk_fd(unpreserve_fd);
> > > +
> > > +    error_setg_errno(&err, errno, "execvp %s failed", argv[0]);
> > > +    error_report_err(error_copy(err));
> > 
> > Feel free to ignore my question in the other patch, so we dump some errors
> > here.. which makes sense.
> > 
> > > +    migrate_set_state(&s->state, s->state, MIGRATION_STATUS_FAILED);
> > 
> > This is indeed FAILED migration, however it seems to imply it can catch
> > whatever possible failures that incoming could have.  Strictly speaking
> > this is not migration failure, but exec failure..  Maybe we need a comment
> > above this one explaining that we won't be able to capture any migration
> > issues, it's too late after exec() succeeded, so there's higher risk of
> > crashing the VM.
> 
> exec() can fail if the user provided a bogus cpr-exec-command, in which case
> recovery is possible.  exec() should never fail for valid exec arguments,
> unless the system is very sick and running out of resources, in which case
> all bets are off.

I really don't expect that to fail... bogus cpr-exec-command is more or
less a programming bug.  After all, I don't expect normal QEMU users would
use cpr-exec without a proper mgmt providing cpr-exec-command.

Adding some comment here on what the FAILED can capture (and what cannot)?

> 
> > Luckily we still are on the same host, so things like mismatched kernel
> > versions at least won't crash this migration.. aka not as easy to fail a
> > migration as cross- hosts indeed. But still, I'd say I agree with Vladimir
> > that this is a major flaw of the design if so.
> > 
> > > +    migrate_set_error(s, err);
> > > +
> > > +    migration_call_notifiers(s, MIG_EVENT_PRECOPY_FAILED, NULL);
> > > +
> > > +    err = NULL;
> > > +    if (!migration_block_activate(&err)) {
> > > +        /* error was already reported */
> > > +        return;
> > > +    }
> > > +
> > > +    if (runstate_is_live(s->vm_old_state)) {
> > > +        vm_start();
> > > +    }
> > > +}
> > > +
> > > +static int cpr_exec_notifier(NotifierWithReturn *notifier, MigrationEvent *e,
> > > +                             Error **errp)
> > > +{
> > > +    MigrationState *s = migrate_get_current();
> > > +
> > > +    if (e->type == MIG_EVENT_PRECOPY_DONE) {
> > > +        assert(s->state == MIGRATION_STATUS_COMPLETED);
> > > +        qemu_system_exec_request(cpr_exec, s->parameters.cpr_exec_command);
> > > +    } else if (e->type == MIG_EVENT_PRECOPY_FAILED) {
> > > +        cpr_exec_unpersist_state();
> > > +    }
> > > +    return 0;
> > > +}
> > > +
> > > +void cpr_exec_init(void)
> > > +{
> > > +    static NotifierWithReturn exec_notifier;
> > > +
> > > +    migration_add_notifier_mode(&exec_notifier, cpr_exec_notifier,
> > > +                                MIG_MODE_CPR_EXEC);
> > 
> > Why using a notifier?  IMHO exec() is something important enough to not be
> > hiding in a notifier..  and CPR is already a major part of migration in the
> > framework, IMHO it'll be cleaner to invoke any CPR request in the migration
> > subsystem.  AFAIU notifiers are normally only for outside migration/ purposes.
> 
> This minimizes the number of control flow conditionals in the core migration code.
> That's a good thing, and I thought you would like it.
> 
> The alternative is to add code right after notifiers are called to check the
> mode, and call cpr_exec_notifier.  Seems silly when we have this generic
> mechanism to define callouts to occur at well-defined points during execution.
> 
> Note that cpr_exec_notifier does not directly call exec.  It posts the exec
> request.  It also recovers if cpr failed.

OK, I don't think I feel strongly on this one.

Initially I was concerned at least on some of the notifiers not invoked,
which looks to be completely random.  But I kind of agree you chose the
spot late enough so whatever should really have been done before an exec(),
should hopefully be processed already, maybe while we do or around
vm_stop() phase.

Feel free to keep it then if nobody else asks.

> 
> > > +}
> > > diff --git a/migration/cpr.c b/migration/cpr.c
> > > index 021bd6a..2078d05 100644
> > > --- a/migration/cpr.c
> > > +++ b/migration/cpr.c
> > > @@ -198,6 +198,8 @@ int cpr_state_save(MigrationChannel *channel, Error **errp)
> > >       if (mode == MIG_MODE_CPR_TRANSFER) {
> > >           g_assert(channel);
> > >           f = cpr_transfer_output(channel, errp);
> > > +    } else if (mode == MIG_MODE_CPR_EXEC) {
> > > +        f = cpr_exec_output(errp);
> > >       } else {
> > >           return 0;
> > >       }
> > > @@ -215,6 +217,10 @@ int cpr_state_save(MigrationChannel *channel, Error **errp)
> > >           return ret;
> > >       }
> > > +    if (migrate_mode() == MIG_MODE_CPR_EXEC) {
> > > +        cpr_exec_persist_state(f);
> > > +    }
> > > +
> > >       /*
> > >        * Close the socket only partially so we can later detect when the other
> > >        * end closes by getting a HUP event.
> > > @@ -226,6 +232,12 @@ int cpr_state_save(MigrationChannel *channel, Error **errp)
> > >       return 0;
> > >   }
> > > +static bool unpreserve_fd(int fd)
> > > +{
> > > +    qemu_set_cloexec(fd);
> > > +    return true;
> > > +}
> > > +
> > >   int cpr_state_load(MigrationChannel *channel, Error **errp)
> > >   {
> > >       int ret;
> > > @@ -237,6 +249,12 @@ int cpr_state_load(MigrationChannel *channel, Error **errp)
> > >           mode = MIG_MODE_CPR_TRANSFER;
> > >           cpr_set_incoming_mode(mode);
> > >           f = cpr_transfer_input(channel, errp);
> > > +    } else if (cpr_exec_has_state()) {
> > > +        mode = MIG_MODE_CPR_EXEC;
> > > +        f = cpr_exec_input(errp);
> > > +        if (channel) {
> > > +            warn_report("ignoring cpr channel for migration mode cpr-exec");
> > 
> > This looks like dead code?  channel can't be set when reaching here, AFAIU..
> 
> The user could define a cpr channel in qemu command line arguments, and it would
> reach here.  In that case the user is confused, but I warn instead of abort, to
> keep new QEMU alive.  I perform this sanity check here, rather than at top level,
> because I have localized awareness of cpr_exec state to here.

The code (after this patch applied) looks like this:

    if (channel) {                                            <------- [*]
        mode = MIG_MODE_CPR_TRANSFER;
        cpr_set_incoming_mode(mode);
        f = cpr_transfer_input(channel, errp);
    } else if (cpr_exec_has_state()) {
        mode = MIG_MODE_CPR_EXEC;
        f = cpr_exec_input(errp);
        if (channel) {
            warn_report("ignoring cpr channel for migration mode cpr-exec");
        }
    } else {
        return 0;
    }

IIUC [*] will capture any channel!=NULL case.

-- 
Peter Xu


