Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40A10CCA471
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 15:11:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4hPh-0005PK-1y; Fri, 03 Oct 2025 11:09:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1v4hPf-0005OG-2F
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 11:09:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1v4hPT-0007MP-4q
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 11:09:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759504155;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c64jOOmHvNHmP/nFOv5P6EtgvCTTXQlbtYsE958WDEk=;
 b=EF2VfgCLSQZmp9cOkg4cwy3FDc+bEuf9MYnD1bTOHEm4iFr6hJkPh959GMm5/dn6cjq8VO
 VChC/sXEI2Qs3WKpL+amjSL9bMMUvizYOvpusmzeq9bk4Ryh7MZGj71kZ4My6qVf0puxkf
 5ipvWG2+rt23T1Sqijg3RJhfIRxiKpE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-kV1iFNqMObyCeJqHuLw-oQ-1; Fri, 03 Oct 2025 11:09:13 -0400
X-MC-Unique: kV1iFNqMObyCeJqHuLw-oQ-1
X-Mimecast-MFC-AGG-ID: kV1iFNqMObyCeJqHuLw-oQ_1759504152
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3f42b54d159so2116070f8f.2
 for <qemu-devel@nongnu.org>; Fri, 03 Oct 2025 08:09:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759504152; x=1760108952;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c64jOOmHvNHmP/nFOv5P6EtgvCTTXQlbtYsE958WDEk=;
 b=op+Xn9mmtP25Y14mmd2yBEN6/TtvLBY/s9awplicnZ0RajKXXbhOq84Ctiu05vni9S
 jW14gB6a+PGDgeS9Y5y/ucJLrD5aonAHBoYTJDLtrxGmZ1LKmK4rq1MitFtOlj/g87K1
 rNth2V8ZbZnAPeCxyftLLlqn4ByDSbV0GjeNzDuYHDaMAN3SbXXfcCicbgMDewQoU46c
 1mmmHF3IkvyjusGtryFiesldZGJe+fYCRNNUAQsCmRvEkCo9r0TLa9bt8dGEXnIph56H
 wZDT1+nATQFItmcd1n1eaQhcJlU4lLRLvQux379F9+FG2lK2jPCDGtfQYPlPDfXsoNgG
 /8XA==
X-Gm-Message-State: AOJu0YzpfUoEPPficRC/92iNzj1SYSvSNI/uEzYqvVaQ0PcDmF4EPARo
 Y9WlIzWD8pCH3KTFVdB5zRtotXUtpmbFF73rKvXrw4JN+3jUFKKU2ssdj/tKFHuM151ZdPLnjcj
 Cpy2VP9MStgK8YsPuv8KBimel/mRB7V4ztBmDX7ZGpdcT2r5Qa+1LuXZL
X-Gm-Gg: ASbGncvVE6rkz6b70qsc/pNYvhvV6OEJ86pqJSUxlSupEb3wmO30GkhE5BIg263WtqN
 1Ac2PZKYUNDfqIuU18grit7hsZ3Dce5A6C/7vxaC7/h2VYjepIsSKWGbon7HyUuce9ntqahh91C
 ICVvehirhDiK8lh+CLUJ07lNOSuI8xUes9mTMXEAOC1qr4RdBxxiNLvDIq/sfe8+3aIyALzqlyf
 O7oUUI+MyTU8pAQkU9qDX5zzlt1tbJ95HFTN7SpDmRhxstv8wMT1EDyFBUdQMwaSNC2B0YBPIUk
 W7oNEgVc4z+PsKBRDaKW+4lmkV6cG8iSlhPk
X-Received: by 2002:a05:6000:4013:b0:425:58d0:4834 with SMTP id
 ffacd0b85a97d-425671948cfmr2184755f8f.39.1759504152084; 
 Fri, 03 Oct 2025 08:09:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZ2AOlAjHmEtDHHUxl7mhm3Emhq5V/ekmOgeaFFe3YcFfgeflSzKZqPg4x4jbZ+4RG9QQ3ug==
X-Received: by 2002:a05:6000:4013:b0:425:58d0:4834 with SMTP id
 ffacd0b85a97d-425671948cfmr2184729f8f.39.1759504151564; 
 Fri, 03 Oct 2025 08:09:11 -0700 (PDT)
