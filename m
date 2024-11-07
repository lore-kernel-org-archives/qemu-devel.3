Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 525B0D4336F
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2024 15:05:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t943j-0004RH-Ul; Thu, 07 Nov 2024 10:04:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t943i-0004Qt-Fs
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 10:04:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t943g-0005Yo-FE
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 10:04:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730991866;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=l9SVD9jsRHXUo9IHbcFj4Mj3LN6xTXlMA+22jfr9Hug=;
 b=LmrNPpsmzwa6G8ofBQbWNX/NZAFU5XHUP7P/0aR6d2wi03+uyaL1EHfTGubSicTGq945Bs
 KcsGr4AJKE9Xeeyhz3SqiQdpvx3nDz7l83/8LHZtoTEl5UG2QlfHYOEbCCQJgapcimbbLz
 ZiEnOAB2qszBS8qs8/xnxx0gjTwsvRE=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-462-idS4YlxOOs6MEAkKxqWJbw-1; Thu, 07 Nov 2024 10:04:24 -0500
X-MC-Unique: idS4YlxOOs6MEAkKxqWJbw-1
X-Mimecast-MFC-AGG-ID: idS4YlxOOs6MEAkKxqWJbw
Received: by mail-oi1-f197.google.com with SMTP id
 5614622812f47-3e6332cc2c0so1205360b6e.3
 for <qemu-devel@nongnu.org>; Thu, 07 Nov 2024 07:04:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730991861; x=1731596661;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l9SVD9jsRHXUo9IHbcFj4Mj3LN6xTXlMA+22jfr9Hug=;
 b=wGnzYn1GjllbKBcdNYxSCS7I8nVTiTsX1XZDM5+eHPzChOT64CIiyNq3PH+Gqgo1CP
 6YXaU6/jIcQlSxa2Il7s3iPVo3lE1jC+a/fue2bqVPbWs5P6xNud6qNvvO6nbS8Qu874
 badzAFHBDuQFgYxEy+MsQDdkwgu0a/PFwNXlV6oVKXoU7XOJP9OyMmZcBPAfMwSEWMHf
 2EbDseecmUD/c/5GIq5x9a8a/GGzHnDizv3HB3E8sSx4uiC4oFKlj/cOqCobjeOQmTD9
 7JH2ls82suu1u/N39iKrFoGyPPywNlcMUtSI96iIjGseVEXIWRlTWQ4ygY9xecwRiwC/
 qVCQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYdI3WR0B0AIYxBjRiDFt1mhm/ycb9IUGk8MRIBh1XKME7fXGZyGREWpIrVYsjXEIx6Px2okewsLSt@nongnu.org
X-Gm-Message-State: AOJu0YxjHzzrOtzu4Ozcz2INxSWd12N3nY+0Z3d7adHulDYzaNA/0oX7
 bPgtfwe8L3hI26YTkRlpaDnxWx0CVjybx/2w+/Dja7f9uEuKf/1EqI3nVnXq+5TX+uCE4yNDfQO
 5SXOo922RBIcA75HeNkAm3L+ulw0VZt0mAJ1ywrO0sPjQvmn3B+lm
X-Received: by 2002:a05:6808:4481:b0:3e6:3b46:c30f with SMTP id
 5614622812f47-3e79362a346mr395855b6e.2.1730991861006; 
 Thu, 07 Nov 2024 07:04:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGnVZS2Iopt9GEI8y2vfhAxtvOM+/Tz6pDmNREjLmyp8YZ7V4F//0S1T4PrP6NlY/FWBmnTBQ==
X-Received: by 2002:a05:6808:4481:b0:3e6:3b46:c30f with SMTP id
 5614622812f47-3e79362a346mr395817b6e.2.1730991860717; 
 Thu, 07 Nov 2024 07:04:20 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3e78cd513e9sm252918b6e.45.2024.11.07.07.04.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Nov 2024 07:04:20 -0800 (PST)
Date: Thu, 7 Nov 2024 10:04:17 -0500
From: Peter Xu <peterx@redhat.com>
To: gerben@altlinux.org
Cc: farosas@suse.de, clg@redhat.com, qemu-devel@nongnu.org,
 sdl.qemu@linuxtesting.org
Subject: Re: [PATCH] migration/migration: fix null pointer dereference in
 migration block
Message-ID: <ZyzW8Vi71srvqwTZ@x1n>
References: <20241107114256.106831-1-gerben@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241107114256.106831-1-gerben@altlinux.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
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

On Thu, Nov 07, 2024 at 02:42:56PM +0300, gerben@altlinux.org wrote:
> From: Denis Rastyogin <gerben@altlinux.org>

Hi, Denis,

Thanks for the patch, there's an identical patch already on the list to fix
it:

https://lore.kernel.org/r/20241105182725.2393425-1-peterx@redhat.com

> 
> In this merge, the migration_is_idle() function was replaced with migrate_is_running().
> However, the null pointer check for `s` was removed, leading to a dereference of `s` 
> when using qemu-system-x86_64 -hda *.vdi.
> A null check for `s` has been added before its use to prevent the dereference.

This is more severe than I thought..  I think I'll send the pull sooner,
and I'll update the commit message a bit too to reflect your report here.

> 
> Fixes: cbad455118 ("Merge tag 'migration-20241030-pull-request' of https://gitlab.com/peterx/qemu into staging")

Definitely not the merge commit to blame..

> Signed-off-by: Denis Rastyogin <gerben@altlinux.org>

Thanks,

> ---
>  migration/migration.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index aedf7f0751..8c5bd0a75c 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1117,6 +1117,10 @@ bool migration_is_running(void)
>  {
>      MigrationState *s = current_migration;
>  
> +    if (!s) {
> +        return false;
> +    }
> +
>      switch (s->state) {
>      case MIGRATION_STATUS_ACTIVE:
>      case MIGRATION_STATUS_POSTCOPY_ACTIVE:
> -- 
> 2.42.2
> 

-- 
Peter Xu


