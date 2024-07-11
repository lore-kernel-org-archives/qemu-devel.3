Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02840C3DA41
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 08:44:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRpPS-0005fH-SY; Thu, 11 Jul 2024 04:44:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sRpPQ-0005Xa-Ts
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 04:44:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sRpPF-0001tl-In
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 04:44:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720687440;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K9pNOhrcv49OC+PDpS8ZrT+a4V155JC6VCgLRDsCXT8=;
 b=UlOwQ/vpTnVZ9gvZV9VOIc8WS6knQMIpCFNYVjwa10MD61sOw1/Y9/HZ7kLmHDmAEaSINF
 J9TB00wmbg5RJf8+tx0Sh+nl4LTjl691E2OSPYc7sd/BS1bpBz4MJ4I1uex70je82YUvZX
 BT6XFDxJHBUXYgFCUVAfVt112HjPZU0=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-367-4f6mFS7APn61S5jLrJtawg-1; Thu,
 11 Jul 2024 04:43:57 -0400
X-MC-Unique: 4f6mFS7APn61S5jLrJtawg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 31179195419C; Thu, 11 Jul 2024 08:43:56 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.51])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A5C841955F3B; Thu, 11 Jul 2024 08:43:50 +0000 (UTC)
Date: Thu, 11 Jul 2024 09:43:46 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, philmd@linaro.org,
 mst@redhat.com, wangyanan55@huawei.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, anisinha@redhat.com, qemu-arm@nongnu.org
Subject: Re: [PATCH] smbios: make memory device size configurable per Machine
Message-ID: <Zo-bQgQVSgZw8J1A@redhat.com>
References: <20240711074822.3384344-1-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240711074822.3384344-1-imammedo@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, Jul 11, 2024 at 09:48:22AM +0200, Igor Mammedov wrote:
> Currently SMBIOS maximum memory device chunk is capped at 16Gb,
> which is fine for the most cases (QEMU uses it to describe initial
> RAM (type 17 SMBIOS table entries)).
> However when starting guest with terabytes of RAM this leads to
> too many memory device structures, which eventually upsets linux
> kernel as it reserves only 64K for these entries and when that
> border is crossed out it runs out of reserved memory.
> 
> Instead of partitioning initial RAM on 16Gb chunks, use maximum
> possible chunk size that SMBIOS spec allows[1]. Which lets
> encode RAM in Mb units in uint32_t-1 field (upto 2047Tb).
> As result initial RAM will generate only one type 17 structure
> until host/guest reach ability to use more RAM in the future.
> 
> Compat changes:
> We can't unconditionally change chunk size as it will break
> QEMU<->guest ABI (and migration). Thus introduce a new machine class
> field that would let older versioned machines to use 16Gb chunks
> while new machine type could use maximum possible chunk size.
> 
> While it might seem to be risky to rise max entry size this much
> (much beyond of what current physical RAM modules support),
> I'd not expect it causing much issues, modulo uncovering bugs
> in software running within guest. And those should be fixed
> on guest side to handle SMBIOS spec properly, especially if
> guest is expected to support so huge RAM configs.
> In worst case, QEMU can reduce chunk size later if we would
> care enough about introducing a workaround for some 'unfixable'
> guest OS, either by fixing up the next machine type or
> giving users a CLI option to customize it.

I was wondering what real hardware does, since the best way to
avoid guest OS surprises is to align with real world behaviour.
IIUC, there is usually one Type 17 structure per physical
DIMM.

Most QEMU configs don't express DIMMs as a concept so in that
case, we can presume 1 virtual DIMM, and thus having one type
17 structure is a match for physical hw practices.

What about when the QEMU config has used nvdimm, pc-dimm,
or virtio-mem devices though ? It feels like the best practice
would be to have a type 17 structure for each instance of one
of those devices.

