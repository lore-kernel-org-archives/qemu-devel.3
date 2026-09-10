Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACFAEC79FB7
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 04:48:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4Whb-0007vT-4s; Thu, 10 Sep 2026 00:47:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x4WhZ-0007vA-PX
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 00:47:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x4WhY-0002JX-AS
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 00:47:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789015675;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=U2A3OgVMxcHHdCjgS4ebzHoZ9OS3sHLFyVUP0LuvR4M=;
 b=MEtb3gEhZl/F6idWT8mBvkrRIQhLSUsYs6PVLbZfDOpuRNKVhMFXal3VAGaomxoMZixrXN
 6evViFZkZcGItpDoq4SrcMqivZFbGctT4jyrJJmT10vTBVqvpEqm8x5sNOyoGVX8LixmQU
 V7TdJDY6oYahWF+VpUKTGsBbUOpdjF8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-164-NhxSHBubOFWgm1Jd3D1Ezg-1; Thu,
 10 Sep 2026 00:47:50 -0400
X-MC-Unique: NhxSHBubOFWgm1Jd3D1Ezg-1
X-Mimecast-MFC-AGG-ID: NhxSHBubOFWgm1Jd3D1Ezg_1789015668
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C53291956095; Thu, 10 Sep 2026 04:47:47 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7FA40195608B; Thu, 10 Sep 2026 04:47:46 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id ECD3221E6A04; Thu, 10 Sep 2026 06:47:43 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Peter Xu <peterx@redhat.com>,  Fabiano Rosas
 <farosas@suse.de>,  qemu-block@nongnu.org,  Eric Blake
 <eblake@redhat.com>,  =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Alex Williamson <alex@shazbot.org>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Jonathan
 Cameron <jic23@kernel.org>,  Lukas Straub <lukasstraub2@web.de>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,  Zhao Liu
 <zhao1.liu@intel.com>,  Hanna
 Reitz <hreitz@redhat.com>,  linux-cxl@vger.kernel.org,  Kevin Wolf
 <kwolf@redhat.com>
Subject: Re: [PATCH 05/10] qapi: convert simple enum intros for cypto.json
In-Reply-To: <20260909041640.69080-6-jsnow@redhat.com> (John Snow's message of
 "Wed, 9 Sep 2026 00:16:35 -0400")
References: <20260909041640.69080-1-jsnow@redhat.com>
 <20260909041640.69080-6-jsnow@redhat.com>
Date: Thu, 10 Sep 2026 06:47:43 +0200
Message-ID: <87jyothfv4.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  qapi/crypto.json | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/qapi/crypto.json b/qapi/crypto.json
> index 5e395bc10c7..f85d1cebed3 100644
> --- a/qapi/crypto.json
> +++ b/qapi/crypto.json
> @@ -10,10 +10,10 @@
>  
>  ##
>  # @QCryptoTLSCredsEndpoint:
> -#
> -# The type of network endpoint that will be using the credentials.
> -# Most types of credential require different setup / structures
> -# depending on whether they will be used in a server versus a client.
> +#     The type of network endpoint that will be using the credentials.
> +#     Most types of credential require different setup / structures
> +#     depending on whether they will be used in a server versus a
> +#     client.
>  #
>  # @client: the network endpoint is acting as the client
>  #
> @@ -126,11 +126,11 @@
>  
>  ##
>  # @QCryptoIVGenAlgo:
> -#
> -# The supported algorithms for generating initialization vectors for
> -# full disk encryption.  The 'plain' generator should not be used for
> -# disks with sector numbers larger than 2^32, except where
> -# compatibility with pre-existing Linux dm-crypt volumes is required.
> +#     The supported algorithms for generating initialization vectors
> +#     for full disk encryption.  The 'plain' generator should not be
> +#     used for disks with sector numbers larger than 2^32, except
> +#     where compatibility with pre-existing Linux dm-crypt volumes is
> +#     required.

'plain' should be @plain, and this part of the text should probably go
below the member descriptions.  I spotted related issues in review of
your "[PATCH 12/12] qapi: convert simple command intros for
block-core.json" and "[PATCH 5/5] qapi: convert simple event intros for
block-core.json".  Same reaction: leave for later, note future work:

1. Add missing markup to argument / member / feature references.

2. Review and improve doc comments where the intro refers to arguments /
members / features.

>  #
>  # @plain: 64-bit sector number truncated to 32-bits
>  #


