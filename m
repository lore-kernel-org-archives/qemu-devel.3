Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1331C48BC4
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 10:48:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcNfW-00015s-Cs; Tue, 20 Feb 2024 05:48:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rcNfU-00015N-Uw
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 05:48:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rcNfT-0003Mt-J4
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 05:48:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708426086;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=n4SRXVYTF2i4hxkK4ATJMZJI5cunzwqbBxYLJsp3UfY=;
 b=cbdstMF/e7eKQ9pMvo0wWoFMGLQ9xU+RWjZ0cxuTsiZ8dxsOyrjIyKdGY8JypG/TYl9+K0
 O1gvP1k2IMpywV2xU7piMNhh4tRnfbyMPqRwJ2oZa/djcAtShBdnuQ14/b1As1wa4XH+92
 VeZF68XH2wAolZQszsj9nnXBO/zKUvY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-270-vJf74tV0MRmPgv9fNfgp4g-1; Tue, 20 Feb 2024 05:48:03 -0500
X-MC-Unique: vJf74tV0MRmPgv9fNfgp4g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AD4F8185A780;
 Tue, 20 Feb 2024 10:48:02 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8A0FE2166AE9;
 Tue, 20 Feb 2024 10:48:02 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7C7E621E66C8; Tue, 20 Feb 2024 11:48:01 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Peter Maydell <peter.maydell@linaro.org>,
 Michael Roth <michael.roth@amd.com>
Subject: Re: [PATCH v3 09/20] qapi/schema: assert resolve_type has 'info'
 and 'what' args on error
In-Reply-To: <20240201224246.39480-10-jsnow@redhat.com> (John Snow's message
 of "Thu, 1 Feb 2024 17:42:35 -0500")
References: <20240201224246.39480-1-jsnow@redhat.com>
 <20240201224246.39480-10-jsnow@redhat.com>
Date: Tue, 20 Feb 2024 11:48:01 +0100
Message-ID: <87v86jbee6.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
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

> resolve_type() is generally used to resolve configuration-provided type
> names into type objects, and generally requires valid 'info' and 'what'
> parameters.
>
> In some cases, such as with QAPISchemaArrayType.check(), resolve_type
> may be used to resolve built-in types and as such will not have an
> 'info' argument, but also must not fail in this scenario.
>
> Use an assertion to sate mypy that we will indeed have 'info' and 'what'
> parameters for the error pathway in resolve_type.
>
> Note: there are only three callsites to resolve_type at present where
> "info" is perceived to be possibly None:

Who is the perceiver?  mypy?

>
>     1) QAPISchemaArrayType.check()
>     2) QAPISchemaObjectTypeMember.check()
>     3) QAPISchemaEvent.check()
>
>     Of those three, only the first actually ever passes None; the other two
>     are limited by their base class initializers which accept info=None, but
>     neither subclass actually use a None value in practice, currently.
>
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  scripts/qapi/schema.py | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
> index e617abb03af..573be7275a6 100644
> --- a/scripts/qapi/schema.py
> +++ b/scripts/qapi/schema.py
> @@ -1004,6 +1004,7 @@ def lookup_type(self, name):
>      def resolve_type(self, name, info, what):
>          typ = self.lookup_type(name)
>          if not typ:
> +            assert info and what  # built-in types must not fail lookup
>              if callable(what):
>                  what = what(info)
>              raise QAPISemError(
<


