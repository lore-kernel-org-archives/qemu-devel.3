Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F035E94625
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 03:00:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpdyV-0008Ap-LL; Mon, 09 Feb 2026 21:59:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vpdyC-0007cW-78
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 21:59:23 -0500
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vpdy4-00049n-HP
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 21:59:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770692352; x=1802228352;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=rAeHvQ95Jt0xFH0E5qmmEaDICDO2TzPR3PyWD5EoqLc=;
 b=fm3vlcMfkhZU9o6NQkuzhrTyTK00+1ocnP7MyEIfBydKoEMgj4XRVJoi
 KQMQkc3POfKcLvzgPFIyAFqZ5B9cXGzWd72N17pza8UkQWXeosaKndnuV
 9mphdnaUna4HTjFRd4/zYQIbNDwEqo6atPUx2GOGHTB0q6CW67X8rXJNd
 idtfXoCxALwsAyNqsSUZD7SMcYRlH8d/lrPAJrO54eXLZ3TOIZJofL+/+
 odL2x7U1kdEr+s3DphoK8Fk/NdGMXaizyn1dGCwGr3cfkU0amPDNyFVoI
 GxP9BRDMTpg9plm7c9JuoqaD/gGEnSoDKaXyEe7wF2FZIHJTx20nBWEY9 g==;
X-CSE-ConnectionGUID: 2F4fN9u8QaOkbmtk43reYw==
X-CSE-MsgGUID: aoMPVT5GTwytirNpUde92Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11696"; a="75659928"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="75659928"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2026 18:59:11 -0800
X-CSE-ConnectionGUID: mPc096nsQw6f2k2CIWWXkg==
X-CSE-MsgGUID: uPjqpBA5TT2tIveyVnwgwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="211800661"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa008.jf.intel.com with ESMTP; 09 Feb 2026 18:59:07 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Zide Chen <zide.chen@intel.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>,
 Zhao Liu <zhao1.liu@intel.com>, qemu-devel@nongnu.org,
 devel@lists.libvirt.org
Subject: [PATCH v2 12/21] qom/object_interfaces: mark properties set from
 qdict & keyval as USER_SET
Date: Tue, 10 Feb 2026 11:23:39 +0800
Message-Id: <20260210032348.987549-13-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260210032348.987549-1-zhao1.liu@intel.com>
References: <20260210032348.987549-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.14; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

object_set_properties_from_qdict() serves as the common entry point for
parsing and setting properties from qdict (and keyval).

This function is primarily utilized for external user configuration:

1. User Creatable Objects (via user_creatable_add_type()):
   - QMP: object-add
   - HMP: object_add
   - CLI: -object (qemu), --object (qemu-img * / qemu-io / qemu-nbd /
         qemu-storage-daemon)
  - Authz list files ("authz-list-file")

2. Device and Machine creation (keyval-based):
   - CLI: -machine / -device
   - QMP/HMP: device_add
   - Failover devices: virtio_net parses user's "qdict" in
    failover_add_primary().

3. Built-in default machine options (MachineClass::default_machine_opts):
   - These hardcoded defaults simulate CLI arguments and are parsed via
     sugar property way or keyval. Treating them as USER_SET is
     acceptable as they emulate user behavior.

There are a few internal corner cases where devices are created using an
internal qdict:
   - Xen USB (usbback_portid_add())
   - Intel HDA (intel_hda_and_codec_init())

Creating devices via internal qdict should be considered as legacy
technical debt and this should be refactored in future work. For these
cases, applying the USER_SET flag is a temporary and acceptable side
effect.

Therefor, update object_set_properties_from_qdict() to explicitly mark
properties as USER_SET.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 qom/object_interfaces.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/qom/object_interfaces.c b/qom/object_interfaces.c
index 415cbee8c5cf..f0d5f9d84300 100644
--- a/qom/object_interfaces.c
+++ b/qom/object_interfaces.c
@@ -56,6 +56,11 @@ static void object_set_properties_from_qdict(Object *obj, const QDict *qdict,
         if (!object_property_set(obj, e->key, v, errp)) {
             goto out;
         }
+
+        if (!object_property_set_flags(obj, e->key,
+                                       OBJ_PROP_FLAG_USER_SET, errp)) {
+            goto out;
+        }
     }
     visit_check_struct(v, errp);
 out:
-- 
2.34.1


