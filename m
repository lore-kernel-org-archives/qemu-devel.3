Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54434C3ABD9
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 08:30:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uF7UE-0006nP-AP; Wed, 14 May 2025 04:29:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uF7UA-0006gc-2W; Wed, 14 May 2025 04:29:06 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uF7U7-0006Fs-OC; Wed, 14 May 2025 04:29:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747211344; x=1778747344;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=1RQexxzH4YFkjxykLnQHXT3NcbCAnyHIN3979LqZumo=;
 b=Mo8erR1SrJnVLE3e+aK0/W8xcJ5ucWYF7nTquH97P0LzlT+0QP1JGtTh
 E7Uu3agpBqDuVvQD+8kLI+/I+ak7fU99r/WmOhzJWG5LXIuUjJXvoflv2
 vKHkmYhacs5EGWhy8jy5qgHKKok1oiwtNHcOsiHynfPWnbPZKEjKV/H4U
 FZgMxc0IfDsga9CpOtu3lhWIl3Z30Z8hjA5DxHOTkpZyQ+QfEiaS3zDEJ
 yg4FqxA6Xd/4WAtIxGs7rWZemtO4w7NGwRKtEXRlovnx8DCULRGY5alnK
 WLe15hTRVhgF/bp8MHyz2qc10cmAfHPMwXurn7hExRn1Y4fZNy48lYP9J A==;
X-CSE-ConnectionGUID: oZNOczmxQzm80Wlk2jVdlw==
X-CSE-MsgGUID: QXuca8NnTSi04U0Io+ZI5g==
X-IronPort-AV: E=McAfee;i="6700,10204,11432"; a="66505583"
X-IronPort-AV: E=Sophos;i="6.15,287,1739865600"; d="scan'208";a="66505583"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 May 2025 01:29:03 -0700
X-CSE-ConnectionGUID: 7KGGgSw0QuG2Ewmiw+SMMg==
X-CSE-MsgGUID: Q3ohJwzCRS6s+i2xXecPpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,287,1739865600"; d="scan'208";a="169065821"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa001.fm.intel.com with ESMTP; 14 May 2025 01:28:59 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Magnus Damm <magnus.damm@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 4/9] hw/char/sh_serial: Consolidate
 OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES
Date: Wed, 14 May 2025 16:49:52 +0800
Message-Id: <20250514084957.2221975-5-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250514084957.2221975-1-zhao1.liu@intel.com>
References: <20250514084957.2221975-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.10; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.549,
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

The QOM type of SHSerialState is declared by OBJECT_DECLARE_SIMPLE_TYPE,
which means it doesn't need the class!

Therefore, use OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES to implement
the type, then there's no need for class definition.

Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Magnus Damm <magnus.damm@gmail.com>
Cc: "Marc-André Lureau" <marcandre.lureau@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 hw/char/sh_serial.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/hw/char/sh_serial.c b/hw/char/sh_serial.c
index 6abd80386fb4..8ccc2234ba4d 100644
--- a/hw/char/sh_serial.c
+++ b/hw/char/sh_serial.c
@@ -78,9 +78,7 @@ struct SHSerialState {
     qemu_irq bri;
 };
 
-typedef struct {} SHSerialStateClass;
-
-OBJECT_DEFINE_TYPE(SHSerialState, sh_serial, SH_SERIAL, SYS_BUS_DEVICE)
+OBJECT_DEFINE_SIMPLE_TYPE(SHSerialState, sh_serial, SH_SERIAL, SYS_BUS_DEVICE)
 
 static void sh_serial_clear_fifo(SHSerialState *s)
 {
-- 
2.34.1


