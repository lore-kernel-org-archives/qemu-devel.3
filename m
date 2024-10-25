Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F5ADD0C5E6
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 08:37:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4FoM-00015N-LM; Fri, 25 Oct 2024 04:36:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1t4FoK-000153-Kw
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 04:36:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1t4FoI-00040I-KP
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 04:36:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729845399;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=L+UciSBKv2k9ceyKz0VqV9oi83DuucC/pL+CSiDT+K4=;
 b=O4aRPWwwlLpdexYszHvK4G6iq7kxDKZiSTFltHj0U09pg09JMVt1qe+S9lzs7e6/fUOv6P
 JJ/keGR6x3Wlwq6TolGEaLQXnIzsV1HLsnZXcyoK6FkFKfmcoTXD79as7nRHMsWYI1zcM6
 rT3RxYdda/zKuJNUIQidaWSm2bGDlw4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-g8WsssVKOXSCWydaHoH0aA-1; Fri, 25 Oct 2024 04:36:38 -0400
X-MC-Unique: g8WsssVKOXSCWydaHoH0aA-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-37d43e7acd9so893126f8f.2
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2024 01:36:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729845397; x=1730450197;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L+UciSBKv2k9ceyKz0VqV9oi83DuucC/pL+CSiDT+K4=;
 b=TaTqZRMTN9b/U/R5fbwsLBVO4bY9/BCU+k70AY6xIOvXTfvdKWF7ZlGdX/VFtgDXmD
 Djh5s/g/8DolyH+DjejfKPybZYeWjb4ACHwWg1FIRyXe1RpeWBehgXAEHsrtLvGPHC0z
 sEoBxC4klgCdF8aXMAdrSkn0ANqaT/fqRWYGM1AnUfsy2u9mrIqYCNpj3ZP5kAh0f0e4
 0DWtozNZsq40paMeTNd1HJzKITDKA5+5y8AugZ/l+GueaUlDnTQHwsEMRb+SwOlvtVYO
 kANjXEdPnDeVgutKxiXp7/wieBgLMFdlP/DBhKIhhpg4Ubl2Cu350c7sf8n7TpRvprLz
 tXFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXE8q0RT31UgppwUaH2MkTKlLoe5YddaTHq2YmjGql48HJJgKDdSUplmsjkY3DMlR+Oq+XHX/wl2rug@nongnu.org
X-Gm-Message-State: AOJu0Ywbuy6Yw8Y7kQeJNuxweML1IJAcMkm+3rqaueJH0pn0TSuKD68E
 ZNrnD0dN7uMdGdWsCzpNFFVLOrcW4A4EvFfASdy6i5bNxRiJU0FKPDjvlic7t2WAqV6mfiB8xBw
 T5Jvd+EolwIVOmjuObBFAndFQRZ2oYFp6vuLQkpdbWBHvLszs8PLb
X-Received: by 2002:adf:fbd1:0:b0:37d:47d8:5fff with SMTP id
 ffacd0b85a97d-380458d5af0mr3260711f8f.37.1729845396884; 
 Fri, 25 Oct 2024 01:36:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGiMnAwExa1F057q8AY79aCTB5ZJEGBDCckByLpjgWPaYlZkdxG44LC3h3xOYTlav3h3N0tZw==
X-Received: by 2002:adf:fbd1:0:b0:37d:47d8:5fff with SMTP id
 ffacd0b85a97d-380458d5af0mr3260697f8f.37.1729845396482; 
 Fri, 25 Oct 2024 01:36:36 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:165:d60:bbdd:3c5e:7d8b:3f72?
 ([2a01:e0a:165:d60:bbdd:3c5e:7d8b:3f72])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38058b71231sm933080f8f.66.2024.10.25.01.36.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Oct 2024 01:36:36 -0700 (PDT)
Message-ID: <ddbe8983-94bb-4d69-8e6e-74d6c03d002b@redhat.com>
Date: Fri, 25 Oct 2024 10:36:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/8] migration: Take migration object refcount earlier
 for threads
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Avihai Horon <avihaih@nvidia.com>, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>
References: <20241024213056.1395400-1-peterx@redhat.com>
 <20241024213056.1395400-2-peterx@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20241024213056.1395400-2-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.263,
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
> Both migration thread or background snapshot thread will take a refcount of
> the migration object at the entrace of the thread function.
> 
> That makes sense, because it protects the object from being freed by the
> main thread in migration_shutdown() later, but it might still race with it
> if the thread is scheduled too late.  Consider the case right after
> pthread_create() happened, VM shuts down with the object released, but
> right after that the migration thread finally got created, referencing
> MigrationState* in the opaque pointer which is already freed.
> 
> The only 100% safe way to make sure it won't get freed is taking the
> refcount right before the thread is created, meanwhile when BQL is held.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   migration/migration.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index 74812ca785..e82ffa8cf3 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -3491,7 +3491,6 @@ static void *migration_thread(void *opaque)
>   
>       rcu_register_thread();
>   
> -    object_ref(OBJECT(s));
>       update_iteration_initial_status(s);
>   
>       if (!multifd_send_setup()) {
> @@ -3629,7 +3628,6 @@ static void *bg_migration_thread(void *opaque)
>       int ret;
>   
>       rcu_register_thread();
> -    object_ref(OBJECT(s));
>   
>       migration_rate_set(RATE_LIMIT_DISABLED);
>   
> @@ -3841,6 +3839,14 @@ void migrate_fd_connect(MigrationState *s, Error *error_in)
>           }
>       }
>   
> +    /*
> +     * Take a refcount to make sure the migration object won't get freed by
> +     * the main thread already in migration_shutdown().
> +     *
> +     * The refcount will be released at the end of the thread function.
> +     */
> +    object_ref(OBJECT(s));
> +
>       if (migrate_background_snapshot()) {
>           qemu_thread_create(&s->thread, MIGRATION_THREAD_SNAPSHOT,
>                   bg_migration_thread, s, QEMU_THREAD_JOINABLE);

yes. It is safer to take a ref before starting the migration thread.

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


