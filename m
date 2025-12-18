Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AF66D711CC
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Dec 2025 23:29:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWNQF-0007yK-LS; Thu, 18 Dec 2025 18:28:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vWNQE-0007xM-6I
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 18:28:38 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vWNQB-0001jf-S2
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 18:28:37 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id DC24A33758;
 Thu, 18 Dec 2025 23:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1766100512; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IPvBd1fzGmwHgaxxwmAr/u4fjdY5qAq7wQwUwmB3UQY=;
 b=p0+2RQaDGQMX65GRQHpXll/NaZg29CI4YF8IAQtfTE9EHdGPKuOF7mTdVE3ay8oTxnpbKH
 meIP/jTnkHoiSeYKptCBIR2FAyqa0oQpVMOCet+PGjo+cpQZqUn5GcE98WlBIL7g/wqiGZ
 ygIIXdwaAf2igm8V6laaQYY3b+VAOqM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1766100512;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IPvBd1fzGmwHgaxxwmAr/u4fjdY5qAq7wQwUwmB3UQY=;
 b=/ubdYVpMrCA7GuqrL+pfudSZaiguWWK6fqa3gCwzllJbtaoVgDv6CnRBaHM5LMAkvSf4TO
 wNDT6aFJd8wYXdCQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=NcGfw33J;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="HW/AjeRQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1766100511; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IPvBd1fzGmwHgaxxwmAr/u4fjdY5qAq7wQwUwmB3UQY=;
 b=NcGfw33JxW9PHy/fo9uVP/pZ/8zZpzN2H39d8Ilf/DxV0d8UyOTvACN27pKgco5Kh8PXIQ
 qe7G502N89qCqKhL9pyjVQagnPgo6DCIfQFcrng8ftvSkIwEywuCWUQvMBkmGOZVHatvif
 dXLaUIqg1zJErA4HObCtwrHUxwjckNY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1766100511;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IPvBd1fzGmwHgaxxwmAr/u4fjdY5qAq7wQwUwmB3UQY=;
 b=HW/AjeRQqO4NbPt+XEwcihzndMcFIfJS7eHqqZloAi1h6uC5dgB5I/owRm8z2aH4F7Zg5k
 Uhla+NSQ8Jhj5FDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5DF583EA63;
 Thu, 18 Dec 2025 23:28:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ZoYWCR+ORGlAegAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 18 Dec 2025 23:28:31 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com, Laurent
 Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 32/51] tests/qtest/migration: Adapt convergence
 routines to config
In-Reply-To: <aURtVveE88n31AN_@x1.local>
References: <20251215220041.12657-1-farosas@suse.de>
 <20251215220041.12657-33-farosas@suse.de> <aUQ5BoCrMXk2SJDC@x1.local>
 <8734571sik.fsf@suse.de> <aURtVveE88n31AN_@x1.local>
Date: Thu, 18 Dec 2025 20:28:28 -0300
Message-ID: <87wm2jz7xf.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: DC24A33758
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; RCPT_COUNT_FIVE(0.00)[6];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

