Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30881CAC5B8
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 16:41:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3dOS-0002Ig-CL; Tue, 30 Sep 2025 12:40:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v3dOQ-0002IJ-Cg
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 12:39:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v3dOJ-0001oF-Uj
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 12:39:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759250388;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pCLF4zSOyJMtFkwU4MaSjs4mSYhBhlROsh/QoRm+3Vc=;
 b=BH5ow9rKOHjSRcIkhbtuAwnFIHFFkeekqugBHMXc/hxtSo8Z63nmrYQ5+ELM4bo3ClmR+9
 /2T1VKkBx1B2mfJ+KeNYYCxZoD0Q54QnM7JK11K9yM8KYoY7e5TxsM2sCzAo7kDBWc1Ktx
 b/TfhqriZ8F1Z2L4PLWWYfeyLBlHGu0=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-348-E5X9O5m4PZGf4evUuTBGzA-1; Tue, 30 Sep 2025 12:39:46 -0400
X-MC-Unique: E5X9O5m4PZGf4evUuTBGzA-1
X-Mimecast-MFC-AGG-ID: E5X9O5m4PZGf4evUuTBGzA_1759250386
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-78e5b6f1296so106413076d6.2
 for <qemu-devel@nongnu.org>; Tue, 30 Sep 2025 09:39:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759250386; x=1759855186;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pCLF4zSOyJMtFkwU4MaSjs4mSYhBhlROsh/QoRm+3Vc=;
 b=ccINpgKrQqXAyB5ftuqncpVY+OUarsS68gv00+dXE3stg9/4Zz/ZVMyQ9sC3kzhTjn
 BWH28ysqIxBy6JMHsVWODE2R6LgTDtSZl0xtbsED3cDLVi2ePv6OgTOEAmlzWwpM8gTJ
 g/b3AwvZxnN+/PTzOlEtoKU/Ud3DqCI9QsyDC++DQx2cS3OSTxlJSArRg9xiodPSf5G9
 e6D6MFaxOjbcBzIQeVwKXQ0hs4Snp0h8badEuIpm7DvrmfuccIvb1iMp9gSIlQGXMVi2
 107vUZkYSkwboA+3f7nJ7lEpD45Frnoxg5qp17qQ9zccgomTjg2/B80/sbZEnLRnu6hq
 pXpA==
X-Gm-Message-State: AOJu0YwoE4OFfH6IXjwi47RzDPtOcDZkKTkWqVNeqdlqehEtFQ8l7Fu2
 /Dra825wGX6cikaB25tlqX62/WwkI0l9sEmmjq0Ms8jZiGvw/33oSGHX8LHqntRtjGq/ZPGd2yt
 QBdWB+YCGCQj21XUzZOqTtn0xS4BFWc4jBvaD7TM1JHM7kEKAyaW39ZEZ
X-Gm-Gg: ASbGncvN+YNEeoNeB7QcIaPHJP1rKrN5IKmx9kWDIBGEkzKQZSBCjK0+JwCH2+RZm7v
 oLuvZ2Gb2YGwCodycLrDvkfP35WuqCqCOGI3rjt+QC6fbGx8lT22MZUh0dgJUClnXL4+JNEblY7
 q55rSC1fjcjVhmqXQi41WshJE2yEHuRIphhoQK+U4qsvBQCNLkq6tcerEn+5feVt9LnKGDdvwub
 ZoNtuomOcrJyDc8I6eO4s+YL6vwQSxrzdrswWzCZNndQkq/cCAuFuCyhrO1W3dAHgQlgOOS6tAQ
 4c/T7ky8OgdrixZigimAoF++zZAfHDrEKLtJyg==
X-Received: by 2002:a05:6214:1942:b0:77c:a783:c9c6 with SMTP id
 6a1803df08f44-8739b0b0b9bmr5977016d6.3.1759250385987; 
 Tue, 30 Sep 2025 09:39:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF2+PFLq1DacD67OOdR5G0OrGjEfK49ed7kvext21L8hBUbUJG1oK7GcguqG++5j87nG8tibA==
