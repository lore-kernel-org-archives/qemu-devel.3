Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A0C5FF8861
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 09:11:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHHz7-0005Mc-K0; Mon, 27 Apr 2026 05:10:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aastharawat@linux.microsoft.com>)
 id 1wHHz5-0005L2-IA; Mon, 27 Apr 2026 05:10:32 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aastharawat@linux.microsoft.com>)
 id 1wHHz2-00011q-V4; Mon, 27 Apr 2026 05:10:31 -0400
Received: by linux.microsoft.com (Postfix, from userid 1236)
 id 16FD620B7169; Mon, 27 Apr 2026 02:10:21 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 16FD620B7169
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1777281021;
 bh=RfKVMs36N62/rwHGAjYb/f8kec9Pu9SZ1gBZB1dATII=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=sbM1sPhkBaTZEjF1t8NO2EIhREt+u6G/VPhl/dfAWRD+/SpkfxY8YlOORLZQarreM
 mWdtzZguUaX6qBTSXxaN9+Zs4spLdstZPjWnPDCoOZ6szbn09DcG6c9KVldVzYJbo+
 ATaZn3bEFDu0CHvY2fAUUaDg7slox+00ByrFxcOY=
Date: Mon, 27 Apr 2026 02:10:21 -0700
From: Aastha Rawat <aastharawat@linux.microsoft.com>
To: Mohamed Mediouni <mohamed@unpredictable.fr>
Cc: qemu-devel@nongnu.org, Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 =?iso-8859-1?Q?=22Daniel_P=2E_Berrang=E9=22?= <berrange@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Anirudh Rayabharam <anirudh@anirudhrb.com>,
 Magnus Kulke <magnus.kulke@linux.microsoft.com>,
 qemu-arm@nongnu.org, Alexander Graf <agraf@csgraf.de>,
 Pedro Barbuda <pbarbuda@microsoft.com>
Subject: Re: [PATCH v3 10/14] target/arm: extract MMIO emulation logic for
 HVF & WHPX
Message-ID: <ae8n/bv2HDzwfBMq@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20260421-mshv_accel_arm64_supp-v3-0-469f544778ba@linux.microsoft.com>
 <20260421-mshv_accel_arm64_supp-v3-10-469f544778ba@linux.microsoft.com>
 <0E102AEB-7196-4968-B016-16879EF0D034@unpredictable.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0E102AEB-7196-4968-B016-16879EF0D034@unpredictable.fr>
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=aastharawat@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Apr 21, 2026 at 08:51:07AM +0200, Mohamed Mediouni wrote:
> 
> 
> > On 21. Apr 2026, at 07:21, Aastha Rawat <aastharawat@linux.microsoft.com> wrote:
> > 
> > - Move common MMIO emulation code from HVF and WHPX backend to
> >  arm_emulate_mmio() in helper.c.
> > - Update HVF and WHPX to use the new helper and shared types.
> 
> Hi,
> 
> This one is a bit interesting and not sure if it’s ok in this form.
> 
> That’s for one reason: it causes a slowdown on WHP and HVF by fetching
> state (and sometimes setting) outside of their respective shared register pages.
> 
> In both of those APIs, the existence of the shared register page is opaque/hidden
> away, but if you aren’t careful about what you fetch you’re going to hit the slow
> path very easily.
> 
> On x86 WHPX, we have a state level abstraction with a FAST_RUNTIME_STATE
> that only fetches a (sub)set accessible that is readable using only information
> from the shared register page - and that is supposed to be enough for the vast
> majority of MMIO - that doesn’t touch the FP/MMX/SSE register files.
> 
> And another possibility is putting it in a target/arm/emulate with mimicking
> the x86_emul_ops interface with adding register callbacks to that so that state
> is fetched/set dynamically.

Thanks for the review. I agree with you, the current approach fetches far 
more state than needed for a typical MMIO access, which only touches a 
single GP register (Xt). That would indeed bypass the shared register 
page fast path on both HVF and WHPX.

I like the suggestion of mirroring the x86_emul_ops pattern. For v4, I'll 
rework this to introduce a struct (arm_emul_ops) with register access 
callbacks, something along the lines of:

struct arm_emul_ops {
    uint64_t (*get_reg)(CPUState *cpu, unsigned reg);
    void (*set_reg)(CPUState *cpu, unsigned reg, uint64_t val);
};

This would use the existing backend implementation for WHPX & HVF. 
HVF can use hvf_get_reg()/hvf_set_reg(), WHPX can go through the 
shared register page via whpx_get_reg()/whpx_set_reg(), and MSHV 
can access env->xregs[] directly since it already syncs state in the 
run loop.

I'll have this reworked in v4.

Thanks,
Aastha

