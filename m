Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BABBDCD8CA4
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 13:37:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWwd9-0008NF-PC; Tue, 09 Jun 2026 09:36:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wWwd7-0008N3-3H
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 09:36:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wWwd5-0003Pm-1C
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 09:36:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781012189;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=By/wLe3LaheVuQx9svV5G6LjUdt9TvmPEWth7bYC3pQ=;
 b=QlddnGgIjK59YB6c5qWUJfAKkwTl7y7zhFn8Vuk+fFlvCVZN0a94rNsiaoDnoQZCQ8CVIk
 0EoJIXe3n8m9GDAzgi4krsNKwkZdORDVtYDpOoynqGYOEdiAZ6m/iCJ1yFtICldEA9KSIn
 +p350SAJq9Fj4inBmNHj1PPoKVG8NvI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-371-lDyDXIxXN_y9KFLXySLZrw-1; Tue,
 09 Jun 2026 09:36:25 -0400
X-MC-Unique: lDyDXIxXN_y9KFLXySLZrw-1
X-Mimecast-MFC-AGG-ID: lDyDXIxXN_y9KFLXySLZrw_1781012184
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1EC02195F157; Tue,  9 Jun 2026 13:36:24 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.28])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 897051800591; Tue,  9 Jun 2026 13:36:23 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 315AC21E6A01; Tue, 09 Jun 2026 15:36:21 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Ani Sinha <anisinha@redhat.com>,  Michael Roth
 <michael.roth@amd.com>,  Igor Mammedov <imammedo@redhat.com>,  Peter
 Maydell <peter.maydell@linaro.org>,  Eric Blake <eblake@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,  Mauro
 Carvalho Chehab
 <mchehab+huawei@kernel.org>,  "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,  Richard Henderson
 <richard.henderson@linaro.org>,  Gerd Hoffmann <kraxel@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 linux-edac@vger.kernel.org, Cleber Rosa <crosa@redhat.com>
Subject: Re: [PATCH v3 11/16] qapi/docs: add rendering for INTRO sections
In-Reply-To: <20260603032201.993015-12-jsnow@redhat.com> (John Snow's message
 of "Tue, 2 Jun 2026 23:21:56 -0400")
References: <20260603032201.993015-1-jsnow@redhat.com>
 <20260603032201.993015-12-jsnow@redhat.com>
Date: Tue, 09 Jun 2026 15:36:21 +0200
Message-ID: <87a4t3omy2.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
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

> Amend the qapidoc generator to handle and render INTRO sections.
>
> The only real difference here from other sections is that we need to
> dedent the text so it renders correctly. Members and Features are also
> indented, but do not require a dedent() because they are always used
> in tandem with an rST construct that forms the start of a new indented
> block; there is coincidental harmony.
>
> Plaintext sections, however, do not start their own block and thus
> need to be dedented to prevent accidentally rendering them as a
> blockquote or a syntax error.
>
> This dedent transformation on the text does not reflow the text, so
> source line information remains accurate, and the "blame" chain of
> custody for sphinx rST parsing error messages continues to be correct
> even through this transformation.
>
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  docs/sphinx/qapidoc.py | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
>
> diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
> index 16ad15fe94f..317dc44b1b8 100644
> --- a/docs/sphinx/qapidoc.py
> +++ b/docs/sphinx/qapidoc.py
> @@ -35,6 +35,7 @@
>  from pathlib import Path
>  import re
>  import sys
> +import textwrap
>  from typing import TYPE_CHECKING
>  
>  from docutils import nodes
> @@ -150,8 +151,15 @@ def add_lines(
>          self,
>          content: str,
>          info: QAPISourceInfo,
> +        dedent: bool = False,
>      ) -> None:
>          lines = content.splitlines(True)
> +
> +        if dedent:
> +            lines = textwrap.dedent(content).splitlines(True)
> +        else:
> +            lines = content.splitlines(True)
> +
>          for i, line in enumerate(lines):
>              self.add_line_raw(line, info.fname, info.line + i)
>  
> @@ -223,13 +231,14 @@ def reformat_arobase(text: str) -> str:
>  
>      # Transmogrification helpers
>  
> -    def visit_paragraph(self, section: QAPIDoc.Section) -> None:
> +    def visit_plaintext(self, section: QAPIDoc.Section) -> None:
>          # Squelch empty paragraphs.
>          if not section.text:
>              return
>  
> +        dedent = bool(section.kind == QAPIDoc.Kind.INTRO)

Could use a comment explaining why INTRO needs to be dedented.

>          self.ensure_blank_line()
> -        self.add_lines(section.text, section.info)
> +        self.add_lines(section.text, section.info, dedent)
>          self.ensure_blank_line()
>  
>      def visit_member(self, section: QAPIDoc.ArgSection) -> None:
> @@ -373,7 +382,7 @@ def visit_sections(self, ent: QAPISchemaDefinition) -> None:
>              section.text = self.reformat_arobase(section.text)
>  
>              if section.kind.name in ("PLAIN", "INTRO"):
> -                self.visit_paragraph(section)
> +                self.visit_plaintext(section)
>              elif section.kind == QAPIDoc.Kind.MEMBER:
>                  assert isinstance(section, QAPIDoc.ArgSection)
>                  if section.name == "q_dummy":


