Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D8FCCD5BA0
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Nov 2025 09:10:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJTKl-0006BC-UV; Thu, 13 Nov 2025 04:09:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vJTKe-00066b-CG; Thu, 13 Nov 2025 04:09:32 -0500
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vJTKb-0006XY-RX; Thu, 13 Nov 2025 04:09:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763024970; x=1794560970;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=HYtCHLm1VjKvp+3jFbMACUA6QhmvWqyHyieoy5nfuNQ=;
 b=L0iFoAl88u4JEPipOjj9Axt95j7YALuIJaqb2cEW5yzm5H45M10g1pqX
 czt4I32UyIZU18CF8fffKlnpGlocRYM7bDfl/xmWnwJQscCUFnAs9bst8
 SfPmVZi+nJLqhNXCM8POfjellhttJjtnP1HOG0wq7I0rNkBdpNNKVqMQW
 L8mhaT+yWW1YBaWX4Usdp/yvN1Zd1xhEO7lWJ8tk9MgIMz+NFySrddvR1
 CBafk9fxJfd8m+z2Mibch+OPIpMjcwd+7AlQjrnCMA1pnNYzYkhC7tFvh
 O9znx/zZ52lUySzOndspevm47JfL3X//03ZlcQ9uOkTF3IA7tPK637n/i w==;
X-CSE-ConnectionGUID: rIJdX/0+Q7SnT6dj9GHiGw==
X-CSE-MsgGUID: uRlSkbKMSiOpkNTQsY4T4w==
X-IronPort-AV: E=McAfee;i="6800,10657,11611"; a="82497238"
X-IronPort-AV: E=Sophos;i="6.19,301,1754982000"; d="scan'208";a="82497238"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Nov 2025 01:09:27 -0800
X-CSE-ConnectionGUID: e0O417TxTm+/v9dmWx/8yA==
X-CSE-MsgGUID: NJmPzYYESI6XcC2je1xoDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,301,1754982000"; d="scan'208";a="190210044"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa010.fm.intel.com with ESMTP; 13 Nov 2025 01:09:24 -0800
Date: Thu, 13 Nov 2025 17:31:42 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org,
 qemu-rust@nongnu.org
Subject: Re: [PATCH 21/22] rust/hpet: Replace BqlRefCell<HPETRegisters> with
 Mutex<HPETRegisters>
Message-ID: <aRWlfgShnpNbiLAP@intel.com>
References: <20251113051937.4017675-1-zhao1.liu@intel.com>
 <20251113051937.4017675-22-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251113051937.4017675-22-zhao1.liu@intel.com>
Received-SPF: pass client-ip=198.175.65.10; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
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

> @@ -179,8 +180,8 @@ const fn deactivating_bit(old: u64, new: u64, shift: usize) -> bool {
>  fn timer_handler(timer_cell: &BqlRefCell<HPETTimer>) {
>      let mut t = timer_cell.borrow_mut();
>      // SFAETY: state field is valid after timer initialization.
> -    let regs = &mut unsafe { t.state.as_mut() }.regs.borrow_mut();
> -    t.callback(regs)
> +    let mut regs = unsafe { t.state.as_ref() }.regs.lock().unwrap();
> +    t.callback(&mut regs)
>  }

callback()
 -> arm_timer(): access timer N register
 -> update_irq(): modify global register (int_status or "isr" in C code)

So timer handler needs to lock Mutex. But this may cause deadlock:

timer_hanlder -> lock BQL   -> try to lock Mutex
MMIO access   -> lock Mutex -> try to lock BQL

C HPET doesn't have such deadlock issue since it doesn't lock Mutex in
timer handler.

I think it seems necessay to lock Mutex in timer handler since there's
no guarantee to avoid data race...

Thanks,
Zhao



