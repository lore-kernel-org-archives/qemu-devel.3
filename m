Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C2F3C9833E
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 06:28:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xB4pX-00031B-TX; Mon, 28 Sep 2026 02:27:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1xB4pU-000300-Ow; Mon, 28 Sep 2026 02:27:12 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1xB4pR-000619-Os; Mon, 28 Sep 2026 02:27:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790576830; x=1822112830;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=Aza63WU/5csk9n4J8JDPlFxyZoeVVVisOoh9N2U7Zp0=;
 b=Q3cu+I8NeyXYH7vSqmoETlnP2cSbN3E7cgfd0MTtPnVU9+hfXhlon2BT
 a+Do7jab3OUBl8gIcoPQEgFv7ZOq96U+HWi+ehDr6uI3XNvSqcP60Xk81
 dduhtIuHogNWPgrdj/fIOzbpYQ6zH6E6/HpSMAkGFPHHNhIOPYpRFKj68
 JBakGRL9/39RZV8evghvJZ43t3js5sYiFPag55TnhI9hIzeh0k4uiLwDD
 +4xyEt2ZRFdjIdhcanWvuPbsfsWeNtV57BzQWOoh99sprhrjSKCgmSTg0
 WwNXV6h9m65ViFVYMen9/GkGuWfUL6NbOYAs2bFIsMKxNuEOJeYySNTsl A==;
X-CSE-ConnectionGUID: 39R5vK+KSSSTi3wgJMLutQ==
X-CSE-MsgGUID: HuCVjhOMTXmEHLlZECpF+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11918"; a="102638288"
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; d="scan'208";a="102638288"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Sep 2026 23:27:03 -0700
X-CSE-ConnectionGUID: 4XqZDyeAQHWIlFcLahsrkQ==
X-CSE-MsgGUID: TUEMGebASdaKayeTzv2I5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; d="scan'208";a="274202506"
Received: from zhaoliu1-desk.sh.intel.com (HELO localhost) ([10.238.208.118])
 by fmviesa010.fm.intel.com with ESMTP; 27 Sep 2026 23:27:01 -0700
Date: Mon, 28 Sep 2026 14:26:59 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-riscv@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v3 17/21] target/i386: Use an acquire load for
 interrupt_request
Message-ID: <aroIs/s9lhoqUrlS@intel.com>
References: <20260923171116.31276-1-philmd@oss.qualcomm.com>
 <20260923171116.31276-18-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260923171116.31276-18-philmd@oss.qualcomm.com>
Received-SPF: pass client-ip=192.198.163.10; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Sep 23, 2026 at 07:11:11PM +0200, Philippe Mathieu-Daudé wrote:
> Date: Wed, 23 Sep 2026 19:11:11 +0200
> From: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> Subject: [PATCH v3 17/21] target/i386: Use an acquire load for
>  interrupt_request
> X-Mailer: git-send-email 2.53.0
> 
> x86_cpu_has_work() may run without the BQL, but currently reads
> CPUState::interrupt_request directly. Other threads update this
> field with qatomic_or() in cpu_set_interrupt(), so the direct
> read races with an atomic access.
> 
> Load the interrupt request with qatomic_load_acquire(), matching
> cpu_test_interrupt(). This provides the acquire ordering required
> before x86_cpu_pending_interrupt() inspects the CPU state.
> 
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>  target/i386/cpu.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

(and I agree with Richard's comment :-))

Regards,
Zhao