> 
> 1) SMBIOS 3.1.0 7.18.5 Memory Device — Extended Size
> 
> PS:
> * tested on 8Tb host with RHEL6 guest, which seems to parse
>   type 17 SMBIOS table entries correctly (according to 'dmidecode').
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  include/hw/boards.h |  4 ++++
>  hw/arm/virt.c       |  1 +
>  hw/core/machine.c   |  1 +
>  hw/i386/pc_piix.c   |  1 +
>  hw/i386/pc_q35.c    |  1 +
>  hw/smbios/smbios.c  | 11 ++++++-----
>  6 files changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/include/hw/boards.h b/include/hw/boards.h
> index ef6f18f2c1..48ff6d8b93 100644
> --- a/include/hw/boards.h
> +++ b/include/hw/boards.h
> @@ -237,6 +237,9 @@ typedef struct {
>   *    purposes only.
>   *    Applies only to default memory backend, i.e., explicit memory backend
>   *    wasn't used.
> + * @smbios_memory_device_size:
> + *    Default size of memory device,
> + *    SMBIOS 3.1.0 "7.18 Memory Device (Type 17)"
>   */
>  struct MachineClass {
>      /*< private >*/
> @@ -304,6 +307,7 @@ struct MachineClass {
>      const CPUArchIdList *(*possible_cpu_arch_ids)(MachineState *machine);
>      int64_t (*get_default_cpu_node_id)(const MachineState *ms, int idx);
>      ram_addr_t (*fixup_ram_size)(ram_addr_t size);
> +    uint64_t smbios_memory_device_size;
>  };
>  
>  /**
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index b0c68d66a3..719e83e6a1 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -3308,6 +3308,7 @@ DEFINE_VIRT_MACHINE_AS_LATEST(9, 1)
>  static void virt_machine_9_0_options(MachineClass *mc)
>  {
>      virt_machine_9_1_options(mc);
> +    mc->smbios_memory_device_size = 16 * GiB;
>      compat_props_add(mc->compat_props, hw_compat_9_0, hw_compat_9_0_len);
>  }
>  DEFINE_VIRT_MACHINE(9, 0)
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index bc38cad7f2..3cfdaec65d 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -1004,6 +1004,7 @@ static void machine_class_init(ObjectClass *oc, void *data)
>      /* Default 128 MB as guest ram size */
>      mc->default_ram_size = 128 * MiB;
>      mc->rom_file_has_mr = true;
> +    mc->smbios_memory_device_size = 2047 * TiB;
>  
>      /* numa node memory size aligned on 8MB by default.
>       * On Linux, each node's border has to be 8MB aligned
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index 9445b07b4f..d9e69243b4 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -495,6 +495,7 @@ static void pc_i440fx_machine_9_0_options(MachineClass *m)
>      pc_i440fx_machine_9_1_options(m);
>      m->alias = NULL;
>      m->is_default = false;
> +    m->smbios_memory_device_size = 16 * GiB;
>  
>      compat_props_add(m->compat_props, hw_compat_9_0, hw_compat_9_0_len);
>      compat_props_add(m->compat_props, pc_compat_9_0, pc_compat_9_0_len);
> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> index 71d3c6d122..9d108b194e 100644
> --- a/hw/i386/pc_q35.c
> +++ b/hw/i386/pc_q35.c
> @@ -374,6 +374,7 @@ static void pc_q35_machine_9_0_options(MachineClass *m)
>      PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
>      pc_q35_machine_9_1_options(m);
>      m->alias = NULL;
> +    m->smbios_memory_device_size = 16 * GiB;
>      compat_props_add(m->compat_props, hw_compat_9_0, hw_compat_9_0_len);
>      compat_props_add(m->compat_props, pc_compat_9_0, pc_compat_9_0_len);
>      pcmc->isa_bios_alias = false;
> diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
> index 3b7703489d..a394514264 100644
> --- a/hw/smbios/smbios.c
> +++ b/hw/smbios/smbios.c
> @@ -1093,6 +1093,7 @@ static bool smbios_get_tables_ep(MachineState *ms,
>                         Error **errp)
>  {
>      unsigned i, dimm_cnt, offset;
> +    MachineClass *mc = MACHINE_GET_CLASS(ms);
>      ERRP_GUARD();
>  
>      assert(ep_type == SMBIOS_ENTRY_POINT_TYPE_32 ||
> @@ -1123,12 +1124,12 @@ static bool smbios_get_tables_ep(MachineState *ms,
>      smbios_build_type_9_table(errp);
>      smbios_build_type_11_table();
>  
> -#define MAX_DIMM_SZ (16 * GiB)
> -#define GET_DIMM_SZ ((i < dimm_cnt - 1) ? MAX_DIMM_SZ \
> -                                        : ((current_machine->ram_size - 1) % MAX_DIMM_SZ) + 1)
> +#define GET_DIMM_SZ ((i < dimm_cnt - 1) ? mc->smbios_memory_device_size \
> +    : ((current_machine->ram_size - 1) % mc->smbios_memory_device_size) + 1)
>  
> -    dimm_cnt = QEMU_ALIGN_UP(current_machine->ram_size, MAX_DIMM_SZ) /
> -               MAX_DIMM_SZ;
> +    dimm_cnt = QEMU_ALIGN_UP(current_machine->ram_size,
> +                             mc->smbios_memory_device_size) /
> +               mc->smbios_memory_device_size;
>  
>      /*
>       * The offset determines if we need to keep additional space between
> -- 
> 2.43.0
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


