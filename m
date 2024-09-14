Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F19DC0218C
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Sep 2024 09:36:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1spPBl-0005N6-EB; Sat, 14 Sep 2024 05:35:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1spPBk-0005Md-IZ
 for qemu-devel@nongnu.org; Sat, 14 Sep 2024 05:35:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1spPBj-0006JW-2v
 for qemu-devel@nongnu.org; Sat, 14 Sep 2024 05:35:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726306529;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=16POvHRz7CymBssDBry4GNQVe2bcqyXr/AjFQX+F9KE=;
 b=TTdyNywEVH6gDg86V7Os92Xb8vhc36YouPWpPZvPsezoYmeuUTwK0AnIUbtzNLp9fMUluA
 dUn1UCkjHcXzLx6lADyAjb5qGivlTNdAZVPtTRT/PZ2fpzWj48AkOc6ouGdZ+o6jVH4vUL
 B9vum6rrOvOY52QCcrGob+YQKtLxakI=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-425-aIvhI_Z2OkGPEP07qG-w7Q-1; Sat,
 14 Sep 2024 05:35:25 -0400
X-MC-Unique: aIvhI_Z2OkGPEP07qG-w7Q-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8E3C319560A7; Sat, 14 Sep 2024 09:35:23 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.112])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2C73B1955D44; Sat, 14 Sep 2024 09:35:23 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D0CAC21E6A28; Sat, 14 Sep 2024 11:35:20 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,  Thomas Huth
 <thuth@redhat.com>,  Fabiano Rosas <farosas@suse.de>,
 qemu-devel@nongnu.org,  Peter Xu <peterx@redhat.com>
Subject: Re: [RFC PATCH 0/2] qtest: Log verbosity changes
In-Reply-To: <ZuQoauSdVNaG3F6m@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Fri, 13 Sep 2024 12:56:26 +0100")
References: <20240905210328.25393-1-farosas@suse.de>
 <95d9509b-d9a5-467a-860a-91bcd4baae1f@redhat.com>
 <Ztq5068xW640qeuD@redhat.com>
 <CAFEAcA-naWfN5sLSJ3uS6VjC3HWvyaGqAk0=B_iqTYgtJOH+ow@mail.gmail.com>
 <ZuQoauSdVNaG3F6m@redhat.com>
Date: Sat, 14 Sep 2024 11:35:20 +0200
Message-ID: <87ikuyshlz.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Fri, Sep 06, 2024 at 10:52:53AM +0100, Peter Maydell wrote:
>> On Fri, 6 Sept 2024 at 09:14, Daniel P. Berrang=C3=A9 <berrange@redhat.c=
om> wrote:
>> >
>> > On Fri, Sep 06, 2024 at 08:16:31AM +0200, Thomas Huth wrote:
>> > > On 05/09/2024 23.03, Fabiano Rosas wrote:
>> > > > Hi,
>> > > >
>> > > > This series silences QEMU stderr unless the QTEST_LOG variable is =
set
>> > > > and silences -qtest-log unless both QTEST_LOG and gtest's --verbose
>> > > > flag is passed.
>> > > >
>> > > > This was motivated by Peter Maydell's ask to suppress deprecation
>> > > > warn_report messages from the migration-tests and by my own
>> > > > frustration over noisy output from qtest.
>>=20
>> This isn't what I want, though -- what I want is that a
>> qtest run should not print "warning:" messages for things
>> that we expect to happen when we run that test. I *do* want
>> warnings for things that we do not expect to happen when
>> we run the test.
>
> Currently we just allow the child QEMU process stdout/err
> to inherit to the qtest program's stdout/err. With that
> approach we have to do filtering at soruce (ie in QEMU
> itself). I feel that in general it is a bad idea for the
> program being tested to alter itself to suit the test
> suite, not least because two different parts of the test
> suite may have differing views about what messages they
> want to ignore vs display.
>
> We could address this be switching to the model used
> with IO tests.  Always capture the child QEMU process
> stdout/err to a pipe. The test program can apply regex
> filters to cull output that is expected & irrelevant,
> and then print out whatever is left over on its own
> stderr.
>
> That way all the filtering of undesirable messages would
> be exclusively in the test suite, not QEMU itself.

Point.


