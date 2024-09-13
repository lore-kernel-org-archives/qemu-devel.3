Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC5E1FA373B
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2024 10:03:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sp38N-0000z6-CD; Fri, 13 Sep 2024 06:02:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sp38J-0000vc-K7
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 06:02:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sp38H-0008VQ-Kw
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 06:02:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726221747;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oELS8lorYl6e3eza86TzlkGIz6etN1f07y9CwGvgjXg=;
 b=SvKrB+0fWfyUdRD444eMtvYrwE4zJ6uX03ufHn80YFeBxx0C9dXIcTa7uV1WLLcgZGpI10
 LA7+U3XqhoqQ6RWwOGBaNd7pctCwuEdpDnZ0N2UgehfTHCP52ayUmsrVU74cXu7x59/cs0
 VFBbEOXGBPo66vhkdNCVs6P5x+rfyBE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-48-zUO8oJ_RPaCSgQrKhv4I8A-1; Fri,
 13 Sep 2024 06:02:26 -0400
X-MC-Unique: zUO8oJ_RPaCSgQrKhv4I8A-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0CD41195608B; Fri, 13 Sep 2024 10:02:25 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.112])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 17D6419560AB; Fri, 13 Sep 2024 10:02:24 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id AF9FA21E6A28; Fri, 13 Sep 2024 12:02:21 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Peter Maydell <peter.maydell@linaro.org>,  Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9?= <berrange@redhat.com>,  Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org,  Peter Xu <peterx@redhat.com>,  Markus Armbruster
 <armbru@redhat.com>
