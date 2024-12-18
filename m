Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 683D9E77187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 18:17:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNyb8-0001kt-Vf; Wed, 18 Dec 2024 13:16:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tNya7-0001Bb-Qa
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 13:15:39 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tNya3-0007Wh-7G
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 13:15:33 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A9D7C1F396;
 Wed, 18 Dec 2024 18:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1734545724; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Fr4PCJWf1z/7qkA7bpPemTrE0aKfLWoErXYMz9di20A=;
 b=Xpm4TfGSaF7ptGoi32chqmwwCbi4AjW7e8y4xqY6ddCCcVvyMikZf2JQ4ez6GW9wogCFke
 YJKYxXWtFOUkcmtqJcSF3p/hDOWrGm4Se+8q+AKzZ5FjRS+cfoAU0kduOdaWUboPx4tgy8
 /QQya1Bf3TZ6jvY8X33M1ATze8klfhI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1734545724;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Fr4PCJWf1z/7qkA7bpPemTrE0aKfLWoErXYMz9di20A=;
 b=WOPBcAKc5/BwU7O93XxqLiDK+qTsDglJpxVNmBcXe5DjVnjJP2aO6UcgjnuxUx6sy8DSIw
 K74IsqbMKzJc0MCA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Xpm4TfGS;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=WOPBcAKc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1734545724; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Fr4PCJWf1z/7qkA7bpPemTrE0aKfLWoErXYMz9di20A=;
 b=Xpm4TfGSaF7ptGoi32chqmwwCbi4AjW7e8y4xqY6ddCCcVvyMikZf2JQ4ez6GW9wogCFke
 YJKYxXWtFOUkcmtqJcSF3p/hDOWrGm4Se+8q+AKzZ5FjRS+cfoAU0kduOdaWUboPx4tgy8
 /QQya1Bf3TZ6jvY8X33M1ATze8klfhI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1734545724;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Fr4PCJWf1z/7qkA7bpPemTrE0aKfLWoErXYMz9di20A=;
 b=WOPBcAKc5/BwU7O93XxqLiDK+qTsDglJpxVNmBcXe5DjVnjJP2aO6UcgjnuxUx6sy8DSIw
 K74IsqbMKzJc0MCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CC5D4137CF;
 Wed, 18 Dec 2024 18:15:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id SQDIIzsRY2fWaQAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 18 Dec 2024 18:15:23 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?utf-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, Alex
 =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 19/22] tests/qtest/migration: Add migration-test-smoke
In-Reply-To: <Z2MKesakYn3fn2ue@x1n>
References: <20241113194630.3385-1-farosas@suse.de>
 <20241113194630.3385-20-farosas@suse.de> <Z2MKesakYn3fn2ue@x1n>
Date: Wed, 18 Dec 2024 15:13:08 -0300
Message-ID: <87h670vozv.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: A9D7C1F396
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; RCPT_COUNT_SEVEN(0.00)[7];
 MIME_TRACE(0.00)[0:+]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

> On Wed, Nov 13, 2024 at 04:46:27PM -0300, Fabiano Rosas wrote:
>> diff --git a/tests/qtest/migration-test-smoke.c b/tests/qtest/migration-test-smoke.c
>> new file mode 100644
>> index 0000000000..ff2d72881f
>> --- /dev/null
>> +++ b/tests/qtest/migration-test-smoke.c
>> @@ -0,0 +1,39 @@
>> +/* SPDX-License-Identifier: GPL-2.0-or-later */
>> +
>> +#include "qemu/osdep.h"
>> +#include "libqtest.h"
>> +#include "migration/test-framework.h"
>> +#include "qemu/module.h"
>> +
>> +int main(int argc, char **argv)
>> +{
>> +    MigrationTestEnv *env;
>> +    int ret;
>> +
>> +    g_test_init(&argc, &argv, NULL);
>> +    env = migration_get_env();
>> +    module_call_init(MODULE_INIT_QOM);
>> +
>> +    if (env->has_kvm) {
>> +        g_test_message(
>> +            "Smoke tests already run as part of the full suite on KVM hosts");
>> +        goto out;
>> +    }
>
> So the "smoke" here is almost "tcg".. and if i want to run a smoke test on
> a kvm-enabled host, it's noop.. which isn't easy to understand why.
>
> If to rethink our goal, we have two requirements:
>
>   (1) We want to categorize migration tests, so some are quick, some are
>       slow, some might be flacky.  Maybe more, but it's about putting one
>       test into only one bucket, and there're >1 buckets.

It's true that the smoke test should never have slow or flaky tests, but
we can't use this categorization for anything else. IOW, what you
describe here is not a goal. If a test is found to be slow we put it
under slow and it will only run with -m slow/thorough, that's it. We can
just ignore this.

>
>   (2) We want to run only a small portion of tests on tcg, more tests on
>       kvm.

Yes. Guests are fast with KVM and slow with TCG (generally) and the KVM
hosts are the ones where it's actually important to ensure all migration
features work OK. Non-KVM will only care about save/restore of
snapshots. Therefore we don't need to have all tests running with TCG,
only the smoke set.

And "smoke set" is arbitrary, not tied to speed, but of course no slow
tests please (which already happens because we don't pass -m slow to
migration-test-smoke).

>
> Ideally, we don't need two separate main test files, do we?
>
> I mean, we can do (1) with the existing migration-test.c, with the help of
> either gtest's "-m" or something we invent.  The only unfortunate part is
> qtest only have quick/slow, afaiu the "thorough" mode is the same as
> "slow".. while we don't yet have real "perf" tests.  It means we only have
> two buckets if we want to reuse gtest's "-m".
>
> Maybe it's enough?  If not, we can implement >2 categories in whatever
> form, either custom argv/argc cmdline, or env variable.
>
> Then, if we always categorize one test (let me try to not reuse glib's
> terms to be clear) into any of: FAST|NORMAL|SLOW|..., then we have a single

It's either normal or slow. Because we only know a test is only after it
bothers us.

> migration-test that have different level of tests.  We can invoke
> "migration-test --mode FAST" if kvm is not supported, and invoke the same
> "migration-test --mode SLOW" if kvm is supported.

This is messy due to how qtest/meson.build works. Having two tests is
the clean change. Otherwise we'll have to add "if migration-test" or
create artificial test names to be able to restrict the arguments that
are passed to the test per arch.

I also *think* we cannot have anything extra in argv because gtester
expects to be able to parse those.

>
> Would this be nicer?  At least we can still run a pretty fast smoke / FAST
> test even on kvm. Basically, untangle accel v.s. "test category".

We could just remove the restriction from migration-test-smoke if that's
an issue.

