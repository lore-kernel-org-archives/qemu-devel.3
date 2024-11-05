Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCB5BD1CA39
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 06:38:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8DBm-0004qY-CD; Tue, 05 Nov 2024 01:37:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1t8DBg-0004mT-DL
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 01:37:12 -0500
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1t8DBe-0001rn-0m
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 01:37:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730788630; x=1762324630;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=3vrjucC0HxJukGg8dTLCBBUFcd1deUmBY7cHA/rzJ28=;
 b=fnDTIZgCHldWTxTiLS3W9VW8QbT0q7DLEaPWNsc/yEP/jhIM5W19r6BP
 Mbxe1m30kqo8N6uffEI1Ix8cSF/HnLU3yeHalkXGPg7xPpX5mKI+adI/w
 1ney5Ckn9VCf0x3PJ/yp4sj1WvmpeXuL/7DQQZ4fP4F4Y9+M9i3oo0c0O
 /vWzybsBkE1UZtv58hHVgtJxlD562rjmID9jJm8IDpvia7TuM0wchrW2b
 u5nMwcl77fTDaBCNErF+sqecmsjeE5QtwcuyC79MdsFyKbICBU2Cq7s+v
 0/wgUAGhLU1/3t307PME3nBmBmr0qsKwmjzAFB6Re1i8RQj2tatGVhzFi w==;
X-CSE-ConnectionGUID: TpP6pdLlTiKF0+ChMefqMw==
X-CSE-MsgGUID: DnQdGaypTVWNzqRilC2dhg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30689397"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="30689397"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2024 22:37:09 -0800
X-CSE-ConnectionGUID: Zm2pPz90SC68qOWzD6MiDQ==
X-CSE-MsgGUID: UIm5o8N/TvOypSmczHpCoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,259,1725346800"; d="scan'208";a="83988743"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by fmviesa009.fm.intel.com with ESMTP; 04 Nov 2024 22:37:04 -0800
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
Subject: [PATCH v6 11/60] i386/tdx: Make sept_ve_disable set by default
Date: Tue,  5 Nov 2024 01:23:19 -0500
Message-Id: <20241105062408.3533704-12-xiaoyao.li@intel.com>
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

From: Isaku Yamahata <isaku.yamahata@intel.com>

For TDX KVM use case, Linux guest is the most major one.  It requires
sept_ve_disable set.  Make it default for the main use case.  For other use
case, it can be enabled/disabled via qemu command line.

Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
---
 target/i386/kvm/tdx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index faac05ef630f..e8fd5c7d49e7 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -258,7 +258,7 @@ static void tdx_guest_init(Object *obj)
     qemu_mutex_init(&tdx->lock);
 
     cgs->require_guest_memfd = true;
-    tdx->attributes = 0;
+    tdx->attributes = TDX_TD_ATTRIBUTES_SEPT_VE_DISABLE;
 
     object_property_add_uint64_ptr(obj, "attributes", &tdx->attributes,
                                    OBJ_PROP_FLAG_READWRITE);
-- 
2.34.1


