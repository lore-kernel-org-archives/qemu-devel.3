Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C65C1C19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 12:18:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqWef-0000Rh-17; Fri, 07 Mar 2025 07:18:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tqWeb-0000MH-I1
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 07:18:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tqWeZ-00081G-Ns
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 07:18:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741349890;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=llWegreVUaqKEHHrBlqHJqyLjZo2sMER7PUq0gteNpw=;
 b=Q7e4kQLQxEVeoDa3dAdqMurt1L0LlTxYXYEluazF3enle30LzhKPQh64N8KPQLpOZd2+m4
 PlNG1AdDqXGkYfnkZKjDNEOmZez5UF8A2I4SGCnFsZh7HRUfvLwN3LbecuYkQEaOPuxvWq
 RzCC6OD5hg4xrVhkgAvbms1cWlT58DY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-117-7DMENGppOpyGhedGlTeMWw-1; Fri,
 07 Mar 2025 07:18:08 -0500
X-MC-Unique: 7DMENGppOpyGhedGlTeMWw-1
X-Mimecast-MFC-AGG-ID: 7DMENGppOpyGhedGlTeMWw_1741349887
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7C91818E651C; Fri,  7 Mar 2025 12:18:05 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.15])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1ADD61809B6D; Fri,  7 Mar 2025 12:18:05 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4AAD021E675E; Fri, 07 Mar 2025 13:18:02 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Michael Roth <michael.roth@amd.com>,  Alex
 =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,  Philippe =?utf-8?Q?Mat?=
 =?utf-8?Q?hieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Peter Maydell <peter.maydell@linaro.org>,  Thomas
 Huth <thuth@redhat.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>
Subject: Re: [PATCH 48/57] docs/qapidoc: add visit_returns() method
In-Reply-To: <20250305034610.960147-49-jsnow@redhat.com> (John Snow's message
 of "Tue, 4 Mar 2025 22:45:57 -0500")
References: <20250305034610.960147-1-jsnow@redhat.com>
 <20250305034610.960147-49-jsnow@redhat.com>
Date: Fri, 07 Mar 2025 13:18:02 +0100
Message-ID: <877c51japx.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

> Generates :returns: fields for explicit returns statements. Note that
> this does not presently handle undocumented returns, which is handled in
> a later commit.
>
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  docs/sphinx/qapidoc.py | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
> index 834f12ba6e9..6458790fe55 100644
> --- a/docs/sphinx/qapidoc.py
> +++ b/docs/sphinx/qapidoc.py
> @@ -41,6 +41,7 @@
>  from qapi.schema import (
>      QAPISchema,
>      QAPISchemaArrayType,
> +    QAPISchemaCommand,
>      QAPISchemaDefinition,
>      QAPISchemaEnumMember,
>      QAPISchemaFeature,
> @@ -210,6 +211,20 @@ def visit_feature(self, section: QAPIDoc.ArgSection) -> None:
>  
>          self.generate_field("feat", section.member, section.text, section.info)
>  
> +    def visit_returns(self, section: QAPIDoc.Section) -> None:
> +        assert isinstance(self.entity, QAPISchemaCommand)
> +        rtype = self.entity.ret_type
> +        # q_empty can produce None, but we won't be documenting anything
> +        # without an explicit return statement in the doc block, and we
> +        # should not have any such explicit statements when there is no
> +        # return value.
> +        assert rtype
> +
> +        typ = self.format_type(rtype)
> +        assert typ
> +        assert section.text  # We don't expect empty returns sections.

Not sure the comment is worth its keep.  Up to you.

> +        self.add_field("returns", typ, section.text, section.info)
> +
>      def visit_errors(self, section: QAPIDoc.Section) -> None:
>          # FIXME: the formatting for errors may be inconsistent and may
>          # or may not require different newline placement to ensure


