Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8DD6EC01A6
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 08:56:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4b4f-0006Xd-FX; Mon, 23 Mar 2026 04:55:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w4b4W-0006W9-Bs
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 04:55:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w4b4R-0003eN-QP
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 04:55:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774256134;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Mc8SKLnpaGmojrXAO+R+LxB10hvOzoaoROtS2Ock0pQ=;
 b=QhDk6b44VT3VFPA2WYTAXAi1ChmqD/x15lkvwa6Vzb/5nOT6cyzMfYvrB4kt3bAxMY/wNx
 kGu26t1qXleaYpB+K9AtNZ8NTNc5/c8ewNw9cMsyGOyuCWZ3lgkzg15Letxl5j4APgAcPa
 2/t/Vc79S72coipVUGukupzde2ov9wU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-691-45jtarbMP9icDBH3KNTt3g-1; Mon,
 23 Mar 2026 04:55:30 -0400
X-MC-Unique: 45jtarbMP9icDBH3KNTt3g-1
X-Mimecast-MFC-AGG-ID: 45jtarbMP9icDBH3KNTt3g_1774256128
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BA301195608A; Mon, 23 Mar 2026 08:55:27 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.6])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 732AC180035F; Mon, 23 Mar 2026 08:55:26 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1633121E6937; Mon, 23 Mar 2026 09:55:24 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,  Pierrick Bouvier
 <pierrick.bouvier@linaro.org>,  Lukas Straub <lukasstraub2@web.de>,
 Richard Henderson <richard.henderson@linaro.org>,  Zhao Liu
 <zhao1.liu@intel.com>,  Jason Wang <jasowang@redhat.com>,  Mauro Carvalho
 Chehab <mchehab+huawei@kernel.org>,  Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>,
 Peter Xu <peterx@redhat.com>,  Eric Blake <eblake@redhat.com>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Fabiano Rosas
 <farosas@suse.de>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater
 <clg@redhat.com>,  Qemu-block <qemu-block@nongnu.org>,  =?utf-8?Q?Marc-An?=
 =?utf-8?Q?dr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,  Stefan Berger
 <stefanb@linux.vnet.ibm.com>,  Alex Williamson <alex@shazbot.org>,  Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>,  Kevin Wolf <kwolf@redhat.com>,
 Michael Roth <michael.roth@amd.com>,  Stefano Garzarella
 <sgarzare@redhat.com>,  Stefan Hajnoczi <stefanha@redhat.com>,  Igor
 Mammedov <imammedo@redhat.com>,  Jiri Pirko <jiri@resnulli.us>,  Yanan
 Wang <wangyanan55@huawei.com>,  Paolo Bonzini <pbonzini@redhat.com>,
 Kashyap Chamarthy <kchamart@redhat.com>,  Hanna Reitz
 <hreitz@redhat.com>,  Ani Sinha <anisinha@redhat.com>
