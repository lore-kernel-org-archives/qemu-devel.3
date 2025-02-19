Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B428DC021B1
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2025 12:49:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkjWI-0000FW-LI; Wed, 19 Feb 2025 07:49:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tkjW7-00009j-AU
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 07:49:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tkjW4-0003Zv-2r
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 07:49:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739969367;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aPDI4jiTmSU82e7BWgbphFniq0WIFbEcpiTJr20KXHY=;
 b=P0CHpwnYvKGozfFZggUR4fKdv9qtkrY2DIX5iFswC91zJcWNsG3eq/p1lUAXnRWnqKdqS5
 qJ5N78FKEh33i9RSd8zZKBRXkfxM1aq/hGx91iAwDSL9gNXV/VHdtDOtKl+8obNMN/akcd
 WMRt3teaNhEftAJBWGmq5TZh2DctKjg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-509-VtDU4v_UMNKPWs1ZXAFKWQ-1; Wed,
 19 Feb 2025 07:49:24 -0500
X-MC-Unique: VtDU4v_UMNKPWs1ZXAFKWQ-1
X-Mimecast-MFC-AGG-ID: VtDU4v_UMNKPWs1ZXAFKWQ_1739969362
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CEC3C18D95EE; Wed, 19 Feb 2025 12:49:21 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.9])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 042551800352; Wed, 19 Feb 2025 12:49:20 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9E14321E6A28; Wed, 19 Feb 2025 13:49:17 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>,  Yanan Wang <wangyanan55@huawei.com>,
 Fabiano Rosas <farosas@suse.de>,  Zhao Liu <zhao1.liu@intel.com>,  Lukas
 Straub <lukasstraub2@web.de>,  Eduardo Habkost <eduardo@habkost.net>,
 Michael Roth <michael.roth@amd.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Peter Xu <peterx@redhat.com>,  Eric Blake
 <eblake@redhat.com>,  Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,  Alex
 =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,  Jason Wang
 <jasowang@redhat.com>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
