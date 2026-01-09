Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B9BBD1A610
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 12:27:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veBZY-000594-T4; Fri, 09 Jan 2026 07:26:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1veBZX-00058G-Lm
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 07:26:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1veBZV-0005TG-2t
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 07:26:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767961586;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zDo1NUmvGczPAlknAHYPwQ/p6hGU4SN3wqxogeRjgVw=;
 b=HcW15CFQ368IXSJnCdauLCjDO1+8j3zZXkFdGxL78p63JfGBPVmI8/OYCuFbWPBIoII5J9
 U62mAMQwNJ72n+1QzznkCyaVQ8UQ3Ueg+WiO99lZsoTZOgvTsQwEUeGpkKnPP1G9utSeK+
 at4LLwAFNHnC93UPzEFsYbAn+FRnG1I=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-371-3PTERwRtP0iee_I6XxUn_A-1; Fri,
 09 Jan 2026 07:26:25 -0500
X-MC-Unique: 3PTERwRtP0iee_I6XxUn_A-1
X-Mimecast-MFC-AGG-ID: 3PTERwRtP0iee_I6XxUn_A_1767961584
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ABEA2180047F; Fri,  9 Jan 2026 12:26:24 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.32])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2C3391800240; Fri,  9 Jan 2026 12:26:23 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9F0BA21E66C1; Fri, 09 Jan 2026 13:26:21 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: marcandre.lureau@redhat.com,  qemu-devel@nongnu.org,  Eric Blake
 <eblake@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,  Marcelo
 Tosatti <mtosatti@redhat.com>,  "open list:X86 KVM CPUs"
 <kvm@vger.kernel.org>
Subject: Re: [PATCH] Add query-tdx-capabilities
In-Reply-To: <aWDatqLQYBV9fznm@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Fri, 9 Jan 2026 10:38:46 +0000")
References: <20260106183620.2144309-1-marcandre.lureau@redhat.com>
 <aV41CQP0JODTdRqy@redhat.com> <87qzrzku9z.fsf@pond.sub.org>
 <aWDMU7WOlGIdNush@redhat.com> <87jyxrksug.fsf@pond.sub.org>
 <aWDTXvXxPRj2fs2b@redhat.com> <87cy3jkrj8.fsf@pond.sub.org>
 <aWDatqLQYBV9fznm@redhat.com>
Date: Fri, 09 Jan 2026 13:26:21 +0100
Message-ID: <871pjzkm4y.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

> On Fri, Jan 09, 2026 at 11:29:47AM +0100, Markus Armbruster wrote:
>> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>>=20
>> > On Fri, Jan 09, 2026 at 11:01:27AM +0100, Markus Armbruster wrote:
>> >> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>> >>=20
>> >> > On Fri, Jan 09, 2026 at 10:30:32AM +0100, Markus Armbruster wrote:
>> >> >> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>> >> >>=20
>> >> >> > On Tue, Jan 06, 2026 at 10:36:20PM +0400, marcandre.lureau@redha=
t.com wrote:
>> >> >> >> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> >> >> >>=20
>> >> >> >> Return an empty TdxCapability struct, for extensibility and mat=
ching
>> >> >> >> query-sev-capabilities return type.
>> >> >> >>=20
>> >> >> >> Fixes: https://issues.redhat.com/browse/RHEL-129674
>> >> >> >> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.=
com>
>> >>=20
>> >> [...]
>> >>=20
>> >> >> > This matches the conceptual design used with query-sev-capabilit=
ies,
>> >> >> > where the lack of SEV support has to be inferred from the command
>> >> >> > returning "GenericError".
>> >> >>=20
>> >> >> Such guesswork is brittle.  An interface requiring it is flawed, a=
nd
>> >> >> should be improved.
>> >> >>=20
>> >> >> Our SEV interface doesn't actually require it: query-sev tells you
>> >> >> whether we have SEV.  Just run that first.
>> >> >
>> >> > Actually these commands are intended for different use cases.
>> >> >
>> >> > "query-sev" only returns info if you have launched qemu with
>> >> >
>> >> >   $QEMU -object sev-guest,id=3Dcgs0  -machine confidential-guest-su=
pport=3Dcgs0
>> >> >
>> >> > The goal of "query-sev-capabilities" is to allow you to determine
>> >> > if the combination of host+kvm+qemu are capable of running a guest
>> >> > with "sev-guest".
>> >> >
>> >> > IOW, query-sev-capabilities alone is what you want/need in order
>> >> > to probe host features.
>> >> >
>> >> > query-sev is for examining running guest configuration
>> >>=20
>> >> The doc comments fail to explain this.  Needs fixing.
>> >>=20
>> >> Do management applications need to know more than "this combination of
>> >> host + KVM + QEMU can do SEV, yes / no?
>> >>=20
>> >> If yes, what do they need?  "No" split up into serval "No, because X"?
>> >
>> > When libvirt runs  query-sev-capabilities it does not care about the
>> > reason for it being unsupported.   Any "GenericError" is considered
>> > to mark the lack of host support, and no fine grained checks are
>> > performed on the err msg.
>> >
>> > If query-sev-capabilities succeeds (indicating SEV is supported), then
>> > all the returned info is exposed to mgmt apps in the libvirt domain
>> > capabilities XML document.
>>=20
>> So query-sev-capabilities is good enough as is?
>
> IIUC, essentially all QEMU errors that could possibly be seen with
> query-sev-capabilities are "GenericError" these days, except for
> the small possibility of "CommandNotFound".
>
> The two scenarios with lack of SEV support are covered by GenericError
> but I'm concerned that other things that should be considered fatal
> will also fall under GenericError.
>
> eg take a look at qmp_dispatch() and see countless places where we can
> return GenericError which ought to be treated as fatal by callers.=20
>
> IMHO  "SEV not supported" is not conceptually an error, it is an
> expected informational result of query-sev-capabilities, and thus
> shouldn't be using the QMP error object, it should have been a
> boolean result field.

I agree that errors should be used only for "abnormal" outcomes, not for
the "no" answer to a simple question like "is SEV available, and if yes,
what are its capabilities?"

I further agree that encoding "no" as GenericError runs the risk of
conflating "no" with other errors.  Since query-sev itself can fail just
one way, these can only come from the QMP core.  For the core's syntax
and type errors, the risk is only theoretical: just don't do that.
Errors triggered by state, like the one in qmp_command_available(), are
a bit more worrying.  I think they're easy enough to avoid if you're
aware, but "if you're aware" is admittedly rittle.

Anyway, that's what we have.  Badly designed, but it seems to be
workable.

Is the bad enough to justify revising the interface?  I can't see how to
do that compatibly.

Is it bad enough to justify new interfaces for similar things to be
dissimilar?

>> If yes, then the proposed query-tdx-capabilities should also be good
>> enough, shouldn't it?
>
> With regards,
> Daniel


