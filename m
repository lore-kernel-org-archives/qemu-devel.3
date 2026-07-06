Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 858E9C43602
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 11:39:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wghej-0000jL-Qv; Mon, 06 Jul 2026 07:38:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wgheh-0000in-Ed
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 07:38:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wghef-0001dD-GY
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 07:38:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783337908;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=C2prD0ld7gDaXuX+U75vgHb3OstsCHGqaP5WMZS+0S8=;
 b=Q+jnKEPufkY/6bOr+HISRecDytqLl0F1NRcQroJSQMOnN15NrT6QtgCcE95VS5q+eZBR+r
 ShHXPQh8AwOyaPHQPvEmZWAScvLUUiEl+d3XZMowY1F2f/ur2jRVFe0lPuswptAR/TQV1j
 MZnTMSv+CBmeRLou6+3w0HCZwB7ofek=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-401-GyulweX4Nkqh-UnlYcNo1g-1; Mon, 06 Jul 2026 07:38:27 -0400
X-MC-Unique: GyulweX4Nkqh-UnlYcNo1g-1
X-Mimecast-MFC-AGG-ID: GyulweX4Nkqh-UnlYcNo1g_1783337906
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-493bdf90adaso21337755e9.2
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 04:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1783337906; x=1783942706; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=C2prD0ld7gDaXuX+U75vgHb3OstsCHGqaP5WMZS+0S8=;
 b=dQ34K9PX8AriJHKYeRM4fK62wkpZsFBmgz+T2LrHq9N3zP9MsxwCG21SxDjmR3avE9
 9FrAuEaDs+pqFPElaOzaSfQCNhhv6aSAhBqce1MMrMn7kDNf9DgVHIxhu/TYl8mo6sMJ
 42vhCii+eRXVCva7ZB2ecgeZJuG/OGkXedzW2mC7j5UxqZvFIOXoM7NShRQsiVs2N3GK
 U5WduBhfSEx18cjTsuDnsTJCkcsTPPnh0oMw/U5VkTpMWX1sxciAZlyij7boP4q5BpwE
 iupyHQKPVKdzW6d/5OZVWJeT+XCqq4kJv4HUJRkbRL0nTmVGTiHmkjALm6vBAjvUWSmj
 jcsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783337906; x=1783942706;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=C2prD0ld7gDaXuX+U75vgHb3OstsCHGqaP5WMZS+0S8=;
 b=GQM4tjBvC03IkjfhCY8dQcmTRmAAhb37itFh8bAGAeetiKYppo3L4cJJRf0sMeahn9
 R3dgbpRxWEG2G9G5HyYsXJUo+J3rDYp4vuwe25x1MpqNH1TOes4dVbSZtnAyxvQvTI3a
 8QjqwN+bffQAWMReUJkhE4x5LuSOlacQ6NwV6rmvhvkNaaPMbt248z6LU6AvsIAIo9xM
 6WxdZUt/VUCeGKSAaCrzY7KzJj6ztCcGmP6EClxYm6O2Pi70TAj7Y7YfOTxEzI01jdwz
 GOemBwvKq6mKY8Fp4sXucIDp9LYWAKwgYRyFkDtdXnl/ujpWIfVUVTY0hpMpk+3DyrNs
 kABg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpwvfN3CflS5Rjjh2xRzrB+7F1NMbM4+Zp99mlRuH/07zpFCfbO9AdNyT7jF+E0bmCyk3DvV6yZGULw@nongnu.org
X-Gm-Message-State: AOJu0YxzCc6EjtTGyR7BI95VLaH9+cOKpz3TWbesWenJ7wZ/LPsZjtkx
 n0VWFUr30EijKPa814OH4/84iglGSrMMTKLm5HrZBeXxESttjaOa/Ylw50AJc9R5hbulVzQgGCL
 RWe4SPbjdY37JZ57uT8mjdPQdbXiXordgFbtX9m6T4ls75l+zCwYSnOia
