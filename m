Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F045C54E58
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Mar 2024 14:05:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rl8AJ-0006ki-Oo; Fri, 15 Mar 2024 10:04:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rl8AI-0006ka-3j
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 10:04:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rl8A5-00030A-N7
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 10:04:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710511432;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gmoXN40jJ1wqYZr8b/Isz8+uCD+Smp5XpKdZ6PkylKw=;
 b=Tud8crIstFHkj3/U19cMW507jHnQBpzZZwd584xvN7mK8Eoe08b1b6YMdNUuB9rca1Tmdw
 o1pjsPWIt6m7f+aiCNR8C91Nv/O0e3elmeyG+bx9dKhy9p9dIP73zsYlhkbHnvuo+bquDL
 4Vn6T8xKCTSFXQXx+Lr0kh37p7PErms=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-518-iuiVgA60Oti3680TZecbPw-1; Fri,
 15 Mar 2024 10:03:49 -0400
X-MC-Unique: iuiVgA60Oti3680TZecbPw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 851073C0CF09;
 Fri, 15 Mar 2024 14:03:48 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.138])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 644A910E4B;
 Fri, 15 Mar 2024 14:03:48 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5F6AA21E6A24; Fri, 15 Mar 2024 15:03:47 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Peter Maydell <peter.maydell@linaro.org>,
 Michael Roth <michael.roth@amd.com>
Subject: Re: [PATCH v4 21/23] qapi/schema: add type hints
In-Reply-To: <20240313044127.49089-22-jsnow@redhat.com> (John Snow's message
 of "Wed, 13 Mar 2024 00:41:25 -0400")
References: <20240313044127.49089-1-jsnow@redhat.com>
 <20240313044127.49089-22-jsnow@redhat.com>
Date: Fri, 15 Mar 2024 15:03:47 +0100
Message-ID: <87edcbegn0.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.933,
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

> This patch only adds type hints, which aren't utilized at runtime and
> don't change the behavior of this module in any way.
>
> In a scant few locations, type hints are removed where no longer
> necessary due to inference power from typing all of the rest of
> creation; and any type hints that no longer need string quotes are
> changed.
>
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  scripts/qapi/schema.py | 568 ++++++++++++++++++++++++++++-------------
>  1 file changed, 396 insertions(+), 172 deletions(-)
>
> diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
> index 3b8c2ebbb5f..d2faaea6eac 100644
> --- a/scripts/qapi/schema.py
> +++ b/scripts/qapi/schema.py

[...]

> @@ -1006,18 +1181,27 @@ def _def_definition(self, defn):
>                  defn.info, "%s is already defined" % other_defn.describe())
>          self._entity_dict[defn.name] = defn
>  
> -    def lookup_entity(self, name, typ=None):
> +    def lookup_entity(
> +        self,
> +        name: str,
> +        typ: Optional[type] = None,
> +    ) -> Optional[QAPISchemaEntity]:

Optional[QAPISchemaDefinition], actually.

>          ent = self._entity_dict.get(name)
>          if typ and not isinstance(ent, typ):
>              return None
>          return ent

[...]


