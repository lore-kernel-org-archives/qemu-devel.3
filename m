Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5749D13592
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2024 02:52:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5Fql-0006Ed-0I; Sun, 27 Oct 2024 22:51:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tao1.su@linux.intel.com>)
 id 1t5Fqi-0006ED-UF
 for qemu-devel@nongnu.org; Sun, 27 Oct 2024 22:51:20 -0400
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tao1.su@linux.intel.com>)
 id 1t5Fqh-0003XK-4d
 for qemu-devel@nongnu.org; Sun, 27 Oct 2024 22:51:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730083879; x=1761619879;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=rp03Uwl7l03pPj4HY9BuMvQ1YdrKKOFrRjevx8nf8/s=;
 b=HSAhEO+GuaVj9ZnhvsfZ+IHp1svEmJTimWDYUQPfWcTIZOZmEqAgYzyZ
 X3TwMwM89RlkJlrAUhLr8x6t+Ox6hkmR80FXlxFUgE7Avyj/O6XetomnH
 TVHjgsyr1qNFSmAW0VR9HkbO83EBz2BEvL77pxQOEaF5fDuxZQb6P02/S
 0fX1wPjVQafH5ok0DZRLuZyozRPpZAJ5PzuLro57IfT8Q418dgM0fdwLQ
 8TKIWxUdwxHilc4RWU/85pRTo8O144/Bkiz0ftI4RVe87hCAaSzk1iGnQ
 m14FUFt1QAYTlhAY+TdmOjfDL+0O+4l77R8TsuNKPOm0caGsQCbl+cMkf Q==;
X-CSE-ConnectionGUID: QaHNSbK2RnGcNdJgxsET4w==
X-CSE-MsgGUID: 1TrsxcjtTmCVFlwi6ENLqQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11238"; a="40249478"
X-IronPort-AV: E=Sophos;i="6.11,238,1725346800"; d="scan'208";a="40249478"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2024 19:51:05 -0700
X-CSE-ConnectionGUID: DDpFGIdcT9ujjbRSzhG3Cg==
X-CSE-MsgGUID: zTjI3JZVQmeColUNzejurA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,238,1725346800"; d="scan'208";a="81420959"
Received: from st-server.bj.intel.com ([10.240.193.102])
 by orviesa009.jf.intel.com with ESMTP; 27 Oct 2024 19:51:02 -0700
From: Tao Su <tao1.su@linux.intel.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mtosatti@redhat.com, xiaoyao.li@intel.com,
 xuelian.guo@intel.com, tao1.su@linux.intel.com
Subject: [PATCH 6/6] target/i386: Introduce GraniteRapids-v2 model
Date: Mon, 28 Oct 2024 10:45:12 +0800
Message-Id: <20241028024512.156724-7-tao1.su@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241028024512.156724-1-tao1.su@linux.intel.com>
References: <20241028024512.156724-1-tao1.su@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=192.198.163.11;
 envelope-from=tao1.su@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.287,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Update GraniteRapids CPU model to add AVX10 and the missing features(ss,
tsc-adjust, cldemote, movdiri, movdir64b).

Tested-by: Xuelian Guo <xuelian.guo@intel.com>
Signed-off-by: Tao Su <tao1.su@linux.intel.com>
---
 target/i386/cpu.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index adde98fd26..8d72c08b66 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -4375,6 +4375,23 @@ static const X86CPUDefinition builtin_x86_defs[] = {
         .model_id = "Intel Xeon Processor (GraniteRapids)",
         .versions = (X86CPUVersionDefinition[]) {
             { .version = 1 },
+            {
+                .version = 2,
+                .props = (PropValue[]) {
+                    { "ss", "on" },
+                    { "tsc-adjust", "on" },
+                    { "cldemote", "on" },
+                    { "movdiri", "on" },
+                    { "movdir64b", "on" },
+                    { "avx10", "on" },
+                    { "avx10-128", "on" },
+                    { "avx10-256", "on" },
+                    { "avx10-512", "on" },
+                    { "avx10-version", "1" },
+                    { "stepping", "1" },
+                    { /* end of list */ }
+                }
+            },
             { /* end of list */ },
         },
     },
-- 
2.34.1


