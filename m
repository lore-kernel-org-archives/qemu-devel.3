Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64548CFB43F
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 11:52:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxmGg-00079d-AJ; Mon, 07 Oct 2024 07:51:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sxmGZ-0006zU-Hm
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 07:51:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sxmGX-0005Av-VN
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 07:51:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728301865;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hCth+qjrAmJgbmMuAVkuFx20F8/9rFX5SbHFTFe1FO0=;
 b=ULuc1EOH9OS2Q+zIWo4A+ZEkwWONkGVfWhDznbosBmtwGqXZTRnvUJeIJGhPZg6IKisBFP
 Fj8Iw+KTMQelsHaL/c7LETFF7pOaZn7Z54+lXuHIbG2+/g5iuSL0W+7lhsf18gah0rPGrc
 3b0BEQfvlABUDQcb+pfB2QSwqs0tApw=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-557-mXBd-XoZPsqx7oWOXjKzxg-1; Mon,
 07 Oct 2024 07:51:02 -0400
X-MC-Unique: mXBd-XoZPsqx7oWOXjKzxg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E3ECD1955D65; Mon,  7 Oct 2024 11:51:00 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.194.46])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 53C9319560AE; Mon,  7 Oct 2024 11:50:57 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 10/12] target/s390x: Use explicit big-endian LD/ST API
Date: Mon,  7 Oct 2024 13:50:25 +0200
Message-ID: <20241007115027.243425-11-thuth@redhat.com>
In-Reply-To: <20241007115027.243425-1-thuth@redhat.com>
References: <20241007115027.243425-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.153,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

The S390X architecture uses big endianness. Directly use
the big-endian LD/ST API.

Mechanical change using:

  $ end=be; \
    for acc in uw w l q tul; do \
      sed -i -e "s/ld${acc}_p(/ld${acc}_${end}_p(/" \
             -e "s/st${acc}_p(/st${acc}_${end}_p(/" \
        $(git grep -wlE '(ld|st)t?u?[wlq]_p' target/s390x/); \
    done

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20241004163042.85922-24-philmd@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 target/s390x/gdbstub.c | 34 +++++++++++++++++-----------------
 target/s390x/ioinst.c  |  2 +-
 2 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/target/s390x/gdbstub.c b/target/s390x/gdbstub.c
