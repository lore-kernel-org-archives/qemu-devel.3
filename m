Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A62A2C28B28
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Mar 2025 21:02:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trNmh-0007bx-Oj; Sun, 09 Mar 2025 17:02:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1trNm2-00075V-4b
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 17:01:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1trNm0-00005L-B0
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 17:01:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741554083;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=skz4/oU2hHpyGVagdsmAA9xHOLrSqJIpl3e04FCOq2Q=;
 b=O39KJtLfXHzn4i8umb29h/mEpmWdESLMx91xDdGGeQNc9yBQEH104G1DlGAT7PZuUlW2OP
 asuiVeE4r6HSnTUGBwue96V9/YvUAzZQqIl9VbB8mgTsmQavSW7s5xi8SRtKq+Sh/26ruN
 JDJwiz6VPfJ+Hbo2EMWWf61h0eODihs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-135-GrjjiGjwMJyspgruWAqPpg-1; Sun,
 09 Mar 2025 17:01:21 -0400
X-MC-Unique: GrjjiGjwMJyspgruWAqPpg-1
X-Mimecast-MFC-AGG-ID: GrjjiGjwMJyspgruWAqPpg_1741554080
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4BAB01809CA3; Sun,  9 Mar 2025 21:01:20 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 045E81800945; Sun,  9 Mar 2025 21:01:20 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7413421E675E; Sun, 09 Mar 2025 22:01:17 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 Michael Roth <michael.roth@amd.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Eric Blake <eblake@redhat.com>,  Thomas Huth
 <thuth@redhat.com>,  Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v2 42/62] docs/qapidoc: add visit_freeform() method
In-Reply-To: <20250309083550.5155-43-jsnow@redhat.com> (John Snow's message of
 "Sun, 9 Mar 2025 04:35:29 -0400")
References: <20250309083550.5155-1-jsnow@redhat.com>
 <20250309083550.5155-43-jsnow@redhat.com>
Date: Sun, 09 Mar 2025 22:01:17 +0100
Message-ID: <87frjlzzoi.fsf@pond.sub.org>
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

> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  docs/sphinx/qapidoc.py | 50 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
>
> diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
> index 6de8c900543..cf5dbb0133d 100644
> --- a/docs/sphinx/qapidoc.py
> +++ b/docs/sphinx/qapidoc.py
> @@ -29,6 +29,7 @@
>  from contextlib import contextmanager
>  import os
>  from pathlib import Path
> +import re
>  import sys
>  from typing import TYPE_CHECKING
>  
> @@ -55,6 +56,8 @@
>          Sequence,
>      )
>  
> +    from qapi.parser import QAPIDoc
> +
>      from sphinx.application import Sphinx
>      from sphinx.util.typing import ExtensionMetadata
>  
> @@ -130,6 +133,53 @@ def visit_module(self, path: str) -> None:
>          self.add_line_raw(f".. qapi:module:: {name}", path, 1)
>          self.ensure_blank_line()
>  
> +    def visit_freeform(self, doc: QAPIDoc) -> None:
> +        # TODO: Once the old qapidoc transformer is deprecated, freeform
> +        # sections can be updated to pure rST, and this transformed removed.
> +        #
> +        # For now, translate our micro-format into rST. Code adapted
> +        # from Peter Maydell's freeform().
> +
> +        assert len(doc.all_sections) == 1, doc.all_sections
> +        body = doc.all_sections[0]
> +        text = body.text
> +        info = doc.info
> +
> +        if re.match(r"=+ ", text):
> +            # Section/subsection heading (if present, will always be the
> +            # first line of the block)
> +            (heading, _, text) = text.partition("\n")
> +            (leader, _, heading) = heading.partition(" ")
> +            level = len(leader) + 1  # Implicit +1 for heading in .rST stub

I find "in .rST stub" less than clear.  Could we use the filename?

> +
> +            # https://www.sphinx-doc.org/en/master/usage/restructuredtext/basics.html#sections
> +            markers = {
> +                1: "#",
> +                2: "*",
> +                3: "=",
> +                4: "-",
> +                5: "^",
> +                6: '"',
> +            }

Suggest

               markers = '#*=-^".

> +            overline = level <= 2
> +            marker = markers[level]
> +
> +            self.ensure_blank_line()
> +            # This credits all 2 or 3 lines to the single source line.
> +            if overline:
> +                self.add_line(marker * len(heading), info)
> +            self.add_line(heading, info)
> +            self.add_line(marker * len(heading), info)
> +            self.ensure_blank_line()
> +
> +            # Eat blank line(s) and advance info
> +            trimmed = text.lstrip("\n")
> +            text = trimmed
> +            info = info.next_line(len(text) - len(trimmed) + 1)
> +
> +        self.add_lines(text, info)
> +        self.ensure_blank_line()
> +
>  
>  class QAPISchemaGenDepVisitor(QAPISchemaVisitor):
>      """A QAPI schema visitor which adds Sphinx dependencies each module


