Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DA70D1A452
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Oct 2024 08:40:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1szXfW-0007JI-8h; Sat, 12 Oct 2024 04:40:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1szXfQ-0007GQ-VE; Sat, 12 Oct 2024 04:40:05 -0400
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1szXfO-0002GR-VE; Sat, 12 Oct 2024 04:40:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1728722403; x=1760258403;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=29g+mvsDpBL6Y33o5GU40SpDJhsEI/Sppc+4Zugk09g=;
 b=G8U7LRME2W8VJgA8IWnqi/G9GZQ4BCSIMBPO2uyv/s3/aQ7q+PE84mwi
 1Ue4mNr7Zgx5vIsxByofIVfO/7OmGeJHSB/jZfEgTHuVC8epcm456FD4Z
 awBYrEQtPMWEfRlDJ2I/h3WuMuaWyqNG3POkaBBt+oUD4sJMztYZTT897
 rZCUw5in1oMxFKsaN5aDq5v30V+cullxkc9Y5XD8jr6+gDzK81I6FWCX2
 H1F0GYcnZvbYO1ob1+rNi/GQ2YTiA+olcdcAR/LV74oyK2BnNHcNnsYXO
 L9BJ21TjInn2xMnCPcV4UQCYJeGRlUsawaBwOO6tKfr+nuk210GsTNq1E w==;
X-CSE-ConnectionGUID: NEIQqu97TVehTuAak2QNzw==
X-CSE-MsgGUID: iWgPBnbjQNahl9NL2hZnnQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="28227374"
X-IronPort-AV: E=Sophos;i="6.11,198,1725346800"; d="scan'208";a="28227374"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2024 01:39:58 -0700
X-CSE-ConnectionGUID: gYClNDB3TpOQXEN0BP8t+w==
X-CSE-MsgGUID: Ymx61wWITdS0xFRRqxOuNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,198,1725346800"; d="scan'208";a="77037121"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa010.jf.intel.com with ESMTP; 12 Oct 2024 01:39:56 -0700
Date: Sat, 12 Oct 2024 16:56:08 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Chuang Xu <xuchuangxclwt@bytedance.com>, pbonzini@redhat.com,
 imammedo@redhat.com, xieyongji@bytedance.com,
 chaiwen.cc@bytedance.com, qemu-stable@nongnu.org,
 Guixiong Wei <weiguixiong@bytedance.com>,
 Yipeng Yin <yinyipeng@bytedance.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v6] i386/cpu: fixup number of addressable IDs for logical
 processors in the physical package
Message-ID: <Zwo5qH/TCNOQOXml@intel.com>
References: <20241009035638.59330-1-xuchuangxclwt@bytedance.com>
 <00f25e56-72e4-485a-a6a4-6b0c5563330d@intel.com>
 <ceb6f780-5dc2-4df7-b4f3-70884124d705@bytedance.com>
 <cfa014eb-d658-4c53-aaf1-086baf22c52a@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cfa014eb-d658-4c53-aaf1-086baf22c52a@intel.com>
Received-SPF: pass client-ip=198.175.65.17; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.15,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-0.001,
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

> > > > +            if (cpu->vendor_cpuid_only && IS_AMD_CPU(env)) {
> > > > +                *ebx |= threads_per_pkg << 16;
> > > > +            } else {
> > > > +                *ebx |= 1 << apicid_pkg_offset(&topo_info) << 16;
> > > > +            }
> > > 
> > > you need to handle the overflow case when the number of logical
> > > processors > 255.
> > > 
> > It seems other cpuid cases of bit shifting don't condiser the overflow
> > case too..
> > 
> > Since intel only reserves 8bits for this field, do you have any
> > suggestions to make sure this field emulated
> > 
> > correctly?
> 
> the usual option can be masking the value to only 8 bits before shifting,
> like
> 
> 	((1 << apicid_pkg_offset(&topo_info)) & 0xff) << 16
> 
> but when the value is greater than 255, it will be truncated, so we need
> something like below to reflect the hardware behavior:
> 
> 	MIN((1 << apicid_pkg_offset(&topo_info)), 255) << 16
> 
> This is what Qian's patch [1] wanted to fix last year, but that patch never
> gets merged.
> 
> [1] https://lore.kernel.org/qemu-devel/20230829042405.932523-2-qian.wen@intel.com/
> 

That's on my list. I had the plan to help Qian pick up it again and
rebase that series on Chuang's change.

-Zhao


