Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E9C9CD585E
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 12:09:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdSJp-0003vY-D1; Wed, 07 Jan 2026 07:07:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vdSJf-0003tS-Q5
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 07:07:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vdSJY-00029n-SE
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 07:07:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767787618;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MfiJBRSHKWd6uUsqcK6dtBKc4aUeaTwvVHsNFr2yqLg=;
 b=SA6XnBm5TFeZd22+H3Y4L35sr7nMh1fB+13bxuuWhYj2OLCbWd3HC/83PtziEkZrU03ECb
 /Q3imqSX1zrWIlCrQAPAtX8XB9ia6rRuZ7VihUKl4Xp92OKy3OYtvYzfHARrSOIu0m1gqL
 0c3CD6NdZNc3258Lx862HIlvlh6ZmZw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-211-2Dk1ajVmO964o88oGs9TjQ-1; Wed,
 07 Jan 2026 07:06:55 -0500
X-MC-Unique: 2Dk1ajVmO964o88oGs9TjQ-1
X-Mimecast-MFC-AGG-ID: 2Dk1ajVmO964o88oGs9TjQ_1767787614
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0397C1800473; Wed,  7 Jan 2026 12:06:54 +0000 (UTC)
Received: from thuth-p1g4.str.redhat.com (dhcp-192-176.str.redhat.com
 [10.33.192.176])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A173F1956053; Wed,  7 Jan 2026 12:06:52 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Eric Farman <farman@linux.ibm.com>
Subject: [PULL 08/14] target/s390x: Replace gdb_get_regl() -> gdb_get_reg64()
Date: Wed,  7 Jan 2026 13:06:32 +0100
Message-ID: <20260107120638.56735-9-thuth@redhat.com>
In-Reply-To: <20260107120638.56735-1-thuth@redhat.com>
References: <20260107120638.56735-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

We only build s390x targets as 64-bit:

  $ git grep BIT configs/targets/s390x-*
  configs/targets/s390x-linux-user.mak:6:TARGET_LONG_BITS=64
  configs/targets/s390x-softmmu.mak:5:TARGET_LONG_BITS=64

Therefore gdb_get_regl() expands to gdb_get_reg64(). Use
the latter which is more explicit.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20251224162036.90404-4-philmd@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 target/s390x/gdbstub.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/target/s390x/gdbstub.c b/target/s390x/gdbstub.c
index 6bca376f2b6..d1f02ea5ce4 100644
--- a/target/s390x/gdbstub.c
+++ b/target/s390x/gdbstub.c
@@ -34,11 +34,11 @@ int s390_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 
     switch (n) {
     case S390_PSWM_REGNUM:
-        return gdb_get_regl(mem_buf, s390_cpu_get_psw_mask(env));
+        return gdb_get_reg64(mem_buf, s390_cpu_get_psw_mask(env));
     case S390_PSWA_REGNUM:
-        return gdb_get_regl(mem_buf, env->psw.addr);
+        return gdb_get_reg64(mem_buf, env->psw.addr);
     case S390_R0_REGNUM ... S390_R15_REGNUM:
-        return gdb_get_regl(mem_buf, env->regs[n - S390_R0_REGNUM]);
+        return gdb_get_reg64(mem_buf, env->regs[n - S390_R0_REGNUM]);
     }
     return 0;
 }
@@ -190,7 +190,7 @@ static int cpu_read_c_reg(CPUState *cs, GByteArray *buf, int n)
 
     switch (n) {
     case S390_C0_REGNUM ... S390_C15_REGNUM:
-        return gdb_get_regl(buf, env->cregs[n]);
+        return gdb_get_reg64(buf, env->cregs[n]);
     default:
         return 0;
     }
@@ -227,13 +227,13 @@ static int cpu_read_virt_reg(CPUState *cs, GByteArray *mem_buf, int n)
 
     switch (n) {
     case S390_VIRT_CKC_REGNUM:
-        return gdb_get_regl(mem_buf, env->ckc);
+        return gdb_get_reg64(mem_buf, env->ckc);
     case S390_VIRT_CPUTM_REGNUM:
-        return gdb_get_regl(mem_buf, env->cputm);
+        return gdb_get_reg64(mem_buf, env->cputm);
     case S390_VIRT_BEA_REGNUM:
-        return gdb_get_regl(mem_buf, env->gbea);
+        return gdb_get_reg64(mem_buf, env->gbea);
     case S390_VIRT_PREFIX_REGNUM:
-        return gdb_get_regl(mem_buf, env->psa);
+        return gdb_get_reg64(mem_buf, env->psa);
     default:
         return 0;
     }
@@ -279,13 +279,13 @@ static int cpu_read_virt_kvm_reg(CPUState *cs, GByteArray *mem_buf, int n)
 
     switch (n) {
     case S390_VIRT_KVM_PP_REGNUM:
-        return gdb_get_regl(mem_buf, env->pp);
+        return gdb_get_reg64(mem_buf, env->pp);
     case S390_VIRT_KVM_PFT_REGNUM:
-        return gdb_get_regl(mem_buf, env->pfault_token);
+        return gdb_get_reg64(mem_buf, env->pfault_token);
     case S390_VIRT_KVM_PFS_REGNUM:
-        return gdb_get_regl(mem_buf, env->pfault_select);
+        return gdb_get_reg64(mem_buf, env->pfault_select);
     case S390_VIRT_KVM_PFC_REGNUM:
-        return gdb_get_regl(mem_buf, env->pfault_compare);
+        return gdb_get_reg64(mem_buf, env->pfault_compare);
     default:
         return 0;
     }
@@ -330,7 +330,7 @@ static int cpu_read_gs_reg(CPUState *cs, GByteArray *buf, int n)
     S390CPU *cpu = S390_CPU(cs);
     CPUS390XState *env = &cpu->env;
 
-    return gdb_get_regl(buf, env->gscb[n]);
+    return gdb_get_reg64(buf, env->gscb[n]);
 }
 
 static int cpu_write_gs_reg(CPUState *cs, uint8_t *mem_buf, int n)
-- 
2.52.0


