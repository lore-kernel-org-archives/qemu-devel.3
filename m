Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B31FC9EC94
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 15:51:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfKCV-0006GM-Cs; Mon, 12 Jan 2026 10:51:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vfKCB-00069z-8B
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 10:51:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vfKC5-0003PF-92
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 10:51:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768233058;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7PtzNrOJiyvhnBNKea6mwGWICs3RgUoneVrPltLKNBc=;
 b=bjlp7sIoQjDEnOkx/8M3f3reiOSRiB5Emr9OlRFJ30h6z4StYxpYMg6IXiT7VpvTc3gC4E
 u33k+zp3pJD8kmghIMijuV0uQ7w3/LahIK3q8BFfnNT+0+l03hxwY3sNXYNaHcEAGUJiKO
 V6PpNPOJOmaYNpIEVO567Q3J9xYTVno=
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-292-IkDbAFKBNxivDNyxQgHF_Q-1; Mon, 12 Jan 2026 10:50:56 -0500
X-MC-Unique: IkDbAFKBNxivDNyxQgHF_Q-1
X-Mimecast-MFC-AGG-ID: IkDbAFKBNxivDNyxQgHF_Q_1768233056
Received: by mail-ua1-f69.google.com with SMTP id
 a1e0cc1a2514c-93f65d0a94eso9159489241.2
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 07:50:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768233056; x=1768837856; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=7PtzNrOJiyvhnBNKea6mwGWICs3RgUoneVrPltLKNBc=;
 b=oZ5iYNE8u7OOLIh40P0Do9juj5GLNQOb5qCYG46CqMX34KKzAWsjro505ir9CgAIBp
 +g9ZvG+rF6MRsFnbw96M3vNyjhnBgo9r1deVhPVS5NJRr5xDmBsPMjH/fUvKN7pPM776
 t3nVPoDTLhux179hRB0i5RFeviRTVzal7fKMJlF8xUkNLY4jnApic5rkcmktOzvfET0d
 rAVucSS0YyFnnfS3pY04U4w3rphDuJBnsePmmVnXL7n6AyDz44m7iqRoZw8tl/RnaZjw
 4sfJoaJ6SHXlyluuSpBpXAfDCRh6pBNbjiIgKCyayaGbPT7hdqGjz80xEkqFpG+N40E+
 f6Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768233056; x=1768837856;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7PtzNrOJiyvhnBNKea6mwGWICs3RgUoneVrPltLKNBc=;
 b=uCRdbHB+7e/PCK6pSCJHnTC/f1w+/vA6m1FL4i0tv20Z7ZEkiBkAslGgNSkzISHRib
 W7k8qDyfElpIzLDD2wM0dFDeUOU4jUKGuXtlEgZNfPcLWugyj7NXsekBnRcoAqwM+MpZ
 U9m4VTTynop8qk+wskFAfgW0ichfJLHRK95Kuio98SnDZrp39gNfoWRzX+xjbomZU/GJ
 5c1s9yKmCxDDMqGk6IXcl3mFuh8gXOdNqUImXJZnBa7kR4evSj5yeLcWfSfzRl4R0fJl
 zNAgCzLnv1BdrwgWx0KjFZz2hd3o8s6NwyvpWBpwr4TFxWOV4BPQgRZ2aflzOTSGrreM
 YR9A==
X-Gm-Message-State: AOJu0YyZIi8hjTTSsuMZN+9lfTVGd9skRDdr60WPJ5Gk1SSo98MN8aXd
 To3kTrg5nP2Uli8nhjiHmRp5hS3/IsKcCEy9FYTKlgvHAbWctOIEXssbDkIVJOD6RUAEvbYJw/m
 T2RUmkF63nhvEF77BruQ7HBYwgzpn5D8jbUp+XOqGh62fHZ86wXD4+4m2
