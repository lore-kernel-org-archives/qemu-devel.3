Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9DD7C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 11:20:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjbBJ-0006he-HN; Tue, 14 Jul 2026 07:20:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wjbBH-0006gw-LK
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 07:20:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wjbBE-0000pm-VY
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 07:20:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784028004;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=esj4GrV6iqHlEg8jGCqFPbwbrCli41gKQ/CZ1jVSYLg=;
 b=YYj/3C41JbHHzqLPh3EZ+sVhNIbCoJKqnXEBLcATWUuOHQSIhm4xwVA6yNa1ziNV1lXMFc
 zkhaywDl/1tin13n5UhpCbwNnHgxlUjGeTno6kZRqMg8oHt9K8xxuoHziMM5f7iMH5cVm6
 inDzZcuIU4O+QIIh3/HJagvt0kTugVs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-630-QY1YO9TjO0C5k7gU_Wy_pQ-1; Tue,
 14 Jul 2026 07:20:00 -0400
X-MC-Unique: QY1YO9TjO0C5k7gU_Wy_pQ-1
X-Mimecast-MFC-AGG-ID: QY1YO9TjO0C5k7gU_Wy_pQ_1784027999
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B48ED1956060; Tue, 14 Jul 2026 11:19:58 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.162])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1C5801956087; Tue, 14 Jul 2026 11:19:56 +0000 (UTC)
Date: Tue, 14 Jul 2026 13:19:54 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: "Denis V. Lunev" <den@openvz.org>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH 2/3] iotests: skip FUSE tests when FUSE is not usable
Message-ID: <alYbWsd6_58SXYTq@redhat.com>
References: <20260710161309.1104712-1-den@openvz.org>
 <20260710161309.1104712-3-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710161309.1104712-3-den@openvz.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: permerror client-ip=170.10.133.124;
 envelope-from=kwolf@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
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

Am 10.07.2026 um 18:13 hat Denis V. Lunev geschrieben:
> file-io-error, fuse-allow-other and fuse-mmap-shared skip only when
> FUSE is not compiled in. When FUSE is built in but unusable at run
> time (no /dev/fuse access, fusermount lacking permissions), the
> export fails to mount with "Failed to mount FUSE session to export"
> and the tests report a spurious failure instead of skipping, like
> NBD tests already do for missing NBD support.
> 
> Add _notrun_on_no_fuse() to common.rc and use it in the shell tests.
> fuse-mmap-shared is Python, so it gets an equivalent inline check.
> 
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Kevin Wolf <kwolf@redhat.com>
> CC: Hanna Reitz <hreitz@redhat.com>
> ---
>  tests/qemu-iotests/common.rc              | 14 ++++++++++++++
>  tests/qemu-iotests/tests/file-io-error    |  4 +---
>  tests/qemu-iotests/tests/fuse-allow-other |  2 ++
>  tests/qemu-iotests/tests/fuse-mmap-shared |  9 ++++++---
>  4 files changed, 23 insertions(+), 6 deletions(-)
> 
> diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.rc
> index 298bc483e0..62a2bc146b 100644
> --- a/tests/qemu-iotests/common.rc
> +++ b/tests/qemu-iotests/common.rc
> @@ -981,6 +981,20 @@ _require_drivers()
>      done
>  }
>  
> +# Skip if FUSE is unusable: not compiled in, or the export failed to
> +# mount. $1 is the failing 'block-export-add' reply.
> +_notrun_on_no_fuse()

I'm not completely happy with the name, though this is not a blocker.

My first thought was to keep the name consistent with the other
functions in common.rc and have something like _require_fuse. On second
thoughts, this is probably confusing because it's different from the
existing _require_* functions in that it takes an error message from the
test case instead of doing its own probing.

So maybe at least remove the double negative? _notrun_on_fuse_error
sounds slightly better to me.

> +{
> +    case "$1" in
> +        *"Parameter 'type' does not accept value 'fuse'"*)
> +            _notrun "No FUSE support"
> +            ;;
> +        *"Failed to mount FUSE session"*)
> +            _notrun "FUSE not usable in this environment"
> +            ;;
> +    esac
> +}
> +

Adding these checks is a good idea, of course.

Kevin


