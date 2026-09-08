Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D596EC79F99
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 02:50:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3luP-0007u2-0M; Mon, 07 Sep 2026 22:50:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1x3luN-0007tm-GY; Mon, 07 Sep 2026 22:50:03 -0400
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1x3luL-00071R-Dl; Mon, 07 Sep 2026 22:50:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788835801; x=1820371801;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=fbZQTo0ShgS5y2Esy/5sEa5ttyGSVI9woDdGApk69Ss=;
 b=FaJggHJfjEM3ogYpXwScmS04vgZbYHbWfNUU0iAUZScbcCRdQKxk+I2l
 gRC/2SMGs1/xnkgYYYUso4j4/bppUFgBHtn4s1+r4DrfFa/yfpjt0wCbL
 qsVAMSEesh4E3bLLiX+OxZc8AxlqyPBZjWR2S0xHDQv/XkL3NupvBc6dG
 hbPVJqB7JhchfpgWn3mp/4vFHEFo7WoIltVpIUfWfHam9pQLLewfhswhg
 ZiM0kpV9pBN2FrVYdZujudQ/Bs79aECIrbmpA93s3tP7WEcMd3jaUvAjN
 UiWeNbTdISzuAm9DaSXwBvZoH3c1ETnP9TNMfhvZsx8X69eiPfdFANiRw g==;
X-CSE-ConnectionGUID: ny5XnopDRpaktDawOMnGlg==
X-CSE-MsgGUID: XHBUZxtXTpWwcvGsDrOJaw==
X-IronPort-AV: E=McAfee;i="6800,10657,11899"; a="99888173"
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; d="scan'208";a="99888173"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Sep 2026 19:49:57 -0700
X-CSE-ConnectionGUID: GupaeoblS0uZGdgK3k3mYA==
X-CSE-MsgGUID: GWe+0nneQwCSPGKHVGinGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; d="scan'208";a="274999680"
Received: from junjie-desk-dev.bj.intel.com ([10.238.152.71])
 by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Sep 2026 19:49:53 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: Chen Pei <cp0613@linux.alibaba.com>
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, mst@redhat.com,
 imammedo@redhat.com, sunilvl@ventanamicro.com, sunilvl@oss.qualcomm.com,
 jic23@kernel.org, pbonzini@redhat.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu@processmission.com, anisinha@redhat.com, dave.jiang@intel.com,
 alison.schofield@intel.com, guoren@kernel.org, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, linux-cxl@vger.kernel.org
Subject: Re: [PATCH v6 0/6] hw/riscv/virt: Add CXL support to the RISC-V virt
 machine
Date: Tue,  8 Sep 2026 10:49:41 +0800
Message-ID: <20260908024941.492366-1-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260907093735.2753-1-cp0613@linux.alibaba.com>
References: <20260907093735.2753-1-cp0613@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.9; envelope-from=junjie.cao@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Hi Chen Pei,

On Mon,  7 Sep 2026 17:37:27 +0800, Chen Pei wrote:
>   - Collected review tags: Junjie Cao's Reviewed-by/Tested-by on
>     patches 1, 2 and 6.  Michael S. Tsirkin acked the ACPI parts on
>     the v5 cover letter thread.

My tags on 1-6 stand for v6, retested on master 35500e5c41 and on
riscv-to-apply.next b23a62773a. Thanks for the quick turnarounds and
the careful respins throughout.

Alistair, Palmer: no open points from me, and the series touches
nothing under hw/cxl, so there is no dependency on the CXL tree.

Many thanks,
Junjie

