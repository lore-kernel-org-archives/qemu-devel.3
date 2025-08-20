Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF13CCA0EDC
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Aug 2025 06:56:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uocjZ-00087q-Sz; Wed, 20 Aug 2025 02:55:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uocjW-00087O-Mm
 for qemu-devel@nongnu.org; Wed, 20 Aug 2025 02:55:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uocjU-0006TY-7z
 for qemu-devel@nongnu.org; Wed, 20 Aug 2025 02:55:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755672938;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=VAzSEjMqPvW+GIMy73ZFmml1pe0sByp73PgGZQG5KzA=;
 b=QbGdZJD6byKwHrqqEA3IBxbl8zPsf/LQqO0Y6VMuyH/N0aN4GSSycAPJpgpNOrKCUsHrUE
 O6RQFmV2LGqhotT9GLoDug4wb0txOglWJxJRNpBaIWSU5eLAIk/ZcnBMLuksu0hvHU65sd
 GqzpV0jssQ6MWef6dOzSbhvWFBP0hlo=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-340-u2a6yOJCPUCPnG3cpxVf_A-1; Wed, 20 Aug 2025 02:55:37 -0400
X-MC-Unique: u2a6yOJCPUCPnG3cpxVf_A-1
X-Mimecast-MFC-AGG-ID: u2a6yOJCPUCPnG3cpxVf_A_1755672936
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7e864817cb8so203819285a.0
 for <qemu-devel@nongnu.org>; Tue, 19 Aug 2025 23:55:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755672936; x=1756277736;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VAzSEjMqPvW+GIMy73ZFmml1pe0sByp73PgGZQG5KzA=;
 b=utOTc74FuSmjbxdoS4OFubUa6KY4F+lNNoZh+QHxqv/Yw5I6M/rxQbPX4dGG6vquAN
 8K7K/ysz7uggQF7WNHoNTWtIjmyVwKWNDIN8ESsqHDl7i4Oi0GtteKDywVMhKmLA8bRN
 0eLrG6XKBra+Um+2HJbrZKxIlruA9NaWMgSTe/H32t8APSo/f7VL765YwlYuowQyZ8Dh
 TCBdHR6559jgeSotfon2LhJZiA3aOzVeWaGCTeNKlssokVUBOqf9UA4gPk93o7L0+2M4
 yCgaSKVmYWg++7zM6t53+MV0Ir5mDM/bShrG8ekjh8b09uKlUjlZfTL2blJbTfpFwC9S
 vsaA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUmh42hk4lyexDrcJeDjrmmjnyHKfjxgRyNQI1iBYklv8Wjtw4jdtFp3cPf7nXbT63ocCsnb5PMj0FB@nongnu.org
X-Gm-Message-State: AOJu0Yx4fJipUSzFtClFTzh49yA7GPD/caZ+18yHjNhWdCiVYa4wyr6L
 kfmcS5ycraYZFPC9df/Lehp2mEkAgfKQsFXIZWeAgBZYmVxRHT8hHQKwMAYtZS6jFL1t+O2vjP5
 IJ3hZmBvyV1VEf/bhkHnimrESvkOeI7E6hCuvgAdN0NmjXvow+yjYwrt+
X-Gm-Gg: ASbGncvGyMf5o1Pq1Si09iFLa9+0dWp44p8kEHtSJFFHkvHhOtIHvI5e3tqby3tY3eD
 ZmmCehFClHTvYEpuYlxmHXW8r8Njk/NQG5hHL7wyqeB0WJTVo70UoojHHRTtlT3MU4YKP+m4zcI
 u8lvHQoMacDReMmfgcc1kpJHO4BzwCA1AIEv6Zc3sYwBN1eJHZNiWrfw4dPDc0rHYsFnPZLI0V5
 ePD6Gvdims92pSCi01s0C2DzFXsM/jYXlx/Icn0n4rohKing94NqCsyXm2zPcHBRad8eJhsxDA+
 htf5HOSqwTlGtiiupw5oXt8DiWqCZDWfvbJdYjWO8IedoydaeVvc765ufDR1PJpLSBuMkseHbZO
 2+pU=
