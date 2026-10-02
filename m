Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72F54CA5FC4
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 04:07:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCUXi-00037z-NC; Fri, 02 Oct 2026 00:06:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1xCUXh-00037b-5a
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 00:06:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1xCUXe-0000v1-Le
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 00:06:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790913997;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Gs7YJR2mPXTbKCewLFBLQH9fuzpBXhw+3Y9+5ECj960=;
 b=UjmcsC7Lnv+yPQJCWlMVuuEDZXpKB5y9V68cJ0MWWgj28nxT/qmaQStHRzctZIxwAMV4yp
 eirmAwjRBBdUsfPKXFwcYJ4Dj8WNEk4sswiCfShiRDZ2uo87JBO6tloHExP9gjzOyEn5f0
 OTg/x1TGK35ObjWuC+kQnUnZ7OTpyDg=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-0CU5WOp9P2G29mMGlHSgsw-1; Fri, 02 Oct 2026 00:06:34 -0400
X-MC-Unique: 0CU5WOp9P2G29mMGlHSgsw-1
X-Mimecast-MFC-AGG-ID: 0CU5WOp9P2G29mMGlHSgsw_1790913991
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2cfa4e4684bso119957925ad.2
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 21:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790913991; x=1791518791; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Gs7YJR2mPXTbKCewLFBLQH9fuzpBXhw+3Y9+5ECj960=;
 b=MNVFtaEnyCPEb9sl548acLd3P9Bv1FsTT62VMZ9X0VAGpN+L+D65+su+ddUAeiVrVK
 HOx4gcG2FhaH6V9ahe3gY/E+uMjhGJ663UJgWIcT2yHGmEz4zO6ASOW0mdfHQs2fyUI1
 BEMp/6eGNx1N5oBsLUYkKRLQB9gQSGqKXEa4unyw+TBVWgiTqgq2FksBHZ/bBE2Sja9z
 NjffDHxO7Suyh63zk7cTBcDX55Mxb3sWUY/TOiCyXySbsBsvcG3LVDcdQIiGX0SfXlNj
 nfSMk0yaTvt1Yg0Dwc3OL1/UfslWA+V+kmgOG6yyxk8vwRngSUy6v4Feyrq5CZCc4sq4
 1v+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790913991; x=1791518791;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Gs7YJR2mPXTbKCewLFBLQH9fuzpBXhw+3Y9+5ECj960=;
 b=T8X8Z1wxDdJZ1k/klUfL8L/ggZRZGYKzhrgSsvOIt9JVo1SlEATb/42CXTgXxMyhr2
 F3+uRG4zbqLY+85AcA/RE6elN/uCP/fvKUSM9saJksjg4tqDCgofWDQrYnHt1vqQHrqZ
 s1ZLQVod3Ztd/IkXZ6cSjVeQziNRCJRNGOcdxzAI5s6Nkq77LA3xTBrbGDotDHl+83BJ
 411UomQxpp8hJmpvf4/JVaXksmQdyNUEqC3fCWmqTKW51pTkBWdk9UCs2/Es1wzn3i99
 1giB4t285/Gjun/1gLurZNcA7xuD0BNkpCgeNhcMA03fg60Ys8+94NLvGnioTk0kSKJs
 J2YQ==
X-Gm-Message-State: AFq9FYItztrLni496y8vFJeKTaETY6R1W9PjAK56o9sWfesP1VXf1fn1
 38+erQ6PyE0XbdXvG4/zPYVciDMEIo63C93/1Wf0IMHE/dSWfZfGXxd5GUHfiL1V6GHfadwUiFK
 6QjYMhRm+0JzgEA+k5I9PqelDvcHVa175qY/CaM1yGzn2v6XoMMc9DZda
