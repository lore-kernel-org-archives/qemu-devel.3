Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C9C4C79F82
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 08:02:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3qmN-00017m-PN; Tue, 08 Sep 2026 04:02:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1x3qmL-00017U-JO
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 04:02:05 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1x3qmH-0002xc-6v
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 04:02:05 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 68881mY9027549
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 8 Sep 2026 17:01:48 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=i3tMWTt7PzrIjwsxR2r72ThQhszAuk6/El5qOEV5HoA=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1788854508; v=1;
 b=JnAXbXMSlIGTPtKI5JpG+WlQ8qv22nwCb6D9FvNxUmopb5k8cUVPtM7GSHzhQbWB
 mPb7zEo6EKWaoHinQT3R8NbIgE8auT9HuvcYG6Z4q5KJAOlKXXDNDObGqZHU0gG8
 hqGFqDMvtZNfMcfe9COSYQCcr4+TOKW+SMLeu6NhU82tqwD8a5HPXx1lAWjtnXFw
 3EhkpcIKbuABTeCfXTZGPA4HuVE9gPFCC0ubYoulbxLPM26LmAVVlt8gwYCTQZUW
 h6dkAt1wboeMfzaaS+R9Zk1jn1TOGO/wtB3oSIUqyb9WBqWnBWiRBsebKq6EhIZ4
 eMkqH0EcGlmN3mJ7/tLSfw==
Message-ID: <846e77a1-56df-4d14-a1ee-d6c6489a2bcb@rsg.ci.i.u-tokyo.ac.jp>
Date: Tue, 8 Sep 2026 17:01:48 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 3/9] igb: Add VF state serialization for live
 migration
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Jason Wang <jasowangio@gmail.com>, Alex Williamson <alex@shazbot.org>,
 Peter Xu <peterx@redhat.com>
References: <20260902192054.3329753-1-clg@redhat.com>
 <20260902192054.3329753-4-clg@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260902192054.3329753-4-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 2026/09/03 4:20, Cédric Le Goater wrote:
