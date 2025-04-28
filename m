Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95A67C369DC
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 13:52:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9OtX-0007ub-CE; Mon, 28 Apr 2025 09:51:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u9OtG-0007tE-W1; Mon, 28 Apr 2025 09:51:27 -0400
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u9OtD-0003Bk-VE; Mon, 28 Apr 2025 09:51:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1745848280; x=1777384280;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=VsHmrNXKviIE8IQ9R1HhlyLdam+mB76jNTS9v/imXWs=;
 b=afBJGxlnOygstodwxP54aaFlIZ3eTk0lr/YevradvLsAnXAYODv1IFua
 zjXAVv0GZEk2Hg9elHoi1nv9mvBDr8Orh7BRnYm1qOvoIA6zBY7RA8HB3
 U19BC7HAbYaMyQNAu94NNY5nr5OHjaniDFmWg2VLzVZVvtaRmwymtWuLS
 CjEWZN6orvJ1XqIhjOltEUf0IJqYn4ZpTfXYVldVhFLmrs7o7Zpnb9Eiv
 zAmtCOBJvNeGWRYWuw3HVu5PIYR7P2CrdsKjr7BRPeTIqHcN8llBQx1cU
 ym7WzcTGgsZc+l8aaU13xW6vVGkBtVYDU+6pitS4hvUyGFC3RYQN3PcCW A==;
X-CSE-ConnectionGUID: ++y8CVQiTomQGISsRyufGw==
X-CSE-MsgGUID: hOnViCjORTiYDAyCkld9mg==
X-IronPort-AV: E=McAfee;i="6700,10204,11416"; a="58085736"
X-IronPort-AV: E=Sophos;i="6.15,246,1739865600"; d="scan'208";a="58085736"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2025 06:51:14 -0700
X-CSE-ConnectionGUID: 9rsWKEuKTXSkzsns7eGPDg==
X-CSE-MsgGUID: mHZMTY5nS4exFTHFKWI5vQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,246,1739865600"; d="scan'208";a="164487636"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa002.jf.intel.com with ESMTP; 28 Apr 2025 06:51:09 -0700
Date: Mon, 28 Apr 2025 22:12:06 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Shaoqin Huang <shahuang@redhat.com>, Eric Auger <eauger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Sebastian Ott <sebott@redhat.com>, Gavin Shan <gshan@redhat.com>,
 qemu-devel@nongnu.org, kvm@vger.kernel.org, qemu-arm@nongnu.org,
 Dapeng Mi <dapeng1.mi@intel.com>, Yi Lai <yi1.lai@intel.com>
Subject: Re: [PATCH 2/5] i386/kvm: Support basic KVM PMU filter
Message-ID: <aA+MttdYlZKPAwqT@intel.com>
References: <20250409082649.14733-1-zhao1.liu@intel.com>
 <20250409082649.14733-3-zhao1.liu@intel.com>
 <878qnoha3j.fsf@pond.sub.org> <aA3sLRzZj2270cSs@intel.com>
 <87r01c3jd2.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r01c3jd2.fsf@pond.sub.org>
Received-SPF: pass client-ip=192.198.163.9; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.484,
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

On Mon, Apr 28, 2025 at 08:12:09AM +0200, Markus Armbruster wrote:
> Date: Mon, 28 Apr 2025 08:12:09 +0200
> From: Markus Armbruster <armbru@redhat.com>
> Subject: Re: [PATCH 2/5] i386/kvm: Support basic KVM PMU filter
> 
> Zhao Liu <zhao1.liu@intel.com> writes:
> 
> > ...
> >
> >> > diff --git a/qemu-options.hx b/qemu-options.hx
> >> > index dc694a99a30a..51a7c61ce0b0 100644
> >> > --- a/qemu-options.hx
> >> > +++ b/qemu-options.hx
> >> > @@ -232,7 +232,8 @@ DEF("accel", HAS_ARG, QEMU_OPTION_accel,
> >> >      "                eager-split-size=n (KVM Eager Page Split chunk size, default 0, disabled. ARM only)\n"
> >> >      "                notify-vmexit=run|internal-error|disable,notify-window=n (enable notify VM exit and set notify window, x86 only)\n"
> >> >      "                thread=single|multi (enable multi-threaded TCG)\n"
> >> > -    "                device=path (KVM device path, default /dev/kvm)\n", QEMU_ARCH_ALL)
> >> > +    "                device=path (KVM device path, default /dev/kvm)\n"
> >> > +    "                pmu-filter=id (configure KVM PMU filter)\n", QEMU_ARCH_ALL)
> >> 
> >> As we'll see below, this property is actually available only for i386.
> >> Other target-specific properties document this like "x86 only".  Please
> >> do that for this one, too.
> >
> > Thanks! I'll change QEMU_ARCH_ALL to QEMU_ARCH_I386.
> 
> That would be wrong :)
> 
> QEMU_ARCH_ALL is the last argument passed to macro DEF().  It applies to
> the entire option, in this case -accel.

Thank you for correction! I didn't realize this point :-(.

> I'd like you to mark the option parameter as "(x86 only)", like
> notify-vmexit right above, and several more elsewhere.

Sure, I see. This option has already provided good example for me.

> >> As far as I can tell, the kvm-pmu-filter object needs to be activated
> >> with -accel pmu-filter=... to do anything.  Correct?
> >
> > Yes,
> >
> >> You can create any number of kvm-pmu-filter objects, but only one of
> >> them can be active.  Correct?
> >
> > Yes! I'll try to report error when user repeats to set this object, or
> > mention this rule in doc.
> 
> Creating kvm-pmu-filter objects without using them should be harmless,
> shouldn't it?  I think users can already create other kinds of unused
> objects.

I think I understand now. Indeed, creating an object should be allowed
regardless of whether it's used, as this helps decouple "-object" from
other options.

I can add something that:

the kvm-pmu-filter object needs to be activated with "-accel pmu-filter=id",
and only when it is activated, its filter policy can be passed to KVM.

(A single sentence is just an example; I think it needs to be carefully
refined within the context of the entire paragraph :-).)

> >> > +
> >> > +static int kvm_install_pmu_event_filter(KVMState *s)
> >> > +{
> >> > +    struct kvm_pmu_event_filter *kvm_filter;
> >> > +    KVMPMUFilter *filter = s->pmu_filter;
> >> > +    int ret;
> >> > +
> >> > +    kvm_filter = g_malloc0(sizeof(struct kvm_pmu_event_filter) +
> >> > +                           filter->nevents * sizeof(uint64_t));
> >> 
> >> Should we use sizeof(filter->events[0])?
> >
> > No, here I'm trying to constructing the memory accepted in kvm interface
> > (with the specific layout), which is not the same as the KVMPMUFilter
> > object.
> 
> You're right.  What about sizeof(kvm_filter->events[0])?

I get your point now! Yes, I should do in this way.

Thanks,
Zhao


