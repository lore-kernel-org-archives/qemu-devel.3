Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 855F7CA0EDC
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Aug 2025 13:18:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umXiY-0003GS-E1; Thu, 14 Aug 2025 09:10:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mikko.ylinen@linux.intel.com>)
 id 1umX81-00057e-8H
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 08:32:21 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mikko.ylinen@linux.intel.com>)
 id 1umX7r-0000D3-Ta
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 08:32:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1755174732; x=1786710732;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=bevTCByl6UBAESZRwEE97NINll5vS1LciZXikIHEC8o=;
 b=mnWTkhhmN9SHyYuLA0xFR99a9HVWWagHBUPfVFMQ6ODfcIa2wbEzVWbg
 UlSzY9EAwUfjLlZCwx/THmx3ftZ8ppCp8H5GjB8VKTDtMVI9+zEvvfO6q
 m1z8mM36NvuruehVzPcSFLNRHwlC/wJ2lvQbjyXobZ89bQR6SxdPTtyuO
 N9McNB9ln80qFiSNJDKIKea3/Js5ZKCHl+U+ks9pd7wNug+bt1cS6nQ4q
 lWTLYVsyusjcapZT2t0Gftibcva9GpRlV3H9UdY9iX/7QJxtNTx2+24KG
 zTF41vmVpeQXpCZGCihFtTlEdVtjqe2ElzF2liVLDaawEWL6HcRYlMVzO w==;
X-CSE-ConnectionGUID: 3b/TJLF3StOHn28pnNH/Gw==
X-CSE-MsgGUID: M6gaE4Q+QvGYma7/SNlH3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="68863810"
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; d="scan'208";a="68863810"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Aug 2025 05:32:01 -0700
X-CSE-ConnectionGUID: aWJQV8pFSzygInbYZWH79A==
X-CSE-MsgGUID: DG5HGnljTY65IlL+BV7JTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; d="scan'208";a="167010450"
Received: from agladkov-desk.ger.corp.intel.com (HELO himmelriiki.intel.com)
 ([10.245.244.92])
 by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Aug 2025 05:32:00 -0700
From: Mikko Ylinen <mikko.ylinen@linux.intel.com>
To: qemu-devel@nongnu.org
Cc: xiaoyao.li@intel.com
Subject: [PATCH] docs/system/i386: document TDG.VP.VMCALL<GetQuote> and TD
 attestation
Date: Thu, 14 Aug 2025 15:31:44 +0300
Message-ID: <20250814123144.136966-1-mikko.ylinen@linux.intel.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=192.198.163.10;
 envelope-from=mikko.ylinen@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 14 Aug 2025 09:09:26 -0400
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

TD attestation has been supported since the handling of
TDG.VP.VMCALL<GetQuote> was added. However, the documentation still
states that TD attestation is future work.

Update TDX documention to match with the code and move the TD attestation
section up to the feature configuration section. In addition, add a link
to TDX Enabling Guide that gives further details on how to setup the
platform for attestation to work.

Fixes: 40da501d8989 ("i386/tdx: handle TDG.VP.VMCALL<GetQuote>")
Reported-by: Benny Fuhry <benny.fuhry@intel.com>
Signed-off-by: Mikko Ylinen <mikko.ylinen@linux.intel.com>
---
 docs/system/i386/tdx.rst | 40 ++++++++++++++++++++++++++--------------
 1 file changed, 26 insertions(+), 14 deletions(-)

diff --git a/docs/system/i386/tdx.rst b/docs/system/i386/tdx.rst
index 8131750b64..47d8fd023f 100644
--- a/docs/system/i386/tdx.rst
+++ b/docs/system/i386/tdx.rst
@@ -97,6 +97,28 @@ if the fixed-1 feature is requested to be disabled explicitly. This is newly
 added to QEMU for TDX because TDX has fixed-1 features that are forcibly enabled
 by TDX module and VMM cannot disable them.
 
+TD attestation
+~~~~~~~~~~~~~~
+
+In TD guest, the attestation process is used to verify the TDX guest
+trustworthiness to other entities before provisioning secrets to the guest.
+
+TD attestation is initiated first by calling TDG.MR.REPORT inside TD to get the
+REPORT. Then the REPORT data needs to be converted into a remotely verifiable
+TD-Quote signed by a service hosting TD-Quoting Enclave operating on the host.
+
+The guest issues TDG.VP.VMCALL<GetQuote> which is forwarded to user space by KVM.
+QEMU handles the request and sends the REPORT further to a Quote Generation Service
+(QGS) for signing. On success, a TD-Quote is returned back to the guest.
+
+To enable TD attestation, QGS destination must be configured using a
+"quote-generation-socket" property. Intel reference TDX QGS supports the
+following socket addresses: `{"type":"unix", "path":"/var/run/tdx-qgs/qgs.socket"}`
+or `{"type": "vsock", "cid":"2","port":"<portnum>"}`.
+
+See TDX Enabling Guide for details on how to provision the platform for
+TD attestation to work.
+
 Launching a TD (TDX VM)
 -----------------------
 
@@ -112,6 +134,9 @@ split kernel-irqchip, as below:
         -machine ...,confidential-guest-support=tdx0 \\
         -bios OVMF.fd \\
 
+Additional properties and their descriptions are documented in the QAPI
+schema for the 'tdx-guest' object.
+
 Restrictions
 ------------
 
@@ -135,19 +160,6 @@ SEAMCALLs and corresonponding QEMU change.
 
 It's targeted as future work.
 
-TD attestation
---------------
-
-In TD guest, the attestation process is used to verify the TDX guest
-trustworthiness to other entities before provisioning secrets to the guest.
-
-TD attestation is initiated first by calling TDG.MR.REPORT inside TD to get the
-REPORT. Then the REPORT data needs to be converted into a remotely verifiable
-Quote by SGX Quoting Enclave (QE).
-
-It's a future work in QEMU to add support of TD attestation since it lacks
-support in current KVM.
-
 Live Migration
 --------------
 
@@ -158,4 +170,4 @@ References
 
 - `TDX Homepage <https://www.intel.com/content/www/us/en/developer/articles/technical/intel-trust-domain-extensions.html>`__
 
-- `SGX QE <https://github.com/intel/SGXDataCenterAttestationPrimitives/tree/master/QuoteGeneration>`__
+- `TDX Enabling Guide <https://cc-enabling.trustedservices.intel.com/intel-tdx-enabling-guide/01/introduction/>`__
-- 
2.50.1