> Implement per-VF state serialization and deserialization for the SAVE
> and LOAD commands. The wire format consists of a header (magic,
> version, VF number, register count), per-VF register offset/value
> pairs from a whitelist, RA table entries owned by the VF, and TX
> queue contexts.
> 
> Register offsets are relocated on load so a VF can migrate to a
> different VF number on the destination. RA pool ownership bits are
> swapped accordingly.
> 
> AI-used-for: analysis, code (prototype)
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   hw/net/igb_core.h      |   2 +
>   hw/net/igb_migration.h |   2 +
>   hw/net/igb.c           |   5 +
>   hw/net/igb_migration.c | 347 ++++++++++++++++++++++++++++++++++++++++-
>   4 files changed, 354 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/net/igb_core.h b/hw/net/igb_core.h
> index d70b54e318f1..60724e2824ab 100644
> --- a/hw/net/igb_core.h
> +++ b/hw/net/igb_core.h
> @@ -143,4 +143,6 @@ igb_receive_iov(IGBCore *core, const struct iovec *iov, int iovcnt);
>   void
>   igb_start_recv(IGBCore *core);
>   
> +IGBCore *igb_pf_get_core(void *pf);
> +
>   #endif
> diff --git a/hw/net/igb_migration.h b/hw/net/igb_migration.h
> index ea40ac65c54b..b2f601e74346 100644
> --- a/hw/net/igb_migration.h
> +++ b/hw/net/igb_migration.h
> @@ -73,6 +73,8 @@
>   #define IGB_MIG_ERR_NO_BUFFER           3
>   #define IGB_MIG_ERR_DMA_FAILED          4
>   #define IGB_MIG_ERR_BAD_SIZE            5
> +#define IGB_MIG_ERR_BAD_MAGIC           6
> +#define IGB_MIG_ERR_BAD_VERSION         7
>   
>   /* Shared buffer constants */
>   #define IGB_VF_STATE_MAX_SIZE           4096
> diff --git a/hw/net/igb.c b/hw/net/igb.c
> index 7268e5473fc3..f39f2bc3a04e 100644
> --- a/hw/net/igb.c
> +++ b/hw/net/igb.c
> @@ -133,6 +133,11 @@ void igb_vf_reset(void *opaque, uint16_t vfn)
>       igb_core_vf_reset(&s->core, vfn);
>   }
>   
> +IGBCore *igb_pf_get_core(void *pf)
> +{
> +    return &IGB(pf)->core;
> +}
> +
>   static bool
>   igb_io_get_reg_index(IGBState *s, uint32_t *idx)
>   {
> diff --git a/hw/net/igb_migration.c b/hw/net/igb_migration.c
> index 8e7e6fac9b9b..c34035974620 100644
> --- a/hw/net/igb_migration.c
> +++ b/hw/net/igb_migration.c
> @@ -10,18 +10,241 @@
>   #include "qemu/log.h"
>   #include "hw/pci/pci_device.h"
>   #include "hw/pci/pcie.h"
> +#include "net/eth.h"
> +#include "net/net.h"
>   #include "igb_common.h"
> +#include "igb_core.h"
>   #include "igb_migration.h"
>   #include "system/address-spaces.h"
>   #include "trace.h"
>   
> +static IGBCore *igbvf_get_core(IgbVfState *s)
> +{
> +    return igb_pf_get_core(pcie_sriov_get_pf(PCI_DEVICE(s)));
> +}
> +
>   /*
>    * Per-VF state serialization / deserialization
>    */
>   
> +#define IGB_MIG_BLOB_MAGIC        0x4D494742  /* "MIGB" */
> +#define IGB_MIG_BLOB_VERSION      1
> +
> +typedef struct IgbMigRegPair {
> +    uint32_t offset;
> +    uint32_t value;
> +} IgbMigRegPair;
> +
> +typedef struct IgbMigTxCtx {
> +    uint32_t ctx_desc[8];         /* 2 × adv_tx_context_desc (4 dwords each) */
> +    uint32_t first_cmd_type_len;
> +    uint32_t first_olinfo_status;
> +    uint32_t first;
> +    uint32_t skip_cp;
> +} IgbMigTxCtx;
> +
> +#define IGB_VF_MAX_FIXED_REGS     64
> +#define IGB_VF_MAX_RA_REGS        48  /* (16 + 8) RA entries × 2 (RAL+RAH) */
> +
> +typedef struct IgbMigBlob {
> +    uint32_t magic;
> +    uint32_t version;
> +    uint32_t vfn;
> +    uint32_t num_regs;
> +    IgbMigRegPair regs[IGB_VF_MAX_FIXED_REGS];
> +    uint32_t num_ra;
> +    IgbMigRegPair ra[IGB_VF_MAX_RA_REGS];
> +    uint32_t num_tx_ctx;
> +    IgbMigTxCtx tx_ctx[2];
> +} IgbMigBlob;
> +
> +#define IGB_MIG_BLOB_SIZE            sizeof(IgbMigBlob)
> +
> +QEMU_BUILD_BUG_ON(IGB_MIG_BLOB_SIZE > IGB_VF_STATE_MAX_SIZE);
> +
> +/* Register offsets that constitute a VF's state slice */
> +static int igb_vf_reg_list(uint16_t vfn, uint32_t *offsets)
> +{
> +    int n = 0;
> +    int q0 = vfn;
> +    int q1 = vfn + IGB_NUM_VM_POOLS;
> +
> +    /* Per-VF control and interrupt registers */
> +    offsets[n++] = E1000_PVTCTRL(vfn) >> 2;
> +    offsets[n++] = E1000_PVTEICS(vfn) >> 2;
> +    offsets[n++] = E1000_PVTEIMS(vfn) >> 2;
> +    offsets[n++] = E1000_PVTEIMC(vfn) >> 2;
> +    offsets[n++] = E1000_PVTEIAC(vfn) >> 2;
> +    offsets[n++] = E1000_PVTEIAM(vfn) >> 2;
> +    offsets[n++] = E1000_PVTEICR(vfn) >> 2;
> +
> +    /* Per-VF statistics */
> +    offsets[n++] = E1000_PVFGPRC(vfn) >> 2;
> +    offsets[n++] = E1000_PVFGPTC(vfn) >> 2;
> +    offsets[n++] = E1000_PVFGORC(vfn) >> 2;
> +    offsets[n++] = E1000_PVFGOTC(vfn) >> 2;
> +    offsets[n++] = E1000_PVFMPRC(vfn) >> 2;
> +    offsets[n++] = E1000_PVFGPRLBC(vfn) >> 2;
> +    offsets[n++] = E1000_PVFGPTLBC(vfn) >> 2;
> +    offsets[n++] = E1000_PVFGORLBC(vfn) >> 2;
> +    offsets[n++] = E1000_PVFGOTLBC(vfn) >> 2;
> +
> +    /*
> +     * Mailbox control registers only - the 16-dword payload buffer
> +     * (VMBMEM) is transient and drained on quiesce.
> +     */
> +    offsets[n++] = E1000_V2PMAILBOX(vfn) >> 2;
> +    offsets[n++] = E1000_P2VMAILBOX(vfn) >> 2;
> +
> +    /* Per-VF config */
> +    offsets[n++] = E1000_VMOLR(vfn) >> 2;
> +    offsets[n++] = E1000_VMVIR(vfn) >> 2;
> +    offsets[n++] = E1000_PSRTYPE(vfn) >> 2;
> +
> +    /*
> +     * VF receive addresses (RA/RA2) are saved dynamically in
> +     * igb_core_vf_save_state by scanning for entries whose pool
> +     * bits match this VF - the PF driver chooses the RA slot.
> +     */
> +
> +    /* Interrupt routing */
> +    offsets[n++] = (E1000_VTIVAR + vfn * 4) >> 2;
> +    offsets[n++] = (E1000_VTIVAR_MISC + vfn * 4) >> 2;
> +
> +    /*
> +     * EITR (Extended Interrupt Throttle Register) - 3 vectors per VF.
> +     * Each VF has 3 MSI-X vectors, each with its own EITR controlling
> +     * interrupt coalescing. Without saving these, interrupt
> +     * throttling resets to zero after migration which can cause
> +     * interrupt storms or latency changes. VF N uses PF EITR indices
> +     * (22 - N*3) .. (24 - N*3).
> +     */
> +    {
> +        int eitr_base = 22 - vfn * 3;
> +        offsets[n++] = E1000_EITR(eitr_base) >> 2;
> +        offsets[n++] = E1000_EITR(eitr_base + 1) >> 2;
> +        offsets[n++] = E1000_EITR(eitr_base + 2) >> 2;
> +    }
> +
> +    /* RX and TX queue registers for queues q0 and q1 */
> +#define ADD_QUEUE_REGS(q) do { \
> +    offsets[n++] = E1000_RDBAL(q) >> 2; \
> +    offsets[n++] = E1000_RDBAH(q) >> 2; \
> +    offsets[n++] = E1000_RDLEN(q) >> 2; \
> +    offsets[n++] = E1000_SRRCTL(q) >> 2; \
> +    offsets[n++] = E1000_RDH(q) >> 2; \
> +    offsets[n++] = E1000_RDT(q) >> 2; \
> +    offsets[n++] = E1000_RXDCTL(q) >> 2; \
> +    offsets[n++] = E1000_RXCTL(q) >> 2; \
> +    offsets[n++] = E1000_RQDPC(q) >> 2; \
> +    offsets[n++] = E1000_TDBAL(q) >> 2; \
> +    offsets[n++] = E1000_TDBAH(q) >> 2; \
> +    offsets[n++] = E1000_TDLEN(q) >> 2; \
> +    offsets[n++] = E1000_TDH(q) >> 2; \
> +    offsets[n++] = E1000_TDT(q) >> 2; \
> +    offsets[n++] = E1000_TXDCTL(q) >> 2; \
> +    offsets[n++] = E1000_TXCTL(q) >> 2; \
> +    offsets[n++] = E1000_TDWBAL(q) >> 2; \
> +    offsets[n++] = E1000_TDWBAH(q) >> 2; \
> +} while (0)
> +
> +    ADD_QUEUE_REGS(q0);
> +    ADD_QUEUE_REGS(q1);
> +#undef ADD_QUEUE_REGS
> +
> +    g_assert(n <= IGB_VF_MAX_FIXED_REGS);
> +    return n;
> +}
> +
> +/*
> + * Scan RA and RA2 arrays for receive address entries assigned to
> + * this VF. The PF driver picks the RA slot, so we cannot use a
> + * fixed index - instead check each entry's pool bits.
> + */
> +static int igb_core_vf_save_ra(IGBCore *core, uint16_t vfn,
> +                               IgbMigRegPair *regs)
> +{
> +    uint32_t vf_pool_bit = E1000_RAH_POOL_1 << vfn;
> +    int n = 0;
> +    static const struct {
> +        uint32_t base;
> +        int count;
> +    } ra_banks[] = {
> +        { RA,  16 },
> +        { RA2,  8 },
> +    };
> +
> +    for (int i = 0; i < ARRAY_SIZE(ra_banks); i++) {
> +        for (int j = 0; j < ra_banks[i].count; j++) {
> +            uint32_t ral_off = ra_banks[i].base + j * 2;
> +            uint32_t rah_off = ra_banks[i].base + j * 2 + 1;
> +            uint32_t rah_val = core->mac[rah_off];
> +
> +            if ((rah_val & E1000_RAH_AV) && (rah_val & vf_pool_bit)) {
> +                regs[n].offset = cpu_to_le32(ral_off);
> +                regs[n].value = cpu_to_le32(core->mac[ral_off]);
> +                n++;
> +                regs[n].offset = cpu_to_le32(rah_off);
> +                regs[n].value = cpu_to_le32(rah_val);
> +                n++;
> +            }
> +        }
> +    }
> +    return n;
> +}
> +
> +static void igb_core_vf_save_tx_ctx(IGBCore *core, int queue,
> +                                    IgbMigTxCtx *tx)
> +{
> +    struct igb_tx *src = &core->tx[queue];
> +
> +    memcpy(tx->ctx_desc, src->ctx, sizeof(tx->ctx_desc));
> +    tx->first_cmd_type_len = cpu_to_le32(src->first_cmd_type_len);
> +    tx->first_olinfo_status = cpu_to_le32(src->first_olinfo_status);
> +    tx->first = cpu_to_le32(src->first);
> +    tx->skip_cp = cpu_to_le32(src->skip_cp);
> +}
> +
>   static int igb_core_vf_save_state(IgbVfState *s, void *buf, size_t buf_size)
>   {
> -    int size = 0;
> +    int size = IGB_MIG_BLOB_SIZE;
> +    IGBCore *core = igbvf_get_core(s);
> +    IgbMigBlob *blob = buf;
> +    uint32_t offsets[IGB_VF_MAX_FIXED_REGS];
> +    int num_regs;
> +    int q0 = s->vfn;
> +    int q1 = s->vfn + IGB_NUM_VM_POOLS;
> +
> +    /*
> +     * Save PVT shadow registers (PVTEIMS/PVTEIAC/PVTEIAM) instead of
> +     * extracting from PF aggregates - the L1 PF driver may have
> +     * transiently cleared EIMS via EIMC. The load path ORs them back.
> +     */
> +    num_regs = igb_vf_reg_list(s->vfn, offsets);
> +
> +    if (!buf) {
> +        return size;
> +    }
> +
> +    if (size > buf_size) {
> +        return -IGB_MIG_ERR_BAD_SIZE;
> +    }
> +
> +    blob->magic = cpu_to_le32(IGB_MIG_BLOB_MAGIC);
> +    blob->version = cpu_to_le32(IGB_MIG_BLOB_VERSION);
> +    blob->vfn = cpu_to_le32(s->vfn);
> +
> +    blob->num_regs = cpu_to_le32(num_regs);
> +    for (int i = 0; i < num_regs; i++) {
> +        blob->regs[i].offset = cpu_to_le32(offsets[i]);
> +        blob->regs[i].value = cpu_to_le32(core->mac[offsets[i]]);
> +    }
> +
> +    blob->num_ra = cpu_to_le32(igb_core_vf_save_ra(core, s->vfn, blob->ra));

The serialized state contains RA entries but excludes VFTA/VLVF and 
MTA/UTA state. A guest-configured VLAN therefore resumes on a 
destination lacking its filter membership: packets are rejected by the 
global VLAN check or have their VF queue removed  in 
igb_receive_assign(),. Likewise, restored VMOLR.ROMPE cannot receive 
subscribed multicast without its MTA hash bits. These are 
guest-requested settings communicated through the PF mailbox, and the 
resumed guest does not recreate them automatically.

> +
> +    blob->num_tx_ctx = cpu_to_le32(2);
> +    igb_core_vf_save_tx_ctx(core, q0, &blob->tx_ctx[0]);
> +    igb_core_vf_save_tx_ctx(core, q1, &blob->tx_ctx[1]);
>   
>       trace_igbvf_mig_save_state(s->vfn, size);
>       return size;
> @@ -29,11 +252,131 @@ static int igb_core_vf_save_state(IgbVfState *s, void *buf, size_t buf_size)
>   
>   static int igb_core_vf_max_data_size(IgbVfState *s)
>   {
> -    return sizeof(s->mig.mig_data);
> +    int size = igb_core_vf_save_state(s, NULL, 0);
> +
> +    g_assert(size > 0 && size <= IGB_VF_STATE_MAX_SIZE);
> +    return size;
> +}
> +
> +static void igb_core_vf_load_tx_ctx(IGBCore *core, int queue,
> +                                    const IgbMigTxCtx *tx)
> +{
> +    struct igb_tx *dst = &core->tx[queue];
> +
> +    /*
> +     * Preserve the destination's tx_pkt - it's a host-side object,
> +     * not guest state
> +     */
> +    memcpy(dst->ctx, tx->ctx_desc, sizeof(dst->ctx));
> +    dst->first_cmd_type_len = le32_to_cpu(tx->first_cmd_type_len);
> +    dst->first_olinfo_status = le32_to_cpu(tx->first_olinfo_status);
> +    dst->first = le32_to_cpu(tx->first);
> +    dst->skip_cp = le32_to_cpu(tx->skip_cp);
> +}
> +
> +static uint32_t igb_vf_relocate_offset(uint32_t offset,
> +                                       const uint32_t *src_offsets,
> +                                       const uint32_t *dst_offsets,
> +                                       int num_offsets)
> +{
> +    for (int i = 0; i < num_offsets; i++) {
> +        if (src_offsets[i] == offset) {
> +            return dst_offsets[i];
> +        }
> +    }
> +    return 0;
>   }
>   
>   static int igb_core_vf_load_state(IgbVfState *s, const void *buf, size_t size)
>   {
> +    IGBCore *core = igbvf_get_core(s);
> +    uint32_t src_offsets[IGB_VF_MAX_FIXED_REGS];
> +    uint32_t dst_offsets[IGB_VF_MAX_FIXED_REGS];
> +    int q0 = s->vfn;
> +    int q1 = s->vfn + IGB_NUM_VM_POOLS;
> +
> +    if (size < IGB_MIG_BLOB_SIZE) {
> +        return -IGB_MIG_ERR_BAD_SIZE;
> +    }
> +
> +    const IgbMigBlob *blob = buf;
> +
> +    uint32_t magic = le32_to_cpu(blob->magic);
> +    uint32_t version = le32_to_cpu(blob->version);
> +    uint32_t saved_vfn = le32_to_cpu(blob->vfn);
> +    uint32_t num_regs = le32_to_cpu(blob->num_regs);
> +
> +    if (magic != IGB_MIG_BLOB_MAGIC) {
> +        return -IGB_MIG_ERR_BAD_MAGIC;
> +    }
> +    if (version != IGB_MIG_BLOB_VERSION) {
> +        return -IGB_MIG_ERR_BAD_VERSION;
> +    }
> +    if (num_regs > IGB_VF_MAX_FIXED_REGS) {
> +        return -IGB_MIG_ERR_BAD_SIZE;
> +    }
> +
> +    uint32_t num_ra = le32_to_cpu(blob->num_ra);
> +    if (num_ra > IGB_VF_MAX_RA_REGS) {
> +        return -IGB_MIG_ERR_BAD_SIZE;
> +    }
> +
> +    int num_offsets = igb_vf_reg_list(saved_vfn, src_offsets);
> +    igb_vf_reg_list(s->vfn, dst_offsets);
> +
> +    for (uint32_t i = 0; i < num_regs; i++) {
> +        uint32_t src_off = le32_to_cpu(blob->regs[i].offset);
> +        uint32_t value = le32_to_cpu(blob->regs[i].value);
> +        uint32_t offset = igb_vf_relocate_offset(src_off,
> +            src_offsets, dst_offsets, num_offsets);
> +        if (!offset) {
> +            return -IGB_MIG_ERR_BAD_SIZE;
> +        }
> +
> +        core->mac[offset] = value;
> +
> +        /*
> +         * Sync EITR to eitr_guest_value[] shadow array, stripping
> +         * E1000_EITR_CNT_IGNR so guest register readback returns the
> +         * correct value.
> +         */
> +        if (offset >= EITR0 && offset < EITR0 + IGB_INTR_NUM) {
> +            core->eitr_guest_value[offset - EITR0] =
> +                value & ~E1000_EITR_CNT_IGNR;
> +        }
> +    }
> +
> +    /*
> +     * MSI-X table/PBA is not saved - L1's VFIO reprograms it with
> +     * destination-specific IRTE references after migration.
> +     */
> +
> +    uint32_t src_pool = E1000_RAH_POOL_1 << saved_vfn;
> +    uint32_t dst_pool = E1000_RAH_POOL_1 << s->vfn;
> +
> +    for (uint32_t i = 0; i < num_ra; i++) {
> +        uint32_t offset = le32_to_cpu(blob->ra[i].offset);
> +        uint32_t value = le32_to_cpu(blob->ra[i].value);
> +
> +        /* RAH entries: swap pool ownership bits */
> +        if (offset >= RA && offset < RA + 32 && (offset - RA) % 2 == 1) {
> +            value = (value & ~src_pool) | dst_pool;
> +        }
> +        if (offset >= RA2 && offset < RA2 + 16 && (offset - RA2) % 2 == 1) {
> +            value = (value & ~src_pool) | dst_pool;
> +        }
> +
> +        core->mac[offset] = value;

Please validate RA offsets before writing core->mac. A valid-sized LOAD 
blob with one RA entry and an out-of-range offset produces an 
out-of-bounds 32-bit host write. LOAD reads this blob directly from 
guest RAM. Please validate all offsets and saved_vfn before modifying state.

This loop also changes the VF pool bit but preserves the source RA slot. 
A valid VF0→VF1 migration onto a destination already using VF0 
overwrites destination VF0’s primary MAC entry. Linux assigns the 
primary entry as rar_entry_count - (vf + 1); receive filtering consumes 
these slots directly in igb_receive_assign(). Thus the unrelated 
destination VF loses unicast reception. Existing destination entries 
owned by the migrating VF are also left behind.

Regards,
Akihiko Odaki

> +    }
> +
> +    uint32_t num_tx = le32_to_cpu(blob->num_tx_ctx);
> +    if (num_tx != 2) {
> +        return -IGB_MIG_ERR_BAD_SIZE;
> +    }
> +
> +    igb_core_vf_load_tx_ctx(core, q0, &blob->tx_ctx[0]);
> +    igb_core_vf_load_tx_ctx(core, q1, &blob->tx_ctx[1]);
> +
>       trace_igbvf_mig_load_state(s->vfn, (uint32_t)size);
>       return 0;
>   }


