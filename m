Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92BF5E92733
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 16:18:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaFwP-000246-9S; Mon, 29 Dec 2025 11:17:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1vaFwL-0001wl-02; Mon, 29 Dec 2025 11:17:49 -0500
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1vaFwI-0005OL-Gq; Mon, 29 Dec 2025 11:17:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=virtuozzo.com; s=relay; h=MIME-Version:Message-ID:Date:Subject:From:
 Content-Type; bh=KWu6dgQsyiprW8vGaRrrJa32iLgci/iXzBGySqZ9RAY=; b=hOW+8s6nvSx0
 Vv/IJUFKxR5sCN7ZTb2QcygAwFNw783sN9OcaB9u1jTRE8aG2N0+GcxJ8BQWnruBbc432BjcXwtkQ
 4juizmwwPQ5x0vZSvTP2Dfj7bQYUDe15tlzUbCZXI3tj6q5zV0w+3thvLq951bfO5HfJDnFEWkePO
 T9+MmijvG9s5dmQSRQCatJPBJ8V3WOSVhTI8R0sXqBShEjzR9vs/V4skwakrsNT684cbBeMGw8vFm
 GCiujCiN7ETd651vI0U3W1ijPFUh6RQXWBq95hFdQ6fd4HmOEQKOUaDG6lylciSkh6QSQ6bbK/gew
 N5xwGb+gAebvPKvGTsSQdA==;
Received: from [10.193.1.107] (helo=dev007.aci.vzint.dev)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <den@openvz.org>) id 1vaFvu-00Apz0-2A;
 Mon, 29 Dec 2025 17:17:32 +0100
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org,
	qemu-stable@nongnu.org
Cc: den@openvz.org, Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: [PATCH 0/3] fix potential data loss in QEMU (missed flush)
Date: Mon, 29 Dec 2025 19:07:42 +0300
Message-ID: <20251229161740.758800-1-den@openvz.org>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: softfail client-ip=130.117.225.111; envelope-from=den@openvz.org;
 helo=relay.virtuozzo.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_SOFTFAIL=0.665 autolearn=ham autolearn_force=no
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
Reply-to:  "Denis V. Lunev" <den@openvz.org>
From:  "Denis V. Lunev" via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This series is a followup to my previous patch sent under
"qcow2: add very final sync on QCOW2 image closing". Could be considered
as v2.

This series addresses two problems:
1. bdrv_co_flush() at the end of bdrv_driver_pwritev() and
   bdrv_co_do_pwrite_zeroes() could be effectively no op. The problem is
   that bdrv_co_flush() is optimized internally this way to track real
   requests which were making changes in the image and without such
   requests from previous flush() do nothing. Requests are tracked using
   write_gen on BDS. This field should be incremented after write is
   completed but before flush is called.

   This could be considered as potential data loss if caller relies on
   BDRV_REQ_FUA flag which means that such requests are really lands on
   the underlying device, which could not due to missed flush().

2. qcow2_update_header() must actually write header with BDRV_REQ_FUA
   flag as image processing on open relies on the fact that header is
   actual and it is not possible to reorder header modifications and
   image content modifications.

Changes:
    * added patches 1 & 2

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
CC: Kevin Wolf <kwolf@redhat.com>
CC: Hanna Reitz <hreitz@redhat.com>


