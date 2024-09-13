Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0821FA3746
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2024 11:30:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sp4VH-0001aB-6A; Fri, 13 Sep 2024 07:30:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sp4V3-0001Yy-0l
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 07:30:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sp4V1-0003C1-Ap
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 07:30:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726227001;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IoAIxMmekUkDj8kF7aDt12qfKqo2vCx+4m3GO9J0s84=;
 b=Ox7Ezrma3wfZlsx5C6sT2+wW/YBbN1v54yI0eFiB79wXeXC4KD7lNw3X3+2HjRzugPB/ep
 4eX2jZE1wBJFx4oqHqls+9LJBk6IqEBGDHbH3Y/FBpUUc5wqjgA8HQZWKWffC+GjAf4jdJ
 WereezygeBs4xNmqccoczraneP3M8oY=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-122-3a68Zr3AOzmTiTVQ_iXP2Q-1; Fri,
 13 Sep 2024 07:29:57 -0400
X-MC-Unique: 3a68Zr3AOzmTiTVQ_iXP2Q-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8ECF019560AD; Fri, 13 Sep 2024 11:29:56 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.112])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0FD1419560AA; Fri, 13 Sep 2024 11:29:56 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4AA1321E6A28; Fri, 13 Sep 2024 13:29:53 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Fabiano Rosas <farosas@suse.de>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org,  Peter Xu <peterx@redhat.com>
Subject: Re: [RFC PATCH 0/2] qtest: Log verbosity changes
In-Reply-To: <CAFEAcA9nHvrm1K=WFQROLDuY-g9F2zk4C0CFk4bqZKc1d5hUFg@mail.gmail.com>
 (Peter Maydell's message of "Fri, 13 Sep 2024 11:08:56 +0100")
References: <20240905210328.25393-1-farosas@suse.de>
 <95d9509b-d9a5-467a-860a-91bcd4baae1f@redhat.com>
 <Ztq5068xW640qeuD@redhat.com>
 <CAFEAcA-naWfN5sLSJ3uS6VjC3HWvyaGqAk0=B_iqTYgtJOH+ow@mail.gmail.com>
 <87r09wlu87.fsf@suse.de> <87r09nzxaq.fsf@pond.sub.org>
 <CAFEAcA9nHvrm1K=WFQROLDuY-g9F2zk4C0CFk4bqZKc1d5hUFg@mail.gmail.com>
Date: Fri, 13 Sep 2024 13:29:53 +0200
Message-ID: <878qvvzt8u.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.147,
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

Peter Maydell <peter.maydell@linaro.org> writes:

> On Fri, 13 Sept 2024 at 11:02, Markus Armbruster <armbru@redhat.com> wrote:
>>
>> Fabiano Rosas <farosas@suse.de> writes:
>> > I could add error/warn variants that are noop in case qtest is
>> > enabled. It would, however, lead to this pattern which is discouraged by
>> > the error.h documentation (+Cc Markus for advice):
>> >
>> > before:
>> >     if (!dinfo && !qtest_enabled()) {
>> >         error_report("A flash image must be given with the "
>> >                      "'pflash' parameter");
>> >         exit(1);
>> >     }
>>
>> This is connex_init() and verdex_init() in hw/arm/gumstix.c.
>>
>> qtest_enabled() is *not* just suppressing a warning here, it's
>> suppressing a fatal error.  We use it to take a different codepath,
>> which is what Peter called out as a bad idea.
>>
>> Comes from commit bdf921d65f8 (gumstix: Don't enforce use of -pflash for
>> qtest).
>
> The good news on this one is that gumstix.c goes away in the
> "arm: Drop deprecated boards" series, so this specific
> error is moot :-) But it's in the same category as various
> "-kernel is mandatory except with qtest" machine checks.
>
>> > after:
>> >     if (!dinfo) {
>> >         error_report_noqtest(&error_fatal,
>> >                              "A flash image must be given with the "
>> >                              "'pflash' parameter");
>> >     }
>>
>> I don't like creating infrastructure to make bad ideas look less
>> obviously bad.
>>
>> > For both error/warn, we'd reduce the amount of qtest_enabled() to only
>> > the special cases not related to printing. We'd remove ~35/83 instances,
>> > not counting the 7 printfs.
>> >
>> >> Some categories as a starter:
>> >>  * some board models will error-and-exit if the user
>> >>    didn't provide any guest code (eg no -kernel option),
>> >>    like hw/m68k/an5206.c. When we're running with the
>> >>    qtest accelerator it's fine and expected that there's
>> >>    no guest code loaded because we'll never run any guest code
>>
>> Having tests provide the things users need to provide feels better.  It
>> may not always be practical.
>
> Specifically, if you don't disable the error-exit when qtest
> is in use, then the generic qom-test tests which say "can we
> at least instantiate every machine?" will fail, because they
> assume that "qemu-system-foo -machine bar -accel qtest" will
> at least start.
>
> It doesn't really seem feasible to me to have qom-test
> know about every machine's specific requirements for
> how to pass a guest image.

Yes.

> The other approach would be to standardize on "every machine
> type should happily start up with no warnings even if there
> is no guest code specified by the user and it would simply
> execute zeroes". We already do this for quite a lot of
> boards, including some major ones, so we're certainly not
> consistent about trying to diagnose user errors in this area.

Fatal error unless qtest is bad, because we take a different path.

Silently executing zero can be hard for users to diagnose.

Possible compromise: warn unless qtest?


