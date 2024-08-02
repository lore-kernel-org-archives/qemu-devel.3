Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B594CC3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 02:18:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZhrt-00039K-K5; Thu, 01 Aug 2024 22:18:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sZhro-00038i-Pw
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 22:18:04 -0400
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sZhrg-0007xf-GH
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 22:18:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1722565077; x=1754101077;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=DY66/wD6X+zfL20JbykXe+HXrwux3tLZOsLHlHPkmJ4=;
 b=mjX0RcSSOoppY9b3BLCATPl+JgStO/+Q7/6owOx437Xvfi030c1Is3PI
 fQivnZpbLeFay3kEMwwvMnQgH6tBHMnawLyEyaAu15uoEy9mBuafdEgp9
 o0kA6Zcwv56kjKhmCG6bebJJhLEr+YjAn/eftph6JQH9M/9oSm/YssQgG
 whCRN7OBKeTRU5VGUXbUHwgBFBhRn1ptE3poghLzmOqOjl8XrYFY1GE6H
 +1y8jQm4ZAciQQW3bPvYyktC/R5YpGcA7llIc1vIoC/c7STPWHNy5kZvV
 8dcS1ESTYHguMpr7iwt5A3Bv1hSvh/q3ul07fy6MHJ11wXQbijjU0nbBM Q==;
X-CSE-ConnectionGUID: pKHSzXh5RxeYCSufwWniiA==
X-CSE-MsgGUID: egaKOI1OTASLYWlDpxND7Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11151"; a="20680113"
X-IronPort-AV: E=Sophos;i="6.09,256,1716274800"; d="scan'208";a="20680113"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Aug 2024 19:17:54 -0700
X-CSE-ConnectionGUID: eDNn1f5NQbaTcTf71L1Xgw==
X-CSE-MsgGUID: 6hvFu3mmQmWQRvzy13fTWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,256,1716274800"; d="scan'208";a="55162733"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa010.jf.intel.com with ESMTP; 01 Aug 2024 19:17:51 -0700
Date: Fri, 2 Aug 2024 10:33:39 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Manish <manish.mishra@nutanix.com>
Cc: Igor Mammedov <imammedo@redhat.com>,
 John Levon <john.levon@nutanix.com>, qemu-devel@nongnu.org,
 berrange@redhat.com, pbonzini@redhat.com, bob.ball@nutanix.com,
 prerna.saxena@nutanix.com
Subject: Re: [PATCH v1] target/i386: Always set leaf 0x1f
Message-ID: <ZqxFg4rsRRwf5j+W@intel.com>
References: <20240724075226.212882-1-manish.mishra@nutanix.com>
 <20240724110004.389c1a0c@imammedo.users.ipa.redhat.com>
 <21ca5c19-677b-4fac-84d4-72413577f260@nutanix.com>
 <ZqDh2NIE2ELRcwq6@lent>
 <20240724145432.6e91dd28@imammedo.users.ipa.redhat.com>
 <ZqEW/TIZAqLN3CKI@intel.com>
 <20240729141839.44203b6c@imammedo.users.ipa.redhat.com>
 <96caae6c-5263-4b66-ab72-65f34dc63c17@nutanix.com>
 <20240730133958.1a3ff13a@imammedo.users.ipa.redhat.com>
 <3b8b0b28-70e8-480a-8a6f-8b1d7af1a3f1@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b8b0b28-70e8-480a-8a6f-8b1d7af1a3f1@nutanix.com>
Received-SPF: pass client-ip=198.175.65.17; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.131,
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

