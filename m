Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5FA4C44501
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 11:44:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjF4r-00036d-P2; Mon, 13 Jul 2026 07:44:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wjF4p-00036F-KM
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 07:43:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wjF4n-0003Uj-56
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 07:43:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783943035;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1LQFDfDfZLjgeSyyjoZyHedGtiPVPl2rg6d2axS8FZ8=;
 b=Qhu777chyO+gh7U45eyKq0xTbmdW+8PROgU79pf60q9foSpggKMPs4BOgcuTOasEFPQyQA
 h3DdfUX/4KMlA1sOVNp8deWV7rdTLxe3SVTsej7wRriq9X5f5LB8NypVKqpTkZE3PTJmgH
 dRitFBLy4joiPWb3zmtxi1FuugfMziY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-439-Hr9zCKYBPy2GlR2qfFXN8Q-1; Mon,
 13 Jul 2026 07:43:51 -0400
X-MC-Unique: Hr9zCKYBPy2GlR2qfFXN8Q-1
X-Mimecast-MFC-AGG-ID: Hr9zCKYBPy2GlR2qfFXN8Q_1783943030
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7C0D21955D78; Mon, 13 Jul 2026 11:43:49 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8D63636F29; Mon, 13 Jul 2026 11:43:48 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1A1C821E6920; Mon, 13 Jul 2026 13:43:46 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,  QEMU Developers
 <qemu-devel@nongnu.org>,  Paolo Bonzini <pbonzini@redhat.com>,  Pedro
 Barbuda <pbarbuda@microsoft.com>,  Mohamed Mediouni
 <mohamed@unpredictable.fr>,  Nicholas Piggin <npiggin@gmail.com>,  Harsh
 Prateek Bora <harshpb@linux.ibm.com>,  Cornelia Huck <cohuck@redhat.com>,
 Eric Farman <farman@linux.ibm.com>,  Matthew Rosato
 <mjrosato@linux.ibm.com>
Subject: Re: what is qemu_system_guest_panicked() for?
In-Reply-To: <alSqlDRT9L8OqAso@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Mon, 13 Jul 2026 10:06:28 +0100")
References: <CAFEAcA_zmc=Vvs38Qos_gecCmGAbRgDQF-0+x85Ja66nsqrHxA@mail.gmail.com>
 <alSkWHw6ryhEEaDf@redhat.com> <87cxwrtgfd.fsf@pond.sub.org>
 <alSqlDRT9L8OqAso@redhat.com>
Date: Mon, 13 Jul 2026 13:43:46 +0200
Message-ID: <87se5ngln1.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=armbru@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Mon, Jul 13, 2026 at 10:57:58AM +0200, Markus Armbruster wrote:
>> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>>=20
>> > On Fri, Jul 10, 2026 at 05:02:53PM +0100, Peter Maydell wrote:
>>=20
>> [...]
>>=20
>> >> So I guess my question is, is it OK to mash these two categories of
>> >> "we can't keep running the VM" together, or should we define a new
>> >> one for the "unrecoverable guest error" case, or do we already have
>> >> some better thing to do that I missed?
>> >
>> > IMHO we should NOT be abusing "panicked" for cases which are
>> > not guest OS panics.
>>=20
>> Point.
>>=20
>> > Adding new QMP events is cheap and we should do so.
>>=20
>> Changing the event sent on a certain situation is technically a
>> compatibility break.  Would it matter here?
>
> What wins "compat break" or "bug fix" ? A strict POV prevents almost
> any bug fixes, if you want to remain bug-for-bug compatible with
> old QEMU.

There is no hard and fast rule.

If a patch changes behavior, and no one is around to observe it, should
we still treat it as compatibility break?  The pragmatic answer is no.

It's of course hard to be sure about non-observation.  The pragmatic
answer to that is "we use the best available data, and where it is
lacking, reasonably conservative guesses."

How likely is it that the fix breaks something else, and how painful
could such breakage be?  Again, hard to be sure, thus reasonably
conservative guesses.

> With my "management app" hat on, I want QEMU to stop sending panic
> events for things that are not panics, as that is triggering incorrect
> actions / admin activities. ie on a panic, I'm going to take a guest
> memory dump and try to analyse what is broken in the guest kernel.
>
> The QAPI spec says:
>
>   ##
>   # @GUEST_PANICKED:
>   #
>   # Emitted when guest OS panic is detected
>
>
> and
>
>   ##
>   # @RunState:
>   #
>   # An enumeration of VM run states.
>   #
>   ..
>   # @guest-panicked: guest has been panicked as a result of guest OS
>   #     panic
>
>
> I don't think "machine check exception" or "unknown VM exit"
> can be said to match either of those docs, and thus fixing
> compliance should trump bug-for-bug compatibility IMHO.

I'm not objecting, I just want the compatibility issues considered.

What are the known observers of GUEST_PANICKED?  How would they be
affected by the change?

What are the use cases for observing GUEST_PANICKED?  How could they be
affected?

Reasonably conservative guesses will do.


