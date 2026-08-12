Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EFF9C5CFCF
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 14:51:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuAIX-0004U4-Ji; Wed, 12 Aug 2026 10:51:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wuAIB-0004JQ-0i; Wed, 12 Aug 2026 10:50:56 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wuAI0-0006dc-CK; Wed, 12 Aug 2026 10:50:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786546230; bh=aWLR8fPOlFmW08HKpmF6uy4rFj273SSImMAspSXxzHM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=pt15HLiPMT3ieuRS820u89vM8QGpSC+EAx+zXurAsgKTAMK4g5Eml4JYYo4vqxPLB
 ke7fSv7N5CMryqXHYE7ZGO/RsKdHCsERObpRrGb8aKBuMB3SSRil4EDhPr+pw5i3Mq
 fs1uCvpIQHOlbwV0P2hp1ExJXKROsvKWUt3bgVPB0thL5AksbMgsFQIC6RZldUF4lm
 mHA4cAO3+Uad8Vrr3doQVv56oh1lcenniGu6BVbqKXyo8sB5HzIcQNtkOShoSRTi/+
 PYkysNzdWS6BuSuasGrM/UB1ji5X+c2UCE4KtEVYs8qaoCjlx7zLtjO2M3QFgbvrsp
 6/kyGHhmr8wEA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id AAB761CA605;
 Wed, 12 Aug 2026 17:50:30 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 11627409D3E;
 Wed, 12 Aug 2026 17:50:42 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 6DE832F965; Wed, 12 Aug 2026 17:50:17 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Luigi Leonardi <leonardi@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.4 001/120] hw/uefi: add sanity check
Date: Wed, 12 Aug 2026 17:47:44 +0300
Message-ID: <20260812144955.649205-1-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.4-20260812160441@cover.tls.msk.ru>
References: <qemu-stable-11.0.4-20260812160441@cover.tls.msk.ru>
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Gerd Hoffmann <kraxel@redhat.com>

Verify the passed buffer has the minimal required length before
reading the size field + verifying the total length.

Fixes: CVE-2026-58581
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3614
Acked-by: Luigi Leonardi <leonardi@redhat.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20260720143244.821889-2-kraxel@redhat.com>
(cherry picked from commit 702216619e2a1afd5039520114f4d245d7011f09)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/uefi/var-service-policy.c b/hw/uefi/var-service-policy.c
index 58da4adbeba..989bf87ddb8 100644
--- a/hw/uefi/var-service-policy.c
+++ b/hw/uefi/var-service-policy.c
@@ -276,6 +276,9 @@ static uint32_t uefi_vars_mm_check_policy_register(uefi_vars_state *uv,
     uefi_var_policy *pol;
     uint64_t length;
 
+    if (mhdr->length < sizeof(*mchk) + sizeof(*pe)) {
+        return uefi_vars_mm_policy_error(mhdr, mchk, EFI_BAD_BUFFER_SIZE);
+    }
     if (uadd64_overflow(sizeof(*mchk), pe->size, &length)) {
         return uefi_vars_mm_policy_error(mhdr, mchk, EFI_BAD_BUFFER_SIZE);
     }
-- 
2.47.3


