Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B666C44501
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 13:58:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjHAK-0001HR-1T; Mon, 13 Jul 2026 09:57:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wjHAD-0001H8-KR
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 09:57:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wjHAA-0005hJ-Ep
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 09:57:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783951057;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vprLLMxMgkmFZoq3V9aPKpeT/lbh9F4mkQAmNb309qM=;
 b=cA4jxBYY5xSivW+8ln5Bx5zVh+2hb0sVRffV4v+2tnRA+6GDO57jTB+6hTv4kd5c7+gV6K
 UPCNakbykQEQypt7d1b8vv2ThUoKs/WK+i7AnpAGDWKecjWSX8Y/cli+Y/3DMRTfO1KuYf
 EwtGArt04fU08IqZrutiW+muNiQIduo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-680-DWkiaYvDOEe2l8jlDnUVFw-1; Mon,
 13 Jul 2026 09:57:33 -0400
X-MC-Unique: DWkiaYvDOEe2l8jlDnUVFw-1
X-Mimecast-MFC-AGG-ID: DWkiaYvDOEe2l8jlDnUVFw_1783951052
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 14C6319300F1; Mon, 13 Jul 2026 13:57:29 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 07E9C3000B4C; Mon, 13 Jul 2026 13:57:28 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 943A821E6920; Mon, 13 Jul 2026 15:57:25 +0200 (CEST)
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
In-Reply-To: <alTWn2xq4FfdxnE4@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Mon, 13 Jul 2026 13:14:23 +0100")
References: <CAFEAcA_zmc=Vvs38Qos_gecCmGAbRgDQF-0+x85Ja66nsqrHxA@mail.gmail.com>
 <alSkWHw6ryhEEaDf@redhat.com> <87cxwrtgfd.fsf@pond.sub.org>
 <alSqlDRT9L8OqAso@redhat.com> <87se5ngln1.fsf@pond.sub.org>
 <alTWn2xq4FfdxnE4@redhat.com>
Date: Mon, 13 Jul 2026 15:57:25 +0200
Message-ID: <87bjcbf0vu.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: permerror client-ip=170.10.133.124;
 envelope-from=armbru@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
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

> On Mon, Jul 13, 2026 at 01:43:46PM +0200, Markus Armbruster wrote:
>> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>>=20
>> > On Mon, Jul 13, 2026 at 10:57:58AM +0200, Markus Armbruster wrote:
>> >> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>> >>=20
>> >> > On Fri, Jul 10, 2026 at 05:02:53PM +0100, Peter Maydell wrote:
>> >>=20
>> >> [...]
>> >>=20
>> >> >> So I guess my question is, is it OK to mash these two categories of
>> >> >> "we can't keep running the VM" together, or should we define a new
>> >> >> one for the "unrecoverable guest error" case, or do we already have
>> >> >> some better thing to do that I missed?
>> >> >
>> >> > IMHO we should NOT be abusing "panicked" for cases which are
>> >> > not guest OS panics.
>> >>=20
>> >> Point.
>> >>=20
>> >> > Adding new QMP events is cheap and we should do so.
>> >>=20
>> >> Changing the event sent on a certain situation is technically a
>> >> compatibility break.  Would it matter here?
>> >
>> > What wins "compat break" or "bug fix" ? A strict POV prevents almost
>> > any bug fixes, if you want to remain bug-for-bug compatible with
>> > old QEMU.
>>=20
>> There is no hard and fast rule.
>>=20
>> If a patch changes behavior, and no one is around to observe it, should
>> we still treat it as compatibility break?  The pragmatic answer is no.
>>=20
>> It's of course hard to be sure about non-observation.  The pragmatic
>> answer to that is "we use the best available data, and where it is
>> lacking, reasonably conservative guesses."
>>=20
>> How likely is it that the fix breaks something else, and how painful
>> could such breakage be?  Again, hard to be sure, thus reasonably
>> conservative guesses.
>>=20
>> > With my "management app" hat on, I want QEMU to stop sending panic
>> > events for things that are not panics, as that is triggering incorrect
>> > actions / admin activities. ie on a panic, I'm going to take a guest
>> > memory dump and try to analyse what is broken in the guest kernel.
>> >
>> > The QAPI spec says:
>> >
>> >   ##
>> >   # @GUEST_PANICKED:
>> >   #
>> >   # Emitted when guest OS panic is detected
>> >
>> >
>> > and
>> >
>> >   ##
>> >   # @RunState:
>> >   #
>> >   # An enumeration of VM run states.
>> >   #
>> >   ..
>> >   # @guest-panicked: guest has been panicked as a result of guest OS
>> >   #     panic
>> >
>> >
>> > I don't think "machine check exception" or "unknown VM exit"
>> > can be said to match either of those docs, and thus fixing
>> > compliance should trump bug-for-bug compatibility IMHO.
>>=20
>> I'm not objecting, I just want the compatibility issues considered.
>>=20
>> What are the known observers of GUEST_PANICKED?  How would they be
>> affected by the change?
>>=20
>> What are the use cases for observing GUEST_PANICKED?  How could they be
>> affected?
>>=20
>> Reasonably conservative guesses will do.
>
> When libvirt see a GUEST_PANICKED, it will transition the state to
> "CRASHED" and assign a reason of "PANICKED" as the trigger / cause.
>
> Then depending on the guest XML config for <on_crash> it will do one
> of
>
>  * Take a core dump of QEMU
>  * Terminate QEMU
>  * Restart QEMU
>  * Take a core dump of QEMU and restart
>  * Leave it in crashed state (to allow a debugger to attach)
>
>
> The "machine check" and "unknown VM exit" scenarios, would still map
> to libvirt's "CRASHED" state, but we would want to assign distinct
> "cause" for each of them.

Say we add event GUEST_MACHINE_CHECK, then send it instead of
GUEST_PANICKED on a machine check.

With an updated version of libvirt, this changes exactly the "cause"
recorded for a machine check in the "CRASHED" state.  This change is
desirable.

Older versions of libvirt ignore the unknown GUEST_MACHINE_CHECK event.
They therefore no longer take the <on_crash> action.  This is
undesirable, I'm afraid.  Is it?

An orderly transition could look like this:

1. Add a new event for each distinct cause, and emit the appropriate
   event in addition to GUEST_PANICKED.

2. Deprecate GUEST_PANICKED.

3. Remove GUEST_PANICKED after a suitable grace period.


