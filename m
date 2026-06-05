Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88995CD6E7C
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2026 15:34:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVWY4-0000zc-Aj; Fri, 05 Jun 2026 11:33:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wVWY2-0000zH-Fn
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 11:33:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wVWY0-0001qg-Vi
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 11:33:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780673603;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nQUv3+udqgwKP1tZY4Q/t05GsWmNSHl6f3SWLX5jboo=;
 b=G65FEebXG+PY5XcuMReJl2ZwvTQXSb/xWmEws8uSdCv/wfEk4AxanOp5IUwVnsdrbIGeAH
 A2nEPnUOOv/YYwiZ75wfZBzgCp9Jyah8t40btKwFSu48MW/ANG4AK3/pUwBryhklpCsZNm
 9VZmZhY799l6WQjzRHiIX8q1wjVkNcM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-151-5gmSx_BCMZi7-1Y-NjVaPA-1; Fri,
 05 Jun 2026 11:33:19 -0400
X-MC-Unique: 5gmSx_BCMZi7-1Y-NjVaPA-1
X-Mimecast-MFC-AGG-ID: 5gmSx_BCMZi7-1Y-NjVaPA_1780673598
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A1CD1195609E; Fri,  5 Jun 2026 15:33:17 +0000 (UTC)
Received: from redhat.com (unknown [10.44.48.109])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 869E73000210; Fri,  5 Jun 2026 15:33:15 +0000 (UTC)
Date: Fri, 5 Jun 2026 17:33:12 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, hreitz@redhat.com,
 qemu-stable@nongnu.org
Subject: Re: [PATCH 0/3] block/export/fuse: set FUSE_DIRECT_IO_ALLOW_MMAP
 flag to fix regression
Message-ID: <aiLsOMEQDfCG3jht@redhat.com>
References: <20260506145424.10249-1-f.ebner@proxmox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260506145424.10249-1-f.ebner@proxmox.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

Am 06.05.2026 um 16:49 hat Fiona Ebner geschrieben:
> Commit 8599559580 ("fuse: Set direct_io and parallel_direct_writes")
> broke use cases that require mmap() with MAP_SHARED on the export. In
> particular, swtpm_setup using its 'file://' protocol requires this.
> This is mentioned in the kernel documentation [0]:
> 
> > To allow shared mmap, the FUSE_DIRECT_IO_ALLOW_MMAP flag may be
> > enabled in the FUSE_INIT reply.
> 
> [0]: https://www.kernel.org/doc/html/next/filesystems/fuse/fuse-io.html
> 
> Set the FUSE_DIRECT_IO_ALLOW_MMAP flag to restore compatibility with
> users requiring shared mmap.

Thanks, applied to the block branch.

Kevin


