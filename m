Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD068D3B7EA
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Dec 2025 17:00:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vSead-0008Ms-V6; Mon, 08 Dec 2025 12:00:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1vSeac-0008Mb-C7
 for qemu-devel@nongnu.org; Mon, 08 Dec 2025 11:59:58 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1vSeaZ-00085Z-BT
 for qemu-devel@nongnu.org; Mon, 08 Dec 2025 11:59:58 -0500
Received: from mail.maildlp.com (unknown [172.18.224.107])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dQ7Sh2SBPzJ46D9;
 Tue,  9 Dec 2025 00:57:24 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
 by mail.maildlp.com (Postfix) with ESMTPS id 51A534056D;
 Tue,  9 Dec 2025 00:57:39 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Mon, 8 Dec
 2025 16:57:38 +0000
Date: Mon, 8 Dec 2025 16:57:37 +0000
To: fanhuang <FangSheng.Huang@amd.com>
CC: <qemu-devel@nongnu.org>, <david@redhat.com>, <imammedo@redhat.com>,
 <Zhigang.Luo@amd.com>, <Lianjie.Shi@amd.com>
Subject: Re: [PATCH v3 1/1] numa: add 'spm' option for Specific Purpose Memory
Message-ID: <20251208165737.00001e85@huawei.com>
In-Reply-To: <20251208105137.2058928-2-FangSheng.Huang@amd.com>
References: <286f685c-0694-46d1-a8cb-13c77fc598a1@amd.com>
 <20251208105137.2058928-1-FangSheng.Huang@amd.com>
 <20251208105137.2058928-2-FangSheng.Huang@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.203.177.15]
X-ClientProxiedBy: lhrpeml500010.china.huawei.com (7.191.174.240) To
 dubpeml100005.china.huawei.com (7.214.146.113)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Reply-to:  Jonathan Cameron <jonathan.cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, 8 Dec 2025 18:51:37 +0800
fanhuang <FangSheng.Huang@amd.com> wrote:

> This patch adds support for Specific Purpose Memory (SPM) through the
> NUMA node configuration. When 'spm=3Don' is specified for a NUMA node,
> QEMU will set the E820 type to E820_SOFT_RESERVED for this memory region.
>=20
> This allows guest operating systems to recognize the memory as soft reser=
ved
> memory, which can be used for device-specific memory management.
>=20
> The implementation directly iterates over NUMA nodes to update E820 entri=
es,
> avoiding unnecessary RAMBlock traversal and flags, as suggested in code r=
eview.
>=20
> Usage:
>   -numa node,nodeid=3D0,memdev=3Dm1,spm=3Don
>=20
> Signed-off-by: fanhuang <FangSheng.Huang@amd.com>

Hi,

A few suggestions inline,

One general thing. I would never send a new version in reply to
a previous one.  That tends to just mean it ends up way back in
reviewer's in boxes + leads to confusing threads.

The thread naming of the cover letter is enough to associate the different
versions.

