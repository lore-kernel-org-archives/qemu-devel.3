Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31DABCAC5AC
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 18:04:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v17Me-0000Vf-HH; Tue, 23 Sep 2025 14:03:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1v17Mc-0000Uz-52
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 14:03:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1v17Ma-0004R5-Am
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 14:03:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758650617;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TSTyU/dc96wgvzHEhWCnffelvYTkPsoP+0tpVcdadeg=;
 b=KUZL6qm0XHe3m+ueS7asE8k9x/6X1tYb+wzN/7mby2ILayZoVfOv1oXFgg7IJTq1GfeGXY
 vOixboHTQpn64Mb0RY2yxvFbbQ8gng6sNrhDMTm+pv3NsNV4xlNVS8gsQmnpbPt0dm/+s7
 bYZ/Ud0toxDHqdr8LLWmJg8B75NK6yA=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-101-cz5XHWyHNH-JlHaIUVvfSQ-1; Tue,
 23 Sep 2025 14:03:35 -0400
X-MC-Unique: cz5XHWyHNH-JlHaIUVvfSQ-1
X-Mimecast-MFC-AGG-ID: cz5XHWyHNH-JlHaIUVvfSQ_1758650614
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9796B195606C; Tue, 23 Sep 2025 18:03:34 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.89])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C47281800451; Tue, 23 Sep 2025 18:03:32 +0000 (UTC)
Date: Tue, 23 Sep 2025 13:03:30 -0500
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, hreitz@redhat.com, qemu-devel@nongnu.org
Subject: Re: [PATCH 1/2] block: Expose block limits for images in QMP
Message-ID: <jpdlse4d46upjbeapa45ic7kpfuqv7vuyxo4ka4ansnqvrd32b@yqmxu256sujs>
References: <20250923163735.378254-1-kwolf@redhat.com>
 <20250923163735.378254-2-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250923163735.378254-2-kwolf@redhat.com>
User-Agent: NeoMutt/20250510
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Sep 23, 2025 at 06:37:34PM +0200, Kevin Wolf wrote:
> This information can be useful both for debugging and for management
> tools trying to configure guest devices with the optimal limits
> (possibly across multiple hosts). There is no reason not to make it
> available, so just add it to BlockNodeInfo.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  qapi/block-core.json             | 59 ++++++++++++++++++++++++++++++++
>  block/qapi.c                     | 34 ++++++++++++++++--
>  tests/qemu-iotests/184           |  3 +-
>  tests/qemu-iotests/184.out       |  8 -----
>  tests/qemu-iotests/common.filter |  3 +-
>  5 files changed, 94 insertions(+), 13 deletions(-)
> 
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index dc6eb4ae23..eda041ac1c 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -275,6 +275,62 @@
>        'file': 'ImageInfoSpecificFileWrapper'
>    } }
>  
> +##
> +# @BlockLimitsInfo:

Quite a few additions to the QMP, but this is really just exposing
what we already have.  I don't think the larger output is going to
make QMP any noticeably slower, and it's not recursive, so I have no
objection to your decision of just always exposing it.

> +++ b/tests/qemu-iotests/184
> @@ -46,7 +46,8 @@ do_run_qemu()
>  run_qemu()
>  {
>      do_run_qemu "$@" 2>&1 | _filter_testdir | _filter_qemu | _filter_qmp\
> -                          | _filter_qemu_io | _filter_generated_node_ids
> +                          | _filter_qemu_io | _filter_generated_node_ids \
> +                          | _filter_img_info

Inconsistent on absence or use of space before backslash-newline.
Cosmetic only.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


