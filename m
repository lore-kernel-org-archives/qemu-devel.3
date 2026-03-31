Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC3CC109B461
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 12:51:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7YZ2-0006Vw-SE; Tue, 31 Mar 2026 08:51:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1w7YYv-0006SH-Mm
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 08:51:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1w7YYu-0000GU-0M
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 08:51:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774961475;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZVSbwTjwfruAbnqz7v1ei+v70KSMwZI5i3xXobdMKvw=;
 b=Cxu8fsfBinom7L7hMMpuc2Bl5QR6h4xACdAkQa/BynjbQBMt1yx1wYZgd2s+6+VxfR8rMK
 NjDRsNW9yy/JxGsribKfwg1h/F7XshfXoYYem7dZdtFYpwJwhF6g5PAxT5XOn5uy19d+ls
 k+SYE7plPfBN6StBprCMxzcuxUNNL40=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-33-jvmeYQ_yMq6W6GN_kHrODg-1; Tue,
 31 Mar 2026 08:51:11 -0400
X-MC-Unique: jvmeYQ_yMq6W6GN_kHrODg-1
X-Mimecast-MFC-AGG-ID: jvmeYQ_yMq6W6GN_kHrODg_1774961469
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C92E4195C27B; Tue, 31 Mar 2026 12:51:09 +0000 (UTC)
Received: from redhat.com (unknown [10.44.50.38])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E4BE130001A1; Tue, 31 Mar 2026 12:51:06 +0000 (UTC)
Date: Tue, 31 Mar 2026 14:51:04 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Max Makarov <maxpain177@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Coiby Xu <Coiby.Xu@gmail.com>, Stefano Garzarella <sgarzare@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Max Makarov <maxpain@linux.com>
Subject: Re: [PATCH] vhost-user-blk-server: fix size_max=0 breaking Windows
 guests
Message-ID: <acvDOFITDiEhO1ei@redhat.com>
References: <20260330151313.66318-1-maxpain@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260330151313.66318-1-maxpain@linux.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 27
X-Spam_score: 2.7
X-Spam_bar: ++
X-Spam_report: (2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Am 30.03.2026 um 17:13 hat Max Makarov geschrieben:
> The QSD vhost-user-blk export sets size_max=0 in the virtio config,
> but the vhost-user-blk frontend unconditionally advertises
> VIRTIO_BLK_F_SIZE_MAX. This creates a spec-violating state: the
> feature bit tells the guest that size_max is valid, but the value
> is 0.
> 
> Native virtio-blk-pci does not advertise VIRTIO_BLK_F_SIZE_MAX when
> size_max=0, so guests never see this contradiction there.
> 
> The Windows viostor driver trusts the feature bit and uses size_max=0
> in its MaximumTransferLength calculation, producing malformed
> scatter-gather requests. The disk appears completely empty to Windows
> (no GPT, no partitions in diskpart), causing INACCESSIBLE_BOOT_DEVICE
> BSOD. Linux is unaffected because its virtio_blk driver falls back to
> PAGE_SIZE when size_max=0.

Where is this fallback to PAGE_SIZE?

I can see that in virtblk_read_limits(), not setting the flag would
leave lim->max_segment_size at max_dma_size (capped at U32_MAX, which I
think it will actually be in the normal case), whereas setting it makes
it 0. If it's 0, blk_validate_limits() later updates it to
BLK_MAX_SEGMENT_SIZE, which is 65536.

> Set size_max to 4096 (PAGE_SIZE) to provide a valid segment size limit
> that matches what Linux assumes as a fallback. This fixes Windows
> Server 2025 (and likely all Windows versions) booting from
> vhost-user-blk.

4096 is really small and doesn't feel very optimal.

Why don't we just do what the in-process virtio-blk device does and
clear the VIRTIO_BLK_F_SIZE_MAX flag?

> Buglink: https://github.com/spdk/spdk/issues/3199
> Buglink: https://github.com/virtio-win/kvm-guest-drivers-windows/issues/692
> Signed-off-by: Max Makarov <maxpain@linux.com>

The linked bug reports seems to be about a different bug, which has long
been addressed in both projects. Buglink should be used for bug reports
that are fixed with this patch (see docs/devel/submitting-a-patch.rst).

Kevin


