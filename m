Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9549C71155
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Jun 2025 12:36:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uR946-0002mv-Tr; Mon, 16 Jun 2025 08:35:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uR943-0002kY-1F
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 08:35:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uR93y-0007YD-D1
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 08:35:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750077344;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hy/vp6MtoVC4uXmqOjzpDo6sBKOhpU9PSaFLc1s35wk=;
 b=h4CTgrqxUI43LtyCFMqe0aeujH/BvNpNaUFH4vUzL5rqARKKkcN2XM8dQxcNFTUoD1ee4e
 k+ZVV75saRkremONWzTbOP8ZN4MnzvtG1jdrG580bqzfm8bqSyrF2Zt3aicQjG/YkWYuiK
 6F/FQUw5cKTTt4+nzjBAYL5OUmyRfLs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-695-3jNI20xhOa-OWt7qedpKdA-1; Mon,
 16 Jun 2025 08:35:40 -0400
X-MC-Unique: 3jNI20xhOa-OWt7qedpKdA-1
X-Mimecast-MFC-AGG-ID: 3jNI20xhOa-OWt7qedpKdA_1750077338
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8220C195609F; Mon, 16 Jun 2025 12:35:37 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.11])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E4154195608F; Mon, 16 Jun 2025 12:35:35 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 74A9921E6A27; Mon, 16 Jun 2025 14:35:33 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Zhenwei Pi <pizhenwei@bytedance.com>,  Stefan
 Berger <stefanb@linux.vnet.ibm.com>,  Jiri Pirko <jiri@resnulli.us>,  Ani
 Sinha <anisinha@redhat.com>,  Jason Wang <jasowang@redhat.com>,  Mads
 Ynddal <mads@ynddal.dk>,  Zhao Liu <zhao1.liu@intel.com>,  Eduardo Habkost
 <eduardo@habkost.net>,  Kashyap Chamarthy <kchamart@redhat.com>,  Peter
 Maydell <peter.maydell@linaro.org>,  Hanna Reitz <hreitz@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,  Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-block@nongnu.org,  Igor Mammedov <imammedo@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?=
 Lureau <marcandre.lureau@redhat.com>,  Eric Blake <eblake@redhat.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,  Lukas Straub
 <lukasstraub2@web.de>,  Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,  Vladimir Sementsov-Ogievskiy
 <vsementsov@yandex-team.ru>,  Fan Ni <fan.ni@samsung.com>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Peter Xu
 <peterx@redhat.com>,  Alex
 =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,  Paolo Bonzini
 <pbonzini@redhat.com>,
 Yanan Wang <wangyanan55@huawei.com>,  Stefano Garzarella
 <sgarzare@redhat.com>,  Alex Williamson <alex.williamson@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,  Jonathan Cameron
 <jonathan.cameron@huawei.com>,  =?utf-8?Q?C=C3=A9dric?= Le Goater
 <clg@redhat.com>,
 Michael Roth <michael.roth@amd.com>,  Kevin Wolf <kwolf@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Konstantin
 Kostiuk <kkostiuk@redhat.com>,  Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v2 3/3] docs: remove special parsing for freeform sections
In-Reply-To: <20250612221051.1224565-4-jsnow@redhat.com> (John Snow's message
 of "Thu, 12 Jun 2025 18:10:51 -0400")
References: <20250612221051.1224565-1-jsnow@redhat.com>
 <20250612221051.1224565-4-jsnow@redhat.com>
Date: Mon, 16 Jun 2025 14:35:33 +0200
Message-ID: <87wm9bg8yy.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.892,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 WEIRD_QUOTING=0.001 autolearn=unavailable autolearn_force=no
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

> This change removes special parsing for freeform sections and allows
> them to simply be unmodified rST syntax. The existing headings in the
> QAPI schema are adjusted to reflect the new paradigm.
>
> Signed-off-by: John Snow <jsnow@redhat.com>

[...]

> diff --git a/docs/devel/qapi-code-gen.rst b/docs/devel/qapi-code-gen.rst
> index 231cc0fecf7..dfdbeac5a5a 100644
> --- a/docs/devel/qapi-code-gen.rst
> +++ b/docs/devel/qapi-code-gen.rst
> @@ -876,25 +876,35 @@ structuring content.
>  Headings and subheadings
>  ~~~~~~~~~~~~~~~~~~~~~~~~
>  
> -A free-form documentation comment containing a line which starts with
> -some ``=`` symbols and then a space defines a section heading::
> +Free-form documentation does not start with ``@SYMBOL`` and can contain
> +arbitrary rST markup. Headings can be marked up using the standard rST

Two spaces between sentences for consistency, please.

