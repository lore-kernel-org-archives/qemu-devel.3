Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA5C9C02182
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 17:39:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taID4-0004S1-VT; Tue, 21 Jan 2025 12:38:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pawan.kumar.gupta@linux.intel.com>)
 id 1taICw-0004Q5-Bv
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 12:38:35 -0500
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pawan.kumar.gupta@linux.intel.com>)
 id 1taICt-0002s2-RG
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 12:38:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1737481112; x=1769017112;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=PN9mmLinmtdOcw8BaxaR+Td9BmXjQNMTWSjoZhSnktE=;
 b=P0x04Qp7YiRZxBSUp2Zvy9pVmCtNEfVZTyYMWc55w0l/vnxMi21FX86Q
 0TDwGUfOr/crvIgcnjtdo53jjdWFQpn8O5cITSXrDI8Z53K5eIyOr+QWl
 LfzaIuWFEzaMUfYMgWJo5a+5rCoKCawUnszXd7GAC/d0bw4FGOeZdlGIO
 YvkPn93B1WxdMMzWV1zbK2cnW+pNiOFwYcuv270JvoXf31LKUZmddatYH
 WaB75kcHT/9M9I3qs4elr390ntgQLwmnf+uHn+VPWV3NqGnoaf4E+IFjm
 K5yxvvWdl44KQxmx0vyxsqxmdFiwPPbweGQAbKqKWuk6jlqdXk5q7yVnA g==;
X-CSE-ConnectionGUID: +XAw8gMITGSJgN+efOcO+w==
X-CSE-MsgGUID: MunJzRBJS6iyuNs+ah9QqQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11322"; a="40723194"
X-IronPort-AV: E=Sophos;i="6.13,222,1732608000"; d="scan'208";a="40723194"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jan 2025 09:38:28 -0800
X-CSE-ConnectionGUID: quz973vCRy+2VaB3KI/lYw==
X-CSE-MsgGUID: aRYNtyBUSNuDuzd2p0eSTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,222,1732608000"; d="scan'208";a="111856058"
Received: from mnoman-mobl1.amr.corp.intel.com (HELO desk) ([10.125.145.99])
 by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jan 2025 09:38:28 -0800
Date: Tue, 21 Jan 2025 09:38:22 -0800
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Tao Su <tao1.su@linux.intel.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, imammedo@redhat.com,
 xiaoyao.li@intel.com, zhao1.liu@linux.intel.com, xuelian.guo@intel.com
Subject: Re: [PATCH 2/4] target/i386: Export BHI_NO bit to guests
Message-ID: <20250121173822.l65ndmkent4aknsa@desk>
References: <20250121020650.1899618-1-tao1.su@linux.intel.com>
 <20250121020650.1899618-3-tao1.su@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250121020650.1899618-3-tao1.su@linux.intel.com>
Received-SPF: none client-ip=192.198.163.13;
 envelope-from=pawan.kumar.gupta@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -72
X-Spam_score: -7.3
X-Spam_bar: -------
X-Spam_report: (-7.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On Tue, Jan 21, 2025 at 10:06:48AM +0800, Tao Su wrote:
> Branch History Injection (BHI) is a CPU side-channel vulnerability, where
> an attacker may manipulate branch history before transitioning from user
> to supervisor mode or from VMX non-root/guest to root mode. CPUs that set
> BHI_NO bit in MSR IA32_ARCH_CAPABILITIES to indicate no additional
> mitigation is required to prevent BHI.
> 
> Make BHI_NO bit available to guests.
> 
> Tested-by: Xuelian Guo <xuelian.guo@intel.com>
> Signed-off-by: Tao Su <tao1.su@linux.intel.com>

Reviewed-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>

