Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29B49D7497D
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2024 07:54:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t63WP-00019z-TM; Wed, 30 Oct 2024 03:53:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t63WO-00019r-Fw
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 03:53:40 -0400
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t63WM-0004zK-4f
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 03:53:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730274818; x=1761810818;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=L6iHFxtT6MaDuU0qehbs8622ZoPkgsX/GeUhCCkJYpo=;
 b=VjuQCGReg3vFanjzr8Qtg8cLcK7CVM6rl4LC1WgDNsbRETp4l2BJFxsZ
 nRDZHplxOSUyIkZNfPV1Ioo/wQuTbqtgYHPcZU4aMjCM4a7q1ewNo0M2N
 m8XWPUoGEzt9QnBUUwi0NGXl767BqDu/zAYY+M+DXGqrNMAx8vYxFCuJt
 L0tUtNbq7guXGECZ0aeEuuz267lMc7lKCkyrrg43RmMd0h2gpUsnPQEh7
 WJ4TuNC5kHwMwXtlFVONEMBgIKF0uQ4eeJstKV4burDppccfYrQKvXn2W
 GJ1XJkMLINxUO8dGrFeiUcnyITmWAfoE+HI5xcWwAdHzKgpFxEWavJ+t+ A==;
X-CSE-ConnectionGUID: 4lW1odzZTOCHBzdMj3tWQw==
X-CSE-MsgGUID: Pgezc3fyQb6XD1oktdFqYg==
X-IronPort-AV: E=McAfee;i="6700,10204,11240"; a="29861914"
X-IronPort-AV: E=Sophos;i="6.11,244,1725346800"; d="scan'208";a="29861914"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Oct 2024 00:53:34 -0700
X-CSE-ConnectionGUID: CGhg8ikvRaWsPGtubPN0mA==
X-CSE-MsgGUID: dMIOjkyFSHOcR5nIXXL1Ng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,244,1725346800"; d="scan'208";a="86788924"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa005.fm.intel.com with ESMTP; 30 Oct 2024 00:53:33 -0700
Date: Wed, 30 Oct 2024 16:09:53 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Tao Su <tao1.su@linux.intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 xiaoyao.li@intel.com
Subject: Re: [PATCH 4/8] target/i386: add AVX10 feature and AVX10 version
 property
Message-ID: <ZyHp0Yl4zSMkJpU3@intel.com>
References: <20241029151858.550269-1-pbonzini@redhat.com>
 <20241029151858.550269-5-pbonzini@redhat.com>
 <ZyGic6S+/lcuR36v@linux.bj.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZyGic6S+/lcuR36v@linux.bj.intel.com>
Received-SPF: pass client-ip=192.198.163.17; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.302,
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

On Wed, Oct 30, 2024 at 11:05:23AM +0800, Tao Su wrote:
> Date: Wed, 30 Oct 2024 11:05:23 +0800
> From: Tao Su <tao1.su@linux.intel.com>
> Subject: Re: [PATCH 4/8] target/i386: add AVX10 feature and AVX10 version
>  property
> 
> On Tue, Oct 29, 2024 at 04:18:54PM +0100, Paolo Bonzini wrote:
> > From: Tao Su <tao1.su@linux.intel.com>
> 
> [ ... ]
> 
> >  static void max_x86_cpu_realize(DeviceState *dev, Error **errp)
> >  {
> >      Object *obj = OBJECT(dev);
> > +    X86CPU *cpu = X86_CPU(dev);
> > +    CPUX86State *env = &cpu->env;
> >  
> >      if (!object_property_get_int(obj, "family", &error_abort)) {
> >          if (X86_CPU(obj)->env.features[FEAT_8000_0001_EDX] & CPUID_EXT2_LM) {
> > @@ -5351,6 +5357,14 @@ static void max_x86_cpu_realize(DeviceState *dev, Error **errp)
> >          }
> >      }
> >  
> > +    if ((env->features[FEAT_7_1_EDX] & CPUID_7_1_EDX_AVX10) && !env->avx10_version) {
> 
> CPUID_7_1_EDX_AVX10 is not set now and will be set in x86_cpu_realizefn().
> How about just checking !env->avx10_version? Because cpu_x86_cpuid will
> also check (env->features[FEAT_7_1_EDX] & CPUID_7_1_EDX_AVX10).

If you explicitly turn on avx10 via -cpu max,+avx10, then CPUID_7_1_EDX_AVX10
will be there. But I agree, this is not a good place to check avx10 and
avx10_version.


