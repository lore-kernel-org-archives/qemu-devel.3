Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13125E67495
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2024 02:27:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6hN7-0001l4-Fn; Thu, 31 Oct 2024 22:26:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t6hN5-0001ko-5F
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 22:26:43 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t6hMz-0005O0-UU
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 22:26:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730427998; x=1761963998;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=brHY6ZKAtAGyid+uTksT6TtWPwxO7PuIl4SugUoFbfU=;
 b=TVhkDk4rotRKXaLh/RaD3yt+1pWg6T73bpEr6sOsCZ1dfaveq8es19g8
 cumzze5oYsjY6tn2bDK83M1kNELEBmnw2riPXwYfITZkqrEAYpHY+2u0F
 BRf0sc4SG3K1cT90g5gKX8PRDcYKGSJqvwglRbvCzza/EP1j4KF5m+jEx
 uFc5zCBMP8OQlMZ0RqvGw1C+ITfwxZZRpMqXx9RtPe4znz55WzLzr4BId
 4BA0A5562EsE0edXnpeZ3T3VEQpYfpItXbIGUtAXkMuOomqpv3kSUp78H
 NefuEi+EwyjZDxlmGg074TeTNMKkR7Sn1Ys+cqz7QQ/9K7pRv/qohOWcc Q==;
X-CSE-ConnectionGUID: yatOoJ6IS2Wezmed9lmA8g==
X-CSE-MsgGUID: sVQORv1SQgOrZTPG97a0Rg==
X-IronPort-AV: E=McAfee;i="6700,10204,11242"; a="41561819"
X-IronPort-AV: E=Sophos;i="6.11,248,1725346800"; d="scan'208";a="41561819"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Oct 2024 19:26:35 -0700
X-CSE-ConnectionGUID: xQags8yhTBGoQeSUlVmlRA==
X-CSE-MsgGUID: TVkWTVRgRhi36KXScehQqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="87601236"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa003.jf.intel.com with ESMTP; 31 Oct 2024 19:26:33 -0700
Date: Fri, 1 Nov 2024 10:44:23 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Tao Su <tao1.su@linux.intel.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, mtosatti@redhat.com,
 xiaoyao.li@intel.com, xuelian.guo@intel.com
Subject: Re: [PATCH v3 4/8] target/i386: add AVX10 feature and AVX10 version
 property
Message-ID: <ZyRAhxjaeizc+FWm@intel.com>
References: <20241031085233.425388-1-tao1.su@linux.intel.com>
 <20241031085233.425388-5-tao1.su@linux.intel.com>
 <ZyO1vL0o0SxgcW8q@intel.com> <ZyQ4RzWX4oJB3vP0@linux.bj.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZyQ4RzWX4oJB3vP0@linux.bj.intel.com>
Received-SPF: pass client-ip=192.198.163.10; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.366,
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

> > prefix is just used to print warning. So here we should check prefix
> > for warn_report.
> > 
> > +    } else if (env->avx10_version) {
> > +        if (prefix) {
> > +            warn_report("%s: avx10.%d.", prefix, env->avx10_version);
> > +        }
> > +        have_filtered_features = true;
> > +    }
> > 
> 
> Yes, thanks for pointing out! But I see this patch set is already pulled,
> not sure whether it is easy to change...

I will soon have another clean-up series, and I can include this part.
You can send me your patch, or I can help you with it.

-Zhao