X-Gm-Gg: AYBFou1EpwPh9cjJL3+n5aEOAKF4EGHXTG5ia2TtCqeZmucz39KzkfUaS7kS3r8loZL
 KtPaTRIOQu37Ctg+T54BQaewDxY7s/R8LFqyv0rScGzaHtGEjfJc5Q68G1et/s1G4WBBfUy8B92
 28vJSeto/v9OnA+ARW2Lf41B+2kaQKGtyA4GmR3p7CB98KSdvhwJHNAPx5+81jXVjl2XQJ9qGJY
 nBC+zpntx9wb6Gu2s0fk3fkLSEL+kWSMtc88SwH3pBV5c1KfnjpR7ZztvD5aKqm8hDoKp08bqX9
 I4L8jLp3xajJN6m5vv5x3P4hwe4m19P0Ci+QE0aQo5FsuLaLXpD8MSfZLMao8DuJTclKLr9ZXYL
 t/WEh9p3DmaWYOGsAqdqBaYiGiY6I4I2miUN4XljD2w==
X-Received: by 2002:a17:90b:1c12:b0:3a0:4444:ef1e with SMTP id
 98e67ed59e1d1-3a6ceaeb09amr1510011a91.29.1790913991217; 
 Thu, 01 Oct 2026 21:06:31 -0700 (PDT)
X-Received: by 2002:a17:90b:1c12:b0:3a0:4444:ef1e with SMTP id
 98e67ed59e1d1-3a6ceaeb09amr1509996a91.29.1790913990647; 
 Thu, 01 Oct 2026 21:06:30 -0700 (PDT)
Received: from [192.168.68.52] (n175-34-8-244.mrk21.qld.optusnet.com.au.
 [175.34.8.244]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a6cd5dc4e7sm2120673a91.11.2026.10.01.21.06.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Oct 2026 21:06:30 -0700 (PDT)
Message-ID: <eda8ee8f-5f17-4144-b21e-b1d990ee3270@redhat.com>
Date: Fri, 2 Oct 2026 14:06:24 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v4 12/24] target/arm/cpu: Set number of breakpoints and
 watchpoints in KVM
To: Mathieu Poirier <mathieu.poirier@linaro.org>, berrange@redhat.com,
 kchamart@redhat.com, pierrick.bouvier@oss.qualcomm.com,
 peter.maydell@linaro.org, mst@redhat.com, cohuck@redhat.com,
 pbonzini@redhat.com, eblake@redhat.com, armbru@redhat.com,
 lorenzo.pieralisi@linaro.org, enju.kohei@fujitsu.com
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvm@vger.kernel.org
References: <20260903193611.1058589-1-mathieu.poirier@linaro.org>
 <20260903193611.1058589-13-mathieu.poirier@linaro.org>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20260903193611.1058589-13-mathieu.poirier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.331,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 9/4/26 5:35 AM, Mathieu Poirier wrote:
> From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> 
> Add "num-breakpoints" and "num-watchpoints" CPU parameters to configure
> the debug features that KVM presents to the guest. The KVM vCPU
> configuration is modified by calling SET_ONE_REG on the ID register.
> 
> This is needed for Realm VMs, whose parameters include breakpoints and
> watchpoints, and influence the Realm Initial Measurement.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
>   target/arm/arm-qmp-cmds.c |  1 +
>   target/arm/cpu.h          |  4 ++
>   target/arm/cpu64.c        | 81 +++++++++++++++++++++++++++++++++++++++
>   target/arm/kvm.c          | 56 +++++++++++++++++++++++++++
>   4 files changed, 142 insertions(+)
> 
> diff --git a/target/arm/arm-qmp-cmds.c b/target/arm/arm-qmp-cmds.c
> index 83ec95c290f6..9ed65eb090d7 100644
> --- a/target/arm/arm-qmp-cmds.c
> +++ b/target/arm/arm-qmp-cmds.c
> @@ -76,6 +76,7 @@ static const char *cpu_model_advertised_features[] = {
>       "sve1408", "sve1536", "sve1664", "sve1792", "sve1920", "sve2048",
>       "kvm-no-adjvtime", "kvm-steal-time",
>       "pauth", "pauth-impdef", "pauth-qarma3", "pauth-qarma5",
> +    "num-breakpoints", "num-watchpoints",
>       NULL
>   };
>   
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 6bbc942f9a59..d256d66a3e1b 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -1173,6 +1173,10 @@ struct ArchCPU {
>   
>       /* Generic timer counter frequency, in Hz */
>       uint64_t gt_cntfrq_hz;
> +
> +    /* Allows to override the default configuration */
> +    uint8_t num_bps;
> +    uint8_t num_wps;
>   };
>   

