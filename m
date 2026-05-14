Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 310C3CD4F39
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2026 05:42:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNOoy-0002jb-6O; Thu, 14 May 2026 01:41:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1wNOow-0002jJ-Ps
 for qemu-devel@nongnu.org; Thu, 14 May 2026 01:41:18 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1wNOos-0000T0-1I
 for qemu-devel@nongnu.org; Thu, 14 May 2026 01:41:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778737274; x=1810273274;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=EQL0GZBA27tPrNMU6rL7XBYMd0x16CudSqv2W8IftT8=;
 b=A6a0IJXFHgqez3ESPJ+LIsb/Cs5YY5HMd16fvrmsuYh/ZOiOtXLlTER4
 AgeJ7d5X9xa9/KuvWoFpJDar2Ke2iLj/YidNYlq9jjgaR0BiVVozKbAhm
 xDe8NSk62OQdgHZoE5u2njxwBz39XXeqt+hNayP/IEoIqzP07knj53UQb
 adym/5JVYNG/OqRbbNvfITkAZ/u/pQtZb+6YqrlnD/aKHlUwt58E/ivU4
 AW9Y+dUiupFfLpHb8hp3K6r+U+EvfBuNlTopnofh1gG6M2TzK1j8NSMAk
 xF92KNzfS0bvrWGXvMtSguvfOJnkXLiYm15PKBtzfJVYqUdnrWdwS2c9C w==;
X-CSE-ConnectionGUID: Z85YVD4ESDC69gJL8VtNFQ==
X-CSE-MsgGUID: 8mZKnsPgRyGnv9a0BOqNVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11785"; a="105132374"
X-IronPort-AV: E=Sophos;i="6.23,234,1770624000"; d="scan'208";a="105132374"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 May 2026 22:41:09 -0700
X-CSE-ConnectionGUID: brhjLntkS+aXEZOGiC4jXA==
X-CSE-MsgGUID: lLEJH1uwTF6HjsLdSmz0GA==
X-ExtLoop1: 1
Received: from junjie-optiplex-micro-plus-7010.bj.intel.com ([10.238.152.98])
 by fmviesa003-auth.fm.intel.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 22:41:06 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: yi.l.liu@intel.com,
	zhenzhong.duan@intel.com
Cc: qemu-devel@nongnu.org, philmd@linaro.org, mst@redhat.com,
 jasowang@redhat.com, clement.mathieu--drif@bull.com,
 marcel.apfelbaum@gmail.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, farosas@suse.de, lvivier@redhat.com,
 Junjie Cao <junjie.cao@intel.com>
Subject: Re: [PATCH v3 1/2] intel_iommu: fix guest-triggerable abort on
 oversized MMIO access
Date: Thu, 14 May 2026 21:42:11 +0800
Message-ID: <20260514134211.48018-1-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <IA3PR11MB913608B2CB25D851EE72D35492382@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <IA3PR11MB913608B2CB25D851EE72D35492382@IA3PR11MB9136.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.7; envelope-from=junjie.cao@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DATE_IN_FUTURE_06_12=1.947,
 DKIMWL_WL_HIGH=-0.445, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

Hi Yi and Zhenzhong,

Thanks both.

On Yi's question -- I enumerated the 25 v2 assert sites and checked
offset & 7.  21 (3 reads + 18 writes) sit at non-8-aligned offsets
and are unreachable (memory_region_access_valid() rejects 8-byte
access there) -- just deleted.  The remaining 4, all writes at
8-aligned offsets, are reachable: FECTL 0x38, IECTL 0xa0,
IEADDR 0xa8, PECTL 0xe0.

(FEADDR 0x40 is 8-aligned too but already takes 8-byte writes via
vtd_set_quad() for Xen; GCMD 0x18 and VER 0x0 never asserted on
size and their default/long paths already truncate.)

On the log -- Yi, fair point that the truncation is harmless from
QEMU's side.  The one thing I'd gently float: the VT-d spec is
silent on oversized accesses to 32-bit registers, so the guest is
in undefined territory, and Zhenzhong's LOG_GUEST_ERROR suggestion
is free unless -d guest_errors is passed.  If that reasoning works
for you, I'd combine both -- keep the log (with Zhenzhong's API)
and add the comment you asked for, so future maintainers don't
delete the block as "harmless":

    /*
     * 32-bit register at an 8-byte-aligned offset: a well-formed
     * 8-byte guest access reaches this handler.  vtd_set_long()
     * takes uint32_t and truncates the high half -- undefined
     * per the VT-d spec but harmless here.  Flag it so
     * -d guest_errors surfaces the guest-side bug.
     */
    if (size != 4) {
        qemu_log_mask(LOG_GUEST_ERROR,
                      "%s: invalid %u-byte access to 32-bit reg "
                      "addr=0x%" PRIx64 "\n", __func__, size, addr);
    }
    vtd_set_long(s, addr, val);
    vtd_handle_*_write(s);

Happy either way -- if you'd still rather drop the log, I'll do
that in v4.

Thanks,
Junjie

