Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3CC6E7717F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 16:30:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNDyQ-0002W8-Kh; Mon, 16 Dec 2024 11:29:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tNDyO-0002VT-Lc
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 11:29:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tNDyM-0000u6-KO
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 11:29:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734366567;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jGEIAvk85LVeQG+m873VaY9ymrP9o88CbKtv7+puQhk=;
 b=AbjNG5EHploACZBoEqO96JIpKOcmObcEYLy/s1nB3ONVxTuATKJdMiKMziYTVNh8zbDJe1
 uYR+i+/725g0Fo252nWIWbEmtRXnhWpXqkhEJrSjX/n4xDTNbB70FHzAhuyJTXNPJ+Qc9C
 tsoGHExLP8Ns5G2LpM3I6au5u3oMtzg=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-261-j0d7apq6NVKIHtk26UN4JQ-1; Mon, 16 Dec 2024 11:29:26 -0500
X-MC-Unique: j0d7apq6NVKIHtk26UN4JQ-1
X-Mimecast-MFC-AGG-ID: j0d7apq6NVKIHtk26UN4JQ
Received: by mail-il1-f200.google.com with SMTP id
 e9e14a558f8ab-3a7e0d5899bso88393495ab.0
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2024 08:29:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734366565; x=1734971365;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jGEIAvk85LVeQG+m873VaY9ymrP9o88CbKtv7+puQhk=;
 b=oAOn5lCrfXWTDES5xg+gwdVnRT4qKkYVOL+LDHAhvk1DQ+ISTBP1lnIZkTXfjsr0nW
 0Qb4GrrrTn/lRJV9MA79/orQyHD8XwctWF5GSG5p8mNEbtyCyiJB9SpD5u7vf140kmFr
 ccU7ovbgjfpmPFe8UXHpIChLH4cKVTR6PcFEj3GLa3dpQdEFP9c7Dy4lz3lIBugLdWTe
 VcKqG9aasP14OLhCLv/JT/O5lIAO6Te8HP11rEf+W1PqcfRJ2OajsmQNejyE0oeiqHqw
 COd2ybVqNFLWZ0w7l3X0FxbWMrxeRPv3M92c+MmKK4XV+Qu7OPiZ9JhhYJZ2bV9rYPS/
 TCeA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUfiieaGK6c1bhNyAsXX/VOXt4aJGxZnM4FpYvRozqYhEbKiIvVz45Z812Rielk3S6ZbfAmt8bEsZ7X@nongnu.org
X-Gm-Message-State: AOJu0Yyb11QqgXBlEjYEr/BYONphYUvmm4TANtAIaeYTOmBEvJJtHZGC
 xCzJ8kYSFVYOr7Qlht9cv0Xt40gAJKRXFfEc6jAjYPSA5mUKayTkbwFO5UdR1J4NCDi6Iw4G6zT
 eS23bU5qaBXZHu+XUuCbTHYnDVBi71YoZpimNPrMezNcOCRQfzlO1
X-Gm-Gg: ASbGncuGKU1bVzkj06tFju4NAC6pqiRIvIM1nAhpe07RQGOMzoDGj7YsqtOkHzNPc2x
 RGAolIV3S+sg4fEWbfs9GuSbm0IDnEusExCqOt4o22TWz2UMc/9Vsl9EJya/TVDc0h0u2b+eP9/
 WYnwdPOhEAsTF0r0Gg43W8UKhxswB2UU8IZQMOKEWGcrfYhIluwr+89pwQkkIsgPII6/GRu6pjp
 9jwTenBPpVpHjMImzrFySInpuI2O2rui2hsKVAxycas235FEaIlya/XbHzi0UGt/piMw3WnH6r5
 Ap6R7av5uPEzQ+N+AA==
X-Received: by 2002:a05:6e02:1563:b0:3a7:956c:61a4 with SMTP id
 e9e14a558f8ab-3bad2ea6f7amr4239585ab.10.1734366564997; 
 Mon, 16 Dec 2024 08:29:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHN4d7BHdw8Y+I58ssbVZ/ZYyt2sVUvU6EY4VcvNaLBy1fA9zJcTM7y8swgXLk5EHFRZk50Zw==
X-Received: by 2002:a05:6e02:1563:b0:3a7:956c:61a4 with SMTP id
 e9e14a558f8ab-3bad2ea6f7amr4239435ab.10.1734366564749; 
 Mon, 16 Dec 2024 08:29:24 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3b24d8dc980sm16070365ab.67.2024.12.16.08.29.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2024 08:29:24 -0800 (PST)
Date: Mon, 16 Dec 2024 11:29:22 -0500
From: Peter Xu <peterx@redhat.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Eric Blake <eblake@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Markus Armbruster <armbru@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v3 08/24] migration: Add thread pool of optional load
 threads
