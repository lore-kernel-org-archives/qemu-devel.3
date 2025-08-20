Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D43BCA0EED
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Aug 2025 09:44:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uofLt-0007nN-9h; Wed, 20 Aug 2025 05:43:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uofLq-0007mL-28
 for qemu-devel@nongnu.org; Wed, 20 Aug 2025 05:43:26 -0400
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uofLn-0003Yy-4O
 for qemu-devel@nongnu.org; Wed, 20 Aug 2025 05:43:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1755683003; x=1787219003;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=qbfLSEb5FUUQ6c3gyDdGEr7Q6EBZVrcThkqOwEyKN6U=;
 b=M49slmzDF2ff21ajqKA44fcXziXl/BdpW5TNHJPr/DsEGSNby/93EqbJ
 w5PmeQdijumwmTEZ5RF/AhzXXj0CpApdVuYVPCCne/nhU5rqHEMmd1G0G
 s7LSiLM5fYg3gfn708MKezyEsm9MAGSGh9XJIqdAiD820PsHWDaY2Efb2
 anwxEYJuWieuAPaCejrr17IHk9L/UUYVxlcy9ZQbesfq7qyL/DIgtaxOR
 yHyBoCuxoXqVRR8iZuFebsKBpmelWxEqH4TJuZMl+L+xAI8ivHZR+oJLQ
 gfyPEJ0gLjO1KLNedDFCi5wuWW2/uEnvfhKQguh02W5U3xReNAhTkk6Ap w==;
X-CSE-ConnectionGUID: aLfN5bIJSVq3aWxDgVXYrg==
X-CSE-MsgGUID: rK7eojAWR5W4+XBQJq8A6Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="80538353"
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; d="scan'208";a="80538353"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Aug 2025 02:43:18 -0700
X-CSE-ConnectionGUID: nQrmfFvhQ8i1OfEs0NMjnw==
X-CSE-MsgGUID: yG9eNSCdRLK6BPZV29L8JA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; d="scan'208";a="191774253"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa002.fm.intel.com with ESMTP; 20 Aug 2025 02:43:16 -0700
Date: Wed, 20 Aug 2025 18:05:00 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Wang Xin <wangxinxin.wang@huawei.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, weidong.huang@huawei.com,
 Tuo Xie <xietuo@huawei.com>
Subject: Re: [PATCH] target/i386: Add support save/load exception error_code
Message-ID: <aKWdzEt2zUByeMwH@intel.com>
References: <20250819145834.3998-1-wangxinxin.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819145834.3998-1-wangxinxin.wang@huawei.com>
Received-SPF: pass client-ip=198.175.65.9; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Tue, Aug 19, 2025 at 10:58:34PM +0800, Wang Xin wrote:
> Date: Tue, 19 Aug 2025 22:58:34 +0800
> From: Wang Xin <wangxinxin.wang@huawei.com>
> Subject: [PATCH] target/i386: Add support save/load exception error_code
> X-Mailer: git-send-email 2.50.1.windows.1
> 
> From: WangXin <wangxinxin.wang@huawei.com>
> 
> For now, qemu save/load CPU exception info(such as exception_nr and
> has_error_code), while the exception error_code is ignored. This will
> cause the dest hypervisor reinject a vCPU exception with error_code(0),
> potentially causing a guest kernel panic.
> 
> For instance, if src VM stopped with an user-mode write #PF (error_code 6),
> the dest hypervisor will reinject an #PF with error_code(0) when vCPU resume,
> then guest kernel panic as:
>   BUG: unable to handle page fault for address: 00007f80319cb010
>   #PF: supervisor read access in user mode
>   #PF: error_code(0x0000) - not-present page
>   RIP: 0033:0x40115d
> 
> To fix it, support save/load exception error_code.
> 
> Signed-off-by: Xin Wang <wangxinxin.wang@huawei.com>
> Signed-off-by: Tuo Xie <xietuo@huawei.com>

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


