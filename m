Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0735BCA100F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 15:29:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0iTN-0008On-H8; Mon, 22 Sep 2025 11:29:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v0iT1-0008N6-RD
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 11:28:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v0iSw-0000sm-HS
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 11:28:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758554912;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=K6k7q3zM6D1nsCAUm4Q01StHOV5ZxZH03cpa6LKuuq8=;
 b=gfNbKFcsWoFNyQn5nyAoMw2MVUApQEPAXnho8lC46Jk3OO5Oeq3LbqdjsAXZu7d5pC4JtJ
 j4YH+MIwSDu+W3ZZv3hWgbxf86JJ0xhulP8EU9HsVw9oO5J5k5i+wMAKAH/Srf5crnJhBJ
 gZXnRAqgGukPgID48gI7S00dxCwse88=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-EfcVxNaRPBKQQS-XJ0BAkA-1; Mon, 22 Sep 2025 11:28:31 -0400
X-MC-Unique: EfcVxNaRPBKQQS-XJ0BAkA-1
X-Mimecast-MFC-AGG-ID: EfcVxNaRPBKQQS-XJ0BAkA_1758554910
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-45f2b0eba08so32508155e9.3
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 08:28:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758554910; x=1759159710;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=K6k7q3zM6D1nsCAUm4Q01StHOV5ZxZH03cpa6LKuuq8=;
 b=cUA69FdavvY5+qi//x5qlli6GzIPzZXTnW/eZGNgCpJdfbFSPEIPq7jC1c6uSys9rK
 2YEw1rBQkcrrhQ5HeR5JURb3UTGZbr6JEm2HjCZIQa0W8h7dthitIXri+VJHeN9brckm
 rM9uDZ3tOP9eeiu7F9jNhXkZkEBS1VpzxztPYlfLRgUhcINzlSxF3zFDpenlWWUWOWcP
 bio2p676FgIo3vFQuS7xPoi0tWpxPI5xu92ketcHLJiN7E9lLB3z6ox8k5TnFeYOSXmG
 LqHsS0L9DxJzfNJNOu/TZT/GnPE7Dgb3/twRg3Es3r+SyQ7NG6ZNKFqreED8BDPlRdsm
 CYEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXNkNOR0ijytewxMhcSqlJ7AAD7EZVuMmwAHlq7bXFm5pNrpOhNQ4Vz9Wx+ho9Nzp0NAPO7YzbEmtHp@nongnu.org
X-Gm-Message-State: AOJu0Yw6NUxg7/Q8+NpJiUIoSFkb9Kip3J8ArZqFdkTMvPerCxp8TCZl
 HP32ASfUFquCKX7X4t7KMxQlR+OHvqUvIDEpJpGUlu0TDWBfJ7Vu9irEsx0V7tE3ZWqTQlMVe/d
 8K+XmPm8CYIQRj8EWkeclzAVnzXJrqMBLE7GFYB7QgjYZAgl44HIuqnfXpzURnE5K
X-Gm-Gg: ASbGncsjIHv1NxWnYdLS7zhnbduIsLnbL18ySDkcUqpYnsL9ebKtxWT96rDWbcvaTkt
 /7uGZvKYNlAVrzUA2hFkBMjWiDxr2qyPBVYwkC/JVOKgfnCrwg/FT4W7yVUNf6ofNHHyRVsz5c8
 oZBh14cWb/ZfuntUW5g+snR2TFfjTlzilMo0CHeTul9qQO41YtKQzQLBBlJghcUfvI+zd0mfhX0
 dponAM6DadRH2j4LX029sY1b7n/HHAbWeolFBYJkud1XsHmsdbE92Bnne9aLgVdCr4+StY4TG8j
 LwpMfqHFMzNfMOtEz3JJVLYyXI8dKJGRbSm7eDUMVvLh1u2IGwmkutryQKH7/xGTQaw5TdDockZ
 mHdI=
X-Received: by 2002:a05:600c:c48e:b0:45d:f88f:9304 with SMTP id
 5b1f17b1804b1-467ebbbfff4mr134581875e9.30.1758554909551; 
 Mon, 22 Sep 2025 08:28:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5oH/IbCgBFh/PQWCviuAfIhKh2ZtvrMMc5vOAAQ3gmYbMIFnz3QgGskmI9+2xvOVGwop39Q==
