Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB2AFC27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2024 06:29:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJoo8-00066d-TY; Wed, 19 Jun 2024 02:28:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sJoo7-00066G-1d
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 02:28:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sJoo5-0008IR-1O
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 02:28:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718778510;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=T5jDyG9/Qjd/dBA19PDmLUWLTyMtIOI1H9DWP9fFMTY=;
 b=A4CheE3lClG/cNYbapeaDmSjxsYdGZnEjbzXFRbduuGjYOveyhJBwT0qwNvcm1pwPfJ3KG
 i8o4MX2XSk18ENQMaJcQnyFyNO7izslYrLRX52K6f4M/eziFGqp4ZBLQIy20I6rSgmFvRU
 TupA1BRFQSHFa7JZZ7YYhRYzlmhrPNA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-669-3mFyQCXQMGmuML_5fJE3Xw-1; Wed,
 19 Jun 2024 02:28:25 -0400
X-MC-Unique: 3mFyQCXQMGmuML_5fJE3Xw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B9B3519560B1; Wed, 19 Jun 2024 06:28:21 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.93])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 514B119560B4; Wed, 19 Jun 2024 06:28:19 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0B70121E64CD; Wed, 19 Jun 2024 08:28:17 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Stefan Hajnoczi <stefanha@redhat.com>,  Hanna
 Reitz <hreitz@redhat.com>,  Michael Roth <michael.roth@amd.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Victor Toso de
 Carvalho <victortoso@redhat.com>,  "Michael S. Tsirkin" <mst@redhat.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>,  Yanan Wang
 <wangyanan55@huawei.com>,  Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,  Marcel
 Apfelbaum
 <marcel.apfelbaum@gmail.com>,  Fabiano Rosas <farosas@suse.de>,  Lukas
 Straub <lukasstraub2@web.de>,  Eduardo Habkost <eduardo@habkost.net>,
 Mads Ynddal <mads@ynddal.dk>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,  Stefan Berger
 <stefanb@linux.vnet.ibm.com>,  Peter Xu <peterx@redhat.com>,  Igor
 Mammedov <imammedo@redhat.com>,  =?utf-8?Q?C=C3=A9dric?= Le Goater
 <clg@redhat.com>,  Jason
 Wang <jasowang@redhat.com>,  Ani Sinha <anisinha@redhat.com>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Peter Maydell <peter.maydell@linaro.org>,
 qemu-block@nongnu.org,  Jiri Pirko <jiri@resnulli.us>,  Alex Williamson
 <alex.williamson@redhat.com>,  Kevin Wolf <kwolf@redhat.com>,  Eric Blake
 <eblake@redhat.com>
Subject: Re: [PATCH 03/13] docs/qapidoc: delint a tiny portion of the module
In-Reply-To: <20240619003012.1753577-4-jsnow@redhat.com> (John Snow's message
 of "Tue, 18 Jun 2024 20:30:02 -0400")
References: <20240619003012.1753577-1-jsnow@redhat.com>
 <20240619003012.1753577-4-jsnow@redhat.com>
Date: Wed, 19 Jun 2024 08:28:17 +0200
Message-ID: <87plsd30qm.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.148,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

> In a forthcoming series that adds a new QMP documentation generator, it
> will be helpful to have a linting baseline. However, there's no need to
> shuffle around the deck chairs too much, because most of this code will
> be removed once that new qapidoc generator (the "transmogrifier") is in
> place.
>
> To ease my pain: just turn off the black auto-formatter for most, but
> not all, of qapidoc.py. This will help ensure that *new* code follows a
> coding standard without bothering too much with cleaning up the existing
> code.
>
> Code that I intend to keep is still subject to the delinting beam.
>
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  docs/sphinx/qapidoc.py | 66 +++++++++++++++++++++++++-----------------
>  1 file changed, 40 insertions(+), 26 deletions(-)
>
> diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
> index f270b494f01..e675966defa 100644
> --- a/docs/sphinx/qapidoc.py
> +++ b/docs/sphinx/qapidoc.py
> @@ -28,33 +28,42 @@
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
>  
>  # Sphinx up to 1.6 uses AutodocReporter; 1.7 and later
>  # use switch_source_input. Check borrowed from kerneldoc.py.
> -Use_SSI = sphinx.__version__[:3] >= '1.7'
> -if Use_SSI:
> +USE_SSI = sphinx.__version__[:3] >= "1.7"
> +if USE_SSI:
>      from sphinx.util.docutils import switch_source_input
>  else:
> -    from sphinx.ext.autodoc import AutodocReporter
> +    from sphinx.ext.autodoc import (  # pylint: disable=no-name-in-module
> +        AutodocReporter,
> +    )
>  
>  
> -__version__ = '1.0'
> +__version__ = "1.0"
>  
>  
> +# Disable black auto-formatter until re-enabled:
> +# fmt: off
> +
>  # Function borrowed from pydash, which is under the MIT license
>  def intersperse(iterable, separator):
>      """Yield the members of *iterable* interspersed with *separator*."""
>      iterable = iter(iterable)
> -    yield next(iterable)
> +    try:
> +        yield next(iterable)
> +    except StopIteration:
> +        return

