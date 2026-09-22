Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB673C98302
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 17:06:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x93wY-0007Es-0W; Tue, 22 Sep 2026 13:06:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x93wQ-0007Dv-Oe
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 13:06:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x93wP-0004Ba-8W
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 13:06:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790096760;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HYAuJYMHVKECvw4I1vaX7j/jcHTP5akScR7OEdaB7Rg=;
 b=XiQctiBXxjvoLBbKp2QdRzoQyHYr09SO0SYDw3AYJ3GlvkrizSmU8F6xYT0B4Uo47RmoC5
 AvvsvBvrlNILzVvh4VWoH5908tGUZITXtL8rGBem9wQzE97AJilPCluM3FkWKA3h9FAPeK
 lB0GuH8JYfcVjImIKxt7d3efSzpVCaM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-678-26QJ3aK1Pa6JWhlFMxHoBQ-1; Tue,
 22 Sep 2026 13:05:57 -0400
X-MC-Unique: 26QJ3aK1Pa6JWhlFMxHoBQ-1
X-Mimecast-MFC-AGG-ID: 26QJ3aK1Pa6JWhlFMxHoBQ_1790096755
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F04401805A1B; Tue, 22 Sep 2026 17:05:54 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 40B431800351; Tue, 22 Sep 2026 17:05:54 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B75C121E6A04; Tue, 22 Sep 2026 19:05:51 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Michael Roth <michael.roth@amd.com>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Kashyap Chamarthy
 <kchamart@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>,  Michael Tokarev <mjt@tls.msk.ru>,  Hanna
 Reitz <hreitz@redhat.com>,  Stefano Garzarella <sgarzare@redhat.com>,
 Jason Wang <jasowangio@gmail.com>,  Zhao Liu <zhao1.liu@intel.com>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Da?=
 =?utf-8?Q?ud=C3=A9?= <philmd@oss.qualcomm.com>,  qemu-block@nongnu.org,
 qemu-trivial@nongnu.org,  Laurent Vivier <laurent@vivier.eu>,  Eric Blake
 <eblake@redhat.com>,  "Michael S. Tsirkin" <mst@redhat.com>,  Pierrick
 Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: Re: [PATCH 2/9] qapi: convert intro sections for unit tests
In-Reply-To: <20260921205147.1857168-3-jsnow@redhat.com> (John Snow's message
 of "Mon, 21 Sep 2026 16:51:40 -0400")
References: <20260921205147.1857168-1-jsnow@redhat.com>
 <20260921205147.1857168-3-jsnow@redhat.com>
Date: Tue, 22 Sep 2026 19:05:51 +0200
Message-ID: <87a4p92p3k.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
>  tests/qapi-schema/doc-good.json                | 10 +++++-----
>  tests/qapi-schema/doc-good.out                 | 13 +++++--------
>  tests/qapi-schema/doc-interleaved-section.err  |  2 +-
>  tests/qapi-schema/doc-interleaved-section.json |  3 +--
>  4 files changed, 12 insertions(+), 16 deletions(-)
>
> diff --git a/tests/qapi-schema/doc-good.json b/tests/qapi-schema/doc-good.json
> index fac13425b72..00721d5c522 100644
> --- a/tests/qapi-schema/doc-good.json
> +++ b/tests/qapi-schema/doc-good.json
> @@ -94,12 +94,11 @@
>  
>  ##
>  # @Variant1:
> +#     A paragraph
>  #
> -# A paragraph
> +#     Another paragraph
>  #
> -# Another paragraph
> -#
> -# @var1 is undocumented
> +#     @var1 is undocumented

Let's keep '@var1 is undocumented' plain.  That way, it stays close to
"author forgot the colon after the member name", which I find useful.

>  #
>  # Features:
>  # @variant1-feat: a feature
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
> index 371dd25ffc7..8c0818a3f0d 100644
> --- a/tests/qapi-schema/doc-good.out
> +++ b/tests/qapi-schema/doc-good.out
> @@ -126,13 +126,11 @@ doc symbol=Base
>   minimally indented
>  doc symbol=Variant1
>      Intro
> +    A paragraph
>  
> -    Plain
> -A paragraph
> +    Another paragraph
>  
> -Another paragraph
> -
> -@var1 is undocumented
> +    @var1 is undocumented
>      Member=var1
>  
>      Feature=variant1-feat
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

I'm mildly surprised that the intro's indentation isn't stripped.  Maybe
we discussed that already, and I forgot.  Anyway, it works, and changing
it is way out of scope right now.

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


