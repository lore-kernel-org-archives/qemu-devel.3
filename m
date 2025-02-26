Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E071C18E7C
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 16:44:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnKW1-0008Hs-Jz; Wed, 26 Feb 2025 11:44:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tnKVu-0008Fl-J5
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 11:44:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tnKVs-00030Y-J4
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 11:44:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740588238;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=N22T5LB6yuFa/YMgG6JjcM6qlNETxOYvRfVUWzju59w=;
 b=S/00Oj36seTqDuk5pRqoHdAGN9nfSOrn8ELCHbt4l3/M6j9Uohiu2ID8NR59sCCJt23DG9
 iCoBBYbrBf6q2wCVCsjK9zO4fb8gGpAOgeAk680twQ77tnvX6+1Wa1+1dPg0YtkyVKLF+a
 luOe6N/dSAjoUJunNOnu/ZWONtigmlk=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-wz--6mrRNTOGYogieadxlg-1; Wed, 26 Feb 2025 11:43:57 -0500
X-MC-Unique: wz--6mrRNTOGYogieadxlg-1
X-Mimecast-MFC-AGG-ID: wz--6mrRNTOGYogieadxlg_1740588237
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7c0a71aaf9fso1035120585a.3
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2025 08:43:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740588237; x=1741193037;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N22T5LB6yuFa/YMgG6JjcM6qlNETxOYvRfVUWzju59w=;
 b=kvGC4TL+IFXo6Z2phE5lbpJIiBzkbi0IYCI/Yi1d7LRrORzxqKHXQxjeG4IfyE6yim
 xcomxSE7RZoYK07/SB1vSvYsE1MwGTGwW2d4Y2YZUUG5KlmcsqU1MjC4ZXbsCHqQSeGp
 Q4dY+K+YNI/UyS3nuUZ8pwCb9BSLrwN3MsW/MEPzXjA+C7Nh0IBeUoxoaWYBaMf8TQrQ
 gEAO/J/2dSnPR8tQ9AM5FdQR814cr8VLYFdOScfPVIbNUoNlztKHKkYXwSYmILeSWTcf
 +QtgSmAmgN7PDekKhhA5OzOTgOxZBIK9AbATkwrbL61ZMsbmdctgHTp8fknoB47uxf7s
 lQeg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWiyPg+xBBjSKi/XzhEkvyUWHzb8+jydDXFcLGDfIdbkjRxmZZG19nWlZTvo6KF3Xf0Ro3wZ9i2nAEy@nongnu.org
X-Gm-Message-State: AOJu0YxzQHHnYoHEl7+9yRG8mIPc1v9kw+4yS0xnoaq6tiomigoPibkG
 u+ewO0VyZFPRzlz0fMsgp36U0U7/VW73rCoFgPT+UBEkRl55esaeLlV+anurdoow0wOKM323Orp
 meE9nMgctpLDry3uvDIGQR1PqFyuldLOlPi5bvtQi4zUYaygw10gw
X-Gm-Gg: ASbGnct8GNNSgU9d9O1EwrUHoWDwWYqXhfThaoJlMJpGT8FeEm5WrRdYMhjjKHcRaAv
 3U9FOevDtXg0azmyB7HLHRkPf3HMcFfcEUZtXrxrhczvK9ghbzDRknUGiAH4lK1YVZjTmOWfSGm
 LVA3N8+ZyjNPua3FZbJ8EDhx8UH3I4ok8Beq0xJd/SKwkU2NNupY37IQbDS3p9B8+yDK8yeW/t5
 BPQJeaufzWzC8PvTXD/yMrT2kLvTse3iER6/Q5SdvIpqbrCWI+uQo4VV/iDlHMoQb6n4w==
X-Received: by 2002:a05:620a:2699:b0:7c0:c3a2:9609 with SMTP id
 af79cd13be357-7c23be26e2amr949181385a.34.1740588236979; 
 Wed, 26 Feb 2025 08:43:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHZ7cgdTlrs8ddrMJ5mcEr0UTk+OINfYbWuCmTfg9FLnUvdgJYtAE0ft4Lme1+r7/OEIp6t5Q==
