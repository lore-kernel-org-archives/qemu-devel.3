Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C6FCC02192
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 22:58:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tf5NR-0001OQ-QU; Mon, 03 Feb 2025 17:57:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tf5NO-0001Nt-Ji
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 17:57:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tf5NM-0007L6-7n
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 17:57:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738623425;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GEix8W0l9ekm3sOVXpNkgQGL38PsmdqmlRM6Sw7SQBo=;
 b=Tj7ALBiwS6eWi9GIPLynWlHwdHiPNFk3DcV35M4rz3bg3edbgvxsMborXDxJsFb7sY61hw
 SRPav7AWne0jM+eSN1dBRNQTerzXI+fKhAtj10S9Hg9qwXt7b/stVleV/hEXk62nCnYtbG
 OlAStfz9c7FHExZ8N0iadd9+y+8Kveg=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-41-DNurZENXPq-ar4PQOi_d9w-1; Mon, 03 Feb 2025 17:57:04 -0500
X-MC-Unique: DNurZENXPq-ar4PQOi_d9w-1
X-Mimecast-MFC-AGG-ID: DNurZENXPq-ar4PQOi_d9w
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7b6eabd51cfso795531785a.0
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2025 14:57:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738623420; x=1739228220;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GEix8W0l9ekm3sOVXpNkgQGL38PsmdqmlRM6Sw7SQBo=;
 b=A7I74Znt/WU7bUH0p4psK+9woTXROtGbhLAQ2WT3wvcSO6ByFvHoQSOhPOmCgefP7D
 iiPaj0ANiuZsc2tRIZVIUOxnOh7SRvOPs69DKkMuWQfcEcALBKnIxcD8pAfWttJysRnY
 rFO7g4Dr8d6mm2Hp6SRjMYq0CkdN7x0vTLuXJSoEzBD9WbOON2zfy/mwf8Ywv+fqYL/0
 HQbCq4tzqJPOWO/xnmyUgKrUJGnS5ktJyZHt47P2QR9JjD/glfD9+FukwORISQInZbj/
 ZTV7WeygdW70I3X1ZF+I5URvoLtyRhNyIOVQleIlRdmFZwuB2M8/RMChjSE8W/MHlUlh
 AqPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXiklI5C6+0aHZQBIAIqe4o/thVqHhH/NfjIMsbd21I12B2Z6noGBOi8/F/Z6W7DKxzIkqSj//oSjki@nongnu.org
X-Gm-Message-State: AOJu0Yxt7tavcRyx67PX9UvXAScU5YYTW7iCT3XEAYnM9SV8Fr81/Puo
 5DjDl94NKG9vTNcF+7nGwGbAaL52n9xK0yrCp+bdaEC0R/KsDFIzzfBYq/R7CuktSBeMoh/10V6
 iTvOStIeeibAK5b5WBNo4p1D98wdpQEdEoYAOCoXOOkdu8xZvOgNP
X-Gm-Gg: ASbGnct6d/dBS8Sb53FSZv8jK5hNgPYceGAxYHlXb72YLPrpnONlwZUo7aMXLq3qSbG
 YFz0CV8bU/kogOizWvZyuKEqDgcZ/hzZAbqQ7CLiVMQhyixKt3KZaj1voAL70u9KW+C3efV4w7S
 Ya9L8nQkFhseO5OdH+4GtvD93sp5+4JF/jkfgx6EKUOQCm435RRZGGXDWsmThbcLLIQt50Qchge
 6eDXkCHy5PKVSRr5S0RmJYQO3Y5prCwzvraEUC0ppkIDcCt0oOf+xSy4rI3IKmD21t5V5jTTpZ6
 AF1sc5QQhBAklec9Bb/GJqLRiy19X28iaIIZTey0kJRZppwy
X-Received: by 2002:a05:620a:8f07:b0:7bf:ff64:3378 with SMTP id
 af79cd13be357-7bfff64362dmr2921494885a.53.1738623419683; 
 Mon, 03 Feb 2025 14:56:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG/yePBusNBMRHUpGy+GVA+GggLcDyIMmgfXMCTTbeOH+cmD0usuaoQubd3TNU3KwUyUpuuLA==
X-Received: by 2002:a05:620a:8f07:b0:7bf:ff64:3378 with SMTP id
 af79cd13be357-7bfff64362dmr2921492185a.53.1738623419289; 
 Mon, 03 Feb 2025 14:56:59 -0800 (PST)
Received: from x1.local (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c00a90d0casm575830785a.101.2025.02.03.14.56.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2025 14:56:58 -0800 (PST)
Date: Mon, 3 Feb 2025 17:56:56 -0500
From: Peter Xu <peterx@redhat.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v4 08/33] migration/multifd: Allow premature EOF on TLS
 incoming channels
