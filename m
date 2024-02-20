Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1D0AC48BC4
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 10:40:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcNXe-0003td-32; Tue, 20 Feb 2024 05:40:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rcNXd-0003t0-1w
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 05:40:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rcNXb-0001ZD-N9
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 05:40:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708425598;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7hKvs+fss1yJdd3AvC/xvyy2p8z9mPMyaHhYj3g0/YY=;
 b=ipOgkI/HMKBNwvjaLNZhgqmxj+EmaR2MTSdULdaKHedz9Aer5nWK8I5SrM2FMlhv0HJ0Pr
 BXsDvyiEi9pnr5vRoOOFfWo3qTjwYj5r2UVOmvdUT92v2AAgg+tfwCCRnK8sBAZkQ+IqWd
 HI/FkHQpQb7TEGzWUA5kUMOSlZqPc2o=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-374-r-abOaYPP0yeVwxzFfF9LA-1; Tue, 20 Feb 2024 05:39:55 -0500
X-MC-Unique: r-abOaYPP0yeVwxzFfF9LA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C292B86F122;
 Tue, 20 Feb 2024 10:39:54 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A041F492BC6;
 Tue, 20 Feb 2024 10:39:54 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A2D1121E66D0; Tue, 20 Feb 2024 11:39:53 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Peter Maydell <peter.maydell@linaro.org>,
 Michael Roth <michael.roth@amd.com>
Subject: Re: [PATCH v3 08/20] qapi/schema: add type narrowing to lookup_type()
In-Reply-To: <20240201224246.39480-9-jsnow@redhat.com> (John Snow's message of
 "Thu, 1 Feb 2024 17:42:34 -0500")
References: <20240201224246.39480-1-jsnow@redhat.com>
 <20240201224246.39480-9-jsnow@redhat.com>
Date: Tue, 20 Feb 2024 11:39:53 +0100
Message-ID: <87zfvvberq.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.072,
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

> This function is a bit hard to type as-is; mypy needs some assertions to
> assist with the type narrowing.
>
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  scripts/qapi/schema.py | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
> index 043ee7556e6..e617abb03af 100644
> --- a/scripts/qapi/schema.py
> +++ b/scripts/qapi/schema.py
> @@ -997,7 +997,9 @@ def lookup_entity(self, name, typ=None):
       def lookup_entity(self, name, typ=None):
           ent = self._entity_dict.get(name)
           if typ and not isinstance(ent, typ):
               return None
>          return ent
>  
>      def lookup_type(self, name):
> -        return self.lookup_entity(name, QAPISchemaType)
> +        typ = self.lookup_entity(name, QAPISchemaType)
> +        assert typ is None or isinstance(typ, QAPISchemaType)
> +        return typ
>  
>      def resolve_type(self, name, info, what):
>          typ = self.lookup_type(name)

I figure the real trouble-maker is .lookup_entity().

When not passed an optional type argument, it returns QAPISchemaEntity.

When passed an optional type argument, it returns that type or None.

Too cute for type hints to express, I guess.

What if we drop .lookup_entity()'s optional argument?  There are just
three callers:

1. .lookup_type(), visible above.  

       def lookup_type(self, name):
           ent = self.lookup_entity(name)
           if isinstance(ent, QAPISchemaType):
               return ent
           return None

    This should permit typing it as -> Optional[QAPISchemaType] without
    further ado.

2. ._make_implicit_object_type() below

   Uses .lookup_type() to check whether the implicit object type already
   exists.  We figure we could

           typ = self.lookup_entity(name)
           if typ:
               assert(isinstance(typ, QAPISchemaObjectType))
               # The implicit object type has multiple users.  This can

3. QAPIDocDirective.run() doesn't pass a type argument, so no change.

Thoughts?

If you'd prefer not to rock the boat for this series, could it still
make sense as a followup?


