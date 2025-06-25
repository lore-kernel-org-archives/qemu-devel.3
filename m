Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C297C77B7C
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Jun 2025 04:03:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUHLP-00056o-KW; Wed, 25 Jun 2025 00:02:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uUHLN-00056b-NB
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 00:02:41 -0400
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uUHLL-0003Lv-PY
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 00:02:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750824160; x=1782360160;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=42nRR0KrbdmqvkZGe4dz55Pz3JwJ3F4EGtg8zANaY3M=;
 b=GDtR/w3AQj9EBn1zMZ9Vd4xMNf6eLjT+pmBfZwePHjlJWgf46YDlGhvF
 SuOxDTUYa6iWshlCL9rH/07wRR4mbigA7sBq92bAAacG+xedA6/uG4vE/
 jBynBcziHVc82ywOCE12B/iYlciXRA65O+HxB62s98p5xwzR4dHK6Fizq
 c/vMx0k3O2Jt7qsO1tV8kP8tvqGvdGenzpVjodnEzn2eX2my70uJBwoyR
 JlC3UEDSe5egDNXAlk7T3mQ1iGNn6fJ+pIUjD9IBBp2XJtjZv1VAuvWLu
 GTR/OVz7gHblzAQIN1cy/WyfK/BCXnXMBNGaT8djQNw15nAdnyPWmngJm w==;
X-CSE-ConnectionGUID: AtTAsko8RiaAftFSm0Ouig==
X-CSE-MsgGUID: oDtpR8bGQ0mj6nCVS8eCZw==
X-IronPort-AV: E=McAfee;i="6800,10657,11474"; a="53222453"
X-IronPort-AV: E=Sophos;i="6.16,263,1744095600"; d="scan'208";a="53222453"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jun 2025 21:02:14 -0700
X-CSE-ConnectionGUID: VnTpLUnmQ7K7vQwQwWpYQQ==
X-CSE-MsgGUID: eowW5MzbSCm6lRmrFqMETw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,263,1744095600"; d="scan'208";a="156380636"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by fmviesa005.fm.intel.com with ESMTP; 24 Jun 2025 21:02:13 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel@nongnu.org,
	xiaoyao.li@intel.com
Subject: [PATCH] i386/tdx: Remove task->watch only when it's valid
Date: Wed, 25 Jun 2025 11:55:05 +0800
Message-ID: <20250625035505.2770580-1-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.15; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

In some case (e.g., failed to connect to QGS socket),
tdx_generate_quote_cleanup() is called with task->watch invalid. It
triggers assertion of

  qemu-system-x86_64: GLib: g_source_remove: assertion 'tag > 0' failed

Fix it by checking task->watch.

Fixes: 40da501d8989 ("i386/tdx: handle TDG.VP.VMCALL<GetQuote>")
Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 target/i386/kvm/tdx-quote-generator.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/i386/kvm/tdx-quote-generator.c b/target/i386/kvm/tdx-quote-generator.c
index f59715f61751..dee8334b27ac 100644
--- a/target/i386/kvm/tdx-quote-generator.c
+++ b/target/i386/kvm/tdx-quote-generator.c
@@ -75,7 +75,9 @@ static void tdx_generate_quote_cleanup(TdxGenerateQuoteTask *task)
 {
     timer_del(&task->timer);
 
-    g_source_remove(task->watch);
+    if (task->watch) {
+        g_source_remove(task->watch);
+    }
     qio_channel_close(QIO_CHANNEL(task->sioc), NULL);
     object_unref(OBJECT(task->sioc));
 
-- 
2.43.0


