Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D483C5AD49
	for <qemu-devel@archiver.kernel.org>; Thu, 29 May 2025 08:51:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKYxx-0001Yc-OT; Thu, 29 May 2025 04:50:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uKYxt-0001Xc-OC; Thu, 29 May 2025 04:50:18 -0400
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uKYxr-0006fq-9K; Thu, 29 May 2025 04:50:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748508615; x=1780044615;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=Mvcy7k4AYPgRD7u2Sb9mK6YSW4GcuGLVMXyZN6T8CyM=;
 b=jBUyVdIACy1/aOvfsPn3bcG5rhYt/yoaxLEeaGLTLYaY8dayl0IRizp5
 W7YrJWOlDSjjo+WNeftVPoMkieyUZH5pZAIb+1XExgFaJhoFVCklD7aIp
 NZOaE0IxpMC7AQ5WDff9G3sZS9E0cM86hKIYTdY0UrDBeFJqqsvBNIzEs
 7fJWSQZRqsg7UErLmHBMIm4Lt1/9MvOB0torX4ucUnu9qFNedKYa/CFCH
 KyOo9e6CxtB7XuO+rcJ8CzqvoxkXXQ1sUg4HTfjAk5bFfhL0CNlgwCe5D
 QkQ9+9qvHjau60f6YmB2YMG2GiUpu5KuFk6J+WXK1zRQdk6NlgDlaQZqO g==;
X-CSE-ConnectionGUID: Ozad9zDjSbCrHRVXeZzxoA==
X-CSE-MsgGUID: eVRIgK9nS5KF0MFJ13bflg==
X-IronPort-AV: E=McAfee;i="6700,10204,11447"; a="54356444"
X-IronPort-AV: E=Sophos;i="6.15,323,1739865600"; d="scan'208";a="54356444"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 May 2025 01:50:12 -0700
X-CSE-ConnectionGUID: F48YEoAPTBOWEBOHBLuecg==
X-CSE-MsgGUID: cVStmxhuRoqyreWZMV1MRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,323,1739865600"; d="scan'208";a="148272072"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa003.jf.intel.com with ESMTP; 29 May 2025 01:50:11 -0700
Date: Thu, 29 May 2025 17:11:21 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, qemu-rust@nongnu.org
Subject: Re: [PATCH 09/12] rust/hpet: change timer of num_timers to usize
Message-ID: <aDgkuQ0Jo9mX9bGp@intel.com>
References: <20250526142254.1061009-1-pbonzini@redhat.com>
 <20250526142455.1061519-9-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250526142455.1061519-9-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.12; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -72
X-Spam_score: -7.3
X-Spam_bar: -------
X-Spam_report: (-7.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.904,
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

> @@ -1016,16 +1016,16 @@ impl ObjectImpl for HPETState {
>  static VMSTATE_HPET: VMStateDescription = VMStateDescription {
>      name: c"hpet".as_ptr(),
>      version_id: 2,
> -    minimum_version_id: 1,
> +    minimum_version_id: 2,
>      pre_save: Some(hpet_pre_save),
>      post_load: Some(hpet_post_load),
>      fields: vmstate_fields! {
>          vmstate_of!(HPETState, config),
>          vmstate_of!(HPETState, int_status),
>          vmstate_of!(HPETState, counter),
> -        vmstate_of!(HPETState, num_timers_save).with_version_id(2),
> +        vmstate_of!(HPETState, num_timers_save),
>          vmstate_validate!(HPETState, VALIDATE_TIMERS_NAME, HPETState::validate_num_timers),
> -        vmstate_struct!(HPETState, timers[0 .. num_timers], &VMSTATE_HPET_TIMER, BqlRefCell<HPETTimer>, HPETState::validate_num_timers).with_version_id(0),
> +        vmstate_struct!(HPETState, timers[0 .. num_timers_save], &VMSTATE_HPET_TIMER, BqlRefCell<HPETTimer>, HPETState::validate_num_timers).with_version_id(0),
>      },

Here Rust and C take slightly different paths.

Either changes should be made in the C version as well, or the
"functional\ [#issues]_ replacements" issue note in docs/devel/rust.rst
needs to be updated as well. I think the former is simpler!

Otherwise,

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


