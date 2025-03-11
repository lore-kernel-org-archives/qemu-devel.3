Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1EA4C28B2E
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 08:53:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trvMa-0003SZ-H1; Tue, 11 Mar 2025 04:53:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1trvME-0003Lf-Hh
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 04:53:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1trvMB-00005a-AG
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 04:53:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741683177;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gC4KXTZO4597AoIndamDFKbs3tWUnKwTJRDSgmgRvE4=;
 b=DjCIt6UtK/UOdgvxzOi8mKfE68Dr7A4zL+IXiOAO5DkXXtbKH3cJO134SF0Z/CVRNazscu
 WFiiR9VF99+JTLMgicJYNFSHkQVCQkR+bxF9XXQMb9HtUHXyaa85LYJyBDN6cu/ptn6rpi
 iO3rwKvjLteaNO8sKKUtLK7BxVvGEGA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-279-fC5quPmPNI-Zu606y2lHKg-1; Tue,
 11 Mar 2025 04:52:53 -0400
X-MC-Unique: fC5quPmPNI-Zu606y2lHKg-1
X-Mimecast-MFC-AGG-ID: fC5quPmPNI-Zu606y2lHKg_1741683172
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 86F6C195608F; Tue, 11 Mar 2025 08:52:52 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.22.74.4])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B973530001A2; Tue, 11 Mar 2025 08:52:50 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id EDAE121E66C1; Tue, 11 Mar 2025 09:52:46 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Peter Maydell <peter.maydell@linaro.org>,
 Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Eric Blake
 <eblake@redhat.com>,  Michael Roth <michael.roth@amd.com>,  Thomas Huth
 <thuth@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH v3 54/63] docs/qapidoc: implement transmogrify() method
In-Reply-To: <20250311034303.75779-55-jsnow@redhat.com> (John Snow's message
 of "Mon, 10 Mar 2025 23:42:52 -0400")
References: <20250311034303.75779-1-jsnow@redhat.com>
 <20250311034303.75779-55-jsnow@redhat.com>
Date: Tue, 11 Mar 2025 09:52:46 +0100
Message-ID: <874j0054pt.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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

> This is the true top-level processor for the new transmogrifier;
> responsible both for generating the intermediate rST and then running
> the nested parse on that generated document to produce the final
> docutils tree that is then - very finally - postprocessed by sphinx for
> final rendering to HTML &c.
>
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  docs/sphinx/qapidoc.py | 49 ++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 47 insertions(+), 2 deletions(-)
>
> diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
> index aaf5b6e22bc..32baf66a390 100644
> --- a/docs/sphinx/qapidoc.py
> +++ b/docs/sphinx/qapidoc.py
> @@ -2,6 +2,7 @@
>  #
>  # QEMU qapidoc QAPI file parsing extension
>  #
> +# Copyright (c) 2024-2025 Red Hat
>  # Copyright (c) 2020 Linaro
>  #
>  # This work is licensed under the terms of the GNU GPLv2 or later.
> @@ -56,6 +57,7 @@
>  from sphinx import addnodes
>  from sphinx.directives.code import CodeBlock
>  from sphinx.errors import ExtensionError
> +from sphinx.util import logging
>  from sphinx.util.docutils import switch_source_input
>  from sphinx.util.nodes import nested_parse_with_titles
>=20=20
> @@ -74,7 +76,9 @@
>      from sphinx.util.typing import ExtensionMetadata
>=20=20
>=20=20
> -__version__ =3D "1.0"
> +__version__ =3D "2.0"

PEP 8:

    Module level =E2=80=9Cdunders=E2=80=9D (i.e. names with two leading and=
 two trailing
    underscores) such as __all__, __author__, __version__, etc. should
    be placed after the module docstring but before any import
    statements except from __future__ imports.

Will move it in my tree.

> +
> +logger =3D logging.getLogger(__name__)
>=20=20
>=20=20
>  class Transmogrifier:
> @@ -95,6 +99,10 @@ def __init__(self) -> None:
>          self._result =3D StringList()
>          self.indent =3D 0
>=20=20
> +    @property
> +    def result(self) -> StringList:
> +        return self._result
> +
>      @property
>      def entity(self) -> QAPISchemaDefinition:
>          assert self._curr_ent is not None
> @@ -438,7 +446,43 @@ def new_serialno(self) -> str:
>          return "qapidoc-%d" % env.new_serialno("qapidoc")
>=20=20
>      def transmogrify(self, schema: QAPISchema) -> nodes.Element:
> -        raise NotImplementedError
> +        logger.info("Transmogrifying QAPI to rST ...")
> +        vis =3D Transmogrifier()
> +        modules =3D set()
> +
> +        for doc in schema.docs:
> +            module_source =3D doc.info.fname
> +            if module_source not in modules:
> +                vis.visit_module(module_source)
> +                modules.add(module_source)
> +
> +            if doc.symbol:
> +                ent =3D schema.lookup_entity(doc.symbol)
> +                assert isinstance(ent, QAPISchemaDefinition)
> +                vis.visit_entity(ent)
> +            else:
> +                vis.visit_freeform(doc)
> +
> +        logger.info("Transmogrification complete.")
> +
> +        contentnode =3D nodes.section()
> +        content =3D vis.result
> +        titles_allowed =3D True
> +
> +        logger.info("Transmogrifier running nested parse ...")
> +        with switch_source_input(self.state, content):
> +            if titles_allowed:
> +                node: nodes.Element =3D nodes.section()
> +                node.document =3D self.state.document
> +                nested_parse_with_titles(self.state, content, contentnod=
e)
> +            else:
> +                node =3D nodes.paragraph()
> +                node.document =3D self.state.document
> +                self.state.nested_parse(content, 0, contentnode)
> +        logger.info("Transmogrifier's nested parse completed.")
> +        sys.stdout.flush()
> +
> +        return contentnode
>=20=20
>      def legacy(self, schema: QAPISchema) -> nodes.Element:
>          vis =3D QAPISchemaGenRSTVisitor(self)
> @@ -572,6 +616,7 @@ def run(self) -> List[nodes.Node]:
>=20=20
>  def setup(app: Sphinx) -> ExtensionMetadata:
>      """Register qapi-doc directive with Sphinx"""
> +    app.setup_extension("qapi_domain")
>      app.add_config_value("qapidoc_srctree", None, "env")
>      app.add_directive("qapi-doc", QAPIDocDirective)
>      app.add_directive("qmp-example", QMPExample)


