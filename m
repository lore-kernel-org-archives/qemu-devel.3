Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5044C36008
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Mar 2025 05:39:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txJTY-0003NF-Gv; Wed, 26 Mar 2025 01:38:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1txJTS-0003Mq-SW
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 01:38:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1txJTQ-0005hQ-7l
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 01:38:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742967522;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=q+dcLXC/15M/sFI5qSwuwlJhmvzVGh2puUHpfwp7v2I=;
 b=ZOWXCfKicmkR7sEt4ffDiTk3Z2EKaixNFuiypwJzc7hT1CUP2qV+VjXIGpimuPJp1XfD2r
 BIQq8ICrhX1eJNirmVDMyyIlBdfczHI23vB3aoDCdLVJnYWAf7tvY8Ysaq9qel2kclNA9y
 gLHvZXN3esynN2C4g2V5rFD54ZMcz7s=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-345-bXzdUSDJN_ag074U4LH9uQ-1; Wed,
 26 Mar 2025 01:38:38 -0400
X-MC-Unique: bXzdUSDJN_ag074U4LH9uQ-1
X-Mimecast-MFC-AGG-ID: bXzdUSDJN_ag074U4LH9uQ_1742967517
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 692A7196D2CC; Wed, 26 Mar 2025 05:38:36 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.22.74.4])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 33919180B492; Wed, 26 Mar 2025 05:38:35 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4E74421E66C7; Wed, 26 Mar 2025 06:38:32 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-block@nongnu.org,  qemu-devel@nongnu.org,  Kevin Wolf
 <kwolf@redhat.com>
Subject: Re: [PATCH 14/15] fuse: Implement multi-threading
In-Reply-To: <20250325160655.119407-13-hreitz@redhat.com> (Hanna Czenczek's
 message of "Tue, 25 Mar 2025 17:06:54 +0100")
References: <20250325160529.117543-1-hreitz@redhat.com>
 <20250325160655.119407-13-hreitz@redhat.com>
Date: Wed, 26 Mar 2025 06:38:32 +0100
Message-ID: <87sen0fj1j.fsf@pond.sub.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Hanna Czenczek <hreitz@redhat.com> writes:

> FUSE allows creating multiple request queues by "cloning" /dev/fuse FDs
> (via open("/dev/fuse") + ioctl(FUSE_DEV_IOC_CLONE)).
>
> We can use this to implement multi-threading.
>
> Note that the interface presented here differs from the multi-queue
> interface of virtio-blk: The latter maps virtqueues to iothreads, which
> allows processing multiple virtqueues in a single iothread.  The
> equivalent (processing multiple FDs in a single iothread) would not make
> sense for FUSE because those FDs are used in a round-robin fashion by
> the FUSE kernel driver.  Putting two of them into a single iothread will
> just create a bottleneck.
>
> Therefore, all we need is an array of iothreads, and we will create one
> "queue" (FD) per thread.

[...]

> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
> ---
>  qapi/block-export.json |   8 +-
>  block/export/fuse.c    | 214 +++++++++++++++++++++++++++++++++--------
>  2 files changed, 179 insertions(+), 43 deletions(-)
>
> diff --git a/qapi/block-export.json b/qapi/block-export.json
> index c783e01a53..0bdd5992eb 100644
> --- a/qapi/block-export.json
> +++ b/qapi/block-export.json
> @@ -179,12 +179,18 @@
>  #     mount the export with allow_other, and if that fails, try again
>  #     without.  (since 6.1; default: auto)
>  #
> +# @iothreads: Enables multi-threading: Handle requests in each of the
> +#     given iothreads (instead of the block device's iothread, or the
> +#     export's "main" iothread).

When does "the block device's iothread" apply, and when "the export's
main iothread"?  Is this something the QMP user needs to know?


> +#                                 For this, the FUSE FD is duplicated so
> +#     there is one FD per iothread.  (since 10.1)

Is the file descriptor duplication something the QMP user needs to know?

> +#
>  # Since: 6.0
>  ##
>  { 'struct': 'BlockExportOptionsFuse',
>    'data': { 'mountpoint': 'str',
>              '*growable': 'bool',
> -            '*allow-other': 'FuseExportAllowOther' },
> +            '*allow-other': 'FuseExportAllowOther',
> +            '*iothreads': ['str'] },
>    'if': 'CONFIG_FUSE' }
>  
>  ##

[...]


