Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88955C79FB6
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2026 07:35:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5IGW-0002VU-8N; Sat, 12 Sep 2026 03:35:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x5IGU-0002UL-KJ
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 03:35:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x5IGS-0000vf-QG
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 03:35:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789198508;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=v4il07WnelfQAacPaGox1eoQq+k6ZMm81RGQtSdm/8U=;
 b=MAlKNRgfQBBN7XFuVoN/HI1VFw7AgghwGmyZqzRsclEI7TBWutsrP/hZed8YKZ9/Exo2Ug
 17OLrJLVDzXIR5RA40zHP0iI5s2UETVxl8pRaPFD5mHvz4+hTnDLl8xIUBFTw+hPHblb+K
 zBGW8/Ds53TK7Lj19Yy0e7EjMkT/5l4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-317-vKT7G3BMPSK65s1OChCOjQ-1; Sat,
 12 Sep 2026 03:35:06 -0400
X-MC-Unique: vKT7G3BMPSK65s1OChCOjQ-1
X-Mimecast-MFC-AGG-ID: vKT7G3BMPSK65s1OChCOjQ_1789198505
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D3F221802647; Sat, 12 Sep 2026 07:35:04 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CF96F18004D4; Sat, 12 Sep 2026 07:35:03 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 749DA21E6A04; Sat, 12 Sep 2026 09:35:01 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  qemu-block@nongnu.org,  Kevin Wolf
 <kwolf@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@mailo.com>,  Eric
 Blake <eblake@redhat.com>,  Jonathan Cameron <jic23@kernel.org>,  Lukas
 Straub <lukasstraub2@web.de>,  Paolo Bonzini <pbonzini@redhat.com>,  Zhao
 Liu <zhao1.liu@intel.com>,  linux-cxl@vger.kernel.org,  Jason Wang
 <jasowangio@gmail.com>,  Hanna Reitz <hreitz@redhat.com>,  Fabiano Rosas
 <farosas@suse.de>,  Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH 4/6] qapi: convert remaining simple intros for
 block-core.json
In-Reply-To: <20260911172200.227914-5-jsnow@redhat.com> (John Snow's message
 of "Fri, 11 Sep 2026 13:21:58 -0400")
References: <20260911172200.227914-1-jsnow@redhat.com>
 <20260911172200.227914-5-jsnow@redhat.com>
Date: Sat, 12 Sep 2026 09:35:01 +0200
Message-ID: <87fqze3ot6.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

> These are either structs or unions that are used in an inlinable
> context: i.e. the generated documentation is likely to feature a
> version of this documentation block that does not include the intro in
> context of another command, event, or structure.
>
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  qapi/block-core.json | 45 +++++++++++++++++++-------------------------
>  1 file changed, 19 insertions(+), 26 deletions(-)
>
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 1ca147285e7..88218e38d02 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -4462,9 +4462,8 @@
>  
>  ##
>  # @BlockdevOptionsCurlHttp:
> -#
> -# Driver specific block device options for HTTP connections over the
> -# curl backend.  URLs must start with "http://".
> +#     Driver specific block device options for HTTP connections over
> +#     the curl backend.  URLs must start with "http://".
>  #
>  # @cookie: List of cookies to set; format is "name1=content1;
>  #     name2=content2;" as explained by CURLOPT_COOKIE(3).  Defaults to

Not this patch's problem, but here goes anyway.

"URLs must start" applies to BlockdevOptionsCurlBase member @url.  We
should turn this into a proper link eventually.

Pattern: the base type's documentation needs to be amended somehow.
Here, we need to amend it to restrict the values os the base's member
@url.

This splits the documentation for @url.  Amendments are easy to miss.
At some point, we might want to think of ways to avoid this.

> @@ -4488,9 +4487,8 @@
>  
>  ##
>  # @BlockdevOptionsCurlHttps:
> -#
> -# Driver specific block device options for HTTPS connections over the
> -# curl backend.  URLs must start with "https://".
> +#     Driver specific block device options for HTTPS connections over
> +#     the curl backend.  URLs must start with "https://".
>  #
>  # @sslverify: Whether to verify the SSL certificate's validity
>  #     (defaults to true)
> @@ -4503,9 +4501,8 @@
>  
>  ##
>  # @BlockdevOptionsCurlFtp:
> -#
> -# Driver specific block device options for FTP connections over the
> -# curl backend.  URLs must start with "ftp://".
> +#     Driver specific block device options for FTP connections over
> +#     the curl backend.  URLs must start with "ftp://".
>  #
>  # Since: 2.9
>  ##
> @@ -4515,9 +4512,8 @@
>  
>  ##
>  # @BlockdevOptionsCurlFtps:
> -#
> -# Driver specific block device options for FTPS connections over the
> -# curl backend.  URLs must start with "ftps://".
> +#     Driver specific block device options for FTPS connections over
> +#     the curl backend.  URLs must start with "ftps://".
>  #
>  # @sslverify: Whether to verify the SSL certificate's validity
>  #     (defaults to true)
> @@ -4643,14 +4639,13 @@
>  
>  ##
>  # @BlockdevOptionsCbw:
> -#
> -# Driver specific block device options for the copy-before-write
> -# driver, which does so called copy-before-write operations: when data
> -# is written to the filter, the filter first reads corresponding
> -# blocks from its file child and copies them to @target child.  After
> -# successfully copying, the write request is propagated to file child.
> -# If copying fails, the original write request is failed too and no
> -# data is written to file child.
> +#     Driver specific block device options for the copy-before-write
> +#     driver, which does so called copy-before-write operations: when
> +#     data is written to the filter, the filter first reads
> +#     corresponding blocks from its file child and copies them to
> +#     @target child.  After successfully copying, the write request is
> +#     propagated to file child.  If copying fails, the original write
> +#     request is failed too and no data is written to file child.
>  #
>  # @target: The target for copy-before-write operations.
>  #
> @@ -4686,9 +4681,8 @@
>  
>  ##
>  # @BlockdevOptions:
> -#
> -# Options for creating a block device.  Many options are available for
> -# all block devices, independent of the block driver:
> +#     Options for creating a block device.  Many options are available
> +#     for all block devices, independent of the block driver:

Intro ends with colon, which is unusual, and doesn't really work with
the way documentation gets rendered:

   Options for creating a block device.  Many options are available
   for all block devices, independent of the block driver:

   Members:
      * driver ("BlockdevDriver") -- block driver name

      [More non-variant members...]

      * force-share ("boolean", *optional*) -- force share all
        permission on added nodes.  Requires read-only=true.  (Since
        2.10)

      * When "driver" is "blkdebug": The members of
        "BlockdevOptionsBlkdebug".

      [More variants...]

>  #
>  # @driver: block driver name
>  #
> @@ -5473,9 +5467,8 @@
>  
>  ##
>  # @BlockdevAmendOptionsQcow2:
> -#
> -# Driver specific image amend options for qcow2.  For now, only
> -# encryption options can be amended
> +#     Driver specific image amend options for qcow2.  For now, only
> +#     encryption options can be amended

The second sentence lacks a period.

Let's leave both of these for another day, just take note of future
work:

7. Clean up intros to consist of sentences.  Sentences start with a
capital letter and end with a period.

>  #
>  # @encrypt: Encryption options to be amended
>  #


