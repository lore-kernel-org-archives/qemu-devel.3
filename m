Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BDBAC77B7C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 08:29:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXFJn-0006rq-Ex; Thu, 03 Jul 2025 04:29:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uXFJm-0006rc-0F
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 04:29:18 -0400
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uXFJj-0005re-0T
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 04:29:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751531355; x=1783067355;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=51+gFFdmepzo8qYIJYUhU9HT0NkgUsszN/f3MdC0dZk=;
 b=MrvhIGZzhs0ibFT9KpZ0VhmbBC4ND32fKAUj2XOzXWvxiZRQzWdWP69/
 oMUvfmbK2+polKPQ9Tmmo/n9L5uWpMlcB0q7mTbxLR7Kxvl7xVlw0JP8j
 XI2H+RUfHRloEU4+XfpCGIT3RZOcXh/GKjFhNAbmgqkgwlTJ19e1RWYQD
 muG9keK/zgNJiSuIn2L7PuERXs7X0lMZF4QbX6A05/6snvesWqaMKsuP6
 4sSc+KVy5f6jVbEo7V+uekHdxy6OnnOvnfuCeJ20rgpmLQlWj6uwRDIK4
 PHeI7bsWCwwRG8kOa05/tfJzZHZdKhjDIjcIKuRgtnbDKxxV6bGA7TruB A==;
X-CSE-ConnectionGUID: SC3MQk1PSom76EAcxIAOsA==
X-CSE-MsgGUID: hjlleKkOQ26l13pQFPEK7Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11482"; a="71417377"
X-IronPort-AV: E=Sophos;i="6.16,283,1744095600"; d="scan'208";a="71417377"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2025 01:29:13 -0700
X-CSE-ConnectionGUID: spJCeh+BT3a78EJen165LA==
X-CSE-MsgGUID: NHC6Mn/zTfS4N9rxFgnk7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,283,1744095600"; d="scan'208";a="159816001"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa004.fm.intel.com with ESMTP; 03 Jul 2025 01:29:11 -0700
Date: Thu, 3 Jul 2025 16:50:36 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: Re: [PATCH v4 63/65] accel/tcg: Factor rr_cpu_exec() out
Message-ID: <aGZEXBU0m9WbtTNu@intel.com>
References: <20250702185332.43650-1-philmd@linaro.org>
 <20250702185332.43650-64-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250702185332.43650-64-philmd@linaro.org>
Received-SPF: pass client-ip=192.198.163.8; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237,
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

On Wed, Jul 02, 2025 at 08:53:25PM +0200, Philippe Mathieu-Daudé wrote:
> Date: Wed,  2 Jul 2025 20:53:25 +0200
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: [PATCH v4 63/65] accel/tcg: Factor rr_cpu_exec() out
> X-Mailer: git-send-email 2.49.0
> 
> Altough we aren't going to re-use rr_cpu_exec(), factor
> it out to have RR implementation matches with MTTCG one.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  accel/tcg/tcg-accel-ops-rr.c | 31 ++++++++++++++++++++-----------
>  1 file changed, 20 insertions(+), 11 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


