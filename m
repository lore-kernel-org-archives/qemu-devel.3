Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98D74C88E5C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 09:48:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6mFV-0005YV-Jy; Wed, 16 Sep 2026 05:48:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x6mFB-0005XQ-Cg
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 05:48:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x6mF9-0003yL-SE
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 05:47:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789552075;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xTkHLONo+Ken2qC1ucAI/GroFXoUoMQ1JDE0I4EPxZI=;
 b=Q+Ji2rEEazCkAM9Z6HN6ZJFhEb89fSE7VnTTNd9t3mKSe3Vwox/moPy56o5fkbrhuZYwIT
 iplstuRaMHrR5zQ19MN+Nn+g0O50OMwY8gT3brR1LenISNASzsPtFBAPZn55h/pIu9N9Fs
 fzQnYqoKW9eNY/pJFkkGjDVPU1QgO20=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-270-_vmIS3_WPP2yW7Wu1nxDWA-1; Wed,
 16 Sep 2026 05:47:51 -0400
X-MC-Unique: _vmIS3_WPP2yW7Wu1nxDWA-1
X-Mimecast-MFC-AGG-ID: _vmIS3_WPP2yW7Wu1nxDWA_1789552070
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BA9751953961; Wed, 16 Sep 2026 09:47:49 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6F0911800473; Wed, 16 Sep 2026 09:47:48 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 10EFF21E6A04; Wed, 16 Sep 2026 11:47:46 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Zhao Liu <zhao1.liu@intel.com>,  Jason Wang
 <jasowangio@gmail.com>,  Paolo Bonzini <pbonzini@redhat.com>,  Fabiano
 Rosas <farosas@suse.de>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@mailo.com>,
 Hanna Reitz <hreitz@redhat.com>,  Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-block@nongnu.org,  Eric Blake <eblake@redhat.com>,  Igor Mammedov
 <imammedo@redhat.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,  Peter Xu <peterx@redhat.com>,
 Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Ani Sinha
 <anisinha@redhat.com>
Subject: Re: [PATCH 3/9] qapi: convert multi-paragraph intros (enums)
In-Reply-To: <20260911203002.305316-4-jsnow@redhat.com> (John Snow's message
 of "Fri, 11 Sep 2026 16:29:56 -0400")
References: <20260911203002.305316-1-jsnow@redhat.com>
 <20260911203002.305316-4-jsnow@redhat.com>
Date: Wed, 16 Sep 2026 11:47:46 +0200
Message-ID: <87zexhbk8t.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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

> This patch converts some slightly-non-trivial intros with more than
> one paragraph, but doesn't create any new intro/details splits.
>
> Review notes: The "See also ..." texts here are prime candidates for
> moving into the details section with a ".. seealso::", but like the
> last patch, as these are for enums and not candidates as an inline
> source, I left them alone for now to keep patch sizes and motion down
> until after initial review.
>
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  qapi/machine.json | 39 +++++++++++++++++++--------------------
>  1 file changed, 19 insertions(+), 20 deletions(-)
>
> diff --git a/qapi/machine.json b/qapi/machine.json
> index 0516112f8e8..710b638b3bf 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json
> @@ -608,12 +608,12 @@
>  
>  ##
>  # @HmatLBMemoryHierarchy:
> +#     The memory hierarchy in the System Locality Latency and
> +#     Bandwidth Information Structure of HMAT (Heterogeneous Memory
> +#     Attribute Table)
>  #
> -# The memory hierarchy in the System Locality Latency and Bandwidth
> -# Information Structure of HMAT (Heterogeneous Memory Attribute Table)
> -#
> -# For more information about `HmatLBMemoryHierarchy`, see chapter
> -# 5.2.27.4: Table 5-146: Field "Flags" of ACPI 6.3 spec.
> +#     For more information about `HmatLBMemoryHierarchy`, see chapter
> +#     5.2.27.4: Table 5-146: Field "Flags" of ACPI 6.3 spec.

This is one of the "see also" you discussed in the commit message.  Such
references tend to belong closer to the end, not in the intro.  Moving
involves a split.

More of the same below.

Not splitting now keeps the conversion simple, which is a plus.  It
reindents the entire unsplit intro, and if we do split it later, the
part split off gets reindented right back.

I'm happy to leave this decision to you.  I'm adding to my notes on
future work:

8. Move "see also" out of intro

>  #
>  # @memory: the structure represents the memory performance
>  #
> @@ -630,12 +630,12 @@
>  
>  ##
>  # @HmatLBDataType:
> +#     Data type in the System Locality Latency and Bandwidth
> +#     Information Structure of HMAT (Heterogeneous Memory Attribute
> +#     Table)
>  #
> -# Data type in the System Locality Latency and Bandwidth Information
> -# Structure of HMAT (Heterogeneous Memory Attribute Table)
> -#
> -# For more information about `HmatLBDataType`, see chapter 5.2.27.4:
> -# Table 5-146: Field "Data Type" of ACPI 6.3 spec.
> +#     For more information about `HmatLBDataType`, see chapter
> +#     5.2.27.4: Table 5-146: Field "Data Type" of ACPI 6.3 spec.
>  #
>  # @access-latency: access latency (nanoseconds)
>  #
> @@ -693,12 +693,11 @@
>  
>  ##
>  # @HmatCacheAssociativity:
> +#     Cache associativity in the Memory Side Cache Information
> +#     Structure of HMAT
>  #
> -# Cache associativity in the Memory Side Cache Information Structure
> -# of HMAT
> -#
> -# For more information of `HmatCacheAssociativity`, see chapter
> -# 5.2.27.5: Table 5-147 of ACPI 6.3 spec.
> +#     For more information of `HmatCacheAssociativity`, see chapter
> +#     5.2.27.5: Table 5-147 of ACPI 6.3 spec.
>  #
>  # @none: None (no memory side cache in this proximity domain, or cache
>  #     associativity unknown)
> @@ -714,12 +713,12 @@
>  
>  ##
>  # @HmatCacheWritePolicy:
> +#     Cache write policy in the Memory Side Cache Information
> +#     Structure of HMAT
>  #
> -# Cache write policy in the Memory Side Cache Information Structure of
> -# HMAT
> -#
> -# For more information of `HmatCacheWritePolicy`, see chapter
> -# 5.2.27.5: Table 5-147: Field "Cache Attributes" of ACPI 6.3 spec.
> +#     For more information of `HmatCacheWritePolicy`, see chapter
> +#     5.2.27.5: Table 5-147: Field "Cache Attributes" of ACPI 6.3
> +#     spec.
>  #
>  # @none: None (no memory side cache in this proximity domain, or cache
>  #     write policy unknown)