index 9ffec0bccb..63373f02ce 100644
--- a/target/s390x/gdbstub.c
+++ b/target/s390x/gdbstub.c
@@ -46,7 +46,7 @@ int s390_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 int s390_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
 {
     CPUS390XState *env = cpu_env(cs);
-    target_ulong tmpl = ldq_p(mem_buf);
+    target_ulong tmpl = ldq_be_p(mem_buf);
 
     switch (n) {
     case S390_PSWM_REGNUM:
@@ -88,7 +88,7 @@ static int cpu_write_ac_reg(CPUState *cs, uint8_t *mem_buf, int n)
 
     switch (n) {
     case S390_A0_REGNUM ... S390_A15_REGNUM:
-        env->aregs[n] = ldl_p(mem_buf);
+        env->aregs[n] = ldl_be_p(mem_buf);
         cpu_synchronize_post_init(env_cpu(env));
         return 4;
     default:
@@ -123,10 +123,10 @@ static int cpu_write_fp_reg(CPUState *cs, uint8_t *mem_buf, int n)
 
     switch (n) {
     case S390_FPC_REGNUM:
-        env->fpc = ldl_p(mem_buf);
+        env->fpc = ldl_be_p(mem_buf);
         return 4;
     case S390_F0_REGNUM ... S390_F15_REGNUM:
-        *get_freg(env, n - S390_F0_REGNUM) = ldq_p(mem_buf);
+        *get_freg(env, n - S390_F0_REGNUM) = ldq_be_p(mem_buf);
         return 8;
     default:
         return 0;
@@ -167,11 +167,11 @@ static int cpu_write_vreg(CPUState *cs, uint8_t *mem_buf, int n)
 
     switch (n) {
     case S390_V0L_REGNUM ... S390_V15L_REGNUM:
-        env->vregs[n][1] = ldq_p(mem_buf + 8);
+        env->vregs[n][1] = ldq_be_p(mem_buf + 8);
         return 8;
     case S390_V16_REGNUM ... S390_V31_REGNUM:
-        env->vregs[n][0] = ldq_p(mem_buf);
-        env->vregs[n][1] = ldq_p(mem_buf + 8);
+        env->vregs[n][0] = ldq_be_p(mem_buf);
+        env->vregs[n][1] = ldq_be_p(mem_buf + 8);
         return 16;
     default:
         return 0;
@@ -203,7 +203,7 @@ static int cpu_write_c_reg(CPUState *cs, uint8_t *mem_buf, int n)
 
     switch (n) {
     case S390_C0_REGNUM ... S390_C15_REGNUM:
-        env->cregs[n] = ldq_p(mem_buf);
+        env->cregs[n] = ldq_be_p(mem_buf);
         if (tcg_enabled()) {
             tlb_flush(env_cpu(env));
         }
@@ -246,19 +246,19 @@ static int cpu_write_virt_reg(CPUState *cs, uint8_t *mem_buf, int n)
 
     switch (n) {
     case S390_VIRT_CKC_REGNUM:
-        env->ckc = ldq_p(mem_buf);
+        env->ckc = ldq_be_p(mem_buf);
         cpu_synchronize_post_init(cs);
         return 8;
     case S390_VIRT_CPUTM_REGNUM:
-        env->cputm = ldq_p(mem_buf);
+        env->cputm = ldq_be_p(mem_buf);
         cpu_synchronize_post_init(cs);
         return 8;
     case S390_VIRT_BEA_REGNUM:
-        env->gbea = ldq_p(mem_buf);
+        env->gbea = ldq_be_p(mem_buf);
         cpu_synchronize_post_init(cs);
         return 8;
     case S390_VIRT_PREFIX_REGNUM:
-        env->psa = ldq_p(mem_buf);
+        env->psa = ldq_be_p(mem_buf);
         cpu_synchronize_post_init(cs);
         return 8;
     default:
@@ -298,19 +298,19 @@ static int cpu_write_virt_kvm_reg(CPUState *cs, uint8_t *mem_buf, int n)
 
     switch (n) {
     case S390_VIRT_KVM_PP_REGNUM:
-        env->pp = ldq_p(mem_buf);
+        env->pp = ldq_be_p(mem_buf);
         cpu_synchronize_post_init(env_cpu(env));
         return 8;
     case S390_VIRT_KVM_PFT_REGNUM:
-        env->pfault_token = ldq_p(mem_buf);
+        env->pfault_token = ldq_be_p(mem_buf);
         cpu_synchronize_post_init(env_cpu(env));
         return 8;
     case S390_VIRT_KVM_PFS_REGNUM:
-        env->pfault_select = ldq_p(mem_buf);
+        env->pfault_select = ldq_be_p(mem_buf);
         cpu_synchronize_post_init(env_cpu(env));
         return 8;
     case S390_VIRT_KVM_PFC_REGNUM:
-        env->pfault_compare = ldq_p(mem_buf);
+        env->pfault_compare = ldq_be_p(mem_buf);
         cpu_synchronize_post_init(env_cpu(env));
         return 8;
     default:
@@ -338,7 +338,7 @@ static int cpu_write_gs_reg(CPUState *cs, uint8_t *mem_buf, int n)
     S390CPU *cpu = S390_CPU(cs);
     CPUS390XState *env = &cpu->env;
 
-    env->gscb[n] = ldq_p(mem_buf);
+    env->gscb[n] = ldq_be_p(mem_buf);
     cpu_synchronize_post_init(env_cpu(env));
     return 8;
 }
diff --git a/target/s390x/ioinst.c b/target/s390x/ioinst.c
index bbe45a497a..a944f16c25 100644
--- a/target/s390x/ioinst.c
+++ b/target/s390x/ioinst.c
@@ -603,7 +603,7 @@ static int chsc_sei_nt2_have_event(void)
 #define CHSC_SEI_NT2    (1ULL << 61)
 static void ioinst_handle_chsc_sei(ChscReq *req, ChscResp *res)
 {
-    uint64_t selection_mask = ldq_p(&req->param1);
+    uint64_t selection_mask = ldq_be_p(&req->param1);
     uint8_t *res_flags = (uint8_t *)res->data;
     int have_event = 0;
     int have_more = 0;
-- 
2.46.1


