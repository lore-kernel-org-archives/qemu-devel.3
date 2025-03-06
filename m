Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 254ACC282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 06:54:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tq578-00042i-DK; Thu, 06 Mar 2025 01:53:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tq575-0003xf-FR
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 01:53:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tq573-0007JT-DU
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 01:53:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741244023;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Nsg3fpPFam7SH2iem93Pf/zDmy3zUHwh22w01OCRGQ0=;
 b=BLyhpGR0z1wIcZw7vzEYYLAV7HUTbT0newsHtCaNrHYO6CC+47GKMOJet/j4bR08Ar27+/
 Bknvu7Bv3bXKBDptoGsY0mvwZZXwTmu71VYkFyqBa5zLV3IrhccjVXf11MwON56AGPhfFs
 R5k8oNTxxNT5q0BxPwyoPMXmQy4u8us=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-323-XDayDkruM9-YPJJIkVRKIg-1; Thu,
 06 Mar 2025 01:53:38 -0500
X-MC-Unique: XDayDkruM9-YPJJIkVRKIg-1
X-Mimecast-MFC-AGG-ID: XDayDkruM9-YPJJIkVRKIg_1741244017
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 41F201954B31; Thu,  6 Mar 2025 06:53:37 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.15])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A5B3B1956096; Thu,  6 Mar 2025 06:53:35 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1E7F921E66C1; Thu, 06 Mar 2025 07:53:33 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Michael Roth <michael.roth@amd.com>,  Alex
 =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,  Philippe =?utf-8?Q?Mat?=
 =?utf-8?Q?hieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Peter Maydell <peter.maydell@linaro.org>,  Thomas
 Huth <thuth@redhat.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>
Subject: Re: [PATCH 30/57] qapi/parser: adjust info location for doc body
 section
In-Reply-To: <CAFn=p-YwnFRZwZVL+NmYNs5MZePf9Rwc_To=BCTejuHMiBazzg@mail.gmail.com>
 (John Snow's message of "Wed, 5 Mar 2025 22:42:37 -0500")
References: <20250305034610.960147-1-jsnow@redhat.com>
 <20250305034610.960147-31-jsnow@redhat.com>
 <87bjufokj7.fsf@pond.sub.org>
 <CAFn=p-YwnFRZwZVL+NmYNs5MZePf9Rwc_To=BCTejuHMiBazzg@mail.gmail.com>
Date: Thu, 06 Mar 2025 07:53:33 +0100
Message-ID: <87v7smfy4y.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

John Snow <jsnow@redhat.com> writes:

> On Wed, Mar 5, 2025 at 5:10=E2=80=AFAM Markus Armbruster <armbru@redhat.c=
om> wrote:
>
>> John Snow <jsnow@redhat.com> writes:
>>
>> > Instead of using the info object for the doc block as a whole (which
>> > always points to the very first line of the block), update the info
>> > pointer for each call to ensure_untagged_section when the existing
>> > section is otherwise empty. This way, Sphinx error information will
>> > match precisely to where the text actually starts.
>> >
>> > For example, this patch will move the info pointer for the "Hello!"
>> > untagged section ...
>> >
>> >> ##       <-- from here ...
>> >> # Hello! <-- ... to here.
>> >> ##
>> >
>> > Signed-off-by: John Snow <jsnow@redhat.com>
>>
>> This patch would be easier to accept with a test case where it improves
>> the error location.  I tried to construct one quickly, but failed.  Can
>> you help?
>>
>> Possible substitute: point to a patch later in this series where things
>> become worse without this patch.
>
>
> Maybe we can use the "if build_docs" section of the qapi schema testing to
> run things through Sphinx and harvest the error messages for negative
> cases...? I gotta sit down and figure out how.

Rule of thumb for compilers: every error needs a negative test.  So,
test coverage for transmogrifier errors is certainly wanted, but it's
not a blocker for an initial merge.  We need to make progress, and to
make progress, we need to limit the size of the steps.

> In the meantime, if I unapply my series, then edit block-core to look like
> this:
>
> ##
> # @SnapshotInfo:
> #
> # rST syntax error: *ahh!
> #
>
> (Lines 13-17, error is on line 16)
>
> Building, I get this error:
>
> /home/jsnow/src/qemu/docs/../qapi/block-core.json:14: WARNING: Inline
> emphasis start-string without end-string. [docutils]
> /home/jsnow/src/qemu/docs/../storage-daemon/qapi/../../qapi/block-core.js=
on:14:
> WARNING: Inline emphasis start-string without end-string. [docutils]
>
> Mmm, nope. Not quite.
>
> If I re-push my series and try again with the same edit ...
>
> /home/jsnow/src/qemu/docs/../qapi/block-core.json:14: WARNING: Inline
> emphasis start-string without end-string. [docutils]
> /home/jsnow/src/qemu/docs/../storage-daemon/qapi/../../qapi/block-core.js=
on:14:
> WARNING: Inline emphasis start-string without end-string. [docutils]
> /home/jsnow/src/qemu/docs/../qapi/block-core.json:16: WARNING: Inline
> emphasis start-string without end-string. [docutils]
>
> The two inclusions from the old qapidoc are still wrong, but the inclusion
> through the new transmogrifier is correct.

Reproduced.  To get non-first warnings, you have to configure
--disable-werror.  Observation, not a complaint.

> (I'm going to be honest with you, I don't know why the error location
> didn't change at all for the old qapidoc. I think one of the many error
> location bugs I fixed when writing the new transmogrifier that just never
> got applied to the old system...)

I'm definitely not asking you to find out more :)

> If I undo this fix but keep the rest of my series, I get these errors:
>
> /home/jsnow/src/qemu/docs/../qapi/block-core.json:14: WARNING: Inline
> emphasis start-string without end-string. [docutils]
> /home/jsnow/src/qemu/docs/../storage-daemon/qapi/../../qapi/block-core.js=
on:14:
> WARNING: Inline emphasis start-string without end-string. [docutils]
> /home/jsnow/src/qemu/docs/../qapi/block-core.json:13: WARNING: Inline
> emphasis start-string without end-string. [docutils]
>
> Two are from the old qapidoc, one is from the new one. They're all wrong.

Also reproduced.  Thanks!

Perhaps the patch could be moved closer to where it's needed, or even be
squashed into one the first one that depends it.  Bah, good enough as
is.

Here's my attempt to improve the commit message:

    qapi/parser: adjust info location for doc body section

    Instead of using the info object for the doc block as a whole (which
    always points to the very first line of the block), update the info
    pointer for each call to ensure_untagged_section when the existing
    section is otherwise empty. This way, Sphinx error information will
    match precisely to where the text actually starts.

    For example, this patch will move the info pointer for the "Hello!"
    untagged section ...

        ##       <-- from here ...
        # Hello! <-- ... to here.
        ##

    This doesn't seem to improve error reporting now.  It will with the
    QAPI doc transmogrifier I'm about to add.

    If I stick bad rST into qapi/block-core.json like this

         ##
         # @SnapshotInfo:
         #
        +# rST syntax error: *ahh!
        +#
         # @id: unique snapshot id
         #
         # @name: user chosen name

    the existing code's error message will point to the beginning of the
    doc comment, which is less than helpful.  The transmogrifier's
    message will point to the erroneous line, but to accomplish this, it
    needs this patch.

What do you think?


