Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EE4CCCF2C4
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2026 18:58:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xI9aK-0008VJ-LX; Sat, 17 Oct 2026 14:56:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xI9Zs-0008FQ-1f; Sat, 17 Oct 2026 14:56:20 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xI9Zq-0003cq-Cy; Sat, 17 Oct 2026 14:56:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1792263367; bh=y33UjaNmeodbvgW+vvTu/Qo/QJ3QIrjbmPwUOXWxO4g=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=J5nb7hBYbCoJiLax45FIZTp9EUPNjmVef6I17hNtBqJifY2QitM2YgZChAXeHRn6g
 qu2krfKpF6Gc4pvnGQ3cGBlHzUnBfdjFCakVYbKzsLUzIUQny2ESoSRvojr6vOOxrp
 cZrn2JZUwfSmup0q+sf0Kj9TZ1+4lVHzeRhE6uJapbUGun5bEMjcIblTAikFzcPrm8
 GJc9aShmG0J63iFrjqkLg4IqUYCuUV4P6RqEaAdIRBV1oPr4HJWkhQ85P6JwIcJ7K/
 9oL9xX2MeKAhbWFBMxSUlXgZQR/L5BskGTUnUCKlav0rCT5t8EXt9wanmgdFGeJrwi
 nFY1gqojd6l3g==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id DA7971DE6AB;
 Sat, 17 Oct 2026 21:56:07 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id B1D49443376;
 Sat, 17 Oct 2026 21:56:06 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Eric Farman <farman@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.15 11/63] s390x/sclp: Reject short headers in PV case
Date: Sat, 17 Oct 2026 21:54:27 +0300
Message-ID: <20261017185528.722197-11-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.15-20261017215444@cover.tls.msk.ru>
References: <qemu-stable-10.0.15-20261017215444@cover.tls.msk.ru>
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
index 977b8f5907..ed7481ba4f 100644
--- a/hw/s390x/sclp.c
+++ b/hw/s390x/sclp.c
@@ -279,6 +279,11 @@ int sclp_service_call_protected(S390CPU *cpu, uint64_t sccb, uint32_t code)
 
     s390_cpu_pv_mem_read(env_archcpu(env), 0, &header, sizeof(SCCBHeader));
 
+    /* We should never end up here due to UV checks, but lets be sure */
+    if (be16_to_cpu(header.length) < sizeof(SCCBHeader)) {
+        goto out_no_write;
+    }
+
     work_sccb = g_malloc0(be16_to_cpu(header.length));
     s390_cpu_pv_mem_read(env_archcpu(env), 0, work_sccb,
                          be16_to_cpu(header.length));
@@ -292,6 +297,7 @@ int sclp_service_call_protected(S390CPU *cpu, uint64_t sccb, uint32_t code)
 out_write:
     s390_cpu_pv_mem_write(env_archcpu(env), 0, work_sccb,
                           be16_to_cpu(header.length));
+out_no_write:
     sclp_c->service_interrupt(sclp, SCLP_PV_DUMMY_ADDR);
     return 0;
 }
-- 
2.47.3