Subject: Re: [PATCH 29/42] qapi: Add "Details:" disambiguation marker
In-Reply-To: <CAFn=p-ahRX5fULGNn4uCh5aqqKcZoocQiXQEO=xkQAKdNEZAHA@mail.gmail.com>
 (John Snow's message of "Tue, 18 Feb 2025 17:48:09 -0500")
References: <20250205231208.1480762-1-jsnow@redhat.com>
 <20250205231208.1480762-30-jsnow@redhat.com>
 <87h64srcpo.fsf@pond.sub.org>
 <CAFn=p-ahRX5fULGNn4uCh5aqqKcZoocQiXQEO=xkQAKdNEZAHA@mail.gmail.com>
Date: Wed, 19 Feb 2025 13:49:17 +0100
Message-ID: <87v7t62j76.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.191,
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

> On Mon, Feb 17, 2025 at 7:13=E2=80=AFAM Markus Armbruster <armbru@redhat.=
com> wrote:
>
>> John Snow <jsnow@redhat.com> writes:
>>
>> > This clarifies sections that are mistaken by the parser as "intro"
>> > sections to be "details" sections instead.
>> >
>> > Signed-off-by: John Snow <jsnow@redhat.com>
>>
>> This is rather terse.
>>
>
> Mea culpa. I can write more at length if we agree on the general approach.
> For now, you got an RFC as this was the subject of a considerable amount =
of
> controversy between us in the past ... so I am doing baby steps.
>
> "Commit message needs to be hit with the unterseification beam" added to
> tasklist. :)
>
>
>>
>> Why does the boundary between "intro" (previously "body") and "details"
>> matter?  As far as I understand, it matters for inlining.
>>
>
>> What is inlining?
>>
>
>> The old doc generator emits "The members of T" into the argument
>> description in the following cases:
>>
>> * When a command's arguments are given as a type T, the doc comment has
>>   no argument descriptions, and the generated argument description
>>   becomes "The members of T".
>>
>> * When an object type has a base type T, "The members of T" is appended
>>   to the doc comment's (possibly empty) argument descriptions.
>>
>> * For union types, "The members of T when TAG is VALUE" is appended to
>>   the doc comment's argument descriptions for every tag VALUE and
>>   associated type T.
>>
>> We want a description of the members of T right there instead.  To get
>> it right there, we need to inline from T's documentation.
>>
>> What exactly do we need to inline?  Turns out we don't want "intro", we
>> do want the argument descriptions and other stuff we can ignore here.
>>
>> "intro" ends before the argument descriptions, features, or a tagged
>> section, whatever comes first.  Most of the time, this works fine.  But
>> there are a few troublesome cases.  Here's one:
>>
>>     ##
>>     # @MemoryBackendShmProperties:
>>     #
>>     # Properties for memory-backend-shm objects.
>>     #
>>     # This memory backend supports only shared memory, which is the
>>     # default.
>>     #
>>     # Since: 9.1
>>     ##
>>     { 'struct': 'MemoryBackendShmProperties',
>>       'base': 'MemoryBackendProperties',
>>       'data': { },
>>       'if': 'CONFIG_POSIX' }
>>
>> Everything up to "Since:" is "intro".  Consequently, the old doc
>> generator emits "The members of MemoryBackendProperties" right there:
>>
>>     "MemoryBackendShmProperties" (Object)
>>     -------------------------------------
>>
>>     Properties for memory-backend-shm objects.
>>
>>     This memory backend supports only shared memory, which is the defaul=
t.
>>
>>
>>     Members
>>     ~~~~~~~
>>
>>     The members of "MemoryBackendProperties"
>>
>>     Since
>>     ~~~~~
>>
>>     9.1
>>
>>
>>     If
>>     ~~
>>
>>     "CONFIG_POSIX"
>>
>> That's also where the new one inlines.  Okay so far.
>>
>> This gets in turn inlined into ObjectOptions for branch
>> memory-backend-shm.  Since we don't inline "intro", we don't inline
>> "This memory backend supports only shared memory, which is the default."
>> That's a problem.
>>
>
> Yes, this is all correct so far.
>
>
>>
>> This patch moves the boundary between "intro" and the remainder up that
>> paragraph, so we don't lose that line.  It accomplishes that by giving
>> us syntax to manually mark the end of "intro"
>>
>> However, your solution is manual: it gives us the means[*] to mark the
>> boundary with "Details:" to avoid loss of text.  What if we don't
>> notice?  Should we tweak the syntax to force us to be explicit?  How
>> many doc comments would that affect?
>>
>
> I'm leaving that question to you. The calculus I made was that there were
> fewer SLOC changes to explicitly denote the "Details:" sections only in t=
he
> handful of cases where it was (potentially) relevant than to mandate its
> use unconditionally.

How did you determine where it is (potentially) relevant?  Oh, wait ...

>                      If you have an idea that is enforceable at runtime a=
nd
> has fewer SLOC changes, suggest away!
>
> Unseen in this patch is a warning I added to the /inliner/ that identified
> potentially "ambiguous" delineation spots and issued a warning (error); t=
he
> exact code that did this is possibly a little hokey but it was what I used
> to identify the spots addressed by this patch.

... that's how.

> Point being: it's possible to enforce, but I enforced it in qapidoc.py in
> the inliner instead of directly in the parser. We could discuss moving the
> check to the parser if you'd like. The check itself is somewhat "dumb":
>
> - If a doc block has only one *paragraph* (knowingly/intentionally not
> using the term section here) of text, it's assumed to be the intro.

You mean if the "body" has just one paragraph, right?  The "body" is the
first section, always untagged, possibly empty.  It's contains the text
between the line naming the definition and the first tagged section.

