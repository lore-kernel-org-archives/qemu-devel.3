Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8FE1606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 06:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=bBVdMFI3
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWp67-0002nW-Hh; Fri, 27 Nov 2026 01:06:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWp4h-0007GI-Of; Fri, 27 Nov 2026 01:04:49 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWp4f-0003hK-Mr; Fri, 27 Nov 2026 01:04:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1795759043; bh=RwnwsWt8l9aZXt9odO0pfH8jp3ZGcLrOKHR42AFEvyo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=bBVdMFI3CQrfCdrOUa39ff2/dvejvyYy4JUJ8MVzBLCi324l2yAaY9e3OL4QNLzCY
 fc96q93ybpgLShp24WnsqDnVrh4FzqlpgyP/Gu8EKnuaHVtfDWEtm7oXCmzdGVuNms
 0sm6p/AT9YkGbfsg9uQIl9eFcfoZCtRVXPorbtzgG5MbIbeGGVP/EaMzEudoXWfiBn
 WVYvlzJT4d3BF26DiTiJsk8UIbKlDu6css45yTFzzZgFCFU4hkya28fn8LSgNXZB0a
 sLG5EJ+QAoQpeSSChgKqI+oGPbd0uDmxDF1kcgKv2lFRn3UPB6QC/cRj8+VPu2Raih
 at+tVJ2kCnT+g==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id B4E581EA349;
 Fri, 27 Nov 2026 08:57:23 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id B2C26469974;
 Fri, 27 Nov 2026 08:57:23 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 9FC47CF2E0; Fri, 27 Nov 2026 08:57:23 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Klaus Jensen <k.jensen@samsung.com>,
 Jesper Wendel Devantier <foss@defmacro.it>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.4 v2 087/152] hw/nvme: verify source and destination lba
 size for copy
Date: Fri, 27 Nov 2026 08:53:45 +0300
Message-ID: <20261127055709.39630-24-mjt@tls.msk.ru>
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

Cross-namespace copy requires the source and destination namespace to
have the same logical block size. This is not verified, causing a heap
out-of-bounds write.

Fix by correctly identifying the invalid operation.

Cc: qemu-stable@nongnu.org
Reported-by: Feng Xue and XGPT of ThreatBook
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4173
Fixes: d522aef88d42 ("hw/nvme: add cross namespace copy support")
Reviewed-by: Jesper Wendel Devantier <foss@defmacro.it>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
(cherry picked from commit 0b9935a847175c29ea794bbf42a79230fbf4031b)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 45aacf81467..28c41a10779 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -3257,6 +3257,11 @@ static void nvme_do_copy(NvmeCopyAIOCB *iocb)
         status = NVME_INVALID_FIELD | NVME_DNR;
         goto invalid;
     } else if (snsid != dnsid) {
+        if (sns->lbaf.ds != dns->lbaf.ds) {
+            status = NVME_CMD_INCOMP_NS_OR_FMT | NVME_DNR;
+            goto invalid;
+        }
+
         if (!NVME_ID_NS_DPS_TYPE(sns->id_ns.dps) &&
             !NVME_ID_NS_DPS_TYPE(dns->id_ns.dps)) {
             if (!nvme_copy_matching_ns_format(sns, dns, false)) {
-- 
2.47.3


