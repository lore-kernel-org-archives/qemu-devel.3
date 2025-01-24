Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70FA3C02181
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 13:48:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbJuT-0000CD-MA; Fri, 24 Jan 2025 08:39:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tbJtc-0006Zi-Lm
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 08:38:58 -0500
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tbJta-00041c-PL
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 08:38:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1737725931; x=1769261931;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=9LeRcYgDvW5lMsehq+j8bbe6PQs/g/hSfE4cA/e4doU=;
 b=SlivONiI8mh/8f10tDEcIIqmIDJnCeO415Bizw35hX7PocneU9+y6/bp
 OCwvLAziRFcxFLEQLmNrepPPzQI4g/l6kKDNmP/tLliDfk+PbaKj3tVwp
 AhEtLZzzbcbG0pq0VlBFl5CA/c3mVKc+L3UUwAK+FgwnjlrhcXCJiRYzr
 uhTJ18rgGFsUM+mVA8v/20jEs4PS64LPLjk+kereusjE/xNX00sJrJK3H
 14/b6Mu87+219pbMv9vcBh2c4Yv/nehUrVGQ/laXlyuSJwGUFznaAMm/8
 39ohb4cXMBWbHLlCgN2Hvkem/Wc9lBTdZJh3PL4rPr4y6B3J4BC19yGsh g==;
X-CSE-ConnectionGUID: TsBYQSndS1auoHWN/gTCdA==
X-CSE-MsgGUID: yGoK038sSumtSeVB0C8YtA==
X-IronPort-AV: E=McAfee;i="6700,10204,11325"; a="49246429"
X-IronPort-AV: E=Sophos;i="6.13,231,1732608000"; d="scan'208";a="49246429"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jan 2025 05:38:36 -0800
X-CSE-ConnectionGUID: A65DTX7TRl2FBFd2ClD4QQ==
X-CSE-MsgGUID: 4nMhs+4ZReudkhpfCqarDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="111804321"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by fmviesa003.fm.intel.com with ESMTP; 24 Jan 2025 05:38:32 -0800
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>
Cc: Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>, Huacai Chen <chenhuacai@kernel.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Francesco Lavra <francescolavra.fl@gmail.com>, xiaoyao.li@intel.com,
 qemu-devel@nongnu.org, kvm@vger.kernel.org
Subject: [PATCH v7 25/52] i386/tdx: Finalize TDX VM
Date: Fri, 24 Jan 2025 08:20:21 -0500
Message-Id: <20250124132048.3229049-26-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250124132048.3229049-1-xiaoyao.li@intel.com>
References: <20250124132048.3229049-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.13; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -63
X-Spam_score: -6.4
X-Spam_bar: ------
X-Spam_report: (-6.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.998, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Invoke KVM_TDX_FINALIZE_VM to finalize the TD's measurement and make
the TD vCPUs runnable once machine initialization is complete.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Acked-by: Gerd Hoffmann <kraxel@redhat.com>
---
 target/i386/kvm/tdx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index 99c1664d836b..d7f7f8301ca2 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -351,6 +351,9 @@ static void tdx_finalize_vm(Notifier *notifier, void *unused)
      */
     ram_block = tdx_guest->tdvf_mr->ram_block;
     ram_block_discard_range(ram_block, 0, ram_block->max_length);
+
+    tdx_vm_ioctl(KVM_TDX_FINALIZE_VM, 0, NULL, &error_fatal);
+    CONFIDENTIAL_GUEST_SUPPORT(tdx_guest)->ready = true;
 }
 
 static Notifier tdx_machine_done_notify = {
-- 
2.34.1


