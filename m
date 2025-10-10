Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 217D9CCD18D
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 08:24:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v78OI-000291-Aq; Fri, 10 Oct 2025 04:22:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v78OC-00027Q-5P
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 04:22:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v78O7-00011Z-U9
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 04:22:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760084522;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/vSSZEI/Kr1oUdUVr1yK3MzhrrjUHh6aYDlKLtj28uw=;
 b=Pgwb4jojNA0r8MfO5UqrEMyKsDNBYtwD/ifE3FUgDrhnTtm2pZAiC2cM492KsgtZHTCVVy
 lfPu2i+pTVkqxfeRBCW07tztsh4so06X25WwsWvOKQvkgUwefnWvzDcbRt7Ye3U/SHOZx6
 GecyaNP2XSpSH4lKN5S5wqqK5MWQWOM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-34-NCLuLMl1NSyichtBCsiqdA-1; Fri,
 10 Oct 2025 04:21:58 -0400
X-MC-Unique: NCLuLMl1NSyichtBCsiqdA-1
X-Mimecast-MFC-AGG-ID: NCLuLMl1NSyichtBCsiqdA_1760084517
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9EBEA1956096; Fri, 10 Oct 2025 08:21:57 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.34.98])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2837E180141D; Fri, 10 Oct 2025 08:21:55 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 4/9] target/s390x: Propagate CPUS390XState to
 cpu_unmap_lowcore()
Date: Fri, 10 Oct 2025 10:21:39 +0200
Message-ID: <20251010082145.576222-5-thuth@redhat.com>
In-Reply-To: <20251010082145.576222-1-thuth@redhat.com>
References: <20251010082145.576222-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

To be able to access the CPU state in cpu_unmap_lowcore()
in the next commit, propagate it as argument.
cpu_map_lowcore() already takes it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20251002091132.65703-6-philmd@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 target/s390x/s390x-internal.h  |  2 +-
 target/s390x/helper.c          |  4 ++--
 target/s390x/tcg/excp_helper.c | 10 +++++-----
 target/s390x/tcg/misc_helper.c |  4 ++--
 4 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/target/s390x/s390x-internal.h b/target/s390x/s390x-internal.h
index 56cce2e7f50..1fb752aa1d6 100644
--- a/target/s390x/s390x-internal.h
+++ b/target/s390x/s390x-internal.h
@@ -327,7 +327,7 @@ hwaddr s390_cpu_get_phys_addr_debug(CPUState *cpu, vaddr addr);
 int s390_store_status(S390CPU *cpu, hwaddr addr, bool store_arch);
 int s390_store_adtl_status(S390CPU *cpu, hwaddr addr, hwaddr len);
 LowCore *cpu_map_lowcore(CPUS390XState *env);
-void cpu_unmap_lowcore(LowCore *lowcore);
+void cpu_unmap_lowcore(CPUS390XState *env, LowCore *lowcore);
 #endif /* CONFIG_USER_ONLY */
 
 
diff --git a/target/s390x/helper.c b/target/s390x/helper.c
index 5c127da1a6a..a6d4a1ce05d 100644
--- a/target/s390x/helper.c
+++ b/target/s390x/helper.c
@@ -117,7 +117,7 @@ LowCore *cpu_map_lowcore(CPUS390XState *env)
     return lowcore;
 }
 
-void cpu_unmap_lowcore(LowCore *lowcore)
+void cpu_unmap_lowcore(CPUS390XState *env, LowCore *lowcore)
 {
     cpu_physical_memory_unmap(lowcore, sizeof(LowCore), 1, sizeof(LowCore));
 }
@@ -134,7 +134,7 @@ void do_restart_interrupt(CPUS390XState *env)
     mask = be64_to_cpu(lowcore->restart_new_psw.mask);
     addr = be64_to_cpu(lowcore->restart_new_psw.addr);
 
