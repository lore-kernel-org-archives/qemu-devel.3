Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23C76C44506
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2026 22:05:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wifnT-0000BS-3v; Sat, 11 Jul 2026 18:03:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wifnG-0007pa-Qe; Sat, 11 Jul 2026 18:03:32 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wifnB-0000BO-CQ; Sat, 11 Jul 2026 18:03:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1783807181; bh=nuTOMIE/WJ+A+UsDjoUlEZxCqmfVQBK6le+mjRTmLcA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=t+YR1uQe4S2mb4QDj7EQqFwZYwuFlcy56EsU4Rx95zAiTXcVM5pg3KlqYcn2QpVSt
 +8aCvXXS8UsVrlUJRDdY4r3XoxpaVlT3oUtPz3Bl770Q9Z9NZLdF5kKRo0dqeknqN9
 KUGq4dQ7ZgKQrWEvlKI9OIhr7uVayCkURGsgjhMmGWTjxnqfRtFQbBp4mGkPc5YHh+
 E4NHTZSce8uV34GWCB1mdmzoJh5FIOPOUJW2Udu8opGojIxx5jXGHPfgrKKlSCOrl4
 UXNBZb1XKWnhHaK9AELRiwO7Y6vWAfgqvnZuadl0GQ0GrpUUbRhL4CmhcaO3jQ6POg
 gdnAUkqAdHlnA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 167191C0AB5;
 Sun, 12 Jul 2026 00:59:41 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id C108A3EAF40;
 Sun, 12 Jul 2026 00:59:50 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 9BE6A13337; Sun, 12 Jul 2026 00:59:50 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.3 42/81] s390x/ioinst: Require strict length and format
 for SEI CHSC handler
Date: Sun, 12 Jul 2026 00:58:20 +0300
Message-ID: <20260711215904.3757-42-mjt@tls.msk.ru>
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

From: Matthew Rosato <mjrosato@linux.ibm.com>

Ensure SEI commands that are received are of the appropriate length and
format before handling.

Cc: qemu-stable@nongnu.org
Fixes: 8cba80c3a0 ("s390: Add PCI bus support")
Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Reviewed-by: Farhan Ali <alifm@linux.ibm.com>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Message-ID: <20260707070728.147203-5-borntraeger@linux.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
(cherry picked from commit 386268daea86e53d90baf99df5c7b8e2727ea783)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/s390x/ioinst.c b/target/s390x/ioinst.c
index 2320dd4c122..94619f92155 100644
--- a/target/s390x/ioinst.c
+++ b/target/s390x/ioinst.c
@@ -609,13 +609,27 @@ static int chsc_sei_nt2_have_event(void)
 
 #define CHSC_SEI_NT0    (1ULL << 63)
 #define CHSC_SEI_NT2    (1ULL << 61)
+#define CHSC_SEI_0_FMT 0x0f000000
 static void ioinst_handle_chsc_sei(ChscReq *req, ChscResp *res)
 {
     uint64_t selection_mask = ldq_be_p(&req->param1);
+    uint32_t param0 = be32_to_cpu(req->param0);
     uint8_t *res_flags = (uint8_t *)res->data;
+    uint16_t len = be16_to_cpu(req->len);
+    uint16_t resp_code;
     int have_event = 0;
     int have_more = 0;
 
+    if (len != 0x0010) {
+        resp_code = 0x0003;
+        goto out_err;
+    }
+
+    if (param0 & CHSC_SEI_0_FMT) {
+        resp_code = 0x0007;
+        goto out_err;
+    }
+
     /* regarding architecture nt0 can not be masked */
     have_event = !chsc_sei_nt0_get_event(res);
     have_more = chsc_sei_nt0_have_event();
@@ -642,6 +656,12 @@ static void ioinst_handle_chsc_sei(ChscReq *req, ChscResp *res)
         res->code = cpu_to_be16(0x0005);
         res->len = cpu_to_be16(CHSC_MIN_RESP_LEN);
     }
+    return;
+
+ out_err:
+    res->code = cpu_to_be16(resp_code);
+    res->len = cpu_to_be16(CHSC_MIN_RESP_LEN);
+    res->param = 0;
 }
 
 static void ioinst_handle_chsc_unimplemented(ChscResp *res)
-- 
2.47.3