This gets rid of pylint's

    docs/sphinx/qapidoc.py:82:10: R1708: Do not raise StopIteration in generator, use return statement instead (stop-iteration-return)

I considered the same change some time ago, and decided against it to
avoid deviating from pydash.  StopIteration would be a programming error
here.

Please *delete* the function instead: commit fd62bff901b removed its
last use.  I'd do it in a separate commit, but that's up to you.

>      for item in iterable:
>          yield separator
>          yield item
> @@ -451,6 +460,10 @@ def get_document_nodes(self):
>          return self._top_node.children
>  
>  
> +# Turn the black formatter on for the rest of the file.
> +# fmt: on
> +
> +
>  class QAPISchemaGenDepVisitor(QAPISchemaVisitor):
>      """A QAPI schema visitor which adds Sphinx dependencies each module
>  
> @@ -458,34 +471,34 @@ class QAPISchemaGenDepVisitor(QAPISchemaVisitor):
>      that the generated documentation output depends on the input
>      schema file associated with each module in the QAPI input.
>      """
> +
>      def __init__(self, env, qapidir):
>          self._env = env
>          self._qapidir = qapidir
>  
>      def visit_module(self, name):
>          if name != "./builtin":
> -            qapifile = self._qapidir + '/' + name
> +            qapifile = self._qapidir + "/" + name

The string literal quote changes are mildly annoying.  But since by your
good work you're effectively appointing yourself maintainer of this
file...  ;)

>              self._env.note_dependency(os.path.abspath(qapifile))
>          super().visit_module(name)
>  
>  
>  class QAPIDocDirective(Directive):
>      """Extract documentation from the specified QAPI .json file"""
> +
>      required_argument = 1
>      optional_arguments = 1
> -    option_spec = {
> -        'qapifile': directives.unchanged_required
> -    }
> +    option_spec = {"qapifile": directives.unchanged_required}
>      has_content = False
>  
>      def new_serialno(self):
>          """Return a unique new ID string suitable for use as a node's ID"""
>          env = self.state.document.settings.env
> -        return 'qapidoc-%d' % env.new_serialno('qapidoc')
> +        return "qapidoc-%d" % env.new_serialno("qapidoc")
>  
>      def run(self):
>          env = self.state.document.settings.env
> -        qapifile = env.config.qapidoc_srctree + '/' + self.arguments[0]
> +        qapifile = env.config.qapidoc_srctree + "/" + self.arguments[0]
>          qapidir = os.path.dirname(qapifile)
>  
>          try:
> @@ -523,13 +536,14 @@ def do_parse(self, rstlist, node):
>          # plain self.state.nested_parse(), and so we can drop the saving
>          # of title_styles and section_level that kerneldoc.py does,
>          # because nested_parse_with_titles() does that for us.
> -        if Use_SSI:
> +        if USE_SSI:
>              with switch_source_input(self.state, rstlist):
>                  nested_parse_with_titles(self.state, rstlist, node)
>          else:
>              save = self.state.memo.reporter
>              self.state.memo.reporter = AutodocReporter(
> -                rstlist, self.state.memo.reporter)
> +                rstlist, self.state.memo.reporter
> +            )
>              try:
>                  nested_parse_with_titles(self.state, rstlist, node)
>              finally:
> @@ -537,12 +551,12 @@ def do_parse(self, rstlist, node):
>  
>  
>  def setup(app):
> -    """ Register qapi-doc directive with Sphinx"""
> -    app.add_config_value('qapidoc_srctree', None, 'env')
> -    app.add_directive('qapi-doc', QAPIDocDirective)
> +    """Register qapi-doc directive with Sphinx"""
> +    app.add_config_value("qapidoc_srctree", None, "env")
> +    app.add_directive("qapi-doc", QAPIDocDirective)
>  
> -    return dict(
> -        version=__version__,
> -        parallel_read_safe=True,
> -        parallel_write_safe=True
> -    )
> +    return {
> +        "version": __version__,
> +        "parallel_read_safe": True,
> +        "parallel_write_safe": True,
> +    }

With intersperse() deleted
Reviewed-by: Markus Armbruster <armbru@redhat.com>


