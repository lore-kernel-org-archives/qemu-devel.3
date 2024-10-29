Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9626D3A660
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 14:34:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5nIr-0005nD-G9; Tue, 29 Oct 2024 10:34:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tao1.su@linux.intel.com>)
 id 1t5nIq-0005n0-D4
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 10:34:36 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tao1.su@linux.intel.com>)
 id 1t5nIo-0001A9-C6
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 10:34:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730212474; x=1761748474;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=XWsxeM4LQdLTtzju8ZyvvQP4oeYx2lSyysePXZuyeVo=;
 b=lrWzQ24ficl0VnNU0tY3uiPqcay6Lh9Oe42owcAEaAFtHk1oMTGKXkPJ
 fexkcqvRQb7cKFHEgJue2dyKeD0ssXpVumRCGFlOG4ZCo9I/G4ccZ86At
 nKmgLkbE7N13WxUZ8gbfFNZqez/iaR/lGAheLCXtlehwJXRB4WqoN3nrG
 BIpraBjRFDN2v5ZmE9ShOWD60dyQDOLJYGrTtkMFX0K16/Lw+rRFmbFM2
 0nwJ8Nt9AOjsJ116nikAwJLYL573Hgll5wRblknpoYwU6iy3/TMt6wvtr
 ylwolgJDiEEPgoVce/xWQ0GUZ/T8tc7XpYYHDFaoE0gcFrpDFEVmg0X8a Q==;
X-CSE-ConnectionGUID: Bhk7nWeZSNWPEx8syCrGiA==
X-CSE-MsgGUID: U0M13OtmQoOpEwfg5ukshQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29821795"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="29821795"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2024 07:34:29 -0700
X-CSE-ConnectionGUID: q7TM4nGuQheH0h9tG9tcDQ==
X-CSE-MsgGUID: w2ukMyagTDSr5ykLn0Shaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; d="scan'208";a="119447358"
Received: from linux.bj.intel.com ([10.238.157.71])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2024 07:34:27 -0700
Date: Tue, 29 Oct 2024 22:29:19 +0800
From: Tao Su <tao1.su@linux.intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, mtosatti@redhat.com, xiaoyao.li@intel.com,
 xuelian.guo@intel.com
Subject: Re: [PATCH 3/6] target/i386: Add CPUID.24 leaf for AVX10
Message-ID: <ZyDxP4S074/ZXfpv@linux.bj.intel.com>
References: <20241028024512.156724-1-tao1.su@linux.intel.com>
 <20241028024512.156724-4-tao1.su@linux.intel.com>
 <537e3009-1706-4799-a57a-8369ddd2b335@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <537e3009-1706-4799-a57a-8369ddd2b335@redhat.com>
Received-SPF: none client-ip=198.175.65.21;
 envelope-from=tao1.su@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.302,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Tue, Oct 29, 2024 at 09:25:53AM +0100, Paolo Bonzini wrote:
