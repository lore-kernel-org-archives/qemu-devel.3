Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12BB8D0C606
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 12:51:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4JmA-0004RC-1n; Fri, 25 Oct 2024 08:50:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1t4Jm8-0004R2-G9
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 08:50:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1t4Jm5-00049U-W4
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 08:50:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729860640;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ksWT5CfLrDsMxLVZ9ngJNNz9XBAPnEi6bvw17Zfepwg=;
 b=S3OgXfqU3gx3wl8E+dkvtBKuGADZR5QKDY1lboDigCMvKod0Ks4VoXMMY45Cw+emMDEcgJ
 S1C17iimswkTHLOd38wQFO1xXfKFUPAYLgmoqgU37moKDzANzUmDufcFLf3mFWmZN4DpBN
 x8HVMCbMwDPy54tr4gpWrLInTzDMlqc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-352-lkt09k_TMkuZleYrZkK0MA-1; Fri, 25 Oct 2024 08:50:39 -0400
X-MC-Unique: lkt09k_TMkuZleYrZkK0MA-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-37d45f1e935so1061318f8f.0
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2024 05:50:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729860638; x=1730465438;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ksWT5CfLrDsMxLVZ9ngJNNz9XBAPnEi6bvw17Zfepwg=;
 b=oE02e8j7TiOXuJv4GxWGfEXAY0AS0sgdtbjFCtZ5AJnCQudWOVbJdyvfq/LxMJ9onn
 mqE79Q5X/4wtEe60+WihteMsYuIGdgbKSaRj3cK8REuLjqwp4+htbum0ROYadz1qsHtM
 1/tscYbXWwSwmus+b5GDAPdx0ecMm45n3SygYMJ4rhBKcb/k6ImFS8fsR1sqwEW6yAmV
 jA677debnIby06jR6EFK01ouo7Cx5rLp1mTb3DgKKsxMPCVeNVRuJgrX+uVTvuLSqDsM
 7GWjTaMehZN8UW6SIhwyC3xR2wDsth1mcQ4ELO53uGDWRe8fnH4MiW1HCd3jGP7TApib
 4PSw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW2+eqHcVViA3siNBrmOpTJ/OOTEVsnOb2NOiSZSUB0GFPibHwHDZw5dtiqVWp9PcPJR5Y3S/CyfAKy@nongnu.org
X-Gm-Message-State: AOJu0YzY549M4waIPwnpHZ7JvGzSmtsmGXJR+WcwSxcZ/wZO5Bv+bLgY
 QReOyW2vXcQRugmj1eaIDuTEwZmt+Ox/cGDlYI01yd+FKzcFcoUCE6I8LTlvrhp892Yq5ca1AH/
 H8TgbGiT63hthX7uvh6jih6xweyA+SlIgrPmoyxHDn5Oem/iFKVrd
X-Received: by 2002:a05:6000:1210:b0:374:b6f4:d8d1 with SMTP id
 ffacd0b85a97d-37efcf0b548mr6268296f8f.13.1729860637823; 
 Fri, 25 Oct 2024 05:50:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWo9x3bEtUKrq4a8a4Gf8ZICDuOdoe6atbwkhA1/7z8joypdDT/99E3eYv0Ec99qqtXDN8xg==
X-Received: by 2002:a05:6000:1210:b0:374:b6f4:d8d1 with SMTP id
 ffacd0b85a97d-37efcf0b548mr6268280f8f.13.1729860637441; 
 Fri, 25 Oct 2024 05:50:37 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:165:d60:bbdd:3c5e:7d8b:3f72?
 ([2a01:e0a:165:d60:bbdd:3c5e:7d8b:3f72])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38058b1c4d8sm1453895f8f.2.2024.10.25.05.50.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Oct 2024 05:50:36 -0700 (PDT)
Message-ID: <ac9645b9-e188-4f8c-87bb-abaa9da12c74@redhat.com>
Date: Fri, 25 Oct 2024 14:50:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 8/8] migration: Protect updates to current_migration
 with a mutex
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Avihai Horon <avihaih@nvidia.com>, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>
References: <20241024213056.1395400-1-peterx@redhat.com>
 <20241024213056.1395400-9-peterx@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20241024213056.1395400-9-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.454,
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

On 10/24/24 23:30, Peter Xu wrote:
> Introduce migration_mutex, protecting concurrent updates to
> current_migration.
> 
> In reality, most of the exported migration functions are safe to access
> migration objects on capabilities, etc., e.g. many of the code is invoked
> within migration thread via different hooks (e.g., precopy notifier,
> vmstate handler hooks, etc.).
> 
> So literally the mutex so far only makes sure below two APIs that are prone
> to accessing freed current_migration:
> 
>          migration_is_running()
>          migration_file_set_error()
> 
> Then we'll need to take the mutex too when init/free the migration object.

