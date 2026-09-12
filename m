Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A82F6C79FB6
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2026 07:35:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5IG1-0002No-0M; Sat, 12 Sep 2026 03:34:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x5IFy-0002NC-Rr
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 03:34:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x5IFx-0000jN-Ew
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 03:34:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789198476;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=milOYn+egTVPgep39dcg4cxxAUlOsDpdyziKQ5Gn3pM=;
 b=hGChywuGR1MLkL52bV/pipT9nuDGk9KAg5vSxTMc44C0J7oGJVvG1RELJ7yhsSoE3+JwTN
 bPcMsRHn1UXuXZw2roIjU1jinnOGVD3A2PPolWXt+6yv2F/S0Yz33Hj/LbyLuAVPnn9muy
 1CM6p5r+6VNlFAQde4yTH+0aMY6vHuA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-19-RRoGBTgoMR2QI0_6mjf2yA-1; Sat,
 12 Sep 2026 03:34:32 -0400
X-MC-Unique: RRoGBTgoMR2QI0_6mjf2yA-1
X-Mimecast-MFC-AGG-ID: RRoGBTgoMR2QI0_6mjf2yA_1789198470
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1C4AF18005AA; Sat, 12 Sep 2026 07:34:30 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 21DD41800446; Sat, 12 Sep 2026 07:34:29 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id AD1CE21E6A04; Sat, 12 Sep 2026 09:34:26 +0200 (CEST)
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
Subject: Re: [PATCH 1/6] qapi: convert remaining simple intros for
 block-export.json
In-Reply-To: <20260911172200.227914-2-jsnow@redhat.com> (John Snow's message
 of "Fri, 11 Sep 2026 13:21:55 -0400")
References: <20260911172200.227914-1-jsnow@redhat.com>
 <20260911172200.227914-2-jsnow@redhat.com>
Date: Sat, 12 Sep 2026 09:34:26 +0200
Message-ID: <87ik4a3ou5.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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

> These are either structs or unions that are used in an inlinable
> context: i.e. the generated documentation is likely to feature a
> version of this documentation block that does not include the intro in
> context of another command, event, or structure.
>
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  qapi/block-export.json | 19 ++++++++-----------
>  1 file changed, 8 insertions(+), 11 deletions(-)
>
> diff --git a/qapi/block-export.json b/qapi/block-export.json
> index 2893c6456d5..e9f7e72c8ee 100644
> --- a/qapi/block-export.json
> +++ b/qapi/block-export.json
> @@ -37,10 +37,9 @@
>  
>  ##
>  # @NbdServerOptions:
> -#
> -# Keep this type consistent with the `NbdServerOptionsLegacy` type.
> -# The only intended difference is using `SocketAddress` instead of
> -# `SocketAddressLegacy`.
> +#     Keep this type consistent with the `NbdServerOptionsLegacy`
> +#     type.  The only intended difference is using `SocketAddress`
> +#     instead of `SocketAddressLegacy`.

"Keep this consistent" is for developers, and should not go into user
reference documentation.

Let's leave this for another day, just take note of future work:

6. Move comments for developers out of doc comments

>  #
>  # @addr: Address on which to listen (since 4.2).
>  ##
> @@ -50,10 +49,9 @@
>  
>  ##
>  # @NbdServerOptionsLegacy:
> -#
> -# Keep this type consistent with the `NbdServerOptions` type.  The
> -# only intended difference is using `SocketAddressLegacy` instead of
> -# `SocketAddress`.
> +#     Keep this type consistent with the `NbdServerOptions` type.  The
> +#     only intended difference is using `SocketAddressLegacy` instead
> +#     of `SocketAddress`.

Likewise.

>  #
>  # @addr: Address on which to listen (since 1.3).
>  ##
> @@ -339,9 +337,8 @@
>  
>  ##
>  # @BlockExportOptions:
> -#
> -# Describes a block export, i.e. how single node should be exported on
> -# an external interface.
> +#     Describes a block export, i.e. how single node should be
> +#     exported on an external interface.
>  #
>  # @type: Block export type
>  #


