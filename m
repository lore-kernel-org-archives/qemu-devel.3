Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 477E7CAC597
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Sep 2025 06:31:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uz8AQ-0005ff-Mc; Thu, 18 Sep 2025 02:30:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uz8AB-0005ea-7u
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 02:30:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uz8A5-0000Hv-TV
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 02:30:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758177032;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AjX0CFtovQGG8ilFeB+wCsdNjuVyHXuxyjiR7VKQhK8=;
 b=W0djXzHJQvjzWTHlewbK+N1k700IU8X5elRbZ60cd7xMDi+k0oNFkhMB8eKpKeiCB6Wq7a
 djZJ6UBHenP4dfQDVe/5FCYwo2WSKJgyaERO7Nc84F1rr2avUyTJR6u97F+p6Kc/MkZ+nA
 LDsAS1Ora6U6SFo9+1PgKMuAa0ezmaM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-404-a5p9qX6UMRG9_QrqzE1bqA-1; Thu,
 18 Sep 2025 02:30:28 -0400
X-MC-Unique: a5p9qX6UMRG9_QrqzE1bqA-1
X-Mimecast-MFC-AGG-ID: a5p9qX6UMRG9_QrqzE1bqA_1758177027
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 98EE61800359; Thu, 18 Sep 2025 06:30:26 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.9])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C66A918003FC; Thu, 18 Sep 2025 06:30:25 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 410F321E6A27; Thu, 18 Sep 2025 08:30:23 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  qemu-block@nongnu.org,  Hanna Reitz
 <hreitz@redhat.com>,  Kevin Wolf <kwolf@redhat.com>,  =?utf-8?Q?Marc-Andr?=
 =?utf-8?Q?=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  Christian Schoenebeck
 <qemu_oss@crudebyte.com>,  Richard Henderson
 <richard.henderson@linaro.org>,  Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>,  Stefan Weil <sw@weilnetz.de>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Gerd Hoffmann
 <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,  "Dr. David Alan Gilbert"
 <dave@treblig.org>
Subject: Re: [PATCH v3 02/20] monitor: initialize global data from a
 constructor
In-Reply-To: <aMrUNYrYeDB_sagn@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Wed, 17 Sep 2025 16:31:01 +0100")
References: <20250910180357.320297-1-berrange@redhat.com>
 <20250910180357.320297-3-berrange@redhat.com>
 <871po541h1.fsf@pond.sub.org> <aMrUNYrYeDB_sagn@redhat.com>
Date: Thu, 18 Sep 2025 08:30:23 +0200
Message-ID: <87frck1dds.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

> On Wed, Sep 17, 2025 at 04:07:06PM +0200, Markus Armbruster wrote:
>> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>>=20
>> > Some monitor functions, most notably, monitor_cur() rely on global
>> > data being initialized by 'monitor_init_globals()'. The latter is
>> > called relatively late in startup. If code triggers error_report()
>> > before monitor_init_globals() is called, QEMU will abort when
>> > accessing the uninitialized monitor mutex.
>> >
>> > The critical monitor global data must be initialized from a
>> > constructor function, to improve the guarantee that it is done
>> > before any possible calls to monitor_cur(). Not only that, but
>> > the constructor must be marked to run before the default
>> > constructor in case any of them trigger error reporting.
>>=20
>> Is error reporting from constructors a good idea?  I feel they're best
>> used for simple initializations only.
>
> When you're down in the weeds on a given piece of code it might
> not occurr that it could be used in a constructor.

Fair.  The sane way to avoid that is keeping constructors super-simple.
Ideally, not call anything.  Next best, not call anything but simple
initialization functions from well-known system libraries, and our own
portability wrappers for them.

> The biggest usage is QOM type registration, which we've obviously
> been careful (lucky) enough to keep safe.
>
> The other common use if initializing global mutexes.
>
> I rather wish our mutex APIs supported a static initializer
> like you get with pthreads and/or glib mutexes. That would
> have avoided this ordernig problem.

Oh yes.  So much simpler, easier, and safer than constructors.

>> Do we actually do it?
>
> Probably not, but I can't be that confident as I have not auditted
> all constructors.

More evidence for us abusing constructors.

The constructor audit I'd like to see: dumb them down to super-simple, ...

> I accidentally created a problem myself by putting an error_report
> call into the rcu constructor to debug something never realized
> that would result in pain.

... so nobody will need to put debug prints there.

> And then I put error_report into the RCU thread itself and thus
> discovered that was running concurrently with other constructors.
>
>> > Note in particular that the RCU constructor will spawn a background
>> > thread so we might even have non-constructor QEMU code running
>> > concurrently with other constructors.
>>=20
>> Ugh!
>
> Indeed, that was my thought when discovernig this :-(

The spiked pits we set up for ourselves...

>> Arguably
>>=20
>>   Fixes: e69ee454b5f9 (monitor: Make current monitor a per-coroutine pro=
perty)
>>=20
>> I never liked the @coroutine_mon hash table (which is what broke early
>> monitor_cur()), but accepted it for want of better ideas.
>
> I spent a little time wondering if we could replace coroutine_mon with
> a "__thread Monitor cur' and then update that in monitor_set_cur, but
> I couldn't convince myself it would be entirely safe. So for sake of
> getting the series done I took this approach and left the current
> monitor stuff for another day.
>
>>=20
>> > Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>> > Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>
>> > Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

I suggest to record our low opinion on constructor abuse in the commit
message.  As is, it almost sounds as if we considered it normal.
Starting threads there definitely isn't!

Reviewed-by: Markus Armbruster <armbru@redhat.com>


