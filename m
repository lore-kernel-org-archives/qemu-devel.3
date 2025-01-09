Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF73EE77197
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 08:01:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVnTB-0007V7-Vg; Thu, 09 Jan 2025 03:00:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tVnT8-0007Ux-RB
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 03:00:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tVnT4-0005Iu-10
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 03:00:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736409636;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7yjJuauq7x2OldAm+jaA68Jr/YS6BukR/kZE0GH2y0A=;
 b=eIzcNgC1wffX6it3g1WuhMCJNNyOQPHcLl57eRBdNyKqfo+SmwU61JBJzkwTGv1U0FFRPi
 8mmAl4GrKBu/W3dH60ZkG+/CJR6wMabFUdMRQ0WjN/aCI2j/4P+gSji8q2PlXe17Gy/uoh
 W0JMW32dH6PYQeHAzcDZJuMVxrev/Pk=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-383-EbznLtnrNamxzqm8nKHVNg-1; Thu,
 09 Jan 2025 03:00:33 -0500
X-MC-Unique: EbznLtnrNamxzqm8nKHVNg-1
X-Mimecast-MFC-AGG-ID: EbznLtnrNamxzqm8nKHVNg
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3435D19560AB; Thu,  9 Jan 2025 08:00:32 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.194.101])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1867A19560AD; Thu,  9 Jan 2025 08:00:31 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id CF44821E6924; Thu, 09 Jan 2025 09:00:28 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Peter Maydell <peter.maydell@linaro.org>,
 Michael Roth <michael.roth@amd.com>
Subject: Re: [PATCH 09/23] qapi/source: allow multi-line QAPISourceInfo
 advancing
In-Reply-To: <CAFn=p-YBsJBNFWrX=XLF1TaWPjSA5kNhg3spf83Cw9_JnS2_pw@mail.gmail.com>
 (John Snow's message of "Wed, 8 Jan 2025 16:18:07 -0500")
References: <20241213021827.2956769-1-jsnow@redhat.com>
 <20241213021827.2956769-10-jsnow@redhat.com>
 <87h66y4hgl.fsf@pond.sub.org>
 <CAFn=p-YBsJBNFWrX=XLF1TaWPjSA5kNhg3spf83Cw9_JnS2_pw@mail.gmail.com>
Date: Thu, 09 Jan 2025 09:00:28 +0100
Message-ID: <87plkwto0z.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.432,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

John Snow <jsnow@redhat.com> writes:

> On Fri, Dec 20, 2024 at 8:22=E2=80=AFAM Markus Armbruster <armbru@redhat.=
com> wrote:
>
>> John Snow <jsnow@redhat.com> writes:
>>
>> > This is for the sake of the new rST generator (the "transmogrifier") so
>> > we can advance multiple lines on occasion while keeping the
>> > generated<-->source mappings accurate.
>> >
>> > next_line now simply takes an optional n parameter which chooses the
>> > number of lines to advance.
>> >
>> >
>> > RFC: Here's the exorbitant detail on why I want this:
>> >
>> > This is used mainly when converting section syntax in free-form
>> > documentation to more traditional rST section header syntax, which
>> > does not always line up 1:1 for line counts.
>> >
>> > For example:
>> >
>> > ```
>> >  ##
>> >  # =3D Section     <-- Info is pointing here, "L1"
>> >  #
>> >  # Lorem Ipsum
>> >  ##
>> > ```
>> >
>> > would be transformed to rST as:
>> >
>> > ```
>> > =3D=3D=3D=3D=3D=3D=3D        <-- L1
>> > Section        <-- L1
>> > =3D=3D=3D=3D=3D=3D=3D        <-- L1
>> >                <-- L2
>> > Lorem Ipsum    <-- L3
>> > ```
>>
>> I can't help to wonder...  Could we simply use rST markup instead?
>>
>> "Later", "maybe later", or even "please ask me later" would be perfectly
>> acceptable answers.
>>
>
> Yeah, I'd be happy with that, I just didn't want to add more complexity to
> the pile so I went for what I felt was "simplest":

Avoiding mission creep is good.

> - Leave source syntax alone
> - Copy and modify the existing freeform doc parser
> - Quickly allow for multi-line advancing where it appeared to be importan=
t.
>
> Modifying freeform syntax to be purely rST that isn't modified or rewritt=
en
> at all has benefits:
>
> - No need to mangle or multiplex source line source information
> - Less code
> - More straightforward
>
> I'm quite happy to do it later, is there some kind of "ticket" system you=
'd
> tolerate using for tracking nits for cleanup? I *will* forget if we don't
> listify and track them, I'm sorry (but wise enough) to admit. I just don't
> want to get sidetracked on little side-quests right now. (Quite prone to
> this...)

TODO comment in code this would obviously kill?  Not exactly a ticket
system...

scripts/qapi/TODO?  Still not a ticket system...

Other ideas?

>> > After consuming the single "Section" line from the source, we want to
>> > advance the source pointer to the next non-empty line which requires
>> > jumping by more than one line.
>> >
>> > Signed-off-by: John Snow <jsnow@redhat.com>
>> > ---
>> >  scripts/qapi/source.py | 4 ++--
>> >  1 file changed, 2 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/scripts/qapi/source.py b/scripts/qapi/source.py
>> > index 7b379fdc925..ffdc3f482ac 100644
>> > --- a/scripts/qapi/source.py
>> > +++ b/scripts/qapi/source.py
>> > @@ -47,9 +47,9 @@ def set_defn(self, meta: str, name: str) -> None:
>> >          self.defn_meta =3D meta
>> >          self.defn_name =3D name
>> >
>> > -    def next_line(self: T) -> T:
>> > +    def next_line(self: T, n: int =3D 1) -> T:
>> >          info =3D copy.copy(self)
>> > -        info.line +=3D 1
>> > +        info.line +=3D n
>> >          return info
>> >
>> >      def loc(self) -> str:
>>
>> Assuming we need this:
>> Reviewed-by: Markus Armbruster <armbru@redhat.com>
>
> Thanks! We can always drop stuff later if we wind up not needing it, it's
> just a means to an end.

Yes, and this one isn't exactly a complexity bomb :)