X-Gm-Gg: AY/fxX7sho4f6zDgQ1GTnX3cvdWDdRnpjRK8obd9nY7P12of7FFhaL5Q2OOahMymtCO
 nkCxen9HK3fL+csPrCShB6kxQSw+GTWOuhtGcQMdZq/GHcYnvxdFD3d4tm4fQ6CHYlCvp9en7Qk
 XvCA7xi4cuWXZtV+pHXLi+urfNO3ZBCDerLbEL4eOPo5w0+Omveg49ZXeJly3uB+AaYrZUmsAIx
 yGry9YlnAWW3WI4VvDfwrSclwVjULF5ni8V4SP+2qGFlXZNUcIaHRaaiWJv/3APz2yAXI4gjvwv
 d76MhdI/PGBbGO2KXVYaWRq5zrg54EtTyR9EqyxwDP7ng0wxLzFzeymbjNmT5SbKvuf8qax3nEN
 j2RM=
X-Received: by 2002:a05:6102:604b:b0:5ed:679:d9ce with SMTP id
 ada2fe7eead31-5ed0679dea8mr5424494137.9.1768233055998; 
 Mon, 12 Jan 2026 07:50:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE6XfsMJDRq4jeKtognWmqLL48XbNFdxd1m54xAX2hAreyBYwAVMjM1te125ZTsBkcyfP5hxA==
X-Received: by 2002:a05:6102:604b:b0:5ed:679:d9ce with SMTP id
 ada2fe7eead31-5ed0679dea8mr5424474137.9.1768233055456; 
 Mon, 12 Jan 2026 07:50:55 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-944122ad97esm16622732241.3.2026.01.12.07.50.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Jan 2026 07:50:55 -0800 (PST)
Date: Mon, 12 Jan 2026 10:50:46 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Li Zhijian <lizhijian@fujitsu.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>, Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Zhang Chen <zhangckid@gmail.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Prasad Pandit <ppandit@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Yury Kotov <yury-kotov@yandex-team.ru>, Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH 08/13] migration: Thread-ify precopy vmstate load process
Message-ID: <aWUYVvFVbhXCdVod@x1.local>
References: <20251022192612.2737648-1-peterx@redhat.com>
 <20251022192612.2737648-9-peterx@redhat.com>
 <87y0m7df46.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87y0m7df46.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Jan 08, 2026 at 05:27:37PM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > Migration module was there for 10+ years.  Initially, it was in most cases
> > based on coroutines.  As more features were added into the framework, like
> > postcopy, multifd, etc.. it became a mixture of threads and coroutines.
> >
> > I'm guessing coroutines just can't fix all issues that migration want to
> > resolve.
> >
> > After all these years, migration is now heavily based on a threaded model.
> >
> > Now there's still a major part of migration framework that is still not
> > thread-based, which is precopy load.  We do load in a separate thread in
> > postcopy since the 1st day postcopy was introduced, however that requires a
> > separate state transition from precopy loading all devices first, which
> > still happens in the main thread of a coroutine.
> >
> > This patch tries to move the migration incoming side to be run inside a
> > separate thread (mig/dst/main) just like the src (mig/src/main).  The
> > entrance to be migration_incoming_thread().
> >
> > Quite a few things are needed to make it fly..  One note here is we need to
> > change all these things in one patch to not break anything.  The other way
> > to do this is add code to make all paths (that this patch touched) be ready
> > for either coroutine or thread.  That may cause confusions in another way.
> > So reviewers, please take my sincere apology on the hardness of reviewing
> > this patch: it covers a few modules at the same time, and with some risky
> > changes.
> >
> > BQL Analysis
> > ============
> >
> > Firstly, when moving it over to the thread, it means the thread cannot take
> > BQL during the whole process of loading anymore, because otherwise it can
> > block main thread from using the BQL for all kinds of other concurrent
> > tasks (for example, processing QMP / HMP commands).
> >
> > Here the first question to ask is: what needs BQL during precopy load, and
> > what doesn't?
> >
> 
> I just noticed that the BQL held at process_incoming_migration_co is
> also responsible for stopping qmp_migrate_set_capabilities from being
> dispatched.

