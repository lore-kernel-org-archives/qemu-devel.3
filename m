Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C749DC87FCA
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Aug 2025 12:10:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujzQs-0007XM-Ky; Thu, 07 Aug 2025 08:09:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1ujzQm-0007RM-Js; Thu, 07 Aug 2025 08:09:12 -0400
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1ujzQi-000545-PT; Thu, 07 Aug 2025 08:09:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1754568549; x=1786104549;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=MnawxUnvOKw6/CZfAUA3YSLAXwZrIDsAEHY4hJuFuGw=;
 b=jTo3+0XYMh7bCA06sIAQlY5r9RhD7ExsvghWoAkDDnMgdjFVEkzdBrjo
 Xbc7hizJAlYJtGzkvmpZ6DOHMJmgH4qKhni4y5S6Pg0Eeor3boWgJBl1h
 p2Cg4YSfFHo3eSHXGZAtzx7KJsjiXL2UDCXGYeZY2SxeQ35vPyFaJYAHP
 zpkW4rQvqWqlw3HTUO75ah0YgMNgTjJ1yaW6I3z2+HY+YiQ4XlMDQ2UN0
 JrJMDL/DpsYEr7OKzGs2bYjD1HotZy/tyJ/Ba2mgDJ4hBl1tubmZbghKH
 +GzEUb7YZTVBaeFu2r2Vacd8HXCOdUvpjdK2pNe4o7IyVIK6hBAflHXTz Q==;
X-CSE-ConnectionGUID: utDGbuXUTgm90/YUZFgflA==
X-CSE-MsgGUID: +FSYt2XtTzqBzX8S3gF0bQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="57036698"
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; d="scan'208";a="57036698"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Aug 2025 05:09:03 -0700
X-CSE-ConnectionGUID: 7lU+aHq6QSaxtbpbRmePhQ==
X-CSE-MsgGUID: oqnQXITGS26YA4vElYBHBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; d="scan'208";a="164701033"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa009.jf.intel.com with ESMTP; 07 Aug 2025 05:09:01 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Junjie Mao <junjie.mao@hotmail.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org,
 Dapeng Mi <dapeng1.mi@linux.intel.com>,
 Chuanxiao Dong <chuanxiao.dong@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [RFC 01/26] rust/hpet: Fix the error caused by vm-memory
Date: Thu,  7 Aug 2025 20:30:02 +0800
Message-Id: <20250807123027.2910950-2-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250807123027.2910950-1-zhao1.liu@intel.com>
References: <20250807123027.2910950-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.15; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
 rust/hw/timer/hpet/src/device.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/hw/timer/hpet/src/device.rs b/rust/hw/timer/hpet/src/device.rs
index acf7251029e9..9fd75bf096e4 100644
--- a/rust/hw/timer/hpet/src/device.rs
+++ b/rust/hw/timer/hpet/src/device.rs
@@ -881,7 +881,7 @@ fn is_offset_needed(&self) -> bool {
     }
 
     fn validate_num_timers(&self, _version_id: u8) -> bool {
-        self.num_timers == self.num_timers_save.get().into()
+        self.num_timers == Into::<usize>::into(self.num_timers_save.get())
     }
 }
 
-- 
2.34.1


