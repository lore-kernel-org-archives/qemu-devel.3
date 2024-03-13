Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28375C54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 06:57:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkIYH-0007p8-Pi; Wed, 13 Mar 2024 02:57:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rkIYB-0007op-Ul
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 02:57:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rkIY8-0001jq-98
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 02:57:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710313035;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cZ42ak4GGnXvuXQ5DCu1OrYp4XI1jnHSj0uxXYyjwQc=;
 b=PIWgC6uQz9OOgOtro6CjSxnYxKpsvUm3NzxWHAA5HnldLrHcBmMg+LX29pOX2lEOxDNHNR
 rqHXhLFgB5+fgSZvyyR07cDWjMtCrwQ5AEBTElG48bCeSdCwL5ygu+P64vy6+8vsuirbhy
 HgIBadsVkd6qyQzT92R3VQ0IhXkbW1Y=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-647-7ODwfB0zN7OMgp6qr_tTnQ-1; Wed,
 13 Mar 2024 02:57:11 -0400
X-MC-Unique: 7ODwfB0zN7OMgp6qr_tTnQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8880D380052A;
 Wed, 13 Mar 2024 06:57:11 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.138])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 477112024517;
 Wed, 13 Mar 2024 06:57:11 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1ED5821E6A24; Wed, 13 Mar 2024 07:57:10 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Peter Maydell <peter.maydell@linaro.org>,
 Michael Roth <michael.roth@amd.com>
Subject: Re: [PATCH v3 14/20] qapi/schema: Don't initialize "members" with
 `None`
In-Reply-To: <CAFn=p-Yb935TK-FmKtun+wWPjZjMYPOAivHOLUQK0hZr64Gh1w@mail.gmail.com>
 (John Snow's message of "Tue, 12 Mar 2024 17:10:53 -0400")
References: <20240201224246.39480-1-jsnow@redhat.com>
 <20240201224246.39480-15-jsnow@redhat.com>
 <87y1bf5g9x.fsf@pond.sub.org>
 <CAFn=p-Yb935TK-FmKtun+wWPjZjMYPOAivHOLUQK0hZr64Gh1w@mail.gmail.com>
Date: Wed, 13 Mar 2024 07:57:10 +0100
Message-ID: <87cyryipq1.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
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

> On Tue, Feb 20, 2024 at 10:03=E2=80=AFAM Markus Armbruster <armbru@redhat=
.com> wrote:
>>
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
>> > the _checked/_checking fields.)
>> >
>> > Signed-off-by: John Snow <jsnow@redhat.com>
>> > ---
>> >  scripts/qapi/schema.py | 13 +++++++------
>> >  1 file changed, 7 insertions(+), 6 deletions(-)
>> >
>> > diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
>> > index a459016e148..947e7efb1a8 100644
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
>> > @@ -457,7 +457,7 @@ def __init__(self, name, info, doc, ifcond, featur=
es,
>> >          self.base =3D None
>> >          self.local_members =3D local_members
>> >          self.variants =3D variants
>> > -        self.members =3D None
>> > +        self.members: List[QAPISchemaObjectTypeMember]
>> >          self._checking =3D False
>> >
>> >      def check(self, schema):
>> > @@ -474,7 +474,7 @@ def check(self, schema):
>> >
>> >          self._checking =3D True
>> >          super().check(schema)
>> > -        assert self._checked and self.members is None
>> > +        assert self._checked
>>
>> This asserts state is "2. Being checked:.
>>
>> The faithful update would be
>>
>>            assert self._checked and self._checking
>>
>> Or with my alternative patch
>>
>>            assert self._checked and not self._check_complete
>> >
>> >          seen =3D OrderedDict()
>> >          if self._base_name:
>> > @@ -491,7 +491,10 @@ def check(self, schema):
>> >          for m in self.local_members:
>> >              m.check(schema)
>> >              m.check_clash(self.info, seen)
>> > -        members =3D seen.values()
>> > +
>> > +        # check_clash is abstract, but local_members is asserted to be
>> > +        # List[QAPISchemaObjectTypeMember]. Cast to the narrower type.
>>
>> What do you mean by "check_clash is abstract"?
>>
>> > +        members =3D cast(List[QAPISchemaObjectTypeMember], list(seen.=
values()))
>>
>> Do we actually need this *now*, or only later when we have more type
>> hints?
>>
>> >
>> >          if self.variants:
>> >              self.variants.check(schema, seen)
>> > @@ -524,11 +527,9 @@ def is_implicit(self):
>> >          return self.name.startswith('q_')
>> >
>> >      def is_empty(self):
>> > -        assert self.members is not None
>>
>> This asserts state is "3. Checked".
>>
>> The faithful update would be
>>
>>            assert self._checked and not self._checking
>>
>> Or with my alternative patch
>>
>>            assert self._check_complete
>>
>> >          return not self.members and not self.variants
>> >
>> >      def has_conditional_members(self):
>> > -        assert self.members is not None
>>
>> Likewise.
>
> Do we even need these assertions, though? If members isn't set, it's
> gonna crash anyway. I don't think you actually need them at all. I
> think it's fine to leave these changes in this patch and to remove the
> assertion as it no longer really guards anything.

When I wrote my review comment, my mind was running on "mechanical
transformation" rails: "the faithful update would be".  The "in state 3"
predicate is .members is not None before the patch, and ._check_complete
afterwards.

You're right, the assertion no longer guards.  It can at best aid
understanding the code.  Feel free to drop it.

Would it make sense to explain the transformation of the "in state N"
predicates briefly in the commit message?

>> >          return any(m.ifcond.is_present() for m in self.members)
>> >
>> >      def c_name(self):
>>
>> This patch does two things:
>>
>> 1. Replace test of self.members (enabled by the previous patch)
>>
>> 2. Drop initialization of self.members and simplify the typing
>>
>> Observation, not demand.  Wouldn't *mind* a split, though :)
>>
>
> I think maybe one of the assertions can be replaced in the previous
> patch, but I think everything else does really belong in this patch.

My observation is that this patch could be split in two, not that parts
of it belong to the previous patch.