Subject: Re: [PATCH 3/8] qapi: add "Details:" disambiguation marker
In-Reply-To: <CAFn=p-ZQicGi2CxNsKpk09mvC=KUhDnHnPTb878tKCj_RJiidA@mail.gmail.com>
 (John Snow's message of "Fri, 20 Mar 2026 14:25:11 -0400")
References: <20260316182608.148628-1-jsnow@redhat.com>
 <20260316182608.148628-4-jsnow@redhat.com>
 <87tsua62cz.fsf@pond.sub.org>
 <CAFn=p-ZQicGi2CxNsKpk09mvC=KUhDnHnPTb878tKCj_RJiidA@mail.gmail.com>
Date: Mon, 23 Mar 2026 09:55:24 +0100
Message-ID: <87mrzzylfn.fsf@pond.sub.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

John Snow <jsnow@redhat.com> writes:

> On Fri, Mar 20, 2026, 9:45=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
>> John Snow <jsnow@redhat.com> writes:
>>
>> > When a documentation block consists only of plaintext, there is nothing
>> > to semantically differentiate the "intro" from the "details"
>> > section. For the purposes of the inliner, the intro section is likely =
to
>> > be dropped while the details section will be merged onto the end of the
>> > parent's details section.
>> >
>> > When the delineation between "intro" and "details" is not clear because
>> > there is no intervening "members", "features", "errors", "returns",
>> > "TODO", or "Since" section, the parser assumes the entire text section
>> > is an "intro" section. This may not always be semantically true, so th=
is
>> > patch clarifies certain sections explicitly as "details" sections by
>> > using an empty "Details:" marker.
>> >
>> > Signed-off-by: John Snow <jsnow@redhat.com>
>> > ---
>> >  qapi/block-core.json   | 3 +++
>> >  qapi/machine.json      | 2 +-
>> >  qapi/migration.json    | 8 ++++++--
>> >  qapi/net.json          | 2 +-
>> >  qapi/qom.json          | 4 ++++
>> >  qapi/yank.json         | 2 +-
>> >  scripts/qapi/parser.py | 8 ++++++++
>> >  7 files changed, 24 insertions(+), 5 deletions(-)
>>
>> Missing: update to docs/devel/qapi-code-gen.rst.  Suggest to put in a
>> FIXME, so we don't forget.
>>
>
> ACK
>
>
>> >
>> > diff --git a/qapi/block-core.json b/qapi/block-core.json
>> > index f8d446b3d6e..c5ff15ae7a1 100644
>> > --- a/qapi/block-core.json
>> > +++ b/qapi/block-core.json
>> > @@ -5007,6 +5007,9 @@
>> >  # @blockdev-reopen:
>> >  #
>> >  # Reopens one or more block devices using the given set of options.
>> > +#
>> > +# Details:
>> > +#
>> >  # Any option not specified will be reset to its default value
>> >  # regardless of its previous status.  If an option cannot be changed
>> >  # or a particular driver does not support reopening then the command
>>
>> Rendered documentation before the patch:
>>
>>     Command blockdev-reopen (Since: 6.1)
>>
>>        Reopens one or more block devices using the given set of options.
>>        Any option not specified will be reset to its default value
>>        regardless of its previous status.  If an option cannot be changed
>>        or a particular driver does not support reopening then the command
>>        will return an error.  All devices in the list are reopened in one
>>        transaction, so if one of them fails then the whole transaction is
>>        cancelled.
>>
>>        [...]
>>
>>        Unlike with "blockdev-add", the "backing" option must always be
>>        present unless the node being reopened does not have a backing fi=
le
>>        and its image does not have a default backing file name as part of
>>        its metadata.
>>
>>        Arguments:
>>           * options ([BlockdevOptions]) -- Not documented
>>
>> The command's single argument is undocumented, and the doc generator
>> papered over this (sadly common defect) by splicing in this "Not
>> documented" description.
>>
>> Aside: why not boxed, like blockdev-add?  Design mistake?
>>
>> The patch moves the splice point.  Not wrong, but we should really fill
>> in the document gap instead.
>>
>
> Sure, but I'm worried about other things for the time being. I don't
> disagree but I think I'm the wrong person for intricate doc cleanup work =
of
> that sort.

Put in a TODO for now?

>> > diff --git a/qapi/machine.json b/qapi/machine.json
>> > index 685e4e29b87..bc2279b2526 100644
>> > --- a/qapi/machine.json
>> > +++ b/qapi/machine.json
>> > @@ -1259,7 +1259,7 @@
>> >  # Return the amount of initially allocated and present hotpluggable
>> >  # (if enabled) memory in bytes.
>> >  #
>> > -# TODO: This line is a hack to separate the example from the body
>> > +# Details:
>>
>> This replaces a hack by a proper solution.  More of the same below, not
>> mentioning this again.
>>
>> >  #
>> >  # .. qmp-example::
>> >  #
>> > diff --git a/qapi/migration.json b/qapi/migration.json
>> > index 7134d4ce47e..558b4f145ed 100644
>> > --- a/qapi/migration.json
>> > +++ b/qapi/migration.json
>> > @@ -1633,7 +1633,7 @@
>> >  #
>> >  # Query replication status while the vm is running.
>> >  #
>> > -# TODO: This line is a hack to separate the example from the body
>> > +# Details:
>> >  #
>> >  # .. qmp-example::
>> >  #
>> > @@ -1651,6 +1651,8 @@
>> >  #
>> >  # Xen uses this command to notify replication to trigger a checkpoint.
>> >  #
>> > +# Details:
>> > +#
>> >  # .. qmp-example::
>> >  #
>> >  #     -> { "execute": "xen-colo-do-checkpoint" }
>>
>> No change to generated documentation.  I guess this is needed to avoid
>> the yelping added in the next patch.  Correct?
>>
>
> Yes, probably. I didn't differentiate the cases...
>
>
>> > @@ -1687,7 +1689,7 @@
>> >  #
>> >  # Query COLO status while the vm is running.
>> >  #
>> > -# TODO: This line is a hack to separate the example from the body
>> > +# Details:
>> >  #
>> >  # .. qmp-example::
>> >  #
>> > @@ -1724,6 +1726,8 @@
>> >  #
>> >  # Pause a migration.  Currently it only supports postcopy.
>> >  #
>> > +# Details:
>> > +#
>> >  # .. qmp-example::
>> >  #
>> >  #     -> { "execute": "migrate-pause" }
>>
>> Likewise?
>>
>> > diff --git a/qapi/net.json b/qapi/net.json
>> > index 118bd349651..c011d6dc1a9 100644
>> > --- a/qapi/net.json
>> > +++ b/qapi/net.json
>> > @@ -1070,7 +1070,7 @@
>> >  # switches.  This can be useful when network bonds fail-over the
>> >  # active slave.
>> >  #
>> > -# TODO: This line is a hack to separate the example from the body
>> > +# Details:
>> >  #
>> >  # .. qmp-example::
>> >  #
>> > diff --git a/qapi/qom.json b/qapi/qom.json
>> > index 1b47abd44e9..568b7d4b997 100644
>> > --- a/qapi/qom.json
>> > +++ b/qapi/qom.json
>> > @@ -777,6 +777,8 @@
>> >  #
>> >  # Properties for memory-backend-shm objects.
>> >  #
>> > +# Details:
>> > +#
>> >  # This memory backend supports only shared memory, which is the
>> >  # default.
>> >  #
>>
>> Rendered documentation changes from
>>
>>     Object MemoryBackendShmProperties (Since: 9.1)
>>         Availability: CONFIG_POSIX
>>
>>        Properties for memory-backend-shm objects.
>>
>>        This memory backend supports only shared memory, which is the
>>        default.
>>
>>        Members:
>>           * The members of MemoryBackendProperties.
>>
>> to
>>
>>     Object MemoryBackendShmProperties (Since: 9.1)
>>         Availability: CONFIG_POSIX
>>
>>        Properties for memory-backend-shm objects.
>>
>>        Members:
>>           * The members of MemoryBackendProperties.
>>
>>        This memory backend supports only shared memory, which is the
>>        default.
>>
>> Feels like a wash.
>>
>> I guess we need a "Details:" somewhere to avoid yelping.  Correct?
>>
>
> If we choose to formally include the yelper patch. I included it to show
> all of the cases where this *might* make a difference.
>
> There's likely other heuristics we could employ to reduce how often we
> yelp. For instance, things that are never inlined from, or never inline,
> could likely be skipped as it won't make a difference.
>
> I think the trick here is to come up with a blanket "rule" that makes sen=
se
> and is easy to understand for the uninitiated, even if that rule covers
> more cases than strictly necessary.

Yes.

I think it's better to keep the rules around "Details:" as simple as
possible, even if that means we have to write it more often.  The
decision whether and where to write it should be as obvious as we can
make it.  The less obvious is it, the more often we'll get it wrong[*].

> This patch used a very broad algorithm with almost no edge cases to yelp.
>
> Concern: if I do not make the parser yelp, we may see new cases added in
> the future that render in unintended ways. If I make the yelper too yelpy,
> it's just annoying without providing sufficient benefit.

Yes, this is still an open problem.

> Truth is likely in the middle somewhere. This patch is an effort to find
> and flush out that truth by brute force.

Good.

>> > @@ -792,6 +794,8 @@
>> >  #
>> >  # Properties for memory-backend-epc objects.
>> >  #
>> > +# Details:
>> > +#
>> >  # The @merge boolean option is false by default with epc
>> >  #
>> >  # The @dump boolean option is false by default with epc
>>
>> Similar change to rendered documentation, same request to confirm
>> yelping.
>>
>> > diff --git a/qapi/yank.json b/qapi/yank.json
>> > index f3cd5c15d60..2854a8a9d2a 100644
>> > --- a/qapi/yank.json
>> > +++ b/qapi/yank.json
>> > @@ -104,7 +104,7 @@
>> >  #
>> >  # Query yank instances.  See `YankInstance` for more information.
>> >  #
>> > -# TODO: This line is a hack to separate the example from the body
>> > +# Details:
>> >  #
>> >  # .. qmp-example::
>> >  #
>>
>> [Skipping the Python code in my first pass...]
>>
>> I'd be tempted to split the patch into hack replacement and yelping
>> avoidance.
>>
>
> ACK, I can do that. It will take a moment to audit which cause real html
> output changes and which are solely yelp avoidance, but it can be done.

Thanks!

> Note that some changes may appear to be yelp avoidance only without the
> inliner active. Some cases *may* produce tangible differences with the
> inliner active.
>
> I don't have an example at hand or a method currently to identify them,
> it's just a heads up for the possibility.


[*] A glance at rendered documentation should catch most instances of
wrong, but in developers generally don't do that.


