Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32319CD8CA4
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 13:40:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWwga-0001Yf-FM; Tue, 09 Jun 2026 09:40:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wWwgZ-0001YE-Oe
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 09:40:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wWwgX-00042x-2J
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 09:40:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781012403;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1/9U9z2QG2P5RE+MzIeRWzUhUZBEuA6mCl4iYKbOQUY=;
 b=TMEuKrf0a38AUvMBhql5jwXENlTfmGontIMizsp+DAkjSAJ/xKL4qI4muxVqFTHdunXNyg
 prQcStxCRVE0FNF/H6YdU8Rw1wDKDvE5UChyA0lxqAPV5oXmBO67JeV8Nr5ekwtrjhOhsS
 WVTdbSq0gVQSm0uPBgZ5KcxwvaHpMqE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-100-2SyOoIXRMuOLG8bSiTJ3vQ-1; Tue,
 09 Jun 2026 09:39:58 -0400
X-MC-Unique: 2SyOoIXRMuOLG8bSiTJ3vQ-1
X-Mimecast-MFC-AGG-ID: 2SyOoIXRMuOLG8bSiTJ3vQ_1781012396
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 604EA1805C2C; Tue,  9 Jun 2026 13:39:56 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.28])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8C1DB3652A; Tue,  9 Jun 2026 13:39:55 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2F3EF21E6A01; Tue, 09 Jun 2026 15:39:53 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Ani Sinha <anisinha@redhat.com>,  Michael Roth
 <michael.roth@amd.com>,  Igor Mammedov <imammedo@redhat.com>,  Peter
 Maydell <peter.maydell@linaro.org>,  Eric Blake <eblake@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,  Mauro
 Carvalho Chehab
 <mchehab+huawei@kernel.org>,  "Michael S. Tsirkin" <mst@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>,  Richard Henderson
 <richard.henderson@linaro.org>,  Gerd Hoffmann <kraxel@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 linux-edac@vger.kernel.org, Cleber Rosa <crosa@redhat.com>
Subject: Re: [PATCH v3 12/16] qapi/docs: add "Intro" section parsing
In-Reply-To: <20260603032201.993015-13-jsnow@redhat.com> (John Snow's message
 of "Tue, 2 Jun 2026 23:21:57 -0400")
References: <20260603032201.993015-1-jsnow@redhat.com>
 <20260603032201.993015-13-jsnow@redhat.com>
Date: Tue, 09 Jun 2026 15:39:53 +0200
Message-ID: <874ijboms6.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

> Add parsing for explicit Intro section syntax.
>
> A side effect of this patch is that we will (currently) always create
> an empty Intro section, similar to how we used to have an empty Plain
> section. The tests are adjusted accordingly, rendered document output
> does not change at all.
>
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  docs/devel/qapi-code-gen.rst   | 16 +++++++---------
>  scripts/qapi/parser.py         |  4 ++--
>  tests/qapi-schema/doc-good.out | 18 ++++++++++++++++++
>  3 files changed, 27 insertions(+), 11 deletions(-)
>
> diff --git a/docs/devel/qapi-code-gen.rst b/docs/devel/qapi-code-gen.rst
> index 3a632b4a648..b1cc5b5f0db 100644
> --- a/docs/devel/qapi-code-gen.rst
> +++ b/docs/devel/qapi-code-gen.rst
> @@ -984,11 +984,11 @@ definition it documents.
>  When documentation is required (see pragma_ 'doc-required'), every
>  definition must have documentation.
>  
> -Definition documentation starts with a line naming the definition,
> -followed by an optional overview, a description of each argument (for
> -commands and events), member (for structs and unions), branch (for
> -alternates), or value (for enums), a description of each feature (if
> -any), and finally optional tagged sections.
> +Definition documentation starts with a description naming the
> +definition with an optional indented overview, a description of each
> +argument (for commands and events), member (for structs and unions),
> +branch (for alternates), or value (for enums), a description of each
> +feature (if any), and finally optional tagged sections.
>  
>  Descriptions start with '\@name:'.  The description text must be
>  indented like this::

This works if we convert the entire schema in the same series.  I guess
that's the plan.  Is it?

> @@ -1093,8 +1093,7 @@ Examples of complete definition documentation::
>  
>   ##
>   # @BlockStats:
> - #
> - # Statistics of a virtual block device or a block backing device.
> + #     Statistics of a virtual block device or a block backing device.
>   #
>   # @device: If the stats are for a virtual block device, the name
>   #     corresponding to the virtual block device.
> @@ -1111,8 +1110,7 @@ Examples of complete definition documentation::
>  
>   ##
>   # @query-blockstats:
> - #
> - # Query the @BlockStats for all virtual block devices.
> + #     Query the @BlockStats for all virtual block devices.
>   #
>   # @query-nodes: If true, the command will query all the block nodes
>   #     ... explain, explain ...

[...]


