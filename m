Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16573C83030
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 08:31:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXFKv-0007fN-UM; Thu, 03 Jul 2025 04:30:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uXFKs-0007f4-EC
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 04:30:27 -0400
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uXFKp-0006MK-Vg
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 04:30:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751531425; x=1783067425;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=d/DU3BP7NVsjJCnv0D7mFZcycE79rWuP7Z3t0ZemRkc=;
 b=f4ew2BTlblaC41Wui5I+9h2EmoxLkd8+ZwXl/V+bGxmCb+9YsMU+ihU6
 5JpgK3ymYHFRNme/Q7GeLZA3YBGq+PhynuwkyIATsezOCxn1uByri8XIx
 Wa/Nr6gH8yE9QcZKGOrja151Nt7qMqTRsQFPCOKnnEH+8bogsCN1FMwEb
 lzLzAjBiCS/sd6e1im5S0rBEQSjA1OVO/5OQ8UPiHjoyHUWH/t3CMIFIo
 w61U8bHXgMUCIO7vLqjA4zojx21nutJR2NVq/MQ/QRgu3rSFEM0lFrwqj
 JQuep2QaEumkJBHpIaVYxPErrf1m7xyp/8gGh8mCwTnmml4wPiDnfcQ4G g==;
X-CSE-ConnectionGUID: JnSpa0vCTqezyFjn2sBHrA==
X-CSE-MsgGUID: DHdN4jlYRAqBKjpu4J0AVA==
X-IronPort-AV: E=McAfee;i="6800,10657,11482"; a="53960767"
X-IronPort-AV: E=Sophos;i="6.16,283,1744095600"; d="scan'208";a="53960767"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2025 01:30:22 -0700
X-CSE-ConnectionGUID: SiJOV2N+SrG95Nx6esvQ5g==
X-CSE-MsgGUID: cWQjwBAYS9ef5soO2F5cwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,283,1744095600"; d="scan'208";a="154797113"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa008.jf.intel.com with ESMTP; 03 Jul 2025 01:30:20 -0700
Date: Thu, 3 Jul 2025 16:51:45 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: Re: [PATCH v4 65/65] accel/tcg: Unregister the RCU before exiting RR
 thread
Message-ID: <aGZEofGtmQjsKbJe@intel.com>
References: <20250702185332.43650-1-philmd@linaro.org>
 <20250702185332.43650-66-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250702185332.43650-66-philmd@linaro.org>
Received-SPF: pass client-ip=198.175.65.16; envelope-from=zhao1.liu@intel.com;
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

On Wed, Jul 02, 2025 at 08:53:27PM +0200, Philippe Mathieu-Daudé wrote:
> Date: Wed,  2 Jul 2025 20:53:27 +0200
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: [PATCH v4 65/65] accel/tcg: Unregister the RCU before exiting RR
>  thread
> X-Mailer: git-send-email 2.49.0
> 
> Although unreachable, still unregister the RCU before exiting
> the thread, as documented in "qemu/rcu.h":
> 
>  /*
>   * Important !
>   *
>   * Each thread containing read-side critical sections must be registered
>   * with rcu_register_thread() before calling rcu_read_lock().
>   * rcu_unregister_thread() should be called before the thread exits.
>   */
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Acked-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  accel/tcg/tcg-accel-ops-rr.c | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


