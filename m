Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C2B9D6ED0E
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 11:38:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tE5VJ-0005iE-GK; Thu, 21 Nov 2024 06:37:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <16d4c54023a20d3f30765896402fc23197dcc432@kylie.crudebyte.com>)
 id 1tE5VH-0005hk-G7
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 06:37:43 -0500
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <16d4c54023a20d3f30765896402fc23197dcc432@kylie.crudebyte.com>)
 id 1tE5VG-0000zF-3h
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 06:37:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Message-Id:Cc:To:Subject:Date:From:Content-Type:
 Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Content-ID:
 Content-Description; bh=AWzAHO6gyqFD/yFS6Ch1fb7eIx2m9gItRsv/Z0riUF0=; b=EA/57
 3TM5zyzsXw9V0B/Fx1eK6iY1+gk56otd4z6NKL6EnTvO5EmZxaceAEbtNo6922X5gMcVKPr//sMb4
 w4VnoZz8/oje+kbWvc46ChVWjEQWgQmkjCJSYDUhVeEiYygYp/Oqy65YJaEwwvkIFe0QYz8Tf0xhc
 GHKTIXsas8DYKA1+MDwnsK6wgozIlMP2FR5XpVmcqLzASUzPBb2tc/l1N8yZhibgskk14H5esQfks
 JOr9syEFwjI/zXdGVi9gQeDoetc3mYHhbyT10IgZMvaYUbVpoS1MRtDrvks83rj1u+kyNHBUymzBN
 ltpEVonDUNEfge1u0sTOxL+DNYy8Lh78YFjZ+i0fKwnnwEFlHd/u9igTZtqjQnAkkuF3lerWLhLs6
 6ppmhCa50lKHfYE1iJnXJnP7Pfsv6vYfu3/p4YlC1k1i6CipcnIiwTjUaXhd2DtYCyP9rBInINGxN
 lha50wX2DE/KQ6BkRfsWyHL/USGrdNQ08K4ONmcOK9cPaaU8w6WQdUR1FWwGMXGrlJhimB6m7HVft
 eJQZUK2DDE45VkNcwHQQyuiGaR0xU6kKyH/j2jYVq9RhCbOesiaIKA0HgEwU6BspsGxL06GLTUhEX
 YMCVIylHs6iSn890BZVBdN1p9sSaPYtlCtzcXuYZtXQCgS7SWbY5uG7DCIVsd0=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Thu, 21 Nov 2024 11:52:48 +0100
Subject: [PATCH] 9pfs: cleanup V9fsFidState
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>,
    Linus Heckemann <git@sphalerite.org>
Message-Id: <E1tE4v2-0051EH-Ni@kylie.crudebyte.com>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=16d4c54023a20d3f30765896402fc23197dcc432@kylie.crudebyte.com;
 helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Drop V9fsFidState's 'next' member, which is no longer used since:

  f5265c8f917e ('9pfs: use GHashTable for fid table')

Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 hw/9pfs/9p.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/9pfs/9p.h b/hw/9pfs/9p.h
index a6f59abccb..5e041e1f60 100644
--- a/hw/9pfs/9p.h
+++ b/hw/9pfs/9p.h
@@ -280,7 +280,6 @@ struct V9fsFidState {
     uid_t uid;
     int ref;
     bool clunked;
-    QSIMPLEQ_ENTRY(V9fsFidState) next;
     QSLIST_ENTRY(V9fsFidState) reclaim_next;
 };
 
-- 
2.39.5


