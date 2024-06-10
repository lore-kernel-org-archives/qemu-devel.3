Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3C21C27C5E
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2024 05:22:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGXSc-0008Ko-J6; Mon, 10 Jun 2024 01:20:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sGXSa-0008Jx-AQ
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 01:20:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sGXSX-0000b7-Nx
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 01:20:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717996844;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=svY5H/Wx7L7PtA87wn20j9OYTIRwws86F115fnHjXIc=;
 b=Os2nM6ucSIXovPN4y1hWbJyvYaBoUKSyPMmMkv8E+ZuW2BQP00uf8EYExgkwuFeDe27+38
 HqoH7SlllUl7Q/uSW9y5g1Y/tXmBLlVcow2l/Mmy4x03gTuStPTK3wqHdo+k5DFug+2BB+
 JrR9ij9ieTmLja2wbticfaeONBcpakM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-471-SY6Q_EMLO_2J9AMMOsjcLg-1; Mon,
 10 Jun 2024 01:20:39 -0400
X-MC-Unique: SY6Q_EMLO_2J9AMMOsjcLg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9C60129AA381;
 Mon, 10 Jun 2024 05:20:38 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.93])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CF754C158D0;
 Mon, 10 Jun 2024 05:20:37 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id AB83821E6757; Mon, 10 Jun 2024 07:20:36 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: "Dr. David Alan Gilbert" <dave@treblig.org>
Cc: Markus Armbruster <armbru@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Dau?=
 =?utf-8?Q?d=C3=A9?=
 <philmd@linaro.org>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Thomas
 Huth <thuth@redhat.com>,  qemu-devel@nongnu.org,  Cornelia Huck
 <cohuck@redhat.com>,  David Hildenbrand <david@redhat.com>,  Alex
 =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,  Christian Borntraeger
 <borntraeger@linux.ibm.com>,  qemu-s390x@nongnu.org,
 devel@lists.libvirt.org,  Eric Farman <farman@linux.ibm.com>,  Ilya
 Leoshkevich <iii@linux.ibm.com>,  Richard Henderson
 <richard.henderson@linaro.org>,  Eric Blake <eblake@redhat.com>,  Halil
 Pasic <pasic@linux.ibm.com>,  Anton Johansson <anjo@rev.ng>,  qemu-arm
 <qemu-arm@nongnu.org>
Subject: Re: [PATCH 0/4] hw/s390x: Alias @dump-skeys -> @dump-s390-skey and
 deprecate
In-Reply-To: <ZmBPhxW85fqQWGSE@gallifrey> (David Alan Gilbert's message of
 "Wed, 5 Jun 2024 11:44:07 +0000")
References: <20240530074544.25444-1-philmd@linaro.org>
 <cb4028fc-9596-47f3-9468-f8912dd48aed@redhat.com>
 <Zl20rAjHLJlZkwxE@redhat.com> <Zl4tgFuAdjU2bst6@gallifrey>
 <87y17lcni7.fsf@pond.sub.org>
 <fcb6ff5d-fcad-4eb1-9b64-0a8477954a0d@linaro.org>
 <875xup81u9.fsf@pond.sub.org> <ZmBPhxW85fqQWGSE@gallifrey>
Date: Mon, 10 Jun 2024 07:20:36 +0200
Message-ID: <87zfrts7a3.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

"Dr. David Alan Gilbert" <dave@treblig.org> writes:

