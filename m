Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CE33CA0FED
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Sep 2025 11:06:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwIeD-0002Bt-Fz; Wed, 10 Sep 2025 07:05:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uwIeA-0002BL-Hc
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 07:05:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uwIe5-0002WY-6A
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 07:05:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757502345;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oZgHwLREy18GzLUggA2Fp6ndCi9BTU/lo7hYAlHU1NM=;
 b=h0cvLRrerRlPnN5BqZLOnIqcFDOU4842dM0A2ASKYnxiJFnTpW1TiohDefgAaAqlqHjmZA
 E+GFqfIr2MsEhladDRX43ORNoyqXV767Psu38iaphl/6fw20OLzAYgKQnztdlhgR3/VP1G
 GNNDWmaNmpnxe0QKexms54ds0uDTImI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-512-YafSvOIbPfupVBnmhD2lyw-1; Wed,
 10 Sep 2025 07:05:44 -0400
X-MC-Unique: YafSvOIbPfupVBnmhD2lyw-1
X-Mimecast-MFC-AGG-ID: YafSvOIbPfupVBnmhD2lyw_1757502343
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3FCB519560BA
 for <qemu-devel@nongnu.org>; Wed, 10 Sep 2025 11:05:43 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AE6241800446
 for <qemu-devel@nongnu.org>; Wed, 10 Sep 2025 11:05:42 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2E89021E6A27; Wed, 10 Sep 2025 13:05:40 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: Abuse of warnings for unhandled errors and programming errors
In-Reply-To: <aKRuXq0_5ULf5yp-@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Tue, 19 Aug 2025 13:30:22 +0100")
References: <87h5yijh3b.fsf@pond.sub.org> <aKRuXq0_5ULf5yp-@redhat.com>
Date: Wed, 10 Sep 2025 13:05:40 +0200
Message-ID: <87frcupny3.fsf@pond.sub.org>
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

> On Fri, Aug 08, 2025 at 11:30:32AM +0200, Markus Armbruster wrote:
>> In "[PATCH 00/12] Error reporting cleanup, a fix, and &error_warn
>> removal", I challenged the use of warnings in a few places.  I think the
>> topic deserves a wider audience than the one a rather pedestrian cleanup
>> series draws.
>>=20
>>=20
>> To make my case, I need to start with errors.  We distinguish between
>> ordinary errors (for lack of a better word) and programming errors.
>>=20
>> Ordinary errors are things like nonsensical user requests, unavailable
>> resources, and so forth.  A correct program is prepared for such
>> failures, detects them, and reports them to the user.  The user can then
>> fix their request, try again when resources are available, and so forth.
>>=20
>> Tools for reporting ordinary errors are error_report(),
>> error_report_err(), &error_fatal, and friends.
>
> The thing about nonsense user rquests / unavailable resources , etc
> is that almost none of them should imply exiting QEMU, except if they
> occur in the context of system startup before the VM starts executing.
> Once running we should do everything in our power to not let the users
> workload die.
>
> From that POV, I tend to wish that error_fatal did not exist and that
> we instead propagated all fatal errors up until reaching main(), so
> we were not at risk of using error_fatal in runtime scenarios. We're
> largely stuck with what we've got though, due to our need to retrofit
> error reporting in to our existing codebase design.

Yes, &error_fatal is almost always wrong after the guest starts.

When it isn't wrong, it's quite convenient.

> I do try to push back in review any time we introduce new code that
> doesn't propagate errors as high up the stack as possible/practcal.
>
>> Programming errors are bugs.  A developer needs to fix the program.
>> Unlike ordinary errors, programming errors are *unexpected*.
>>=20
>> Programming errors are commonly not recoverable.  The proper tool for
>> unrecoverable ones is assertions.  &error_abort can be a convenient way
>> to assert "this can't fail".
>
> We could have called it &error_assert but that's bike shed colouring :-)

Yup :)

>> On to warnings.
>>=20
>> When some failure doesn't prevent satisfying some request, an ordinary
>> error can be misleading.  We make it a warning instead then.
>>=20
>> What if it's a programming error we recover from?
>>=20
>> Aside: trying to recover in a buggy program is risky, but that's not the
>> debate I want to have here.
>>=20
>> How do we want such recoverable programming errors reported?
>>=20
>> Warning?  We seem to be abusing warnings this way, and I hate it.  What
>> we have to report is a *bug*, and we should make that crystal clear.
>> "warning: FunctionYouNeverHeardAbout() failed" does not.  It could be
>> anything, and you likely need to look at the source to find out.
>>=20
>> Ordinary error reporting with "internal error: " prefix, so the user
>> understands this is a bug, and all they can do about it is report it?
>>=20
>> Log the bug somehow?
>>=20
>> Thoughts?
>
> I don't see 'warnings' as something directly actionable for a user.
> Rather they are messages that I would want to see included in a log
> file that a user attaches to a bug report if they find some behavioural
> problem. If the user understands the warning great, but that isn't a
> requirement.
>
> IOW, while informative warnings is of course better than not, as long
> as the warning message contains sufficient info for the maintainer to
> understand what happened the minimum quality bar is satisfied IMHO.

That's a low quality bar indeed.  Here's mine:

1. A warning should make perfectly clear whether this is a bug that
should be reported, or an issue with usage, resources, etc. that can be
ignored, but may help understand future trouble, if any (typically an
ordinary error that wasn't fully handled).  Our errors make bug
vs. ordinary error clear.

2. A warning of the former kind (bug) should provide information
developers need to start debugging.  For errors, we give them a core
dump, source file and line number.  For warnings, we currently give them
grep and warm wishes.

3. A warning of the latter kind (not a bug) should at least try to
provide hints that help users diagnose and correct / work around what's
wrong.  "warning: failed to WSAEventSelect()" doesn't.  "warning:
trouble initializing slirp for user mode networking" might.


