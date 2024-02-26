Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A56DDC48BF6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 09:49:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reXbY-0005vy-PS; Mon, 26 Feb 2024 04:49:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1reXbW-0005sW-67; Mon, 26 Feb 2024 04:48:58 -0500
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1reXbT-0002Cw-2y; Mon, 26 Feb 2024 04:48:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1708940935; x=1740476935;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=bVO41e4zPtJH5qmN17JgAlI9BZ418Qj0Yiy10/OkBTk=;
 b=IYuwH/tQP1OQzRJ8XrbJrnDNNDf5lP3Ee33KV5CPqRRlWFElIHNKttrh
 8QGGwmswq8o0TJCBQ/XaBMNXVuqomON/h8eaVseUcYbngzGlpLaQmUw4Z
 v6Jb7doWPgv4jnNSnb6HUe2V1KKwdkT6o19PSbUJ5Zfag3k8LtgUjPVRe
 oGXg6XqUS35uIZn04+A2+YtSFyn0vIbYJWDaxD5E95mfvU1oq1n2Llxnv
 1zMQOq2Du1j71GjWloSst+NlKTI/zM2Z2dTb+F10vO9NQCcSA9l+p8yYK
 cXPSMsP6u58hyZh6YgpU/wwfW78Eq5yNlTNhh031zEVftOcrl8KyzNTy4 A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="3333578"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="3333578"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2024 01:48:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="6539807"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa009.fm.intel.com with ESMTP; 26 Feb 2024 01:48:50 -0800
Date: Mon, 26 Feb 2024 18:02:32 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: dinglimin <dinglimin@cmss.chinamobile.com>
Cc: richard.henderson@linaro.org, philmd@linaro.org, qemu-devel@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>, qemu-trivial@nongnu.org
Subject: Re: [PATCH] semihosting/uaccess.c: Replaced a malloc call with
 g_malloc
Message-ID: <ZdxhuN8w/wB7yZrx@intel.com>
References: <20240226090628.1986-1-dinglimin@cmss.chinamobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240226090628.1986-1-dinglimin@cmss.chinamobile.com>
Received-SPF: pass client-ip=198.175.65.18; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.097,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, Feb 26, 2024 at 05:06:28PM +0800, dinglimin wrote:
> Date: Mon, 26 Feb 2024 17:06:28 +0800
> From: dinglimin <dinglimin@cmss.chinamobile.com>
> Subject: [PATCH] semihosting/uaccess.c: Replaced a malloc call with g_malloc
> X-Mailer: git-send-email 2.30.0.windows.2
> 
> Signed-off-by: dinglimin <dinglimin@cmss.chinamobile.com>
> ---
>  semihosting/uaccess.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Also cc Michael and qemu-trivial@nongnu.org.
I understand the simple cleanup can cc qemu-trivial@nongnu.org. ;-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

> 
> diff --git a/semihosting/uaccess.c b/semihosting/uaccess.c
> index dc587d73bc..7788ead9b2 100644
> --- a/semihosting/uaccess.c
> +++ b/semihosting/uaccess.c
> @@ -14,10 +14,10 @@
>  void *uaccess_lock_user(CPUArchState *env, target_ulong addr,
>                          target_ulong len, bool copy)
>  {
> -    void *p = malloc(len);
> +    void *p = g_try_malloc(len);
>      if (p && copy) {
>          if (cpu_memory_rw_debug(env_cpu(env), addr, p, len, 0)) {
> -            free(p);
> +            g_free(p);
>              p = NULL;
>          }
>      }
> @@ -87,5 +87,5 @@ void uaccess_unlock_user(CPUArchState *env, void *p,
>      if (len) {
>          cpu_memory_rw_debug(env_cpu(env), addr, p, len, 1);
>      }
> -    free(p);
> +    g_free(p);
>  }
> -- 
> 2.30.0.windows.2