I don't know if it is by design, or even if it will be guaranteed to work..

Consider the migration incoming rocoutine runs into qemu_get_byte(), and
then proactively yield the migration coroutine (qemu_coroutine_yield())
when the incoming port is blocked on read..

AFAIU, a proper fix for that (note, this will currently break tests) is:

bool migration_is_running(void)
 {
-    MigrationState *s = current_migration;
+    MigrationStatus state;
 
-    if (!s) {
-        return false;
+    if (runstate_check(RUN_STATE_INMIGRATE)) {
+        MigrationIncomingState *mis = migration_incoming_get_current();
+
+        if (!mis) {
+            return false;
+        }
+
+        state = mis->state;
+    } else {
+        MigrationState *s = migrate_get_current();
+
+        if (!s) {
+            return false;
+        }
+
+        state = s->state;
     }
 
-    switch (s->state) {
+    switch (state) {
     case MIGRATION_STATUS_ACTIVE:
     case MIGRATION_STATUS_POSTCOPY_DEVICE:
     case MIGRATION_STATUS_POSTCOPY_ACTIVE:

> 
> Any point during incoming migration when BQL is unlocked we have a
> window where a capability could be changed. Same for parameters, for
> that matter.
> 
> To make matters worse, the -incoming cmdline will trigger
> qmp_migrate_incoming->...->migration_transport_compatible early on, but
> until the channels finally connect and process_incoming_migration_co
> starts it's possible to just change a capability in an incompatible way
> and the transport will never be validated again.

Right.  Above should fix it, but I believe it also means after "-incoming
tcp:xxx" (or anything not "defer") we should forbid changing migration caps
or params on destination.

As discussed above, that'll at least break our qtests.  But frankly
speaking I think that's the right thing to do..  I hope libvirt always
works with "defer" and never update any caps/params after QMP
migrate_incoming.

So I wonder if I should continue with above patch, and then fix our qtests.
Your work from the other "merge caps+params" might also work here,
actually, if we make sure everything will be set alone with the QMP
migrate_incoming single command.

Let me know your initial thoughts, then I'll see what I can do..

Thanks,

> 
> One example:
> 
> -- >8 --
> From 99bd88aa0a8b6d4e7c52196f25d344a2800b3d89 Mon Sep 17 00:00:00 2001
> From: Fabiano Rosas <farosas@suse.de>
> Date: Thu, 8 Jan 2026 17:21:20 -0300
> Subject: [PATCH] tmp
> 
> ---
>  tests/qtest/migration/precopy-tests.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/tests/qtest/migration/precopy-tests.c b/tests/qtest/migration/precopy-tests.c
> index aca7ed51ef..3f1a2870ee 100644
> --- a/tests/qtest/migration/precopy-tests.c
> +++ b/tests/qtest/migration/precopy-tests.c
> @@ -158,6 +158,13 @@ static int new_rdma_link(char *buffer, bool ipv6)
>      return -1;
>  }
>  
> +static void *migrate_rdma_set_caps(QTestState *from, QTestState *to)
> +{
> +    migrate_set_capability(to, "mapped-ram", true);
> +
> +    return NULL;
> +}
> +
>  static void __test_precopy_rdma_plain(MigrateCommon *args, bool ipv6)
>  {
>      char buffer[128] = {};
> @@ -185,6 +192,7 @@ static void __test_precopy_rdma_plain(MigrateCommon *args, bool ipv6)
>  
>      args->listen_uri = uri;
>      args->connect_uri = uri;
> +    args->start_hook = migrate_rdma_set_caps;
>  
>      test_precopy_common(args);
>  }
> -- 
> 2.51.0
> 

-- 
Peter Xu


