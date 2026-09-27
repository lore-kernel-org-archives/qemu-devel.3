Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4274C9833F
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 09:09:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAkrc-0002WJ-JO; Sun, 27 Sep 2026 05:08:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xAkpd-0008Vv-5Q; Sun, 27 Sep 2026 05:06:02 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xAkpb-00086B-FD; Sun, 27 Sep 2026 05:06:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1790499956; bh=Jp5FRdAGQPo0Xl3DRBq+xWupd+2Wj0hVes4qBynH0jQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=mrWTj3dJ+c0HF9I7He0MoCMPRc52RMPNeFM/3fTPeJBWNVqgCxHa9oEwj8S9KGwHs
 CWIeZrjL/xERv4FPloQcAOKejlu+6E11ppmiCTRN7EuZ5PhQdLRpT+fn9LbhTFZCeH
 UkGU7v/wYxr2qHsN1SNPqrJIKtVtTNuT334elI0M5NJCGEkYKdIN/yj6ZgquzLPsSy
 UjnqlgM2s/Xqi72R1pLQKralksURB+0qVo22vMXMO4y7jiW934TmBjKUd7XIRauXJq
 h/xVyHohNIgaQDejBxSkRA53GgMnsei3tgwejPArW+TeFeQlq1rXGjGljMXQ9PPZcX
 HDRKeiJhd2F/Q==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id E3C521D8B0C;
 Sun, 27 Sep 2026 12:05:56 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id DE9564320C5;
 Sun, 27 Sep 2026 12:05:56 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id D08AE5E649; Sun, 27 Sep 2026 12:05:56 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Luigi Leonardi <leonardi@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.5 v2 59/86] hw/uefi: add missing uefi_str_is_valid check
 to uefi_vars_mm_lock_variable
Date: Sun, 27 Sep 2026 12:05:06 +0300
Message-ID: <20260927090540.102811-2-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.5-20260927120511@cover.tls.msk.ru>
References: <qemu-stable-11.0.5-20260927120511@cover.tls.msk.ru>
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

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4213
Reviewed-by: Luigi Leonardi <leonardi@redhat.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20260916145050.1329206-1-kraxel@redhat.com>
(cherry picked from commit ff96d562906644699c6a553c35e6cd51383c26c2)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/uefi/var-service-vars.c b/hw/uefi/var-service-vars.c
index e0ea3d532eb..ef8849f8151 100644
--- a/hw/uefi/var-service-vars.c
+++ b/hw/uefi/var-service-vars.c
@@ -690,6 +690,10 @@ uefi_vars_mm_lock_variable(uefi_vars_state *uv, mm_header *mhdr,
         return uefi_vars_mm_error(mhdr, mvar, EFI_BAD_BUFFER_SIZE);
     }
 
+    if (!uefi_str_is_valid(name, lv->name_size, true)) {
+        return uefi_vars_mm_error(mhdr, mvar, EFI_INVALID_PARAMETER);
+    }
+
     uefi_trace_variable(__func__, lv->guid, name, lv->name_size);
 
     pe = g_malloc0(sizeof(*pe) + lv->name_size);
-- 
2.47.3


