Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49DCFC54791
	for <qemu-devel@archiver.kernel.org>; Sun, 10 Mar 2024 12:50:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjIcm-0008JL-N3; Sun, 10 Mar 2024 08:49:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rjIck-0008J0-L8
 for qemu-devel@nongnu.org; Sun, 10 Mar 2024 08:49:54 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rjIci-0005rF-4T
 for qemu-devel@nongnu.org; Sun, 10 Mar 2024 08:49:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1710074992; x=1741610992;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=wZVyuCXhkdDSNtsIjfCuY7xN6aPE/fbcGty8FvnIMhg=;
 b=b4CONXfGeRRaVbKAN12OHSkOmzhpYmKNGvXsJfATCUMa0v3QZi2TXvnR
 ZmIigv/xMJdfrrHTwMQdjm4sOavyRmxH1CmUCWruIUm2BPPu/XfFuMOjm
 4id8dQMo+yWH9hC54bcF9xfQ6RDNcNMWfkRxEQt+Dtmaxe0pZCfKAW3UC
 B1SgaLJk9C78GVbADIkCjysW6pDfpWwKoOTGGD5mH1ofjpQ7qyBFFru30
 154hP1x4BXuXClxPrbaD3EW30J8rPOhqj1bnWMxrpG5grdqoONR0hm2lQ
 Yr5R8kAdbYNHRfrx9V6Va8pJ1MCAFce0W173qXGPQHtaDh3HA03Eb58lU A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11008"; a="22201204"
X-IronPort-AV: E=Sophos;i="6.07,114,1708416000"; d="scan'208";a="22201204"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Mar 2024 05:49:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,114,1708416000"; d="scan'208";a="10817214"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa010.fm.intel.com with ESMTP; 10 Mar 2024 05:49:45 -0700
Date: Sun, 10 Mar 2024 21:03:33 +0800
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
Message-ID: <Ze2vpSiicH8vp3hB@intel.com>
References: <20240308160148.3130837-1-zhao1.liu@linux.intel.com>
 <a6c12d41-2801-4425-98e9-351851e2f7a4@linaro.org>
 <ZeuxcZmE9Ejr6acx@intel.com>
 <94997958-3cc3-4e4b-bc92-2eb7e501539e@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94997958-3cc3-4e4b-bc92-2eb7e501539e@linaro.org>
Received-SPF: none client-ip=198.175.65.10;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.945,
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

> Ah no, it is due to commit 01e449809b ("*-user: Deprecate and
> disable -p pagesize").
> 
> No need to respin this series, I queued it in favor of the 4 other
> patches.

Thanks for your queuing!  

-Zhao

