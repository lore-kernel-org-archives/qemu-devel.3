Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E4B8C5DF97
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 03:36:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wz4QS-0004zz-3h; Tue, 25 Aug 2026 23:35:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kishen.maloor@intel.com>)
 id 1wz4QQ-0004vw-K7
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 23:35:42 -0400
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kishen.maloor@intel.com>)
 id 1wz4QP-00074u-6T
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 23:35:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787715341; x=1819251341;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=fIqB/q6xq21Itqsn2ztBWJFiSntXIZKCsqRrTY+RK/U=;
 b=gwVDuhVJKGKi6xFbB9lLbKfzgR/0JnFy7MqZ5IRyn5ylp7Si5yTqFQfV
 yARJijTMSRyh7bb3CM9JCxcccJ56XCu1VpTWlCWeSTNcmwe22otqx4H/A
 cxColtA5xUI2sq0NRbvcPJSlLmkgAZ+xGI6MdUQXwEJdbgEGaOw2sFdiD
 V3q7kUXKMyKyXKLRTUhJ0sjj7GH7UFlNDYbRyfP2OggXxfdcr+pyuvVj8
 XRYfajs8Fhr+9AqaAnQkdq6OifB4mHIuuY/1h44VF5CK5ZUBj6Cl4YHfH
 uhcLWI/dLyTHOgZCY8/oLB/AgucgQtmGfcGCJHzLbzFVU8HWfmm9rEyIK g==;
X-CSE-ConnectionGUID: gVuMImHyT4CSBYz/fztoKQ==
X-CSE-MsgGUID: gLH8UiG0RoCkDkbmTS765Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11886"; a="75728383"
X-IronPort-AV: E=Sophos;i="6.25,244,1779174000"; d="scan'208";a="75728383"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Aug 2026 20:35:31 -0700
X-CSE-ConnectionGUID: V0DeUYCfThqt7OfqTVKgCg==
X-CSE-MsgGUID: t4X+5MgxRVuHTSLeJg+vSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,244,1779174000"; d="scan'208";a="297364020"
Received: from d404e69c8b80.jf.intel.com ([10.54.34.91])
 by orviesa002.jf.intel.com with ESMTP; 25 Aug 2026 20:35:32 -0700
From: Kishen Maloor <kishen.maloor@intel.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, zhao1.liu@intel.com, kvm@vger.kernel.org,
 sohil.mehta@intel.com, xiaoyao.li@intel.com, binbin.wu@linux.intel.com,
 farrah.chen@intel.com, kishen.maloor@intel.com
Subject: [PATCH 4/5] target/i386: Introduce SierraForest-v7 to enable LASS
Date: Tue, 25 Aug 2026 20:57:33 -0700
Message-ID: <20260826035734.114685-5-kishen.maloor@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260826035734.114685-1-kishen.maloor@intel.com>
References: <20260826035734.114685-1-kishen.maloor@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.16;
 envelope-from=kishen.maloor@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Add SierraForest-v7 to expose Linear Address Space Separation (LASS)
on the SierraForest CPU model.

Signed-off-by: Kishen Maloor <kishen.maloor@intel.com>
---
 target/i386/cpu.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index fa6b76be27..167df0e6cb 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6018,6 +6018,14 @@ static const X86CPUDefinition builtin_x86_defs[] = {
                     { /* end of list */ },
                 }
             },
+            {
+                .version = 7,
+                .note = "with LASS",
+                .props = (PropValue[]) {
+                    { "lass", "on" },
+                    { /* end of list */ },
+                }
+            },
             { /* end of list */ },
         },
     },
-- 
2.47.1


