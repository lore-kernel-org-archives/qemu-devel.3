Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23250C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 03:00:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzpK7-0006mM-DD; Wed, 24 Apr 2024 22:58:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rzpJy-0006ja-6T; Wed, 24 Apr 2024 22:58:50 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rzpJw-00055w-1f; Wed, 24 Apr 2024 22:58:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1714013928; x=1745549928;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=VhsAZz3GZDugXvCbTu1lmTbG6KqX61IfVZfRXKWJzJA=;
 b=Z4L4xyhTc3BTUigtqh1blhDdxUNYLLPlR3EZrv70MTkRIruPjHmEHPP6
 ljKMq10TSpL6B8SrlgaysVHRy1TcctCwXn46wt3uV1qqVswquPqqkkYgS
 sX6LlkfLTvIWsD6bVy9+a3BgxfJ8HQHh3aHziY/+eWmpxSBFaML5qUHsr
 5vIe0PY8oe34LFlGWeeH5mUxaLiGKBogyua/WyN+flblSUCpt54QUmwpK
 Zc2Xzg/10Gei2Aw4vANA+PqPk3Wa1Gkzy3i8IkgqWrbM9OaG/kjj14tTl
 E2E+C8kAup2/88BAHNlEUplTTKrlabxyeYq70Zndc+tPnFSkUdfVArD56 A==;
X-CSE-ConnectionGUID: UHX/Rnk8TFW70tE15Gxv7Q==
X-CSE-MsgGUID: 0x3epI2hRdmmoP7pBjQmaw==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="9605645"
X-IronPort-AV: E=Sophos;i="6.07,228,1708416000"; 
   d="scan'208";a="9605645"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Apr 2024 19:58:47 -0700
X-CSE-ConnectionGUID: zzlCY8FgSdaQP8FgQAEYww==
X-CSE-MsgGUID: 6kUWRUHbRoyTvTSrFSDrkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,228,1708416000"; d="scan'208";a="62395668"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by orviesa001.jf.intel.com with ESMTP; 24 Apr 2024 19:58:44 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v2 2/7] target/s390x/cpu_model: Drop local @err in
 s390_realize_cpu_model()
Date: Thu, 25 Apr 2024 11:12:27 +0800
Message-Id: <20240425031232.1586401-3-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240425031232.1586401-1-zhao1.liu@intel.com>
References: <20240425031232.1586401-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.21; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.668,
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

Use @errp to fetch error information directly and drop the local
variable @err.

Suggested-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 target/s390x/cpu_models.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index 8cb47d905fb4..052540a866ac 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -577,7 +577,6 @@ S390CPUModel *get_max_cpu_model(Error **errp)
 void s390_realize_cpu_model(CPUState *cs, Error **errp)
 {
     ERRP_GUARD();
-    Error *err = NULL;
     S390CPUClass *xcc = S390_CPU_GET_CLASS(cs);
     S390CPU *cpu = S390_CPU(cs);
     const S390CPUModel *max_model;
@@ -606,8 +605,7 @@ void s390_realize_cpu_model(CPUState *cs, Error **errp)
     cpu->model->cpu_ver = max_model->cpu_ver;
 
     check_consistency(cpu->model);
-    if (!check_compatibility(max_model, cpu->model, &err)) {
-        error_propagate(errp, err);
+    if (!check_compatibility(max_model, cpu->model, errp)) {
         return;
     }
 
-- 
2.34.1


