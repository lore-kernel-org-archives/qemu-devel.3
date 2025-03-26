Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 983FEC36008
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Mar 2025 08:30:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txM9C-0008KN-FR; Wed, 26 Mar 2025 04:30:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1txM99-0008JU-0k
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 04:29:59 -0400
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1txM95-0002zw-Nx
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 04:29:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1742977796; x=1774513796;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=pK0ln1xlfUcDI29zqR2jpLe+KIqRz6jmq2c/5JWOoGo=;
 b=MfbCNyiluBt9933x7xnqMpjD6cIDGNCOu1ndO3qGIvgvNJc7Vx9ROs38
 TVoO/HA9XYngcOsh3GKW2GCu0zZVf0xSlT5Fzq9cJOZVFiZyyMc+onuJY
 /lDITA5vDhzKHBwhqL48LwxELFVxRtKsmiiq3u2CS2yDRE5MZyqkppw4+
 +UZgwKHbgA9u4ZfjjlSy1p6KQykTOXd2kAEnNkB9Tte/IXlOKdYhspvZm
 fzVYDfJTAfsOoILzqfSp2LqSZ61RY0xYNR12kvLEhaHmpy6oWoWKB25aQ
 J/1bR0PHUlr+Dym0Cg2gBBpkAdzwuKrMhudvnyEQNNspquCzMTriUErOJ g==;
X-CSE-ConnectionGUID: ANpRgj0CQJmOJ+7fYaOIEQ==
X-CSE-MsgGUID: Nd5Ybz6FRCqFlIRt7dEjaA==
X-IronPort-AV: E=McAfee;i="6700,10204,11384"; a="55247301"
X-IronPort-AV: E=Sophos;i="6.14,277,1736841600"; d="scan'208";a="55247301"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2025 01:29:53 -0700
X-CSE-ConnectionGUID: ImVm2x7+SNKJZ9gnrKxj0Q==
X-CSE-MsgGUID: VeIFM/sIQuuhdTiu9Cr2Jw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,277,1736841600"; d="scan'208";a="129366216"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa005.fm.intel.com with ESMTP; 26 Mar 2025 01:29:50 -0700
Date: Wed, 26 Mar 2025 16:50:07 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: Re: [PATCH-for-10.1] target/i386/gdbstub: Replace ldtul_p() -> ldq_p()
Message-ID: <Z+O/v/ZwZmBFd32I@intel.com>
References: <20250325154528.93845-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250325154528.93845-1-philmd@linaro.org>
Received-SPF: pass client-ip=198.175.65.13; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Tue, Mar 25, 2025 at 04:45:28PM +0100, Philippe Mathieu-Daudé wrote:
> Date: Tue, 25 Mar 2025 16:45:28 +0100
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: [PATCH-for-10.1] target/i386/gdbstub: Replace ldtul_p() -> ldq_p()
> X-Mailer: git-send-email 2.47.1
> 
> When TARGET_LONG_BITS == 64, ldtul_p() expand to ldq_p().
> Directly use the expanded form for clarity.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  target/i386/gdbstub.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


