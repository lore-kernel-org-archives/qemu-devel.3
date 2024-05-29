Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2628FC25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 10:56:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCGxo-0004hI-Rn; Wed, 29 May 2024 06:55:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sCGxn-0004gf-KD
 for qemu-devel@nongnu.org; Wed, 29 May 2024 06:55:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sCGxl-0003B0-HR
 for qemu-devel@nongnu.org; Wed, 29 May 2024 06:55:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716980119;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yc9I/Tyn702qLgVI+8AQi35YjeMvPXJqOmiU2hephSc=;
 b=SFOvDKrS/jJ6/EKk5Dh2ot5OOsTvjxstvrj5Cyi58L1QeNJAwCMSxFTSLJtvlc9AuPXLXH
 4nLabgaEtfFt86+wLBgkusDM1ztbmvdSOw9nM2iR7kYcurRjohApj3L8GNRWeTb7pZ7D5N
 COy/DOfP7495H3OGRrYuhp1FNUVmn5I=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-569-N95wLpp6Ofifk1PBHOr8CA-1; Wed,
 29 May 2024 06:55:17 -0400
X-MC-Unique: N95wLpp6Ofifk1PBHOr8CA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 019353806701;
 Wed, 29 May 2024 10:55:17 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.109])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E85E8105480A;
 Wed, 29 May 2024 10:55:15 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-s390x@nongnu.org
Subject: [PULL 10/22] target/s390x: Raise exception from per_store_real
Date: Wed, 29 May 2024 12:54:42 +0200
Message-ID: <20240529105454.1149225-11-thuth@redhat.com>
In-Reply-To: <20240529105454.1149225-1-thuth@redhat.com>
References: <20240529105454.1149225-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
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

At this point the instruction is complete and there's nothing
left to do but raise the exception.  With this change we need
not make two helper calls for this event.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20240502054417.234340-11-richard.henderson@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 target/s390x/helper.h          | 2 +-
 target/s390x/tcg/misc_helper.c | 4 +++-
 target/s390x/tcg/translate.c   | 7 ++++---
 3 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index 061b379065..5611155ba1 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -362,7 +362,7 @@ DEF_HELPER_3(lra, i64, env, i64, i64)
 DEF_HELPER_FLAGS_3(per_check_exception, TCG_CALL_NO_WG, void, env, i64, i32)
 DEF_HELPER_FLAGS_3(per_branch, TCG_CALL_NO_WG, void, env, i64, i32)
 DEF_HELPER_FLAGS_2(per_ifetch, TCG_CALL_NO_RWG, void, env, i64)
-DEF_HELPER_FLAGS_1(per_store_real, TCG_CALL_NO_RWG, void, env)
+DEF_HELPER_FLAGS_2(per_store_real, TCG_CALL_NO_WG, noreturn, env, i32)
 DEF_HELPER_FLAGS_1(stfl, TCG_CALL_NO_RWG, void, env)
 
 DEF_HELPER_2(xsch, void, env, i64)
diff --git a/target/s390x/tcg/misc_helper.c b/target/s390x/tcg/misc_helper.c
index 974d14703c..43cacc448f 100644
--- a/target/s390x/tcg/misc_helper.c
+++ b/target/s390x/tcg/misc_helper.c
@@ -660,11 +660,13 @@ void HELPER(per_ifetch)(CPUS390XState *env, uint64_t addr)
     }
 }
 
-void HELPER(per_store_real)(CPUS390XState *env)
+void HELPER(per_store_real)(CPUS390XState *env, uint32_t ilen)
 {
     /* PSW is saved just before calling the helper.  */
     env->per_address = env->psw.addr;
+    env->int_pgm_ilen = ilen;
     env->per_perc_atmid = PER_CODE_EVENT_STORE_REAL | get_per_atmid(env);
+    per_raise_exception_log(env);
 }
 #endif
 
diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index de029185e0..5bb15a46e0 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -4342,8 +4342,10 @@ static DisasJumpType op_stura(DisasContext *s, DisasOps *o)
     tcg_gen_qemu_st_tl(o->in1, o->in2, MMU_REAL_IDX, s->insn->data);
 
     if (s->base.tb->flags & FLAG_MASK_PER_STORE_REAL) {
+        update_cc_op(s);
         update_psw_addr(s);
-        gen_helper_per_store_real(tcg_env);
+        gen_helper_per_store_real(tcg_env, tcg_constant_i32(s->ilen));
+        return DISAS_NORETURN;
     }
     return DISAS_NEXT;
 }
@@ -6355,8 +6357,7 @@ static DisasJumpType translate_one(CPUS390XState *env, DisasContext *s)
     }
 
 #ifndef CONFIG_USER_ONLY
-    if (s->base.tb->flags & (FLAG_MASK_PER_STORE_REAL |
-                             FLAG_MASK_PER_IFETCH)) {
+    if (s->base.tb->flags & FLAG_MASK_PER_IFETCH) {
         TCGv_i64 next_pc = psw_addr;
 
         if (ret == DISAS_NEXT || ret == DISAS_TOO_MANY) {
-- 
2.45.1


