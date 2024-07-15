Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0A29C2BD09
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 08:08:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTGjN-00022v-8d; Mon, 15 Jul 2024 04:06:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sTGjI-0001xB-Cc; Mon, 15 Jul 2024 04:06:41 -0400
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sTGjD-00044A-9p; Mon, 15 Jul 2024 04:06:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1721030795; x=1752566795;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=7YV0Vz0c/N4ySWCieuwbaL0Lj+whTDjZLEl2lUjUcMU=;
 b=JVkPcinJdy+kNu4a2RGqLZ9BHZ4Nt/tRED9nBSkx7BPIy05hUZpKSlm6
 p/3jCNVJ2k51uv/SD86qtF2qec45og8xow2O4U/N3WTFiwPmkrTetLbdc
 xJpEOmenNInIjEYzHs7P6ubpZDlnvxFecOI93cITc97fdcF1H2+ULZXE+
 GHS2BQfC847AxvyVt/FO0UvaJkKwEGA5Fw6CDuSwFa1rdROFij+ehsqRz
 zSVyFdHf9ft0ff3paN6qCo7NV19yHqB5qBYWhApIa3sW3y8C8VcjKyM44
 9pDwZfkzR3nLhSyB/79IJBn42i2aUTAeS6okeSckSOtyNPBvU/nUOc66C g==;
X-CSE-ConnectionGUID: 5lxK2CWiSw+MCdp7xTF3mQ==
X-CSE-MsgGUID: E175ywqMRQCakc/Y74qoqw==
X-IronPort-AV: E=McAfee;i="6700,10204,11133"; a="35935629"
X-IronPort-AV: E=Sophos;i="6.09,209,1716274800"; d="scan'208";a="35935629"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jul 2024 01:06:33 -0700
X-CSE-ConnectionGUID: /ONSoJKQQfqkKewi6bxDHg==
X-CSE-MsgGUID: 61QyDX41Tuy+dgqopHQDig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,209,1716274800"; d="scan'208";a="49512573"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa009.fm.intel.com with ESMTP; 15 Jul 2024 01:06:30 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Michael Tokarev <mjt@tls.msk.ru>,
	Laurent Vivier <laurent@vivier.eu>
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-trivial@nongnu.org, qemu-devel@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH 1/7] hw/i386/sgx: Get rid of qemu_open_old()
Date: Mon, 15 Jul 2024 16:21:49 +0800
Message-Id: <20240715082155.28771-2-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240715082155.28771-1-zhao1.liu@intel.com>
References: <20240715082155.28771-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.8; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

For qemu_open_old(), osdep.h said:

> Don't introduce new usage of this function, prefer the following
> qemu_open/qemu_create that take an "Error **errp".

So replace qemu_open_old() with qemu_open(). And considering the SGX
enablement description is useful, convert it into a error message hint.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>
Cc: Eduardo Habkost <eduardo@habkost.net>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 hw/i386/sgx.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/i386/sgx.c b/hw/i386/sgx.c
index de76397bcfb3..a14a84bc6f69 100644
--- a/hw/i386/sgx.c
+++ b/hw/i386/sgx.c
@@ -157,10 +157,12 @@ SGXInfo *qmp_query_sgx_capabilities(Error **errp)
 {
     SGXInfo *info = NULL;
     uint32_t eax, ebx, ecx, edx;
+    Error *local_err = NULL;
 
-    int fd = qemu_open_old("/dev/sgx_vepc", O_RDWR);
+    int fd = qemu_open("/dev/sgx_vepc", O_RDWR, &local_err);
     if (fd < 0) {
-        error_setg(errp, "SGX is not enabled in KVM");
+        error_append_hint(&local_err, "SGX is not enabled in KVM");
+        error_propagate(errp, local_err);
         return NULL;
     }
 
-- 
2.34.1


