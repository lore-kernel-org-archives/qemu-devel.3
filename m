Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1795E77188
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Dec 2024 02:56:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQHYc-0004P2-NN; Tue, 24 Dec 2024 21:55:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tQHYa-0004Ot-SA
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 21:55:32 -0500
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tQHYZ-0002rm-40
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 21:55:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1735095331; x=1766631331;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=AfZndZCwwqW8fGGdg4N+iydft+loycjq6e2Cmi6ZLNc=;
 b=gnfpM+Aq50moVIVnKoBX/VhdjDtf7JBAgcEa0xZ/HHY8GgYCjGmSmtw6
 j/xzqQRyTff39aGogr0v8+5OwPncOv0afpf1pl1gcIR5Mxtj2Yq1eGxTA
 1AcZo/Gv0dxFJllbngw7hUk2FDjg0Gkq4f6rQUcFrpdj0sblaNXk+mjPi
 rg8qnZ0ejojTH+Bz0C51r4S8hyXcslvhite5WHPn5QyiuTLvx5p3EjYyA
 +NZQIArxUJEQ7eEPCBOT/lC4lQpTyF5hSzz43o3rYU/dhVQdj28QUjqfQ
 fML2Qun1wgQUsHv/EGhSeJgZfqLLqyKm5eTsMAUMaVuhpdcuG+LUXDybk g==;
X-CSE-ConnectionGUID: Bc9pGpo1SD6W78D17BYudQ==
X-CSE-MsgGUID: lDaYnScARCmR3i7oPddGvQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11296"; a="34829825"
X-IronPort-AV: E=Sophos;i="6.12,262,1728975600"; d="scan'208";a="34829825"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Dec 2024 18:55:29 -0800
X-CSE-ConnectionGUID: Re400YvoSVakUHYQANkjHw==
X-CSE-MsgGUID: lz2Iy1CiSdyF96ned8+x0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="103712908"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa003.fm.intel.com with ESMTP; 24 Dec 2024 18:55:26 -0800
Date: Wed, 25 Dec 2024 11:14:09 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Tao Su <tao1.su@linux.intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Pankaj Gupta <pankaj.gupta@amd.com>,
 Zide Chen <zide.chen@intel.com>, qemu-devel@nongnu.org, kvm@vger.kernel.org
Subject: Re: [PATCH v5 10/11] target/i386/kvm: Clean up error handling in
 kvm_arch_init()
Message-ID: <Z2t4gSUU2ix1EKF1@intel.com>
References: <20241106030728.553238-1-zhao1.liu@intel.com>
 <20241106030728.553238-11-zhao1.liu@intel.com>
 <ff866f4c-766c-4637-ba73-bbbdd4b15a2c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff866f4c-766c-4637-ba73-bbbdd4b15a2c@redhat.com>
Received-SPF: pass client-ip=192.198.163.19; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
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

On Tue, Dec 24, 2024 at 04:53:36PM +0100, Paolo Bonzini wrote:
> Date: Tue, 24 Dec 2024 16:53:36 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: Re: [PATCH v5 10/11] target/i386/kvm: Clean up error handling in
>  kvm_arch_init()
> 
> On 11/6/24 04:07, Zhao Liu wrote:
> > Currently, there're following incorrect error handling cases in
> > kvm_arch_init():
> > * Missed to handle failure of kvm_get_supported_feature_msrs().
> > * Missed to return when kvm_vm_enable_disable_exits() fails.
> 
> At least in these two cases I think it was intentional to avoid hard
> failures.  It's probably not a very likely case and I think your patch is
> overall a good idea.

I have the idea to clean up the abort()/exit() in KVM and instead use
@errp to handle failure cases. However, this would be a big change, so
this patch only makes a small change, as a first step.

Thanks,
Zhao


