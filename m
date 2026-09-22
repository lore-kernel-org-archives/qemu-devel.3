Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AB6DC982FE
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 15:06:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x923W-0008Fz-96; Tue, 22 Sep 2026 11:05:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x923M-0008F3-Lq
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 11:05:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x923K-0000E1-7n
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 11:05:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790089500;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qp9qbFjCh1VRCmcFLEV8A2P+Wj1OKCQz0E8TprRLUvo=;
 b=DFwbaCT8jARxYOIIa+zbKNconOzVMAYOFtnj7CIPQFOuOcJv9APwxeLTtDzG2r3Lug1nfB
 /zRrFo41YuELba5b7CCxCh3WVqE2jAymq8jB3hMR3UaooPkrm5HnH746qh8UQzK4TNL/SH
 4lpTZWb3lk9jnM7ba8N3VgVzPdj1ogA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-509-XyUau_4ZM4CohkPxgGOANw-1; Tue,
 22 Sep 2026 11:04:55 -0400
X-MC-Unique: XyUau_4ZM4CohkPxgGOANw-1
X-Mimecast-MFC-AGG-ID: XyUau_4ZM4CohkPxgGOANw_1790089493
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9F790183EEEA; Tue, 22 Sep 2026 15:04:53 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 01FB21953941; Tue, 22 Sep 2026 15:04:53 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8ABA121E6A04; Tue, 22 Sep 2026 17:04:50 +0200 (CEST)
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
Subject: Re: [PATCH 7/9] qapi: convert intro sections for
 docs/interop/firmware.json
In-Reply-To: <20260921205147.1857168-8-jsnow@redhat.com> (John Snow's message
 of "Mon, 21 Sep 2026 16:51:45 -0400")
References: <20260921205147.1857168-1-jsnow@redhat.com>
 <20260921205147.1857168-8-jsnow@redhat.com>
Date: Tue, 22 Sep 2026 17:04:50 +0200
Message-ID: <874ifh499p.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

> All conversions in this patch do not create a new documentation
> insertion point, except for one at the very end.
>
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  docs/interop/firmware.json | 76 ++++++++++++++++----------------------
>  1 file changed, 31 insertions(+), 45 deletions(-)
>
> diff --git a/docs/interop/firmware.json b/docs/interop/firmware.json
> index 421bee0e5ed..1efd32c6315 100644
> --- a/docs/interop/firmware.json
> +++ b/docs/interop/firmware.json

[...]

> @@ -250,12 +244,11 @@
>  
>  ##
>  # @FirmwareFlashFile:
> -#
> -# Defines common properties that are necessary for loading a firmware
> -# file into a pflash chip.  The corresponding QEMU command line option
> -# is "-drive file=@filename,format=@format".  Note however that the
> -# option-argument shown here is incomplete; it is completed under
> -# @FirmwareMappingFlash.
> +#     Defines common properties that are necessary for loading a
> +#     firmware file into a pflash chip.  The corresponding QEMU
> +#     command line option is "-drive file=@filename,format=@format".
> +#     Note however that the option-argument shown here is incomplete;
> +#     it is completed under @FirmwareMappingFlash.
>  #
>  # @filename: Specifies the filename on the host filesystem where the
>  #     firmware file can be found.

This smells like it could use a split, but it doesn't really matter;
let's move on.

[...]

> @@ -467,9 +454,8 @@
>  
>  ##
>  # @Firmware:
> -#
> -# Describes a firmware (or a firmware use case) to management
> -# software.
> +#     Describes a firmware (or a firmware use case) to management
> +#     software.
>  #
>  # It is possible for multiple @Firmware elements to match the search
>  # criteria of management software.  Applications thus need rules to

This is the split you mentioned in the commit message.  Correct?


