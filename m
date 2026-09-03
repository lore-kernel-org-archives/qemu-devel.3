Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B094C624A4
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 12:56:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x26dl-00025u-A8; Thu, 03 Sep 2026 08:34:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1x26dg-00025c-QR
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 08:33:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1x26df-0001Vw-0X
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 08:33:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788438833;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=dVH6EPWYRyPV7/YwNrLZn61mjAP7mSoqbvyg4reqEzs=;
 b=fNESAJAFu111S2lznvrPVa7v8PSETDYV9ETuYIySrl+3IrlvRNhB+IpJXpaCjnLO3oocdA
 03zsluMFWT0yOzNot3mrdUxYq0cHhojHU1XMEftOtsE7TG54T6Cta9k9FY8sWrgEL6mTkS
 ndeqT8PhJO0uU9EsV07mXAfeDjitL6E=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-125-Ow4-1xonMb-bbcBavFHQFA-1; Thu, 03 Sep 2026 08:33:49 -0400
X-MC-Unique: Ow4-1xonMb-bbcBavFHQFA-1
X-Mimecast-MFC-AGG-ID: Ow4-1xonMb-bbcBavFHQFA_1788438829
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-49b8c651ac0so27157405e9.2
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 05:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788438829; x=1789043629; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=dVH6EPWYRyPV7/YwNrLZn61mjAP7mSoqbvyg4reqEzs=;
 b=bp91d7Vg7zN5A5wazMDhFPrylM24CXbA+gE+UaBKEm3ovkZQtTWMJUTxnxHn4DBBJF
 34lzdTo47r1EBI2Cc/udgQJMH925UXADsg29I/aH57CBE963iL1/88cVjFC0h3dNkjuB
 tmWWk+SG3FQ/aBBoaQZrtBvwu9Nd/RE1fu2o9zsqoHIkOcqeKGCFZK2VW3rGdbC/T2Dq
 8K7KYO2UmeyacFeYdIUgMPq2XCS/s3GzTsnjyJfjvdoP4sxL5aekxka9B7pDB+1NUdW5
 gdcUvFKGexULMtLaY0lw/F879w+WWwLWpNTfOl7jzTa9cz34Qcj83/5buTefZUKNNDxw
 kqKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788438829; x=1789043629;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=dVH6EPWYRyPV7/YwNrLZn61mjAP7mSoqbvyg4reqEzs=;
 b=GhhTWjgS/JoMUC9r7EEI4s19WToL5iO/it/ZRabmsU/GoI7AlU/FxY0QWxJrErM0R6
 WQjXR3/XvVuSolkroF1B7+6KXOzVe+G3xm7CqXZh8rbBNv0BHx52gqC8/KrJ+hR6CUGv
 hHyij/PHDe9TQqFeAMtwcyK8VY3hy+/SQRYb7Pup79TKkVsLmTxn+ziuc/dkEePiqMQa
 zY0cHb/w8otEO28lsvkphonU40wV/hdpgUL7UgVVF+1GFMt8gboGtoyq3HZgBIT9At2k
 +ELygPqNfBnUmalAAN9fkDrD6yrf23k3RowYsf08x1jEJXXK5/XdjSw6dOrWukfopmiJ
 ik4g==
X-Forwarded-Encrypted: i=1;
 AKwUvBytRcj9SERtslcRyPG472DumHB9rE4NajXkbPLXF5HgDcqA+ZyyrEYhGGs0vTJZTC3PRn7KI8RGO54s@nongnu.org
X-Gm-Message-State: AFuF++ksaiz3mzc5P5+UqnaNhF4X01ucPE/EITZCbXYjdC8ocN49QVo1
 eXaOzEGlu43+T3tGl+g01E0C7ds+DQLTNYa2WF9+UiKkO3fHgnuwPfWHB5DdNOr9jU4mufsXC6Q
 XNnJAj7LLBrXDEb8x9qMD18MMOqkJCq2UIoSPoKZzBkXC+EZIG3TbZF9N
X-Gm-Gg: AYBFou3GQi3DXDCw9NzZk14WJjMmIFdbn9GgPFFwV/hf8+lNoVlqsrwFUGbWK+S9cMn
 1HAgKMaqLBjki73M/kL+WvimhSp8VlcJdumvOxYdFHPA0z7K2d9wGCI4bPVJYU6YwAz5g9zhA7s
 lQFxqyN81nE4dOGmBQM5ieE8C3DIg9aUxz/vj/Tx0RHzi9s5E3EUja/Ww2A534ybdHHo2XuvAem
 k3i1HvCjE3xCcwQuuAfxaUUYzpBZA838Q7kqvd+kfOFk6Vyj/uiV5wQT0kvQnTCfAt6IJF7758K
 UXwQyVQHWkO0J2lkHQ+h+W1J2643mt9VAAJ0SBqx9fCdlzK/wdhS6TJBowqRoPWPSlFqAlCQ/jt
 OEPKw8WhxCEGrMpjqr9O2wq8vopN+vu9RGSUEbVU=
