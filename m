Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3494C10F1A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2024 13:38:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s53yU-0000HR-HJ; Thu, 09 May 2024 09:38:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s53yS-0000D0-C3
 for qemu-devel@nongnu.org; Thu, 09 May 2024 09:38:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s53yQ-0003ZX-SX
 for qemu-devel@nongnu.org; Thu, 09 May 2024 09:38:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715261894;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dJ2ItHeiShGhQ2LSCdlOrwvvo11oLvGXjQvPyADsKNI=;
 b=PMqvnJXdqbRngDBgUALDrsgiwSadC9OyQ2jqOaW4sZd+uYmcmthxZDg7eRS1miLks/YdOP
 DMSp27wMfwbD+3AkZNqMFPIWLRsJvZemt13qvOrPW14fuYUhj9dgJcsZQOXYRdzJShYSy1
 1T+ZC+KhM6ZSCMWweanZoCr1d9IKmTQ=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-29-ChDNVuqSM3uNW4nd6Jg3ug-1; Thu, 09 May 2024 09:38:12 -0400
X-MC-Unique: ChDNVuqSM3uNW4nd6Jg3ug-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6a0e9eddad0so3044866d6.0
 for <qemu-devel@nongnu.org>; Thu, 09 May 2024 06:38:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715261892; x=1715866692;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dJ2ItHeiShGhQ2LSCdlOrwvvo11oLvGXjQvPyADsKNI=;
 b=gwMKixboII33idB0PvcQK1M4FVJuxXX2pIaBy122jooicJiXPUn8Z5qNuZGdOI6RqK
 Iu66LKAtnmUAHN5j5nIHnvWaIsqy+oPGrIYvbmgKWEjgrYmQl39z4egLG6Xd9T68hZEx
 LG2+5PZD3ip1BIxeO846lRdD2d1EOdGn9NiOEPuKNtWCbwmxZ4XiRX6319ibopBR+F+/
 wH6UUNhPLS6PNDVrkUo5ZsXbfG9w7UxaSTDCLDmsRkud4JzBZUBeSvVO90vs84zMWCow
 tgs1sN+LdAoDJaik1McSaUD1Z1dnudLRa52L63v4KlTZt/R1mt/JcySKGH0OaZrcEH42
 PM4g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVhudT+0DVP6tkcZaVcyH4KgAbNeDmIlwFSbQw+sCgzgOHNV88nfPGtv7KzMjsxzDugWoZmtLDyttrrZNBcz4mc1gfljME=
X-Gm-Message-State: AOJu0Yw0IvAi8kRQxmev86BVQGrMTbNN9NjrkkoD4YXgtcDZapXqHCOE
 H9wUtD1GnP1MU0oNIEg8Dub7a9v4w3RCzXPNQqqBEihSYWsIBRQzX5gwzfaLZAEvuYRWs3IY2Jq
 gwdpb1JstoFNj1ZT6T4JLn3utDznhATk/aFJVgM63acB5odN2A9Jp
X-Received: by 2002:a05:6214:e69:b0:6a0:cd65:599a with SMTP id
 6a1803df08f44-6a15143eaa5mr64301336d6.2.1715261892004; 
 Thu, 09 May 2024 06:38:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENhY2Tfr7wEmUencavtr2gz91dxPkjjEkgx8k/slRoKfMjLfAzApB0WCbb+ujYXh95lhyemQ==
X-Received: by 2002:a05:6214:e69:b0:6a0:cd65:599a with SMTP id
 6a1803df08f44-6a15143eaa5mr64300386d6.2.1715261890100; 
 Thu, 09 May 2024 06:38:10 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6a15f179649sm7077176d6.16.2024.05.09.06.38.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 May 2024 06:38:09 -0700 (PDT)
Date: Thu, 9 May 2024 09:38:08 -0400
From: Peter Xu <peterx@redhat.com>
To: Li Zhijian <lizhijian@fujitsu.com>
Cc: Fabiano Rosas <farosas@suse.de>,
 Hailiang Zhang <zhanghailiang@xfusion.com>, qemu-devel@nongnu.org,
 Zhang Chen <chen.zhang@intel.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: Re: [PATCH 3/3] migration/colo: Tidy up bql_unlock() around
 bdrv_activate_all()
Message-ID: <ZjzRwLOijr91ir2M@x1n>
References: <20240509033106.1321880-1-lizhijian@fujitsu.com>
 <20240509033106.1321880-3-lizhijian@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240509033106.1321880-3-lizhijian@fujitsu.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, May 09, 2024 at 11:31:06AM +0800, Li Zhijian via wrote:
> Make the code more tight.
> 
> Cc: Michael Tokarev <mjt@tls.msk.ru>
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

> ---
> This change/comment suggested by "Michael Tokarev <mjt@tls.msk.ru>" came
> a bit late at that time, let's update it together in these minor set
> this time.

You can use a tag next time:

Suggested-by: Michael Tokarev <mjt@tls.msk.ru>

> ---
>  migration/colo.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/migration/colo.c b/migration/colo.c
> index 991806c06a..1b6d9da1c8 100644
> --- a/migration/colo.c
> +++ b/migration/colo.c
> @@ -838,12 +838,11 @@ static void *colo_process_incoming_thread(void *opaque)
>      /* Make sure all file formats throw away their mutable metadata */
>      bql_lock();
>      bdrv_activate_all(&local_err);
> +    bql_unlock();
>      if (local_err) {
> -        bql_unlock();
>          error_report_err(local_err);
>          return NULL;
>      }
> -    bql_unlock();
>  
>      failover_init_state();
>  
> -- 
> 2.31.1
> 
> 

-- 
Peter Xu