Subject: Re: [RFC PATCH 0/2] qtest: Log verbosity changes
In-Reply-To: <87r09wlu87.fsf@suse.de> (Fabiano Rosas's message of "Fri, 06 Sep
 2024 11:42:00 -0300")
References: <20240905210328.25393-1-farosas@suse.de>
 <95d9509b-d9a5-467a-860a-91bcd4baae1f@redhat.com>
 <Ztq5068xW640qeuD@redhat.com>
 <CAFEAcA-naWfN5sLSJ3uS6VjC3HWvyaGqAk0=B_iqTYgtJOH+ow@mail.gmail.com>
 <87r09wlu87.fsf@suse.de>
Date: Fri, 13 Sep 2024 12:02:21 +0200
Message-ID: <87r09nzxaq.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Fabiano Rosas <farosas@suse.de> writes:

> Peter Maydell <peter.maydell@linaro.org> writes:
>
>> On Fri, 6 Sept 2024 at 09:14, Daniel P. Berrang=C3=A9 <berrange@redhat.c=
om> wrote:
>>>
>>> On Fri, Sep 06, 2024 at 08:16:31AM +0200, Thomas Huth wrote:
>>> > On 05/09/2024 23.03, Fabiano Rosas wrote:
>>> > > Hi,
>>> > >
>>> > > This series silences QEMU stderr unless the QTEST_LOG variable is s=
et
>>> > > and silences -qtest-log unless both QTEST_LOG and gtest's --verbose
>>> > > flag is passed.
>>> > >
>>> > > This was motivated by Peter Maydell's ask to suppress deprecation
>>> > > warn_report messages from the migration-tests and by my own
>>> > > frustration over noisy output from qtest.
>>
>> This isn't what I want, though -- what I want is that a
>> qtest run should not print "warning:" messages for things
>> that we expect to happen when we run that test. I *do* want
>> warnings for things that we do not expect to happen when
>> we run the test.
>>
>>> > Not sure whether we want to ignore stderr by default... we might also=
 miss
>>> > important warnings or error messages that way...?
>>>
>>> I would prefer if our tests were quiet by default, and just printed
>>> clear pass/fail notices without extraneous fluff. Having an opt-in
>>> to see full messages from stderr feels good enough for debugging cases
>>> where you need more info from a particular test.
>>
>> I find it is not uncommon that something fails and
>> you don't necessarily have the option to re-run it with
>> the "give me the error message this time" flag turn on.
>> CI is just the most obvious example; other kinds of
>> intermittent failure can be similar.
>>
>>> Probably we should set verbose mode in CI though, since it is tedious
>>> to re-run CI on failure to gather more info
>>>
>>> > If you just want to suppress one certain warning, I think it's maybe =
best to
>>> > fence it with "if (!qtest_enabled()) { ... }" on the QEMU side - at l=
east
>>> > that's what we did in similar cases a couple of times, IIRC.
>>>
>>> We're got a surprisingly large mumber of if(qtest_enabled()) conditions
>>> in the code. I can't help feeling this is a bad idea in the long term,
>>> as its making us take different codepaths when testing from production.
>>
>> What I want from CI and from tests in general:
>>  * if something fails, I want all the information
>>  * if something unexpected happens I want the warning even
>>    if the test passes (this is why I grep the logs for
>>    "warning:" in the first place -- it is to catch the case
>>    of "something went wrong but it didn't result in QEMU or
>>    the test case exiting with a failure status")
>>  * if something is expected, it should be silent
>>
>> That means there's a class of messages where we want to warn
>> the user that they're doing something that might not be what
>> they intended or which is deprecated and will go away soon,
>> but where we do not want to "warn" in the test logging because
>> the test is deliberately setting up that oddball corner case.
>>
>> It might be useful to have a look at where we're using
>> if (qtest_enabled()) to see if we can make some subcategories
>> avoid the explicit if(), e.g. by having a warn_deprecated(...)
>> and hide the "don't print if qtest" inside the function.
>>
>
> I could add error/warn variants that are noop in case qtest is
> enabled. It would, however, lead to this pattern which is discouraged by
> the error.h documentation (+Cc Markus for advice):
>
> before:
>     if (!dinfo && !qtest_enabled()) {
>         error_report("A flash image must be given with the "
>                      "'pflash' parameter");
>         exit(1);
>     }

This is connex_init() and verdex_init() in hw/arm/gumstix.c.

qtest_enabled() is *not* just suppressing a warning here, it's
suppressing a fatal error.  We use it to take a different codepath,
which is what Peter called out as a bad idea.

Comes from commit bdf921d65f8 (gumstix: Don't enforce use of -pflash for
qtest).

> after:
>     if (!dinfo) {
>         error_report_noqtest(&error_fatal,
>                              "A flash image must be given with the "
>                              "'pflash' parameter");
>     }

I don't like creating infrastructure to make bad ideas look less
obviously bad.

> For both error/warn, we'd reduce the amount of qtest_enabled() to only
> the special cases not related to printing. We'd remove ~35/83 instances,
> not counting the 7 printfs.
>
>> Some categories as a starter:
>>  * some board models will error-and-exit if the user
>>    didn't provide any guest code (eg no -kernel option),
>>    like hw/m68k/an5206.c. When we're running with the
>>    qtest accelerator it's fine and expected that there's
>>    no guest code loaded because we'll never run any guest code

Having tests provide the things users need to provide feels better.  It
may not always be practical.

I guess the example above is in this camp.

>>  * in some places (eg target/arm/cpu.c) we treat qtest as
>>    another accelerator type, so we might say
>>    if (tcg_enabled() || qtest_enabled()) to mean "not
>>    hvf or kvm"
>>  * sometimes we print a deprecation message only if
>>    not qtest, eg hw/core/numa.c or hw/core/machine.c

This is obviously fine, and if you guys want infrastructure for that,
I'll give it a sympathetic review.

>>  * the clock related code needs to be qtest aware because
>>    under qtest it's the qtest protocol that advances the
>>    clock
>>  * sometimes we warn about possible user error if not
>>    qtest, eg hw/ppc/pnv.c or target/mips/cpu.c

This can be fine, but it's not obviously fine.