Message-ID: <Z2BVYvO1359M1i9Q@x1n>
References: <cover.1731773021.git.maciej.szmigiero@oracle.com>
 <877b7108c9cb9064615606d4c731cb12c549b7f9.1731773021.git.maciej.szmigiero@oracle.com>
 <9a229308-2c80-4ee2-8c49-5fec2207ad74@redhat.com>
 <489d1769-3807-4007-888c-608c1e9407fb@maciej.szmigiero.name>
 <Z1DcVH6j7pzboucr@x1n>
 <366e5477-9d3f-4c11-8042-542e9b4b7f65@maciej.szmigiero.name>
 <Z1sReL5wrlhvO3P5@x1n>
 <d45267a6-74a6-4eeb-b8fa-f427db03afde@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d45267a6-74a6-4eeb-b8fa-f427db03afde@maciej.szmigiero.name>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.13,
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

On Thu, Dec 12, 2024 at 11:53:24PM +0100, Maciej S. Szmigiero wrote:
> On 12.12.2024 17:38, Peter Xu wrote:
> > On Wed, Dec 11, 2024 at 12:05:23AM +0100, Maciej S. Szmigiero wrote:
> > > > Maybe move it over to migration_object_init()?  Then we keep
> > > > qemu_loadvm_state_setup() only invoke the load_setup()s.
> > > 
> > > AFAIK migration_object_init() is called unconditionally
> > > at QEMU startup even if there won't me any migration done?
> > > 
> > > Creating a load thread pool there seems wasteful if no
> > > incoming migration will ever take place (or will but only
> > > much later).
> > 
> > I was expecting an empty pool to not be a major resource, but if that's a
> > concern, yes we can do that until later.
> > 
> > [...]
> > 
> > > > > > > @@ -3007,6 +3071,19 @@ int qemu_loadvm_state(QEMUFile *f)
> > > > > > >             return ret;
> > > > > > >         }
> > > > > > > +    if (ret == 0) {
> > > > > > > +        bql_unlock(); /* Let load threads do work requiring BQL */
> > > > > > > +        thread_pool_wait(load_threads);
> > > > > > > +        bql_lock();
> > > > > > > +
> > > > > > > +        ret = load_threads_ret;
> > > > > > > +    }
> > > > > > > +    /*
> > > > > > > +     * Set this flag unconditionally so we'll catch further attempts to
> > > > > > > +     * start additional threads via an appropriate assert()
> > > > > > > +     */
> > > > > > > +    qatomic_set(&load_threads_abort, true);
> > > > 
> > > > I assume this is only for debugging purpose and not required.
> > > > 
> > > > Setting "abort all threads" to make sure "nobody will add more thread
> > > > tasks" is pretty awkward, IMHO.  If we really want to protect against it
> > > > and fail hard, it might be easier after the thread_pool_wait() we free the
> > > > pool directly (destroy() will see NULL so it'll skip; still need to free
> > > > there in case migration failed before this).  Then any enqueue will access
> > > > null pointer on the pool.
> > > 
> > > We don't want to destroy the thread pool in the path where the downtime
> > > is still counting.
> > 
> > Yeah this makes sense.
> > 
> > > 
> > > That's why we only do cleanup after the migration is complete.
> > > 
> > > The above setting of load_threads_abort flag also makes sure that we abort
> > > load threads if the migration is going to fail for other reasons (non-load
> > > threads related) - in other words, when the above block with thread_pool_wait()
> > > isn't even entered due to ret already containing an earlier error.
> > 
> > In that case IIUC we should cleanup the load threads in destroy(), not
> > here?  Especially with the comment that's even more confusing.
> > 
> 
> This flag only asks the threads in pool which are still running to exit ASAP
> (without waiting for them in the "fail for other reasons"
> qemu_loadvm_state() code flow).

I thought we could switch to an Error** model as we talked elsewhere, then
the thread who hits the error should set the quit flag, IIUC.

Even without it..

> 
> Setting this flag does *not* do the cleanup of the whole thread pool - this
> only happens in qemu_loadvm_state_cleanup().

... we have two cases here:

Either no error at all, then thread_pool_wait() will wait for all threads
until finished.  When reaching here setting this flag shouldn't matter for
the threads because they're all finished.

Or there's error in some thread, then QEMU should be stuck at
thread_pool_wait() anyway, until all threads quit.  Again, I thought it
could be the qemu_loadvm_load_thread() that sets the quit flag (rather than
here) so the failed thread will notify all threads to quit.

I just still don't see what's the help of setting it after
thread_pool_wait(), which already marked all threads finished at its
return.  That goes back to my question on whether it was only for debugging
(so no new threads to be created after this), rather than the flag to tell
all threads to quit.

Thanks,

-- 
Peter Xu


