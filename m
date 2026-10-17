Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E95B7CCF2C9
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2026 20:33:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIB0f-0005y7-R4; Sat, 17 Oct 2026 16:28:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xIB0E-0005H8-8f; Sat, 17 Oct 2026 16:27:39 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xIB0C-0003vN-Dr; Sat, 17 Oct 2026 16:27:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1792268834; bh=YvudTu1TjQ7XzZhzWIPBrU8F7GjFpeEV26Ryt+HR480=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Z1vmyPlTyJ1PuGObCczViDc9j8ipIVoEH+LUa7oS1AAEZEKAHpsgyqq2XXHi4AbCh
 +LmqEju1I7awpKThXEWUI0l1kcdZVKfOWuxb3Ra7CxSBcdU7X0iQmqjfXRUMUt7m5O
 ghA1j7oTgbhlV2lR8XvJS682kEFIymFxnNK+oOIaPQ0ZoyAreo3OyuMOKlIOyayhML
 UIK/rlzpVkZfpHQ2Z2Y1NqLJahoEzBIM9oe5jnMnbqLfUgGqDoySIbHC6u3dMNl9vd
 YzXpp0uCV0+hS6qoxmEG3mtI1CZGleEROdBq3l9KclSOK8x4s6x3AmmLvhuFbYuyxE
 mMIz0Z5EKOO7A==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 5623B1DE746;
 Sat, 17 Oct 2026 23:27:14 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id C5A0444341D;
 Sat, 17 Oct 2026 23:27:12 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Eric Farman <farman@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.3 11/73] s390x/sclp: Reject short headers in PV case
Date: Sat, 17 Oct 2026 23:25:29 +0300
Message-ID: <20261017202638.728621-11-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.3-20261017220607@cover.tls.msk.ru>
References: <qemu-stable-11.1.3-20261017220607@cover.tls.msk.ru>
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

From: Eric Farman <farman@linux.ibm.com>

An invalid length in an SCCB header correctly generates a specification
exception for the regular (non-PV) codepath that processes an SCLP
instruction intercept. The PV case doesn't, because the UV enforces
a valid length before getting to this point. The length is used to
allocate storage later down the line, so doublecheck the length here
in the (unlikely) case it is too short.

Cc: Janosch Frank <frankja@linux.ibm.com>
Cc: qemu-stable@nongnu.org
Fixes: c1db53a591 ("s390/sclp: read sccb from mem based on provided length")
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Acked-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260922201526.2383047-10-farman@linux.ibm.com
[farman@linux.ibm.com: Updated commit/comment text, per Janosch]
Signed-off-by: Eric Farman <farman@linux.ibm.com>
(cherry picked from commit 119860f15cd239dced773de9375f741db255652d)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
index b452f2ce54..8e5bd21f03 100644
--- a/hw/s390x/sclp.c
+++ b/hw/s390x/sclp.c
@@ -275,6 +275,11 @@ int sclp_service_call_protected(S390CPU *cpu, uint64_t sccb, uint32_t code)
 
     s390_cpu_pv_mem_read(env_archcpu(env), 0, &header, sizeof(SCCBHeader));
 
+    /* We should never end up here due to UV checks, but lets be sure */
+    if (be16_to_cpu(header.length) < sizeof(SCCBHeader)) {
+        goto out_no_write;
+    }
+
     work_sccb = g_malloc0(be16_to_cpu(header.length));
     s390_cpu_pv_mem_read(env_archcpu(env), 0, work_sccb,
                          be16_to_cpu(header.length));
@@ -288,6 +293,7 @@ int sclp_service_call_protected(S390CPU *cpu, uint64_t sccb, uint32_t code)
 out_write:
     s390_cpu_pv_mem_write(env_archcpu(env), 0, work_sccb,
                           be16_to_cpu(header.length));
+out_no_write:
     sclp_c->service_interrupt(sclp, SCLP_PV_DUMMY_ADDR);
     return 0;
 }
-- 
2.47.3


