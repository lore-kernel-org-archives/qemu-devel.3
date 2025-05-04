Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5344EC3ABAC
	for <qemu-devel@archiver.kernel.org>; Sun,  4 May 2025 15:26:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBbDl-0008IZ-Q8; Sun, 04 May 2025 11:25:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uBbDU-00087g-AU
 for qemu-devel@nongnu.org; Sun, 04 May 2025 11:25:22 -0400
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uBbDP-0007s2-RW
 for qemu-devel@nongnu.org; Sun, 04 May 2025 11:25:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746372315; x=1777908315;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=aVVB12iY3Eqbd7oYZWZBVSAEQOCOUbeVAGqucWecCOA=;
 b=MSb8ZUqri7kKchBpTPpgv5omFylgsKbK7zYfk4sHuRRJ811arSWKowYg
 WIBqRSracG1knoN93ISrXoltuPXd2wr97gLwmgq1JsgFsCJsxQBtSFa1l
 Zu+c5DFnI+whDQUIJkWth5oI7QWal6zPT9Ds48GBbcGVGCCD77qMiRYxc
 tYlJh6fN+aleki0E/SwWeyF7p8XXJvwpmf02sNHNQ41UJ6HijeiZe/eWD
 lB3/BzWJ25EK3JKMod3hum5mdLqxCEYVfQryIAiHEVvDXtlX+Y+e0U16D
 MxDVVBhQ3CgIYwQbaPDFM4grvrnZ8K2azi9LmbMJ4gxm3xbhIB80KLk5o g==;
X-CSE-ConnectionGUID: oyY19C26QUqbzkxIuoVKrA==
X-CSE-MsgGUID: ar98wj7OQqWUVONwhoFjEw==
X-IronPort-AV: E=McAfee;i="6700,10204,11423"; a="58647255"
X-IronPort-AV: E=Sophos;i="6.15,262,1739865600"; d="scan'208";a="58647255"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 May 2025 08:25:11 -0700
X-CSE-ConnectionGUID: x6+8tv/5SdGTN+D79CzgEw==
X-CSE-MsgGUID: gyVzb2i4T8um3KOdX1BOUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,262,1739865600"; d="scan'208";a="134938813"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa010.jf.intel.com with ESMTP; 04 May 2025 08:25:09 -0700
Date: Sun, 4 May 2025 23:46:08 +0800
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
Subject: Re: [PATCH v8 41/55] i386/apic: Skip kvm_apic_put() for TDX
Message-ID: <aBeLwMws9o11bq3a@intel.com>
References: <20250401130205.2198253-1-xiaoyao.li@intel.com>
 <20250401130205.2198253-42-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250401130205.2198253-42-xiaoyao.li@intel.com>
Received-SPF: pass client-ip=192.198.163.9; envelope-from=zhao1.liu@intel.com;
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

On Tue, Apr 01, 2025 at 09:01:51AM -0400, Xiaoyao Li wrote:
> Date: Tue,  1 Apr 2025 09:01:51 -0400
> From: Xiaoyao Li <xiaoyao.li@intel.com>
> Subject: [PATCH v8 41/55] i386/apic: Skip kvm_apic_put() for TDX
> X-Mailer: git-send-email 2.34.1
> 
> KVM neithers allow writing to MSR_IA32_APICBASE for TDs, nor allow for
> KVM_SET_LAPIC[*].
> 
> Note, KVM_GET_LAPIC is also disallowed for TDX. It is called in the path
> 
>   do_kvm_cpu_synchronize_state()
>   -> kvm_arch_get_registers()
>      -> kvm_get_apic()
> 
> and it's already disllowed for confidential guest through
> guest_state_protected.
> 
> [*] https://lore.kernel.org/all/Z3w4Ku4Jq0CrtXne@google.com/
> 
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> ---
> Changes in v8:
> - Fix the coding style; (Francesco)
> ---
>  hw/i386/kvm/apic.c | 5 +++++
>  1 file changed, 5 insertions(+)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


