Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9974BC3ABDD
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 15:12:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHOYX-0007ww-Je; Tue, 20 May 2025 11:07:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uHOYO-0007c4-AA; Tue, 20 May 2025 11:06:53 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uHOYM-0002y8-GK; Tue, 20 May 2025 11:06:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747753611; x=1779289611;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Mt5jKbsCQSp5uvoXWGR63XStLO+hUKDByG/gsMDB3KI=;
 b=PjQKLURn2zEkVi/gbDa1KS4oERA4BGni5cXHslh6B0JGf/PuvyZijriJ
 cjDjII1hKk50avlAAGhDV7kEBpfB+ekoVuUjMtz7XrmI1D3U7GFamVf+7
 4kfTE6wDNH2+N5MuBUiatWd9iFvHNUBp9of2GTcjzE87Cdbs7Fk/LeJ0/
 33I04njzrLS2kzg/TCZsToIvbjrFw5udqoysAX2RftzX1NVxz5NvEo28x
 t+sztxZX9hqlc9jbfaB1WIGwrTxdmFvuDvZMioc334QRa31WuZqNVQ1PS
 V7x5lpivh+OIOpVjEp7f2rLrJ/G0j9/IrRMesCV9n9I6BChCYSGg4Deef Q==;
X-CSE-ConnectionGUID: iV/cZjaWTEahtef3ZwSAiw==
X-CSE-MsgGUID: 8PZCsXP/SlmUD6M6e48qsw==
X-IronPort-AV: E=McAfee;i="6700,10204,11439"; a="59922475"
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; d="scan'208";a="59922475"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2025 08:06:48 -0700
X-CSE-ConnectionGUID: 4Ei2nWrPRN68Q280ZuH9+g==
X-CSE-MsgGUID: SW3bvSy7QHCtpYttXQAOPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; d="scan'208";a="144461860"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa003.jf.intel.com with ESMTP; 20 May 2025 08:06:46 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org,
 Dapeng Mi <dapeng1.mi@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 2/5] hw/timer/hpet: Adjust num_timers in hpet_init()
Date: Tue, 20 May 2025 23:27:47 +0800
Message-Id: <20250520152750.2542612-3-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250520152750.2542612-1-zhao1.liu@intel.com>
References: <20250520152750.2542612-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.11; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.487,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Currently, HPET adjusts num_timers in hpet_realize(), and doesn't change
it in any other place. And this field is initialized as a property.

Therefore, it's possible to move such adjustments to hept_init(), so
that Rust side can synchronize this change.

Adjust num_timers in hpet_init().

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 hw/timer/hpet.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/hw/timer/hpet.c b/hw/timer/hpet.c
index 0fd1337a1564..48b1a9289f83 100644
--- a/hw/timer/hpet.c
+++ b/hw/timer/hpet.c
@@ -682,6 +682,12 @@ static void hpet_init(Object *obj)
     /* HPET Area */
     memory_region_init_io(&s->iomem, obj, &hpet_ram_ops, s, "hpet", HPET_LEN);
     sysbus_init_mmio(sbd, &s->iomem);
+
+    if (s->num_timers < HPET_MIN_TIMERS) {
+        s->num_timers = HPET_MIN_TIMERS;
+    } else if (s->num_timers > HPET_MAX_TIMERS) {
+        s->num_timers = HPET_MAX_TIMERS;
+    }
 }
 
 static void hpet_realize(DeviceState *dev, Error **errp)
@@ -710,11 +716,6 @@ static void hpet_realize(DeviceState *dev, Error **errp)
         sysbus_init_irq(sbd, &s->irqs[i]);
     }
 
-    if (s->num_timers < HPET_MIN_TIMERS) {
-        s->num_timers = HPET_MIN_TIMERS;
-    } else if (s->num_timers > HPET_MAX_TIMERS) {
-        s->num_timers = HPET_MAX_TIMERS;
-    }
     for (i = 0; i < HPET_MAX_TIMERS; i++) {
         timer = &s->timer[i];
         timer->qemu_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, hpet_timer, timer);
-- 
2.34.1


