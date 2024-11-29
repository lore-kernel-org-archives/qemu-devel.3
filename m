Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00A9ED6EC0E
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2024 14:04:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tH1b6-0003Fl-PT; Fri, 29 Nov 2024 09:03:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tH1b4-0003FI-JF
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 09:03:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tH1b2-0008Hm-JK
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 09:03:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732889026;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Tn6+PhyWnk76N1SNHeLxXA5/7GABil60v+7N34V0664=;
 b=YhaYwieXCQxmxbj8MiY8vwzx3rJic3yfeqI2CWSvbNR15Lb25Ej/2JtKRbesiGIC/xqKaj
 SweTvWVYosInUZMGJKiyY3A8VYOKcXRCTYIb8gpkCppsJ3BhrbJ93Y5PmnaHwmNXtfcOuy
 YQ5R4kgh/5RgOGgYi/tXlIq+CzeZXZg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-351-d5qk0mOuNdOwpo-qfikIuA-1; Fri, 29 Nov 2024 09:03:44 -0500
X-MC-Unique: d5qk0mOuNdOwpo-qfikIuA-1
X-Mimecast-MFC-AGG-ID: d5qk0mOuNdOwpo-qfikIuA
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4349e08ae91so14056285e9.0
 for <qemu-devel@nongnu.org>; Fri, 29 Nov 2024 06:03:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732889023; x=1733493823;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Tn6+PhyWnk76N1SNHeLxXA5/7GABil60v+7N34V0664=;
 b=NJ/MjJx3CA4B4Ju8gIQZdGk/6I2wex9RIxzJWqlKld8XevtfmTp7Yiu68qO5WcoTi4
 KGXHOSDj4edyHwlKRdz6TLWrQChnkLOGB8sCQP6d1zHmZ7KYpRKKGULhHFLAM4vpQJYo
 gQFt269muyp0HulysNlnfP1fadhE70+hFaGje47yxSZQC2iJjXRw+CR9FLmYBLe1jn+w
 LrY5+E+8jQ+LdmxHItxt6ktYH2tExyvWAO46sZREoQT1zq53Rzy5+r7chhzg5q4YoQGV
 ZxqsxHmd7XsbAD+y6cPtWa3vg6GkyqU/rGuhp2SlMGSrLLL8hdjZT3RETtFV1Br55pWr
 PQow==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJFMQRVI+pxpjibMrUBYXgsmIS+BzJUtmIJxhrTp7QBcnj7fkPfQ+eTbZzeFOedxL7XXYxpkLqChJ4@nongnu.org
X-Gm-Message-State: AOJu0Yzmur88FtAIq8i3Sht2mzV4u1Lem1BMSOFr4cYvAHx1vZ216epo
 nDx5APfAZjy6JU2dsyHQn3H8r+c/dYHuk/5c/kt+asitLdyYxcGxIKv/QPv6k7m1Nr9tA3Ivyzy
 WrkdLaz9cklXLU/ddeBvgmOVNF8pQuGp/+YsMRBH5WxIWEFBRxLj7
X-Gm-Gg: ASbGnct2bJwq9hlIujZeiQzRm2TIv/c+ixXMtO3qv1WOwN/3HfTKuXqvu9ebzeGHG6B
 yTZ/Dq7vxOVOEd9THFU4I/EJGQhgSq8ycqQQbjLV6XQJY8Kd+FcL5N95XsJwM+mjwsqj1ByjHdm
 +fyhRnjZC1KCoyohOWeThXQWUsJAbH37HocepKAH3UWMP1SuHeQCcbbPLXLsl7/Tq1ImzT29fUU
 YEbAExsWzWeELfI2qfWsjeylZlKEl+5BQJ+8l7QDIuG4FGfLQ7f9TkEzTbeJFtj2tL6lD/UpB7t
 MEd3QdANUKZm
X-Received: by 2002:a05:600c:4f08:b0:434:a179:71b8 with SMTP id
 5b1f17b1804b1-434a9dbbc2cmr90062175e9.1.1732889022868; 
 Fri, 29 Nov 2024 06:03:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEr8ZleBIzHYOEpJMevLTBhcUk6kpqHXLBqjEPQPAbgOvtosjwi46F35ucwmRo2DT1WrOPcUQ==
X-Received: by 2002:a05:600c:4f08:b0:434:a179:71b8 with SMTP id
 5b1f17b1804b1-434a9dbbc2cmr90046975e9.1.1732889006853; 
 Fri, 29 Nov 2024 06:03:26 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434aa74f2c7sm87036575e9.2.2024.11.29.06.03.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Nov 2024 06:03:26 -0800 (PST)
Message-ID: <bac4bc49-4db2-4188-b449-1f324ab32074@redhat.com>
Date: Fri, 29 Nov 2024 15:03:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 17/24] migration: Add save_live_complete_precopy_thread
 handler
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>,
 qemu-devel@nongnu.org
