Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4ED2E68956
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 07:02:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6PCM-0001ej-CE; Thu, 31 Oct 2024 03:02:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t6PCI-0001eF-Si
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 03:02:22 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t6PCG-00072A-Ht
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 03:02:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730358141; x=1761894141;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=1uLbxR5aLR6yFMicCtuhn4ntzlEHWQ0jaJkDQayEaIw=;
 b=Qfk6kQlJut/wKbrDYgMjiIJfKdgfr+tCpe6C19ZutUp9MBcLvgJrdNpp
 pBcE6XD7POFGtHyiyyXUTcNS0QDTb6IBDOTq76UWDf0lCUXB5s0voxxEV
 55+SSjepHGvCXbkJlQX4HkeDZf3uTZJHYkbXQpd9tTtMlolxmROEp7EuS
 OMJzAlTfMS0jqFs0mWtlZolCQcfgDQmU9PGOCpQxBU9N5Cf1pVk23dY3K
 3naNWNqxoA6VQyDWhBjuekKqmER7AAHx3Z6UREWQ6ttdfEp3doRRhf02A
 +Q4QBax7812iqYdfdU4v+gpCOBejfURLNLUGDtPMnC9GcmYhD4hJoLmsu w==;
X-CSE-ConnectionGUID: xAAoldaJSMeZr99vfrEXQQ==
X-CSE-MsgGUID: wKaHjDhVSYavDiSEpMI1jw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="47540913"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="47540913"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Oct 2024 00:02:19 -0700
X-CSE-ConnectionGUID: Q3ET6XQQRQSP08iL/Hhc+w==
X-CSE-MsgGUID: jxlgvlKCSTeQ88Hw/BhoAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; d="scan'208";a="87135339"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa004.fm.intel.com with ESMTP; 31 Oct 2024 00:02:17 -0700
Date: Thu, 31 Oct 2024 15:18:37 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Tao Su <tao1.su@linux.intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 xiaoyao.li@intel.com
Subject: Re: [PATCH 4/8] target/i386: add AVX10 feature and AVX10 version
 property
Message-ID: <ZyMvTcW1QzA1ycUI@intel.com>
References: <20241029151858.550269-1-pbonzini@redhat.com>
 <20241029151858.550269-5-pbonzini@redhat.com>
 <ZyHyBnPvOHsSdh8D@intel.com> <ZyH+RB3v55cQ43+S@linux.bj.intel.com>
 <ZyIy4OGSGPhAZutK@intel.com> <ZyI9P1ftFOTUhDzb@linux.bj.intel.com>
 <ZyJW9nGgpEXqiyli@intel.com> <ZyMKAwq4lsk+ozu3@linux.bj.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZyMKAwq4lsk+ozu3@linux.bj.intel.com>
Received-SPF: pass client-ip=198.175.65.10; envelope-from=zhao1.liu@intel.com;
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

> > > > > > @@ -7674,13 +7682,21 @@ static bool x86_cpu_filter_features(X86CPU *cpu, bool verbose)
> > > > > >                                      &eax_0, &ebx_0, &ecx_0, &edx_0);
> > > > > >          uint8_t version = ebx_0 & 0xff;
> > > > > > 
> > > > > > -        if (version < env->avx10_version) {
> > > > > > +        if (!env->avx10_version) {
> > > > > > +            env->avx10_version = version;
> > > > > 
> > > > > x86_cpu_filter_features() is not a good place to assign avx10_version, I
> > > > > still tend to set it in max_x86_cpu_realize().
> > > > 
> > > > It's not proper to get the host's version when AVX10 cannot be enabled,
> > > > even maybe host doesn't support AVX10.
> > > > 
> > > > As you found out earlier, max_x86_cpu_realize doesn't know if AVX10 can
> > > > be enabled or not.
> > > > 
> > > 
> > > How about moving to x86_cpu_expand_features()? We can set when checking
> > > cpu->max_features.
> > 
> > The feature bit set in x86_cpu_expand_features() is unstable since it
> > may be masked later in x86_cpu_filter_features(). :)
> > 
> 
> A lot of feature bits are set in x86_cpu_expand_features() with reported
> value, so I think avx10_version can also be set to reported value there.
> 
> I mainly want to let avx10_version be assigned only when -cpu host or max,
> so that it can be distinguished from the cpu model. This should also be
> Paolo's original intention in v2.

OK. In this case, extend avx10-version is also consistent with the
semantics of this function. Even if host doesn't support avx10, then in
principle it's ok to read unimplemented avx10-version as 0.

Pls go ahead. :)

Thanks,
Zhao


