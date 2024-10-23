Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D30FCFA478
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 21:43:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3j8d-0007Xr-0K; Wed, 23 Oct 2024 17:43:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t3j8b-0007Xg-CB
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 17:43:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t3j8Z-0001Kh-Gp
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 17:43:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729719805;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=70lE+KRDfL2D8BvCRzKaTQiL7nmGBY3W2JQlONcftHc=;
 b=Sq6S1RANtrmOvT4rwT6c6VUhjp+l/NF4h5+WWVlpzmXATC7t2iw59yZg/nWJwWDMdodjPx
 gSTDHIBmAkSp2USqflECbbRQM4AUTv7dC7aMJpnOdQKv/vOH994THblIz3BVsRIviqkP9v
 pmgFLePVuJKy3WWgL56xJvA2HZKOAis=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-310-Jinu95SVPyuScnAmr6As4A-1; Wed, 23 Oct 2024 17:43:24 -0400
X-MC-Unique: Jinu95SVPyuScnAmr6As4A-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6cbd2cb2f78so8004296d6.0
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2024 14:43:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729719804; x=1730324604;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=70lE+KRDfL2D8BvCRzKaTQiL7nmGBY3W2JQlONcftHc=;
 b=rrd4H9FQxIkQ0HUF0bcn+rbAJk6YZONZLVFAXZgRzWxIyEqeoMElPxAyKoF2Dvj1iu
 5ZzC0DRYRxgSFF88ffidLBYuhOmWRe/fjC5yYlwgS7inQZNQ2UURSETHcZMI6ZvzCUzt
 wnMyfCauxNhJmITWZ0yD8HCXmikcViYm32FiBsVDheYvHrEbGECGEK5NFYNt+TUkDpgA
 hbFmnOJTTVtrV0d5OZ18/l32z8t7geQgs7s/pFEvQh3TVnp1CHRp7TWv3mwiKt5gYS1q
 ES0NCSCco4Tb/x4Dm3pIfs53yVIvmFkrtkAazNQ/bZES5BYZAN+Wn3/aSC7+ZkWp3dvv
 1fKQ==
X-Gm-Message-State: AOJu0Yw1YP0j/uXgWkPnB4MA5QkKIdyDaIa5WG4a3c8r4dvUM3JEQOfc
 ivz2bWNw0nyDRqy476m63swlE71uspEN8Oda6YjiJFgrGWEw9HTGvWabOPerik1Af09tJbkg9Oa
 NhDix6Bv7C4Ui9DtJJiEdKV7kHC4jyXc9skYAgsr6FEHFkLSEeTlQ
X-Received: by 2002:a05:6214:260c:b0:6cb:5bde:d78 with SMTP id
 6a1803df08f44-6ce2178ecd2mr148630916d6.3.1729719803855; 
 Wed, 23 Oct 2024 14:43:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGaRzXWW1qmSFcGucdU8ALMNVjhtkepmY/wRrj9ltA1ah2AKpLYAenkmVgTe1AQnyrzNHMoZQ==
X-Received: by 2002:a05:6214:260c:b0:6cb:5bde:d78 with SMTP id
 6a1803df08f44-6ce2178ecd2mr148630616d6.3.1729719803520; 
 Wed, 23 Oct 2024 14:43:23 -0700 (PDT)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6ce00a02338sm43059276d6.141.2024.10.23.14.43.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Oct 2024 14:43:22 -0700 (PDT)
Date: Wed, 23 Oct 2024 17:43:20 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Subject: Re: [PATCH v2 0/4] Migration: Make misc.h helpers available for
 whole VM lifecycle
Message-ID: <Zxlt-E0PsT3wlRYC@x1n>
References: <20241023180216.1072575-1-peterx@redhat.com>
 <87ed46fwem.fsf@suse.de> <ZxlWjpVfRzCg1PJA@x1n>
 <87bjzafs5z.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87bjzafs5z.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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

On Wed, Oct 23, 2024 at 06:03:36PM -0300, Fabiano Rosas wrote:
> Right, but consider that it's easy enough for someone to look for a
> global object to write in the code, find the wrong one and just use
> it. It would then be up to reviewers to catch the mistake.
> 
> Look at this:
> 
>   bool migration_is_idle(void)
>   {
>       MigrationState *s = current_migration;
>       ...
>   }

This is actually something I overlooked (and just fixed it up before this
email..).. so yah I think it's too trivial indeed.

>   
>   bool migration_is_active(void)
>   {
>       MigrationState *s = global_migration;
>       ...
>   }
> 
> Of course we'll get this wrong at some point.
> 
> Also, if in the future someone decides to call migration_is_idle() from
> outside migration/, we'd be not only adding the burden to change the
> variable, but also the functional change at shutdown time.
> 
> If we're to carry on with this idea, we'll need to play with some
> headers to properly isolate these two usages. Something like:
> 
> migration.h:
>   bool migration_is_active_internal(MigrationState *s);
>   void set_global_obj(MigrationState *obj);
> 
> migration.c:
>   bool migration_is_active_internal(MigrationState *s)
>   {
>   }
> 
>   void migration_object_init(void)
>   {
>       set_global_object(MIGRATION_OBJ(object_new(TYPE_MIGRATION)));
>   }
> 
> exports.h:
>   #include migration.h
>   bool migration_is_active(void);
> 
> exports.c:
>   static MigrationState *global_migration;
>   
>   void set_global_obj(MigrationState *obj)
>   {
>       global_migration = obj;
>   }
>   
>   bool migration_is_active(void)
>   {
>       return migration_is_active_internal(global_migration);
>   }
> 
> That way, the internal code never calls the exported functions with
> global, always with current.

Yes if so we'll need this if to make it clean.

Now I'm thinking whether we can make it easier, by using a mutex to protect
current_migration accesses, but only when outside migration/ (so migration
thread's refcount will make sure the migration code has safe access to the
variable).  Tricky, but maybe working.

The 1st thing we may want to fix is, we never clear current_migration, but
QEMU does free the object after all refcounts released.. it means when
accessed after freed it's UAF and it'll be harder to debug (comparing to
NULL deref).  So the 1st thing is to clear current_migration properly,
probably.

The only possible place to reset current_migration is in finalize() (as
proposed in this series), because it can be either main / migration thread
that does the last unref and invoke finalize(), there's no function we can
clear it manually besides the finalize().

But then this leads me to the QOM unit test crash, just noticing that QEMU
has device-introspect-test which can dynamically create a migration object
via qom-list-properties QMP command.

We'll need to think about how to declare a class that can only be initiated
once.  Things like INTERFACE_INTERNAL can potentially hide a class (per we
talked just now), but you were right that could make qom-set harder to be
applicable to migration some day.  The other approach can be
INTERFACE_SINGLETON so it should still apply to qom-set /
qom-list-properties / ... but it can't be created more than once.  Either
of them needs more thoughts as prior work to allow mutex to protect
current_migration.

I'll think about it tomorrow to see what I'll propose next.

-- 
Peter Xu


