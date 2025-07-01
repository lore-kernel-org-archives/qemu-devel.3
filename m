Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92297C83038
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 14:48:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWcGt-00008p-SM; Tue, 01 Jul 2025 10:47:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1uWcG6-0007vc-JB
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:47:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1uWcG0-0007Wt-QT
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:46:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751381204;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UMC/A6RAs43ZKJp/HNwTuRg/0+rMwp9YxcboB6r83i0=;
 b=LWhblFzOkY+LyHxT5wga1rkJlC6eniHuSrm9FOaqlBc5opGlaz4CJEiZs2JJl9aThm9rxs
 jfAKYgEAhFn2Li6UWNDflAlH4CauM7NDzSjNv6EKxLYM8P3VN6kpnEJh2r3lnenARZviKq
 7i+AjBnhLyoIOMY7f7254/AOekZhbX4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-LZVLWg9nNY2RSCYceWSwQQ-1; Tue, 01 Jul 2025 10:46:42 -0400
X-MC-Unique: LZVLWg9nNY2RSCYceWSwQQ-1
X-Mimecast-MFC-AGG-ID: LZVLWg9nNY2RSCYceWSwQQ_1751381201
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-450d290d542so36974735e9.1
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 07:46:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751381201; x=1751986001;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UMC/A6RAs43ZKJp/HNwTuRg/0+rMwp9YxcboB6r83i0=;
 b=gXIFvk8KA6APoAThahqSXtvXN7Q77jfeA8DM+cZZO38dkBTZ19KOaaYEfleh06StPU
 tGvDuFZIbn66Hj9RqyxE0vm9i7+xMwVmeyIXtCNo5k8MteCPp9fNLfSn8hIID1C2susN
 cRsR5N5BWzXXrYhQSf/CmwOOlRr70Ijk9Sb5jNHtLU7zrANEQdZbqMBT4GtSxA6G6G+x
 v/w7zcWxdAhJLBd7oMcbR8Ja6oJ2XtYr8Ofc2vJlyxAUaAECsttCW8hsltqMX0Wsf7Y6
 wAvCrRIe7e4us6Aft9umA1C2r8J6NnPRyvhyxqWem0XGtbJGe2Cp/mUH7M7F8UjIzB3L
 FAzg==
X-Gm-Message-State: AOJu0Yy5yHsic0OO4owA9OkACaO7/rnOwh/dLECcPAQMVYId4nugoe5M
 nTeH4Nc0R2bwMghneD1lNu85kOLnF3+QXnPyIOuXtzCXiGusmNfBk2xnVvcEV500NXYk/YO3hOt
 7EiUonyClSGIzWOA1KCkCUnEEDaqYR3o/Ma2cwhly9IYZ6McYhJUzkYYR
X-Gm-Gg: ASbGncv8BSyMhIYBakUQIhRtJ/gpB8i+yxs5aaGDHupwbL/l9SKFU7M9LAAA2LjrCCo
 J1hps6w6oqiGcSedA4hie7s6IbT18adJRknrQM3o8qblxHFLeDwVKhg09x2IOkPOmRvOpct7fmt
 4u8e95OITticTtge3/H3ZZRTA/S58VlSBphzpWogAXG5Pfp2Ipn8zhrAWEaN/0DP1swFSvAIdii
 l4qdO6yJ+YlWxTKSNnVnNuuMlwfuSQyMH4ROl96CqLgROdewaevMOOxv9cK4CDLDcyU2YhknHk0
 y6NB+EzHDWG4UxmPLWOPwCCFEGD8fQIULN22BrmwrNRe5Mz7zHEB1jm94g8mJFsx4XxowvCd5NG
 1c+eMFBBgeLYvllhrZlGKqQJoVEpzBs4pM9vBAp0YAvJslfmxVoU=
X-Received: by 2002:a05:600c:190b:b0:44b:eb56:1d48 with SMTP id
 5b1f17b1804b1-4538ee4f88cmr199617435e9.4.1751381201013; 
 Tue, 01 Jul 2025 07:46:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMeT/YY3inTBxyQTVgKTSbxEEAcLrxTan0VXaWX4UKFD0XhfIh5lEoacPC6K7bTh61p79v7w==
X-Received: by 2002:a05:600c:190b:b0:44b:eb56:1d48 with SMTP id
 5b1f17b1804b1-4538ee4f88cmr199617085e9.4.1751381200512; 
 Tue, 01 Jul 2025 07:46:40 -0700 (PDT)
