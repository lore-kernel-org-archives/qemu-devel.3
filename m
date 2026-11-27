Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62126606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 06:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=oErEUfyK
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWp6B-00037S-0t; Fri, 27 Nov 2026 01:06:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWp5D-0007gK-2k; Fri, 27 Nov 2026 01:05:23 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWp5B-0003oz-Bw; Fri, 27 Nov 2026 01:05:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1795759043; bh=8jwUdPnpebUsB6Dcx40jjSC7POrp4KZtevSLBVU9SvA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=oErEUfyKsEtmTeU0S0SjeLTIRFNxnCpR6GmknQ58MthRzpL5aP3v7COnHPscz9Ws+
 JKNqFsxy5m2Pp9D6t4b9o3Tw8Y8Hkeku4trg4Gjzo6Vzqndl9LEEAh4IdmjZiCRgQL
 uiM645vNVaDKntH8n2EQnnvowTJovVDnWjjNsPohhPsT5vpyNa6rjlEZbW+VIshvh3
 4VErYs+bWT3SI+teTLdMr6wu+dIRYhzBAds6UIgM7nquK7AsKmMLiOxmaowuAKdBqT
 3IHz6kJ1pgN2bcvNmI5Uw9rJ8K3GYrbYl4C9WlgbWV6JZixRN3IaxjCjlIDsrzIlS9
 v8CdWLH9ZdONA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id BD94A1EA34B;
 Fri, 27 Nov 2026 08:57:23 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id BB6B0469976;
 Fri, 27 Nov 2026 08:57:23 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id A55DCCF2E4; Fri, 27 Nov 2026 08:57:23 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Klaus Jensen <k.jensen@samsung.com>,
 Jesper Wendel Devantier <foss@defmacro.it>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.4 v2 089/152] hw/nvme: fix fdp reclaim unit accounting
Date: Fri, 27 Nov 2026 08:53:47 +0300
Message-ID: <20261127055709.39630-26-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.4-20261127085309@cover.tls.msk.ru>
References: <qemu-stable-11.1.4-20261127085309@cover.tls.msk.ru>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Klaus Jensen <k.jensen@samsung.com>

nvme_do_write_fdp falls back to placement handle zero for a write that
has no Data Placement directive or where the placement identifier is
invalid. However, it then passes the invalid placement identifier to
nvme_update_ruh which results in no update to RUAMW for placement handle
zero.

Reset the placement identifier along with the handle in the fallback.

Cc: qemu-stable@nongnu.org
Link: https://gitlab.com/qemu-project/qemu/-/work_items/4520
Fixes: 73064edfb864 ("hw/nvme: flexible data placement emulation")
Reviewed-by: Jesper Wendel Devantier <foss@defmacro.it>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
(cherry picked from commit f7d61b4064458372dca0c3b1c2053eac6d311e5c)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 28c41a10779..8629f2f1e9f 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -3733,6 +3733,7 @@ static void nvme_do_write_fdp(NvmeCtrl *n, NvmeRequest *req, uint64_t slba,
         !nvme_parse_pid(ns, pid, &ph, &rg)) {
         ph = 0;
         rg = 0;
+        pid = 0;
     }
 
     ruhid = ns->fdp.phs[ph];
-- 
2.47.3


