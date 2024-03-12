Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CE78C54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 06:34:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjvi6-00024D-6Q; Tue, 12 Mar 2024 02:34:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rjvht-00023h-QB
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 02:33:51 -0400
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rjvhr-0007kG-EV
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 02:33:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1710225227; x=1741761227;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=A40cpWHNCMBGRoSma3Qn8LijYDYVsOTMZUZgVJWLNEI=;
 b=jEsOqEczLH6xEImyoUxh1NeTBBsctb6ASDnWAAxjI7m70XGnLLQrgwAT
 RJJlVJlT3vCf/0ngd8C3qcTIzAJDUs3PWjs5GRkD2vEmJKbX4XvpNnFST
 Fe0+ClC5Ga1Sw21hpdgybsOnaUeCnlSnD0UE9fhHAz+aTcPmFAZGxjbG7
 AlNGB9hrDXMs+VszERSJIJXNLlvP4Bj6v6U5ft41rV9I2pqO/zqCOGunc
 2mVRCilok+MMTKTerzBW45ehvwFSJEnwO65jS2/IKJQc1txojBRCBd2Ur
 5irLAVbUUkAU6Q2S1IPs/FJqZ0Efrkf69xSn2KHs4RY5x/2NqPbcxOaHE Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11010"; a="4771014"
X-IronPort-AV: E=Sophos;i="6.07,118,1708416000"; 
   d="scan'208";a="4771014"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Mar 2024 23:32:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,118,1708416000"; d="scan'208";a="34608643"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa002.fm.intel.com with ESMTP; 11 Mar 2024 23:32:43 -0700
Date: Tue, 12 Mar 2024 14:46:31 +0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>, qemu-devel@nongnu.org,
 Xiaoling Song <xiaoling.song@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH v2 00/13] Cleanup on SMP and its test
Message-ID: <Ze/6R0kT++CKfaGP@intel.com>
References: <20240308160148.3130837-1-zhao1.liu@linux.intel.com>
 <a6c12d41-2801-4425-98e9-351851e2f7a4@linaro.org>
 <ZeuxcZmE9Ejr6acx@intel.com>
 <94997958-3cc3-4e4b-bc92-2eb7e501539e@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <94997958-3cc3-4e4b-bc92-2eb7e501539e@linaro.org>
Received-SPF: none client-ip=192.198.163.18;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.029,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

Hi Philippe,

On Sat, Mar 09, 2024 at 02:49:17PM +0100, Philippe Mathieu-Daudé wrote:
> Date: Sat, 9 Mar 2024 14:49:17 +0100
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: Re: [PATCH v2 00/13] Cleanup on SMP and its test
> 
> On 9/3/24 01:46, Zhao Liu wrote:
> > Hi Philippe,
> > 
> > > 
> > > Can you share your base commit please?
> > > 
> > > Applying: hw/core/machine-smp: Remove deprecated "parameter=0" SMP
> > > configurations
> > > Applying: hw/core/machine-smp: Deprecate unsupported "parameter=1" SMP
> > > configurations
> > > error: patch failed: docs/about/deprecated.rst:47
> > > error: docs/about/deprecated.rst: patch does not apply
> > > Patch failed at 0002 hw/core/machine-smp: Deprecate unsupported
> > > "parameter=1" SMP configurations
> > > 
> > 
> > The base commit is e1007b6bab5cf ("Merge tag 'pull-request-2024-03-01'
> > of https://gitlab.com/thuth/qemu into staging").
> > 
> > But I think this conflict is because of the first 4 patches of mudule
> > series you picked. Let me rebase this series on that module series and
> > refresh a v3.
> 
> Ah no, it is due to commit 01e449809b ("*-user: Deprecate and
> disable -p pagesize").
> 
> No need to respin this series, I queued it in favor of the 4 other
> patches.

In the commit 54c4ea8f3ae6 ("hw/core/machine-smp: Deprecate unsupported
'parameter=1' SMP configurations"), the smp related thing is put under
the section "User-mode emulator command line arguments" instead of "System
emulator command line arguments".

Is this not quite right...or does it need to be fixed? If so I can tweak
and clean it up with a minor patch. ;-)

Thanks,
Zhao



