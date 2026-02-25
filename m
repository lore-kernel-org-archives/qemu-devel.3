Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 354D8FCEEAD
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 12:12:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvDkT-0006KY-2e; Wed, 25 Feb 2026 07:12:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vvDkR-0006Jn-6b
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 07:12:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vvDkP-0005QX-5k
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 07:12:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772021527;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=g1vvfEcfKlKR5YJmMjDab6u3KVHfsqMk7Wxiz7JaetI=;
 b=DcDcwb70oAqITz8Tzp2z2fz2Diq840I4hGo9hWG1FOdYcETkGoX/jzZ/pIajLPZbyiKZnz
 8SqKX9Gh95B2LmJqawTrzDCkDRFPl1FcRZ4neC0uCc4pw4feKl5fXR6cPG84ef1NSmLKjX
 tOCMGyF+WWqrmXbEWRoq9p3iT9L1bmM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-501-5CzsIybJNSa9ECRgzHLScQ-1; Wed,
 25 Feb 2026 07:12:04 -0500
X-MC-Unique: 5CzsIybJNSa9ECRgzHLScQ-1
X-Mimecast-MFC-AGG-ID: 5CzsIybJNSa9ECRgzHLScQ_1772021523
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4368A195606B; Wed, 25 Feb 2026 12:12:03 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.13])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B46CD19560B6; Wed, 25 Feb 2026 12:12:02 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 54A2F21E692D; Wed, 25 Feb 2026 13:12:00 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Antoine Damhet <adamhet@scaleway.com>
Cc: qemu-devel@nongnu.org,  qemu-block@nongnu.org,  Kevin Wolf
 <kwolf@redhat.com>,  Hanna Reitz <hreitz@redhat.com>,  Eric Blake
 <eblake@redhat.com>
Subject: Re: [PATCH v2 2/3] qapi: block: Refactor HTTP(s) common arguments
In-Reply-To: <20260224155314.1658988-3-adamhet@scaleway.com> (Antoine Damhet's
 message of "Tue, 24 Feb 2026 16:51:30 +0100")
References: <20260224155314.1658988-1-adamhet@scaleway.com>
 <20260224155314.1658988-3-adamhet@scaleway.com>
Date: Wed, 25 Feb 2026 13:12:00 +0100
Message-ID: <875x7lm38v.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.734, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.78,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Antoine Damhet <adamhet@scaleway.com> writes:

> The HTTPs curl block driver is a superset of the HTTP driver, reflect
> that in the QAPI.
>
> Suggested-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Antoine Damhet <adamhet@scaleway.com>
> ---
>  qapi/block-core.json | 13 ++-----------
>  1 file changed, 2 insertions(+), 11 deletions(-)
>
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index b82af7425614..a7871705fa69 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -4595,23 +4595,14 @@
>  # Driver specific block device options for HTTPS connections over the
>  # curl backend.  URLs must start with "https://".
>  #
> -# @cookie: List of cookies to set; format is "name1=content1;
> -#     name2=content2;" as explained by CURLOPT_COOKIE(3).  Defaults to
> -#     no cookies.
> -#
>  # @sslverify: Whether to verify the SSL certificate's validity
>  #     (defaults to true)
>  #
> -# @cookie-secret: ID of a QCryptoSecret object providing the cookie
> -#     data in a secure way.  See @cookie for the format.  (since 2.10)
> -#
>  # Since: 2.9
>  ##
>  { 'struct': 'BlockdevOptionsCurlHttps',
> -  'base': 'BlockdevOptionsCurlBase',
> -  'data': { '*cookie': 'str',
> -            '*sslverify': 'bool',
> -            '*cookie-secret': 'str'} }
> +  'base': 'BlockdevOptionsCurlHttp',
> +  'data': { '*sslverify': 'bool'} }
>  
>  ##
>  # @BlockdevOptionsCurlFtp:

Reviewed-by: Markus Armbruster <armbru@redhat.com>


