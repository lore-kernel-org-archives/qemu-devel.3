Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E0B9C4829D
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 13:59:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYROJ-0003GT-RB; Fri, 09 Feb 2024 08:58:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruansy.fnst@fujitsu.com>)
 id 1rYPSh-0003F5-9f
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 06:54:31 -0500
Received: from esa11.hc1455-7.c3s2.iphmx.com ([207.54.90.137])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruansy.fnst@fujitsu.com>)
 id 1rYPSc-0001eL-Gh
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 06:54:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1707479664; x=1739015664;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=SKVS38o1Km3z4Luil8Xfaslo0HYVtFO34MsPNdZRqi8=;
 b=jw+DFOd83IqGLJbSffpfYDyQLvNIgCNbKcj+xUetEqluCbu8b1NePKAg
 vp+KM1rzSVcb95MijpLBbOIiZLkeS4e85OrNclfC83ZrW+VlSGvunOYpV
 o5CaUGeCDvIy0KIZNGWDEFmZyu+aQZFxJ3f50o9TWcIa2k5o+qMw3AEcl
 wDD2zqh1ApPe9RlPE1tWXIEip3oAZUd1JaN+4OcpMuew+IIzCdZdohLHn
 nMEBzMk/Ro/XXfvLcYVyYAYTERwQvmBis52Jo4kjJCPS8tvZy9a8kCIDt
 LhDOSwKA9pdIco3/2kf/9GTf/yJTF6SZId+GhuBjZ7+bLpUcSmu5VaJ/6 Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="128323594"
X-IronPort-AV: E=Sophos;i="6.05,256,1701097200"; d="scan'208";a="128323594"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
 by esa11.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2024 20:54:21 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com
 [192.168.87.59])
 by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 00D1914A255
 for <qemu-devel@nongnu.org>; Fri,  9 Feb 2024 20:54:20 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com
 [192.51.206.22])
 by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 2A2B61F73B
 for <qemu-devel@nongnu.org>; Fri,  9 Feb 2024 20:54:20 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id B56521EBDBD
 for <qemu-devel@nongnu.org>; Fri,  9 Feb 2024 20:54:19 +0900 (JST)
Received: from irides.g08.fujitsu.local (unknown [10.167.226.114])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 573551A00A1;
 Fri,  9 Feb 2024 19:54:19 +0800 (CST)
To: qemu-devel@nongnu.org,
	linux-cxl@vger.kernel.org
Cc: Jonathan.Cameron@huawei.com,
	dan.j.williams@intel.com
Subject: [RFC PATCH 3/5] cxl/core: introduce cxl_mem_report_poison()
Date: Fri,  9 Feb 2024 19:54:15 +0800
Message-Id: <20240209115417.724638-6-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240209115417.724638-1-ruansy.fnst@fujitsu.com>
References: <20240209115417.724638-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28180.007
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28180.007
X-TMASE-Result: 10--10.314200-10.000000
X-TMASE-MatchedRID: iRE9Ev702i8M5CG8CYBPxRhvfWx0TE/bpUdkPtBbnm48DTfVRLTQzC/6
 oQ/dDcvKjFsElAmG+V4AFpgHFBD8OTalR2nLpNunvVD3+zz/FW/0swHSFcVJ6DoUdFbHYUawvwU
 evDt+uW5/XjpbSJS7a1Tdr6jAw79qMzwe5s18okMe4SzTjxRVolgy2ozNthE2S1jK4vkKprEEk8
 U+JlahFNbw3DIpBm/jzHj1xOR70ZBNBEVz6twCz54CIKY/Hg3AGdQnQSTrKGPEQdG7H66TyH4gK
 q42LRYk15qh5+XAYnW7HdUyxQzt8SsIfslr3ZFShfFE3dU460d+3BndfXUhXQ==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
Received-SPF: pass client-ip=207.54.90.137;
 envelope-from=ruansy.fnst@fujitsu.com; helo=esa11.hc1455-7.c3s2.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 09 Feb 2024 08:57:58 -0500
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
Reply-to:  Shiyang Ruan <ruansy.fnst@fujitsu.com>
From:  Shiyang Ruan via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

If poison is detected(reported from cxl memdev), OS should be notified to
handle it.  Introduce this function:
  1. translate DPA to HPA;
  2. construct a MCE instance; (TODO: more details need to be filled)
  3. log it into MCE event queue;

After that, MCE mechanism can walk over its notifier chain to execute
specific handlers.

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
---
 arch/x86/kernel/cpu/mce/core.c |  1 +
 drivers/cxl/core/mbox.c        | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index bc39252bc54f..a64c0aceb7e0 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -131,6 +131,7 @@ void mce_setup(struct mce *m)
 	m->ppin = cpu_data(m->extcpu).ppin;
 	m->microcode = boot_cpu_data.microcode;
 }
+EXPORT_SYMBOL_GPL(mce_setup);
 
 DEFINE_PER_CPU(struct mce, injectm);
 EXPORT_PER_CPU_SYMBOL_GPL(injectm);
diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 27166a411705..f9b6f50fbe80 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -4,6 +4,7 @@
 #include <linux/debugfs.h>
 #include <linux/ktime.h>
 #include <linux/mutex.h>
+#include <asm/mce.h>
 #include <asm/unaligned.h>
 #include <cxlpci.h>
 #include <cxlmem.h>
@@ -1290,6 +1291,38 @@ int cxl_set_timestamp(struct cxl_memdev_state *mds)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_set_timestamp, CXL);
 
+static void cxl_mem_report_poison(struct cxl_memdev *cxlmd,
+				  struct cxl_poison_record *poison)
+{
+	struct mce m;
+	u64 dpa = le64_to_cpu(poison->address) & CXL_POISON_START_MASK;
+	u64 len = le64_to_cpu(poison->length), i;
+	phys_addr_t phys_addr = cxl_memdev_dpa_to_hpa(cxlmd, dpa);
+
+	if (phys_addr)
+		return;
+
+	/*
+	 * Initialize struct mce.  Call preempt_disable() to avoid
+	 * "BUG: using smp_processor_id() in preemptible" for now, not sure
+	 * if this is a correct way.
+	 */
+	preempt_disable();
+	mce_setup(&m);
+	preempt_enable();
+
+	m.bank = -1;
+	/* Fake a memory read error with unknown channel */
+	m.status = MCI_STATUS_VAL | MCI_STATUS_EN | MCI_STATUS_ADDRV |
+		   MCI_STATUS_MISCV | 0x9f;
+	m.misc = (MCI_MISC_ADDR_PHYS << 6);
+
+	for (i = 0; i < len; i++) {
+		m.addr = phys_addr++;
+		mce_log(&m);
+	}
+}
+
 int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
 		       struct cxl_region *cxlr)
 {
-- 
2.34.1


