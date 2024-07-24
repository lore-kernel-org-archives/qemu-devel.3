Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89BBDC3DA61
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2024 14:45:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWdEL-0006gE-Qh; Wed, 24 Jul 2024 10:44:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sWdEJ-0006fb-NU
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 10:44:35 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sWdEH-0002gV-Il
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 10:44:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1721832273; x=1753368273;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=eXOiiBhS/U94VOGGl7aMIsHizhkCpYZPu/fXymV97/0=;
 b=U3Prchx/9Canz/z8VpRIFE2lkN9d0jEkZMx4M+AMZXK3cZi89dswKCxJ
 Gr87n8AxKee5c0YI1AAfMVlDusJQqvJISW2G4GZSaV7WlyJvSWTZSlR7u
 JZv9osGUoQgA3KR9SuqsvtGayLz+GFpiysBcpiHXsnGS6WZfbyXPqPcGR
 Ps9XxTIOsZHejS9H7fi8YLDDosqx7YcaaCBHDKyBFUJ4G36ZXdPv1BXnW
 pvjkPBIm/l8lUlotbNffnTnhwTHkCblmY/GWtp8+GuE7mK9KP1Xf1T0uI
 9MQ5iWPrKP35E3ewKDw0mtauJeIxA00M66wOHBsPb2sHNOUPlp68vezJQ A==;
X-CSE-ConnectionGUID: 9ifv8zk8R0K6tdLBEmq0jQ==
X-CSE-MsgGUID: ObXavbyLS4ang9v+54xLog==
X-IronPort-AV: E=McAfee;i="6700,10204,11143"; a="30114866"
X-IronPort-AV: E=Sophos;i="6.09,233,1716274800"; d="scan'208";a="30114866"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jul 2024 07:44:31 -0700
X-CSE-ConnectionGUID: 2ru3n3PMSha2AEBpWOhO8g==
X-CSE-MsgGUID: U1ipYSNOR2mpgQigIHEnYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,233,1716274800"; d="scan'208";a="57416206"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa005.jf.intel.com with ESMTP; 24 Jul 2024 07:44:30 -0700
Date: Wed, 24 Jul 2024 23:00:13 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Igor Mammedov <imammedo@redhat.com>
Cc: John Levon <john.levon@nutanix.com>, Manish <manish.mishra@nutanix.com>,
 qemu-devel@nongnu.org, berrange@redhat.com, pbonzini@redhat.com,
 bob.ball@nutanix.com, prerna.saxena@nutanix.com
Subject: Re: [PATCH v1] target/i386: Always set leaf 0x1f
Message-ID: <ZqEW/TIZAqLN3CKI@intel.com>
References: <20240724075226.212882-1-manish.mishra@nutanix.com>
 <20240724110004.389c1a0c@imammedo.users.ipa.redhat.com>
 <21ca5c19-677b-4fac-84d4-72413577f260@nutanix.com>
 <ZqDh2NIE2ELRcwq6@lent>
 <20240724145432.6e91dd28@imammedo.users.ipa.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240724145432.6e91dd28@imammedo.users.ipa.redhat.com>
Received-SPF: pass client-ip=198.175.65.11; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.136,
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

Hi Igor,

On Wed, Jul 24, 2024 at 02:54:32PM +0200, Igor Mammedov wrote:
> Date: Wed, 24 Jul 2024 14:54:32 +0200
> From: Igor Mammedov <imammedo@redhat.com>
> Subject: Re: [PATCH v1] target/i386: Always set leaf 0x1f
> X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-redhat-linux-gnu)
> 
> On Wed, 24 Jul 2024 12:13:28 +0100
> John Levon <john.levon@nutanix.com> wrote:
> 
> > On Wed, Jul 24, 2024 at 03:59:29PM +0530, Manish wrote:
> > 
> > > > > Leaf 0x1f is superset of 0xb, so it makes sense to set 0x1f equivalent
> > > > > to 0xb by default and workaround windows issue.>
> > > > > This change adds a
> > > > > new property 'cpuid-0x1f-enforce' to set leaf 0x1f equivalent to 0xb in
> > > > > case extended CPU topology is not configured and behave as before otherwise.  
> > > > repeating question
> > > > why we need to use extra property instead of just adding 0x1f leaf for CPU models
> > > > that supposed to have it?  
> > > 
> > > As i mentioned in earlier response. "Windows expects it only when we have
> > > set max cpuid level greater than or equal to 0x1f. I mean if it is exposed
> > > it should not be all zeros. SapphireRapids CPU definition raised cpuid level
> > > to 0x20, so we starting seeing it with SapphireRapids."
> > > 
> > > Windows does not expect 0x1f to be present for any CPU model. But if it is
> > > exposed to the guest, it expects non-zero values.  
> > 
> > I think Igor is suggesting:
> > 
> >  - leave x86_cpu_expand_features() alone completely
> yep, drop that if possible
> 
>  
> >  - change the 0x1f handling to always report topology i.e. never report all
> >    zeroes
> 
> Do this but only for CPU models that have this leaf per spec,
> to avoid live migration issues create a new version of CPU model,
> so it would apply only for new version. This way older versions
> and migration won't be affected. 

So that in the future every new Intel CPU model will need to always
enable 0x1f. Sounds like an endless game. So my question is: at what
point is it ok to consider defaulting to always enable 0x1f and just
disable it for the old CPU model?

Thanks,
Zhao


