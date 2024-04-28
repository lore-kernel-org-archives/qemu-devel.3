Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 259DAC4345F
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Apr 2024 13:00:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s147Y-0007yw-Mb; Sun, 28 Apr 2024 08:59:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s147X-0007ym-9f
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 08:59:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s147V-0003je-If
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 08:59:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714309143;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=De+Mch23BAAVRT66kXRIeFTjcsKV1nzVVhph+GC/ajQ=;
 b=GEAkg8iIVT7IIbZN2LH12gNfr9baroq9xFq8GWYHADV8dzdfLzw4EOl/4dL2Iu+P3Ozdit
 6Gbra0L1yiMiytV06tgEbkSQlng4r1vZNmWBM4PXgi6X14yfDwNN4QZ+QEkXyK+5Y7QAKI
 5DpqQqvzLj6Dmyc3UYWiACZ8qHwu0fs=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581-msdKbyqnP5KnrCv_p45OHg-1; Sun, 28 Apr 2024 08:59:01 -0400
X-MC-Unique: msdKbyqnP5KnrCv_p45OHg-1
Received: by mail-oo1-f72.google.com with SMTP id
 006d021491bc7-5acdbfb5b37so1210605eaf.3
 for <qemu-devel@nongnu.org>; Sun, 28 Apr 2024 05:59:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714309141; x=1714913941;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=De+Mch23BAAVRT66kXRIeFTjcsKV1nzVVhph+GC/ajQ=;
 b=KUEnJBNbyQPJplZ82qLgxb76Pcoabl4gjZAhYaSDOYd55l6h8O7LMmftWdOEzylenR
 5j3AkhYa14FAhgb2Qqg5AkfnDEq/7X1QeGWV4S+KliiGTlTM63kF5yEDCvrBGZT3GWJd
 vrYYj62q1txFK23WBavjA9nS7TwLrMmufunRgzZDhyXvDo+GBFV7LBv6ZooV4IV9f2X3
 sn7lj93Ry/khsq/1ZGCFhExxt3At6RgEEKb+D+q/BCdd6aZ//Vek1Ync+yBXsAwyXgQH
 I5k0p1c9qOQMOScRqufc5PNVW6di6IdfKb0wxRbfACN1dg6sR1yPuEaK/DxKeezj8V1s
 6ryw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVtEsZOeDnp3YMDvxjgyBH751KqA10+LvWAiXZ56Y5YhYjXKsd0E4w8IC36RTp5hXEFQQyzfFyseG5GL/CRWsLtc9Dh92Y=
X-Gm-Message-State: AOJu0Yynkko1/zp3Jb3JXufaSQty3AuWFOvT1Vb5n6FfTo+zgSqxIQm9
 WmXxc4MYChK8aEDR2JOmZWE8OCCSrjqsRhPDOu3jpAGeFVY+MeXs2vyJgzPwrmPb8XgXNPpaJMq
 +hFiTIZdOC817ODkCtpwku/O02z+mKfEVTq2SrdsLJQVW215eY1GC
X-Received: by 2002:a05:6808:1985:b0:3c8:4964:cc9d with SMTP id
 bj5-20020a056808198500b003c84964cc9dmr8733298oib.0.1714309140782; 
 Sun, 28 Apr 2024 05:59:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUIEAVTwWLO03oWKVkH2dWPHSovkAaGOKra7vrXyDw9UIVbZMq1sTdSOZaater9SJYgmgl2Q==
X-Received: by 2002:a05:6808:1985:b0:3c8:4964:cc9d with SMTP id
 bj5-20020a056808198500b003c84964cc9dmr8733280oib.0.1714309140128; 
 Sun, 28 Apr 2024 05:59:00 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 s11-20020a0c8d4b000000b0069ba200fd5csm8422012qvb.70.2024.04.28.05.58.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Apr 2024 05:58:59 -0700 (PDT)
