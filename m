Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CEECC3ABC3
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 03:19:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEg9s-0005SZ-K2; Mon, 12 May 2025 23:18:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uEg9q-0005SE-Dd; Mon, 12 May 2025 23:18:18 -0400
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uEg9n-0004Iq-JT; Mon, 12 May 2025 23:18:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747106296; x=1778642296;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=v7EzudV4/Ya+6M4YGvaIUylCgp31lJUmDL5kclRL7KA=;
 b=GyTm0M5pklsGCR5uErnwyaJTMZW04B+16ZKDRuTzc4DEIDHGq6C9TfkZ
 hFjCXWDKaJXbqMTZ8HA4qyr616DM5BbifR8LLVEf7z5ICtYmg7boyi15Z
 XqZ+SwIRKqqTAYZsOBbMdvSluumkYVJ6tt1Wn6El4AUTUR7vfYM83oiJu
 7pY+m8Xf0ba6NMireE7TYZFMSSYZM19V8yx3TvHwqOyQ9NIRAZeiudtse
 7gFBee3OP1Q9hCpqnojx0pAH5xGwlLT5ErpMoMDvB7+++Aw5FgGRHG1kZ
 Ral2nOg2/rm4qFSfMzxt7veCkSVLjprjuq90nJENcfb2Zs4A8Eno6rsRP Q==;
X-CSE-ConnectionGUID: gwApZBbTRUG5iVwMtAxrpg==
X-CSE-MsgGUID: etZrQT8NSRGY19s9LN9XeA==
X-IronPort-AV: E=McAfee;i="6700,10204,11431"; a="36556454"
X-IronPort-AV: E=Sophos;i="6.15,284,1739865600"; d="scan'208";a="36556454"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 May 2025 20:18:10 -0700
X-CSE-ConnectionGUID: jHtMsGTiSlWYZmP7vHDbNA==
X-CSE-MsgGUID: vBQXI3WTT0eBic3bqHfFUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,284,1739865600"; d="scan'208";a="138498133"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa008.jf.intel.com with ESMTP; 12 May 2025 20:18:07 -0700
Date: Tue, 13 May 2025 11:39:10 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Tao Su <tao1.su@linux.intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Pankaj Gupta <pankaj.gupta@amd.com>,
 Zide Chen <zide.chen@intel.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, qemu-stable@nongnu.org
Subject: Re: [PATCH v5 01/11 for v9.2?] i386/cpu: Mark avx10_version filtered
 when prefix is NULL
Message-ID: <aCK+3m7jv+qPWYZ4@intel.com>
References: <20241106030728.553238-1-zhao1.liu@intel.com>
 <20241106030728.553238-2-zhao1.liu@intel.com>
 <c62b0d60-2815-41e1-9e56-7bec83640208@tls.msk.ru>
 <baafd30e-db22-4950-ad44-2b2b51cc8f6c@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <baafd30e-db22-4950-ad44-2b2b51cc8f6c@tls.msk.ru>
Received-SPF: pass client-ip=192.198.163.16; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.551,
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

On Mon, May 12, 2025 at 12:35:35PM +0300, Michael Tokarev wrote:
> Date: Mon, 12 May 2025 12:35:35 +0300
> From: Michael Tokarev <mjt@tls.msk.ru>
> Subject: Re: [PATCH v5 01/11 for v9.2?] i386/cpu: Mark avx10_version
>  filtered when prefix is NULL
> 
> On 21.12.2024 00:04, Michael Tokarev wrote:
> > 06.11.2024 06:07, Zhao Liu wrote:
> > > In x86_cpu_filter_features(), if host doesn't support AVX10, the
> > > configured avx10_version should be marked as filtered regardless of
> > > whether prefix is NULL or not.
> > > 
> > > Check prefix before warn_report() instead of checking for
> > > have_filtered_features.
> > > 
> > > Cc: qemu-stable@nongnu.org
> > > Fixes: commit bccfb846fd52 ("target/i386: add AVX10 feature and
> > > AVX10 version property")
> > > Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> > 
> > Hi!
> > 
> > Has this patch been forgotten?  9.2 is out already and I'm collecting
> > fixes for it...
> 
> Ping #2?  It's a 10.0.1 time already.. :)
>

Hi Michael,

I'm sorry, but now I think it is not necessary, since it doesn't
affect the normal use of avx10. And I don't think anyone is actively
setting the wrong avx10 version in a normal production environment (
even KVM only supports v1).

Hope this helps and saves you the effort!

Thanks,
Zhao