> diff --git a/hw/i386/e820_memory_layout.c b/hw/i386/e820_memory_layout.c
> index 3e848fb69c..5b090ac6df 100644
> --- a/hw/i386/e820_memory_layout.c
> +++ b/hw/i386/e820_memory_layout.c
> @@ -46,3 +46,76 @@ bool e820_get_entry(int idx, uint32_t type, uint64_t *=
address, uint64_t *length)
>      }
>      return false;
>  }
> +
> +bool e820_update_entry_type(uint64_t start, uint64_t length, uint32_t ne=
w_type)
> +{
> +    uint64_t end =3D start + length;
> +    bool updated =3D false;
> +    assert(!e820_done);
> +
> +    /* For E820_SOFT_RESERVED, validate range is within E820_RAM */
> +    if (new_type =3D=3D E820_SOFT_RESERVED) {
> +        bool range_in_ram =3D false;

I'd put a blank line here for readability.

> +        for (size_t j =3D 0; j < e820_entries; j++) {
> +            uint64_t ram_start =3D le64_to_cpu(e820_table[j].address);
> +            uint64_t ram_end =3D ram_start + le64_to_cpu(e820_table[j].l=
ength);
> +            uint32_t ram_type =3D le32_to_cpu(e820_table[j].type);
> +
> +            if (ram_type =3D=3D E820_RAM && ram_start <=3D start && ram_=
end >=3D end) {
> +                range_in_ram =3D true;
> +                break;
> +            }
> +        }
> +        if (!range_in_ram) {
> +            return false;
> +        }
> +    }
> +
> +    /* Find entry that contains the target range and update it */
> +    for (size_t i =3D 0; i < e820_entries; i++) {
> +        uint64_t entry_start =3D le64_to_cpu(e820_table[i].address);
> +        uint64_t entry_length =3D le64_to_cpu(e820_table[i].length);
> +        uint64_t entry_end =3D entry_start + entry_length;
> +
> +        if (entry_start <=3D start && entry_end >=3D end) {
> +            uint32_t original_type =3D e820_table[i].type;
> +
> +            /* Remove original entry */
> +            memmove(&e820_table[i], &e820_table[i + 1],
> +                    (e820_entries - i - 1) * sizeof(struct e820_entry));
> +            e820_entries--;
> +
> +            /* Add split parts inline */
> +            if (entry_start < start) {
> +                e820_table =3D g_renew(struct e820_entry, e820_table,
> +                                     e820_entries + 1);
> +                e820_table[e820_entries].address =3D cpu_to_le64(entry_s=
tart);
> +                e820_table[e820_entries].length =3D
> +                    cpu_to_le64(start - entry_start);
> +                e820_table[e820_entries].type =3D original_type;
> +                e820_entries++;
> +            }
> +
> +            e820_table =3D g_renew(struct e820_entry, e820_table,
> +                                 e820_entries + 1);
> +            e820_table[e820_entries].address =3D cpu_to_le64(start);
> +            e820_table[e820_entries].length =3D cpu_to_le64(length);
> +            e820_table[e820_entries].type =3D cpu_to_le32(new_type);
> +            e820_entries++;
> +
> +            if (end < entry_end) {
> +                e820_table =3D g_renew(struct e820_entry, e820_table,
> +                                     e820_entries + 1);
> +                e820_table[e820_entries].address =3D cpu_to_le64(end);
> +                e820_table[e820_entries].length =3D cpu_to_le64(entry_en=
d - end);
> +                e820_table[e820_entries].type =3D original_type;
> +                e820_entries++;
> +            }
> +
> +            updated =3D true;
Given you break out of the for loop and then return, why not
		return true;
> +            break;
> +        }
> +    }
> +
> +    return updated;
	return false;
and get rid of the updated local variable.

> +}

> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index f8b919cb6c..ccb2af2a56 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -791,6 +791,58 @@ static hwaddr pc_max_used_gpa(PCMachineState *pcms, =
uint64_t pci_hole64_size)
>      return pc_above_4g_end(pcms) - 1;
>  }
> =20
> +/*
> + * Update E820 entries for NUMA nodes marked as SPM (Specific Purpose Me=
mory).
> + * This function directly iterates over NUMA nodes instead of RAMBlocks,
> + * as suggested by code review to simplify the implementation.

Drop this sentence. That belongs in the patch description not the
code I think.

> + */
> +static void pc_update_spm_memory(X86MachineState *x86ms)
> +{
> +    MachineState *ms =3D MACHINE(x86ms);
> +    uint64_t addr =3D 0;
> +
> +    for (int i =3D 0; i < ms->numa_state->num_nodes; i++) {
> +        NodeInfo *numa_info =3D &ms->numa_state->nodes[i];
> +        uint64_t node_size =3D numa_info->node_mem;
> +
> +        /* Process SPM nodes */
> +        if (numa_info->is_spm && numa_info->node_memdev) {
> +            uint64_t guest_addr;
> +
> +            /* Calculate guest physical address accounting for PCI hole =
*/
> +            if (addr < x86ms->below_4g_mem_size) {
> +                if (addr + node_size <=3D x86ms->below_4g_mem_size) {
> +                    /* Entirely below 4GB */
> +                    guest_addr =3D addr;
> +                } else {
> +                    /* Spans across 4GB boundary - should not happen wit=
h proper config */

Why not just error out then?  Would be better that we don't have
configs in the wild that don't make sense and having qemu not start,
with a good error message is a great way to ensure no one does that.

> +                    warn_report("SPM node %d spans 4GB boundary, "
> +                                "using address above 4GB", i);
> +                    guest_addr =3D 0x100000000ULL +=20
> +                                (addr + node_size - x86ms->below_4g_mem_=
size);
> +                }
> +            } else {
> +                /* Above 4GB, account for PCI hole */
> +                guest_addr =3D 0x100000000ULL +=20
> +                            (addr - x86ms->below_4g_mem_size);
> +            }
> +
> +            /* Update E820 entry type to SOFT_RESERVED */
> +            if (!e820_update_entry_type(guest_addr, node_size,=20
> +                                       E820_SOFT_RESERVED)) {
> +                warn_report("Failed to update E820 entry for SPM node %d=
 "
> +                           "at 0x%" PRIx64 " length 0x%" PRIx64,
> +                           i, guest_addr, node_size);
> +            }
> +        }
> +
> +        /* Accumulate address for next node */
> +        if (numa_info->node_memdev) {
> +            addr +=3D node_size;
> +        }
> +    }
> +}

