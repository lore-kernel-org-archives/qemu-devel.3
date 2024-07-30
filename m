Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA24CC3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 14:51:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYoB5-0007bq-O7; Tue, 30 Jul 2024 10:50:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiong.y.zhang@linux.intel.com>)
 id 1sYiFd-0001BR-2b
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 04:30:33 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiong.y.zhang@linux.intel.com>)
 id 1sYiFa-0004ip-BE
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 04:30:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1722328231; x=1753864231;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=Zu0DkYHZp376mYcxX4BmjxKrhLF7QW+fPRCdyxIIOLI=;
 b=YW3J4WJMSN8Jry2QU9/8kL9GiYepIKSl5ZFunBiCFxogktD9Xj3VcD+h
 0/fbwmCu5IQV9DUB9XQHfmsg+kUq/4vCFZ8qPVLdXekL9HK/fHXOhs6Mn
 po6kkoCymeVzR5sKgOvLpZjyH48YJ6nlgZ4HypHacbvDLisN346Z+qFsP
 u8jxGTBoJp1DiDO3V8pfEGCi/2C/KqzfbnJPDTwCc/ZX0ntJGlqkhMA+I
 IuOn2PDAz63Xs1gBuIzJ3r+PihEdd00B0/KR2UHwoXQlgt5cuXF19d/T6
 r/66GTJXaf5vrjxXb6z0ulvHjUTf/7nL4mfmwTDSExbrk78BcRBNoTx+7 g==;
X-CSE-ConnectionGUID: oSSEqujzSSyVruZDW3S7QQ==
X-CSE-MsgGUID: Q0UYIiXGQBmsUrfVVmI4Jw==
X-IronPort-AV: E=McAfee;i="6700,10204,11148"; a="30716302"
X-IronPort-AV: E=Sophos;i="6.09,248,1716274800"; d="scan'208";a="30716302"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jul 2024 01:30:27 -0700
X-CSE-ConnectionGUID: OmD7hmV6SZGMXrP/i6kwlg==
X-CSE-MsgGUID: 3Xxa/mA3Tx29UNLUJJ7aFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,248,1716274800"; d="scan'208";a="59338242"
Received: from xiongzha-desk1.bj.intel.com ([10.238.156.112])
 by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jul 2024 01:30:26 -0700
From: Xiong Zhang <xiong.y.zhang@linux.intel.com>
To: pbonzini@redhat.com
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Xiong Zhang <xiong.y.zhang@linux.intel.com>
Subject: [PATCH] target/i386: Change unavail from u32 to u64
Date: Tue, 30 Jul 2024 16:29:27 +0800
Message-ID: <20240730082927.250180-1-xiong.y.zhang@linux.intel.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=198.175.65.11;
 envelope-from=xiong.y.zhang@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 30 Jul 2024 10:50:09 -0400
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

The feature word 'r' is a u64, and "unavail" is a u32, the operation
'r &= ~unavail' clears the high 32 bits of 'r'. This causes many vmx cases
in kvm-unit-tests to fail. Changing 'unavail' from u32 to u64 fixes this
issue.

Bugzilla: https://gitlab.com/qemu-project/qemu/-/issues/2442
Fixes: 0b2757412cb1 ("target/i386: drop AMD machine check bits from Intel CPUID")
Signed-off-by: Xiong Zhang <xiong.y.zhang@linux.intel.com>
---
 target/i386/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 4688d140c2..ef06da54c6 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6039,7 +6039,7 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w)
 {
     FeatureWordInfo *wi = &feature_word_info[w];
     uint64_t r = 0;
-    uint32_t unavail = 0;
+    uint64_t unavail = 0;
 
     if (kvm_enabled()) {
         switch (wi->type) {
-- 
2.40.1