The tagged sections are member / argument descriptions, feature
descriptions, 'Returns', 'Errors', 'Since', and 'TODO'.

> - If a doc block has any number of tagged sections, all text above (if an=
y)
> is assumed to be the "intro" and all text below (if any) is assumed to be
> "details".

Uh, this can't be quite right.

Consider:

    ##
    # @query-memory-size-summary:
    #
    # Return the amount of initially allocated and present hotpluggable
    # (if enabled) memory in bytes.
    #
    # .. qmp-example::
    #
    #     -> { "execute": "query-memory-size-summary" }
    #     <- { "return": { "base-memory": 4294967296, "plugged-memory": 0 }=
 }
    #
--> # Since: 2.11
    ##

There is a tagged section.  According to your explanation, the text
above, i.e. everything between @query-memory-size-summary: and Since: is
assumed to be "intro".

According to your patch, which adds "Details:" in the middle, we do not
assume this.  Contradiction.

> It's only in this case that it whines:
>
> - A doc block has *multiple paragraphs* of text at the start of the block,
> but has no other sections and so if there is semantically a "details"
> section or not is unclear to the parser and inliner.

Let's take a step back.  docs/devel/qapi-code-gen.rst:

    Definition documentation starts with a line naming the definition,
    followed by an optional overview, a description of each argument (for
    commands and events), member (for structs and unions), branch (for
    alternates), or value (for enums), a description of each feature (if
    any), and finally optional tagged sections.

Bug: should be "finally optional tagged or untagged sections".

Your generator wants all but 'Since' and 'TODO' together, so it can
render them in a single two-column table.

This description table separates "intro" (above) and "details" (below).
Fair?

Fine and dandy separation unless the description table is *empty*.

Then the "body" (first section, always untagged) extends to the first
'Since', 'TODO', or the end of the doc comment.

Heuristic: when this first untagged section is a single paragraph, we
quietly assume it's "intro".  If it's more than one, we ask the
programmer to mark the end of "intro" explicitly.

Let's see how this works out in practice.  I stick

        if self.symbol and not (self.args or self.features or self.returns =
or self.errors):
            if self.body.text.find('\n\n') =3D=3D -1:
                print(f"{self.info}: single para")
            else:
                print(f"{self.info}: ambiguous")

into QAPIDoc.check().  The outer conditional is true for definition
documentation (doc.symbol) where the table is empty (not ...).  The
inner conditional is a crude check for paragraphs.

This reports 47 "single para" and 8 "ambiguous" in the main QAPI schema
in master.

Your patch hits 5 of 8 ambiguous ones, and throws in a 6th that doesn't
seem to need it:

    ##
    # @query-yank:
    #
    # Query yank instances.  See @YankInstance for more information.
    #
    # Returns: list of @YankInstance
    #
    # .. qmp-example::
    #
    #     -> { "execute": "query-yank" }
    #     <- { "return": [
    #              { "type": "block-node",
    #                "node-name": "nbd0" }
    #          ] }
    #
    # Since: 6.0
    ##

It misses in run-state.json:

    ##
    # @SUSPEND_DISK:
    #
    # Emitted when guest enters a hardware suspension state with data
    # saved on disk, for example, S4 state, which is sometimes called
    # hibernate state
    #
    # .. note:: QEMU shuts down (similar to event @SHUTDOWN) when entering
    #    this state.
    #
    # Since: 1.2
    #
    # .. qmp-example::
    #
    #     <- { "event": "SUSPEND_DISK",
    #          "timestamp": { "seconds": 1344456160, "microseconds": 309119=
 } }
    ##

and in migration.json:

    ##
    # @migrate_cancel:
    #
    # Cancel the current executing migration process.
    #
    # .. note:: This command succeeds even if there is no migration
    #    process running.
    #
    # Since: 0.14
    #
    # .. qmp-example::
    #
    #     -> { "execute": "migrate_cancel" }
    #     <- { "return": {} }
    ##

