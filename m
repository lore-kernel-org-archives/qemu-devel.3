Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0CF5C87FD2
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Aug 2025 05:42:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujtNk-00054Z-Fb; Thu, 07 Aug 2025 01:41:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ujtNj-00053R-4t
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 01:41:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ujtNh-0004m4-6P
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 01:41:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754545295;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=opNt31OvSllS59rmbkTm1e2lfJQ34iTzbLzukkSguwc=;
 b=TUr455IGV5myz9YEVEpkh+2bPeBBlQHEvFRdui3ryw+KBs+3WmoQnibskIlokWqQedkDlz
 4qMqdIqqpzO4bLkvWVEXj4Iz/50awoDDRJhwM05xyQ2GNupaoo27IkKQvW9wi0ywFI6C6r
 BKNWZPQrp9n5O9/A5+1NNGUayR7NhIU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-237-Z-AQq8sbNQyyI4mnpkc1Dg-1; Thu,
 07 Aug 2025 01:41:29 -0400
X-MC-Unique: Z-AQq8sbNQyyI4mnpkc1Dg-1
X-Mimecast-MFC-AGG-ID: Z-AQq8sbNQyyI4mnpkc1Dg_1754545288
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 532AF1956094; Thu,  7 Aug 2025 05:41:28 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AFE4519560AD; Thu,  7 Aug 2025 05:41:27 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id F090821E6A27; Thu, 07 Aug 2025 07:41:24 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Alex
 =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,  Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>,  qemu-devel@nongnu.org,  Paolo Bonzini
 <pbonzini@redhat.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Gustavo
 Romero <gustavo.romero@linaro.org>
Subject: Re: [PATCH RFC] util/error.c: Print backtrace on error
In-Reply-To: <62284106-30c9-4e30-8b97-ef38f920d237@linaro.org> (Pierrick
 Bouvier's message of "Wed, 6 Aug 2025 13:26:48 -0700")
References: <20250805-backtrace-v1-1-d189d09b1e92@linaro.org>
 <aJIqdQSYXO4K6lCJ@redhat.com>
 <CAAjaMXY1ytnhp+APdwM39-K=Mu=5p8W=MEUVvLers3M=rLS6Qw@mail.gmail.com>
 <aJI18an38eBkVL-Q@redhat.com>
 <CAAjaMXZhFM7keE1abmhQqehsZn7LaJXwYvUAuOvd-MdNTYtw1Q@mail.gmail.com>
 <aJJGvL8feHr7Wme7@redhat.com> <87h5ykzout.fsf@draig.linaro.org>
 <aJM9v0ASQOPWzcQ9@redhat.com>
 <62284106-30c9-4e30-8b97-ef38f920d237@linaro.org>
Date: Thu, 07 Aug 2025 07:41:24 +0200
Message-ID: <87bjorr8mz.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:

> On 8/6/25 4:34 AM, Daniel P. Berrang=C3=A9 wrote:
>> On Wed, Aug 06, 2025 at 12:11:38PM +0100, Alex Benn=C3=A9e wrote:
>>> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>>>
>>>> On Tue, Aug 05, 2025 at 07:57:38PM +0300, Manos Pitsidianakis wrote:
>>>>> On Tue, Aug 5, 2025 at 7:49=E2=80=AFPM Daniel P. Berrang=C3=A9 <berra=
nge@redhat.com> wrote:
>>>>>>
>>>>>>
>>>>>> Was there a specific place where you found things hard to debug
>>>>>> from the error message alone ?  I'm sure we have plenty of examples
>>>>>> of errors that can be improved, but wondering if there are some
>>>>>> general patterns we're doing badly that would be a good win
>>>>>> to improve ?
>>>>>
>>>>> Some months ago I was debugging a MemoryRegion use-after-free and used
>>>>> this code to figure out that the free was called from RCU context
>>>>> instead of the main thread.
>>>>
>
> I ran into something similar recently [1], and it was a pain to reproduce=
 it. Luckily, I caught it using rr and could debug it, but it would have be=
en much easier to just get a backtrace of the crash.
>
> In this case, it was a segmentation fault, which is not covered by curren=
t patch. Which brings me the thought I share at the end of this email.
>
> [1] https://lore.kernel.org/qemu-devel/173c1c78-1432-48a4-8251-65c65568c1=
12@linaro.org/T/#
>
>>>> We give useful names to many (but not neccessarily all) threads that we
>>>> spawn. Perhaps we should call pthread_getname_np() to fetch the current
>>>> thread name, and used that as a prefix on the error message we print
>>>> out, as a bit of extra context ?
>>>
>>> Do we always have sensible names for threads or only if we enable the
>>> option?
>>
>> I was surprised to discover we don't name threads by default, only if we
>> add '-name debug-threads=3Dyes'.  I'm struggling to understand why we wo=
uld
>> ever want thread naming disabled, if an OS supports it ?
>> I'm inclined to deprecate 'debug-threads' and always set the names when
>> available.

On POSIX, thread naming uses pthread_setname_np(), which is a GNU
extension.  Can't see drawbacks; just use it when available.

On Windows, thread naming appears to use a dynamically loaded
SetThreadDescription().  Any drawbacks?  I'm a Windows ignoramus...

>>>> Obviously not as much info as a full stack trace, but that is something
>>>> we could likely enable unconditionally without any overheads to worry
>>>> about, so a likely incremental wni.
>>>
>>> The place where it comes in useful is when we get bug reports from users
>>> who have crashed QEMU in a embedded docker container and can't give us a
>>> reasonable reproducer. If we can encourage such users to enable this
>>> option (or maybe make it part of --enable-debug-info) then we could get
>>> a slightly more useful backtrace for those bugs.
>> The challenge is whether this build option would be enabled widely
>> enough to make a significant difference ?
>>
>
> For developers working on crashes/bug fix, it's definitely a good additio=
n (could come with --enable-debug for sure). It's something we could enable=
 in CI by default too. Usually, with sanitizers, the reported stacktrace is=
 enough to get a rough idea of what the problem is, without having to use a=
ny debugger.
>
>> I don't think we could really enable this in any distro builds, as
>> this is way too noisy to have turned on unconditionally at build
>> time for all users. Most containers are going to be consuming
>> distro builds, with relatively few building custom QEMU themselves
>> IME.  We might have better luck if this was a runtime option to
>> the -msg arg.
>>
>
> Regarding the outside world and users, I share Daniel's opinion that it w=
ould be too verbose if a backtrace is emitted with every fatal error messag=
e.

Yes, that's out of the question.  We can debate backtrace on internal
errors, such as hitting &error_abort, or more generally abort().  Need
to demonstrate it adds value to simply dumping core, which we get for
free.

> However, I think it could have *incredible* value if we reported this bac=
ktrace when QEMU segfaults, which is always something exceptional.

This would be a best effort.  The program is already out of order, and
printing may or may not work.  Avoiding printf() and memory allocation
would improve the odds.

> In this case, we could always enable this.
> It's not covered by the current patch, maybe it could be a great addition?
>
> Regarding binary size increase due to -rdynamic, I already know some peop=
le won't like it, so I'm not sure how we can ensure to have useful symbols =
in distributed binaries, which is a harder debate than enabling backtraces =
on segfaults or not.

1. Core dumps may take disk space!  Let's disable them.

2. My programs crash!  I need to know why.

3. I know!  Let's make all the program bigger!

SCNR ;)


