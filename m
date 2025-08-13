Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02C17C87FCF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Aug 2025 14:52:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umCp7-00085G-IU; Wed, 13 Aug 2025 10:51:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1umCon-0007sK-K2; Wed, 13 Aug 2025 10:51:12 -0400
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1umCoi-0001AL-NC; Wed, 13 Aug 2025 10:51:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1755096665; x=1786632665;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=gvTBCTKZO2MqsAwy/vVLHs8YYKd5LMpW7mE5be4HA6M=;
 b=cu7bC9oc5A45YZvHhbkjynSoDwztcfGobGmWcXNzMrEDZJKLMvfGpbS+
 GGyi8OzK6m7TrlhhAmlhOSZiz5CdF/pc70aDBlOT73xi3sIH7xJ4WMqkU
 o+sPapCy+zzYp8MRa4Ec02ZhrM0zwlvBkpMkbhLuQN1o7dSD8CHTxgSAH
 Dxkro0TlSEw1fc5AXamBZfXQ+e0EE79r4EXfj4KhuIVyhfsBP+JxVFmnz
 FPlq3lfOfMxHtCa4b4Lmlpr5me1f62flNHgkWUncfeUc9KcY4T56Exsv5
 wLZM3r2daJU1ZTIJD/xXOCYSo5tg99/NfWEcT+omDy4K2u4M7MKIQeADb g==;
X-CSE-ConnectionGUID: TzUMNncuQJKD89xPoBszjg==
X-CSE-MsgGUID: qGBi/NcLQcONC3onV/wrUA==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="56417912"
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; d="scan'208";a="56417912"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2025 07:51:00 -0700
X-CSE-ConnectionGUID: ZLLK08pcQg22lyNTe6Zhgw==
X-CSE-MsgGUID: CpjqAvpJTOGKp+fRVfosSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; d="scan'208";a="166858511"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa008.fm.intel.com with ESMTP; 13 Aug 2025 07:50:56 -0700
Date: Wed, 13 Aug 2025 23:12:38 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Junjie Mao <junjie.mao@hotmail.com>,
 "open list:ARM SMMU <qemu-arm@nongnu.org>," <qemu-devel@nongnu.org>,
 qemu-rust@nongnu.org, Dapeng Mi <dapeng1.mi@linux.intel.com>,
 Chuanxiao Dong <chuanxiao.dong@intel.com>
Subject: Re: [RFC 16/26] memory: Make flatview_do_translate() return a
 pointer to MemoryRegionSection
Message-ID: <aJyrZi6Vlwe5RYMb@intel.com>
References: <20250807123027.2910950-1-zhao1.liu@intel.com>
 <20250807123027.2910950-17-zhao1.liu@intel.com>
 <beab841b-9c69-43d2-b996-879eee9e1120@redhat.com>
 <aJtgIBgl8JzDsJ1O@intel.com>
 <CAAjaMXaHQs=oKGRGDwpvVCmRH0xLNZZCTvEaeWJ8x0znBCiY7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAjaMXaHQs=oKGRGDwpvVCmRH0xLNZZCTvEaeWJ8x0znBCiY7A@mail.gmail.com>
Received-SPF: pass client-ip=192.198.163.19; envelope-from=zhao1.liu@intel.com;
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

> Yes, the usual approach is to have a Ref and a RefMut type e.g. Opaque and
> OpaqueMut, and the OpaqueMut type can dereference immutably as an Opaque.
> 
> See std::cell::{Ref, RefMut} for inspiration.
> 

Thanks! I'll dorp Opaque directly for this case. If there're more similar
cases, then we can have a OpaqueRef<>.

Regards,
Zhao


