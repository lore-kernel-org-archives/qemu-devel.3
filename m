Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 407A3D68BF8
	for <qemu-devel@archiver.kernel.org>; Sun, 24 Nov 2024 17:10:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFG5X-0003mG-9D; Sun, 24 Nov 2024 12:07:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <daad7af58b403aaa2487c566032beca36664b30e@kylie.crudebyte.com>)
 id 1tFG5V-0003lU-1R; Sun, 24 Nov 2024 12:07:57 -0500
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <daad7af58b403aaa2487c566032beca36664b30e@kylie.crudebyte.com>)
 id 1tFG5T-0005Hk-PF; Sun, 24 Nov 2024 12:07:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-Id:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=AS+IrlCVZDaIn5QIF9PwB79XyCeyEMVXYEcy54dkzfo=; b=TPy5s
 Itr8he/AZW2lFK/6ejlxJrWl6plsk1ApZuNn1x8yRZjuQbcZtml8On1nVoD8NFotze2EuGmBf5muX
 bVLtv7Wxut2azHtLWRWXHTeCWA6RyvPxV0pR6V+pakW4oIHxvflRoKR0jvwRiCOSRdFVQMxBPolP6
 ObkbspujDvAMZgMJB8s7sUvDUs8Gg6HTAA282Ob5TyWcMcJ4wDAbI4GEgCOXq0aoXAx+/f8Y9oi/K
 fmbrbftIoflswanEJRMjr0rNMDmGvdmra7dDVNfq3hGSXX04CrGrinsYMd1d4kRTMWtCDJaYH3KJf
 Exv1CHl+12DV+Ab6DKmPICqnQyQrP6raE5etW1u/X61I9RdgJLQHlhaAG9DE4wu1pLif3cn2OCs/V
 i26m0e9cg6vo92K4UlY7YB4By+XcmFtL/8WuBbN5LqBJikNO3BlY7wWK0451tdr0oM9qQEIdOEuos
 V+SPVtR5ol8rgk3jRCPsTEaHu2ASigbRo4y3kl/ZE9AaTAKriSgjh2rvkDRwY5qLpGpN8KeHmM2M0
 fYyAYMfrrmFc+YxCs06sAGRmkbSDW7UpYiVgC6TxqRINTC2/GjaU5cWEIhsevsZLgpqDPQCVr84Xt
 SMMA08eBiUHcXgMYs03PmQlQCZXeQ8fHTNskitF3KjJ++T36FA6HAHpFVQUbKg=;
Message-Id: <daad7af58b403aaa2487c566032beca36664b30e.1732465720.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1732465720.git.qemu_oss@crudebyte.com>
References: <cover.1732465720.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Sun, 24 Nov 2024 14:34:31 +0100
Subject: [PATCH 2/6] tests/9p: fix Rreaddir response name
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
    Greg Kurz <groug@kaod.org>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=daad7af58b403aaa2487c566032beca36664b30e@kylie.crudebyte.com;
 helo=kylie.crudebyte.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_03_06=1.592,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

All 9p response types are prefixed with an "R", therefore fix
"READDIR" -> "RREADDIR" in function rmessage_name().

Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 tests/qtest/libqos/virtio-9p-client.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qtest/libqos/virtio-9p-client.c b/tests/qtest/libqos/virtio-9p-client.c
index b8adc8d4b9..c61632fcd3 100644
--- a/tests/qtest/libqos/virtio-9p-client.c
+++ b/tests/qtest/libqos/virtio-9p-client.c
@@ -238,7 +238,7 @@ static const char *rmessage_name(uint8_t id)
         id == P9_RLINK ? "RLINK" :
         id == P9_RUNLINKAT ? "RUNLINKAT" :
         id == P9_RFLUSH ? "RFLUSH" :
-        id == P9_RREADDIR ? "READDIR" :
+        id == P9_RREADDIR ? "RREADDIR" :
         "<unknown>";
 }
 
-- 
2.39.5


