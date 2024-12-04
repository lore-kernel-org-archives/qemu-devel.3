Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4260E7716D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 22:44:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIy69-0001xP-6J; Wed, 04 Dec 2024 17:43:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tIy66-0001xG-FR
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 17:43:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tIy64-0002bD-Rt
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 17:43:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733352231;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jL3EQTd8RBoCuosCcsbie1rmXgVsICMfWmXpYq1FCxE=;
 b=MfVJWnAs8nQF+DzwQj83y6iKTBtYSEC6qTvViRhUcxzo4UX3UR0K/cMl7HwZwfOQXRWHtC
 Edy9vexzB1IluvxRtITUSyQJZv6GbF6WT7n3YAk8j9jCB0IJbTCQh+5rrH28bBal8Dk0A7
 4E4xL9TmSimJ+amdYwAdadfSuvpALEE=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-567-5J96-fvoPkiBU7wHdgq1ng-1; Wed, 04 Dec 2024 17:43:48 -0500
X-MC-Unique: 5J96-fvoPkiBU7wHdgq1ng-1
X-Mimecast-MFC-AGG-ID: 5J96-fvoPkiBU7wHdgq1ng
Received: by mail-io1-f70.google.com with SMTP id
 ca18e2360f4ac-84193bb7ed1so40554439f.1
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2024 14:43:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733352227; x=1733957027;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jL3EQTd8RBoCuosCcsbie1rmXgVsICMfWmXpYq1FCxE=;
 b=s4RFVMAi95QPdwHJYd3dhN5QLnT8vZLvTe322mR8UG21rC0wOEAoP4uKoxcdvkEU0S
 776J/3+unZNYH/1L9T4yhwhcMx7w396CetNrk4LiMkz961wrSFGwm+VpHHED/S/Wyn7e
 PlzbLNWtc6CZF44z/VHbL8YGtS1Gu0XTrsu12VSQHk/XsMSFRNYsB/w7/BG8KAKFv6GQ
 g6VJDUL61k0kcC1n7zekMScQqz/+3r5rEQ9xLFeAkVH7nEifBqe9aeRjxyIlYMrddSw7
 BIOL9KMibwHgeaNZzDXsI4gcwpkny3WSzCStAkXFmmbDGPfUMw389SIKS6M+q6baoWFa
 Oi3A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUrmYGg/uKQUfhgyo0uSUZumElEhCblldVtyllwmaJkcV/s8pfkKoq0GcsRYUrfUB9ovtneZWVWkL+K@nongnu.org
X-Gm-Message-State: AOJu0Yxwa4paj7/GkK5KLmR+wrdbW/4TiTcnZ4FL30OzlBivNLM8fKHQ
 zEVld+X2886g/d0zltMzRyB0RG0kduhKUS56kfm1i5IATFaMkFOv88qecP9cXKRpc30gLtb5A/U
 Ahif6LXE0cRZbIurpcZrEmdN4hYqQLJKdhpkyOe46305pBpRS7cJ1
X-Gm-Gg: ASbGncuyx5XjvMgw7kwyUDm/viIrvTckW7cB0gep9hm4QATSyLtQuCjJb0uXOVfNY9Y
 rr/vESHVngRXsdjioDaXRLAxkU/yuWGn5hl94DA9W+qSck3qJWXdJ9rVIRWKX+JLXYVrEQCNIMq
 EcobdBwPs8u5kfx0RqwfsA9PxvTGt0QIf6bxvkYwceE4m3+5ZW6r41I7litHUvbhUx5gxXIsGqo
 aQym81QHjXTBZJzBF0htPkdWMiglhaXA7wfB4d3uHjJjXFREJfDfIGAUUXN6SvXDI2vzNc0Nh6F
 CJWyIx+2G9Q=
X-Received: by 2002:a05:6602:3fc3:b0:841:8d66:8aea with SMTP id
 ca18e2360f4ac-8445b53bcffmr1047311439f.2.1733352227403; 
 Wed, 04 Dec 2024 14:43:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG80OMWwFPufbrkFkpRBSn2SoDFc0eJHJdP4yd7v30ezuwSIoOYuOBL3WtE7n3ucULTfWw8HQ==
