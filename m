Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 392D3C282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 06:39:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tscEK-0000AP-Tj; Thu, 13 Mar 2025 02:39:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tscEC-0008Lw-GO
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 02:39:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tscEA-0003PV-O1
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 02:39:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741847973;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2Vp4mgj96j/z8AfU0a6RpqANf8B7aAzsJbhWaXtTpHE=;
 b=NRJUnN91us2jEoaGPNm956UIIKYi2cehzb/Q1Ta8p9L/me12+ngqoAthtjCa7LoHhVvFfx
 LJT3m2mtNx+q2I79vsXGBZbkUpGr+/WuRW11KQMitM7Evsm1karCHzEubyM/oc35UcbaEY
 c4+KK/Oyg6AnSgiXfzZST3QDw6HZmSE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-376-jjngRZqcM8OYKM67v-nUew-1; Thu,
 13 Mar 2025 02:39:28 -0400
X-MC-Unique: jjngRZqcM8OYKM67v-nUew-1
X-Mimecast-MFC-AGG-ID: jjngRZqcM8OYKM67v-nUew_1741847967
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0656419560B3; Thu, 13 Mar 2025 06:39:26 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.22.74.4])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 823B51800268; Thu, 13 Mar 2025 06:39:24 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A9D4221E66C1; Thu, 13 Mar 2025 07:39:20 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Konstantin Kostiuk <kkostiuk@redhat.com>,  Peter
 Maydell <peter.maydell@linaro.org>,  Eric Blake <eblake@redhat.com>,
 qemu-block@nongnu.org,  Michael Roth <michael.roth@amd.com>,  Kevin Wolf
 <kwolf@redhat.com>,  Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH 04/11] docs/qapi-domain: add :namespace: override option
In-Reply-To: <20250313044312.189276-5-jsnow@redhat.com> (John Snow's message
 of "Thu, 13 Mar 2025 00:43:05 -0400")
References: <20250313044312.189276-1-jsnow@redhat.com>
 <20250313044312.189276-5-jsnow@redhat.com>
Date: Thu, 13 Mar 2025 07:39:20 +0100
Message-ID: <87bju5e8o7.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

John Snow <jsnow@redhat.com> writes:

> Akin to the :module: override option, the :namespace: options allows you
> to forcibly override the contextual namespace associatied with a
> definition.
>
> We don't necessarily actually need this, but I felt compelled to stick
> close to how the Python domain works that offers context overrides.
>
> As of this commit, it is possible to add e.g. ":namespace: QMP" to any
> QAPI directive to forcibly associate that definition with a given
> namespace.
>
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  docs/devel/qapi-domain.rst | 2 ++
>  docs/sphinx/qapi_domain.py | 5 +++--
>  2 files changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/docs/devel/qapi-domain.rst b/docs/devel/qapi-domain.rst
> index 1475870ca6c..51b283277e1 100644
> --- a/docs/devel/qapi-domain.rst
> +++ b/docs/devel/qapi-domain.rst
> @@ -466,6 +466,8 @@ QAPI standard options
>  
>  All QAPI directives -- *except* for module -- support these common options.
>  
> +* ``:namespace: name`` -- This option allows you to override the
> +  namespace association of a given definition.
>  * ``:module: modname`` -- Borrowed from the Python domain, this option allows
>    you to override the module association of a given definition.
>  * ``:since: x.y`` -- Allows the documenting of "Since" information, which is
> diff --git a/docs/sphinx/qapi_domain.py b/docs/sphinx/qapi_domain.py
> index 48a082d489a..6485c432063 100644
> --- a/docs/sphinx/qapi_domain.py
> +++ b/docs/sphinx/qapi_domain.py
> @@ -294,8 +294,9 @@ class QAPIObject(QAPIDescription):
>      )
>      option_spec.update(
>          {
> -            # Borrowed from the Python domain:
> -            "module": directives.unchanged,  # Override contextual module name
> +            # Context overrides:
> +            "namespace": directives.unchanged,
> +            "module": directives.unchanged,
>              # These are QAPI originals:
>              "since": directives.unchanged,
>              "ifcond": directives.unchanged,

Did "Borrowed from the Python domain" become wrong(ish) in PATCH 02?


