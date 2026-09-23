Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7A7DC98302
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 06:08:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9G8z-0004gT-4o; Wed, 23 Sep 2026 02:07:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x9G8x-0004fh-Pl
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 02:07:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x9G8w-0008QC-87
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 02:07:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790143665;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Qc5Ksbd8VC+u/l7GdxEB+vQ8nL5ovASQUasaKRjx9tY=;
 b=EwAnsXRxWf3wS38NkGonfMAxL9IspTK7w4TyYECBQ7xA6fB0vgKk7JN1XGc9ylBPl+aqFT
 BdcXdcn7CSk6n3RrpGs0Trqol5bhEM83XjxWhcaCd2cEGszrZ1A3KxM7DxruEu0KAR/I06
 +/ufEvumuZoz9J1k/o4a1EPkY+OIGTw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-587-nBjYN0D_PCWG9eSwkysIJQ-1; Wed,
 23 Sep 2026 02:07:41 -0400
X-MC-Unique: nBjYN0D_PCWG9eSwkysIJQ-1
X-Mimecast-MFC-AGG-ID: nBjYN0D_PCWG9eSwkysIJQ_1790143660
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9CF331955DE1; Wed, 23 Sep 2026 06:07:39 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E599B1956041; Wed, 23 Sep 2026 06:07:38 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7E5D821E6A04; Wed, 23 Sep 2026 08:07:36 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Laurent Vivier <laurent@vivier.eu>,  Kostiantyn
 Kostiuk <kkostiuk@redhat.com>,  "Michael S. Tsirkin" <mst@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>,  Michael Roth <michael.roth@amd.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Jason Wang <jasowangio@gmail.com>,
 qemu-trivial@nongnu.org,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>,  Stefano Garzarella <sgarzare@redhat.com>,
 Kashyap Chamarthy <kchamart@redhat.com>,  Eric Blake <eblake@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,  Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org,  Michael Tokarev <mjt@tls.msk.ru>
Subject: Re: [PATCH v2 2/8] qapi: convert intro sections for unit tests
In-Reply-To: <20260922205605.501602-3-jsnow@redhat.com> (John Snow's message
 of "Tue, 22 Sep 2026 16:55:59 -0400")
References: <20260922205605.501602-1-jsnow@redhat.com>
 <20260922205605.501602-3-jsnow@redhat.com>
Date: Wed, 23 Sep 2026 08:07:36 +0200
Message-ID: <87ld8szejb.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
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

John Snow <jsnow@redhat.com> writes:

> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  tests/qapi-schema/doc-good.json                |  8 ++++----
>  tests/qapi-schema/doc-good.out                 | 15 ++++++---------
>  tests/qapi-schema/doc-interleaved-section.err  |  2 +-
>  tests/qapi-schema/doc-interleaved-section.json |  3 +--
>  4 files changed, 12 insertions(+), 16 deletions(-)
>
> diff --git a/tests/qapi-schema/doc-good.json b/tests/qapi-schema/doc-good.json
> index fac13425b72..d9a84ccd729 100644
> --- a/tests/qapi-schema/doc-good.json
> +++ b/tests/qapi-schema/doc-good.json
> @@ -94,10 +94,9 @@
>  
>  ##
>  # @Variant1:
> +#     A paragraph
>  #
> -# A paragraph
> -#
> -# Another paragraph
> +#     Another paragraph
>  #
>  # @var1 is undocumented
>  #

This creates a split.  doc-good.out and doc-good.txt need an update.
You got the former and missed the latter (appended) Happy to fix up in
my tree.

> @@ -206,7 +205,8 @@
>  
>  ##
>  # @cmd-boxed:
> -# If you're bored enough to read this, go see a video of boxed cats
> +#     If you're bored enough to read this, go see a video of boxed
> +#     cats
>  #
>  # Features:
>  # @cmd-feat1: a feature
> diff --git a/tests/qapi-schema/doc-good.out b/tests/qapi-schema/doc-good.out
> index 371dd25ffc7..eaaf119dea8 100644
> --- a/tests/qapi-schema/doc-good.out
> +++ b/tests/qapi-schema/doc-good.out
> @@ -126,15 +126,13 @@ doc symbol=Base
>   minimally indented
>  doc symbol=Variant1
>      Intro
> +    A paragraph
>  
> -    Plain
> -A paragraph
> -
> -Another paragraph
> -
> -@var1 is undocumented
> +    Another paragraph
>      Member=var1
>  
> +    Plain
> +@var1 is undocumented
>      Feature=variant1-feat
>  a feature
>      Feature=member-feat
> @@ -213,9 +211,8 @@ Note::
>  2.10
>  doc symbol=cmd-boxed
>      Intro
> -
> -    Plain
> -If you're bored enough to read this, go see a video of boxed cats
> +    If you're bored enough to read this, go see a video of boxed
> +    cats
>      Feature=cmd-feat1
>  a feature
>      Feature=cmd-feat2
> diff --git a/tests/qapi-schema/doc-interleaved-section.err b/tests/qapi-schema/doc-interleaved-section.err
> index e5d1ef54c1b..85f01fa57a7 100644
> --- a/tests/qapi-schema/doc-interleaved-section.err
> +++ b/tests/qapi-schema/doc-interleaved-section.err
> @@ -1 +1 @@
> -doc-interleaved-section.json:15:1: description of '@foobar:' follows a section
> +doc-interleaved-section.json:14:1: description of '@foobar:' follows a section
> diff --git a/tests/qapi-schema/doc-interleaved-section.json b/tests/qapi-schema/doc-interleaved-section.json
> index eec01ed5650..bc0937b8601 100644
> --- a/tests/qapi-schema/doc-interleaved-section.json
> +++ b/tests/qapi-schema/doc-interleaved-section.json
> @@ -2,8 +2,7 @@
>  
>  ##
>  # @TestStruct:
> -#
> -# body
> +#     body
>  #
>  # @integer: foo
>  #           blah

diff --git a/tests/qapi-schema/doc-good.txt b/tests/qapi-schema/doc-good.txt
index 74b73681d3..ba089a7f94 100644
--- a/tests/qapi-schema/doc-good.txt
+++ b/tests/qapi-schema/doc-good.txt
@@ -65,11 +65,11 @@ Object Variant1
 
    Another paragraph
 
-   "var1" is undocumented
-
    Members:
       * **var1** ("string") -- Not documented
 
+   "var1" is undocumented
+
    Features:
       * **variant1-feat** -- a feature
 


