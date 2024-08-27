Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0118EC54734
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 13:59:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1siwii-0002LR-Az; Tue, 27 Aug 2024 09:58:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=96280ffda=graf@amazon.de>)
 id 1siwig-0002K5-8J
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 09:58:50 -0400
Received: from smtp-fw-52002.amazon.com ([52.119.213.150])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=96280ffda=graf@amazon.de>)
 id 1siwic-00016O-Ft
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 09:58:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
 t=1724767127; x=1756303127;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=z9zEe+lkht9BZdyVELoJNX/vYOdHMaJZK/VIuYMnNHw=;
 b=R5rB3Ij27rSZJp0qopBoGopJhQX6G4DvQtjiyv6mpfWs5B7cTEMdUuJI
 mYB/aeUJpydGwAQ3seobx6GSU+YgQ8oSuc58eefjb/20wvyBlxZ+2J6kr
 triz2Yw74LBZnQ4EYE6wptL657w9EV8Hm9lU73pyRe8GYjhODiJ1kEPKt M=;
X-IronPort-AV: E=Sophos;i="6.10,180,1719878400"; d="scan'208";a="655100756"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO
 smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
 by smtp-border-fw-52002.iad7.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 13:58:41 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.38.20:28053]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.7.79:2525] with
 esmtp (Farcaster)
 id 7edc41dc-ea79-4b8b-be21-f639f516052c; Tue, 27 Aug 2024 13:58:40 +0000 (UTC)
X-Farcaster-Flow-ID: 7edc41dc-ea79-4b8b-be21-f639f516052c
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 27 Aug 2024 13:58:40 +0000
Received: from dev-dsk-graf-1a-5ce218e4.eu-west-1.amazon.com (10.253.83.51) by
 EX19D020UWC004.ant.amazon.com (10.13.138.149) with Microsoft SMTP
 Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 27 Aug 2024 13:58:39 +0000
From: Alexander Graf <graf@amazon.com>
To: <qemu-devel@nongnu.org>
CC: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Eduardo Habkost <eduardo@habkost.net>, "Jan
 Kiszka" <jan.kiszka@siemens.com>, Eduard Vlad <evlad@amazon.de>
Subject: [PATCH] target-i386: Walk NPT in guest real mode
Date: Tue, 27 Aug 2024 13:58:37 +0000
Message-ID: <20240827135837.67077-1-graf@amazon.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-Originating-IP: [10.253.83.51]
X-ClientProxiedBy: EX19D038UWB002.ant.amazon.com (10.13.139.185) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=52.119.213.150;
 envelope-from=prvs=96280ffda=graf@amazon.de; helo=smtp-fw-52002.amazon.com
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

When translating virtual to physical address with a guest CPU that
supports nested paging (NPT), we need to perform every page table walk
access indirectly through the NPT, which we correctly do.

However, we treat real mode (no page table walk) special: In that case,
we currently just skip any walks and translate VA -> PA. With NPT
enabled, we also need to then perform NPT walk to do GVA -> GPA -> HPA
which we fail to do so far.

The net result of that is that TCG VMs with NPT enabled that execute
real mode code (like SeaBIOS) end up with GPA==HPA mappings which means
the guest accesses host code and data. This typically shows as failure
to boot guests.

This patch changes the page walk logic for NPT enabled guests so that we
always perform a GVA -> GPA translation, but simply provide a 1 GiB fake
PTE when in real mode. That way, all remaining logic to walk the NPT
stays and we successfully walk the NPT in real mode.

Fixes: fe441054bb3f0 ("target-i386: Add NPT support")

Signed-off-by: Alexander Graf <graf@amazon.com>
Reported-by: Eduard Vlad <evlad@amazon.de>
---
 target/i386/tcg/sysemu/excp_helper.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/target/i386/tcg/sysemu/excp_helper.c b/target/i386/tcg/sysemu/excp_helper.c
index 8fb05b1f53..17f45431f6 100644
--- a/target/i386/tcg/sysemu/excp_helper.c
+++ b/target/i386/tcg/sysemu/excp_helper.c
@@ -298,7 +298,7 @@ static bool mmu_translate(CPUX86State *env, const TranslateParams *in,
         /* combine pde and pte nx, user and rw protections */
         ptep &= pte ^ PG_NX_MASK;
         page_size = 4096;
-    } else {
+    } else if (pg_mode) {
         /*
          * Page table level 2
          */
@@ -343,6 +343,12 @@ static bool mmu_translate(CPUX86State *env, const TranslateParams *in,
         ptep &= pte | PG_NX_MASK;
         page_size = 4096;
         rsvd_mask = 0;
+    } else {
+        /* No paging (real mode), let's assemble a fake 1:1 1GiB PTE */
+        page_size = 0x40000000;
+        pte = (in->addr & ~(page_size - 1)) | PG_DIRTY_MASK | PG_ACCESSED_MASK;
+        ptep = PG_NX_MASK | PG_USER_MASK | PG_RW_MASK;
+        rsvd_mask = 0;
     }
 
 do_check_protect:
@@ -562,7 +568,7 @@ static bool get_physical_address(CPUX86State *env, vaddr addr,
             addr = (uint32_t)addr;
         }
 
-        if (likely(env->cr[0] & CR0_PG_MASK)) {
+        if (likely(env->cr[0] & CR0_PG_MASK || use_stage2)) {
             in.cr3 = env->cr[3];
             in.mmu_idx = mmu_idx;
             in.ptw_idx = use_stage2 ? MMU_NESTED_IDX : MMU_PHYS_IDX;
-- 
2.40.1




Amazon Web Services Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


