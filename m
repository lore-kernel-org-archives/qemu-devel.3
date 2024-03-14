Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6824C54E60
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Mar 2024 13:59:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rklbC-0000wE-5j; Thu, 14 Mar 2024 09:58:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rklb9-0000vq-Jc
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 09:58:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rklb8-0004QJ-0U
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 09:58:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710424694;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s+REjrBfqXfR/fb3olzXZvn2DYLroPvl7g+gFKMh8AM=;
 b=SZQGD4OO4JEG5ZAJUCic6IRgzvZJNsmSu/y9CQfet8Hv4JiVQUKRJmfijEUGKd734RsdJ2
 r1drYS0mWvMt16goIYwQuBz9KsY//zMsjCvDtUeX86RioS77xvr7zcegZCKkf6mwgGrKKK
 BYPGg3niZBxdSEd/x3sjskK1HTtXHlM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-91-EdswRYeDOwy1luuLQK48Mg-1; Thu,
 14 Mar 2024 09:58:11 -0400
X-MC-Unique: EdswRYeDOwy1luuLQK48Mg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A014E3800BAA;
 Thu, 14 Mar 2024 13:58:10 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.138])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 68A67492BD0;
 Thu, 14 Mar 2024 13:58:10 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6DE5121E6A24; Thu, 14 Mar 2024 14:58:09 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,  Peter Maydell
 <peter.maydell@linaro.org>,  Michael Roth <michael.roth@amd.com>
Subject: Re: [PATCH v4 16/23] qapi/schema: Don't initialize "members" with
 `None`
In-Reply-To: <CAFn=p-Z9Y_wOn8H9qusrD8vHsvyseEZfLn67uo4JpMgjzt9-yQ@mail.gmail.com>
 (John Snow's message of "Thu, 14 Mar 2024 09:35:59 -0400")
References: <20240313044127.49089-1-jsnow@redhat.com>
 <20240313044127.49089-17-jsnow@redhat.com>
 <87a5n19dce.fsf@pond.sub.org>
 <CAFn=p-Z9Y_wOn8H9qusrD8vHsvyseEZfLn67uo4JpMgjzt9-yQ@mail.gmail.com>
Date: Thu, 14 Mar 2024 14:58:09 +0100
Message-ID: <87msr09aq6.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.987,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

> On Thu, Mar 14, 2024, 9:01=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
>> John Snow <jsnow@redhat.com> writes:
>>
>> > Declare, but don't initialize the "members" field with type
>> > List[QAPISchemaObjectTypeMember].
>> >
>> > This simplifies the typing from what would otherwise be
>> > Optional[List[T]] to merely List[T]. This removes the need to add
>> > assertions to several callsites that this value is not None - which it
>> > never will be after the delayed initialization in check() anyway.
>> >
>> > The type declaration without initialization trick will cause accidental
>> > uses of this field prior to full initialization to raise an
>> > AttributeError.
>> >
>> > (Note that it is valid to have an empty members list, see the internal
>> > q_empty object as an example. For this reason, we cannot use the empty
>> > list as a replacement test for full initialization and instead rely on
>> > the _checked/_check_complete fields.)
>> >
>> > Signed-off-by: John Snow <jsnow@redhat.com>
>> > ---
>> >  scripts/qapi/schema.py | 12 +++++++-----
>> >  1 file changed, 7 insertions(+), 5 deletions(-)
>> >
>> > diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
>> > index 50ebc4f12de..fb30314741a 100644
>> > --- a/scripts/qapi/schema.py
>> > +++ b/scripts/qapi/schema.py
>> > @@ -20,7 +20,7 @@
>> >  from collections import OrderedDict
>> >  import os
>> >  import re
>> > -from typing import List, Optional
>> > +from typing import List, Optional, cast
>> >
>> >  from .common import (
>> >      POINTER_SUFFIX,
>> > @@ -449,7 +449,7 @@ def __init__(self, name, info, doc, ifcond, featur=
es,
>> >          self.base =3D None
>> >          self.local_members =3D local_members
>> >          self.variants =3D variants
>> > -        self.members =3D None
>> > +        self.members: List[QAPISchemaObjectTypeMember]
>> >          self._check_complete =3D False
>> >
>> >      def check(self, schema):
>> > @@ -482,7 +482,11 @@ def check(self, schema):
>> >          for m in self.local_members:
>> >              m.check(schema)
>> >              m.check_clash(self.info, seen)
>> > -        members =3D seen.values()
>> > +
>> > +        # check_clash works in terms of the supertype, but local_memb=
ers
>> > +        # is asserted to be List[QAPISchemaObjectTypeMember].
>>
>> Do you mean "but self.members is declared as
>> List[QAPISchemaObjectTypeMember]"?
>
> Argh. I meant asserted in the linguistic sense. mypy asserts it to be; not
> a runtime assertion.
>
> I do this a lot, apparently.

Okay to adjust your comment to my version?

[...]


