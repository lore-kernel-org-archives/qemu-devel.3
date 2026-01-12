Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87423CF45C8
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 19:06:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfNEK-00030z-4i; Mon, 12 Jan 2026 14:05:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vfNDC-0002e2-2A
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 14:04:23 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vfNDA-0000Nl-09
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 14:04:21 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E72BF3368A;
 Mon, 12 Jan 2026 19:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1768244656; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/2ZXWkvbkAdoupKCgS6TrgpJw6UqPpUvNAEH/WTOPBU=;
 b=niLS45gcrusaV2o0JBeSkCo9UTqEWH/pSVZ/aoj4klXOPIks2mc5rQGDrna9oW6GCSzP0Z
 422M4FUwOsfgfxnUjaU2LQqnca/wkFqCzRoGLlUEYsto00jqQBxj1gYmTimwTTUcECs/5z
 PNKxiVYj3zvWFTJUIVdn4p5AZB1rfRM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1768244656;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/2ZXWkvbkAdoupKCgS6TrgpJw6UqPpUvNAEH/WTOPBU=;
 b=Dh4qx6F0SyTomnkE/bJL+BZjfxxf83Olq7ps1AhLxQfW/kIxF+Zk9hAbAo4uIcmOBFbxKJ
 c+Ea9UKAno5rsGBw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=niLS45gc;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Dh4qx6F0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1768244656; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/2ZXWkvbkAdoupKCgS6TrgpJw6UqPpUvNAEH/WTOPBU=;
 b=niLS45gcrusaV2o0JBeSkCo9UTqEWH/pSVZ/aoj4klXOPIks2mc5rQGDrna9oW6GCSzP0Z
 422M4FUwOsfgfxnUjaU2LQqnca/wkFqCzRoGLlUEYsto00jqQBxj1gYmTimwTTUcECs/5z
 PNKxiVYj3zvWFTJUIVdn4p5AZB1rfRM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1768244656;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/2ZXWkvbkAdoupKCgS6TrgpJw6UqPpUvNAEH/WTOPBU=;
 b=Dh4qx6F0SyTomnkE/bJL+BZjfxxf83Olq7ps1AhLxQfW/kIxF+Zk9hAbAo4uIcmOBFbxKJ
 c+Ea9UKAno5rsGBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4F21F3EA63;
 Mon, 12 Jan 2026 19:04:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id CotqBK9FZWm6cwAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 12 Jan 2026 19:04:15 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Li Zhijian <lizhijian@fujitsu.com>, Hailiang
 Zhang <zhanghailiang@xfusion.com>, Kevin Wolf <kwolf@redhat.com>, Vladimir
 Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, =?utf-8?Q?Daniel_P_=2E?=
 =?utf-8?Q?_Berrang=C3=A9?=
 <berrange@redhat.com>, Zhang Chen <zhangckid@gmail.com>, "Dr . David Alan
 Gilbert" <dave@treblig.org>, Prasad Pandit <ppandit@redhat.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Yury Kotov <yury-kotov@yandex-team.ru>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH 08/13] migration: Thread-ify precopy vmstate load process
In-Reply-To: <aWUYVvFVbhXCdVod@x1.local>
References: <20251022192612.2737648-1-peterx@redhat.com>
 <20251022192612.2737648-9-peterx@redhat.com> <87y0m7df46.fsf@suse.de>
 <aWUYVvFVbhXCdVod@x1.local>
Date: Mon, 12 Jan 2026 16:04:12 -0300
Message-ID: <871pju1wlv.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; ARC_NA(0.00)[];
 RCPT_COUNT_TWELVE(0.00)[13]; MIME_TRACE(0.00)[0:+];
 RCVD_TLS_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[nongnu.org,fujitsu.com,xfusion.com,redhat.com,yandex-team.ru,gmail.com,treblig.org];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: E72BF3368A
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Peter Xu <peterx@redhat.com> writes:

> On Thu, Jan 08, 2026 at 05:27:37PM -0300, Fabiano Rosas wrote:
>> Peter Xu <peterx@redhat.com> writes:
>> 
>> > Migration module was there for 10+ years.  Initially, it was in most cases
>> > based on coroutines.  As more features were added into the framework, like
>> > postcopy, multifd, etc.. it became a mixture of threads and coroutines.
>> >
>> > I'm guessing coroutines just can't fix all issues that migration want to
>> > resolve.
>> >
>> > After all these years, migration is now heavily based on a threaded model.
>> >
>> > Now there's still a major part of migration framework that is still not
>> > thread-based, which is precopy load.  We do load in a separate thread in
>> > postcopy since the 1st day postcopy was introduced, however that requires a
>> > separate state transition from precopy loading all devices first, which
>> > still happens in the main thread of a coroutine.
>> >
>> > This patch tries to move the migration incoming side to be run inside a
>> > separate thread (mig/dst/main) just like the src (mig/src/main).  The
>> > entrance to be migration_incoming_thread().
>> >
>> > Quite a few things are needed to make it fly..  One note here is we need to
>> > change all these things in one patch to not break anything.  The other way
>> > to do this is add code to make all paths (that this patch touched) be ready
>> > for either coroutine or thread.  That may cause confusions in another way.
>> > So reviewers, please take my sincere apology on the hardness of reviewing
>> > this patch: it covers a few modules at the same time, and with some risky
>> > changes.
>> >
>> > BQL Analysis
>> > ============
>> >
>> > Firstly, when moving it over to the thread, it means the thread cannot take
>> > BQL during the whole process of loading anymore, because otherwise it can
>> > block main thread from using the BQL for all kinds of other concurrent
>> > tasks (for example, processing QMP / HMP commands).
>> >
>> > Here the first question to ask is: what needs BQL during precopy load, and
>> > what doesn't?
>> >
>> 
>> I just noticed that the BQL held at process_incoming_migration_co is
>> also responsible for stopping qmp_migrate_set_capabilities from being
>> dispatched.
>
> I don't know if it is by design, or even if it will be guaranteed to work..
>

Regardless, we shouldn't rely on the BQL for this. The BQL should be
left as last resort for things that interact across subsystems. If
someone is issuing a migration command during a migration, the migration
code is exquisitely positioned to handle that itself.

> Consider the migration incoming rocoutine runs into qemu_get_byte(), and
> then proactively yield the migration coroutine (qemu_coroutine_yield())
> when the incoming port is blocked on read..
>
> AFAIU, a proper fix for that (note, this will currently break tests) is:
>
> bool migration_is_running(void)
>  {
> -    MigrationState *s = current_migration;
> +    MigrationStatus state;
>  
> -    if (!s) {
> -        return false;
> +    if (runstate_check(RUN_STATE_INMIGRATE)) {
> +        MigrationIncomingState *mis = migration_incoming_get_current();
> +
> +        if (!mis) {
> +            return false;
> +        }
> +
> +        state = mis->state;
> +    } else {
> +        MigrationState *s = migrate_get_current();
> +
> +        if (!s) {
> +            return false;
> +        }
> +
> +        state = s->state;
>      }
>  
> -    switch (s->state) {
> +    switch (state) {
>      case MIGRATION_STATUS_ACTIVE:
>      case MIGRATION_STATUS_POSTCOPY_DEVICE:
>      case MIGRATION_STATUS_POSTCOPY_ACTIVE:
>

LGTM

>> 
>> Any point during incoming migration when BQL is unlocked we have a
>> window where a capability could be changed. Same for parameters, for
>> that matter.
>> 
>> To make matters worse, the -incoming cmdline will trigger
>> qmp_migrate_incoming->...->migration_transport_compatible early on, but
>> until the channels finally connect and process_incoming_migration_co
>> starts it's possible to just change a capability in an incompatible way
>> and the transport will never be validated again.
>
> Right.  Above should fix it, but I believe it also means after "-incoming
> tcp:xxx" (or anything not "defer") we should forbid changing migration caps
> or params on destination.
>

Parameters are never forbidden, right? And we cannot forbid them with
is_running because some parameters are allowed to be changed while
running.

I feel we should have a more fine grained way of saying "this option
cannot be set at this moment", instead of just using the state as a
proxy. States can change, while the fact that from a certain point on,
certain options should not be touched anymore doesn't change.

Maybe a little infra like bdrv_op_is_blocked, i.e, a list of blocked
operations. It could be set in qmp_migrate and checked in
qmp_set_parameters/caps.

> As discussed above, that'll at least break our qtests.  But frankly
> speaking I think that's the right thing to do..  I hope libvirt always
> works with "defer" and never update any caps/params after QMP
> migrate_incoming.
>
> So I wonder if I should continue with above patch, and then fix our qtests.
> Your work from the other "merge caps+params" might also work here,
> actually, if we make sure everything will be set alone with the QMP
> migrate_incoming single command.
>

For incoming, yes. And this is maybe a point in favor of adding the
'config'.

For outgoing, there's still the point I mentioned above about how to
restrict _some_ options to be allowed at runtime and others not.

> Let me know your initial thoughts, then I'll see what I can do..
>

We should fix the bug, I think your patch is good for that.

Although this kind of overlaps with some things we've been discussing
with Prasad. I'd be super happy if the code magically stopped using
QAPI's MigrationStatus for internal tracking of migration state and
blocking of commands and so on.

Whatever comes first =)

---
Side note, did we ever discuss something like this?

struct MigrationState {
   <state>
   union {
     <outgoing>
     <incoming>
   }
}

there's so much stuff in these structs...

