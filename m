Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32109C369AB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 07:54:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7rPf-00066a-4o; Thu, 24 Apr 2025 03:54:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u7rPd-00066Q-UJ
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 03:54:26 -0400
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u7rPc-0006vP-20
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 03:54:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1745481264; x=1777017264;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=uh2RyeMH6MjQsOJfpZlnPDAGaChJ3wjA6eoytmR8ggM=;
 b=LciydTwJQXb0huMl9ZO3k2QGdRNnpg0lMGpFOr4szQtkK8tLbe/fU3U7
 GZbUzGMRi8e8DQv51XwXOgRhPsY7y5BWuk92pUiwLVUF8TRjcZzstQjOR
 5GhK9IiYSEHFUrr6DWLzHMy8DdEz1xpsA9Esuc4p6aeHE0EYO1Gz++Zb+
 GLUUM18pKnXJ3d021cLn2FLLbuav6P/emozlWm3Um8DLcOFdvq480dzTz
 arga+sLUAy0dl5wdzbDVgxtPBVM+1+E1tQvYEo6Z3nNpNzLgHpiAnE5rn
 xb8iGQ3JChJ21/gbae4mPv3YmcMXYS0/EPJx7PxVEs/d/xX5Txu6p7aTp w==;
X-CSE-ConnectionGUID: rAk9N+Q0RmW51OLEFX1JFg==
X-CSE-MsgGUID: yV2dgOxcRaW2pybg/09TgA==
X-IronPort-AV: E=McAfee;i="6700,10204,11412"; a="47195634"
X-IronPort-AV: E=Sophos;i="6.15,235,1739865600"; d="scan'208";a="47195634"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Apr 2025 00:54:20 -0700
X-CSE-ConnectionGUID: 15tzpQGwQV2yswp7wjkEnw==
X-CSE-MsgGUID: X+tVTFriQ667o0bdxJfNIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,235,1739865600"; d="scan'208";a="137396598"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa003.jf.intel.com with ESMTP; 24 Apr 2025 00:54:19 -0700
Date: Thu, 24 Apr 2025 16:15:14 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Francesco Lavra <francescolavra.fl@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>
Subject: Re: [PATCH v8 17/55] i386/tdvf: Introduce function to parse TDVF
 metadata
Message-ID: <aAnzEhX+8gXgngfl@intel.com>
References: <20250401130205.2198253-1-xiaoyao.li@intel.com>
 <20250401130205.2198253-18-xiaoyao.li@intel.com>
 <Z-0o0sYJcnqI23aX@redhat.com>
 <f311a233-0238-4bcd-8481-0829d6bc1eda@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f311a233-0238-4bcd-8481-0829d6bc1eda@intel.com>
Received-SPF: pass client-ip=198.175.65.16; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.294,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

> > struct field names starting with an initial capital is
> > not the usual QEMU code style. Can this be all initial
> > lowercase, with capital just for word separation.
> 
> I think Isaku used such names because they are defined in TDVF Design Guide
> spec[1].
> 
> QEMU's internal data structure for metadata are below, which follows QEMU
> coding style.
> 
> 	typedef struct TdxFirmwareEntry {
> 	    uint32_t data_offset;
> 	    uint32_t data_len;
> 	    uint64_t address;
> 	    uint64_t size;
> 	    uint32_t type;
> 	    uint32_t attributes;
> 	} TdxFirmwareEntry;
> 
> 	typedef struct TdxFirmware {
> 	    uint32_t nr_entries;
> 	    TdxFirmwareEntry *entries;
> 	} TdxFirmware;
> 
> So if no strong preference, I would keep it as-is that the raw struct read
> from TDVF keeps the name convention of TDVF Design Guide spec and internal
> data struct uses QEMU's convention.
> 
> [1] https://cdrdv2.intel.com/v1/dl/getContent/733585

Or you can add a simple comemnt about "the raw struct read from TDVF
keeps the name convention of TDVF Design Guide spec", to remind other
people that there is no need to clean up the style here. I have no
objections; up to you.


