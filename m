Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A28E7C2BD09
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 18:04:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sP4Kd-0000kH-My; Wed, 03 Jul 2024 14:03:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sP4KX-0000ic-Ct
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 14:03:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sP4KV-0007o5-FC
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 14:03:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720029821;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XfqmdywImwo59dyBOVs3ewAbRoE2VxeJYU/6HHa+VO8=;
 b=CU/ggdMtPmOd+l8D4+17S/4lVXrA020OCq962Y854iYMNQcGj7g5XUyTFa7xtDFNdJhGe8
 +YH6vvRv+rqLnb79Zx100a7lSrYBGZ6mKbA/QUAuioUNm/HwgP2kIrZFlMIOq54GHVO2TO
 lnm0MHJYnhmiyd0GE58r0vCq9iLV4/A=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-372-q-ZI0eOnO2WWIGeoz8sQ8g-1; Wed, 03 Jul 2024 14:03:38 -0400
X-MC-Unique: q-ZI0eOnO2WWIGeoz8sQ8g-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-79560b25fc4so103030385a.3
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 11:03:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720029817; x=1720634617;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XfqmdywImwo59dyBOVs3ewAbRoE2VxeJYU/6HHa+VO8=;
 b=MKcXD0NFT9M/nY2XAKRw8JZ9/0mRRz8+RINh4QYSWCImo5H37iMGoRfd+/E3+QieGb
 j9u535RD3dJSppt5IXuH8InEdyUHoi9VZrJR21qlmb5eiIo1AJ2I/utdoJ+ixMMhZZon
 cObMIeb0wCCqPImV4NBoDhagBdEfwxZSxNiSNVV3VbZSxHqPmMfmo/9a1atRtt69UeLe
 jLiT4jEzNMzNSolieBVZZL3PK7SVSG4ACHhO8LKWLquzJNVXPd83m4RGwIJq/P9KFYHA
 EqkzqBKm96r2PRDDWLgXrblqsj78DlmD9d9E4mgdNFiiTTRtwlLNTKBotMQ13zFrVI8/
 qawA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWEb2XrNHsPg9eaHmaE28QFMrHlBYGIS3B+YoTLygZnT1QduLNsmwqMG0Fo6qNU6qEcQbNmlN+Y6RzbjTAxN+ltUyPWeOQ=
X-Gm-Message-State: AOJu0YyIDQ9iO7fDUcuTx6zibdf3+OsJrj3p+oDo4pH8euBgiyJB8mNm
 2Gh4KDL4SYrY2AGX26/yaQ6aX3iWPacge1wq5eb0s1EF7BIgNIUUayUmAsxjQeqYviPJ/qQTjK0
 dEgVb2rkzksGonZt6Ph8Vp+HwPuX4wGGluycehiza/IZ4nqCPKDMS
X-Received: by 2002:a05:6214:2265:b0:6b5:de38:d6ee with SMTP id
 6a1803df08f44-6b5de38dde1mr38530836d6.3.1720029817027; 
 Wed, 03 Jul 2024 11:03:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHTOC6yMgBw/GyfGi6L8AS4Suwcke50c44eGZiFCPyChInAsBACJNtQsHB57ldTqmQltcP4LQ==
X-Received: by 2002:a05:6214:2265:b0:6b5:de38:d6ee with SMTP id
 6a1803df08f44-6b5de38dde1mr38530526d6.3.1720029816549; 
 Wed, 03 Jul 2024 11:03:36 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6b59e36ac03sm55721736d6.20.2024.07.03.11.03.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jul 2024 11:03:36 -0700 (PDT)
Date: Wed, 3 Jul 2024 14:03:33 -0400
From: Peter Xu <peterx@redhat.com>
To: Wei Wang <wei.w.wang@intel.com>
Cc: pbonzini@redhat.com, mtosatti@redhat.com, farosas@suse.de,
 qemu-devel@nongnu.org, Lei Wang <lei4.wang@intel.com>,
 Jiri Denemark <jdenemar@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Subject: Re: [PATCH v1] target/i386: kvm: Block migration when enfore_cpuid
 is set to false