> * Markus Armbruster (armbru@redhat.com) wrote:
>> Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:
>>=20
>> > Hi Daniel, Dave, Markus & Thomas.
>> >
>> > On 4/6/24 06:58, Markus Armbruster wrote:
>> >> "Dr. David Alan Gilbert" <dave@treblig.org> writes:
>> >>> * Daniel P. Berrang=C3=A9 (berrange@redhat.com) wrote:
>> >>>> On Fri, May 31, 2024 at 06:47:45AM +0200, Thomas Huth wrote:
>> >>>>> On 30/05/2024 09.45, Philippe Mathieu-Daud=C3=A9 wrote:
>> >>>>>> We are trying to unify all qemu-system-FOO to a single binary.
>> >>>>>> In order to do that we need to remove QAPI target specific code.
>> >>>>>>
>> >>>>>> @dump-skeys is only available on qemu-system-s390x. This series
>> >>>>>> rename it as @dump-s390-skey, making it available on other
>> >>>>>> binaries. We take care of backward compatibility via deprecation.
>> >>>>>>
>> >>>>>> Philippe Mathieu-Daud=C3=A9 (4):
>> >>>>>>     hw/s390x: Introduce the @dump-s390-skeys QMP command
>> >>>>>>     hw/s390x: Introduce the 'dump_s390_skeys' HMP command
>> >>>>>>     hw/s390x: Deprecate the HMP 'dump_skeys' command
>> >>>>>>     hw/s390x: Deprecate the QMP @dump-skeys command
>> >>>>>
>> >>>>> Why do we have to rename the command? Just for the sake of it? I t=
hink
>> >>>>> renaming HMP commands is maybe ok, but breaking the API in QMP is =
something
>> >>>>> you should consider twice.
>> >
>> > I'm looking at how to include this command in the new "single binary".
>> >
>> > Markus explained in an earlier series, just expanding this command as
>> > stub to targets that don't implement it is not backward compatible and
>> > breaks QMP introspection. Currently on s390x we get a result, on other
>> > targets the command doesn't exist. If we add a stubs, then other targe=
ts
>> > return something (even if it is an empty list), confusing management
>> > interface.
>>=20
>> Loss of introspection precision is a concern, not a hard "no".
>>=20
>> We weigh all the concerns, and pick a solution we hate the least :)
>>=20
>> > So this approach use to deprecate process to include a new command
>> > which behaves differently on non-s390x targets.
>> >
>> > If we don't care for this particular case, better. However I'd still
>> > like to discuss this approach for other target-specific commands.
>> >
>> >> PRO rename: the command's tie to S390 is them immediately obvious, wh=
ich
>> >> may be useful when the command becomes available in qemu-systems capa=
ble
>> >> of running other targets.
>> >>
>> >> CON rename: users need to adapt.
>> >>
>> >> What are the users?  Not libvirt, as far as I can tell.
>> >
>> > Years ago we said, "all HMP must be based on QMP".
>>=20
>> In practice, it's closer to "HMP must be base on QMP when the
>> functionality does or should exist in QMP."
>>=20
>> >                                                    Now we realize HMP
>> > became stable because QMP-exposed, although not consumed externally...
>>=20
>> I'm afraid I didn't get this part.
>>=20
>> > Does the concept of "internal QMP commands" makes sense for HMP debug
>> > ones? (Looking at a way to not expose them). We could use the "x-"
>> > prefix to not care about stable / backward compat, but what is the poi=
nt
>> > of exposing to QMP commands that will never be accessed there?
>> >
>> >>>> That was going to be my question too. Seems like its possible to si=
mply
>> >>>> stub out the existing command for other targets.
>> >>
>> >> That's going to happen whether we rename the commands or not.
>> >>=20
>> >>> Are these commands really supposed to be stable, or are they just de=
bug
>> >>> commands?  If they are debug, then add the x- and don't worry too mu=
ch.
>> >
>> > OK.
>> >
>> >> docs/devel/qapi-code-gen.rst:
>> >>
>> >>      Names beginning with ``x-`` used to signify "experimental".  This
>> >>      convention has been replaced by special feature "unstable".
>> >>
>> >> Feature "unstable" is what makes something unstable, and is what
>> >> machines should check.
>> >
>> > What I mentioned earlier could be 'Feature "internal" or "debug"'.
>>=20
>> What's the difference to "unstable"?
>
> It should be clear *why* something is marked x- - something that's
> marked 'x-' because the feature is still in development is expected to sh=
ake
> out at some point, and the interface designed so it can.
> (and at some point the developer should get a prod to be asked whethere t=
he
> x- can be removed).
> That's different from it permenantly being x- because it's expected to
> change as the needs of the people debugging change.

When you add special feature 'unstable', the tooling insists you cover
it in the doc comment.  Review should then ensure the doc comment
explains why it is unstable.  Examples:

   # @unstable: Member @x-perf is experimental.

   # @unstable: This command is meant for debugging.

> Dave
>
>> >> An "x-" prefix may still be useful for humans.  Machines should *not*
>> >> key on the prefix.  It's unreliable anyway: InputBarrierProperties
>> >> member @x-origin is stable despite it's name.  Renames to gain or lose
>> >> the prefix may or may not be worth the bother.
>> >
>> > Could follow the rules and be renamed as "origin-coordinate-x".
>>=20
>> I don't think it's worth the trouble.  The "x-" prefix is now strictly
>> for humans, and humans can figure out what the x- in @x-origin,
>> @y-origin means.
>>=20
>> [...]
>>=20


