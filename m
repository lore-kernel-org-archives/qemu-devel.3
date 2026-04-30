Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2583DFF887E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 16:14:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wI7Xw-0004CK-VY; Wed, 29 Apr 2026 12:13:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1wI7Xu-0004Bu-9Z
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 12:13:54 -0400
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1wI7Xr-0003oI-ST
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 12:13:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777479231; x=1809015231;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=WB8OnPlJPAdRAt1MDwobbcZZoiEJDK5rqiEuMTypIkc=;
 b=ieMRsnnADIzWgdGUg03/s50XfqVURDcxE1oziEU0XHYsafjx9T2mJzxi
 MxWUroQr2swaiTykNfFt+EPhCoamM0acbkfOUvYIsiYAIK9TtrTQWWtfU
 B10MNyFB9TFofer/rUuLIUb8zG+zr1muEklZI1Mqfdgcug5CG8FTLZcJN
 tODULIs/k5xtegGI230ACvqVDcTQZn5QENVYbpi+GqMGgAx1WSE9SmyIL
 NFy+Huno2+zUyFqDHscxAGsY7OH4dCZvssbxLCTnmYYxR7ISCu775poS7
 G+Uyo9m7j36i7mFDg/OCLwb5DCGlmaRsPZNpg+/RKZ70smbWvGvgdWaVp w==;
X-CSE-ConnectionGUID: ym54vVCiSIO8v2/sJoCDqA==
X-CSE-MsgGUID: kOR4H7W8QNifVx1MtFPf4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="82020309"
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; d="scan'208";a="82020309"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Apr 2026 09:13:46 -0700
X-CSE-ConnectionGUID: jyqM5L0iRCyDF5SimmOzIg==
X-CSE-MsgGUID: CV15JZ+4S22cdwQ9CLLoYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; d="scan'208";a="257644736"
Received: from junjie-optiplex-micro-plus-7010.bj.intel.com ([10.238.152.98])
 by fmviesa002-auth.fm.intel.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 09:13:44 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: zhenzhong.duan@intel.com
Cc: qemu-devel@nongnu.org, mst@redhat.com, jasowang@redhat.com,
 yi.l.liu@intel.com, clement.mathieu--drif@bull.com, philmd@linaro.org,
 Junjie Cao <junjie.cao@intel.com>
Subject: Re: [PATCH v2 1/2] intel_iommu: widen impl.min_access_size to 8 to
 fix MMIO abort
Date: Thu, 30 Apr 2026 08:16:07 +0800
Message-ID: <20260430001607.3505699-1-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <IA3PR11MB9136A84869D0FA17B213347392362@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20260424201842.176953-1-junjie.cao@intel.com>
 <20260424201842.176953-2-junjie.cao@intel.com>
 <IA3PR11MB9136A84869D0FA17B213347392362@IA3PR11MB9136.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.15; envelope-from=junjie.cao@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DATE_IN_FUTURE_06_12=1.947,
 DKIMWL_WL_HIGH=-0.001, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

Hi Zhenzhong,

Thanks for the careful review.

You are right that the code path has changed.  With min_access_size=8
the handler always receives size=8, so a guest 4-byte write to a base
offset calls vtd_set_quad() with a zero-extended value instead of
vtd_set_long().  Two effects:


1. Triggers called unconditionally

CCMD_REG, IOTLB_REG, and FRCD_REG_0_2 originally guarded the
trigger on size==8.  In v2 all three are still no-ops:
vtd_handle_ccmd_write() and vtd_handle_iotlb_write() gate on
ICC/IVT (bit 63), which the zero-extended write just cleared
through the wmask.  For FRCD_REG_0_2, wmask is zero and the w1c
bit 63 does not fire (val bit 63 = 0), so the register is
unchanged.


2. Upper writable bits cleared by zero-extended vtd_set_quad()

Where the upper 32-bit wmask is non-zero, zero-extended val clears
those bits:

  Register       Offset  Upper wmask   Bits cleared
  CCMD_REG       0x28    0xe0000003    ICC, CIRG, 33:32
  IOTLB_REG      0xf8    0xb003ffff    IVT, IIRG, DID
  RTADDR_REG     0x20    0xffffffff    address 63:32
  IQA_REG        0x90    0xffffffff    address 63:32
  IVA_REG        0xf0    0xffffffff    address 63:32
  IRTA_REG       0xb8    0xffffffff    address 63:32

  (IQT_REG, FRCD_0_0, and FRCD_0_2 have upper wmask = 0 -- safe.)

This is safe because a guest must program the full register before
the value is consumed: CCMD/IOTLB fields are set before the action
bit (ICC/IVT) in the high-half write; RTADDR, IQA, and IRTA are
latched only when a GCMD enable bit (SRTP/QIE/SIRTP) fires; IVA is
read when IOTLB invalidation triggers via IVT.

However, a read-back between the low-half and high-half writes
would observe zeroed upper bits -- a real behavioral difference.


Two possible paths

(a) Keep v2 as-is, add comments documenting the safety argument
    above.

(b) Stay with min_access_size=4.  Simply remove all 25 asserts.
    21 sit at non-8-aligned offsets -- unreachable by any 8-byte
    guest access (alignment check rejects them).  The remaining 4
    at 8-aligned offsets (FECTL 0x38, IECTL 0xa0, IEADDR 0xa8,
    PECTL 0xe0) fall through to vtd_set_long() which implicitly
    truncates the value -- safe and no semantic change.  All
    existing size branches in 64-bit register pairs are preserved.

As I see it, both approaches are correct; (a) is simpler but
changes observable semantics in an edge case, (b) is conservative
with zero semantic change.  That said, I am happy to hear any other
suggestions.

Thanks,
Junjie

