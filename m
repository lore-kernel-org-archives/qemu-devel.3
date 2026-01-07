Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC848CD585E
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 12:12:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdSJr-0003wi-J2; Wed, 07 Jan 2026 07:07:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vdSJh-0003tr-4x
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 07:07:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vdSJd-0002A8-OF
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 07:07:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767787624;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aCB/BvVjHfqWu8sUtNUVfE+zdmRFKL8G5oYZq1JtvDQ=;
 b=BITINCNih4+NDeTDg7zPj+pFpv78FxtipDkkitxt0/gw0doptYQt/UST+is6V/RWaFp2ym
 xysqJTJC179ysAkLNyTm7lkODln1TMv453lYulAcT2BdLGz/hFqdE/R78cD1tAnVTeYzxt
 0b3E4aZSpm/b1oZ3qyAZ4mSGVDZz/XY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-619-bAiGhg3uNACmS912NfTtGg-1; Wed,
 07 Jan 2026 07:06:58 -0500
X-MC-Unique: bAiGhg3uNACmS912NfTtGg-1
X-Mimecast-MFC-AGG-ID: bAiGhg3uNACmS912NfTtGg_1767787617
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9B8E7195605B; Wed,  7 Jan 2026 12:06:57 +0000 (UTC)
Received: from thuth-p1g4.str.redhat.com (dhcp-192-176.str.redhat.com
 [10.33.192.176])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 459881956048; Wed,  7 Jan 2026 12:06:56 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Eric Farman <farman@linux.ibm.com>
Subject: [PULL 10/14] target/s390x: Inline cpu_ld{uw,
 l}_code() calls in EX opcode helper
Date: Wed,  7 Jan 2026 13:06:34 +0100
Message-ID: <20260107120638.56735-11-thuth@redhat.com>
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

In preparation of removing the cpu_lduw_code() and cpu_ldl_code()
wrappers, inline them.

Since S390x instructions are always stored in big-endian order,
replace MO_TE -> MO_BE.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20251224162036.90404-6-philmd@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 target/s390x/tcg/mem_helper.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/target/s390x/tcg/mem_helper.c b/target/s390x/tcg/mem_helper.c
index c29253fab56..b7b6f581901 100644
--- a/target/s390x/tcg/mem_helper.c
+++ b/target/s390x/tcg/mem_helper.c
@@ -2430,15 +2430,18 @@ uint64_t HELPER(lra)(CPUS390XState *env, uint64_t r1, uint64_t addr)
 */
 void HELPER(ex)(CPUS390XState *env, uint32_t ilen, uint64_t r1, uint64_t addr)
 {
+    CPUState *cs = env_cpu(env);
     uint64_t insn;
     uint8_t opc;
+    MemOpIdx oi;
 
     /* EXECUTE targets must be at even addresses.  */
     if (addr & 1) {
         tcg_s390_program_interrupt(env, PGM_SPECIFICATION, GETPC());
     }
 
-    insn = cpu_lduw_code(env, addr);
+    oi = make_memop_idx(MO_BEUW, cpu_mmu_index(cs, true));
+    insn = cpu_ldw_code_mmu(env, addr, oi, 0);
     opc = insn >> 8;
 
     /* Or in the contents of R1[56:63].  */
@@ -2450,10 +2453,11 @@ void HELPER(ex)(CPUS390XState *env, uint32_t ilen, uint64_t r1, uint64_t addr)
     case 2:
         break;
     case 4:
-        insn |= (uint64_t)cpu_lduw_code(env, addr + 2) << 32;
+        insn |= (uint64_t)cpu_ldw_code_mmu(env, addr + 2, oi, 0) << 32;
         break;
     case 6:
-        insn |= (uint64_t)(uint32_t)cpu_ldl_code(env, addr + 2) << 16;
+        oi = make_memop_idx(MO_BEUL, cpu_mmu_index(cs, true));
+        insn |= (uint64_t)(uint32_t)cpu_ldl_code_mmu(env, addr + 2, oi, 0) << 16;
         break;
     default:
         g_assert_not_reached();
-- 
2.52.0


