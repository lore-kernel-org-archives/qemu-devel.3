Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71954C83030
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 21:32:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXRXC-0007UE-6F; Thu, 03 Jul 2025 17:31:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uXRX9-0007TL-OI
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 17:31:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uXRX7-0007qW-Ul
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 17:31:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751578312;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Mv3/liEXbdi8Or8sOjTT4AN5x9mjmdkW8beC5++aaN0=;
 b=hxln+lvqOueBIaKJuVhuo+KUYL6u+AmM6yR8T9inf9S8lRpRiKcQw/sLQNCk2BDNrsD6rc
 Bqqg2mr1mYHD7yczZEi0j6EyrzP+GGP/rrCVg9J+RUjjXDfTD/cZyPVXVgm/F8rxqBqZpK
 A6aTjiltHNQVT66Ryt7jNX7aI75hBhw=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-438-rcgc-hk1P0ijhH3zJ6TI9w-1; Thu, 03 Jul 2025 17:31:43 -0400
X-MC-Unique: rcgc-hk1P0ijhH3zJ6TI9w-1
X-Mimecast-MFC-AGG-ID: rcgc-hk1P0ijhH3zJ6TI9w_1751578296
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7d3e90c3a81so23224585a.1
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 14:31:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751578296; x=1752183096;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mv3/liEXbdi8Or8sOjTT4AN5x9mjmdkW8beC5++aaN0=;
 b=AeEffLrv2ItpoicL1VT2pGa9cEw4f7s5tWh1jgSiqNYMA/Hrudw9jz1m2j8MVWUyrf
 HRXjgcOXqh5rWTJHr3Lm8SAKkTxI8viM2DJs6SByuuG8fnA5mMJZz450zxQumW/HB5Wd
 Ljmuf6F/1SbHal9bf8MbopjcHrsPyN5hBg01+eWiFwRyn94jrCOjUht/bIw8lSHHgXhk
 v9pHQGob/0R662N//xLde2LRm0AKZ09v29zTju+ajSXGTWBi6Fd9Q0BCQzdM8PGplCXT
 S8URsadYw10s8pGTQnYpEmRePPhiK/b7l6y3SEgwNs8QPkwYDRZJb33pkr8M5GsXW2eH
 Lg1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXS4iAvazuRgRxHHHQ7qVLzed+oyo886u+oUDCdHKJIqWH8gkdRHA0hgGWPX+45suKvaxOal2W8TnVW@nongnu.org
X-Gm-Message-State: AOJu0YwTWUCfjJrU8+g8uBMkxwWL/ceiJMc7mvOsN0st5jw/GJUfudx1
 +FwRc4hvgXjAELRphXJEB9+sHbYz0Zy/9qX5B1ub0BuLJIs2PPWF20wnJwNIDz6RUFvK0CEDCrx
 It1p2+Ss3VHRUeeFLsi0vtCH4BYjZgi9NCqb/GXFOOZPLsfpVMHfW3rmo
X-Gm-Gg: ASbGncu94d0q4i4o9qbgxS/l89nWESPFxYbTO7V46AADGvMgIrShkdYfYsmDhu+V4Po
 KJXCxGn4/ViTzy3ALbViHmYsz46nSzI1C8pmAJkxeUpT47qYWAqc9Euttk9X/QQ/p2+ySQlNPYL
 IxXg/lOd5k4vfspGRV4gojxtUu4jcAGbZWI2W4uMYljy8pHvB8tBf/77rh/xyJdi5bqYBrDlPTL
 Zx0HckR6CqlgugtP1G42K5S/EsQEehmL7nSal+VXaA0t502Ns+GwpN94rpIGHAPTPyfuMbQ/Ywo
 XAEJU95ykm3MKw==
X-Received: by 2002:a05:620a:1713:b0:7d5:d1a3:40af with SMTP id
 af79cd13be357-7d5dcd14e83mr94899985a.32.1751578295575; 
 Thu, 03 Jul 2025 14:31:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF4izf0oiF4yQ6u73BjHkDo0+t341CPrM+1vG921p8j4xcYuAfv3067UzuaMYJ6uhESymLJYw==
X-Received: by 2002:a05:620a:1713:b0:7d5:d1a3:40af with SMTP id
 af79cd13be357-7d5dcd14e83mr94895985a.32.1751578295094; 
 Thu, 03 Jul 2025 14:31:35 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7d5dbe919afsm51343285a.93.2025.07.03.14.31.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Jul 2025 14:31:34 -0700 (PDT)
Date: Thu, 3 Jul 2025 17:31:31 -0400
From: Peter Xu <peterx@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org, berrange@redhat.com
Subject: Re: [PATCH v2 01/24] migration: Fix leak of block_bitmap_mapping
Message-ID: <aGb2s6iySOJrEMx7@x1.local>
References: <20250630195913.28033-1-farosas@suse.de>
 <20250630195913.28033-2-farosas@suse.de>
 <87h5zw4eyc.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87h5zw4eyc.fsf@pond.sub.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Tue, Jul 01, 2025 at 08:12:27AM +0200, Markus Armbruster wrote:
> Fabiano Rosas <farosas@suse.de> writes:
> 
> > Caught by inspection, but ASAN also reports:
> >
> > Direct leak of 16 byte(s) in 1 object(s) allocated from:
> >  #0 in malloc
> >  #1 in g_malloc
> >  #2 in g_memdup
> >  #3 in qapi_clone_start_struct ../qapi/qapi-clone-visitor.c:40:12
> >  #4 in qapi_clone_start_list ../qapi/qapi-clone-visitor.c:59:12
> >  #5 in visit_start_list ../qapi/qapi-visit-core.c:80:10
> >  #6 in visit_type_BitmapMigrationNodeAliasList qapi/qapi-visit-migration.c:639:10
> >  #7 in migrate_params_apply ../migration/options.c:1407:13
> >  #8 in qmp_migrate_set_parameters ../migration/options.c:1463:5
> >  #9 in qmp_marshal_migrate_set_parameters qapi/qapi-commands-migration.c:214:5
> >  #10 in do_qmp_dispatch_bh ../qapi/qmp-dispatch.c:128:5
> 
> migration_instance_finalize() runs when a TYPE_MIGRATION object dies, we
> have just one such object, pointed to by @current_migration, and it
> lives until QEMU shuts down.
> 
> So this is as harmless as they get.  Please mentions this in the commit
> message, to guide backporters.

If we do not copy qemu-stable, and do not attach Fixes, logically it should
imply no backport needed.  Not sure if it was intentional, though..  Agreed
some enrichment in the log would always be nicer.

> 
> > Signed-off-by: Fabiano Rosas <farosas@suse.de>
> > ---
> >  migration/migration.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/migration/migration.c b/migration/migration.c
> > index 4098870bce..7ec60d97f9 100644
> > --- a/migration/migration.c
> > +++ b/migration/migration.c
> > @@ -4050,6 +4050,7 @@ static void migration_instance_finalize(Object *obj)
> >  {
> >      MigrationState *ms = MIGRATION_OBJ(obj);
> >  
> > +    qapi_free_BitmapMigrationNodeAliasList(ms->parameters.block_bitmap_mapping);
> >      qemu_mutex_destroy(&ms->error_mutex);
> >      qemu_mutex_destroy(&ms->qemu_file_lock);
> >      qemu_sem_destroy(&ms->wait_unplug_sem);
> 
> With an adjusted commit message:
> Reviewed-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