Received: from fedora ([85.93.96.130]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e723593d8sm41594115e9.11.2025.10.03.08.09.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 08:09:11 -0700 (PDT)
Date: Fri, 3 Oct 2025 17:09:08 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: salil.mehta@opnsrc.net
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, mst@redhat.com,
 salil.mehta@huawei.com, maz@kernel.org, jean-philippe@linaro.org,
 jonathan.cameron@huawei.com, lpieralisi@kernel.org,
 peter.maydell@linaro.org, richard.henderson@linaro.org, armbru@redhat.com,
 andrew.jones@linux.dev, david@redhat.com, philmd@linaro.org,
 eric.auger@redhat.com, will@kernel.org, ardb@kernel.org,
 oliver.upton@linux.dev, pbonzini@redhat.com, gshan@redhat.com,
 rafael@kernel.org, borntraeger@linux.ibm.com, alex.bennee@linaro.org,
 gustavo.romero@linaro.org, npiggin@gmail.com, harshpb@linux.ibm.com,
 linux@armlinux.org.uk, darren@os.amperecomputing.com,
 ilkka@os.amperecomputing.com, vishnu@os.amperecomputing.com,
 gankulkarni@os.amperecomputing.com, karl.heubaum@oracle.com,
 miguel.luis@oracle.com, zhukeqian1@huawei.com, wangxiongfeng2@huawei.com,
 wangyanan55@huawei.com, wangzhou1@hisilicon.com, linuxarm@huawei.com,
 jiakernel2@gmail.com, maobibo@loongson.cn, lixianglai@loongson.cn,
 shahuang@redhat.com, zhao1.liu@intel.com
Subject: Re: [PATCH RFC V6 11/24] hw/arm/acpi: MADT change to size the guest
 with possible vCPUs
Message-ID: <20251003170908.48070061@fedora>
In-Reply-To: <20251001010127.3092631-12-salil.mehta@opnsrc.net>
References: <20251001010127.3092631-1-salil.mehta@opnsrc.net>
 <20251001010127.3092631-12-salil.mehta@opnsrc.net>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.467,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Wed,  1 Oct 2025 01:01:14 +0000
salil.mehta@opnsrc.net wrote:

> From: Salil Mehta <salil.mehta@huawei.com>
> 
> When QEMU builds the MADT table, modifications are needed to include information
> about possible vCPUs that are exposed as ACPI-disabled (i.e., `_STA.Enabled=0`).
> This new information will help the guest kernel pre-size its resources during
> boot time. Pre-sizing based on possible vCPUs will facilitate the future
> hot-plugging of the currently disabled vCPUs.
> 
> Additionally, this change addresses updates to the ACPI MADT GIC CPU interface
> flags, as introduced in the UEFI ACPI 6.5 specification [1]. These updates
> enable deferred virtual CPU onlining in the guest kernel.
> 
> Reference:
> [1] 5.2.12.14. GIC CPU Interface (GICC) Structure (Table 5.37 GICC CPU Interface Flags)
>     Link: https://uefi.org/specs/ACPI/6.5/05_ACPI_Software_Programming_Model.html#gic-cpu-interface-gicc-structure
> 
> Co-developed-by: Keqian Zhu <zhukeqian1@huawei.com>
> Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> ---
>  hw/arm/virt-acpi-build.c | 40 ++++++++++++++++++++++++++++++++++------
>  hw/core/machine.c        | 14 ++++++++++++++
>  include/hw/boards.h      | 20 ++++++++++++++++++++
>  3 files changed, 68 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index b01fc4f8ef..7c24dd6369 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -760,6 +760,32 @@ static void build_append_gicr(GArray *table_data, uint64_t base, uint32_t size)
>      build_append_int_noprefix(table_data, size, 4); /* Discovery Range Length */
>  }
>  
> +static uint32_t virt_acpi_get_gicc_flags(CPUState *cpu)
> +{
> +    MachineClass *mc = MACHINE_GET_CLASS(qdev_get_machine());
> +    const uint32_t GICC_FLAG_ENABLED = BIT(0);
> +    const uint32_t GICC_FLAG_ONLINE_CAPABLE = BIT(3);
> +
> +    /* ARM architecture does not support vCPU hotplug yet */
> +    if (!cpu) {
> +        return 0;
> +    }
> +
> +    /*
> +     * If the machine does not support online-capable CPUs, report the GICC as
> +     * 'enabled' only.
> +     */
> +    if (!mc->has_online_capable_cpus) {
> +        return GICC_FLAG_ENABLED;
> +    }
> +
> +    /*
> +     * ACPI 6.5, 5.2.12.14 (GICC): mark the boot CPU 'enabled' and all others
> +     * 'online-capable'.
> +     */
> +    return (cpu == first_cpu) ? GICC_FLAG_ENABLED : GICC_FLAG_ONLINE_CAPABLE;
> +}
> +
>  static void
>  build_madt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>  {
> @@ -785,12 +811,14 @@ build_madt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>      build_append_int_noprefix(table_data, vms->gic_version, 1);
>      build_append_int_noprefix(table_data, 0, 3);   /* Reserved */
>  
> -    for (i = 0; i < MACHINE(vms)->smp.cpus; i++) {
> -        ARMCPU *armcpu = ARM_CPU(qemu_get_cpu(i));
> +    for (i = 0; i < MACHINE(vms)->smp.max_cpus; i++) {
                                     ^^^^^^^^^^^^
> +        CPUState *cpu = machine_get_possible_cpu(i);
...
> +        CPUArchId *archid = machine_get_possible_cpu_arch_id(i);

what complexity above adds? /and then you say creating instantiating ARM VM
is slow./

I'd drop machine_get_possible_cpu/machine_get_possible_cpu_arch_id altogether
and mimic what acpi_build_madt() does.

> +        uint32_t flags = virt_acpi_get_gicc_flags(cpu);
> +        uint64_t mpidr = archid->arch_id;
>  
>          if (vms->gic_version == VIRT_GIC_VERSION_2) {
>              physical_base_address = memmap[VIRT_GIC_CPU].base;
> @@ -805,7 +833,7 @@ build_madt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>          build_append_int_noprefix(table_data, i, 4);    /* GIC ID */
>          build_append_int_noprefix(table_data, i, 4);    /* ACPI Processor UID */
>          /* Flags */
> -        build_append_int_noprefix(table_data, 1, 4);    /* Enabled */
> +        build_append_int_noprefix(table_data, flags, 4);
>          /* Parking Protocol Version */
>          build_append_int_noprefix(table_data, 0, 4);
>          /* Performance Interrupt GSIV */
> @@ -819,7 +847,7 @@ build_madt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>          build_append_int_noprefix(table_data, vgic_interrupt, 4);
>          build_append_int_noprefix(table_data, 0, 8);    /* GICR Base Address*/
>          /* MPIDR */
> -        build_append_int_noprefix(table_data, arm_cpu_mp_affinity(armcpu), 8);
> +        build_append_int_noprefix(table_data, mpidr, 8);
>          /* Processor Power Efficiency Class */
>          build_append_int_noprefix(table_data, 0, 1);
>          /* Reserved */
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 69d5632464..65388d859a 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -1383,6 +1383,20 @@ CPUState *machine_get_possible_cpu(int64_t cpu_index)
>      return NULL;
>  }
>  
> +CPUArchId *machine_get_possible_cpu_arch_id(int64_t cpu_index)
> +{
> +    MachineState *ms = MACHINE(qdev_get_machine());
> +    CPUArchIdList *possible_cpus = ms->possible_cpus;
> +
> +    for (int i = 0; i < possible_cpus->len; i++) {
> +        if (possible_cpus->cpus[i].cpu &&
> +            possible_cpus->cpus[i].cpu->cpu_index == cpu_index) {
> +            return &possible_cpus->cpus[i];
> +        }
> +    }
> +    return NULL;
> +}
> +
>  static char *cpu_slot_to_string(const CPUArchId *cpu)
>  {
>      GString *s = g_string_new(NULL);
> diff --git a/include/hw/boards.h b/include/hw/boards.h
> index 3ff77a8b3a..fe51ca58bf 100644
> --- a/include/hw/boards.h
> +++ b/include/hw/boards.h
> @@ -461,6 +461,26 @@ struct MachineState {
>      bool acpi_spcr_enabled;
>  };
>  
> +/*
> + * machine_get_possible_cpu_arch_id:
> + * @cpu_index: logical cpu_index to search for
> + *
> + * Return a pointer to the CPUArchId entry matching the given @cpu_index
> + * in the current machine's MachineState. The possible_cpus array holds
> + * the full set of CPUs that the machine could support, including those
> + * that may be created as disabled or taken offline.
> + *
> + * The slot index in ms->possible_cpus[] is always sequential, but the
> + * logical cpu_index values are assigned by QEMU and may or may not be
> + * sequential depending on the implementation of a particular machine.
> + * Direct indexing by cpu_index is therefore unsafe in general. This
> + * helper performs a linear search of the possible_cpus array to find
> + * the matching entry.
> + *
> + * Returns: pointer to the matching CPUArchId, or NULL if not found.
> + */
> +CPUArchId *machine_get_possible_cpu_arch_id(int64_t cpu_index);
> +
>  /*
>   * The macros which follow are intended to facilitate the
>   * definition of versioned machine types, using a somewhat