Received: from ?IPV6:2003:cf:d700:f3aa:cbe1:b363:ae39:fc99?
 (p200300cfd700f3aacbe1b363ae39fc99.dip0.t-ipconnect.de.
 [2003:cf:d700:f3aa:cbe1:b363:ae39:fc99])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-453823ad03asm200375865e9.23.2025.07.01.07.46.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Jul 2025 07:46:39 -0700 (PDT)
Message-ID: <18f6275a-dee0-4df4-85e3-efaf81a7724d@redhat.com>
Date: Tue, 1 Jul 2025 16:46:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] block: implement 'resize' callback for child_of_bds
 class
To: Fiona Ebner <f.ebner@proxmox.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, stefanha@redhat.com,
 fam@euphon.net
References: <20250630113035.820557-1-f.ebner@proxmox.com>
 <20250630113035.820557-4-f.ebner@proxmox.com>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20250630113035.820557-4-f.ebner@proxmox.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 30.06.25 13:27, Fiona Ebner wrote:
> If a node below a filter node is resized, the size of the filter node
> is now also refreshed (recursively for filter parents).
>
> Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
> ---
>   block.c                          | 12 ++++++++++++
>   include/block/block_int-common.h |  2 +-
>   2 files changed, 13 insertions(+), 1 deletion(-)

What does this do for block job filter nodes, like mirror?  If they 
changed their length, we might have to consider whether the job also 
needs to be amended somehow.

However, I assume it’s a safe (conservative) change for them because 
such drivers don’t implement bdrv_co_getlength(), so 
bdrv_co_refresh_total_sectors() will not change anything.  Is that right 
and intended?

Reviewed-by: Hanna Czenczek <hreitz@redhat.com>

(Babbling below.)

> diff --git a/block.c b/block.c
> index bfd4340b24..449f814ebe 100644
> --- a/block.c
> +++ b/block.c
> @@ -1497,6 +1497,17 @@ static void GRAPH_WRLOCK bdrv_child_cb_detach(BdrvChild *child)
>       }
>   }
>   
> +static void coroutine_fn GRAPH_RDLOCK bdrv_child_cb_resize(BdrvChild *child)
> +{
> +    BlockDriverState *bs = child->opaque;
> +
> +    if (bs->drv && bs->drv->is_filter) {

Checking the role for BDRV_CHILD_FILTERED would be more generic; but it 
would cause 'raw' nodes to be updated, too.  But I don’t know whether we 
want that or not, and excluding raw (i.e. not changing behavior there) 
is certainly the safe option.

> +        /* Best effort, ignore errors. */
> +        bdrv_co_refresh_total_sectors(bs, bs->total_sectors);
> +        bdrv_co_parent_cb_resize(bs);

This makes me wonder whether bdrv_co_refresh_total_sectors() should 
itself call bdrv_co_parent_cb_resize().  Still not quite sure; if the 
underlying image file is resized by an external party (and we notice 
this by accident, more or less), maybe the guest device should be informed.

(One thing to consider, maybe, are nodes that unshare the resize 
permission for a child.  It’s probably not clever to call the resize CB 
if that permission is unshared, so maybe just from that perspective, we 
should keep that CB strictly inside of that explicit truncate path that 
checks that permission (at least when growing images...).)

Anyway, again, this is the safe option.

Hanna

> +    }
> +}
> +
>   static int bdrv_child_cb_update_filename(BdrvChild *c, BlockDriverState *base,
>                                            const char *filename,
>                                            bool backing_mask_protocol,
> @@ -1529,6 +1540,7 @@ const BdrvChildClass child_of_bds = {
>       .detach          = bdrv_child_cb_detach,
>       .inactivate      = bdrv_child_cb_inactivate,
>       .change_aio_ctx  = bdrv_child_cb_change_aio_ctx,
> +    .resize          = bdrv_child_cb_resize,
>       .update_filename = bdrv_child_cb_update_filename,
>       .get_parent_aio_context = child_of_bds_get_parent_aio_context,
>   };
> diff --git a/include/block/block_int-common.h b/include/block/block_int-common.h
> index 692a9696d1..6670db2f85 100644
> --- a/include/block/block_int-common.h
> +++ b/include/block/block_int-common.h
> @@ -1023,7 +1023,7 @@ struct BdrvChildClass {
>       /*
>        * Notifies the parent that the child was resized.
>        */
> -    void (*resize)(BdrvChild *child);
> +    void GRAPH_RDLOCK_PTR (*resize)(BdrvChild *child);
>   
>       /*
>        * Returns a name that is supposedly more useful for human users than the


