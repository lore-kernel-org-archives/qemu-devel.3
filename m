Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6EC8CEFC39
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 18:29:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syEws-0001Ca-Ky; Tue, 08 Oct 2024 14:28:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1syEwq-00016y-GH
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 14:28:40 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1syEwn-0008Li-RI
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 14:28:39 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7F8C721D12;
 Tue,  8 Oct 2024 18:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1728412114; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SqaqQNgulZHBzmCzcD38W6uv4EipOMx4QKDAc/BnYhQ=;
 b=LBZt8h4f/nmySx5Bl+Oa63oeHMxtWW22mYEA/0aSEJkwFnZEAxfhjxHJkj9wZdwuA3JcKn
 NxD8UNsLZ4SE8upeyRJCZrkSzgOFyuBaLKooc3D6HNoyhewf2/h3yrxovTjlgsEJY0LbvQ
 zltYD9q0jogSq+37ZxYljHbm/nCC10E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1728412114;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SqaqQNgulZHBzmCzcD38W6uv4EipOMx4QKDAc/BnYhQ=;
 b=n0oLODyVgsyR/6BZV7BWp5B5AMIZnCyy2+Pt3GEJwSClPEEx1m/kZpM374B0dimr2eavbj
 z8BvfiiInQNJwABA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1728412114; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SqaqQNgulZHBzmCzcD38W6uv4EipOMx4QKDAc/BnYhQ=;
 b=LBZt8h4f/nmySx5Bl+Oa63oeHMxtWW22mYEA/0aSEJkwFnZEAxfhjxHJkj9wZdwuA3JcKn
 NxD8UNsLZ4SE8upeyRJCZrkSzgOFyuBaLKooc3D6HNoyhewf2/h3yrxovTjlgsEJY0LbvQ
 zltYD9q0jogSq+37ZxYljHbm/nCC10E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1728412114;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SqaqQNgulZHBzmCzcD38W6uv4EipOMx4QKDAc/BnYhQ=;
 b=n0oLODyVgsyR/6BZV7BWp5B5AMIZnCyy2+Pt3GEJwSClPEEx1m/kZpM374B0dimr2eavbj
 z8BvfiiInQNJwABA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D6F1D1340C;
 Tue,  8 Oct 2024 18:28:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id pX1TJNF5BWdiagAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 08 Oct 2024 18:28:33 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Steven Sistare <steven.sistare@oracle.com>, Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>, Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>, Eduardo Habkost
 <eduardo@habkost.net>, Philippe Mathieu-Daude <philmd@linaro.org>, Paolo
 Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH V2 13/13] migration: cpr-transfer mode
In-Reply-To: <eb41bce1-a776-4bb2-adb8-23fdc7cff1fb@oracle.com>
References: <1727725244-105198-1-git-send-email-steven.sistare@oracle.com>
 <1727725244-105198-14-git-send-email-steven.sistare@oracle.com>
 <ZwQ6GbVCmitlills@x1n> <eb41bce1-a776-4bb2-adb8-23fdc7cff1fb@oracle.com>
