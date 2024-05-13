Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58774C25B10
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 21:22:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6d76-0007kk-Af; Mon, 13 May 2024 17:21:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s6d72-0007kN-AA
 for qemu-devel@nongnu.org; Mon, 13 May 2024 17:21:36 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s6d70-0006TC-C7
 for qemu-devel@nongnu.org; Mon, 13 May 2024 17:21:36 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 251815D201;
 Mon, 13 May 2024 21:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1715635292; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TeUnjiOW3m67Pw19QwR6SGg6f37V29VVrHEnTMuhiVo=;
 b=kO6B6+RoTLc0kpBFtryk/1iHIUGO36xYLpHR4EStIrg9fYBcsOiv2JqVS61xbYwhpxHyGc
 KmyYtTXnfsiqW0UAfhBUlZhYnXQhzD0/HuFMRQLjkne2Dte8g2tTvD/7l8Fh7+Y57IfOTM
 u8dQii7yx15W59L2CtYPtoUc2GAy/fY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1715635292;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TeUnjiOW3m67Pw19QwR6SGg6f37V29VVrHEnTMuhiVo=;
 b=S1vEdWOct4m5QyM/Fbb4cQqermXHlC6sPwiJlS1/nK3EGHZYqad9LzOxGlfN/k87kmbVC9
 NVznZCfSpQC1NJCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1715635292; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TeUnjiOW3m67Pw19QwR6SGg6f37V29VVrHEnTMuhiVo=;
 b=kO6B6+RoTLc0kpBFtryk/1iHIUGO36xYLpHR4EStIrg9fYBcsOiv2JqVS61xbYwhpxHyGc
 KmyYtTXnfsiqW0UAfhBUlZhYnXQhzD0/HuFMRQLjkne2Dte8g2tTvD/7l8Fh7+Y57IfOTM
 u8dQii7yx15W59L2CtYPtoUc2GAy/fY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1715635292;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TeUnjiOW3m67Pw19QwR6SGg6f37V29VVrHEnTMuhiVo=;
 b=S1vEdWOct4m5QyM/Fbb4cQqermXHlC6sPwiJlS1/nK3EGHZYqad9LzOxGlfN/k87kmbVC9
 NVznZCfSpQC1NJCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A17B013A52;
 Mon, 13 May 2024 21:21:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id DSbhGVuEQmaYMQAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 13 May 2024 21:21:31 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Steven Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>, Igor
 Mammedov <imammedo@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Philippe Mathieu-Daude
 <philmd@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, "Daniel P.
 Berrange" <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH V1 06/26] migration: precreate vmstate for exec
In-Reply-To: <6950e549-4714-44e7-b6ee-641649024215@oracle.com>
References: <1714406135-451286-1-git-send-email-steven.sistare@oracle.com>
 <1714406135-451286-7-git-send-email-steven.sistare@oracle.com>
 <8734qums4h.fsf@suse.de> <6950e549-4714-44e7-b6ee-641649024215@oracle.com>