May improve the comments to indicate: these two fields are only needed
by RME-vCPUs.

        /* Override the default configuration, only for RME vCPUs */

>   typedef struct ARMCPUInfo {
> diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
> index 4e8c47253086..18adb06d78ad 100644
> --- a/target/arm/cpu64.c
> +++ b/target/arm/cpu64.c
> @@ -666,6 +666,86 @@ void aarch64_add_pauth_properties(Object *obj)
>       }
>   }
>   
> +#if defined(CONFIG_KVM)
> +static void arm_cpu_get_num_wps(Object *obj, Visitor *v, const char *name,
> +                                void *opaque, Error **errp)
> +{
> +    uint8_t val;
> +    ARMCPU *cpu = ARM_CPU(obj);
> +
> +    val = cpu->num_wps;
> +    if (val == 0) {
> +        val = FIELD_EX64(cpu->isar.idregs[ID_AA64DFR0_EL1_IDX],
> +                         ID_AA64DFR0, WRPS) + 1;
> +    }
> +
> +    visit_type_uint8(v, name, &val, errp);
> +}
> +
> +static void arm_cpu_set_num_wps(Object *obj, Visitor *v, const char *name,
> +                                void *opaque, Error **errp)
> +{
> +    uint8_t val;
> +    ARMCPU *cpu = ARM_CPU(obj);
> +    uint8_t max_wps = FIELD_EX64(cpu->isar.idregs[ID_AA64DFR0_EL1_IDX],
> +                                 ID_AA64DFR0, WRPS) + 1;
> +
> +    if (!visit_type_uint8(v, name, &val, errp)) {
> +        return;
> +    }
> +
> +    if (val < 2 || val > max_wps) {
> +        error_setg(errp, "invalid number of watchpoints");
> +        return;
> +   }
> +
> +    cpu->num_wps = val;
> +}
> +
> +static void arm_cpu_get_num_bps(Object *obj, Visitor *v, const char *name,
> +                                void *opaque, Error **errp)
> +{
> +    uint8_t val;
> +    ARMCPU *cpu = ARM_CPU(obj);
> +
> +    val = cpu->num_bps;
> +    if (val == 0) {
> +        val = FIELD_EX64(cpu->isar.idregs[ID_AA64DFR0_EL1_IDX],
> +                         ID_AA64DFR0, BRPS) + 1;
> +    }
> +
> +    visit_type_uint8(v, name, &val, errp);
> +}
> +
> +static void arm_cpu_set_num_bps(Object *obj, Visitor *v, const char *name,
> +                                void *opaque, Error **errp)
> +{
> +    uint8_t val;
> +    ARMCPU *cpu = ARM_CPU(obj);
> +    uint8_t max_bps = FIELD_EX64(cpu->isar.idregs[ID_AA64DFR0_EL1_IDX],
> +                                 ID_AA64DFR0, BRPS) + 1;
> +
> +    if (!visit_type_uint8(v, name, &val, errp)) {
> +        return;
> +    }
> +
> +    if (val < 2 || val > max_bps) {
> +        error_setg(errp, "invalid number of breakpoints");
           ^^^^^

Code alignment issue here.

> +       return;
> +    }
> +
> +    cpu->num_bps = val;
> +}
> +
> +static void aarch64_add_kvm_writable_properties(Object *obj)
> +{
> +    object_property_add(obj, "num-breakpoints", "uint8", arm_cpu_get_num_bps,
> +                        arm_cpu_set_num_bps, NULL, NULL);
> +    object_property_add(obj, "num-watchpoints", "uint8", arm_cpu_get_num_wps,
> +                        arm_cpu_set_num_wps, NULL, NULL);
> +}
> +#endif /* CONFIG_KVM */
> +
>   void aarch64_cpu_lpa2_finalize(ARMCPU *cpu, Error **errp)
>   {
>       uint64_t t;
> @@ -807,6 +887,7 @@ void aarch64_host_initfn(Object *obj)
>       kvm_arm_set_cpreg_mig_tolerances(cpu);
>       kvm_arm_set_cpu_features_from_host(cpu);
>       aarch64_add_sve_properties(obj);
> +    aarch64_add_kvm_writable_properties(obj);
>   #elif defined(CONFIG_HVF)
>       hvf_arm_set_cpu_features_from_host(cpu);
>   #elif defined(CONFIG_WHPX)
> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index ca25b707a0a8..93686b038263 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -912,6 +912,56 @@ out:
>       return ret;
>   }
>   
> +#define KVM_REG_ARM_ID_AA64DFR0_EL1     ARM64_SYS_REG(3, 0, 0, 5, 0)
> +
> +static void kvm_arm_configure_aa64dfr0(ARMCPU *cpu)
> +{
> +    int ret;
> +    uint64_t val, newval;
> +    CPUState *cs = CPU(cpu);
> +
> +    if (!cpu->num_bps && !cpu->num_wps) {
> +        return;
> +    }
> +
> +    newval = cpu->isar.idregs[ID_AA64DFR0_EL1_IDX];
> +    if (cpu->num_bps) {
> +        uint64_t ctx_cmps = FIELD_EX64(newval, ID_AA64DFR0, CTX_CMPS);
> +
> +        /* CTX_CMPs is never greater than BRPs */
> +        ctx_cmps = MIN(ctx_cmps, cpu->num_bps - 1);
> +        newval = FIELD_DP64(newval, ID_AA64DFR0, BRPS, cpu->num_bps - 1);
> +        newval = FIELD_DP64(newval, ID_AA64DFR0, CTX_CMPS, ctx_cmps);
> +    }
> +    if (cpu->num_wps) {
> +        newval = FIELD_DP64(newval, ID_AA64DFR0, WRPS, cpu->num_wps - 1);
> +    }
> +    ret = kvm_set_one_reg(cs, KVM_REG_ARM_ID_AA64DFR0_EL1, &newval);
> +    if (ret) {
> +        error_report("Failed to set KVM_REG_ARM_ID_AA64DFR0_EL1");
> +        return;
> +    }
> +
> +    /*
> +     * Check if the write succeeded. KVM does offer the writable mask for this
> +     * register, but this way we also check if the value we wrote was sane.
> +     */
> +    ret = kvm_get_one_reg(cs, KVM_REG_ARM_ID_AA64DFR0_EL1, &val);
> +    if (ret) {
> +        error_report("Failed to get KVM_REG_ARM_ID_AA64DFR0_EL1");
> +        return;
> +    }
> +
> +    if (val != newval) {
> +        error_report("Failed to update KVM_REG_ARM_ID_AA64DFR0_EL1");
> +    }

These two checks could be combined since we needn't to know how the write has
been failing.

        if (ret || val != newval) {
            error_report("Failed to update KVM_REG_ARM_ID_AA64DFR0_EL1");
        }

> +}
> +
> +static void kvm_arm_configure_vcpu_regs(ARMCPU *cpu)
> +{
> +    kvm_arm_configure_aa64dfr0(cpu);
> +}
> +
>   /**
>    * kvm_arm_cpreg_level:
>    * @regidx: KVM register index
> @@ -1128,6 +1178,12 @@ void kvm_arm_reset_vcpu(ARMCPU *cpu)
>           fprintf(stderr, "kvm_arm_vcpu_init failed: %s\n", strerror(-ret));
>           abort();
>       }
> +
> +    /*
> +     * Before loading the KVM values into CPUState, update the KVM configuration
> +     */

Can be squeezed into one line:

        /* Update KVM state before it's loaded to CPUState */

> +    kvm_arm_configure_vcpu_regs(cpu);
> +

The newly added properties ("num-breakpoints", "num-watchpoints") are only needed by
RME-vCPUs, but they're also visible to the normal vCPUs. So do we need to bail without
adding the properties if RME isn't supported by the vCPUs in kvm_arm_configure_vcpu_regs() ?

>       if (!write_kvmstate_to_list(cpu)) {
>           fprintf(stderr, "write_kvmstate_to_list failed\n");
>           abort();

Thanks,
Gavin