Date: Tue, 08 Oct 2024 15:28:30 -0300
Message-ID: <87ed4qtpo1.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; TAGGED_RCPT(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_SEVEN(0.00)[10];
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[nongnu.org,redhat.com,gmail.com,habkost.net,linaro.org];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Steven Sistare <steven.sistare@oracle.com> writes:

> On 10/7/2024 3:44 PM, Peter Xu wrote:
>> On Mon, Sep 30, 2024 at 12:40:44PM -0700, Steve Sistare wrote:
>>> Add the cpr-transfer migration mode.  Usage:
>>>    qemu-system-$arch -machine anon-alloc=memfd ...
>>>
>>>    start new QEMU with "-incoming <uri-1> -cpr-uri <uri-2>"
>>>
>>>    Issue commands to old QEMU:
>>>    migrate_set_parameter mode cpr-transfer
>>>    migrate_set_parameter cpr-uri <uri-2>
>>>    migrate -d <uri-1>
>>>
>>> The migrate command stops the VM, saves CPR state to uri-2, saves
>>> normal migration state to uri-1, and old QEMU enters the postmigrate
>>> state.  The user starts new QEMU on the same host as old QEMU, with the
>>> same arguments as old QEMU, plus the -incoming option.  Guest RAM is
>>> preserved in place, albeit with new virtual addresses in new QEMU.
>>>
>>> This mode requires a second migration channel, specified by the
>>> cpr-uri migration property on the outgoing side, and by the cpr-uri
>>> QEMU command-line option on the incoming side.  The channel must
>>> be a type, such as unix socket, that supports SCM_RIGHTS.
>>>
>>> Memory-backend objects must have the share=on attribute, but
>>> memory-backend-epc is not supported.  The VM must be started with
>>> the '-machine anon-alloc=memfd' option, which allows anonymous
>>> memory to be transferred in place to the new process.  The memfds
>>> are kept open by sending the descriptors to new QEMU via the
>>> cpr-uri, which must support SCM_RIGHTS, and they are mmap'd
>>> in new QEMU.
>>>
>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>> ---
>>>   include/migration/cpr.h   |  1 +
>>>   migration/cpr.c           | 34 +++++++++++++++++++----
>>>   migration/migration.c     | 69 +++++++++++++++++++++++++++++++++++++++++++++--
>>>   migration/migration.h     |  2 ++
>>>   migration/ram.c           |  2 ++
>>>   migration/vmstate-types.c |  5 ++--
>>>   qapi/migration.json       | 27 ++++++++++++++++++-
>>>   stubs/vmstate.c           |  7 +++++
>>>   8 files changed, 137 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/include/migration/cpr.h b/include/migration/cpr.h
>>> index e886c98..5cd373f 100644
>>> --- a/include/migration/cpr.h
>>> +++ b/include/migration/cpr.h
>>> @@ -30,6 +30,7 @@ int cpr_state_save(Error **errp);
>>>   int cpr_state_load(Error **errp);
>>>   void cpr_state_close(void);
>>>   struct QIOChannel *cpr_state_ioc(void);
>>> +bool cpr_needed_for_reuse(void *opaque);
>>>   
>>>   QEMUFile *cpr_transfer_output(const char *uri, Error **errp);
>>>   QEMUFile *cpr_transfer_input(const char *uri, Error **errp);
>>> diff --git a/migration/cpr.c b/migration/cpr.c
>>> index 86f66c1..911b556 100644
>>> --- a/migration/cpr.c
>>> +++ b/migration/cpr.c
>>> @@ -9,6 +9,7 @@
>>>   #include "qapi/error.h"
>>>   #include "migration/cpr.h"
>>>   #include "migration/misc.h"
>>> +#include "migration/options.h"
>>>   #include "migration/qemu-file.h"
>>>   #include "migration/savevm.h"
>>>   #include "migration/vmstate.h"
>>> @@ -57,7 +58,7 @@ static const VMStateDescription vmstate_cpr_fd = {
>>>           VMSTATE_UINT32(namelen, CprFd),
>>>           VMSTATE_VBUFFER_ALLOC_UINT32(name, CprFd, 0, NULL, namelen),
>>>           VMSTATE_INT32(id, CprFd),
>>> -        VMSTATE_INT32(fd, CprFd),
>>> +        VMSTATE_FD(fd, CprFd),
>>>           VMSTATE_END_OF_LIST()
>>>       }
>>>   };
>>> @@ -174,9 +175,16 @@ int cpr_state_save(Error **errp)
>>>   {
>>>       int ret;
>>>       QEMUFile *f;
>>> +    MigMode mode = migrate_mode();
>>>   
>>> -    /* set f based on mode in a later patch in this series */
>>> -    return 0;
>>> +    if (mode == MIG_MODE_CPR_TRANSFER) {
>>> +        f = cpr_transfer_output(migrate_cpr_uri(), errp);
>>> +    } else {
>>> +        return 0;
>>> +    }
>>> +    if (!f) {
>>> +        return -1;
>>> +    }
>>>   
>>>       qemu_put_be32(f, QEMU_CPR_FILE_MAGIC);
>>>       qemu_put_be32(f, QEMU_CPR_FILE_VERSION);
>>> @@ -205,8 +213,18 @@ int cpr_state_load(Error **errp)
>>>       uint32_t v;
>>>       QEMUFile *f;
>>>   
>>> -    /* set f based on mode in a later patch in this series */
>>> -    return 0;
>>> +    /*
>>> +     * Mode will be loaded in CPR state, so cannot use it to decide which
>>> +     * form of state to load.
>>> +     */
>>> +    if (cpr_uri) {
>>> +        f = cpr_transfer_input(cpr_uri, errp);
>>> +    } else {
>>> +        return 0;
>>> +    }
>>> +    if (!f) {
>>> +        return -1;
>>> +    }
>>>   
>>>       v = qemu_get_be32(f);
>>>       if (v != QEMU_CPR_FILE_MAGIC) {
>>> @@ -243,3 +261,9 @@ void cpr_state_close(void)
>>>           cpr_state_file = NULL;
>>>       }
>>>   }
>>> +
>>> +bool cpr_needed_for_reuse(void *opaque)
>>> +{
>>> +    MigMode mode = migrate_mode();
>>> +    return mode == MIG_MODE_CPR_TRANSFER;
>>> +}
>> 
>> Drop it until used?
>
> Maybe, but here is my reason for including it here.
>
> These common functions like cpr_needed_for_reuse and cpr_resave_fd are needed
> by multiple follow-on series: vfio, tap, iommufd.  To send those for comment,
> as I have beem, I need to prepend a patch for cpr_needed_for_reuse to each of
> those series, which is redundant.  It makes more sense IMO to include them in
> this initial series.
>
> But, it's your call.
>
>>> diff --git a/migration/migration.c b/migration/migration.c
>>> index 3301583..73b85aa 100644
>>> --- a/migration/migration.c
>>> +++ b/migration/migration.c
>>> @@ -76,6 +76,7 @@
>>>   static NotifierWithReturnList migration_state_notifiers[] = {
>>>       NOTIFIER_ELEM_INIT(migration_state_notifiers, MIG_MODE_NORMAL),
>>>       NOTIFIER_ELEM_INIT(migration_state_notifiers, MIG_MODE_CPR_REBOOT),
>>> +    NOTIFIER_ELEM_INIT(migration_state_notifiers, MIG_MODE_CPR_TRANSFER),
>>>   };
>>>   
>>>   /* Messages sent on the return path from destination to source */
>>> @@ -109,6 +110,7 @@ static int migration_maybe_pause(MigrationState *s,
>>>   static void migrate_fd_cancel(MigrationState *s);
>>>   static bool close_return_path_on_source(MigrationState *s);
>>>   static void migration_completion_end(MigrationState *s);
>>> +static void migrate_hup_delete(MigrationState *s);
>>>   
>>>   static void migration_downtime_start(MigrationState *s)
>>>   {
>>> @@ -204,6 +206,12 @@ migration_channels_and_transport_compatible(MigrationAddress *addr,
>>>           return false;
>>>       }
>>>   
>>> +    if (migrate_mode() == MIG_MODE_CPR_TRANSFER &&
>>> +        addr->transport == MIGRATION_ADDRESS_TYPE_FILE) {
>>> +        error_setg(errp, "Migration requires streamable transport (eg unix)");
>>> +        return false;
>>> +    }
>>> +
>>>       return true;
>>>   }
>>>   
>>> @@ -316,6 +324,7 @@ void migration_cancel(const Error *error)
>>>           qmp_cancel_vcpu_dirty_limit(false, -1, NULL);
>>>       }
>>>       migrate_fd_cancel(current_migration);
>>> +    migrate_hup_delete(current_migration);
>>>   }
>>>   
>>>   void migration_shutdown(void)
>>> @@ -718,6 +727,9 @@ static void qemu_start_incoming_migration(const char *uri, bool has_channels,
>>>       } else {
>>>           error_setg(errp, "unknown migration protocol: %s", uri);
>>>       }
>>> +
>>> +    /* Close cpr socket to tell source that we are listening */
>>> +    cpr_state_close();
>> 
>> Would it be possible to use some explicit reply message to mark this?  
>
> In theory yes, but I fear that using a return channel with message parsing and
> dispatch adds more code than it is worth.

I think this approach is fine for now, but I wonder whether we could
reuse the current return path (RP) by starting it earlier and take
benefit from it already having the message passing infrastructure in
place. I'm actually looking ahead to the migration handshake thread[1],
which could be thought to have some similarity with the early cpr
channel. So having a generic channel in place early on to handle
handshake, CPR, RP, etc. could be a good idea.

Anyway, I'm probing on this a bit so I can start drafting something. I
got surprised that we don't even have the capability bits in the stream
in a useful way (currently, configuration_validate_capabilities() does
kind of nothing).

1- https://wiki.qemu.org/ToDo/LiveMigration#Migration_handshake


