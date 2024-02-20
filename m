Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A152C5475B
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 15:18:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcRsx-00060N-VG; Tue, 20 Feb 2024 10:18:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rcRsj-0005sy-18
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 10:18:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rcRsg-0005Xb-72
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 10:18:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708442281;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ebjXmKsGT91UkuwrQATBHAXcPrvs+Jw+b4QnQb0mY+o=;
 b=TlrkP/FfcZKvuyOD4Mmg686v0TOj1K+5/hvtVFve0fs6527vE3lvP5xOiwNQiIBZXt/aKC
 TmjCzIsTT9kzklWD6WFWSluQ+fiz/v4HiYNLOMZnKao6Lh9jbLGQiRiaX4cUnhxIAPllA3
 dShszZNI+g9VfeD2UfbG9jPSZRH9jhM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-377-Iuet2MMcMdOKG4vmY6U99g-1; Tue, 20 Feb 2024 10:17:58 -0500
X-MC-Unique: Iuet2MMcMdOKG4vmY6U99g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C4032811E81;
 Tue, 20 Feb 2024 15:17:57 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A163A1C14B0C;
 Tue, 20 Feb 2024 15:17:57 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A576E21E6740; Tue, 20 Feb 2024 16:17:56 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Peter Maydell <peter.maydell@linaro.org>,
 Michael Roth <michael.roth@amd.com>
Subject: Re: [PATCH v3 10/20] qapi: use schema.resolve_type instead of
 schema.lookup_type
In-Reply-To: <20240201224246.39480-11-jsnow@redhat.com> (John Snow's message
 of "Thu, 1 Feb 2024 17:42:36 -0500")
References: <20240201224246.39480-1-jsnow@redhat.com>
 <20240201224246.39480-11-jsnow@redhat.com>
Date: Tue, 20 Feb 2024 16:17:56 +0100
Message-ID: <87h6i35fmj.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
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

> the function lookup_type() is capable of returning None, but some
> callers aren't prepared for that and assume it will always succeed. For
> static type analysis purposes, this creates problems at those callsites.
>
> Modify resolve_type() - which already cannot ever return None - to allow
> 'info' and 'what' parameters to be elided, which infers that the type
> lookup is a built-in type lookup.
>
> Change several callsites to use the new form of resolve_type to avoid
> the more laborious strictly-typed error-checking scaffolding:
>
>   ret = lookup_type("foo")
>   assert ret is not None
>   typ: QAPISchemaType = ret
>
> which can be replaced with the simpler:
>
>   typ = resolve_type("foo")
>
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  scripts/qapi/introspect.py | 4 ++--
>  scripts/qapi/schema.py     | 5 ++---
>  2 files changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py
> index 67c7d89aae0..c38df61a6d5 100644
> --- a/scripts/qapi/introspect.py
> +++ b/scripts/qapi/introspect.py
> @@ -227,10 +227,10 @@ def _use_type(self, typ: QAPISchemaType) -> str:
>  
>          # Map the various integer types to plain int
>          if typ.json_type() == 'int':
> -            typ = self._schema.lookup_type('int')
> +            typ = self._schema.resolve_type('int')
>          elif (isinstance(typ, QAPISchemaArrayType) and
>                typ.element_type.json_type() == 'int'):
> -            typ = self._schema.lookup_type('intList')
> +            typ = self._schema.resolve_type('intList')
>          # Add type to work queue if new
>          if typ not in self._used_types:
>              self._used_types.append(typ)
> diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
> index 573be7275a6..074897ee4fb 100644
> --- a/scripts/qapi/schema.py
> +++ b/scripts/qapi/schema.py
> @@ -650,8 +650,7 @@ def check(self, schema, seen):
>                      "discriminator '%s' is not a member of %s"
>                      % (self._tag_name, base))
>              # Here we do:
> -            base_type = schema.lookup_type(self.tag_member.defined_in)
> -            assert base_type
> +            base_type = schema.resolve_type(self.tag_member.defined_in)
>              if not base_type.is_implicit():
>                  base = "base type '%s'" % self.tag_member.defined_in
>              if not isinstance(self.tag_member.type, QAPISchemaEnumType):
> @@ -1001,7 +1000,7 @@ def lookup_type(self, name):
>          assert typ is None or isinstance(typ, QAPISchemaType)
>          return typ
>  
> -    def resolve_type(self, name, info, what):
> +    def resolve_type(self, name, info=None, what=None):
>          typ = self.lookup_type(name)
>          if not typ:
>              assert info and what  # built-in types must not fail lookup

I still dislike this, but I don't think discussing this more will help.
I can either accept it as the price of all your other work, or come up
with my own solution.

Let's focus on the remainder of the series.


