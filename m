Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00A45C25B7C
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 06:19:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCCds-0007M3-Es; Wed, 29 May 2024 02:18:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sCCdr-0007LL-3k
 for qemu-devel@nongnu.org; Wed, 29 May 2024 02:18:31 -0400
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sCCdp-0004RQ-GW
 for qemu-devel@nongnu.org; Wed, 29 May 2024 02:18:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1716963510; x=1748499510;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=YdimhYvBAgr8+wLbMX23ZiJusjLsqD1ddhi6dNEO7gc=;
 b=eEz7usxJeVXiCXflsCkNhjF3360JkoX7wc0sXI67gn3KGLKt9+tnQXja
 OX7Yatzz0coZ+tzPdQrKYZHfRMYp05rP+TrNJC3QqDH6ToqjE8oqlcd3i
 6UeW1QtJlabLhHib57yCfbWvOY+oj6Ckb2/t+xcejoy9ZhTMjzkO1fN3Y
 P4vI1DcwDhXDQfvGMBxn5WPSYasRzOZtTj4R4FrNBgdHNX0QWS/ED19oE
 jiDzsaXfoaGFjKWPAM664Q263xWEIaNFMW07Y27s2y3xteF28uEDMl6ih
 hluijAkqSH74UIaB9VFyhT5URSY6RlbV3uWzEiLqEL+5luPNkL43Cxcpw A==;
X-CSE-ConnectionGUID: Xq15/+sNR466nGoBEonyVA==
X-CSE-MsgGUID: CceZh5tdTsqcpywo3XuyuA==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="24760174"
X-IronPort-AV: E=Sophos;i="6.08,197,1712646000"; d="scan'208";a="24760174"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 May 2024 23:18:27 -0700
X-CSE-ConnectionGUID: QAkNAF/4Q5KDn84kaQDQ9A==
X-CSE-MsgGUID: 0UPamZekSnOBcVSqQ7XoTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,197,1712646000"; d="scan'208";a="35935454"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa007.jf.intel.com with ESMTP; 28 May 2024 23:18:24 -0700
Date: Wed, 29 May 2024 14:33:48 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH v5 21/23] hw/i386/pc: Simplify DEFINE_I440FX_MACHINE()
 macro
Message-ID: <ZlbMTANLtj58yTi3@intel.com>
References: <20240529051539.71210-1-philmd@linaro.org>
 <20240529051539.71210-22-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240529051539.71210-22-philmd@linaro.org>
Received-SPF: pass client-ip=198.175.65.12; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.034,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, May 29, 2024 at 07:15:37AM +0200, Philippe Mathieu-Daudé wrote:
> Date: Wed, 29 May 2024 07:15:37 +0200
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: [PATCH v5 21/23] hw/i386/pc: Simplify DEFINE_I440FX_MACHINE() macro
> X-Mailer: git-send-email 2.41.0
> 
> Last commit removed the last non-NULL use of DEFINE_I440FX_MACHINE
> 3rd parameter. 'compatfn' is now obsolete, remove it.
> 
> Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  hw/i386/pc_piix.c | 62 ++++++++++++++++++++++-------------------------
>  1 file changed, 29 insertions(+), 33 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


