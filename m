Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54FE0C43458
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2026 22:06:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wifpB-0004eI-VA; Sat, 11 Jul 2026 18:05:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wifoy-0004PS-5C; Sat, 11 Jul 2026 18:05:17 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wifow-0000az-HI; Sat, 11 Jul 2026 18:05:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1783807181; bh=0wUaGL+SyRk9TslpNYgpAnx7XjUEd1F+xd6GutZPLCI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=A2OHmoBIv8yLReZRU1GAR7tdHfYQjlsVfQ0Du6H+V0O5zSNwE2rkGN8ZLZIMF6xSI
 Ucw+mAULe2Gi+7/5xz+k2IP5iXCbyiRyiozTvVNtfPuxSGDjOrTmzi1pVgU81nIi6k
 Tvi1cjkdxK4Azcv3F2GLVDbnosQTYUDyR51trf7yeCpYL7OgJ67kWnboFdczrnCOFV
 DHt0vCc5Bsjlek1oKzrWEy2qiifkOaR3LZWPI9iuldWIGtR17Yh8sCU2etdnqSqTg8
 2w6zDDZC+Cj8mUDFQC8Y1r+4eyWuxK59OD/7NWoaBLp/0LIRNh+lH9ZCOEiMvzZCMG
 jp6KLmTMTKc3Q==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 7433E1C0AC6;
 Sun, 12 Jul 2026 00:59:41 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 2B1E73EAF51;
 Sun, 12 Jul 2026 00:59:51 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id C540013359; Sun, 12 Jul 2026 00:59:50 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.3 59/81] scsi: register again after PREEMPT without
 reservation
Date: Sun, 12 Jul 2026 00:58:37 +0300
Message-ID: <20260711215904.3757-59-mjt@tls.msk.ru>
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

From: Stefan Hajnoczi <stefanha@redhat.com>

The SCSI specification says PREEMPT without a reservation removes all
registrations with the given key. Try to register again after PREEMPT
since our key will have been removed.

In practice some SCSI targets keep the calling I_T nexus' registration
instead of removing it. Therefore we need to handle both the
spec-compliant and the non-compliant behavior.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Link: https://lore.kernel.org/r/20260401171927.396672-4-stefanha@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit b9a3b329d09dea5a4692de483419693ef0e23052)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/scsi/scsi-generic.c b/hw/scsi/scsi-generic.c
index 349dea6bddf..5182f9236da 100644
--- a/hw/scsi/scsi-generic.c
+++ b/hw/scsi/scsi-generic.c
@@ -513,6 +513,16 @@ bool scsi_generic_pr_state_preempt(SCSIDevice *s, Error **errp)
         if (!scsi_generic_pr_preempt(s, key, resv_type, errp)) {
             return false;
         }
+
+        /*
+         * Some SCSI targets, like the Linux LIO target, remove our
+         * registration when preempting without a reservation (resv_type is 0).
+         * Try to register again but ignore the error since a RESERVATION
+         * CONFLICT is expected if our registration remained in place.
+         */
+        if (resv_type == 0) {
+            scsi_generic_pr_register(s, key, NULL);
+        }
     }
     return true;
 }
-- 
2.47.3


