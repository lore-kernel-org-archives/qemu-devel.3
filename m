Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8492C52D71
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2024 08:47:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1scLGs-0005WP-2O; Fri, 09 Aug 2024 04:46:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1scLGq-0005P8-5L
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 04:46:48 -0400
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1scLGo-0002r6-Da
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 04:46:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1723193206; x=1754729206;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=EBo2CWUAyKTI796A9q51D37P+w1g57rmuunWJ4L3Npc=;
 b=FEFsSTkOr0nRQCAirAlNk735uzTM7sNncGigEKGYW+XB8VGtOjFywGwW
 U2oanxoZ0UCXM74hupozBXB6C1scE9xgfI0tOy6zZNW9Fw+iYkOqBcvT6
 Wf5H3y5zToVGuUKN/mz2x673PhLr9Vqo0NQA5y4WbiFU2DG/etZEbvKBv
 24ESc2goVqMwlqQB65STi4m3n2ayO6shGzab7IYGF8MOssAaTe/kwzTgz
 uxu9ZdpvcRXA5hhKMQwqsMlN5ks7tw3WCZs96Diea9ivoiTzVmlm3Mwci
 qYXp4NE+euof0JpglYnYlEyke9oL1GX7+K/S4KvWO/td76RHVyVonqYUU A==;
X-CSE-ConnectionGUID: zBLI1kbpTqaVaCjpYyiXkA==
X-CSE-MsgGUID: A4l46IoXTkeZ8lBazpRPrQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="12931522"
X-IronPort-AV: E=Sophos;i="6.09,275,1716274800"; d="scan'208";a="12931522"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Aug 2024 01:46:45 -0700
X-CSE-ConnectionGUID: wTo8X4XgRECBki1wmPN7lg==
X-CSE-MsgGUID: j1G/6JsES9iaVM13kWvcOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,275,1716274800"; d="scan'208";a="62145138"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa004.fm.intel.com with ESMTP; 09 Aug 2024 01:46:44 -0700
Date: Fri, 9 Aug 2024 17:02:34 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Xin Li <xin@zytor.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v1 2/3] target/i386: Add VMX control bits for nested FRED
 support
Message-ID: <ZrXbKsfe0LnZdA9V@intel.com>
References: <20240807081813.735158-1-xin@zytor.com>
 <20240807081813.735158-3-xin@zytor.com>
 <ZrOZkYuSKhYH0ymi@intel.com>
 <f4422fc2-d8fc-4902-80c7-0e2dda5bba59@zytor.com>
 <ZrSSlri1K5WL7XVj@intel.com>
 <f4ece0e8-b2b3-4178-b281-6ba9cc9cab8a@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=gb2312
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f4ece0e8-b2b3-4178-b281-6ba9cc9cab8a@zytor.com>
Received-SPF: pass client-ip=192.198.163.16; envelope-from=zhao1.liu@intel.com;
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

On Thu, Aug 08, 2024 at 11:38:11PM -0700, Xin Li wrote:
> Date: Thu, 8 Aug 2024 23:38:11 -0700
> From: Xin Li <xin@zytor.com>
> Subject: Re: [PATCH v1 2/3] target/i386: Add VMX control bits for nested
>  FRED support
> 
> > > > > @@ -1450,7 +1450,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
> > > > >                NULL, "vmx-entry-ia32e-mode", NULL, NULL,
> > > > >                NULL, "vmx-entry-load-perf-global-ctrl", "vmx-entry-load-pat", "vmx-entry-load-efer",
> > > > >                "vmx-entry-load-bndcfgs", NULL, "vmx-entry-load-rtit-ctl", NULL,
> > > > > -            NULL, NULL, "vmx-entry-load-pkrs", NULL,
> > > > > +            NULL, NULL, "vmx-entry-load-pkrs", "vmx-entry-load-fred",
> > > > 
> > > > Should we also define VMX_VM_ENTRY_LOAD_FRED? "vmx-entry-load-rtit-ctl"
> > > > and "vmx-entry-load-pkrs" have their corresponding bit definitions, even
> > > > if they are not used.
> > > 
> > > I'm not sure, but why add something that is not being used (thus not
> > > tested)?
> > 
> > Yes, the use of macros is a factor. My another consideration is the
> > integrity of the feature definitions. When the such feature definitions
> > were first introduced in commit 704798add83b (¡±target/i386: add VMX
> > definitions¡±), I understand thay were mainly used to enumerate and
> > reflect hardware support and not all defs are used directly.
> > 
> > The feat word name and the feature definition should essentially be
> > bound, and it might be possible to generate the feature definition
> > from the feat word via some script without having to add it manually,
> > but right now there is no work on this, and no additional constraints,
> > so we have to manually add and manually check it to make sure that the
> > two correspond to each other. When a feature word is added, it means
> > that Host supports the corresponding feature, and from an integrity
> > perspective, so it is natural to continue adding definition (just like
> > the commit 52a44ad2b92b ("target/i386: Expose VMX entry/exit load pkrs
> > control bits")), right?
> > 
> > Though I found that there are still some mismatches between the feature
> > word and the corresponding definition, but ideally they should coexist.
> > 
> > About the test, if it's just enumerated and not added to a specific CPU
> > model or involved by other logic, it's harmless?
> 
> Unless tests are ready, such code are literally dead code, and could get
> broken w/o being noticed for a long time.
> 
> I think we should add it only when tests are also added.  Otherwise we added
> burden to maintainers, hoping test will be added soon, which often
> never happen.

It makes sense and can reduce the burden on maintainers. Now I totally
agree with you.

Thanks,
Zhao


