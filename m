Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DD34C52D71
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2024 05:58:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1scIdN-0007tY-IH; Fri, 09 Aug 2024 01:57:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1scIdK-0007sQ-V1; Fri, 09 Aug 2024 01:57:51 -0400
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1scIdI-0000O0-NK; Fri, 09 Aug 2024 01:57:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1723183069; x=1754719069;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=xnP+MSR/wvIrA5raQK0NBZEHIJRmZdfsczn+tYlznUM=;
 b=KbRu3k59tDZczK4V4XKTxUgUTCgH5X0AB6Hvdn71Q0uVyiWWigtzK42t
 /QHmC+kKLBTu5e4Inc0qtxbdGMOElI3FtGlDSexB1IMRCWKicVqLlnaut
 XYZzADtQSkmS3rhrRqwQEOdb9xw3qOMraXEIR3jC+4Jmt88Kq28BNAmJf
 zTNbzWqiBgjvVwNKwsdArsgtLECACz6jIht9Zz6H8eXL8FrFx0bzC1fhH
 cJe4sUMpm39xgwva7RzrPqiyBKB9IvLp9mcUQYSbfKW3IxeO5QSz+0az9
 gQeieP3oGUHY0n00oJ1bhUDwF8x5qhraT329QUE42BnmuP35f98omiNvW w==;
X-CSE-ConnectionGUID: Vl/VQxicTvyAGdbhv2pTLQ==
X-CSE-MsgGUID: kUsXEP44QNmt5MChrH0CNA==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="20905618"
X-IronPort-AV: E=Sophos;i="6.09,275,1716274800"; d="scan'208";a="20905618"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Aug 2024 22:57:39 -0700
X-CSE-ConnectionGUID: WDs2KvbSQLWNIMcbVD4wjQ==
X-CSE-MsgGUID: tkfS8gnOSyeGcFimJ4QBTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,275,1716274800"; d="scan'208";a="80702279"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa002.fm.intel.com with ESMTP; 08 Aug 2024 22:57:37 -0700
Date: Fri, 9 Aug 2024 14:13:28 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-trivial@nongnu.org,
 kvm@vger.kernel.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 1/2] kvm: replace fprintf with error_report() in
 kvm_init() for error conditions
Message-ID: <ZrWziCQWgLogq+lV@intel.com>
References: <20240809051054.1745641-1-anisinha@redhat.com>
 <20240809051054.1745641-2-anisinha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240809051054.1745641-2-anisinha@redhat.com>
Received-SPF: pass client-ip=192.198.163.18; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

On Fri, Aug 09, 2024 at 10:40:53AM +0530, Ani Sinha wrote:
> Date: Fri,  9 Aug 2024 10:40:53 +0530
> From: Ani Sinha <anisinha@redhat.com>
> Subject: [PATCH v2 1/2] kvm: replace fprintf with error_report() in
>  kvm_init() for error conditions
> X-Mailer: git-send-email 2.45.2
> 
> error_report() is more appropriate for error situations. Replace fprintf with
> error_report. Cosmetic. No functional change.
> 
> CC: qemu-trivial@nongnu.org
> CC: zhao1.liu@intel.com
> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> ---
>  accel/kvm/kvm-all.c | 40 ++++++++++++++++++----------------------
>  1 file changed, 18 insertions(+), 22 deletions(-)
> 
> changelog:
> v2: fix a bug.

Generally good to me. Only some nits below, otherwise,

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

>  #ifdef TARGET_S390X
>          if (ret == -EINVAL) {
> -            fprintf(stderr,
> -                    "Host kernel setup problem detected. Please verify:\n");
> -            fprintf(stderr, "- for kernels supporting the switch_amode or"
> -                    " user_mode parameters, whether\n");
> -            fprintf(stderr,
> -                    "  user space is running in primary address space\n");
> -            fprintf(stderr,
> -                    "- for kernels supporting the vm.allocate_pgste sysctl, "
> -                    "whether it is enabled\n");
> +            error_report("Host kernel setup problem detected. Please verify:");

The doc of error_report() said it doesn't want multiple sentences or trailing
punctuation:

"The resulting message should be a single phrase, with no newline or trailing
punctuation."

So I think these extra messages (with complex formatting & content) are
better printed with error_printf() as I suggested in [1].

[1]: https://lore.kernel.org/qemu-devel/ZrWP0fWPNzeAvjja@intel.com/T/#m953afd879eb6279fcdf03cda594c43f1829bdffe

> +            error_report("- for kernels supporting the switch_amode or"
> +                        " user_mode parameters, whether");
> +            error_report("  user space is running in primary address space");
> +            error_report("- for kernels supporting the vm.allocate_pgste "
> +                        "sysctl, whether it is enabled");
>          }
>  #elif defined(TARGET_PPC)
>          if (ret == -EINVAL) {
> -            fprintf(stderr,
> -                    "PPC KVM module is not loaded. Try modprobe kvm_%s.\n",
> -                    (type == 2) ? "pr" : "hv");
> +            error_report("PPC KVM module is not loaded. Try modprobe kvm_%s.",
> +                        (type == 2) ? "pr" : "hv");

Same here. A trailing punctuation. If possible, feel free to refer to
the comment in [1].

>          }
>  #endif

[snip]

> @@ -2542,8 +2538,8 @@ static int kvm_init(MachineState *ms)
>      }
>      if (missing_cap) {
>          ret = -EINVAL;
> -        fprintf(stderr, "kvm does not support %s\n%s",
> -                missing_cap->name, upgrade_note);
> +        error_report("kvm does not support %s", missing_cap->name);
> +        error_report("%s", upgrade_note);

"upgrade_note" string also has the trailing punctuation, and it's
also better to use error_printf() to replace the 2nd error_report().

For this patch, error_report() is already a big step forward, so I think
these few nits doesn't block this patch.

Thank you for your patience.
Zhao


