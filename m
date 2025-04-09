Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBDFCC36002
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Apr 2025 11:38:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2Tk9-00081O-FF; Wed, 09 Apr 2025 07:37:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1u2Tk8-00081C-2v
 for qemu-devel@nongnu.org; Wed, 09 Apr 2025 07:37:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1u2Tk6-0001Zh-82
 for qemu-devel@nongnu.org; Wed, 09 Apr 2025 07:37:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744198636;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XvhkNUNp0Vjp41HMAC4Dg9sf6OvHm7Ymre0YeeMnUfc=;
 b=R5rRkOHwBKNE3Of0mj4iRNSI3rLU3FyQae9yBo1rfxhZdL/j5rZbHDjPaqn5Y1LnvMWwD6
 Wc9jfUkueu3NHzaB/1orsx50eD2MGa4uKvI06yRDBKOUxC8juvou42ocSXS2kRXNsV2UMs
 rWYDsKzXPXuynkc8A59kXi0C9FSJgeI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-452-WumYT4uPNe-su_DsBQeXpw-1; Wed,
 09 Apr 2025 07:37:12 -0400
X-MC-Unique: WumYT4uPNe-su_DsBQeXpw-1
X-Mimecast-MFC-AGG-ID: WumYT4uPNe-su_DsBQeXpw_1744198631
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 86DA118001E2; Wed,  9 Apr 2025 11:37:09 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.7])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BF379180B487; Wed,  9 Apr 2025 11:37:08 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 08AEE21E66C5; Wed, 09 Apr 2025 13:37:06 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Mario Fleischmann <mario.fleischmann@lauterbach.com>,
 qemu-devel@nongnu.org,  philmd@linaro.org, christian.boenig@lauterbach.com
Subject: Re: [PATCH 00/16] Add Multi-Core Debug (MCD) API support
In-Reply-To: <875xjdheaj.fsf@draig.linaro.org> ("Alex =?utf-8?Q?Benn=C3=A9?=
 =?utf-8?Q?e=22's?= message of "Wed, 09 Apr 2025 10:31:16 +0100")
References: <20250310150510.200607-1-mario.fleischmann@lauterbach.com>
 <87semkw3qx.fsf@pond.sub.org>
 <ea767dfa-d52b-44fc-baec-deea0223094f@lauterbach.com>
 <87semjp286.fsf@pond.sub.org>
 <0736943f-443b-4bfc-8d69-f30f42029d07@lauterbach.com>
 <87r023m422.fsf@pond.sub.org> <87a58qj3ay.fsf@draig.linaro.org>
 <87ldsakgp9.fsf@pond.sub.org> <87y0wahh65.fsf@draig.linaro.org>
 <87mscqiut6.fsf@pond.sub.org>
 <b610c46f-3137-4fc9-a80a-6855e5884c6c@lauterbach.com>
 <875xjdheaj.fsf@draig.linaro.org>
Date: Wed, 09 Apr 2025 13:37:06 +0200
Message-ID: <8734ehbm71.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.505,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> Mario Fleischmann <mario.fleischmann@lauterbach.com> writes:
>
>> On 08.04.2025 16:37, Markus Armbruster wrote:

[...]

>>> Use of QAPI/QMP does not imply use of the QMP monitor.  We can keep the
>>> monitor and the debugging interface separate even though both are based
>>> on QAPI/QMP.
>>>=20
>>> The monitor code is gnarly, I'm afraid.  It supports multiple monitors,
>>> but they are not fully independent for historical reasons, chiefly
>>> implied mutual exclusion for commands.  Adding a QAPI/QMP-based
>>> debugging interface without undue coupling to monitors may pose a few
>>> technical problems.  One way to find out.
>>
>> If I understand you correctly, when QAPI-MCD runs on a separate socket
>> without using a monitor, it's still coupled to the monitor code
>> internally? Does this have an influence on the either the usage of a
>> monitor or the MCD interface or is it rather an implementation detail?
>
> An implementation detail - we should try and avoid needless coupling if
> we can though.
>
> AFAIK not all monitor commands map to QMP equivalents but I'm not sure
> if that's true the other way around - can you do everything you can over
> QMP under HMP? If you don't have to then that implies we can over a
> separate schema on a debug socket that doesn't need monitor bits tied
> in.

Ideally, HMP commands are human-friendly wrappers around QMP commands.
Such commands can't do anything that could be done with QMP.

Not all the functionality of QMP needs to be exposed in HMP.  Some
functionality might only exist in QMP.  How much to expose is a
pragmatic "is it worth the bother?" decision.

Certain HMP commands make no sense in QMP.  Examples:

* HMP cpu sets the default CPU.  The concept doesn't exist in QMP.

* Ad hoc debugging commands that are used only by humans, such as
  sync-profile.

* The desk calculator[*]

My abstract mental model of MCD has it completely separate from monitors
(HMP and QMP).  Just like gdbstub.

We're considering to use QAPI/QMP as interface definition and transport
infrastructure.

Mario's patches do that in a simple way: by "embedding" MCD in the QMP
monitor.  This creates a coupling that doesn't exist in my abstract
mental model.

We could have a separate QAPI schema for interface definition, and a
separate socket for transport.  This avoids coupling.

Obviously, we'd still want to reuse existing QMP infrastructure as much
as practical.  Some of that that code is gnarly.  If we're not careful,
we get some subtle coupling deep under the hood.

Here's one possible complication.  While we can have any number of QMP
monitors, we still funnel most[**] commands to the main loop thread,
where they run one after the other.  If we reuse all that machinery for
MCD, we end up forcing MCD commands through the same funnel to the main
loop thread.  This coupling could be undesirable.

Before we contemplate how to press the existing QMP infrastructure into
service for MCD, we should first figure out how we'd want MCD to operate
if we started on a green field.  Can we have more than one MCD
connection?  Which thread should execure MCD commands?  Any locking
requirements?  Any need for asynchronous commands?


[*] Which arguably makes no sense in HMP either.

[**] Not out-of-band commands.  You probably don't want to know more.


