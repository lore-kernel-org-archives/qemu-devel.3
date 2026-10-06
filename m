Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08B16CA5FF1
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:24:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEMwC-0004FZ-29; Wed, 07 Oct 2026 04:23:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xEHdg-0005Z5-W9
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 22:44:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xEHdV-0003Bi-7x
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 22:44:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791340980;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Q48BE2IEcNUWcqGIBr43OQS1am5d1J5E99crXuHfnlE=;
 b=RmkDvaCSPD8k9Tpq1UiuG6pCtpOBOoqYCaUAyOIstZeiynGngXjDRqTzgyyX2CXlcx5Wjo
 2lztREH3fRsoYpKMngHsOSZDvoIdxjjGD6xhI26QO3iNmRHzLW+neI8UTox2eOANdpWRnp
 RCt8pHAeOL1VzKAmxlPGuMO+vgEtkew=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-26-hsU4yqFyPSO-9TBIeDoGyA-1; Tue,
 06 Oct 2026 06:02:19 -0400
X-MC-Unique: hsU4yqFyPSO-9TBIeDoGyA-1
X-Mimecast-MFC-AGG-ID: hsU4yqFyPSO-9TBIeDoGyA_1791280937
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6B42A19235DB; Tue,  6 Oct 2026 10:02:16 +0000 (UTC)
Received: from redhat.com (unknown [10.44.48.53])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 47C9F3001D2A; Tue,  6 Oct 2026 10:02:14 +0000 (UTC)
Date: Tue, 6 Oct 2026 12:02:11 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: "Denis V. Lunev" <den@openvz.org>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>,
 Hanna Reitz <hreitz@redhat.com>, qemu-stable@nongnu.org
Subject: Re: [PATCH v4 2/5] block: reject a reopen of an unusable node
 instead of crashing
Message-ID: <asTHI1FWnb4sWMVK@redhat.com>
References: <20260824133729.1141990-1-den@openvz.org>
 <20260824133729.1141990-3-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260824133729.1141990-3-den@openvz.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Am 24.08.2026 um 15:37 hat Denis V. Lunev geschrieben:
> From: Denis V. Lunev <den@openvz.org>
> 
> qcow2_signal_corruption() drops bs->drv, so a node can lose its driver
> at any time and a reopen has to expect that. Both ends of the path
> assume otherwise:
> 
>   $ qemu-io -c "read 0 64k" -c "reopen -r" corrupt.qcow2
>   qcow2: Marking image as corrupt: Cluster allocation offset 0x1200
>   unaligned (L2 offset: 0x40000, L2 index: 0); ...
>   Segmentation fault
> 
> bdrv_reopen_queue_child() dereferences bs->drv while descending into
> the children the node opened itself, and bdrv_reopen_prepare() asserts
> on it. commit_clean() reopens the base of a commit job back to
> read-only, so a base which goes corrupt under the job arrives here too.
> 
> There is nothing to reopen for such a node, so stop descending into its
> children and let bdrv_reopen_prepare() report what every caller of
> bdrv_reopen() already handles. bdrv_reopen_commit() and
> bdrv_reopen_abort() keep their assertion, only a prepared entry reaches
> them.
> 
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> Reviewed-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> CC: Kevin Wolf <kwolf@redhat.com>
> CC: Hanna Reitz <hreitz@redhat.com>
> CC: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> Cc: qemu-stable@nongnu.org

Reviewed-by: Kevin Wolf <kwolf@redhat.com>


