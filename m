Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D7D9CAC599
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 13:26:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyVgR-0007qb-3h; Tue, 16 Sep 2025 09:25:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uyVgL-0007mq-Rv
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 09:25:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uyVgI-0007oS-6c
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 09:25:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758029110;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dVFtiKI5NIKoYN3fi9d+a58tKrtk2d6KlPbFyDogzfg=;
 b=CIaI0k0xvMj4XurFmba9/glUqC+8zWlefzd9GVOWmJIGAjz3KWLrzOQhEbfRI02YXtuOVv
 S3tLgq8AkFEtbIY1GDSUqpl9YECRWJ7V1I0swLc7DYQbwR6CP1n2n5+oUUkba31if2UaBQ
 EtVzrkfSJ7QMMcM+Miv3yuternSNuho=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-466-eG1TDFdZNNGBS-IgSNBe-w-1; Tue,
 16 Sep 2025 09:25:08 -0400
X-MC-Unique: eG1TDFdZNNGBS-IgSNBe-w-1
X-Mimecast-MFC-AGG-ID: eG1TDFdZNNGBS-IgSNBe-w_1758029108
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2ADA218002D6
 for <qemu-devel@nongnu.org>; Tue, 16 Sep 2025 13:25:08 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.9])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D769F19560B8
 for <qemu-devel@nongnu.org>; Tue, 16 Sep 2025 13:25:07 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 32CBF21E6A27; Tue, 16 Sep 2025 15:25:05 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: Abuse of warnings for unhandled errors and programming errors
In-Reply-To: <aMhUxTLiKorN5tjf@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Mon, 15 Sep 2025 19:02:45 +0100")
References: <87h5yijh3b.fsf@pond.sub.org> <aKRuXq0_5ULf5yp-@redhat.com>
 <87frcupny3.fsf@pond.sub.org> <aMhUxTLiKorN5tjf@redhat.com>
Date: Tue, 16 Sep 2025 15:25:05 +0200
Message-ID: <87y0qemswe.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.009,
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

> On Wed, Sep 10, 2025 at 01:05:40PM +0200, Markus Armbruster wrote:
>> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>> > On Fri, Aug 08, 2025 at 11:30:32AM +0200, Markus Armbruster wrote:
>> >
>> > I don't see 'warnings' as something directly actionable for a user.
>> > Rather they are messages that I would want to see included in a log
>> > file that a user attaches to a bug report if they find some behavioural
>> > problem. If the user understands the warning great, but that isn't a
>> > requirement.
>> >
>> > IOW, while informative warnings is of course better than not, as long
>> > as the warning message contains sufficient info for the maintainer to
>> > understand what happened the minimum quality bar is satisfied IMHO.
>>=20
>> That's a low quality bar indeed.  Here's mine:
>>=20
>> 1. A warning should make perfectly clear whether this is a bug that
>> should be reported, or an issue with usage, resources, etc. that can be
>> ignored, but may help understand future trouble, if any (typically an
>> ordinary error that wasn't fully handled).  Our errors make bug
>> vs. ordinary error clear.
>>=20
>> 2. A warning of the former kind (bug) should provide information
>> developers need to start debugging.  For errors, we give them a core
>> dump, source file and line number.  For warnings, we currently give them
>> grep and warm wishes.
>
> Don't understate the value of "grep"  :-)
>
> It is my #1 tool when I see a string mentioned in bug report, whether
> that's from error_report or warn_report.
>
> What annoys/frustrates me is when the message (whether an eror or
> warning) lacks the technical details of exactly what failed.
>
> ie if the message doesn't substitute in either the errno value, or the
> strerror string, or equivalent, then it massively reduces the chances
> of diagnosis unless the bug is easily reproducible.

True.

>> 3. A warning of the latter kind (not a bug) should at least try to
>> provide hints that help users diagnose and correct / work around what's
>> wrong.  "warning: failed to WSAEventSelect()" doesn't.  "warning:
>> trouble initializing slirp for user mode networking" might.
>
> I agree that the latter is more informative for users, though for
> developers it might be worse as such a generic message may provide
> cover for several different low level problems.=20

My two example messages are differently generic :)

The first tells a user nothing, and a developer which function failed.
It doesn't tell what failed.  If we're lucky, only one thing can fail
this way, so finding it is easy enough.  Are we feeling lucky?

The second tells both of them what failed, but doesn't tell the
developer how exactly it failed.

> Neither help me diagnose the problem though if I see them in a bug
> report though, because neither include the "WSAGetLastError()" value
> (or its string equivalent).
>
> Probably we deserve both.

No objection at all as long as the message remains useful to the users.
Remember, this kind of warning is for users first, developers second.
Warnings about bugs are the other way round.

>                           In the case of "Error" objects, we have
> error_prepend so code can do
>
>   error_setg(errp, "failed to WSAEventSelect: %s", WSAGetLastError())
>
> and then the caller one or more levels up the stack can do
>
>   error_prepend(errp, "unable to initialize slirp user mode networking")
>
> which becomes useful when we see the final error_report() or equiv.
>
> We don't have an error_prepend concept for warnings=20

I'm not following.  error_prepend() doesn't care how the error it
modifies will be consumed.  The following should just work:

    error_setg(errp, "failed to WSAEventSelect: %s", WSAGetLastError())
    ... up the stack some ...
    error_prepend(errp, "unable to initialize slirp user mode networking")
    ... up the stack some more ...
    warn_report_err(err);

We even have a convenience function to warn with prepended text:

    error_setg(errp, "failed to WSAEventSelect: %s", WSAGetLastError())
    ... up the stack some ...
    warn_reportf_err(err, "unable to initialize slirp user mode networking:=
 ")


