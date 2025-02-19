Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54C79C021B0
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2025 13:22:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkk2A-00086I-MW; Wed, 19 Feb 2025 08:22:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tkk22-00085w-7J
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 08:22:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tkk1y-0000Os-UX
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 08:22:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739971339;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mrBq7vVvwUZ0lOt2AajAT57ihoANfpxJ+icSBGDFbeM=;
 b=XMlZXtzYaTwd1bWbSh5b1rQJqRTqprCIDjV4jiGO1A9RWhc/h65ytAnm57YhS2cqydk1QK
 SeVk/+KrCpHDJ+6UU/AJ/aBGv7Xl3icG/zpg6X5Qc69diNzm6dbw1kPzJ6ITCPAhA0PTrE
 R9OR7pKyeurp5Uru6TLYsEG+hDYJk/0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-627-C9AuU2XeM_OqySQW7sUZVg-1; Wed,
 19 Feb 2025 08:22:13 -0500
X-MC-Unique: C9AuU2XeM_OqySQW7sUZVg-1
X-Mimecast-MFC-AGG-ID: C9AuU2XeM_OqySQW7sUZVg_1739971332
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 40CBE190F9DF; Wed, 19 Feb 2025 13:22:12 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.9])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6320419560B9; Wed, 19 Feb 2025 13:22:11 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id CB1BA21E6A28; Wed, 19 Feb 2025 14:22:08 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>,  qemu-devel@nongnu.org,  Peter
 Maydell <peter.maydell@linaro.org>,  Thomas Huth <thuth@redhat.com>,
 Yanan Wang <wangyanan55@huawei.com>,  Fabiano Rosas <farosas@suse.de>,
 Zhao Liu <zhao1.liu@intel.com>,  Lukas Straub <lukasstraub2@web.de>,
 Eduardo Habkost <eduardo@habkost.net>,  Michael Roth
 <michael.roth@amd.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Peter
 Xu <peterx@redhat.com>,  Eric Blake <eblake@redhat.com>,  Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>,  Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>,
 Jason Wang <jasowang@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH 00/42] docs: add sphinx-domain rST generator to qapidoc
In-Reply-To: <CAFn=p-adsVRfMhwEst8iX57OOzNDjLkRHg2SQO7+jLuzfx78fw@mail.gmail.com>
 (John Snow's message of "Tue, 18 Feb 2025 15:01:06 -0500")
References: <20250205231208.1480762-1-jsnow@redhat.com>
 <87wmds4tpk.fsf@pond.sub.org>
 <CAFn=p-adsVRfMhwEst8iX57OOzNDjLkRHg2SQO7+jLuzfx78fw@mail.gmail.com>
Date: Wed, 19 Feb 2025 14:22:08 +0100
Message-ID: <874j0q2hof.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
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

> "The text handler you add looks just like the existing latex handler. Does
> LaTeX output lack "little headings", too?"
>
> Yes, almost certainly. Can you let me know which output formats we actual=
ly
> "care about"? I'll have to test them all.

As far as I can tell, our build system runs sphinx-build -b html and -b
man.

I run it with -b text manually all the time to hunt for and review
changes in output.  I'd prefer to keep it working if practical.

For what it's worth, there is a bit of LaTeX configuration in
docs/conf.py.

>                                           In the meantime, I upgraded my
> patch so that the text translator properly handles branches with headings
> that delineate the different branches so that the text output is fully
> reasonable. I will need to do the same for any format we care about.
>
> I've re-pushed as of "about 30 minutes before I wrote this email" --
> https://gitlab.com/jsnow/qemu/-/commits/sphinx-domain-blergh2
>
> This branch includes the text generator fixes (which technically belong
> with the predecessor series we skipped, but I'll refactor that later.)
> it also includes fixes to the branch inliner, generated return statements,
> and generated out-of-band feature sections.

I'll fetch it, thanks!

> (Long story short: inserting new sections in certain spots was broken
> because of cache. Oops. We can discuss more why I wrote that part of the
> code like I did in review for the patch that introduced that problem. It's
> the "basic inliner" patch.)
>
> Below, I'm going to try a new communication approach where I explicitly s=
ay
> if I have added something to my tasklist or not so that it's clear to you
> what I believe is actionable (and what I am agreeing to change) and what I
> believe needs stronger input from you before I do anything. Apologies if =
it
> seems a little robotic, just trying new things O:-)
>
> On that note: not added to tasklist: do we need the LaTeX handler? Do we
> need any others? Please confirm O:-)

See above.

> On Fri, Feb 14, 2025 at 7:05=E2=80=AFAM Markus Armbruster <armbru@redhat.=
com> wrote:
>
>> I started to eyeball old and new generated output side by side.
>>
>> New table of contents shows one level, old two.  No objection; the
>> navigation thingie on the left is more useful anyway.
>>
>
> Unintentional, but if you like it, it's fine by me. Nothing added to my
> tasklist.

Mention in a commit message.

>> The new generator elides unreferenced types.  Generally good, but two
>> observations:
>>
>> * QapiErrorClass is unreferenced, but its members are mentioned in
>>   Errors sections.  QapiErrorClass serves as better than nothing error
>>   code documentation, but it's gone in the new doc.  So this is a minor
>>   regression.  We can figure out what to do about it later.
>>
>
> Right. I debated making the members references to that class, but recalled
> that you disliked this class and figured you'd not like such a change, so=
 I
> just left it alone. I do not have cross-references for individual members
> of objects at all yet anyway, so this is definitely more work regardless.
>
> We could always create a pragma of some sort (or just hardcode a list) of
> items that must be documented regardless of if they're referenced or not.
> Please let me know your preference and I will add a "ticket" on my person=
al
> tasklist for this project to handle that at /some point/. Nothing added to
> my tasklist just yet.

