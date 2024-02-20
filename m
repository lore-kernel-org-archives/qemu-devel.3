Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11451C5475B
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 13:30:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcQBt-00024r-Cl; Tue, 20 Feb 2024 08:29:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rcQBf-00023p-2q
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 08:29:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rcQBd-0000yr-9g
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 08:29:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708435768;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=msqOxMmBZMJYvWdOz1JEBqBlNI1V12lAmU701UTeeVs=;
 b=LXrhiTcC9wPNZD7QFvF1+6F5Oe/5VE7S2vosu5RAzsLXIAsgteATAiRzZcS4HBXXxEC6P9
 jSdMba2Pu4mj07HmRlY4cJ1Z+6yd8VxTUu3OgDqpl/4H8hbucNpL4pz/HRUvCGQ0FwZRnB
 w+xPkbuk4UlbYW06yzkD3O+oq3EnX00=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-450-4_mIIIPEMmmX1cIluQ_kAw-1; Tue, 20 Feb 2024 08:29:26 -0500
X-MC-Unique: 4_mIIIPEMmmX1cIluQ_kAw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6AD2A83B86F;
 Tue, 20 Feb 2024 13:29:26 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 202C620229A4;
 Tue, 20 Feb 2024 13:29:26 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 02C7C21E66D5; Tue, 20 Feb 2024 14:29:24 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Peter Maydell <peter.maydell@linaro.org>,
 Michael Roth <michael.roth@amd.com>
Subject: Re: [PATCH v3 13/20] qapi/schema: split "checked" field into
 "checking" and "checked"
In-Reply-To: <20240201224246.39480-14-jsnow@redhat.com> (John Snow's message
 of "Thu, 1 Feb 2024 17:42:39 -0500")
References: <20240201224246.39480-1-jsnow@redhat.com>
 <20240201224246.39480-14-jsnow@redhat.com>
Date: Tue, 20 Feb 2024 14:29:23 +0100
Message-ID: <87cysr9scs.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.05,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

> Instead of using the None value for the members field, use a dedicated
> "checking" value to detect recursive misconfigurations.
>
> This is intended to assist with subsequent patches which will seek to
> remove the "None" value from the members field (which can never be set
> legally after the final call to check()) in order to simplify static
> typing of that field, by avoiding needing assertions littered at many
> callsites.
>
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  scripts/qapi/schema.py | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
> index d4d3c3bbcee..a459016e148 100644
> --- a/scripts/qapi/schema.py
> +++ b/scripts/qapi/schema.py
> @@ -458,19 +458,21 @@ def __init__(self, name, info, doc, ifcond, features,
>          self.local_members = local_members
>          self.variants = variants
>          self.members = None
> +        self._checking = False
>  
>      def check(self, schema):
>          # This calls another type T's .check() exactly when the C
>          # struct emitted by gen_object() contains that T's C struct
>          # (pointers don't count).
> -        if self.members is not None:
> -            # A previous .check() completed: nothing to do
> -            return
> -        if self._checked:
> +        if self._checking:
>              # Recursed: C struct contains itself
>              raise QAPISemError(self.info,
>                                 "object %s contains itself" % self.name)
> +        if self._checked:
> +            # A previous .check() completed: nothing to do
> +            return

The diff would be easier to read if you could keep the order...  You
don't due to the subtle change of the state predicates.  More on that
below.

>  
> +        self._checking = True
>          super().check(schema)
>          assert self._checked and self.members is None
>  
> @@ -495,7 +497,8 @@ def check(self, schema):
>              self.variants.check(schema, seen)
>              self.variants.check_clash(self.info, seen)
>  
> -        self.members = members  # mark completed
> +        self.members = members
> +        self._checking = False  # mark completed
>  
>      # Check that the members of this type do not cause duplicate JSON members,
>      # and update seen to track the members seen so far. Report any errors

We .check() entities on after the other.  *Except*
QAPISchemaObjectType.check() "calls another type T's .check() exactly
when the C struct emitted by gen_object() contains that T's C struct".
If the recursion loops, the schema asks for C structs containing
themselves.  To catch this, we have QAPISchemaType objects go through
three states:

1. Not yet checked.

2. Being checked; object.check() is on the call stack.

3. Checked, i.e. object.check() completed.

How to recognize the states before the patch:

1. not ._checked and .members is None

2. ._checked and .members is None

3. ._checked and .members is not None

   Since .members is not None implies .checked, we simply use
   .members is not None.

We go from state 1. to 2. in super().check().

We go from state 2. to 3. at # mark completed.

Note that .checked becomes true well before we finish checking.  This is
admittedly confusing.  If you can think of a less confusing name, ...

The patch's aim is to avoid use of .members, to enable the next patch.

I don't doubt that your solution works, but trying to understand how it
works makes my tired brain go owww!

State invariants (I think):

1. not ._checked and .members is None and not ._checking

2. ._checked and .members is None and ._checking

3. ._checked and .members is not None and not ._checking

We can then recognize states without use of .members:

1. not ._checked and not ._checking

   Since not ._checked implies not .checking, we can simply use
   not ._checked.

2. ._checked and ._checking

   A deliciously confusing predicate, isn't it?

3. ._checked and not ._checking

Deep breath...  alright, here's the stupidest replacement for use of
.members that could possibly work: add a flag, ensure it's True exactly
when .members is not None.  Like this:

diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
index d4d3c3bbce..095831baf2 100644
--- a/scripts/qapi/schema.py
+++ b/scripts/qapi/schema.py
@@ -458,12 +458,13 @@ def __init__(self, name, info, doc, ifcond, features,
         self.local_members = local_members
         self.variants = variants
         self.members = None
+        self._check_complete = False
 
     def check(self, schema):
         # This calls another type T's .check() exactly when the C
         # struct emitted by gen_object() contains that T's C struct
         # (pointers don't count).
-        if self.members is not None:
+        if self._check_complete:
             # A previous .check() completed: nothing to do
             return
         if self._checked:
@@ -495,7 +496,8 @@ def check(self, schema):
             self.variants.check(schema, seen)
             self.variants.check_clash(self.info, seen)
 
-        self.members = members  # mark completed
+        self.members = members
+        self._check_complete = True  # mark completed
 
     # Check that the members of this type do not cause duplicate JSON members,
     # and update seen to track the members seen so far. Report any errors


Thoughts?


