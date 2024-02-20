Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D6ACC5475B
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 15:04:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcRfG-00034E-9C; Tue, 20 Feb 2024 10:04:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rcRfB-00033u-4b
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 10:04:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rcRf8-000375-FY
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 10:04:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708441441;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=78BikkyALO9iFBQ6S0+WLiFPvYMI43HBO7+hazm6yEc=;
 b=dFzUZnPbgeUhJ+UvTJ+P7IUdguMkG2j7dMh80o+f+UfNr2bQtzFv3wXqlX4/2vc2ju50bZ
 pJ72S0RmY+t3PL3gd9WKSJO6c6hBfCfcyg12aHHPexJRYMJ8nLlbyEKs+yd8zr64iAwSXe
 sI5io4sIzyJGKN/lh1s5jTaB9Fi2EaE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-343-2Gto6mXgNEKLblTmvMSzrg-1; Tue, 20 Feb 2024 10:03:57 -0500
X-MC-Unique: 2Gto6mXgNEKLblTmvMSzrg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C164E1078502;
 Tue, 20 Feb 2024 15:03:56 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9E997400D784;
 Tue, 20 Feb 2024 15:03:56 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 983E421E66D0; Tue, 20 Feb 2024 16:03:54 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Peter Maydell <peter.maydell@linaro.org>,
 Michael Roth <michael.roth@amd.com>
Subject: Re: [PATCH v3 14/20] qapi/schema: Don't initialize "members" with
 `None`
In-Reply-To: <20240201224246.39480-15-jsnow@redhat.com> (John Snow's message
 of "Thu, 1 Feb 2024 17:42:40 -0500")
References: <20240201224246.39480-1-jsnow@redhat.com>
 <20240201224246.39480-15-jsnow@redhat.com>
Date: Tue, 20 Feb 2024 16:03:54 +0100
Message-ID: <87y1bf5g9x.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.05,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

> Declare, but don't initialize the "members" field with type
> List[QAPISchemaObjectTypeMember].
>
> This simplifies the typing from what would otherwise be
> Optional[List[T]] to merely List[T]. This removes the need to add
> assertions to several callsites that this value is not None - which it
> never will be after the delayed initialization in check() anyway.
>
> The type declaration without initialization trick will cause accidental
> uses of this field prior to full initialization to raise an
> AttributeError.
>
> (Note that it is valid to have an empty members list, see the internal
> q_empty object as an example. For this reason, we cannot use the empty
> list as a replacement test for full initialization and instead rely on
> the _checked/_checking fields.)
>
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  scripts/qapi/schema.py | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
> index a459016e148..947e7efb1a8 100644
> --- a/scripts/qapi/schema.py
> +++ b/scripts/qapi/schema.py
> @@ -20,7 +20,7 @@
>  from collections import OrderedDict
>  import os
>  import re
> -from typing import List, Optional
> +from typing import List, Optional, cast
>  
>  from .common import (
>      POINTER_SUFFIX,
> @@ -457,7 +457,7 @@ def __init__(self, name, info, doc, ifcond, features,
>          self.base = None
>          self.local_members = local_members
>          self.variants = variants
> -        self.members = None
> +        self.members: List[QAPISchemaObjectTypeMember]
>          self._checking = False
>  
>      def check(self, schema):
> @@ -474,7 +474,7 @@ def check(self, schema):
>  
>          self._checking = True
>          super().check(schema)
> -        assert self._checked and self.members is None
> +        assert self._checked

This asserts state is "2. Being checked:.

The faithful update would be

           assert self._checked and self._checking

Or with my alternative patch

           assert self._checked and not self._check_complete
>  
>          seen = OrderedDict()
>          if self._base_name:
> @@ -491,7 +491,10 @@ def check(self, schema):
>          for m in self.local_members:
>              m.check(schema)
>              m.check_clash(self.info, seen)
> -        members = seen.values()
> +
> +        # check_clash is abstract, but local_members is asserted to be
> +        # List[QAPISchemaObjectTypeMember]. Cast to the narrower type.

What do you mean by "check_clash is abstract"?

> +        members = cast(List[QAPISchemaObjectTypeMember], list(seen.values()))

Do we actually need this *now*, or only later when we have more type
hints?

>  
>          if self.variants:
>              self.variants.check(schema, seen)
> @@ -524,11 +527,9 @@ def is_implicit(self):
>          return self.name.startswith('q_')
>  
>      def is_empty(self):
> -        assert self.members is not None

This asserts state is "3. Checked".

The faithful update would be

           assert self._checked and not self._checking

Or with my alternative patch

           assert self._check_complete

>          return not self.members and not self.variants
>  
>      def has_conditional_members(self):
> -        assert self.members is not None

Likewise.

>          return any(m.ifcond.is_present() for m in self.members)
>  
>      def c_name(self):

This patch does two things:

1. Replace test of self.members (enabled by the previous patch)

2. Drop initialization of self.members and simplify the typing

Observation, not demand.  Wouldn't *mind* a split, though :)


