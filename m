Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB8B8C54E64
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 03:49:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpgkH-0007Wm-7K; Wed, 27 Mar 2024 23:48:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rpgkD-0007Wa-Vc
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 23:48:01 -0400
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rpgkB-00062A-8A
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 23:48:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1711597679; x=1743133679;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=CZmyMDYmLGJt1aVeM7GMIos7pinDxlgS7ivSaGO4u00=;
 b=V0ea/Kl9AVT+FmDuwoH9YqMHru1c2XBUQXirjKqwyMjPDdYDYy6PIlXg
 UCkx5LmJ1SvQxHK6n+1Dm9OFejSvxctaNpSK6juKfcM6yj5NmXzjg7gJ2
 baGy9WarrX/3E4wzsTiYWiKlFhCNEcjhM+LrdLTl98cIhEj9yT5D/c3jc
 P2lCKE/yWt/DDitj1L8P9n3X6RuDbT/wt0CCVgw9n1rU/con/PtuXfgdW
 tTEJoi97U3aiQV69VUH6hanmez9luQGhG0xp+Xmbhy84rsZxh405IlBAk
 8sSviQaNO/BBczBmUgO1TaPzk2cfkzNQ5u5lzgGrdFIJf+oZdfuBkEIzY Q==;
X-CSE-ConnectionGUID: JxaRD7XQQeik92LDGx3HGQ==
X-CSE-MsgGUID: SfzVBNPbQLqSTKcyziTn0Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="6597091"
X-IronPort-AV: E=Sophos;i="6.07,160,1708416000"; 
   d="scan'208";a="6597091"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2024 20:47:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,160,1708416000"; d="scan'208";a="16538537"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa009.fm.intel.com with ESMTP; 27 Mar 2024 20:47:54 -0700
Date: Thu, 28 Mar 2024 12:01:49 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, devel@lists.libvirt.org,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Ani Sinha <anisinha@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org
Subject: Re: [PATCH-for-9.1 v2 20/21] target/i386: Remove
 X86CPU::kvm_no_smi_migration field
Message-ID: <ZgTrrZVam/hEdcU0@intel.com>
References: <20240327095124.73639-1-philmd@linaro.org>
 <20240327095124.73639-21-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240327095124.73639-21-philmd@linaro.org>
Received-SPF: pass client-ip=192.198.163.17; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Wed, Mar 27, 2024 at 10:51:22AM +0100, Philippe Mathieu-Daudé wrote:
> Date: Wed, 27 Mar 2024 10:51:22 +0100
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: [PATCH-for-9.1 v2 20/21] target/i386: Remove
>  X86CPU::kvm_no_smi_migration field
> X-Mailer: git-send-email 2.41.0
> 
> X86CPU::kvm_no_smi_migration was only used by the
> pc-i440fx-2.3 machine, which got removed. Remove it
> and simplify kvm_put_vcpu_events().
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  target/i386/cpu.h     | 3 ---
>  target/i386/cpu.c     | 2 --
>  target/i386/kvm/kvm.c | 7 +------
>  3 files changed, 1 insertion(+), 11 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