> On Thu, Dec 18, 2025 at 04:47:47PM -0300, Fabiano Rosas wrote:
>> Peter Xu <peterx@redhat.com> writes:
>> 
>> > On Mon, Dec 15, 2025 at 07:00:18PM -0300, Fabiano Rosas wrote:
>> >> Adapt the convergence routines migrate_ensure_[non_]converge to set
>> >> the convergence parameters in the config dict it instead of using
>> >> migrate-set-parameters.
>> >> 
>> >> Some tests need to change the convergence parameters during the
>> >> migration. The config object method is specific to configuration prior
>> >> to starting a migration, so by design it's not suitable to effect
>> >> migration-runtime changes. The existing routines will be kept for this
>> >> purpose (renamed with 'ongoing' for clarity).
>> >> 
>> >> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> >> ---
>> >>  tests/qtest/migration/framework.c     | 10 ++++-----
>> >>  tests/qtest/migration/migration-qmp.c | 32 +++++++++++++++++++++++++--
>> >>  tests/qtest/migration/migration-qmp.h |  6 +++--
>> >>  tests/qtest/migration/misc-tests.c    |  4 ++--
>> >>  tests/qtest/migration/precopy-tests.c | 26 +++++++++-------------
>> >>  5 files changed, 52 insertions(+), 26 deletions(-)
>> >> 
>> >> diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
>> >> index fd15bd832e..df42a8a2c6 100644
>> >> --- a/tests/qtest/migration/framework.c
>> >> +++ b/tests/qtest/migration/framework.c
>> >> @@ -583,7 +583,7 @@ static int migrate_postcopy_prepare(QTestState **from_ptr,
>> >>          args->postcopy_data = args->start_hook(from, to);
>> >>      }
>> >>  
>> >> -    migrate_ensure_non_converge(from);
>> >> +    migrate_ensure_non_converge(from, args->start.config);
>> >>      migrate_prepare_for_dirty_mem(from);
>> >>      qtest_qmp_assert_success(to, "{ 'execute': 'migrate-incoming',"
>> >>                               "  'arguments': { "
>> >> @@ -872,7 +872,7 @@ int test_precopy_common(MigrateCommon *args)
>> >>      }
>> >>  
>> >>      if (args->live) {
>> >> -        migrate_ensure_non_converge(from);
>> >> +        migrate_ensure_non_converge(from, args->start.config);
>> >>          migrate_prepare_for_dirty_mem(from);
>> >>      } else {
>> >>          /*
>> >> @@ -884,7 +884,7 @@ int test_precopy_common(MigrateCommon *args)
>> >>          if (args->result == MIG_TEST_SUCCEED) {
>> >>              qtest_qmp_assert_success(from, "{ 'execute' : 'stop'}");
>> >>              wait_for_stop(from, &src_state);
>> >> -            migrate_ensure_converge(from);
>> >> +            migrate_ongoing_ensure_converge(from);
>> >>          }
>> >>      }
>> >>  
>> >> @@ -942,7 +942,7 @@ int test_precopy_common(MigrateCommon *args)
>> >>              }
>> >>              migrate_wait_for_dirty_mem(from, to);
>> >>  
>> >> -            migrate_ensure_converge(from);
>> >> +            migrate_ongoing_ensure_converge(from);
>> >>  
>> >>              /*
>> >>               * We do this first, as it has a timeout to stop us
>> >> @@ -1047,7 +1047,7 @@ void test_file_common(MigrateCommon *args, bool stop_src)
>> >>          data_hook = args->start_hook(from, to);
>> >>      }
>> >>  
>> >> -    migrate_ensure_converge(from);
>> >> +    migrate_ensure_converge(from, args->start.config);
>> >>      wait_for_serial("src_serial");
>> >>  
>> >>      if (stop_src) {
>> >> diff --git a/tests/qtest/migration/migration-qmp.c b/tests/qtest/migration/migration-qmp.c
>> >> index 5c46ceb3e6..7fe47a5793 100644
>> >> --- a/tests/qtest/migration/migration-qmp.c
>> >> +++ b/tests/qtest/migration/migration-qmp.c
>> >> @@ -499,20 +499,48 @@ void migrate_set_parameter_bool(QTestState *who, const char *parameter,
>> >>      migrate_check_parameter_bool(who, parameter, value);
>> >>  }
>> >>  
>> >> -void migrate_ensure_non_converge(QTestState *who)
>> >> +void migrate_ongoing_ensure_non_converge(QTestState *who)
>> >>  {
>> >>      /* Can't converge with 1ms downtime + 3 mbs bandwidth limit */
>> >>      migrate_set_parameter_int(who, "max-bandwidth", 3 * 1000 * 1000);
>> >>      migrate_set_parameter_int(who, "downtime-limit", 1);
>> >>  }
>> >>  
>> >> -void migrate_ensure_converge(QTestState *who)
>> >> +void migrate_ongoing_ensure_converge(QTestState *who)
>> >>  {
>> >>      /* Should converge with 30s downtime + 1 gbs bandwidth limit */
>> >>      migrate_set_parameter_int(who, "max-bandwidth", 1 * 1000 * 1000 * 1000);
>> >>      migrate_set_parameter_int(who, "downtime-limit", 30 * 1000);
>> >>  }
>> >>  
>> >> +void migrate_ensure_non_converge(QTestState *who, QDict *config)
>> >> +{
>> >> +    config = config_load(config);
>> >> +    if (config) {
>> >> +        /* Can't converge with 1ms downtime + 3 mbs bandwidth limit */
>> >> +        qdict_put_int(config, "max-bandwidth", 3 * 1000 * 1000);
>> >> +        qdict_put_int(config, "downtime-limit", 1);
>> >> +    } else {
>> >> +        assert(who);
>> >> +        migrate_ongoing_ensure_non_converge(who);
>> >> +    }
>> >> +    config_put(config);
>> >> +}
>> >> +
>> >> +void migrate_ensure_converge(QTestState *who, QDict *config)
>> >> +{
>> >> +    config = config_load(config);
>> >> +    /* Should converge with 30s downtime + 1 gbs bandwidth limit */
>> >> +    if (config) {
>> >> +        qdict_put_int(config, "max-bandwidth", 1 * 1000 * 1000 * 1000);
>> >> +        qdict_put_int(config, "downtime-limit", 30 * 1000);
>> >> +    } else {
>> >> +        assert(who);
>> >> +        migrate_ongoing_ensure_converge(who);
>> >> +    }
>> >> +    config_put(config);
>> >> +}
>> >
>> > It's slightly an overkill to me to have these converge helpers to provide
>> > two versions.  Also a bit confusing on when should we use which.
>> >
>> > After all, parameters touched on convergence must be able to be dynamically
>> > set..
>> >
>> > Can we always stick with the QMP set-parameters for all these?
>> >
>> 
>> Well, QEMU ignores anything set with migrate-set-parameters once it sees
>> the config, so we'd need to change that in the code.
>> 
>> Thinking about the design of "config", I think the point was to never
>> configure a migration via migrate-set-parameters. Always pass the config
>> to the migration commands.
>> 
>> These options are special in that they make sense both before and after
>> starting the migration, so it's indeed confusing. I don't know what the
>> best approach is.
>
> Hmm, now I start to question whether this is a good idea.  That's about
> this patch of the series:
>
>     migration: Allow migrate commands to provide the migration config
>     
>     Allow the migrate and migrate_incoming commands to pass the migration
>     configuration options all at once, dispensing the use of
>     migrate-set-parameters and migrate-set-capabilities.
>     
>     The motivation of this is to simplify the interface with the
>     management layer and avoid the usage of several command invocations to
>     configure a migration. It also avoids stale parameters from a previous
>     migration to influence the current migration.
>
> Logically speaking, if mgmt worries about a stale parameter leftover, the
> mgmt should always overwrite it in the config of this QMP migrate command..
> Now I don't see a real benefit that we need to ignore global setups.
>
> A mgmt should simply query all parameters when QEMU just started up, then
> keep it, then whatever user changes should be applied on top,  Then when
> any QMP migrate happens, it should always set all parameters.. no matter
> what is the global.
>

