Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83FE1CA0FED
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 11:30:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urELj-0006n4-9a; Wed, 27 Aug 2025 07:29:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1urELd-0006iI-7M
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 07:29:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1urELZ-00032f-QA
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 07:29:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756294183;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=6IvKTOxaXmZP8SRLB+yLehxCE1xusVRG9vRhO9nD5Yc=;
 b=BueZ7MxvS10q75X1jjoSZfgqtP3rE5ClIpruWpr/2Yyg5oB2mUwv+BgTdCol4BJU1hSj7J
 QgWh6HlYBfEc8ds8cjuPqifyy4EgX002qUSAorIyl0n8EySiJ8T+6AkeQXnKCj/UAvepK4
 JiDY7BvU8txg05AOdl6Q5sHV2GoxS8o=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-617-n8Rvlp3fMdexeOTYTkqJpQ-1; Wed,
 27 Aug 2025 07:29:39 -0400
X-MC-Unique: n8Rvlp3fMdexeOTYTkqJpQ-1
X-Mimecast-MFC-AGG-ID: n8Rvlp3fMdexeOTYTkqJpQ_1756294178
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5958A180035C; Wed, 27 Aug 2025 11:29:37 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.195])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D238D180028A; Wed, 27 Aug 2025 11:29:28 +0000 (UTC)
Date: Wed, 27 Aug 2025 12:29:25 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Magnus Kulke <magnuskulke@linux.microsoft.com>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Magnus Kulke <magnus.kulke@linux.microsoft.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Magnus Kulke <magnus.kulke@microsoft.com>,
 Cornelia Huck <cohuck@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Thomas Huth <thuth@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Cameron Esfahani <dirty@apple.com>, Wei Liu <wei.liu@kernel.org>,
 Wei Liu <liuwe@microsoft.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v3 18/26] target/i386/mshv: Register CPUID entries with
 MSHV
Message-ID: <aK7sFds3tf5fMToM@redhat.com>
References: <20250807143951.1154713-1-magnuskulke@linux.microsoft.com>
 <20250807143951.1154713-19-magnuskulke@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250807143951.1154713-19-magnuskulke@linux.microsoft.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Aug 07, 2025 at 04:39:43PM +0200, Magnus Kulke wrote:
> Convert the guest CPU's CPUID model into MSHV's format and register it
> with the hypervisor. This ensures that the guest observes the correct
> CPU feature set during CPUID instructions.

QEMU supports a variety of CPU models. '-cpu host' is intended to
expose every possible feature that the underlying hypervisor can
support, while '-cpu $NAME' exposes certain named CPU models.

Also KVM will force enable certain features that it can either
unconditionally emulate, or requires to always be present.

Are you aware if there any noteworthy differences /  restrictions
in the use of CPU models for MSHV that would not be present for
KVM, or vica-verca ?  I'm particularly wondering if there is
anything special libvirt needs to be aware of - most of what
libvirt does it gets via the QMP query-cpu-XXXX commands.