Date: Mon, 13 May 2024 18:21:29 -0300
Message-ID: <875xvhflwm.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; TAGGED_RCPT(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_SEVEN(0.00)[11];
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[redhat.com,habkost.net,gmail.com,linaro.org];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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

Steven Sistare <steven.sistare@oracle.com> writes:

> On 5/6/2024 7:34 PM, Fabiano Rosas wrote:
>> Steve Sistare <steven.sistare@oracle.com> writes:
>> 
>>> Provide migration_precreate_save for saving precreate vmstate across exec.
>>> Create a memfd, save its value in the environment, and serialize state
>>> to it.  Reverse the process in migration_precreate_load.
>>>
>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>> ---
>>>   include/migration/misc.h |   5 ++
>>>   migration/meson.build    |   1 +
>>>   migration/precreate.c    | 139 +++++++++++++++++++++++++++++++++++++++++++++++
>>>   3 files changed, 145 insertions(+)
>>>   create mode 100644 migration/precreate.c
>>>
>>> diff --git a/include/migration/misc.h b/include/migration/misc.h
>>> index c9e200f..cf30351 100644
>>> --- a/include/migration/misc.h
>>> +++ b/include/migration/misc.h
>>> @@ -56,6 +56,11 @@ AnnounceParameters *migrate_announce_params(void);
>>>   
>>>   void dump_vmstate_json_to_file(FILE *out_fp);
>>>   
>>> +/* migration/precreate.c */
>>> +int migration_precreate_save(Error **errp);
>>> +void migration_precreate_unsave(void);
>>> +int migration_precreate_load(Error **errp);
>>> +
>>>   /* migration/migration.c */
>>>   void migration_object_init(void);
>>>   void migration_shutdown(void);
>>> diff --git a/migration/meson.build b/migration/meson.build
>>> index f76b1ba..50e7cb2 100644
>>> --- a/migration/meson.build
>>> +++ b/migration/meson.build
>>> @@ -26,6 +26,7 @@ system_ss.add(files(
>>>     'ram-compress.c',
>>>     'options.c',
>>>     'postcopy-ram.c',
>>> +  'precreate.c',
>>>     'savevm.c',
>>>     'socket.c',
>>>     'tls.c',
>>> diff --git a/migration/precreate.c b/migration/precreate.c
>>> new file mode 100644
>>> index 0000000..0bf5e1f
>>> --- /dev/null
>>> +++ b/migration/precreate.c
>>> @@ -0,0 +1,139 @@
>>> +/*
>>> + * Copyright (c) 2022, 2024 Oracle and/or its affiliates.
>>> + *
>>> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
>>> + * See the COPYING file in the top-level directory.
>>> + */
>>> +
>>> +#include "qemu/osdep.h"
>>> +#include "qemu/cutils.h"
>>> +#include "qemu/memfd.h"
>>> +#include "qapi/error.h"
>>> +#include "io/channel-file.h"
>>> +#include "migration/misc.h"
>>> +#include "migration/qemu-file.h"
>>> +#include "migration/savevm.h"
>>> +
>>> +#define PRECREATE_STATE_NAME "QEMU_PRECREATE_STATE"
>>> +
>>> +static QEMUFile *qemu_file_new_fd_input(int fd, const char *name)
>>> +{
>>> +    g_autoptr(QIOChannelFile) fioc = qio_channel_file_new_fd(fd);
>>> +    QIOChannel *ioc = QIO_CHANNEL(fioc);
>>> +    qio_channel_set_name(ioc, name);
>>> +    return qemu_file_new_input(ioc);
>>> +}
>>> +
>>> +static QEMUFile *qemu_file_new_fd_output(int fd, const char *name)
>>> +{
>>> +    g_autoptr(QIOChannelFile) fioc = qio_channel_file_new_fd(fd);
>>> +    QIOChannel *ioc = QIO_CHANNEL(fioc);
>>> +    qio_channel_set_name(ioc, name);
>>> +    return qemu_file_new_output(ioc);
>>> +}
>>> +
>>> +static int memfd_create_named(const char *name, Error **errp)
>>> +{
>>> +    int mfd;
>>> +    char val[16];
>>> +
>>> +    mfd = memfd_create(name, 0);
>>> +    if (mfd < 0) {
>>> +        error_setg_errno(errp, errno, "memfd_create failed");
>>> +        return -1;
>>> +    }
>>> +
>>> +    /* Remember mfd in environment for post-exec load */
>>> +    qemu_clear_cloexec(mfd);
>>> +    snprintf(val, sizeof(val), "%d", mfd);
>>> +    g_setenv(name, val, 1);
>>> +
>>> +    return mfd;
>>> +}
>>> +
>>> +static int memfd_find_named(const char *name, int *mfd_p, Error **errp)
>>> +{
>>> +    const char *val = g_getenv(name);
>>> +
>>> +    if (!val) {
>>> +        *mfd_p = -1;
>>> +        return 0;       /* No memfd was created, not an error */
>>> +    }
>>> +    g_unsetenv(name);
>>> +    if (qemu_strtoi(val, NULL, 10, mfd_p)) {
>>> +        error_setg(errp, "Bad %s env value %s", PRECREATE_STATE_NAME, val);
>>> +        return -1;
>>> +    }
>>> +    lseek(*mfd_p, 0, SEEK_SET);
>>> +    return 0;
>>> +}
>>> +
>>> +static void memfd_delete_named(const char *name)
>>> +{
>>> +    int mfd;
>>> +    const char *val = g_getenv(name);
>>> +
>>> +    if (val) {
>>> +        g_unsetenv(name);
>>> +        if (!qemu_strtoi(val, NULL, 10, &mfd)) {
>>> +            close(mfd);
>>> +        }
>>> +    }
>>> +}
>>> +
>>> +static QEMUFile *qemu_file_new_memfd_output(const char *name, Error **errp)
>>> +{
>>> +    int mfd = memfd_create_named(name, errp);
>>> +
>>> +    if (mfd < 0) {
>>> +        return NULL;
>>> +    }
>>> +
>>> +    return qemu_file_new_fd_output(mfd, name);
>>> +}
>>> +
>>> +static QEMUFile *qemu_file_new_memfd_input(const char *name, Error **errp)
>>> +{
>>> +    int ret, mfd;
>>> +
>>> +    ret = memfd_find_named(name, &mfd, errp);
>>> +    if (ret || mfd < 0) {
>>> +        return NULL;
>>> +    }
>>> +
>>> +    return qemu_file_new_fd_input(mfd, name);
>>> +}
>>> +
>>> +int migration_precreate_save(Error **errp)
>>> +{
>>> +    QEMUFile *f = qemu_file_new_memfd_output(PRECREATE_STATE_NAME, errp);
>>> +
>>> +    if (!f) {
>>> +        return -1;
>>> +    } else if (qemu_savevm_precreate_save(f, errp)) {
>>> +        memfd_delete_named(PRECREATE_STATE_NAME);
>>> +        return -1;
>>> +    } else {
>>> +        /* Do not close f, as mfd must remain open. */
>>> +        return 0;
>>> +    }
>>> +}
>>> +
>>> +void migration_precreate_unsave(void)
>>> +{
>>> +    memfd_delete_named(PRECREATE_STATE_NAME);
>>> +}
>>> +
>>> +int migration_precreate_load(Error **errp)
>>> +{
>>> +    int ret;
>>> +    QEMUFile *f = qemu_file_new_memfd_input(PRECREATE_STATE_NAME, errp);
>> 
>> Can we avoid the QEMUFile? I don't see it being exported from this file.
>
> It is not exported, but within this file, it is the basis for all read and
> write operations, via the existing functions qemu_file_new_input() and 
> qemu_file_new_output()

Right, that's the easy part, we could just use the QIOChannel
directly. But I missed the fact that you also need to interop with the
existing code that needs the QEMUFile.

Reviewed-by: Fabiano Rosas <farosas@suse.de>

