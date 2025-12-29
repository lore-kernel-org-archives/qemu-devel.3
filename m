Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F20FAE92733
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 17:13:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaGn7-0002GY-JO; Mon, 29 Dec 2025 12:12:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vaGn6-0002GC-Bx
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 12:12:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vaGn3-00067M-0r
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 12:12:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767028334;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=p+N6d6FZ0owyY5D77OCXrnv55/f5iSaSLYIoviXPgjk=;
 b=hhJ/3O7dZsvMGjJYAPJs4YtayfG6nLjqepOLozoIa17P/T5QnB+zwpgRmOAIqmI0jWKMYm
 6uo26y6nP5W6sWzltlYyqyBa6NtVhwCwGO2o3n7XNazKw+9BZVpr3aUKvOZucYOyvJLXNe
 s14Q4CRMefnUDXNiRzzq95ZgER1wk/s=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-325-24n8Q904O9aH0dYwAbRtfw-1; Mon, 29 Dec 2025 12:12:12 -0500
X-MC-Unique: 24n8Q904O9aH0dYwAbRtfw-1
X-Mimecast-MFC-AGG-ID: 24n8Q904O9aH0dYwAbRtfw_1767028332
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-8b9ff555d2dso2255996685a.0
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 09:12:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767028332; x=1767633132; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=p+N6d6FZ0owyY5D77OCXrnv55/f5iSaSLYIoviXPgjk=;
 b=kmPodPRn3NuS60MTsj59eBnjThFc47C1z6I6P2ZruDpMBYUcpJAUlbleAUP0KSQkRb
 q+RuZ7p1t3FC6zdr2wb7oD1Ual1Q6Ax6MkbYPt2JGjSfiWcYSUIaRSc+hFhaBJbklfDQ
 DasqIHBgiQlW6EsLwIqu/ke2HZKs+G7xbQtyXoI9/6seDDMpsZMNrCgjyeVYNPTudqsB
 E7TxJPU3h7vYwF1jDul2OS53woSrQzaQDkQVZbZHtYvC47D81EBRFAt1MAbeU/j9oiUd
 oaO9z+iAv+b1lp9AXDa2U9DB6Z1sHOAeQ88FNPMCDMuZfx/Idogvr/JaehuwJaAMPGBz
 Ap7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767028332; x=1767633132;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p+N6d6FZ0owyY5D77OCXrnv55/f5iSaSLYIoviXPgjk=;
 b=qT03K3o6qgpoyK75t5NDhcLw4lPb3uvp3SFrhf5+RgRtc09su8lHPkkATiWxK084So
 ICl/PsYcGoVXVnTt+iZEbLL1WlY577ijURCVy1jZMmNPieHQnXG0snljuaR0c1u4mogP
 JQ+guS1tdSvNEdsAILtprn/bUyYBWip8av2NJnGRhrJMN08eu3rTd8T2Wn4xcmBxS+NJ
 hYLZvrI/kfZenshrNX436o8ZFhB6k6IQNd1H/9xby115nEiQhFHYgjLFB6zCQYEpKSW8
 LHqpo5pUimy1yi4y933127OJnZtzSLoXRMx5gRBY23/GaguAtjh6+L8Z98oij4zWwvpm
 W1cA==
X-Gm-Message-State: AOJu0YxECDbNq6gAaDZi6JyF6fZ71hss304bAL8cev5bfqSSU3J27m+N
 BhDTc8d/EjNoNjuTjCdKf//0H15Voy5myqhZzZyGW1IagIpkHoE7tXQKuTH737Hm9IuOTZwaaM0
 0MtUGZjWsletVwbbn7x0Ef6lzDtU7ggUqqQ6EUxK6Q82h6MGlMH1Ng+aI
X-Gm-Gg: AY/fxX4SbH2+LE7VmCHUhT1FTXH7GdcTSY5XS8eQpc1MgX23zcok+igk8EZw01S7bTJ
 s/nf7K31PVE4o/FGPMXekpludEvmJ9uEyzonA//31m7Q60wfeqqb4hQ63aVWFblJ2WrXvpxbWYW
 NATBQVa7cRGUCwv+17YZvvq/4p79jZO+OD09F3HqTo+hIPKHAqIJbf2uiCtwtHr/XhtWhjrbSMg
 qLnFnjkN8GzxenqhPRo6w4NBIErxbc4uPrRnKno5fOjDDit6QXXDXRdzOaOSA2kYgDggCI1nm2d
 8VKj5o1F1cfvnsaqB5UkJNMpx3tHoyp+rhg1T8RZfGOoPbMcWogBA1VWyZ5WMgBx9V0wUK/DDBN
 rDF4=
