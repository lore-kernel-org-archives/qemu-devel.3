Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46555D59F41
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 15:44:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8iC8-0007BX-6m; Wed, 06 Nov 2024 10:43:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=033153df9=graf@amazon.de>)
 id 1t8iC6-0007At-7r; Wed, 06 Nov 2024 10:43:42 -0500
Received: from smtp-fw-9102.amazon.com ([207.171.184.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=033153df9=graf@amazon.de>)
 id 1t8iC4-0005Qk-4e; Wed, 06 Nov 2024 10:43:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
 t=1730907820; x=1762443820;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=TdA+lWyPL3HpqI6a6iym7ggnODIDoGehybZ4ZPNcoVY=;
 b=TSy3QJ3qjzSO93UNzjk8McoSukv4Bq0mBZJawpKUFs3x5S/Mbd0DyC4C
 01sRTDKcqixwibMTeYv1AKzv9TYO5oNb+oBVeGPZTyRwZtyyB+mXChSsi
 eYVrX9+c2qn0ckcBi1B//A1nypl8KLOyn5oIrogFBzruwX35XoCAxnxIK Y=;
X-IronPort-AV: E=Sophos;i="6.11,263,1725321600"; d="scan'208";a="467647670"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO
 smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
 by smtp-border-fw-9102.sea19.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2024 15:43:33 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.7.35:2030]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.6.147:2525]
 with esmtp (Farcaster)
 id e8e0f48e-2ad1-4387-8ba5-608092a2fa09; Wed, 6 Nov 2024 15:43:32 +0000 (UTC)
X-Farcaster-Flow-ID: e8e0f48e-2ad1-4387-8ba5-608092a2fa09
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 6 Nov 2024 15:43:32 +0000
Received: from dev-dsk-graf-1a-5ce218e4.eu-west-1.amazon.com (10.253.83.51) by
 EX19D020UWC004.ant.amazon.com (10.13.138.149) with Microsoft SMTP
 Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 6 Nov 2024 15:43:30 +0000
From: Alexander Graf <graf@amazon.com>
To: <qemu-devel@nongnu.org>
CC: Eduardo Habkost <eduardo@habkost.net>, Richard Henderson
 <richard.henderson@linaro.org>, Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini
 <pbonzini@redhat.com>, <qemu-stable@nongnu.org>, Mark Cave-Ayland
 <mark.cave-ayland@ilande.co.uk>
Subject: [PATCH] target/i386: Fix legacy page table walk
Date: Wed, 6 Nov 2024 15:43:29 +0000
Message-ID: <20241106154329.67218-1-graf@amazon.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-Originating-IP: [10.253.83.51]
X-ClientProxiedBy: EX19D031UWA002.ant.amazon.com (10.13.139.96) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.171.184.29;
 envelope-from=prvs=033153df9=graf@amazon.de; helo=smtp-fw-9102.amazon.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Commit b56617bbcb4 ("target/i386: Walk NPT in guest real mode") added
logic to run the page table walker even in real mode if we are in NPT
mode.  That function then determined whether real mode or paging is
active based on whether the pg_mode variable was 0.

Unfortunately pg_mode is 0 in two situations:

  1) Paging is disabled (real mode)
  2) Paging is in 2-level paging mode (32bit without PAE)

That means the walker now assumed that 2-level paging mode was real
mode, breaking NetBSD as well as Windows XP.

To fix that, this patch adds a new PG flag to pg_mode which indicates
whether paging is active at all and uses that to determine whether we
are in real mode or not.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2654
Fixes: b56617bbcb4 ("target/i386: Walk NPT in guest real mode")
Signed-off-by: Alexander Graf <graf@amazon.com>
Reported-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 target/i386/cpu.h                    | 1 +
 target/i386/tcg/seg_helper.c         | 2 +-
 target/i386/tcg/sysemu/excp_helper.c | 2 +-
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index c24d81bf31..99d4805ac1 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -346,6 +346,7 @@ typedef enum X86Seg {
 #define PG_MODE_PKE      (1 << 17)
 #define PG_MODE_PKS      (1 << 18)
 #define PG_MODE_SMEP     (1 << 19)
+#define PG_MODE_PG       (1 << 20)
 
 #define MCG_CTL_P       (1ULL<<8)   /* MCG_CAP register available */
 #define MCG_SER_P       (1ULL<<24) /* MCA recovery/new status bits */
diff --git a/target/i386/tcg/seg_helper.c b/target/i386/tcg/seg_helper.c
index 02ae6a0d1f..71962113fb 100644
--- a/target/i386/tcg/seg_helper.c
+++ b/target/i386/tcg/seg_helper.c
@@ -94,7 +94,7 @@ static uint32_t popl(StackAccess *sa)
 
 int get_pg_mode(CPUX86State *env)
 {
-    int pg_mode = 0;
+    int pg_mode = PG_MODE_PG;
     if (!(env->cr[0] & CR0_PG_MASK)) {
         return 0;
     }
diff --git a/target/i386/tcg/sysemu/excp_helper.c b/target/i386/tcg/sysemu/excp_helper.c
index da187c8792..02d3486421 100644
--- a/target/i386/tcg/sysemu/excp_helper.c
+++ b/target/i386/tcg/sysemu/excp_helper.c
@@ -298,7 +298,7 @@ static bool mmu_translate(CPUX86State *env, const TranslateParams *in,
         /* combine pde and pte nx, user and rw protections */
         ptep &= pte ^ PG_NX_MASK;
         page_size = 4096;
-    } else if (pg_mode) {
+    } else if (pg_mode & PG_MODE_PG) {
         /*
          * Page table level 2
          */
-- 
2.40.1




Amazon Web Services Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


