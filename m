Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E65DC369D1
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 07:51:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8DqC-0007LE-4E; Fri, 25 Apr 2025 03:51:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u8Dq9-0007Ky-J2
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 03:51:17 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u8Dq7-00056r-SA
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 03:51:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1745567475; x=1777103475;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=BZqusQBZyDnBJsKfQrHAVWBpClWoCGYJAwfbRCNf7jg=;
 b=LAGAeBZc+GBu2lleLDgoB/wvPeb2t7+Vj4LdiifxwS63Ba1N9WB+8fdc
 qve/yTzMTu0a6eofYuUz0x2vlJG10TmIQNE5sChfOSs9cHOQWPNk6P/Ja
 d8rHyyfI9OH6f499Dd01EPItAH82kPj3/I0zHLRNTl0G8+4OzIKxhdKTV
 BC6cRLQxAA2G68IJfzZwTOtqDupqLs1SPae+fqahCr+XHYv/XsMG9XcXp
 6nX4HSbnm4KWUVMYNILYTf/+qtioOM2kmVHoFGdv2tqJUvSXL9OSR/zI7
 KjBrpCegOZo3Hi6hkusN7fkR56qUjMr93gNTPi3uucuYcrzZv1q4OdhJs g==;
X-CSE-ConnectionGUID: 8KNTyMi7QhSt5wRkNxE0wQ==
X-CSE-MsgGUID: mcsDrwDnTY+n2o8kbqLr4w==
X-IronPort-AV: E=McAfee;i="6700,10204,11413"; a="72592487"
X-IronPort-AV: E=Sophos;i="6.15,238,1739865600"; d="scan'208";a="72592487"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Apr 2025 00:51:12 -0700
X-CSE-ConnectionGUID: nhd2iUhZRsGWjkMDqe1UuQ==
X-CSE-MsgGUID: 7pivHPZrT9+VA+W/W3qzXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,238,1739865600"; d="scan'208";a="137926586"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa004.fm.intel.com with ESMTP; 25 Apr 2025 00:51:10 -0700
Date: Fri, 25 Apr 2025 16:12:06 +0800
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
Subject: Re: [PATCH v8 25/55] i386/tdx: Call KVM_TDX_INIT_VCPU to initialize
 TDX vcpu
Message-ID: <aAtD1ngjuDzmvJkH@intel.com>
References: <20250401130205.2198253-1-xiaoyao.li@intel.com>
 <20250401130205.2198253-26-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250401130205.2198253-26-xiaoyao.li@intel.com>
Received-SPF: pass client-ip=192.198.163.7; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.84,
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

On Tue, Apr 01, 2025 at 09:01:35AM -0400, Xiaoyao Li wrote:
> Date: Tue,  1 Apr 2025 09:01:35 -0400
> From: Xiaoyao Li <xiaoyao.li@intel.com>
> Subject: [PATCH v8 25/55] i386/tdx: Call KVM_TDX_INIT_VCPU to initialize
>  TDX vcpu
> X-Mailer: git-send-email 2.34.1
> 
> TDX vcpu needs to be initialized by SEAMCALL(TDH.VP.INIT) and KVM
> provides vcpu level IOCTL KVM_TDX_INIT_VCPU for it.
> 
> KVM_TDX_INIT_VCPU needs the address of the HOB as input. Invoke it for
> each vcpu after HOB list is created.
> 
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Acked-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  target/i386/kvm/tdx.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


