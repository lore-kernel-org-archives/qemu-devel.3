Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A8ACC282D0
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 05:47:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqQXN-0006JA-07; Fri, 07 Mar 2025 00:46:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tqQXL-0006Ip-4R
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 00:46:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tqQXJ-0006fg-7n
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 00:46:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741326375;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rG+eEZR1YRqsjeR54znBAI4pudwZxEuMEwqD6HPODTM=;
 b=AUwF1OFxxX8PdKmK7MdrVGsNiaSz0v9J6Ejtem68caWrP4Fd7HDBSjPunafIFoCmvDkiyU
 tRpfllEP8I0P43MuvE0fdjZSDIo7uxOqdK8auNAbdkYbhts1+/BNXNGnsPLAH+KPbC7rz3
 91RNVSKuYLY4WvuTSRomxLLKFmDB8Jo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-369-khXI9QXgObaj5ovjcpqehA-1; Fri,
 07 Mar 2025 00:46:10 -0500
X-MC-Unique: khXI9QXgObaj5ovjcpqehA-1
X-Mimecast-MFC-AGG-ID: khXI9QXgObaj5ovjcpqehA_1741326369
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E8B28180035E; Fri,  7 Mar 2025 05:46:08 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.15])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4C7F31956095; Fri,  7 Mar 2025 05:46:08 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9FCE621E66C2; Fri, 07 Mar 2025 06:46:05 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Michael Roth <michael.roth@amd.com>,  Alex
 =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,  Philippe =?utf-8?Q?Mat?=
 =?utf-8?Q?hieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Peter Maydell <peter.maydell@linaro.org>,  Thomas
 Huth <thuth@redhat.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>
Subject: Re: [PATCH 04/57] docs/sphinx: add compat.py module and
 nested_parse helper
In-Reply-To: <20250305034610.960147-5-jsnow@redhat.com> (John Snow's message
 of "Tue, 4 Mar 2025 22:45:13 -0500")
References: <20250305034610.960147-1-jsnow@redhat.com>
 <20250305034610.960147-5-jsnow@redhat.com>
Date: Fri, 07 Mar 2025 06:46:05 +0100
Message-ID: <87o6ydtmua.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
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

> Create a compat module that handles sphinx cross-version compatibility
> issues. For the inaugural function, add a nested_parse() helper that
> handles differences in line number tracking for nested directive body
> parsing.
>
> Spoilers: there are more cross-version hacks to come throughout the
> series.
>
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  docs/sphinx/compat.py | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
>  create mode 100644 docs/sphinx/compat.py
>
> diff --git a/docs/sphinx/compat.py b/docs/sphinx/compat.py
> new file mode 100644
> index 00000000000..792aca10e39
> --- /dev/null
> +++ b/docs/sphinx/compat.py
> @@ -0,0 +1,33 @@
> +"""
> +Sphinx cross-version compatibility goop
> +"""
> +
> +from docutils.nodes import Element
> +
> +from sphinx.util.docutils import SphinxDirective, switch_source_input
> +from sphinx.util.nodes import nested_parse_with_titles
> +
> +
> +def nested_parse(directive: SphinxDirective, content_node: Element) -> None:
> +    """
> +    This helper preserves error parsing context across sphinx versions.
> +    """
> +
> +    # necessary so that the child nodes get the right source/line set
> +    content_node.document = directive.state.document
> +
> +    try:
> +        # Modern sphinx (6.2.0+) supports proper offsetting for
> +        # nested parse error context management
> +        nested_parse_with_titles(
> +            directive.state,
> +            directive.content,
> +            content_node,
> +            content_offset=directive.content_offset,
> +        )
> +    except TypeError:
> +        # No content_offset argument. Fall back to SSI method.
> +        with switch_source_input(directive.state, directive.content):
> +            nested_parse_with_titles(
> +                directive.state, directive.content, content_node
> +            )

The function wraps around sphinx.util.nodes.nested_parse_with_titles().
Would calling it nested_parse_with_titles() reduce readers' cognitive
load at call sites?

Please do not misinterpret my question as a demand.  It's really just a
question :)


