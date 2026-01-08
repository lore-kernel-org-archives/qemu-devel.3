Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4976D1D493
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 20:28:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdwbj-0000cL-HP; Thu, 08 Jan 2026 15:27:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vdwbh-0000X8-Rw
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 15:27:45 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vdwbf-0004v3-W9
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 15:27:45 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E413634567;
 Thu,  8 Jan 2026 20:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1767904061; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PZFXne9Uo/30v0glti/DB7GOOHyo5QUtF0aKbQ+/AME=;
 b=bz361fnhch4OKHQMJgHw8Mh3S+Dz9+6tcOxyI0ADwnjml8dOznPcpD59YQO5smsvIHYO41
 uTIIAu4BU4OSmwF8KtcQMYvCwRkSPD6VrLnlrSrwb1uiE5EKgrwYztHqWsCqcwmMZX330L
 LdnNDIeCEEShH+HiqTKJEkUeDEyeG0g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1767904061;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PZFXne9Uo/30v0glti/DB7GOOHyo5QUtF0aKbQ+/AME=;
 b=9sNVP+uQ7sEfdNSiEEU1YNh4WIEho3jLjewAgJOdLUbywTrQWNttZdgEGrvJWfh34dGHuX
 xNOPrngwzhKc2aCw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=D71dqzp1;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="MW/Ag3Eq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1767904060; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PZFXne9Uo/30v0glti/DB7GOOHyo5QUtF0aKbQ+/AME=;
 b=D71dqzp1Y08tTC0jeruZoxrr8DLpnK3liw0mdPcZUkB0IFi9aPcIInE/X7emN+RGqwGhlP
 Ib43dl38pjEVtOyBNH3ALZxfF6qSWRTVWEe+0sVB7GloMGU2dv5IJaqFtXam8DV2G3org8
 t/kys+d8BYa86vRogL8E7OlTqV6wBfI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1767904060;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PZFXne9Uo/30v0glti/DB7GOOHyo5QUtF0aKbQ+/AME=;
 b=MW/Ag3EqcYAvecwewmOSqgWm+doc5vgu+K7mjdvo3n78grHT615C+iJ5ZP+5raKEZcJ/BR
 2F00P6xqKslFm9CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 55EDC3EA63;
 Thu,  8 Jan 2026 20:27:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id bC3tBTwTYGmUIwAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 08 Jan 2026 20:27:40 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Li Zhijian <lizhijian@fujitsu.com>, Hailiang Zhang
 <zhanghailiang@xfusion.com>, Kevin Wolf <kwolf@redhat.com>, Vladimir
 Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, peterx@redhat.com,
 =?utf-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, Zhang Chen
 <zhangckid@gmail.com>, "Dr . David Alan Gilbert" <dave@treblig.org>,
 Prasad Pandit <ppandit@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Yury Kotov <yury-kotov@yandex-team.ru>, Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH 08/13] migration: Thread-ify precopy vmstate load process
In-Reply-To: <20251022192612.2737648-9-peterx@redhat.com>
References: <20251022192612.2737648-1-peterx@redhat.com>
 <20251022192612.2737648-9-peterx@redhat.com>
Date: Thu, 08 Jan 2026 17:27:37 -0300
Message-ID: <87y0m7df46.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCPT_COUNT_TWELVE(0.00)[14]; MIME_TRACE(0.00)[0:+];
 FREEMAIL_CC(0.00)[fujitsu.com,xfusion.com,redhat.com,yandex-team.ru,gmail.com,treblig.org];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MID_RHS_MATCH_FROM(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim, suse.de:mid, suse.de:email,
 imap1.dmz-prg2.suse.org:rdns, imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: E413634567
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Peter Xu <peterx@redhat.com> writes:

> Migration module was there for 10+ years.  Initially, it was in most cases
> based on coroutines.  As more features were added into the framework, like
> postcopy, multifd, etc.. it became a mixture of threads and coroutines.
>
> I'm guessing coroutines just can't fix all issues that migration want to
> resolve.
>
> After all these years, migration is now heavily based on a threaded model.
>
> Now there's still a major part of migration framework that is still not
> thread-based, which is precopy load.  We do load in a separate thread in
> postcopy since the 1st day postcopy was introduced, however that requires a
> separate state transition from precopy loading all devices first, which
> still happens in the main thread of a coroutine.
>
> This patch tries to move the migration incoming side to be run inside a
> separate thread (mig/dst/main) just like the src (mig/src/main).  The
> entrance to be migration_incoming_thread().
>
> Quite a few things are needed to make it fly..  One note here is we need to
> change all these things in one patch to not break anything.  The other way
> to do this is add code to make all paths (that this patch touched) be ready
> for either coroutine or thread.  That may cause confusions in another way.
> So reviewers, please take my sincere apology on the hardness of reviewing
> this patch: it covers a few modules at the same time, and with some risky
> changes.
>
> BQL Analysis
> ============
>
> Firstly, when moving it over to the thread, it means the thread cannot take
> BQL during the whole process of loading anymore, because otherwise it can
> block main thread from using the BQL for all kinds of other concurrent
> tasks (for example, processing QMP / HMP commands).
>
> Here the first question to ask is: what needs BQL during precopy load, and
> what doesn't?
>

I just noticed that the BQL held at process_incoming_migration_co is
also responsible for stopping qmp_migrate_set_capabilities from being
dispatched.

Any point during incoming migration when BQL is unlocked we have a
window where a capability could be changed. Same for parameters, for
that matter.

To make matters worse, the -incoming cmdline will trigger
qmp_migrate_incoming->...->migration_transport_compatible early on, but
until the channels finally connect and process_incoming_migration_co
starts it's possible to just change a capability in an incompatible way
and the transport will never be validated again.

One example:

-- >8 --
From 99bd88aa0a8b6d4e7c52196f25d344a2800b3d89 Mon Sep 17 00:00:00 2001
From: Fabiano Rosas <farosas@suse.de>
Date: Thu, 8 Jan 2026 17:21:20 -0300
Subject: [PATCH] tmp

---
 tests/qtest/migration/precopy-tests.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tests/qtest/migration/precopy-tests.c b/tests/qtest/migration/precopy-tests.c
index aca7ed51ef..3f1a2870ee 100644
--- a/tests/qtest/migration/precopy-tests.c
+++ b/tests/qtest/migration/precopy-tests.c
@@ -158,6 +158,13 @@ static int new_rdma_link(char *buffer, bool ipv6)
     return -1;
 }
 
+static void *migrate_rdma_set_caps(QTestState *from, QTestState *to)
+{
+    migrate_set_capability(to, "mapped-ram", true);
+
+    return NULL;
+}
+
 static void __test_precopy_rdma_plain(MigrateCommon *args, bool ipv6)
 {
     char buffer[128] = {};
@@ -185,6 +192,7 @@ static void __test_precopy_rdma_plain(MigrateCommon *args, bool ipv6)
 
     args->listen_uri = uri;
     args->connect_uri = uri;
+    args->start_hook = migrate_rdma_set_caps;
 
     test_precopy_common(args);
 }
-- 
2.51.0

