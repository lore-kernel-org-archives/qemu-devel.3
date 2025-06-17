Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F177C71157
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Jun 2025 10:59:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRU1y-0004q0-EU; Tue, 17 Jun 2025 06:59:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uRU1w-0004js-4T
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 06:59:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uRU1t-0008IJ-Nb
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 06:59:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750157939;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ll8Pu8fWO5pLJlieWzTx8djWwly8ZdyIrU4GDzrcl0o=;
 b=dM+uMdoT5FKkn0S7Let33dAOd/AbACSKB6s9pbjAa0RIpz42b+atQZsx2FqmahMni5PMfw
 GbX/WrxzVRxxUl/9zpFXFvuVcX64zd/rdSTrqRhvzNab8WKqqiIP7frDi/Lc8AEwLpx3Rz
 bYoNKMXXP0JcsXVBfgwRo1cOTeUemjI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-491-VZVNihXnPtSW9rjAAq89rA-1; Tue,
 17 Jun 2025 06:58:57 -0400
X-MC-Unique: VZVNihXnPtSW9rjAAq89rA-1
X-Mimecast-MFC-AGG-ID: VZVNihXnPtSW9rjAAq89rA_1750157936
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C374A1800290; Tue, 17 Jun 2025 10:58:55 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.11])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EFF4A1956094; Tue, 17 Jun 2025 10:58:54 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 63E3421E6A27; Tue, 17 Jun 2025 12:58:52 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Zhuoying Cai <zycai@linux.ibm.com>
Cc: thuth@redhat.com,  berrange@redhat.com,  richard.henderson@linaro.org,
 david@redhat.com,  pbonzini@redhat.com,  walling@linux.ibm.com,
 jjherne@linux.ibm.com,  jrossi@linux.ibm.com,  pasic@linux.ibm.com,
 borntraeger@linux.ibm.com,  farman@linux.ibm.com,  iii@linux.ibm.com,
 eblake@redhat.com,  qemu-s390x@nongnu.org,  qemu-devel@nongnu.org
Subject: Re: [PATCH v3 02/28] crypto/x509-utils: Add helper functions for
 certificate store
In-Reply-To: <20250604215657.528142-3-zycai@linux.ibm.com> (Zhuoying Cai's
 message of "Wed, 4 Jun 2025 17:56:30 -0400")
References: <20250604215657.528142-1-zycai@linux.ibm.com>
 <20250604215657.528142-3-zycai@linux.ibm.com>
Date: Tue, 17 Jun 2025 12:58:52 +0200
Message-ID: <87sejyskgj.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.89,
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

Zhuoying Cai <zycai@linux.ibm.com> writes:

> Add helper functions for x509 certificate which will be used in the next
> patch for the certificate store.
>
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>

[...]

> diff --git a/qapi/crypto.json b/qapi/crypto.json
> index c9d967d782..af487dcecd 100644
> --- a/qapi/crypto.json
> +++ b/qapi/crypto.json
> @@ -612,3 +612,83 @@
>    'base': { 'alg': 'QCryptoAkCipherAlgo' },
>    'discriminator': 'alg',
>    'data': { 'rsa': 'QCryptoAkCipherOptionsRSA' }}
> +
> +##
> +# @QCryptoKeyidFlags:
> +#
> +# The supported flags for the key ID
> +#
> +# @sha1: SHA-1
> +#
> +# @sha256: SHA-256
> +#
> +# @sha512: SHA-512
> +#
> +# @best-known: BEST-KNOWN
> +#
> +# Since: 10.1
> +##
> +{ 'enum': 'QCryptoKeyidFlags',
> +  'data': ['sha1', 'sha256', 'sha512', 'best-known']}
> +
> +##
> +# @QCryptoCertFmt:

For better or worse, we tend not to abbreviate things in QAPI schema
names: QCryptoCertFormat.

> +#
> +# The supported certificate encoding formats
> +#
> +# @der: DER
> +#
> +# @pem: PEM
> +#
> +# Since: 10.1
> +##
> +{ 'enum': 'QCryptoCertFmt',
> +  'data': ['der', 'pem']}
> +
> +##
> +# @QCryptoSigAlgo:
> +#
> +# Algorithms for digital signature
> +#
> +# @unknown: UNKNOWN
> +#
> +# @rsa-sha1: RSA-SHA1 or RSA-SHA
> +#
> +# @dsa-sha1: DSA-SHA1 or DSA-SHA
> +#
> +# @rsa-md5: RSA-MD5
> +#
> +# @rsa-md2: RSA-MD2
> +#
> +# @rsa-rmd160: RSA-RMD160
> +#
> +# @rsa-sha256: RSA-SHA256
> +#
> +# @rsa-sha384: RSA-SHA384
> +#
> +# @rsa-sha512: RSA-SHA512
> +#
> +# @rsa-sha224: RSA-SHA224
> +#
> +# @dsa-sha224: DSA-SHA224
> +#
> +# @dsa-sha256: DSA-SHA256
> +#
> +# @ecdsa-sha1: ECDSA-SHA1
> +#
> +# @ecdsa-sha224: ECDSA-SHA224
> +#
> +# @ecdsa-sha256: ECDSA-SHA256
> +#
> +# @ecdsa-sha384: ECDSA-SHA384
> +#
> +# @ecdsa-sha512: ECDSA-SHA512
> +#
> +# Since: 10.1
> +##
> +{ 'enum': 'QCryptoSigAlgo',
> +  'data': ['unknown', 'rsa-sha1', 'dsa-sha1',
> +           'rsa-md5', 'rsa-md2', 'rsa-rmd160',
> +           'rsa-sha256', 'rsa-sha384', 'rsa-sha512', 'rsa-sha224',
> +           'dsa-sha224', 'dsa-sha256',
> +           'ecdsa-sha1', 'ecdsa-sha224', 'ecdsa-sha256', 'ecdsa-sha384', 'ecdsa-sha512']}

Ignorant question: why are these QAPI enums?

If they need to be QAPI enums, then I'll have some requests on the doc
comments.


