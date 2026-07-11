Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E2FFC44506
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2026 22:06:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wifoa-0003aq-EM; Sat, 11 Jul 2026 18:04:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wifoX-0003XS-KA; Sat, 11 Jul 2026 18:04:49 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wifoW-0000Ny-4N; Sat, 11 Jul 2026 18:04:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1783807181; bh=iHYQpyNPdzXsG1Hyh5gnLv5dtisLNiUhnurAc4Ozgf4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=BoCDjQhe8Gab3YpeDs7i0Pk/wxSBGKfv3g55VyZ2GnQkIyi3CjGvdlXt7IkC6Cdef
 LIVOUnCCBibC9Mjg8Iw7ZwYhZoFcuTAVYS1pAZlNZaGC/FiP+PlKRSx9Xv3X6gQ+r2
 MD2HSkjZma9/V2u0QwRZ4vzEpt0KAEaKOKcahmZLTYg5tONPfGFAvueZCTSMVQTEFu
 4YF0xvk0FMtFVf7Mf1HU+wccsbEJghcyko74MjyXbhvpHTx3jSiDZGLI7Krpznur23
 Ay9UJS2ppP+BPAcojS1MgL7Bl2bGvgQh8vfWfzTH1aQYr5dc5hr4Poaa4ShMRT2vpR
 rP6J4e/xPn9hA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 5E8781C0AC2;
 Sun, 12 Jul 2026 00:59:41 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 15A103EAF4D;
 Sun, 12 Jul 2026 00:59:51 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id BBECA13351; Sun, 12 Jul 2026 00:59:50 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Nathan Chen <nathanc@nvidia.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>,
 Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.3 55/81] hw/arm/smmuv3: Update ATC invalidation check
Date: Sun, 12 Jul 2026 00:58:33 +0300
Message-ID: <20260711215904.3757-55-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.3-20260712005649@cover.tls.msk.ru>
References: <qemu-stable-11.0.3-20260712005649@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_MSPIKE_H2=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Nathan Chen <nathanc@nvidia.com>

Use smmuv3_ats_enabled() to determine whether ATS is enabled for the
guest when handling an ATC invalidation command, as setting the ATS
property value to 'auto' will resolve to ATS being detected as
enabled in the ATC invalidation check otherwise.

Fixes: f7f5013a55a3 ("hw/arm/smmuv3-accel: Add support for ATS")
Reported-by: Shameer Kolothum <skolothumtho@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Shameer Kolothum <skolothumtho@nvidia.com>
Signed-off-by: Nathan Chen <nathanc@nvidia.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Message-id: 20260608174900.2227340-2-nathanc@nvidia.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit 8addbdb793b783228ab22867ac5e2d59ea6662a7)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 7fead1c3cff..4e4b79c0f1c 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1528,7 +1528,7 @@ static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp)
         {
             SMMUDevice *sdev = smmu_find_sdev(bs, CMD_SID(&cmd));
 
-            if (!sdev || !s->ats) {
+            if (!sdev || !smmuv3_ats_enabled(s)) {
                 trace_smmuv3_unhandled_cmd(type);
                 break;
             }
-- 
2.47.3


