Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4937EC43458
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 07:45:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whMxO-0008EV-M3; Wed, 08 Jul 2026 03:44:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1whMxJ-0007YB-MQ; Wed, 08 Jul 2026 03:44:29 -0400
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1whMxH-0005DU-Sw; Wed, 08 Jul 2026 03:44:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783496668; x=1815032668;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=MkhJUpvaQIjzCksDxyxoEb9n4G0BNU21kIB5iLpLljs=;
 b=GhKxEdmzCkeUyAxQn1/XzVw6vJk2BxCV1OSHOKxPKHo9ablXg5E00N0L
 2p9uhK+fd7lbXT1ogPbpf/Z0B3mhe/+KDlsmj0Y2m8YKuIcyQh+MmrjFT
 YCoLwKdPny1yrj2yuUbx0HoLQeJIL7r+ZcnW4n1DJkgFIRxKBG+meZKiU
 KOlGwnozMPiW0d/vTUWKt2TtZhiVmotNCGl9sSF5F6CvgHBTVsX3Tdwve
 Zjc2CLiiWF+ikSTbhct7L3//8EHGE48Z0lCei5mBZvRewwT/wq/f0KZsm
 7pKaq/1OK9mRZtU/VU75pbz/0rvzwOrsakr8IHKqa033O91aoWPAfiG5M g==;
X-CSE-ConnectionGUID: KEg2QusLTAeobQ4LSp+v6w==
X-CSE-MsgGUID: Sm98e2b/SH6ZV5BiTAYyIw==
X-IronPort-AV: E=McAfee;i="6800,10657,11840"; a="84343469"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; d="scan'208";a="84343469"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jul 2026 00:44:08 -0700
X-CSE-ConnectionGUID: kytbo46NSveqa3GxmA3BhQ==
X-CSE-MsgGUID: i3TulGU2Q9iV1rZbQhhI9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; d="scan'208";a="251556113"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa008.fm.intel.com with ESMTP; 08 Jul 2026 00:44:03 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org,
 Junjie Mao <junjie.mao@hotmail.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>,
 Chuanxiao Dong <chuanxiao.dong@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [RFC v2 25/26] hw/timer/hpet: Add HPET_TN_BASE macro
Date: Wed,  8 Jul 2026 16:10:51 +0800
Message-Id: <20260708081052.2276617-26-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260708081052.2276617-1-zhao1.liu@intel.com>
References: <20260708081052.2276617-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.16; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Use the HPET_TN_BASE macro instead of a hardcoded value to support
next HPET test case.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
Changes since v1:
 * New commit.
---
 hw/timer/hpet.c         | 8 ++++----
 include/hw/timer/hpet.h | 1 +
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/hw/timer/hpet.c b/hw/timer/hpet.c
index 42285cff762b..84405e7cb4cb 100644
--- a/hw/timer/hpet.c
+++ b/hw/timer/hpet.c
@@ -450,7 +450,7 @@ static uint64_t hpet_ram_read(void *opaque, hwaddr addr,
 
     QEMU_LOCK_GUARD(&s->lock);
     /*address range of all global regs*/
-    if (addr <= 0xff) {
+    if (addr < HPET_TN_BASE) {
         switch (addr) {
         case HPET_ID: // including HPET_PERIOD
             return s->capability >> shift;
@@ -463,7 +463,7 @@ static uint64_t hpet_ram_read(void *opaque, hwaddr addr,
             break;
         }
     } else {
-        uint8_t timer_id = (addr - 0x100) / 0x20;
+        uint8_t timer_id = (addr - HPET_TN_BASE) / 0x20;
         HPETTimer *timer;
 
         if (timer_id >= s->num_timers) {
@@ -501,7 +501,7 @@ static void hpet_ram_write(void *opaque, hwaddr addr,
     addr &= ~4;
 
     /*address range of all global regs*/
-    if (addr <= 0xff) {
+    if (addr < HPET_TN_BASE) {
         switch (addr) {
         case HPET_ID:
             return;
@@ -564,7 +564,7 @@ static void hpet_ram_write(void *opaque, hwaddr addr,
             break;
         }
     } else {
-        uint8_t timer_id = (addr - 0x100) / 0x20;
+        uint8_t timer_id = (addr - HPET_TN_BASE) / 0x20;
         HPETTimer *timer;
 
         trace_hpet_ram_write_timer_id(timer_id);
diff --git a/include/hw/timer/hpet.h b/include/hw/timer/hpet.h
index 84be4c3529a7..cc1e48706327 100644
--- a/include/hw/timer/hpet.h
+++ b/include/hw/timer/hpet.h
@@ -37,6 +37,7 @@
 #define HPET_CFG        0x010
 #define HPET_STATUS     0x020
 #define HPET_COUNTER    0x0f0
+#define HPET_TN_BASE    0x100
 #define HPET_TN_CFG     0x000
 #define HPET_TN_CMP     0x008
 #define HPET_TN_ROUTE   0x010
-- 
2.34.1


