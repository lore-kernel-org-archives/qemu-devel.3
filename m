Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F3DAD5B16B
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 08:46:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5hpV-00034e-7V; Tue, 29 Oct 2024 04:43:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t5hpT-00034N-Hn
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 04:43:55 -0400
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t5hpS-000848-2S
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 04:43:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730191434; x=1761727434;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Bg5maz9r6esN8mOcyPsxhwPKeGRYq/RWrV44SW6Ow9M=;
 b=fhxfUWGRr3bKuJLGuXnDGoc4fAUilKJKNAplGpqG1HX+j2+EmbWPSUuL
 cIb7jsPpsom0vscZqVtWR1Oq1yN7+2gk5KgQbSyfrrvQ31HPV/I0g7DdV
 5wVRkXxCqdHG1AjK55nSxQxqkwPT3FKhT2DR/lcG4VbpEaa3NSYRty7MX
 BKkHTtT85itC6nZPf7RuegGS1y2UN0iO7rd/ZRgVpDw9Dl0FV797zzkXG
 ow/EEB+TFe08ve6bN1ccAbMysPlPhjw6dfls/RK7fYIV9J4ZczwkxSO4g
 f1sUiUvfMx5giAd8aPICgtoAn5p8+hh/XIUKMYXr0yBTcFpmEbDoi2Ezs Q==;
X-CSE-ConnectionGUID: UKFQ785VQeWG3Nnww8bQQw==
X-CSE-MsgGUID: p6Njco9zSmCOK1fnXK2lsA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29592826"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="29592826"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2024 01:43:42 -0700
X-CSE-ConnectionGUID: YBhkgr+LQ/+nG7zPsdXyrQ==
X-CSE-MsgGUID: G/NBFFzJRJ+LW6X7wFPUIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; d="scan'208";a="85847217"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa003.fm.intel.com with ESMTP; 29 Oct 2024 01:43:41 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Cc: qemu-devel@nongnu.org,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 12/16] target/sparc: Replace type_register() with
 type_register_static()
Date: Tue, 29 Oct 2024 16:59:30 +0800
Message-Id: <20241029085934.2799066-13-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241029085934.2799066-1-zhao1.liu@intel.com>
References: <20241029085934.2799066-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.20; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.373,
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

Replace type_register() with type_register_static() because
type_register() will be deprecated.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 target/sparc/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index 54cb269e0af1..f784b84ddd91 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -1000,7 +1000,7 @@ static void sparc_register_cpudef_type(const struct sparc_def_t *def)
         .class_data = (void *)def,
     };
 
-    type_register(&ti);
+    type_register_static(&ti);
     g_free(typename);
 }
 
-- 
2.34.1


