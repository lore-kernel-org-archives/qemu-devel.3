Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84F8BC25B10
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 23:35:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s47rM-0000r5-DC; Mon, 06 May 2024 19:35:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s47rL-0000qK-8f
 for qemu-devel@nongnu.org; Mon, 06 May 2024 19:35:03 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s47rJ-0005PU-51
 for qemu-devel@nongnu.org; Mon, 06 May 2024 19:35:02 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id BDB2522D01;
 Mon,  6 May 2024 23:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1715038497; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qDMZsJlGTu/AaeaVmfmgPf7nsAyStOjVH2gPcGlMKos=;
 b=ZYOtJeI0Z/TRFHycjSoTUIxH5JH30R0Rz1uEYur3uYD92S6D4V9tVgbfAGGdJtRZvnySs3
 T3Ba6QGrVr3VvGO4/izvvOh3TzV0jIuzLQKFG4BivrjBKc/evvuTyJeFVbg1BizHn40zNk
 kUpauvdCa9aNVp6BAFb9LMfMILt8Rz8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1715038497;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qDMZsJlGTu/AaeaVmfmgPf7nsAyStOjVH2gPcGlMKos=;
 b=t9vGamBB4dVpKXibkC8XcNPZwBd9V0wRxNkhefNNSo3gaM7uXdwwUO+fXtQzF80QTqPIPg
 dVoleII9JYS8hODg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ZYOtJeI0;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=t9vGamBB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1715038497; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qDMZsJlGTu/AaeaVmfmgPf7nsAyStOjVH2gPcGlMKos=;
 b=ZYOtJeI0Z/TRFHycjSoTUIxH5JH30R0Rz1uEYur3uYD92S6D4V9tVgbfAGGdJtRZvnySs3
 T3Ba6QGrVr3VvGO4/izvvOh3TzV0jIuzLQKFG4BivrjBKc/evvuTyJeFVbg1BizHn40zNk
 kUpauvdCa9aNVp6BAFb9LMfMILt8Rz8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1715038497;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qDMZsJlGTu/AaeaVmfmgPf7nsAyStOjVH2gPcGlMKos=;
 b=t9vGamBB4dVpKXibkC8XcNPZwBd9V0wRxNkhefNNSo3gaM7uXdwwUO+fXtQzF80QTqPIPg
 dVoleII9JYS8hODg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 30D7813A25;
 Mon,  6 May 2024 23:34:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id uNg+OiBpOWY8GgAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 06 May 2024 23:34:56 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>, Igor
 Mammedov <imammedo@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Philippe Mathieu-Daude
 <philmd@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, "Daniel P.
 Berrange" <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: Re: [PATCH V1 06/26] migration: precreate vmstate for exec
In-Reply-To: <1714406135-451286-7-git-send-email-steven.sistare@oracle.com>
References: <1714406135-451286-1-git-send-email-steven.sistare@oracle.com>
 <1714406135-451286-7-git-send-email-steven.sistare@oracle.com>
Date: Mon, 06 May 2024 20:34:54 -0300
Message-ID: <8734qums4h.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: BDB2522D01
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; RCPT_COUNT_TWELVE(0.00)[12];
 FUZZY_BLOCKED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 FREEMAIL_CC(0.00)[redhat.com,habkost.net,gmail.com,linaro.org,oracle.com];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TAGGED_RCPT(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]; MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

Steve Sistare <steven.sistare@oracle.com> writes:

