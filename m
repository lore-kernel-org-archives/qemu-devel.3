Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9937C54E4A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 07:35:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riUl2-0001wK-3p; Fri, 08 Mar 2024 02:35:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1riUkx-0001vn-Lp
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 02:35:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1riUkt-0006jD-Ry
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 02:35:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709883298;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3YeEwiyecYJozWumeIWxnUE913G+WAH25sdBxNDiA9U=;
 b=jAkdaZZofUTp41fF1CERdcikd9Og/LccuB6Ve4qSH0ZCpbV80i/l/ESOgFOCSpStpTvDci
 V8iyxHR/9Yeg2WQeHoO0X0UvyQzlgNIIUk0bMc+oJp8Fr7iMmuG/YgG9z3jF1NbutGx8bg
 28bCSaCJPHLbiGYM7ZiIubTv3UeVK/g=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-402-Hwn7CjFcPHm0xMLUQ9fPqg-1; Fri, 08 Mar 2024 02:34:54 -0500
X-MC-Unique: Hwn7CjFcPHm0xMLUQ9fPqg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D289B185A781;
 Fri,  8 Mar 2024 07:34:53 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.3])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 75676C04120;
 Fri,  8 Mar 2024 07:34:53 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0B83621E6A24; Fri,  8 Mar 2024 08:34:52 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-devel@nongnu.org,  qemu-block@nongnu.org,  eblake@redhat.com,
 hreitz@redhat.com,  kwolf@redhat.com,  vsementsov@yandex-team.ru,
 jsnow@redhat.com,  f.gruenbichler@proxmox.com,  t.lamprecht@proxmox.com,
 mahaocong@didichuxing.com,  xiechanglong.d@gmail.com,
 wencongyang2@huawei.com
Subject: Re: [PATCH v2 1/4] qapi/block-core: avoid the re-use of
 MirrorSyncMode for backup
In-Reply-To: <20240307134711.709816-2-f.ebner@proxmox.com> (Fiona Ebner's
 message of "Thu, 7 Mar 2024 14:47:08 +0100")
References: <20240307134711.709816-1-f.ebner@proxmox.com>
 <20240307134711.709816-2-f.ebner@proxmox.com>
Date: Fri, 08 Mar 2024 08:34:52 +0100
Message-ID: <87cys56usj.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.583,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Fiona Ebner <f.ebner@proxmox.com> writes:

> Backup supports all modes listed in MirrorSyncMode, while mirror does
> not. Introduce BackupSyncMode by copying the current MirrorSyncMode
> and drop the variants mirror does not support from MirrorSyncMode as
> well as the corresponding manual check in mirror_start().

Results in tighter introspection: query-qmp-schema no longer reports
drive-mirror and blockdev-mirror accepting @sync values they actually
reject.  Suggest to mention this in the commit message.

> Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
> ---
>
> I felt like keeping the "Since: X.Y" as before makes the most sense as
> to not lose history. Or is it necessary to change this for
> BackupSyncMode (and its members) since it got a new name?

Doc comments are for users of the QMP interface.  Type names do not
matter there.  I agree with your decision not to update the "since"
tags.

[...]

> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 1874f880a8..59d75b0793 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -1304,10 +1304,10 @@
>    'data': ['report', 'ignore', 'enospc', 'stop', 'auto'] }
>  
>  ##
> -# @MirrorSyncMode:
> +# @BackupSyncMode:
>  #
> -# An enumeration of possible behaviors for the initial synchronization
> -# phase of storage mirroring.
> +# An enumeration of possible behaviors for image synchronization used
> +# by backup jobs.
>  #
>  # @top: copies data in the topmost image to the destination
>  #
> @@ -1323,7 +1323,7 @@
>  #
>  # Since: 1.3
>  ##
> -{ 'enum': 'MirrorSyncMode',
> +{ 'enum': 'BackupSyncMode',
>    'data': ['top', 'full', 'none', 'incremental', 'bitmap'] }
>  
>  ##
> @@ -1347,6 +1347,23 @@
>  { 'enum': 'BitmapSyncMode',
>    'data': ['on-success', 'never', 'always'] }
>  
> +##
> +# @MirrorSyncMode:
> +#
> +# An enumeration of possible behaviors for the initial synchronization
> +# phase of storage mirroring.
> +#
> +# @top: copies data in the topmost image to the destination
> +#
> +# @full: copies data from all images to the destination
> +#
> +# @none: only copy data written from now on
> +#
> +# Since: 1.3
> +##
> +{ 'enum': 'MirrorSyncMode',
> +  'data': ['top', 'full', 'none'] }
> +
>  ##
>  # @MirrorCopyMode:
>  #
> @@ -1624,7 +1641,7 @@
>  ##
>  { 'struct': 'BackupCommon',
>    'data': { '*job-id': 'str', 'device': 'str',
> -            'sync': 'MirrorSyncMode', '*speed': 'int',
> +            'sync': 'BackupSyncMode', '*speed': 'int',
>              '*bitmap': 'str', '*bitmap-mode': 'BitmapSyncMode',
>              '*compress': 'bool',
>              '*on-source-error': 'BlockdevOnError',

QAPI schema
Acked-by: Markus Armbruster <armbru@redhat.com>


