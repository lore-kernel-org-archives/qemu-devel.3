Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B20A5C8303C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 09:35:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaA9M-0000vw-1A; Fri, 11 Jul 2025 05:34:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uaA8k-0000il-6V
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 05:33:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uaA8h-00072q-5J
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 05:33:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752226434;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iuHxyNeV4qtD24IT0BCs6RPwKnUSyqymzBlSd5wXCIU=;
 b=WHIuHXZVhfHWl2Lnz52hI0ObYK0tfCKtOD0Kcri5AJ3uemUaNBZUUVGaRinwWM5QUN1hMa
 dA8eLki6wff8K+FFfDE97FWNoyfwKtmHR4ENQursW63ZSkEG1vzKlIrLWO52RCbKfhwfWF
 EQZUhyp59gLxjyMsClSlGLYaoHIng2Q=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-628-cFPyNKE_OVmYNtaXfgAyjQ-1; Fri,
 11 Jul 2025 05:33:50 -0400
X-MC-Unique: cFPyNKE_OVmYNtaXfgAyjQ-1
X-Mimecast-MFC-AGG-ID: cFPyNKE_OVmYNtaXfgAyjQ_1752226429
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4DEE418089B7; Fri, 11 Jul 2025 09:33:49 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.54])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 394B419560A3; Fri, 11 Jul 2025 09:33:46 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 02/15] target/s390x/tcg: Use vaddr in s390_probe_access()
Date: Fri, 11 Jul 2025 11:33:27 +0200
Message-ID: <20250711093340.608485-3-thuth@redhat.com>
In-Reply-To: <20250711093340.608485-1-thuth@redhat.com>
References: <20250711093340.608485-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Commit 70ebd9ce1cb ("s390x/tcg: Fault-safe memset") passed
vaddr type to access_prepare(), and commit b6c636f2cd6
("s390x/tcg: Fault-safe memmove") to do_access_get_byte(),
but declared S390Access::vaddr[1,2] as target_ulong.
Directly declare these as vaddr type, and have
s390_probe_access() use that type as argument.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250707171059.3064-3-philmd@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 target/s390x/tcg/mem_helper.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/s390x/tcg/mem_helper.c b/target/s390x/tcg/mem_helper.c
index a03609a1406..f1acb1618f7 100644
--- a/target/s390x/tcg/mem_helper.c
+++ b/target/s390x/tcg/mem_helper.c
@@ -126,8 +126,8 @@ static inline void cpu_stsize_data_ra(CPUS390XState *env, uint64_t addr,
 
 /* An access covers at most 4096 bytes and therefore at most two pages. */
 typedef struct S390Access {
-    target_ulong vaddr1;
-    target_ulong vaddr2;
+    vaddr vaddr1;
+    vaddr vaddr2;
     void *haddr1;
     void *haddr2;
     uint16_t size1;
@@ -148,7 +148,7 @@ typedef struct S390Access {
  * For !CONFIG_USER_ONLY, the TEC is stored stored to env->tlb_fill_tec.
  * For CONFIG_USER_ONLY, the faulting address is stored to env->__excp_addr.
  */
-static inline int s390_probe_access(CPUArchState *env, target_ulong addr,
+static inline int s390_probe_access(CPUArchState *env, vaddr addr,
                                     int size, MMUAccessType access_type,
                                     int mmu_idx, bool nonfault,
                                     void **phost, uintptr_t ra)
@@ -258,7 +258,7 @@ static void access_memset(CPUS390XState *env, S390Access *desta,
 static uint8_t access_get_byte(CPUS390XState *env, S390Access *access,
                                int offset, uintptr_t ra)
 {
-    target_ulong vaddr = access->vaddr1;
+    vaddr vaddr = access->vaddr1;
     void *haddr = access->haddr1;
 
     if (unlikely(offset >= access->size1)) {
@@ -278,7 +278,7 @@ static uint8_t access_get_byte(CPUS390XState *env, S390Access *access,
 static void access_set_byte(CPUS390XState *env, S390Access *access,
                             int offset, uint8_t byte, uintptr_t ra)
 {
-    target_ulong vaddr = access->vaddr1;
+    vaddr vaddr = access->vaddr1;
     void *haddr = access->haddr1;
 
     if (unlikely(offset >= access->size1)) {
-- 
2.50.0


