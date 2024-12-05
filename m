Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AFD4E77173
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 05:49:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJ4jw-0006BY-SY; Thu, 05 Dec 2024 00:49:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tJ4jw-0006BM-0L; Thu, 05 Dec 2024 00:49:28 -0500
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tJ4ju-00079A-F5; Thu, 05 Dec 2024 00:49:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1733377767; x=1764913767;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Sx8nPxJJRfYhQt7D0F4clWV/fbFfMbPN7go3+4J/5Rc=;
 b=k9XC99M/lx1XFVaz2A4xoDvLqKocn6Eo9qv8T4oeYxh+3UullTfn1Dim
 Cnty98ONsKmaASjVR/Rqw1jodll8N3WYWXucnsKxj+biWDJsRPFFg6wsi
 HTMLG3L4QHhh1yKfs3oLP83ckCniy4qPY0IqOoJUx3xTCfYzFLGBwFaCR
 8Gvaeea8WChMKVYz2I26SNlRVnFsWtJh0y7+h35Bh7NHh6lrOYak3Zmab
 OZX1/hrRVKrtb9tkAEVzGUkWqy/CtPFDLRKwwRYTuSVjsMUfeOMxRG1Z3
 KnTSarQWWqrlWi4BD2212nw8tBOaOFOMoESjxHHJor5Z0LsecpkWDWQSM A==;
X-CSE-ConnectionGUID: VoNbXnOFQIiTwfPMdimSQQ==
X-CSE-MsgGUID: iFQ5Azm8QC+MpqjCEOvXOw==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="33815623"
X-IronPort-AV: E=Sophos;i="6.12,209,1728975600"; d="scan'208";a="33815623"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Dec 2024 21:49:24 -0800
X-CSE-ConnectionGUID: TRWGioeHT7257PaafcEfDA==
X-CSE-MsgGUID: sxO6YOnFTVqTlepySetzDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,209,1728975600"; d="scan'208";a="94454972"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa009.fm.intel.com with ESMTP; 04 Dec 2024 21:49:21 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [RFC 03/13] rust/cell: add get_mut() method for BqlCell
Date: Thu,  5 Dec 2024 14:07:04 +0800
Message-Id: <20241205060714.256270-4-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241205060714.256270-1-zhao1.liu@intel.com>
References: <20241205060714.256270-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.18; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -73
X-Spam_score: -7.4
X-Spam_bar: -------
X-Spam_report: (-7.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

The get_mut() is useful when doing compound assignment operations, e.g.,
*c.get_mut() += 1.

Implement get_mut() for BqlCell by referring to Cell.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 rust/qemu-api/src/cell.rs | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/rust/qemu-api/src/cell.rs b/rust/qemu-api/src/cell.rs
index 07b636f26266..95f1cc0b3eb5 100644
--- a/rust/qemu-api/src/cell.rs
+++ b/rust/qemu-api/src/cell.rs
@@ -324,6 +324,31 @@ impl<T> BqlCell<T> {
     pub const fn as_ptr(&self) -> *mut T {
         self.value.get()
     }
+
+    /// Returns a mutable reference to the underlying data.
+    ///
+    /// This call borrows `BqlCell` mutably (at compile-time) which guarantees
+    /// that we possess the only reference.
+    ///
+    /// However be cautious: this method expects `self` to be mutable, which is
+    /// generally not the case when using a `BqlCell`. If you require interior
+    /// mutability by reference, consider using `BqlRefCell` which provides
+    /// run-time checked mutable borrows through its [`borrow_mut`] method.
+    ///
+    /// [`borrow_mut`]: BqlRefCell::borrow_mut()
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use qemu_api::cell::BqlCell;;
+    ///
+    /// let mut c = BqlCell::new(5);
+    /// *c.get_mut() += 1;
+    ///
+    /// assert_eq!(c.get(), 6);
+    pub fn get_mut(&mut self) -> &mut T {
+        self.value.get_mut()
+    }
 }
 
 impl<T: Default> BqlCell<T> {
-- 
2.34.1


