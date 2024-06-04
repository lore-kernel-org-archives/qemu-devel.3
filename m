Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23A07C25B78
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 10:01:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEQxz-0004pr-Oo; Tue, 04 Jun 2024 06:00:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sEQxr-0004ll-Fi
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 06:00:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sEQxp-0002jf-2a
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 06:00:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717495220;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eOp3+7D2uNMb07yykFmHo+Qspq1nliJgGoc4hTeKOos=;
 b=Ol9lVBcF9TeX/K71h8B3F5ZKFyEIcgdjsKst+l13u6DCmPH+MnDQP4Brsvq9mCJ985RLLm
 ieGHEW5BCnKGhBBiJzvbIlJmQqSBfaVXH0f8AMwDr8rLLcwptirEfMxRFhriDlKlqLNvlm
 K/7WaoNQN6nfd+d5FBKu3jycQBi8MYo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-15-sYDTzuV3N7W-eBxomz0mHQ-1; Tue,
 04 Jun 2024 06:00:16 -0400
X-MC-Unique: sYDTzuV3N7W-eBxomz0mHQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 847AC3802121;
 Tue,  4 Jun 2024 10:00:15 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.93])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 471DB201D999;
 Tue,  4 Jun 2024 10:00:15 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5294021E66E5; Tue,  4 Jun 2024 12:00:14 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,  Daniel P. =?utf-8?Q?Berr?=
 =?utf-8?Q?ang=C3=A9?=
 <berrange@redhat.com>,  Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org,  Cornelia Huck <cohuck@redhat.com>,  David
 Hildenbrand <david@redhat.com>,  Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 qemu-s390x@nongnu.org,  devel@lists.libvirt.org,  Eric Farman
 <farman@linux.ibm.com>,  Ilya Leoshkevich <iii@linux.ibm.com>,  Richard
 Henderson <richard.henderson@linaro.org>,  Eric Blake <eblake@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,  Anton Johansson <anjo@rev.ng>,
 qemu-arm <qemu-arm@nongnu.org>
Subject: Re: [PATCH 0/4] hw/s390x: Alias @dump-skeys -> @dump-s390-skey and
 deprecate
In-Reply-To: <fcb6ff5d-fcad-4eb1-9b64-0a8477954a0d@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Tue, 4 Jun 2024 11:45:11
 +0200")
References: <20240530074544.25444-1-philmd@linaro.org>
 <cb4028fc-9596-47f3-9468-f8912dd48aed@redhat.com>
 <Zl20rAjHLJlZkwxE@redhat.com> <Zl4tgFuAdjU2bst6@gallifrey>
 <87y17lcni7.fsf@pond.sub.org>
 <fcb6ff5d-fcad-4eb1-9b64-0a8477954a0d@linaro.org>
Date: Tue, 04 Jun 2024 12:00:14 +0200
Message-ID: <875xup81u9.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> Hi Daniel, Dave, Markus & Thomas.
>
> On 4/6/24 06:58, Markus Armbruster wrote:
>> "Dr. David Alan Gilbert" <dave@treblig.org> writes:
>>> * Daniel P. Berrang=C3=A9 (berrange@redhat.com) wrote:
>>>> On Fri, May 31, 2024 at 06:47:45AM +0200, Thomas Huth wrote:
>>>>> On 30/05/2024 09.45, Philippe Mathieu-Daud=C3=A9 wrote:
>>>>>> We are trying to unify all qemu-system-FOO to a single binary.
>>>>>> In order to do that we need to remove QAPI target specific code.
>>>>>>
>>>>>> @dump-skeys is only available on qemu-system-s390x. This series
>>>>>> rename it as @dump-s390-skey, making it available on other
>>>>>> binaries. We take care of backward compatibility via deprecation.
>>>>>>
>>>>>> Philippe Mathieu-Daud=C3=A9 (4):
>>>>>>     hw/s390x: Introduce the @dump-s390-skeys QMP command
>>>>>>     hw/s390x: Introduce the 'dump_s390_skeys' HMP command
>>>>>>     hw/s390x: Deprecate the HMP 'dump_skeys' command
>>>>>>     hw/s390x: Deprecate the QMP @dump-skeys command
>>>>>
>>>>> Why do we have to rename the command? Just for the sake of it? I think
>>>>> renaming HMP commands is maybe ok, but breaking the API in QMP is som=
ething
>>>>> you should consider twice.
>
> I'm looking at how to include this command in the new "single binary".
>
> Markus explained in an earlier series, just expanding this command as
> stub to targets that don't implement it is not backward compatible and
> breaks QMP introspection. Currently on s390x we get a result, on other
> targets the command doesn't exist. If we add a stubs, then other targets
> return something (even if it is an empty list), confusing management
> interface.

Loss of introspection precision is a concern, not a hard "no".

We weigh all the concerns, and pick a solution we hate the least :)

> So this approach use to deprecate process to include a new command
> which behaves differently on non-s390x targets.
>
> If we don't care for this particular case, better. However I'd still
> like to discuss this approach for other target-specific commands.
>
>> PRO rename: the command's tie to S390 is them immediately obvious, which
>> may be useful when the command becomes available in qemu-systems capable
>> of running other targets.
>>
>> CON rename: users need to adapt.
>>
>> What are the users?  Not libvirt, as far as I can tell.
>
> Years ago we said, "all HMP must be based on QMP".

In practice, it's closer to "HMP must be base on QMP when the
functionality does or should exist in QMP."

>                                                    Now we realize HMP
> became stable because QMP-exposed, although not consumed externally...

I'm afraid I didn't get this part.

> Does the concept of "internal QMP commands" makes sense for HMP debug
> ones? (Looking at a way to not expose them). We could use the "x-"
> prefix to not care about stable / backward compat, but what is the point
> of exposing to QMP commands that will never be accessed there?
>
>>>> That was going to be my question too. Seems like its possible to simply
>>>> stub out the existing command for other targets.
>>
>> That's going to happen whether we rename the commands or not.
>>=20
>>> Are these commands really supposed to be stable, or are they just debug
>>> commands?  If they are debug, then add the x- and don't worry too much.
>
> OK.
>
>> docs/devel/qapi-code-gen.rst:
>>
>>      Names beginning with ``x-`` used to signify "experimental".  This
>>      convention has been replaced by special feature "unstable".
>>
>> Feature "unstable" is what makes something unstable, and is what
>> machines should check.
>
> What I mentioned earlier could be 'Feature "internal" or "debug"'.

What's the difference to "unstable"?

>> An "x-" prefix may still be useful for humans.  Machines should *not*
>> key on the prefix.  It's unreliable anyway: InputBarrierProperties
>> member @x-origin is stable despite it's name.  Renames to gain or lose
>> the prefix may or may not be worth the bother.
>
> Could follow the rules and be renamed as "origin-coordinate-x".

I don't think it's worth the trouble.  The "x-" prefix is now strictly
for humans, and humans can figure out what the x- in @x-origin,
@y-origin means.

[...]


