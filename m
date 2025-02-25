Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1AAEC021B2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 17:17:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmyXh-00080F-SD; Tue, 25 Feb 2025 12:16:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tmyXg-0007zw-7f
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 12:16:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tmyXd-00042i-Lt
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 12:16:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740503780;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/mKJxsn3rooQ+zjk4FbXGJu6VkqR5puvW5Sbx3c476g=;
 b=D+KzbuCavA3FF/zDuCg/zE+Gkl6gc5+86I69d3w1BcpsJPskxKe5HFaD3XQBjrE6bwT2Jr
 J5FXd3EVE59MvymDQbc3UXq2+mQ+cwY6ta2cubbY1r6CfHPwPlA70TaUsMJ8+5mb00pGBt
 sDeL7Zh73U4RB0tEHIHcAD8icEdBVUY=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-205-glR2Po0ONJqKOheTdgioSw-1; Tue, 25 Feb 2025 12:16:16 -0500
X-MC-Unique: glR2Po0ONJqKOheTdgioSw-1
X-Mimecast-MFC-AGG-ID: glR2Po0ONJqKOheTdgioSw_1740503775
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6d89154adabso99916206d6.0
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 09:16:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740503775; x=1741108575;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/mKJxsn3rooQ+zjk4FbXGJu6VkqR5puvW5Sbx3c476g=;
 b=aHtxo6Vp2Q6jWrseFxiLGCsOt1f8E0gbD/rRb/6VXWI/xiMN6WIT8fUxyqbzChusyX
 pfpzlfXydIL7vQGbTo6EEEFKAGG8RsQKpHFFp6d1SabeL7hXKEuo9mkQHh4gYf8hu0VM
 UPCGbzSy9CvBXD7CDwnI9FhoOvP56TtiAvKSk34yRxfX0Z/UtpdnvDy3Ga13ipkuONZn
 D0vS3/EApS0f3oPdvY4qOPWrB0sqXZvdLk8ZtTeVXCn8Czn8Am+1Wu5wT/tkSZXeag+6
 WLeyzCuoBx5whS5SUSicbpWVcohqttsTpYHq4UpNTcA74Apfhvr3XxhbH/IqMWESUe4Q
 xD+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUkaDGmZJN3ZexfSCbMGa2fgl6Cq5k4CqgjpO9Y+aVK9CuYPEYqiIJcGRvUsOxno3eCJgn3R4xlXtqW@nongnu.org
X-Gm-Message-State: AOJu0YxTRham9bd8G7v6An36r3pNorYAOBd7gbz+JPug6BTMeLNZ8oj0
 ddj/p2trJ7hTKZ82gnax5s7DD1MrY2am32J0a5TXrOXJJbRGmPewYKYTfI5zMC0vBbdYrfTOzeK
 y2C5dhHk4zupTX/VqgKxYWwfa9iA8Vjx/fIAaaTT0Uf19IvmGavZf
X-Gm-Gg: ASbGncsItLTqH0lmmcONn7bIrsGig6wncFyw9HNF8u8s1ZhYP2uHbzacp0RRc+JO6jB
 NzE1vMAtVkQ5beNT/DTJc3Zr41nJYKXWMZ9fkkfZyaV6sRvw7ONJ6lVjKamv+0KY6YZOU2DTVSS
 mfekILS/uhFWt26Vo5sUp3J30iepS7UIvijQtzCRLKB/QFp5zmKNWwpgE1LJ9MLuN3C6Cm63uWW
 vvTTXzS1KFfJHpGWLp60k+wO/lSh5bz9595Zh+N3HOXDjXJEKDL3CXBovZkWYD1Ub8rkA==
X-Received: by 2002:a05:6214:518e:b0:6e4:7307:51af with SMTP id
 6a1803df08f44-6e8868fd61emr960466d6.36.1740503775544; 
 Tue, 25 Feb 2025 09:16:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF+shOaKmcoLKLQfn4V8293ZhtW517tN/bwkYakd0ppf0sSefvZITX/rb7sZ9/6HVdM69otLg==
X-Received: by 2002:a05:6214:518e:b0:6e4:7307:51af with SMTP id
 6a1803df08f44-6e8868fd61emr960176d6.36.1740503775282; 
 Tue, 25 Feb 2025 09:16:15 -0800 (PST)
Received: from x1.local ([2604:7a40:2041:2b00::1000])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e87b08729dsm11475346d6.37.2025.02.25.09.16.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2025 09:16:14 -0800 (PST)
Date: Tue, 25 Feb 2025 12:16:11 -0500
From: Peter Xu <peterx@redhat.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v5 07/36] migration: postcopy_ram_listen_thread() should
 take BQL for some calls
Message-ID: <Z73620Mo_DHV3zK0@x1.local>
References: <cover.1739994627.git.maciej.szmigiero@oracle.com>
 <c331cfc5c87a33df856e58c203d3c1d7e39fc1c1.1739994627.git.maciej.szmigiero@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c331cfc5c87a33df856e58c203d3c1d7e39fc1c1.1739994627.git.maciej.szmigiero@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Feb 19, 2025 at 09:33:49PM +0100, Maciej S. Szmigiero wrote:
> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
> 
> All callers to migration_incoming_state_destroy() other than
> postcopy_ram_listen_thread() do this call with BQL held.
> 
> Since migration_incoming_state_destroy() ultimately calls "load_cleanup"
> SaveVMHandlers and it will soon call BQL-sensitive code it makes sense
> to always call that function under BQL rather than to have it deal with
> both cases (with BQL and without BQL).
> Add the necessary bql_lock() and bql_unlock() to
> postcopy_ram_listen_thread().

We can do that, but let's be explicit on what needs BQL to be taken.

Could you add an assertion in migration_incoming_state_destroy() on
bql_locked(), then add a rich comment above it listing what needs the BQL?
We may consider dropping it some day when it's not needed.

Thanks,

> 
> qemu_loadvm_state_main() in postcopy_ram_listen_thread() could call
> "load_state" SaveVMHandlers that are expecting BQL to be held.
> 
> In principle, the only devices that should be arriving on migration
> channel serviced by postcopy_ram_listen_thread() are those that are
> postcopiable and whose load handlers are safe to be called without BQL
> being held.
> 
> But nothing currently prevents the source from sending data for "unsafe"
> devices which would cause trouble there.
> Add a TODO comment there so it's clear that it would be good to improve
> handling of such (erroneous) case in the future.
> 
> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
> ---
>  migration/savevm.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 7c1aa8ad7b9d..3e86b572cfa8 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -1986,6 +1986,8 @@ static void *postcopy_ram_listen_thread(void *opaque)
>       * in qemu_file, and thus we must be blocking now.
>       */
>      qemu_file_set_blocking(f, true);
> +
> +    /* TODO: sanity check that only postcopiable data will be loaded here */
>      load_res = qemu_loadvm_state_main(f, mis);
>  
>      /*
> @@ -2046,7 +2048,9 @@ static void *postcopy_ram_listen_thread(void *opaque)
>       * (If something broke then qemu will have to exit anyway since it's
>       * got a bad migration state).
>       */
> +    bql_lock();
>      migration_incoming_state_destroy();
> +    bql_unlock();
>  
>      rcu_unregister_thread();
>      mis->have_listen_thread = false;
> 

-- 
Peter Xu


