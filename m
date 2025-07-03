Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56F7FC77B7C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 08:20:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXFA4-0002PR-15; Thu, 03 Jul 2025 04:19:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uXF9z-0002PE-Q3
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 04:19:11 -0400
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uXF9x-0001gd-7b
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 04:19:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751530749; x=1783066749;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=5DHORijCX5eAH4gWwiIQCXX4hT0+mYI5gCAB94Rl49Y=;
 b=mPqtDnXcTpx4Wl2zp0zpQfk/yvmPkrjjHi9zbQ1SC2eBluhf9hDHJyxg
 twArDRUmaC8TigK+6iBuhxTMNMyk3nx5kYRksEjHyRZZ4ez4qKUOjGNsq
 Pjndh5X+FMcNLEZWaJcQpEiSwFDWlcjBc9DUxZH/Eo7244ayL5J+iT7cV
 C4sq6UaOLhol0WER6IG/aVxgQaCz8swiDfA/WmVOqrqOK2VA4C96wMJk/
 O209wSdWsmQ4ONj/vYHPWOqcrgrZmp9ybFb3B8m9pbs0zD36rgQqzjLKc
 +0CrmPN+2xkMnYyO7pV5KPJvejgx5/J89/azslGDX1ukO4Et6xA9wmEd/ g==;
X-CSE-ConnectionGUID: G77ZAEJiR9i6PA1SG7XcRA==
X-CSE-MsgGUID: ND1zqZgzR/mwvaqEmrcdiw==
X-IronPort-AV: E=McAfee;i="6800,10657,11482"; a="53962507"
X-IronPort-AV: E=Sophos;i="6.16,283,1744095600"; d="scan'208";a="53962507"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2025 01:19:06 -0700
X-CSE-ConnectionGUID: gUQOgkmjRrq48IDhQng3Zw==
X-CSE-MsgGUID: +xdD7Y4USxyr2ltNP8JH6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,283,1744095600"; d="scan'208";a="155050329"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa010.fm.intel.com with ESMTP; 03 Jul 2025 01:19:04 -0700
Date: Thu, 3 Jul 2025 16:40:29 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: Re: [PATCH v4 26/65] accel/tcg: Implement get_[vcpu]_stats()
Message-ID: <aGZB/cw1/eZNJ/0R@intel.com>
References: <20250702185332.43650-1-philmd@linaro.org>
 <20250702185332.43650-27-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250702185332.43650-27-philmd@linaro.org>
Received-SPF: pass client-ip=198.175.65.18; envelope-from=zhao1.liu@intel.com;
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

[It seems my previous reply was missing in mail list. If repetitive,
 please ignore it. :-) ]

Hi Philippe,

On Wed, Jul 02, 2025 at 08:52:48PM +0200, Philippe Mathieu-Daudé wrote:
> Date: Wed,  2 Jul 2025 20:52:48 +0200
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: [PATCH v4 26/65] accel/tcg: Implement get_[vcpu]_stats()
> X-Mailer: git-send-email 2.49.0
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  accel/tcg/tcg-all.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
> index ae83ca0bd10..d49d2b3b0fa 100644
> --- a/accel/tcg/tcg-all.c
> +++ b/accel/tcg/tcg-all.c
> @@ -239,11 +239,17 @@ static int tcg_gdbstub_supported_sstep_flags(AccelState *as)
>      }
>  }
>  
> +static void tcg_get_stats(AccelState *as, GString *buf)
> +{
> +    tcg_dump_flush_info(buf);
> +}
> +

With:

./configure

make -j

I met the error:

/usr/bin/ld: libuser.a.p/accel_tcg_tcg-all.c.o: in function `tcg_get_stats':
/qemu/build/../accel/tcg/tcg-all.c:244: undefined reference to `tcg_dump_flush_info'

It seems tcg_dump_flush_info() needs a stub?

Thanks,
Zhao