Message-ID: <Z6FJuK2FVKhI0C2j@x1.local>
References: <cover.1738171076.git.maciej.szmigiero@oracle.com>
 <baf944c37ead5d30d7e268b2a4074d9acaac2db0.1738171076.git.maciej.szmigiero@oracle.com>
 <Z6EI0V6Cg7aCbzQU@x1.local>
 <67a7c2ce-2391-4b8e-a5be-bce370fd2e66@maciej.szmigiero.name>
 <Z6ElIlavWHda8YcH@x1.local>
 <6b9b4c31-6598-4fd9-9ae2-dbef4cdd7089@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6b9b4c31-6598-4fd9-9ae2-dbef4cdd7089@maciej.szmigiero.name>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Feb 03, 2025 at 10:41:32PM +0100, Maciej S. Szmigiero wrote:
> On 3.02.2025 21:20, Peter Xu wrote:
> > On Mon, Feb 03, 2025 at 07:53:00PM +0100, Maciej S. Szmigiero wrote:
> > > On 3.02.2025 19:20, Peter Xu wrote:
> > > > On Thu, Jan 30, 2025 at 11:08:29AM +0100, Maciej S. Szmigiero wrote:
> > > > > From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
> > > > > 
> > > > > Multifd send channels are terminated by calling
> > > > > qio_channel_shutdown(QIO_CHANNEL_SHUTDOWN_BOTH) in
> > > > > multifd_send_terminate_threads(), which in the TLS case essentially
> > > > > calls shutdown(SHUT_RDWR) on the underlying raw socket.
> > > > > 
> > > > > Unfortunately, this does not terminate the TLS session properly and
> > > > > the receive side sees this as a GNUTLS_E_PREMATURE_TERMINATION error.
> > > > > 
> > > > > The only reason why this wasn't causing migration failures is because
> > > > > the current migration code apparently does not check for migration
> > > > > error being set after the end of the multifd receive process.
> > > > > 
> > > > > However, this will change soon so the multifd receive code has to be
> > > > > prepared to not return an error on such premature TLS session EOF.
> > > > > Use the newly introduced QIOChannelTLS method for that.
> > > > > 
> > > > > It's worth noting that even if the sender were to be changed to terminate
> > > > > the TLS connection properly the receive side still needs to remain
> > > > > compatible with older QEMU bit stream which does not do this.
> > > > 
> > > > If this is an existing bug, we could add a Fixes.
> > > 
> > > It is an existing issue but only uncovered by this patch set.
> > > 
> > > As far as I can see it was always there, so it would need some
> > > thought where to point that Fixes tag.
> > 
> > If there's no way to trigger a real functional bug anyway, it's also ok we
> > omit the Fixes.
> > 
> > > > Two pure questions..
> > > > 
> > > >     - What is the correct way to terminate the TLS session without this flag?
> > > 
> > > I guess one would need to call gnutls_bye() like in this GnuTLS example:
> > > https://gitlab.com/gnutls/gnutls/-/blob/2b8c3e4c71ad380bbbffb32e6003b34ecad596e3/doc/examples/ex-client-anon.c#L102
> > > 
> > > >     - Why this is only needed by multifd sessions?
> > > 
> > > What uncovered the issue was switching the load threads to using
> > > migrate_set_error() instead of their own result variable
> > > (load_threads_ret) which you had requested during the previous
> > > patch set version review:
> > > https://lore.kernel.org/qemu-devel/Z1DbH5fwBaxtgrvH@x1n/
> > > 
> > > Turns out that the multifd receive code always returned
> > > error in the TLS case, just nothing was previously checking for
> > > that error presence.
> > 
> > What I was curious is whether this issue also exists for the main migration
> > channel when with tls, especially when e.g. multifd not enabled at all.  As
> > I don't see anywhere that qemu uses gnutls_bye() for any tls session.
> > 
> > I think it's a good to find that we overlooked this before.. and IMHO it's
> > always good we could fix this.
> > 
> > Does it mean we need proper gnutls_bye() somewhere?
> > 
> > If we need an explicit gnutls_bye(), then I wonder if that should be done
> > on the main channel as well.
> 
> That's a good question and looking at the code qemu_loadvm_state_main() exits
> on receiving "QEMU_VM_EOF" section (that's different from receiving socket EOF)
> and then optionally "QEMU_VM_VMDESCRIPTION" section is read with explicit size
> in qemu_loadvm_state() - so still not until channel EOF.

I had a closer look, I do feel like such pre-mature termination is caused
by explicit shutdown()s of the iochannels, looks like that can cause issue
even after everything is sent.  Then I noticed indeed multifd sender
iochannels will get explicit shutdown()s since commit 077fbb5942, while we
don't do that for the main channel.  Maybe that is a major difference.

Now I wonder whether we should shutdown() the channel at all if migration
succeeded, because looks like it can cause tls session to interrupt even if
the shutdown() is done after sent everything, and if so it'll explain why
you hit the issue with tls.

> 
> Then I can't see anything else reading the channel until it is closed in
> migration_incoming_state_destroy().
> 
> So most likely the main migration channel will never read far enough to
> reach that GNUTLS_E_PREMATURE_TERMINATION error.
> 
> > If we don't need gnutls_bye(), then should we always ignore pre-mature
> > termination of tls no matter if it's multifd or non-multifd channel (or
> > even a tls session that is not migration-related)?
> 
> So basically have this patch extended to calling
> qio_channel_tls_set_premature_eof_okay() also on the main migration channel?

