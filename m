Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E18BBD13570
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2024 06:43:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5JT5-0006yy-Vo; Mon, 28 Oct 2024 02:43:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t5JT0-0006yQ-5S
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 02:43:06 -0400
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t5JSy-0008NN-2p
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 02:43:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730097784; x=1761633784;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=/ojNyzEvkXc3gjW31rjjvySL+jX2GWb/Xty5DpADLSs=;
 b=GWJAie3o3nprl1yeKiGSZQ4tUoWHKgwst3PK8lJumIgaVFj0GyZetHYE
 casPERj4XnRnWnZ5dXvscL6dwuN8RNbmrEgCwtyUVuU7i5kx+JupfXwm/
 wcdgdv0pjFBnnL7YbyATWfIqJLve/SvogYEcpmqIlGAf8pcV6uNqq+zUD
 XGyB9L0X17pdM6jfIUGU78YOz0DP9tSmg0VnRHM9cXrWQuz4JzfA0G8+8
 +Mk3Cgm27QaRaqUqZTkeXCDiL0lPCc+cmUlgvWKuT8pBVMkMMgZDLRDng
 oEcrZHOO8zwViOnA0CsexQPwzIGXsg6cH338sbGnvEHroddtbUzssB/65 w==;
X-CSE-ConnectionGUID: ZgifJiREQeiXGLsJ/Pe6GA==
X-CSE-MsgGUID: 9Tz8a+LxS2K6beuufcaVZw==
X-IronPort-AV: E=McAfee;i="6700,10204,11238"; a="40303041"
X-IronPort-AV: E=Sophos;i="6.11,238,1725346800"; d="scan'208";a="40303041"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2024 23:43:00 -0700
X-CSE-ConnectionGUID: iH8c8OTIT/ObRXKruBliKw==
X-CSE-MsgGUID: t2yVzOgIQLm5dVqtEjvFKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,238,1725346800"; d="scan'208";a="104850200"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa002.fm.intel.com with ESMTP; 27 Oct 2024 23:42:58 -0700
Date: Mon, 28 Oct 2024 14:59:17 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Babu Moger <babu.moger@amd.com>
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org,
 John Allen <john.allen@amd.com>
Subject: Re: [PATCH v3 2/7] target/i386: Add RAS feature bits on EPYC CPU
 models
Message-ID: <Zx82ReAE9h7bLSNN@intel.com>
References: <cover.1729807947.git.babu.moger@amd.com>
 <63d01f172cabd5a7741434fb923ed7e1447776ee.1729807947.git.babu.moger@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63d01f172cabd5a7741434fb923ed7e1447776ee.1729807947.git.babu.moger@amd.com>
Received-SPF: pass client-ip=192.198.163.9; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.287,
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

(+John)

Hi Babu,

This patch is fine for me.

However, users recently reported an issue with SUCCOR support on AMD
hosts: https://gitlab.com/qemu-project/qemu/-/issues/2571.

Could you please double check and clarify that issue on AMD host?

Thanks,
Zhao

On Thu, Oct 24, 2024 at 05:18:20PM -0500, Babu Moger wrote:
> Date: Thu, 24 Oct 2024 17:18:20 -0500
> From: Babu Moger <babu.moger@amd.com>
> Subject: [PATCH v3 2/7] target/i386: Add RAS feature bits on EPYC CPU models
> X-Mailer: git-send-email 2.34.1
> 
> Add the support for following RAS features bits on AMD guests.
> 
> SUCCOR: Software uncorrectable error containment and recovery capability.
> 	The processor supports software containment of uncorrectable errors
> 	through context synchronizing data poisoning and deferred error
> 	interrupts.
> 
> McaOverflowRecov: MCA overflow recovery support.
> 
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
> v3: No changes
> 
> v2: Added reviewed by from Zhao.
> ---
>  target/i386/cpu.c | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)