X-Received: by 2002:a05:6214:1942:b0:77c:a783:c9c6 with SMTP id
 6a1803df08f44-8739b0b0b9bmr5976756d6.3.1759250385205; 
 Tue, 30 Sep 2025 09:39:45 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8016ce9a3cbsm97194826d6.56.2025.09.30.09.39.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Sep 2025 09:39:44 -0700 (PDT)
Date: Tue, 30 Sep 2025 12:39:43 -0400
From: Peter Xu <peterx@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Cedric Le Goater <clg@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH V4 6/8] migration: cpr-exec mode
Message-ID: <aNwHz39FkYIq7DgX@x1.local>
References: <1758548985-354793-1-git-send-email-steven.sistare@oracle.com>
 <1758548985-354793-7-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1758548985-354793-7-git-send-email-steven.sistare@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Sep 22, 2025 at 06:49:43AM -0700, Steve Sistare wrote:
> Add the cpr-exec migration mode.  Usage:
>   qemu-system-$arch -machine aux-ram-share=on ...
>   migrate_set_parameter mode cpr-exec
>   migrate_set_parameter cpr-exec-command \
>     <arg1> <arg2> ... -incoming <uri-1> \
>   migrate -d <uri-1>
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
>  qapi/migration.json       | 25 +++++++++++++-
>  include/migration/cpr.h   |  1 +
>  migration/cpr-exec.c      | 84 +++++++++++++++++++++++++++++++++++++++++++++++
>  migration/cpr.c           | 28 ++++++++++++++--
>  migration/migration.c     | 10 +++++-
>  migration/ram.c           |  1 +
>  migration/vmstate-types.c |  8 +++++
>  system/vl.c               |  4 ++-
>  migration/trace-events    |  1 +
>  9 files changed, 157 insertions(+), 5 deletions(-)
> 
> diff --git a/qapi/migration.json b/qapi/migration.json
> index 2be8fa1..be0f3fc 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -694,9 +694,32 @@
>  #     until you issue the `migrate-incoming` command.
>  #
>  #     (since 10.0)
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
>  ##
>  { 'enum': 'MigMode',
> -  'data': [ 'normal', 'cpr-reboot', 'cpr-transfer' ] }
> +  'data': [ 'normal', 'cpr-reboot', 'cpr-transfer', 'cpr-exec' ] }
>  
>  ##
>  # @ZeroPageDetection:
> diff --git a/include/migration/cpr.h b/include/migration/cpr.h
> index b84389f..beed392 100644
> --- a/include/migration/cpr.h
> +++ b/include/migration/cpr.h
> @@ -53,6 +53,7 @@ int cpr_get_fd_param(const char *name, const char *fdname, int index,
>  QEMUFile *cpr_transfer_output(MigrationChannel *channel, Error **errp);
>  QEMUFile *cpr_transfer_input(MigrationChannel *channel, Error **errp);
>  
> +void cpr_exec_init(void);
>  QEMUFile *cpr_exec_output(Error **errp);
>  QEMUFile *cpr_exec_input(Error **errp);
>  void cpr_exec_persist_state(QEMUFile *f);
> diff --git a/migration/cpr-exec.c b/migration/cpr-exec.c
> index 2c32e9c..8cf55a3 100644
> --- a/migration/cpr-exec.c
> +++ b/migration/cpr-exec.c
> @@ -6,15 +6,21 @@
>  
>  #include "qemu/osdep.h"
>  #include "qemu/cutils.h"
> +#include "qemu/error-report.h"
>  #include "qemu/memfd.h"
>  #include "qapi/error.h"
> +#include "qapi/type-helpers.h"
>  #include "io/channel-file.h"
>  #include "io/channel-socket.h"
> +#include "block/block-global-state.h"
> +#include "qemu/main-loop.h"
>  #include "migration/cpr.h"
>  #include "migration/qemu-file.h"
> +#include "migration/migration.h"
>  #include "migration/misc.h"
>  #include "migration/vmstate.h"
>  #include "system/runstate.h"
> +#include "trace.h"
>  
>  #define CPR_EXEC_STATE_NAME "QEMU_CPR_EXEC_STATE"
>  
> @@ -92,3 +98,81 @@ QEMUFile *cpr_exec_input(Error **errp)
>      lseek(mfd, 0, SEEK_SET);
>      return qemu_file_new_fd_input(mfd, CPR_EXEC_STATE_NAME);
>  }
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