If above theory can stand, then eof-okay could be a workaround papering
over the real problem that we shouldn't always shutdown()..

Could you have a look at below patch and see whether it can fix the problem
you hit too, in replace of these two patches (including the previous
iochannel change)?

Thanks,

===8<===
From 3147084174b0e0bda076ad205ae139f8fc433892 Mon Sep 17 00:00:00 2001
From: Peter Xu <peterx@redhat.com>
Date: Mon, 3 Feb 2025 17:27:45 -0500
Subject: [PATCH] migration: Avoid shutdown multifd channels if migration
 succeeded
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Multifd channels behave differently from the main channel when shutting
down: the sender side will always shutdown() on the multifd iochannels, no
matter whether migration succeeded or not.  QEMU doesn't do that on src.

Such behavior was introduced in commit 077fbb5942 ("multifd: Shut down the
QIO channels to avoid blocking the send threads when they are terminated.")
to fix a hang issue when multifd enabled.

This might be problematic though, especially in TLS context, because it
looks like such shutdown() on src (even if succeeded) could cause
destination multifd iochannels to receive pre-mature terminations of TLS
sessions.

It's debatable whether such shutdown() should be explicitly done even for a
succeeded migration.  This patch moves the shutdown() instead from
finalization phase into qmp_migrate_cancel(), so that we only do the
shutdown() when cancels, and we should avoid such when it succeeds.

When at it, keep all the shutdown() code together, moving the return path
shutdown() (which seems a bit redundant, but no harm to do) to where the
rest channels are shutdown.

Cc: Li Zhang <lizhang@suse.de>
Cc: Dr. David Alan Gilbert <dave@treblig.org>
Cc: Daniel P. Berrangé <berrange@redhat.com>
Reported-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/multifd.h   |  1 +
 migration/migration.c | 24 +++++++++++++++++-------
 migration/multifd.c   | 14 +++++++++++---
 3 files changed, 29 insertions(+), 10 deletions(-)

diff --git a/migration/multifd.h b/migration/multifd.h
index bd785b9873..26ef94ac93 100644
--- a/migration/multifd.h
+++ b/migration/multifd.h
@@ -340,6 +340,7 @@ static inline void multifd_send_prepare_header(MultiFDSendParams *p)
 
 void multifd_channel_connect(MultiFDSendParams *p, QIOChannel *ioc);
 bool multifd_send(MultiFDSendData **send_data);
+void multifd_send_shutdown_iochannels(void);
 MultiFDSendData *multifd_send_data_alloc(void);
 
 static inline uint32_t multifd_ram_page_size(void)
diff --git a/migration/migration.c b/migration/migration.c
index 74c50cc72c..e43f8222dc 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1565,13 +1565,6 @@ static void migrate_fd_cancel(MigrationState *s)
 
     trace_migrate_fd_cancel();
 
-    WITH_QEMU_LOCK_GUARD(&s->qemu_file_lock) {
-        if (s->rp_state.from_dst_file) {
-            /* shutdown the rp socket, so causing the rp thread to shutdown */
-            qemu_file_shutdown(s->rp_state.from_dst_file);
-        }
-    }
-
     do {
         old_state = s->state;
         if (!migration_is_running()) {
@@ -1594,6 +1587,23 @@ static void migrate_fd_cancel(MigrationState *s)
             if (s->to_dst_file) {
                 qemu_file_shutdown(s->to_dst_file);
             }
+            /*
+             * Above should work already, because the iochannel is shared
+             * between outgoing and return path qemufiles, however just to
+             * be on the safe side to set qemufile error on return path too
+             * if existed.
+             */
+            if (s->rp_state.from_dst_file) {
+                qemu_file_shutdown(s->rp_state.from_dst_file);
+            }
+        }
+
+        /*
+         * We need to shutdown multifd channels too if they are available,
+         * to make sure no multifd send threads will be stuck at syscalls.
+         */
+        if (migrate_multifd()) {
+            multifd_send_shutdown_iochannels();
         }
     }
 
diff --git a/migration/multifd.c b/migration/multifd.c
index ab73d6d984..96bcbb1e0c 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -384,6 +384,17 @@ static void multifd_send_set_error(Error *err)
     }
 }
 
+void multifd_send_shutdown_iochannels(void)
+{
+    QIOChannel *c;
+    int i;
+
+    for (i = 0; i < migrate_multifd_channels(); i++) {
+        c = multifd_send_state->params[i].c;
+        qio_channel_shutdown(c, QIO_CHANNEL_SHUTDOWN_BOTH, NULL);
+    }
+}
+
 static void multifd_send_terminate_threads(void)
 {
     int i;
@@ -404,9 +415,6 @@ static void multifd_send_terminate_threads(void)
         MultiFDSendParams *p = &multifd_send_state->params[i];
 
         qemu_sem_post(&p->sem);
-        if (p->c) {
-            qio_channel_shutdown(p->c, QIO_CHANNEL_SHUTDOWN_BOTH, NULL);
-        }
     }
 
     /*
-- 
2.47.0


-- 
Peter Xu


