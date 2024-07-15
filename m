Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E9AEC2BD09
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 08:08:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTGk0-0003Uq-AT; Mon, 15 Jul 2024 04:07:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sTGjs-0002zz-0Q; Mon, 15 Jul 2024 04:07:16 -0400
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sTGjf-00048k-7H; Mon, 15 Jul 2024 04:07:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1721030823; x=1752566823;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=YCLpBmWyjqRhCjA5if9DiWPaQGLwQuPCOoB+ZMle+lg=;
 b=eUiwbEVkEttximvioDk5HKPZ181bDzrQy9u9XiA+WFyk8ZMMyJ/MKmJc
 fizEYwsoGrW7WApDE7tpE2CJ7hLmWwmsLt2t+xab4abwhMThxgy8pxhYW
 sKXMANU+qTw1qQcg2qNKSYYtkZ3lTwrQCvPZrs5ydy2OL64lbwbqoCjvj
 JjmzYWtk3uQCqW+wdRevuf3bNiuNIjrgABvQal1FfpN8FotlENu3QTGB1
 x35G2MQbFkQrV9APVdH69drHqw1KTAn1t6BkRu3Bf6UVsL95vnp2TEgkz
 mOwjJyXN2NBaFBOrX7gMFyg/Ph8AhUp8BHNeU72mzxaX+sMJ4A561ObaD A==;
X-CSE-ConnectionGUID: 7FIRPCbBRKGHK0FUk60cyQ==
X-CSE-MsgGUID: lewdhUpdQAmWexGF2y0ZnA==
X-IronPort-AV: E=McAfee;i="6700,10204,11133"; a="35935677"
X-IronPort-AV: E=Sophos;i="6.09,209,1716274800"; d="scan'208";a="35935677"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jul 2024 01:06:43 -0700
X-CSE-ConnectionGUID: 8UsliN5GRZm4uaQMhPB0zQ==
X-CSE-MsgGUID: UZm0wjTYSNCAuQKMMZKugw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,209,1716274800"; d="scan'208";a="49512591"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa009.fm.intel.com with ESMTP; 15 Jul 2024 01:06:40 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Michael Tokarev <mjt@tls.msk.ru>,
	Laurent Vivier <laurent@vivier.eu>
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-trivial@nongnu.org, qemu-devel@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>, David Hildenbrand <david@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
Subject: [PATCH 5/7] backends/hostmem-epc: Get rid of qemu_open_old()
Date: Mon, 15 Jul 2024 16:21:53 +0800
Message-Id: <20240715082155.28771-6-zhao1.liu@intel.com>
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

For qemu_open_old(), osdep.h said:

> Don't introduce new usage of this function, prefer the following
> qemu_open/qemu_create that take an "Error **errp".

So replace qemu_open_old() with qemu_open().

Cc: David Hildenbrand <david@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 backends/hostmem-epc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/backends/hostmem-epc.c b/backends/hostmem-epc.c
index f58fcf00a10b..6c024d6217d2 100644
--- a/backends/hostmem-epc.c
+++ b/backends/hostmem-epc.c
@@ -29,10 +29,8 @@ sgx_epc_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
         return false;
     }
 
-    fd = qemu_open_old("/dev/sgx_vepc", O_RDWR);
+    fd = qemu_open("/dev/sgx_vepc", O_RDWR, errp);
     if (fd < 0) {
-        error_setg_errno(errp, errno,
-                         "failed to open /dev/sgx_vepc to alloc SGX EPC");
         return false;
     }
 
-- 
2.34.1


