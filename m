Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A7AFC28B2E
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 06:56:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tscTO-0005PQ-NI; Thu, 13 Mar 2025 02:55:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tscT1-0005Cg-Ip
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 02:54:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tscSz-0005ed-SO
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 02:54:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741848892;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5/p+AcFG+nzj5Ok7M2TaUyDpKZTxhAJHi6p2eOtfisg=;
 b=VFKs+tg8mxi/lN7XF509UrMGECxmQq8BgcLRQvPhQfuO8REKCVdtuzqHh/3xHC/SSGHaDV
 uWSDC24lZ93gL0WTpkaToosPNPVfqhjoiAvAicwtCJkRtgoe4gj3fnnsTYugS1dXp/nFl0
 P621Fwe7yaQeKCkBkNq0ZpOoQeXuXZM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-621-6lkSrfTbPXa2_rlT56zDzw-1; Thu,
 13 Mar 2025 02:54:48 -0400
X-MC-Unique: 6lkSrfTbPXa2_rlT56zDzw-1
X-Mimecast-MFC-AGG-ID: 6lkSrfTbPXa2_rlT56zDzw_1741848887
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B8C59180049D; Thu, 13 Mar 2025 06:54:47 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.22.74.4])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 38E251978F5D; Thu, 13 Mar 2025 06:54:47 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 746CE21E66C1; Thu, 13 Mar 2025 07:54:43 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Konstantin Kostiuk <kkostiuk@redhat.com>,  Peter
 Maydell <peter.maydell@linaro.org>,  Eric Blake <eblake@redhat.com>,
 qemu-block@nongnu.org,  Michael Roth <michael.roth@amd.com>,  Kevin Wolf
 <kwolf@redhat.com>
Subject: Re: [PATCH 11/11] docs: enable transmogrifier for QSD and QGA
In-Reply-To: <20250313044312.189276-12-jsnow@redhat.com> (John Snow's message
 of "Thu, 13 Mar 2025 00:43:12 -0400")
References: <20250313044312.189276-1-jsnow@redhat.com>
 <20250313044312.189276-12-jsnow@redhat.com>
Date: Thu, 13 Mar 2025 07:54:43 +0100
Message-ID: <87y0x9cte4.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

John Snow <jsnow@redhat.com> writes:

> This also creates the `qapi-qsd-index` and `qapi-qga-index` QMP indices.
>
> Signed-off-by: John Snow <jsnow@redhat.com>

[...]

> diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
> index 995594aaf43..35ec0e7db31 100644
> --- a/qga/qapi-schema.json
> +++ b/qga/qapi-schema.json
> @@ -3,6 +3,9 @@
>  
>  ##
>  # = QEMU guest agent protocol commands and structs
> +#
> +# For a concise listing of all commands, events, and types in the QEMU
> +# guest agent, please consult the `qapi-qga-index`.
>  ##
>  
>  { 'pragma': { 'doc-required': true } }
> diff --git a/storage-daemon/qapi/qapi-schema.json b/storage-daemon/qapi/qapi-schema.json
> index f10c9494906..2a562ee32e5 100644
> --- a/storage-daemon/qapi/qapi-schema.json
> +++ b/storage-daemon/qapi/qapi-schema.json
> @@ -13,6 +13,14 @@
>  # the array type in the main schema, even if it is unused outside of the
>  # storage daemon.
>  
> +##
> +# = QEMU storage daemon protocol commands and structs
> +#
> +# For a concise listing of all commands, events, and types in the QEMU
> +# storage daemon, please consult the `qapi-qsd-index`.
> +##
> +
> +
>  { 'include': '../../qapi/pragma.json' }
>  
>  # Documentation generated with qapi-gen.py is in source order, with

Compare qapi/qapi-schema.json:

   # = Introduction
   #
   # This document describes all commands currently supported by QMP.
   #
   # For locating a particular item, please see the `qapi-qmp-index`.
   #

Suggest to pick one phrasing and stick to it, unless there's a reason
for more than one.


