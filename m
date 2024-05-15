Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88A1BC25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 09:17:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7Akw-0008VA-Ao; Wed, 15 May 2024 05:17:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1s7Aku-0008Uc-Kn
 for qemu-devel@nongnu.org; Wed, 15 May 2024 05:17:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1s7Aks-000528-RT
 for qemu-devel@nongnu.org; Wed, 15 May 2024 05:17:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715764618;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZA7YYy2A5qEtXQSMLl4eUoJM2oifOMOfCG7Zlm7tSoE=;
 b=MNItRT0jcbBI6+TwXtaCQECIg58ww/mKUAIzFl5ZOrjqweMBQec9r93mgUlP/GIl5ILTZf
 fodWMTBf2AAYWWG7TV/8HlI5ooses1yoIlKWe6V5RZ6lSPWlEQt9hqTbxNtnjhplJkn3Bc
 /UeeLtVycU4RnMRQXKoi3ivMclLZXFM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-56-3IMqd8OJMxeDz3eUEtn7ng-1; Wed,
 15 May 2024 05:16:54 -0400
X-MC-Unique: 3IMqd8OJMxeDz3eUEtn7ng-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8FF0629AA381;
 Wed, 15 May 2024 09:16:53 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.21])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 22405C15BEE;
 Wed, 15 May 2024 09:16:53 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2E8CB21E66E5; Wed, 15 May 2024 11:16:52 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Peter Xu <peterx@redhat.com>,  Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>,  Gerd Hoffmann <kraxel@redhat.com>,  Fabiano
 Rosas <farosas@suse.de>,  Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,  Ani
 Sinha <anisinha@redhat.com>,  Michael Roth <michael.roth@amd.com>,  Kevin
 Wolf <kwolf@redhat.com>,  Jiri Pirko <jiri@resnulli.us>,  Mads Ynddal
 <mads@ynddal.dk>,  Jason Wang <jasowang@redhat.com>,  Igor Mammedov
 <imammedo@redhat.com>,  Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,  Eduardo Habkost
 <eduardo@habkost.net>,  "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-block@nongnu.org,  Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Victor Toso de Carvalho <victortoso@redhat.com>,  Eric Blake
 <eblake@redhat.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>,  Lukas Straub
 <lukasstraub2@web.de>,  Yanan Wang <wangyanan55@huawei.com>,  Hanna Reitz
 <hreitz@redhat.com>
Subject: Re: [PATCH 03/20] docs/qapidoc: delint a tiny portion of the module
In-Reply-To: <20240514215740.940155-4-jsnow@redhat.com> (John Snow's message
 of "Tue, 14 May 2024 17:57:22 -0400")
References: <20240514215740.940155-1-jsnow@redhat.com>
 <20240514215740.940155-4-jsnow@redhat.com>
Date: Wed, 15 May 2024 11:16:52 +0200
Message-ID: <87h6ezwi2j.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.974,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

> In the coming patches, it's helpful to have a linting baseline. However,
> there's no need to shuffle around the deck chairs too much, because most
> of this code will be removed once the new qapidoc generator (the
> "transmogrifier") is in place.
>
> To ease my pain: just turn off the black auto-formatter for most, but
> not all, of qapidoc.py. This will help ensure that *new* code follows a
> coding standard without bothering too much with cleaning up the existing
> code.
>
> For manual checking for now, try "black --check qapidoc.py" from the
> docs/sphinx directory. "pip install black" (without root permissions) if
> you do not have it installed otherwise.
>
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  docs/sphinx/qapidoc.py | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
>
> diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
> index f270b494f01..1655682d4c7 100644
> --- a/docs/sphinx/qapidoc.py
> +++ b/docs/sphinx/qapidoc.py
> @@ -28,28 +28,30 @@
>  import re
>  
>  from docutils import nodes
> +from docutils.parsers.rst import Directive, directives
>  from docutils.statemachine import ViewList
> -from docutils.parsers.rst import directives, Directive
> -from sphinx.errors import ExtensionError
> -from sphinx.util.nodes import nested_parse_with_titles
> -import sphinx
> -from qapi.gen import QAPISchemaVisitor
>  from qapi.error import QAPIError, QAPISemError
> +from qapi.gen import QAPISchemaVisitor
>  from qapi.schema import QAPISchema
>  
> +import sphinx
> +from sphinx.errors import ExtensionError
> +from sphinx.util.nodes import nested_parse_with_titles
> +

Exchanges old pylint gripe

    docs/sphinx/qapidoc.py:45:4: C0412: Imports from package sphinx are not grouped (ungrouped-imports)

for new gripes

    docs/sphinx/qapidoc.py:37:0: C0411: third party import "import sphinx" should be placed before "from qapi.error import QAPIError, QAPISemError" (wrong-import-order)
    docs/sphinx/qapidoc.py:38:0: C0411: third party import "from sphinx.errors import ExtensionError" should be placed before "from qapi.error import QAPIError, QAPISemError" (wrong-import-order)
    docs/sphinx/qapidoc.py:39:0: C0411: third party import "from sphinx.util.nodes import nested_parse_with_titles" should be placed before "from qapi.error import QAPIError, QAPISemError" (wrong-import-order)

Easy enough to fix.

>  
>  # Sphinx up to 1.6 uses AutodocReporter; 1.7 and later
>  # use switch_source_input. Check borrowed from kerneldoc.py.
> -Use_SSI = sphinx.__version__[:3] >= '1.7'
> +Use_SSI = sphinx.__version__[:3] >= "1.7"
>  if Use_SSI:
>      from sphinx.util.docutils import switch_source_input
>  else:
>      from sphinx.ext.autodoc import AutodocReporter
>  
>  
> -__version__ = '1.0'
> +__version__ = "1.0"
>  
>  
> +# fmt: off

I figure this tells black to keep quiet for the remainder of the file.
Worth a comment, I think.

>  # Function borrowed from pydash, which is under the MIT license
>  def intersperse(iterable, separator):
>      """Yield the members of *iterable* interspersed with *separator*."""

With my comments addressed
Reviewed-by: Markus Armbruster <armbru@redhat.com>