X-Received: by 2002:ad4:576d:0:b0:70b:ab14:d827 with SMTP id
 6a1803df08f44-70c5a59d675mr52148286d6.7.1755672936530; 
 Tue, 19 Aug 2025 23:55:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMz31xYK67qkznKSNGSDiF2iRjRWfPqgIR3kjEa08b1WxzcRhnTPT1INR4agLs5ey22adn9g==
X-Received: by 2002:ad4:576d:0:b0:70b:ab14:d827 with SMTP id
 6a1803df08f44-70c5a59d675mr52148156d6.7.1755672935992; 
 Tue, 19 Aug 2025 23:55:35 -0700 (PDT)
Received: from [192.168.0.6] (ltea-047-064-112-073.pools.arcor-ip.net.
 [47.64.112.73]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-70ba9077520sm82492986d6.21.2025.08.19.23.55.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Aug 2025 23:55:35 -0700 (PDT)
Message-ID: <2556e0cf-ccca-4ac1-8be5-a18163f860d4@redhat.com>
Date: Wed, 20 Aug 2025 08:55:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] target/ppc: Fix env->quiesced migration
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Fabian Vogt <fvogt@suse.de>,
 Peter Xu <peterx@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Chinmay Rath <rathc@linux.ibm.com>
References: <20250819223905.2247-1-farosas@suse.de>
 <20250819223905.2247-5-farosas@suse.de>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250819223905.2247-5-farosas@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 20/08/2025 00.39, Fabiano Rosas wrote:
