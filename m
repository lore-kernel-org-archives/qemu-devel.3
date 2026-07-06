Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77EA9C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 11:39:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wghed-0000iQ-23; Mon, 06 Jul 2026 07:38:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wgheZ-0000i7-4D
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 07:38:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wgheW-0001bK-Bf
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 07:38:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783337898;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=QcwVYXbNa3n7yPn3Rcnr6ySq9+9MHcBH1u3iEQkkWQ8=;
 b=Lt3ifVlrNluu6DsAAFx9NuBYbLt1lnWOAbKosPEdzqQ/uVerbdi1JPP3cj3g5tY8RSilxT
 imaMhDo9yrQC69Fi/JHOUr3Ul5FJdEh2Un9NJRjT7lSw8qRllBwJBq6Pu6ASrSVFGNi88S
 GH1AgrhskQQrih2WIP23/I2JR66IMHA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-301-y0EeD0afP7SZuZxHVf8TIA-1; Mon, 06 Jul 2026 07:38:17 -0400
X-MC-Unique: y0EeD0afP7SZuZxHVf8TIA-1
X-Mimecast-MFC-AGG-ID: y0EeD0afP7SZuZxHVf8TIA_1783337896
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4926fa2cb17so28007465e9.1
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 04:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1783337896; x=1783942696; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=QcwVYXbNa3n7yPn3Rcnr6ySq9+9MHcBH1u3iEQkkWQ8=;
 b=aEDqQXnKRXKZyRFMOuW5JqUSGroFy5UMmiUQGAyjNhLzImK5IyCwL31MpA6vHqjyA8
 nk5h6pfsajIJ8QJPiV3jdm2mV0hxribbZ+NSZ9Zv1Xo4T/HVwEkz96aZrO7I2QFZPXXs
 rTKxLBKIgaQ+GeuutuqK6bEJ97oc8egeWtLUKMRdMd1Xe8TbEEeoUV7gEjUtTJvkNJ7F
 84/2qAMyBr8tIjJ9mNkCKcrlK1Q0jAJIRzqSYXqbnHDq2B6otKG5ooJYupkTsVg0rClZ
 W1owseY8Q+vZxsm/gCx9AsUlXHE2fFb6RjVApbZLnuHgvJ5+0SlGwUDuPpjIBQFhnfbA
 jTcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783337896; x=1783942696;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QcwVYXbNa3n7yPn3Rcnr6ySq9+9MHcBH1u3iEQkkWQ8=;
 b=rjsu0Y9LqKDBDH9uGfgbtWsJzI3lY1SSKHpxj/pus3T6ys04iPdicr1FkhVnjOECPB
 Xkmmzk5EFvw3qfJF8UsAcCLybPgQYzvORDYE25qHM9WLXo+JL2fPG+8XwMVF8nkd6+3O
 /RqAQhJUakaobTUKXPHZ0gDKMCpfWDFkquKAsxP/nZNo7hHR5cx2C3IsUGCStPzzk25M
 OuHEUBcvJ5LhsRVREv/ska3J/kKgJl5bEQC+Q8er0PqS2fhzx5l0FglvZ0yTjmBMbe7J
 uQzH0MvIH59RCz/3l0vE5CTW0+aQTgXIXxF8MyAg5kqfohj4t2pAI3aNml3gKCb8tXMb
 YXWQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpLOyz4LBPGH4nlUaHzeOfCNZ6A8WkUbglPrT9ED8UbbRS0ZgmvBMmVhhFSJR8OGWCPnN6wHs1Ssj42@nongnu.org
X-Gm-Message-State: AOJu0YwERIWalRKGuQy9LFsoXzOEyJFVNlJ/JoGMbtjlFwOwQaFY9klS
 riq1Z2wXlS++7UWGJ7+Als4p+kcCOL4sFdVpKajkU3INsCjG3nVsvnxsXWBZ/BCbZYPYK96U/wM
 MHUkmoE06b2Jv7qE0GLKHeVF9j1TxRgGymwByqH3C2wJJWd4ItyCDOGXu
X-Gm-Gg: AfdE7cloQHh5IF0q0SSnBb9LGOc0Uo6ltw60cqEuOyvHlEnCB+drB61R71ZVryE5fTB
 LN3FGpbtBZl96Eqr0GfYZsyo2GACNnLSxDyVwk5fbrWr+U0zx8uO6HI3qS1qIwnxzcqzlvDQBAd
 x9Q05+qk0/FDP8Y/496m7PzEZ/FKdC4Fgf4dqVUYuq20XtbjKRZ9vwcVEP+9vbI/rsrG5ZlwTn8
 3zGPzi8WqDhZjkpqh4F7C2goS3FFl8gwxeiIHiDzDEtj7AkX++d2RSb+dYA/bzdbonS42PYt3wh
 PzNECQRux1+hL0qHVDQ9mXcqgCK1i6vXWNse9gJWNPpWk15jeXyPmnOKdekHkVohavS5YsnicXz
 /XSvMTPDVMAkfo+x4qtudaHxESdENMzIHaM+KoyaEWQkeELOGbg==
