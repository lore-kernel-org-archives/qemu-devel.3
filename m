Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F6CDC07E8F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2024 08:50:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rypMi-0006Fn-K9; Mon, 22 Apr 2024 04:49:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rypMa-0006FQ-Me; Mon, 22 Apr 2024 04:49:26 -0400
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rypMY-0002SN-Pd; Mon, 22 Apr 2024 04:49:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1713775763; x=1745311763;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=8t/dXVGbjBlLLUrS10ykGEfjfGtntYlrLoBHLtuuNlA=;
 b=JgW9Uy9ZE7RC0PBQKkHlSXYQp81Y8XE+FnvSFIb6XLo0+Qs3a6ZyEbct
 G+bmnz94tgpD8Mtbym9D8VZqbfb3Eo562W6jvGurg4O0FQRTtZqwNfgcs
 aZuj7wk+Xj+5s9T8AkSfDs/HJdQyF/fJN2T9j7EqjytbY6aRbrj4Va1+c
 yk3siKCCAyH0Z/VpmQJsQAsMGdaCiLZa/GtavSullGc1iUfREVn1Z7f4c
 N4K+HQXAaZZ/XB3/OK1HjasqxDUmrqI9NXPHoOHFtoBduPoC9wbJmb+Io
 cTr9NkcSZ66/FJBfIlY5tvvPSVKYPVnR92BVneVNN3mxXBqfTaJwVVQIy A==;
X-CSE-ConnectionGUID: PmM1mfhsSda9rVMofesluw==
X-CSE-MsgGUID: cmaQiZ8+Ree8agl09yOGLQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11051"; a="9521496"
X-IronPort-AV: E=Sophos;i="6.07,220,1708416000"; 
   d="scan'208";a="9521496"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Apr 2024 01:49:13 -0700
X-CSE-ConnectionGUID: t7/llO5hSRequhbM4LQE1A==
X-CSE-MsgGUID: g0iILtA8TAiVauJPx570yQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,220,1708416000"; d="scan'208";a="24465297"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa007.jf.intel.com with ESMTP; 22 Apr 2024 01:49:11 -0700
Date: Mon, 22 Apr 2024 17:03:16 +0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH 3/6] target/s390x/cpu_models: Make
 kvm_s390_get_host_cpu_model() return boolean
Message-ID: <ZiYn1BhTx5BSUBf+@intel.com>
References: <20240419065712.1225038-1-zhao1.liu@linux.intel.com>
 <20240419065712.1225038-4-zhao1.liu@linux.intel.com>
 <0ae778e1-b4aa-4021-bdbc-4c6a663db41a@redhat.com>
 <ZiIvAXd6wFQ2pwoM@intel.com>
 <d6b6f544-ea3c-495e-95ff-e6f974dc7e9c@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d6b6f544-ea3c-495e-95ff-e6f974dc7e9c@linaro.org>
Received-SPF: none client-ip=192.198.163.14;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.42,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On Fri, Apr 19, 2024 at 11:08:22AM +0200, Philippe Mathieu-Daudé wrote:
> Date: Fri, 19 Apr 2024 11:08:22 +0200
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: Re: [PATCH 3/6] target/s390x/cpu_models: Make
>  kvm_s390_get_host_cpu_model() return boolean
> 
> On 19/4/24 10:44, Zhao Liu wrote:
> > Hi Thomas,
> > 
> > On Fri, Apr 19, 2024 at 09:50:46AM +0200, Thomas Huth wrote:
> > > Date: Fri, 19 Apr 2024 09:50:46 +0200
> > > From: Thomas Huth <thuth@redhat.com>
> > > Subject: Re: [PATCH 3/6] target/s390x/cpu_models: Make
> > >   kvm_s390_get_host_cpu_model() return boolean
> > > 
> > > On 19/04/2024 08.57, Zhao Liu wrote:
> > > > From: Zhao Liu <zhao1.liu@intel.com>
> > > > 
> > > > As error.h suggested, the best practice for callee is to return
> > > > something to indicate success / failure.
> > > > 
> > > > So make kvm_s390_get_host_cpu_model() return boolean and check the
> > > > returned boolean in get_max_cpu_model() instead of accessing @err.
> > > > 
> > > > Additionally, since now get_max_cpu_model() returns directly if
> > > > kvm_s390_get_host_cpu_model() fills @err, so make
> > > > kvm_s390_get_host_cpu_model() return true by default for the non-KVM
> > > > case in target/s390x/cpu_models.h.
> > > 
> > > You could also argue the other way round that there should be something in
> > > *model if it returns "true" ... anyway, the stub should never be executed,
> > > so it likely doesn't matter too much, but I'd still prefer if we'd rather
> > > return "false" in the non-KVM stub instead.
> > 
> > I see, since this interface in wrapped in kvm_enabled() condition, so
> > the non-kvm sutb wouldn't be called.
> > 
> > Thanks! Will change to return false.
> 
> Or try to rebase your series on this untested patch:
> https://lore.kernel.org/qemu-devel/20240419090631.48055-1-philmd@linaro.org/
>

Good, pls let me pick this patch into my v2.