> 
> Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
> ---
>  target/i386/mshv/mshv-cpu.c | 199 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 199 insertions(+)
> 
> diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
> index c233d4af70..0b7350877d 100644
> --- a/target/i386/mshv/mshv-cpu.c
> +++ b/target/i386/mshv/mshv-cpu.c
> @@ -324,6 +324,199 @@ int mshv_load_regs(CPUState *cpu)
>      return 0;
>  }
>  
> +static void add_cpuid_entry(GList *cpuid_entries,
> +                            uint32_t function, uint32_t index,
> +                            uint32_t eax, uint32_t ebx,
> +                            uint32_t ecx, uint32_t edx)
> +{
> +    struct hv_cpuid_entry *entry;
> +
> +    entry = g_malloc0(sizeof(struct hv_cpuid_entry));
> +    entry->function = function;
> +    entry->index = index;
> +    entry->eax = eax;
> +    entry->ebx = ebx;
> +    entry->ecx = ecx;
> +    entry->edx = edx;
> +
> +    cpuid_entries = g_list_append(cpuid_entries, entry);
> +}
> +
> +static void collect_cpuid_entries(const CPUState *cpu, GList *cpuid_entries)
> +{
> +    X86CPU *x86_cpu = X86_CPU(cpu);
> +    CPUX86State *env = &x86_cpu->env;
> +    uint32_t eax, ebx, ecx, edx;
> +    uint32_t leaf, subleaf;
> +    size_t max_leaf = 0x1F;
> +    size_t max_subleaf = 0x20;
> +
> +    uint32_t leaves_with_subleaves[] = {0x4, 0x7, 0xD, 0xF, 0x10};
> +    int n_subleaf_leaves = ARRAY_SIZE(leaves_with_subleaves);
> +
> +    /* Regular leaves without subleaves */
> +    for (leaf = 0; leaf <= max_leaf; leaf++) {
> +        bool has_subleaves = false;
> +        for (int i = 0; i < n_subleaf_leaves; i++) {
> +            if (leaf == leaves_with_subleaves[i]) {
> +                has_subleaves = true;
> +                break;
> +            }
> +        }
> +
> +        if (!has_subleaves) {
> +            cpu_x86_cpuid(env, leaf, 0, &eax, &ebx, &ecx, &edx);
> +            if (eax == 0 && ebx == 0 && ecx == 0 && edx == 0) {
> +                /* all zeroes indicates no more leaves */
> +                continue;
> +            }
> +
> +            add_cpuid_entry(cpuid_entries, leaf, 0, eax, ebx, ecx, edx);
> +            continue;
> +        }
> +
> +        subleaf = 0;
> +        while (subleaf < max_subleaf) {
> +            cpu_x86_cpuid(env, leaf, subleaf, &eax, &ebx, &ecx, &edx);
> +
> +            if (eax == 0 && ebx == 0 && ecx == 0 && edx == 0) {
> +                /* all zeroes indicates no more leaves */
> +                break;
> +            }
> +            add_cpuid_entry(cpuid_entries, leaf, 0, eax, ebx, ecx, edx);
> +            subleaf++;
> +        }
> +    }
> +}
> +
> +static int register_intercept_result_cpuid_entry(int cpu_fd,
> +                                                 uint8_t subleaf_specific,
> +                                                 uint8_t always_override,
> +                                                 struct hv_cpuid_entry *entry)
> +{
> +    struct hv_register_x64_cpuid_result_parameters cpuid_params = {
> +        .input.eax = entry->function,
> +        .input.ecx = entry->index,
> +        .input.subleaf_specific = subleaf_specific,
> +        .input.always_override = always_override,
> +        .input.padding = 0,
> +        /*
> +         * With regard to masks - these are to specify bits to be overwritten
> +         * The current CpuidEntry structure wouldn't allow to carry the masks
> +         * in addition to the actual register values. For this reason, the
> +         * masks are set to the exact values of the corresponding register bits
> +         * to be registered for an overwrite. To view resulting values the
> +         * hypervisor would return, HvCallGetVpCpuidValues hypercall can be
> +         * used.
> +         */
> +        .result.eax = entry->eax,
> +        .result.eax_mask = entry->eax,
> +        .result.ebx = entry->ebx,
> +        .result.ebx_mask = entry->ebx,
> +        .result.ecx = entry->ecx,
> +        .result.ecx_mask = entry->ecx,
> +        .result.edx = entry->edx,
> +        .result.edx_mask = entry->edx,
> +    };
> +    union hv_register_intercept_result_parameters parameters = {
> +        .cpuid = cpuid_params,
> +    };
> +    struct mshv_register_intercept_result args = {
> +        .intercept_type = HV_INTERCEPT_TYPE_X64_CPUID,
> +        .parameters = parameters,
> +    };
> +    int ret;
> +
> +    ret = ioctl(cpu_fd, MSHV_VP_REGISTER_INTERCEPT_RESULT, &args);
> +    if (ret < 0) {
> +        error_report("failed to register intercept result for cpuid: %s",
> +                     strerror(errno));
> +        return -1;
> +    }
> +
> +    return 0;
> +}
> +
> +static int register_intercept_result_cpuid(int cpu_fd, struct hv_cpuid *cpuid)
> +{
> +    int ret = 0, entry_ret;
> +    struct hv_cpuid_entry *entry;
> +    uint8_t subleaf_specific, always_override;
> +
> +    for (size_t i = 0; i < cpuid->nent; i++) {
> +        entry = &cpuid->entries[i];
> +
> +        /* set defaults */
> +        subleaf_specific = 0;
> +        always_override = 1;
> +
> +        /* Intel */
> +        /* 0xb - Extended Topology Enumeration Leaf */
> +        /* 0x1f - V2 Extended Topology Enumeration Leaf */
> +        /* AMD */
> +        /* 0x8000_001e - Processor Topology Information */
> +        /* 0x8000_0026 - Extended CPU Topology */
> +        if (entry->function == 0xb
> +            || entry->function == 0x1f
> +            || entry->function == 0x8000001e
> +            || entry->function == 0x80000026) {
> +            subleaf_specific = 1;
> +            always_override = 1;
> +        } else if (entry->function == 0x00000001
> +            || entry->function == 0x80000000
> +            || entry->function == 0x80000001
> +            || entry->function == 0x80000008) {
> +            subleaf_specific = 0;
> +            always_override = 1;
> +        }
> +
> +        entry_ret = register_intercept_result_cpuid_entry(cpu_fd,
> +                                                          subleaf_specific,
> +                                                          always_override,
> +                                                          entry);
> +        if ((entry_ret < 0) && (ret == 0)) {
> +            ret = entry_ret;
> +        }
> +    }
> +
> +    return ret;
> +}
> +
> +static int set_cpuid2(const CPUState *cpu)
> +{
> +    int ret;
> +    size_t n_entries, cpuid_size;
> +    struct hv_cpuid *cpuid;
> +    struct hv_cpuid_entry *entry;
> +    GList *entries = NULL;
> +    int cpu_fd = mshv_vcpufd(cpu);
> +
> +    collect_cpuid_entries(cpu, entries);
> +    n_entries = g_list_length(entries);
> +
> +    cpuid_size = sizeof(struct hv_cpuid)
> +        + n_entries * sizeof(struct hv_cpuid_entry);
> +
> +    cpuid = g_malloc0(cpuid_size);
> +    cpuid->nent = n_entries;
> +    cpuid->padding = 0;
> +
> +    for (size_t i = 0; i < n_entries; i++) {
> +        entry = g_list_nth_data(entries, i);
> +        cpuid->entries[i] = *entry;
> +        g_free(entry);
> +    }
> +    g_list_free(entries);
> +
> +    ret = register_intercept_result_cpuid(cpu_fd, cpuid);
> +    g_free(cpuid);
> +    if (ret < 0) {
> +        return ret;
> +    }
> +
> +    return 0;
> +}
> +
>  static inline void populate_hv_segment_reg(SegmentCache *seg,
>                                             hv_x64_segment_register *hv_reg)
>  {
> @@ -608,6 +801,12 @@ int mshv_configure_vcpu(const CPUState *cpu, const struct MshvFPU *fpu,
>      int ret;
>      int cpu_fd = mshv_vcpufd(cpu);
>  
> +    ret = set_cpuid2(cpu);
> +    if (ret < 0) {
> +        error_report("failed to set cpuid");
> +        return -1;
> +    }
> +
>      ret = set_cpu_state(cpu, fpu, xcr0);
>      if (ret < 0) {
>          error_report("failed to set cpu state");
> -- 
> 2.34.1
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


