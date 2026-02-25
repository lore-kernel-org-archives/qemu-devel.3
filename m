Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 711F1FD374E
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 13:21:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvEoi-0007nH-D1; Wed, 25 Feb 2026 08:20:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vvEod-0007mg-Uv
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 08:20:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vvEoc-00007T-3Z
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 08:20:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772025633;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hI986VH1FQe86su7H+1dxO7fuiGZfSFhntLITGuBoLE=;
 b=Qkgd53SL33lafnYhy043QHg3IgYZYiIUgfommENLhw/M8x4yZdekUKStXdcMqw0pstu1Lu
 Al/zdpYaLRL3BTlwmoKmB+rJEqxSbUqCZlVmfi6qX7R4ZpanGVwh9kVn5eSJw13K+LWNT8
 0tEQvZmyBeEf5nSsqa/5AGklIzTBP6I=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-68-r6-Ji_ifPKuoESJ_F5oS-A-1; Wed,
 25 Feb 2026 08:20:30 -0500
X-MC-Unique: r6-Ji_ifPKuoESJ_F5oS-A-1
X-Mimecast-MFC-AGG-ID: r6-Ji_ifPKuoESJ_F5oS-A_1772025629
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7AB941956089; Wed, 25 Feb 2026 13:20:29 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.13])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E402E3003D88; Wed, 25 Feb 2026 13:20:28 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id CF83121E692D; Wed, 25 Feb 2026 14:20:25 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Antoine Damhet <adamhet@scaleway.com>
Cc: qemu-devel@nongnu.org,  qemu-block@nongnu.org,  Kevin Wolf
 <kwolf@redhat.com>,  Hanna Reitz <hreitz@redhat.com>,  Pierrick Bouvier
 <pierrick.bouvier@linaro.org>,  Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v2 3/3] block/curl: add support for S3 presigned URLs
In-Reply-To: <20260224155314.1658988-4-adamhet@scaleway.com> (Antoine Damhet's
 message of "Tue, 24 Feb 2026 16:51:31 +0100")
References: <20260224155314.1658988-1-adamhet@scaleway.com>
 <20260224155314.1658988-4-adamhet@scaleway.com>
Date: Wed, 25 Feb 2026 14:20:25 +0100
Message-ID: <871pi9m02u.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

> S3 presigned URLs are signed for a specific HTTP method (typically GET
> for our use cases). The curl block driver currently issues a HEAD
> request to discover the web server features and the file size, which
> fails with 'HTTP 403' (forbidden).
>
> Add a 'force-range' option that skips the HEAD request and instead
> issues a minimal GET request (querying 1 byte from the server) to
> extract the file size from the 'Content-Range' response header. To
> achieve this the 'curl_header_cb' is redesigned to generically parse
> HTTP headers.
>
> $ $QEMU -drive driver=https,\
>              'url=https://s3.example.com/some.img?X-Amz-Security-Token=XXX',
>              force-range=true
>
> Enabling the 'force-range' option without the web server specified with
> @url supporting it might cause the server to respond successfully with
> 'HTTP 200' and attempt to send the whole file body. With the
> 'CURLOPT_NOBODY' option set the libcurl will skip reading after the
> headers and close the connection. QEMU still gracefully detects the
> missing feature. This might waste a small number of TCP packets but is
> otherwise transparent to the user.
>
> Signed-off-by: Antoine Damhet <adamhet@scaleway.com>

[...]

> diff --git a/docs/system/device-url-syntax.rst.inc b/docs/system/device-url-syntax.rst.inc
> index aae65d138c00..445e2a0a4157 100644
> --- a/docs/system/device-url-syntax.rst.inc
> +++ b/docs/system/device-url-syntax.rst.inc
> @@ -179,6 +179,12 @@ These are specified using a special URL syntax.
>        get the size of the image to be downloaded. If not set, the
>        default timeout of 5 seconds is used.
>  
> +   ``force-range``
> +      Assume the HTTP backend supports range requests and avoid doing
> +      an HTTP HEAD request to discover the feature. Typically S3
> +      presigned URLs will only support one method and refuse other
> +      request types.
> +

Similar to the description in qapi/block-core.json.  I find the latter
clearer.  Perhaps you'd like to use it here.  Entirely up to you.

>     Note that when passing options to qemu explicitly, ``driver`` is the
>     value of <protocol>.
>  
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index a7871705fa69..50e7078cbec0 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -4582,12 +4582,19 @@
>  # @cookie-secret: ID of a QCryptoSecret object providing the cookie
>  #     data in a secure way.  See @cookie for the format.  (since 2.10)
>  #
> +# @force-range: Don't issue a HEAD HTTP request to discover if the
> +#     http server supports range requests and rely only on GET
> +#     requests.  This is especially useful for S3 presigned URLs where
> +#     HEAD requests are unauthorized.  Defaults to false.
> +#     (default: false; since 11.0)
> +#
>  # Since: 2.9
>  ##
>  { 'struct': 'BlockdevOptionsCurlHttp',
>    'base': 'BlockdevOptionsCurlBase',
>    'data': { '*cookie': 'str',
> -            '*cookie-secret': 'str'} }
> +            '*cookie-secret': 'str',
> +            '*force-range': 'bool'} }
>  
>  ##
>  # @BlockdevOptionsCurlHttps:

QAPI schema
Acked-by: Markus Armbruster <armbru@redhat.com>


