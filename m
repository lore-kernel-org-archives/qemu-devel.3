Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B32EBD5B164
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 08:46:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5hpj-0003A7-B9; Tue, 29 Oct 2024 04:44:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t5hpf-000383-EP
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 04:44:07 -0400
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t5hpd-000848-TA
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 04:44:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730191446; x=1761727446;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=aMSKVSsDVHQPhtuOVweaXCvBB+2RwCjvpnBmbD6sagg=;
 b=NnqrmuYC+jfCIWE1UN1Bjn4ejchZ6a9WS2pvGHJi1YGxc/d98lchGWef
 gJiC3e+kxgbyFbeMKfIAfgJOeL2e9uT4GBotChkVAicRlhU5Wdb8dvQXd
 HURVfO9XXO5CbUo41DSbGc4yhUqI5sxdCf/b/j4qy7sv0cJuw3BD1s7lF
 YHioTkbPA7ntSmQGCyfGfwobwarKEe5SBU85v25eMCvCGg9fUDQb90k15
 6PtEJnDfeNIuCvL1WxTgQK+m65DtLd3ShtpgTGOnd6z6GXdAUiuPKziit
 WR8HMZEaCpsuR+IDqIkzIzxGx/mVEXJn8eMcR1IZblta5CRpeT10VT0hG w==;
X-CSE-ConnectionGUID: GqDU1yTiT+iX0DProNv70w==
X-CSE-MsgGUID: r4PoZX8WTMq+lthk3m01bA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29592837"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="29592837"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2024 01:43:47 -0700
X-CSE-ConnectionGUID: FWktUwy0QaGmm0T+ME1n+Q==
X-CSE-MsgGUID: +wkPxCN/TAu2qBXivemaeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; d="scan'208";a="85847239"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa003.fm.intel.com with ESMTP; 29 Oct 2024 01:43:45 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Cc: qemu-devel@nongnu.org,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 15/16] script/codeconverter/qom_type_info: Deprecate
 MakeTypeRegisterStatic and MakeTypeRegisterNotStatic
Date: Tue, 29 Oct 2024 16:59:33 +0800
Message-Id: <20241029085934.2799066-16-zhao1.liu@intel.com>
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

Deprecate MakeTypeRegisterStatic and MakeTypeRegisterNotStatic because
type_register() will be deprecated, then only type_register_static()
is used.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 .../codeconverter/qom_type_info.py            | 20 -------------------
 1 file changed, 20 deletions(-)

diff --git a/scripts/codeconverter/codeconverter/qom_type_info.py b/scripts/codeconverter/codeconverter/qom_type_info.py
index 255cb59923da..f92c3a4730ef 100644
--- a/scripts/codeconverter/codeconverter/qom_type_info.py
+++ b/scripts/codeconverter/codeconverter/qom_type_info.py
@@ -901,26 +901,6 @@ class TypeRegisterCall(FileMatch):
     regexp = S(r'^[ \t]*', NAMED('func_name', 'type_register'),
                r'\s*\(&\s*', NAMED('name', RE_IDENTIFIER), r'\s*\);[ \t]*\n')
 
-class MakeTypeRegisterStatic(TypeRegisterCall):
-    """Make type_register() call static if variable is static const"""
-    def gen_patches(self):
-        var = self.file.find_match(TypeInfoVar, self.name)
-        if var is None:
-            self.warn("can't find TypeInfo var declaration for %s", self.name)
-            return
-        if var.is_static() and var.is_const():
-            yield self.group_match('func_name').make_patch('type_register_static')
-
-class MakeTypeRegisterNotStatic(TypeRegisterStaticCall):
-    """Make type_register() call static if variable is static const"""
-    def gen_patches(self):
-        var = self.file.find_match(TypeInfoVar, self.name)
-        if var is None:
-            self.warn("can't find TypeInfo var declaration for %s", self.name)
-            return
-        if not var.is_static() or not var.is_const():
-            yield self.group_match('func_name').make_patch('type_register')
-
 class TypeInfoMacro(FileMatch):
     """TYPE_INFO macro usage"""
     regexp = S(r'^[ \t]*TYPE_INFO\s*\(\s*', NAMED('name', RE_IDENTIFIER), r'\s*\)[ \t]*;?[ \t]*\n')
-- 
2.34.1


