Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D147C83F03
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Jul 2025 08:40:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZQL7-000378-A3; Wed, 09 Jul 2025 04:39:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uZQL2-00036P-Gy
 for qemu-devel@nongnu.org; Wed, 09 Jul 2025 04:39:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uZQKy-0000A7-Fo
 for qemu-devel@nongnu.org; Wed, 09 Jul 2025 04:39:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752050371;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mkN6yO9T9kFzneVI0S005xNOWpPTEu41K2zwN3Og3iY=;
 b=IBW6YZ3A+j/EDU0aL35raYaCFI6UYhJDKP3H6GfqRd1Av8qdmtrB7kSogM4SCZl7s3taxk
 Fe0I4N2DEQjimSJL6VKpLfyFRcYWsRn8J6+jwdfkTmX0/kqnjE+yjoON3FHzswlAvbmyAz
 skdL9K8pkGakPOBenw5S+8ZJwZu5vJ4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-679-xUgnpV8sOUW0yN7K27KYrw-1; Wed,
 09 Jul 2025 04:39:26 -0400
X-MC-Unique: xUgnpV8sOUW0yN7K27KYrw-1
X-Mimecast-MFC-AGG-ID: xUgnpV8sOUW0yN7K27KYrw_1752050365
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0AAB1195F172; Wed,  9 Jul 2025 08:39:25 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.6])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A708B19560AB; Wed,  9 Jul 2025 08:39:24 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E024421E6A27; Wed, 09 Jul 2025 10:39:21 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org,  John Snow <jsnow@redhat.com>,  Cleber Rosa
 <crosa@redhat.com>,  Eric Blake <eblake@redhat.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,  Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>,  Philippe Mathieu-Daude
 <philmd@linaro.org>
Subject: Re: [PATCH V3 1/3] qom: qom-list-getv
In-Reply-To: <1751995472-211897-2-git-send-email-steven.sistare@oracle.com>
 (Steve Sistare's message of "Tue, 8 Jul 2025 10:24:30 -0700")
References: <1751995472-211897-1-git-send-email-steven.sistare@oracle.com>
 <1751995472-211897-2-git-send-email-steven.sistare@oracle.com>
Date: Wed, 09 Jul 2025 10:39:21 +0200
Message-ID: <878qkxrc5i.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Steve Sistare <steven.sistare@oracle.com> writes:

> Define the qom-list-getv command, which fetches all the properties and
> values for a list of paths.  This is faster than qom-tree-get when
> fetching a subset of the QOM tree.  See qom.json for details.
>
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>

You cover letter explains *why* we want this.  Please include the
relevant parts here, so the rationale gets captured in git.

> ---
>  qapi/qom.json      | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  qom/qom-qmp-cmds.c | 53 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 103 insertions(+)
>
> diff --git a/qapi/qom.json b/qapi/qom.json
> index b133b06..c16c2dd 100644
> --- a/qapi/qom.json
> +++ b/qapi/qom.json
> @@ -46,6 +46,34 @@
>              '*default-value': 'any' } }
>  
>  ##
> +# @ObjectPropertyValue:
> +#
> +# @name: the name of the property
> +#
> +# @type: the type of the property, as described in @ObjectPropertyInfo
> +#
> +# @value: the value of the property.  Absent when the property cannot
> +#     be read.

Best to consistently end the descriptions with a period.

> +#
> +# Since 10.1
> +##
> +{ 'struct': 'ObjectPropertyValue',
> +  'data': { 'name': 'str',
> +            'type': 'str',
> +            '*value': 'any' } }
> +
> +##
> +# @ObjectPropertiesValues:
> +#
> +# @properties: a list of properties.
> +#
> +# Since 10.1
> +##
> +{ 'struct': 'ObjectPropertiesValues',
> +  'data': { 'properties': [ 'ObjectPropertyValue' ] }}
> +
> +
> +##
>  # @qom-list:
>  #
>  # This command will list any properties of a object given a path in
> @@ -126,6 +154,28 @@
>    'allow-preconfig': true }
>  
>  ##
> +# @qom-list-getv:
> +#
> +# List properties and their values for each object path in the input
> +# list.
> +#
> +# @paths: The absolute or partial path for each object, as described
> +#     in @qom-get

John Snow's "[PATCH 00/18] QAPI: add cross-references to qapi docs"
rewrites things so they become links in generated HTML.  @qom-get
beccomes `qom-get`.  Please use `qom-get` to avoid the semantic
conflict.

> +#
> +# Errors:
> +#     - If any path is not valid or is ambiguous
> +#
> +# Returns: A list of @ObjectPropertiesValues.  Each element contains
> +#     the properties of the corresponding element in @paths.

I understand you patterned this after qom-get.  It comes out like

   Return:
      "[""ObjectPropertiesValues""]" -- A list of
      "ObjectPropertiesValues".  Each element contains the properties
      of the corresponding element in "paths".

in the generated manual.  'A list of "ObjectPropertiesValues"' is
redundant.  John Snow's "[PATCH v5 4/4] qapi: rephrase return docs to
avoid type name" cleans up existing instances, including qom-get.

Perhaps something like "A list where each element contains information
on the properties of the object referenced by the corresponding element
in @paths."  Or shorter: "A list where each element is the result for
the corresponding element of @paths".

> +#
> +# Since 10.1
> +##
> +{ 'command': 'qom-list-getv',
> +  'data': { 'paths': [ 'str' ] },
> +  'returns': [ 'ObjectPropertiesValues' ],
> +  'allow-preconfig': true }
> +
> +##
>  # @qom-set:
>  #
>  # This command will set a property from a object model path.

The schema looks good.  Not entirely happy with the names.  Naming is
hard!  Type names are not part of the interface, so let's not worry
about them too much.  The command name will be set in stone, though.

When you named the command qom-list-getv, you also had qom-list-get.
qom-list-get works on a single path, and -getv on multiple paths.  The
"v" suffix feels like a natural choice among people used to C.  But does
it make sense without its buddy?

How do you feel about calling it qom-list-get?  qom-get-many?  Other
ideas?

> diff --git a/qom/qom-qmp-cmds.c b/qom/qom-qmp-cmds.c

[...]

The C code looks good to me.