On Wed, Jul 31, 2024 at 07:30:44PM +0530, Manish wrote:
> Date: Wed, 31 Jul 2024 19:30:44 +0530
> From: Manish <manish.mishra@nutanix.com>
> Subject: Re: [PATCH v1] target/i386: Always set leaf 0x1f
> 
> 
> On 30/07/24 6:39 pm, Igor Mammedov wrote:
> > !-------------------------------------------------------------------|
> >    CAUTION: External Email
> > 
> > |-------------------------------------------------------------------!
> > 
> > On Mon, 29 Jul 2024 19:42:39 +0700
> > Manish <manish.mishra@nutanix.com> wrote:
> > 
> > > On 29/07/24 7:18 pm, Igor Mammedov wrote:
> > > > !-------------------------------------------------------------------|
> > > >     CAUTION: External Email
> > > > 
> > > > |-------------------------------------------------------------------!
> > > > 
> > > > On Wed, 24 Jul 2024 23:00:13 +0800
> > > > Zhao Liu <zhao1.liu@intel.com> wrote:
> > > > > Hi Igor,
> > > > > 
> > > > > On Wed, Jul 24, 2024 at 02:54:32PM +0200, Igor Mammedov wrote:
> > > > > > Date: Wed, 24 Jul 2024 14:54:32 +0200
> > > > > > From: Igor Mammedov <imammedo@redhat.com>
> > > > > > Subject: Re: [PATCH v1] target/i386: Always set leaf 0x1f
> > > > > > X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-redhat-linux-gnu)
> > > > > > 
> > > > > > On Wed, 24 Jul 2024 12:13:28 +0100
> > > > > > John Levon <john.levon@nutanix.com> wrote:
> > > > > > > On Wed, Jul 24, 2024 at 03:59:29PM +0530, Manish wrote:
> > > > > > > > > > Leaf 0x1f is superset of 0xb, so it makes sense to set 0x1f equivalent
> > > > > > > > > > to 0xb by default and workaround windows issue.>
> > > > > > > > > > This change adds a
> > > > > > > > > > new property 'cpuid-0x1f-enforce' to set leaf 0x1f equivalent to 0xb in
> > > > > > > > > > case extended CPU topology is not configured and behave as before otherwise.
> > > > > > > > > repeating question
> > > > > > > > > why we need to use extra property instead of just adding 0x1f leaf for CPU models
> > > > > > > > > that supposed to have it?
> > > > > > > > As i mentioned in earlier response. "Windows expects it only when we have
> > > > > > > > set max cpuid level greater than or equal to 0x1f. I mean if it is exposed
> > > > > > > > it should not be all zeros. SapphireRapids CPU definition raised cpuid level
> > > > > > > > to 0x20, so we starting seeing it with SapphireRapids."
> > > > > > > > 
> > > > > > > > Windows does not expect 0x1f to be present for any CPU model. But if it is
> > > > > > > > exposed to the guest, it expects non-zero values.
> > > > > > > I think Igor is suggesting:
> > > > > > > 
> > > > > > >    - leave x86_cpu_expand_features() alone completely
> > > > > > yep, drop that if possible
> > > > > > 
> > > > > > >    - change the 0x1f handling to always report topology i.e. never report all
> > > > > > >      zeroes
> > > > > > Do this but only for CPU models that have this leaf per spec,
> > > > > > to avoid live migration issues create a new version of CPU model,
> > > > > > so it would apply only for new version. This way older versions
> > > > > > and migration won't be affected.
> > > > > So that in the future every new Intel CPU model will need to always
> > > > > enable 0x1f. Sounds like an endless game. So my question is: at what
> > > > > point is it ok to consider defaulting to always enable 0x1f and just
> > > > > disable it for the old CPU model?
> > > > I have suggested to enable 0x1f leaf excluding:
> > > >      * existing cpu models (versions)
> > > >      * cpu models that do not have this leaf in real world should
> > > >        not have it in QEMU either.
> > > > 
> > > > If cpu model already exists, you'd need a new version of cpu model to
> > > > enable new leaf by default.
> > > > 
> > > > For completely new cpu model, it could be enabled from the start.
> > > > i.e. workflow for enabling that should be the same as with CPU features
> > > > (or as you said 'endless game' of copying base model and making it look like
> > > > should be according to spec,
> > > > but that's the process we currently use for describing CPU models).
> > > Igor my understanding was that there are two type of features one is
> > > real CPU feature, yes those makes sense in CPU models. But on other hand
> > > there are features which are emulated ones i.e. kvm-*, these make sense
> > > enabling regardless of any CPU model and we usually use machine types to
> > > enable these. Does not this features makes sense in 2nd category.
> > I'm not convinced that it applies to any CPU model.
> > I'd say it's risky to expose new leaf on CPUs that don't have it to begin with.
> > Also what about AMD cpus? Do they also support this leaf?
> 
> Hi Igor, No AMD has different leaf for this purpose, i think 8000_0026. But
> should not AMD platforms or guest ignore it in that case. This flag was
> anyway getting populated earlier too for nr_dies > 1?
> 

AMD hasn't supported that leaf in QEMU (cpu_x86_cpuid()).

Igor's concern is right, as there is no way to ensure how the software
will behave (just like Windows doesn't respect the x86 spec). It is
least risky to consider this property as the 1st category, because the
particular CPU model supports this leaf, and software that runs
properly on the corresponding bare metal certainly won't complain about
0x1f or even prefer to have 0x1f in Guest (also as in your Windows
example).

Disable "cpuid-0x1f-enforce" by default is also fine for me. If you find
it's not easy to add 0x1f for the CPU models, I can add 0x1f into CPU
models in the future with my other cache model work, to help you fill in
the last piece that Igor suggested.

Regards,
Zhao


