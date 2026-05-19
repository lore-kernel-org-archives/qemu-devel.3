Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CDB2CD4F3C
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 02:47:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPATd-0002On-DB; Mon, 18 May 2026 22:46:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1wPATE-0002Lj-Bn; Mon, 18 May 2026 22:46:15 -0400
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1wPATC-0000b3-TP; Mon, 18 May 2026 22:46:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779158771; x=1810694771;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=CBWUW2b1EhtSvPe/HKlUv9QP0AZ9AMq7FiJ1YBl3ACc=;
 b=mXq3VXTsxwBXxQdpT952RGIca32peKQt9hiPGxTprMe84NOV+T5w4xyB
 VOBOR2d8L7R7PNFr8LXpEkQQZmoF7dVbtUcmECK+kw3RZizf/Xbb8BzgL
 JDBvsPOrOFu4bAy24On2juQZCSS4aICMzJFv35Ftje8UMoLAxKpzt28go
 4SZqOCBIRPMVeFGOyaJ+mEwnDKc/EaaoMVlEBQrzHlHPdwnmT+dUhFLn3
 sgrOmQEfDfmaL7+v9Auw4y3Ci+RERS6S+1ngFX/J1FAXRHhytmJgaqqc5
 Z0IkBMG8yJr3G+16tpMB1jReFsO4cAYD3nJqJhAfxgp8JaVB4Yv47pEUD A==;
X-CSE-ConnectionGUID: enPp4iTPSO+f88IBpaxaLg==
X-CSE-MsgGUID: f66FKlTvTr+CNmBOPAgT+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11790"; a="79878362"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; d="scan'208";a="79878362"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 May 2026 19:46:09 -0700
X-CSE-ConnectionGUID: hyaPeDJSTLWr9wDV5swuvg==
X-CSE-MsgGUID: heJwj7hPQcWjXK7EBVfUsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; d="scan'208";a="239879586"
Received: from junjie-desk-dev.bj.intel.com ([10.238.152.71])
 by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 May 2026 19:46:07 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu, chad@jablonski.xyz, philmd@linaro.org, bea1e@proton.me,
 qemu-stable@nongnu.org, junjie.cao@intel.com
Subject: [PATCH v2 2/2] hw/display/ati: guard against zero bpp in
 ati_host_data_flush
Date: Tue, 19 May 2026 10:39:37 +0800
Message-ID: <20260519023937.439077-3-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260519023937.439077-1-junjie.cao@intel.com>
References: <20260519023937.439077-1-junjie.cao@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.17; envelope-from=junjie.cao@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

ati_bpp_from_datatype() returns 0 for unrecognized dp_datatype nibble
values (0, 1, or >= 7). ati_host_data_flush() only guards against the
bpp == 24 case but not bpp == 0, leading to:

  1. Division by zero at "pix_count /= ctx.bpp" (SIGFPE) when
     src_datatype is SRC_COLOR.
  2. g_assert_not_reached() in stn_he_p() when bypp (= bpp/8 = 0)
     hits the default case of the size switch.

Both are guest-triggerable via MMIO writes to the dp_datatype register
while a HOST_DATA blit is active.

Add an explicit bpp == 0 check with LOG_GUEST_ERROR before proceeding
with the blit, consistent with the existing check in ati_2d_do_blt().

Reported-by: Feifan Qian <bea1e@proton.me>
Cc: qemu-stable@nongnu.org
Signed-off-by: Junjie Cao <junjie.cao@intel.com>
---
 hw/display/ati_2d.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
index 8ef82bb87f..22dd811bd8 100644
--- a/hw/display/ati_2d.c
+++ b/hw/display/ati_2d.c
@@ -377,6 +377,11 @@ bool ati_host_data_flush(ATIVGAState *s)
 
     setup_2d_blt_ctx(s, &ctx);
 
+    if (!ctx.bpp) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "host_data_blt: invalid bpp from datatype\n");
+        return false;
+    }
     if (ctx.bpp == 24) {
         qemu_log_mask(LOG_UNIMP,
                       "host_data_blt: unsupported in 24 bits mode\n");
-- 
2.43.0