> +syntax::
>  
>      ##
> -    # = This is a top level heading
> +    # *************************
> +    # This is a level 2 heading
> +    # *************************
>      #
>      # This is a free-form comment which will go under the
>      # top level heading.
>      ##
>  
>      ##
> -    # == This is a second level heading
> +    # This is a third level heading
> +    # ==============================
> +    #
> +    # Level 4
> +    # _______
> +    #
> +    # Level 5
> +    # ^^^^^^^
> +    #
> +    # Level 6
> +    # """""""
>      ##
>  
> -A heading line must be the first line of the documentation
> -comment block.
> -
> -Section headings must always be correctly nested, so you can only
> -define a third-level heading inside a second-level heading, and so on.
> +Level 1 headings are reserved for use by the generated documentation
> +page itself, leaving level 2 as the highest level that should be used.
>  
>  
>  Documentation markup
> diff --git a/docs/interop/firmware.json b/docs/interop/firmware.json
> index 745d21d8223..f46fdedfa89 100644
> --- a/docs/interop/firmware.json
> +++ b/docs/interop/firmware.json
> @@ -11,7 +11,9 @@
>  # later. See the COPYING file in the top-level directory.
>  
>  ##
> -# = Firmware
> +# ********
> +# Firmware
> +# ********
>  ##
>  
>  { 'pragma': {
> diff --git a/docs/interop/vhost-user.json b/docs/interop/vhost-user.json
> index b6ade9e4931..095eb99cf79 100644
> --- a/docs/interop/vhost-user.json
> +++ b/docs/interop/vhost-user.json
> @@ -10,7 +10,9 @@
>  # later. See the COPYING file in the top-level directory.
>  
>  ##
> -# = vhost user backend discovery & capabilities
> +# *******************************************
> +# vhost user backend discovery & capabilities
> +# *******************************************
>  ##
>  
>  ##

I dislike reST headings.  Sticking to plain reST makes sense regardless.

> diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
> index c9c477378f5..cdf556c2a3c 100644
> --- a/docs/sphinx/qapidoc.py
> +++ b/docs/sphinx/qapidoc.py
> @@ -391,44 +391,9 @@ def visit_module(self, path: str) -> None:
>          self.ensure_blank_line()
>  
>      def visit_freeform(self, doc: QAPIDoc) -> None:
> -        # TODO: Once the old qapidoc transformer is deprecated, freeform
> -        # sections can be updated to pure rST, and this transformed removed.
> -        #
> -        # For now, translate our micro-format into rST. Code adapted
> -        # from Peter Maydell's freeform().
> -
>          assert len(doc.all_sections) == 1, doc.all_sections
>          body = doc.all_sections[0]
> -        text = body.text
> -        info = doc.info
> -
> -        if re.match(r"=+ ", text):
> -            # Section/subsection heading (if present, will always be the
> -            # first line of the block)
> -            (heading, _, text) = text.partition("\n")
> -            (leader, _, heading) = heading.partition(" ")
> -            # Implicit +1 for heading in the containing .rst doc
> -            level = len(leader) + 1
> -
> -            # https://www.sphinx-doc.org/en/master/usage/restructuredtext/basics.html#sections
> -            markers = ' #*=_^"'
> -            overline = level <= 2
> -            marker = markers[level]
> -
> -            self.ensure_blank_line()
> -            # This credits all 2 or 3 lines to the single source line.
> -            if overline:
> -                self.add_line(marker * len(heading), info)
> -            self.add_line(heading, info)
> -            self.add_line(marker * len(heading), info)
> -            self.ensure_blank_line()
> -
> -            # Eat blank line(s) and advance info
> -            trimmed = text.lstrip("\n")
> -            text = trimmed
> -            info = info.next_line(len(text) - len(trimmed) + 1)
> -
> -        self.add_lines(text, info)
> +        self.add_lines(body.text, doc.info)
>          self.ensure_blank_line()
>  
>      def visit_entity(self, ent: QAPISchemaDefinition) -> None:

Lovely.

Left in scripts/qapi/parser.py:

                elif line.startswith('='):
                    raise QAPIParseError(
                        self,
                        "unexpected '=' markup in definition documentation")

with test case tests/qapi-schema/doc-bad-section.json.

We might want to reject '=' markup anywhere for a while, to catch
outmoded headings.

[...]

Fails "make check".  Fixup:

diff --git a/tests/qapi-schema/doc-good.out b/tests/qapi-schema/doc-good.out
index 3711cf5480..f60a24d1b7 100644
--- a/tests/qapi-schema/doc-good.out
+++ b/tests/qapi-schema/doc-good.out
@@ -55,13 +55,16 @@ event EVT_BOXED Object
     feature feat3
 doc freeform
     body=
-= Section
+*******
+Section
+*******
 doc freeform
     body=
 Just text, no heading.
 doc freeform
     body=
-== Subsection
+Subsection
+==========
 
 *with emphasis*
 @var {in braces}
@@ -155,7 +158,8 @@ description starts on the same line
 a feature
 doc freeform
     body=
-== Another subsection
+Another subsection
+==================
 doc symbol=cmd
     body=
 


