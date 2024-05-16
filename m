Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D15DDC25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2024 08:33:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7WXf-0000fJ-Lg; Thu, 16 May 2024 04:32:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1s7WXc-0000eg-ST
 for qemu-devel@nongnu.org; Thu, 16 May 2024 04:32:44 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1s7WXZ-0001Rs-Md
 for qemu-devel@nongnu.org; Thu, 16 May 2024 04:32:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1715848361; x=1747384361;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=ct05y/5RHMltKPplq3OAHrXd/tyixF9CmDVpdAJ3hec=;
 b=ijVaaaB1Vpl1dFJQamw3Z5WMZ0DUJe3XgdRxRcTO3agKnW/2Vi4gY28L
 3xOufSgnwb17uIkS/CwLJmSW4OS37Z3+4UbyDd8fwXnP+uKdsM0en2SXS
 Zk/gswvYG7dYgSr3/3AMIPKes0Jbz518xgiHY34Iou+uMi8RcRkKkeAJH
 I1rJHfdDA02vAvEZkNPX9vNF9My8VcAe3Guw64YKkf5t7Xe8Q0q3VeSI0
 BnanNHB4EVsQ16kWnZCA4MSqSxKRIINfr8woXQLULczKrTt+8iZ9gOXxu
 OpXdoxawz/tGWwqrFVX1UXyMGDw/oxyT+z6NfW5jtsB3UszKBtjaYmFiA g==;
X-CSE-ConnectionGUID: a/o61BTdS66i7EoaoT88JA==
X-CSE-MsgGUID: s+ewSWpZT8aurX2ZvYOtpA==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="22523100"
X-IronPort-AV: E=Sophos;i="6.08,164,1712646000"; d="scan'208";a="22523100"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 May 2024 01:32:38 -0700
X-CSE-ConnectionGUID: bGQTsmEYSJ2NLjLuYj3LmA==
X-CSE-MsgGUID: TJbB3bBRSUuBPYH2WxOE8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,164,1712646000"; d="scan'208";a="35867175"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa003.fm.intel.com with ESMTP; 16 May 2024 01:32:35 -0700
Date: Thu, 16 May 2024 16:47:53 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 devel@lists.libvirt.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Krempa <pkrempa@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH 1/2] hw/core: allow parameter=1 for SMP topology on any
 machine
Message-ID: <ZkXIOW/F0oM1v0jQ@intel.com>
References: <20240513123358.612355-1-berrange@redhat.com>
 <20240513123358.612355-2-berrange@redhat.com>
 <ZkIiHgw9rQActD2i@intel.com> <ZkImOkl-HtsFMaAz@redhat.com>
 <ZkLfVB/1arSlAptC@intel.com> <ZkTrsDdyGRFzVULG@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZkTrsDdyGRFzVULG@redhat.com>
