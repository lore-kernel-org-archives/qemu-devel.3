Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 282DEC61DD3
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 05:24:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2MQ1-0004rB-A3; Fri, 04 Sep 2026 01:24:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x2MQ0-0004nn-DW
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 01:24:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x2MPy-0001ja-R8
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 01:24:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788499489;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Wm0SJzPJmyBvLFHwxrPdW6WsUK9z1BhojGQtDpeSBrw=;
 b=U3kTq3lQk7zjEOUHOjcz5Fp3MTHFSHkkS8pW2hfxZZlJobd5Tpi+5z+FVizGnc2al3Cuyl
 CDLlcVXrU2Ek/nWi8JZ0iEHo8KPPbIoyl8uIKqs+kozoVUU5d5Hx9VRm4y+6bbkgLAv6Dx
 TolgkrnYRFlrfIz6DbDX1LFqlO3Lraw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-680--9FOUs-NMd2PGlllRtDKXQ-1; Fri,
 04 Sep 2026 01:24:45 -0400
X-MC-Unique: -9FOUs-NMd2PGlllRtDKXQ-1
X-Mimecast-MFC-AGG-ID: -9FOUs-NMd2PGlllRtDKXQ_1788499484
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DD7DF18C107F; Fri,  4 Sep 2026 05:24:43 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 148BE1801AEA; Fri,  4 Sep 2026 05:24:43 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A0E8C21E6A04; Fri, 04 Sep 2026 07:24:40 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Jason Wang <jasowangio@gmail.com>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Philippe =?utf-8?Q?Math?=
 =?utf-8?Q?ieu-Daud=C3=A9?=
 <philmd@mailo.com>,  Fabiano Rosas <farosas@suse.de>,  Hanna Reitz
 <hreitz@redhat.com>,  Zhao Liu <zhao1.liu@intel.com>,  Peter Xu
 <peterx@redhat.com>,  Eric Blake <eblake@redhat.com>,  Kevin Wolf
 <kwolf@redhat.com>,  qemu-block@nongnu.org,  Paolo Bonzini
 <pbonzini@redhat.com>
Subject: Re: [PATCH 5/5] qapi: convert simple event intros for block-core.json
In-Reply-To: <20260903200008.729791-6-jsnow@redhat.com> (John Snow's message
 of "Thu, 3 Sep 2026 16:00:08 -0400")
References: <20260903200008.729791-1-jsnow@redhat.com>
 <20260903200008.729791-6-jsnow@redhat.com>
Date: Fri, 04 Sep 2026 07:24:40 +0200
Message-ID: <87cxutio6f.fsf@pond.sub.org>
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
>  qapi/block-core.json | 30 ++++++++++++++----------------
>  1 file changed, 14 insertions(+), 16 deletions(-)
>
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 29f011dc209..84ef21736b8 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -5555,11 +5555,10 @@
>  
>  ##
>  # @BLOCK_IMAGE_CORRUPTED:
> -#
> -# Emitted when a disk image is being marked corrupt.  The image can be
> -# identified by its device or node name.  The 'device' field is always
> -# present for compatibility reasons, but it can be empty ("") if the
> -# image does not have a device name associated.
> +#     Emitted when a disk image is being marked corrupt.  The image
> +#     can be identified by its device or node name.  The 'device'
> +#     field is always present for compatibility reasons, but it can be
> +#     empty ("") if the image does not have a device name associated.

'device' should be @device, and this part of the text should probably go
below the argument descriptions.  I spotted related issues in review of
your "[PATCH 12/12] qapi: convert simple command intros for
block-core.json".  Same reaction: leave for later, note future work:

1. Add missing markup to argument / member / feature references.

2. Review and improve doc comments where the intro refers to arguments /
members / features.

>  #
>  # @device: device name.  This is always present for compatibility
>  #     reasons, but it can be empty ("") if the image does not have a

[...]


