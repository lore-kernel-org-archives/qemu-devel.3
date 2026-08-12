Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAD1BC5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 13:04:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu8cD-0003Tw-22; Wed, 12 Aug 2026 09:03:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wu8c7-0003Ra-5u; Wed, 12 Aug 2026 09:03:24 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wu8c4-0004HL-JW; Wed, 12 Aug 2026 09:03:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786539783; bh=lHiW524Pw4IwbBzb/+ylDqXNIMsr4SRVu2qzpcaHq1c=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Mi9ltSY+ZzpUdYF13D3/cw/cv9sTePH5Rbbc8uZElX6FXimhdO3rAy9jHIQ5GP1Qq
 cdcZhkAhw+8F7BgHRInKONAI8p4CqIZm9qXIPWTGEljt9lzd6FKuWahTHXK92jxHeu
 AZvX9wOjJ+O3x38uUZ9XSEhVYxFsqvcYy1M6/Ue6OzkdYeBx5EsKzpmO2A1E3vwBcZ
 HIxwdZ3KaZXRYpe9/R6dF8W2qJacvbz0eR5bQ/kv4HdmmGhA4j9G4zku6/UUDpgIin
 gPGSr0iAR7fUKGB9ZPnWyIEarSzCyRzCX+nh4sU8AtihOdCysWhu0pMZwgw3QSuVfd
 w7l1dRmjoiY7w==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 12A1E1CA483;
 Wed, 12 Aug 2026 16:03:03 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 48DDC409B66;
 Wed, 12 Aug 2026 16:03:14 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id CAB4B2F89C; Wed, 12 Aug 2026 16:02:49 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Luigi Leonardi <leonardi@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.13 004/102] hw/uefi: account variable policy entries
 against storage size
Date: Wed, 12 Aug 2026 16:00:39 +0300
Message-ID: <20260812130233.621965-4-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.13-20260812152851@cover.tls.msk.ru>
References: <qemu-stable-10.0.13-20260812152851@cover.tls.msk.ru>
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

uefi-vars already tracks (and limits) the memory footprint of UEFI
variables.  Do that for variable policies too.

Fixes: CVE-2026-61405
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3890
Acked-by: Luigi Leonardi <leonardi@redhat.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20260720143244.821889-5-kraxel@redhat.com>
(cherry picked from commit 8e0ddb4a6ebd1c3d2dfd067f82b6d92de5b23e30)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/uefi/var-service-policy.c b/hw/uefi/var-service-policy.c
index 64811ef4c45..1e941a65fcc 100644
--- a/hw/uefi/var-service-policy.c
+++ b/hw/uefi/var-service-policy.c
@@ -283,7 +283,12 @@ static uint32_t uefi_vars_mm_check_policy_register(uefi_vars_state *uv,
         return uefi_vars_mm_policy_error(mhdr, mchk, EFI_ALREADY_STARTED);
     }
 
+    if (uv->used_storage + pe->size > uv->max_storage) {
+        return uefi_vars_mm_policy_error(mhdr, mchk, EFI_OUT_OF_RESOURCES);
+    }
+
     uefi_vars_add_policy(uv, pe);
+    uv->used_storage += pe->size;
 
     mchk->result = EFI_SUCCESS;
     return sizeof(*mchk);
diff --git a/hw/uefi/var-service-vars.c b/hw/uefi/var-service-vars.c
index ef8a3db873a..dface7e8cd7 100644
--- a/hw/uefi/var-service-vars.c
+++ b/hw/uefi/var-service-vars.c
@@ -164,11 +164,15 @@ void uefi_vars_clear_all(uefi_vars_state *uv)
 void uefi_vars_update_storage(uefi_vars_state *uv)
 {
     uefi_variable *var;
+    uefi_var_policy *pol;
 
     uv->used_storage = 0;
     QTAILQ_FOREACH(var, &uv->variables, next) {
         uv->used_storage += variable_size(var);
     }
+    QTAILQ_FOREACH(pol, &uv->var_policies, next) {
+        uv->used_storage += pol->entry->size;
+    }
 }
 
 static gboolean check_access(uefi_vars_state *uv, uefi_variable *var)
-- 
2.47.3