-    cpu_unmap_lowcore(lowcore);
+    cpu_unmap_lowcore(env, lowcore);
     env->pending_int &= ~INTERRUPT_RESTART;
 
     s390_cpu_set_psw(env, mask, addr);
diff --git a/target/s390x/tcg/excp_helper.c b/target/s390x/tcg/excp_helper.c
index 5e1d4dc9583..0ae4e266065 100644
--- a/target/s390x/tcg/excp_helper.c
+++ b/target/s390x/tcg/excp_helper.c
@@ -285,7 +285,7 @@ static void do_program_interrupt(CPUS390XState *env)
     addr = be64_to_cpu(lowcore->program_new_psw.addr);
     lowcore->per_breaking_event_addr = cpu_to_be64(env->gbea);
 
-    cpu_unmap_lowcore(lowcore);
+    cpu_unmap_lowcore(env, lowcore);
 
     s390_cpu_set_psw(env, mask, addr);
 }
@@ -304,7 +304,7 @@ static void do_svc_interrupt(CPUS390XState *env)
     mask = be64_to_cpu(lowcore->svc_new_psw.mask);
     addr = be64_to_cpu(lowcore->svc_new_psw.addr);
 
-    cpu_unmap_lowcore(lowcore);
+    cpu_unmap_lowcore(env, lowcore);
 
     s390_cpu_set_psw(env, mask, addr);
 
@@ -378,7 +378,7 @@ static void do_ext_interrupt(CPUS390XState *env)
     lowcore->external_old_psw.mask = cpu_to_be64(s390_cpu_get_psw_mask(env));
     lowcore->external_old_psw.addr = cpu_to_be64(env->psw.addr);
 
-    cpu_unmap_lowcore(lowcore);
+    cpu_unmap_lowcore(env, lowcore);
 
     s390_cpu_set_psw(env, mask, addr);
 }
@@ -405,7 +405,7 @@ static void do_io_interrupt(CPUS390XState *env)
     mask = be64_to_cpu(lowcore->io_new_psw.mask);
     addr = be64_to_cpu(lowcore->io_new_psw.addr);
 
-    cpu_unmap_lowcore(lowcore);
+    cpu_unmap_lowcore(env, lowcore);
     g_free(io);
 
     s390_cpu_set_psw(env, mask, addr);
@@ -491,7 +491,7 @@ static void do_mchk_interrupt(CPUS390XState *env)
     mask = be64_to_cpu(lowcore->mcck_new_psw.mask);
     addr = be64_to_cpu(lowcore->mcck_new_psw.addr);
 
-    cpu_unmap_lowcore(lowcore);
+    cpu_unmap_lowcore(env, lowcore);
 
     s390_cpu_set_psw(env, mask, addr);
 }
diff --git a/target/s390x/tcg/misc_helper.c b/target/s390x/tcg/misc_helper.c
index f7101be5745..6d9d601d29a 100644
--- a/target/s390x/tcg/misc_helper.c
+++ b/target/s390x/tcg/misc_helper.c
@@ -570,7 +570,7 @@ uint32_t HELPER(tpi)(CPUS390XState *env, uint64_t addr)
         lowcore->subchannel_nr = cpu_to_be16(io->nr);
         lowcore->io_int_parm = cpu_to_be32(io->parm);
         lowcore->io_int_word = cpu_to_be32(io->word);
-        cpu_unmap_lowcore(lowcore);
+        cpu_unmap_lowcore(env, lowcore);
     }
 
     g_free(io);
@@ -700,7 +700,7 @@ void HELPER(stfl)(CPUS390XState *env)
     lowcore = cpu_map_lowcore(env);
     prepare_stfl();
     memcpy(&lowcore->stfl_fac_list, stfl_bytes, sizeof(lowcore->stfl_fac_list));
-    cpu_unmap_lowcore(lowcore);
+    cpu_unmap_lowcore(env, lowcore);
 }
 #endif
 
-- 
2.51.0