We can decide that QEMU will not force the mgmt app to do that work and
will provide an API that doesn't require setting all parameters. I don't
see an argument here.

> The problem is exactly here, that when some parameters can be dynamically
> changed like max-bw, if it was set and throttled 10Gbps dynamically,
> migration failed, someone re-started the migration expecting the 10Gbps was
> still applied when QMP migrate didn't set max-bw this time, but it didn't
> work like that.
>

We need to think about what the QMP API exposes.

If we expose an API that says: QMP_MIGRATE might use a value that was
set using MIGRATE-SET-PARAMETERS 6 months ago because QEMU uses global
state, that's an API usability issue.

If we expose an API that says: QMP_MIGRATE runs the migration with
whatever arguments were passed to it via CONFIG, that sounds like
something sensible.

I don't think the API consumers would be surprised if we allow
MIGRATE-SET-PARAMETERS to change runtime values for a migration and on
the next migration that value is no longer the same.

> Do you think we should make "config" of migrate / migrate_incoming taking
> global setting as base, rather than initial_params?  I hope we don't
> introduce something for nobody at last, but only to make our lives slightly
> harder. :(

One calls a function and it uses the arguments passed to it, that's
it. New migration, new arguments. As you said, mgmt could just hold the
dynamic parameter that their user changed and pass that along with the
config for the new migration.

But I don't think we fleshed out the usage regarding the dynamic
parameters yet. There might be other issues that I'm overlooking. Maybe
we'd need a whole new command with slightly different semantics from
migrate-set-parameters that adjusts the dynamic options while migration
is running, I'm not sure.

---
side note:

If you think the whole endevour of passing a config to qmp_migrate
is a bad idea, please speak up. If mgmt code will require the amount of
churn I had to do for our test suite, maybe it's not worth the effort
after all.

My opinion is that, in general, the "config" changes are going in a good
direction. I worry slightly about what the cost would be for the users
to adhere to it. Migration has been quirky for a looong time, you make
it less quirky people will find it strange =)