> On 10/28/24 03:45, Tao Su wrote:
> > @@ -6835,6 +6850,26 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
> >           }
> >           break;
> >       }
> > +    case 0x24: {
> > +        *eax = 0;
> > +        *ebx = 0;
> > +        *ecx = 0;
> > +        *edx = 0;
> > +        if (!(env->features[FEAT_7_1_EDX] & CPUID_7_1_EDX_AVX10)) {
> > +            break;
> > +        }
> > +
> > +        if (count == 0) {
> > +            uint8_t v = kvm_arch_get_supported_cpuid(cs->kvm_state, 0x24,
> > +                                                     0, R_EBX);
> > +            if (env->avx10_version && env->avx10_version < v) {
> > +                v = env->avx10_version;
> > +            }
> > +
> > +            *ebx = env->features[FEAT_24_0_EBX] | v;
> > +        }
> > +        break;
> > +    }
> >       case 0x40000000:
> >           /*
> >            * CPUID code in kvm_arch_init_vcpu() ignores stuff
> 
> This check should be done elsewhere (called by x86_cpu_realizefn());
> cpu_x86_cpuid() should only report the value:
> 
>          if ((env->features[FEAT_7_1_EDX] & CPUID_7_1_EDX_AVX10) && count == 0) {
>              *ebx = env->features[FEAT_24_0_EBX] | env->avx10_version;
>          }
> 
> Also, the check should use x86_cpu_get_supported_cpuid() because KVM is not the
> only accelerator.
> 

Yes, I see, I add check here:

@@ -7679,6 +7719,27 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)

     x86_cpu_filter_features(cpu, cpu->check_cpuid || cpu->enforce_cpuid);

+    if (env->features[FEAT_7_1_EDX] & CPUID_7_1_EDX_AVX10) {
+        uint32_t eax, ebx, ecx, edx;
+        x86_cpu_get_supported_cpuid(0x24, 0, &eax, &ebx, &ecx, &edx);
+
+        ebx &= 0xff;
+
+        if (ebx < env->avx10_version) {
+            const char *msg = accel_uses_host_cpuid()
+                              ? "Host doesn't support requested feature"
+                              : "TCG doesn't support requested feature";
+            if (cpu->enforce_cpuid) {
+                error_setg(&local_err, "%s: avx10.%d", msg,
+                           env->avx10_version);
+                goto out;
+            } else if (cpu->check_cpuid) {
+                warn_report("%s: avx10.%d", msg, env->avx10_version);
+            }
+            env->avx10_version = ebx;
+        }
+    }
+
     if (cpu->enforce_cpuid && x86_cpu_have_filtered_features(cpu)) {
         error_setg(&local_err,
                    accel_uses_host_cpuid() ?


> 
> > 
> > +    if (env->features[FEAT_7_1_EDX] & CPUID_7_1_EDX_AVX10) {
> > +        uint8_t version =
> > +            kvm_arch_get_supported_cpuid(cs->kvm_state, 0x24, 0, R_EBX);
> > +
> > +        if (!env->avx10_version) {
> > +            env->avx10_version = version;
> > +        }
> > +
> 
> This should not be done here, but in max_x86_cpu_realize().  It should also
> use x86_cpu_get_supported_cpuid().
> 

Yes, I try to add here:

@@ -5327,6 +5365,12 @@ static void max_x86_cpu_realize(DeviceState *dev, Error **errp)
         }
     }

+    if (!object_property_get_uint(obj, "avx10-version", &error_abort)) {
+        uint32_t eax, ebx, ecx, edx;
+        x86_cpu_get_supported_cpuid(0x24, 0, &eax, &ebx, &ecx, &edx);
+        object_property_set_uint(obj, "avx10-version", ebx & 0xff, &error_abort);
+    }
+
     x86_cpu_realizefn(dev, errp);
 }


> For Granite Rapids you're only setting the AVX10 version in v2 and therefore
> you don't need it, but there should also be (for the future) an avx10_version
> field in X86CPUDefinition, which is set into the avx10-version property at
> x86_cpu_load_model().
> 

Yes, for new CPU model, we should do that.

> > index d845384dcd..5566a13f4f 100644
> > --- a/target/i386/cpu.h
> > +++ b/target/i386/cpu.h
> > @@ -662,6 +662,7 @@ typedef enum FeatureWord {
> >       FEAT_XSAVE_XSS_HI,     /* CPUID[EAX=0xd,ECX=1].EDX */
> >       FEAT_7_1_EDX,       /* CPUID[EAX=7,ECX=1].EDX */
> >       FEAT_7_2_EDX,       /* CPUID[EAX=7,ECX=2].EDX */
> > +    FEAT_24_0_EBX,      /* CPUID[EAX=0x24,ECX=0].EBX */
> 
> Adding FEAT_24_0_EBX should be a separate patch.
> 

Yes, all you said above are excellent suggestions and I have tested on
my platform. Should I submit a v2 with these changes or wait for you to
send v2 directly? :-)

