Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 138DBC5478C
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 19:34:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdbJi-000174-L9; Fri, 23 Feb 2024 14:34:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rdawB-0005m6-4U
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 14:10:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rdaw0-0005At-Ow
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 14:10:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708715410;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o3bEtATyp9tRxwVqQamHVsA7dwSgZbW9H9fEsU3qThM=;
 b=ANThoY3R3b0hfY55teEbMr2+wOeiBymfXwq64fzb3pbQRR0L23Z3lW9vDRSSaNqJwYpq2b
 uu1ISEt+Vb6kQyoStMkT9pjsd9pmtle3aAMxlvVKnt4ApquvQcCVNucDVc0tdH3m42+q/0
 nD7UbpVfjVQBRA/MfDNqgCNFRFLJZDQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-Y48CuBOZO0OWDsmoXEx3ZQ-1; Fri, 23 Feb 2024 14:10:07 -0500
X-MC-Unique: Y48CuBOZO0OWDsmoXEx3ZQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D77EE85A589;
 Fri, 23 Feb 2024 19:10:06 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B6DBB10800;
 Fri, 23 Feb 2024 19:10:05 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Daniel Palmer <daniel@0x0f.com>
Subject: [PULL 01/11] target/m68k: Fix exception frame format for 68010
Date: Fri, 23 Feb 2024 20:09:53 +0100
Message-ID: <20240223191003.6268-2-thuth@redhat.com>
In-Reply-To: <20240223191003.6268-1-thuth@redhat.com>
References: <20240223191003.6268-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.066,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Daniel Palmer <daniel@0x0f.com>

From the 68010 a word with the frame format and exception vector
are placed on the stack before the PC and SR.

M68K_FEATURE_QUAD_MULDIV is currently checked to workout if to do
this or not for the configured CPU but that flag isn't set for
68010 so currently the exception stack when 68010 is configured
is incorrect.

It seems like checking M68K_FEATURE_MOVEFROMSR_PRIV would do but
adding a new flag that shows exactly what is going on here is
maybe clearer.

Add a new flag for the behaviour, M68K_FEATURE_EXCEPTION_FORMAT_VEC,
and set it for 68010 and above, and then use it to control if the
format and vector word are pushed/pop during exception entry/exit.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2164
Signed-off-by: Daniel Palmer <daniel@0x0f.com>
Message-ID: <20240115101643.2165387-1-daniel@0x0f.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 target/m68k/cpu.h       | 2 ++
 target/m68k/cpu.c       | 4 +++-
 target/m68k/op_helper.c | 4 ++--
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
index 646cacbdf1..346427e144 100644
--- a/target/m68k/cpu.h
+++ b/target/m68k/cpu.h
@@ -550,6 +550,8 @@ enum m68k_features {
     M68K_FEATURE_TRAPCC,
     /* MOVE from SR privileged (from 68010) */
     M68K_FEATURE_MOVEFROMSR_PRIV,
+    /* Exception frame with format+vector (from 68010) */
+    M68K_FEATURE_EXCEPTION_FORMAT_VEC,
 };
 
 static inline bool m68k_feature(CPUM68KState *env, int feature)
diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index 8a8392e694..d5a71c6315 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -142,7 +142,8 @@ static void m68000_cpu_initfn(Object *obj)
 }
 
 /*
- * Adds BKPT, MOVE-from-SR *now priv instr, and MOVEC, MOVES, RTD
+ * Adds BKPT, MOVE-from-SR *now priv instr, and MOVEC, MOVES, RTD,
+ *      format+vector in exception frame.
  */
 static void m68010_cpu_initfn(Object *obj)
 {
@@ -155,6 +156,7 @@ static void m68010_cpu_initfn(Object *obj)
     m68k_set_feature(env, M68K_FEATURE_BKPT);
     m68k_set_feature(env, M68K_FEATURE_MOVEC);
     m68k_set_feature(env, M68K_FEATURE_MOVEFROMSR_PRIV);
+    m68k_set_feature(env, M68K_FEATURE_EXCEPTION_FORMAT_VEC);
 }
 
 /*
diff --git a/target/m68k/op_helper.c b/target/m68k/op_helper.c
index 47b4173bb9..956e76eb5f 100644
--- a/target/m68k/op_helper.c
+++ b/target/m68k/op_helper.c
@@ -52,7 +52,7 @@ throwaway:
     sp += 2;
     env->pc = cpu_ldl_mmuidx_ra(env, sp, MMU_KERNEL_IDX, 0);
     sp += 4;
-    if (m68k_feature(env, M68K_FEATURE_QUAD_MULDIV)) {
+    if (m68k_feature(env, M68K_FEATURE_EXCEPTION_FORMAT_VEC)) {
         /*  all except 68000 */
         fmt = cpu_lduw_mmuidx_ra(env, sp, MMU_KERNEL_IDX, 0);
         sp += 2;
@@ -256,7 +256,7 @@ static inline void do_stack_frame(CPUM68KState *env, uint32_t *sp,
                                   uint16_t format, uint16_t sr,
                                   uint32_t addr, uint32_t retaddr)
 {
-    if (m68k_feature(env, M68K_FEATURE_QUAD_MULDIV)) {
+    if (m68k_feature(env, M68K_FEATURE_EXCEPTION_FORMAT_VEC)) {
         /*  all except 68000 */
         CPUState *cs = env_cpu(env);
         switch (format) {
-- 
2.43.2


