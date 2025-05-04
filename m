Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D56C1C369DC
	for <qemu-devel@archiver.kernel.org>; Sun,  4 May 2025 15:27:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBbFl-0001Aq-LW; Sun, 04 May 2025 11:27:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uBbFj-0001Ac-H2
 for qemu-devel@nongnu.org; Sun, 04 May 2025 11:27:39 -0400
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uBbFh-00085r-NU
 for qemu-devel@nongnu.org; Sun, 04 May 2025 11:27:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746372458; x=1777908458;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=gdhO+Pifgk/IT1fASIGlmwJYSPw/RsKWXVHXvQeo/BI=;
 b=aQwhKIPhCLN3cNsv4rG8woiw2bQr+wVsXeKIM3yePH2qSEiGjMvi37gx
 lUMiq0hL8Wd6LKHQvTJC/p9FLexQznx727KjyeuCjFTfAqkRKHT4fSvXI
 QGiwawAtmMpcxeFPmzUZYM/U3OuiIg6/KamvYZNJHtjoNJfkyh8kz25jl
 4nled/Y861JHaEM1kKSdsFvoVfnExqb6PMQX2fZWECDaIYGKSv35zFZZj
 KCc0CeUZ1HmqY72/5L6i6v24djfbbTw/Fmo/+n5IRTriZmblhEh5fACev
 1HKyms9un7hSrq+zDJCoJGLLxZFXJDlwGdw1Z5THwVjyhlIa7gezTH0Ta w==;
X-CSE-ConnectionGUID: B6V+L9LNSmuzB0iTy/nf2g==
X-CSE-MsgGUID: 35owbHxwT+esqNkR0QeLpg==
X-IronPort-AV: E=McAfee;i="6700,10204,11423"; a="70492723"
X-IronPort-AV: E=Sophos;i="6.15,262,1739865600"; d="scan'208";a="70492723"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 May 2025 08:27:35 -0700
X-CSE-ConnectionGUID: a9bEOYESSn2nHvrJetAOgQ==
X-CSE-MsgGUID: h9U7fUcbSLCFsdXBqmxAfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,262,1739865600"; d="scan'208";a="172280449"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa001.jf.intel.com with ESMTP; 04 May 2025 08:27:32 -0700
Date: Sun, 4 May 2025 23:48:32 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Francesco Lavra <francescolavra.fl@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>
Subject: Re: [PATCH v8 42/55] cpu: Don't set vcpu_dirty when
 guest_state_protected
Message-ID: <aBeMUMEvnX1NFpUA@intel.com>
References: <20250401130205.2198253-1-xiaoyao.li@intel.com>
 <20250401130205.2198253-43-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250401130205.2198253-43-xiaoyao.li@intel.com>
Received-SPF: pass client-ip=198.175.65.9; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -57
X-Spam_score: -5.8
X-Spam_bar: -----
X-Spam_report: (-5.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.411,
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

On Tue, Apr 01, 2025 at 09:01:52AM -0400, Xiaoyao Li wrote:
> Date: Tue,  1 Apr 2025 09:01:52 -0400
> From: Xiaoyao Li <xiaoyao.li@intel.com>
> Subject: [PATCH v8 42/55] cpu: Don't set vcpu_dirty when
>  guest_state_protected
> X-Mailer: git-send-email 2.34.1
> 
> QEMU calls kvm_arch_put_registers() when vcpu_dirty is true in
> kvm_vcpu_exec(). However, for confidential guest, like TDX, putting
> registers is disallowed due to guest state is protected.
> 
> Only set vcpu_dirty to true with guest state is not protected when
> creating the vcpu.
> 
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> ---
> Changes in v7:
>  - new patch to replace "i386/tdx: Don't get/put guest state for TDX VMs"
>    in v6;
> ---
>  accel/kvm/kvm-all.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


