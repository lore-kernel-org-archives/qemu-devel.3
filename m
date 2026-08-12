Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA58FC5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 15:13:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuAIt-0004st-Qj; Wed, 12 Aug 2026 10:51:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wuAIG-0004Ph-0O; Wed, 12 Aug 2026 10:51:01 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wuAIC-0006fs-Qk; Wed, 12 Aug 2026 10:50:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786546230; bh=3RFVQH8DG5t57EwQKAlm+0YwYLra1HqTSuyKnt2s0iE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=lziZ173fJjKLxXT5qNY4TcsRY4zqP3FC7KHkxWFNCbvSgy3FBzT65bGz8W7nDFfsk
 QjMZCFeZgWB5HHg3N1amXbnXNML42wsvSIGBaTEwYuZJFt6IPzL9wqQCzkL6KmB7M1
 EYm6x44NCoczi5Z8Cr3cYXTLeKOzIHaCQR2R5mScfiLP8H3Cjx1yCE3aygd9k/6oXE
 A7NHyOgsfOblgz2Z70FKj3rTYGKbvmIA7QpZ65JcmII0gsU1SZZYC/eNtrfoZ7HjkF
 TefjJDkTV31ItsbtU0B1R6elrYjm7zLN5h/XpHGIaqlkIISlKeo+n5xBH+NQQu/Nn+
 KRmtYkOmG9HWA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id BD2471CA608;
 Wed, 12 Aug 2026 17:50:30 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 2404B409D41;
 Wed, 12 Aug 2026 17:50:42 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 8398B2F96B; Wed, 12 Aug 2026 17:50:17 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Luigi Leonardi <leonardi@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.4 004/120] hw/uefi: account variable policy entries
 against storage size
Date: Wed, 12 Aug 2026 17:47:47 +0300
Message-ID: <20260812144955.649205-4-mjt@tls.msk.ru>
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
index 0880bfe074a..46c4ff2daca 100644
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
index 2c83130ebf6..fd07782f1e0 100644
--- a/hw/uefi/var-service-vars.c
+++ b/hw/uefi/var-service-vars.c
@@ -201,11 +201,15 @@ void uefi_vars_clear_all(uefi_vars_state *uv)
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


