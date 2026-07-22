Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECD8AC44536
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 12:50:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmWMe-0002z6-IK; Wed, 22 Jul 2026 08:47:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wmWMB-0002kp-1p; Wed, 22 Jul 2026 08:47:29 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wmWM9-0001dd-DJ; Wed, 22 Jul 2026 08:47:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1784724390; bh=27tVyj76yu7ecrkT99EBbIhqp+A+PZztAbZYuxVvsHk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Mqw4uMkfWvO7e/meZO6CQH4+HqR2F9lZRlBF3ZJApZkG55J0QLwhJ9WjC/4UODP05
 3f+ZpTkTqZOy6TEfCzq7YHxk8GHQe46HLPWh4sv4027XZ2HR82ptHMj1x/sllkgFeM
 J8zYTOhEBDuhxYdDw9Tve8b/KHeXthhDtyWCV+CxNkjJXJtL+NCYEvYxNnZG//zgEp
 kOI9TbWL7nuR9gxsdRqnOjR6zuU0ZdR3jxnbw6QoMJOh5euviu86lUj3GbuC0U4Zn5
 MpcQP2TuRLIC8gbX9QpUYs8+RYPckLVFxdbLYGP44Lu4KFlaaH98z14h8RZQtx+ipn
 VoYqU2mEnepvQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 63BBA1C3AFF;
 Wed, 22 Jul 2026 15:46:30 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id AB9093F3759;
 Wed, 22 Jul 2026 15:46:47 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 4F55F17EE7; Wed, 22 Jul 2026 15:46:38 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, "Jason J. Herne" <jjherne@linux.ibm.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.12 v2 086/122] hw/s390x/sclp: Do not ignore
 address_space_read/write() errors
Date: Wed, 22 Jul 2026 15:45:35 +0300
Message-ID: <20260722124622.31034-11-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.12-20260722154425@cover.tls.msk.ru>
References: <qemu-stable-10.0.12-20260722154425@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

If address_space_read() fails, return PGM_ADDRESSING. In the
unlikely case address_space_write() fails (we already checked
the address is readable), return PGM_PROTECTION.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Jason J. Herne <jjherne@linux.ibm.com>
Message-Id: <20251007015802.24748-1-philmd@linaro.org>
(cherry picked from commit d39ac36fe298400eac7e9272c950bedca29490c0)
(Mjt: pick this one up for 10.0.x so subsequent changes apply cleanly)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
index ce31bf8b0c0..3a7302f760c 100644
--- a/hw/s390x/sclp.c
+++ b/hw/s390x/sclp.c
@@ -305,6 +305,7 @@ int sclp_service_call(S390CPU *cpu, uint64_t sccb, uint32_t code)
     g_autofree SCCB *work_sccb = NULL;
     AddressSpace *as = CPU(cpu)->as;
     const MemTxAttrs attrs = MEMTXATTRS_UNSPECIFIED;
+    MemTxResult ret;
 
     /* first some basic checks on program checks */
     if (env->psw.mask & PSW_MASK_PSTATE) {
@@ -319,7 +320,10 @@ int sclp_service_call(S390CPU *cpu, uint64_t sccb, uint32_t code)
     }
 
     /* the header contains the actual length of the sccb */
-    address_space_read(as, sccb, attrs, &header, sizeof(SCCBHeader));
+    ret = address_space_read(as, sccb, attrs, &header, sizeof(SCCBHeader));
+    if (ret != MEMTX_OK) {
+        return -PGM_ADDRESSING;
+    }
 
     /* Valid sccb sizes */
     if (be16_to_cpu(header.length) < sizeof(SCCBHeader)) {
@@ -332,7 +336,11 @@ int sclp_service_call(S390CPU *cpu, uint64_t sccb, uint32_t code)
      * the host has checked the values
      */
     work_sccb = g_malloc0(be16_to_cpu(header.length));
-    address_space_read(as, sccb, attrs, work_sccb, be16_to_cpu(header.length));
+    ret = address_space_read(as, sccb, attrs,
+                            work_sccb, be16_to_cpu(header.length));
+    if (ret != MEMTX_OK) {
+        return -PGM_ADDRESSING;
+    }
 
     if (!sclp_command_code_valid(code)) {
         work_sccb->h.response_code = cpu_to_be16(SCLP_RC_INVALID_SCLP_COMMAND);
@@ -346,7 +354,11 @@ int sclp_service_call(S390CPU *cpu, uint64_t sccb, uint32_t code)
 
     sclp_c->execute(sclp, work_sccb, code);
 out_write:
-    address_space_write(as, sccb, attrs, work_sccb, be16_to_cpu(header.length));
+    ret = address_space_write(as, sccb, attrs,
+                              work_sccb, be16_to_cpu(header.length));
+    if (ret != MEMTX_OK) {
+        return -PGM_PROTECTION;
+    }
 
     sclp_c->service_interrupt(sclp, sccb);
 
-- 
2.47.3