X-Received: by 2002:a05:620a:1901:b0:8b2:1f04:f83 with SMTP id
 af79cd13be357-8c08fab3fa0mr4419491085a.70.1767028332347; 
 Mon, 29 Dec 2025 09:12:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH42y7d5tXyANQ3iNdqLtkWY8b2LA9Gfjf2qA/hcZepOvAyWL7dnLl2W8rnICpoK5STEbNb3g==
X-Received: by 2002:a05:620a:1901:b0:8b2:1f04:f83 with SMTP id
 af79cd13be357-8c08fab3fa0mr4419486985a.70.1767028331890; 
 Mon, 29 Dec 2025 09:12:11 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8c096781f33sm2442829485a.11.2025.12.29.09.12.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Dec 2025 09:12:11 -0800 (PST)
Date: Mon, 29 Dec 2025 12:12:10 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org
Subject: Re: [RFC PATCH 10/25] migration: Expand
 migration_connect_error_propagate to cover cancelling
Message-ID: <aVK2aqXZICw9IDke@x1.local>
References: <20251226211930.27565-1-farosas@suse.de>
 <20251226211930.27565-11-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251226211930.27565-11-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Dec 26, 2025 at 06:19:12PM -0300, Fabiano Rosas wrote:
> Cover the CANCELLING state in migration_connect_error_propagate() and
> use it to funnel errors from migrate_prepare() until the end of
> migration_connect().
> 
> (add some line breaks for legibility)
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  migration/migration.c | 24 +++++++++++++++---------
>  1 file changed, 15 insertions(+), 9 deletions(-)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index 83854d084a..e1c00867ab 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1575,18 +1575,25 @@ static void migrate_error_free(MigrationState *s)
>  static void migration_connect_error_propagate(MigrationState *s, Error *error)
>  {
>      MigrationStatus current = s->state;
> -    MigrationStatus next;
> -
> -    assert(s->to_dst_file == NULL);
> +    MigrationStatus next = MIGRATION_STATUS_NONE;
>  
>      switch (current) {
>      case MIGRATION_STATUS_SETUP:
>          next = MIGRATION_STATUS_FAILED;
>          break;
> +
>      case MIGRATION_STATUS_POSTCOPY_RECOVER_SETUP:
>          /* Never fail a postcopy migration; switch back to PAUSED instead */
>          next = MIGRATION_STATUS_POSTCOPY_PAUSED;
>          break;
> +
> +    case MIGRATION_STATUS_CANCELLING:
> +        /*
> +         * Don't move out of CANCELLING, the only valid transition is to
> +         * CANCELLED, at migration_cleanup().
> +         */
> +        break;
> +
>      default:
>          /*
>           * This really shouldn't happen. Just be careful to not crash a VM
> @@ -1597,7 +1604,10 @@ static void migration_connect_error_propagate(MigrationState *s, Error *error)
>          return;
>      }
>  
> -    migrate_set_state(&s->state, current, next);
> +    if (next) {
> +        migrate_set_state(&s->state, current, next);
> +    }
> +
>      migrate_error_propagate(s, error);
>  }
>  
> @@ -4107,11 +4117,7 @@ void migration_connect(MigrationState *s, Error *error_in)
>      return;
>  
>  fail:
> -    migrate_error_propagate(s, error_copy(local_err));
> -    if (s->state != MIGRATION_STATUS_CANCELLING) {
> -        migrate_set_state(&s->state, s->state, MIGRATION_STATUS_FAILED);
> -    }
> -    error_report_err(local_err);

OK you removed this line here..  maybe it should belong to the previous
patch?

If you agree, feel free to take:

Reviewed-by: Peter Xu <peterx@redhat.com>

> +    migration_connect_error_propagate(s, local_err);
>      migration_cleanup(s);
>      if (s->error) {
>          error_report_err(error_copy(s->error));
> -- 
> 2.51.0
> 

-- 
Peter Xu


