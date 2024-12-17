Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B850E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 16:23:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNaL8-0005S8-52; Tue, 17 Dec 2024 11:22:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tNaL6-0005QG-EH
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 11:22:28 -0500
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tNaL0-0005rK-1l
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 11:22:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1734452542; x=1765988542;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=bSSJtAhFi9+wn70gIbA8jtwpLbdp/CJSIX5+4YACGcU=;
 b=gKMwlF0tnAvI3Z+4ffCDBAFKNVbty+5ljP+IdbWr+qJHlFSOu+k/3Btg
 DtEJsptOcrmP4ynSB1vofvisjzE5BAwrzDWeSsN0yv4XTPMW8ZbxaywKf
 w8EKKtfEcg3L3p/JewHrJlaGMuRx2nO3NHw35XBm1LyYchvDiR4o8b8VS
 mOblobyXSZX/fy9Zg4JC/CSbSXhlX5m+4nNo6K447k3rhsne4CetZxUBq
 tTsFgSCqzC/dcybHA6GbjPOepiJ0KR0nW+PbBf9LOx1HBu7+vUVZNObfA
 R9ePS78KyglRGgBHXwDVkDjZOMLU3jwzw4G8qhcJyHe9+mbdq6WW2+Gcf g==;
X-CSE-ConnectionGUID: MQYIVFNkT/KjNbLfhE+JmQ==
X-CSE-MsgGUID: J69zs9FBRHahbZe+PM+vtQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11288"; a="34780158"
X-IronPort-AV: E=Sophos;i="6.12,242,1728975600"; d="scan'208";a="34780158"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Dec 2024 08:13:06 -0800
X-CSE-ConnectionGUID: gtGARqVeRha+l45LWCoExA==
X-CSE-MsgGUID: FyrE7Um2R0K/hTZIkP7hBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,242,1728975600"; d="scan'208";a="97615422"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa006.jf.intel.com with ESMTP; 17 Dec 2024 08:13:04 -0800
Date: Wed, 18 Dec 2024 00:31:43 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH 2/2] target/i386: Print CPUID subleaf info for
 unsupported feature
Message-ID: <Z2Gnb4zL9NwWNZTf@intel.com>
References: <20241217123932.948789-1-xiaoyao.li@intel.com>
 <20241217123932.948789-3-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241217123932.948789-3-xiaoyao.li@intel.com>
Received-SPF: pass client-ip=192.198.163.17; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -54
X-Spam_score: -5.5
X-Spam_bar: -----
X-Spam_report: (-5.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-1.116,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Tue, Dec 17, 2024 at 07:39:32AM -0500, Xiaoyao Li wrote:
> Date: Tue, 17 Dec 2024 07:39:32 -0500
> From: Xiaoyao Li <xiaoyao.li@intel.com>
> Subject: [PATCH 2/2] target/i386: Print CPUID subleaf info for unsupported
>  feature
> X-Mailer: git-send-email 2.34.1
> 
> Some CPUID leaves have meaningful subleaf index. Print the subleaf info
> in feature_word_description for CPUID features.
> 
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  target/i386/cpu.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


