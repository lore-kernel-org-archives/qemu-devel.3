Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30609D374A0
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 14:16:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1RIx-0001KU-Ua; Thu, 17 Oct 2024 10:16:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t1RIw-0001KD-Gm
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 10:16:42 -0400
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t1RIu-0002JQ-KZ
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 10:16:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1729174601; x=1760710601;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=zNtyLbF2NaEtnWKH8mXKsOb2TpHKY3e2pLSl8z5LJkE=;
 b=PT7HHEP9NONXcC8f1/qz+DLhoTlmK+trtWKAe72Ws6WHZI89llM9YxdU
 w39nSTVs3+mx17HxlqhOqWR8kL7NSmvl76DkBc9W4TltGY09vQCA2GvLS
 bpHuQawM5OU1dJ74GbAcVLsIWel4xexsmADM53jvzpo+TGz58r3B8gA3c
 KNneIG9Dti7djdeyf500cFSreM8rA/5XoZOX3EN6U5Rj6m8J57A8bOExH
 ptEZdJW9APJxBhGv/o9Ufd8JXKRQapaQMQP3LbYvWWTr3VMu31LN/lbL3
 pA+F+fZcO9Jkhq/Zy1dcHgMEg+NXJG7QdT05fRHWIQOtx5rCnHagKuYYQ g==;
X-CSE-ConnectionGUID: c3WvVi5pSsGymKxlpHr6Ig==
X-CSE-MsgGUID: e0/p4nNvTeiFGAD14csVJw==
X-IronPort-AV: E=McAfee;i="6700,10204,11228"; a="39299383"
X-IronPort-AV: E=Sophos;i="6.11,211,1725346800"; d="scan'208";a="39299383"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Oct 2024 07:16:38 -0700
X-CSE-ConnectionGUID: M3Cq/5AmS7+V5XzAPIxIRA==
X-CSE-MsgGUID: 1zrriyKdTU2W5gXAu9AUbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,211,1725346800"; d="scan'208";a="78900048"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa010.fm.intel.com with ESMTP; 17 Oct 2024 07:16:36 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Junjie Mao <junjie.mao@hotmail.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [RFC 1/2] rust/qemu-api: Fix fragment-specifiers in define_property
 macro
Date: Thu, 17 Oct 2024 22:32:44 +0800
Message-Id: <20241017143245.1248589-2-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241017143245.1248589-1-zhao1.liu@intel.com>
References: <20241017143245.1248589-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.9; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.068,
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

From: Junjie Mao <junjie.mao@hotmail.com>

For the matcher of macro, "expr" is used for expressions, while "ident"
is used for variable/function names, and "ty" matches types.

In define_property macro, $field is a member name of type $state, so it
should be defined as "ident", though offset_of! doesn't complain about
this. $type is the type of $field, since it is not used in the macro, so
that no type mismatch error is triggered either.

Fix fragment-specifiers of $field and $type.

Signed-off-by: Junjie Mao <junjie.mao@hotmail.com>
Co-developed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 rust/qemu-api/src/device_class.rs | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/rust/qemu-api/src/device_class.rs b/rust/qemu-api/src/device_class.rs
index 1ea95beb78db..be363fd63223 100644
--- a/rust/qemu-api/src/device_class.rs
+++ b/rust/qemu-api/src/device_class.rs
@@ -26,7 +26,7 @@ macro_rules! device_class_init {
 
 #[macro_export]
 macro_rules! define_property {
-    ($name:expr, $state:ty, $field:expr, $prop:expr, $type:expr, default = $defval:expr$(,)*) => {
+    ($name:expr, $state:ty, $field:ident, $prop:expr, $type:ty, default = $defval:expr$(,)*) => {
         $crate::bindings::Property {
             name: {
                 #[used]
@@ -47,7 +47,7 @@ macro_rules! define_property {
             link_type: ::core::ptr::null(),
         }
     };
-    ($name:expr, $state:ty, $field:expr, $prop:expr, $type:expr$(,)*) => {
+    ($name:expr, $state:ty, $field:ident, $prop:expr, $type:ty$(,)*) => {
         $crate::bindings::Property {
             name: {
                 #[used]
-- 
2.34.1


