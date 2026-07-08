Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB816C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 07:43:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whMvz-00045K-F7; Wed, 08 Jul 2026 03:43:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1whMvT-0003lF-Ga; Wed, 08 Jul 2026 03:42:35 -0400
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1whMvQ-0004RW-DN; Wed, 08 Jul 2026 03:42:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783496553; x=1815032553;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=BI6TOgdFhQ54fWSeUs+UOy7AvxWy1MB55cs1Y1rdGKI=;
 b=hsceRZZcbx69MKJJQPFH6JtQ0RNBzrh7czpc6lpqTIToqDiTCy7tI4U9
 rJbtUEFOM61OuiYofXcc41JlLB/vIVOeJoBoCWmubAJjhXdd8uvj/Sue0
 mzDTUvsYfhPFe8mCzAPzYspjWNSIfC/MqozFkwxm5Njddt0JlGi+95Fvx
 sBB+2Ccw2YEAAnqCbSDuihJQcmB80jnH6YyT3GN3i72hcDlm9VLyTwSY9
 nWXJcPI5S9d3UuX7XGM2mAKh8H/iRSkq4J/duaHAutDnTt1DhkZsXsH0e
 0UJD74uCsqXHuRAN78NeGUkmyDsmtcyYOgKaKoi2QeiJz6aVq069PJHqk g==;
X-CSE-ConnectionGUID: XnbpI5pQSE+e8YipVywfgw==
X-CSE-MsgGUID: azNXajVSRwO1MqGGDatfCw==
X-IronPort-AV: E=McAfee;i="6800,10657,11840"; a="84343183"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; d="scan'208";a="84343183"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jul 2026 00:42:29 -0700
X-CSE-ConnectionGUID: hTd4+yO7RW+6EzhJgLUkBg==
X-CSE-MsgGUID: 8GUVoGb2QeWSettsoaKp9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; d="scan'208";a="251555894"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa008.fm.intel.com with ESMTP; 08 Jul 2026 00:42:25 -0700
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
Subject: [RFC v2 01/26] rust/hpet: Fix the error caused by vm-memory
Date: Wed,  8 Jul 2026 16:10:27 +0800
Message-Id: <20260708081052.2276617-2-zhao1.liu@intel.com>
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

error[E0283]: type annotations needed
   --> hw/timer/hpet/src/device.rs:884:55
    |
884 |         self.num_timers == self.num_timers_save.get().into()
    |                         --                            ^^^^
    |                         |
    |                         type must be known at this point
    |
    = note: multiple `impl`s satisfying `usize: PartialEq<_>` found in the following crates: `core`, `vm_memory`:
            - impl PartialEq<vm_memory::endian::BeSize> for usize;
            - impl PartialEq<vm_memory::endian::LeSize> for usize;
            - impl<host> PartialEq for usize
              where the constant `host` has type `bool`;
help: try using a fully qualified path to specify the expected types
    |
884 |         self.num_timers == <u8 as Into<T>>::into(self.num_timers_save.get())
    |                            ++++++++++++++++++++++                          ~

For more information about this error, try `rustc --explain E0283`.
error: could not compile `hpet` (lib) due to 1 previous error

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
Changes since v1:
 * Use From instead of Into.
---
 rust/hw/timer/hpet/src/device.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/hw/timer/hpet/src/device.rs b/rust/hw/timer/hpet/src/device.rs
index ec0bca4496de..7c60cc0f10ab 100644
--- a/rust/hw/timer/hpet/src/device.rs
+++ b/rust/hw/timer/hpet/src/device.rs
@@ -959,7 +959,7 @@ fn is_offset_needed(&self) -> bool {
     }
 
     fn validate_num_timers(&self, _version_id: u8) -> bool {
-        self.num_timers == self.num_timers_save.get().into()
+        self.num_timers == usize::from(self.num_timers_save.get())
     }
 }
 
-- 
2.34.1