X-Received: by 2002:a05:620a:2699:b0:7c0:c3a2:9609 with SMTP id
 af79cd13be357-7c23be26e2amr949178585a.34.1740588236626; 
 Wed, 26 Feb 2025 08:43:56 -0800 (PST)
Received: from x1.local ([2604:7a40:2041:2b00::1001])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c23c299315sm266580485a.9.2025.02.26.08.43.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2025 08:43:55 -0800 (PST)
Date: Wed, 26 Feb 2025 11:43:53 -0500
From: Peter Xu <peterx@redhat.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v5 17/36] migration: Add
 save_live_complete_precopy_thread handler
Message-ID: <Z79EyapCxc2HMHPQ@x1.local>
References: <cover.1739994627.git.maciej.szmigiero@oracle.com>
 <910a9d0950b609943e414ec557bebee85a4804a5.1739994627.git.maciej.szmigiero@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <910a9d0950b609943e414ec557bebee85a4804a5.1739994627.git.maciej.szmigiero@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.44,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Feb 19, 2025 at 09:33:59PM +0100, Maciej S. Szmigiero wrote:
> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
> 
> This SaveVMHandler helps device provide its own asynchronous transmission
> of the remaining data at the end of a precopy phase via multifd channels,
> in parallel with the transfer done by save_live_complete_precopy handlers.
> 
> These threads are launched only when multifd device state transfer is
> supported.
> 
> Management of these threads in done in the multifd migration code,
> wrapping them in the generic thread pool.
> 
> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
> ---
>  include/migration/misc.h         | 17 +++++++
>  include/migration/register.h     | 19 +++++++
>  include/qemu/typedefs.h          |  3 ++
>  migration/multifd-device-state.c | 85 ++++++++++++++++++++++++++++++++
>  migration/savevm.c               | 35 ++++++++++++-
>  5 files changed, 158 insertions(+), 1 deletion(-)
> 
> diff --git a/include/migration/misc.h b/include/migration/misc.h
> index 273ebfca6256..8fd36eba1da7 100644
> --- a/include/migration/misc.h
> +++ b/include/migration/misc.h
> @@ -119,8 +119,25 @@ bool migrate_uri_parse(const char *uri, MigrationChannel **channel,
>                         Error **errp);
>  
>  /* migration/multifd-device-state.c */
> +typedef struct SaveLiveCompletePrecopyThreadData {
> +    SaveLiveCompletePrecopyThreadHandler hdlr;
> +    char *idstr;
> +    uint32_t instance_id;
> +    void *handler_opaque;
> +} SaveLiveCompletePrecopyThreadData;
> +
>  bool multifd_queue_device_state(char *idstr, uint32_t instance_id,
>                                  char *data, size_t len);
>  bool multifd_device_state_supported(void);
>  
> +void
> +multifd_spawn_device_state_save_thread(SaveLiveCompletePrecopyThreadHandler hdlr,
> +                                       char *idstr, uint32_t instance_id,
> +                                       void *opaque);
> +
> +bool multifd_device_state_save_thread_should_exit(void);
> +
> +void multifd_abort_device_state_save_threads(void);
> +bool multifd_join_device_state_save_threads(void);
> +
>  #endif
> diff --git a/include/migration/register.h b/include/migration/register.h
> index 58891aa54b76..c041ce32f2fc 100644
> --- a/include/migration/register.h
> +++ b/include/migration/register.h
> @@ -105,6 +105,25 @@ typedef struct SaveVMHandlers {
>       */
>      int (*save_live_complete_precopy)(QEMUFile *f, void *opaque);
>  
> +    /**
> +     * @save_live_complete_precopy_thread (invoked in a separate thread)
> +     *
> +     * Called at the end of a precopy phase from a separate worker thread
> +     * in configurations where multifd device state transfer is supported
> +     * in order to perform asynchronous transmission of the remaining data in
> +     * parallel with @save_live_complete_precopy handlers.
> +     * When postcopy is enabled, devices that support postcopy will skip this
> +     * step.
> +     *
> +     * @d: a #SaveLiveCompletePrecopyThreadData containing parameters that the
> +     * handler may need, including this device section idstr and instance_id,
> +     * and opaque data pointer passed to register_savevm_live().
> +     * @errp: pointer to Error*, to store an error if it happens.
> +     *
> +     * Returns true to indicate success and false for errors.
> +     */
> +    SaveLiveCompletePrecopyThreadHandler save_live_complete_precopy_thread;
> +
>      /* This runs both outside and inside the BQL.  */
>  
>      /**
> diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
> index fd23ff7771b1..42ed4e6be150 100644
> --- a/include/qemu/typedefs.h
> +++ b/include/qemu/typedefs.h
> @@ -108,6 +108,7 @@ typedef struct QString QString;
>  typedef struct RAMBlock RAMBlock;
>  typedef struct Range Range;
>  typedef struct ReservedRegion ReservedRegion;
> +typedef struct SaveLiveCompletePrecopyThreadData SaveLiveCompletePrecopyThreadData;
>  typedef struct SHPCDevice SHPCDevice;
>  typedef struct SSIBus SSIBus;
>  typedef struct TCGCPUOps TCGCPUOps;
> @@ -133,5 +134,7 @@ typedef struct IRQState *qemu_irq;
>  typedef void (*qemu_irq_handler)(void *opaque, int n, int level);
>  typedef bool (*MigrationLoadThread)(void *opaque, bool *should_quit,
>                                      Error **errp);
> +typedef bool (*SaveLiveCompletePrecopyThreadHandler)(SaveLiveCompletePrecopyThreadData *d,
> +                                                     Error **errp);
>  
>  #endif /* QEMU_TYPEDEFS_H */
> diff --git a/migration/multifd-device-state.c b/migration/multifd-device-state.c
> index 5de3cf27d6e8..63f021fb8dad 100644
> --- a/migration/multifd-device-state.c
> +++ b/migration/multifd-device-state.c
> @@ -8,7 +8,10 @@
>   */
>  
>  #include "qemu/osdep.h"
> +#include "qapi/error.h"
>  #include "qemu/lockable.h"
> +#include "block/thread-pool.h"
> +#include "migration.h"
>  #include "migration/misc.h"
>  #include "multifd.h"
>  #include "options.h"
> @@ -17,6 +20,9 @@ static struct {
>      QemuMutex queue_job_mutex;
>  
>      MultiFDSendData *send_data;
> +
> +    ThreadPool *threads;
> +    bool threads_abort;
>  } *multifd_send_device_state;
>  
>  void multifd_device_state_send_setup(void)
> @@ -27,10 +33,14 @@ void multifd_device_state_send_setup(void)
>      qemu_mutex_init(&multifd_send_device_state->queue_job_mutex);
>  
>      multifd_send_device_state->send_data = multifd_send_data_alloc();
> +
> +    multifd_send_device_state->threads = thread_pool_new();
> +    multifd_send_device_state->threads_abort = false;
>  }
>  
>  void multifd_device_state_send_cleanup(void)
>  {
> +    g_clear_pointer(&multifd_send_device_state->threads, thread_pool_free);
>      g_clear_pointer(&multifd_send_device_state->send_data,
>                      multifd_send_data_free);
>  
> @@ -115,3 +125,78 @@ bool multifd_device_state_supported(void)
>      return migrate_multifd() && !migrate_mapped_ram() &&
>          migrate_multifd_compression() == MULTIFD_COMPRESSION_NONE;
>  }
> +
> +static void multifd_device_state_save_thread_data_free(void *opaque)
> +{
> +    SaveLiveCompletePrecopyThreadData *data = opaque;
> +
> +    g_clear_pointer(&data->idstr, g_free);
> +    g_free(data);
> +}
> +
> +static int multifd_device_state_save_thread(void *opaque)
> +{
> +    SaveLiveCompletePrecopyThreadData *data = opaque;
> +    g_autoptr(Error) local_err = NULL;
> +
> +    if (!data->hdlr(data, &local_err)) {
> +        MigrationState *s = migrate_get_current();
> +
> +        assert(local_err);
> +
> +        /*
> +         * In case of multiple save threads failing which thread error
> +         * return we end setting is purely arbitrary.
> +         */
> +        migrate_set_error(s, local_err);

Where did you kick off all the threads when one hit error?  I wonder if
migrate_set_error() should just set quit flag for everything, but for this
series it might be easier to use multifd_abort_device_state_save_threads().

Other than that, looks good to me, thanks.

> +    }
> +
> +    return 0;
> +}
> +
> +bool multifd_device_state_save_thread_should_exit(void)
> +{
> +    return qatomic_read(&multifd_send_device_state->threads_abort);
> +}
> +
> +void
> +multifd_spawn_device_state_save_thread(SaveLiveCompletePrecopyThreadHandler hdlr,
> +                                       char *idstr, uint32_t instance_id,
> +                                       void *opaque)
> +{
> +    SaveLiveCompletePrecopyThreadData *data;
> +
> +    assert(multifd_device_state_supported());
> +    assert(multifd_send_device_state);
> +
> +    assert(!qatomic_read(&multifd_send_device_state->threads_abort));
> +
> +    data = g_new(SaveLiveCompletePrecopyThreadData, 1);
> +    data->hdlr = hdlr;
> +    data->idstr = g_strdup(idstr);
> +    data->instance_id = instance_id;
> +    data->handler_opaque = opaque;
> +
> +    thread_pool_submit_immediate(multifd_send_device_state->threads,
> +                                 multifd_device_state_save_thread,
> +                                 data,
> +                                 multifd_device_state_save_thread_data_free);
> +}
> +
> +void multifd_abort_device_state_save_threads(void)
> +{
> +    assert(multifd_device_state_supported());
> +
> +    qatomic_set(&multifd_send_device_state->threads_abort, true);
> +}
> +
> +bool multifd_join_device_state_save_threads(void)
> +{
> +    MigrationState *s = migrate_get_current();
> +
> +    assert(multifd_device_state_supported());
> +
> +    thread_pool_wait(multifd_send_device_state->threads);
> +
> +    return !migrate_has_error(s);
> +}
> diff --git a/migration/savevm.c b/migration/savevm.c
> index e412d05657a1..9a1e0ac807a0 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -37,6 +37,7 @@
>  #include "migration/register.h"
>  #include "migration/global_state.h"
>  #include "migration/channel-block.h"
> +#include "multifd.h"
>  #include "ram.h"
>  #include "qemu-file.h"
>  #include "savevm.h"
> @@ -1527,6 +1528,24 @@ int qemu_savevm_state_complete_precopy_iterable(QEMUFile *f, bool in_postcopy)
>      int64_t start_ts_each, end_ts_each;
>      SaveStateEntry *se;
>      int ret;
> +    bool multifd_device_state = multifd_device_state_supported();
> +
> +    if (multifd_device_state) {
> +        QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
> +            SaveLiveCompletePrecopyThreadHandler hdlr;
> +
> +            if (!se->ops || (in_postcopy && se->ops->has_postcopy &&
> +                             se->ops->has_postcopy(se->opaque)) ||
> +                !se->ops->save_live_complete_precopy_thread) {
> +                continue;
> +            }
> +
> +            hdlr = se->ops->save_live_complete_precopy_thread;
> +            multifd_spawn_device_state_save_thread(hdlr,
> +                                                   se->idstr, se->instance_id,
> +                                                   se->opaque);
> +        }
> +    }
>  
>      QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
>          if (!se->ops ||
> @@ -1552,16 +1571,30 @@ int qemu_savevm_state_complete_precopy_iterable(QEMUFile *f, bool in_postcopy)
>          save_section_footer(f, se);
>          if (ret < 0) {
>              qemu_file_set_error(f, ret);
> -            return -1;
> +            goto ret_fail_abort_threads;
>          }
>          end_ts_each = qemu_clock_get_us(QEMU_CLOCK_REALTIME);
>          trace_vmstate_downtime_save("iterable", se->idstr, se->instance_id,
>                                      end_ts_each - start_ts_each);
>      }
>  
> +    if (multifd_device_state &&
> +        !multifd_join_device_state_save_threads()) {
> +        qemu_file_set_error(f, -EINVAL);
> +        return -1;
> +    }
> +
>      trace_vmstate_downtime_checkpoint("src-iterable-saved");
>  
>      return 0;
> +
> +ret_fail_abort_threads:
> +    if (multifd_device_state) {
> +        multifd_abort_device_state_save_threads();
> +        multifd_join_device_state_save_threads();
> +    }
> +
> +    return -1;
>  }
>  
>  int qemu_savevm_state_complete_precopy_non_iterable(QEMUFile *f,
> 

-- 
Peter Xu


