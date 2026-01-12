Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83DD3D25032
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 07:57:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfCku-0007Gx-Ta; Mon, 12 Jan 2026 02:54:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vfCjv-0007AC-MB
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 02:53:36 -0500
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vfCjs-0002be-BN
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 02:53:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1768204404; x=1799740404;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=gwH/H9GnHnHhyQfXq+OE2IrBZuwVvfh0BK9XNq0ZUms=;
 b=E6t8GmntNVSX1ZCu+Z/ISc8RNjkOKkv41MX40tFEF2l/C3g5fFjdfzCy
 iOrE64tEBYOSBZ5A87dErtnp8K4bZjhOYZvU0Vb9cOHgT0WjFtg9r/9Ja
 hwtieo+4YqD5FWVd0c34TG9RDnREBjIuVwUZg2TrABtNsodf3gkQz72wD
 uLBiVZLksAg6AY1bj8fm/NWaJqpc4t5FxPix9QXzaLsJ47cS/fpQW3TzM
 pIbn+9cBzJZ5ZmNpawpUfaGLX1Q9aCoTWfz9t0NfljatGxVnyAmBK22B5
 2pcm07brjlZDXo/31F9YCxWUnDn2QhIugTWXGNiIkZfrIv5N3D6aIB1ly w==;
X-CSE-ConnectionGUID: hy2UssujSy+C5IZ3H799vA==
X-CSE-MsgGUID: wfeNG4XQSnORtpVAbDNWbA==
X-IronPort-AV: E=McAfee;i="6800,10657,11668"; a="79768346"
X-IronPort-AV: E=Sophos;i="6.21,219,1763452800"; d="scan'208";a="79768346"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jan 2026 23:53:21 -0800
X-CSE-ConnectionGUID: b2knEYZmR/Gqn5ALWwiW0w==
X-CSE-MsgGUID: YfDbXU++Q4K+ecDiV8QPpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,219,1763452800"; d="scan'208";a="204719495"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa010.fm.intel.com with ESMTP; 11 Jan 2026 23:53:19 -0800
Date: Mon, 12 Jan 2026 16:18:46 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Avihai Horon <avihaih@nvidia.com>,
 Anton Johansson <anjo@rev.ng>,
 Alex Williamson <alex.williamson@redhat.com>,
 "Maciej S . Szmigiero" <maciej.szmigiero@oracle.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH v2] hw/vfio/migration: Check base architecture at runtime
Message-ID: <aWSuZpjvdhv/cjAN@intel.com>
References: <20251021161707.8324-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251021161707.8324-1-philmd@linaro.org>
Received-SPF: pass client-ip=198.175.65.11; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Tue, Oct 21, 2025 at 06:17:07PM +0200, Philippe Mathieu-Daudé wrote:
> Date: Tue, 21 Oct 2025 18:17:07 +0200
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: [PATCH v2] hw/vfio/migration: Check base architecture at runtime
> X-Mailer: git-send-email 2.51.0
> 
> Inline vfio_arch_wants_loading_config_after_iter() and
> replace the compile time check of the TARGET_ARM definition
> by a runtime call to target_base_arm().
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> Supersedes: <20251020222315.68963-1-philmd@linaro.org>
> Based-on: <20251020220941.65269-1-philmd@linaro.org>
> https://lore.kernel.org/qemu-devel/20251020221508.67413-5-philmd@linaro.org/
> ---
>  hw/vfio/vfio-helpers.h      |  2 --
>  hw/vfio/helpers.c           | 17 -----------------
>  hw/vfio/migration-multifd.c | 12 +++++++++++-
>  3 files changed, 11 insertions(+), 20 deletions(-)

(Checked with 20251020221508.67413-5-philmd@linaro.org)

LGTM, so,

Zhao Liu <zhao1.liu@intel.com>


