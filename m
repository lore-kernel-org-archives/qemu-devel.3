Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89F67D15DA9
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 15:14:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2u6w-0000Li-5q; Mon, 21 Oct 2024 11:14:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1t2u6u-0000K9-10
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 11:14:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1t2u6r-0004KB-P8
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 11:14:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729523655;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=SCSmxnX9WwEfsYfQls0UuEkj65l0gCfWwhBFvLNcK8Q=;
 b=eiVRt2mcDLoe3LsDUsT+vzokMTCXzxmIpmvGoJee4xXL+cxJHYRHSh+TjvMeApurG7RA2O
 SleQKb8Hu3FfJ2J8iJP5pisIrzUbUxleVKIA0ayi5RO8p9/887Eft56zdMmPvp/uWirJak
 pXDXGMfJFeARjmYA4MvR/9dy1/VsFx4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-39-On3ixCQVPHqbNN-RWLAPvQ-1; Mon, 21 Oct 2024 11:14:14 -0400
X-MC-Unique: On3ixCQVPHqbNN-RWLAPvQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4315f48bd70so27745765e9.2
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 08:14:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729523653; x=1730128453;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SCSmxnX9WwEfsYfQls0UuEkj65l0gCfWwhBFvLNcK8Q=;
 b=AiYeaLjFSDyuVT6uZ3NsLLbbqpWaw4LRE3IevcXiO+8QD1H3/vNODbT0pOLV98KbE7
 IH501NaI1YgHTA/TdvoL32yx3E2ycNmB7ht2xVhB1ke7vswRwyJvW2xj7bnN64X2iEkn
 0huqtA5cA+9JO5gblIRWLVvqAUGM65fU1Liop274J2M/ROxMuw5urrG1zq4QnHKlTneG
 ZaAyHAri/JS393I5wVI4xKwl+NQd8KEs3nqVKvS3zzBLX40aPKa9fJgunf9gEmdRH0Oj
 5e1SOG3A09SDlheC2EftpurU/3behnZTlXJisy/Qi54sk2qicupdyHtRxqIuQvBpxUu3
 NoWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVsRdU7xvICbCyGJbo/NEzIe0erH2nS9zKaSWfmQVRu1KkmiF8Sycm6Grxgqx9z9CX5yCER1uXO+XMa@nongnu.org
X-Gm-Message-State: AOJu0Yxmf9sLbvHxWVdVlY2EhbDsUmMm4fHQJNoBZl1KqPjojtuw1iWG
 jur4HWRHL9kbic4NaVccMr1ylurp5/C/j4fzQry3917IuVphDPQepRwP7v1yQfBP3YxbI5FZgNm
 W/K4iDhlxVM+3aW4nLifr88EoPR6nE8LjV2BKFL5VkCzP7qKR23mU
X-Received: by 2002:a05:600c:1988:b0:42c:bd27:4c12 with SMTP id
 5b1f17b1804b1-4316164642fmr90647965e9.10.1729523653187; 
 Mon, 21 Oct 2024 08:14:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHE9IsPD3UX7IurFG5100CmBKxhUtpGHRsBHNMuy+i1W4oCsjGUXzDnRnipYrEPKD/Rbcf3wA==
X-Received: by 2002:a05:600c:1988:b0:42c:bd27:4c12 with SMTP id
 5b1f17b1804b1-4316164642fmr90647735e9.10.1729523652802; 
 Mon, 21 Oct 2024 08:14:12 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:165:d60:bbdd:3c5e:7d8b:3f72?
 ([2a01:e0a:165:d60:bbdd:3c5e:7d8b:3f72])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4316f5cc4dfsm61035835e9.45.2024.10.21.08.14.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Oct 2024 08:14:12 -0700 (PDT)
Message-ID: <cfca06dd-cfd3-4a36-a80f-b8e2ddecbf88@redhat.com>
Date: Mon, 21 Oct 2024 17:14:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] vfio/migration: Refactor
 vfio_vmstate_change/_prepare() error reporting
To: Avihai Horon <avihaih@nvidia.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, Peter Xu
 <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <20241020130108.27148-1-avihaih@nvidia.com>
 <20241020130108.27148-3-avihaih@nvidia.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20241020130108.27148-3-avihaih@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.421,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.699,
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

Hello Avihai,

On 10/20/24 15:01, Avihai Horon wrote:
> When the VM is shut down vfio_vmstate_change/_prepare() are called to
> transition the VFIO device state to STOP. They are called after
> migration_shutdown() and thus, by this time, the migration object is
> already freed (more specifically, MigrationState->qemu_file_lock is
> already destroyed).
> 
> In this case, if there is an error in vfio_vmstate_change/_prepare(), it
> calls migration_file_set_error() which tries to lock the already
> destroyed MigrationState->qemu_file_lock, leading to the following
> assert:
> 
>    qemu-system-x86_64: ../util/qemu-thread-posix.c:92: qemu_mutex_lock_impl: Assertion `mutex->initialized' failed.
> 
> Fix this by not setting migration file error in the shut down flow.
> 
> Fixes: 20c64c8a51a4 ("migration: migration_file_set_error")
> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
> ---
>   hw/vfio/migration.c | 31 +++++++++++++++++++++----------
>   1 file changed, 21 insertions(+), 10 deletions(-)
> 
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index 992dc3b102..1c44b036ea 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -783,6 +783,25 @@ static const SaveVMHandlers savevm_vfio_handlers = {
>   
>   /* ---------------------------------------------------------------------- */
>   
> +static void vfio_vmstate_change_error_report(int ret, Error *err,
> +                                             RunState state)
> +{
> +    if (state == RUN_STATE_SHUTDOWN) {
> +        /*
> +         * If VM is being shut down, migration object might have already been
> +         * freed, so just report the error.
> +         */
> +        error_report_err(err);
> +        return;
> +    }
> +
> +    /*
> +     * Migration should be aborted in this case, but vm_state_notify()
> +     * currently does not support reporting failures.
> +     */
> +    migration_file_set_error(ret, err);
> +}

This seems correct, but testing the machine's runtime state to
work around the fact that 'current_migration' is not safe to
use reveals a flaw.

In vfio, migration_is_setup_or_active() is unsafe. So are the
calls to vfio_set_migration_error().


This comment seems in contradiction with the migration code :

/* When we add fault tolerance, we could have several
    migrations at once.  For now we don't need to add
    dynamic creation of migration */

Why is 'current_migration' allocated and destroyed today ?

Could we replace it with a singleton and switch the state to
MIGRATION_STATUS_NONE instead of destroying it ?

If not, should 'current_migration' be set to NULL in
migration_shutdown() and its value tested before accessing
to any of its fields, in a thread safe manner if necessary.

Thanks,

C.



