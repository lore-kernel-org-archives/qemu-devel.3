Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D56DC83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 11:12:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXeKm-0001V6-95; Fri, 04 Jul 2025 07:12:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uXeKh-0001Tj-Dx
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 07:11:55 -0400
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uXeKe-0001PX-1D
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 07:11:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751627512; x=1783163512;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=o1Nrk5RUp6fY1bkTBtN3Hp9y0X6x3rmoyVhWTfb40es=;
 b=PdIH6utue9QzyoVdnS8Oxxu0x2bEA0uYpuJJSXp4PYtWRzz9mbbeOQ5V
 zV/M0j7BUC53tj+r22mqt9ITSHkzDFGWZVna2OFSKETZBgJgVoYoKpZua
 qTsBEtJWOX9hw/qNa5Vq2dDdFzadUktGi2dorGcFHmOLvxK6gMGnDZK+S
 RcOiWXKF+K6wOqeX4lszZKBP24ieB7Au/HIrmCYWhQUdiGKtCQSv0arFY
 EthL6QymsnPPKJktMQIJqGAKbktxpj94rOL0HHDOjFQV4kmc+pY/BTsiS
 YEP41N5grtuDS2dhTLAE6E/Jqq4mv9t+A8G+MAUhT0Q5NTI+Pu4UC56Zi w==;
X-CSE-ConnectionGUID: 5t3m/BQxQCSLB/4+FH855Q==
X-CSE-MsgGUID: uwWJ5dzZSPW7tGPwV/6FhQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="54104361"
X-IronPort-AV: E=Sophos;i="6.16,287,1744095600"; d="scan'208";a="54104361"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jul 2025 04:11:48 -0700
X-CSE-ConnectionGUID: 9GV3W5YtQfabXlm8uFAwUA==
X-CSE-MsgGUID: Rb2p5PN2TDWcFZtsdBilyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,287,1744095600"; d="scan'208";a="154746779"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa007.jf.intel.com with ESMTP; 04 Jul 2025 04:11:44 -0700
Date: Fri, 4 Jul 2025 19:33:09 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Mads Ynddal <mads@ynddal.dk>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>, Paul Durrant <paul@xen.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 Reinoud Zandijk <reinoud@netbsd.org>,
 Sunil Muthuswamy <sunilmut@microsoft.com>, kvm@vger.kernel.org,
 xen-devel@lists.xenproject.org
Subject: Re: [PATCH v6 30/39] accel: Propagate AccelState to
 AccelClass::init_machine()
Message-ID: <aGe79U/acV51nQM9@intel.com>
References: <20250703173248.44995-1-philmd@linaro.org>
 <20250703173248.44995-31-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250703173248.44995-31-philmd@linaro.org>
Received-SPF: pass client-ip=192.198.163.15; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.218,
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

On Thu, Jul 03, 2025 at 07:32:36PM +0200, Philippe Mathieu-Daudé wrote:
> Date: Thu,  3 Jul 2025 19:32:36 +0200
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: [PATCH v6 30/39] accel: Propagate AccelState to
>  AccelClass::init_machine()
> X-Mailer: git-send-email 2.49.0
> 
> In order to avoid init_machine() to call current_accel(),
> pass AccelState along.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  include/qemu/accel.h        | 2 +-
>  accel/accel-system.c        | 2 +-
>  accel/hvf/hvf-all.c         | 2 +-
>  accel/kvm/kvm-all.c         | 2 +-
>  accel/qtest/qtest.c         | 2 +-
>  accel/tcg/tcg-all.c         | 2 +-
>  accel/xen/xen-all.c         | 2 +-
>  bsd-user/main.c             | 2 +-
>  linux-user/main.c           | 2 +-
>  target/i386/nvmm/nvmm-all.c | 2 +-
>  target/i386/whpx/whpx-all.c | 2 +-
>  11 files changed, 11 insertions(+), 11 deletions(-)

...

> diff --git a/accel/accel-system.c b/accel/accel-system.c
> index b5b368c6a9c..fb8abe38594 100644
> --- a/accel/accel-system.c
> +++ b/accel/accel-system.c
> @@ -37,7 +37,7 @@ int accel_init_machine(AccelState *accel, MachineState *ms)
>      int ret;
>      ms->accelerator = accel;
>      *(acc->allowed) = true;
> -    ret = acc->init_machine(ms);
> +    ret = acc->init_machine(accel, ms);

Now we've already set "ms->accelerator", so that we could get @accel
by ms->accelerator.

But considerring the user emulation, where the @ms is NULL, and for
these cases, it needs to bring current_accel() back in patch 32.

Anyway, this solution is also fine for me, so,

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


...But there're still more comments/questions about user emulation:

> --- a/bsd-user/main.c
> +++ b/bsd-user/main.c
> @@ -474,7 +474,7 @@ int main(int argc, char **argv)
>                                   opt_one_insn_per_tb, &error_abort);
>          object_property_set_int(OBJECT(accel), "tb-size",
>                                  opt_tb_size, &error_abort);
> -        ac->init_machine(NULL);
> +        ac->init_machine(accel, NULL);

Not the issue about this patch though,

it seems user emulation doesn't set acc->allowed. At least TCG enabled
is necessary, I guess?

>      }
>  
>      /*
> diff --git a/linux-user/main.c b/linux-user/main.c
> index 5ac5b55dc65..a9142ee7268 100644
> --- a/linux-user/main.c
> +++ b/linux-user/main.c
> @@ -820,7 +820,7 @@ int main(int argc, char **argv, char **envp)
>                                   opt_one_insn_per_tb, &error_abort);
>          object_property_set_int(OBJECT(accel), "tb-size",
>                                  opt_tb_size, &error_abort);
> -        ac->init_machine(NULL);
> +        ac->init_machine(accel, NULL);

Ditto.

>      }
>  
>      /*

Thanks,
Zhao