X-Received: by 2002:a05:6602:3fc3:b0:841:8d66:8aea with SMTP id
 ca18e2360f4ac-8445b53bcffmr1047308939f.2.1733352227087; 
 Wed, 04 Dec 2024 14:43:47 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-844738d0f20sm1318539f.12.2024.12.04.14.43.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Dec 2024 14:43:46 -0800 (PST)
Date: Wed, 4 Dec 2024 17:43:43 -0500
From: Peter Xu <peterx@redhat.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Avihai Horon <avihaih@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v3 08/24] migration: Add thread pool of optional load
 threads
Message-ID: <Z1DbH5fwBaxtgrvH@x1n>
References: <cover.1731773021.git.maciej.szmigiero@oracle.com>
 <877b7108c9cb9064615606d4c731cb12c549b7f9.1731773021.git.maciej.szmigiero@oracle.com>
 <198ca4a4-01fd-42b4-9e1a-d2860277be9e@nvidia.com>
 <ceff9e17-b23e-472b-9f29-bf4c3c895c55@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ceff9e17-b23e-472b-9f29-bf4c3c895c55@maciej.szmigiero.name>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On Thu, Nov 28, 2024 at 01:11:53PM +0100, Maciej S. Szmigiero wrote:
> > > +static int qemu_loadvm_load_thread(void *thread_opaque)
> > > +{
> > > +    struct LoadThreadData *data = thread_opaque;
> > > +    int ret;
> > > +
> > > +    ret = data->function(&load_threads_abort, data->opaque);
> > > +    if (ret && !qatomic_read(&load_threads_ret)) {
> > > +        /*
> > > +         * Racy with the above read but that's okay - which thread error
> > > +         * return we report is purely arbitrary anyway.
> > > +         */
> > > +        qatomic_set(&load_threads_ret, ret);
> > > +    }
> > 
> > Can we use cmpxchg instead? E.g.:
> > 
> > if (ret) {
> >      qatomic_cmpxchg(&load_threads_ret, 0, ret);
> > }
> 
> cmpxchg always forces sequentially consistent ordering
> while qatomic_read() and qatomic_set() have relaxed ordering.
> 
> As the comment above describes, there's no need for sequential
> consistency since which thread error is returned is arbitrary
> anyway.

IMHO this is not a hot path, so mem ordering isn't an issue.  If we could
avoid any data race we still should try to.

I do feel uneasy on the current design where everybody shares the "whether
to quit" via one bool, and any thread can set it... meanwhile we can't
stablize the first error to report later.

E.g., ideally we want to capture the first error no matter where it came
from, then keep it with migrate_set_error() so that "query-migrate" on dest
later can tell us what was wrong.  I think libvirt generally uses that.

So as to support a string error, at least we'll need to allow Error** in
the thread fn:

typedef bool (*MigrationLoadThread)(void *opaque, bool *should_quit,
                                    Error **errp);

I also changed retval to bool, as I mentioned elsewhere QEMU tries to stick
with "bool SOME_FUNCTION(..., Error **errp)" kind of error reporting.

Then any thread should only report error to qemu_loadvm_load_thread(), and
the report should always be a local Error**, then it further reports to the
global error.  Something like:

static int qemu_loadvm_load_thread(void *thread_opaque)
{
    MigrationIncomingState *mis = migration_incoming_get_current();
    struct LoadThreadData *data = thread_opaque;
    Error *error = NULL;

    if (!data->function(data->opaque, &mis->should_quit, &error)) {
       migrate_set_error(migrate_get_current(), error);
    }

    return 0;
}

migrate_set_error() is thread-safe, and it'll only record the 1st error.
Then the thread should only read &should_quit, and only set &error.  If we
want, migrate_set_error() can set &should_quit.

PS: I wished we have an unified place to tell whether we should quit
incoming migration - we already have multifd_recv_state->exiting, we could
have had a global flag like that then we can already use.  But I know I'm
asking too much.. However would you think it make sense to still have at
least Error** report the error and record it?

-- 
Peter Xu


