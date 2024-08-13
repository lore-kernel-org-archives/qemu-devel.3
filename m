Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E53ABC52D7C
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 07:21:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdlq2-0003V6-8l; Tue, 13 Aug 2024 03:21:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sdlpw-0003UA-Cc
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 03:20:58 -0400
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sdlpr-0004uF-Op
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 03:20:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1723533652; x=1755069652;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=7KqRcn7KpL/eTs6HG3k5HECcrx7NZSaP+OnI2VSl9kk=;
 b=Ikbkk4HUg7AezFIxHMaPRe2/mosNgywev/OgcVkaIEhOjs0Kz9Q3XyyB
 +7wClvlk+81gJXVVzNknYlMhB0Iy2w30Zd9/tOUCiPMxYbiVw9rR4DZDf
 ulMcaMhqeND7C6objKqEb8KXmlUAFhoVEmQMwKJR57TSC8elIrxnhOGsA
 /v8PCFbHOjn2oPbJYIaveUmbUZKRbxAmT8u1ak3jFjG3vBj1soTa2zUS+
 Vjcy/hRvUPIx971N0ks3KzpU61JoOLc8OpTOMGaN1BdUd7tKxJsiu6f72
 LSKSwm8aijZq9sgtdfZOeln48tPMvtIyz3HFZnvNV+EpjuMKWikwgpgtL A==;
X-CSE-ConnectionGUID: lIZfZhtGTECdaCtqsrTXNw==
X-CSE-MsgGUID: 5SidkvKxTOabFFkC4n1bxQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11162"; a="32355456"
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; d="scan'208";a="32355456"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2024 00:20:25 -0700
X-CSE-ConnectionGUID: THeOCwrvRQuhuZARiTMuQw==
X-CSE-MsgGUID: WdyiKhpeTvWHB3s+zbmUGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; d="scan'208";a="59141200"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa007.jf.intel.com with ESMTP; 13 Aug 2024 00:20:22 -0700
Date: Tue, 13 Aug 2024 15:36:14 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Manish <manish.mishra@nutanix.com>, John Levon <john.levon@nutanix.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH] i386/cpu: Introduce enable_cpuid_0x1f to force exposing
 CPUID 0x1f
Message-ID: <ZrsM7rf5C65CJDMJ@intel.com>
References: <20240802072426.4016194-1-xiaoyao.li@intel.com>
 <ZrSZQN/AQa6BiIUu@intel.com>
 <26064315-6730-48fa-9f04-cb86a2dcfdf0@intel.com>
 <ZrTaVfziPc61OYlI@intel.com>
 <ec35b71a-15af-4547-8989-ed4368fa9c58@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec35b71a-15af-4547-8989-ed4368fa9c58@intel.com>
Received-SPF: pass client-ip=192.198.163.9; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.126,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Tue, Aug 13, 2024 at 10:52:27AM +0800, Xiaoyao Li wrote:

[snip]

> > Any levels that 0xb doesn't cover.
> 
> The name of extended_topo is so misleading. At least, it misleads me.
> 
> Both Intel and AMD support leaf 0xb and the name of leaf 0xb is "Extended
> topology enumeration". And here, x86_has_extended_topo() is used for topo
> levels that cannot be covered by 0xb.
> 

Yes, names are really hard, Intel and AMD have different naming for
topology leafs (the ones 0xb doesn't cover)... This helper has a
comment, which is also a clear expression of what it is doing.

Thanks,
Zhao


