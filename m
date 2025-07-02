Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCE0BC8303D
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 02:08:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWmtj-0006xf-Vc; Tue, 01 Jul 2025 22:08:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uWmth-0006xP-9i
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 22:08:29 -0400
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uWmtb-00035w-0I
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 22:08:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751422103; x=1782958103;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=FsdKYmDatCxUVwe9w4gO57fvEC3oHF2ZeK3IcATW23k=;
 b=G1W3d1Ir0ImFAMruQurQXFvvZXMN49+jQ+arExbeqk5CQ8lwAfL1m5dj
 74TeFoRKqwbsVoZRhSjzVxAmK8t7XbC55uJcap6DFmDtBCmqHDU5Trdkg
 ijo2jNxkUPx11Ja7m0VyyayXFK+2sR8KWsmbpU/ASnt3y6zbl3TsUHiEc
 ApY5LP7CvpFDvpE2c31Wir8EYDVUu1kPdJtB7UJhC2ssFjMoK+59tISgD
 kiljkYSMscy+0IqiqkSH+d67jN2XC6zJG61RoNkAfCvGNZzTZbH+CRyNx
 AQgISh8uJo/Usif1FgvVRHtUjb6gutHZqaK72Kqyt0LHn5kP+P2cYdrPJ g==;
X-CSE-ConnectionGUID: 0Or02HCiSfW2BHO4FFJv6A==
X-CSE-MsgGUID: 9JMigKfGRFCv0scKD8OudQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11481"; a="53637181"
X-IronPort-AV: E=Sophos;i="6.16,280,1744095600"; d="scan'208";a="53637181"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jul 2025 19:08:19 -0700
X-CSE-ConnectionGUID: pT2HLC+pT0K89+jeNj5n8Q==
X-CSE-MsgGUID: DuxzbOTQQlaTFTuaT9Wv2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,280,1744095600"; d="scan'208";a="177607192"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa002.fm.intel.com with ESMTP; 01 Jul 2025 19:08:11 -0700
Date: Wed, 2 Jul 2025 10:29:36 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Wei Liu <liuwe@linux.microsoft.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Sergio Andres Gomez Del Real <Sergio.G.DelReal@gmail.com>
Subject: Re: [RFC PATCH] target/i386: Report TPR accesses to HVF
Message-ID: <aGSZkJeoMVI0yCuM@intel.com>
References: <20250616090632.55214-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250616090632.55214-1-philmd@linaro.org>
Received-SPF: pass client-ip=192.198.163.17; envelope-from=zhao1.liu@intel.com;
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

On Mon, Jun 16, 2025 at 11:06:32AM +0200, Philippe Mathieu-Daudé wrote:
> Date: Mon, 16 Jun 2025 11:06:32 +0200
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: [RFC PATCH] target/i386: Report TPR accesses to HVF
> X-Mailer: git-send-email 2.49.0
> 
> HVF should be able to handle task priority register accesses.
> 
> Cc: Sergio Andres Gomez Del Real <Sergio.G.DelReal@gmail.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> RFC: Untested as I don't have access to such setup, noticed
> during code review.
> ---
>  target/i386/helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Untested too. But code looks fine for me,

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


