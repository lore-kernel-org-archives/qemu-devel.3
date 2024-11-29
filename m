Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2184D6EC12
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2024 14:09:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tH1g1-0005bW-9H; Fri, 29 Nov 2024 09:08:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tH1fx-0005bM-UT
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 09:08:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tH1fs-0001wR-6f
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 09:08:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732889323;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=IgoPeENWsph8qrdvtTj9Pw2dqqeyIUeGqULNXcXU1WY=;
 b=N8KdTHjRVD3eYTlrEAMb1h0aTsgX5GElI+snc9l4HraeLvASMrooc6xWAd0MH9aOq5Xw2w
 3DdOaGva2JExqE+EL+DzWIzo+xZUXIcnPloU7go1iME848rKfcpXh7RdWYSZY5abWfG1+8
 KQZMFZRPbwM9WO7SJaBrz196AbEYXpI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-61-glQV7mLiPUij3WA7hsemqA-1; Fri, 29 Nov 2024 09:08:41 -0500
X-MC-Unique: glQV7mLiPUij3WA7hsemqA-1
X-Mimecast-MFC-AGG-ID: glQV7mLiPUij3WA7hsemqA
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-385e03f54d0so246169f8f.3
 for <qemu-devel@nongnu.org>; Fri, 29 Nov 2024 06:08:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732889320; x=1733494120;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IgoPeENWsph8qrdvtTj9Pw2dqqeyIUeGqULNXcXU1WY=;
 b=v5o5vHeIb0skBuOpbVn8mNSXlInjXxwftfG1fE1JETRnrquNzRBWw8PK9b854JaHKo
 BpPVn4s+zNBK61GxXOfd6SoqZmMXu5DkBfAlx2jZ5BxpMhhxCsF/bW3c/MprjzPhOqvS
 QUKcZ2VLh6Ab4Cm65NL6T3Cxg86G7TiWT0NpxTn5bd9/wrCcMXCLZ1fPRyhE76NMNZ5M
 WftZsHbS9dBhWM2me86wnAslP8G4f6Y+yVTcmNLa1MePMc0RfVcwbjjMBGGpHxDP63ub
 fg0Ff9E9J8vY1pqd5Ee79MGyTonTuvgTqIfvQTQbEh7C/+dTvYSUlVVutBGuBCfJpf3p
 4snQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXMT3LAibO3gOyOArpM/erYhjxX0ZG3s7mxP63eDKY/ygx2SxB9nj2TGMJMDTIjkyaEh8+9jXkKagrv@nongnu.org
X-Gm-Message-State: AOJu0Yw0C3MkJiZBQV5fcu6NqH1kycUrMwM0LNFw5kfDuH3IDAXHPJP/
 P0R4f9hCa9XgxDrwP8w/1I2rKJV1TOH+ZbqPYiZiRKltDxwArwGeB10B2uxrlf6AVYPKHNXZ6F3
 lFQJWyyxA5YeJJ2UnknCcKrDpKFHjajjQrsQI6egmhKFzBS/dIx/X
X-Gm-Gg: ASbGnct+CUkXAFX3f5A5D5WztOCHrx5ELqw3vrgc4PE+TJqaKrRc0ZJ/dP/5q1tuOuP
 a7oYeQ+tnwkotNSfCDUeCwSWRz7qJbSPetlqd+fXNvC+/aYnOTSThjVWzuUMC6Ff8za0FfIOX7S
 0fXfQb/tHRO7RcFTM4zkEvewWgnJi/72f9mbriDCsh4+DWJWJ2EktiHO1DaWPCC99JhCvAdjAs2
 +0dkvR51U5cnRzdS4wqkJWC2ggptjFjKHqKcsuG+0tYUdqpeod9MgpF9Ub+Nf0fvMGeBUH8BKfJ
 MBLM710Xhuyx
X-Received: by 2002:a5d:47cb:0:b0:382:4f77:5bec with SMTP id
 ffacd0b85a97d-385c6ebb82fmr11800774f8f.16.1732889318866; 
 Fri, 29 Nov 2024 06:08:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGR8Rm+CBzxL7KEjGOzjJk9ErSj85RUFKTkMLrsYSkKU3wgaylIGZDpLtqy8LkmfpWbAvFl1Q==
X-Received: by 2002:a5d:47cb:0:b0:382:4f77:5bec with SMTP id
 ffacd0b85a97d-385c6ebb82fmr11800660f8f.16.1732889318072; 
 Fri, 29 Nov 2024 06:08:38 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385ccd68c1bsm4633365f8f.84.2024.11.29.06.08.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Nov 2024 06:08:37 -0800 (PST)
Message-ID: <9f27f058-59f0-4056-b19a-f613418e0760@redhat.com>
Date: Fri, 29 Nov 2024 15:08:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 18/24] vfio/migration: Don't run load cleanup if load
 setup didn't run
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>,
 qemu-devel@nongnu.org
References: <cover.1731773021.git.maciej.szmigiero@oracle.com>
 <72424ece45968b1ae6b39750917a041867c415ab.1731773021.git.maciej.szmigiero@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <72424ece45968b1ae6b39750917a041867c415ab.1731773021.git.maciej.szmigiero@oracle.com>
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
> It's possible for load_cleanup SaveVMHandler to get called without
> load_setup handler being called first.
> 
> Since we'll be soon running cleanup operations there that access objects
> that need earlier initialization in load_setup let's make sure these
> cleanups only run when load_setup handler had indeed been called
> earlier.
> 
> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>

tbh, that's a bit ugly. I agree it's similar to those 'bool initialized'
attributes we have in some structs, so nothing new or really wrong.
But it does look like a workaound for a problem or cleanups missing
that would need time to untangle.

I would prefer to avoid this change and address the issue from the
migration subsystem if possible.


Thanks,

C.




> ---
>   hw/vfio/migration.c           | 21 +++++++++++++++++++--
>   include/hw/vfio/vfio-common.h |  1 +
>   2 files changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index 01aa11013e42..9e2657073012 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -688,16 +688,33 @@ static void vfio_save_state(QEMUFile *f, void *opaque)
>   static int vfio_load_setup(QEMUFile *f, void *opaque, Error **errp)
>   {
>       VFIODevice *vbasedev = opaque;
> +    VFIOMigration *migration = vbasedev->migration;
> +    int ret;
> +
> +    assert(!migration->load_setup);
> +
> +    ret = vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_RESUMING,
> +                                   migration->device_state, errp);
> +    if (ret) {
> +        return ret;
> +    }
>   
> -    return vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_RESUMING,
> -                                    vbasedev->migration->device_state, errp);
> +    migration->load_setup = true;
> +
> +    return 0;
>   }
>   
>   static int vfio_load_cleanup(void *opaque)
>   {
>       VFIODevice *vbasedev = opaque;
> +    VFIOMigration *migration = vbasedev->migration;
> +
> +    if (!migration->load_setup) {
> +        return 0;
> +    }
>   
>       vfio_migration_cleanup(vbasedev);
> +    migration->load_setup = false;
>       trace_vfio_load_cleanup(vbasedev->name);
>   
>       return 0;
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index e0ce6ec3a9b3..246250ed8b75 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -66,6 +66,7 @@ typedef struct VFIOMigration {
>       VMChangeStateEntry *vm_state;
>       NotifierWithReturn migration_state;
>       uint32_t device_state;
> +    bool load_setup;
>       int data_fd;
>       void *data_buffer;
>       size_t data_buffer_size;
> 


