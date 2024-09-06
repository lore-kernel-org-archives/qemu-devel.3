Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2AEDCE7B1D
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 14:42:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smaA6-0001on-1M; Fri, 06 Sep 2024 10:42:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1smaA3-0001nk-In
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 10:42:07 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1smaA1-00085B-Kp
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 10:42:07 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 43F3321ACE;
 Fri,  6 Sep 2024 14:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1725633723; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=igsyrWmp+9i+v/K0qwU7lQN3ORS3xzs2qIrYkk1Oe3w=;
 b=D09BfYDCMU5Q1Wj4hK34EkCqbaQORVuejRAzCkxL+9qMA1PZMoDb3l62NFMvjV9kHL0SFy
 4MsgW7re338o0VbtcBzMSkUkEIjywS9wwanpsz8OI27t5CZyZszK9MA/L73VnF2CraVIqu
 jaNjHuGtydva8VGGinp4L2y2REgDLos=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1725633723;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=igsyrWmp+9i+v/K0qwU7lQN3ORS3xzs2qIrYkk1Oe3w=;
 b=cJinv8O5K34SffR5vuz61Gt6kEyzZbRoMvKYgEdY/+Jk8qCDNVkqytL6mR4tUvwvuojAAf
 9Xi9XaYA6twBH9DQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1725633723; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=igsyrWmp+9i+v/K0qwU7lQN3ORS3xzs2qIrYkk1Oe3w=;
 b=D09BfYDCMU5Q1Wj4hK34EkCqbaQORVuejRAzCkxL+9qMA1PZMoDb3l62NFMvjV9kHL0SFy
 4MsgW7re338o0VbtcBzMSkUkEIjywS9wwanpsz8OI27t5CZyZszK9MA/L73VnF2CraVIqu
 jaNjHuGtydva8VGGinp4L2y2REgDLos=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1725633723;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=igsyrWmp+9i+v/K0qwU7lQN3ORS3xzs2qIrYkk1Oe3w=;
 b=cJinv8O5K34SffR5vuz61Gt6kEyzZbRoMvKYgEdY/+Jk8qCDNVkqytL6mR4tUvwvuojAAf
 9Xi9XaYA6twBH9DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BE84E136A8;
 Fri,  6 Sep 2024 14:42:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id rhVtIboU22YJOgAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 06 Sep 2024 14:42:02 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Maydell <peter.maydell@linaro.org>, =?utf-8?Q?Daniel_P=2E_Berran?=
 =?utf-8?Q?g=C3=A9?= <berrange@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Peter Xu
 <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>
Subject: Re: [RFC PATCH 0/2] qtest: Log verbosity changes
In-Reply-To: <CAFEAcA-naWfN5sLSJ3uS6VjC3HWvyaGqAk0=B_iqTYgtJOH+ow@mail.gmail.com>
References: <20240905210328.25393-1-farosas@suse.de>
 <95d9509b-d9a5-467a-860a-91bcd4baae1f@redhat.com>
 <Ztq5068xW640qeuD@redhat.com>
 <CAFEAcA-naWfN5sLSJ3uS6VjC3HWvyaGqAk0=B_iqTYgtJOH+ow@mail.gmail.com>
Date: Fri, 06 Sep 2024 11:42:00 -0300
Message-ID: <87r09wlu87.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.998]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[6]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,linaro.org:email]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Peter Maydell <peter.maydell@linaro.org> writes:

> On Fri, 6 Sept 2024 at 09:14, Daniel P. Berrang=C3=A9 <berrange@redhat.co=
m> wrote:
>>
>> On Fri, Sep 06, 2024 at 08:16:31AM +0200, Thomas Huth wrote:
>> > On 05/09/2024 23.03, Fabiano Rosas wrote:
>> > > Hi,
>> > >
>> > > This series silences QEMU stderr unless the QTEST_LOG variable is set
>> > > and silences -qtest-log unless both QTEST_LOG and gtest's --verbose
>> > > flag is passed.
>> > >
>> > > This was motivated by Peter Maydell's ask to suppress deprecation
>> > > warn_report messages from the migration-tests and by my own
>> > > frustration over noisy output from qtest.
>
> This isn't what I want, though -- what I want is that a
> qtest run should not print "warning:" messages for things
> that we expect to happen when we run that test. I *do* want
> warnings for things that we do not expect to happen when
> we run the test.
>
>> > Not sure whether we want to ignore stderr by default... we might also =
miss
>> > important warnings or error messages that way...?
>>
>> I would prefer if our tests were quiet by default, and just printed
>> clear pass/fail notices without extraneous fluff. Having an opt-in
>> to see full messages from stderr feels good enough for debugging cases
>> where you need more info from a particular test.
>
> I find it is not uncommon that something fails and
> you don't necessarily have the option to re-run it with
> the "give me the error message this time" flag turn on.
> CI is just the most obvious example; other kinds of
> intermittent failure can be similar.
>
>> Probably we should set verbose mode in CI though, since it is tedious
>> to re-run CI on failure to gather more info
>>
>> > If you just want to suppress one certain warning, I think it's maybe b=
est to
>> > fence it with "if (!qtest_enabled()) { ... }" on the QEMU side - at le=
ast
>> > that's what we did in similar cases a couple of times, IIRC.
>>
>> We're got a surprisingly large mumber of if(qtest_enabled()) conditions
>> in the code. I can't help feeling this is a bad idea in the long term,
>> as its making us take different codepaths when testing from production.
>
> What I want from CI and from tests in general:
>  * if something fails, I want all the information
>  * if something unexpected happens I want the warning even
>    if the test passes (this is why I grep the logs for
>    "warning:" in the first place -- it is to catch the case
>    of "something went wrong but it didn't result in QEMU or
>    the test case exiting with a failure status")
>  * if something is expected, it should be silent
>
> That means there's a class of messages where we want to warn
> the user that they're doing something that might not be what
> they intended or which is deprecated and will go away soon,
> but where we do not want to "warn" in the test logging because
> the test is deliberately setting up that oddball corner case.
>
> It might be useful to have a look at where we're using
> if (qtest_enabled()) to see if we can make some subcategories
> avoid the explicit if(), e.g. by having a warn_deprecated(...)
> and hide the "don't print if qtest" inside the function.
>

I could add error/warn variants that are noop in case qtest is
enabled. It would, however, lead to this pattern which is discouraged by
the error.h documentation (+Cc Markus for advice):

before:
    if (!dinfo && !qtest_enabled()) {
        error_report("A flash image must be given with the "
                     "'pflash' parameter");
        exit(1);
    }

after:
    if (!dinfo) {
        error_report_noqtest(&error_fatal,
                             "A flash image must be given with the "
                             "'pflash' parameter");
    }

For both error/warn, we'd reduce the amount of qtest_enabled() to only
the special cases not related to printing. We'd remove ~35/83 instances,
not counting the 7 printfs.

> Some categories as a starter:
>  * some board models will error-and-exit if the user
>    didn't provide any guest code (eg no -kernel option),
>    like hw/m68k/an5206.c. When we're running with the
>    qtest accelerator it's fine and expected that there's
>    no guest code loaded because we'll never run any guest code
>  * in some places (eg target/arm/cpu.c) we treat qtest as
>    another accelerator type, so we might say
>    if (tcg_enabled() || qtest_enabled()) to mean "not
>    hvf or kvm"
>  * sometimes we print a deprecation message only if
>    not qtest, eg hw/core/numa.c or hw/core/machine.c
>  * the clock related code needs to be qtest aware because
>    under qtest it's the qtest protocol that advances the
>    clock
>  * sometimes we warn about possible user error if not
>    qtest, eg hw/ppc/pnv.c or target/mips/cpu.c
>
> thanks
> -- PMM