X-Gm-Gg: AfdE7ck6y0OJD2oSkf6sVyAjY2YfGgjOl47fn/mgavQS42iaf59Bgqza44RRjacUsC7
 SJVzmLVKQyGMnGsN2rNq0TmT4YlowOAlXDtHd8lQys1ZA/OZWTR8CnI56OiOHimlEEDUnr2f4Km
 JfqjHvKHpUEWo2Q7engeCjfBwUBbTD0WnsjtKQknvtg/vSjZ743R7S/MBXYrcYQtWhSbnk9n5wF
 xaFQgEKKsCZ8veRy3jqdk/CTFpC/LLiJms9yTVz96psbBRfTIiTzpOoBBwj0DISWv20034RtYwD
 GTJLWKUs8UhxFj4jCrLmM5I1PiN5zxrgLkt5vU72gMCBIibDnMUMEP4/ZxWGE5v4rIuB23ogV+b
 ygn5xMtv5iMB1K9gvEaPqX3GnnMmC1oxcMmWNZ5b1V5kka7YtUg==
X-Received: by 2002:a05:600c:37cd:b0:493:9661:f55d with SMTP id
 5b1f17b1804b1-493df09a412mr38115e9.30.1783337906130; 
 Mon, 06 Jul 2026 04:38:26 -0700 (PDT)
X-Received: by 2002:a05:600c:37cd:b0:493:9661:f55d with SMTP id
 5b1f17b1804b1-493df09a412mr37645e9.30.1783337905667; 
 Mon, 06 Jul 2026 04:38:25 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493ccdb62d3sm298886345e9.8.2026.07.06.04.38.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jul 2026 04:38:25 -0700 (PDT)
Message-ID: <442b0edc-232c-4eca-bd50-f5cc6078aa18@redhat.com>
Date: Mon, 6 Jul 2026 13:38:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 15/16] migration: Refactor
 migration_completion_precopy() to return bool
To: Avihai Horon <avihaih@nvidia.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Zhao Liu <zhao1.liu@intel.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Lukas Straub <lukasstraub2@web.de>, Maor Gottlieb <maorg@nvidia.com>
References: <20260706085211.13905-1-avihaih@nvidia.com>
 <20260706085211.13905-16-avihaih@nvidia.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260706085211.13905-16-avihaih@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 7/6/26 10:52, Avihai Horon wrote:
