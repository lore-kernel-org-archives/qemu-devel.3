Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8671AC3DA45
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 08:08:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTGjt-00037p-Ij; Mon, 15 Jul 2024 04:07:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sTGjq-0002tT-8J; Mon, 15 Jul 2024 04:07:15 -0400
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sTGjb-000480-7J; Mon, 15 Jul 2024 04:07:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1721030819; x=1752566819;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=HrFJ7iXMOj+koRtwzVVA42PVliIsg/v/+/zhFzszICU=;
 b=BT5wFazLX2Bp5AszeQn+v2HUGZUhXvQVh+VAIwWl9hcVIPEwx74slhv3
 eX4h+MgDZmPMIEvnPSBZ+bO0UDT0qN41MzVKWNV5GtaI0IPiZjFZvsQqZ
 NJWprRRMYhfn3broxQj8xMFYPnX0gQCIXn27JTGgRMoopbjjjIxBuDP4F
 wWVuMbYBQL10Lzjza/1BX7kdz4Oy/8XZAkkdTyh4/PILzE+QBQ0EgqVAh
 r4lgak2kJw/jb7Cp+oKidBMHGcEILc4M2OYx+Q5VRIgQ2SXZxlgHDjJB4
 ysbLB/YzUFzRkzut3ZMw7WcVQGWslfo91HzdDSkbebjcvdJK3iuy3io/Q Q==;
X-CSE-ConnectionGUID: uWaEtX05TDib9hr+TmCWrA==
X-CSE-MsgGUID: R3YOPtvdSne89wOGUTDwsA==
X-IronPort-AV: E=McAfee;i="6700,10204,11133"; a="35935657"
X-IronPort-AV: E=Sophos;i="6.09,209,1716274800"; d="scan'208";a="35935657"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jul 2024 01:06:38 -0700
X-CSE-ConnectionGUID: k3q6YKbDQQSt3G/wXp0Sow==
X-CSE-MsgGUID: Ar3bYWEbR1OycwaGZSU/lA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,209,1716274800"; d="scan'208";a="49512585"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa009.fm.intel.com with ESMTP; 15 Jul 2024 01:06:35 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Michael Tokarev <mjt@tls.msk.ru>,
	Laurent Vivier <laurent@vivier.eu>
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-trivial@nongnu.org, qemu-devel@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 3/7] hw/usb/u2f-passthru: Get rid of qemu_open_old()
Date: Mon, 15 Jul 2024 16:21:51 +0800
Message-Id: <20240715082155.28771-4-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240715082155.28771-1-zhao1.liu@intel.com>
References: <20240715082155.28771-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.8; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

For qemu_open_old(), osdep.h said:

> Don't introduce new usage of this function, prefer the following
> qemu_open/qemu_create that take an "Error **errp".

So replace qemu_open_old() with qemu_open().

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 hw/usb/u2f-passthru.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/hw/usb/u2f-passthru.c b/hw/usb/u2f-passthru.c
index b7025d303d07..c4a783d12864 100644
--- a/hw/usb/u2f-passthru.c
+++ b/hw/usb/u2f-passthru.c
@@ -482,10 +482,8 @@ static void u2f_passthru_realize(U2FKeyState *base, Error **errp)
         return;
 #endif
     } else {
-        fd = qemu_open_old(key->hidraw, O_RDWR);
+        fd = qemu_open(key->hidraw, O_RDWR, errp);
         if (fd < 0) {
-            error_setg(errp, "%s: Failed to open %s", TYPE_U2F_PASSTHRU,
-                       key->hidraw);
             return;
         }
 
-- 
2.34.1


