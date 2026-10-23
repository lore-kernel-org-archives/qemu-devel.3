Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2CD606A31B
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 14:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=eAr2Y5wx
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKGPR-0003BG-3s; Fri, 23 Oct 2026 10:38:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aastharawat@linux.microsoft.com>)
 id 1xKGPK-0003Af-HW; Fri, 23 Oct 2026 10:38:13 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aastharawat@linux.microsoft.com>)
 id 1xKGPI-0000Z6-J2; Fri, 23 Oct 2026 10:38:10 -0400
Received: by linux.microsoft.com (Postfix, from userid 1236)
 id E55A520B7166; Fri, 23 Oct 2026 07:37:56 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E55A520B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1792766276;
 bh=l/YeEEcWiwjnPNrnVHCOQhxyWwQ84lzT0RwupLKKNEw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=eAr2Y5wx8/xkm4EU2+6CVMdF1HpGzPUoAoS/8tXcEUZoCV9JIOfpSypSGbNnosJ3d
 IjY0LXBLonEWJHce3gYO7ZCUSDPb5rpjiuBbhUPQXGoyt7dKYT98aJLpYcCALtgOt5
 4UruxkOK09x+trY6gvqxpDH/nw68Ozu7+/9ixmec=
Date: Fri, 23 Oct 2026 07:37:56 -0700
From: Aastha Rawat <aastharawat@linux.microsoft.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Wei Liu <wei.liu@kernel.org>,
 Doru =?iso-8859-1?Q?Bl=E2nzeanu?= <dblanzeanu@linux.microsoft.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Anirudh Rayabharam <anirudh@anirudhrb.com>, qemu-arm@nongnu.org,
 Alexander Graf <agraf@csgraf.de>, Pedro Barbuda <pbarbuda@microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>
Subject: Re: [PATCH v6 06/14] target/arm: convert host CPU feature ifdef
 ladder to runtime checks
Message-ID: <attxRD7itjWw3WLl@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20261001-mshv_accel_arm64_supp-v6-0-aefe5e76a0e3@linux.microsoft.com>
 <20261001-mshv_accel_arm64_supp-v6-6-aefe5e76a0e3@linux.microsoft.com>
 <CAFEAcA_a-y6g=mjXECBUEqqcMWSy1wbNY813=4SgdqKVKh8npA@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA_a-y6g=mjXECBUEqqcMWSy1wbNY813=4SgdqKVKh8npA@mail.gmail.com>
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=aastharawat@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Oct 13, 2026 at 05:46:21PM +0100, Peter Maydell wrote:
> On Thu, 1 Oct 2026 at 11:52, Aastha Rawat
> <aastharawat@linux.microsoft.com> wrote:
> >
> > Replace the compile-time #if/#elif preprocessor ladder in
> > aarch64_host_initfn() with runtime calls and add mshv_enabled() to it.
> > This ensures the correct accelerator is selected at runtime when
> > multiple accelerators are compiled in.
> >
> > Add CONFIG_MSHV to the aarch64_cpus[] guard so that mshv accelerator can
> > register the "host" CPU type.
> 
> Don't do two things in one commit, please.

Sure, this will be split into two commits in the next revision.
 
> > Signed-off-by: Aastha Rawat <aastharawat@linux.microsoft.com>
> > ---
> >  target/arm/cpu64.c | 25 +++++++++++++++----------
> >  1 file changed, 15 insertions(+), 10 deletions(-)
> >
> > diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
> > index dcd0d698b3..a9e346049d 100644
> > --- a/target/arm/cpu64.c
> > +++ b/target/arm/cpu64.c
> > @@ -811,17 +811,21 @@ void aarch64_host_initfn(Object *obj)
> >      }
> >  #endif
> >
> > +    if (mshv_enabled()) {
> > +        mshv_arm_set_cpu_features_from_host(cpu);
> > +    } else if (kvm_enabled()) {
> >  #if defined(CONFIG_KVM)
> > -    kvm_arm_set_cpreg_mig_tolerances(cpu);
> > -    kvm_arm_set_cpu_features_from_host(cpu);
> > -    aarch64_add_sve_properties(obj);
> > -#elif defined(CONFIG_HVF)
> > -    hvf_arm_set_cpu_features_from_host(cpu);
> > -#elif defined(CONFIG_WHPX)
> > -    whpx_arm_set_cpu_features_from_host(cpu);
> > -#else
> > -    g_assert_not_reached();
> > +        kvm_arm_set_cpreg_mig_tolerances(cpu);
> >  #endif
> > +        kvm_arm_set_cpu_features_from_host(cpu);
> > +        aarch64_add_sve_properties(obj);
> > +    } else if (hvf_enabled()) {
> > +        hvf_arm_set_cpu_features_from_host(cpu);
> > +    } else if (whpx_enabled()) {
> > +        whpx_arm_set_cpu_features_from_host(cpu);
> > +    } else {
> > +        g_assert_not_reached();
> > +    }
> 
> The reason for the ifdefs is that if CONFIG_HVF etc aren't
> set then the functions hvf_arm_set_cpu_features_from_host()
> don't exist...

Yeah, the compile guards should continue to exist. The old ladder was valid
for one relevant accelerator backend per host build. MSHV can be built
alongside KVM on Linux, so this can be something like:

#if defined(CONFIG_MSHV)
    if (mshv_enabled()) {
        mshv_arm_set_cpu_features_from_host(cpu);
        goto add_common_properties;
    }
#endif

#if defined(CONFIG_KVM)
    if (kvm_enabled()) {
        kvm_arm_set_cpreg_mig_tolerances(cpu);
        kvm_arm_set_cpu_features_from_host(cpu);
        aarch64_add_sve_properties(obj);
        goto add_common_properties;
    }
#endif

#if defined(CONFIG_HVF)
    if (hvf_enabled()) {
        hvf_arm_set_cpu_features_from_host(cpu);
        goto add_common_properties;
    }
#endif

#if defined(CONFIG_WHPX)
    if (whpx_enabled()) {
        whpx_arm_set_cpu_features_from_host(cpu);
        goto add_common_properties;
    }
#endif

    g_assert_not_reached();

#if defined(CONFIG_KVM) || defined(CONFIG_HVF) || \
    defined(CONFIG_WHPX) || defined(CONFIG_MSHV)
add_common_properties:
#endif
    if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
        aarch64_add_pauth_properties(obj);
    }

The runtime checks will select the accelerator actually chosen for the VM when
multiple accelerators, such as KVM and MSHV, are compiled together.

Thanks,
Aastha 

