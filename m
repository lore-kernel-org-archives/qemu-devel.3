Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82119C43602
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 07:43:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whMw9-0004QL-45; Wed, 08 Jul 2026 03:43:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1whMvs-00040s-RF; Wed, 08 Jul 2026 03:43:02 -0400
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1whMvq-0004ox-KP; Wed, 08 Jul 2026 03:43:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783496579; x=1815032579;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=odjHL0x+MROapiVixt+s6VKPVF1LIdg6RNrAA9VuKTM=;
 b=gx3eoM/LFOFQtnyGx80XuSf3werD9FCQxb5+TLL8D0dlCyBPaJP74kJG
 k4AJBzMnSdJLw2i6NasDteblT5w0Hw2rf2HHkWurBf4HosPj2BJeTXCW2
 UyQCkrjtxRyaiLO625mmVmiXM7duDx/BblvU3TLz5iL7hGYaQAwehlc4D
 CdmYvIvPNccDeHHWOgIGwbdx5zvNeq6+a/2LWhtky3bhLSRWns2BgG1rR
 rSZBYZnG5v7c83hcIUD8y/KHCz4l3eo0vtoTIRh5fFrb5/08cdxVcTo/P
 VM/Wq642/qsC0Wwq6XL3p2klkKyIBG/yoXxbJaYr/K8LmTMNJkSsitQyM Q==;
X-CSE-ConnectionGUID: G6C/Rkw/TI2CokyQHXhwlQ==
X-CSE-MsgGUID: yKH5+q73SUyE/Q/DvMz8OA==
X-IronPort-AV: E=McAfee;i="6800,10657,11840"; a="84343267"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; d="scan'208";a="84343267"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jul 2026 00:42:57 -0700
X-CSE-ConnectionGUID: 8UbpCixwTdGX59kZCt78/A==
X-CSE-MsgGUID: kunUydETR2mcJBOEcpot7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; d="scan'208";a="251555948"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa008.fm.intel.com with ESMTP; 08 Jul 2026 00:42:53 -0700
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
Subject: [RFC v2 08/26] rust/bindings/util-sys: Include rcu.h in bindings
 wrapper
Date: Wed,  8 Jul 2026 16:10:34 +0800
Message-Id: <20260708081052.2276617-9-zhao1.liu@intel.com>
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

rcu.h is transitively included by several crates'
wrapper.h files (e.g. hwcore via hw/core/qdev.h, system via
system/memory.h).

Because several structs (e.g. BusChild/FlatView/AddressSpace) embed
struct rcu_head, bindgen automatically generates a rcu_head definition
in each crate that references it.

Explicitly add rcu.h to util-sys/wrapper.h.  With the allowlist-then-
blocklist logic in generate_bindgen_args.py, this makes util-sys the
only owner of rcu.h bindings. Then rcu.h is blocked in hwcore-sys and
system-sys, thus it's necessary to import rcu_head from util_sys in
hwcore-sys/lib.rs and system-sys/lib.rs.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
Changes since v1:
 * New commit.
---
 rust/bindings/hwcore-sys/lib.rs  | 2 +-
 rust/bindings/system-sys/lib.rs  | 2 +-
 rust/bindings/util-sys/wrapper.h | 1 +
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/rust/bindings/hwcore-sys/lib.rs b/rust/bindings/hwcore-sys/lib.rs
index 8cef4a796193..9414c6639e2a 100644
--- a/rust/bindings/hwcore-sys/lib.rs
+++ b/rust/bindings/hwcore-sys/lib.rs
@@ -26,7 +26,7 @@
     InterfaceClass, Object, ObjectClass, ObjectProperty, ObjectPropertyAccessor,
     ObjectPropertyRelease,
 };
-use util_sys::{Error, QDict, QList};
+use util_sys::{rcu_head, Error, QDict, QList};
 
 #[cfg(MESON)]
 include!("bindings.inc.rs");
diff --git a/rust/bindings/system-sys/lib.rs b/rust/bindings/system-sys/lib.rs
index 30adf683c355..8feaa76ca165 100644
--- a/rust/bindings/system-sys/lib.rs
+++ b/rust/bindings/system-sys/lib.rs
@@ -21,7 +21,7 @@
 use common::Zeroable;
 use hwcore_sys::{qemu_irq, DeviceClass, DeviceState};
 use qom_sys::{Object, ObjectClass};
-use util_sys::{Error, EventNotifier, QEMUBH};
+use util_sys::{rcu_head, Error, EventNotifier, QEMUBH};
 
 #[cfg(MESON)]
 include!("bindings.inc.rs");
diff --git a/rust/bindings/util-sys/wrapper.h b/rust/bindings/util-sys/wrapper.h
index e9c433e7dc14..5d3cf7792b92 100644
--- a/rust/bindings/util-sys/wrapper.h
+++ b/rust/bindings/util-sys/wrapper.h
@@ -27,6 +27,7 @@ typedef struct Visitor Visitor;
 #include "qemu/module.h"
 #include "qemu/option.h"
 #include "qemu/timer.h"
+#include "qemu/rcu.h"
 #include "qapi/visitor.h"
 #include "qobject/qbool.h"
 #include "qobject/qdict.h"
-- 
2.34.1