we should also drop :

   static void vfio_set_migration_error(int ret)
   {
       if (migration_is_running()) {
           migration_file_set_error(ret, NULL);
       }
   }

and use directly migration_file_set_error().

> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   migration/migration.h |  3 +++
>   migration/migration.c | 43 +++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 46 insertions(+)
> 
> diff --git a/migration/migration.h b/migration/migration.h
> index 9fa26ab06a..05edcf0c49 100644
> --- a/migration/migration.h
> +++ b/migration/migration.h
> @@ -473,6 +473,9 @@ struct MigrationState {
>       bool rdma_migration;
>   };
>   
> +extern QemuMutex migration_mutex;
> +#define  QEMU_MIGRATION_LOCK_GUARD()  QEMU_LOCK_GUARD(&migration_mutex)
> +

Why are these definitions exported ?

Thanks,

C.



>   void migrate_set_state(MigrationStatus *state, MigrationStatus old_state,
>                          MigrationStatus new_state);
>   
> diff --git a/migration/migration.c b/migration/migration.c
> index 127b01734d..ef044968df 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -97,6 +97,14 @@ enum mig_rp_message_type {
>      migrations at once.  For now we don't need to add
>      dynamic creation of migration */
>   
> +/*
> + * Protects current_migration below.  Must be hold when using migration
> + * exported functions unless the caller knows it won't get freed.  For
> + * example, when in the context of migration_thread() it's safe to access
> + * current_migration without the mutex, because the thread holds one extra
> + * refcount of the object, so it literally pins the object in-memory.
> + */
> +QemuMutex migration_mutex;
>   static MigrationState *current_migration;
>   static MigrationIncomingState *current_incoming;
>   
> @@ -110,6 +118,17 @@ static void migrate_fd_cancel(MigrationState *s);
>   static bool close_return_path_on_source(MigrationState *s);
>   static void migration_completion_end(MigrationState *s);
>   
> +/*
> + * This is explicitly done without migration_object_init(), because it may
> + * start to use this lock already when instance_init() of the object.  The
> + * mutex is alive for the whole lifecycle of QEMU, so it's always usable
> + * and never destroyed.
> + */
> +static void __attribute__((constructor)) migration_mutex_init(void)
> +{
> +    qemu_mutex_init(&migration_mutex);
> +}
> +
>   static void migration_downtime_start(MigrationState *s)
>   {
>       trace_vmstate_downtime_checkpoint("src-downtime-start");
> @@ -336,6 +355,14 @@ void migration_shutdown(void)
>        * stop the migration using this structure
>        */
>       migration_cancel(NULL);
> +    /*
> +     * Release the refcount from the main thread.  It means it can be freed
> +     * here if migration thread is not running.
> +     *
> +     * NOTE: we don't need QEMU_MIGRATION_LOCK_GUARD() on this access
> +     * because we're sure there's one refcount.  The lock will be taken in
> +     * finalize() if it triggers, so we can't take it here anyway.
> +     */
>       object_unref(OBJECT(current_migration));
>   
>       /*
> @@ -1118,8 +1145,14 @@ void migrate_send_rp_resume_ack(MigrationIncomingState *mis, uint32_t value)
>   
>   bool migration_is_running(void)
>   {
> +    QEMU_MIGRATION_LOCK_GUARD();
> +
>       MigrationState *s = current_migration;
>   
> +    if (!s) {
> +        return false;
> +    }
> +
>       switch (s->state) {
>       case MIGRATION_STATUS_ACTIVE:
>       case MIGRATION_STATUS_POSTCOPY_ACTIVE:
> @@ -3029,8 +3062,14 @@ static MigThrError postcopy_pause(MigrationState *s)
>   
>   void migration_file_set_error(int ret, Error *err)
>   {
> +    QEMU_MIGRATION_LOCK_GUARD();
> +
>       MigrationState *s = current_migration;
>   
> +    if (!s) {
> +        return;
> +    }
> +
>       WITH_QEMU_LOCK_GUARD(&s->qemu_file_lock) {
>           if (s->to_dst_file) {
>               qemu_file_set_error_obj(s->to_dst_file, ret, err);
> @@ -3835,6 +3874,8 @@ static void migration_instance_finalize(Object *obj)
>   {
>       MigrationState *ms = MIGRATION_OBJ(obj);
>   
> +    QEMU_MIGRATION_LOCK_GUARD();
> +
>       qemu_mutex_destroy(&ms->error_mutex);
>       qemu_mutex_destroy(&ms->qemu_file_lock);
>       qemu_sem_destroy(&ms->wait_unplug_sem);
> @@ -3858,6 +3899,8 @@ static void migration_instance_init(Object *obj)
>   {
>       MigrationState *ms = MIGRATION_OBJ(obj);
>   
> +    QEMU_MIGRATION_LOCK_GUARD();
> +
>       /*
>        * There can only be one migration object globally. Keep a record of
>        * the pointer in current_migration, which will be reset after the


