Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFB88FF8867
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 02:09:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHXsH-0006Qr-DL; Mon, 27 Apr 2026 22:08:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1wHXsF-0006QY-Ca
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 22:08:31 -0400
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1wHXsC-0002Vs-LE
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 22:08:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777342109; x=1808878109;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Bx+nxCuKfyu+AgDAcfrv51+CejyVtRWx2Nfdfysvr6Y=;
 b=CmQkciqliJCJP0z4RWlIC18KB/bKaQrRP47O1ULCyMYFd1F7r7sg+BAj
 NwOD8jtmE5saUwPrY5IH5JFX/yvvyw6XwTnSrV/nt1RBpZzehRaYLJNJl
 OjjJ/Kb9foyyITR1e6xJSzLXpyYtx/0L+MOXIh6ZQdx8ZGcm8hNzD/V2G
 eB+6n4o2Gp4lX/lYXMSbQR/NZdRGARACbQ5WBX4S8/deIgxzrLi/C+yiy
 VmWfL2/lWTd4Y6GEHohr960rvzCZeZp4XZGxBn7jkSagzyhb+sYdKOh/n
 5n/QDTOB11F7vLGzedgIRUdzDczOSlRCA3yslkVJtqWjyMTq/FYwyvdiJ w==;
X-CSE-ConnectionGUID: Wp2bjDqKQNGxthX2pRgikA==
X-CSE-MsgGUID: kmd3ksKlTeWpzZD+Cvr9dw==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="95810513"
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; d="scan'208";a="95810513"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Apr 2026 19:08:24 -0700
X-CSE-ConnectionGUID: wvyM/DVhSwO1DtmaUnuJSw==
X-CSE-MsgGUID: 2u2VRTrsSCeGldQ/nM93hg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; d="scan'208";a="231165462"
Received: from junjie-optiplex-micro-plus-7010.bj.intel.com ([10.238.152.98])
 by fmviesa008-auth.fm.intel.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 19:08:22 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, kraxel@redhat.com, philmd@linaro.org,
 balaton@eik.bme.hu, chad@jablonski.xyz, junjie.cao@intel.com
Subject: Re: [PATCH 1/2] hw/display/cirrus_vga: Fix packed-24 color-expansion
 transparent pattern fills
Date: Tue, 28 Apr 2026 18:10:31 +0800
Message-ID: <20260428101031.3469905-1-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260410183249.4046456-2-peter.maydell@linaro.org>
References: <20260410183249.4046456-1-peter.maydell@linaro.org>
 <20260410183249.4046456-2-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.8; envelope-from=junjie.cao@intel.com;
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

On Fri, 10 Apr 2026 19:32:48 +0100, Peter Maydell wrote:
> hw/display/cirrus_vga: Fix packed-24 color-expansion transparent
>  pattern fills

Reviewed-by: Junjie Cao <junjie.cao@intel.com>
Tested-by: Junjie Cao <junjie.cao@intel.com>