> diff --git a/include/system/numa.h b/include/system/numa.h
> index 1044b0eb6e..438511a756 100644
> --- a/include/system/numa.h
> +++ b/include/system/numa.h
> @@ -41,6 +41,7 @@ typedef struct NodeInfo {
>      bool present;
>      bool has_cpu;
>      bool has_gi;
> +    bool is_spm;
>      uint8_t lb_info_provided;
>      uint16_t initiator;
>      uint8_t distance[MAX_NODES];
> diff --git a/qapi/machine.json b/qapi/machine.json
> index 907cb25f75..98c2367ee6 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json
> @@ -500,6 +500,10 @@
>  # @memdev: memory backend object.  If specified for one node, it must
>  #     be specified for all nodes.
>  #
> +# @spm: if true, mark the memory region of this node as Specific
> +#     Purpose Memory (SPM).  This will set the E820 type to
> +#     E820_SOFT_RESERVED for guest OS.  (default: false, since 9.2)

This is an arch independent file and only x86 has an E820 table to do
this in. Obviously we'll need to wire it up to the EFI memory map on
other architectures, but I'd definitely like to avoid arch specific
documentation, or call out which architectures it applies to.

> +#
>  # @initiator: defined in ACPI 6.3 Chapter 5.2.27.3 Table 5-145, points
>  #     to the nodeid which has the memory controller responsible for
>  #     this NUMA node.  This field provides additional information as
> @@ -514,6 +518,7 @@
>     '*cpus':   ['uint16'],
>     '*mem':    'size',
>     '*memdev': 'str',
> +   '*spm':    'bool',
>     '*initiator': 'uint16' }}
> =20
>  ##
> diff --git a/qemu-options.hx b/qemu-options.hx
> index fca2b7bc74..7d914a9bc6 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -431,7 +431,7 @@ ERST
> =20
>  DEF("numa", HAS_ARG, QEMU_OPTION_numa,
>      "-numa node[,mem=3Dsize][,cpus=3Dfirstcpu[-lastcpu]][,nodeid=3Dnode]=
[,initiator=3Dnode]\n"
> -    "-numa node[,memdev=3Did][,cpus=3Dfirstcpu[-lastcpu]][,nodeid=3Dnode=
][,initiator=3Dnode]\n"
> +    "-numa node[,memdev=3Did][,cpus=3Dfirstcpu[-lastcpu]][,nodeid=3Dnode=
][,initiator=3Dnode][,spm=3Don|off]\n"
>      "-numa dist,src=3Dsource,dst=3Ddestination,val=3Ddistance\n"
>      "-numa cpu,node-id=3Dnode[,socket-id=3Dx][,core-id=3Dy][,thread-id=
=3Dz]\n"
>      "-numa hmat-lb,initiator=3Dnode,target=3Dnode,hierarchy=3Dmemory|fir=
st-level|second-level|third-level,data-type=3Daccess-latency|read-latency|w=
rite-latency[,latency=3Dlat][,bandwidth=3Dbw]\n"
> @@ -440,7 +440,7 @@ DEF("numa", HAS_ARG, QEMU_OPTION_numa,
>  SRST
>  ``-numa node[,mem=3Dsize][,cpus=3Dfirstcpu[-lastcpu]][,nodeid=3Dnode][,i=
nitiator=3Dinitiator]``
>    \=20
> -``-numa node[,memdev=3Did][,cpus=3Dfirstcpu[-lastcpu]][,nodeid=3Dnode][,=
initiator=3Dinitiator]``
> +``-numa node[,memdev=3Did][,cpus=3Dfirstcpu[-lastcpu]][,nodeid=3Dnode][,=
initiator=3Dinitiator][,spm=3Don|off]``
>    \
>  ``-numa dist,src=3Dsource,dst=3Ddestination,val=3Ddistance``
>    \=20
> @@ -508,6 +508,13 @@ SRST
>      largest bandwidth) to this NUMA node. Note that this option can be
>      set only when the machine property 'hmat' is set to 'on'.
> =20
> +    '\ ``spm``\ ' option marks the memory region of this NUMA node as
> +    Specific Purpose Memory (SPM). When enabled, the memory will be
> +    reported as soft reserved (E820 type 0xEFFFFFFF) to the guest OS,
> +    which can then manage it separately from normal system RAM. This is
> +    useful for device-specific memory that should not be used as general
> +    purpose memory. This option is only supported on x86 platforms.

Do we error out if anyone tries to set it on other architectures?
=46rom a quick look I think you are just ignoring it which is a good
way to confused users.

> +
>      Following example creates a machine with 2 NUMA nodes, node 0 has
>      CPU. node 1 has only memory, and its initiator is node 0. Note that
>      because node 0 has CPU, by default the initiator of node 0 is itself


