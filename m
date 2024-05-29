Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06D7CC27C44
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 10:56:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCGxY-0004Xl-DL; Wed, 29 May 2024 06:55:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sCGxV-0004Vr-Fq
 for qemu-devel@nongnu.org; Wed, 29 May 2024 06:55:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sCGxT-00032m-RT
 for qemu-devel@nongnu.org; Wed, 29 May 2024 06:55:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716980103;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+QYlakjJc7E2aRRntrBWn7dGsezTUaIxUX0JZczpE6g=;
 b=K7cRMkAxXB2b/CVrxUsmJ/mTf9mpAclNvHrG/q7AVnsEhkDZTakrBRdradqBFfs1W3tt3m
 s4Lz14QtxWMts++CO9p8a/fZqFuy4V2rfpGkshDQMlRRX/SRSa4UfN2XH/2w3hUFR+Fbml
 lZ8656sdViuy35RFKL0I+46j4tNft0U=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-144-2j9nrVX7P0ia_g3uvlUTZA-1; Wed, 29 May 2024 06:55:01 -0400
X-MC-Unique: 2j9nrVX7P0ia_g3uvlUTZA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F09D8800CAC;
 Wed, 29 May 2024 10:55:00 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.109])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CB116105480A;
 Wed, 29 May 2024 10:54:59 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-s390x@nongnu.org,
	Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PULL 03/22] target/s390x: Update CR9 bits
Date: Wed, 29 May 2024 12:54:35 +0200
Message-ID: <20240529105454.1149225-4-thuth@redhat.com>
In-Reply-To: <20240529105454.1149225-1-thuth@redhat.com>
References: <20240529105454.1149225-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.036,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Richard Henderson <richard.henderson@linaro.org>

Update from the PoO 14th edition.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
Message-ID: <20240502054417.234340-4-richard.henderson@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 target/s390x/cpu.h             | 18 +++++++++++-------
 target/s390x/tcg/misc_helper.c |  2 +-
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 950f84f316..1bb723a9d3 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -419,13 +419,17 @@ void cpu_get_tb_cpu_state(CPUS390XState *env, vaddr *pc,
 #endif /* CONFIG_TCG */
 
 /* PER bits from control register 9 */
-#define PER_CR9_EVENT_BRANCH           0x80000000
-#define PER_CR9_EVENT_IFETCH           0x40000000
-#define PER_CR9_EVENT_STORE            0x20000000
-#define PER_CR9_EVENT_STORE_REAL       0x08000000
-#define PER_CR9_EVENT_NULLIFICATION    0x01000000
-#define PER_CR9_CONTROL_BRANCH_ADDRESS 0x00800000
-#define PER_CR9_CONTROL_ALTERATION     0x00200000
+#define PER_CR9_EVENT_BRANCH                    0x80000000
+#define PER_CR9_EVENT_IFETCH                    0x40000000
+#define PER_CR9_EVENT_STORE                     0x20000000
+#define PER_CR9_EVENT_STORAGE_KEY_ALTERATION    0x10000000
+#define PER_CR9_EVENT_STORE_REAL                0x08000000
+#define PER_CR9_EVENT_ZERO_ADDRESS_DETECTION    0x04000000
+#define PER_CR9_EVENT_TRANSACTION_END           0x02000000
+#define PER_CR9_EVENT_IFETCH_NULLIFICATION      0x01000000
+#define PER_CR9_CONTROL_BRANCH_ADDRESS          0x00800000
+#define PER_CR9_CONTROL_TRANSACTION_SUPRESS     0x00400000
+#define PER_CR9_CONTROL_STORAGE_ALTERATION      0x00200000
 
 /* PER bits from the PER CODE/ATMID/AI in lowcore */
 #define PER_CODE_EVENT_BRANCH          0x8000
diff --git a/target/s390x/tcg/misc_helper.c b/target/s390x/tcg/misc_helper.c
index 7c94468392..0482442458 100644
--- a/target/s390x/tcg/misc_helper.c
+++ b/target/s390x/tcg/misc_helper.c
@@ -644,7 +644,7 @@ void HELPER(per_ifetch)(CPUS390XState *env, uint64_t addr)
 
         /* If the instruction has to be nullified, trigger the
            exception immediately. */
-        if (env->cregs[9] & PER_CR9_EVENT_NULLIFICATION) {
+        if (env->cregs[9] & PER_CR9_EVENT_IFETCH_NULLIFICATION) {
             CPUState *cs = env_cpu(env);
 
             env->per_perc_atmid |= PER_CODE_EVENT_NULLIFICATION;
-- 
2.45.1


