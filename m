Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BCDBC282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 19:01:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tucAu-0007n9-US; Tue, 18 Mar 2025 15:00:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1tucAt-0007mq-1f; Tue, 18 Mar 2025 15:00:27 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1tucAr-0005pF-80; Tue, 18 Mar 2025 15:00:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=AFCTUPxHr5ekfLC1lqSeIisf1S8qe0lfnZG/Q9RvmPc=; b=H0bMauGsMkvRcCmjqBaMVht/ge
 BzFXZGa2KszqMoVG0hBplEuNGSZSL2entwgLY8cfNgiio75HEA15B/xI8ZLt3H5IW53U1iUyOxMWt
 AgEe47GXHgN3CmLK7AnXd3rh3vlk2CMTawTalf1ZBX0lqHJC47GdO5fjTh0+iODwyxHW45je+rO22
 i2W6PxXVqCdS5juimk+TzyVQTV1gl83yhB/Xf65Huwq0MHaeoxgVopIbwT5BW+vvB2EdN32l+q0ak
 uCf838udKLNAaxMAzH7oi5rfwDKjevkuECrWYNJAvheNJSZigdlKbDsE8ktReQS/ry7RQKwkciE3L
 GSOKH89pFp5HI0e1qabhz+kO8cZ0rxBGezMcrGHe0MFIfkwSMEgVtF8hkGuBr6fQ5/rbAwrYihEHK
 BL7bhTxs1wclR2yjMw06ZKK51w3Qyb/u8FPGFaI4dUOGsLwxufuO/blnpj/Kf5gmwN1tWlvJrxUkh
 +E+AtCrfaQM27QbMHo2afy7wpsLNAbZiS7v97N5lWg+HCL+U5iGFNpIoVUJRRDwWTRyS01eRv68NI
 +5aHrdKQE/82Us9gPeRIjpaq2667OR+3h9++Orfn0znHHBCf16zZTsnPZ9MYnZhy5Q6HUXpHdhZyT
 GkHxWI6UIQu88l6VFmzVBOs6nXs9iMDX3zPEvS6bM=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>, qemu-stable@nongnu.org,
 Christian Schoenebeck <qemu_oss@crudebyte.com>
Subject: Re: [PATCH v2 0/2] 9pfs: v9fs_reclaim_fd() fixes
Date: Tue, 18 Mar 2025 20:00:19 +0100
Message-ID: <2853065.71BMcKx459@silver>
In-Reply-To: <cover.1741339452.git.qemu_oss@crudebyte.com>
References: <cover.1741339452.git.qemu_oss@crudebyte.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=qemu_oss@crudebyte.com; helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Friday, March 7, 2025 10:24:12 AM CET Christian Schoenebeck wrote:
> Three fixes for 9p server's v9fs_reclaim_fd() function:
> 
> * Patch 1 fixes a concurrency issue.
> 
> * Patch 2 fixes a file descriptor leak and optimizes overall latency. On a test
>   machine with ~800,000 FIDs, this reduced execution duration of
>   v9fs_reclaim_fd() from 30ms to 1ms.
> 
> V2:
>   - Patch 2: Decrement global variable total_open_fd on main thread, not
>     on fs driver background thread.
>   - Patch 2: Update commit log about file descriptor leak being fixed.
> 
> Christian Schoenebeck (2):
>   9pfs: fix concurrent v9fs_reclaim_fd() calls
>   9pfs: fix FD leak and reduce latency of v9fs_reclaim_fd()
> 
>  hw/9pfs/9p.c | 39 ++++++++++++++++++++++++++++++---------
>  hw/9pfs/9p.h |  1 +
>  2 files changed, 31 insertions(+), 9 deletions(-)
> 
> 

Queued on 9p.next:
https://github.com/cschoenebeck/qemu/commits/9p.next

Thanks!

/Christian



