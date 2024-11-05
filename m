Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB4F8D1CA3A
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 06:48:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8DH4-0005qd-Bo; Tue, 05 Nov 2024 01:42:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1t8DF7-0003YJ-O8
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 01:40:50 -0500
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1t8DF2-0001w0-LT
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 01:40:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730788841; x=1762324841;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=N6wZGF3LbJuiZwh2h+P0qnuOeIsvhZtITe8MucmhR3Y=;
 b=nmGdyajjcbvXf2DHxxT5vhBvTC0dNIdQNyMfr+CGIfFrLVFqQuirYIpa
 dSb3YP6gnNHXrt0V9cs+TqIutSdyiiqiIv3yqGoSBYPogY0sTPvdwICE4
 F6ed5P6WCD6LgWxq2AL4xoLcWAJdPmCo2ZEvSwjGsdC//6Y0C88PUneGY
 +s21W+modJNnyvf2XVv3N51+9DzGurjjss+8o+KK2t2Um0QS45VJgqGn3
 WtfX0BnDaKymFySJYHyZhzPbKm4bnW4T4XN3z2SqLtJW6Ys0TaIa+Kfr/
 gKgbeGtTpPi776o2SfbHlPjRcdTgj/2S3BbRnQ5xUBb4zVnxN8flLFnaI w==;
X-CSE-ConnectionGUID: OoOeTxGXSoufjx13YronRQ==
X-CSE-MsgGUID: M/3V27CaSpGbME/RQYhsqw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30689925"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="30689925"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2024 22:40:22 -0800
X-CSE-ConnectionGUID: cui/g9wYSTW/R2q/F+xxag==
X-CSE-MsgGUID: BO/sHFRmRSK/ivSD8JW1yA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,259,1725346800"; d="scan'208";a="83990064"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by fmviesa009.fm.intel.com with ESMTP; 04 Nov 2024 22:40:18 -0800
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, rick.p.edgecombe@intel.com,
 kvm@vger.kernel.org, qemu-devel@nongnu.org, xiaoyao.li@intel.com
Subject: [PATCH v6 56/60] i386/tdx: Don't treat SYSCALL as unavailable
Date: Tue,  5 Nov 2024 01:24:04 -0500
Message-Id: <20241105062408.3533704-57-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241105062408.3533704-1-xiaoyao.li@intel.com>
References: <20241105062408.3533704-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.18; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.781, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 target/i386/kvm/tdx.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index 9cb099e160e4..05475edf72bd 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -734,6 +734,13 @@ static int tdx_check_features(X86ConfidentialGuest *cg, CPUState *cs)
 
         requested = env->features[w];
         unavailable = requested & ~actual;
+        /*
+         * Intel enumerates SYSCALL bit as 1 only when processor in 64-bit
+         * mode and before vcpu running it's not in 64-bit mode.
+         */
+        if (w == FEAT_8000_0001_EDX && unavailable & CPUID_EXT2_SYSCALL) {
+            unavailable &= ~CPUID_EXT2_SYSCALL;
+        }
         mark_unavailable_features(cpu, w, unavailable, unav_prefix);
         if (unavailable) {
             mismatch = true;
-- 
2.34.1


