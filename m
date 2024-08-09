Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51CF8C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2024 11:49:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1scO6y-00007b-2m; Fri, 09 Aug 2024 07:48:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lkp@intel.com>) id 1scO6v-0008WT-9q
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 07:48:45 -0400
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lkp@intel.com>) id 1scO6o-0003Ci-1F
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 07:48:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1723204118; x=1754740118;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=xzbTSU7hvjS4ZqdqP09hBUAYcDwniEeE/J0sXofj5Hs=;
 b=cWsQ/f+QHd/IG2xxYpOT6hpY8NGEiG6retpTOKPV9PBO4NJ2+kQ3UQGK
 wEB0zKTo7goSSl2Woz02T1OCmwV+CTmeDU0CJnXT1ki8x6TUpPoEGnEjj
 Z1+pgDKWNOhTCpstXXjaOnS5Z5v5NxXkxFo/rhPgicf57rJkBhD21yPIY
 jLNL0qYRIDxXFuE2i9DuCgXyFxseY30GUMyr1j5S4fchq3bGu+ZDFUic/
 gR7LL56nz3nscsdGgu4BKiQhowGlT8YcrjtW21pEb7vd1R4gNo++hfXkm
 aXUE+ex31RLcmcIyW9uDq40EAMf/erXEddlq04FWlPgrKTDbBrk5IV5cS A==;
X-CSE-ConnectionGUID: +1SZl31MQT6wumtJTF+FAA==
X-CSE-MsgGUID: ugY9y998S8+r/qIY0guW+g==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="21548730"
X-IronPort-AV: E=Sophos;i="6.09,276,1716274800"; d="scan'208";a="21548730"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Aug 2024 04:48:35 -0700
X-CSE-ConnectionGUID: GmvAt9TMShyFFtIoHfNpOg==
X-CSE-MsgGUID: 9XXBcAUVSH6fAeMx6zhw7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,276,1716274800"; d="scan'208";a="62500435"
Received: from unknown (HELO b6bf6c95bbab) ([10.239.97.151])
 by orviesa004.jf.intel.com with ESMTP; 09 Aug 2024 04:48:30 -0700
Received: from kbuild by b6bf6c95bbab with local (Exim 4.96)
 (envelope-from <lkp@intel.com>) id 1scO6d-0007u6-2v;
 Fri, 09 Aug 2024 11:48:28 +0000
Date: Fri, 9 Aug 2024 19:48:11 +0800
From: kernel test robot <lkp@intel.com>
To: Shiyang Ruan <ruansy.fnst@fujitsu.com>, qemu-devel@nongnu.org,
 linux-cxl@vger.kernel.org, linux-edac@vger.kernel.org,
 linux-mm@kvack.org, dan.j.williams@intel.com,
 vishal.l.verma@intel.com, Jonathan.Cameron@huawei.com,
 alison.schofield@intel.com
Cc: oe-kbuild-all@lists.linux.dev, bp@alien8.de, dave.jiang@intel.com,
 dave@stgolabs.net, ira.weiny@intel.com, james.morse@arm.com,
 linmiaohe@huawei.com, mchehab@kernel.org, nao.horiguchi@gmail.com,
 rric@kernel.org, tony.luck@intel.com, ruansy.fnst@fujitsu.com
Subject: Re: [PATCH v4 2/2] cxl: avoid duplicated report from MCE & device
Message-ID: <202408091914.TFbjPuNQ-lkp@intel.com>
References: <20240808151328.707869-3-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240808151328.707869-3-ruansy.fnst@fujitsu.com>
Received-SPF: pass client-ip=192.198.163.14; envelope-from=lkp@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Shiyang,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tip/x86/core]
[also build test WARNING on cxl/next linus/master v6.11-rc2 next-20240809]
[cannot apply to cxl/pending]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Shiyang-Ruan/cxl-core-introduce-device-reporting-poison-hanlding/20240809-013658
base:   tip/x86/core
patch link:    https://lore.kernel.org/r/20240808151328.707869-3-ruansy.fnst%40fujitsu.com
patch subject: [PATCH v4 2/2] cxl: avoid duplicated report from MCE & device
config: x86_64-randconfig-121-20240809 (https://download.01.org/0day-ci/archive/20240809/202408091914.TFbjPuNQ-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240809/202408091914.TFbjPuNQ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408091914.TFbjPuNQ-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/cxl/core/mbox.c:1465:1: sparse: sparse: symbol 'cxl_mce_records' was not declared. Should it be static?
   drivers/cxl/core/mbox.c: note: in included file (through include/linux/gfp.h, include/linux/xarray.h, include/linux/list_lru.h, ...):
   include/linux/mmzone.h:2018:40: sparse: sparse: self-comparison always evaluates to false

vim +/cxl_mce_records +1465 drivers/cxl/core/mbox.c

  1464	
> 1465	DEFINE_XARRAY(cxl_mce_records);
  1466	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

