Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BDE9CCF9F8
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 11:00:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFsHo-0004SY-Qf; Mon, 03 Nov 2025 05:59:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vFsHj-0004Io-VM
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 05:59:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vFsHf-0004m5-NN
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 05:59:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762167572;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qTnH6S3Bw8xH+z2ZRrA7mhfL4V2VfEnhe8gpVHFu6sw=;
 b=iXNI8gxNJvaTP9oBS2m3ZDN+eEwKEhB3VgMKRMT9ynsd7VzSYn85xTch4S4Bm9LoPFTtk9
 mliWIpcj8cPsmAFuz159UWzURB+lfV+vd3KbUFMwZpHvCoNmjlH20Ugda0knvfc9Hte9DQ
 yD+G6NUsjZX22tKCE9dCy2kvTvg7s5E=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-462-aXnXK3L0OkCxDuck5fe0iA-1; Mon,
 03 Nov 2025 05:59:12 -0500
X-MC-Unique: aXnXK3L0OkCxDuck5fe0iA-1
X-Mimecast-MFC-AGG-ID: aXnXK3L0OkCxDuck5fe0iA_1762167551
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BD1CE180A22B; Mon,  3 Nov 2025 10:59:11 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.33.12])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D063130001A8; Mon,  3 Nov 2025 10:59:09 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-stable@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PULL 20/22] target/s390x: Fix missing clock-comparator interrupts
 after reset
Date: Mon,  3 Nov 2025 11:58:17 +0100
Message-ID: <20251103105824.322039-21-thuth@redhat.com>
In-Reply-To: <20251103105824.322039-1-thuth@redhat.com>
References: <20251103105824.322039-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Ilya Leoshkevich <iii@linux.ibm.com>

After reset, CKC value is set to 0, so if clock-comparator interrupts
are enabled, one should occur very shortly thereafter.

Currently the code that loads the respective control register does not
set tod_timer, so this does not happen.

Fix by adding a tcg_s390_tod_updated() call to LCTL and LCTLG.

Cc: qemu-stable@nongnu.org
Suggested-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Message-ID: <20251016175954.41153-3-iii@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 target/s390x/tcg/mem_helper.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/target/s390x/tcg/mem_helper.c b/target/s390x/tcg/mem_helper.c
index f1acb1618f7..24675fc818d 100644
--- a/target/s390x/tcg/mem_helper.c
+++ b/target/s390x/tcg/mem_helper.c
@@ -1959,6 +1959,10 @@ void HELPER(lctlg)(CPUS390XState *env, uint32_t r1, uint64_t a2, uint32_t r3)
         if (env->cregs[i] != val && i >= 9 && i <= 11) {
             PERchanged = true;
         }
+        if (i == 0 && !(env->cregs[i] & CR0_CKC_SC) && (val & CR0_CKC_SC)) {
+            BQL_LOCK_GUARD();
+            tcg_s390_tod_updated(env_cpu(env), RUN_ON_CPU_NULL);
+        }
         env->cregs[i] = val;
         HELPER_LOG("load ctl %d from 0x%" PRIx64 " == 0x%" PRIx64 "\n",
                    i, src, val);
@@ -1989,10 +1993,15 @@ void HELPER(lctl)(CPUS390XState *env, uint32_t r1, uint64_t a2, uint32_t r3)
 
     for (i = r1;; i = (i + 1) % 16) {
         uint32_t val = cpu_ldl_data_ra(env, src, ra);
+        uint64_t val64 = deposit64(env->cregs[i], 0, 32, val);
         if ((uint32_t)env->cregs[i] != val && i >= 9 && i <= 11) {
             PERchanged = true;
         }
-        env->cregs[i] = deposit64(env->cregs[i], 0, 32, val);
+        if (i == 0 && !(env->cregs[i] & CR0_CKC_SC) && (val64 & CR0_CKC_SC)) {
+            BQL_LOCK_GUARD();
+            tcg_s390_tod_updated(env_cpu(env), RUN_ON_CPU_NULL);
+        }
+        env->cregs[i] = val64;
         HELPER_LOG("load ctl %d from 0x%" PRIx64 " == 0x%x\n", i, src, val);
         src += sizeof(uint32_t);
 
-- 
2.51.0


