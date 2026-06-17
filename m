Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66F35CD98ED
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 07:44:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZkwK-0002mR-2y; Wed, 17 Jun 2026 03:44:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1wZkwI-0002mE-L8
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 03:43:58 -0400
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1wZkwG-0003e7-Jw
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 03:43:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781682237; x=1813218237;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=vX+SK5biF18HWMNs2gKYB/K/CyR/ty1NqvQZn4jwlro=;
 b=CMmDTDGNKnaqJByp00FheQAbwkRITSSP8FMfp4q99AnQhOYSLwT1xSrS
 3y0OLb15eQnP4/AffbigrA2Jf8Lqc/qJM8GOcV+ktzan8fJ5ctTg5dHUz
 ChK/nMK4VhDQFKMSUxrdvJKab+pgQ2+3GLB7SDz2/aeR/+N+AqIEYb3sT
 rZ5DrQpfeVPDfHNnRPBOqv4WDXyoXfKTpcdGu+84vAiiveIQrjPAIVPE4
 wJNp+VmjUvxLevbk7M26ReLFjJGTSO2iY458gZpcMwD4u5HYmUc3UFxc1
 FjQBEOSl9jHmWERDfBLJKP9Di1p498m5y/3s2+rrRZkCt+jmZ6AYj6o/q w==;
X-CSE-ConnectionGUID: ewt6UdqdSRaYIWk9lfy+4A==
X-CSE-MsgGUID: EIpOkl/vQwadtlpmPQhSog==
X-IronPort-AV: E=McAfee;i="6800,10657,11819"; a="93133611"
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; d="scan'208";a="93133611"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jun 2026 00:43:51 -0700
X-CSE-ConnectionGUID: 4+C+s93ZTHiNEEKhh5bHAw==
X-CSE-MsgGUID: xz7U0y1eTuOMAeeIH2qTyA==
X-ExtLoop1: 1
Received: from junjie-optiplex-micro-plus-7010.bj.intel.com ([10.238.152.98])
 by fmviesa003-auth.fm.intel.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2026 00:43:48 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: Shrihari E S <shrihari.s@samsung.com>
Cc: Junjie Cao <junjie.cao@intel.com>, jic23@kernel.org,
 linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
 qemu-devel@nongnu.org, cpgs@samsung.com, arun.george@samsung.com,
 vikash.k5@samsung.com, s.neeraj@samsung.com, dongjoo.seo1@samsung.com,
 dave@stgolabs.net, gost.dev@samsung.com
Subject: Re: [RFC 5/8] hw/cxl: Wire UIO capability into HDM decoder registers
Date: Wed, 17 Jun 2026 23:45:17 +0800
Message-ID: <20260617154521.520191-1-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260609105836.3702787-6-shrihari.s@samsung.com>
References: <20260609105836.3702787-1-shrihari.s@samsung.com>
 <20260609105836.3702787-6-shrihari.s@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.9; envelope-from=junjie.cao@intel.com;
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

Hi Shrihari,

On Tue,  9 Jun 2026 16:28:33 +0530, Shrihari E S wrote:
> +    ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, UIO,
> +                     (type == CXL2_TYPE3_DEVICE || CXL2_UPSTREAM_PORT) && uio);
>      ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY,
> -                     UIO_DECODER_COUNT, 0);
> +                     UIO_DECODER_COUNT,
> +                     (type == CXL2_TYPE3_DEVICE || CXL2_UPSTREAM_PORT) && uio ?
> +                     decoder_count : 0);

CXL2_UPSTREAM_PORT is an enum constant with a non-zero value, so
"|| CXL2_UPSTREAM_PORT" is always true and the type check collapses
to just "uio" -- every type that reaches hdm_init_common() with
uio=true gets the UIO bit set.  Presumably the intent was:

    (type == CXL2_TYPE3_DEVICE || type == CXL2_UPSTREAM_PORT) && uio

I haven't proposed which types should be in that set -- patch 7 sets
crp->uio_capable on the cxl-rp, so a root port may well be intended
here too.  Either way the current expression isn't gating on type.
The same applies to the UIO_DECODER_COUNT line just below.

Many thanks,
Junjie

