Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E436C369AB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 15:17:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7yKC-0007Uj-HN; Thu, 24 Apr 2025 11:17:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u7yK8-0007OZ-I0; Thu, 24 Apr 2025 11:17:14 -0400
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u7yK5-0000Hu-Tr; Thu, 24 Apr 2025 11:17:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1745507830; x=1777043830;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=158fBQSNMKzDqaY04yznGURrydccjjocAD1i7xFg+R8=;
 b=UgIEoN6LnP72zKxiz2ne6akzcgdsJi87y3F9CdWLrgmi7Vldd2wTkeQr
 s+tOAq1PzXV3q+S6Lsn6suldItj6OWvZ6ZOyI3H6QWDL1dT28oNaDICL3
 Awuon4EaPhhFY59JajGEng6bmTTm5IKGogH5r0G5H2RasA0ey1MmGdKY3
 JawDvi2BOxYNUpMi8iPEKVF0YunyeLaS11vQ3IaUATnWF1jKSUKiDFjUq
 w3gfjKVx0hdmAlj0b+ttsbpDMBAuUAlmrNCQF+0m8xuwp8eo8ZNk2fW9H
 g/i+UfYR7sHBy0K9C4L3MNsL4fYUHrzt/8ySjLYe0JL97ToJyBh/dPFuW Q==;
X-CSE-ConnectionGUID: 39inQe+NSQCkHFlp3k9tew==
X-CSE-MsgGUID: CpW3AoNnSF+LksMP9pYzmQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11413"; a="46863091"
X-IronPort-AV: E=Sophos;i="6.15,236,1739865600"; d="scan'208";a="46863091"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Apr 2025 08:17:07 -0700
X-CSE-ConnectionGUID: HAY4lmrHSWKVbuq4LuAgpA==
X-CSE-MsgGUID: Hk+awAWlQOqsKBW7YtugwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,236,1739865600"; d="scan'208";a="169861172"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa001.jf.intel.com with ESMTP; 24 Apr 2025 08:17:04 -0700
Date: Thu, 24 Apr 2025 23:37:59 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 qemu-ppc@nongnu.org, Yanan Wang <wangyanan55@huawei.com>,
 qemu-stable@nongnu.org, Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH] hw/core: Get default_cpu_type calling
 machine_class_default_cpu_type()
Message-ID: <aApa11VBifiTI5fl@intel.com>
References: <20250422084114.39499-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250422084114.39499-1-philmd@linaro.org>
Received-SPF: pass client-ip=198.175.65.20; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.84,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Apr 22, 2025 at 10:41:14AM +0200, Philippe Mathieu-Daudé wrote:
> Date: Tue, 22 Apr 2025 10:41:14 +0200
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: [PATCH] hw/core: Get default_cpu_type calling
>  machine_class_default_cpu_type()
> X-Mailer: git-send-email 2.47.1
> 
> Since commit 62b4a227a33 the default cpu type can come from the
> valid_cpu_types[] array. Call the machine_class_default_cpu_type()
> instead of accessing MachineClass::default_cpu_type field.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: 62b4a227a33 ("hw/core: Add machine_class_default_cpu_type()")
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> Cc: Gavin Shan <gshan@redhat.com>
> ---
>  hw/core/machine-qmp-cmds.c | 5 +++--
>  target/ppc/cpu_init.c      | 2 +-
>  2 files changed, 4 insertions(+), 3 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


