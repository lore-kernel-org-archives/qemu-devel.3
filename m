Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 212A4CCD199
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 15:51:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9QG0-0005tk-86; Thu, 16 Oct 2025 11:51:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1v9QFv-0005t7-VH
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 11:51:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1v9QFn-0008DD-OT
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 11:51:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760629850;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E65owRgyDYyHbqOnJRKa4CCGFJ09a+0V84lMUKow6mw=;
 b=Fu+VwZ9mwrmgyczp/cu+j5WEhtp2O/UQP13qWlv3hl6keDSRyYqqAHpSU21G/NUerLr2Fu
 XEYpqycnrK3nEdp4ITU3XKZI9ospss3IL89qycrTBN/nTY3id5C7qpcGjLic+Yra4QOHyw
 K2PowKZzQHo+1ayfp4j5bGA7PsnufbA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-86-pjaGDj5NOJqXPVv5DY-EjA-1; Thu,
 16 Oct 2025 11:50:49 -0400
X-MC-Unique: pjaGDj5NOJqXPVv5DY-EjA-1
X-Mimecast-MFC-AGG-ID: pjaGDj5NOJqXPVv5DY-EjA_1760629848
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4089E1800744
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 15:50:48 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.155])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BA1B11956056; Thu, 16 Oct 2025 15:50:46 +0000 (UTC)
Date: Thu, 16 Oct 2025 10:50:44 -0500
From: Eric Blake <eblake@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v2 6/6] crypto: fix error reporting in cert chain checks
Message-ID: <5xa3qjk4lon53h2kdu5palyvq5dtj5j6pbr56o3hfliypkxdpi@wduygbmdxy25>
References: <20250919101022.1491007-1-berrange@redhat.com>
 <20250919101022.1491007-7-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250919101022.1491007-7-berrange@redhat.com>
User-Agent: NeoMutt/20250905
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Sep 19, 2025 at 11:10:22AM +0100, Daniel P. Berrangé wrote:
> The loop that checks the CA certificate chain can fail to report
> an error message if one of the certs in the chain has an issuer
> than is not present in the chain. In this case, the outer loop

s/than/that/

> 'while (checking_issuer)' will terminate after failing to find
> the issuer, and no error message will be reported.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  crypto/tlscredsx509.c | 32 +++++++++++++++++++++-----------
>  1 file changed, 21 insertions(+), 11 deletions(-)
> 
> diff --git a/crypto/tlscredsx509.c b/crypto/tlscredsx509.c
> index 89a8e261d5..d42f2afaea 100644
> --- a/crypto/tlscredsx509.c
> +++ b/crypto/tlscredsx509.c
> @@ -319,7 +319,6 @@ qcrypto_tls_creds_check_authority_chain(QCryptoTLSCredsX509 *creds,
>                                          Error **errp)
>  {
>      gnutls_x509_crt_t cert_to_check = certs[ncerts - 1];
> -    int checking_issuer = 1;

This was the line I mentioned in patch 1/6 as needing a bool.  Should
this cleanup be squashed into that patch rather than having churn in
the series?

>      int retval = 0;
>      gnutls_datum_t dn = {}, dnissuer = {};
>

Should there be a testsuite patch along with this to provoke that
particular failure scenario?

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