Suggest to add something like "compensate for the loss of QapiErrorClass
documentation in the QEMU QMP Reference Manual".

>> * Section "QMP errors" is empty in the new doc, because its entire
>>   contents is elided.  I guess we should elide the section as well, but
>>   it's fine to leave that for later.
>>
>
> Adding to tasklist to elide empty modules, but "for later".

ACK

>> Old doc shows a definition's since information like any other section.
>> New doc has it in the heading box.  Looks prettier and uses much less
>> space.  Not sure the heading box is the best place, but it'll do for
>> now, we can always move it around later.
>>
>
> Agree, it's a strict improvement - there may be further improvements, but
> that is always true anyway. When we tackle "autogenerated since
> information" we can tackle the since display issues more meticulously. Or
> maybe we'll need do sooner because of conflicting info in branches or
> whatever else. I dunno, I'll burn that bridge when I get to it. Nothing
> added to tasklist.

ACK

>> The new doc's headings use "Struct" or "Union" where the old one uses
>> just "Object".  Let's keep "Object", please.
>>
>
> I was afraid you'd ask for this. OK, I think it's an easy change. Can I
> keep the index page segmented by object type still, though?
>
> I do find knowing the *type* of object to be helpful as a developer,

Can you explain why and how struct vs. union matters to you as a
developer?

>                                                                      thou=
gh
> I understand that from the point of view of a QMP user, they're all just
> objects, so your request makes sense.

I'd prefer a single index.

> Replace JSON object type headers with "Object" instead of QAPI data types
> added to tasklist.

ACK

>> In the new doc, some member references are no longer rendered as such,
>> e.g. @on-source-error and @on-target-error in BackupCommon's note.
>> Another small regression.
>>
>
> Ah, I actually knew this one. I didn't implement special formatting for
> these yet. I do not have cross-references for individual members, so
> there's nothing to transform these *into* yet. If you'd like special
> rendering for them (fixed width, no link?) that's easy to accomplish. I am
> not yet sure where I will do that conversion.

Suggest the render them the same as before.

Have a look at BackupCommon's "Note" box in the old docs: the member
names appear to use a fixed-width font.

Peeking at old qapidoc.py...  it seems to rewrite @foo to ``foo``.

> Reminder/Note that in my KVM Forum branch, I did actually replace all
> @references that pointed to something actually cross-referenceable with an
> actual sphinx cross-reference, leaving only @member references behind.
>
> Nothing added to tasklist just yet.
>
>
>>
>> Union branches are busted in the new generator's output.  I know they
>> used to work, so I'm not worried about it.
>>
>
> Fixed in new push, sorry! An embarrassing mistake that took me aeons to
> spot.
>
>
>>
>> The new doc shows the return type, the old doc doesn't.  Showing it is
>> definitely an improvement, but we need to adjust the doc text to avoid
>> silliness like "Returns: SnapshotInfo =E2=80=93 SnapshotInfo".
>>
>
> My KVM Forum branch actually corrected the QAPI documentation to remove
> pointless returns. I didn't include that with this series yet, it was long
> enough. This issue will be addressed solely through source documentation
> edits, of which I believe I already have a comprehensive patch for.
>
> Added to my tasklist: "Submit source documentation patches to remove
> pointless return documentation"

ACK

> It was my intent to submit those patches *afterwards*, but we can always =
do
> it before if you'd like. Let me know. (I don't know offhand how easy they
> are to extricate from my KVM Forum branch. I reserve the right to change =
my
> mind on being flexible depending on the answer there :p)

No need to decide or extricate right now.  Tasklist is good enough for
me.

>> The new doc shows Arguments / Members, Returns, and Errors in two-column
>> format.  Looks nice.  But for some reason, the two columns don't align
>> horizontally for Errors like they do for the others.  Certainly not a
>> blocker of anything, but we should try to fix it at some point.
>>
>
> Known issue. The reason is because we do not mandate a source documentati=
on
> format for errors - by convention, it is a list. There is (or was?) one
> occurrence where it wasn't a list and I wrote a patch to change that. I
> don't recall right now if we merged that or not. The misalignment is a
> result of nesting a list inside of a list.

Commit b32a6b62a82 (qapi: nail down convention that Errors sections are
lists)

> If we *mandate* the source format, I gain the ability to "peel off the
> nesting", which will fix the alignment.

"Mandate" means changing "should be formatted as an rST list" into "must
be", plus enforcement.  Works for me.

> Added to tasklist: "Address vertical misalignment in Errors formatting"

ACK, low priority.

> Not added: how? need more input from you, please.
>
>
>>
>> The new doc doesn't show non-definition conditionals, as mentioned in
>> the cover letter.  It shows definition conditionals twice.  Once should
>> suffice.
>>
>
> Known/intentional issue. I couldn't decide where I wanted it, so I put it
> in both places. If you have a strong opinion right now, please let me know
> what it is and I'll take care of it, it's easy - but it's code in the
> predecessor series and nothing to do with qapidoc, so please put it out of
> mind for now.
>
> If you don't have strong feelings, or you feel that the answer may depend
> on how we solve other glaring issues (non-definition conditionals), let's
> wait a little bit before making a decision.
>
> Added to tasklist: "Remove the duplication of definition conditionals";
> left unspecified is how or in what direction :)

ACK

I'll try to make up my mind :)

>> There's probably more, but this is it for now.
>>
>>
>
> Tasklist:
>
>  For the qapi-domain (prequel!) series:
>   - Remove the duplication of definition conditionals
>
> For this (qapidoc) series:
>   - Display all JSON object types as "Object" and not as their QAPI data
> type.
>
> For later:
>   - Elide empty modules
>   - Submit source documentation patches to remove pointless return
> documentation
>   - Address vertical misalignment in Errors formatting