X-Received: by 2002:a05:600c:8010:b0:48a:5f32:62c6 with SMTP id
 5b1f17b1804b1-493c9b6be47mr171825855e9.11.1783337895020; 
 Mon, 06 Jul 2026 04:38:15 -0700 (PDT)
X-Received: by 2002:a05:600c:8010:b0:48a:5f32:62c6 with SMTP id
 5b1f17b1804b1-493c9b6be47mr171825535e9.11.1783337894529; 
 Mon, 06 Jul 2026 04:38:14 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9e4d8410sm24332276f8f.15.2026.07.06.04.38.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jul 2026 04:38:14 -0700 (PDT)
Message-ID: <a04934dc-0209-44a6-993f-644dfab84a65@redhat.com>
Date: Mon, 6 Jul 2026 13:38:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 16/16] migration: Fix "switchover" used as a verb in
 comments and docs
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
 <20260706085211.13905-17-avihaih@nvidia.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260706085211.13905-17-avihaih@nvidia.com>
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
> "Switchover" is a noun; the verb form is "switch over".  Replace all
> instances where "switchover" was incorrectly used as a verb in comments
> and documentation.
> 
> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
> ---
>   qapi/migration.json   | 4 ++--
>   migration/migration.h | 6 +++---
>   migration/migration.c | 4 ++--
>   migration/savevm.c    | 2 +-
>   4 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/qapi/migration.json b/qapi/migration.json
> index d2f42c4b0f..66bd900465 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -509,7 +509,7 @@
>   #
>   # @switchover-ack: If enabled, migration will not stop the source VM
>   #     and complete the migration until the destination has
> -#     acknowledged that it is OK to switchover.  The acknowledgement
> +#     acknowledged that it is OK to switch over.  The acknowledgement
>   #     may depend, for example, on some device's data being loaded in
>   #     the destination before doing switchover.  This can reduce
>   #     downtime if devices that support this capability are present.
> @@ -919,7 +919,7 @@
>   #     migration can use during switchover phase, in bytes per
>   #     second.  **Note:** this does not limit the bandwidth during
>   #     switchover, but only for calculations when making decisions to
> -#     switchover.  By default, this value is zero, which means QEMU
> +#     switch over.  By default, this value is zero, which means QEMU
>   #     will estimate the bandwidth automatically.  This can be set
>   #     when the estimated value is not accurate, while the user is
>   #     able to guarantee such bandwidth is available when switching
> diff --git a/migration/migration.h b/migration/migration.h
> index 44bce199cd..631421c784 100644
> --- a/migration/migration.h
> +++ b/migration/migration.h
> @@ -496,12 +496,12 @@ struct MigrationState {
>        * migration progresses, the devices on the destination acknowledge
>        * switchover, decreasing the counter. When the counter reaches zero, a
>        * single ACK message is sent to the source via the return path, indicating
> -     * that it's OK to switchover.
> +     * that it's OK to switch over.
>        *
>        * In new switchover-ack, the source is the one that keeps track of a
>        * pending ACKs counter. As migration progresses, the destination sends ACK
>        * message per-device via the return path, which decrements the source
> -     * counter. When the counter reaches zero, it's OK to switchover. During
> +     * counter. When the counter reaches zero, it's OK to switch over. During
>        * precopy, source-side devices may request additional ACKs, which increment
>        * the counter again.
>        *
> @@ -521,7 +521,7 @@ struct MigrationState {
>       /*
>        * Indicates the number of pending ACKs from the destination. The value may
>        * increase or decrease during precopy as new ACKs are requested or
> -     * received. When zero is reached, it's OK to switchover. In legacy
> +     * received. When zero is reached, it's OK to switch over. In legacy
>        * switchover-ack, it's initialized to 1 and decreased to zero upon ACK.
>        */
>       uint32_t switchover_ack_pending_num;
> diff --git a/migration/migration.c b/migration/migration.c
> index 7d5acd93c3..9736c14458 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -3293,7 +3293,7 @@ static bool migration_iteration_next_ready(MigrationState *s,
>                                              MigPendingData *pending)
>   {
>       /*
> -     * If the estimated values already suggest us to switchover, mark this
> +     * If the estimated values already suggest us to switch over, mark this
>        * iteration finished, time to do a slow sync.
>        */
>       if (pending->total_bytes <= s->threshold_size) {
> @@ -3418,7 +3418,7 @@ static MigIterateState migration_iteration_run(MigrationState *s)
>               migration_iteration_go_next(s, &pending);
>           }
>   
> -        /* Check can switchover after qemu_savevm_query_pending() */
> +        /* Check if we can switch over after qemu_savevm_query_pending() */
>           can_switchover = migration_can_switchover(s);
>   
>           /* Should we switch to postcopy now? */
> diff --git a/migration/savevm.c b/migration/savevm.c
> index bbb8d2b47c..34dd06f9f7 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -2509,7 +2509,7 @@ static int loadvm_postcopy_handle_switchover_start(Error **errp)
>   
>   /*
>    * If legacy switchover-ack is enabled but no device uses it, need to send an
> - * ACK to source that it's OK to switchover.
> + * ACK to source that it's OK to switch over.
>    */
>   static int loadvm_switchover_ack_no_users_legacy(MigrationIncomingState *mis,
>                                                    Error **errp)

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


