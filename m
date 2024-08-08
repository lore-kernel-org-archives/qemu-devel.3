Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE615C52D73
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2024 09:26:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbzOF-0000nl-CM; Thu, 08 Aug 2024 05:24:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sbzOC-0000mZ-Q2
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 05:24:56 -0400
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sbzO9-0004D7-0Q
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 05:24:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1723109093; x=1754645093;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=386A0BBaRX3jDp8fOnNYUADd2ks/RpMi/bWG9OBvsV0=;
 b=mnIoF3pbrUebtdrmHgyG3tdFz2I+WAQLm2dPReP0Mec/W6MoUywmmo7h
 YGV8A0ikt9OC4QMo3YL/a+ho0Qu9+yDp+VOtRsfpyNBUCHOciBA6nUlS1
 FpbTzNYwn6fHf6LJbosIEExXnjNZng47EM2RyRbRS5U0sywqzCICu0Eay
 w5JuYQMcr0ehMz7xhDO6HkFerCzJW9BA4NMWI+xIv+sR4EgTpTWFU/ZR0
 I18WPWwopSrm6E0M6E4BnTmTB4zjLuMsd6lQVUaGE4sgfRO6c0BLAV8Zn
 YgZdjWr9HeSilV7nEi8Jeu6qCKT3sp0V4+yDuMB/ob05GGwiVQT0UtaxG w==;
X-CSE-ConnectionGUID: +V8lA+TIR4ygkVkJgNIsFQ==
X-CSE-MsgGUID: NuUHyfdVRROTIU5yjO6SyA==
X-IronPort-AV: E=McAfee;i="6700,10204,11157"; a="25094055"
X-IronPort-AV: E=Sophos;i="6.09,272,1716274800"; d="scan'208";a="25094055"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Aug 2024 02:24:49 -0700
X-CSE-ConnectionGUID: S6gqtJEqTACjazY2lbm2Gw==
X-CSE-MsgGUID: uGNm97kLRSa2C0OGhY+c2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,272,1716274800"; d="scan'208";a="88064997"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa001.fm.intel.com with ESMTP; 08 Aug 2024 02:24:48 -0700
Date: Thu, 8 Aug 2024 17:40:38 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Xin Li <xin@zytor.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v1 2/3] target/i386: Add VMX control bits for nested FRED
 support
Message-ID: <ZrSSlri1K5WL7XVj@intel.com>
References: <20240807081813.735158-1-xin@zytor.com>
 <20240807081813.735158-3-xin@zytor.com>
 <ZrOZkYuSKhYH0ymi@intel.com>
 <f4422fc2-d8fc-4902-80c7-0e2dda5bba59@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=gb2312
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f4422fc2-d8fc-4902-80c7-0e2dda5bba59@zytor.com>
Received-SPF: pass client-ip=192.198.163.12; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
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

Hi Xin,

On Thu, Aug 08, 2024 at 12:04:42AM -0700, Xin Li wrote:
> Date: Thu, 8 Aug 2024 00:04:42 -0700
> From: Xin Li <xin@zytor.com>
> Subject: Re: [PATCH v1 2/3] target/i386: Add VMX control bits for nested
>  FRED support
> 
> On 8/7/2024 8:58 AM, Zhao Liu wrote:
> > On Wed, Aug 07, 2024 at 01:18:11AM -0700, Xin Li (Intel) wrote:
> > > @@ -1435,7 +1435,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
> > >               "vmx-exit-save-efer", "vmx-exit-load-efer",
> > >                   "vmx-exit-save-preemption-timer", "vmx-exit-clear-bndcfgs",
> > >               NULL, "vmx-exit-clear-rtit-ctl", NULL, NULL,
> > > -            NULL, "vmx-exit-load-pkrs", NULL, NULL,
> > > +            NULL, "vmx-exit-load-pkrs", NULL, "vmx-exit-secondary-ctls",
> > 
> > Oh, the order of my reviews is mixed up.
> > It's better to move VMX_VM_EXIT_ACTIVATE_SECONDARY_CONTROLS into this patch.
> 
> Usually a simple definition is added in a patch where it is used, not in
> qemu?
> 
> > >           },
> > >           .msr = {
> > >               .index = MSR_IA32_VMX_TRUE_EXIT_CTLS,
> > > @@ -1450,7 +1450,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
> > >               NULL, "vmx-entry-ia32e-mode", NULL, NULL,
> > >               NULL, "vmx-entry-load-perf-global-ctrl", "vmx-entry-load-pat", "vmx-entry-load-efer",
> > >               "vmx-entry-load-bndcfgs", NULL, "vmx-entry-load-rtit-ctl", NULL,
> > > -            NULL, NULL, "vmx-entry-load-pkrs", NULL,
> > > +            NULL, NULL, "vmx-entry-load-pkrs", "vmx-entry-load-fred",
> > 
> > Should we also define VMX_VM_ENTRY_LOAD_FRED? "vmx-entry-load-rtit-ctl"
> > and "vmx-entry-load-pkrs" have their corresponding bit definitions, even
> > if they are not used.
> 
> I'm not sure, but why add something that is not being used (thus not
> tested)?

Yes, the use of macros is a factor. My another consideration is the
integrity of the feature definitions. When the such feature definitions
were first introduced in commit 704798add83b (¡±target/i386: add VMX
definitions¡±), I understand thay were mainly used to enumerate and
reflect hardware support and not all defs are used directly.

The feat word name and the feature definition should essentially be
bound, and it might be possible to generate the feature definition
from the feat word via some script without having to add it manually,
but right now there is no work on this, and no additional constraints,
so we have to manually add and manually check it to make sure that the
two correspond to each other. When a feature word is added, it means
that Host supports the corresponding feature, and from an integrity
perspective, so it is natural to continue adding definition (just like
the commit 52a44ad2b92b ("target/i386: Expose VMX entry/exit load pkrs
control bits")), right?

Though I found that there are still some mismatches between the feature
word and the corresponding definition, but ideally they should coexist.

About the test, if it's just enumerated and not added to a specific CPU
model or involved by other logic, it's harmless?

Thanks,
Zhao