> migration_completion_precopy() reports its error through the Error
> **errp argument, so its int return value carries no information beyond
> success/failure. Convert it to return a bool, matching the common
> convention.
> 
> Convert its underlying helper qemu_savevm_state_complete_precopy()
> likewise, and in turn qemu_savevm_state_non_iterable(), which it calls.
> Adjust all callers accordingly.
> 
> Refactor and clean migration_completion() code too, which no longer
> needs to track int return values.
> 
> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
> ---
>   migration/savevm.h    |  4 ++--
>   migration/migration.c | 35 ++++++++++++++---------------------
>   migration/savevm.c    | 32 +++++++++++++++-----------------
>   3 files changed, 31 insertions(+), 40 deletions(-)
> 
> diff --git a/migration/savevm.h b/migration/savevm.h
> index 415198423f..f7dcdd7d1b 100644
> --- a/migration/savevm.h
> +++ b/migration/savevm.h
> @@ -44,7 +44,7 @@ void qemu_savevm_state_header(QEMUFile *f);
>   int qemu_savevm_state_iterate(QEMUFile *f, bool postcopy);
>   void qemu_savevm_state_cleanup(void);
>   void qemu_savevm_state_complete_postcopy(QEMUFile *f);
> -int qemu_savevm_state_complete_precopy(MigrationState *s, Error **errp);
> +bool qemu_savevm_state_complete_precopy(MigrationState *s, Error **errp);
>   void qemu_savevm_query_pending_iter(MigrationState *s, MigPendingData *pending,
>                                       bool exact);
>   bool qemu_savevm_query_pending_final(MigrationState *s,
> @@ -74,7 +74,7 @@ int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis,
>                              Error **errp);
>   int qemu_load_device_state(QEMUFile *f, Error **errp);
>   int qemu_loadvm_approve_switchover(const char *approver);
> -int qemu_savevm_state_non_iterable(QEMUFile *f, Error **errp);
> +bool qemu_savevm_state_non_iterable(QEMUFile *f, Error **errp);
>   int qemu_savevm_state_non_iterable_early(QEMUFile *f,
>                                            JSONWriter *vmdesc,
>                                            Error **errp);
> diff --git a/migration/migration.c b/migration/migration.c
> index 98603ee19c..7d5acd93c3 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -2659,8 +2659,7 @@ static int postcopy_start(MigrationState *ms, Error **errp)
>        */
>       qemu_savevm_send_postcopy_listen(fb);
>   
> -    ret = qemu_savevm_state_non_iterable(fb, errp);
> -    if (ret) {
> +    if (!qemu_savevm_state_non_iterable(fb, errp)) {
>           error_prepend(errp, "Postcopy save non-iterable states failed: ");
>           goto fail_closefb;
>       }
> @@ -2858,22 +2857,22 @@ static bool migration_switchover_start(MigrationState *s, Error **errp)
>       return true;
>   }
>   
> -static int migration_completion_precopy(MigrationState *s, Error **errp)
> +static bool migration_completion_precopy(MigrationState *s, Error **errp)
>   {
> -    int ret;
> +    bool ret = false;
>   
>       bql_lock();
>   
>       if (!migrate_mode_is_cpr()) {
> -        ret = migration_stop_vm(s, RUN_STATE_FINISH_MIGRATE);
> -        if (ret < 0) {
> -            error_setg_errno(errp, -ret, "Failed to stop the VM");
> +        int r = migration_stop_vm(s, RUN_STATE_FINISH_MIGRATE);
> +
> +        if (r < 0) {
> +            error_setg_errno(errp, -r, "Failed to stop the VM");
>               goto out_unlock;
>           }
>       }
>   
>       if (!migration_switchover_start(s, errp)) {
> -        ret = -EFAULT;
>           goto out_unlock;
>       }
>   
> @@ -2910,18 +2909,17 @@ static void migration_completion_postcopy(MigrationState *s)
>    */
>   static void migration_completion(MigrationState *s)
>   {
> -    int ret = 0;
>       Error *local_err = NULL;
>   
>       if (s->state == MIGRATION_STATUS_ACTIVE) {
> -        ret = migration_completion_precopy(s, &local_err);
> +        if (!migration_completion_precopy(s, &local_err)) {
> +            goto fail;
> +        }
>       } else if (s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE) {
>           migration_completion_postcopy(s);
>       } else {
> -        ret = -1;
> -    }
> -
> -    if (ret < 0) {
> +        error_setg(&local_err, "Unexpected migration completion status %s",
> +                   MigrationStatus_str(s->state));
>           goto fail;
>       }
>   
> @@ -2945,12 +2943,7 @@ static void migration_completion(MigrationState *s)
>       return;
>   
>   fail:
> -    if (local_err) {
> -        migrate_error_propagate(s, local_err);
> -    } else if (qemu_file_get_error_obj(s->to_dst_file, &local_err)) {
> -        migrate_error_propagate(s, local_err);
> -    } else if (ret) {
> -        error_setg_errno(&local_err, -ret, "Error in migration completion");
> +    if (local_err || qemu_file_get_error_obj(s->to_dst_file, &local_err)) {
>           migrate_error_propagate(s, local_err);
>       }
>   
> @@ -3863,7 +3856,7 @@ static void *bg_migration_thread(void *opaque)
>           goto fail_with_bql;
>       }
>   
> -    if (qemu_savevm_state_non_iterable(fb, &local_err)) {
> +    if (!qemu_savevm_state_non_iterable(fb, &local_err)) {
>           error_prepend(&local_err, "Failed to save non-iterable devices ");
>           goto fail_with_bql;
>       }
> diff --git a/migration/savevm.c b/migration/savevm.c
> index f654a1c563..bbb8d2b47c 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -1737,13 +1737,12 @@ void qemu_savevm_state_end_precopy(MigrationState *s, QEMUFile *f)
>       qemu_savevm_state_vm_desc(s, f);
>   }
>   
> -int qemu_savevm_state_non_iterable(QEMUFile *f, Error **errp)
> +bool qemu_savevm_state_non_iterable(QEMUFile *f, Error **errp)
>   {
>       MigrationState *ms = migrate_get_current();
>       int64_t start_ts_each, end_ts_each;
>       JSONWriter *vmdesc = ms->vmdesc;
>       SaveStateEntry *se;
> -    int ret;
>   
>       /* Making sure cpu states are synchronized before saving non-iterable */
>       cpu_synchronize_all_states();
> @@ -1756,9 +1755,8 @@ int qemu_savevm_state_non_iterable(QEMUFile *f, Error **errp)
>   
>           start_ts_each = qemu_clock_get_us(QEMU_CLOCK_REALTIME);
>   
> -        ret = vmstate_save(f, se, vmdesc, errp);
> -        if (ret) {
> -            return ret;
> +        if (vmstate_save(f, se, vmdesc, errp) < 0) {
> +            return false;
>           }
>   
>           end_ts_each = qemu_clock_get_us(QEMU_CLOCK_REALTIME);
> @@ -1768,10 +1766,10 @@ int qemu_savevm_state_non_iterable(QEMUFile *f, Error **errp)
>   
>       trace_vmstate_downtime_checkpoint("src-non-iterable-saved");
>   
> -    return 0;
> +    return true;
>   }
>   
> -int qemu_savevm_state_complete_precopy(MigrationState *s, Error **errp)
> +bool qemu_savevm_state_complete_precopy(MigrationState *s, Error **errp)
>   {
>       ERRP_GUARD();
>       QEMUFile *f = s->to_dst_file;
> @@ -1781,12 +1779,11 @@ int qemu_savevm_state_complete_precopy(MigrationState *s, Error **errp)
>       if (ret) {
>           qemu_file_get_error_obj(f, errp);
>           error_prepend(errp, "Failed to save iterable device state: ");
> -        return ret;
> +        return false;
>       }
>   
> -    ret = qemu_savevm_state_non_iterable(f, errp);
> -    if (ret) {
> -        return ret;
> +    if (!qemu_savevm_state_non_iterable(f, errp)) {
> +        return false;
>       }
>   
>       qemu_savevm_state_end_precopy(s, f);
> @@ -1795,10 +1792,10 @@ int qemu_savevm_state_complete_precopy(MigrationState *s, Error **errp)
>       if (ret) {
>           qemu_file_get_error_obj(f, errp);
>           error_prepend(errp, "Failed to flush QEMUFile: ");
> -        return ret;
> +        return false;
>       }
>   
> -    return 0;
> +    return true;
>   }
>   
>   static void qemu_savevm_query_pending(MigrationState *s,
> @@ -1928,7 +1925,9 @@ static int qemu_savevm_state(QEMUFile *f, Error **errp)
>           goto cleanup;
>       }
>   
> -    ret = qemu_savevm_state_complete_precopy(ms, errp);
> +    if (!qemu_savevm_state_complete_precopy(ms, errp)) {
> +        ret = -1;
> +    }
>   cleanup:
>       qemu_savevm_state_cleanup();
>   
> @@ -1962,9 +1961,8 @@ int qemu_save_device_state(QEMUFile *f, Error **errp)
>           return ret;
>       }
>   
> -    ret = qemu_savevm_state_non_iterable(f, errp);
> -    if (ret) {
> -        return ret;
> +    if (!qemu_savevm_state_non_iterable(f, errp)) {
> +        return -1;
>       }
>   
>       qemu_savevm_state_end(f);

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


