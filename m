Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87091606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 06:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=k+RFke33
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWp3E-0004me-SX; Fri, 27 Nov 2026 01:03:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWp1p-0003gT-Jx; Fri, 27 Nov 2026 01:01:50 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWp1m-0008LF-Ni; Fri, 27 Nov 2026 01:01:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1795758881; bh=4ypmJZW8TwhV5K5tOsXbz43wNFhm9PbeHSRKeE10EKw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=k+RFke3342xQjRXEdVWgPCXhsP7OUPtVBPswwjpVEh77QuAV7QBcA2Ms+4QK6CLta
 2l2aHO4rnwgef/29SPhmt1Hhj9N7sG8CGiYvh3b73106rdzdC8DeIOcsEtxAS3ChbG
 wmJ2Cbi4aCseW1oEs02kbxpYNCaf2ddl4JQe6NJ0Bp3gF1BOO4ULAogV8AkVfxFBIW
 VNssbbwbiWS3tf4Raet+zG56dN5j7bBm3VNTUw9VIDGjSwhCxrY47ovXcNuFwJDWIT
 RNWwTIejuo/LuW3s60y5BWO97XyKQl1ubG1FPL2Bpctxu/M2hNg2oIyi4+Db84ndzi
 BddF/TitEyg4w==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id DDA201EA313;
 Fri, 27 Nov 2026 08:54:41 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id DB91E469953;
 Fri, 27 Nov 2026 08:54:41 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id AF140CF2A6; Fri, 27 Nov 2026 08:54:41 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Wang Jianqiang <wjq.sec@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.16 v2 136/140] hw/block/pflash_cfi01: Register VM change
 handler once
Date: Fri, 27 Nov 2026 08:54:02 +0300
Message-ID: <20261127055421.39015-77-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.16-20261127085304@cover.tls.msk.ru>
References: <qemu-stable-10.0.16-20261127085304@cover.tls.msk.ru>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

Each pflash_post_load() added a VM change-state handler and
overwrote pfl->vmstate. Loading twice before the VM resumes
left the first entry on the list, and resuming then ran a
freed entry. Register the handler only when none is held.

Cc: qemu-stable@nongnu.org
Fixes: 90c647db8d59 ("Fix pflash migration")
Reported-by: Wang Jianqiang <wjq.sec@gmail.com>
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/2635
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20261124185556.81132-2-philmd@oss.qualcomm.com>
(cherry picked from commit 0522a9457b071fcdb3470278e3df78c1e773d432)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
index 72b29708fff..31d0f226510 100644
--- a/hw/block/pflash_cfi01.c
+++ b/hw/block/pflash_cfi01.c
@@ -1048,7 +1048,8 @@ static int pflash_post_load(void *opaque, int version_id)
         memory_region_rom_device_set_romd(&pfl->mem, false);
     }
 
-    if (!pfl->ro) {
+    /* A second load before the VM resumes must not add a duplicate entry */
+    if (!pfl->ro && !pfl->vmstate) {
         pfl->vmstate = qemu_add_vm_change_state_handler(postload_update_cb,
                                                         pfl);
     }
-- 
2.47.3


