Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7208C83F1B
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 14:48:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZsYx-0007fX-5s; Thu, 10 Jul 2025 10:47:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uZsYW-0006UV-2w
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 10:47:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uZsYT-0008BH-JN
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 10:47:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752158839;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LCWxbyEmQcQPWULPp0LZWJvwqnfD7qVZt45dt0xsMts=;
 b=N05to3aYkRgoOOYFay/bPChsy+AT8aCpnF/ic6mxSvYwjUIwl9WEXKbrAOzr6RjZDEQA/D
 JeGTh/ZsE7elt3FtN7zUddyMOuH75clbS8fF1/3NwS0bpX77/4FSsdojBTX7YyhcclcJmi
 M1n3x1rEps+9K4Y1OA4mWGbXtZ00tKI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-614-WdBuZEp7Nf-rSozvZIBpKw-1; Thu,
 10 Jul 2025 10:47:17 -0400
X-MC-Unique: WdBuZEp7Nf-rSozvZIBpKw-1
X-Mimecast-MFC-AGG-ID: WdBuZEp7Nf-rSozvZIBpKw_1752158836
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8DD4D19560A1; Thu, 10 Jul 2025 14:47:16 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.76])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7ECB519560AB; Thu, 10 Jul 2025 14:47:15 +0000 (UTC)
Date: Thu, 10 Jul 2025 15:47:11 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] crypto/x509-utils: Check for error from
 gnutls_x509_crt_init()
Message-ID: <aG_SbyU8XiiTc500@redhat.com>
References: <20250710144417.1187478-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250710144417.1187478-1-peter.maydell@linaro.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Jul 10, 2025 at 03:44:17PM +0100, Peter Maydell wrote:
> Coverity notes that in qcrypto_get_x509_cert_fingerprint() we
> call gnutls_x509_crt_init() but don't check for an error return.
> Add the missing check.
> 
> Coverity: CID 1593155
> Fixes: 10a1d34fc0d ("crypto: Introduce x509 utils")
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  crypto/x509-utils.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>

> diff --git a/crypto/x509-utils.c b/crypto/x509-utils.c
> index 8bad00a51b8..39bb6d4d8c3 100644
> --- a/crypto/x509-utils.c
> +++ b/crypto/x509-utils.c
> @@ -46,7 +46,11 @@ int qcrypto_get_x509_cert_fingerprint(uint8_t *cert, size_t size,
>          return -1;
>      }
>  
> -    gnutls_x509_crt_init(&crt);
> +    if (gnutls_x509_crt_init(&crt) < 0) {
> +        error_setg(errp, "Unable to initialize certificate: %s",
> +                   gnutls_strerror(ret));
> +        return -1;
> +    }
>  
>      if (gnutls_x509_crt_import(crt, &datum, GNUTLS_X509_FMT_PEM) != 0) {
>          error_setg(errp, "Failed to import certificate");
> -- 
> 2.43.0
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


