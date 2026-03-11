Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEF5BFD064E
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 07:43:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0EDI-0005sc-Hd; Wed, 11 Mar 2026 03:42:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1w0EDG-0005sE-OA; Wed, 11 Mar 2026 03:42:38 -0400
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1w0EDE-00063u-Tq; Wed, 11 Mar 2026 03:42:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773214956; x=1804750956;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=4VPH06at6S/BQIH/65F6vrzONUraudyS1Rej7YvhBlI=;
 b=cRQei0/ZUQvm+6HVFXQy7gNuRnoAJRGweeag9mlEh4mfNBf9fvLlNQAT
 1l3V946TqmVpJ0tBB1vWJ6nHSAhPwmx5n7V82V/Py1sGMFxDZ4zrAxdbM
 uc4xb1pifgxSEyOE+ePGgfa6V7kzKqLo0DtWK99Ds7Ill58TfEdywmhA7
 GWpjSrsFlL6+cZbneYhw4mVLQ8Ni70Yga98WPEWNOKM1YnNKDtB92YA6p
 IPo1XLyOYemy00txOPFU3n9DRcb1r5qzmw5aKn5KsQcqotEuQ8bQT4NRM
 0GYF/vENZ/Tix7z9odjuBVF4FhLu7n0UlonXJE/lgr8ZA5vZ32EWvuzhh g==;
X-CSE-ConnectionGUID: 7wjXyT0lTjiyZMyzTc0qLw==
X-CSE-MsgGUID: WGRi4kHeQIGO1AsG7TQYvg==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="91845148"
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; d="scan'208";a="91845148"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Mar 2026 00:42:32 -0700
X-CSE-ConnectionGUID: XK3k5crSR6u5uy1+aqMu7Q==
X-CSE-MsgGUID: e8p/n7YIRUOmUs+84VCoEg==
X-ExtLoop1: 1
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa003.fm.intel.com with ESMTP; 11 Mar 2026 00:42:30 -0700
Date: Wed, 11 Mar 2026 16:08:40 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, mst@redhat.com,
 marcel.apfelbaum@gmail.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, eduardo@habkost.net,
 peterx@redhat.com, farosas@suse.de, wangxinxin.wang@huawei.com
Subject: Re: [PATCH v2] target/i386: add compat for migrating error code
Message-ID: <abEjCF+DZiRTy6CN@intel.com>
References: <20260310154348.495332-1-f.ebner@proxmox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260310154348.495332-1-f.ebner@proxmox.com>
Received-SPF: pass client-ip=192.198.163.8; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Mar 10, 2026 at 04:43:23PM +0100, Fiona Ebner wrote:
> Date: Tue, 10 Mar 2026 16:43:23 +0100
> From: Fiona Ebner <f.ebner@proxmox.com>
> Subject: [PATCH v2] target/i386: add compat for migrating error code
> X-Mailer: git-send-email 2.47.3
> 
> If cpu->env.has_error_code is true, backwards migration of a VM from
> a QEMU binary with commit 27535e9cca to a QEMU binary without commit
> 27535e9cca will fail:
> 
> > kvm: error while loading state for instance 0x0 of device 'cpu'
> 
> In practice, wrongly setting the error code to 0 on the target is
> often unproblematic, so additionally checking error_code != 0 in
> cpu_errcode_needed() is not enough to mitigate the issue. Instead, add
> proper machine version compat handling.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: 27535e9cca ("target/i386: Add support for save/load of exception error code")
> Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
> ---
> 
> Changes in v2:
> * Add proper machine version compat rather than just checking if
>   error_code != 0.
> 
>  hw/i386/pc.c          | 1 +
>  target/i386/cpu.c     | 1 +
>  target/i386/cpu.h     | 1 +
>  target/i386/machine.c | 2 +-
>  4 files changed, 4 insertions(+), 1 deletion(-)

...

> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index 5a62aa6157..ecae8593c8 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -2361,6 +2361,7 @@ struct ArchCPU {
>      bool expose_tcg;
>      bool migratable;
>      bool migrate_smi_count;

only a nit, it's better to have a comment like:

    /*
     * Compatibility bits for old machine types.
     * If true, allow to migrate error code.
     */

> +    bool migrate_error_code;
>      uint32_t apic_id;

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