Received-SPF: pass client-ip=198.175.65.11; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -52
X-Spam_score: -5.3
X-Spam_bar: -----
X-Spam_report: (-5.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.935,
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

On Wed, May 15, 2024 at 06:06:56PM +0100, Daniel P. Berrangé wrote:
> Date: Wed, 15 May 2024 18:06:56 +0100
> From: "Daniel P. Berrangé" <berrange@redhat.com>
> Subject: Re: [PATCH 1/2] hw/core: allow parameter=1 for SMP topology on any
>  machine
> 
> On Tue, May 14, 2024 at 11:49:40AM +0800, Zhao Liu wrote:
> > > I'm failing to see what real world technical problems QEMU faces
> > > with a parameter being set to '1' by a mgmt app, when QEMU itself
> > > treats all omitted values as being '1' anyway.
> > > 
> > > If we're trying to faithfully model the real world, then restricting
> > > the topology against machine types though still looks inherantly wrong.
> > > The valid topology ought to be constrained based on the named CPU model.
> > > eg it doesn't make sense to allow 'dies=4' with a Skylake CPU model,
> > > only an EPYC CPU model, especially if we want to model cache info in
> > > a way that matches the real world silicon better.
> > 
> > Thanks for figuring out this. This issue is related with Intel CPU
> > cache model: currently Intel code defaults L3 shared at die level.
> > This could be resolved by defining the accurate default cache topology
> > level for CPU model and make Intel CPU models share L3 at package level
> > except only Cascadelake.
> > 
> > Then user could define any other topology levels (die/module) for
> > Icelake and this won't change the cache topology, unless the user adds
> > more sockets or further customizes the cache topology in another way [1].
> > Do you agree with this solution?
> 
> Broadly speaking yes. Historically we have created trouble for
> ourselves (and or our users) by allowing creation of "wierd"
> guest CPU models, which don't resemble those which can be found
> in real world silicon. Problems specifically have been around
> unsual combinations of CPUID features eg user enabled X, but not Y,
> where real silicon always has X + Y enabled, and guest OS assumed
> this is always the case.
> 
> So if our named CPU models can more faithfully match what you might
> see in terms of cache topology in the real world, that's likely to
> be a good thing.

Good to know what you think, it's the important guide for our work.

> > > As above, I think that restrictions based on machine type, while nice and
> > > simple, are incorrect long term. If we did impose restrictions based on
> > > CPU model, then we could trivially expose this info to mgmt apps via the
> > > existing mechanism for querying supported CPU models. Limiting based on
> > > CPU model, however, has potentially greater back compat issues, though
> > > it would be strictly more faithful to hardware.
> > 
> > I think as long as the default cache topology model is clearly defined,
> > users can further customize the CPU topology and adjust the cache
> > topology based on it. After all, topology is architectural, not CPU
> > model-specific (linux support for topology does not take into account
> > specific CPU models).
> > 
> > For example, x86, for simplicity, can we assume that all x86 CPU models
> > support all x86 topology levels (thread/core/module/die/package) without
> > making distinctions based on specific CPU models?
> 
> Hmm, true, if we have direct control over cache topology, the
> CPU topology is less critical. I'd still be wary of suggesting
> it is a good idea to use CPU topology configs that don't reflect
> something the CPU vendor has concievably used in real silicon.

Thank you! Yes, besides cache, it may affect other features like
Anthony's RAPL support, MSR is (die/package) topology-aware.

There's still a lot of open here, I'll take your warning into serious
consideration.

> > That way as long as the user doesn't change the default topology, then
> > Guest's cache and other topology information won't be "corrupted".
> 
> > And there's one more question, does this rollback mean that smp's
> > parameters must have compatible default values for all architectures?
> 
> Historically we preferred "sockets", when filling missing topology,
> then more recently we switched to prefer "cores", since high core
> counts are generally more common in real world than high socket
> counts.
> 
> In theory at some point, one might want to fill in 'dies > 0' for
> EPYC, or 'modules > 0' for appropriate Intel CPU models, but doing
> the reverse while theoretically valid, would be wierd as no such
> topology would exist in real silicon.
> 
> Ultimately if you're allowing QEMU guest vCPUs threads to float
> freely across host CPUs, there is little point in setting dies/
> modules/threads to a value other than 1, because the guest OS
> won't benefit from understanding cache differences for dies/
> modules/threads/etc, if the vCPU can be moved between host CPUs
> at any time by the host OS scheduler.
> 
> Fine grained control over dies/modules/threads only makes more
> sense if you have strictly pinning vCPU threads 1:1 to host CPUs
> 
> IOW, simply preferring "cores" for everything is a reasonable
> default long term plan for everything, unless the specific
> architecture target has no concept of "cores".

Thank you very much for your education, it has helped me understand the
meaning of SMP much better!

It makes sense to default the cache topology configuration to core, I'll
check further to see if it would conflict with the current x86 default
cache topology encoding model and how to defuse the potential conflict.

The CPU topology building is centralized in the general SMP code, while
cache topology is scattered throughout the architectures' code, which is
a significant difference between the two. I'll refresh the smp cache
series later.

Regards,
Zhao


