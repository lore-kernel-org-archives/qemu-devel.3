Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A46EC5475B
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Mar 2024 00:34:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rikeS-0004EF-Os; Fri, 08 Mar 2024 19:33:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rikeQ-0004Ds-H5
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 19:33:22 -0500
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rike6-0004zV-IM
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 19:33:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709944382; x=1741480382;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=hx6j4/MUb1luJsn2GGe8j/JH5xwP6tDDG7xQJn722TY=;
 b=L00/1k+WpzMeS3RJwWOSPKA3p6yVhU7RMRut4GPB7c/pR6/cN1bbFqc7
 lRLUnphncwJ4fJwCnwPE4n580FFUYfeaEsu1wORaDcBHLj1h2nFE5ZGNc
 CgU9RL0myZS6PS/ncyN3JNM9bTHuw5W9ZqDn0U0ACb31iG59o8N9nk8Qf
 Yg+hd3Qv4yi1yLYPy+OuBixmMPziyh/zq8IEf/cvuEVXg91+GUUXSbqtz
 yLy71byu5mUxHWJuk/Gg+SYzZ+HB8FZpYpZltVh6EpNilU+wNuOIhjKSO
 LF23Ye1TwG2NwhsC8aPrJN+ULevBnGGQDaG3zIDTHuk7d+9ybiMG8dQff g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11007"; a="15248365"
X-IronPort-AV: E=Sophos;i="6.07,111,1708416000"; d="scan'208";a="15248365"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Mar 2024 16:32:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,111,1708416000"; d="scan'208";a="11176915"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa008.jf.intel.com with ESMTP; 08 Mar 2024 16:32:54 -0800
Date: Sat, 9 Mar 2024 08:46:41 +0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>, qemu-devel@nongnu.org,
 Xiaoling Song <xiaoling.song@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH v2 00/13] Cleanup on SMP and its test
Message-ID: <ZeuxcZmE9Ejr6acx@intel.com>
References: <20240308160148.3130837-1-zhao1.liu@linux.intel.com>
 <a6c12d41-2801-4425-98e9-351851e2f7a4@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6c12d41-2801-4425-98e9-351851e2f7a4@linaro.org>
Received-SPF: none client-ip=198.175.65.11;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.572,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

> 
> Can you share your base commit please?
> 
> Applying: hw/core/machine-smp: Remove deprecated "parameter=0" SMP
> configurations
> Applying: hw/core/machine-smp: Deprecate unsupported "parameter=1" SMP
> configurations
> error: patch failed: docs/about/deprecated.rst:47
> error: docs/about/deprecated.rst: patch does not apply
> Patch failed at 0002 hw/core/machine-smp: Deprecate unsupported
> "parameter=1" SMP configurations
>

The base commit is e1007b6bab5cf ("Merge tag 'pull-request-2024-03-01'
of https://gitlab.com/thuth/qemu into staging").

But I think this conflict is because of the first 4 patches of mudule
series you picked. Let me rebase this series on that module series and
refresh a v3.

Thanks,
Zhao