> Provide migration_precreate_save for saving precreate vmstate across exec.
> Create a memfd, save its value in the environment, and serialize state
> to it.  Reverse the process in migration_precreate_load.
>
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>  include/migration/misc.h |   5 ++
>  migration/meson.build    |   1 +
>  migration/precreate.c    | 139 +++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 145 insertions(+)
>  create mode 100644 migration/precreate.c
>
> diff --git a/include/migration/misc.h b/include/migration/misc.h
> index c9e200f..cf30351 100644
> --- a/include/migration/misc.h
> +++ b/include/migration/misc.h
> @@ -56,6 +56,11 @@ AnnounceParameters *migrate_announce_params(void);
>  
>  void dump_vmstate_json_to_file(FILE *out_fp);
>  
> +/* migration/precreate.c */
> +int migration_precreate_save(Error **errp);
> +void migration_precreate_unsave(void);
> +int migration_precreate_load(Error **errp);
> +
>  /* migration/migration.c */
>  void migration_object_init(void);
>  void migration_shutdown(void);
> diff --git a/migration/meson.build b/migration/meson.build
> index f76b1ba..50e7cb2 100644
> --- a/migration/meson.build
> +++ b/migration/meson.build
> @@ -26,6 +26,7 @@ system_ss.add(files(
>    'ram-compress.c',
>    'options.c',
>    'postcopy-ram.c',
> +  'precreate.c',
>    'savevm.c',
>    'socket.c',
>    'tls.c',
> diff --git a/migration/precreate.c b/migration/precreate.c
> new file mode 100644
> index 0000000..0bf5e1f
> --- /dev/null
> +++ b/migration/precreate.c
> @@ -0,0 +1,139 @@
> +/*
> + * Copyright (c) 2022, 2024 Oracle and/or its affiliates.
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/cutils.h"
> +#include "qemu/memfd.h"
> +#include "qapi/error.h"
> +#include "io/channel-file.h"
> +#include "migration/misc.h"
> +#include "migration/qemu-file.h"
> +#include "migration/savevm.h"
> +
> +#define PRECREATE_STATE_NAME "QEMU_PRECREATE_STATE"
> +
> +static QEMUFile *qemu_file_new_fd_input(int fd, const char *name)
> +{
> +    g_autoptr(QIOChannelFile) fioc = qio_channel_file_new_fd(fd);
> +    QIOChannel *ioc = QIO_CHANNEL(fioc);
> +    qio_channel_set_name(ioc, name);
> +    return qemu_file_new_input(ioc);
> +}
> +
> +static QEMUFile *qemu_file_new_fd_output(int fd, const char *name)
> +{
> +    g_autoptr(QIOChannelFile) fioc = qio_channel_file_new_fd(fd);
> +    QIOChannel *ioc = QIO_CHANNEL(fioc);
> +    qio_channel_set_name(ioc, name);
> +    return qemu_file_new_output(ioc);
> +}
> +
> +static int memfd_create_named(const char *name, Error **errp)
> +{
> +    int mfd;
> +    char val[16];
> +
> +    mfd = memfd_create(name, 0);
> +    if (mfd < 0) {
> +        error_setg_errno(errp, errno, "memfd_create failed");
> +        return -1;
> +    }
> +
> +    /* Remember mfd in environment for post-exec load */
> +    qemu_clear_cloexec(mfd);
> +    snprintf(val, sizeof(val), "%d", mfd);
> +    g_setenv(name, val, 1);
> +
> +    return mfd;
> +}
> +
> +static int memfd_find_named(const char *name, int *mfd_p, Error **errp)
> +{
> +    const char *val = g_getenv(name);
> +
> +    if (!val) {
> +        *mfd_p = -1;
> +        return 0;       /* No memfd was created, not an error */
> +    }
> +    g_unsetenv(name);
> +    if (qemu_strtoi(val, NULL, 10, mfd_p)) {
> +        error_setg(errp, "Bad %s env value %s", PRECREATE_STATE_NAME, val);
> +        return -1;
> +    }
> +    lseek(*mfd_p, 0, SEEK_SET);
> +    return 0;
> +}
> +
> +static void memfd_delete_named(const char *name)
> +{
> +    int mfd;
> +    const char *val = g_getenv(name);
> +
> +    if (val) {
> +        g_unsetenv(name);
> +        if (!qemu_strtoi(val, NULL, 10, &mfd)) {
> +            close(mfd);
> +        }
> +    }
> +}
> +
> +static QEMUFile *qemu_file_new_memfd_output(const char *name, Error **errp)
> +{
> +    int mfd = memfd_create_named(name, errp);
> +
> +    if (mfd < 0) {
> +        return NULL;
> +    }
> +
> +    return qemu_file_new_fd_output(mfd, name);
> +}
> +
> +static QEMUFile *qemu_file_new_memfd_input(const char *name, Error **errp)
> +{
> +    int ret, mfd;
> +
> +    ret = memfd_find_named(name, &mfd, errp);
> +    if (ret || mfd < 0) {
> +        return NULL;
> +    }
> +
> +    return qemu_file_new_fd_input(mfd, name);
> +}
> +
> +int migration_precreate_save(Error **errp)
> +{
> +    QEMUFile *f = qemu_file_new_memfd_output(PRECREATE_STATE_NAME, errp);
> +
> +    if (!f) {
> +        return -1;
> +    } else if (qemu_savevm_precreate_save(f, errp)) {
> +        memfd_delete_named(PRECREATE_STATE_NAME);
> +        return -1;
> +    } else {
> +        /* Do not close f, as mfd must remain open. */
> +        return 0;
> +    }
> +}
> +
> +void migration_precreate_unsave(void)
> +{
> +    memfd_delete_named(PRECREATE_STATE_NAME);
> +}
> +
> +int migration_precreate_load(Error **errp)
> +{
> +    int ret;
> +    QEMUFile *f = qemu_file_new_memfd_input(PRECREATE_STATE_NAME, errp);

Can we avoid the QEMUFile? I don't see it being exported from this file.

> +
> +    if (!f) {
> +        return -1;
> +    }
> +    ret = qemu_savevm_precreate_load(f, errp);
> +    qemu_fclose(f);
> +    g_unsetenv(PRECREATE_STATE_NAME);
> +    return ret;
> +}