References: <cover.1731773021.git.maciej.szmigiero@oracle.com>
 <87f31f02484d33e9a3bf1df08b0c8a9fa5fa9fe0.1731773021.git.maciej.szmigiero@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <87f31f02484d33e9a3bf1df08b0c8a9fa5fa9fe0.1731773021.git.maciej.szmigiero@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.93,
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

On 11/17/24 20:20, Maciej S. Szmigiero wrote:
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
>   include/migration/misc.h         |  8 +++
>   include/migration/register.h     | 23 +++++++++
>   include/qemu/typedefs.h          |  4 ++
>   migration/multifd-device-state.c | 85 ++++++++++++++++++++++++++++++++
>   migration/savevm.c               | 33 ++++++++++++-
>   5 files changed, 152 insertions(+), 1 deletion(-)
> 
> diff --git a/include/migration/misc.h b/include/migration/misc.h
> index 43558d9198f7..67014122dcff 100644
> --- a/include/migration/misc.h
> +++ b/include/migration/misc.h
> @@ -114,4 +114,12 @@ bool multifd_queue_device_state(char *idstr, uint32_t instance_id,
>                                   char *data, size_t len);
>   bool migration_has_device_state_support(void);
>   
> +void
> +multifd_spawn_device_state_save_thread(SaveLiveCompletePrecopyThreadHandler hdlr,
> +                                       char *idstr, uint32_t instance_id,
> +                                       void *opaque);
> +
> +void multifd_abort_device_state_save_threads(void);
> +int multifd_join_device_state_save_threads(void);
> +
>   #endif
> diff --git a/include/migration/register.h b/include/migration/register.h
> index 761e4e4d8bcb..ab702e0a930b 100644
> --- a/include/migration/register.h
> +++ b/include/migration/register.h
> @@ -105,6 +105,29 @@ typedef struct SaveVMHandlers {
>        */
>       int (*save_live_complete_precopy)(QEMUFile *f, void *opaque);
>   
> +    /* This runs in a separate thread. */
> +
> +    /**
> +     * @save_live_complete_precopy_thread
> +     *
> +     * Called at the end of a precopy phase from a separate worker thread
> +     * in configurations where multifd device state transfer is supported
> +     * in order to perform asynchronous transmission of the remaining data in
> +     * parallel with @save_live_complete_precopy handlers.
> +     * When postcopy is enabled, devices that support postcopy will skip this
> +     * step.
> +     *
> +     * @idstr: this device section idstr
> +     * @instance_id: this device section instance_id
> +     * @abort_flag: flag indicating that the migration core wants to abort
> +     * the transmission and so the handler should exit ASAP. To be read by
> +     * qatomic_read() or similar.
> +     * @opaque: data pointer passed to register_savevm_live()
> +     *
> +     * Returns zero to indicate success and negative for error
> +     */
> +    SaveLiveCompletePrecopyThreadHandler save_live_complete_precopy_thread;
> +
>       /* This runs both outside and inside the BQL.  */
>   
>       /**
> diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
> index 8c8ea5c2840d..926baaad211f 100644
> --- a/include/qemu/typedefs.h
> +++ b/include/qemu/typedefs.h
> @@ -132,5 +132,9 @@ typedef struct IRQState *qemu_irq;
>    */
>   typedef void (*qemu_irq_handler)(void *opaque, int n, int level);
>   typedef int (*MigrationLoadThread)(bool *abort_flag, void *opaque);
> +typedef int (*SaveLiveCompletePrecopyThreadHandler)(char *idstr,
> +                                                    uint32_t instance_id,
> +                                                    bool *abort_flag,
> +                                                    void *opaque);
>   
>   #endif /* QEMU_TYPEDEFS_H */
> diff --git a/migration/multifd-device-state.c b/migration/multifd-device-state.c
> index bcbea926b6be..74a4aef346c8 100644
> --- a/migration/multifd-device-state.c
> +++ b/migration/multifd-device-state.c
> @@ -9,12 +9,17 @@
>   
>   #include "qemu/osdep.h"
>   #include "qemu/lockable.h"
> +#include "block/thread-pool.h"
>   #include "migration/misc.h"
>   #include "multifd.h"
>   #include "options.h"
>   
>   static QemuMutex queue_job_mutex;
>   
> +static ThreadPool *send_threads;
> +static int send_threads_ret;
> +static bool send_threads_abort;
> +
>   static MultiFDSendData *device_state_send;
>   
>   void multifd_device_state_send_setup(void)
> @@ -22,6 +27,10 @@ void multifd_device_state_send_setup(void)
>       qemu_mutex_init(&queue_job_mutex);
>   
>       device_state_send = multifd_send_data_alloc();
> +
> +    send_threads = thread_pool_new();
> +    send_threads_ret = 0;
> +    send_threads_abort = false;
>   }
>   
>   void multifd_device_state_clear(MultiFDDeviceState_t *device_state)
> @@ -32,6 +41,7 @@ void multifd_device_state_clear(MultiFDDeviceState_t *device_state)
>   
>   void multifd_device_state_send_cleanup(void)
>   {
> +    g_clear_pointer(&send_threads, thread_pool_free);
>       g_clear_pointer(&device_state_send, multifd_send_data_free);
>   
>       qemu_mutex_destroy(&queue_job_mutex);
> @@ -106,3 +116,78 @@ bool migration_has_device_state_support(void)
>       return migrate_multifd() && !migrate_mapped_ram() &&
>           migrate_multifd_compression() == MULTIFD_COMPRESSION_NONE;
>   }
> +
> +struct MultiFDDSSaveThreadData {
> +    SaveLiveCompletePrecopyThreadHandler hdlr;
> +    char *idstr;
> +    uint32_t instance_id;
> +    void *handler_opaque;
> +};
> +
> +static void multifd_device_state_save_thread_data_free(void *opaque)
> +{
> +    struct MultiFDDSSaveThreadData *data = opaque;
> +
> +    g_clear_pointer(&data->idstr, g_free);
> +    g_free(data);
> +}
> +
> +static int multifd_device_state_save_thread(void *opaque)
> +{
> +    struct MultiFDDSSaveThreadData *data = opaque;
> +    int ret;
> +
> +    ret = data->hdlr(data->idstr, data->instance_id, &send_threads_abort,
> +                     data->handler_opaque);
> +    if (ret && !qatomic_read(&send_threads_ret)) {
> +        /*
> +         * Racy with the above read but that's okay - which thread error
> +         * return we report is purely arbitrary anyway.
> +         */
> +        qatomic_set(&send_threads_ret, ret);
> +    }
> +
> +    return 0;
> +}
> +
> +void
> +multifd_spawn_device_state_save_thread(SaveLiveCompletePrecopyThreadHandler hdlr,
> +                                       char *idstr, uint32_t instance_id,
> +                                       void *opaque)
> +{
> +    struct MultiFDDSSaveThreadData *data;
> +
> +    assert(migration_has_device_state_support());
> +
> +    data = g_new(struct MultiFDDSSaveThreadData, 1);
> +    data->hdlr = hdlr;
> +    data->idstr = g_strdup(idstr);
> +    data->instance_id = instance_id;
> +    data->handler_opaque = opaque;
> +
> +    thread_pool_submit(send_threads,
> +                       multifd_device_state_save_thread,
> +                       data, multifd_device_state_save_thread_data_free);
> +
> +    /*
> +     * Make sure that this new thread is actually spawned immediately so it
> +     * can start its work right now.
> +     */
> +    thread_pool_adjust_max_threads_to_work(send_threads);
> +}
> +
> +void multifd_abort_device_state_save_threads(void)
> +{
> +    assert(migration_has_device_state_support());
> +
> +    qatomic_set(&send_threads_abort, true);
> +}
> +
> +int multifd_join_device_state_save_threads(void)
> +{
> +    assert(migration_has_device_state_support());
> +
> +    thread_pool_wait(send_threads);
> +
> +    return send_threads_ret;
> +}

