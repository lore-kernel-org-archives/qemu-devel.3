Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A80C9D2FFE0
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 09:35:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1jO6-0002Bf-3u; Fri, 18 Oct 2024 05:35:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t1jO4-0002Ac-5Q
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 05:35:12 -0400
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t1jO2-00016n-Cd
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 05:35:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1729244110; x=1760780110;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=tgLLQrUDqbrqsjgXzv+tNDVt+F/JOQTFcwHrzAz7Xx8=;
 b=SGxYiKQZhD5oRuwCyadeSg2XutNtBnuStHKDtSC49vpIpTMqAbalVcNd
 jwXImBcyM/4s8QDR15Yove45dwdQ6bqWd4k5yPbyWpZfU6EhvwxrsoBMo
 GsGRSiX0jYh/fKnf44nsREzLWlm/j3H7P2NDE/5htiPynms4VHTs7wcD7
 jymH/1ySD0mNjG/RyAum/tDbu/LGEZEW830kq6FHjgnVilVU0RWkm0akc
 jAKKfDpJbNLd6hSezZdOpuXvyoAIYN+vGTG0TvwRrMHx4dzfujAIXz/N8
 zatTv9fBMo3ow67OvcrEg4oHnRgM2scEgT9E00H+Pw11eRDpi18euXQLC g==;
X-CSE-ConnectionGUID: th2L5xv7Sg6rWUA1+qxuVA==
X-CSE-MsgGUID: R/VSFhxWS3KHgbUh7dZrbQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="28921365"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="28921365"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Oct 2024 02:35:08 -0700
X-CSE-ConnectionGUID: 83RSPGzySgqpGXbwKdse/g==
X-CSE-MsgGUID: O5OUn9OMTDq+7ZH4K0WLbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,213,1725346800"; d="scan'208";a="78776457"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa010.jf.intel.com with ESMTP; 18 Oct 2024 02:35:03 -0700
Date: Fri, 18 Oct 2024 17:51:17 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v2 04/31] block: adapt to new import path for qobject
 data type headers
Message-ID: <ZxIvlacgDWs+q99Y@intel.com>
References: <20241017113344.883424-1-berrange@redhat.com>
 <20241017113344.883424-5-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241017113344.883424-5-berrange@redhat.com>
Received-SPF: pass client-ip=198.175.65.18; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.068,
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

On Thu, Oct 17, 2024 at 12:33:16PM +0100, Daniel P. Berrangé wrote:
> Date: Thu, 17 Oct 2024 12:33:16 +0100
> From: "Daniel P. Berrangé" <berrange@redhat.com>
> Subject: [PATCH v2 04/31] block: adapt to new import path for qobject data
>  type headers
> 
> The qobject data type headers have moved from qapi/qmp/ to
> qobject/.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  block.c                              |  8 ++++----
>  block/blkdebug.c                     |  6 +++---
>  block/blkio.c                        |  2 +-
>  block/blklogwrites.c                 |  4 ++--
>  block/blkverify.c                    |  4 ++--
>  block/copy-before-write.c            |  2 +-
>  block/copy-on-read.c                 |  2 +-
>  block/curl.c                         |  4 ++--
>  block/file-posix.c                   |  4 ++--
>  block/file-win32.c                   |  4 ++--
>  block/gluster.c                      |  2 +-
>  block/iscsi.c                        |  4 ++--
>  block/monitor/block-hmp-cmds.c       |  2 +-
>  block/nbd.c                          |  2 +-
>  block/nfs.c                          |  4 ++--
>  block/null.c                         |  4 ++--
>  block/nvme.c                         |  4 ++--
>  block/parallels.c                    |  2 +-
>  block/qapi-sysemu.c                  |  2 +-
>  block/qapi.c                         | 10 +++++-----
>  block/qcow.c                         |  4 ++--
>  block/qcow2.c                        |  4 ++--
>  block/qed.c                          |  2 +-
>  block/quorum.c                       |  6 +++---
>  block/rbd.c                          |  8 ++++----
>  block/replication.c                  |  2 +-
>  block/snapshot.c                     |  4 ++--
>  block/ssh.c                          |  4 ++--
>  block/stream.c                       |  2 +-
>  block/vhdx.c                         |  2 +-
>  block/vmdk.c                         |  2 +-
>  block/vpc.c                          |  2 +-
>  block/vvfat.c                        |  4 ++--
>  blockdev.c                           |  8 ++++----
>  qemu-img.c                           |  4 ++--
>  qemu-io-cmds.c                       |  2 +-
>  qemu-io.c                            |  4 ++--
>  qemu-nbd.c                           |  4 ++--
>  storage-daemon/qemu-storage-daemon.c |  4 ++--
>  39 files changed, 74 insertions(+), 74 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


