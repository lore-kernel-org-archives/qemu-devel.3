Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB776D3B98B
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 12:58:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFv8x-0002yG-7P; Tue, 26 Nov 2024 07:58:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tFv8h-0002xY-Dd
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 07:58:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tFv8e-0007ZU-JB
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 07:57:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732625850;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QGOmP5dCOn8AoD8n68FQpmw+ByxO4khxn2FtEwn8lCc=;
 b=IKcpP5n5YgPb3PpdhugCcF23wxZZIZR+y7eNgOThVgPJQOFIbdIQWk2z4YOBK55+qdtILU
 u8Ho6kQhT4bbMtdr2FYP4tYrHN76qDA3vRMGfXzfElAXdJF3YkAaXqRjHvmK1suDlEbD7m
 0RMzF9yS2wt5WroyaVjkmWHC3J3weaI=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-86-N3AYO85tODOy4TVrOusabQ-1; Tue,
 26 Nov 2024 07:57:29 -0500
X-MC-Unique: N3AYO85tODOy4TVrOusabQ-1
X-Mimecast-MFC-AGG-ID: N3AYO85tODOy4TVrOusabQ
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 354011953954; Tue, 26 Nov 2024 12:57:27 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.147])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 246341956086; Tue, 26 Nov 2024 12:57:23 +0000 (UTC)
Date: Tue, 26 Nov 2024 12:57:20 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org,
 philmd@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 alex.bennee@linaro.org, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH v3 11/26] target/arm/kvm-rme: Add measurement algorithm
 property
Message-ID: <Z0XFsC6vWkrR7aAm@redhat.com>
References: <20241125195626.856992-2-jean-philippe@linaro.org>
 <20241125195626.856992-13-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241125195626.856992-13-jean-philippe@linaro.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Nov 25, 2024 at 07:56:10PM +0000, Jean-Philippe Brucker wrote:
> This option selects which measurement algorithm to use for attestation.
> Supported values are SHA256 and SHA512. Default to SHA512 arbitrarily.

I'd suggest that defaulting to sha256 is the better choice.

sha512 is overkill from a security POV, while doubling the size
of hash data that has to be passed around. It is unusual for
applications needing hashing to pick 512 over 256 IME.

Shorter config param data is a win for QEMU command line parameters.

> SHA512 is generally faster on 64-bit architectures. On a few arm64 CPUs
> I tested SHA256 is much faster, but that's most likely because they only
> support acceleration via FEAT_SHA256 (Armv8.0) and not FEAT_SHA512
> (Armv8.2). Future CPUs supporting RME are likely to also support
> FEAT_SHA512.

IMHO speed is largely tangential for this use case, as it is a
one time hash operation at VM startup.

> Cc: Eric Blake <eblake@redhat.com>
> Cc: Markus Armbruster <armbru@redhat.com>
> Cc: Daniel P. Berrangé <berrange@redhat.com>
> Cc: Eduardo Habkost <eduardo@habkost.net>
> Acked-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
> v2->v3: Rename measurement-algorithm
> ---
>  qapi/qom.json        | 20 +++++++++++++++++++-
>  target/arm/kvm-rme.c | 39 ++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 57 insertions(+), 2 deletions(-)
> 
> diff --git a/qapi/qom.json b/qapi/qom.json
> index f982850bca..901ba67634 100644
> --- a/qapi/qom.json
> +++ b/qapi/qom.json
> @@ -1068,6 +1068,20 @@
>    'data': { '*cpu-affinity': ['uint16'],
>              '*node-affinity': ['uint16'] } }
>  
> +##
> +# @RmeGuestMeasurementAlgorithm:
> +#
> +# @sha256: Use the SHA256 algorithm
> +#
> +# @sha512: Use the SHA512 algorithm
> +#
> +# Algorithm to use for realm measurements
> +#
> +# Since: 9.3
> +##
> +{ 'enum': 'RmeGuestMeasurementAlgorithm',
> +  'data': ['sha256', 'sha512'] }


A design question for Markus....


We have a "QCryptoHashAlg" enum that covers both of these strings
and more besides.

We have a choice of using a dedicated enum strictly limited to
just what RME needs, vs using the common enum type, but rejecting
unsupported algorithms at runtime.  Do we prefer duplication for
improve specificity, or removal of duplication ?

> +
>  ##
>  # @RmeGuestProperties:
>  #
> @@ -1077,10 +1091,14 @@
>  #     hex string. This optional parameter allows to uniquely identify
>  #     the VM instance during attestation. (default: 0)
>  #
> +# @measurement-algorithm: Realm measurement algorithm
> +#     (default: sha512)
> +#
>  # Since: 9.3
>  ##
>  { 'struct': 'RmeGuestProperties',
> -  'data': { '*personalization-value': 'str' } }
> +  'data': { '*personalization-value': 'str',
> +            '*measurement-algorithm': 'RmeGuestMeasurementAlgorithm' } }
>  

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