Date: Sun, 28 Apr 2024 08:58:52 -0400
From: Peter Xu <peterx@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Li Zhijian <lizhijian@fujitsu.com>, zhanghailiang@xfusion.com,
 farosas@suse.de, qemu-devel@nongnu.org, chen.zhang@intel.com,
 Wen Congyang <wencongyang2@huawei.com>,
 Xie Changlong <xiechanglong.d@gmail.com>
Subject: Re: [PATCH v2] migration/colo: Fix bdrv_graph_rdlock_main_loop:
 Assertion `!qemu_in_coroutine()' failed.
Message-ID: <Zi5IDLt7GFi7AFfC@x1n>
References: <20240417025634.1014582-1-lizhijian@fujitsu.com>
 <41d35401-2573-415e-a475-1e81708bdaa4@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <41d35401-2573-415e-a475-1e81708bdaa4@tls.msk.ru>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.114,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Sun, Apr 28, 2024 at 03:39:09PM +0300, Michael Tokarev wrote:
> 17.04.2024 05:56, Li Zhijian via wrote:
> > bdrv_activate_all() should not be called from the coroutine context, move
> > it to the QEMU thread colo_process_incoming_thread() with the bql_lock
> > protected.
> > 
> > The backtrace is as follows:
> >   #4  0x0000561af7948362 in bdrv_graph_rdlock_main_loop () at ../block/graph-lock.c:260
> >   #5  0x0000561af7907a68 in graph_lockable_auto_lock_mainloop (x=0x7fd29810be7b) at /patch/to/qemu/include/block/graph-lock.h:259
> >   #6  0x0000561af79167d1 in bdrv_activate_all (errp=0x7fd29810bed0) at ../block.c:6906
> >   #7  0x0000561af762b4af in colo_incoming_co () at ../migration/colo.c:935
> >   #8  0x0000561af7607e57 in process_incoming_migration_co (opaque=0x0) at ../migration/migration.c:793
> >   #9  0x0000561af7adbeeb in coroutine_trampoline (i0=-106876144, i1=22042) at ../util/coroutine-ucontext.c:175
> >   #10 0x00007fd2a5cf21c0 in  () at /lib64/libc.so.6
> > 
> > CC: Fabiano Rosas <farosas@suse.de>
> > Closes: https://gitlab.com/qemu-project/qemu/-/issues/2277
> > Fixes: 2b3912f135 ("block: Mark bdrv_first_blk() and bdrv_is_root_node() GRAPH_RDLOCK")
> > Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> 
> Commit 2b3912f135 is in 8.2 (v8.1.0-1575-g2b3912f135).  Is this fix supposed to go
> to stable-8.2 series?

Yes we probably should.  I've copied qemu-stable when queuing this patch
for that:

https://lore.kernel.org/r/20240423223813.3237060-27-peterx@redhat.com

> The prob here is that in 8.2, there's no bql_lock/unlock.
> I guess it should use qemu_mutex_lock_iothread() instead, for before
> 195801d700c008 "system/cpus: rename qemu_mutex_lock_iothread() to bql_lock()".

Right, some further care needs to be taken on this one indeed.

> 17.04.2024 05:56, Li Zhijian via wrote:
> > --- a/migration/colo.c
> > +++ b/migration/colo.c
> > @@ -835,6 +835,16 @@ static void *colo_process_incoming_thread(void *opaque)
> >           return NULL;
> >       }
> > +    /* Make sure all file formats throw away their mutable metadata */
> > +    bql_lock();
> > +    bdrv_activate_all(&local_err);
> > +    if (local_err) {
> > +        bql_unlock();
> > +        error_report_err(local_err);
> > +        return NULL;
> > +    }
> > +    bql_unlock();
> 
> FWIW, this can be simplified as follows:
> 
>    bql_lock();
>    bdrv_activate_all(&local_err);
>    bql_unlock();
>    if (local_err) {
>         error_report_err(local_err);
>         return NULL;
>    }
> 
> (I know it is already too late)

Agree. :)

Thanks,

-- 
Peter Xu