There is a lot in common with the load_thread part in patch 8. I think
more code could be shared.

C.


> diff --git a/migration/savevm.c b/migration/savevm.c
> index 98049cb9b09a..177849e7d493 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -1499,6 +1499,23 @@ int qemu_savevm_state_complete_precopy_iterable(QEMUFile *f, bool in_postcopy)
>       int ret;
>       bool multifd_device_state = migration_has_device_state_support();
>   
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
> +
>       QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
>           if (!se->ops ||
>               (in_postcopy && se->ops->has_postcopy &&
> @@ -1523,7 +1540,7 @@ int qemu_savevm_state_complete_precopy_iterable(QEMUFile *f, bool in_postcopy)
>           save_section_footer(f, se);
>           if (ret < 0) {
>               qemu_file_set_error(f, ret);
> -            return -1;
> +            goto ret_fail_abort_threads;
>           }
>           end_ts_each = qemu_clock_get_us(QEMU_CLOCK_REALTIME);
>           trace_vmstate_downtime_save("iterable", se->idstr, se->instance_id,
> @@ -1531,6 +1548,12 @@ int qemu_savevm_state_complete_precopy_iterable(QEMUFile *f, bool in_postcopy)
>       }
>   
>       if (multifd_device_state) {
> +        ret = multifd_join_device_state_save_threads();
> +        if (ret) {
> +            qemu_file_set_error(f, ret);
> +            return -1;
> +        }
> +
>           /* Send the final SYNC */
>           ret = multifd_send_sync_main();
>           if (ret) {
> @@ -1542,6 +1565,14 @@ int qemu_savevm_state_complete_precopy_iterable(QEMUFile *f, bool in_postcopy)
>       trace_vmstate_downtime_checkpoint("src-iterable-saved");
>   
>       return 0;
> +
> +ret_fail_abort_threads:
> +    if (multifd_device_state) {
> +        multifd_abort_device_state_save_threads();
> +        multifd_join_device_state_save_threads();
> +    }
> +
> +    return -1;
>   }
>   
>   int qemu_savevm_state_complete_precopy_non_iterable(QEMUFile *f,
> 