Message-ID: <ZoWSdR1IOQ0iIxZC@x1n>
References: <20240703144912.130988-1-wei.w.wang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240703144912.130988-1-wei.w.wang@intel.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Jul 03, 2024 at 10:49:12PM +0800, Wei Wang wrote:
> When enforce_cpuid is set to false, the guest is launched with a filtered
> set of features, meaning that unsupported features by the host are removed
> from the guest's vCPU model. This could cause issues for live migration.
> For example, a guest on the source is running with features A and B. If
> the destination host does not support feature B, the stub guest can still
> be launched on the destination with feature A only if enforce_cpuid=false.
> Live migration can start in this case, though it may fail later when the
> states of feature B are put to the destination side. This failure occurs
> in the late stage (i.e., stop&copy phase) of the migration flow, where the
> source guest has already been paused. Tests show that in such cases the
> source guest does not recover, and the destination is unable to resume to
> run.
> 
> Make "enfore_cpuid=true" a hard requirement for a guest to be migratable,
> and change the default value of "enforce_cpuid" to true, making the guest
> vCPUs migratable by default. If the destination stub guest has inconsistent
> CPUIDs (i.e., destination host cannot support the features defined by the
> guest's vCPU model), it fails to boot (with enfore_cpuid=true by default),
> thereby preventing migration from occuring. If enfore_cpuid=false is
> explicitly added for the guest, the guest is deemed as non-migratable
> (via the migration blocker), so the above issue won't occur as the guest
> won't be migrated.
> 
> Tested-by: Lei Wang <lei4.wang@intel.com>
> Signed-off-by: Wei Wang <wei.w.wang@intel.com>

[Copy Jiri and Dan for libvirt-side implications]

> ---
>  target/i386/cpu.c     |  2 +-
>  target/i386/kvm/kvm.c | 25 +++++++++++++++----------
>  2 files changed, 16 insertions(+), 11 deletions(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 4c2e6f3a71..7db4fe4ead 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -8258,7 +8258,7 @@ static Property x86_cpu_properties[] = {
>      DEFINE_PROP_UINT32("hv-version-id-snumber", X86CPU, hyperv_ver_id_sn, 0),
>  
>      DEFINE_PROP_BOOL("check", X86CPU, check_cpuid, true),
> -    DEFINE_PROP_BOOL("enforce", X86CPU, enforce_cpuid, false),
> +    DEFINE_PROP_BOOL("enforce", X86CPU, enforce_cpuid, true),

I assume in many cases people can still properly migrate when the hosts are
similar or identical, so maybe we at least want the old machine types keep
working (by introducing a machine compat property)?

>      DEFINE_PROP_BOOL("x-force-features", X86CPU, force_features, false),
>      DEFINE_PROP_BOOL("kvm", X86CPU, expose_kvm, true),
>      DEFINE_PROP_UINT32("phys-bits", X86CPU, phys_bits, 0),
> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> index dd8b0f3313..aee717c1cf 100644
> --- a/target/i386/kvm/kvm.c
> +++ b/target/i386/kvm/kvm.c
> @@ -1741,7 +1741,7 @@ static int hyperv_init_vcpu(X86CPU *cpu)
>      return 0;
>  }
>  
> -static Error *invtsc_mig_blocker;
> +static Error *cpu_mig_blocker;
>  
>  #define KVM_MAX_CPUID_ENTRIES  100
>  
> @@ -2012,6 +2012,15 @@ full:
>      abort();
>  }
>  
> +static bool kvm_vcpu_need_block_migration(X86CPU *cpu)
> +{
> +    CPUX86State *env = &cpu->env;
> +
> +    return !cpu->enforce_cpuid ||
> +           (!env->user_tsc_khz && (env->features[FEAT_8000_0007_EDX] &
> +                                   CPUID_APM_INVTSC));
> +}

Nit: maybe it's nice this returns a "const char*" with detailed reasons to
be put into the error_setg(), so it dumps the same as before for the invtsc
blocker.

Thanks,

> +
>  int kvm_arch_init_vcpu(CPUState *cs)
>  {
>      struct {
> @@ -2248,18 +2257,14 @@ int kvm_arch_init_vcpu(CPUState *cs)
>          has_msr_mcg_ext_ctl = has_msr_feature_control = true;
>      }
>  
> -    if (!env->user_tsc_khz) {
> -        if ((env->features[FEAT_8000_0007_EDX] & CPUID_APM_INVTSC) &&
> -            invtsc_mig_blocker == NULL) {
> -            error_setg(&invtsc_mig_blocker,
> -                       "State blocked by non-migratable CPU device"
> -                       " (invtsc flag)");
> -            r = migrate_add_blocker(&invtsc_mig_blocker, &local_err);
> +    if (!cpu_mig_blocker &&  kvm_vcpu_need_block_migration(cpu)) {
> +            error_setg(&cpu_mig_blocker,
> +                       "State blocked by non-migratable CPU device");
> +            r = migrate_add_blocker(&cpu_mig_blocker, &local_err);
>              if (r < 0) {
>                  error_report_err(local_err);
>                  return r;
>              }
> -        }
>      }
>  
>      if (cpu->vmware_cpuid_freq
> @@ -2312,7 +2317,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
>      return 0;
>  
>   fail:
> -    migrate_del_blocker(&invtsc_mig_blocker);
> +    migrate_del_blocker(&cpu_mig_blocker);
>  
>      return r;
>  }
> -- 
> 2.27.0
> 
> 

-- 
Peter Xu


