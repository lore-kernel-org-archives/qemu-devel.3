Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56464C47258
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 03:37:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSqRQ-0008Na-Bh; Wed, 24 Jan 2024 22:30:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rSqRF-00082W-1c
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 22:30:02 -0500
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rSqRD-0001Dy-9F
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 22:30:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1706153399; x=1737689399;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=iNM9pCGVMbyxVuz0wFBBI7zYmOMZam6gMTxzOMMdo6k=;
 b=fudkYYQfWEsm4B8ESfCjlhM6iNFVYK3L36YHwflT7vKzoB96zBkQkQ5N
 nBNzBXnHcuMRrCHMvHbA2lQE64Q8gllNLBI5tsy44/n//4S0rvEIMhH4A
 rY1lVZGvfFggj76Qf0rmctnRPceR6NncTiaJBzQKCRbtfapXtAtY0onpQ
 1qU1jjtR4ajGD1+c9At9Ny528kwSOxu4CLHaJSZWwm10eKzcjhhsleyLn
 zCtcc9ipg3L1dWNIyEPffts/BpceaR5PMSmh5jGvy0bjsJAxjbYbCdKSm
 HvaxZv80biX23j6G19WXPZvEA55b2jStPSlnPsPFbF1JQvDrmYnrg4O9S g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="9429218"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="9429218"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jan 2024 19:26:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="2085800"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by orviesa005.jf.intel.com with ESMTP; 24 Jan 2024 19:26:39 -0800
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, xiaoyao.li@intel.com,
 Michael Roth <michael.roth@amd.com>,
 Sean Christopherson <seanjc@google.com>,
 Claudio Fontana <cfontana@suse.de>, Gerd Hoffmann <kraxel@redhat.com>,
 Isaku Yamahata <isaku.yamahata@gmail.com>,
 Chenyi Qiang <chenyi.qiang@intel.com>
Subject: [PATCH v4 34/66] kvm/tdx: Don't complain when converting vMMIO region
 to shared
Date: Wed, 24 Jan 2024 22:22:56 -0500
Message-Id: <20240125032328.2522472-35-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240125032328.2522472-1-xiaoyao.li@intel.com>
References: <20240125032328.2522472-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.10; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.5,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.999, HK_RANDOM_FROM=1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Because vMMIO region needs to be shared region, guest TD may explicitly
convert such region from private to shared.  Don't complain such
conversion.

Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 accel/kvm/kvm-all.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 094ce7695e16..e26e9121b30d 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -2975,9 +2975,22 @@ static int kvm_convert_memory(hwaddr start, hwaddr size, bool to_private)
             ret = ram_block_discard_guest_memfd_range(rb, offset, size);
         }
     } else {
-        error_report("Convert non guest_memfd backed memory region "
-                    "(0x%"HWADDR_PRIx" ,+ 0x%"HWADDR_PRIx") to %s",
-                    start, size, to_private ? "private" : "shared");
+        /*
+         * Because vMMIO region must be shared, guest TD may convert vMMIO
+         * region to shared explicitly.  Don't complain such case.  See
+         * memory_region_type() for checking if the region is MMIO region.
+         */
+        if (!to_private &&
+            !memory_region_is_ram(mr) &&
+            !memory_region_is_ram_device(mr) &&
+            !memory_region_is_rom(mr) &&
+            !memory_region_is_romd(mr)) {
+		    ret = 0;
+        } else {
+            error_report("Convert non guest_memfd backed memory region "
+                        "(0x%"HWADDR_PRIx" ,+ 0x%"HWADDR_PRIx") to %s",
+                        start, size, to_private ? "private" : "shared");
+        }
     }
 
     memory_region_unref(section.mr);
-- 
2.34.1