and in machine.json

    ##
    # @HV_BALLOON_STATUS_REPORT:
    #
    # Emitted when the hv-balloon driver receives a "STATUS" message from
    # the guest.
    #
    # .. note:: This event is rate-limited.
    #
    # Since: 8.2
    #
    # .. qmp-example::
    #
    #     <- { "event": "HV_BALLOON_STATUS_REPORT",
    #          "data": { "committed": 816640000, "available": 3333054464 },
    #          "timestamp": { "seconds": 1600295492, "microseconds": 661044=
 } }
    ##

> The check as I wrote it is unintelligent in that it does not bother to
> check if the doc block it is checking is ever one that *could* be inlined;
> i.e. it will complain about being unable to delineate for commands -- even
> though it wouldn't really matter in that case. It's a potential improveme=
nt
> to the algorithm to ignore cases where that "ambiguity" is not actually
> important.

The ambiguity affects both doc blocks the inliner inlines from and doc
blocks the inliner inlines into.

When inlining from, the inliner omits "intro", and therefore needs to
know where "intro" ends.

When inlining into, the inliner needs to know where to insert the
inlined material.  When the answer is "right after intro", it needs to
know where "intro" ends.

Getting the former wrong loses information.  Getting the latter wrong
may look funny, which is a lot less serious, but still useful to avoid.

> But, it's possible to mechanically enforce and nudge documentation writers
> to add the delineation marker where the parser is uncertain.
>
>> [*] Actually, we have means even before this patch, they're just ugly.
>> See the TODO comment added in commit 14b48aaab92 (qapi: convert
>> "Example" sections without titles)
>
>
> That's right. This is merely a formalization of that hack: I add a
> "section" that is intentionally empty and serves only as a marker to the
> parser to begin recording a new section.

Yes.


Let's take a step back again.

Recall the problem's cause is "empty description table".  Can we enforce
non-empty?

Here's the table's syntactic structure:

    member / argument descriptions *
    ( "Features:" line
       feature descriptions ("features") + ) ?
    "Returns" section ?
    "Errors" section ?

This is slightly more strict than what we actually accept now, but
that's detail.

Consider:

    "Members:" / "Arguments:" line
    member / argument descriptions *
    ( "Features:" line
       feature descriptions ("features") + ) ?
    "Returns" section ?
    "Errors" section ?

With this, the table always starts with a "Members" / "Arguments" line,
and thus cannot be empty.

Drawback: we'd have to add this line to every single definition comment.
The main QAPI schema has almost 1000.  Tolerable?

We could require it only when there are no member / argument
descriptions.  55 instances.

We could require it only when there are none, and our "one paragraph"
heuristic for finding the end of "intro" fails.  8 instances.

You might ask what the difference to your "Details:" proposal is.  There
are two.

1. The keyword(s).  Matter of taste, best discussed last.

2. As coded, your patch accepts "Details:" almost[*] anywhere.
   "Members:" / "Arguments" would be accepted only where member / argument
   descriptions can go, i.e. not after feature descriptions etc.  Consider:

    ##
    # @Enum:
    #
    # @one: The _one_ {and only}, description on the same line
    #
    # Features:
    # @enum-feat: Also _one_ {and only}
    # @enum-member-feat: a member feature
    #
    # Details:
    #
    # @two is undocumented
    ##

   This is accepted, and the "Details:" line gets swallowed.

   I figure tightening the position makes accidents slightly less
   likely.

Here's another way to force non-empty:

    ( "Members: none" / "Arguments: none" line
    | member / argument descriptions * )
    ( "Features:" line
       feature descriptions ("features") + ) ?
    "Returns" section ?
    "Errors" section ?

This is similar to "require it only when there are no member / argument
descriptions" above, except we also accept it only then.  55 instances.

Syntax ideas better than "Members: none" are welcome.

Thoughts?


[*] Not after untagged sections following tagged ones.


