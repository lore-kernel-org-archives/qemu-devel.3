Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87691D5B87A
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 06:18:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5fZ1-0007KZ-E9; Tue, 29 Oct 2024 02:18:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tao1.su@linux.intel.com>)
 id 1t5fYp-0006wa-7G
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 02:18:40 -0400
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tao1.su@linux.intel.com>)
 id 1t5fYl-00083g-P4
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 02:18:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730182711; x=1761718711;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=lFfcfmuQyvY4bgk9I4IOtFQg4Da8L1MCrKWR7fphgAo=;
 b=UBxpCQarPARbhuQalCUEMsQ2tySFnJx0MIfXSFwNENWvaKlfBHLCEaui
 wfc+rdHEzguDDaRwdE2G2yiCoLzrPUNK6Fs/xhDrfBhMVoG6nKpKhLWBq
 BJLL1M/bYuQ4/o92NWkvthqq2CLeG1FityuIr/dODW28jt3ActlbToHpj
 C6tHuCTNL8UR7DkCcwW9hx1Z4Ogf052uJjfUC2fWeuheXdM3WDXgc3t/z
 h6//v6Q89G+SU/WerRvvIyImYutbN+2GkcfKP62GJLWEJJZW0ykbBMItD
 hZ4PiaoBD24S0SeusrKNe56JtEjtNQSMtobwKpo5yMQ23NzdCO110jFLh g==;
X-CSE-ConnectionGUID: dwx13zAvTPiKP06LigU7pQ==
X-CSE-MsgGUID: f6Fyz8BuRRGA8PU1N6D6xA==
X-IronPort-AV: E=McAfee;i="6700,10204,11239"; a="30017896"
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; d="scan'208";a="30017896"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Oct 2024 23:18:24 -0700
X-CSE-ConnectionGUID: LZr0GMjQSfSDGJZVowXQxw==
X-CSE-MsgGUID: MGID8DFQTseKBrrjmgSWAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; d="scan'208";a="119312702"
Received: from linux.bj.intel.com ([10.238.157.71])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Oct 2024 23:18:22 -0700
Date: Tue, 29 Oct 2024 14:13:16 +0800
From: Tao Su <tao1.su@linux.intel.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, mtosatti@redhat.com,
 xuelian.guo@intel.com
Subject: Re: [PATCH 3/6] target/i386: Add CPUID.24 leaf for AVX10
Message-ID: <ZyB8/BJZ/hIDb186@linux.bj.intel.com>
References: <20241028024512.156724-1-tao1.su@linux.intel.com>
 <20241028024512.156724-4-tao1.su@linux.intel.com>
 <c9d9414c-41aa-4ee5-be23-9a12b9bb768d@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9d9414c-41aa-4ee5-be23-9a12b9bb768d@intel.com>
Received-SPF: none client-ip=192.198.163.14;
 envelope-from=tao1.su@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.373,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Mon, Oct 28, 2024 at 11:04:07PM +0800, Xiaoyao Li wrote:
> On 10/28/2024 10:45 AM, Tao Su wrote:
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
> 
> Here, if user specified avx10_version is >= kvm reported value, it uses
> KVM's reported value silently.
> 
> I think it's not good. It'd better to validate if user specified value can
> be satisfied or not, and emit a warning when not. e.g., in
> x86_cpu_filter_features() or in kvm_cpu_realizefn(). Also we can put the
> behavior along with it that "use KVM reported maximum value when
> avx10_version is 0 "
> 
> then, here we can simply do
> 
> 	*ebx = env->features[FEAT_24_0_EBX] | env->avx10_version;

Is it necessary to add enforce_cpuid for avx10_version too?

How about checking this in x86_cpu_realizefn, because I see this may be a
more suitable place to implement check_cpuid and enforce_cpuid.


@@ -7816,6 +7810,29 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)

     x86_cpu_filter_features(cpu, cpu->check_cpuid || cpu->enforce_cpuid);

+    if (env->features[FEAT_7_1_EDX] & CPUID_7_1_EDX_AVX10) {
+        uint8_t version =
+            kvm_arch_get_supported_cpuid(cs->kvm_state, 0x24, 0, R_EBX);
+
+        if (!env->avx10_version) {
+            env->avx10_version = version;
+        }
+
+        if (version < env->avx10_version) {
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
+            env->avx10_version = version;
+        }
+    }
+
     if (cpu->enforce_cpuid && x86_cpu_have_filtered_features(cpu)) {
         error_setg(&local_err,
                    accel_uses_host_cpuid() ?


