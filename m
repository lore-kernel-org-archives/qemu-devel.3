Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B164C48BC3
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 06:56:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcgVd-0002cJ-E6; Wed, 21 Feb 2024 01:55:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rcgVb-0002bp-6y
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 01:55:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rcgVZ-0003O1-LC
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 01:55:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708498509;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z0ivVPMDW/jHYO1qb052WGs/syMNFRiVaaD7Begqu8Y=;
 b=BDHNelMmHIyqHrnH+ld25dvMKz8rBv1hekvxUJqmeNScWfwsv0Ew6nwiC8ypIfNjoLQndn
 QdxlObzhW4YXWGQMKK3+fea7iuVfKp3QokmykLaEP/Z+HkoIJoq2cEkpMdrSmYvTHoOKOL
 aywmVgNwQWtyW17nzew/tExufqqCgTk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-564-1bg92L-rODyvHx5Om6Ylsg-1; Wed,
 21 Feb 2024 01:55:04 -0500
X-MC-Unique: 1bg92L-rODyvHx5Om6Ylsg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BD9DB3813F34;
 Wed, 21 Feb 2024 06:55:03 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8D6F0492BE3;
 Wed, 21 Feb 2024 06:55:02 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 388E721E6767; Wed, 21 Feb 2024 07:55:01 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-devel@nongnu.org,  qemu-block@nongnu.org,  eblake@redhat.com,
 hreitz@redhat.com,  kwolf@redhat.com,  vsementsov@yandex-team.ru,
 jsnow@redhat.com,  f.gruenbichler@proxmox.com,  t.lamprecht@proxmox.com,
 mahaocong@didichuxing.com
Subject: Re: [RFC 1/4] drive-mirror: add support for sync=bitmap mode=never
In-Reply-To: <20240216105513.309901-2-f.ebner@proxmox.com> (Fiona Ebner's
 message of "Fri, 16 Feb 2024 11:55:10 +0100")
References: <20240216105513.309901-1-f.ebner@proxmox.com>
 <20240216105513.309901-2-f.ebner@proxmox.com>
Date: Wed, 21 Feb 2024 07:55:01 +0100
Message-ID: <87il2i1f3u.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.05,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

> From: John Snow <jsnow@redhat.com>
>
> This patch adds support for the "BITMAP" sync mode to drive-mirror and
> blockdev-mirror. It adds support only for the BitmapSyncMode "never,"
> because it's the simplest mode.
>
> This mode simply uses a user-provided bitmap as an initial copy
> manifest, and then does not clear any bits in the bitmap at the
> conclusion of the operation.
>
> Any new writes dirtied during the operation are copied out, in contrast
> to backup. Note that whether these writes are reflected in the bitmap
> at the conclusion of the operation depends on whether that bitmap is
> actually recording!
>
> This patch was originally based on one by Ma Haocong, but it has since
> been modified pretty heavily.
>
> Suggested-by: Ma Haocong <mahaocong@didichuxing.com>
> Signed-off-by: Ma Haocong <mahaocong@didichuxing.com>
> Signed-off-by: John Snow <jsnow@redhat.com>
> [FG: switch to bdrv_dirty_bitmap_merge_internal]
> Signed-off-by: Fabian Gr=C3=BCnbichler <f.gruenbichler@proxmox.com>
> Signed-off-by: Thomas Lamprecht <t.lamprecht@proxmox.com>
> [FE: rebase for 9.0
>      update version and formatting in QAPI]
> Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>

[...]

> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index ab5a93a966..ac05483958 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -2181,6 +2181,15 @@
>  #     destination (all the disk, only the sectors allocated in the
>  #     topmost image, or only new I/O).
>  #
> +# @bitmap: The name of a bitmap to use for sync=3Dbitmap mode.  This
> +#     argument must be present for bitmap mode and absent otherwise.
> +#     The bitmap's granularity is used instead of @granularity.
> +#     (Since 9.0).

What happens when the user specifies @granularity anyway?  Error or
silently ignored?

> +#
> +# @bitmap-mode: Specifies the type of data the bitmap should contain
> +#     after the operation concludes.  Must be present if sync is
> +#     "bitmap".  Must NOT be present otherwise.  (Since 9.0)

Members that must be present when and only when some enum member has a
certain value should perhaps be in a union branch.  Perhaps the block
maintainers have an opinion here.

> +#
>  # @granularity: granularity of the dirty bitmap, default is 64K if the
>  #     image format doesn't have clusters, 4K if the clusters are
>  #     smaller than that, else the cluster size.  Must be a power of 2
> @@ -2223,7 +2232,9 @@
>  { 'struct': 'DriveMirror',
>    'data': { '*job-id': 'str', 'device': 'str', 'target': 'str',
>              '*format': 'str', '*node-name': 'str', '*replaces': 'str',
> -            'sync': 'MirrorSyncMode', '*mode': 'NewImageMode',
> +            'sync': 'MirrorSyncMode', '*bitmap': 'str',
> +            '*bitmap-mode': 'BitmapSyncMode',
> +            '*mode': 'NewImageMode',
>              '*speed': 'int', '*granularity': 'uint32',
>              '*buf-size': 'int', '*on-source-error': 'BlockdevOnError',
>              '*on-target-error': 'BlockdevOnError',
> @@ -2507,6 +2518,15 @@
>  #     destination (all the disk, only the sectors allocated in the
>  #     topmost image, or only new I/O).
>  #
> +# @bitmap: The name of a bitmap to use for sync=3Dbitmap mode.  This
> +#     argument must be present for bitmap mode and absent otherwise.
> +#     The bitmap's granularity is used instead of @granularity.
> +#     (Since 9.0).
> +#
> +# @bitmap-mode: Specifies the type of data the bitmap should contain
> +#     after the operation concludes.  Must be present if sync is
> +#     "bitmap".  Must NOT be present otherwise.  (Since 9.0)
> +#
>  # @granularity: granularity of the dirty bitmap, default is 64K if the
>  #     image format doesn't have clusters, 4K if the clusters are
>  #     smaller than that, else the cluster size.  Must be a power of 2
> @@ -2557,7 +2577,8 @@
>  { 'command': 'blockdev-mirror',
>    'data': { '*job-id': 'str', 'device': 'str', 'target': 'str',
>              '*replaces': 'str',
> -            'sync': 'MirrorSyncMode',
> +            'sync': 'MirrorSyncMode', '*bitmap': 'str',
> +            '*bitmap-mode': 'BitmapSyncMode',
>              '*speed': 'int', '*granularity': 'uint32',
>              '*buf-size': 'int', '*on-source-error': 'BlockdevOnError',
>              '*on-target-error': 'BlockdevOnError',

[...]


