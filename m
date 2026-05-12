Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1BA1CD4F3D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 21:41:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMuUZ-0007cf-25; Tue, 12 May 2026 17:18:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuTz-0006Zx-IR; Tue, 12 May 2026 17:17:39 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuTx-0006tP-63; Tue, 12 May 2026 17:17:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1778619307; bh=JIKFRlQIwK1/FxLkJ2ppK44nheMtdlfIIxo/AMV79x0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=GQON7rJPH4EOiVf74zdcz9TYg57weScU7xlBtJKu2sou/H5PIqP+M1cjkhKxqUODK
 ZuMMt4xq53wC6P4XTILn4zjpMrTvWtC4uMZBEmOFpsTxy1fPuW2ah2yDcWeMXljtiK
 2KAtGQRl49c2K9625A8cPLCc2dbe9I6KI/tHrn8a3s2b9MymwNqkTMXTAE7en+f7SU
 zypL/1MCNxWsu3G6psK2Bp5OPIHA3PQ97F6QmvouHGfNu+PTZVepFbItS3DzLN7Ax/
 xzmAELqmQRqOkKsvbU/WYiNih3+an0KpV1D4TTNmIZPZJcZ4+7IGmsKx3mYWnPJDpx
 nDqiaKtCgF5Fg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 8BE091AA3B1;
 Tue, 12 May 2026 23:55:07 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 8D2003ABD20;
 Tue, 12 May 2026 23:55:11 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Katherine Leaver <katherine.j.leaver@gmail.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.2.3 115/117] hw/uefi: add name_size check to
 uefi_vars_mm_lock_variable()
Date: Tue, 12 May 2026 23:54:57 +0300
Message-ID: <20260512205503.361097-115-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.2.3-20260512103849@cover.tls.msk.ru>
References: <qemu-stable-10.2.3-20260512103849@cover.tls.msk.ru>
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

Make sure the total variable_policy_entry size stays below
64k so the (16-bit) size field can not wrap.

Fixes: CVE-2026-41438
Fixes: db1ecfb473ac ("hw/uefi: add var-service-vars.c")
Reported-by: Katherine Leaver <katherine.j.leaver@gmail.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20260422092910.444997-5-kraxel@redhat.com>
(cherry picked from commit c45b460d16f991ff3f753623f3423e1adc4077a2)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/uefi/var-service-vars.c b/hw/uefi/var-service-vars.c
index 922f6dd963..d7187e006d 100644
--- a/hw/uefi/var-service-vars.c
+++ b/hw/uefi/var-service-vars.c
@@ -629,6 +629,9 @@ uefi_vars_mm_lock_variable(uefi_vars_state *uv, mm_header *mhdr,
     if (mhdr->length < length) {
         return uefi_vars_mm_error(mhdr, mvar, EFI_BAD_BUFFER_SIZE);
     }
+    if (sizeof(*pe) + lv->name_size > UINT16_MAX) {
+        return uefi_vars_mm_error(mhdr, mvar, EFI_BAD_BUFFER_SIZE);
+    }
 
     uefi_trace_variable(__func__, lv->guid, name, lv->name_size);
 
-- 
2.47.3