I believe this is the only place we can have the state machine from
COMPLETED->FAILED.  It's pretty hacky.  Maybe add a quick comment?

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

We have rollback logic in migration_iteration_finish().  Make a small
helper and reuse the code?

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

Newline can be dropped.

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
>      if (mode == MIG_MODE_CPR_TRANSFER) {
>          g_assert(channel);
>          f = cpr_transfer_output(channel, errp);
> +    } else if (mode == MIG_MODE_CPR_EXEC) {
> +        f = cpr_exec_output(errp);
>      } else {
>          return 0;
>      }
> @@ -202,6 +204,10 @@ int cpr_state_save(MigrationChannel *channel, Error **errp)
>          return ret;
>      }
>  
> +    if (migrate_mode() == MIG_MODE_CPR_EXEC) {
> +        cpr_exec_persist_state(f);
> +    }
> +
>      /*
>       * Close the socket only partially so we can later detect when the other
>       * end closes by getting a HUP event.
> @@ -213,6 +219,12 @@ int cpr_state_save(MigrationChannel *channel, Error **errp)
>      return 0;
>  }
>  
> +static bool unpreserve_fd(int fd)
> +{
> +    qemu_set_cloexec(fd);
> +    return true;
> +}

Is this function defined twice?

> +
>  int cpr_state_load(MigrationChannel *channel, Error **errp)
>  {
>      int ret;
> @@ -220,7 +232,13 @@ int cpr_state_load(MigrationChannel *channel, Error **errp)
>      QEMUFile *f;
>      MigMode mode = 0;
>  
> -    if (channel) {
> +    if (cpr_exec_has_state()) {
> +        mode = MIG_MODE_CPR_EXEC;
> +        f = cpr_exec_input(errp);
> +        if (channel) {
> +            warn_report("ignoring cpr channel for migration mode cpr-exec");
> +        }
> +    } else if (channel) {
>          mode = MIG_MODE_CPR_TRANSFER;
>          cpr_set_incoming_mode(mode);
>          f = cpr_transfer_input(channel, errp);
> @@ -232,6 +250,7 @@ int cpr_state_load(MigrationChannel *channel, Error **errp)
>      }
>  
>      trace_cpr_state_load(MigMode_str(mode));
> +    cpr_set_incoming_mode(mode);
>  
>      v = qemu_get_be32(f);
>      if (v != QEMU_CPR_FILE_MAGIC) {
> @@ -253,6 +272,11 @@ int cpr_state_load(MigrationChannel *channel, Error **errp)
>          return ret;
>      }
>  
> +    if (migrate_mode() == MIG_MODE_CPR_EXEC) {
> +        /* Set cloexec to prevent fd leaks from fork until the next cpr-exec */
> +        cpr_walk_fd(unpreserve_fd);
> +    }
> +
>      /*
>       * Let the caller decide when to close the socket (and generate a HUP event
>       * for the sending side).
> @@ -273,7 +297,7 @@ void cpr_state_close(void)
>  bool cpr_incoming_needed(void *opaque)
>  {
>      MigMode mode = migrate_mode();
> -    return mode == MIG_MODE_CPR_TRANSFER;
> +    return mode == MIG_MODE_CPR_TRANSFER || mode == MIG_MODE_CPR_EXEC;
>  }
>  
>  /*
> diff --git a/migration/migration.c b/migration/migration.c
> index 08a98f7..2515bec 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -333,6 +333,7 @@ void migration_object_init(void)
>  
>      ram_mig_init();
>      dirty_bitmap_mig_init();
> +    cpr_exec_init();
>  
>      /* Initialize cpu throttle timers */
>      cpu_throttle_init();
> @@ -1796,7 +1797,8 @@ bool migrate_mode_is_cpr(MigrationState *s)
>  {
>      MigMode mode = s->parameters.mode;
>      return mode == MIG_MODE_CPR_REBOOT ||
> -           mode == MIG_MODE_CPR_TRANSFER;
> +           mode == MIG_MODE_CPR_TRANSFER ||
> +           mode == MIG_MODE_CPR_EXEC;
>  }
>  
>  int migrate_init(MigrationState *s, Error **errp)
> @@ -2145,6 +2147,12 @@ static bool migrate_prepare(MigrationState *s, bool resume, Error **errp)
>          return false;
>      }
>  
> +    if (migrate_mode() == MIG_MODE_CPR_EXEC &&
> +        !s->parameters.has_cpr_exec_command) {
> +        error_setg(errp, "cpr-exec mode requires setting cpr-exec-command");
> +        return false;
> +    }
> +
>      if (migration_is_blocked(errp)) {
>          return false;
>      }
> diff --git a/migration/ram.c b/migration/ram.c
> index 7208bc1..6730a41 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -228,6 +228,7 @@ bool migrate_ram_is_ignored(RAMBlock *block)
>      MigMode mode = migrate_mode();
>      return !qemu_ram_is_migratable(block) ||
>             mode == MIG_MODE_CPR_TRANSFER ||
> +           mode == MIG_MODE_CPR_EXEC ||
>             (migrate_ignore_shared() && qemu_ram_is_shared(block)
>                                      && qemu_ram_is_named_file(block));
>  }
> diff --git a/migration/vmstate-types.c b/migration/vmstate-types.c
> index 741a588..1aa0573 100644
> --- a/migration/vmstate-types.c
> +++ b/migration/vmstate-types.c
> @@ -321,6 +321,10 @@ static int get_fd(QEMUFile *f, void *pv, size_t size,
>                    const VMStateField *field)
>  {
>      int32_t *v = pv;
> +    if (migrate_mode() == MIG_MODE_CPR_EXEC) {
> +        qemu_get_sbe32s(f, v);
> +        return 0;
> +    }
>      *v = qemu_file_get_fd(f);
>      return 0;
>  }
> @@ -329,6 +333,10 @@ static int put_fd(QEMUFile *f, void *pv, size_t size,
>                    const VMStateField *field, JSONWriter *vmdesc)
>  {
>      int32_t *v = pv;
> +    if (migrate_mode() == MIG_MODE_CPR_EXEC) {
> +        qemu_put_sbe32s(f, v);
> +        return 0;
> +    }
>      return qemu_file_put_fd(f, *v);
>  }
>  
> diff --git a/system/vl.c b/system/vl.c
> index 4c24073..f395d04 100644
> --- a/system/vl.c
> +++ b/system/vl.c
> @@ -3867,6 +3867,8 @@ void qemu_init(int argc, char **argv)
>      }
>      qemu_init_displays();
>      accel_setup_post(current_machine);
> -    os_setup_post();
> +    if (migrate_mode() != MIG_MODE_CPR_EXEC) {
> +        os_setup_post();
> +    }
>      resume_mux_open();
>  }
> diff --git a/migration/trace-events b/migration/trace-events
> index 706db97..e8edd1f 100644
> --- a/migration/trace-events
> +++ b/migration/trace-events
> @@ -354,6 +354,7 @@ cpr_state_save(const char *mode) "%s mode"
>  cpr_state_load(const char *mode) "%s mode"
>  cpr_transfer_input(const char *path) "%s"
>  cpr_transfer_output(const char *path) "%s"
> +cpr_exec(void) ""
>  
>  # block-dirty-bitmap.c
>  send_bitmap_header_enter(void) ""
> -- 
> 1.8.3.1
> 

-- 
Peter Xu


