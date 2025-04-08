Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FF58C369A2
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Apr 2025 14:38:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2A4e-0004d6-Ih; Tue, 08 Apr 2025 10:37:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1u2A4b-0004cS-U8
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 10:37:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1u2A4a-0002V0-92
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 10:37:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744123025;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h6epCfA2UVDHPBc9HkB+VVA19yy2JMxwvYtGWxttMGY=;
 b=Ogjq4dv0IyEyxpe8Ge50bDoeFnxIj0ZJCZXbstq9cbRGqfJuOOd+wUh296h1hUcVfLttph
 u30ekWUeYxQXWO8uSSvsQGaOgx3bzS+v1KDhuJZ65gRPSLl84M0AtpPeVH5O5U5sK9BJoZ
 XinOhdwjqb37WOEseRr1wUvIx3Lk+ac=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-687-_F8pPfsYPmidoR1JnmdvEw-1; Tue,
 08 Apr 2025 10:36:58 -0400
X-MC-Unique: _F8pPfsYPmidoR1JnmdvEw-1
X-Mimecast-MFC-AGG-ID: _F8pPfsYPmidoR1JnmdvEw_1744123017
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CDF9D1955DCF; Tue,  8 Apr 2025 14:36:56 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.7])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 550361956094; Tue,  8 Apr 2025 14:36:56 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id BC81221E6757; Tue, 08 Apr 2025 16:36:53 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Mario Fleischmann <mario.fleischmann@lauterbach.com>,
 qemu-devel@nongnu.org,  philmd@linaro.org, christian.boenig@lauterbach.com
Subject: Re: [PATCH 00/16] Add Multi-Core Debug (MCD) API support
In-Reply-To: <87y0wahh65.fsf@draig.linaro.org> ("Alex =?utf-8?Q?Benn=C3=A9?=
 =?utf-8?Q?e=22's?= message of "Tue, 08 Apr 2025 15:16:50 +0100")
References: <20250310150510.200607-1-mario.fleischmann@lauterbach.com>
 <87semkw3qx.fsf@pond.sub.org>
 <ea767dfa-d52b-44fc-baec-deea0223094f@lauterbach.com>
 <87semjp286.fsf@pond.sub.org>
 <0736943f-443b-4bfc-8d69-f30f42029d07@lauterbach.com>
 <87r023m422.fsf@pond.sub.org> <87a58qj3ay.fsf@draig.linaro.org>
 <87ldsakgp9.fsf@pond.sub.org> <87y0wahh65.fsf@draig.linaro.org>
Date: Tue, 08 Apr 2025 16:36:53 +0200
Message-ID: <87mscqiut6.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.845,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> Markus Armbruster <armbru@redhat.com> writes:
>
>> Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:
>>
>>> Markus Armbruster <armbru@redhat.com> writes:
>>>
>>>> Mario Fleischmann <mario.fleischmann@lauterbach.com> writes:
>>>>
>>>>> Apologies for the line wrapping in yesterday's answer. Should be fixe=
d now.
>>>>>
>>>>> On 08.04.2025 09:00, Markus Armbruster wrote:
>>
>> [...]
>>
>>>>>> What about providing the MCD interface as a separate QMP-like protoc=
ol?
>>>>>> It gets its own QAPI schema, just like for qemu-ga.  Simplifies
>>>>>> compiling it out when not needed.
>>>>>>
>>>>>> It gets its own socket, just like the GDB stub.  Might reduce
>>>>>> interference between debugging and QMP.
>>>>>>=20
>>>>>> Thoughts?  Alex, Philippe, care to chime in?
>>>>>
>>>>> Sound reasonable to me. Keeping in mind the size of generated QAPI co=
de,
>>>>> an option to `./configure [...] --enable-mcd` is definitely advisable.
>>>>
>>>> Alex, Philippe?
>>>
>>> When I spoke to Mario at DVCon last year I liked the idea of re-using
>>> QMP instead of inventing yet another RPC interface for QEMU. QMP
>>> certainly has nicer properties than the gdbstub which has a very
>>> "organic" and "serial" feel to it.
>>>
>>> Are you suggesting we re-use the machinery but use an entirely separate
>>> socket with just the MCD namespace in it? I don't see that being a
>>> problem as long as we can test it properly in the CI.
>>
>> Yes.
>>
>> "Keep them separate" is only a gut feeling, though.  While I pay
>> attention to my gut feelings, I know they can be wrong.  I am soliciting
>> opinions.
>
> I forgot to add isn't the flexibility of the QMP API something we need
> to handle for single binary anyway?

I have no idea :)

Evolving a target-dependent interface into a target-independent
interface without breaking compatibility is always a bother.

It's likely more of a bother when the interface is binary.  Textual
interfaces tend to have less target-dependence.

Designing a target-independent interface is probably easier than
evolving it compatibly from a target-dependent one.

QMP is textual, and it's designed for certain kinds of compatible
evolution.  Using QAPI/QMP for a debugging interface may be a perfectly
sensible idea.  I don't know enough about debugging interfaces to judge.

Use of QAPI/QMP does not imply use of the QMP monitor.  We can keep the
monitor and the debugging interface separate even though both are based
on QAPI/QMP.

The monitor code is gnarly, I'm afraid.  It supports multiple monitors,
but they are not fully independent for historical reasons, chiefly
implied mutual exclusion for commands.  Adding a QAPI/QMP-based
debugging interface without undue coupling to monitors may pose a few
technical problems.  One way to find out.


