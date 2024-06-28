Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C18BC2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 13:10:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNBLh-0001ly-1p; Fri, 28 Jun 2024 09:09:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sNBLd-0001la-3t
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 09:09:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sNBLb-0000zp-Bl
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 09:09:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719580141;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/lPZNrXkbavBfxPxn2U5XsfJRYecIuolXy38Azj7HOA=;
 b=XRucGqBV5Ns/uTcZppplLWcFRNYbiDrJ+I7kVVnhvH2UQIdkMvjSDBuv3jcD9nTosVXrN9
 dBcyEEkrfsPv8PSpup4YZdd3yaz8cLf+1/c9bp/IMYL8pw1mdjr9woV28GKHmCFC6n0ncU
 0ICkimInS1ZDQY8CH8eRwu9ZGzDJp/M=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-542-XrRdJv9VP3m_2EbG1_qGyA-1; Fri,
 28 Jun 2024 09:08:55 -0400
X-MC-Unique: XrRdJv9VP3m_2EbG1_qGyA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A02C01955D80; Fri, 28 Jun 2024 13:08:52 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.194.114])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ED4DD1955BD4; Fri, 28 Jun 2024 13:08:50 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D718F21E668B; Fri, 28 Jun 2024 15:08:48 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Mads Ynddal <mads@ynddal.dk>,  Jiri Pirko
 <jiri@resnulli.us>,  Stefan Hajnoczi <stefanha@redhat.com>,  Eric Blake
 <eblake@redhat.com>,  Peter Maydell <peter.maydell@linaro.org>,  Michael
 Roth <michael.roth@amd.com>,  "Michael S. Tsirkin" <mst@redhat.com>,  Alex
 Williamson <alex.williamson@redhat.com>,  Pavel Dovgalyuk
 <pavel.dovgaluk@ispras.ru>,  Victor Toso de Carvalho
 <victortoso@redhat.com>,  =?utf-8?Q?C=C3=A9dric?= Le Goater
 <clg@redhat.com>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  qemu-block@nongnu.org,
 Ani Sinha
 <anisinha@redhat.com>,  Fabiano Rosas <farosas@suse.de>,  Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  Gerd Hoffmann <kraxel@redhat.com>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Kevin Wolf <kwolf@redhat.com>,  Peter Xu
 <peterx@redhat.com>,  Eduardo Habkost <eduardo@habkost.net>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Lukas Straub
 <lukasstraub2@web.de>,
 Igor Mammedov <imammedo@redhat.com>,  Jason Wang <jasowang@redhat.com>,
 Yanan Wang <wangyanan55@huawei.com>,  Hanna Reitz <hreitz@redhat.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>
Subject: Re: [PATCH v2 14/21] docs/qapidoc: factor out do_parse()
In-Reply-To: <20240626222128.406106-15-jsnow@redhat.com> (John Snow's message
 of "Wed, 26 Jun 2024 18:21:20 -0400")
References: <20240626222128.406106-1-jsnow@redhat.com>
 <20240626222128.406106-15-jsnow@redhat.com>
Date: Fri, 28 Jun 2024 15:08:48 +0200
Message-ID: <87tthdxli7.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.206,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

> Factor out the compatibility parser helper so it can be shared by other
> directives.

Suggest "Factor out the compatibility parser helper into a base class,
so it can be shared by other directives."

>
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  docs/sphinx/qapidoc.py | 64 +++++++++++++++++++++++-------------------
>  1 file changed, 35 insertions(+), 29 deletions(-)
>
> diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
> index efcd84656fa..43dd99e21e6 100644
> --- a/docs/sphinx/qapidoc.py
> +++ b/docs/sphinx/qapidoc.py
> @@ -494,7 +494,41 @@ def visit_module(self, name):
>          super().visit_module(name)
>  
>  
> -class QAPIDocDirective(Directive):
> +class NestedDirective(Directive):
> +    def run(self):
> +        raise NotImplementedError

Should this class be abstract?

> +
> +    def do_parse(self, rstlist, node):
> +        """
> +        Parse rST source lines and add them to the specified node
> +
> +        Take the list of rST source lines rstlist, parse them as
> +        rST, and add the resulting docutils nodes as children of node.
> +        The nodes are parsed in a way that allows them to include
> +        subheadings (titles) without confusing the rendering of
> +        anything else.
> +        """
> +        # This is from kerneldoc.py -- it works around an API change in
> +        # Sphinx between 1.6 and 1.7. Unlike kerneldoc.py, we use
> +        # sphinx.util.nodes.nested_parse_with_titles() rather than the
> +        # plain self.state.nested_parse(), and so we can drop the saving
> +        # of title_styles and section_level that kerneldoc.py does,
> +        # because nested_parse_with_titles() does that for us.
> +        if USE_SSI:
> +            with switch_source_input(self.state, rstlist):
> +                nested_parse_with_titles(self.state, rstlist, node)
> +        else:
> +            save = self.state.memo.reporter
> +            self.state.memo.reporter = AutodocReporter(
> +                rstlist, self.state.memo.reporter
> +            )
> +            try:
> +                nested_parse_with_titles(self.state, rstlist, node)
> +            finally:
> +                self.state.memo.reporter = save
> +
> +
> +class QAPIDocDirective(NestedDirective):
>      """Extract documentation from the specified QAPI .json file"""
>  
>      required_argument = 1
> @@ -532,34 +566,6 @@ def run(self):
>              # so they are displayed nicely to the user
>              raise ExtensionError(str(err)) from err
>  
> -    def do_parse(self, rstlist, node):
> -        """Parse rST source lines and add them to the specified node
> -
> -        Take the list of rST source lines rstlist, parse them as
> -        rST, and add the resulting docutils nodes as children of node.
> -        The nodes are parsed in a way that allows them to include
> -        subheadings (titles) without confusing the rendering of
> -        anything else.
> -        """
> -        # This is from kerneldoc.py -- it works around an API change in
> -        # Sphinx between 1.6 and 1.7. Unlike kerneldoc.py, we use
> -        # sphinx.util.nodes.nested_parse_with_titles() rather than the
> -        # plain self.state.nested_parse(), and so we can drop the saving
> -        # of title_styles and section_level that kerneldoc.py does,
> -        # because nested_parse_with_titles() does that for us.
> -        if USE_SSI:
> -            with switch_source_input(self.state, rstlist):
> -                nested_parse_with_titles(self.state, rstlist, node)
> -        else:
> -            save = self.state.memo.reporter
> -            self.state.memo.reporter = AutodocReporter(
> -                rstlist, self.state.memo.reporter
> -            )
> -            try:
> -                nested_parse_with_titles(self.state, rstlist, node)
> -            finally:
> -                self.state.memo.reporter = save
> -
>  
>  def setup(app):
>      """Register qapi-doc directive with Sphinx"""

Reviewed-by: Markus Armbruster <armbru@redhat.com>