> The commit referenced (from QEMU 10.0) has changed the way the pseries
> machine marks a cpu as quiesced. Previously, the cpu->halted value
> from QEMU common cpu code was (incorrectly) used. With the fix, the
> env->quiesced variable starts being used, which improves on the
> original situation, but also causes a side effect after migration:
> 
> The env->quiesced is set at reset and never migrated, which causes the
> destination QEMU to stop delivering interrupts and hang the machine.
> 
> To fix the issue from this point on, start migrating the env->quiesced
> value.
> 
> For QEMU versions < 10.0, sending the new element on the stream would
> cause migration to be aborted, so add the appropriate compatibility
> property to omit the new subsection.
> 
> Independently of this patch, all migrations from QEMU versions < 10.0
> will result in a hang since the older QEMU never migrates
> env->quiesced. This is bad because it leaves machines already running
> on the old QEMU without a migration path into newer versions.
> 
> As a workaround, clear env->quiesced in the new QEMU whenever
> cpu->halted is also clear. This assumes rtas_stop_self() always sets
> both flags at the same time. Migrations during secondaries bringup
> (i.e. before rtas-start-cpu) will still cause a hang, but those are
> early enough that requiring reboot would not be unreasonable.
> 
> Note that this was tested with -cpu power9 and -machine ic-mode=xive
> due to another bug affecting migration of XICS guests. Tested both
> forward and backward migration and savevm/loadvm from 9.2 and 10.0.
> 
> Reported-by: Fabian Vogt <fvogt@suse.de>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3079
> Fixes: fb802acdc8b ("ppc/spapr: Fix RTAS stopped state")
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
> The choice of PowerPCCPU to hold the compat property is dubious. This
> only affects pseries, but it seems like a layering violation to access
> SpaprMachine from target/ppc/, suggestions welcome.
> ---
>   hw/core/machine.c     |  1 +
>   target/ppc/cpu.h      |  1 +
>   target/ppc/cpu_init.c |  7 +++++++
>   target/ppc/machine.c  | 40 ++++++++++++++++++++++++++++++++++++++++
>   4 files changed, 49 insertions(+)
> 
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index bd47527479..ea83c0876b 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -42,6 +42,7 @@ GlobalProperty hw_compat_10_0[] = {
>       { "vfio-pci", "x-migration-load-config-after-iter", "off" },
>       { "ramfb", "use-legacy-x86-rom", "true"},
>       { "vfio-pci-nohotplug", "use-legacy-x86-rom", "true" },
> +    { "powerpc64-cpu", "rtas-stopped-state", "false" },

This is specific to ppc, so it should not go into the generic hw_compat_* array.

Please define a spapr_compat_10_0 array in 
spapr_machine_10_0_class_options() and do another compat_props_add() for 
that array there. (Similar to what is done for TYPE_SPAPR_PCI_HOST_BRIDGE in
spapr_machine_5_0_class_options() for example)

  Thanks,
   Thomas


>   };
>   const size_t hw_compat_10_0_len = G_N_ELEMENTS(hw_compat_10_0);
>   
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index 6b90543811..8ff453024b 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -1470,6 +1470,7 @@ struct ArchCPU {
>       void *machine_data;
>       int32_t node_id; /* NUMA node this CPU belongs to */
>       PPCHash64Options *hash64_opts;
> +    bool rtas_stopped_state;
>   
>       /* Those resources are used only during code translation */
>       /* opcode handlers */
> diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
> index a0e77f2673..4380c6eb14 100644
> --- a/target/ppc/cpu_init.c
> +++ b/target/ppc/cpu_init.c
> @@ -55,6 +55,11 @@
>   /* #define PPC_DEBUG_SPR */
>   /* #define USE_APPLE_GDB */
>   
> +static const Property powerpc_cpu_properties[] = {
> +    DEFINE_PROP_BOOL("rtas-stopped-state", PowerPCCPU,
> +                      rtas_stopped_state, true),
> +};
> +
>   static inline void vscr_init(CPUPPCState *env, uint32_t val)
>   {
>       /* Altivec always uses round-to-nearest */
> @@ -7525,6 +7530,8 @@ static void ppc_cpu_class_init(ObjectClass *oc, const void *data)
>                                         &pcc->parent_unrealize);
>       pcc->pvr_match = ppc_pvr_match_default;
>   
> +    device_class_set_props(dc, powerpc_cpu_properties);
> +
>       resettable_class_set_parent_phases(rc, NULL, ppc_cpu_reset_hold, NULL,
>                                          &pcc->parent_phases);
>   
> diff --git a/target/ppc/machine.c b/target/ppc/machine.c
> index d72e5ecb94..8797233ebe 100644
> --- a/target/ppc/machine.c
> +++ b/target/ppc/machine.c
> @@ -257,6 +257,23 @@ static int cpu_post_load(void *opaque, int version_id)
>           ppc_store_sdr1(env, env->spr[SPR_SDR1]);
>       }
>   
> +    if (!cpu->rtas_stopped_state) {
> +        /*
> +         * The source QEMU doesn't have fb802acdc8 and still uses halt
> +         * + PM bits in LPCR to implement RTAS stopped state. The new
> +         * QEMU will have put the newly created vcpus in that state,
> +         * waiting for the start-cpu RTAS call. Clear the quiesced
> +         * flag if possible, otherwise the newly-loaded machine will
> +         * hang indefinitely due to quiesced state ignoring
> +         * interrupts.
> +         */
> +
> +        if (!CPU(cpu)->halted) {
> +            /* not halted, so definitely not in RTAS stopped state */
> +            env->quiesced = 0;
> +        }
> +    }
> +
>       post_load_update_msr(env);
>   
>       if (tcg_enabled()) {
> @@ -649,6 +666,28 @@ static const VMStateDescription vmstate_reservation = {
>       }
>   };
>   
> +static bool rtas_stopped_needed(void *opaque)
> +{
> +    PowerPCCPU *cpu = opaque;
> +
> +    return cpu->rtas_stopped_state && !cpu->env.quiesced;
> +}
> +
> +static const VMStateDescription vmstate_rtas_stopped = {
> +    .name = "cpu/rtas_stopped",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .needed = rtas_stopped_needed,
> +    .fields = (const VMStateField[]) {
> +        /*
> +         * "RTAS stopped" state, independent of halted state. For QEMU
> +         * < 10.0, this is taken from cpu->halted at cpu_post_load()
> +         */
> +        VMSTATE_BOOL(env.quiesced, PowerPCCPU),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
>   #ifdef TARGET_PPC64
>   static bool bhrb_needed(void *opaque)
>   {
> @@ -715,6 +754,7 @@ const VMStateDescription vmstate_ppc_cpu = {
>           &vmstate_tlbmas,
>           &vmstate_compat,
>           &vmstate_reservation,
> +        &vmstate_rtas_stopped,
>           NULL
>       }
>   };