X-Received: by 2002:a05:600c:c48e:b0:45d:f88f:9304 with SMTP id
 5b1f17b1804b1-467ebbbfff4mr134581495e9.30.1758554908967; 
 Mon, 22 Sep 2025 08:28:28 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46566f72354sm206109985e9.3.2025.09.22.08.28.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Sep 2025 08:28:28 -0700 (PDT)
Message-ID: <c76d4944-280b-49e1-a324-36429a5513cb@redhat.com>
Date: Mon, 22 Sep 2025 17:28:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 6/8] migration: cpr-exec mode
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eric Blake <eblake@redhat.com>, "Dr. David Alan Gilbert" <dave@treblig.org>,
 Alex Williamson <alex.williamson@redhat.com>
References: <1758548985-354793-1-git-send-email-steven.sistare@oracle.com>
 <1758548985-354793-7-git-send-email-steven.sistare@oracle.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <1758548985-354793-7-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 9/22/25 15:49, Steve Sistare wrote:
> Add the cpr-exec migration mode.  Usage:
>    qemu-system-$arch -machine aux-ram-share=on ...
>    migrate_set_parameter mode cpr-exec
>    migrate_set_parameter cpr-exec-command \
>      <arg1> <arg2> ... -incoming <uri-1> \
>    migrate -d <uri-1>
> 
> The migrate command stops the VM, saves state to uri-1,
> directly exec's a new version of QEMU on the same host,
> replacing the original process while retaining its PID, and
> loads state from uri-1.  Guest RAM is preserved in place,
> albeit with new virtual addresses.
> 
> The new QEMU process is started by exec'ing the command
> specified by the @cpr-exec-command parameter.  The first word of
> the command is the binary, and the remaining words are its
> arguments.  The command may be a direct invocation of new QEMU,
> or may be a non-QEMU command that exec's the new QEMU binary.
> 
> This mode creates a second migration channel that is not visible
> to the user.  At the start of migration, old QEMU saves CPR state
> to the second channel, and at the end of migration, it tells the
> main loop to call cpr_exec.  New QEMU loads CPR state early, before
> objects are created.
> 
> Because old QEMU terminates when new QEMU starts, one cannot
> stream data between the two, so uri-1 must be a type,
> such as a file, that accepts all data before old QEMU exits.
> Otherwise, old QEMU may quietly block writing to the channel.
> 
> Memory-backend objects must have the share=on attribute, but
> memory-backend-epc is not supported.  The VM must be started with
> the '-machine aux-ram-share=on' option, which allows anonymous
> memory to be transferred in place to the new process.  The memfds
> are kept open across exec by clearing the close-on-exec flag, their
> values are saved in CPR state, and they are mmap'd in new QEMU.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> Acked-by: Markus Armbruster <armbru@redhat.com>
> ---
>   qapi/migration.json       | 25 +++++++++++++-
>   include/migration/cpr.h   |  1 +
>   migration/cpr-exec.c      | 84 +++++++++++++++++++++++++++++++++++++++++++++++
>   migration/cpr.c           | 28 ++++++++++++++--
>   migration/migration.c     | 10 +++++-
>   migration/ram.c           |  1 +
>   migration/vmstate-types.c |  8 +++++
>   system/vl.c               |  4 ++-
>   migration/trace-events    |  1 +
>   9 files changed, 157 insertions(+), 5 deletions(-)
> 
> diff --git a/qapi/migration.json b/qapi/migration.json
> index 2be8fa1..be0f3fc 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -694,9 +694,32 @@
>   #     until you issue the `migrate-incoming` command.
>   #
>   #     (since 10.0)
> +#
> +# @cpr-exec: The migrate command stops the VM, saves state to the
> +#     migration channel, directly exec's a new version of QEMU on the
> +#     same host, replacing the original process while retaining its
> +#     PID, and loads state from the channel.  Guest RAM is preserved
> +#     in place.  Devices and their pinned pages are also preserved for
> +#     VFIO and IOMMUFD.
> +#
> +#     Old QEMU starts new QEMU by exec'ing the command specified by
> +#     the @cpr-exec-command parameter.  The command may be a direct
> +#     invocation of new QEMU, or may be a wrapper that exec's the new
> +#     QEMU binary.
> +#
> +#     Because old QEMU terminates when new QEMU starts, one cannot
> +#     stream data between the two, so the channel must be a type,
> +#     such as a file, that accepts all data before old QEMU exits.
> +#     Otherwise, old QEMU may quietly block writing to the channel.
> +#
> +#     Memory-backend objects must have the share=on attribute, but
> +#     memory-backend-epc is not supported.  The VM must be started
> +#     with the '-machine aux-ram-share=on' option.
> +#
> +#     (since 10.2)
>   ##
>   { 'enum': 'MigMode',
> -  'data': [ 'normal', 'cpr-reboot', 'cpr-transfer' ] }
> +  'data': [ 'normal', 'cpr-reboot', 'cpr-transfer', 'cpr-exec' ] }
>   
>   ##
>   # @ZeroPageDetection:
> diff --git a/include/migration/cpr.h b/include/migration/cpr.h
> index b84389f..beed392 100644
> --- a/include/migration/cpr.h
> +++ b/include/migration/cpr.h
> @@ -53,6 +53,7 @@ int cpr_get_fd_param(const char *name, const char *fdname, int index,
>   QEMUFile *cpr_transfer_output(MigrationChannel *channel, Error **errp);
>   QEMUFile *cpr_transfer_input(MigrationChannel *channel, Error **errp);
>   
> +void cpr_exec_init(void);
>   QEMUFile *cpr_exec_output(Error **errp);
>   QEMUFile *cpr_exec_input(Error **errp);
>   void cpr_exec_persist_state(QEMUFile *f);
> diff --git a/migration/cpr-exec.c b/migration/cpr-exec.c
> index 2c32e9c..8cf55a3 100644
> --- a/migration/cpr-exec.c
> +++ b/migration/cpr-exec.c
> @@ -6,15 +6,21 @@
>   
>   #include "qemu/osdep.h"
>   #include "qemu/cutils.h"
> +#include "qemu/error-report.h"
>   #include "qemu/memfd.h"
>   #include "qapi/error.h"
> +#include "qapi/type-helpers.h"
>   #include "io/channel-file.h"
>   #include "io/channel-socket.h"
> +#include "block/block-global-state.h"
> +#include "qemu/main-loop.h"
>   #include "migration/cpr.h"
>   #include "migration/qemu-file.h"
> +#include "migration/migration.h"
>   #include "migration/misc.h"
>   #include "migration/vmstate.h"
>   #include "system/runstate.h"
> +#include "trace.h"
>   
>   #define CPR_EXEC_STATE_NAME "QEMU_CPR_EXEC_STATE"
>   
> @@ -92,3 +98,81 @@ QEMUFile *cpr_exec_input(Error **errp)
>       lseek(mfd, 0, SEEK_SET);
>       return qemu_file_new_fd_input(mfd, CPR_EXEC_STATE_NAME);
>   }
> +
> +static bool preserve_fd(int fd)
> +{
> +    qemu_clear_cloexec(fd);
> +    return true;
> +}
> +
> +static bool unpreserve_fd(int fd)
> +{
> +    qemu_set_cloexec(fd);
> +    return true;
> +}
> +
> +static void cpr_exec_cb(void *opaque)
> +{
> +    MigrationState *s = migrate_get_current();
> +    char **argv = strv_from_str_list(s->parameters.cpr_exec_command);
> +    Error *err = NULL;
> +
> +    /*
> +     * Clear the close-on-exec flag for all preserved fd's.  We cannot do so
> +     * earlier because they should not persist across miscellaneous fork and
> +     * exec calls that are performed during normal operation.
> +     */
> +    cpr_walk_fd(preserve_fd);
> +
> +    trace_cpr_exec();
> +    execvp(argv[0], argv);
> +
> +    /*
> +     * exec should only fail if argv[0] is bogus, or has a permissions problem,
> +     * or the system is very short on resources.
> +     */
> +    g_strfreev(argv);
> +    cpr_walk_fd(unpreserve_fd);
> +
> +    error_setg_errno(&err, errno, "execvp %s failed", argv[0]);
> +    error_report_err(error_copy(err));
> +    migrate_set_state(&s->state, s->state, MIGRATION_STATUS_FAILED);
> +    migrate_set_error(s, err);
> +
> +    migration_call_notifiers(s, MIG_EVENT_PRECOPY_FAILED, NULL);
> +
> +    err = NULL;
> +    if (!migration_block_activate(&err)) {
> +        /* error was already reported */
> +        return;
> +    }
> +
> +    if (runstate_is_live(s->vm_old_state)) {
> +        vm_start();
> +    }
> +}
> +
> +static int cpr_exec_notifier(NotifierWithReturn *notifier, MigrationEvent *e,
> +                             Error **errp)
> +{
> +    MigrationState *s = migrate_get_current();
> +
> +    if (e->type == MIG_EVENT_PRECOPY_DONE) {
> +        QEMUBH *cpr_exec_bh = qemu_bh_new(cpr_exec_cb, NULL);
> +        assert(s->state == MIGRATION_STATUS_COMPLETED);
> +        qemu_bh_schedule(cpr_exec_bh);
> +        qemu_notify_event();
> +
> +    } else if (e->type == MIG_EVENT_PRECOPY_FAILED) {
> +        cpr_exec_unpersist_state();
> +    }
> +    return 0;
> +}
> +
> +void cpr_exec_init(void)
> +{
> +    static NotifierWithReturn exec_notifier;
> +
> +    migration_add_notifier_mode(&exec_notifier, cpr_exec_notifier,
> +                                MIG_MODE_CPR_EXEC);
> +}
> diff --git a/migration/cpr.c b/migration/cpr.c
> index d3e370e..eea3773 100644
> --- a/migration/cpr.c
> +++ b/migration/cpr.c
> @@ -185,6 +185,8 @@ int cpr_state_save(MigrationChannel *channel, Error **errp)
>       if (mode == MIG_MODE_CPR_TRANSFER) {
>           g_assert(channel);
>           f = cpr_transfer_output(channel, errp);
> +    } else if (mode == MIG_MODE_CPR_EXEC) {
> +        f = cpr_exec_output(errp);
>       } else {
>           return 0;
>       }
> @@ -202,6 +204,10 @@ int cpr_state_save(MigrationChannel *channel, Error **errp)
>           return ret;
>       }
>   
> +    if (migrate_mode() == MIG_MODE_CPR_EXEC) {
> +        cpr_exec_persist_state(f);
> +    }
> +
>       /*
>        * Close the socket only partially so we can later detect when the other
>        * end closes by getting a HUP event.
> @@ -213,6 +219,12 @@ int cpr_state_save(MigrationChannel *channel, Error **errp)
>       return 0;
>   }
>   
> +static bool unpreserve_fd(int fd)
> +{
> +    qemu_set_cloexec(fd);
> +    return true;
> +}
> +
>   int cpr_state_load(MigrationChannel *channel, Error **errp)
>   {
>       int ret;
> @@ -220,7 +232,13 @@ int cpr_state_load(MigrationChannel *channel, Error **errp)
>       QEMUFile *f;
>       MigMode mode = 0;
>   
> -    if (channel) {
> +    if (cpr_exec_has_state()) {
> +        mode = MIG_MODE_CPR_EXEC;
> +        f = cpr_exec_input(errp);
> +        if (channel) {
> +            warn_report("ignoring cpr channel for migration mode cpr-exec");

migration/cpr.c does not include "qemu/error-report.h"

C.

> +        }
> +    } else if (channel) {
>           mode = MIG_MODE_CPR_TRANSFER;
>           cpr_set_incoming_mode(mode);
>           f = cpr_transfer_input(channel, errp);
> @@ -232,6 +250,7 @@ int cpr_state_load(MigrationChannel *channel, Error **errp)
>       }
>   
>       trace_cpr_state_load(MigMode_str(mode));
> +    cpr_set_incoming_mode(mode);
>   
>       v = qemu_get_be32(f);
>       if (v != QEMU_CPR_FILE_MAGIC) {
> @@ -253,6 +272,11 @@ int cpr_state_load(MigrationChannel *channel, Error **errp)
>           return ret;
>       }
>   
> +    if (migrate_mode() == MIG_MODE_CPR_EXEC) {
> +        /* Set cloexec to prevent fd leaks from fork until the next cpr-exec */
> +        cpr_walk_fd(unpreserve_fd);
> +    }
> +
>       /*
>        * Let the caller decide when to close the socket (and generate a HUP event
>        * for the sending side).
> @@ -273,7 +297,7 @@ void cpr_state_close(void)
>   bool cpr_incoming_needed(void *opaque)
>   {
>       MigMode mode = migrate_mode();
> -    return mode == MIG_MODE_CPR_TRANSFER;
> +    return mode == MIG_MODE_CPR_TRANSFER || mode == MIG_MODE_CPR_EXEC;
>   }
>   
>   /*
> diff --git a/migration/migration.c b/migration/migration.c
> index 08a98f7..2515bec 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -333,6 +333,7 @@ void migration_object_init(void)
>   
>       ram_mig_init();
>       dirty_bitmap_mig_init();
> +    cpr_exec_init();
>   
>       /* Initialize cpu throttle timers */
>       cpu_throttle_init();
> @@ -1796,7 +1797,8 @@ bool migrate_mode_is_cpr(MigrationState *s)
>   {
>       MigMode mode = s->parameters.mode;
>       return mode == MIG_MODE_CPR_REBOOT ||
> -           mode == MIG_MODE_CPR_TRANSFER;
> +           mode == MIG_MODE_CPR_TRANSFER ||
> +           mode == MIG_MODE_CPR_EXEC;
>   }
>   
>   int migrate_init(MigrationState *s, Error **errp)
> @@ -2145,6 +2147,12 @@ static bool migrate_prepare(MigrationState *s, bool resume, Error **errp)
>           return false;
>       }
>   
> +    if (migrate_mode() == MIG_MODE_CPR_EXEC &&
> +        !s->parameters.has_cpr_exec_command) {
> +        error_setg(errp, "cpr-exec mode requires setting cpr-exec-command");
> +        return false;
> +    }
> +
>       if (migration_is_blocked(errp)) {
>           return false;
>       }
> diff --git a/migration/ram.c b/migration/ram.c
> index 7208bc1..6730a41 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -228,6 +228,7 @@ bool migrate_ram_is_ignored(RAMBlock *block)
>       MigMode mode = migrate_mode();
>       return !qemu_ram_is_migratable(block) ||
>              mode == MIG_MODE_CPR_TRANSFER ||
> +           mode == MIG_MODE_CPR_EXEC ||
>              (migrate_ignore_shared() && qemu_ram_is_shared(block)
>                                       && qemu_ram_is_named_file(block));
>   }
> diff --git a/migration/vmstate-types.c b/migration/vmstate-types.c
> index 741a588..1aa0573 100644
> --- a/migration/vmstate-types.c
> +++ b/migration/vmstate-types.c
> @@ -321,6 +321,10 @@ static int get_fd(QEMUFile *f, void *pv, size_t size,
>                     const VMStateField *field)
>   {
>       int32_t *v = pv;
> +    if (migrate_mode() == MIG_MODE_CPR_EXEC) {
> +        qemu_get_sbe32s(f, v);
> +        return 0;
> +    }
>       *v = qemu_file_get_fd(f);
>       return 0;
>   }
> @@ -329,6 +333,10 @@ static int put_fd(QEMUFile *f, void *pv, size_t size,
>                     const VMStateField *field, JSONWriter *vmdesc)
>   {
>       int32_t *v = pv;
> +    if (migrate_mode() == MIG_MODE_CPR_EXEC) {
> +        qemu_put_sbe32s(f, v);
> +        return 0;
> +    }
>       return qemu_file_put_fd(f, *v);
>   }
>   
> diff --git a/system/vl.c b/system/vl.c
> index 4c24073..f395d04 100644
> --- a/system/vl.c
> +++ b/system/vl.c
> @@ -3867,6 +3867,8 @@ void qemu_init(int argc, char **argv)
>       }
>       qemu_init_displays();
>       accel_setup_post(current_machine);
> -    os_setup_post();
> +    if (migrate_mode() != MIG_MODE_CPR_EXEC) {
> +        os_setup_post();
> +    }
>       resume_mux_open();
>   }
> diff --git a/migration/trace-events b/migration/trace-events
> index 706db97..e8edd1f 100644
> --- a/migration/trace-events
> +++ b/migration/trace-events
> @@ -354,6 +354,7 @@ cpr_state_save(const char *mode) "%s mode"
>   cpr_state_load(const char *mode) "%s mode"
>   cpr_transfer_input(const char *path) "%s"
>   cpr_transfer_output(const char *path) "%s"
> +cpr_exec(void) ""
>   
>   # block-dirty-bitmap.c
>   send_bitmap_header_enter(void) ""


