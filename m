Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C78ACC282DE
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 12:26:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqWmF-0002hX-Ve; Fri, 07 Mar 2025 07:26:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tqWmD-0002ei-P9
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 07:26:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tqWm9-000509-8W
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 07:26:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741350360;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1Po6Bqsh/tcYtP6Jwx513/ICY3quw06/CSvaZKWs8M8=;
 b=Yn0XsIYzQuTDVZ4fn5EeiUNo1zNFWqpSNH86yo+YLHpLLBzvN7rCTHRxA8VMsxQ+Hf08QT
 S4V6u3xN1AvYv4RScWz0cSEm1MXqJJwUTBc7Qayvlsak+yy0Rzvmh9/xF78i68NVxAC6R6
 54nPIwLCuPHexSLv8AGVxdXzNK2bHA8=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-522-aFijUbxpPby_pAip8_WHFQ-1; Fri,
 07 Mar 2025 07:25:57 -0500
X-MC-Unique: aFijUbxpPby_pAip8_WHFQ-1
X-Mimecast-MFC-AGG-ID: aFijUbxpPby_pAip8_WHFQ_1741350356
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 46CE71956087; Fri,  7 Mar 2025 12:25:56 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.15])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C26321956095; Fri,  7 Mar 2025 12:25:55 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 405FC21E675F; Fri, 07 Mar 2025 13:25:53 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Michael Roth <michael.roth@amd.com>,  Alex
 =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,  Philippe =?utf-8?Q?Mat?=
 =?utf-8?Q?hieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Peter Maydell <peter.maydell@linaro.org>,  Thomas
 Huth <thuth@redhat.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>
Subject: Re: [PATCH 50/57] docs/qapidoc: add visit_sections() method
In-Reply-To: <20250305034610.960147-51-jsnow@redhat.com> (John Snow's message
 of "Tue, 4 Mar 2025 22:45:59 -0500")
References: <20250305034610.960147-1-jsnow@redhat.com>
 <20250305034610.960147-51-jsnow@redhat.com>
Date: Fri, 07 Mar 2025 13:25:53 +0100
Message-ID: <87wmd1hvse.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

> Implement the actual main dispatch method that processes and handles the
> list of doc sections for a given QAPI entity.
>
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  docs/sphinx/qapidoc.py | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>
> diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
> index ed0269af27d..7308fa0a767 100644
> --- a/docs/sphinx/qapidoc.py
> +++ b/docs/sphinx/qapidoc.py
> @@ -288,6 +288,31 @@ def preamble(self, ent: QAPISchemaDefinition) -> None:
>  
>          self.ensure_blank_line()
>  
> +    def visit_sections(self, ent: QAPISchemaDefinition) -> None:
> +        sections = ent.doc.all_sections if ent.doc else []
> +
> +        # Add sections *in the order they are documented*:

Is the order important, or just a matter of style?

> +        for section in sections:
> +            if section.kind == QAPIDoc.Kind.PLAIN:
> +                self.visit_paragraph(section)
> +            elif section.kind == QAPIDoc.Kind.MEMBER:
> +                assert isinstance(section, QAPIDoc.ArgSection)
> +                self.visit_member(section)
> +            elif section.kind == QAPIDoc.Kind.FEATURE:
> +                assert isinstance(section, QAPIDoc.ArgSection)
> +                self.visit_feature(section)
> +            elif section.kind in (QAPIDoc.Kind.SINCE, QAPIDoc.Kind.TODO):
> +                # Since is handled in preamble, TODO is skipped intentionally.
> +                pass
> +            elif section.kind == QAPIDoc.Kind.RETURNS:
> +                self.visit_returns(section)
> +            elif section.kind == QAPIDoc.Kind.ERRORS:
> +                self.visit_errors(section)
> +            else:
> +                assert False
> +
> +        self.ensure_blank_line()
> +
>      # Transmogrification core methods
>  
>      def visit_module(self, path: str) -> None:


