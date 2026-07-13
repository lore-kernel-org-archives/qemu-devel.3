Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DCEDC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 18:09:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjL6A-0004j2-Ub; Mon, 13 Jul 2026 14:09:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wjL63-0004ho-Hv
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 14:09:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wjL61-00077c-F7
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 14:09:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783966176;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XJzNZVBzm0p+zNKgNuGwiiBlfxocU2VnvfvufnLPBS0=;
 b=TDXDxetkGQ7+SZIlqGoM324mK99vu5BVx3K/s9QtEGZSvklgAeI2jJaICPrTdfzMdWf0yI
 /E/joc9031xr+7rEGn94cMq/83uE3TGe5Ro4H6U/0c4HkSE0bHwSWT97ZE1AT15v2ga2gL
 l7nVbDdQP7s1Vz7jaAEsI3iPsdShKzE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-310-cj0lTyjxOMORbXuxsHTSkw-1; Mon,
 13 Jul 2026 14:09:32 -0400
X-MC-Unique: cj0lTyjxOMORbXuxsHTSkw-1
X-Mimecast-MFC-AGG-ID: cj0lTyjxOMORbXuxsHTSkw_1783966171
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B875F1801379; Mon, 13 Jul 2026 18:09:30 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B44BA3000B4B; Mon, 13 Jul 2026 18:09:29 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 658CA21E6920; Mon, 13 Jul 2026 20:09:27 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>,  Peter Maydell
 <peter.maydell@linaro.org>,  QEMU Developers <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>,  Pedro Barbuda
 <pbarbuda@microsoft.com>,  Mohamed Mediouni <mohamed@unpredictable.fr>,
 Nicholas Piggin <npiggin@gmail.com>,  Harsh Prateek Bora
 <harshpb@linux.ibm.com>,  Cornelia Huck <cohuck@redhat.com>,  Eric Farman
 <farman@linux.ibm.com>,  Matthew Rosato <mjrosato@linux.ibm.com>
Subject: Re: what is qemu_system_guest_panicked() for?
In-Reply-To: <alT-BXlG2EmIS-pD@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Mon, 13 Jul 2026 16:02:29 +0100")
References: <CAFEAcA_zmc=Vvs38Qos_gecCmGAbRgDQF-0+x85Ja66nsqrHxA@mail.gmail.com>
 <alSkWHw6ryhEEaDf@redhat.com> <87cxwrtgfd.fsf@pond.sub.org>
 <alSqlDRT9L8OqAso@redhat.com> <87se5ngln1.fsf@pond.sub.org>
 <alTWn2xq4FfdxnE4@redhat.com> <87bjcbf0vu.fsf@pond.sub.org>
 <alT-BXlG2EmIS-pD@redhat.com>
Date: Mon, 13 Jul 2026 20:09:27 +0200
Message-ID: <874ii2ep7s.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: permerror client-ip=170.10.133.124;
 envelope-from=armbru@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

> On Mon, Jul 13, 2026 at 03:57:25PM +0200, Markus Armbruster wrote:
>> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

[...]

>> > When libvirt see a GUEST_PANICKED, it will transition the state to
>> > "CRASHED" and assign a reason of "PANICKED" as the trigger / cause.
>> >
>> > Then depending on the guest XML config for <on_crash> it will do one
>> > of
>> >
>> >  * Take a core dump of QEMU
>> >  * Terminate QEMU
>> >  * Restart QEMU
>> >  * Take a core dump of QEMU and restart
>> >  * Leave it in crashed state (to allow a debugger to attach)
>> >
>> >
>> > The "machine check" and "unknown VM exit" scenarios, would still map
>> > to libvirt's "CRASHED" state, but we would want to assign distinct
>> > "cause" for each of them.
>>=20
>> Say we add event GUEST_MACHINE_CHECK, then send it instead of
>> GUEST_PANICKED on a machine check.
>>=20
>> With an updated version of libvirt, this changes exactly the "cause"
>> recorded for a machine check in the "CRASHED" state.  This change is
>> desirable.
>>=20
>> Older versions of libvirt ignore the unknown GUEST_MACHINE_CHECK event.
>> They therefore no longer take the <on_crash> action.  This is
>> undesirable, I'm afraid.  Is it?
>>=20
>> An orderly transition could look like this:
>>=20
>> 1. Add a new event for each distinct cause, and emit the appropriate
>>    event in addition to GUEST_PANICKED.
>>=20
>> 2. Deprecate GUEST_PANICKED.
>>=20
>> 3. Remove GUEST_PANICKED after a suitable grace period.
>
> Another option is to accept  "GUEST_PANICKED" as a sub-optimal name
> forever and add a "source" field to the event to explain what actually
> triggered it, where "source" can be  "guest-os", "machine-check", ...
> etc...

Yes, that's a compatible extension.

> Which would probably be better compatible with libvirt too
>
> With regards,
> Daniel