X-Received: by 2002:a05:600c:3494:b0:49b:9202:6f80 with SMTP id
 5b1f17b1804b1-49ce57ee273mr224240075e9.6.1788438828647; 
 Thu, 03 Sep 2026 05:33:48 -0700 (PDT)
X-Received: by 2002:a05:600c:3494:b0:49b:9202:6f80 with SMTP id
 5b1f17b1804b1-49ce57ee273mr224238205e9.6.1788438827655; 
 Thu, 03 Sep 2026 05:33:47 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:1292:d530:bf4:da16:e208:c6bd?
 ([2a01:e0a:1292:d530:bf4:da16:e208:c6bd])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cf0c1728bsm53985775e9.15.2026.09.03.05.33.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Sep 2026 05:33:45 -0700 (PDT)
Message-ID: <ad9069ca-b72f-419f-be2f-af126d28a76b@redhat.com>
Date: Thu, 3 Sep 2026 14:33:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] vfio/migration: Avoid savevm_vfio_handlers for
 cpr-exec and cpr-transfer
To: Dongli Zhang <dongli.zhang@oracle.com>, qemu-devel@nongnu.org
Cc: alex@shazbot.org, peterx@redhat.com, farosas@suse.de,
 maciej.szmigiero@oracle.com, mark.kanda@oracle.com, bchaney@akamai.com,
 joe.jin@oracle.com
References: <20260825225054.807116-1-dongli.zhang@oracle.com>
 <20260825225054.807116-2-dongli.zhang@oracle.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260825225054.807116-2-dongli.zhang@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hello,

On 8/26/26 00:49, Dongli Zhang wrote:
> When the VFIO driver is vfio-pci, vfio_migration_query_flags() returns
> -ENOTTY, so savevm_vfio_handlers is not registered or involved.

I was confused with this sentence. Here is a proposal :

   When the kernel VFIO driver does not support migration (e.g. vfio-pci),
   vfio_migration_query_flags() returns -ENOTTY and savevm_vfio_handlers
   is never registered.

> However, VFIO drivers that support live migration, such as mlx5_vfio_pci,
> do support vfio_migration_query_flags(). In that case, savevm_vfio_handlers
> is registered and may be used to save and load the VFIO migration stream.
> This is expected for VFIO live migration, but not for cpr-exec or
> cpr-transfer.
ok

> Even after migration converges with
> "migrate_set_parameter downtime-limit 1000000", the target still reports
> the following error:
This is unclear to me. Can you rephrase ?

> failed (load of migration failed: Invalid argument: Failed to load vmstate version_id: 1, ret: -22)
> 
> Skip savevm_vfio_handlers for cpr-exec and cpr-transfer.
> 
> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
> ---
>   hw/vfio/migration.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index 73c49d8c24..49aeaad516 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -723,6 +723,13 @@ static bool vfio_is_active_iterate(void *opaque)
>       return vfio_device_state_is_precopy(vbasedev);
>   }
>   
> +static bool vfio_is_active(void *opaque)
> +{
> +    MigMode mode = migrate_mode();
> +
> +    return mode != MIG_MODE_CPR_EXEC && mode != MIG_MODE_CPR_TRANSFER;
  
Let's introduce a new cpr helper :

    static inline bool cpr_is_active(void *opaque)
    {
        MigMode mode = migrate_mode();
        return mode == MIG_MODE_CPR_EXEC || mode == MIG_MODE_CPR_TRANSFER;
    }

cpr_incoming_needed() becomes :

    bool cpr_incoming_needed(void *opaque)
    {
        return cpr_is_active(opaque);
    }


migrate_ram_is_ignored() could be adjusted too :

    bool migrate_ram_is_ignored(RAMBlock *block)
    {
   -    MigMode mode = migrate_mode();
        return !qemu_ram_is_migratable(block) ||
   -           mode == MIG_MODE_CPR_TRANSFER ||
   -           mode == MIG_MODE_CPR_EXEC ||
   +           cpr_is_active() ||
               (migrate_ignore_shared() && qemu_ram_is_shared(block)
                                        && qemu_ram_is_named_file(block));
    }
  

> +}
> +
>   /*
>    * Note about migration rate limiting: VFIO migration buffer size is currently
>    * limited to 1MB, so there is no need to check if migration rate exceeded (as
> @@ -951,6 +958,7 @@ static const SaveVMHandlers savevm_vfio_handlers = {
>       .save_cleanup = vfio_save_cleanup,
>       .save_query_pending = vfio_state_pending,
>       .is_active_iterate = vfio_is_active_iterate,
> +    .is_active = vfio_is_active,

and

     .is_active = cpr_is_active,

Thanks,

C.

>       .save_live_iterate = vfio_save_iterate,
>       .save_complete = vfio_save_complete_precopy,
>       .save_state = vfio_save_state,


